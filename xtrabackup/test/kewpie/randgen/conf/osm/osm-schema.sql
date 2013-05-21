CREATE TABLE IF NOT EXISTS `changesets` (  `id` bigint(20) NOT NULL auto_increment,  `user_id` bigint(20) NOT NULL,  `created_at` datetime NOT NULL,  `min_lat` int(11) default NULL,  `max_lat` int(11) default NULL,  `min_lon` int(11) default NULL,  `max_lon` int(11) default NULL,  `closed_at` datetime NOT NULL,  `num_changes` int(11) NOT NULL default '0',  PRIMARY KEY  (`id`))  DEFAULT CHARSET=utf8 ;
CREATE TABLE IF NOT EXISTS `changeset_tags` (  `id` bigint(64) NOT NULL,  `k` varchar(255) NOT NULL default '',  `v` varchar(255) NOT NULL default '',  KEY `changeset_tags_id_idx` (`id`)) DEFAULT CHARSET=utf8;
CREATE TABLE IF NOT EXISTS `current_nodes` (  `id` bigint(64) NOT NULL auto_increment,  `latitude` int(11) NOT NULL,  `longitude` int(11) NOT NULL,  `changeset_id` bigint(20) NOT NULL,  `visible` tinyint(1) NOT NULL,  `timestamp` datetime NOT NULL,  `tile` int(10) unsigned NOT NULL,  `version` bigint(20) NOT NULL,  PRIMARY KEY  (`id`),  KEY `current_nodes_timestamp_idx` (`timestamp`),  KEY `current_nodes_tile_idx` (`tile`),  KEY `changeset_id` (`changeset_id`))  DEFAULT CHARSET=utf8 ;
CREATE TABLE IF NOT EXISTS `current_node_tags` (  `id` bigint(64) NOT NULL,  `k` varchar(255) NOT NULL default '',  `v` varchar(255) NOT NULL default '',  PRIMARY KEY  (`id`,`k`)) DEFAULT CHARSET=utf8;
CREATE TABLE IF NOT EXISTS `current_relations` (  `id` bigint(64) NOT NULL auto_increment,  `changeset_id` bigint(20) NOT NULL,  `timestamp` datetime NOT NULL,  `visible` tinyint(1) NOT NULL,  `version` bigint(20) NOT NULL,  PRIMARY KEY  (`id`),  KEY `current_relations_timestamp_idx` (`timestamp`),  KEY `changeset_id` (`changeset_id`))  DEFAULT CHARSET=utf8 ;
CREATE TABLE IF NOT EXISTS `current_relation_members` (  `id` bigint(64) NOT NULL,  `member_type` enum('node','way','relation') NOT NULL default 'node',  `member_id` bigint(11) NOT NULL,  `member_role` varchar(255) NOT NULL default '',  `sequence_id` int(11) NOT NULL default '0',  PRIMARY KEY  (`id`,`member_type`,`member_id`,`member_role`,`sequence_id`),  KEY `current_relation_members_member_idx` (`member_type`,`member_id`)) DEFAULT CHARSET=utf8;
CREATE TABLE IF NOT EXISTS `current_relation_tags` (  `id` bigint(64) NOT NULL,  `k` varchar(255) NOT NULL default '',  `v` varchar(255) NOT NULL default '',  PRIMARY KEY  (`id`,`k`)) DEFAULT CHARSET=utf8;
CREATE TABLE IF NOT EXISTS `current_ways` (  `id` bigint(64) NOT NULL auto_increment,  `changeset_id` bigint(20) NOT NULL,  `timestamp` datetime NOT NULL,  `visible` tinyint(1) NOT NULL,  `version` bigint(20) NOT NULL,  PRIMARY KEY  (`id`),  KEY `current_ways_timestamp_idx` (`timestamp`),  KEY `changeset_id` (`changeset_id`))  DEFAULT CHARSET=utf8 ;
CREATE TABLE IF NOT EXISTS `current_way_nodes` (  `id` bigint(64) NOT NULL,  `node_id` bigint(64) NOT NULL,  `sequence_id` bigint(11) NOT NULL,  PRIMARY KEY  (`id`,`sequence_id`),  KEY `current_way_nodes_node_idx` (`node_id`)) DEFAULT CHARSET=utf8;
CREATE TABLE IF NOT EXISTS `current_way_tags` (  `id` bigint(64) NOT NULL,  `k` varchar(255) NOT NULL default '',  `v` varchar(255) NOT NULL default '',  PRIMARY KEY  (`id`,`k`)) DEFAULT CHARSET=utf8;
CREATE TABLE IF NOT EXISTS `diary_comments` (  `id` bigint(20) NOT NULL auto_increment,  `diary_entry_id` bigint(20) NOT NULL,  `user_id` bigint(20) NOT NULL,  `body` text NOT NULL,  `created_at` datetime NOT NULL,  `updated_at` datetime NOT NULL,  PRIMARY KEY  (`id`),  UNIQUE KEY `diary_comments_entry_id_idx` (`diary_entry_id`,`id`)) DEFAULT CHARSET=utf8 ;
CREATE TABLE IF NOT EXISTS `diary_entries` (  `id` bigint(20) NOT NULL auto_increment,  `user_id` bigint(20) NOT NULL,  `title` varchar(255) NOT NULL,  `body` text NOT NULL,  `created_at` datetime NOT NULL,  `updated_at` datetime NOT NULL,  `latitude` double default NULL,  `longitude` double default NULL,  `language` varchar(3) default NULL,  PRIMARY KEY  (`id`)) DEFAULT CHARSET=utf8 ;
CREATE TABLE IF NOT EXISTS `friends` (  `id` bigint(20) NOT NULL auto_increment,  `user_id` bigint(20) NOT NULL,  `friend_user_id` bigint(20) NOT NULL,  PRIMARY KEY  (`id`),  KEY `user_id_idx` (`friend_user_id`),  KEY `friends_user_id_idx` (`user_id`)) DEFAULT CHARSET=utf8 ;
CREATE TABLE IF NOT EXISTS `gps_points` (  `altitude` float default NULL,  `trackid` int(11) NOT NULL,  `latitude` int(11) NOT NULL,  `longitude` int(11) NOT NULL,  `gpx_id` bigint(64) NOT NULL,  `timestamp` datetime default NULL,  `tile` int(10) unsigned NOT NULL,  KEY `points_gpxid_idx` (`gpx_id`),  KEY `points_tile_idx` (`tile`)) DEFAULT CHARSET=utf8;
CREATE TABLE IF NOT EXISTS `gpx_files` (  `id` bigint(64) NOT NULL auto_increment,  `user_id` bigint(20) NOT NULL,  `visible` tinyint(1) NOT NULL default '1',  `name` varchar(255) NOT NULL default '',  `size` bigint(20) default NULL,  `latitude` double default NULL,  `longitude` double default NULL,  `timestamp` datetime NOT NULL,  `public` tinyint(1) NOT NULL default '1',  `description` varchar(255) NOT NULL default '',  `inserted` tinyint(1) NOT NULL,  PRIMARY KEY  (`id`),  KEY `gpx_files_timestamp_idx` (`timestamp`),  KEY `gpx_files_visible_public_idx` (`visible`,`public`),  KEY `gpx_files_user_id_idx` (`user_id`)) DEFAULT CHARSET=utf8 ;
CREATE TABLE IF NOT EXISTS `gpx_file_tags` (  `gpx_id` bigint(64) NOT NULL default '0',  `tag` varchar(255) NOT NULL,  `id` bigint(20) NOT NULL auto_increment,  PRIMARY KEY  (`id`),  KEY `gpx_file_tags_gpxid_idx` (`gpx_id`),  KEY `gpx_file_tags_tag_idx` (`tag`)) DEFAULT CHARSET=utf8 ;
CREATE TABLE IF NOT EXISTS `messages` (  `id` bigint(20) NOT NULL auto_increment,  `from_user_id` bigint(20) NOT NULL,  `title` varchar(255) NOT NULL,  `body` text NOT NULL,  `sent_on` datetime NOT NULL,  `message_read` tinyint(1) NOT NULL default '0',  `to_user_id` bigint(20) NOT NULL,  PRIMARY KEY  (`id`),  KEY `messages_to_user_id_idx` (`to_user_id`)) DEFAULT CHARSET=utf8 ;
CREATE TABLE IF NOT EXISTS `nodes` (  `id` bigint(64) NOT NULL,  `latitude` int(11) NOT NULL,  `longitude` int(11) NOT NULL,  `changeset_id` bigint(20) NOT NULL,  `visible` tinyint(1) NOT NULL,  `timestamp` datetime NOT NULL,  `tile` int(10) unsigned NOT NULL,  `version` bigint(20) NOT NULL,  PRIMARY KEY  (`id`,`version`),  KEY `nodes_timestamp_idx` (`timestamp`),  KEY `nodes_tile_idx` (`tile`),  KEY `changeset_id` (`changeset_id`)) DEFAULT CHARSET=utf8;
CREATE TABLE IF NOT EXISTS `node_tags` (  `id` bigint(64) NOT NULL,  `version` bigint(20) NOT NULL,  `k` varchar(255) NOT NULL default '',  `v` varchar(255) NOT NULL default '',  PRIMARY KEY  (`id`,`version`,`k`)) DEFAULT CHARSET=utf8;
CREATE TABLE IF NOT EXISTS `relations` (  `id` bigint(64) NOT NULL default '0',  `changeset_id` bigint(20) NOT NULL,  `timestamp` datetime NOT NULL,  `version` bigint(20) NOT NULL,  `visible` tinyint(1) NOT NULL default '1',  PRIMARY KEY  (`id`,`version`),  KEY `relations_timestamp_idx` (`timestamp`),  KEY `changeset_id` (`changeset_id`)) DEFAULT CHARSET=utf8;
CREATE TABLE IF NOT EXISTS `relation_members` (  `id` bigint(64) NOT NULL default '0',  `member_type` enum('node','way','relation') NOT NULL default 'node',  `member_id` bigint(11) NOT NULL,  `member_role` varchar(255) NOT NULL default '',  `version` bigint(20) NOT NULL default '0',  `sequence_id` int(11) NOT NULL default '0',  PRIMARY KEY  (`id`,`version`,`member_type`,`member_id`,`member_role`,`sequence_id`),  KEY `relation_members_member_idx` (`member_type`,`member_id`)) DEFAULT CHARSET=utf8;
CREATE TABLE IF NOT EXISTS `relation_tags` (  `id` bigint(64) NOT NULL default '0',  `k` varchar(255) NOT NULL default '',  `v` varchar(255) NOT NULL default '',  `version` bigint(20) NOT NULL,  PRIMARY KEY  (`id`,`version`,`k`)) DEFAULT CHARSET=utf8;
CREATE TABLE IF NOT EXISTS `schema_migrations` (  `version` varchar(255) NOT NULL,  UNIQUE KEY `unique_schema_migrations` (`version`)) DEFAULT CHARSET=utf8;
CREATE TABLE IF NOT EXISTS `sessions` (  `id` int(11) NOT NULL auto_increment,  `session_id` varchar(255) default NULL,  `data` text,  `created_at` datetime default NULL,  `updated_at` datetime default NULL,  PRIMARY KEY  (`id`),  UNIQUE KEY `sessions_session_id_idx` (`session_id`))  DEFAULT CHARSET=utf8 ;
CREATE TABLE IF NOT EXISTS `users` (  `email` varchar(255) NOT NULL,  `id` bigint(20) NOT NULL auto_increment,  `active` int(11) NOT NULL default '0',  `pass_crypt` varchar(255) NOT NULL,  `creation_time` datetime NOT NULL,  `display_name` varchar(255) NOT NULL default '',  `data_public` tinyint(1) NOT NULL default '0',  `description` text NOT NULL,  `home_lat` double default NULL,  `home_lon` double default NULL,  `home_zoom` smallint(6) default '3',  `nearby` int(11) default '50',  `pass_salt` varchar(255) default NULL,  `image` text,  `administrator` tinyint(1) NOT NULL default '0',  `email_valid` tinyint(1) NOT NULL default '0',  `new_email` varchar(255) default NULL,  `visible` tinyint(1) NOT NULL default '1',  `creation_ip` varchar(255) default NULL,  PRIMARY KEY  (`id`),  UNIQUE KEY `users_email_idx` (`email`),  UNIQUE KEY `users_display_name_idx` (`display_name`))  DEFAULT CHARSET=utf8 ;
CREATE TABLE IF NOT EXISTS `user_preferences` (  `user_id` bigint(20) NOT NULL,  `k` varchar(255) NOT NULL,  `v` varchar(255) NOT NULL,  PRIMARY KEY  (`user_id`,`k`)) DEFAULT CHARSET=utf8;
CREATE TABLE IF NOT EXISTS `user_tokens` (  `id` bigint(20) NOT NULL auto_increment,  `user_id` bigint(20) NOT NULL,  `token` varchar(255) NOT NULL,  `expiry` datetime NOT NULL,  PRIMARY KEY  (`id`),  UNIQUE KEY `user_tokens_token_idx` (`token`),  KEY `user_tokens_user_id_idx` (`user_id`)) DEFAULT CHARSET=utf8 ;
CREATE TABLE IF NOT EXISTS `ways` (  `id` bigint(64) NOT NULL default '0',  `changeset_id` bigint(20) NOT NULL,  `timestamp` datetime NOT NULL,  `version` bigint(20) NOT NULL,  `visible` tinyint(1) NOT NULL default '1',  PRIMARY KEY  (`id`,`version`),  KEY `ways_timestamp_idx` (`timestamp`),  KEY `changeset_id` (`changeset_id`)) DEFAULT CHARSET=utf8;
CREATE TABLE IF NOT EXISTS `way_nodes` (  `id` bigint(64) NOT NULL,  `node_id` bigint(64) NOT NULL,  `version` bigint(20) NOT NULL,  `sequence_id` bigint(11) NOT NULL,  PRIMARY KEY  (`id`,`version`,`sequence_id`),  KEY `way_nodes_node_idx` (`node_id`)) DEFAULT CHARSET=utf8;
CREATE TABLE IF NOT EXISTS `way_tags` (  `id` bigint(64) NOT NULL default '0',  `k` varchar(255) NOT NULL,  `v` varchar(255) NOT NULL,  `version` bigint(20) NOT NULL,  PRIMARY KEY  (`id`,`version`,`k`)) DEFAULT CHARSET=utf8;