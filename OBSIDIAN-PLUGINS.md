# Obsidian 插件安装指南

## 方法 1：通过 Obsidian UI（推荐）

1. 打开 Obsidian
2. 添加 vault：`~/.openclaw/workspace/llm-wiki`
3. 设置 → 社区插件 → 浏览
4. 搜索并安装以下插件：

| 插件名 | 用途 |
|--------|------|
| **Web Clipper** | 网页剪藏到 raw/ |
| **Marp Slides** | Markdown 生成幻灯片 |
| **Dataview** | 查询 frontmatter |
| **Advanced Tables** | 表格编辑增强 |

---

## 方法 2：手动安装（高级）

### 步骤 1：找到插件 ID

访问 https://obsidian.md/plugins 查找插件 ID：
- Web Clipper → `obsidian-web-clipper`
- Marp Slides → `marp-slides`
- Dataview → `obsidian-dataview`
- Advanced Tables → `obsidian-advanced-tables`

### 步骤 2：下载插件

每个插件需要下载 3 个文件：
- `main.js`
- `manifest.json`
- `styles.css`（如果有）

从 GitHub releases 下载，例如 Dataview：
```bash
# 创建插件目录
mkdir -p ~/.openclaw/workspace/llm-wiki/.obsidian/plugins/obsidian-dataview

# 下载文件（替换为最新 release URL）
cd ~/.openclaw/workspace/llm-wiki/.obsidian/plugins/obsidian-dataview
curl -O https://github.com/blacksmithgu/obsidian-dataview/releases/latest/download/main.js
curl -O https://github.com/blacksmithgu/obsidian-dataview/releases/latest/download/manifest.json
curl -O https://github.com/blacksmithgu/obsidian-dataview/releases/latest/download/styles.css
```

### 步骤 3：启用插件

编辑 `~/.openclaw/workspace/llm-wiki/.obsidian/community-plugins.json`：
```json
{
  "obsidian-dataview": true,
  "marp-slides": true,
  "obsidian-web-clipper": true,
  "obsidian-advanced-tables": true
}
```

### 步骤 4：重启 Obsidian

---

## 方法 3：使用 BRAT 插件（半自动）

1. 先手动安装 **BRAT** 插件
   - GitHub: https://github.com/TfTHacker/obsidian42-brat
   - 插件 ID: `obsidian42-brat`

2. 通过 BRAT 安装其他插件：
   - 打开 Obsidian
   - BRAT → Add plugin
   - 输入插件 GitHub 仓库地址

---

## 推荐：使用方法 1

最简单可靠，Obsidian 会自动处理依赖和更新。
