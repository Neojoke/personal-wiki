# LLM Wiki

> 基于 Karpathy "Idea File" 架构的个人知识库系统
> 
> **Obsidian 是 IDE；LLM 是程序员；Wiki 是代码库**

---

## 🎯 项目定位

**主题**：LLM 技术研究与知识库

**理念**：
- ❌ 不用 RAG（每次查询重新发现知识）
- ✅ 用 Wiki（知识编译一次，持续更新，复合增长）

**规模目标**：
- 初期：10-100 个源文档
- 中期：100-500 个源文档
- 长期：500+ 源文档（考虑引入 qmd 搜索）

---

## 🏗️ 架构

### 三层结构

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
├── AGENTS.md               # Schema 文件（LLM 必读）
└── README.md               # 本文件
```

### 核心规则

| 目录 | LLM 权限 | 说明 |
|------|---------|------|
| `raw/` | **只读** | 原始资料，LLM 禁止修改或删除 |
| `wiki/` | **完全拥有** | LLM 创建、更新、维护所有内容 |
| `sharing/` | **可写** | 导出分享卡片的目标目录 |
| `AGENTS.md` | **只读** | Schema 文件，仅用户可修改 |

---

## 🚀 快速开始

### 1. 克隆仓库

```bash
git clone https://github.com/Neojoke/llm-wiki.git
cd llm-wiki
```

### 2. 用 Obsidian 打开

1. 安装 [Obsidian](https://obsidian.md)
2. 打开 Obsidian → 添加文件夹作为 Vault
3. 选择 `llm-wiki` 目录

### 3. 安装插件（推荐）

**必需**：
- ✅ Web Clipper - 网页剪藏
- ✅ Dataview - 数据查询
- ✅ Marp Slides - 幻灯片生成

**可选**：
- 📱 Note to RED - 小红书导出
- ✨ Quote Share - 渐变卡片
- 🎴 Content Cards - 内容卡片

### 4. 摄入第一个源

```bash
# 方法 1：网页剪藏
# 安装 Web Clipper 浏览器扩展 → 剪藏文章到 raw/articles/

# 方法 2：手动放入
# 下载 PDF/文章 → 放入 raw/papers/ 或 raw/articles/

# 方法 3：命令行
echo "# 我的笔记" > raw/articles/test.md
```

然后对 Agent 说：
> "Ingest raw/articles/[文件名]"

---

## 📋 核心操作

### Ingest（摄入）

**触发**：放入新源文件到 `raw/` 并说 "ingest [文件名]"

**LLM 执行**：
1. 读取源文件
2. 与用户讨论关键要点
3. 创建摘要页（`wiki/sources/`）
4. 更新相关概念/实体页
5. 更新主目录（`wiki/index.md`）
6. 追加活动日志（`wiki/log.md`）
7. Git 提交

**示例**：
```markdown
# 用户
我添加了新文章到 raw/articles/2026-04-moe-efficiency.md
请摄入它

# LLM
## Ingest 计划

**源文件**: `raw/articles/2026-04-moe-efficiency.md`

### 关键要点
1. MoE 模型实现 4 倍吞吐量
2. 路由效率提升 23%
3. 与 wiki 中"dense 模型更高效"的声明矛盾

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

---

### Query（查询）

**触发**：用户提出问题

**LLM 执行**：
1. 读取 `wiki/index.md` 定位相关页面
2. 读取相关 wiki 页面
3. 综合答案，使用 `[[wikilink]]` 引用
4. 如答案有价值，提议存为新页面

**示例**：
```markdown
# 用户
比较我们源中 MoE 模型的路由策略

# LLM
## 回答

[综合答案内容]

### 引用来源
- [[mixture-of-experts]]：关键信息
- [[summary-moe-efficiency]]：关键信息
- [[scaling-laws]]：关键信息

---

💡 **建议存档**：这个分析很有价值，是否存为 `wiki/comparisons/moe-routing-strategies.md`？
```

---

### Lint（健康检查）

**触发**：用户说 "lint" 或 "健康检查"

**LLM 执行**：
1. 扫描所有 wiki 页面
2. 检查矛盾、孤立页面、缺失页面
3. 生成健康报告
4. 建议修复操作

**示例**：
```markdown
# 用户
lint the wiki

# LLM
## Wiki 健康报告 (2026-04-05)

### ❌ 矛盾 (2)
1. **concepts/dense-vs-sparse.md** vs **sources/summary-moe-efficiency.md**
   - 矛盾点：dense 模型效率声明
   - 建议：更新为 nuanced 描述

### 📄 孤立页面 (3)
- `wiki/concepts/tokenization.md` - 无入链
- `wiki/sources/summary-old-bert-paper.md` - 无引用

### ❓ 缺失页面 (4)
- "RLHF" 被提及 12 次，无概念页
- "Constitutional AI" 被提及 8 次，无页面

### 💡 建议调查
- 缺少 2025 年后的推理优化源
- Meta AI 实体页太薄（仅 1 个源）
```

---

## 🛠️ 工具栈

| 工具 | 用途 | 状态 |
|------|------|------|
| **Obsidian** | 浏览/编辑 Wiki | ✅ 已配置 |
| **Web Clipper** | 网页剪藏到 raw/ | ✅ 已安装 |
| **Dataview** | 查询 frontmatter | ✅ 已安装 |
| **Marp** | 生成幻灯片 | ✅ 已安装 |
| **Note to RED** | 小红书风格导出 | ✅ 已安装 |
| **Quote Share** | 渐变文字卡片 | ✅ 已安装 |
| **Content Cards** | 内容卡片 | ✅ 已安装 |
| **qmd** | 本地搜索（大规模时） | ⏳ 暂不需要 |
| **Git** | 版本控制 | ✅ 已配置 |

---

## 📄 Schema 文件 (AGENTS.md)

**AGENTS.md** 是这个项目的核心配置文件，告诉 LLM：
- 目录结构是什么
- 页面格式规范
- 工作流如何执行
- 什么能做，什么不能做

**LLM 每次会话开始时，必须先读取 AGENTS.md**

详见：[AGENTS.md](./AGENTS.md)

---

## 🎯 使用场景

### 1. 技术研究
深入某个领域（如 LLM 推理优化），阅读论文、文章，构建综合 Wiki

### 2. 读书笔记本
每章做笔记，LLLM 维护角色/主题/情节页面

### 3. 竞争分析
跟踪竞品动态，LLM 自动整理时间线、功能对比

### 4. 学习课程
课程笔记 + 概念整理 + 习题解答

### 5. 分享卡片
用 Note to RED / Quote Share 把知识变成精美图片分享

---

## 📈 最佳实践

### ✅ 应该做的

- [ ] 每次 ingest 只处理一个源（用户参与）
- [ ] 保持 frontmatter 完整
- [ ] 使用 `[[wikilink]]` 创建内部链接
- [ ] 定期运行 lint（建议每周）
- [ ] 将优质查询答案存档为 wiki 页面
- [ ] 图片本地化存储到 `raw/assets/`
- [ ] 每次 ingest 后 git commit

### ❌ 不应该做的

- [ ] 修改 `raw/` 中的任何文件
- [ ] 跳过 index.md 更新
- [ ] 创建无 frontmatter 的页面
- [ ] 使用绝对路径或外部链接代替 wikilink
- [ ] 删除页面（如需要，标记为 `deprecated`）

---

## 🔄 版本历史

| 版本 | 日期 | 变更 |
|------|------|------|
| 1.0 | 2026-04-05 | 初始版本（基于 Karpathy Gist） |
| 1.1 | 2026-04-05 | 添加分享卡片功能 |

---

## 📚 参考资料

- **Karpathy Gist**: [LLM Wiki Idea File](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f)
- **VentureBeat 报道**: [Karpathy's LLM Knowledge Base](https://venturebeat.com/data/karpathy-shares-llm-knowledge-base-architecture-that-bypasses-rag-with-an)
- **完整指南**: [Karpathy's LLM Wiki: Complete Guide](https://antigravity.codes/blog/karpathy-llm-wiki-idea-file)

---

## 🚀 下一步

1. **摄入第一个源**
   ```bash
   # 剪藏一篇文章或手动放入 raw/articles/
   # 然后对 Agent 说："ingest [文件名]"
   ```

2. **运行第一次 Lint**
   ```bash
   # 摄入 10+ 源后
   # 对 Agent 说："lint the wiki"
   ```

3. **分享你的知识**
   ```bash
   # 用 Note to RED 导出小红书图片
   # 用 Quote Share 生成渐变卡片
   ```

---

**开始构建你的知识库吧！** 🧠✨
