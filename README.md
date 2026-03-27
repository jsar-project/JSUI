# JSUI Developer Tools & Skills

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
├── skills/
│   └── jsui-dev/             # AI Agent skill documentation (SKILL.md)
└── .github/workflows/        # Automated daily build and publish workflows
```

## 📄 License

Apache License 2.0
