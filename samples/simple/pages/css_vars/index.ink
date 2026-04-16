<script setup>
  export default {
    onLoad() {
      console.log('CSS Variables Page Loaded');
    },
  };
</script>

<page>
  <view class="container">
    <text class="page-title">CSS Variables Demo</text>

    <view class="demo-card">
      <text class="demo-title">Primary Theme Box</text>
      <text class="demo-desc">This box uses variables defined in app.wxss.</text>
    </view>

    <view class="demo-card secondary">
      <text class="demo-title">Secondary Theme Box</text>
      <text class="demo-desc">This box overrides a global variable locally.</text>
    </view>

    <view class="demo-card fallback">
      <text class="demo-title">Fallback Value Box</text>
      <text class="demo-desc">This box uses a fallback value for an undefined variable.</text>
    </view>
  </view>
</page>

<style>
  .demo-card {
    flex-direction: column;
    margin-bottom: var(--theme-padding);
    padding: var(--theme-padding);
    background-color: var(--theme-bg);
    border: var(--theme-border);
    border-radius: var(--theme-radius);
  }

  .demo-title {
    font-size: 18px;
    font-weight: bold;
    color: var(--theme-color);
    margin-bottom: 10px;
  }

  .demo-desc {
    font-size: 14px;
    color: #666;
  }

  .secondary {
    /* Override global variables for this scope */
    --theme-color: #e74c3c;
    --theme-bg: #fadbd8;
    --theme-border: 2px dashed #e74c3c;
  }

  .fallback {
    /* Use a fallback value because --undefined-color doesn't exist */
    background-color: var(--undefined-bg, #d5f5e3);
    border: 2px solid var(--undefined-color, #2ecc71);
  }

  .fallback .demo-title {
    color: var(--undefined-color, #2ecc71);
  }
</style>
