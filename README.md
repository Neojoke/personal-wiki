# LLM Wiki

> 基于 Karpathy "Idea File" 架构的个人知识库

## 快速开始

```bash
# 1. 添加源文档到 raw/
# 2. 对 Agent 说："ingest [文件名]"
# 3. 浏览生成的 wiki/
```

## 目录结构

```
llm-wiki/
├── AGENTS.md       # Schema 文件（LLM 必读）
├── raw/            # 原始资料（只读）
│   ├── articles/   # 文章
│   ├── papers/     # 论文
│   └── assets/     # 图片/附件
└── wiki/           # 知识库（LLM 维护）
    ├── index.md    # 主目录
    ├── log.md      # 活动日志
    ├── overview.md # 概述
    ├── concepts/   # 概念
    ├── entities/   # 实体
    ├── sources/    # 源摘要
    └── comparisons/# 对比
```

## 核心操作

| 命令 | 说明 |
|------|------|
| `ingest [文件]` | 摄入源文档 |
| `query [问题]` | 查询知识库 |
| `lint` | 健康检查 |

## 工具

- **Obsidian**: 浏览和编辑（推荐）
- **Web Clipper**: 剪藏网页到 raw/
- **qmd**: 大规模时搜索（可选）

## 理念

> "Obsidian 是 IDE；LLM 是程序员；Wiki 是代码库"

- 你负责：源文档、探索、提问
- LLM 负责：总结、交叉引用、归档、簿记

---

📄 完整架构说明见 `AGENTS.md`

🔗 灵感来源：[Karpathy Gist](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f)
