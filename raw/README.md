# raw/ 目录说明

> 原始资料收集目录 - LLM 只读，禁止修改

---

## 📁 目录结构

| 目录 | 用途 | 内容示例 | 处理方式 |
|------|------|---------|---------|
| `articles/` | 文章 | 公众号/即刻/博客 | Web Clipper 导出 Markdown |
| `videos/` | 视频 | 抖音/B 站/YouTube | 链接 + 文字笔记 |
| `papers/` | 学术论文 | PDF/研究论文 | PDF 文件 |
| `books/` | 书籍 | 电子书/读书笔记 | PDF/EPUB/笔记 |
| `courses/` | 课程 | 网课/教程 | 链接 + 笔记 |
| `podcasts/` | 播客 | 音频节目 | 链接 + 转录 |
| `journals/` | 日记 | 个人反思 | Markdown |
| `data/` | 数据 | CSV/JSON/数据集 | 原始数据文件 |
| `assets/` | 附件 | 图片/视频/文档 | 本地文件 |

---

## 🔗 内容来源

### 公众号文章
- 使用 Obsidian Web Clipper 导出
- 保存到 `articles/wechat-[标题].md`

### 即刻动态
- 复制链接，手动整理
- 保存到 `articles/jike-[标题].md`

### 抖音视频
- 复制链接
- 记录关键信息（标题/作者/要点）
- 保存到 `videos/douyin-[标题].md`

---

## 📝 文章模板

```markdown
---
title: 文章标题
source: wechat | jike | blog
url: 原文链接
author: 作者
date: 2026-04-05
tags: [标签 1, 标签 2]
---

# 文章标题

**来源**: [公众号/即刻](url)  
**作者**: xxx  
**日期**: 2026-04-05

---

## 核心观点

- 观点 1
- 观点 2

## 关键内容

正文整理...

## 我的思考

- 启发 1
- 启发 2

---
*收藏于：2026-04-05*
```

---

## 📹 视频模板

```markdown
---
title: 视频标题
source: douyin | bilibili | youtube
url: 视频链接
author: 作者
date: 2026-04-05
tags: [标签]
---

# 视频标题

**来源**: [抖音/B 站](url)  
**作者**: xxx  
**时长**: xx 分钟

---

## 核心内容

- 要点 1
- 要点 2

## 关键信息

文字整理/转录...

## 我的思考

- 启发 1
- 启发 2

---
*收藏于：2026-04-05*
```

---

## ⚠️ LLM 规则

**raw/ 是 LLM 只读目录**：
- ✅ LLM 可以读取
- ❌ LLM 禁止修改
- ❌ LLM 禁止删除
- ❌ LLM 禁止移动

**这是你的 source of truth**

---

*最后更新：2026-04-05*
