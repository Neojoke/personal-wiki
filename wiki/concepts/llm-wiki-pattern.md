---
title: LLM Wiki Pattern
type: concept
tags: [knowledge-base, llm, wiki, pattern, architecture]
sources: [raw/articles/karpathy-llm-wiki-idea-file.md]
related: [[rag-vs-wiki], [summary-karpathy-llm-wiki], [ingest-workflow], [query-workflow], [lint-workflow]]
created: 2026-04-05
updated: 2026-04-05
confidence: high
---

# LLM Wiki Pattern

**一句话定义**：一种使用 LLM 增量构建和维护持久化知识库的模式，替代传统的 RAG 检索方式。

---

## 🎯 核心问题

**RAG 的局限性**：
- 每次查询都重新发现知识
- 没有积累和复合增长
- 需要复杂的向量数据库和嵌入管道
- 黑盒检索，难以追溯

**LLM Wiki 的解决方案**：
- 知识编译一次，持续更新
- 每次摄入和查询都让 Wiki 更丰富
- 使用 Markdown 文件，人类可读
- 完全可追溯和审计

---

## 🏗️ 架构模式

### 三层结构

```
┌─────────────────────────────────────┐
│  raw/                               │
│  原始资料（LLM 只读）               │
│  - articles/                        │
│  - papers/                          │
│  - journal/                         │
│  - data/                            │
│  - assets/                          │
└──────────────┬──────────────────────┘
               │ 读取
               ↓
┌─────────────────────────────────────┐
│  wiki/                              │
│  LLM 生成的知识库（LLM 完全拥有）   │
│  - concepts/                        │
│  - entities/                        │
│  - sources/                         │
│  - comparisons/                     │
│  - index.md                         │
│  - log.md                           │
└──────────────┬──────────────────────┘
               │ 维护
               ↑
┌─────────────────────────────────────┐
│  AGENTS.md                          │
│  Schema 文件（LLM 必读）            │
│  - 目录结构定义                     │
│  - Frontmatter 规范                 │
│  - 工作流程规范                     │
└─────────────────────────────────────┘
```

### 核心规则

| 目录 | LLM 权限 | 说明 |
|------|---------|------|
| `raw/` | **只读** | 原始资料，禁止修改。Source of truth |
| `wiki/` | **完全拥有** | LLM 创建、更新、维护 |
| `AGENTS.md` | **只读** | Schema 文件，仅用户可修改 |

---

## ⚙️ 工作流程

### 1. Ingest（摄入）

```
放入源 → 读取 → 讨论 → 计划 → 用户确认 → 执行 → 更新 index → 追加 log
```

**特点**：
- 单个源影响 10-15 个 Wiki 页面
- 必须用户确认（严格模式）
- 必须更新 index.md 和 log.md

### 2. Query（查询）

```
读 index.md → 定位相关页面 → 读取 → 综合答案 → 建议存档
```

**特点**：
- 先读 index.md 导航
- 使用 [[wikilink]] 引用
- 好答案存回 Wiki

### 3. Lint（健康检查）

```
扫描 → 检查矛盾 → 找孤立页 → 建议缺失页 → 生成报告
```

**频率**：每周一次或摄入 10+ 源后

---

## 📊 RAG vs Wiki 对比

| 维度 | RAG | LLM Wiki |
|------|-----|----------|
| **知识处理时机** | 查询时（每次都重新发现） | 摄入时（一次编译，持续更新） |
| **交叉引用** | 临时发现 | 预先构建并维护 |
| **矛盾检测** | 可能不发现 | 摄入时标记 |
| **知识积累** | 无（每次从头开始） | 复合增长 |
| **输出格式** | 聊天回复（临时） | Markdown 文件（持久） |
| **可追溯性** | 低（黑盒） | 高（直接追溯源） |
| **维护者** | 系统（黑盒） | LLM（透明，可编辑） |
| **理想规模** | 百万级文档 | 100-10,000 高价值文档 |

---

## 🧠 人机分工

### 用户负责
- ✅ curated 源文档
- ✅ 探索和思考
- ✅ 问对的问题
- ✅ 审查和批准

### LLM 负责
- ✅ 总结
- ✅ 交叉引用
- ✅ 归档
- ✅ 簿记
- ✅ 维护一致性

### 比喻
> **"Obsidian 是 IDE；LLM 是程序员；Wiki 是代码库"**

---

## 📈 复合增长机制

```
源文档摄入
    ↓
Wiki 页面增长
    ↓
查询探索 → 新页面存档
    ↓
定期 Lint → 健康维护
    ↓
分享卡片 → 知识传播
    ↓
（循环）→ Wiki 更丰富
```

**关键洞察**：
- 每次摄入都让 Wiki 更丰富
- 每次查询都可能产生新页面
- 定期 Lint 保持健康
- 知识像代码一样版本控制

---

## 🛠️ 工具栈

### 必需
- **Obsidian**：浏览/编辑 Wiki
- **Git**：版本控制
- **LLM Agent**：Wiki 维护者

### 推荐
- **Web Clipper**：网页剪藏
- **Dataview**：查询 frontmatter
- **Marp**：生成幻灯片

### 可选（大规模时）
- **qmd**：本地搜索（>100 页时）

---

## 🎯 适用场景

Karpathy 提到的场景：

1. **个人知识库**：目标/健康/心理/日记/文章
2. **研究**：深入某个主题数周/数月
3. **读书**：每章做笔记，LLM 维护
4. **企业/团队**：内部 Wiki
5. **其他**：竞争分析/旅行计划/课程笔记

---

## 📝 实施建议

### 从小开始
```
1. 摄入第一个源
2. 摄入 10 个源
3. 问一个综合问题
4. 验证系统是否给出独特洞察
5. 如果有效，继续扩展
```

### 严格模式
- Frontmatter 必填字段不能缺少
- 页面必须分类到指定目录
- Ingest 必须用户确认
- index.md 每次必须更新
- log.md 必须用一致前缀

### 演化 Schema
- 与 LLM 共同演进 AGENTS.md
- 记录变更日志
- 用 git commit message 记录原因

---

## 🔗 相关概念

- [[rag-vs-wiki]] - RAG vs Wiki 详细对比
- [[summary-karpathy-llm-wiki]] - Karpathy Gist 摘要
- [[ingest-workflow]] - 摄入工作流规范
- [[query-workflow]] - 查询工作流规范
- [[lint-workflow]] - 健康检查工作流
- [[index-md-spec]] - index.md 规范
- [[log-md-spec]] - log.md 规范

---

## 📚 参考资料

- **Karpathy Gist**: https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f
- **获取方式**: `gh gist view 442a6bf555914893e9891c11519de94f`

---

*最后更新：2026-04-05 | 置信度：high*
