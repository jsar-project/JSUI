<script setup>
import wx from 'wx';

export default {
  onLoad() {
    console.log('Outline test page loaded');
  },
};
</script>

<page>
  <view class="container">
    <view class="page-title">Outline</view>

    <view class="card section">
      <text class="label">outline: 2px solid blue</text>
      <view class="box solid-outline"></view>
    </view>

    <view class="card section">
      <text class="label">outline: 2px dashed red</text>
      <view class="box dashed-outline"></view>
    </view>

    <view class="card section">
      <text class="label">outline: 2px dotted green</text>
      <view class="box dotted-outline"></view>
    </view>

    <view class="card section">
      <text class="label">outline-offset: 4px</text>
      <view class="box offset-outline"></view>
    </view>

    <view class="card section">
      <text class="label">outline + border-radius</text>
      <view class="box rounded-outline"></view>
    </view>

    <view class="card section">
      <text class="label">outline + border</text>
      <view class="box border-and-outline"></view>
    </view>
  </view>
</page>

<style>
  .container {
    display: flex;
    flex-direction: column;
    padding: 20px;
    background-color: #f0f0f0;
  }

  .title {
    font-size: 24px;
    font-weight: bold;
    margin-bottom: 20px;
    display: block;
  }

  .section {
    flex-direction: column;
    margin-bottom: 40px;
  }

  .label {
    color: black;
    font-size: 16px;
    margin-bottom: 12px;
    display: block;
  }

  .box {
    width: 80px;
    height: 80px;
    background-color: #e0e8ff;
  }

  .solid-outline {
    outline: 2px solid blue;
  }

  .dashed-outline {
    outline: 2px dashed red;
  }

  .dotted-outline {
    outline: 2px dotted green;
  }

  .offset-outline {
    outline-width: 2px;
    outline-style: solid;
    outline-color: #ff6600;
    outline-offset: 4px;
  }

  .rounded-outline {
    border-radius: 12px;
    outline: 3px solid #9b59b6;
    outline-offset: 2px;
  }

  .border-and-outline {
    border: 2px solid #333;
    outline: 3px solid #e74c3c;
    outline-offset: 3px;
  }
</style>
