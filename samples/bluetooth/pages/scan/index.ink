<script type="application/json" def>
{
  "navigationBarTitleText": "Scan Filters"
}
</script>

<script setup>
export default {
  data: {
    isScanning: false,
    activeFilterLabel: 'None',
    devices: [],
    nameFilter: 'Polar H10',
    error: '',
  },

  onUnload: function () {
    this.stopScan();
  },

  onNameInput: function (e) {
    this.setData({ nameFilter: e.detail.value });
  },

  startHeartRateScan: async function () {
    await this.startScan(
      {
        filters: [{ services: ['heart_rate'] }],
      },
      'filters: heart_rate service'
    );
  },

  startAllDevicesScan: async function () {
    await this.startScan(
      {
        acceptAllDevices: true,
      },
      'acceptAllDevices: true'
    );
  },

  startNameScan: async function () {
    const name = (this.data.nameFilter || '').trim();
    if (!name) {
      this.setData({ error: 'Please provide a device name before starting a name filter scan.' });
      return;
    }

    await this.startScan(
      {
        filters: [{ name }],
      },
      `filters: name = ${name}`
    );
  },

  startScan: async function (options, label) {
    await this.stopScan();

    this.setData({
      isScanning: true,
      activeFilterLabel: label,
      devices: [],
      error: '',
    });

    try {
      const scan = await navigator.bluetooth.scanDevices(options);
      this.scanSession = scan;

      scan.onDeviceFound((event) => {
        const device = event.device;
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
      console.error('Failed to start Bluetooth scan', e);
      this.setData({
        isScanning: false,
        error: 'Failed to start scan: ' + e.message,
      });
    }
  },

  stopScan: async function () {
    if (!this.scanSession) {
      this.setData({ isScanning: false });
      return;
    }

    try {
      await this.scanSession.stop();
    } catch (e) {
      console.error('Failed to stop Bluetooth scan', e);
    } finally {
      this.scanSession = null;
      this.setData({ isScanning: false });
    }
  },
};
</script>

<page>
  <view class="container">
    <view class="nav-shell">
      <text class="eyebrow">Bluetooth Console</text>
      <text class="title">Scan Filters</text>
      <text class="subtitle">Run themed scan presets and inspect the reported devices like a live console feed.</text>
    </view>

    <view class="section">
      <text class="section-label">FILTERS</text>
      <view class="card">
        <text class="card-kicker">Control Panel</text>
        <text class="card-title">Preset Filters</text>
        <text class="card-subtitle">Run scans with common filter configurations.</text>
        <button class="primary-button" bindtap="startHeartRateScan">Heart Rate Service</button>
        <button class="secondary-button" bindtap="startAllDevicesScan">Accept All Devices</button>
        <input
          class="text-input"
          value="{{nameFilter}}"
          placeholder="Exact device name"
          bindinput="onNameInput"
        />
        <button class="secondary-button" bindtap="startNameScan">Exact Name Filter</button>
        <button class="ghost-button" bindtap="stopScan">Stop Scan</button>
      </view>
    </view>

    <view class="section">
      <text class="section-label">STATUS</text>
      <view class="card">
        <view class="status-row">
          <view style="flex-direction: column;">
            <text class="card-kicker">Session</text>
            <text class="card-title">Scan Session</text>
            <text class="card-subtitle">Active filter: {{ activeFilterLabel }}</text>
          </view>
          <view class="pill {{ isScanning ? 'ok' : 'idle' }}">
            {{ isScanning ? 'Scanning' : 'Idle' }}
          </view>
        </view>
        <text ink:if="{{error}}" class="error">{{ error }}</text>
      </view>
    </view>

    <view class="section">
      <text class="section-label">RESULTS</text>
      <view class="card list-card">
        <text class="card-kicker">Device Feed</text>
        <text ink:if="{{devices.length === 0}}" class="hint">No devices reported yet.</text>
        <view
          ink:for="{{ devices }}"
          ink:for-item="device"
          class="device-item"
          key="{{ device.id }}"
        >
          <text class="device-name">{{ device.name }}</text>
          <text class="device-id">{{ device.id }}</text>
        </view>
      </view>
    </view>
  </view>
</page>

<style>
.container {
  display: flex;
  flex-direction: column;
  padding: 18px 16px 28px;
  background-color: #050805;
  min-height: 100%;
}

.nav-shell {
  flex-direction: column;
  padding: 10px 4px 18px;
}

.eyebrow {
  font-size: 13px;
  font-weight: 600;
  color: #72f79d;
  text-transform: uppercase;
}

.title {
  font-size: 34px;
  line-height: 34px;
  font-weight: bold;
  color: #ecfff1;
  margin-top: 6px;
}

.subtitle {
  margin-top: 10px;
  font-size: 16px;
  color: #8ba494;
  line-height: 22px;
}

.section {
  flex-direction: column;
  margin-bottom: 18px;
}

.section-label {
  line-height: 12px;
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

.card-title {
  font-size: 17px;
  font-weight: 600;
  color: #d7ffe2;
}

.card-subtitle {
  margin-top: 6px;
  margin-bottom: 12px;
  color: #81a08b;
  font-size: 14px;
  line-height: 20px;
}

.card {
  background-color: #0d1510;
  border-radius: 18px;
  padding: 16px;
  margin-bottom: 10px;
  display: flex;
  flex-direction: column;
  border: 1px solid #193323;
  box-shadow: 0 10px 24px rgba(0, 0, 0, 0.28);
}

.text-input {
  margin: 8px 0 10px;
  padding: 10px 12px;
  border-radius: 14px;
  background-color: #07100a;
  border: 1px solid #1e3b29;
  color: #d9ffe4;
}

.primary-button {
  padding: 10px;
  background-color: #6aff8f;
  color: #031106;
  border-radius: 14px;
  font-weight: 700;
}

.secondary-button {
  padding: 10px;
  margin-top: 8px;
  background-color: #132117;
  color: #8dffab;
  border-radius: 14px;
  border: 1px solid #24452f;
}

.ghost-button {
  padding: 10px;
  margin-top: 8px;
  background-color: #0b120d;
  color: #9eb8a6;
  border-radius: 14px;
  border: 1px solid #1b2a1f;
}

.status-row {
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  align-items: center;
  gap: 10px;
}

.pill {
  padding: 6px 10px;
  border-radius: 999px;
  font-size: 12px;
  font-weight: 600;
  border: 1px solid transparent;
}

.pill.ok {
  color: #7cff9a;
  background-color: #102317;
  border-color: #1f6a38;
}

.pill.idle {
  color: #93aa9a;
  background-color: #111914;
  border-color: #26352a;
}

.error {
  color: #ff8377;
  margin-top: 10px;
}

.list-card {
  padding-top: 14px;
}

.hint {
  color: #72887b;
  padding: 8px 0 10px;
}

.device-item {
  padding: 12px;
  border: 1px solid #1e3024;
  border-radius: 14px;
  background-color: #09100b;
  display: flex;
  flex-direction: column;
  margin-bottom: 10px;
}

.device-name {
  font-size: 16px;
  color: #dbffe5;
}

.device-id {
  margin-top: 4px;
  font-size: 12px;
  color: #73a785;
}
</style>
