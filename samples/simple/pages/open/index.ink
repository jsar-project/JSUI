<script setup>
import { createOpenAPI } from 'open';

export default {
  data: {
    status: 'idle',
    result: '',
    error: '',
  },

  async onLoad() {
    console.log('Open module test page loaded');
    try {
      this.api = await createOpenAPI('dev');
      console.info('api is ready', this.api);
    } catch (err) {
      console.info('failed to create open api', err);
      this.setData({ status: 'error', error: String(err) });
    }
  },

  async callHello() {
    if (!this.api || !this.api.dummy) {
      this.setData({ status: 'error', error: 'API not initialized' });
      return;
    }
    
    this.setData({ status: 'loading', result: '', error: '' });
    try {
      const res = await this.api.dummy.hello();
      console.info(res);
      const text = typeof res === 'string' ? res : JSON.stringify(res, null, 2);
      this.setData({ status: 'success', result: text });
    } catch (err) {
      console.error('failed to call', err);
      this.setData({ status: 'error', error: String(err) });
    }
  },
};
</script>

<page>
  <view class="container">
    <view class="page-title">Open Module Test</view>

    <view class="info-card">
      <text class="label">Method: dummy.hello()</text>
      <text class="label">URL: https://example.com/hello</text>
    </view>

    <view class="status-row">
      <text class="status-label">Status:</text>
      <text class="status-value status-{{status}}">{{status}}</text>
    </view>

    <view class="result-box" ink:if="{{status === 'success'}}">
      <text class="result-title">Response</text>
      <text class="result-text">{{result}}</text>
    </view>

    <view class="error-box" ink:if="{{status === 'error'}}">
      <text class="error-title">Error</text>
      <text class="error-text">{{error}}</text>
    </view>

    <button class="btn" bindtap="callHello">Call dummy.hello()</button>
  </view>
</page>

<style>
  .container {
    display: flex;
    flex-direction: column;
    padding: 40px;
    background-color: #f8f9fa;
  }

  .title {
    font-size: 28px;
    font-weight: bold;
    color: #1d1d1f;
    margin-bottom: 24px;
  }

  .info-card {
    background-color: #ffffff;
    border-radius: 10px;
    padding: 16px;
    margin-bottom: 20px;
    border: 1px solid #e5e5ea;
    flex-direction: column;
  }

  .label {
    font-size: 14px;
    color: #6c757d;
    margin-bottom: 4px;
    font-family: monospace;
  }

  .status-row {
    flex-direction: row;
    align-items: center;
    margin-bottom: 20px;
  }

  .status-label {
    font-size: 16px;
    color: #1d1d1f;
    margin-right: 8px;
  }

  .status-value {
    font-size: 16px;
    font-weight: bold;
  }

  .status-idle {
    color: #6c757d;
  }

  .status-loading {
    color: #ff9f0a;
  }

  .status-success {
    color: #34c759;
  }

  .status-error {
    color: #ff3b30;
  }

  .result-box {
    background-color: #f0fff4;
    border-radius: 10px;
    padding: 16px;
    margin-bottom: 20px;
    border: 1px solid #34c759;
    flex-direction: column;
  }

  .result-title {
    font-size: 14px;
    font-weight: bold;
    color: #34c759;
    margin-bottom: 8px;
  }

  .result-text {
    font-size: 13px;
    color: #1d1d1f;
    font-family: monospace;
  }

  .error-box {
    background-color: #fff5f5;
    border-radius: 10px;
    padding: 16px;
    margin-bottom: 20px;
    border: 1px solid #ff3b30;
    flex-direction: column;
  }

  .error-title {
    font-size: 14px;
    font-weight: bold;
    color: #ff3b30;
    margin-bottom: 8px;
  }

  .error-text {
    font-size: 13px;
    color: #1d1d1f;
    font-family: monospace;
  }

  .btn {
    background-color: #007aff;
    color: #ffffff;
    font-size: 16px;
    font-weight: bold;
    border-radius: 8px;
    padding: 12px 20px;
    text-align: center;
  }
</style>
