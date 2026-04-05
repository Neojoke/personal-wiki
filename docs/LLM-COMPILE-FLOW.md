# LLM 编译流程

> raw/ → wiki/ 的自动化知识整理

---

## 🎯 核心概念

**LLM 编译** = LLM 读取 raw/ 中的原始资料 → 提取关键信息 → 创建/更新 wiki/ 页面

```
raw/articles/wechat-xxx.md  ← 你收藏的文章
    ↓ (LLM 读取)
wiki/sources/summary-xxx.md  ← LLM 创建的摘要
wiki/concepts/[概念].md      ← LLM 更新的概念页
wiki/index.md               ← LLM 更新的主目录
wiki/log.md                 ← LLM 追加的活动记录
```

**关键差异**：
- ❌ RAG：查询时重新发现知识
- ✅ Wiki：编译一次，持续更新，复合增长

---

## 🚀 快速开始

### 一句话指令

```
"Ingest raw/articles/[文件名]"
```

**示例**：
```
"Ingest raw/articles/wechat-ai-trend.md"
"Ingest raw/videos/douyin-llm-tips.md"
```

---

## 📊 编译过程

### 你做的

1. 从抖音/公众号/复制链接
2. 保存到 raw/[类型]/
3. 说："Ingest raw/[路径]"

### LLM 做的

1. 读取 raw 文件
2. 讨论关键要点（3-5 个）
3. 创建 Ingest 计划
4. 等你确认
5. 创建/更新 wiki 页面
6. 更新 index.md
7. 追加 log.md

### 编译后的效果

**raw/**：保持不变（source of truth）

**wiki/**：
- 新增源摘要页面
- 更新相关概念页面
- 更新主目录
- 追加活动记录

---

## 📋 三个核心操作

### Ingest（摄入）

**触发**：`"Ingest raw/[路径]"`

**LLM 输出**：
```markdown
## Ingest 计划

**源文件**: `raw/articles/wechat-ai-trend.md`

### 关键要点
1. 2026 年 LLM 将向多模态发展
2. Agent 技术将成为主流
3. 边缘 AI 计算将兴起

### 将创建/更新的页面
- ✅ 新建：`wiki/sources/summary-ai-trend-2026.md`
- 🔄 更新：`wiki/concepts/llm-trends.md`
- 🔄 更新：`wiki/index.md`
- 📝 追加：`wiki/log.md`

**是否继续？**
```

**严格规则**：
- 逐个 ingest（除非用户要求批量）
- 必须等待用户确认
- 必须更新 index.md 和 log.md

---

### Query（查询）

**触发**：用户提问

**LLM 输出**：
```markdown
## 回答

根据你的知识库，2026 年 LLM 趋势包括：

1. 多模态融合（文本 + 图像 + 音频）
2. Agent 自主任务执行
3. 边缘推理性能提升

### 引用来源
- [[llm-trends]]：LLM 发展方向
- [[summary-ai-trend-2026]]：2026 趋势分析

---

💡 **建议存档**：这个分析很有价值，是否存为 `wiki/comparisons/2026-llm-trends.md`？
```

**严格规则**：
- 先读 index.md 定位
- 使用 [[wikilink]] 引用
- 建议存档有价值的分析

---

### Lint（健康检查）

**触发**：`"lint the wiki"`

**LLM 输出**：
```markdown
## Wiki 健康报告 (2026-04-05)

### ❌ 矛盾 (1)
1. **llm-trends.md** vs **agent-tech.md**
   - 矛盾点：Agent 技术成熟时间
   - 建议：更新为 nuanced 描述

### 📄 孤立页面 (2)
- `wiki/concepts/multimodal.md` - 无入链

### ❓ 缺失页面 (3)
- "边缘 AI" 被提及 5 次，无独立页面

### 💡 建议调查
- 缺少 2026 年最新推理优化源
```

**频率**：每周一次或摄入 10+ 源后

---

## 📊 效果示例

### 收藏 10 篇文章后

**raw/articles/**：
```
wechat-ai-trend.md
wechat-llm-tips.md
jike-ai-news-01.md
...
```

**wiki/sources/**：
```
summary-ai-trend-2026.md
summary-llm-tips-collection.md
...
```

**wiki/concepts/**：
```
llm-trends.md          ← 被更新 3 次
agent-technology.md    ← 被更新 2 次
```

**wiki/index.md**：
```markdown
# Wiki Index

## 📚 Concepts
- [[llm-trends]] — LLM 发展趋势 (3 个源)
- [[agent-technology]] — Agent 技术 (2 个源)
```

---

## ⚠️ 核心规则

**raw/**：
- ✅ LLM 可以读取
- ❌ LLM 禁止修改/删除/移动
- 这是 source of truth

**wiki/**：
- ✅ LLM 完全拥有
- ✅ LLM 创建/更新/维护
- 你读它，LLM 写它

---

## 💡 最佳实践

### 应该做的

- 每次 ingest 只处理一个源
- 确认 LLM 的 Ingest 计划
- 每周运行一次 lint

### 不应该做的

- 批量 ingest（除非明确要求）
- 跳过确认直接执行
- 手动修改 wiki/ 页面

---

## 🔗 相关文档

- **AGENTS.md** - 完整 Schema 规范
- **raw/README.md** - raw 目录使用说明
- **wiki/goals/GOALS-SPEC.md** - 目标管理规范

---

*基于 Karpathy LLM Wiki pattern | 最后更新：2026-04-05*
