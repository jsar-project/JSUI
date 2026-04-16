<script setup>
import wx from 'wx';

export default {
  onLoad() {
    console.log('Filter test page loaded');
  },
};
</script>

<page>
  <view class="container">
    <view class="title">Filter</view>

    <view class="card section">
      <text class="label">filter: drop-shadow</text>
      <view class="box drop-shadow"></view>
    </view>

    <view class="card section">
      <text class="label">filter: blur(5px)</text>
      <view class="box blur"></view>
    </view>

    <view class="card section">
      <text class="label">filter: grayscale(100%)</text>
      <view class="box grayscale">
        <view class="inner-box bg-red"></view>
        <view class="inner-box bg-green"></view>
        <view class="inner-box bg-blue"></view>
      </view>
    </view>

    <view class="card section">
      <text class="label">filter: invert(100%)</text>
      <view class="box invert">
        <view class="inner-box bg-red"></view>
        <view class="inner-box bg-green"></view>
        <view class="inner-box bg-blue"></view>
      </view>
    </view>

    <view class="card section">
      <text class="label">filter: opacity(50%)</text>
      <view class="box opacity"></view>
    </view>

    <view class="card section">
      <text class="label">filter: contrast(200%) brightness(150%)</text>
      <view class="box contrast-brightness">
        <view class="inner-box bg-red"></view>
        <view class="inner-box bg-green"></view>
        <view class="inner-box bg-blue"></view>
      </view>
    </view>

    <view class="card section">
      <text class="label">Multiple filters combined</text>
      <view class="box combined">
        <view class="inner-box bg-red"></view>
      </view>
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
    background-color: #3498db;
    display: flex;
    flex-direction: row;
    justify-content: center;
    align-items: center;
    border-radius: 8px;
  }

  .inner-box {
    width: 20px;
    height: 20px;
    margin: 2px;
    border-radius: 4px;
  }

  .bg-red { background-color: #e74c3c; }
  .bg-green { background-color: #2ecc71; }
  .bg-blue { background-color: #2980b9; }

  .drop-shadow {
    filter: drop-shadow(5px 5px 10px rgba(0, 0, 0, 0.5));
  }

  .blur {
    filter: blur(5px);
  }

  .grayscale {
    filter: grayscale(100%);
  }

  .invert {
    filter: invert(100%);
  }

  .opacity {
    filter: opacity(50%);
  }

  .contrast-brightness {
    filter: contrast(200%) brightness(150%);
  }

  .combined {
    filter: drop-shadow(4px 4px 5px rgba(0, 0, 0, 0.4)) blur(2px) grayscale(50%);
  }
</style>