<script type="application/json" def>
{
  "schema": {
    "data": {}
  }
}
</script>

<script setup>
import wx from 'wx';

export default {
  onShow() {
    try {
      this.draw();
    } catch (err) {
      console.error('failed to draw', err.message || err);
      console.error(err.stack);
    }
  },

  draw() {
    const ctx = wx.createCanvasContext('apiCanvas');
    if (!ctx) return;

    // 1. 测试 clearRect
    ctx.fillStyle = '#f0f0f0';
    ctx.fillRect(0, 0, 400, 800);
    ctx.clearRect(50, 50, 100, 100); // 在灰色背景上清除一个方块

    // 2. 测试路径和基础样式 (strokeStyle, lineWidth, lineCap, lineJoin)
    ctx.beginPath();
    ctx.strokeStyle = 'red';
    ctx.lineWidth = 10;
    ctx.lineCap = 'round';
    ctx.lineJoin = 'bevel';
    ctx.moveTo(20, 150);
    ctx.lineTo(100, 150);
    ctx.lineTo(100, 200);
    ctx.stroke();

    ctx.beginPath();
    ctx.strokeStyle = 'blue';
    ctx.lineWidth = 15;
    ctx.lineCap = 'square';
    ctx.lineJoin = 'round';
    ctx.moveTo(150, 150);
    ctx.lineTo(230, 150);
    ctx.lineTo(230, 200);
    ctx.stroke();

    // 3. 测试 quadraticCurveTo
    ctx.beginPath();
    ctx.strokeStyle = 'green';
    ctx.lineWidth = 5;
    ctx.moveTo(20, 250);
    ctx.quadraticCurveTo(100, 200, 180, 250);
    ctx.stroke();

    // 4. 测试 bezierCurveTo
    ctx.beginPath();
    ctx.strokeStyle = 'purple';
    ctx.moveTo(20, 350);
    ctx.bezierCurveTo(20, 300, 180, 400, 180, 350);
    ctx.stroke();

    // 5. 测试 rect() 和 fillStyle
    ctx.beginPath();
    ctx.fillStyle = 'orange';
    ctx.rect(20, 450, 100, 50);
    ctx.fill();
    ctx.strokeStyle = 'black';
    ctx.lineWidth = 2;
    ctx.stroke();

    // 6. 测试 arc() 和 closePath
    ctx.beginPath();
    ctx.fillStyle = 'cyan';
    ctx.arc(250, 475, 40, 0, Math.PI * 1.5);
    ctx.closePath(); // 闭合路径，形成扇形到圆心的连线（如果用了 moveTo 到圆心的话）
    ctx.fill();
    ctx.stroke();

    // 7. 测试多种 lineJoin
    const lineJoins = ['round', 'bevel', 'miter'];
    ctx.lineWidth = 20;
    ctx.strokeStyle = 'black';
    for (let i = 0; i < lineJoins.length; i++) {
      ctx.lineJoin = lineJoins[i];
      ctx.beginPath();
      ctx.moveTo(20, 550 + i * 50);
      ctx.lineTo(70, 600 + i * 50);
      ctx.lineTo(120, 550 + i * 50);
      ctx.stroke();
    }
  }
}
</script>

<page>
  <view class="container">
    <view class="page-title">Canvas API</view>
    <view class="card">
      <canvas id="apiCanvas" width="400" height="800" class="canvas"></canvas>
    </view>
  </view>
</page>

<style>
.container {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 20px;
}

.title {
  font-size: 24px;
  font-weight: bold;
  margin-bottom: 20px;
}

.canvas {
  width: 400px;
  height: 800px;
  border: 1px solid #ccc;
  background-color: #fff;
}
</style>
