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
    ];

    public static function validFor($userId, $nodeId): bool
    {
        return self::where('user_id', (int) $userId)
            ->where('node_id', (int) $nodeId)
            ->where('status', 1)
            ->where('expire_at', '>', time())
            ->exists();
    }

    public static function forUser($userId)
    {
        return self::where('user_id', (int) $userId)
            ->where('status', 1)
            ->where('expire_at', '>', time())
            ->get();
    }

    public static function grant($userId, $nodeId, $days, $shopId = 0, $boughtId = 0)
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
        $access->expire_at = max((int) $access->expire_at, $now) + max(1, (int) $days) * 86400;
        $access->status = 1;
        $access->save();

        return $access;
    }
}
