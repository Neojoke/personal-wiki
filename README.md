# Personal Wiki

> 基于 Karpathy "Idea File" 架构的个人知识库系统
> 
> **Obsidian 是 IDE；LLM 是程序员；Wiki 是代码库**
> 
> **严格模式**：本 Wiki 采用严格的结构化规范，确保知识的一致性和可维护性

---

## 🎯 项目定位

**用途**：个人知识库

**追踪内容**：
- 🎯 自己的目标
- 💪 健康状况
- 🧠 心理状态
- 📈 自我提升
- 📔 日记条目
- 📰 文章/播客笔记

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
personal-wiki/
├── raw/                          # 原始资料（LLM 只读，禁止修改）
│   ├── articles/                 # 网络文章、博客
│   ├── papers/                   # 学术论文
│   ├── journal/                  # 日记
│   ├── podcast/                  # 播客笔记
│   ├── repos/                    # GitHub 仓库笔记
│   ├── data/                     # 数据集、CSV、JSON
│   └── assets/                   # 图片、附件（本地存储）
│
├── wiki/                         # LLM 生成的知识库（LLM 完全拥有）
│   ├── index.md                  # 主目录（每次摄入必须更新）
│   ├── log.md                    # 活动日志（追加式）
│   ├── overview.md               # 高层综合/概述
│   ├── concepts/                 # 概念页面（通用）
│   ├── entities/                 # 实体页面（通用）
│   ├── sources/                  # 源文档摘要（通用）
│   ├── comparisons/              # 对比分析（通用）
│   ├── goals/                    # 目标追踪（个人）
│   ├── health/                   # 健康记录（个人）
│   └── reflections/              # 反思/心理状态（个人）
│
├── sharing/                      # 分享卡片导出（可选）
│   ├── red/                      # 小红书风格图片
│   ├── quotes/                   # 渐变文字卡片
│   └── cards/                    # 内容卡片
│
└── AGENTS.md                     # Schema 文件（LLM 必读）
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
git clone https://github.com/Neojoke/personal-wiki.git
cd personal-wiki
```

### 2. 用 Obsidian 打开

1. 安装 [Obsidian](https://obsidian.md)
2. 打开 Obsidian → 添加文件夹作为 Vault
3. 选择 `personal-wiki` 目录

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
# 下载 PDF/文章 → 放入 raw/articles/ 或 raw/papers/

# 方法 3：使用已有源
# raw/articles/karpathy-llm-wiki-idea-file.md（Karpathy Gist）
```

然后对 Agent 说：
> "Ingest raw/articles/[文件名]"

---

## 📋 核心操作

### Ingest（摄入）【严格模式】

**触发**：放入新源文件到 `raw/` 并说 "ingest [文件名]"

**LLM 执行**：
1. 读取源文件
2. 与用户讨论关键要点
3. 创建 Ingest 计划
4. **【严格】等待用户确认**
5. 创建摘要页（`wiki/sources/`）
6. 更新相关概念/实体页
7. 更新主目录（`wiki/index.md`）【严格】
8. 追加活动日志（`wiki/log.md`）【严格】
9. Git 提交

**示例**：
```markdown
# 用户
我添加了新文章到 raw/articles/2026-04-goals.md
请摄入它

# LLM
## Ingest 计划

**源文件**: `raw/articles/2026-04-goals.md`

### 关键要点
1. 要点一
2. 要点二
3. 要点三

### 将创建/更新的页面
- ✅ 新建：`wiki/sources/summary-goals.md`
- 🔄 更新：`wiki/goals/2026-fitness.md`
- 🔄 更新：`wiki/index.md`
- 📝 追加：`wiki/log.md`

**是否继续？** [等待用户确认]
```

---

### Query（查询）【严格模式】

**触发**：用户提出问题

**LLM 执行**：
1. 读取 `wiki/index.md` 定位相关页面【严格】
2. 读取相关 wiki 页面
3. 综合答案，使用 `[[wikilink]]` 引用【严格】
4. 如答案有价值，提议存为新页面

**示例**：
```markdown
# 用户
我最近的能量水平如何？

# LLM
## 回答

根据过去 30 天的健康记录，你的平均能量水平为 3.8/5...

### 引用来源
- [[health-2026-04-01]]：能量 4
- [[health-2026-04-02]]：能量 3
- [[health-2026-04-03]]：能量 4

---

💡 **建议存档**：是否将月度总结存为 `wiki/health/summary-2026-04.md`？
```

---

### Lint（健康检查）【严格模式】

**触发**：用户说 "lint" 或 "健康检查"

**LLM 执行**：
1. 扫描所有 wiki 页面
2. 检查矛盾、孤立页面、缺失页面
3. 生成健康报告
4. 建议修复操作

**频率建议**：每周一次

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
- 页面格式规范（两种 frontmatter 模板）
- 工作流如何执行（严格模式）
- 什么能做，什么不能做

**LLM 每次会话开始时，必须先读取 AGENTS.md**

详见：[AGENTS.md](./AGENTS.md)

---

## 🎯 使用场景

### 1. 目标追踪
记录短期/长期目标，LLM 帮助追踪进度、提醒回顾

### 2. 健康记录
每日健康数据（能量、心情、运动），LLM 生成趋势分析

### 3. 日记/反思
每日日记，LLM 帮助识别模式、关联事件

### 4. 文章/播客笔记
剪藏内容，LLM 提取要点、关联已有知识

### 5. 分享卡片
用 Note to RED / Quote Share 把知识变成精美图片分享

---

## 📈 最佳实践

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
- [ ] 批量 ingest（除非用户明确要求）

---

## 🔄 Schema 变更日志

| 版本 | 日期 | 变更 |
|------|------|------|
| 1.0 | 2026-04-05 | 初始版本（基于 Karpathy Gist） |

---

## 📚 参考资料

- **Karpathy Gist**: [LLM Wiki Idea File](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f)
- **获取方式**: `gh gist view 442a6bf555914893e9891c11519de94f`
- **第一个摄入源**: `raw/articles/karpathy-llm-wiki-idea-file.md`

---

## 🚀 下一步

### 立即开始

1. **打开 Obsidian**
   ```bash
   obsidian://open?vault=personal-wiki
   ```

2. **启用插件**
   - 设置 → 社区插件
   - 启用 7 个插件

3. **摄入第一个源**
   ```bash
   # Karpathy Gist 已保存在 raw/articles/
   # 对 Agent 说："Ingest raw/articles/karpathy-llm-wiki-idea-file.md"
   ```

4. **查看效果**
   - 打开 `wiki/index.md` 查看目录
   - 打开 `wiki/log.md` 查看活动记录

### 10 源测试

Karpathy 建议的里程碑：

```
摄入 10 个源 → 问一个综合问题 → 验证系统是否给出独特洞察
```

如果系统能给你阅读单个源得不到的洞察，说明工作正常！

---

**开始构建你的个人知识库吧！** 🧠✨
