# JSUI Developer Tools & Skills

[简体中文](./README.zh-CN.md)

This repository provides developer tools, CLIs, and AI agent skills for building applications on **JSUI** (JavaScript User Interface) — an agentic runtime designed for AI glasses with displays.

## 🚀 Quick Start

### Create a new JSUI Agent

You can quickly scaffold a new JSUI Agent project using our official CLI tool. Run the following command and follow the prompts:

```bash
npm create jsui-agent my-agent
```

This will generate a ready-to-use JSUI project template including:
- `app.js` and `app.json` for global configuration.
- `AGENTS.md` for agent capability manifestation.
- A modern Single File Component (SFC) `index.ink` page setup.

## 🧪 Samples

The [`samples/`](./samples/) directory contains runnable example projects that demonstrate JSUI features and provide reference implementations for common UI patterns.

At the moment, the repository includes [`samples/simple/`](./samples/simple/), a complete sample app that you can use to explore page structure, assets, helper modules, and feature demos in one place.

- `pages/`: Example pages covering a range of JSUI capabilities and UI patterns.
- `assets/`: Static resources used by the demos, such as images, SVGs, and audio files.
- `lib/`: Helper modules shared by sample pages.

Representative demos inside `samples/simple/pages/` include:
- `layout`, `grid`, `position`: Layout and positioning patterns.
- `image`, `list`, `input_textarea`: Common UI building blocks.
- `canvas`, `canvas_api`, `chart`, `lottie`: Rendering and visual content examples.
- `media_query`, `css_vars`, `filter`, `transform`: Styling and responsive behavior examples.

## 🤖 AI Agent Skills

We provide built-in instructions and context files to help LLMs (Large Language Models) or AI coding assistants write JSUI code effectively.

### Install via CLI

You can easily install the JSUI developer skill into your project using the `npx skills add` command. This will fetch the necessary context files and make them available to your AI coding assistant:

```bash
npx skills add https://github.com/jsar-project/JSUI/tree/main/skills/jsui-dev
```

- **`jsui-dev` Skill**: Located in [`skills/jsui-dev/SKILL.md`](./skills/jsui-dev/SKILL.md), this document contains comprehensive API references, project structure guidelines, and `.ink` SFC specifications. You can feed this file to your AI assistant to grant it the "skill" of developing JSUI applications.

## 📂 Repository Structure

```text
.
├── packages/
│   └── create-jsui-agent/    # npm CLI for scaffolding JSUI agent projects
├── samples/
│   └── simple/               # runnable JSUI sample app and feature demos
├── skills/
│   └── jsui-dev/             # AI Agent skill documentation (SKILL.md)
└── .github/workflows/        # Automated daily build and publish workflows
```

## 📄 License

Apache License 2.0
