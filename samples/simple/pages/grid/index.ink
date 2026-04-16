<script setup>
  export default {};
</script>

<page>
  <view class="container">
    <view class="page-title">Grid</view>

    <view class="card section">
      <view class="title">Basic 3-column Grid</view>
      <view class="grid-3col">
        <view class="cell">1</view>
        <view class="cell">2</view>
        <view class="cell">3</view>
        <view class="cell">4</view>
        <view class="cell">5</view>
        <view class="cell">6</view>
      </view>
    </view>

    <view class="card section">
      <view class="title">Fixed + Fr columns</view>
      <view class="grid-fixed-fr">
        <view class="cell sidebar">Sidebar</view>
        <view class="cell main">Main</view>
      </view>
    </view>

    <view class="card section">
      <view class="title">Column + Row Gap</view>
      <view class="grid-gap">
        <view class="cell">A</view>
        <view class="cell">B</view>
        <view class="cell">C</view>
        <view class="cell">D</view>
      </view>
    </view>

    <view class="card section">
      <view class="title">Grid-column Span</view>
      <view class="grid-span">
        <view class="cell span2">Span 2</view>
        <view class="cell">3</view>
        <view class="cell">4</view>
        <view class="cell">5</view>
      </view>
    </view>

    <view class="card section">
      <view class="title">Explicit Placement</view>
      <view class="grid-place">
        <view class="cell place-a">A (col 2, row 1)</view>
        <view class="cell place-b">B (col 1, row 2)</view>
        <view class="cell place-c">C (col 3, row 2)</view>
      </view>
    </view>

    <view class="card section">
      <view class="title">Auto-fill with minmax</view>
      <view class="grid-autofill">
        <view class="cell">1</view>
        <view class="cell">2</view>
        <view class="cell">3</view>
        <view class="cell">4</view>
        <view class="cell">5</view>
      </view>
    </view>

    <view class="card section">
      <view class="title">align-items &amp; justify-items</view>
      <view class="grid-align">
        <view class="cell align-cell">Center</view>
        <view class="cell align-cell">Center</view>
        <view class="cell align-cell">Center</view>
      </view>
    </view>
  </view>
</page>

<style>
  .container {
    flex-direction: column;
    padding: 16px;
    background-color: #f7f8fa;
    color: #333;
  }

  .page-title {
    font-size: 24px;
    font-weight: bold;
    margin-bottom: 16px;
    color: #323233;
  }

  .card {
    background-color: #ffffff;
    border-radius: 12px;
    border: 1px solid #ebedf0;
  }

  .section {
    flex-direction: column;
    margin-bottom: 16px;
    padding: 16px;
  }

  .title {
    font-size: 16px;
    font-weight: 600;
    color: #323233;
    margin-bottom: 12px;
    padding-bottom: 8px;
    border-bottom: 1px solid #ebedf0;
  }

  /* shared cell style */
  .cell {
    background-color: #1989fa;
    color: #ffffff;
    font-size: 14px;
    font-weight: 600;
    display: flex;
    justify-content: center;
    align-items: center;
    border-radius: 6px;
    height: 48px;
  }

  /* ── Basic 3-column grid ── */
  .grid-3col {
    display: grid;
    grid-template-columns: 1fr 1fr 1fr;
    gap: 8px;
  }

  /* ── Fixed sidebar + flexible main ── */
  .grid-fixed-fr {
    display: grid;
    grid-template-columns: 80px 1fr;
    gap: 8px;
  }

  .sidebar {
    background-color: #ff976a;
  }

  .main {
    background-color: #07c160;
  }

  /* ── Column + row gap ── */
  .grid-gap {
    display: grid;
    grid-template-columns: 1fr 1fr;
    column-gap: 16px;
    row-gap: 8px;
  }

  /* ── Spanning cells ── */
  .grid-span {
    display: grid;
    grid-template-columns: 1fr 1fr 1fr;
    gap: 8px;
  }

  .span2 {
    grid-column: 1 / span 2;
    background-color: #ee0a24;
  }

  /* ── Explicit placement ── */
  .grid-place {
    display: grid;
    grid-template-columns: 1fr 1fr 1fr;
    grid-template-rows: 48px 48px;
    gap: 8px;
  }

  .place-a {
    grid-column: 2;
    grid-row: 1;
    background-color: #7232dd;
  }

  .place-b {
    grid-column: 1;
    grid-row: 2;
    background-color: #ff976a;
  }

  .place-c {
    grid-column: 3;
    grid-row: 2;
    background-color: #07c160;
  }

  /* ── Auto-fill with minmax ── */
  .grid-autofill {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(80px, 1fr));
    gap: 8px;
  }

  /* ── align-items / justify-items ── */
  .grid-align {
    display: grid;
    grid-template-columns: 1fr 1fr 1fr;
    align-items: center;
    justify-items: center;
    gap: 8px;
    height: 80px;
    background-color: #f7f8fa;
    border-radius: 8px;
    padding: 8px;
  }

  .align-cell {
    width: 60px;
    height: 40px;
    background-color: #1989fa;
  }
</style>
