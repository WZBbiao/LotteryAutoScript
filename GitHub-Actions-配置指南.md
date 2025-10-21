# GitHub Actions 配置指南

## ✅ 已完成的工作

我已经为你创建了 GitHub Actions 的配置文件：[.github/workflows/lottery.yml](.github/workflows/lottery.yml)

### 📅 自动运行时间表

| 任务 | 运行时间（北京时间） | 说明 |
|-----|-------------------|------|
| 🎰 启动抽奖 | 每天 08:00 | 自动参与抽奖活动 |
| 🎁 检查中奖 | 每天 20:00 | 检查是否中奖，并推送通知 |
| 🧹 清理动态 | 手动触发 | 清理过期的动态和关注 |

---

## 🚀 配置步骤（3步完成）

### 步骤 1：提交配置文件到 GitHub

在本地终端执行以下命令：

```bash
cd /Users/wangzhenbiao/Downloads/LotteryAutoScript-main

# 添加所有修改（包括飞书推送功能）
git add .

# 提交修改
git commit -m "添加 GitHub Actions 自动化配置和飞书推送支持"

# 推送到你的 GitHub 仓库
git push origin main
```

如果遇到权限问题，需要先配置 Git 远程仓库：

```bash
# 设置远程仓库地址
git remote set-url origin https://github.com/WZBbiao/LotteryAutoScript.git

# 或者使用 SSH（需要先配置 SSH Key）
git remote set-url origin git@github.com:WZBbiao/LotteryAutoScript.git
```

---

### 步骤 2：添加 GitHub Secrets（重要！）

#### 2.1 打开 Secrets 设置页面

访问：https://github.com/WZBbiao/LotteryAutoScript/settings/secrets/actions

或者：
1. 打开你的仓库 https://github.com/WZBbiao/LotteryAutoScript
2. 点击 `Settings`（设置）
3. 左侧菜单找到 `Secrets and variables` → `Actions`
4. 点击 `New repository secret`（新建仓库密钥）

#### 2.2 添加必需的 Secrets

点击 `New repository secret` 按钮，依次添加以下密钥：

##### ⭐ 必填项

| Name | Value | 说明 |
|------|-------|------|
| `COOKIE` | 你的B站Cookie | 从浏览器获取的完整Cookie |

##### 🔔 推送通知（至少选一个）

| Name | Value | 说明 |
|------|-------|------|
| `FEISHU_WEBHOOK` | `https://open.feishu.cn/open-apis/bot/v2/hook/080c9bea-f498-4695-a9f2-f85b2d2a98c5` | 你的飞书 Webhook 地址 |
| `SENDKEY` | 你的SendKey | Server酱 Turbo版 推送 |
| `TG_BOT_TOKEN` | Bot Token | Telegram 推送 |
| `TG_USER_ID` | User ID | Telegram 推送 |

##### 🤖 AI评论（可选）

| Name | Value | 说明 |
|------|-------|------|
| `AI_API_KEY` | API Key | OpenAI 或其他兼容 API 的密钥 |

#### 2.3 如何获取 B站 Cookie

**方法一：使用浏览器（推荐）**

1. 打开浏览器，访问 https://www.bilibili.com
2. 登录你的账号
3. 按 `F12` 打开开发者工具
4. 点击 `Network`（网络）标签
5. 刷新页面 `F5`
6. 在网络请求中找到任意一个 `bilibili.com` 的请求
7. 点击该请求，找到 `Request Headers`（请求头）
8. 复制 `Cookie` 字段的完整内容

**Cookie 应该包含以下关键字段：**
```
DedeUserID=...; SESSDATA=...; bili_jct=...; buvid3=...
```

**方法二：使用控制台脚本**

1. 按 `F12` 打开控制台
2. 切换到 `Application` 标签
3. 展开 `Cookies` → `https://www.bilibili.com`
4. 找到 `SESSDATA`，取消勾选 `HttpOnly`
5. 切换到 `Console` 标签，粘贴以下代码：

```javascript
document.cookie.split(/\s*;\s*/)
  .map(it => it.split('='))
  .filter(it => ['DedeUserID','bili_jct','SESSDATA','buvid3'].includes(it[0]))
  .map(it => it.join('='))
  .join('; ')
  .split()
  .forEach(it => copy(it) || console.log(it))
```

6. Cookie 已自动复制到剪贴板

---

### 步骤 3：启用 GitHub Actions

#### 3.1 访问 Actions 页面

打开：https://github.com/WZBbiao/LotteryAutoScript/actions

#### 3.2 启用 Workflows

如果看到提示 "Workflows aren't being run on this forked repository"，点击绿色按钮：
```
I understand my workflows, go ahead and enable them
```

#### 3.3 手动测试运行（推荐）

1. 点击左侧的 `B站抽奖自动脚本`
2. 点击右侧的 `Run workflow` 下拉菜单
3. 选择运行模式：
   - `start` - 启动抽奖
   - `check` - 检查中奖
   - `clear` - 清理动态
4. 点击绿色的 `Run workflow` 按钮

#### 3.4 查看运行日志

1. 点击正在运行的 workflow
2. 点击对应的 job（如 "启动抽奖"）
3. 展开各个步骤查看详细日志
4. 如果有错误，日志会显示具体原因

---

## 📊 运行状态说明

### 成功标志

- ✅ 绿色对勾：运行成功
- 📱 飞书收到推送：配置正确
- 📋 可以下载运行日志：点击 Artifacts

### 常见问题

#### ❌ Cookie 失效

**错误信息：** `Cookie已失效`

**解决方案：**
1. 重新获取 Cookie
2. 更新 GitHub Secrets 中的 `COOKIE`

#### ❌ 推送失败

**错误信息：** `飞书机器人发送失败`

**解决方案：**
1. 检查 `FEISHU_WEBHOOK` 是否正确
2. 确认飞书机器人未被禁用
3. 测试 Webhook 是否可访问

#### ⚠️ Actions 未运行

**原因：**
1. Fork 的仓库默认禁用 Actions
2. 需要手动启用

**解决方案：**
访问 Actions 页面，点击启用按钮

---

## 🎯 定时任务说明

### 当前配置

```yaml
schedule:
  # 每天北京时间 8:00 运行抽奖
  - cron: '0 0 * * *'
  # 每天北京时间 20:00 检查中奖
  - cron: '0 12 * * *'
```

### 自定义时间

如果想修改运行时间，编辑 [.github/workflows/lottery.yml](.github/workflows/lottery.yml) 文件：

**Cron 表达式说明：**

```
┌───────────── 分钟 (0 - 59)
│ ┌───────────── 小时 (0 - 23)
│ │ ┌───────────── 日期 (1 - 31)
│ │ │ ┌───────────── 月份 (1 - 12)
│ │ │ │ ┌───────────── 星期 (0 - 6) (周日 = 0)
│ │ │ │ │
* * * * *
```

**常用时间配置：**

| 时间（北京） | Cron 表达式 | 说明 |
|------------|------------|------|
| 每天 8:00 | `0 0 * * *` | UTC 0:00 |
| 每天 12:00 | `0 4 * * *` | UTC 4:00 |
| 每天 20:00 | `0 12 * * *` | UTC 12:00 |
| 每 6 小时 | `0 */6 * * *` | 0, 6, 12, 18 点 |
| 每周一 8:00 | `0 0 * * 1` | 每周一运行 |

**注意：** GitHub Actions 使用 UTC 时间，北京时间需要 **减 8 小时**

---

## 🔍 监控和维护

### 查看运行历史

访问：https://github.com/WZBbiao/LotteryAutoScript/actions

可以看到：
- ✅ 成功运行的次数
- ❌ 失败的次数
- ⏱️ 运行时长
- 📊 运行趋势

### 下载运行日志

1. 打开成功运行的 workflow
2. 下拉到底部 `Artifacts` 区域
3. 点击 `lottery-logs-xxx` 下载日志

### 接收通知

配置了飞书推送后，以下情况会收到通知：
- 🎁 检测到中奖
- ⚠️ 运行出错
- 📊 运行状态报告（如果启用）

---

## 🛠️ 高级配置

### 多账号支持

如果需要多个 B站 账号，可以：

1. 添加更多 Secrets：
   - `COOKIE_2`
   - `COOKIE_3`

2. 修改 workflow 文件，添加多账号逻辑

3. 或者创建多个 workflow 文件

### AI 评论

如果想启用 AI 自动评论：

1. 添加 Secret：`AI_API_KEY`
2. 修改 `env.js` 中的 `ENABLE_AI_COMMENTS: true`
3. 配置 `my_config.js` 中的 AI 参数

---

## 📚 相关文档

- [GitHub Actions 官方文档](https://docs.github.com/actions)
- [Cron 表达式生成器](https://crontab.guru/)
- [项目 README](README.md)
- [部署指南](部署指南.md)

---

## ❓ 常见问题 FAQ

### Q: Actions 消耗我的免费额度吗？

A: GitHub 为公开仓库提供**无限免费**的 Actions 使用时间。私有仓库每月有 2000 分钟免费额度。

### Q: 为什么要等到第二天才运行？

A: 首次配置后，需���等待下一个定时任务触发时间。你可以使用 "Run workflow" 手动触发立即测试。

### Q: Cookie 多久需要更新一次？

A: 通常几个月到半年。如果在 B站 网页端点击退出，Cookie 会立即失效。

### Q: 可以同时使用多种推送方式吗？

A: 可以！所有配置的推送方式会并发执行，提高通知到达率。

### Q: 运行失败会怎样？

A: 不会影响下次定时运行。你可以查看日志了解失败原因，修复后继续使用。

---

## 🎉 完成！

按照以上步骤操作后，你的 B站 抽奖脚本就会：

- ✅ 每天自动运行
- ✅ 自动检查中奖
- ✅ 推送通知到飞书
- ✅ 无需本地电脑开机
- ✅ 完全免费

祝你抽奖好运！🍀
