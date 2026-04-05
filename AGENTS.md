# LLM Wiki Schema

> **这是 LLM Wiki 的核心配置文件**
> 
> LLM 每次会话开始时，必须先读取本文件
> 
> 版本：1.1 | 基于：Karpathy Gist (2026-04-04)

---

## 📁 项目结构

```
llm-wiki/
├── raw/                    # 原始资料（LLM 只读，禁止修改）
│   ├── articles/           # 网络文章、博客
│   ├── papers/             # 学术论文
│   ├── repos/              # GitHub 仓库笔记
│   ├── data/               # 数据集、CSV、JSON
│   └── assets/             # 图片、附件（本地存储）
│
├── wiki/                   # LLM 生成的知识库（LLM 完全拥有）
│   ├── index.md            # 主目录（每次摄入必须更新）
│   ├── log.md              # 活动日志（追加式）
│   ├── overview.md         # 高层综合/概述
│   ├── concepts/           # 概念页面
│   ├── entities/           # 实体页面（公司、人物、组织）
│   ├── sources/            # 源文档摘要
│   └── comparisons/        # 对比分析
│
├── sharing/                # 分享卡片导出（可选）
│   ├── red/                # 小红书风格图片
│   ├── quotes/             # 渐变文字卡片
│   └── cards/              # 内容卡片
│
└── AGENTS.md               # 本 Schema 文件（LLM 必读）
```

### 核心规则

| 目录 | LLM 权限 | 说明 |
|------|---------|------|
| `raw/` | **只读** | 原始资料，LLM 禁止修改或删除。这是你的 source of truth |
| `wiki/` | **完全拥有** | LLM 创建、更新、维护所有内容。你读它，LLM 写它 |
| `sharing/` | **可写** | 导出分享卡片的目标目录 |
| `AGENTS.md` | **只读** | Schema 文件，仅用户可修改 |

---

## 📄 页面规范

### YAML Frontmatter

**每个 wiki 页面必须包含以下 frontmatter：**

```yaml
---
title: 页面标题
type: concept | entity | source-summary | comparison | overview
tags: [标签 1, 标签 2, 标签 3]
sources: [raw/ 文件路径列表]
related: [wiki/ 页面路径列表，使用 [[wikilink]] 格式]
created: YYYY-MM-DD
updated: YYYY-MM-DD
confidence: high | medium | low
---
```

### Frontmatter 字段说明

| 字段 | 类型 | 必填 | 说明 |
|------|------|------|------|
| `title` | string | ✅ | 页面标题 |
| `type` | string | ✅ | 页面类型（见下方说明） |
| `tags` | string[] | ✅ | 标签列表，用于分类和检索 |
| `sources` | string[] | ✅ | 引用的原始资料路径 |
| `related` | string[] | ✅ | 关联的 wiki 页面（使用 `[[wikilink]]` 格式） |
| `created` | date | ✅ | 创建日期（YYYY-MM-DD） |
| `updated` | date | ✅ | 最后更新日期 |
| `confidence` | string | ✅ | 置信度（high/medium/low） |

### 页面类型说明

| 类型 | 位置 | 用途 |
|------|------|------|
| `concept` | `wiki/concepts/` | 概念、理论、方法（如：attention-mechanism） |
| `entity` | `wiki/entities/` | 公司、人物、组织、产品（如：openai） |
| `source-summary` | `wiki/sources/` | 单个源文档的摘要 |
| `comparison` | `wiki/comparisons/` | 对比分析、横向比较 |
| `overview` | `wiki/` | 高层综合、领域概述 |

### 页面内容结构

```markdown
---
title: 注意力机制
type: concept
tags: [深度学习，Transformer, NLP]
sources: [raw/papers/attention-is-all-you-need.pdf]
related: [[transformer-架构], [缩放定律], [tokenization]]
created: 2026-04-05
updated: 2026-04-05
confidence: high
---

# 注意力机制

## 核心定义

一句话定义：注意力机制是一种...

## 关键要点

1. **要点一**：说明文字
2. **要点二**：说明文字
3. **要点三**：说明文字

## 详细解释

正文内容，包含：
- 背景
- 原理
- 公式（如适用）
- 应用场景

## 与其他概念的关系

- 与 [[概念 A]] 的关系：说明
- 与 [[概念 B]] 的关系：说明

## 来源依据

- 📄 [源文档 1](raw/...)：关键引用
- 📄 [源文档 2](raw/...)：关键引用

## 待确认/疑问

- [ ] 需要进一步验证的点
- [ ] 存在矛盾的信息

---
*最后更新：2026-04-05 | 置信度：high*
```

---

## ⚙️ Workflows

### 1️⃣ Ingest（摄入）工作流

**触发**：用户将新源文件放入 `raw/` 并说 "ingest [文件名]"

**LLM 执行步骤：**

```
1. 读取源文件（raw/ 中）
2. 与用户讨论关键要点（输出摘要）
3. 创建/更新摘要页（wiki/sources/）
4. 更新相关概念页（wiki/concepts/）
5. 更新相关实体页（wiki/entities/）
6. 更新主目录（wiki/index.md）
7. 追加活动日志（wiki/log.md）
8. 提交 git commit
```

**输出格式：**

```markdown
## Ingest 计划

**源文件**: `raw/articles/2026-04-moe-efficiency.md`

### 关键要点
1. 要点一
2. 要点二
3. 要点三

### 将创建/更新的页面
- ✅ 新建：`wiki/sources/summary-moe-efficiency.md`
- 🔄 更新：`wiki/concepts/mixture-of-experts.md`
- 🔄 更新：`wiki/concepts/scaling-laws.md`
- 🔄 更新：`wiki/index.md`
- 📝 追加：`wiki/log.md`

### 发现的矛盾/问题
- ⚠️ 与 `wiki/concepts/dense-vs-sparse.md` 的声明矛盾

**是否继续？** [等待用户确认]
```

**重要**：
- ✅ 优先逐个 ingest（用户参与度高，质量控制好）
- ⚠️ 批量 ingest 仅在用户明确要求时使用

---

### 2️⃣ Query（查询）工作流

**触发**：用户提出问题

**LLM 执行步骤：**

```
1. 读取 wiki/index.md 定位相关页面
2. 读取相关 wiki 页面
3. 综合答案，使用 [[wikilink]] 引用
4. 如答案有价值，提议存为新页面
```

**输出格式：**

```markdown
## 回答

[综合答案内容]

### 引用来源
- [[概念页 A]]：关键信息
- [[实体页 B]]：关键信息
- [[源摘要 C]]：关键信息

---

💡 **建议存档**：这个分析很有价值，是否存为 `wiki/comparisons/[主题].md`？
```

**重要**：
- ✅ 好的答案应该存回 wiki，让探索也"复合增长"
- ✅ 支持多种输出形式：markdown 页面、对比表、幻灯片（Marp）、图表

---

### 3️⃣ Lint（健康检查）工作流

**触发**：用户说 "lint" 或 "健康检查"

**LLM 执行步骤：**

```
1. 扫描所有 wiki 页面
2. 检查矛盾、孤立页面、缺失页面
3. 生成健康报告
4. 建议修复操作
```

**输出格式：**

```markdown
## Wiki 健康报告 (YYYY-MM-DD)

### ❌ 矛盾 (N)
1. **页面 A** vs **页面 B**
   - 矛盾点：具体描述
   - 建议：修复方案

### 📄 孤立页面 (N)
- `wiki/concepts/xxx.md` - 无入链
- `wiki/sources/yyy.md` - 无引用

### ❓ 缺失页面 (N)
- "概念 X" 被提及 N 次，无独立页面
- "实体 Y" 被提及 N 次，无独立页面

### 📊 统计
- 总页面数：N
- 本周新增：N
- 平均置信度：high/medium/low

### 💡 建议调查
- 缺少 [主题] 的源文档
- [实体页] 信息太薄（仅 N 个源）
- [概念页] 超过 N 天未更新
```

**频率建议**：每周一次，或摄入 10+ 源后

---

## 📋 index.md 规范

**格式：**

```markdown
# Wiki Index

> 最后更新：YYYY-MM-DD | 总页面数：N

## 📚 Concepts

- [[attention-mechanism]] — 自注意力、多头注意力及变体 (12 个源)
- [[mixture-of-experts]] — 稀疏 MoE 架构、路由策略 (8 个源)
- [[scaling-laws]] — Chinchilla、Kaplan 定律 (15 个源)

## 🏢 Entities

- [[openai]] — GPT 系列、组织历史 (20 个源)
- [[anthropic]] — Claude 系列、宪法 AI (14 个源)

## 📄 Source Summaries

| 标题 | 日期 | 类型 |
|------|------|------|
| [[summary-attention-revisited]] | 2026-03-15 | 论文 |
| [[summary-moe-efficiency]] | 2026-04-01 | 文章 |

## 📊 Comparisons

- [[moe-routing-strategies]] — MoE 路由策略对比
- [[rag-vs-finetuning]] — RAG vs 微调权衡
```

**更新规则：**
- ✅ 每次 ingest 必须更新 index.md
- ✅ 新增页面时添加到对应分类
- ✅ 保持每个条目有一句话摘要 + 源数量

**作用**：
- 🎯 替代 RAG 的检索机制
- 🎯 LLM 先读 index（几千 token），找到相关页面再深入阅读
- 🎯 在中等规模（~100 源，~数百页）下工作良好

---

## 📝 log.md 规范

**格式：**

```markdown
# Activity Log

## [YYYY-MM-DD] ingest | 文章标题
Source: `raw/articles/文件名.md`
Pages created: `wiki/sources/summary-xxx.md`
Pages updated: `wiki/concepts/aaa.md`, `wiki/entities/bbb.md`
Notes: 关键备注（如矛盾标记）

## [YYYY-MM-DD] query | 查询主题
Question: 用户问题
Pages read: 读取的页面列表
Output: 输出形式（答案/存档页面）

## [YYYY-MM-DD] lint | 健康检查
Contradictions found: N
Orphan pages: N
Missing pages suggested: N
Actions taken: 执行的修复操作
```

**解析技巧：**
```bash
# 最近 5 条记录
grep "^## \[" wiki/log.md | tail -5

# 本月 ingest 数量
grep "^## .* ingest" wiki/log.md | grep "$(date +%Y-%m)" | wc -l
```

**作用**：
- 📅 追加式时间线
- 🔍 LLM 通过读最近 log 了解当前状态
- 🛠️ 可被 unix 工具解析

---

## 🎯 分享卡片工作流

### Note to RED（小红书风格）

**触发**：用户说 "导出小红书" 或 "export to red"

**LLM 执行**：
1. 确认笔记按 `##` 标题分段
2. 调用 Note to RED 插件
3. 导出图片到 `sharing/red/`
4. 告知用户保存位置

---

### Quote Share（渐变文字卡片）

**触发**：用户选中文字并说 "生成渐变卡片"

**LLM 执行**：
1. 确认选中的文字
2. 调用 Quote Share 插件
3. 选择渐变样式
4. 保存到 `sharing/quotes/` 或复制到剪贴板

---

### Content Cards（内容卡片）

**触发**：用户插入卡片代码块

**示例**：
```markdown
```book
title: 深度工作
author: 卡尔·纽波特
rating: ⭐⭐⭐⭐⭐
tags: [生产力，学习]
```
```

**LLM 执行**：
1. 渲染卡片
2. 可选导出到 `sharing/cards/`

---

## 🛠️ 工具集成

### Obsidian

- **Web Clipper**: 剪藏网页到 `raw/articles/`
- **附件设置**: `raw/assets/` 存储图片
- **图谱视图**: 可视化页面关联
- **插件**:
  - Marp Slides - 生成幻灯片
  - Dataview - 查询 frontmatter
  - Note to RED - 小红书导出
  - Quote Share - 渐变卡片
  - Content Cards - 内容卡片

### qmd（可选，大规模时）

当 wiki 超过 100 页，index.md 太大时考虑安装：

```bash
# 安装
npm install -g @tobilu/qmd

# 添加集合
qmd collection add ./wiki --name llm-wiki

# 搜索
qmd query "关键词" --json
```

### Git

```bash
# 每次 ingest 后提交
git add .
git commit -m "ingest: [文章标题]"

# 查看历史
git log --oneline

# 回滚
git revert HEAD
```

---

## 🎯 最佳实践

### ✅ 应该做的

- [ ] 每次 ingest 只处理一个源（用户可参与）
- [ ] 保持 frontmatter 完整
- [ ] 使用 `[[wikilink]]` 创建内部链接
- [ ] 定期运行 lint（建议每周）
- [ ] 将优质查询答案存档为 wiki 页面
- [ ] 图片本地化存储到 `raw/assets/`
- [ ] 每次 ingest 后 git commit
- [ ] 用 index.md 导航（小规模时不需要 qmd）

### ❌ 不应该做的

- [ ] 修改 `raw/` 中的任何文件
- [ ] 跳过 index.md 更新
- [ ] 创建无 frontmatter 的页面
- [ ] 使用绝对路径或外部链接代替 wikilink
- [ ] 删除页面（如需要，标记为 `deprecated`）
- [ ] 在 wiki 中引用未下载的 URL 图片

---

## 📈 规模建议

| 规模 | 源文档数 | Wiki 页数 | 检索方式 | 工具 |
|------|---------|----------|----------|------|
| **初期** | 1-50 | 1-100 | index.md | 基础插件 |
| **中期** | 50-200 | 100-500 | index.md + Dataview | + Marp |
| **长期** | 200+ | 500+ | qmd 搜索 | + qmd |

---

## 🔄 Schema 版本

| 版本 | 日期 | 变更 |
|------|------|------|
| 1.0 | 2026-04-05 | 初始版本（基于 Karpathy Gist） |
| 1.1 | 2026-04-05 | 添加分享卡片工作流 |

---

## 🧠 核心理念

> **"Obsidian 是 IDE；LLM 是程序员；Wiki 是代码库"**

### 人机分工

**你（用户）负责**：
-  curated 源文档
-  探索和思考
-  问对的问题
-  审查和批准

**LLM 负责**：
-  总结
-  交叉引用
-  归档
-  簿记
-  维护一致性

### 复合增长

- 📥 源文档摄入 → wiki 增长
- ❓ 查询探索 → 新页面存档
- 🔍 定期 lint → 健康维护
- 📤 分享卡片 → 知识传播

---

> **LLM 注意**：本 schema 是你维护 Wiki 的唯一依据。每次会话开始时，先读取本文件。如有不确定，优先遵循 schema 而非用户临时指示。
>
> **用户注意**：你可以通过修改本文件来演化 Wiki 的行为。建议与 LLM 讨论后共同更新。
