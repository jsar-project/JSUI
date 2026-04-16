<script setup>
  export default {
    data: {
      avatarSrc: '../../assets/avatar.jpg',
      elephantSrc: '../../assets/elephant.png',
      svgSrc: '../../assets/clear-day.svg'
    },
    onLoad() {
      console.log('Image test page loaded');
    }
  };
</script>

<page>
  <view class="container">
    <view class="title">Image Test</view>
    
    <view class="section">
      <view class="section-title">JPG Image</view>
      <view class="image-container">
        <image class="test-image" src="{{ avatarSrc }}" mode="aspectFill" />
      </view>
    </view>

    <view class="section">
      <view class="section-title">PNG Image</view>
      <view class="image-container">
        <image class="test-image" src="{{ elephantSrc }}" mode="aspectFit" />
      </view>
    </view>

    <view class="section">
      <view class="section-title">SVG Image</view>
      <view class="image-container">
        <image class="test-image" src="{{ svgSrc }}" mode="aspectFit" />
      </view>
    </view>
    
    <view class="section">
      <view class="section-title">Broken Image</view>
      <view class="image-container">
        <image class="test-image" src="../../assets/does-not-exist.png" mode="aspectFit" />
      </view>
    </view>
    
  </view>
</page>

<style>
  .container {
    display: flex;
    flex-direction: column;
    width: 100%;
    background-color: #f5f5f7;
    padding: 20px;
    box-sizing: border-box;
  }

  .title {
    font-size: 28px;
    font-weight: bold;
    color: #1d1d1f;
    margin-bottom: 24px;
    text-align: center;
  }

  .section {
    display: flex;
    flex-direction: column;
    align-items: center;
    background-color: #ffffff;
    border-radius: 12px;
    padding: 16px;
    margin-bottom: 20px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.05);
  }

  .section-title {
    font-size: 18px;
    font-weight: 600;
    color: #333333;
    margin-bottom: 12px;
  }

  .image-container {
    width: 240px;
    height: 240px;
    background-color: #e5e5ea;
    border-radius: 8px;
    overflow: hidden;
    display: flex;
    justify-content: center;
    align-items: center;
  }

  .test-image {
    width: 100%;
    height: 100%;
  }
</style>
