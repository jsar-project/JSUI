import wx from 'wx';

export default {
  data: {
    list: [
      { isHeader: true, name: 'Layout & Basic' },
      { name: 'Layout', path: '../layout/index' },
      { name: 'Position', path: '../position/index' },
      { name: 'Grid', path: '../grid/index' },
      { name: 'List', path: '../list/index' },
      { isHeader: true, name: 'Styling' },
      { name: 'Font Styling', path: '../font_styling/index' },
      { name: 'Font Weight', path: '../font_weight/index' },
      { name: 'Transform', path: '../transform/index' },
      { name: 'Filter', path: '../filter/index' },
      { name: 'Opacity', path: '../opacity/index' },
      { name: 'Outline', path: '../outline/index' },
      { name: 'CSS Variables', path: '../css_vars/index' },
      { name: 'Media Query', path: '../media_query/index' },
      { isHeader: true, name: 'Graphics & Canvas' },
      { name: 'Canvas', path: '../canvas/index' },
      { name: 'Canvas API', path: '../canvas_api/index' },
      { name: 'Chart', path: '../chart/index' },
      { name: 'Lottie', path: '../lottie/index' },
      { isHeader: true, name: 'Components & Other' },
      { name: 'A2UI', path: '../a2ui/index' },
      { name: 'Error State', path: '../error_state/index' },
      { name: 'Streamdown', path: '../streamdown/index' },
      { name: 'Open', path: '../open/index' },
      { name: 'Image', path: '../image/index' },
      { isHeader: true, name: 'Input & Forms' },
      { name: 'Input & Textarea', path: '../input_textarea/index' },
      { name: 'Switch', path: '../switch/switch' },
    ],
  },
  onLoad: function () {
    console.log('Index Page Load');
  },
  navigateToPage: function (e) {
    const path = e.currentTarget.attributes['data-path'];
    if (path) {
      wx.navigateTo({ url: path });
    }
  },
};
