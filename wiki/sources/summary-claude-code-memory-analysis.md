---
title: Claude Code 记忆系统分析
type: source-summary
tags: [AI, 记忆系统，Claude Code, OpenClaw, 框架对比]
sources: [raw/articles/jike-claude-code-memory-analysis.md]
related: [[ai-memory-systems], [memory-types], [claude-code]]
created: 2026-04-05
updated: 2026-04-05
confidence: high
---

# Claude Code 记忆系统分析

**来源**: [即刻文章](raw/articles/jike-claude-code-memory-analysis.md)  
**日期**: 2026-04-05

---

## 核心观点

### 1. 记忆三分法（Tulving 1972）

| 记忆类型 | 用途 | 示例 |
|---------|------|------|
| **情境记忆** | 记录过去 | 我干了啥 |
| **语义记忆** | 提炼规律 | 我知道啥 |
| **程序化记忆** | 决定行动 | 我会做啥 |

**循环过程**：经历 → 知识 → 技能 → 新的经历

### 2. Claude Code Memory 实现

- **情境记忆**: jsonl 格式储存对话
- **语义记忆**: extractMemories 子 Agent 提取知识
- **程序化记忆**: feedback 记录正负向经验
- **autoDream**: 后台整合修剪

### 3. 框架对比

| 框架 | 特点 | 复杂度 |
|------|------|--------|
| **LangMem/Mem0/Zep** | 全量记忆 | 高 |
| **OpenClaw** | 三层记忆（全局/工作区/任务） | 中 |
| **Claude Code** | 执行导向，防遗忘 | 低 |

---

## 关键洞察

1. **Claude Code 的定位**：更偏执行，Memory 是防遗忘机制
2. **OpenClaw 的设计**：记忆不是资产，正确使用记忆的能力才是
3. **全量记忆框架**：适合长期记忆管理，但复杂度高

---

## 关联概念

- [[ai-memory-systems]] - AI 记忆系统
- [[memory-types]] - 记忆类型
- [[claude-code]] - Claude Code

---

*摘要生成于：2026-04-05 | 置信度：high*
