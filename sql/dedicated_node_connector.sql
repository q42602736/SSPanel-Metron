-- 专用节点独立 IP 限制。执行前请先备份数据库。
ALTER TABLE `ss_node`
    ADD COLUMN `dedicated_connector` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '专用节点同时使用的公网 IP 数，0 不限' AFTER `dedicated_traffic_rate`;
