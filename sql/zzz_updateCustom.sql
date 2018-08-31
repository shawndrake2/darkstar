/*********************
 ** SERVER SPECIFIC **
 *********************/

/*
/* echad ring */
LOCK TABLES `item_usable` WRITE;
/*!40000 ALTER TABLE `item_usable` DISABLE KEYS */;
UPDATE `item_usable` SET reuseDelay = 300 WHERE itemid = 27556;
/*!40000 ALTER TABLE `item_usable` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `server_variables` WRITE;
/*!40000 ALTER TABLE `server_variables` DISABLE KEYS */;
INSERT INTO `server_variables`(name, value)
VALUES('serverBuild', UNIX_TIMESTAMP())
ON DUPLICATE KEY UPDATE value = UNIX_TIMESTAMP();
/*!40000 ALTER TABLE `server_variables` ENABLE KEYS */;
UNLOCK TABLES;
