<?php

namespace App\Controllers\Api\V1;

use App\Models\{Node, NodeAccess};
use App\Models\User;
use App\Services\Config;
use App\Utils\{Tools, Hash, URL, AppURI};

use App\Controllers\Api\TokenStorage;

/**
 *  ApiController
 */
class ApiController
{
    public function index()
    {
    }

    public function token($request, $response, $args)
    {
        $accessToken = $id = $args['token'];
        $storage = TokenStorage::createTokenStorage();
        $token = $storage->get($accessToken);
        if ($token == null) {
            $res['ret'] = 0;
            $res['msg'] = 'token is null';
            return $response->getBody()->write(json_encode($res));
        }
        $res['ret'] = 1;
        $res['msg'] = 'token ok';
        $res['data'] = $token;
        return $response->getBody()->write(json_encode($res));
    }

    public function newToken($request, $response, $args)
    {
        // $data = $request->post('sdf');
        $email = $request->getParam('email');

        $email = strtolower($email);
        $passwd = $request->getParam('passwd');

        // Handle Login
        $user = User::where('email', '=', $email)->first();

        if ($user == null) {
            $res['ret'] = 0;
            $res['msg'] = '401 账号错误';
            return $response->getBody()->write(json_encode($res));
        }

        if (!Hash::checkPassword($user->pass, $passwd)) {
            $res['ret'] = 0;
            $res['msg'] = '402 密码错误';
            return $response->getBody()->write(json_encode($res));
        }
        $tokenStr = Tools::genToken();
        $storage = TokenStorage::createTokenStorage();
        $expireTime = time() + 3600 * 24 * 7;
        if ($storage->store($tokenStr, $user, $expireTime)) {
            $res['ret'] = 1;
            $res['msg'] = 'newToken ok';
            $res['data']['token'] = $tokenStr;
            $res['data']['user_id'] = $user->id;
            return $response->getBody()->write(json_encode($res));
        }
        $res['ret'] = 0;
        $res['msg'] = 'system error';
        return $response->getBody()->write(json_encode($res));
    }

    public function node($request, $response, $args)
    {
        $accessToken = $request->getParam('access_token');
        $storage = TokenStorage::createTokenStorage();
        $token = $storage->get($accessToken);
        $user = User::find($token->userId);
        $nodes = URL::getNodes($user, 0);
        $mu_nodes = URL::getNodes($user, 9);

        $temparray = array();
        foreach ($nodes as $node) {
            if ($node->mu_only == 0) {
                $temparray[] = array('remarks' => $node->name,
                    'server' => $node->server,
                    'server_port' => $user->port,
                    'method' => $node->custom_method == 1 ? $user->method : $node->method,
                    'obfs' => str_replace('_compatible', '', (($node->custom_rss == 1 && !($user->obfs == 'plain' && $user->protocol == 'origin')) ? $user->obfs : 'plain')),
                    'obfsparam' => ($node->custom_rss == 1 && !($user->obfs == 'plain' && $user->protocol == 'origin')) ? $user->obfs_param : '',
                    'remarks_base64' => base64_encode($node->name),
                    'password' => $user->passwd,
                    'tcp_over_udp' => false,
                    'udp_over_tcp' => false,
                    'group' => Config::get('appName'),
                    'protocol' => str_replace('_compatible', '', (($node->custom_rss == 1 && !($user->obfs == 'plain' && $user->protocol == 'origin')) ? $user->protocol : 'origin')),
                    'obfs_udp' => false,
                    'enable' => true);
            }

            if ($node->custom_rss == 1) {
                foreach ($mu_nodes as $mu_node) {
                    $mu_user = User::where('port', '=', $mu_node->server)->first();
                    $mu_user->obfs_param = $user->getMuMd5();

                    $temparray[] = array('remarks' => $node->name . '- ' . $mu_node->server . ' 单端口',
                        'server' => $node->server,
                        'server_port' => $mu_user->port,
                        'method' => $mu_user->method,
                        'group' => Config::get('appName'),
                        'obfs' => str_replace('_compatible', '', (($node->custom_rss == 1 && !($mu_user->obfs == 'plain' && $mu_user->protocol == 'origin')) ? $mu_user->obfs : 'plain')),
                        'obfsparam' => ($node->custom_rss == 1 && !($mu_user->obfs == 'plain' && $mu_user->protocol == 'origin')) ? $mu_user->obfs_param : '',
                        'remarks_base64' => base64_encode($node->name . '- ' . $mu_node->server . ' 单端口'),
                        'password' => $mu_user->passwd,
                        'tcp_over_udp' => false,
                        'udp_over_tcp' => false,
                        'protocol' => str_replace('_compatible', '', (($node->custom_rss == 1 && !($mu_user->obfs == 'plain' && $mu_user->protocol == 'origin')) ? $mu_user->protocol : 'origin')),
                        'obfs_udp' => false,
                        'enable' => true);
                }
            }
        }

        $res['ret'] = 1;
        $res['msg'] = 'ok';
        $res['data'] = $temparray;
        return $response->getBody()->write(json_encode($res));
    }

    /**
     * 获取专用节点目录及当前用户授权状态。
     *
     * 默认返回可售专用节点与当前用户已拥有的节点；传入 owned_only=1 时只返回已拥有节点，
     * 兼容仅需要下发用户节点配置的客户端。其他用户已占用的节点不进入目录。
     * 原始 server 字段不直接返回，未拥有节点不会返回 configs/urls，避免泄露用户配置和服务端密钥。
     */
    public function dedicatedNodes($request, $response, $args)
    {
        $accessToken = $request->getParam('access_token');
        $storage = TokenStorage::createTokenStorage();
        $token = $storage->get($accessToken);
        $user = $token === null ? null : User::find((int) $token->userId);

        if ($user === null || (int) $user->enable !== 1) {
            return $response->withJson([
                'ret' => 0,
                'msg' => '账号不可用',
            ]);
        }

        NodeAccess::releaseStale();
        $ownedAccesses = NodeAccess::forUser($user->id);
        $ownedAccessByNodeId = [];
        foreach ($ownedAccesses as $access) {
            $ownedAccessByNodeId[(int) $access->node_id] = $access;
        }

        $ownedOnly = in_array(
            strtolower(trim((string) $request->getParam('owned_only', '0'))),
            ['1', 'true', 'yes'],
            true
        );
        $nodesQuery = Node::where('sale_type', 1)->where('type', 1);
        if ($ownedOnly) {
            if (empty($ownedAccessByNodeId)) {
                return $response->withJson([
                    'ret' => 1,
                    'msg' => 'ok',
                    'data' => [],
                ]);
            }
            $nodesQuery->whereIn('id', array_keys($ownedAccessByNodeId));
        } else {
            $ownedNodeIds = array_keys($ownedAccessByNodeId);
            $nodesQuery->where(function ($query) use ($ownedNodeIds) {
                $query->where(function ($saleQuery) {
                    $saleQuery->where('dedicated_price', '>', 0)
                        ->where('dedicated_days', '>', 0);
                });
                if (!empty($ownedNodeIds)) {
                    $query->orWhereIn('id', $ownedNodeIds);
                }
            });
        }

        $nodes = $nodesQuery
            ->orderBy('node_sort', 'desc')
            ->orderBy('name')
            ->get()
            ->keyBy('id');

        $activeAccessByNodeId = [];
        $nodeIds = $nodes->pluck('id')->all();
        if (!empty($nodeIds)) {
            $activeAccesses = NodeAccess::whereIn('node_id', $nodeIds)
                ->whereRaw(NodeAccess::activeSql())
                ->get();
            foreach ($activeAccesses as $access) {
                $nodeId = (int) $access->node_id;
                if (!isset($activeAccessByNodeId[$nodeId])) {
                    $activeAccessByNodeId[$nodeId] = $access;
                }
            }
        }

        $data = [];
        foreach ($nodes as $node) {
            $nodeId = (int) $node->id;
            $access = $ownedAccessByNodeId[$nodeId] ?? null;
            $activeAccess = $activeAccessByNodeId[$nodeId] ?? null;
            $owned = $access !== null;
            if ($activeAccess !== null && !$owned) {
                continue;
            }
            $occupied = $activeAccess !== null && !$owned;
            $configs = $owned ? $this->dedicatedNodeConfigs($node, $user) : [];
            $urls = [];
            foreach ($configs as $config) {
                $url = $this->dedicatedNodeUrl($config);
                if ($url !== null) {
                    $urls[] = $url;
                }
            }

            $primaryConfig = $configs[0] ?? [];
            $trafficLimit = $access === null ? null : max(0, (int) $access->traffic_limit);
            $trafficUsed = $access === null ? null : max(0, (int) $access->traffic_used);
            $trafficRemaining = $trafficLimit === null
                ? null
                : ($trafficLimit > 0 ? max(0, $trafficLimit - $trafficUsed) : 0);
            $trafficBytes = $node->dedicatedTrafficBytes();
            $flag = $this->dedicatedFlagCode((string) $node->name);

            $data[] = [
                'id' => $nodeId,
                'name' => (string) $node->name,
                'description' => (string) ($node->info ?? ''),
                'flag' => $flag,
                'country_code' => $flag,
                'ip' => $node->getMaskedIp(),
                'sort' => (int) $node->sort,
                'protocol' => $this->dedicatedNodeProtocol($node),
                'price' => (float) $node->dedicated_price,
                'days' => (int) $node->dedicated_days,
                'traffic_bytes' => $trafficBytes,
                'traffic_text' => $trafficBytes > 0
                    ? Tools::flowAutoShow($trafficBytes)
                    : '不限',
                'online' => $node->isNodeOnline(),
                'status' => (string) $node->status,
                'owned' => $owned,
                'occupied' => $occupied,
                'available' => !$owned && !$occupied,
                'server' => $owned ? $this->dedicatedConfigAddress($primaryConfig) : null,
                'port' => $owned ? $this->dedicatedConfigPort($primaryConfig) : null,
                'traffic_rate' => (float) $node->dedicatedTrafficRate(),
                'ip_limit' => (int) $node->dedicatedConnector(),
                'expire_at' => $access === null ? null : (int) $access->expire_at,
                'traffic_limit' => $trafficLimit,
                'traffic_used' => $trafficUsed,
                'traffic_remaining' => $trafficRemaining,
                'traffic_unlimited' => $trafficLimit === null ? null : $trafficLimit === 0,
                'configs' => $configs,
                'urls' => $urls,
            ];
        }

        return $response->withJson([
            'ret' => 1,
            'msg' => 'ok',
            'data' => $data,
        ]);
    }

    private function dedicatedFlagCode(string $nodeName): string
    {
        $matches = [];
        preg_match($_ENV['flag_regex'], $nodeName, $matches);

        return [
            '香港' => 'hk',
            '美国' => 'us',
            '日本' => 'jp',
            '中国' => 'cn',
            '俄罗斯' => 'ru',
            '韩国' => 'kr',
            '英国' => 'gb',
            '新加坡' => 'sg',
            '马来西亚' => 'my',
            '台湾' => 'tw',
            '加拿大' => 'ca',
            '菲律宾' => 'ph',
            '德国' => 'de',
        ][$matches[0] ?? ''] ?? 'un';
    }

    /**
     * 按节点协议生成用户可用配置。
     */
    private function dedicatedNodeConfigs(Node $node, User $user): array
    {
        $configs = [];

        switch ((int) $node->sort) {
            case 0:
            case 10:
                foreach ([0, 1] as $isSs) {
                    $item = $node->getItem($user, 0, 0, $isSs);
                    if ($item !== null) {
                        $configs[] = $this->sanitizeDedicatedConfig($item);
                    }
                }
                break;
            case 1:
                $configs[] = $this->sanitizeDedicatedConfig($node->getSS2022Item($user));
                break;
            case 11:
            case 12:
            case 15:
            case 16:
                $configs[] = $this->sanitizeDedicatedConfig($node->getV2RayItem($user));
                break;
            case 13:
                $item = $node->getV2RayPluginItem($user);
                if ($item !== null) {
                    $configs[] = $this->sanitizeDedicatedConfig($item);
                }
                break;
            case 14:
                $configs[] = $this->sanitizeDedicatedConfig($node->getTrojanItem($user));
                break;
            case 17:
                $configs[] = $this->sanitizeDedicatedConfig($node->getHy2Item($user));
                break;
            case 18:
                $configs[] = $this->sanitizeDedicatedConfig($node->getAnyTlsItem($user));
                break;
        }

        return $configs;
    }

    private function sanitizeDedicatedConfig(array $config): array
    {
        unset($config['privateKey'], $config['private_key'], $config['private-key']);

        return $config;
    }

    private function dedicatedNodeUrl(array $config): ?string
    {
        switch ($config['type'] ?? '') {
            case 'ss':
                // SS2022 使用专用的密钥格式，现有通用 URI 生成器不支持该格式。
                if (strpos((string) ($config['method'] ?? ''), '2022-') === 0) {
                    return null;
                }
                return URL::getItemUrl($config, 2);
            case 'ssr':
                return URL::getItemUrl($config, 0);
            default:
                return AppURI::getV2RayNURI($config);
        }
    }

    private function dedicatedConfigAddress(array $config): ?string
    {
        if (isset($config['address'])) {
            return (string) $config['address'];
        }
        if (isset($config['add'])) {
            return (string) $config['add'];
        }

        return null;
    }

    private function dedicatedConfigPort(array $config): ?int
    {
        return isset($config['port']) ? (int) $config['port'] : null;
    }

    private function dedicatedNodeProtocol(Node $node): string
    {
        switch ((int) $node->sort) {
            case 0:
            case 10:
                return 'ss/ssr';
            case 1:
                return 'ss2022';
            case 11:
            case 12:
                return 'vmess';
            case 13:
                return 'ss-v2ray-plugin';
            case 14:
                return 'trojan';
            case 15:
            case 16:
                return 'vless';
            case 17:
                return 'hysteria2';
            case 18:
                return 'anytls';
            default:
                return 'unknown';
        }
    }

    public function userInfo($request, $response, $args)
    {
        $id = $args['id'];
        $accessToken = $request->getParam('access_token');
        $storage = TokenStorage::createTokenStorage();
        $token = $storage->get($accessToken);
        if ($id != $token->userId) {
            $res['ret'] = 0;
            $res['msg'] = 'access denied';
            return $response->getBody()->write(json_encode($res));
        }
        $user = User::find($token->userId);
        $user->pass = null;
        $data = $user;
        $res['ret'] = 1;
        $res['msg'] = 'userInfo ok';
        $res['data'] = $data;
        return $response->getBody()->write(json_encode($res));
    }
}
