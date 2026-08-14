-- 已安装专用节点功能的站点执行一次。
ALTER TABLE `ss_node`
    ADD COLUMN `dedicated_traffic_rate` DECIMAL(8,2) NOT NULL DEFAULT 1.00 COMMENT '专用节点流量倍率' AFTER `dedicated_traffic`;
