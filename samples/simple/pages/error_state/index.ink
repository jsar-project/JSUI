<script setup>
  export default {
    onLoad() {
      console.log('Error State test page loaded');
    },
  };
</script>

<page>
  <view class="container">
    <view class="page-title">Error State</view>

    <view class="section">
      <text class="section-title">Default Error State</text>
      <error-state
        class="error-box"
        text="Something went wrong."
      />
    </view>

    <view class="section">
      <text class="section-title">Error State with Icon</text>
      <error-state
        class="error-box error-box--warning"
        icon="https://cdn.jsdelivr.net/npm/@material-design-icons/svg@0.14.13/filled/warning.svg"
        text="The request could not be completed. Please try again later."
      />
    </view>

    <view class="section">
      <text class="section-title">Critical Error State</text>
      <error-state
        class="error-box error-box--critical"
        icon="https://cdn.jsdelivr.net/npm/@material-design-icons/svg@0.14.13/filled/error.svg"
        text="An unexpected critical error has occurred."
      />
    </view>
  </view>
</page>

<style>
  .container {
    padding: 40px;
    background-color: #f8f9fa;
    flex-direction: column;
  }

  .page-title {
    color: #333;
    font-size: 28px;
    font-weight: bold;
    margin-bottom: 30px;
  }

  .section {
    flex-direction: column;
    margin-bottom: 30px;
    background-color: #ffffff;
    padding: 20px;
    border-radius: 12px;
    border: 1px solid #dee2e6;
  }

  .section-title {
    color: #6c757d;
    font-size: 14px;
    font-weight: bold;
    margin-bottom: 12px;
  }

  .error-box {
    flex-direction: row;
    align-items: center;
    padding: 16px;
    border-radius: 8px;
    background-color: #fff3f3;
    border: 1px solid #f5c6cb;
  }

  .error-box--warning {
    background-color: #fff8e1;
    border: 1px solid #ffe082;
  }

  .error-box--critical {
    background-color: #fce4ec;
    border: 1px solid #f48fb1;
  }
</style>
