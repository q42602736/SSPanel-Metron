<?php

namespace App\Command;

class Tool extends Command
{
    public $description = ''
        . '├─=: php xcat Tool [选项]' . PHP_EOL
        . '│ ├─ initQQWry               - 下载 IP 解析库' . PHP_EOL
        . '│ ├─ setTelegram             - 设置 Telegram 机器人' . PHP_EOL
        . '│ ├─ detectConfigs           - 检查数据库内新增的配置' . PHP_EOL
        . '│ ├─ initdocuments           - 下载用户使用文档至服务器' . PHP_EOL;

    public function boot()
    {
        if (count($this->argv) === 2) {
            echo $this->description;
        } else {
            $methodName = $this->argv[2];
            if (method_exists($this, $methodName)) {
                $this->$methodName();
            } else {
                echo '方法不存在.' . PHP_EOL;
            }
        }
    }

    /**
     * 设定 Telegram Bot
     *
     * @return void
     */
    public function setTelegram()
    {
        if ($_ENV['use_new_telegram_bot'] === true) {
            $WebhookUrl = ($_ENV['baseUrl'] . '/telegram_callback?token=' . $_ENV['telegram_request_token']);
            $telegram = new \Telegram\Bot\Api($_ENV['telegram_token']);
            $telegram->removeWebhook();
            if ($telegram->setWebhook(['url' => $WebhookUrl])) {
                echo ('New Bot @' . $telegram->getMe()->getUsername() . ' 设置成功！');
            }
        } else {
            $bot = new \TelegramBot\Api\BotApi($_ENV['telegram_token']);
            $ch = curl_init();
            curl_setopt($ch, CURLOPT_URL, sprintf('https://api.telegram.org/bot%s/deleteWebhook', $_ENV['telegram_token']));
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
            curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 5);
            $deleteWebhookReturn = json_decode(curl_exec($ch));
            curl_close($ch);
            if ($deleteWebhookReturn->ok && $deleteWebhookReturn->result && $bot->setWebhook($_ENV['baseUrl'] . '/telegram_callback?token=' . $_ENV['telegram_request_token']) == 1) {
                echo ('Old Bot 设置成功！' . PHP_EOL);
            }
        }
    }

    /**
     * 下载使用文档
     *
     * @return void
     */
    public function initdocuments()
    {
        system('git clone https://github.com/GeekQuerxy/PANEL_DOC.git ' . BASE_PATH . "/public/docs/", $ret);
        echo $ret;
    }

    /**
     * 下载 IP 库
     *
     * @return void
     */
    public function initQQWry()
    {
        echo ('开始下载纯真 IP 数据库（IPDB 格式，支持 IPv4/IPv6）....' . PHP_EOL);
        
        // 多个下载源，按顺序尝试
        $urls = [
            'https://raw.githubusercontent.com/nmgliangwei/qqwry.ipdb/main/qqwry.ipdb',
            'https://raw.gitmirror.com/nmgliangwei/qqwry.ipdb/main/qqwry.ipdb',
            'https://ghproxy.com/https://raw.githubusercontent.com/nmgliangwei/qqwry.ipdb/main/qqwry.ipdb',
            'https://mirror.ghproxy.com/https://raw.githubusercontent.com/nmgliangwei/qqwry.ipdb/main/qqwry.ipdb'
        ];
        
        $qqwry = '';
        foreach ($urls as $url) {
            echo ('尝试从 ' . $url . ' 下载...' . PHP_EOL);
            $qqwry = @file_get_contents($url);
            if ($qqwry != '') {
                echo ('下载成功！' . PHP_EOL);
                break;
            }
        }
        
        if ($qqwry != '') {
            $fp = fopen(BASE_PATH . '/storage/qqwry.ipdb', 'wb');
            if ($fp) {
                fwrite($fp, $qqwry);
                fclose($fp);
                echo ('纯真 IP 数据库保存成功！' . PHP_EOL);
            } else {
                echo ('纯真 IP 数据库保存失败！' . PHP_EOL);
            }
        } else {
            echo ('所有下载源均失败！请检查网络连接，或手动下载：' . PHP_EOL);
            echo ('https://github.com/nmgliangwei/qqwry.ipdb/raw/main/qqwry.ipdb' . PHP_EOL);
            echo ('下载后放置到 storage/qqwry.ipdb' . PHP_EOL);
        }
    }

    /**
     * 探测新增配置
     *
     * @return void
     */
    public function detectConfigs()
    {
        echo \App\Services\DefaultConfig::detectConfigs();
    }
}
