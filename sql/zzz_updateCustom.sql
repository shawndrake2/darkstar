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

