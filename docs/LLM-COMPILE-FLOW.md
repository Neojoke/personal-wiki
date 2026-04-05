# LLM 编译流程

> raw/ → wiki/ 的自动化知识整理流程

---

## 🎯 核心概念

**LLM 编译** = LLM 读取 raw/ 中的原始资料 → 提取关键信息 → 创建/更新 wiki/ 页面

```
raw/articles/wechat-xxx.md  ← 你收藏的文章
    ↓ (LLM 读取)
wiki/sources/summary-xxx.md  ← LLM 创建的摘要
wiki/concepts/[相关概念].md  ← LLM 更新的概念页
wiki/index.md               ← LLM 更新的主目录
wiki/log.md                 ← LLM 追加的活动记录
```

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

## 📊 完整流程

### Step 1: 准备 raw 内容

**你做的**：
1. 从抖音/公众号/即刻复制链接
2. 保存到对应的 raw/ 目录
3. 填写基础信息（标题/链接/日期）

**示例文件**：`raw/articles/wechat-ai-trend.md`
```markdown
---
title: 2026 AI 趋势分析
source: wechat
url: https://mp.weixin.qq.com/s/xxx
author: AI 专家
date: 2026-04-05
tags: [AI, 趋势，2026]
---

# 2026 AI 趋势分析

[文章正文内容...]
```

---

### Step 2: 触发 LLM 编译

**你说的**：
```
"Ingest raw/articles/wechat-ai-trend.md"
```

**LLM 做的**：
1. ✅ 读取 raw 文件
2. ✅ 提取关键要点
3. ✅ 创建 Ingest 计划
4. ✅ 等待你确认

**LLM 回复示例**：
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

---

### Step 3: 确认并执行

**你说的**：
```
"继续" 或 "确认"
```

**LLM 做的**：
1. ✅ 创建源摘要页面
2. ✅ 更新相关概念页面
3. ✅ 更新 index.md
4. ✅ 追加 log.md
5. ✅ Git 提交

---

### Step 4: 查看结果

**编译后的 wiki/**：

```
wiki/
├── sources/
│   └── summary-ai-trend-2026.md  ← 新建：文章摘要
├── concepts/
│   └── llm-trends.md             ← 更新：添加新趋势
├── index.md                      ← 更新：添加新页面链接
└── log.md                        ← 追加：记录 ingest 操作
```

**示例：创建的摘要页面**
```markdown
---
title: 2026 AI 趋势分析
type: source-summary
tags: [AI, 趋势，2026]
sources: [raw/articles/wechat-ai-trend.md]
related: [[llm-trends], [agent-technology]]
created: 2026-04-05
updated: 2026-04-05
confidence: high
---

# 2026 AI 趋势分析

**来源**: [公众号文章](raw/articles/wechat-ai-trend.md)  
**作者**: AI 专家  
**日期**: 2026-04-05

---

## 核心观点

1. **多模态 LLM** - 文本 + 图像 + 音频融合
2. **Agent 技术** - 自主任务执行成为主流
3. **边缘 AI** - 本地推理性能大幅提升

## 详细内容

[LLM 提取的详细内容...]

## 关联概念

- [[llm-trends]] - LLM 发展趋势
- [[agent-technology]] - Agent 技术

---
*摘要生成于：2026-04-05 | 置信度：high*
```

---

## 📋 编译前后对比

| 阶段 | raw/ | wiki/ |
|------|------|-------|
| **编译前** | ✅ 有原始文章 | ❌ 无摘要/无索引 |
| **编译后** | ✅ 保持不变 | ✅ 有摘要/有索引/有链接 |

**关键点**：
- raw/ **永远不变**（source of truth）
- wiki/ **持续增长**（知识积累）

---

## ⚙️ LLM 工作流细节

### Ingest（摄入）

**触发**：`"Ingest raw/[路径]"`

**LLM 步骤**：
```
1. 读取 raw 文件
2. 提取关键要点（3-5 个）
3. 识别相关概念
4. 创建 Ingest 计划
5. 等待确认
6. 执行创建/更新
7. 更新 index.md
8. 追加 log.md
9. Git 提交
```

### Query（查询）

**触发**：用户提问

**LLM 步骤**：
```
1. 读取 index.md 定位
2. 读取相关页面
3. 综合答案
4. 使用 [[wikilink]] 引用
5. 建议存档有价值分析
```

### Lint（健康检查）

**触发**：`"lint the wiki"`

**LLM 步骤**：
```
1. 扫描所有 wiki 页面
2. 检查矛盾
3. 找孤立页面
4. 建议缺失页面
5. 生成健康报告
```

---

## 🎯 最佳实践

### ✅ 应该做的

- [ ] 每次 ingest 只处理一个源
- [ ] 确认 LLM 的 Ingest 计划
- [ ] 定期检查 wiki/index.md
- [ ] 每周运行一次 lint

### ❌ 不应该做的

- [ ] 批量 ingest（除非明确要求）
- [ ] 跳过确认直接执行
- [ ] 手动修改 wiki/ 页面（让 LLM 维护）
- [ ] 修改 raw/ 文件（raw 是只读的）

---

## 📊 效果示例

### 收藏 10 篇文章后

**raw/articles/**：
```
wechat-ai-trend.md
wechat-llm-tips.md
jike-ai-news-01.md
jike-ai-news-02.md
...
```

**wiki/sources/**：
```
summary-ai-trend-2026.md
summary-llm-tips-collection.md
summary-ai-news-week1.md
...
```

**wiki/concepts/**：
```
llm-trends.md          ← 被更新 3 次
agent-technology.md    ← 被更新 2 次
ai-applications.md     ← 被更新 5 次
```

**wiki/index.md**：
```markdown
# Wiki Index

## 📚 Concepts
- [[llm-trends]] — LLM 发展趋势 (3 个源)
- [[agent-technology]] — Agent 技术 (2 个源)
- [[ai-applications]] — AI 应用 (5 个源)
```

---

## 🔗 相关文档

- **AGENTS.md** - 完整 Schema 规范
- **raw/README.md** - raw 目录使用说明
- **wiki/goals/GOALS-SPEC.md** - 目标管理规范

---

*最后更新：2026-04-05*
