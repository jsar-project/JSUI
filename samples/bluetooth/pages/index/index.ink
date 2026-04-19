<script type="application/json" def>
{
  "navigationBarTitleText": "Bluetooth Guide"
}
</script>

<script setup>
import wx from 'wx';

export default {
  data: {
    isAvailable: false,
    statusText: 'Checking Bluetooth availability...',
  },

  onLoad: async function () {
    await this.refreshAvailability();
  },

  refreshAvailability: async function () {
    try {
      const isAvailable = await navigator.bluetooth.getAvailability();
      this.setData({
        isAvailable,
        statusText: isAvailable
          ? 'Bluetooth is available. Choose a page to start testing.'
          : 'Bluetooth is not available on this device.',
      });
    } catch (e) {
      console.error('Failed to query Bluetooth availability', e);
      this.setData({
        isAvailable: false,
        statusText: 'Failed to query Bluetooth availability: ' + e.message,
      });
    }
  },

  goToScan: function () {
    wx.navigateTo({ url: '/pages/scan/index' });
  },

  goToHeartRate: function () {
    wx.navigateTo({ url: '/pages/heart_rate/index' });
  },
};
</script>

<page>
  <view class="container">
    <view class="nav-shell">
      <text class="eyebrow">Bluetooth Console</text>
      <text class="title">Bluetooth Agent</text>
      <text class="subtitle">Dark-panel demos for scan validation and live monitor testing.</text>
    </view>

    <view class="section">
      <text class="section-label">STATUS</text>
      <view class="card">
        <view class="status-row">
          <view class="status-copy">
            <text class="card-title">Bluetooth Availability</text>
            <text class="card-subtitle">{{ statusText }}</text>
          </view>
          <view class="pill {{ isAvailable ? 'ok' : 'warn' }}">
            {{ isAvailable ? 'Available' : 'Unavailable' }}
          </view>
        </view>
        <button class="primary-button" bindtap="refreshAvailability">Refresh</button>
      </view>
    </view>

    <view class="section">
      <text class="section-label">PAGES</text>
      <view class="card nav-card" bindtap="goToScan">
        <view class="nav-copy">
          <text class="nav-kicker">Scanner</text>
          <text class="card-title">Scan Filters</text>
          <text class="card-subtitle">
            Validate `scanDevices()` filter combinations and inspect discovered devices.
          </text>
        </view>
        <text class="chevron">›</text>
      </view>
      <view class="card nav-card" bindtap="goToHeartRate">
        <view class="nav-copy">
          <text class="nav-kicker">Monitor</text>
          <text class="card-title">Heart Rate</text>
          <text class="card-subtitle">
            Connect to a monitor, read BPM values, and manage the active connection.
          </text>
        </view>
        <text class="chevron">›</text>
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
  margin-bottom: 4px;
}

.eyebrow {
  font-size: 13px;
  font-weight: 600;
  color: #72f79d;
  text-transform: uppercase;
}

.section {
  flex-direction: column;
  margin-bottom: 18px;
}

.section-label {
  font-size: 12px;
  font-weight: 600;
  color: #4e745a;
  margin: 0 0 8px 2px;
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

.card-title {
  font-size: 17px;
  font-weight: 600;
  color: #d7ffe2;
}

.card-subtitle {
  margin-top: 6px;
  color: #81a08b;
  font-size: 14px;
  line-height: 20px;
}

.status-row {
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  align-items: center;
  gap: 12px;
}

.status-copy {
  display: flex;
  flex: 1;
  flex-direction: column;
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

.pill.warn {
  color: #d6f06b;
  background-color: #1d240b;
  border-color: #4d6216;
}

.primary-button {
  margin-top: 14px;
  padding: 10px;
  background-color: #6aff8f;
  color: #031106;
  border-radius: 14px;
  font-weight: 700;
}

.nav-card {
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: space-between;
  gap: 14px;
}

.nav-copy {
  display: flex;
  flex: 1;
  flex-direction: column;
}

.nav-kicker {
  font-size: 11px;
  font-weight: 700;
  text-transform: uppercase;
  color: #53cc77;
  margin-bottom: 6px;
}

.chevron {
  font-size: 28px;
  color: #6aff8f;
}
</style>
