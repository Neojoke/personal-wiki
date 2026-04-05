# 🎨 分享卡片插件使用指南

已安装的 3 个分享卡片插件，帮你把知识变成精美图片分享出去！

---

## 📱 1. Note to RED（小红书风格）

**最适合**：小红书、朋友圈、微博分享

### 使用方法

1. **编写笔记**
```markdown
# 我的知识卡片

## 核心观点 1
这是第一个知识点的详细内容...
可以写多行，插件会自动排版

## 核心观点 2
这是第二个知识点...

## 总结
最后做个总结
```

2. **导出图片**
   - 按 `Ctrl/Cmd + P` 打开命令面板
   - 搜索 "Note to RED" 或 "Export to RED"
   - 选择导出样式
   - 每个 `##` 标题会生成一张独立图片

3. **保存/分享**
   - 图片自动保存到 `raw/assets/` 或指定文件夹
   - 直接发小红书/朋友圈

### 特点
- ✅ 自动按二级标题分段
- ✅ 小红书风格模板
- ✅ 优化移动端阅读
- ✅ 支持自定义背景/字体

---

## ✨ 2. Quote Share（渐变文字卡片）

**最适合**：金句、名言、重点摘要

### 使用方法

1. **选中文字**
```markdown
> 这是我要分享的金句
> 知识就是力量
```

2. **生成卡片**
   - 选中文字
   - 右键 → "Share as gradient" 
   - 或命令面板搜索 "Quote Share"

3. **选择样式**
   - 多种渐变背景可选
   - 自定义字体大小
   - 调整颜色

4. **复制/保存**
   - 一键复制到剪贴板
   - 或保存为图片文件

### 特点
- ✅ 多种渐变模板
- ✅ 快速生成
- ✅ 适合短文字
- ✅ 一键复制

---

## 🎴 3. Content Cards（内容卡片）

**最适合**：笔记内美化、信息展示

### 支持的卡片类型

#### 书籍卡片
```markdown
```book
title: 深度工作
author: 卡尔·纽波特
rating: ⭐⭐⭐⭐⭐
tags: [生产力，学习]
cover: ![封面](url)
```
```

#### 电影卡片
```markdown
```movie
title: 星际穿越
director: 克里斯托弗·诺兰
year: 2014
rating: 9.3
tags: [科幻，冒险]
```
```

#### 音乐卡片
```markdown
```music
title: Bohemian Rhapsody
artist: Queen
album: A Night at the Opera
year: 1975
```
```

#### 时间线卡片
```markdown
```timeline
- 2024-01: 项目启动
- 2024-03: 第一版上线
- 2024-06: 用户破万
- 2024-12: 完成 A 轮融资
```
```

#### 高亮块
```markdown
```highlight
这是重要内容，需要高亮显示
支持 **Markdown** 格式
```
```

#### 名片卡片
```markdown
```contact
name: 吴鹏
title: 创始人 @ 公司
email: peng@example.com
wechat: peng_wu
github: @wupeng
```
```

### 使用方法

1. 在笔记中插入代码块
2. 选择卡片类型（book/movie/music 等）
3. 填写对应字段
4. 切换阅读模式查看效果

### 特点
- ✅ 10+ 种卡片类型
- ✅ 笔记内渲染
- ✅ 可导出为图片
- ✅ 支持 Markdown

---

## 🎯 场景推荐

| 场景 | 推荐插件 | 输出格式 |
|------|----------|----------|
| 小红书笔记 | Note to RED | 多张图片 |
| 朋友圈金句 | Quote Share | 单张图片 |
| 微博摘要 | Note to RED | 九宫格 |
| 笔记美化 | Content Cards | 内嵌卡片 |
| 书籍推荐 | Content Cards | 书籍卡片 |
| 项目时间线 | Content Cards | 时间线 |
| 联系方式 | Content Cards | 名片 |

---

## 📸 完整工作流

### 小红书发布流程

```
1. 在 Obsidian 写笔记
   ↓
2. 用 ## 标题分段
   ↓
3. Note to RED 导出图片
   ↓
4. 图片自动保存到 raw/assets/
   ↓
5. 打开小红书 APP
   ↓
6. 选择图片发布
```

### 朋友圈金句流程

```
1. 在笔记中标注金句
   ↓
2. 选中文字 → Quote Share
   ↓
3. 选择渐变样式
   ↓
4. 复制到剪贴板
   ↓
5. 微信朋友圈粘贴发布
```

---

## 🔧 插件配置

### Note to RED 配置
- 设置 → 社区插件 → Note to RED
- 可配置：
  - 输出文件夹
  - 图片宽度
  - 默认模板
  - 字体大小

### Quote Share 配置
- 设置 → 社区插件 → Quote Share
- 可配置：
  - 渐变主题
  - 字体样式
  - 默认尺寸

### Content Cards 配置
- 设置 → 社区插件 → Content Cards
- 可配置：
  - 卡片颜色
  - 默认字段
  - 自定义卡片类型

---

## 💡 高级技巧

### 1. 批量导出
用 Note to RED 一次性导出整个笔记的所有章节

### 2. 自定义模板
修改插件 CSS 实现个性化样式

### 3. 组合使用
- Content Cards 美化笔记
- Note to RED 导出分享
- Quote Share 提取金句

### 4. 配合 Dataview
用 Dataview 自动生成卡片内容

---

## 📝 示例笔记

创建一个完整的分享笔记：

```markdown
# 📚 2026 年读书清单

## 《深度工作》
```book
title: 深度工作
author: 卡尔·纽波特
rating: ⭐⭐⭐⭐⭐
tags: [生产力，学习]
```

> 深度工作是信息时代的超级力量

## 《原子习惯》
```book
title: 原子习惯
author: 詹姆斯·克利尔
rating: ⭐⭐⭐⭐⭐
tags: [习惯，成长]
```

> 每天进步 1%，一年后进步 37 倍

## 总结
用 Quote Share 把上面两个金句生成卡片，
用 Note to RED 导出整篇笔记发小红书！
```

---

## 🚀 下一步

1. **打开 Obsidian**
2. **添加 vault**: `~/.openclaw/workspace/llm-wiki`
3. **启用插件**: 设置 → 社区插件 → 启用这三个插件
4. **创建测试笔记**
5. **开始分享！**

---

**祝你分享愉快！** 🎉
