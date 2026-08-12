-- 专用节点销售功能所需结构。执行前请先备份数据库。
ALTER TABLE `ss_node`
    ADD COLUMN `sale_type` TINYINT NOT NULL DEFAULT 0 COMMENT '0普通节点，1专用节点' AFTER `node_group`;

CREATE TABLE IF NOT EXISTS `user_node_access` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `node_id` BIGINT UNSIGNED NOT NULL,
    `shop_id` BIGINT UNSIGNED NOT NULL DEFAULT 0,
    `bought_id` BIGINT UNSIGNED NOT NULL DEFAULT 0,
    `created_at` BIGINT UNSIGNED NOT NULL,
    `expire_at` BIGINT UNSIGNED NOT NULL,
    `status` TINYINT NOT NULL DEFAULT 1,
    PRIMARY KEY (`id`),
    UNIQUE KEY `user_node_access_user_node_unique` (`user_id`, `node_id`),
    KEY `user_node_access_node_status_index` (`node_id`, `status`, `expire_at`),
    KEY `user_node_access_expire_index` (`expire_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
