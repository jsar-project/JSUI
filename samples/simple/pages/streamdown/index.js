const FULL_TEXT = `## Streaming Demo
This is a demonstration of **streamdown** component's streaming capabilities.

- **Fast** parsing with pulldown-cmark
- **Smooth** animations with Caret
- **Flexible** rendering of Markdown elements

\`\`\`javascript
function hello() {
  console.log("Hello, Streamdown!");
}
\`\`\`

Enjoy the streaming experience!`;

export default {
  data: {
    staticContent: '# Hello World\nThis is a **static** markdown content test.',
    streamingContent: '',
    isStreaming: false,
    complexContent: `### Markdown Elements
1. **Ordered**
2. *List*
3. ~~Items~~

> Blockquote test for ink-builtin-components.

---
Horizontal rule above.`,
    currentIndex: 0,
  },

  onLoad() {
    console.log('Streamdown test page loaded');
  },

  onUnload() {
    this.stopStreaming();
  },

  toggleStreaming() {
    if (this.data.isStreaming) {
      this.stopStreaming();
    } else {
      this.startStreaming();
    }
  },

  startStreaming() {
    this.setData({
      isStreaming: true,
      streamingContent: '',
      currentIndex: 0,
    });

    this.timer = setInterval(() => {
      const { currentIndex, streamingContent } = this.data;
      if (currentIndex < FULL_TEXT.length) {
        const nextChar = FULL_TEXT[currentIndex];
        this.setData({
          streamingContent: streamingContent + nextChar,
          currentIndex: currentIndex + 1,
        });
      } else {
        this.stopStreaming();
      }
    }, 50);
  },

  stopStreaming() {
    if (this.timer) {
      clearInterval(this.timer);
      this.timer = null;
    }
    this.setData({
      isStreaming: false,
    });
  },
};
