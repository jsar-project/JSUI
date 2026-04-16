import wx from 'wx';

export default {
  onLoad() {
    const ctx = wx.createCanvasContext('myCanvas');
    ctx.setFontSize(20);

    ctx.font = 'normal 20px sans-serif';
    ctx.fillText('Canvas Normal (400)', 10, 30);

    ctx.font = 'bold 20px sans-serif';
    ctx.fillText('Canvas Bold (700)', 10, 60);

    ctx.font = '900 20px sans-serif';
    ctx.fillText('Canvas 900 (Black)', 10, 90);

    ctx.draw();
  },
};
