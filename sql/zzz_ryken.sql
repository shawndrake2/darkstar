/**************
 ** ACCOUNTS **
 **************/

/* Insert account info for server */
LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT IGNORE INTO `accounts` VALUES (1000,'ryken','*1FB4C5B3C86E9AF2D96D552E233FC218BA587298','','','2018-08-12 03:15:56','2018-08-12 03:16:18',16,4094,13,1,1);
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

/***********
 ** RYKEN **
 ***********/

--
-- Insert data for table `chars`
--

LOCK TABLES `chars` WRITE;
/*!40000 ALTER TABLE `chars` DISABLE KEYS */;
INSERT IGNORE INTO `chars` VALUES (21828,1000,'Ryken',0,230,230,224,-96.000,1.000,-40.000,0,0,230,224,-96.000,1.000,-40.000,NULL,NULL,NULL,NULL,'\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�������?\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�;\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',NULL,NULL,NULL,'\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0@\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0@\0\0\0\0\0\0\0',133,NULL,5,0,0,0,0,0);
/*!40000 ALTER TABLE `chars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Insert data for table `char_equip`
--

LOCK TABLES `char_equip` WRITE;
/*!40000 ALTER TABLE `char_equip` DISABLE KEYS */;
INSERT IGNORE INTO `char_equip` VALUES (21828,1,5,0),(21828,2,6,0),(21828,3,7,0),(21828,4,8,0);
/*!40000 ALTER TABLE `char_equip` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Insert data for table `char_exp`
--

LOCK TABLES `char_exp` WRITE;
/*!40000 ALTER TABLE `char_exp` DISABLE KEYS */;
INSERT IGNORE INTO `char_exp` VALUES (21828,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
/*!40000 ALTER TABLE `char_exp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Insert data for table `char_inventory`
--

LOCK TABLES `char_inventory` WRITE;
/*!40000 ALTER TABLE `char_inventory` DISABLE KEYS */;
INSERT IGNORE INTO `char_inventory` VALUES (21828,0,0,65535,1000,0,'',NULL),(21828,0,1,12637,1,0,'','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),(21828,0,2,12758,1,0,'','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),(21828,0,3,12888,1,0,'','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),(21828,0,4,13009,1,0,'','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),(21828,0,5,13184,1,0,'','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),(21828,0,6,536,1,0,'','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0');
/*!40000 ALTER TABLE `char_inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Insert data for table `char_jobs`
--

LOCK TABLES `char_jobs` WRITE;
/*!40000 ALTER TABLE `char_jobs` DISABLE KEYS */;
INSERT IGNORE INTO `char_jobs` VALUES (21828,126,50,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
/*!40000 ALTER TABLE `char_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Insert data for table `char_look`
--

LOCK TABLES `char_look` WRITE;
/*!40000 ALTER TABLE `char_look` DISABLE KEYS */;
INSERT IGNORE INTO `char_look` VALUES (21828,10,8,2,0,8,8,8,8,21,0,0);
/*!40000 ALTER TABLE `char_look` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Insert data for table `char_pet`
--

LOCK TABLES `char_pet` WRITE;
/*!40000 ALTER TABLE `char_pet` DISABLE KEYS */;
INSERT IGNORE INTO `char_pet` VALUES (21828,0,0,NULL,NULL,0,0);
/*!40000 ALTER TABLE `char_pet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Insert data for table `char_points`
--

LOCK TABLES `char_points` WRITE;
/*!40000 ALTER TABLE `char_points` DISABLE KEYS */;
INSERT IGNORE INTO `char_points` VALUES (21828,0,0,0,12582880,12582880,12582880,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
/*!40000 ALTER TABLE `char_points` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Insert data for table `char_profile`
--

LOCK TABLES `char_profile` WRITE;
/*!40000 ALTER TABLE `char_profile` DISABLE KEYS */;
INSERT IGNORE INTO `char_profile` VALUES (21828,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
/*!40000 ALTER TABLE `char_profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Insert data for table `char_recast`
--

LOCK TABLES `char_recast` WRITE;
/*!40000 ALTER TABLE `char_recast` DISABLE KEYS */;
INSERT IGNORE INTO `char_recast` VALUES (21828,0,1534048246,0);
/*!40000 ALTER TABLE `char_recast` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Insert data for table `char_stats`
--

LOCK TABLES `char_stats` WRITE;
/*!40000 ALTER TABLE `char_stats` DISABLE KEYS */;
INSERT IGNORE INTO `char_stats` VALUES (21828,76,0,0,0,2,0,0,0,206,NULL,0,1,0,0,0,0,0);
/*!40000 ALTER TABLE `char_stats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Insert data for table `char_storage`
--

LOCK TABLES `char_storage` WRITE;
/*!40000 ALTER TABLE `char_storage` DISABLE KEYS */;
INSERT IGNORE INTO `char_storage` VALUES (21828,30,50,0,30,30,80,80,80,80,80);
/*!40000 ALTER TABLE `char_storage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Insert data for table `char_style`
--

LOCK TABLES `char_style` WRITE;
/*!40000 ALTER TABLE `char_style` DISABLE KEYS */;
INSERT IGNORE INTO `char_style` VALUES (21828,0,0,0,0,0,0,0,0);
/*!40000 ALTER TABLE `char_style` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Insert data for table `char_vars`
--

LOCK TABLES `char_vars` WRITE;
/*!40000 ALTER TABLE `char_vars` DISABLE KEYS */;
INSERT IGNORE INTO `char_vars` VALUES (21828,'MoghouseExplication',1);
/*!40000 ALTER TABLE `char_vars` ENABLE KEYS */;
UNLOCK TABLES;
