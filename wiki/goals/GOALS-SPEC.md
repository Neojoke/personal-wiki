# 个人目标规范（GTD 楼层视野）

> **这是个人目标的专门规范**
> 
> 版本：1.0 | 创建：2026-04-05 | 基于：GTD 楼层视野 + LLM Wiki 工作流
> 
> **LLM 注意**：处理目标相关页面时，必须先读取本规范

---

## 🏢 GTD 楼层视野分类

| 楼层 | 名称 | 目录 | Frontmatter type | 时间范围 | 回顾频率 |
|------|------|------|-----------------|---------|---------|
| **5F** | 原则/价值 | `wiki/goals/5f-principles/` | `principle` | 终身 | 每年 1-2 次 |
| **4F** | 愿景 | `wiki/goals/4f-vision/` | `vision` | 3-5 年 | 每半年 |
| **3F** | 目标 | `wiki/goals/3f-goals/` | `goal` | 1-2 年 | 每季度 |
| **2F** | 责任领域 | `wiki/goals/2f-areas/` | `area` | 持续 | 每周 |
| **1F** | 项目 | `wiki/goals/1f-projects/` | `project` | 3-12 个月 | 每周 |
| **地面** | 行动 | `raw/journal/` | `action` | 今天/本周 | 每日 |

---

## 📄 Frontmatter 规范

### 目标页面通用模板

**必填字段**，缺少任何字段都是错误：

```yaml
---
title: 2026 年健身目标
type: goal                    # ✅ 必填：principle/vision/goal/area/project/action
floor: 3F                     # ✅ 必填：楼层标识（5F/4F/3F/2F/1F/地面）
status: active                # ✅ 必填：active/completed/paused/abandoned
priority: high                # ✅ 必填：high/medium/low
category: Personal            # ✅ 必填：Personal/Professional/Relationships/Finance/Health
date_created: 2026-04-05      # ✅ 必填：创建日期
date_target: 2026-12-31       # ⚠️ 可选：目标日期（3F/1F 必填）
date_review: 2026-04-12       # ⚠️ 可选：回顾日期
aligned_above: [[Life-Vision-2030]]  # ⚠️ 可选：对齐上层（下楼→上楼必填）
aligned_below: [[2026-Q1-Fitness]]   # ⚠️ 可选：支撑下层（上楼→下楼必填）
tags: [健身，健康，2026]
related: [[health-sleep-pattern]]
---
```

### 各楼层特殊字段

#### 5F 原则/价值
```yaml
type: principle
floor: 5F
category: Personal  # 或 Professional/Relationships
```

#### 4F 愿景
```yaml
type: vision
floor: 4F
date_target: 2030-12-31  # 必填：愿景年份
aligned_above: [[Personal-Principles]]  # 必填：对齐原则
```

#### 3F 目标
```yaml
type: goal
floor: 3F
date_target: 2026-12-31  # 必填：目标年份
aligned_above: [[Life-Vision-2030]]  # 必填：对齐愿景
```

#### 2F 责任领域
```yaml
type: area
floor: 2F
status: active  # 领域永远 active
metrics:  # 可选：关键指标
  - name: 体脂率
    target: 18%
    current: 20%
    unit: "%"
```

#### 1F 项目
```yaml
type: project
floor: 1F
date_target: 2026-03-31  # 必填：项目结束日期
aligned_above: [[2026-Fitness-Goal]]  # 必填：对齐目标
key_results:  # 可选：关键结果（OKR 风格）
  - text: 每周健身 3 次
    target: 36
    current: 12
    unit: 次
```

#### 地面行动
```yaml
type: action
floor: 地面
date_target: 2026-04-05  # 必填：今天/本周
aligned_above: [[2026-Q1-Fitness]]  # 必填：对齐项目
```

---

## 🔗 楼层对齐规则

### 核心原则

1. **自下而上支撑**：地面行动 → 支撑项目 → 支撑目标 → 支撑愿景 → 支撑原则
2. **自上而下对齐**：愿景指导目标，目标指导项目，项目指导行动
3. **跨楼层引用**：使用 `aligned_above` 和 `aligned_below` 建立连接

### 对齐链示例

```
5F 原则：[[Personal-Principles]]
    ↑ aligned_below
4F 愿景：[[Life-Vision-2030]]
    ↑ aligned_below
3F 目标：[[2026-Fitness-Goal]]
    ↑ aligned_below
1F 项目：[[2026-Q1-Fitness]]
    ↑ aligned_below
地面：[[2026-04-05-Daily]]
```

### LLM 必须遵守的规则

**创建目标页面时**：
1. ✅ 确认楼层（用户说"设定目标"→3F，"启动项目"→1F）
2. ✅ 询问对齐："这个目标对齐哪个上层愿景/原则？"
3. ✅ 填写 `aligned_above` 字段
4. ✅ 存放到对应楼层目录

**更新目标页面时**：
1. ✅ 检查 `aligned_above` 是否仍然有效
2. ✅ 如有下层页面，更新 `aligned_below`
3. ✅ 标记状态变更（active→completed/paused）

**周回顾时**：
1. ✅ 读取 `wiki/goals/2f-areas/` 所有责任领域
2. ✅ 检查每个领域的 `1f-projects/` 项目进度
3. ✅ 更新 `aligned_below` 关联的行动
4. ✅ 标记延期风险

---

## ⚙️ LLM 工作流

### 工作流 1：设定季度目标（3F）

**触发**：用户说"设定 Q1 目标"或"制定季度 OKR"

**LLM 执行**：
```
1. 引导用户确定生活分类（Personal/Professional/Relationships）
2. 每个分类设定 2-3 个 Objectives
3. 为每个 Objective 设定 2-3 个 Key Results
4. 创建 wiki/goals/3f-goals/goal-[主题].md
5. 填写 Frontmatter（包含 aligned_above）
6. 添加到 wiki/index.md
7. 设置周回顾提醒
```

### 工作流 2：启动项目（1F）

**触发**：用户说"启动一个新项目"

**LLM 执行**：
```
1. 询问对齐的目标（3F）
2. 创建 wiki/goals/1f-projects/project-[主题].md
3. 填写 Frontmatter（包含 aligned_above）
4. 建议下一步行动（地面）
5. 更新 aligned_below 关联
```

### 工作流 3：周回顾

**触发**：用户说"周回顾"

**LLM 执行**：
```
1. 读取 wiki/goals/2f-areas/ 所有责任领域
2. 检查每个领域的 1f-projects 进度
3. 更新 aligned_below 关联的行动
4. 标记延期风险（🟢正常 🟡注意 🔴警告）
5. 建议调整
6. 追加到 wiki/log.md
```

---

## 📊 Dataview 查询示例

### 查看某目标下的所有项目

````markdown
```dataview
LIST
FROM "wiki/goals/1f-projects"
WHERE aligned_above = [[2026-Fitness-Goal]]
AND status = "active"
SORT priority DESC
```
````

### 查看未对齐愿景的目标

````markdown
```dataview
LIST
FROM "wiki/goals/3f-goals"
WHERE aligned_above = null
```
````

### 查看本周到期的项目

````markdown
```dataview
TABLE date_target, priority, status
FROM "wiki/goals/1f-projects"
WHERE date_target <= date(this.week)
AND status = "active"
SORT date_target ASC
```
````

### 楼层进度总览

````markdown
```dataview
TABLE WITHOUT ID
  floor AS "楼层",
  count(file) AS "页面数",
  round(sum(status = "active") / count(file) * 100) AS "活跃%"
FROM "wiki/goals"
GROUP BY floor
```
````

---

## 🔄 与 LLM Wiki 工作流整合

### Ingest（摄入）

**当摄入源文档与目标相关时**：
1. 识别源文档中的目标/项目信息
2. 创建/更新对应楼层页面
3. 填写 Frontmatter（包含 aligned_above）
4. 更新 wiki/index.md

### Query（查询）

**当用户查询目标时**：
1. 读取对应楼层目录
2. 显示完整的楼层对齐链
3. 提供进度统计
4. 建议调整

### Lint（健康检查）

**定期检查目标页面**：
1. 验证楼层对齐是否完整
2. 检查过期目标（date_target < today）
3. 发现孤立页面（无 aligned_above 且无 aligned_below）
4. 建议合并/归档

---

## 📈 最佳实践

### ✅ 应该做的

- [ ] 创建目标时必填 `aligned_above`
- [ ] 每季度回顾时检查对齐链
- [ ] 使用 Dataview 自动生成进度看板
- [ ] 周回顾时更新 `aligned_below`
- [ ] 标记状态变更（active→completed）

### ❌ 不应该做的

- [ ] 创建无对齐的目标（孤立页面）
- [ ] 忘记更新 `date_review`
- [ ] 混合楼层类型（如 principle 类型存到 3f-goals/）
- [ ] 删除页面（如需要，标记为 abandoned）

---

## 📚 示例页面

### 示例 1:5F 原则

```markdown
---
title: 个人宪法
type: principle
floor: 5F
category: Personal
date_created: 2026-04-05
tags: [原则，价值，宪法]
---

# 个人宪法

## 核心价值观
1. 诚信
2. 成长
3. 家庭第一

## 人生原则
- 要事第一
- 双赢思维
```

### 示例 2:4F 愿景

```markdown
---
title: 2030 年人生愿景
type: vision
floor: 4F
date_target: 2030-12-31
aligned_above: [[Personal-Principles]]
category: Personal
---

# 2030 年人生愿景

## 事业愿景
- 成为 AI 领域专家
- 出版技术书籍

## 健康愿景
- 保持体脂率 15-18%
```

### 示例 3:3F 目标

```markdown
---
title: 2026 年健身目标
type: goal
floor: 3F
date_target: 2026-12-31
aligned_above: [[Life-Vision-2030#健康愿景]]
priority: high
---

# 2026 年健身目标

## 关键结果
- 每周健身 3 次（36/36 次）
- 体脂率降到 18%（20% → 18%）
```

---

## 🔄 演进记录

| 版本 | 日期 | 变更 | 原因 |
|------|------|------|------|
| 1.0 | 2026-04-05 | 初始版本 | 用户提出需求 |

---

## 🔗 相关文档

- **AGENTS.md**: 主 Schema 文件，包含本规范索引
- **wiki/index.md**: Wiki 主目录
- **wiki/log.md**: 活动日志

---

> **LLM 注意**：本规范是目标管理的唯一依据。处理目标相关页面时，必须遵守本规范的所有规则。如有不确定，优先遵循本规范而非用户临时指示。
