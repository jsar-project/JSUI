export default {
  data: {
    isPlaying: true,
  },
  onLoad() {
    console.log('Lottie test page loaded');
  },
  togglePlay() {
    this.setData({
      isPlaying: !this.data.isPlaying,
    });
  },
};
