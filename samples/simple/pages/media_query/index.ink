<script setup>
export default {
}
</script>

<page>
  <view class="container">
    <view class="header">Media Query Test</view>
    
    <view class="box-container">
      <view class="responsive-box">
        <text class="box-text">Resize window to see changes</text>
      </view>
    </view>
    
    <view class="info-panel">
      <view class="info-item portrait-only">Orientation: Portrait</view>
      <view class="info-item landscape-only">Orientation: Landscape</view>
      
      <view class="info-item mobile-only">Screen: Mobile (&lt; 500px)</view>
      <view class="info-item tablet-only">Screen: Tablet (500px - 800px)</view>
      <view class="info-item desktop-only">Screen: Desktop (&gt; 800px)</view>
    </view>

    <view class="viewport-units-demo">
      <view class="vw-box">50vw width</view>
      <view class="vh-box">20vh height</view>
    </view>
  </view>
</page>

<style>
.container {
  display: flex;
  flex-direction: column;
  width: 100%;
  height: 100%;
  padding: 20px;
  box-sizing: border-box;
  background-color: #f5f5f5;
  gap: 20px;
}

.header {
  font-size: 24px;
  font-weight: bold;
  text-align: center;
  color: #333;
}

/* Base styles for the responsive box */
.box-container {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
  padding: 20px;
  background-color: white;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.responsive-box {
  display: flex;
  justify-content: center;
  align-items: center;
  background-color: #4CAF50;
  border-radius: 8px;
  transition: all 0.3s ease;
  
  /* Default: Desktop size */
  width: 300px;
  height: 200px;
}

.box-text {
  color: white;
  font-size: 16px;
  font-weight: bold;
}

/* Info Panel */
.info-panel {
  display: flex;
  flex-direction: column;
  gap: 10px;
  background-color: white;
  padding: 15px;
  border-radius: 8px;
}

.info-item {
  padding: 10px;
  border-radius: 4px;
  color: white;
  font-weight: bold;
  text-align: center;
  display: none; /* Hidden by default */
}

/* Viewport Units Demo */
.viewport-units-demo {
  display: flex;
  flex-direction: column;
  gap: 10px;
  background-color: white;
  padding: 15px;
  border-radius: 8px;
}

.vw-box {
  background-color: #9C27B0;
  color: white;
  height: 50px;
  width: 50vw;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 4px;
}

.vh-box {
  background-color: #FF9800;
  color: white;
  width: 100%;
  height: 20vh;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 4px;
}

/* Media Queries */

/* Orientation */
@media (orientation: portrait) {
  .portrait-only {
    display: flex;
    background-color: #607D8B;
  }
}

@media (orientation: landscape) {
  .landscape-only {
    display: flex;
    background-color: #607D8B;
  }
}

/* Mobile: < 500px */
@media (max-width: 500px) {
  .responsive-box {
    width: 150px;
    height: 100px;
    background-color: #F44336; /* Red */
  }
  
  .box-text {
    font-size: 12px;
  }

  .mobile-only {
    display: flex;
    background-color: #F44336;
  }
}

/* Tablet: 500px - 800px */
@media (min-width: 500px) and (max-width: 800px) {
  .responsive-box {
    width: 200px;
    height: 150px;
    background-color: #2196F3; /* Blue */
  }

  .tablet-only {
    display: flex;
    background-color: #2196F3;
  }
}

/* Desktop: > 800px */
@media (min-width: 800px) {
  .desktop-only {
    display: flex;
    background-color: #4CAF50;
  }
}

</style>
