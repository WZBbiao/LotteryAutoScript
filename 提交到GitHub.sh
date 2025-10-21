#!/bin/bash

echo "========== 提交代码到 GitHub =========="
echo ""

cd /Users/wangzhenbiao/Downloads/LotteryAutoScript-main

# 1. 初始化 Git 仓库（如果还没有）
if [ ! -d ".git" ]; then
    echo "📦 初始化 Git 仓库..."
    git init
    echo ""
fi

# 2. 设置远程仓库
echo "🔗 配置远程仓库..."
git remote remove origin 2>/dev/null || true
git remote add origin https://github.com/WZBbiao/LotteryAutoScript.git
echo ""

# 3. 配置 Git 用户信息（如果还没有配置）
if [ -z "$(git config user.name)" ]; then
    echo "👤 请输入你的 GitHub 用户名："
    read username
    git config user.name "$username"
fi

if [ -z "$(git config user.email)" ]; then
    echo "📧 请输入你的 GitHub 邮箱："
    read email
    git config user.email "$email"
fi

echo ""
echo "📋 当前修改的文件："
git status --short
echo ""

# 4. 添加所有文件
echo "➕ 添加所有文件..."
git add .
echo ""

# 5. 提交修改
echo "💾 提交修改..."
git commit -m "添加 GitHub Actions 自动化配置和飞书推送支持

- 新增 GitHub Actions workflow 配置
- 集成飞书推送功能
- 添加详细的配置指南文档
- 优化定时任务设置"
echo ""

# 6. 获取远程分支
echo "🔄 获取远程分支信息..."
git fetch origin main 2>/dev/null || git fetch origin master 2>/dev/null || true
echo ""

# 7. 推送到 GitHub
echo "🚀 推送到 GitHub..."
echo "⚠️  如果提示输入用户名密码，请使用 Personal Access Token 作为密码"
echo ""

# 尝试推送到 main 分支
if git push -u origin main 2>/dev/null; then
    echo ""
    echo "✅ 成功推送到 main 分支！"
elif git push -u origin master 2>/dev/null; then
    echo ""
    echo "✅ 成功推送到 master 分支！"
else
    echo ""
    echo "❌ 推送失败！"
    echo ""
    echo "请检查："
    echo "1. GitHub Personal Access Token 是否正确"
    echo "2. 仓库地址是否正确"
    echo "3. 是否有推送权限"
    echo ""
    echo "💡 如果需要创建 Personal Access Token："
    echo "   访问：https://github.com/settings/tokens"
    echo "   点击 'Generate new token (classic)'"
    echo "   勾选 'repo' 权限"
    exit 1
fi

echo ""
echo "========== 完成！=========="
echo ""
echo "📍 下一步操作："
echo "1. 访问：https://github.com/WZBbiao/LotteryAutoScript/actions"
echo "2. 启用 GitHub Actions"
echo "3. 添加 Secrets（Cookie、飞书 Webhook 等）"
echo "4. 手动运行测试"
echo ""
echo "📚 详细说明请查看：GitHub-Actions-配置指南.md"
