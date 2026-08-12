<?php

namespace App\Models;

/**
 * 专用节点购买订单。
 */
class DedicatedNodeOrder extends Model
{
    protected $connection = 'default';
    protected $table = 'dedicated_node_order';

    protected $casts = [
        'user_id' => 'int',
        'node_id' => 'int',
        'days' => 'int',
        'traffic_limit' => 'int',
        'created_at' => 'int',
        'price' => 'float',
    ];
}
