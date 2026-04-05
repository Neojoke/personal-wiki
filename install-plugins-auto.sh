#!/bin/bash
# Obsidian 插件自动安装脚本
# 无需 Obsidian CLI - 直接下载插件文件到 vault

set -e

VAULT_PATH="$HOME/.openclaw/workspace/llm-wiki"
PLUGINS_DIR="$VAULT_PATH/.obsidian/plugins"

echo "🔧 Obsidian 插件自动安装工具"
echo "========================================"
echo "目标 vault: $VAULT_PATH"
echo "插件目录：$PLUGINS_DIR"
echo ""

# 创建插件目录
mkdir -p "$PLUGINS_DIR"

# 插件配置（ID、名称、GitHub 仓库）
declare -A PLUGINS=(
    ["obsidian-web-clipper"]="Web Clipper|obsidian-web-clipper/obsidian-web-clipper"
    ["marp-slides"]="Marp Slides|phibr0/obsidian-marp-slides"
    ["obsidian-dataview"]="Dataview|blacksmithgu/obsidian-dataview"
    ["obsidian-advanced-tables"]="Advanced Tabless|tgrosinger/advanced-tables-obsidian"
)

# 下载并安装单个插件
install_plugin() {
    local plugin_id=$1
    local plugin_name=$2
    local github_repo=$3
    
    PLUGIN_DIR="$PLUGINS_DIR/$plugin_id"
    
    echo ""
    echo "📦 安装：$plugin_name"
    echo "   GitHub: $github_repo"
    
    # 如果已安装，跳过
    if [ -f "$PLUGIN_DIR/main.js" ]; then
        echo "   ✅ 已安装，跳过"
        return 0
    fi
    
    mkdir -p "$PLUGIN_DIR"
    
    # 获取最新 release 信息
    echo "   📥 获取最新版本..."
    LATEST_URL="https://api.github.com/repos/$github_repo/releases/latest"
    
    # 下载 manifest.json
    echo "   📥 下载 manifest.json..."
    curl -sL "https://github.com/$github_repo/releases/latest/download/manifest.json" \
        -o "$PLUGIN_DIR/manifest.json" || {
        echo "   ❌ 下载 manifest.json 失败"
        rm -rf "$PLUGIN_DIR"
        return 1
    }
    
    # 下载 main.js
    echo "   📥 下载 main.js..."
    curl -sL "https://github.com/$github_repo/releases/latest/download/main.js" \
        -o "$PLUGIN_DIR/main.js" || {
        echo "   ❌ 下载 main.js 失败"
        rm -rf "$PLUGIN_DIR"
        return 1
    }
    
    # 下载 styles.css (如果有)
    echo "   📥 检查 styles.css..."
    if curl -sL --head "https://github.com/$github_repo/releases/latest/download/styles.css" | grep -q "200 OK"; then
        curl -sL "https://github.com/$github_repo/releases/latest/download/styles.css" \
            -o "$PLUGIN_DIR/styles.css"
        echo "   ✅ 下载 styles.css"
    else
        echo "   ℹ️  无 styles.css"
    fi
    
    echo "   ✅ $plugin_name 安装完成"
}

# 启用插件（写入 community-plugins.json）
enable_plugin() {
    local plugin_id=$1
    
    CONFIG_FILE="$VAULT_PATH/.obsidian/community-plugins.json"
    
    # 读取现有配置或创建新文件
    if [ -f "$CONFIG_FILE" ]; then
        # 添加插件 ID（如果不存在）
        if ! grep -q "\"$plugin_id\"" "$CONFIG_FILE"; then
            # 使用 sed 添加插件
            sed -i "s/}$/,\n  \"$plugin_id\": true\n}/g" "$CONFIG_FILE"
        fi
    else
        # 创建新配置文件
        echo "{
  \"$plugin_id\": true
}" > "$CONFIG_FILE"
    fi
}

echo "开始安装插件..."
echo "========================================"

# 安装每个插件
for plugin_id in "${!PLUGINS[@]}"; do
    IFS='|' read -r name repo <<< "${PLUGINS[$plugin_id]}"
    install_plugin "$plugin_id" "$name" "$repo"
done

echo ""
echo "========================================"
echo "✅ 所有插件下载完成！"
echo ""
echo "📝 下一步："
echo "   1. 打开 Obsidian"
echo "   2. 添加 vault: $VAULT_PATH"
echo "   3. 设置 → 社区插件"
echo "   4. 关闭'限制社区插件'（如果出现提示）"
echo "   5. 启用已安装的插件"
echo ""
echo "🔧 或者使用 BRAT 插件自动安装："
echo "   1. 先安装 BRAT 插件（社区插件 → 浏览 → 搜索 BRAT）"
echo "   2. BRAT → Add plugin"
echo "   3. 输入插件 GitHub 仓库地址"
echo "========================================"
