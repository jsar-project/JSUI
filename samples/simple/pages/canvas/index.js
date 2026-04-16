import wx from 'wx';

export default {
  onShow() {
    try {
      this.drawAll();
    } catch (err) {
      console.error('failed to draw', err.message || err);
      console.error(err.stack);
    }
  },

  onLoad(query) {
    console.info('load page', query);
  },

  drawAll() {
    const ctx = wx.createCanvasContext('myCanvas');
    if (!ctx) return;

    // 1. Clear
    ctx.clearRect(0, 0, 300, 300);

    // 2. Draw Rectangles with Shadows
    ctx.shadowBlur = 10;
    ctx.shadowColor = 'rgba(0, 0, 0, 0.5)';
    ctx.shadowOffsetX = 5;
    ctx.shadowOffsetY = 5;

    ctx.fillStyle = '#ff0000';
    ctx.fillRect(20, 20, 60, 60);

    ctx.shadowBlur = 0; // Reset shadow
    ctx.shadowOffsetX = 0;
    ctx.shadowOffsetY = 0;
    ctx.strokeStyle = '#0000ff';
    ctx.lineWidth = 4;
    ctx.strokeRect(15, 15, 70, 70);

    // 3. Draw Circle with Gradient
    const gradient = ctx.createRadialGradient(150, 100, 5, 150, 100, 40);
    // Note: addColorStop is currently a placeholder in ink-script,
    // but the native side uses a default black-to-white gradient for now.
    ctx.fillStyle = gradient;
    ctx.beginPath();
    ctx.arc(150, 100, 40, 0, 2 * Math.PI);
    ctx.fill();
    ctx.strokeStyle = '#000000';
    ctx.lineWidth = 2;
    ctx.stroke();

    // 4. Draw Text with Alignment
    console.log('Drawing debug text...');
    ctx.font = '40px Arial';
    ctx.fillStyle = 'blue';
    ctx.textAlign = 'start';
    ctx.textBaseline = 'alphabetic';
    ctx.fillText('TEXT TEST', 10, 250);

    // 5. Pixel Manipulation (ImageData)
    try {
      const imageData = ctx.getImageData(20, 20, 1, 1);
      console.log('Top-left pixel of red rect:', Array.from(imageData.data));
    } catch (e) {
      console.error('ImageData failed:', e);
    }
  },

  drawRect() {
    this.drawAll();
  },
  drawCircle() {
    this.drawAll();
  },
  drawText() {
    this.drawAll();
  },

  clearCanvas() {
    const ctx = wx.createCanvasContext('myCanvas');
    ctx.clearRect(0, 0, 300, 300);
  },
};
