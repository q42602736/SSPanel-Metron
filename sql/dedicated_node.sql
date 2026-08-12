-- 专用节点销售功能所需结构。执行前请先备份数据库。
ALTER TABLE `ss_node`
    ADD COLUMN `sale_type` TINYINT NOT NULL DEFAULT 0 COMMENT '0普通节点，1专用节点' AFTER `node_group`,
    ADD COLUMN `dedicated_price` DECIMAL(12,2) NOT NULL DEFAULT 0 COMMENT '专用节点售价' AFTER `sale_type`,
    ADD COLUMN `dedicated_days` INT NOT NULL DEFAULT 30 COMMENT '专用节点授权天数' AFTER `dedicated_price`,
    ADD COLUMN `dedicated_traffic` BIGINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '专用节点流量GB，0不限' AFTER `dedicated_days`,
    ADD COLUMN `dedicated_status` TINYINT NOT NULL DEFAULT 0 COMMENT '专用节点是否上架' AFTER `dedicated_traffic`;

CREATE TABLE IF NOT EXISTS `user_node_access` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `node_id` BIGINT UNSIGNED NOT NULL,
    `shop_id` BIGINT UNSIGNED NOT NULL DEFAULT 0,
    `bought_id` BIGINT UNSIGNED NOT NULL DEFAULT 0,
    `created_at` BIGINT UNSIGNED NOT NULL,
    `expire_at` BIGINT UNSIGNED NOT NULL,
    `status` TINYINT NOT NULL DEFAULT 1,
    `traffic_limit` BIGINT UNSIGNED NOT NULL DEFAULT 0,
    `traffic_used` BIGINT UNSIGNED NOT NULL DEFAULT 0,
    `started_at` BIGINT UNSIGNED NOT NULL DEFAULT 0,
    `released_at` BIGINT UNSIGNED NOT NULL DEFAULT 0,
    `release_reason` VARCHAR(32) NOT NULL DEFAULT '',
    `price` DECIMAL(12,2) NOT NULL DEFAULT 0,
    PRIMARY KEY (`id`),
    UNIQUE KEY `user_node_access_user_node_unique` (`user_id`, `node_id`),
    KEY `user_node_access_node_status_index` (`node_id`, `status`, `expire_at`),
    KEY `user_node_access_expire_index` (`expire_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `dedicated_node_order` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `node_id` BIGINT UNSIGNED NOT NULL,
    `price` DECIMAL(12,2) NOT NULL DEFAULT 0,
    `days` INT UNSIGNED NOT NULL,
    `traffic_limit` BIGINT UNSIGNED NOT NULL DEFAULT 0,
    `created_at` BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY (`id`),
    KEY `dedicated_node_order_user_index` (`user_id`, `created_at`),
    KEY `dedicated_node_order_node_index` (`node_id`, `created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
