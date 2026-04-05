---
title: Karpathy LLM Wiki Idea File
type: source-summary
tags: [knowledge-base, llm, wiki, karpathy, personal-knowledge]
sources: [raw/articles/karpathy-llm-wiki-idea-file.md]
related: [[llm-wiki-pattern], [rag-vs-wiki], [ingest-workflow], [query-workflow], [lint-workflow]]
created: 2026-04-05
updated: 2026-04-05
confidence: high
---

# Karpathy LLM Wiki Idea File

**源文档**: `raw/articles/karpathy-llm-wiki-idea-file.md`  
**作者**: Andrej Karpathy  
**发布日期**: 2026-04-04  
**类型**: Idea File / Pattern Document

---

## 📋 核心要点

### 1. 核心理念

**问题**：RAG 系统每次查询都重新发现知识，没有积累

**解决方案**：LLM 增量构建并维护持久化 Wiki

**关键差异**：
- ❌ RAG：查询时检索 → 每次都重新拼凑
- ✅ Wiki：摄入时编译 → 持续更新，复合增长

### 2. 三层架构

```
raw/          # 原始资料（LLM 只读）
  ↓ (读取)
wiki/         # LLM 生成（LLM 完全拥有）
  ↑ (维护)
schema/       # 配置文件（LLM 必读）
```

**核心规则**：
- `raw/` 是不可变的 source of truth
- `wiki/` 由 LLM 完全拥有和维护
- `schema/`（如 AGENTS.md）定义结构和流程

### 3. 三大操作

#### Ingest（摄入）
- 放入新源 → LLM 读取 → 讨论要点 → 创建/更新 Wiki → 更新 index → 追加 log
- 单个源可能影响 10-15 个 Wiki 页面
- 建议逐个摄入（用户参与），也支持批量

#### Query（查询）
- 读取 index.md 定位 → 读取相关页面 → 综合答案
- **关键洞察**：好的答案应该存回 Wiki 作为新页面

#### Lint（健康检查）
- 定期检查矛盾、孤立页面、缺失概念
- LLM 建议新的调查方向

### 4. 索引机制

**index.md**：
- 内容导向的目录
- 每个页面：链接 + 一句话摘要 + 源数量
- 每次 ingest 必须更新
- 中等规模（~100 源，~数百页）下替代 RAG

**log.md**：
- 时间顺序的追加记录
- 格式：`## [YYYY-MM-DD] type | 标题`
- 可被 unix 工具解析：`grep "^## \[" log.md | tail -5`

### 5. 人机分工

**用户负责**：
- curated 源文档
- 探索和提问
- 审查和批准

**LLM 负责**：
- 总结
- 交叉引用
- 归档和簿记
- 维护一致性

**比喻**：
> "Obsidian 是 IDE；LLM 是程序员；Wiki 是代码库"

---

## 🎯 适用场景

Karpathy 提到的 5 个场景：

1. **个人知识库**：目标/健康/心理/自我提升/日记/文章/播客
2. **研究**：深入某个主题数周/数月
3. **读书**：每章做笔记，LLM 维护角色/主题/情节
4. **企业/团队**：内部 Wiki，由 LLM 维护
5. **其他**：竞争分析/尽职调查/旅行计划/课程笔记/爱好

---

## 🛠️ 工具推荐

Karpathy 提到的工具：

| 工具 | 用途 |
|------|------|
| Obsidian Web Clipper | 网页剪藏到 raw/ |
| qmd | 本地搜索（大规模时） |
| Obsidian Graph View | 查看 Wiki 结构 |
| Marp | Markdown 幻灯片 |
| Dataview | 查询 frontmatter |
| Git | 版本控制 |

---

## 💡 关键洞察

### 为什么 Wiki 优于 RAG

| 维度 | RAG | Wiki |
|------|-----|------|
| 知识处理时机 | 查询时（每次都重新发现） | 摄入时（一次编译，持续更新） |
| 交叉引用 | 临时发现 | 预先构建并维护 |
| 矛盾检测 | 可能不发现 | 摄入时标记 |
| 知识积累 | 无（每次从头开始） | 复合增长 |
| 输出格式 | 聊天回复（临时） | Markdown 文件（持久） |

### 为什么 LLM 能维护好 Wiki

> "人类放弃 Wiki 是因为维护负担增长快于价值。LLM 不会无聊，不会忘记更新交叉引用，可以一次处理 15 个文件。"

---

## 📚 历史联系

**灵感来源**：Vannevar Bush 的 Memex (1945)

- 个人策划的知识库
- 文档间的关联与文档本身同等重要
- LLM 解决了 Bush 没能解决的维护问题

---

## 🔗 相关概念

- [[llm-wiki-pattern]] - LLM Wiki 模式
- [[rag-vs-wiki]] - RAG vs Wiki 对比
- [[ingest-workflow]] - 摄入工作流
- [[query-workflow]] - 查询工作流
- [[lint-workflow]] - 健康检查工作流
- [[index-md-spec]] - index.md 规范
- [[log-md-spec]] - log.md 规范

---

## 📝 笔记

这是整个知识库的**foundational document**，定义了：
- 架构模式
- 工作流程
- 人机协作方式
- 工具选择

后续所有摄入的源都应该参考这个模式。

---

*最后更新：2026-04-05 | 置信度：high*
