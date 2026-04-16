export default {
  onLaunch: function () {
    console.log('App Launch', this);
  },
  onShow: function () {
    console.log('App Show');
  },
  onHide: function () {
    console.log('App Hide');
  },
  globalData: {
    hasLogin: false,
  },
};
