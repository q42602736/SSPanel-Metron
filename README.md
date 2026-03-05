## SSPanel-Metron 主题

本项目基于 [BobCoderS9/SSPanel-Metron](https://github.com/BobCoderS9/SSPanel-Metron) 开发而来，目前由 [@q42602736](https://github.com/q42602736) 维护开发。

### 📢 交流群

Telegram: [@fluentboard666](https://t.me/fluentboard666)

### ✨ 主要特性

- 支持多种代理协议（Shadowsocks、V2Ray、Trojan、Hysteria2、VLESS Reality、AnyTLS 等）
- 现代化的 Metron 主题界面
- 完善的订阅功能（支持多种客户端）
- IP 归属地查询（支持 IPv4/IPv6）
- 自动化任务管理
- 多种支付方式集成

### 🔌 后端对接

使用新协议（Hysteria2、VLESS Reality、AnyTLS）需要配合专用后端：

**V2BX-malio**: [https://github.com/q42602736/V2BX-malio](https://github.com/q42602736/V2BX-malio)

### 🎬 流媒体解锁检测

本项目提供了强大的流媒体解锁检测脚本 `media_unlock.sh`，支持自动检测节点的流媒体解锁状态并上传到面板。

#### 支持的流媒体平台

- ✅ Netflix
- ✅ Disney+
- ✅ YouTube Premium
- ✅ Discovery+
- ✅ Paramount+
- ✅ Bahamut Anime（巴哈姆特动画疯）
- ✅ OpenAI (ChatGPT)
- ✅ Google Gemini
- ✅ TikTok

#### 主要特性

- 🔍 支持 DNS 解锁配置（可为每个流媒体服务指定解锁 DNS）
- 📊 自动上传检测结果到面板节点信息
- ⏰ 支持定时任务自动检测
- 📝 详细的日志记录
- 🔄 数据验证和重试机制

#### 快速安装

在节点服务器上执行以下命令：

```bash
wget https://raw.githubusercontent.com/q42602736/SSPanel-Metron/master/media_unlock.sh -O media_unlock.sh && chmod +x media_unlock.sh && ./media_unlock.sh
```

#### 配置说明

首次运行时，脚本会提示输入以下信息：

1. **面板地址**：你的 SSPanel-Metron 面板地址（例如：https://demo.sspanel.org）
2. **mu_key**：面板后台的 mu_key（在面板后台 - 节点管理中查看）
3. **节点 ID**：要检测的节点 ID

配置完成后，脚本会自动保存配置到 `/root/.media_unlock.config`

#### DNS 解锁配置（可选）

如果你的节点使用 DNS 解锁方式，首次运行时脚本会提示配置每个流媒体服务的解锁 DNS 服务器地址。

支持的格式：
- IPv4 地址（例如：1.1.1.1）
- DNS 服务器域名（例如：dns.example.com）
- 直接回车使用系统默认 DNS

#### 定时任务配置

脚本支持自动配置定时任务，可选择以下检测频率：
- 每 1 小时
- 每 2 小时
- 每 3 小时
- 每 4 小时
- 每 6 小时
- 每 8 小时
- 每 12 小时
- 每 24 小时

#### 后续运行

配置完成后，可以使用以下命令跳过配置直接运行：

```bash
./media_unlock.sh -S
```

#### 查看日志

```bash
tail -f /root/media_unlock.log
```

#### 配置文件位置

- 主配置文件：`/root/.media_unlock.config`
- DNS 配置文件：`/root/.unlock_config`
- 日志文件：`/root/media_unlock.log`

#### 删除配置

如需重新配置，可删除配置文件：

```bash
rm -f /root/.media_unlock.config /root/.unlock_config
```

### 📝 新协议节点配置示例

在面板后台添加节点时，`节点地址` 字段填写格式如下：

#### Hysteria2 (Sort=17)
```
example.com;port=443&up_mbps=100&down_mbps=100&obfs=salamander&obfs_password=yourpassword&allow_insecure=1
```

#### VLESS Reality (Sort=16)
```
example.com;443;0;tcp;;security=reality|privateKey=your_private_key|publicKey=your_public_key|shortId=0123456789abcdef|serverName=www.amazon.com|fp=chrome|flow=xtls-rprx-vision
```

#### AnyTLS (Sort=18)
```
example.com;port=443&server_name=example.com&insecure=1
```

详细配置说明请查看：[新协议配置指南](docs/NEW_PROTOCOLS.md)

---

#### 1.连接 SSH 安装宝塔面板

#### 2.宝塔面板安装环境, 推荐使用 PHP 7.4、MySQL 5.7、Nginx 1.2+

#### 3.宝塔面板创建网站, 域名等信息自行填写

#### 4.连接 SSH 下载源码

`cd /www/wwwroot/你的网站文件夹名`

#### 5.使用composer安装依赖


```shell
wget https://getcomposer.org/installer -O composer-setup.php
php composer-setup.php
composer install --ignore-platform-reqs
```


#### 6.复制配置文件

```shell

cp config/.config.example.php config/.config.php

cp config/.metron_setting.example.php config/.metron_setting.php

cp config/appprofile.example.php config/appprofile.php
```

.config.php设置后执行`php xcat Tool initQQWry` 下载IP解析库

#### 8.网站设置

打开 宝塔面版 > 网站 > 你的网站


    在 网站目录 里取消勾选 防跨站攻击，运行目录里面选择 /public，点击保存。

在 伪静态 中填入下面内容，然后保存


```shell
location / {
try_files $uri /index.php$is_args$args;
}
```

#### 9.在SSH里的网站目录下执行，给网站文件755权限

```shell
cd ../
chmod -R 755 你的文件夹名/
chown -R www:www 你的文件夹名/
```

#### 10.数据库操作

首次迁移: 导入网站目录下的`sql/glzjin_all.sql` 文件

将数据库user表里的全部用户的theme列改为metron，使用phpmyadmin执行这条sql语句:
```sql
UPDATE user SET theme='metron'
```

#### 11.初始化配置项

在导入数据库后，执行以下命令初始化所有配置项（包括注册设置等）：

```shell
php xcat Tool detectConfigs
```

### 使用宝塔面板的计划任务配置
```
每日任务 (必须)
任务类型：Shell 脚本
任务名称：自行填写
执行周期：每天 0 小时 0 分钟
脚本内容：php /www/wwwroot/你的网站目录/xcat Job DailyJob

检测任务 (必须)
任务类型：Shell 脚本
任务名称：自行填写
执行周期：N分钟 1 分钟
脚本内容：php /www/wwwroot/你的网站目录/xcat Job CheckJob

用户账户相关任务 (必须)
任务类型：Shell 脚本
任务名称：自行填写
执行周期：每小时
脚本内容：php /www/wwwroot/你的网站目录/xcat Job UserJob

检查用户会员等级过期任务 (必须)
任务类型：Shell 脚本
任务名称：自行填写
执行周期：每分钟
脚本内容：php /www/wwwroot/你的网站目录/xcat Job CheckUserClassExpire

检查账号过期任务 (必须)
任务类型：Shell 脚本
任务名称：自行填写
执行周期：每小时
脚本内容：php /www/wwwroot/你的网站目录/xcat Job CheckUserExpire

定时检测邮件队列 (必须)
任务类型：Shell 脚本
任务名称：自行填写
执行周期：N分钟 1 分钟
脚本内容：php /www/wwwroot/你的网站目录/xcat Job SendMail

每日流量报告 (给开启每日邮件的用户发送邮件)
任务类型：Shell 脚本
任务名称：自行填写
执行周期：每天 0 小时 0 分钟
脚本内容：php /www/wwwroot/你的网站目录/xcat SendDiaryMail

审计封禁 (建议设置)
任务类型：Shell 脚本
任务名称：自行填写
执行周期：N分钟 1 分钟
脚本内容：php /www/wwwroot/你的网站目录/xcat DetectBan

检测节点被墙 (可选)
任务类型：Shell 脚本
任务名称：自行填写
执行周期：N分钟 1 分钟
脚本内容：php /www/wwwroot/你的网站目录/xcat DetectGFW

检测中转服务器 (可选)
任务类型：Shell 脚本
任务名称：自行填写
执行周期：N分钟 5 分钟
脚本内容：php /www/wwwroot/你的网站目录/xcat DetectTransfer

Radius (可选)
synclogin
任务类型：Shell 脚本
任务名称：自行填写
执行周期：N分钟 1 分钟
脚本内容：php /www/wwwroot/你的网站目录/xcat SyncRadius synclogin

syncvpn
任务类型：Shell 脚本
任务名称：自行填写
执行周期：N分钟 1 分钟
脚本内容：php /www/wwwroot/你的网站目录/xcat SyncRadius syncvpn

syncnas
任务类型：Shell 脚本
任务名称：自行填写
执行周期：N分钟 1 分钟
脚本内容：php /www/wwwroot/你的网站目录/xcat SyncRadius syncnas
自动备份 (可选)

整体备份
任务类型：Shell 脚本
任务名称：自行填写
执行周期：自己设置, 可以设置每30分钟左右
脚本内容：php /www/wwwroot/你的网站目录/xcat Backup full

只备份核心数据
任务类型：Shell 脚本
任务名称：自行填写
执行周期：自己设置, 可以设置每30分钟左右
脚本内容：php /www/wwwroot/你的网站目录/xcat Backup simple
财务报表 (可选)

日报
任务类型：Shell 脚本
任务名称：自行填写
执行周期：每天 0 小时 0 分钟
脚本内容：php /www/wwwroot/你的网站目录/xcat FinanceMail day

周报
任务类型：Shell 脚本
任务名称：自行填写
执行周期：每星期 周日 0 小时 0 分钟
脚本内容：php /www/wwwroot/你的网站目录/xcat FinanceMail week

月报
任务类型：Shell 脚本
任务名称：自行填写
执行周期：每月 1 日 0 小时 0 分钟
脚本内容：php /www/wwwroot/你的网站目录/xcat FinanceMail month
```
