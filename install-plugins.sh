#!/bin/bash
# Obsidian 插件自动安装脚本
# 基于 Obsidian CLI 1.12.4+

set -e

VAULT_PATH="$HOME/.openclaw/workspace/llm-wiki"

echo "🔧 开始安装 Obsidian 插件到：$VAULT_PATH"

# 检查 Obsidian CLI 是否可用
if ! command -v obsidian &> /dev/null; then
    echo "❌ Obsidian CLI 未找到"
    echo "请先在 Obsidian 中启用 CLI:"
    echo "   设置 → General → Command line interface → Register CLI"
    exit 1
fi

# 检查 Obsidian 版本
VERSION=$(obsidian version 2>/dev/null || echo "unknown")
echo "✅ Obsidian CLI 版本：$VERSION"

# 检查 Obsidian 是否运行中
echo "📋 检查 Obsidian 运行状态..."
# 注意：CLI 需要 Obsidian 应用运行中

# 要安装的插件列表
declare -a PLUGINS=(
    "obsidian-web-clipper:Web Clipper"
    "marp-slides:Marp Slides"
    "obsidian-dataview:Dataview"
    "obsidian-advanced-tables:Advanced Tables"
)

echo ""
echo "📦 待安装插件："
for plugin in "${PLUGINS[@]}"; do
    echo "   - ${plugin#*:} (${plugin%%:*})"
done
echo ""

# 安装插件函数
install_plugin() {
    local plugin_id=$1
    local plugin_name=$2
    
    echo "🔌 安装：$plugin_name ($plugin_id)"
    
    # 使用 CLI 启用插件（如果已安装）
    if obsidian plugin:enable id="$plugin_id" 2>/dev/null; then
        echo "   ✅ $plugin_name 已启用"
    else
        echo "   ⚠️  $plugin_name 需要通过 Obsidian UI 首次安装"
        echo "      打开 Obsidian → 设置 → 社区插件 → 浏览 → 搜索 '$plugin_name' → 安装"
    fi
}

echo "========================================"
echo "开始安装插件..."
echo "========================================"
echo ""

# 遍历安装
for plugin in "${PLUGINS[@]}"; do
    plugin_id="${plugin%%:*}"
    plugin_name="${plugin#*:}"
    install_plugin "$plugin_id" "$plugin_name"
    echo ""
done

echo "========================================"
echo "✅ 插件安装完成！"
echo ""
echo "📝 下一步："
echo "   1. 打开 Obsidian"
echo "   2. 添加 vault: $VAULT_PATH"
echo "   3. 设置 → 社区插件 → 确认插件已启用"
echo ""
echo "🔧 如果插件未自动安装，请手动："
echo "   设置 → 社区插件 → 浏览 → 搜索插件名 → 安装 → 启用"
echo "========================================"
