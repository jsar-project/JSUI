<script type="application/json" def>
  {
    "schema": {
      "data": {
        "a2uiData": "string"
      }
    }
  }
</script>

<script setup>
  export default {
    data: {
      a2uiData: `[
      {
        "type": "createSurface",
        "surfaceId": "surface-1",
        "containerId": "root"
      },
      {
        "type": "updateComponents",
        "surfaceId": "surface-1",
        "components": [
          {
            "id": "root",
            "type": "view",
            "props": {
              "style": "display: flex; flex-direction: column; align-items: center; justify-content: center; width: 100%; height: 100%; background-color: #f5f5f7;"
            },
            "children": ["card"]
          },
          {
            "id": "card",
            "type": "view",
            "props": {
              "style": "display: flex; flex-direction: column; width: 320px; background-color: #ffffff; border-radius: 16px; padding: 24px; box-shadow: 0 8px 24px rgba(0,0,0,0.1);"
            },
            "children": ["header", "divider", "info-list"]
          },
          {
            "id": "header",
            "type": "view",
            "props": {
              "style": "display: flex; flex-direction: row; align-items: center; margin-bottom: 20px;"
            },
            "children": ["avatar", "title-group"]
          },
          {
            "id": "avatar",
            "type": "image",
            "props": {
              "src": "https://avatars.githubusercontent.com/u/14985020?v=4",
              "style": "width: 64px; height: 64px; border-radius: 32px; background-color: #e0e0e0; margin-right: 16px;"
            }
          },
          {
            "id": "title-group",
            "type": "view",
            "props": {
              "style": "display: flex; flex-direction: column; justify-content: center;"
            },
            "children": ["name", "role"]
          },
          {
            "id": "name",
            "type": "text",
            "props": {
              "content": "Alex Chen",
              "style": "font-size: 22px; font-weight: bold; color: #1d1d1f; margin-bottom: 4px;"
            }
          },
          {
            "id": "role",
            "type": "text",
            "props": {
              "content": "Senior Software Engineer",
              "style": "font-size: 14px; color: #86868b;"
            }
          },
          {
            "id": "divider",
            "type": "view",
            "props": {
              "style": "width: 100%; height: 1px; background-color: #e5e5ea; margin-bottom: 20px;"
            }
          },
          {
            "id": "info-list",
            "type": "view",
            "props": {
              "style": "display: flex; flex-direction: column;"
            },
            "children": ["info-email", "info-phone", "info-location"]
          },
          {
            "id": "info-email",
            "type": "view",
            "props": {
              "style": "display: flex; flex-direction: row; align-items: center; margin-bottom: 12px;"
            },
            "children": ["icon-email", "text-email"]
          },
          {
            "id": "icon-email",
            "type": "text",
            "props": {
              "content": "✉️",
              "style": "font-size: 16px; margin-right: 12px;"
            }
          },
          {
            "id": "text-email",
            "type": "text",
            "props": {
              "content": "alex.chen@example.com",
              "style": "font-size: 14px; color: #1d1d1f;"
            }
          },
          {
            "id": "info-phone",
            "type": "view",
            "props": {
              "style": "display: flex; flex-direction: row; align-items: center; margin-bottom: 12px;"
            },
            "children": ["icon-phone", "text-phone"]
          },
          {
            "id": "icon-phone",
            "type": "text",
            "props": {
              "content": "📱",
              "style": "font-size: 16px; margin-right: 12px;"
            }
          },
          {
            "id": "text-phone",
            "type": "text",
            "props": {
              "content": "+1 (555) 123-4567",
              "style": "font-size: 14px; color: #1d1d1f;"
            }
          },
          {
            "id": "info-location",
            "type": "view",
            "props": {
              "style": "display: flex; flex-direction: row; align-items: center;"
            },
            "children": ["icon-location", "text-location"]
          },
          {
            "id": "icon-location",
            "type": "text",
            "props": {
              "content": "📍",
              "style": "font-size: 16px; margin-right: 12px;"
            }
          },
          {
            "id": "text-location",
            "type": "text",
            "props": {
              "content": "San Francisco, CA",
              "style": "font-size: 14px; color: #1d1d1f;"
            }
          }
        ]
      }
    ]`,
    },

    onLoad() {
      console.log("A2UI test page loaded");
    },

    updateA2ui() {
      console.log("Updating A2UI data");
      const a2uiCtx = a2ui.createA2UIContext("my-a2ui");
      if (!a2uiCtx) {
        console.error("A2UI context not found");
        return;
      }

      const json = [
        {
          type: "updateComponents",
          surfaceId: "surface-1",
          components: [
            {
              id: "name",
              type: "text",
              props: {
                content: "Alex Chen (Updated Full Write)",
                style:
                  "font-size: 22px; font-weight: bold; color: #ff3b30; margin-bottom: 4px;",
              },
            },
          ],
        },
      ];
      a2uiCtx.write(JSON.stringify(json, null, 2));
    },

    streamUpdateA2ui() {
      console.log("Stream updating A2UI data via API...");
      const ctx = a2ui.createA2UIContext("my-a2ui");
      if (!ctx) {
        console.error("Failed to get A2UI context");
        return;
      }

      const stream = ctx.startStream();
      const fullJson = `[
      {
        "type": "updateComponents",
        "surfaceId": "surface-1",
        "components": [
          {
            "id": "role",
            "type": "text",
            "props": {
              "content": "Staff Software Engineer (Streamed)",
              "style": "font-size: 14px; color: #34c759; font-style: italic;"
            }
          },
          {
            "id": "text-location",
            "type": "text",
            "props": {
              "content": "New York, NY (Streamed)",
              "style": "font-size: 14px; color: #1d1d1f; font-weight: 500;"
            }
          }
        ]
      }
    ]`;

      // Simulate network chunks (e.g. 100 bytes per chunk)
      const chunkSize = 50;
      let offset = 0;

      const sendNextChunk = () => {
        console.info("send next chunk", offset);
        if (offset < fullJson.length) {
          const chunk = fullJson.slice(offset, offset + chunkSize);
          stream.writeChunk(chunk);
          offset += chunkSize;
          // Schedule next chunk with a slight delay to visualize streaming
          sendNextChunk();
        } else {
          console.log("Stream finished.");
          stream.close();
        }
      };

      sendNextChunk();
    },
  };
</script>

<page>
  <view class="container">
    <view class="page-title">A2UI Test</view>
    <view class="a2ui-container">
      <a2ui
        id="my-a2ui"
        commands="{{ a2uiData }}"
        style="display: flex; flex-direction: column; width: 100%; height: 100%"
      />
    </view>
    <button class="btn" bindtap="updateA2ui">Full Write Update</button>
    <button class="btn stream-btn" bindtap="streamUpdateA2ui">
      Stream Update
    </button>
  </view>
</page>

<style>
  .container {
    display: flex;
    flex-direction: column;
    width: 100%;
    height: 100%;
    background-color: #ffffff;
    padding: 20px;
    box-sizing: border-box;
  }

  .title {
    font-size: 28px;
    font-weight: bold;
    color: #000000;
    margin-bottom: 20px;
    text-align: center;
  }

  .a2ui-container {
    flex: 1;
    width: 100%;
    height: 400px;
    border: 1px solid #e5e5e5;
    border-radius: 8px;
    padding: 10px;
    margin-bottom: 20px;
    overflow: hidden;
  }

  .btn {
    width: 100%;
    height: 44px;
    background-color: #34c759;
    color: #ffffff;
    font-size: 16px;
    font-weight: bold;
    border-radius: 8px;
    display: flex;
    justify-content: center;
    align-items: center;
    margin-bottom: 10px;
  }

  .stream-btn {
    background-color: #007aff;
  }
</style>
