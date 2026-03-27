<script def>
{
  "navigationBarTitleText": "Index Page"
}
</script>

<script setup>
export default {
  data: {
    greeting: 'Hello JSUI!'
  },
  handleTap() {
    this.setData({
      greeting: '你好，世界！'
    });
  }
}
</script>

<page>
  <view class="container">
    <text class="title">{{ greeting }}</text>
    <button bindtap="handleTap">点击我</button>
  </view>
</page>

<style>
.container {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 100vh;
}

.title {
  font-size: 24px;
  margin-bottom: 20px;
}
</style>
