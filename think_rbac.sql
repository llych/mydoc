--
-- 授权表 `think_access`
--

CREATE TABLE IF NOT EXISTS `think_access` (
  `role_id` smallint(6) unsigned NOT NULL COMMENT '用户组的id',
  `node_id` smallint(6) unsigned NOT NULL COMMENT '节点的id',
  `level` tinyint(1) NOT NULL COMMENT '节点的等级',
  `module` varchar(50) DEFAULT NULL ,
  `pid` int(11) NOT NULL COMMENT '节点的父id',
  KEY `groupId` (`role_id`),
  KEY `nodeId` (`node_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT '授权表';

--
-- 转存表中的数据 `think_access`
--

INSERT INTO `think_access` (`role_id`, `node_id`, `level`, `module`, `pid`) VALUES
(2, 1, 1, NULL, 0),
(2, 2, 2, NULL, 1),
(2, 3, 2, NULL, 1),
(2, 4, 3, NULL, 2),
(2, 8, 3, NULL, 3),
(2, 6, 3, NULL, 2);

-- --------------------------------------------------------

--
-- 节点表 `think_node` 项目1 模块2 方法3
--

CREATE TABLE IF NOT EXISTS `think_node` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL COMMENT '节点名称',
  `title` varchar(50) DEFAULT NULL COMMENT '节点标题',
  `status` tinyint(1) DEFAULT '0' COMMENT '状态',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `sort` smallint(6) unsigned DEFAULT NULL COMMENT '排序',
  `pid` smallint(6) unsigned NOT NULL COMMENT '节点父级id',
  `level` tinyint(1) unsigned NOT NULL COMMENT '等级',
  PRIMARY KEY (`id`),
  KEY `level` (`level`),
  KEY `pid` (`pid`),
  KEY `status` (`status`),
  KEY `name` (`name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=12 COMMENT '节点表';

--
-- 转存表中的数据 `think_node`
--

INSERT INTO `think_node` (`id`, `name`, `title`, `status`, `remark`, `sort`, `pid`, `level`) VALUES
(1, 'admin', NULL, 1, NULL, NULL, 0, 1),
(2, 'user', NULL, 1, NULL, NULL, 1, 2),
(3, 'index', NULL, 1, NULL, NULL, 1, 2),
(4, 'index', NULL, 1, NULL, NULL, 2, 3),
(5, 'del', NULL, 1, NULL, NULL, 2, 3),
(6, 'add', NULL, 1, NULL, NULL, 2, 3),
(7, 'update', NULL, 1, NULL, NULL, 2, 3),
(8, 'index', NULL, 1, NULL, NULL, 3, 3),
(9, 'del', NULL, 1, NULL, NULL, 3, 3),
(10, 'add', NULL, 1, NULL, NULL, 3, 3),
(11, 'update', NULL, 1, NULL, NULL, 3, 3);

-- --------------------------------------------------------

--
-- 用户角色 `think_role`
--

CREATE TABLE IF NOT EXISTS `think_role` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL COMMENT '组名称',
  `pid` smallint(6) DEFAULT NULL COMMENT '组父级id',
  `status` tinyint(1) unsigned DEFAULT NULL COMMENT '状态',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`),
  KEY `status` (`status`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3  COMMENT '用户组';

--
-- 转存表中的数据 `think_role`
--

INSERT INTO `think_role` (`id`, `name`, `pid`, `status`, `remark`) VALUES
(1, 'admin', NULL, 1, NULL),
(2, 'user', NULL, 1, NULL);

-- --------------------------------------------------------

--
-- 用户和角色的关系 `think_role_user`
--

CREATE TABLE IF NOT EXISTS `think_role_user` (
  `role_id` mediumint(9) unsigned DEFAULT NULL COMMENT '组id',
  `user_id` char(32) DEFAULT NULL COMMENT '用户id',
  KEY `group_id` (`role_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT '用户和组的关系';

--
-- 转存表中的数据 `think_role_user`
--

INSERT INTO `think_role_user` (`role_id`, `user_id`) VALUES
(1, '1'),
(2, '2'),
(2, '3');

-- --------------------------------------------------------

--
-- 用户表 `think_user`
--

CREATE TABLE IF NOT EXISTS `think_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL COMMENT '用户名',
  `password` char(32) NOT NULL COMMENT '密码',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 COMMENT '用户表';

--
-- 转存表中的数据 `think_user`
--

INSERT INTO `think_user` (`id`, `username`, `password`) VALUES
(1, 'admin', '21232f297a57a5a743894a0e4a801fc3'),
(2, 'user', 'ee11cbb19052e40b07aac0ca060c23ee'),
(3, 'li', '169d2dae41d971658519adef92b144f1');
