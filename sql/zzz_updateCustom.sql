/*********************
 ** SERVER SPECIFIC **
 *********************/

/*
Update zoneip
!!!!! IF SERVER IP CHANGES, THIS WILL HAVE TO CHANGE AS WELL !!!!!
*/
LOCK TABLES `zone_settings` WRITE;
/*!40000 ALTER TABLE `zone_settings` DISABLE KEYS */;
UPDATE zone_settings SET zoneip = '45.55.137.245';
/*!40000 ALTER TABLE `zone_settings` ENABLE KEYS */;
UNLOCK TABLES;

/* echad ring */
LOCK TABLES `item_usable` WRITE;
/*!40000 ALTER TABLE `item_usable` DISABLE KEYS */;
UPDATE `item_usable` SET reuseDelay = 300 WHERE itemid = 27556;
/*!40000 ALTER TABLE `item_usable` ENABLE KEYS */;
UNLOCK TABLES;

