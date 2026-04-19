<script type="application/json" def>
{
  "navigationBarTitleText": "Heart Rate"
}
</script>

<script setup>
const HEART_RATE_SERVICE_UUID = '0000180d-0000-1000-8000-00805f9b34fb';
const HEART_RATE_MEASUREMENT_UUID = '00002a37-0000-1000-8000-00805f9b34fb';

function parseHeartRate(value) {
  const bytes = Array.from(value || []);
  if (bytes.length < 2) {
    return null;
  }

  const flags = bytes[0];
  const is16Bit = (flags & 0x01) !== 0;
  if (is16Bit) {
    if (bytes.length < 3) {
      return null;
    }
    return bytes[1] | (bytes[2] << 8);
  }

  return bytes[1];
}

export default {
  data: {
    isScanning: false,
    devices: [],
    connectingDeviceId: '',
    connectedDeviceId: '',
    connectedDeviceName: '',
    heartRate: '--',
    statusText: 'Scan for a heart rate monitor to begin live monitoring.',
    error: '',
  },

  onUnload: function () {
    this.teardownOnUnload();
  },

  startDiscovery: async function () {
    await this.stopScan();

    this.deviceMap = new Map();
    this.setData({
      isScanning: true,
      devices: [],
      connectingDeviceId: '',
      connectedDeviceId: '',
      connectedDeviceName: '',
      heartRate: '--',
      statusText: 'Scanning for heart rate devices...',
      error: '',
    });

    try {
      const scan = await navigator.bluetooth.scanDevices({
        filters: [{ services: ['heart_rate'] }],
      });

      this.scanSession = scan;
      scan.onDeviceFound((event) => {
        const device = event.device;
        this.deviceMap.set(device.id, device);

        const nextDevices = [...this.data.devices];
        if (!nextDevices.find((item) => item.id === device.id)) {
          nextDevices.push({
            id: device.id,
            name: device.name || 'Unknown Device',
          });
          this.setData({ devices: nextDevices });
        }
      });
    } catch (e) {
      console.error('Failed to start heart rate scan', e);
      this.setData({
        isScanning: false,
        statusText: 'Heart rate scan failed.',
        error: 'Failed to scan: ' + e.message,
      });
    }
  },

  toggleScan: async function () {
    if (this.data.isScanning) {
      await this.stopScan();
      return;
    }

    await this.startDiscovery();
  },

  stopScan: async function () {
    if (!this.scanSession) {
      this.setData({ isScanning: false });
      return;
    }

    try {
      await this.scanSession.stop();
    } catch (e) {
      console.error('Failed to stop heart rate scan', e);
    } finally {
      this.scanSession = null;
      this.setData({ isScanning: false });
    }
  },

  releaseHeartRateListener: function () {
    const characteristic = this.heartRateCharacteristic;
    const listener = this.heartRateListener;

    if (characteristic && listener) {
      characteristic.removeEventListener('characteristicvaluechanged', listener);
    }

    this.heartRateListener = null;
  },

  teardownOnUnload: function () {
    this.releaseHeartRateListener();

    if (this.scanSession) {
      try {
        this.scanSession.stop();
      } catch (_) {}
    }

    this.scanSession = null;
    this.connectedDevice = null;
    this.connectedServer = null;
    this.heartRateCharacteristic = null;
    this.deviceMap = null;
  },

  selectDevice: async function (e) {
    const deviceId = e.currentTarget.attributes['data-id'];
    const device = this.deviceMap && this.deviceMap.get(deviceId);

    if (!device) {
      this.setData({ error: 'Selected device is no longer available.' });
      return;
    }

    if (this.data.connectingDeviceId === deviceId) {
      return;
    }

    if (this.data.connectedDeviceId === deviceId) {
      await this.disconnectCurrent();
      return;
    }

    await this.stopScan();

    this.setData({
      connectingDeviceId: deviceId,
      connectedDeviceId: '',
      connectedDeviceName: '',
      heartRate: '--',
      statusText: 'Connecting to ' + (device.name || 'device') + '...',
      error: '',
    });

    try {
      const server = await device.gatt.connect();
      const service = await server.getPrimaryService('heart_rate');
      const characteristic = await service.getCharacteristic(HEART_RATE_MEASUREMENT_UUID);
      const heartRateListener = () => {
        const bpm = parseHeartRate(characteristic.value);
        if (bpm == null) {
          this.setData({
            statusText: 'Received an unsupported heart rate payload.',
            error: 'Notification payload could not be parsed.',
          });
          return;
        }

        this.setData({
          heartRate: String(bpm),
          statusText: 'Receiving live heart rate notifications.',
          error: '',
        });
      };

      this.heartRateCharacteristic = characteristic;
      this.heartRateListener = heartRateListener;
      characteristic.addEventListener('characteristicvaluechanged', heartRateListener);
      await characteristic.startNotifications();

      this.connectedDevice = device;
      this.connectedServer = server;

      this.setData({
        connectingDeviceId: '',
        connectedDeviceId: deviceId,
        connectedDeviceName: device.name || 'Unknown Device',
        statusText: 'Connected. Waiting for heart rate notifications...',
      });
    } catch (e) {
      console.error('Failed to connect heart rate monitor', e);
      this.releaseHeartRateListener();
      if (this.heartRateCharacteristic) {
        try {
          await this.heartRateCharacteristic.stopNotifications();
        } catch (_) {}
      }
      this.heartRateListener = null;
      this.connectedDevice = null;
      this.connectedServer = null;
      this.heartRateCharacteristic = null;
      this.setData({
        connectingDeviceId: '',
        connectedDeviceId: '',
        connectedDeviceName: '',
        heartRate: '--',
        statusText: 'Connection failed.',
        error: 'Failed to connect: ' + e.message,
      });
    }
  },

  disconnectCurrent: async function () {
    const characteristic = this.heartRateCharacteristic;

    if (!this.connectedDevice) {
      this.releaseHeartRateListener();
      this.connectedServer = null;
      this.heartRateCharacteristic = null;
      this.setData({
        connectingDeviceId: '',
        connectedDeviceId: '',
        connectedDeviceName: '',
        heartRate: '--',
        statusText: 'Disconnected.',
      });
      return;
    }

    try {
      this.releaseHeartRateListener();
      if (characteristic) {
        await characteristic.stopNotifications();
      }
      await this.connectedDevice.gatt.disconnect();
      this.setData({
        connectingDeviceId: '',
        connectedDeviceId: '',
        connectedDeviceName: '',
        heartRate: '--',
        statusText: 'Disconnected from heart rate monitor.',
        error: '',
      });
    } catch (e) {
      console.error('Failed to disconnect heart rate monitor', e);
      this.setData({
        error: 'Failed to disconnect: ' + e.message,
      });
    } finally {
      this.connectedDevice = null;
      this.connectedServer = null;
      this.heartRateCharacteristic = null;
      this.heartRateListener = null;
    }
  },
};
</script>

<page>
  <view class="container">
    <view class="nav-shell">
      <text class="eyebrow">Live Monitor</text>
      <text class="title">Heart Rate</text>
      <text class="subtitle">
        {{ connectedDeviceId ? 'Live reading' : 'Scan and connect a device before showing BPM.' }}
      </text>
    </view>

    <view ink:if="{{ !connectedDeviceId }}" class="section">
      <view class="control-card">
        <text class="card-kicker">Connect Device</text>
        <text class="panel-title">Heart Rate Monitor</text>
        <text class="panel-subtitle">
          {{ statusText }}
        </text>
        <text ink:if="{{ error }}" class="panel-error">{{ error }}</text>
        <button class="primary-button" bindtap="toggleScan">
          {{ isScanning ? 'Stop Heart Rate Scan' : 'Scan Heart Rate Devices' }}
        </button>
      </view>
    </view>

    <view ink:if="{{ !connectedDeviceId }}" class="section">
      <view class="section-header">
        <text class="section-label">AVAILABLE DEVICES</text>
        <text class="section-count">{{ devices.length }}</text>
      </view>
      <view class="list-card">
        <text class="card-kicker">Device Feed</text>
        <text ink:if="{{ devices.length === 0 }}" class="hint">
          {{ isScanning ? 'Scanning for heart rate devices...' : 'No heart rate devices reported yet.' }}
        </text>
        <view
          ink:for="{{ devices }}"
          ink:for-item="device"
          class="device-item"
          key="{{ device.id }}"
          data-id="{{ device.id }}"
          bindtap="selectDevice"
        >
          <view class="device-row">
            <view class="device-copy">
              <text class="device-title">{{ device.name }}</text>
              <text class="device-id">{{ device.id }}</text>
            </view>
            <text
              ink:if="{{ connectingDeviceId === device.id }}"
              class="pill connecting"
            >
              Connecting
            </text>
          </view>
          <text
            ink:if="{{ connectingDeviceId === device.id }}"
            class="device-state connecting"
          >
            Connecting to device...
          </text>
        </view>
      </view>
    </view>

    <view ink:if="{{ connectedDeviceId }}" class="section">
      <view class="hero-card connected-hero">
        <view class="hero-center">
          <text class="hero-device-label">{{ connectedDeviceName || 'Unknown Device' }}</text>
          <view class="heart-rate-display">
            <text class="heart-rate">{{ heartRate }}</text>
            <text class="unit">BPM</text>
          </view>
          <text class="hero-status">{{ error ? 'Connection issue' : statusText }}</text>
          <text ink:if="{{ error }}" class="hero-error">{{ error }}</text>
          <button class="hero-disconnect-button" bindtap="disconnectCurrent">Disconnect</button>
        </view>
      </view>
    </view>
  </view>
</page>

<style>
.container {
  display: flex;
  flex-direction: column;
  padding: 16px 16px 28px;
  background-color: #050805;
}

.nav-shell {
  flex-direction: column;
  padding: 4px 4px 14px;
}

.eyebrow {
  line-height: 13px;
  font-size: 12px;
  font-weight: 600;
  color: #72f79d;
  text-transform: uppercase;
}

.title {
  line-height: 32px;
  font-size: 32px;
  font-weight: bold;
  color: #ecfff1;
  margin-top: 4px;
}

.subtitle {
  margin-top: 8px;
  font-size: 15px;
  color: #8ba494;
  line-height: 21px;
}

.section {
  flex-direction: column;
  margin-bottom: 14px;
}

.section-label {
  font-size: 12px;
  font-weight: 600;
  color: #4e745a;
  margin: 0 0 8px 2px;
  text-transform: uppercase;
}

.card-kicker {
  font-size: 11px;
  font-weight: 700;
  text-transform: uppercase;
  color: #53cc77;
  margin-bottom: 8px;
}

.panel-title {
  font-size: 22px;
  line-height: 28px;
  font-weight: 700;
  color: #ecfff1;
}

.panel-subtitle {
  margin-top: 8px;
  color: #8ba494;
  font-size: 15px;
  line-height: 21px;
}

.panel-error {
  margin-top: 10px;
  color: #ff8377;
  line-height: 20px;
}

.hero-card {
  background: linear-gradient(180deg, #0d1711 0%, #101c14 42%, #0a120d 100%);
  border-radius: 28px;
  padding: 18px 18px 20px;
  display: flex;
  flex-direction: column;
  min-height: 300px;
  box-shadow: 0 18px 40px rgba(0, 0, 0, 0.34);
  border: 1px solid #1c3424;
}

.connected-hero {
  min-height: 300px;
  padding: 18px 20px 20px;
}

.hero-pill {
  padding: 7px 12px;
  border-radius: 999px;
  font-size: 12px;
  font-weight: 700;
  border: 1px solid transparent;
}

.hero-pill.connected {
  color: #7cff9a;
  background-color: #102317;
  border-color: #1f6a38;
}

.hero-pill.scanning {
  color: #d6f06b;
  background-color: #1d240b;
  border-color: #4d6216;
}

.hero-pill.idle {
  color: #93aa9a;
  background-color: #111914;
  border-color: #26352a;
}

.hero-center {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  flex: 1;
  padding: 10px 0 4px;
}

.hero-device-label {
  font-size: 13px;
  line-height: 18px;
  color: #88a694;
  margin-bottom: 18px;
}

.heart-rate-display {
  display: flex;
  flex-direction: row;
  align-items: flex-end;
  justify-content: center;
  gap: 10px;
}

.heart-rate {
  font-size: 92px;
  font-weight: bold;
  color: #7cff9a;
  line-height: 96px;
}

.unit {
  color: #7cff9a;
  font-size: 16px;
  margin-bottom: 18px;
  font-weight: 700;
}

.hero-status {
  margin-top: 14px;
  text-align: center;
  color: #8ba494;
  line-height: 20px;
  font-size: 14px;
  max-width: 220px;
}

.hero-error {
  margin-top: 8px;
  color: #ff8377;
  text-align: center;
  line-height: 20px;
}

.hero-disconnect-button {
  text-align: center;
  margin-top: 18px;
  min-width: 140px;
  padding: 11px 18px;
  background-color: #0d1510;
  color: #b9ccc0;
  border-radius: 14px;
  border: 1px solid #223529;
}

.control-card {
  background-color: #0d1510;
  border-radius: 22px;
  padding: 14px;
  display: flex;
  flex-direction: column;
  border: 1px solid #193323;
  box-shadow: 0 10px 24px rgba(0, 0, 0, 0.28);
}

.hint {
  color: #72887b;
  padding: 8px 2px 10px;
}

.primary-button {
  padding: 12px;
  background-color: #6aff8f;
  color: #031106;
  border-radius: 14px;
  font-weight: 700;
}

.secondary-button {
  padding: 11px;
  background-color: #132117;
  color: #8dffab;
  border-radius: 14px;
  border: 1px solid #24452f;
}

.ghost-button {
  padding: 12px;
  background-color: #0d1510;
  color: #b9ccc0;
  border-radius: 14px;
  border: 1px solid #223529;
}

.half {
  flex: 1;
}

.full {
  flex: 1;
}

.section-header {
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  align-items: center;
  padding: 0 4px 8px;
}

.section-count {
  color: #72f79d;
  font-size: 12px;
  font-weight: 600;
}

.list-card {
  background-color: #0d1510;
  border-radius: 22px;
  padding: 14px 14px 4px;
  box-shadow: 0 10px 24px rgba(0, 0, 0, 0.28);
  border: 1px solid #193323;
}

.device-item {
  padding: 14px 12px;
  border: 1px solid #1e3024;
  border-radius: 14px;
  background-color: #09100b;
  display: flex;
  flex-direction: column;
  margin-bottom: 10px;
}

.device-row {
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  align-items: center;
  gap: 10px;
}

.device-copy {
  display: flex;
  flex-direction: column;
}

.device-title {
  font-size: 16px;
  color: #dbffe5;
}

.device-id {
  margin-top: 4px;
  font-size: 12px;
  color: #73a785;
}

.device-state {
  margin-top: 8px;
  font-size: 12px;
  font-weight: 600;
}

.pill {
  padding: 6px 10px;
  border-radius: 999px;
  font-size: 12px;
  font-weight: 600;
  border: 1px solid transparent;
}

.pill.connected {
  color: #7cff9a;
  background-color: #132117;
  border-color: #2d6a40;
}

.pill.connecting {
  color: #d6f06b;
  background-color: #1d240b;
  border-color: #4d6216;
}

.device-state.connecting {
  color: #d6f06b;
}
</style>
