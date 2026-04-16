import wx from 'wx';

export function testRequest() {
  const startTime = performance.now();
  wx.request({
    url: 'https://www.rokid.com',
    success: (res) => {
      console.info(res);
    },
    complete: () => {
      const endTime = performance.now();
      console.info(`request completed in ${endTime - startTime}ms`);
    },
  });
}

export function testSSE() {
  const es = wx.createEventSource({
    url: 'https://sse.dev/test',
  });
  es.onOpen(() => {
    console.log('SSE Open');
  });
  es.onMessage((msg) => {
    console.log('SSE Message:', msg);
  });
  es.onError((err) => {
    console.log('SSE Error:', err);
  });
}
