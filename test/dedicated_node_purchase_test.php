<?php

require dirname(__DIR__) . '/vendor/autoload.php';

use App\Models\Node;

$cases = [
    ['heartbeat' => 0, 'sort' => 0, 'available' => false],
    ['heartbeat' => time() - 301, 'sort' => 0, 'available' => false],
    ['heartbeat' => time(), 'sort' => 0, 'available' => true],
    ['heartbeat' => time() - 301, 'sort' => 1, 'available' => true],
];

foreach ($cases as $case) {
    $node = new Node();
    $node->setAttribute('node_heartbeat', $case['heartbeat']);
    $node->setAttribute('sort', $case['sort']);

    if ($node->isDedicatedPurchaseAvailable() !== $case['available']) {
        throw new RuntimeException('专用节点可购买状态判定失败');
    }
}

echo "专用节点可购买状态测试通过\n";
