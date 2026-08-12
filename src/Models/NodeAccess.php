<?php

namespace App\Models;

/**
 * 用户专用节点授权。
 */
class NodeAccess extends Model
{
    protected $connection = 'default';
    protected $table = 'user_node_access';

    protected $casts = [
        'user_id' => 'int',
        'node_id' => 'int',
        'shop_id' => 'int',
        'bought_id' => 'int',
        'created_at' => 'int',
        'expire_at' => 'int',
        'status' => 'int',
        'traffic_limit' => 'int',
        'traffic_used' => 'int',
        'started_at' => 'int',
        'released_at' => 'int',
        'price' => 'float',
        'release_reason' => 'string',
    ];

    public static function validFor($userId, $nodeId): bool
    {
        return self::where('user_id', (int) $userId)
            ->where('node_id', (int) $nodeId)
            ->whereRaw(self::activeSql())
            ->exists();
    }

    public static function activeSql(): string
    {
        return '`status` = 1 AND `expire_at` > ' . time() . ' AND (`traffic_limit` = 0 OR `traffic_used` < `traffic_limit`)';
    }

    public static function activeForNode($nodeId)
    {
        return self::where('node_id', (int) $nodeId)->whereRaw(self::activeSql())->first();
    }

    public static function releaseStale($nodeId = null): int
    {
        $query = self::where('status', 1)->where('expire_at', '<=', time());
        if ($nodeId !== null) {
            $query->where('node_id', (int) $nodeId);
        }
        $released = $query->update([
            'status' => 0,
            'released_at' => time(),
            'release_reason' => '授权到期',
        ]);

        $query = self::where('status', 1)
            ->where('traffic_limit', '>', 0)
            ->whereColumn('traffic_used', '>=', 'traffic_limit');
        if ($nodeId !== null) {
            $query->where('node_id', (int) $nodeId);
        }
        return $released + $query->update([
            'status' => 0,
            'released_at' => time(),
            'release_reason' => '流量耗尽',
        ]);
    }

    public static function forUser($userId)
    {
        return self::where('user_id', (int) $userId)
            ->whereRaw(self::activeSql())
            ->get();
    }

    public static function grant($userId, $nodeId, $days, $shopId = 0, $boughtId = 0, $trafficLimit = 0, $price = 0)
    {
        $now = time();
        $access = self::where('user_id', (int) $userId)
            ->where('node_id', (int) $nodeId)
            ->first();
        if ($access === null) {
            $access = new self();
            $access->user_id = (int) $userId;
            $access->node_id = (int) $nodeId;
            $access->created_at = $now;
            $access->expire_at = $now;
        }

        $access->shop_id = (int) $shopId;
        $access->bought_id = (int) $boughtId;
        $access->started_at = $now;
        $access->traffic_limit = max(0, (int) $trafficLimit);
        $access->traffic_used = 0;
        $access->released_at = 0;
        $access->release_reason = '';
        $access->price = (float) $price;
        $access->expire_at = $now + max(1, (int) $days) * 86400;
        $access->status = 1;
        $access->save();

        return $access;
    }
}
