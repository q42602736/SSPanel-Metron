<?php

namespace App\Utils;

use ipip\db\City;

/*
* @author joyphper
* 使用 IPDB 格式的纯真 IP 库，支持 IPv4 和 IPv6
*/

class QQWry
{
    private $db;

    public function __construct()
    {
        $filename = BASE_PATH . '/storage/qqwry.ipdb';

        try {
            if (file_exists($filename)) {
                $this->db = new City($filename);
            } else {
                $this->db = null;
            }
        } catch (\Exception $e) {
            $this->db = null;
        }
    }

    public function getlocation($ip)
    {
        if (!$this->db) {
            return null;
        }

        try {
            // 解析 IP 地址，获取详细信息
            $result = $this->db->findMap($ip, 'CN');

            if (!$result) {
                return null;
            }

            // 构建兼容原有格式的返回数据
            $location = [];
            $location['ip'] = $ip;

            // 组合地理位置信息
            $country_parts = [];
            if (!empty($result['region_name'])) {
                $country_parts[] = $result['region_name'];
            }
            if (!empty($result['city_name'])) {
                $country_parts[] = $result['city_name'];
            }
            if (!empty($result['district_name'])) {
                $country_parts[] = $result['district_name'];
            }

            $country = !empty($country_parts) ? implode(' ', $country_parts) : '未知';
            $area = !empty($result['isp_domain']) ? $result['isp_domain'] : '';

            // IPDB 格式返回 UTF-8，为了兼容旧代码中的 iconv('gbk', 'utf-8')
            // 我们将 UTF-8 转换为 GBK，这样旧代码的 iconv 转换就能正常工作
            $location['country'] = mb_convert_encoding($country, 'GBK', 'UTF-8');
            $location['area'] = mb_convert_encoding($area, 'GBK', 'UTF-8');

            // 保留原有字段以兼容旧代码
            $location['beginip'] = '';
            $location['endip'] = '';

            return $location;
        } catch (\Exception $e) {
            return null;
        }
    }
}
