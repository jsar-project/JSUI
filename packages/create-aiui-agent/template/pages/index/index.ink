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
  color: #40FF5E;
  width: 100%;
  text-align: center;
  font-size: 24px;
  line-height: 24px;
  margin-bottom: 20px;
}

button {
  color: #40FF5E;
  border: 2px solid #40FF5E;
  border-radius: 12px;
  box-sizing: border-box;
  padding: 5px;
  width: 100px;
  line-height: 24px;
  text-align: center;
}
</style>
