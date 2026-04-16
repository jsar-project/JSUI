<script setup>
  export default {
    data: {
      fruits: ['Apple', 'Banana', 'Cherry', 'Durian', 'Elderberry'],
      contacts: [
        { id: 1, name: 'Yorkie', role: 'Maintainer' },
        { id: 2, name: 'Alice', role: 'Contributor' },
        { id: 3, name: 'Bob', role: 'Reviewer' },
      ],
      tasks: [
        { id: 1, title: 'Design API', done: true },
        { id: 2, title: 'Implement ink:for', done: true },
        { id: 3, title: 'Write tests', done: true },
        { id: 4, title: 'Add fixture page', done: false },
      ],
    },
    onLoad() {
      setTimeout(() => {
        this.setData({
          'fruits': ['Apple', 'Banana', 'Elderberry']
        })
      }, 1000);
    }
  };
</script>

<page>
  <view class="container">
    <view class="page-title">List</view>

    <view class="card section">
      <view class="title">Basic List (ink:for)</view>
      <view class="list-item" ink:for="{{ fruits }}" ink:key="index">
        <text class="item-index">{{ index }}.</text>
        <text class="item-name">{{ item }}</text>
      </view>
    </view>

    <view class="card section">
      <view class="title">Object List</view>
      <view class="list-card" ink:for="{{ contacts }}" ink:key="index">
        <text class="card-name">{{ item.name }}</text>
        <text class="card-role">{{ item.role }}</text>
      </view>
    </view>

    <view class="card section">
      <view class="title">Filtered List (ink:for + ink:if)</view>
      <view class="task-item" ink:for="{{ tasks }}" ink:key="index">
        <view ink:if="{{ item.done }}">
          <text class="task-done">✓ {{ item.title }}</text>
        </view>
        <view ink:else>
          <text class="task-pending">○ {{ item.title }}</text>
        </view>
      </view>
    </view>
  </view>
</page>

<style>
  .container {
    display: flex;
    flex-direction: column;
    padding: 20px;
    background-color: #f5f5f5;
  }

  .section {
    flex-direction: column;
    margin-bottom: 24px;
    background-color: white;
    border-radius: 12px;
    padding: 16px;
  }

  .title {
    font-size: 18px;
    font-weight: bold;
    color: #333;
    margin-bottom: 12px;
    border-bottom: 2px solid #1989fa;
    padding-bottom: 8px;
  }

  .list-item {
    display: flex;
    flex-direction: row;
    align-items: center;
    padding: 10px 0;
    border-bottom: 1px solid #eee;
  }

  .item-index {
    font-size: 14px;
    color: #999;
    width: 30px;
  }

  .item-name {
    font-size: 16px;
    color: #333;
  }

  .list-card {
    background-color: #e8f4fd;
    border-radius: 8px;
    padding: 12px;
    margin-bottom: 8px;
  }

  .card-name {
    font-size: 16px;
    font-weight: bold;
    color: #1989fa;
  }

  .card-role {
    font-size: 13px;
    color: #666;
    margin-top: 4px;
  }

  .task-item {
    margin-bottom: 8px;
  }

  .task-done {
    font-size: 15px;
    color: #07c160;
  }

  .task-pending {
    font-size: 15px;
    color: #888;
  }
</style>
