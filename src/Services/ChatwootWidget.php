<?php

namespace App\Services;

class ChatwootWidget
{
    public static function getLauncherConfig()
    {
        $mode = self::normalizeLauncherMode(self::getMetronSetting('chatwoot_launcher_mode', 'official'));
        $config = [
            'ret' => 1,
            'enabled' => self::getMetronSetting('enable_cust', 'none') === 'chatwoot',
            'mode' => $mode,
            'avatar_url' => '',
            'name' => '',
            'msg' => 'ok'
        ];

        if ($config['enabled'] !== true) {
            $config['ret'] = 0;
            $config['msg'] = '未启用 Chatwoot';
            return $config;
        }

        if ($mode !== 'custom_avatar') {
            return $config;
        }

        $baseUrl = rtrim(trim((string) self::getMetronSetting('chatwoot_base_url', '')), '/');
        $websiteToken = trim((string) self::getMetronSetting('chatwoot_website_token', ''));
        $accountId = trim((string) self::getMetronSetting('chatwoot_account_id', ''));
        $apiAccessToken = trim((string) self::getMetronSetting('chatwoot_api_access_token', ''));

        if ($baseUrl === '' || $websiteToken === '' || $accountId === '' || $apiAccessToken === '') {
            $config['msg'] = 'Chatwoot 自定义头像模式缺少必要配置';
            return $config;
        }

        $response = self::requestJson(
            $baseUrl . '/api/v1/accounts/' . rawurlencode($accountId) . '/inboxes',
            [
                'Accept: application/json',
                'api_access_token: ' . $apiAccessToken,
            ]
        );

        if ($response['ok'] !== true) {
            $config['msg'] = $response['msg'];
            return $config;
        }

        $inboxes = self::extractInboxList($response['data']);
        $matchedInbox = self::findInboxByWebsiteToken($inboxes, $websiteToken);

        if ($matchedInbox === null) {
            $config['msg'] = '未找到与 Website Token 对应的 Chatwoot Inbox';
            return $config;
        }

        $config['avatar_url'] = self::normalizeUrl($baseUrl, self::getInboxValue($matchedInbox, 'avatar_url'));
        $config['name'] = trim((string) self::getInboxValue($matchedInbox, 'name'));
        if ($config['avatar_url'] === '') {
            $config['msg'] = '当前 Chatwoot Inbox 未设置头像';
        }

        return $config;
    }

    private static function normalizeLauncherMode($mode)
    {
        return $mode === 'custom_avatar' ? 'custom_avatar' : 'official';
    }

    private static function getMetronSetting($key, $default = '')
    {
        global $_MT;

        return isset($_MT[$key]) ? $_MT[$key] : $default;
    }

    private static function extractInboxList($data)
    {
        if (isset($data['payload']) && is_array($data['payload'])) {
            return $data['payload'];
        }

        return is_array($data) ? $data : [];
    }

    private static function findInboxByWebsiteToken($inboxes, $websiteToken)
    {
        foreach ($inboxes as $inbox) {
            if (!is_array($inbox)) {
                continue;
            }

            $inboxWebsiteToken = trim((string) self::getInboxValue($inbox, 'website_token'));
            if ($inboxWebsiteToken !== '' && hash_equals($inboxWebsiteToken, $websiteToken)) {
                return $inbox;
            }
        }

        return null;
    }

    private static function getInboxValue($inbox, $key)
    {
        if (isset($inbox[$key])) {
            return $inbox[$key];
        }

        if (isset($inbox['channel']) && is_array($inbox['channel']) && isset($inbox['channel'][$key])) {
            return $inbox['channel'][$key];
        }

        return '';
    }

    private static function normalizeUrl($baseUrl, $value)
    {
        $value = trim((string) $value);
        if ($value === '') {
            return '';
        }

        if (preg_match('/^https?:\/\//i', $value) === 1) {
            return $value;
        }

        if (strpos($value, '//') === 0) {
            $scheme = parse_url($baseUrl, PHP_URL_SCHEME) ?: 'https';
            return $scheme . ':' . $value;
        }

        if (strpos($value, '/') === 0) {
            return $baseUrl . $value;
        }

        return $baseUrl . '/' . ltrim($value, '/');
    }

    private static function requestJson($url, $headers)
    {
        if (function_exists('curl_init')) {
            $curl = curl_init();
            curl_setopt($curl, CURLOPT_URL, $url);
            curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
            curl_setopt($curl, CURLOPT_CONNECTTIMEOUT, 5);
            curl_setopt($curl, CURLOPT_TIMEOUT, 10);
            curl_setopt($curl, CURLOPT_FOLLOWLOCATION, true);

            $body = curl_exec($curl);
            $status = (int) curl_getinfo($curl, CURLINFO_HTTP_CODE);
            $error = curl_error($curl);
            curl_close($curl);

            if ($body === false) {
                return [
                    'ok' => false,
                    'msg' => '请求 Chatwoot 失败：' . $error,
                    'data' => null,
                ];
            }

            return self::decodeResponse($body, $status);
        }

        $context = stream_context_create([
            'http' => [
                'method' => 'GET',
                'timeout' => 10,
                'header' => implode("\r\n", $headers),
            ],
        ]);

        $body = @file_get_contents($url, false, $context);
        $status = self::parseStatusCode(isset($http_response_header) ? $http_response_header : []);
        if ($body === false) {
            return [
                'ok' => false,
                'msg' => '请求 Chatwoot 失败',
                'data' => null,
            ];
        }

        return self::decodeResponse($body, $status);
    }

    private static function decodeResponse($body, $status)
    {
        $data = json_decode($body, true);
        if (!is_array($data)) {
            return [
                'ok' => false,
                'msg' => 'Chatwoot 返回了无法解析的响应',
                'data' => null,
            ];
        }

        if ($status >= 400) {
            $message = 'Chatwoot 接口请求失败';
            if (isset($data['message']) && is_string($data['message'])) {
                $message = $data['message'];
            }
            if (isset($data['errors']) && is_array($data['errors']) && count($data['errors']) > 0) {
                $message = implode('；', $data['errors']);
            }

            return [
                'ok' => false,
                'msg' => $message,
                'data' => $data,
            ];
        }

        return [
            'ok' => true,
            'msg' => 'ok',
            'data' => $data,
        ];
    }

    private static function parseStatusCode($headers)
    {
        foreach ($headers as $header) {
            if (preg_match('/\s(\d{3})\s/', $header, $matches) === 1) {
                return (int) $matches[1];
            }
        }

        return 200;
    }
}
