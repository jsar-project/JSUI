# JSUI 开发工具与技能

[English](./README.md)

本仓库提供用于构建 **JSUI**（JavaScript User Interface）应用的开发工具、CLI 以及 AI Agent 技能。JSUI 是一个面向带显示屏 AI 眼镜的 Agent Runtime。

## 🚀 快速开始

### 创建新的 JSUI Agent

你可以使用官方 CLI 工具快速创建一个新的 JSUI Agent 项目。运行下面的命令并按提示操作：

```bash
npm create jsui-agent my-agent
```

该命令会生成一个开箱即用的 JSUI 项目模板，其中包括：
- 用于全局配置的 `app.js` 和 `app.json`
- 用于声明 Agent 能力的 `AGENTS.md`
- 一个现代化的单文件组件（SFC）页面 `index.ink`

## 🧪 示例

[`samples/`](./samples/) 目录包含可运行的示例项目，用于展示 JSUI 的功能特性，并为常见 UI 模式提供参考实现。

当前仓库内提供了 [`samples/simple/`](./samples/simple/)，这是一个完整的示例应用，你可以通过它集中了解页面结构、静态资源、辅助模块以及多个功能演示。

- `pages/`：包含多种 JSUI 能力与 UI 模式的页面示例
- `assets/`：示例中使用的静态资源，例如图片、SVG 和音频文件
- `lib/`：供示例页面复用的辅助模块

`samples/simple/pages/` 中具有代表性的示例包括：
- `layout`、`grid`、`position`：布局与定位相关示例
- `image`、`list`、`input_textarea`：常见 UI 基础能力示例
- `canvas`、`canvas_api`、`chart`、`lottie`：绘制与视觉内容示例
- `media_query`、`css_vars`、`filter`、`transform`：样式与响应式行为示例

## 🤖 AI Agent 技能

我们提供了内置说明文档和上下文文件，帮助 LLM（大语言模型）或 AI 编码助手更高效地编写 JSUI 代码。

### 通过 CLI 安装

你可以使用 `npx skills add` 命令轻松将 JSUI 开发技能安装到你的项目中。该命令会拉取所需的上下文文件，并使其可供你的 AI 编码助手使用：

```bash
npx skills add https://github.com/jsar-project/JSUI/tree/main/skills/jsui-dev
```

- **`jsui-dev` Skill**：位于 [`skills/jsui-dev/SKILL.md`](./skills/jsui-dev/SKILL.md)，该文档包含完整的 API 参考、项目结构指引以及 `.ink` SFC 规范。你可以将该文件提供给 AI 助手，使其具备开发 JSUI 应用的“技能”。

## 📂 仓库结构

```text
.
├── packages/
│   └── create-jsui-agent/    # 用于创建 JSUI Agent 项目的 npm CLI
├── samples/
│   └── simple/               # 可运行的 JSUI 示例应用与功能演示
├── skills/
│   └── jsui-dev/             # AI Agent 技能文档（SKILL.md）
└── .github/workflows/        # 自动化每日构建与发布工作流
```

## 📄 许可证

Apache License 2.0
