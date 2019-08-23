SET foreign_key_checks = 0;
SET SQL_SAFE_UPDATES=0;

DROP TABLE IF EXISTS spring_session;

CREATE TABLE `spring_session` (
  `PRIMARY_ID` char(36) NOT NULL,
  `SESSION_ID` char(36) NOT NULL,
  `CREATION_TIME` bigint(20) NOT NULL,
  `LAST_ACCESS_TIME` bigint(20) NOT NULL,
  `MAX_INACTIVE_INTERVAL` int(11) NOT NULL,
  `EXPIRY_TIME` bigint(20) NOT NULL,
  `PRINCIPAL_NAME` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`PRIMARY_ID`),
  UNIQUE KEY `SPRING_SESSION_IX1` (`SESSION_ID`),
  KEY `SPRING_SESSION_IX2` (`EXPIRY_TIME`),
  KEY `SPRING_SESSION_IX3` (`PRINCIPAL_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS spring_session_attributes;

CREATE TABLE `spring_session_attributes` (
  `SESSION_PRIMARY_ID` char(36) NOT NULL,
  `ATTRIBUTE_NAME` varchar(200) NOT NULL,
  `ATTRIBUTE_BYTES` blob NOT NULL,
  PRIMARY KEY (`SESSION_PRIMARY_ID`,`ATTRIBUTE_NAME`),
  CONSTRAINT `SPRING_SESSION_ATTRIBUTES_FK` FOREIGN KEY (`SESSION_PRIMARY_ID`) REFERENCES `spring_session` (`PRIMARY_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS domain;

CREATE TABLE `domain` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `discriminator` varchar(1) NOT NULL,
  `name` varchar(50) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `url` varchar(250) DEFAULT NULL,
  `root_dn` varchar(250) DEFAULT NULL,
  `user_search_base` varchar(250) DEFAULT NULL,
  `group_search_base` varchar(250) DEFAULT NULL,
  `user_name` varchar(250) DEFAULT NULL,
  `user_password` varchar(250) DEFAULT NULL,
  `user_name_property` varchar(250) DEFAULT NULL,
  `first_name_property` varchar(250) DEFAULT NULL,
  `surname_name_property` varchar(250) DEFAULT NULL,
  `email_property` varchar(250) DEFAULT NULL,
  `department_property` varchar(250) DEFAULT NULL,
  `permitted_client_addresses` varchar(250) NOT NULL,
  `groups_property` varchar(250) DEFAULT NULL,
  `default_department` bigint(20) DEFAULT NULL,
  `spnego_keytab_location` varchar(255) DEFAULT NULL,
  `spnego_service_principal` varchar(255) DEFAULT NULL,
  `override_department_attribute` tinyint(4) NOT NULL,
  `ignore_department_attribute` tinyint(4) NOT NULL,
  `auto_sync` tinyint(4) NOT NULL,
  `last_sync_ts` datetime DEFAULT NULL,
  `employee_id_property` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

insert into `domain` (`id`, `discriminator`, `name`, `active`, `url`, `root_dn`, `user_search_base`, `group_search_base`, `user_name`, `user_password`, `user_name_property`, `first_name_property`, `surname_name_property`, `email_property`, `department_property`, `permitted_client_addresses`, `groups_property`, `default_department`, `spnego_keytab_location`, `spnego_service_principal`, `override_department_attribute`, `ignore_department_attribute`, `auto_sync`, `last_sync_ts`, `employee_id_property`) values('1','I','Q-Pulse','1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL,NULL,'0','0','0',NULL,NULL);
insert into `domain` (`id`, `discriminator`, `name`, `active`, `url`, `root_dn`, `user_search_base`, `group_search_base`, `user_name`, `user_password`, `user_name_property`, `first_name_property`, `surname_name_property`, `email_property`, `department_property`, `permitted_client_addresses`, `groups_property`, `default_department`, `spnego_keytab_location`, `spnego_service_principal`, `override_department_attribute`, `ignore_department_attribute`, `auto_sync`, `last_sync_ts`, `employee_id_property`) values('2','L','L-LDAP','1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL,NULL,'0','0','0',NULL,NULL);

DROP TABLE IF EXISTS role;

CREATE TABLE `role` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL,  
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

insert into role values (1, 'ROLE_ADMIN');
insert into role values (2, 'ROLE_LAW');
insert into role values (3, 'ROLE_RISK');
insert into role values (4, 'ROLE_AUDIT');
insert into role values (5, 'ROLE_DATA');
insert into role values (6, 'ROLE_DOCCONTROL');
insert into role values (7, 'ROLE_DOCS');
insert into role values (8, 'ROLE_INCIDENT');

DROP TABLE IF EXISTS user;

CREATE TABLE `user` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `domain` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`,`domain`),
  KEY `FK375DF2F94806B69A` (`domain`),
  CONSTRAINT `FK375DF2F94806B69A` FOREIGN KEY (`domain`) REFERENCES `domain` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- password value = p@ssw0rd
insert into user values ('106c83e330014847abb5e22aaf5b5249','demo','$2a$10$tEvZ/uU14V1gSOLgAZNlYu.n3yA67pfF11yctyyLX2IIpD5WTL/ZO','demo', 1);
insert into user values ('106c83e330014847abb5e22aaf5b5248','admin','$2a$10$tEvZ/uU14V1gSOLgAZNlYu.n3yA67pfF11yctyyLX2IIpD5WTL/ZO','admin', 1);

DROP TABLE IF EXISTS users_roles;

CREATE TABLE `users_roles` (
  `user_id` varchar(255) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  KEY `FKt4v0rrweyk393bdgt107vdx0x` (`role_id`),
  KEY `FKgd3iendaoyh04b95ykqise6qh` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

insert into users_roles values ('106c83e330014847abb5e22aaf5b5249', 2);
insert into users_roles values ('106c83e330014847abb5e22aaf5b5248', 1);
insert into users_roles values ('106c83e330014847abb5e22aaf5b5248', 2);
insert into users_roles values ('106c83e330014847abb5e22aaf5b5248', 3);
insert into users_roles values ('106c83e330014847abb5e22aaf5b5248', 4);
insert into users_roles values ('106c83e330014847abb5e22aaf5b5248', 5);
insert into users_roles values ('106c83e330014847abb5e22aaf5b5248', 6);
insert into users_roles values ('106c83e330014847abb5e22aaf5b5248', 7);
insert into users_roles values ('106c83e330014847abb5e22aaf5b5248', 8);

