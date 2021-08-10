
# 安装插件是执行的sql文件
CREATE TABLE `integrates_repo` (
  `id` mediumint NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL DEFAULT '0' COMMENT '项目id',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '仓库名',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '路径',
  `encoding` varchar(20) NOT NULL DEFAULT 'utf-8' COMMENT '编码',
  `scm` varchar(10) NOT NULL DEFAULT '' COMMENT '类型：git/gitlab',
  `client` varchar(100) NOT NULL DEFAULT '' COMMENT '客户端:/usr/bin/git',
  `commits` mediumint unsigned NOT NULL COMMENT '提交次数',
  `account` varchar(30) NOT NULL,
  `password` varchar(30) NOT NULL,
  `encrypt` varchar(30) NOT NULL DEFAULT 'plain' COMMENT '加密方式：base64',
  `synced` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否异步：1是，0否',
  `last_sync` datetime NOT NULL COMMENT '上次更新时间',
  `desc` text NOT NULL COMMENT '描述',
  `extra` char(30) NOT NULL COMMENT '扩展',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除：1是，0否',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;