CREATE DATABASE `cb_malldb`;
USE  `cb_malldb`;

# 轮播图管理表
CREATE TABLE `cb_banner`(
	`id` INT(11) UNSIGNED  NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(50) DEFAULT NULL COMMENT 'Banner 名称，通常作为标识',
	`description` VARCHAR(255) DEFAULT NULL COMMENT 'Banner 描述',
	`delete_time` INT(11) UNSIGNED DEFAULT NULL,
	`update_time` INT(11) UNSIGNED DEFAULT NULL,
	`is_delete` TINYINT(4) NOT NULL DEFAULT '0' COMMENT '0 为正常状态 1为删除',
	PRIMARY KEY(`id`)
) ENGINE = INNODB AUTO_INCREMENT = 2 DEFAULT CHARSET = utf8mb4 COMMENT = 'Banner 管理表';

# banner子项表
CREATE TABLE `cb_banner_item`(
	`id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
	`img_id` INT(11) UNSIGNED NOT NULL COMMENT '外键，关联image表',
	`keyword` VARCHAR(100) NOT NULL COMMENT '执行关键字，根据不同type含义不同',
	`type` TINYINT(4) NOT NULL DEFAULT '1' COMMENT '跳转类型，可能是导向商品 可能是导向专题， 可能导向其他。0，无导向；1：导向商品;2:导向专题',
	`delete_time` INT(11) UNSIGNED DEFAULT NULL,
	`update_time` INT(11) UNSIGNED DEFAULT NULL,
	`banner_id` INT(11) UNSIGNED NOT NULL COMMENT '外键，关联banner表',
	`is_delete` TINYINT(4) NOT NULL DEFAULT '0' COMMENT '0 为正常状态 1为删除',
	PRIMARY KEY(`id`)
) ENGINE = INNODB AUTO_INCREMENT = 6 DEFAULT CHARSET = utf8mb4 COMMENT = 'banner子项表';


# 分类
CREATE TABLE `cb_category`(
	`id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(50) NOT NULL COMMENT '分类名称',
	`topic_img_id` INT(11) UNSIGNED DEFAULT NULL COMMENT '外键，关联image表',
	`delete_time` INT(11) UNSIGNED DEFAULT NULL,
	`description` VARCHAR(100) DEFAULT NULL COMMENT '描述',
	`update_time` INT(11) UNSIGNED DEFAULT NULL,
	PRIMARY KEY(`id`)	
) ENGINE = INNODB AUTO_INCREMENT = 8 DEFAULT CHARSET = utf8mb4 COMMENT = '商品类别';


# 图片
CREATE TABLE `cb_image`(
	`id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
	`url` VARCHAR(255) NOT NULL COMMENT '图片路径',
	`from` TINYINT(4) NOT NULL DEFAULT '1' COMMENT '1来源本地 2来自公网',
	`delete_time` INT(11) UNSIGNED DEFAULT NULL,
	`update_time` INT(11) UNSIGNED DEFAULT NULL,
	`is_delete` TINYINT(4) NOT NULL DEFAULT '0' COMMENT '0 为正常状态 1为删除',
	PRIMARY KEY(`id`)
) ENGINE = INNODB DEFAULT AUTO_INCREMENT = 70 CHARSET = utf8mb4 COMMENT = '图片总表';

# 商品
CREATE TABLE `cb_product`(
	`id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(80) NOT NULL COMMENT '商品名称',
	`price` DECIMAL(6, 2) NOT NULL COMMENT '价格，单位：分',
	`stock` INT(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '库存量',
	`delete_time` INT(11) UNSIGNED DEFAULT NULL,
	`update_time` INT(11) UNSIGNED DEFAULT NULL,
	`category_id` INT(11) UNSIGNED DEFAULT NULL COMMENT '外键，关联category表',
	`main_img_url` VARCHAR(255) DEFAULT NULL COMMENT '主图ID号，这是一个反范式设计，有一定冗余',
	`from` TINYINT(4) NOT NULL DEFAULT '1' COMMENT '图片来自 1本地 2公网',
	`create_time` INT(11) UNSIGNED DEFAULT NULL,
	`summary` VARCHAR(50) DEFAULT NULL COMMENT '摘要',
	`img_id` INT(11) UNSIGNED DEFAULT NULL COMMENT '外键，关联image表',
	PRIMARY KEY(`id`)
) ENGINE = INNODB AUTO_INCREMENT = 34 DEFAULT CHARSET = utf8mb4;

# 商品属性
CREATE TABLE `cb_product_property`(
	`id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(30) DEFAULT '' COMMENT '详情属性名称',
	`detail` VARCHAR(255) NOT NULL COMMENT '详情属性',
	`product_id` INT(11) UNSIGNED NOT NULL COMMENT '商品id, 外键',
	`delete_time` INT(11) UNSIGNED DEFAULT NULL,
	`update_time` INT(11) UNSIGNED DEFAULT NULL,
	`is_delete` TINYINT(4) NOT NULL DEFAULT '0' COMMENT '0 为正常状态 1为删除'
	PRIMARY KEY(`id`)
) ENGINE = INNODB AUTO_INCREMENT = 9 DEFAULT CHARSET = utf8mb4;

# 用户表（微信登录）
CREATE TABLE `cb_user`(
	`id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
	`openid` VARCHAR(50) NOT NULL,
	`nickname` VARCHAR(50) DEFAULT NULL,
	`extend` VARCHAR(255) DEFAULT NULL,
	`delete_time` INT(11) UNSIGNED DEFAULT NULL,
	`create_time` INT(11) UNSIGNED DEFAULT NULL COMMENT '注册时间',
	`update_time` INT(11) UNSIGNED DEFAULT NULL,
	PRIMARY KEY(`id`),
	UNIQUE KEY `openid`(`openid`)
) ENGINE = INNODB AUTO_INREMENT = 2, DEFAULT CHARTSet = utf8mb4;

# 用户地址
CREATE TABLE `cb_user_address`(
	`id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(30) NOT NULL COMMENT '收货人姓名',
	`mobile` VARCHAR(20) NOT NULL COMMENT '手机号',
	`province` VARCHAR(20) DEFAULT NULL COMMENT '省',
	`city` VARCHAR(20) DEFAULT NULL COMMENT '市',
	`country` VARCHAR(20) DEFAULT NULL COMMENT '区',
	`detail` VARCHAR(100) DEFAULT NULL COMMENT '详细地址',
	`delete_time` INT(11) UNSIGNED DEFAULT NULL,
	`update_time` INT(11) UNSIGNED DEFAULT NULL,
	`user_id` INT(11) UNSIGNED NOT NULL COMMENT '外键， 关联user表',
	`is_delete` TINYINT(4) NOT NULL DEFAULT '0' COMMENT '0 为正常状态 1为删除',
	PRIMARY KEY(`id`),
	UNIQUE KEY `user_id` (`user_id`)
) ENGINE = INNODB AUTO_INCREMENT = 2 CHARSET = utf8mb4 COMMENT = '用户地址表';

# 订单
CREATE TABLE `cb_order`(
	`id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
	`order_no` VARCHAR(20) NOT NULL COMMENT '订单号',
	`user_id` INT(11) UNSIGNED NOT NULL COMMENT '外键，关联user表',
	`delete_time` INT(11) UNSIGNED DEFAULT NULL,
	`create_time` INT(11) UNSIGNED DEFAULT NULL,
	`update_time` INT(11) UNSIGNED DEFAULT NULL,
	`total_price` DECIMAL(6, 2) NOT NULL,
	`status` TINYINT(4) NOT NULL DEFAULT '1' COMMENT '1:未支付 2：已支付 3：已发货 4：已发货，但库存不足',
	`snap_img` VARCHAR(255) DEFAULT NULL COMMENT '订单快照图片',
	`snap_name` VARCHAR(80) DEFAULT NULL COMMENT '订单快照名称',
	`snap_items` TEXT COMMENT '订单其他信息快照(json)',
	`snap_address` VARCHAR(500) DEFAULT NULL COMMENT '地址快照',
	`total_count` INT(11) UNSIGNED NOT NULL DEFAULT '0',
	`prepay_id` VARCHAR(100) DEFAULT NULL,
	`is_delete` TINYINT(4) NOT NULL DEFAULT '0' COMMENT '0 为正常状态 1为删除',
  COMMENT '订单微信支付的预订单id（用于发送模板消息）',
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_no` (`order_no`),
  KEY `user_id` (`user_id`)
	)  ENGINE = InnoDB AUTO_INCREMENT = 2 DEFAULT CHARSET = utf8mb4 COMMENT = '订单表';
	
	
	# 专题
	CREATE TABLE `cb_theme`(
		`id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
		`name` VARCHAR(50) NOT NULL COMMENT '专题名称',
		`description` VARCHAR(255) DEFAULT NULL COMMENT '专题描述',
		`topic_img_id` INT(11) UNSIGNED NOT NULL COMMENT '主题图， 外键',
		`delete_time` INT(11) UNSIGNED DEFAULT NULL,
		`head_img_id` NOT NULL COMMENT '专题列表页，头图',
		`update_time` INT(11) UNSIGNED DEFAULT NULL,
		PRIMARY KEY(`id`)
	) ENGINE = InnoDB AUTO_INCREMENT = 4 DEFAULT CHARSET = utf8mb4 COMMENT ='主题信息表';
	
	# 专题所包含的商品
	CREATE TABLE `cb_theme_product`(
		`theme_id` INT(11) UNSIGNED NOT NULL COMMENT '主题外键',
		`product_id` INT(11) UNSIGNED NOT NULL COMMENT '商品外键',
		PRIMARY KEY (`theme_id`, `product_id`)
	)  ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT ='主题所包含的商品';
	
# 主题的数据插入
-- 1、创建主题，先上传图片，拿到主题图、主题列表页头图id和主题所需信息创建专题
-- 2、添加商品，添加成功后获取product_id和选择专题进行绑定
-- 3、数据的更新（商品更改主题), 需要拿旧theme_id和product_id查询是否已经存在该条数据，查出则该，没有则插入
-- 4、删除商品和专题的关联，通过product_id进行删除即可


# 第三方登录
CREATE TABLE `cb_third_login` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '会员ID',
  `platform` varchar(30) NOT NULL DEFAULT '' COMMENT '第三方应用',
  `open_id` varchar(50) NOT NULL DEFAULT '' COMMENT '第三方唯一ID',
  `open_name` varchar(50) NOT NULL DEFAULT '' COMMENT '第三方会员昵称',
  `access_token` varchar(255) NOT NULL DEFAULT '' COMMENT 'AccessToken',
  `refresh_token` varchar(255) NOT NULL DEFAULT 'RefreshToken',
  `expires_in` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '有效期',
  `create_time` int(11) unsigned DEFAULT NULL COMMENT '创建时间',
  `update_time` int(11) unsigned DEFAULT NULL COMMENT '更新时间',
  `login_time` int(11) unsigned DEFAULT NULL COMMENT '登录时间',
  `expire_time` int(10) unsigned DEFAULT NULL COMMENT '过期时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `platform` (`platform`,`openid`),
  KEY `user_id` (`user_id`,`platform`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='第三方登录表';