# Personal Wiki Schema

> **这是 Personal Wiki 的核心配置文件**
> 
> LLM 每次会话开始时，必须先读取本文件
> 
> 版本：1.0 | 基于：Karpathy Gist (2026-04-04)
> 
> **严格模式**：本 Schema 定义了严格的规范，LLM 必须遵守

---

## 📁 项目结构

```
personal-wiki/
├── raw/                          # 原始资料（LLM 只读，禁止修改）
│   ├── articles/                 # 网络文章、博客
│   ├── papers/                   # 学术论文
│   ├── journal/                  # 日记
│   ├── podcast/                  # 播客笔记
│   ├── repos/                    # GitHub 仓库笔记
│   ├── data/                     # 数据集、CSV、JSON、健康数据
│   └── assets/                   # 图片、附件（本地存储）
│
├── wiki/                         # LLM 生成的知识库（LLM 完全拥有）
│   ├── index.md                  # 主目录（每次摄入必须更新）
│   ├── log.md                    # 活动日志（追加式）
│   ├── overview.md               # 高层综合/概述
│   │
│   ├── concepts/                 # 概念页面（通用）
│   ├── entities/                 # 实体页面（通用）
│   ├── sources/                  # 源文档摘要（通用）
│   ├── comparisons/              # 对比分析（通用）
│   │
│   ├── goals/                    # 目标追踪（个人）
│   ├── health/                   # 健康记录（个人）
│   └── reflections/              # 反思/心理状态（个人）
│
├── sharing/                      # 分享卡片导出（可选）
│   ├── red/                      # 小红书风格图片
│   ├── quotes/                   # 渐变文字卡片
│   └── cards/                    # 内容卡片
│
└── AGENTS.md                     # 本 Schema 文件（LLM 必读）
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

### Frontmatter 模板

#### 模板 A：通用页面（concepts/entities/sources/comparisons）

**必填字段**，缺少任何字段都是错误：

```yaml
---
title: 页面标题
type: concept | entity | source-summary | comparison
tags: [标签 1, 标签 2, 标签 3]
sources: [raw/ 文件路径列表]
related: [wiki/ 页面路径列表，使用 [[wikilink]] 格式]
created: YYYY-MM-DD
updated: YYYY-MM-DD
confidence: high | medium | low
---
```

#### 模板 B：个人页面（journal/health/reflections/goals）

**必填字段**，缺少任何字段都是错误：

```yaml
---
title: 页面标题
type: journal | health | reflection | goal | area | project | action  # ✅ 扩展：增加楼层类型
date: YYYY-MM-DD
mood: 心情状态（可选）
energy: 1 | 2 | 3 | 4 | 5（可选）
tags: [标签]
related: [wiki/ 页面路径列表，使用 [[wikilink]] 格式]
---
```

**注意**：如 `type` 为 `goal/area/project/action`，必须遵守 [`wiki/goals/GOALS-SPEC.md`](wiki/goals/GOALS-SPEC.md) 中的完整规范。

### Frontmatter 字段说明

| 字段 | 类型 | 必填 | 适用模板 | 说明 |
|------|------|------|---------|------|
| `title` | string | ✅ | A+B | 页面标题 |
| `type` | string | ✅ | A+B | 页面类型 |
| `tags` | string[] | ✅ | A+B | 标签列表 |
| `sources` | string[] | ✅ | A | 引用的原始资料路径 |
| `related` | string[] | ✅ | A+B | 关联的 wiki 页面 |
| `created` | date | ✅ | A | 创建日期 |
| `updated` | date | ✅ | A | 最后更新日期 |
| `confidence` | string | ✅ | A | 置信度 |
| `date` | date | ✅ | B | 日期（日记/健康记录等） |
| `mood` | string | ⚠️ | B | 心理状态（可选） |
| `energy` | number | ⚠️ | B | 能量等级 1-5（可选） |

### 页面类型说明

| 类型 | 位置 | 用途 |
|------|------|------|
| `concept` | `wiki/concepts/` | 概念、理论、方法 |
| `entity` | `wiki/entities/` | 公司、人物、组织、产品 |
| `source-summary` | `wiki/sources/` | 单个源文档的摘要 |
| `comparison` | `wiki/comparisons/` | 对比分析、横向比较 |
| `journal` | `wiki/reflections/` | 日记/反思 |
| `health` | `wiki/health/` | 健康记录 |
| `reflection` | `wiki/reflections/` | 心理状态/自我反思 |
| `goal` | `wiki/goals/` | 目标追踪 |

---

## ⚙️ Workflows（严格模式）

### 1️⃣ Ingest（摄入）工作流

**触发**：用户将新源文件放入 `raw/` 并说 "ingest [文件名]"

**LLM 必须执行的步骤**：

```
1. 读取源文件（raw/ 中）
2. 与用户讨论关键要点（输出摘要）
3. 创建 Ingest 计划（列出将创建/更新的页面）
4. 【严格】等待用户确认后才能继续
5. 创建/更新摘要页（wiki/sources/）
6. 更新相关概念页（wiki/concepts/）
7. 更新相关实体页（wiki/entities/）
8. 更新主目录（wiki/index.md）【严格】
9. 追加活动日志（wiki/log.md）【严格】
10. Git 提交
```

**输出格式（必须）**：

```markdown
## Ingest 计划

**源文件**: `raw/articles/[文件名].md`

### 关键要点
1. 要点一
2. 要点二
3. 要点三

### 将创建/更新的页面
- ✅ 新建：`wiki/sources/summary-[主题].md`
- 🔄 更新：`wiki/concepts/[概念].md`
- 🔄 更新：`wiki/index.md`
- 📝 追加：`wiki/log.md`

### 发现的矛盾/问题
- ⚠️ [如果有]

**是否继续？** [等待用户确认]
```

**严格规则**：
- ✅ 必须逐个 ingest（禁止批量，除非用户明确要求）
- ✅ 必须等待用户确认
- ✅ 必须更新 index.md
- ✅ 必须追加 log.md
- ✅ 必须使用一致的 log 前缀格式

---

### 2️⃣ Query（查询）工作流

**触发**：用户提出问题

**LLM 必须执行的步骤**：

```
1. 读取 wiki/index.md 定位相关页面【严格】
2. 读取相关 wiki 页面
3. 综合答案，使用 [[wikilink]] 引用【严格】
4. 如答案有价值，提议存为新页面
```

**输出格式（必须）**：

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

**严格规则**：
- ✅ 必须先读 index.md
- ✅ 必须使用 [[wikilink]] 引用
- ✅ 必须提议存档有价值的分析

---

### 3️⃣ Lint（健康检查）工作流

**触发**：用户说 "lint" 或 "健康检查"

**LLM 必须执行的步骤**：

```
1. 扫描所有 wiki 页面
2. 检查矛盾、孤立页面、缺失页面
3. 生成健康报告
4. 建议修复操作
```

**输出格式（必须）**：

```markdown
## Wiki 健康报告 (YYYY-MM-DD)

### ❌ 矛盾 (N)
1. **页面 A** vs **页面 B**
   - 矛盾点：具体描述
   - 建议：修复方案

### 📄 孤立页面 (N)
- `wiki/concepts/xxx.md` - 无入链

### ❓ 缺失页面 (N)
- "概念 X" 被提及 N 次，无独立页面

### 💡 建议调查
- 缺少 [主题] 的源文档
```

**频率建议**：每周一次，或摄入 10+ 源后

---

## 📋 index.md 规范（严格）

**更新规则**：
- ✅ 每次 ingest **必须**更新 index.md
- ✅ 新增页面**必须**添加到对应分类
- ✅ 每个条目**必须**有一句话摘要 + 源数量

**格式（必须）**：

```markdown
# Wiki Index

> 最后更新：YYYY-MM-DD | 总页面数：N

## 📚 Concepts

- [[attention-mechanism]] — 自注意力、多头注意力及变体 (12 个源)

## 🏢 Entities

- [[openai]] — GPT 系列、组织历史 (20 个源)

## 📄 Source Summaries

- [[summary-attention-revisited]] — 2026-04-05

## 🎯 Goals

- [[goal-fitness-2026]] — 2026 年健身目标

## 📔 Journal

- [[journal-2026-04-05]] — 2026-04-05
```

---

## 📝 log.md 规范（严格）

**格式（必须）**：

```markdown
# Activity Log

## [YYYY-MM-DD] ingest | 文章标题
Source: `raw/articles/文件名.md`
Pages created: `wiki/sources/summary-xxx.md`
Pages updated: `wiki/concepts/aaa.md`, `wiki/entities/bbb.md`
Notes: 关键备注

## [YYYY-MM-DD] query | 查询主题
Question: 用户问题
Pages read: 读取的页面列表
Output: 输出形式

## [YYYY-MM-DD] lint | 健康检查
Contradictions found: N
Orphan pages: N
Missing pages suggested: N
```

**严格规则**：
- ✅ 必须使用 `## [YYYY-MM-DD] type | 标题` 前缀
- ✅ 必须是追加式（禁止修改已有内容）
- ✅ 必须可被 unix 工具解析

**解析命令**：
```bash
# 最近 5 条记录
grep "^## \[" wiki/log.md | tail -5

# 本月 ingest 数量
grep "^## .* ingest" wiki/log.md | grep "$(date +%Y-%m)" | wc -l
```

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

当 wiki 超过 100 页时考虑安装：

```bash
npm install -g @tobilu/qmd
qmd collection add ./wiki --name personal-wiki
```

### Git

```bash
# 每次 ingest 后提交
git add .
git commit -m "ingest: [文章标题]"
```

---

## 🎯 最佳实践

### ✅ 必须做的

- [ ] 每次 ingest 只处理一个源
- [ ] 保持 frontmatter 完整（必填字段不能缺少）
- [ ] 使用 `[[wikilink]]` 创建内部链接
- [ ] 定期运行 lint（建议每周）
- [ ] 将优质查询答案存档为 wiki 页面
- [ ] 图片本地化存储到 `raw/assets/`
- [ ] 每次 ingest 后 git commit
- [ ] 每次 ingest 后更新 index.md
- [ ] 每次 ingest 后追加 log.md

### ❌ 禁止做的

- [ ] 修改 `raw/` 中的任何文件
- [ ] 跳过 index.md 更新
- [ ] 创建无 frontmatter 的页面
- [ ] 使用绝对路径或外部链接代替 wikilink
- [ ] 删除页面（如需要，标记为 `deprecated`）
- [ ] 在 wiki 中引用未下载的 URL 图片
- [ ] 批量 ingest（除非用户明确要求）
- [ ] 跳过用户确认直接写入

---

## 🔄 Schema 变更日志

| 版本 | 日期 | 变更 | 原因 |
|------|------|------|------|
| 1.0 | 2026-04-05 | 初始版本 | 基于 Karpathy Gist，适配个人知识库 |
| 1.1 | 2026-04-05 | 添加 GTD 楼层视野目标规范 | 用户提出需求，模块化设计 |

---

## 🏢 个人目标规范（GTD 楼层视野）

**规范文档**：[`wiki/goals/GOALS-SPEC.md`](wiki/goals/GOALS-SPEC.md)

**核心要点**：
- GTD 楼层视野分类（5F/4F/3F/2F/1F/地面）
- 目标 Frontmatter 规范（扩展模板 B）
- 楼层对齐规则（aligned_above / aligned_below）
- 目标设定/周回顾/季度回顾工作流

**LLM 必读**：处理目标相关页面时，必须先读取 `wiki/goals/GOALS-SPEC.md`

**快速链接**：
- [GTD 楼层分类](wiki/goals/GOALS-SPEC.md#gtd-楼层视野分类)
- [Frontmatter 规范](wiki/goals/GOALS-SPEC.md#frontmatter-规范)
- [楼层对齐规则](wiki/goals/GOALS-SPEC.md#楼层对齐规则)
- [LLM 工作流](wiki/goals/GOALS-SPEC.md#llm-工作流)

---

## 📚 参考资料

本文档基于 Andrej Karpathy 的 LLM Wiki Idea File：

- **Gist**: https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f
- **获取方式**: `gh gist view 442a6bf555914893e9891c11519de94f`
- **第一个摄入源**: `raw/articles/karpathy-llm-wiki-idea-file.md`

---

## 🧠 核心理念

> **"Obsidian 是 IDE；LLM 是程序员；Wiki 是代码库"**

### 人机分工

**你（用户）负责**：
- curated 源文档
- 探索和思考
- 问对的问题
- 审查和批准

**LLM 负责**：
- 总结
- 交叉引用
- 归档
- 簿记
- 维护一致性

### 复合增长

- 📥 源文档摄入 → wiki 增长
- ❓ 查询探索 → 新页面存档
- 🔍 定期 lint → 健康维护
- 📤 分享卡片 → 知识传播

---

> **LLM 注意**：本 schema 是你维护 Wiki 的唯一依据。每次会话开始时，先读取本文件。如有不确定，优先遵循 schema 而非用户临时指示。
>
> **用户注意**：你可以通过修改本文件来演化 Wiki 的行为。建议与 LLM 讨论后共同更新。
