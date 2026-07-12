#!/bin/bash
# new-client.sh — 从当前模板初始化新客户项目
# 用法: ./new-client.sh <client-name> <github-repo-name>
# 示例: ./new-client.sh "Trattoria Milano" trattoria-milano

set -e

CLIENT_NAME="$1"
REPO_NAME="$2"

if [ -z "$CLIENT_NAME" ] || [ -z "$REPO_NAME" ]; then
  echo "用法: ./new-client.sh <客户名> <GitHub仓库名>"
  echo "示例: ./new-client.sh \"Trattoria Milano\" trattoria-milano"
  exit 1
fi

TEMPLATE_DIR="$(cd "$(dirname "$0")" && pwd)"
PARENT_DIR="$(dirname "$TEMPLATE_DIR")"
NEW_DIR="$PARENT_DIR/$REPO_NAME"

echo "=== 新客户: $CLIENT_NAME ==="
echo "模板: $TEMPLATE_DIR"
echo "目标: $NEW_DIR"

# Step 1: 创建目录，从模板仓库的 master 分支拿 index.html
mkdir -p "$NEW_DIR"
cd "$NEW_DIR"
git init
git --work-tree=. --git-dir="$TEMPLATE_DIR/.git" checkout master -- index.html
cp "$TEMPLATE_DIR/CLAUDE.md" .
cp "$TEMPLATE_DIR/DESIGN.md" .

# Step 2: 初始提交
git add index.html CLAUDE.md DESIGN.md
git commit -m "模板初始化：基于 Bistro Bellini 设计系统"

# Step 3: 创建 GitHub 远程仓库并推送
gh repo create "$REPO_NAME" --public --description "$CLIENT_NAME — 餐厅官网" --source . --remote origin --push 2>/dev/null || {
  echo "GitHub 仓库创建失败，手动执行:"
  echo "  gh repo create $REPO_NAME --public --source . --remote origin --push"
}

# Step 4: 创建开发分支
git switch -c "client/$(echo "$REPO_NAME" | tr '-' '-')-v1"

echo ""
echo "=== 完成 ==="
echo "目录: $NEW_DIR"
echo "分支: client/$REPO_NAME-v1"
echo ""
echo "下一步：告诉我客户的具体信息，我会直接改配色/字体/内容/图片。"
echo "格式: 新客户 [名称]，[菜系类型]，[配色方向]，[字体偏好]，[照片风格]"
