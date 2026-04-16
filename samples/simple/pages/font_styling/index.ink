<script setup>
export default {
  onLoad() {
    console.log('Font Styling page loaded');
  },
};
</script>

<page>
  <view class="container">
    <text class="page-title">Font Styling</text>

    <!-- font-family -->
    <view class="section">
      <text class="section-title">font-family</text>
      <text class="family-serif">Serif fallback (Georgia, serif)</text>
      <text class="family-sans">Sans-serif (Helvetica, Arial, sans-serif)</text>
      <text class="family-mono">Monospace (Courier New, monospace)</text>
      <text class="family-inherit">Inherited from parent</text>
    </view>

    <!-- font-style -->
    <view class="section">
      <text class="section-title">font-style</text>
      <text class="style-normal">Normal style</text>
      <text class="style-italic">Italic style</text>
      <text class="style-oblique">Oblique style</text>
    </view>

    <!-- font-variant -->
    <view class="section">
      <text class="section-title">font-variant</text>
      <text class="variant-normal">Normal variant — Hello World</text>
      <text class="variant-small-caps">Small-caps variant — Hello World</text>
    </view>

    <!-- combined -->
    <view class="section">
      <text class="section-title">Combined</text>
      <text class="combined">Italic small-caps serif</text>
    </view>
  </view>
</page>

<style>
  .container {
    display: flex;
    flex-direction: column;
    padding: 20px;
    background-color: #f8f8f8;
  }

  .page-title {
    font-size: 22px;
    font-weight: bold;
    color: #222;
    margin-bottom: 20px;
  }

  .section {
    display: flex;
    flex-direction: column;
    margin-bottom: 24px;
    padding: 14px;
    background-color: #fff;
    border: 1px solid #ddd;
    border-radius: 8px;
  }

  .section-title {
    font-size: 14px;
    font-weight: bold;
    color: #888;
    margin-bottom: 10px;
  }

  /* font-family rows */
  .family-serif {
    font-family: Georgia, serif;
    font-size: 16px;
    margin-bottom: 6px;
    color: #333;
  }

  .family-sans {
    font-family: Helvetica, Arial, sans-serif;
    font-size: 16px;
    margin-bottom: 6px;
    color: #333;
  }

  .family-mono {
    font-family: "Courier New", monospace;
    font-size: 16px;
    margin-bottom: 6px;
    color: #333;
  }

  .family-inherit {
    font-size: 16px;
    color: #666;
  }

  /* font-style rows */
  .style-normal {
    font-size: 18px;
    font-style: normal;
    margin-bottom: 6px;
    color: #333;
  }

  .style-italic {
    font-size: 18px;
    font-style: italic;
    margin-bottom: 6px;
    color: #333;
  }

  .style-oblique {
    font-size: 18px;
    font-style: oblique;
    color: #333;
  }

  /* font-variant rows */
  .variant-normal {
    font-size: 18px;
    font-variant: normal;
    margin-bottom: 6px;
    color: #333;
  }

  .variant-small-caps {
    font-size: 18px;
    font-variant: small-caps;
    color: #333;
  }

  /* combined */
  .combined {
    font-family: Georgia, serif;
    font-style: italic;
    font-variant: small-caps;
    font-size: 18px;
    color: #1a5276;
  }
</style>
