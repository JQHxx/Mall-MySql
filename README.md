# Mall-MySql
数据库

- 1、varchar 和 char 区别？
```
非空CHAR的最大总长度是255【字节】;非空VARCHAR的最大总长度是65533【字节】。
可空CHAR的最大总长度是254【字节】;可空VARCHAR的最大总长度是65532【字节】。
原因:非空标记需要占据一个字节,VARCHAR超过255需要用2个字节标记字段长度,不超过255用1个字节标记字段长度.

定义一个char[10]和varchar[10],如果存进去的是‘abcd’,那么char所占的长度依然为10，除了字符‘abcd’外，后面跟六个空格，而varchar就立马把长度变为4了，取数据的时候，char类型的要用trim()去掉多余的空格，而varchar是不需要的

char的存储方式是，对英文字符（ASCII）占用1个字节，对一个汉字占用两个字节；而varchar的存储方式是，对每个英文字符占用2个字节，汉字也占用2个字节，两者的存储数据都非unicode的字符数据。

char的存取数度还是要比varchar要快得多，因为其长度固定，方便程序的存储与查找；但是char也为此付出的是空间的代价，因为其长度固定，所以难免会有多余的空格占位符占据空间，可谓是以空间换取时间效率，而varchar是以空间效率为首位的。

char(n)和varchar(n)超出n的范围时,会截取前面n个字符
```

- 2、tinyint(4) 常见于枚举和bool
- 3、如果涉及到金额变动，需要设置金额变动日志表
- 4、tinyint（1个字节 2的8次方减1）、smallint（2字节）、int（4字节）、bigint（8字节）
- 5、decimal(8,2) 金额保留小数位
- 6、int(3) 表示如果不满3位，会在前面补0
- 7、int(10) unsigned 表示正整数
- 8、数据的标志删除  `is_delete` TINYINT(4) NOT NULL DEFAULT '0'  不要用邪门功法 `delete_time`  INT(11) DEFAULT NULL,
- 9、DEFAULT CHARSET = utf8mb4; 数据表的编码（可以处理表情）
- 10、索引（普通索引、）

- 高性能可拓展MySql
- MySQL提升课程 全面讲解MySQL架构设计

### 高性能可拓展MySql
#### 一、数据库开发规范的制定
