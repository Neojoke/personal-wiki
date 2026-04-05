# 🚀 推送到 GitHub 指南

## 方式 1：使用 GitHub CLI（推荐）

```bash
# 1. 登录 GitHub
gh auth login

# 选择：
# - GitHub.com
# - HTTPS
# - Login with a web browser
# 按提示完成登录

# 2. 创建并推送仓库
cd ~/.openclaw/workspace/llm-wiki
gh repo create llm-wiki --public --source=. --push
```

---

## 方式 2：手动创建

### Step 1: 在 GitHub 创建仓库

1. 访问 https://github.com/new
2. 仓库名：`llm-wiki`
3. 公开仓库（Public）
4. **不要**初始化 README/.gitignore
5. 点击 "Create repository"

### Step 2: 推送代码

```bash
cd ~/.openclaw/workspace/llm-wiki

# 添加远程仓库（替换 YOUR_USERNAME 为你的 GitHub 用户名）
git remote add origin https://github.com/YOUR_USERNAME/llm-wiki.git

# 推送
git branch -M main
git push -u origin main
```

---

## 验证推送

访问 `https://github.com/YOUR_USERNAME/llm-wiki` 确认文件已上传。

---

## 后续同步

```bash
# 日常推送
cd ~/.openclaw/workspace/llm-wiki
git add .
git commit -m "描述你的更改"
git push
```
