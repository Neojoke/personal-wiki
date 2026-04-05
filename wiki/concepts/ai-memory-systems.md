---
title: AI 记忆系统
type: concept
tags: [AI, 记忆，架构]
sources: [raw/articles/jike-claude-code-memory-analysis.md]
related: [[memory-types], [claude-code], [openclaw]]
created: 2026-04-05
updated: 2026-04-05
confidence: high
---

# AI 记忆系统

## 核心定义

AI 系统中的记忆管理机制，用于存储和检索上下文信息。

## 主要框架

### 全量记忆框架

- **LangMem**
- **Mem0**
- **Zep**
- **EverMemOS**
- **MemOS**

**特点**：
- 追求全量记忆
- 复杂度高（MongoDB/Elasticsearch/Milvus/Redis）
- 适合个人长期记忆管理

### 执行导向框架

- **Claude Code**

**特点**：
- 防遗忘机制
- 简单实用
- 更像人类工程师 debug

### 分层记忆框架

- **OpenClaw**

**特点**：
- 三层记忆（全局/工作区/任务）
- 只在必要时加载
- 记忆不是资产，正确使用记忆的能力才是

## 记忆类型对应

| 记忆类型 | AI 实现 |
|---------|--------|
| 情境记忆 | 对话历史（jsonl） |
| 语义记忆 | 知识提取（MD 文件） |
| 程序化记忆 | 反馈记录（正负向） |

---

*最后更新：2026-04-05 | 置信度：high*
