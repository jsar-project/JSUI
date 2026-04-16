<script setup>
export default {
  data: {
    switch1Value: false,
    switch2Value: true,
    switch3Value: false,
    switch4Value: true,
    switch5Value: false,
    checkbox1Value: false,
    checkbox2Value: true,
  },

  onSwitchChange(e) {
    console.log('switch changed:', e.detail.value);
    const id = e.currentTarget.attributes['id'];
    if (id) {
      this.setData({
        [`${id}Value`]: e.detail.value
      });
    }
  }
};
</script>

<page>
  <view class="container">
    <view class="page-title">Switch Component</view>

    <view class="section">
      <text class="section-title">Default Switch</text>
      <view class="row">
        <text>Status: {{switch1Value}}</text>
        <switch id="switch1" checked="{{switch1Value}}" bindchange="onSwitchChange" />
      </view>
    </view>

    <view class="section">
      <text class="section-title">Checked Switch</text>
      <view class="row">
        <text>Status: {{switch2Value}}</text>
        <switch id="switch2" checked="{{switch2Value}}" bindchange="onSwitchChange" />
      </view>
    </view>

    <view class="section">
      <text class="section-title">Disabled Switch</text>
      <view class="row">
        <text>Status: {{switch3Value}}</text>
        <switch id="switch3" disabled="true" checked="{{switch3Value}}" bindchange="onSwitchChange" />
      </view>
      <view class="row mt-10">
        <text>Status: {{switch4Value}}</text>
        <switch id="switch4" disabled="true" checked="{{switch4Value}}" bindchange="onSwitchChange" />
      </view>
    </view>

    <view class="section">
      <text class="section-title">Custom Color Switch</text>
      <view class="row">
        <text>Status: {{switch5Value}}</text>
        <switch id="switch5" color="#ff0000" checked="{{switch5Value}}" bindchange="onSwitchChange" />
      </view>
    </view>

    <view class="section">
      <text class="section-title">Checkbox Type</text>
      <view class="row">
        <text>Status: {{checkbox1Value}}</text>
        <switch id="checkbox1" type="checkbox" checked="{{checkbox1Value}}" bindchange="onSwitchChange" />
      </view>
      <view class="row mt-10">
        <text>Status: {{checkbox2Value}}</text>
        <switch id="checkbox2" type="checkbox" color="#00ff00" checked="{{checkbox2Value}}" bindchange="onSwitchChange" />
      </view>
    </view>

  </view>
</page>

<style>
  .container {
    display: flex;
    flex-direction: column;
    padding: 20px;
    background-color: #f8f9fa;
  }

  .page-title {
    font-size: 24px;
    font-weight: bold;
    color: #1d1d1f;
    margin-bottom: 24px;
  }

  .section {
    flex-direction: column;
    margin-bottom: 24px;
    background-color: #ffffff;
    padding: 16px;
    border-radius: 8px;
    border: 1px solid #e5e5ea;
  }

  .section-title {
    font-size: 16px;
    font-weight: bold;
    color: #333333;
    margin-bottom: 12px;
  }

  .row {
    display: flex;
    flex-direction: row;
    align-items: center;
    justify-content: space-between;
  }

  .mt-10 {
    margin-top: 10px;
  }
</style>