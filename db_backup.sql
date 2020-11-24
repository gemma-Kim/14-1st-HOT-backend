-- MySQL dump 10.13  Distrib 8.0.22, for osx10.15 (x86_64)
--
-- Host: localhost    Database: hot
-- ------------------------------------------------------
-- Server version	8.0.22

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `additional_products`
--

DROP TABLE IF EXISTS `additional_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `additional_products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `main_product_id` int NOT NULL,
  `sub_product_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `additional_products_main_product_id_1e6dba6f_fk_product_d` (`main_product_id`),
  KEY `additional_products_sub_product_id_41a2d7c1_fk_product_d` (`sub_product_id`),
  CONSTRAINT `additional_products_main_product_id_1e6dba6f_fk_product_d` FOREIGN KEY (`main_product_id`) REFERENCES `product_details` (`id`),
  CONSTRAINT `additional_products_sub_product_id_41a2d7c1_fk_product_d` FOREIGN KEY (`sub_product_id`) REFERENCES `product_details` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=166 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `additional_products`
--

LOCK TABLES `additional_products` WRITE;
/*!40000 ALTER TABLE `additional_products` DISABLE KEYS */;
INSERT INTO `additional_products` VALUES (1,1,48),(2,1,49),(3,1,50),(4,1,51),(5,1,52),(6,1,53),(7,1,54),(8,1,55),(9,1,56),(10,1,57),(11,1,58),(12,2,48),(13,2,49),(14,2,50),(15,2,51),(16,2,52),(17,2,53),(18,2,54),(19,2,55),(20,2,56),(21,2,57),(22,2,58),(23,3,48),(24,3,49),(25,3,50),(26,3,51),(27,3,52),(28,3,53),(29,3,54),(30,3,55),(31,3,56),(32,3,57),(33,3,58),(34,4,48),(35,4,49),(36,4,50),(37,4,51),(38,4,52),(39,4,53),(40,4,54),(41,4,55),(42,4,56),(43,4,57),(44,4,58),(45,5,48),(46,5,49),(47,5,50),(48,5,51),(49,5,52),(50,5,53),(51,5,54),(52,5,55),(53,5,56),(54,5,57),(55,5,58),(56,6,48),(57,6,49),(58,6,50),(59,6,51),(60,6,52),(61,6,53),(62,6,54),(63,6,55),(64,6,56),(65,6,57),(66,6,58),(67,7,48),(68,7,49),(69,7,50),(70,7,51),(71,7,52),(72,7,53),(73,7,54),(74,7,55),(75,7,56),(76,7,57),(77,7,58),(78,8,48),(79,8,49),(80,8,50),(81,8,51),(82,8,52),(83,8,53),(84,8,54),(85,8,55),(86,8,56),(87,8,57),(88,8,58),(89,9,48),(90,9,49),(91,9,50),(92,9,51),(93,9,52),(94,9,53),(95,9,54),(96,9,55),(97,9,56),(98,9,57),(99,9,58),(100,10,48),(101,10,49),(102,10,50),(103,10,51),(104,10,52),(105,10,53),(106,10,54),(107,10,55),(108,10,56),(109,10,57),(110,10,58),(111,11,48),(112,11,49),(113,11,50),(114,11,51),(115,11,52),(116,11,53),(117,11,54),(118,11,55),(119,11,56),(120,11,57),(121,11,58),(122,12,48),(123,12,49),(124,12,50),(125,12,51),(126,12,52),(127,12,53),(128,12,54),(129,12,55),(130,12,56),(131,12,57),(132,12,58),(133,13,48),(134,13,49),(135,13,50),(136,13,51),(137,13,52),(138,13,53),(139,13,54),(140,13,55),(141,13,56),(142,13,57),(143,13,58),(144,14,48),(145,14,49),(146,14,50),(147,14,51),(148,14,52),(149,14,53),(150,14,54),(151,14,55),(152,14,56),(153,14,57),(154,14,58),(155,15,48),(156,15,49),(157,15,50),(158,15,51),(159,15,52),(160,15,53),(161,15,54),(162,15,55),(163,15,56),(164,15,57),(165,15,58);
/*!40000 ALTER TABLE `additional_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carts`
--

DROP TABLE IF EXISTS `carts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `shipment` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `tracking_number` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `company` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `order_id` char(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `product_detail_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `carts_order_id_89a6b74a_fk_orders_uuid` (`order_id`),
  KEY `carts_product_detail_id_0b745a48_fk_product_details_id` (`product_detail_id`),
  CONSTRAINT `carts_order_id_89a6b74a_fk_orders_uuid` FOREIGN KEY (`order_id`) REFERENCES `orders` (`uuid`),
  CONSTRAINT `carts_product_detail_id_0b745a48_fk_product_details_id` FOREIGN KEY (`product_detail_id`) REFERENCES `product_details` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carts`
--

LOCK TABLES `carts` WRITE;
/*!40000 ALTER TABLE `carts` DISABLE KEYS */;
/*!40000 ALTER TABLE `carts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `menu_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `categories_menu_id_33730ae9_fk_menus_id` (`menu_id`),
  CONSTRAINT `categories_menu_id_33730ae9_fk_menus_id` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'소파/거실가구',1),(2,'침실가구',1),(3,'드레스룸',1),(4,'주방가구',1),(5,'학생/서재가구',1),(6,'수납가구',1),(7,'테이블',1),(8,'의자/스툴',1),(9,'유아동가구',1),(10,'침구',2),(11,'커튼/블라인드',2),(12,'카페트/러그',2),(13,'쿠션/방석',2),(14,'홈패브릭',2),(15,'주방패브릭',2),(16,'공예/취미',2),(17,'유아용패브릭',2),(18,'조명',3),(19,'시계',3),(20,'플라워/식물',3),(21,'홈겔러리',3),(22,'월데코/장식',3),(23,'캔들/디퓨져',3),(24,'장식소품',3),(25,'데스크/디자인문구',3),(26,'크리스마스',3),(27,'주방가전',4),(28,'생활가전',4),(29,'청소가전',4),(30,'이미용가전',4),(31,'음향/영상가전',4),(32,'계절가전',4),(33,'렌탈',4),(34,'수납장/서랍장',5),(35,'리빙박스/수납함',5),(36,'바구니/바스켓',5),(37,'행거',5),(38,'선반',5),(39,'옷것이/옷정리',5),(40,'화장대/테이블정리',5),(41,'현관/신발정리',5),(42,'욕실용품',6),(43,'수건/타월',6),(44,'청소용품',6),(45,'세탁용품',6),(46,'생필품',6),(47,'생활잡화',6),(48,'그릇/홈세트',7),(49,'국내도자기그릇',7),(50,'수저/커트러리',7),(51,'컵/잔/텀블러',7),(52,'냄비/프라이팬',7),(53,'조리도구/도마',7),(54,'칼/커팅기구',7),(55,'주방수납/정리',7),(56,'식기건조대',7),(57,'보관/용기/도시락',7),(58,'주방잡화',7),(59,'커피용품/베이킹',7),(60,'수입주방용품',7),(61,'페인트/부자재',8),(62,'벽지/시트지',8),(63,'바닥재',8),(64,'타일/파벽돌',8),(65,'목재',8),(66,'공구',8),(67,'몰딩/걸레받이',8),(68,'가구부속품',8),(69,'손잡이/방문/유리',8),(70,'접착제/보수용품',8),(71,'수도/전기',8),(72,'디자이너키친',9),(73,'주방',9),(74,'종합시공',9),(75,'중문/도어',9),(76,'욕실',9),(77,'창호/폴딩도어',9),(78,'빌트인수납',9),(79,'철거/홈케어',9),(80,'페인트',9),(81,'마루',9),(82,'강아지 리빙',10),(83,'강아지 외출',10),(84,'강아지 위생/배변',10),(85,'강아지 미용/목욕',10),(86,'강아지 장난감',10),(87,'강아지 패션',10),(88,'강아지 푸드',10),(89,'고양이 리빙',10),(90,'고양이 위생/배변',10),(91,'고양이 미용/목욕',10),(92,'고양이 장난감',10),(93,'고양이 패션/외출',10),(94,'고양이 푸드',10),(95,'관상어',10),(96,'캠핑가구',11),(97,'캠핑주방용품',11),(98,'캠핑생활용품',11);
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `collection_bookmarks`
--

DROP TABLE IF EXISTS `collection_bookmarks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `collection_bookmarks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `collection_id` int NOT NULL,
  `user_id` int NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `collection_bookmarks_collection_id_9b8b06a3_fk_collections_id` (`collection_id`),
  KEY `collection_bookmarks_user_id_408c62f1_fk_users_id` (`user_id`),
  CONSTRAINT `collection_bookmarks_collection_id_9b8b06a3_fk_collections_id` FOREIGN KEY (`collection_id`) REFERENCES `collections` (`id`),
  CONSTRAINT `collection_bookmarks_user_id_408c62f1_fk_users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `collection_bookmarks`
--

LOCK TABLES `collection_bookmarks` WRITE;
/*!40000 ALTER TABLE `collection_bookmarks` DISABLE KEYS */;
/*!40000 ALTER TABLE `collection_bookmarks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `collections`
--

DROP TABLE IF EXISTS `collections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `collections` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `seller_id` int DEFAULT NULL,
  `sub_category_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `collections_seller_id_0d3d6583_fk_sellers_id` (`seller_id`),
  KEY `collections_sub_category_id_f46f7beb_fk_sub_categories_id` (`sub_category_id`),
  CONSTRAINT `collections_seller_id_0d3d6583_fk_sellers_id` FOREIGN KEY (`seller_id`) REFERENCES `sellers` (`id`),
  CONSTRAINT `collections_sub_category_id_f46f7beb_fk_sub_categories_id` FOREIGN KEY (`sub_category_id`) REFERENCES `sub_categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `collections`
--

LOCK TABLES `collections` WRITE;
/*!40000 ALTER TABLE `collections` DISABLE KEYS */;
INSERT INTO `collections` VALUES (1,'연두퍼니쳐 3중침대(SS/Q)',1,6),(2,'민짱 침대 풀세트(S/SS/D/Q/K)',2,6),(3,'모던 승윤 디자인 원목 컬랙션',4,6),(4,'뮤즈 가구 침대 컬랙션',5,6),(5,'공주들을 위한 침대 컬랙션',6,6),(6,'혁명적인 공부를 위한 책상 컬랙션',7,22),(7,'정규표현 데스크의 기준모음',8,22),(8,'장고공부는 여기서 데스크',9,22),(9,'두연을 거꾸로하면 연두 데스크 모음',1,22),(10,'정시에 민짱 기상시킨다 시계 모음',2,94),(11,'노드는 실시간에 강하다시계 모음',3,94),(12,'시키면 승윤이 만들어 준다시계 모음',4,94),(13,'뮤직듣기 좋은 소파 컬렉션',5,1),(14,'공주도 여기서 잔다 소파 컬랙션',6,1),(15,'혁명적인 휴식을 위한 소파 컬랙션',7,1),(16,'장고 공부하다 이거 덥고 자면 딱 모음',9,44),(17,'연두네 이불 모음 ',1,44),(18,'영국에서 가져온 이불 되판다 모음 ',2,44);
/*!40000 ALTER TABLE `collections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `colors`
--

DROP TABLE IF EXISTS `colors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `colors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `colors`
--

LOCK TABLES `colors` WRITE;
/*!40000 ALTER TABLE `colors` DISABLE KEYS */;
INSERT INTO `colors` VALUES (1,'아이보리'),(2,'블랙'),(3,'화이트'),(4,'파스텔블루'),(5,'베이비핑크');
/*!40000 ALTER TABLE `colors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `content` longtext COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `author_id` int NOT NULL,
  `parent_id` int NOT NULL,
  `post_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `comments_author_id_7a23bb5d_fk_users_id` (`author_id`),
  KEY `comments_parent_id_d317363b_fk_comments_id` (`parent_id`),
  KEY `comments_post_id_67cfce36_fk_posts_id` (`post_id`),
  CONSTRAINT `comments_author_id_7a23bb5d_fk_users_id` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`),
  CONSTRAINT `comments_parent_id_d317363b_fk_comments_id` FOREIGN KEY (`parent_id`) REFERENCES `comments` (`id`),
  CONSTRAINT `comments_post_id_67cfce36_fk_posts_id` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `model` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'contenttypes','contenttype'),(30,'order','cart'),(29,'order','order'),(28,'order','status'),(3,'post','comment'),(4,'post','post'),(5,'post','postimage'),(6,'post','posttag'),(8,'post','productinpost'),(7,'post','tag'),(19,'product','additionalproduct'),(9,'product','category'),(10,'product','collection'),(20,'product','color'),(11,'product','menu'),(12,'product','product'),(18,'product','productdetail'),(17,'product','productimage'),(16,'product','review'),(13,'product','seller'),(15,'product','share'),(21,'product','size'),(14,'product','subcategory'),(2,'sessions','session'),(27,'user','collectionbookmark'),(26,'user','follow'),(25,'user','like'),(24,'user','postbookmark'),(23,'user','productbookmark'),(22,'user','user');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2020-11-22 13:39:14.782244'),(2,'contenttypes','0002_remove_content_type_name','2020-11-22 13:39:14.817194'),(3,'user','0001_initial','2020-11-22 13:39:14.828800'),(4,'product','0001_initial','2020-11-22 13:39:15.071105'),(5,'post','0001_initial','2020-11-22 13:39:15.298401'),(6,'user','0002_auto_20201118_1544','2020-11-22 13:39:15.584050'),(7,'user','0003_auto_20201118_1924','2020-11-22 13:39:15.836603'),(8,'user','0004_auto_20201118_2028','2020-11-22 13:39:15.969478'),(9,'order','0001_initial','2020-11-22 13:39:16.024638'),(10,'post','0002_auto_20201118_1544','2020-11-22 13:39:16.358432'),(11,'post','0003_auto_20201122_0033','2020-11-22 13:39:16.374714'),(12,'product','0002_auto_20201120_1750','2020-11-22 13:39:16.424998'),(13,'product','0003_auto_20201120_1752','2020-11-22 13:39:16.532902'),(14,'product','0004_auto_20201120_1755','2020-11-22 13:39:16.625678'),(15,'product','0005_auto_20201122_0029','2020-11-22 13:39:16.825451'),(16,'product','0006_auto_20201122_0033','2020-11-22 13:39:16.868184'),(17,'product','0007_auto_20201122_0043','2020-11-22 13:39:16.938667'),(18,'product','0008_auto_20201122_2227','2020-11-22 13:39:17.028426'),(19,'sessions','0001_initial','2020-11-22 13:39:17.042275'),(20,'user','0005_collectionbookmark','2020-11-22 13:39:17.071802'),(21,'user','0006_auto_20201122_2235','2020-11-22 13:39:17.276959'),(22,'product','0009_auto_20201123_1117','2020-11-23 02:18:11.281809');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `session_data` longtext COLLATE utf8mb4_general_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `follows`
--

DROP TABLE IF EXISTS `follows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `follows` (
  `id` int NOT NULL AUTO_INCREMENT,
  `followee_id` int NOT NULL,
  `follower_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `follows_followee_id_6accedd4_fk_users_id` (`followee_id`),
  KEY `follows_follower_id_63fa6a23_fk_users_id` (`follower_id`),
  CONSTRAINT `follows_followee_id_6accedd4_fk_users_id` FOREIGN KEY (`followee_id`) REFERENCES `users` (`id`),
  CONSTRAINT `follows_follower_id_63fa6a23_fk_users_id` FOREIGN KEY (`follower_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `follows`
--

LOCK TABLES `follows` WRITE;
/*!40000 ALTER TABLE `follows` DISABLE KEYS */;
/*!40000 ALTER TABLE `follows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `likes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `post_id` int NOT NULL,
  `user_id` int NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `likes_post_id_84cc5834_fk_posts_id` (`post_id`),
  KEY `likes_user_id_0899754c_fk_users_id` (`user_id`),
  CONSTRAINT `likes_post_id_84cc5834_fk_posts_id` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`),
  CONSTRAINT `likes_user_id_0899754c_fk_users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menus`
--

DROP TABLE IF EXISTS `menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menus` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menus`
--

LOCK TABLES `menus` WRITE;
/*!40000 ALTER TABLE `menus` DISABLE KEYS */;
INSERT INTO `menus` VALUES (1,'가구'),(2,'패브릭'),(3,'홈데코/조명'),(4,'가전'),(5,'수납/정리'),(6,'생활'),(7,'주방'),(8,'DIY/공구'),(9,'인테리어시공'),(10,'반려동물'),(11,'캠핑용품');
/*!40000 ALTER TABLE `menus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `uuid` char(32) COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `orders_user_id_7e2523fb_fk_users_id` (`user_id`),
  CONSTRAINT `orders_user_id_7e2523fb_fk_users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_bookmarks`
--

DROP TABLE IF EXISTS `post_bookmarks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_bookmarks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `post_id` int NOT NULL,
  `user_id` int NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `post_bookmarks_post_id_ebbc9298_fk_posts_id` (`post_id`),
  KEY `post_bookmarks_user_id_c31fa900_fk_users_id` (`user_id`),
  CONSTRAINT `post_bookmarks_post_id_ebbc9298_fk_posts_id` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`),
  CONSTRAINT `post_bookmarks_user_id_c31fa900_fk_users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_bookmarks`
--

LOCK TABLES `post_bookmarks` WRITE;
/*!40000 ALTER TABLE `post_bookmarks` DISABLE KEYS */;
/*!40000 ALTER TABLE `post_bookmarks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_images`
--

DROP TABLE IF EXISTS `post_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_images` (
  `id` int NOT NULL AUTO_INCREMENT,
  `image_url` varchar(2000) COLLATE utf8mb4_general_ci NOT NULL,
  `post_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `post_images_post_id_de04fec2_fk_posts_id` (`post_id`),
  CONSTRAINT `post_images_post_id_de04fec2_fk_posts_id` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_images`
--

LOCK TABLES `post_images` WRITE;
/*!40000 ALTER TABLE `post_images` DISABLE KEYS */;
/*!40000 ALTER TABLE `post_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_tags`
--

DROP TABLE IF EXISTS `post_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_tags` (
  `id` int NOT NULL AUTO_INCREMENT,
  `post_id` int NOT NULL,
  `tag_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `post_posttag_post_id_907a5d66_fk_posts_id` (`post_id`),
  KEY `post_posttag_tag_id_280fa83d_fk_tags_id` (`tag_id`),
  CONSTRAINT `post_posttag_post_id_907a5d66_fk_posts_id` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`),
  CONSTRAINT `post_posttag_tag_id_280fa83d_fk_tags_id` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_tags`
--

LOCK TABLES `post_tags` WRITE;
/*!40000 ALTER TABLE `post_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `post_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `content` longtext COLLATE utf8mb4_general_ci,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `author_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `posts_author_id_099b8aca_fk_users_id` (`author_id`),
  CONSTRAINT `posts_author_id_099b8aca_fk_users_id` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_bookmarks`
--

DROP TABLE IF EXISTS `product_bookmarks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_bookmarks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `user_id` int NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_bookmarks_product_id_11010545_fk_products_id` (`product_id`),
  KEY `product_bookmarks_user_id_fc60afd3_fk_users_id` (`user_id`),
  CONSTRAINT `product_bookmarks_product_id_11010545_fk_products_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `product_bookmarks_user_id_fc60afd3_fk_users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_bookmarks`
--

LOCK TABLES `product_bookmarks` WRITE;
/*!40000 ALTER TABLE `product_bookmarks` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_bookmarks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_details`
--

DROP TABLE IF EXISTS `product_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `color_id` int NOT NULL,
  `product_id` int NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `size_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_details_product_id_ba410f7b_fk_products_id` (`product_id`),
  KEY `product_productdetail_color_id_3ddc0308` (`color_id`),
  KEY `product_details_size_id_44d25bd7_fk_sizes_id` (`size_id`),
  CONSTRAINT `product_details_product_id_ba410f7b_fk_products_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `product_details_size_id_44d25bd7_fk_sizes_id` FOREIGN KEY (`size_id`) REFERENCES `sizes` (`id`),
  CONSTRAINT `product_productdetail_color_id_3ddc0308_fk_product_color_id` FOREIGN KEY (`color_id`) REFERENCES `colors` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_details`
--

LOCK TABLES `product_details` WRITE;
/*!40000 ALTER TABLE `product_details` DISABLE KEYS */;
INSERT INTO `product_details` VALUES (1,1,1,152000.00,1),(2,1,1,239000.00,2),(3,1,1,321000.00,3),(4,1,1,489000.00,4),(5,2,1,152000.00,1),(6,2,1,239000.00,2),(7,2,1,321000.00,3),(8,2,1,489000.00,4),(9,3,1,152000.00,1),(10,3,1,239000.00,2),(11,3,1,321000.00,3),(12,3,1,489000.00,4),(13,4,1,152000.00,1),(14,4,1,239000.00,2),(15,4,1,321000.00,3),(16,4,1,489000.00,4),(17,5,1,152000.00,1),(18,5,1,239000.00,2),(19,5,1,321000.00,3),(20,5,1,489000.00,4),(21,2,2,432000.00,2),(22,3,3,239000.00,3),(23,4,4,286000.00,4),(24,5,5,552000.00,1),(25,1,6,351000.00,2),(26,2,7,231000.00,3),(27,3,8,524000.00,4),(28,4,9,321000.00,1),(29,5,10,193000.00,2),(30,1,11,238000.00,3),(31,2,12,489000.00,4),(32,3,13,294000.00,1),(33,4,14,432000.00,2),(34,5,15,112000.00,8),(35,1,16,152000.00,9),(36,2,17,432000.00,8),(37,3,18,239000.00,9),(38,4,19,286000.00,8),(39,5,20,552000.00,9),(40,1,21,351000.00,8),(41,2,22,231000.00,9),(42,3,23,524000.00,8),(43,4,24,321000.00,9),(44,5,25,193000.00,8),(45,1,26,238000.00,9),(46,2,27,489000.00,8),(47,3,28,294000.00,NULL),(48,4,29,432000.00,NULL),(49,5,30,112000.00,NULL),(50,1,31,152000.00,NULL),(51,2,32,432000.00,NULL),(52,3,33,239000.00,NULL),(53,4,34,286000.00,NULL),(54,5,35,552000.00,NULL),(55,1,36,351000.00,NULL),(56,2,37,231000.00,5),(57,3,38,524000.00,6),(58,4,39,321000.00,7),(59,5,40,193000.00,5),(60,1,41,238000.00,6),(61,2,42,489000.00,7),(62,3,43,294000.00,5),(63,4,44,432000.00,6),(64,5,45,112000.00,7),(65,1,46,152000.00,5),(66,2,47,432000.00,6),(67,3,48,239000.00,1),(68,4,49,286000.00,2),(69,5,50,552000.00,3),(70,1,51,351000.00,4),(71,2,52,231000.00,1),(72,3,53,524000.00,2),(73,4,54,321000.00,3),(74,5,55,193000.00,4),(75,1,56,238000.00,1),(76,2,57,489000.00,2),(77,3,58,294000.00,3);
/*!40000 ALTER TABLE `product_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_images`
--

DROP TABLE IF EXISTS `product_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_images` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_image_url` varchar(1000) COLLATE utf8mb4_general_ci NOT NULL,
  `product_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_images_product_id_28ebf5f0_fk_products_id` (`product_id`),
  CONSTRAINT `product_images_product_id_28ebf5f0_fk_products_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_images`
--

LOCK TABLES `product_images` WRITE;
/*!40000 ALTER TABLE `product_images` DISABLE KEYS */;
INSERT INTO `product_images` VALUES (1,'https://i1.wp.com/poshpennies.com/wp-content/uploads/2020/08/retro-hannah-bed-.jpg',1),(2,'https://cdn.remodelista.com/wp-content/uploads/2019/11/shou-sugi-ban-house-debbie-kropf-architecture-hotel-hamptons-long-island-new-york-3jpg-1466x1955.jpg',2),(3,'https://ak1.ostkcdn.com/images/products/is/images/direct/10cd4a8f18152bf66fc4d917d22f7bbeb1b9dfec/Carson-Carrington-Blaney-Queen-Solid-Pine-Wooden-Spindle-Bed.jpg',3),(4,'https://cdn.shopify.com/s/files/1/0396/8269/products/linen-venice-set-white-000.JPG?v=1591917282_1440x.jpg',4),(5,'https://imagens-revista.vivadecora.com.br/uploads/2020/01/decora%C3%A7%C3%A3o-simples-com-quadros-para-cabeceira-de-quarto-de-casal-Foto-Women-Shopping-1.jpg',5),(6,'https://dnwdt2n2p011ycoep3azqyo4-wpengine.netdna-ssl.com/wp-content/uploads/2019/01/1792DAC5-465E-4DB1-9716-0A2769BFE4E8.jpeg',6),(7,'https://images.unsplash.com/photo-1582582621959-48d27397dc69?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',7),(8,'https://images.unsplash.com/photo-1578898887932-dce23a595ad4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',8),(9,'https://images.unsplash.com/photo-1577509690643-15691207e526?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',9),(10,'https://images.unsplash.com/photo-1595327023008-bce2898309c0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=934&q=80',10),(11,'https://images.unsplash.com/photo-1582068019386-a943ee9287ae?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',11),(12,'https://images.unsplash.com/photo-1578898886615-0c4719f932dc?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',12),(13,'https://images.unsplash.com/photo-1596909690256-1072fc25b3c0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',13),(14,'https://images.unsplash.com/photo-1581299894303-5a293523369b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',14),(15,'https://images.unsplash.com/photo-1549488344-2974e706a17a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',15),(16,'https://images.unsplash.com/photo-1589884629038-b631346a23c0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=3300&q=80',16),(17,'https://images.unsplash.com/photo-1568052289438-e65932adc96b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2100&q=80',17),(18,'https://images.unsplash.com/photo-1587522384446-64daf3e2689a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1001&q=80',18),(19,'https://images.unsplash.com/photo-1603533842514-20a43accb5ec?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2389&q=80',19),(20,'https://images.unsplash.com/photo-1560890264-4b92305ee66e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2100&q=80',20),(21,'https://images.unsplash.com/photo-1549399905-5d1bad747576?ixlib=rb-1.2.1&auto=format&fit=crop&w=1361&q=80',21),(22,'https://images.unsplash.com/photo-1502810190503-8303352d0dd1?ixlib=rb-1.2.1&auto=format&fit=crop&w=2100&q=80',22),(23,'https://images.unsplash.com/photo-1584098854719-1fb56eb9a5a1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1867&q=80',23),(24,'https://images.unsplash.com/photo-1594614271360-0ed9a570ae15?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2100&q=80',24),(25,'https://images.unsplash.com/photo-1553414481-23cd8149e2c0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2100&q=80',25),(26,'https://images.unsplash.com/photo-1594849966511-77c211e68154?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2102&q=80',26),(27,'https://images.unsplash.com/photo-1587136527307-f53f514267d7?ixlib=rb-1.2.1&auto=format&fit=crop&w=966&q=80',27),(28,'https://images.unsplash.com/photo-1549190179-646f048c6108?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=934&q=80',28),(29,'https://images.unsplash.com/photo-1524678714210-9917a6c619c2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2098&q=80',29),(30,'https://images.unsplash.com/photo-1415604934674-561df9abf539?ixlib=rb-1.2.1&auto=format&fit=crop&w=1872&q=80',30),(31,'https://images.unsplash.com/photo-1602162786736-1575a5b1be76?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1399&q=80',31),(32,'https://images.unsplash.com/photo-1579551767446-b1698b970749?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=975&q=80',32),(33,'https://images.unsplash.com/photo-1511495551392-fc0270bbf22e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2100&q=80',33),(34,'https://images.unsplash.com/photo-1558395872-85709c6d3639?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80',34),(35,'https://images.unsplash.com/photo-1595001918824-83250c5f0599?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2100&q=80',35),(36,'https://images.unsplash.com/photo-1585586463948-9e40851ed193?ixlib=rb-1.2.1&auto=format&fit=crop&w=2100&q=80',36),(37,'https://images.unsplash.com/photo-1555041469-a586c61ea9bc',37),(38,'https://images.unsplash.com/photo-1540574163026-643ea20ade25',38),(39,'https://cdn.pixabay.com/photo/2013/09/21/14/30/sofa-184551_960_720.jpg',39),(40,'https://cdn.pixabay.com/photo/2013/09/21/14/30/sofa-184551_960_720.jpg',40),(41,'https://cdn.pixabay.com/photo/2020/03/08/07/13/table-4911613_960_720.jpg',41),(42,'https://cdn.pixabay.com/photo/2020/02/17/08/12/chair-4855824_960_720.jpg',42),(43,'https://unsplash.com/photos/E8ajXo0KIKM',43),(44,'https://unsplash.com/photos/sAtN5q4cJlM',44),(45,'https://unsplash.com/photos/d74sP6dnt_I',45),(46,'https://unsplash.com/photos/4sIGJHwnYH8',46),(47,'https://unsplash.com/photos/pBgxZgJ-QMo',47),(48,'https://unsplash.com/photos/PyPcHMt5q9Y',48),(49,'https://www.etsy.com/listing/785858837/mint-green-lattice-duvet-cover-set-100?epik=dj0yJnU9djZfLUtGeGdGVXJsS1N3cDV2aWxZTTBDWUtFYk1IZ1AmcD0wJm49UER3WkVhYVVGMVp0RzEyMWVlNDlCdyZ0PUFBQUFBRjk2dk0w&variation0=1329571216',49),(50,'https://unsplash.com/photos/rp82stTgKA0',50),(51,'https://unsplash.com/photos/ZKMThja-d40',51),(52,'https://unsplash.com/photos/sYzpra_fcpM',52),(53,'https://unsplash.com/photos/N3F5TnUWFhk',53),(54,'https://unsplash.com/photos/N3F5TnUWFhk',54),(55,'https://unsplash.com/photos/6_1kGQQGKss',55),(56,'https://unsplash.com/photos/3JoQTBn964Q',56),(57,'https://unsplash.com/photos/LpZMZXXpRcM',57),(58,'https://unsplash.com/photos/LpZMZXXpRcM',58);
/*!40000 ALTER TABLE `product_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_share`
--

DROP TABLE IF EXISTS `product_share`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_share` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_share_product_id_03687cf9_fk_products_id` (`product_id`),
  KEY `product_share_user_id_57241c1c_fk_user_user_id` (`user_id`),
  CONSTRAINT `product_share_product_id_03687cf9_fk_products_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `product_share_user_id_57241c1c_fk_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_share`
--

LOCK TABLES `product_share` WRITE;
/*!40000 ALTER TABLE `product_share` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_share` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `collection_id` int DEFAULT NULL,
  `seller_id` int DEFAULT NULL,
  `sub_category_id` int NOT NULL,
  `category_id` int NOT NULL,
  `menu_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `products_collection_id_3808ce0d_fk_collections_id` (`collection_id`),
  KEY `products_seller_id_76e92f9e_fk_sellers_id` (`seller_id`),
  KEY `products_sub_category_id_f08b7711_fk_sub_categories_id` (`sub_category_id`),
  KEY `products_category_id_a7a3a156_fk_categories_id` (`category_id`),
  KEY `products_menu_id_92765861_fk_menus_id` (`menu_id`),
  CONSTRAINT `products_category_id_a7a3a156_fk_categories_id` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  CONSTRAINT `products_collection_id_3808ce0d_fk_collections_id` FOREIGN KEY (`collection_id`) REFERENCES `collections` (`id`),
  CONSTRAINT `products_menu_id_92765861_fk_menus_id` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`),
  CONSTRAINT `products_seller_id_76e92f9e_fk_sellers_id` FOREIGN KEY (`seller_id`) REFERENCES `sellers` (`id`),
  CONSTRAINT `products_sub_category_id_f08b7711_fk_sub_categories_id` FOREIGN KEY (`sub_category_id`) REFERENCES `sub_categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'we코드 침대',1,1,6,1,1),(2,'아리보 침대',1,1,6,1,1),(3,'브랑스 침대',1,1,6,1,1),(4,'라리비 침대',2,2,6,1,1),(5,'시몽스 침대',2,2,6,1,1),(6,'힌들릐 침대',2,2,6,1,1),(7,'마리티 침대',4,5,6,1,1),(8,'스킨디 침대',4,5,6,1,1),(9,'엘카스르 침대',4,5,6,1,1),(10,'실버라인 침대',3,4,6,1,1),(11,'라르망 침대',3,4,6,1,1),(12,'아라시아 침대',3,4,6,1,1),(13,'소렌토 침대',5,6,6,1,1),(14,'가솔린 침대',5,6,6,1,1),(15,'아르매 침대',5,6,6,1,1),(16,'카르데 데스크',6,7,22,1,1),(17,'프라그미 데스크',6,7,22,1,1),(18,'코날 와이 데스크',6,7,22,1,1),(19,'잼마 데스크',7,8,22,1,1),(20,'아크마 데스크',7,8,22,1,1),(21,'위나스 데스크',7,8,22,1,1),(22,'리동식 혁명 데스크',8,9,22,1,1),(23,'오르카 데스크',8,9,22,1,1),(24,'여서밥노 데스크',8,9,22,1,1),(25,'ALLON 데스크',9,1,22,1,1),(26,'제이슨 토큰 데스크',9,1,22,1,1),(27,'련두 동무 데스크',9,1,22,1,1),(28,'민쨩 시계',10,2,94,1,1),(29,'공주노레잇 시계',10,2,94,1,1),(30,'플라이트 시계',10,2,94,1,1),(31,'북유럽 타이완 시계',11,3,94,1,1),(32,'헬로 아날로그 시계',11,3,94,1,1),(33,'벤자민 시계',11,3,94,1,1),(34,'루마니 시계',12,4,94,1,1),(35,'롤렉스 시계',12,4,94,1,1),(36,'무소음 시계',12,4,94,1,1),(37,'리반 소파',13,5,1,1,1),(38,'아구라 패브릭 소파',13,5,1,1,1),(39,'최고급 럭셔리 빈티지 소파',13,5,1,1,1),(40,'메이바비 소파',14,6,1,1,1),(41,'무빙 숄더 소파',14,6,1,1,1),(42,'하이스 소파',14,6,1,1,1),(43,'장수 돌 소파',15,7,1,1,1),(44,'오로라 소파',15,7,1,1,1),(45,'레이나 소파',15,7,1,1,1),(46,'바니바니 소파',NULL,8,1,1,1),(47,'당근당근 소파',NULL,8,1,1,1),(48,'세이비 침구',NULL,8,44,1,1),(49,'무비 차렵 이불',16,9,44,1,1),(50,'게드 알러지 케어 이불',16,9,44,1,1),(51,'말로우 캉캉 침구',16,9,44,1,1),(52,'고밀도 SQL 이불',17,1,44,1,1),(53,'에브리나잇 코튼 침구',17,1,44,1,1),(54,'댱고 디피컬트 침구',17,1,44,1,1),(55,'프랜드플라워 침구',18,2,44,1,1),(56,'내츄럴 모던 침구',18,2,44,1,1),(57,'마르코 침구',18,2,44,1,1),(58,'로맨틱 혁명 순면 침구',NULL,3,44,1,1);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products_in_posts`
--

DROP TABLE IF EXISTS `products_in_posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products_in_posts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `top_position` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `left_position` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `post_id` int NOT NULL,
  `product_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `products_in_posts_post_id_ffd8e959_fk_posts_id` (`post_id`),
  KEY `products_in_posts_product_id_7c3e8d4f_fk_products_id` (`product_id`),
  CONSTRAINT `products_in_posts_post_id_ffd8e959_fk_posts_id` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`),
  CONSTRAINT `products_in_posts_product_id_7c3e8d4f_fk_products_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products_in_posts`
--

LOCK TABLES `products_in_posts` WRITE;
/*!40000 ALTER TABLE `products_in_posts` DISABLE KEYS */;
/*!40000 ALTER TABLE `products_in_posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `id` int NOT NULL AUTO_INCREMENT,
  `content` longtext COLLATE utf8mb4_general_ci NOT NULL,
  `review_image` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `durability` decimal(1,1) NOT NULL,
  `afforability` decimal(1,1) NOT NULL,
  `design` decimal(1,1) NOT NULL,
  `delivery` decimal(1,1) NOT NULL,
  `author_id` int DEFAULT NULL,
  `product_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `reviews_author_id_6a4e9eab_fk_user_user_id` (`author_id`),
  KEY `reviews_product_id_d4b78cfe_fk_products_id` (`product_id`),
  CONSTRAINT `reviews_author_id_6a4e9eab_fk_user_user_id` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`),
  CONSTRAINT `reviews_product_id_d4b78cfe_fk_products_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sellers`
--

DROP TABLE IF EXISTS `sellers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sellers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sellers`
--

LOCK TABLES `sellers` WRITE;
/*!40000 ALTER TABLE `sellers` DISABLE KEYS */;
INSERT INTO `sellers` VALUES (1,'연두퍼니쳐'),(2,'민짱풀스택'),(3,'노드디자인'),(4,'모던승윤디자인'),(5,'뮤즈가구'),(6,'공주퍼니쳐'),(7,'S혁명가구'),(8,'RE엑트'),(9,'쟁고디자인');
/*!40000 ALTER TABLE `sellers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sizes`
--

DROP TABLE IF EXISTS `sizes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sizes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sizes`
--

LOCK TABLES `sizes` WRITE;
/*!40000 ALTER TABLE `sizes` DISABLE KEYS */;
INSERT INTO `sizes` VALUES (1,'싱글'),(2,'트윈'),(3,'퀸'),(4,'킹'),(5,'2인용'),(6,'4인용'),(7,'6인용'),(8,'100x200'),(9,'150x300');
/*!40000 ALTER TABLE `sizes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `statuses`
--

DROP TABLE IF EXISTS `statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `statuses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statuses`
--

LOCK TABLES `statuses` WRITE;
/*!40000 ALTER TABLE `statuses` DISABLE KEYS */;
/*!40000 ALTER TABLE `statuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sub_categories`
--

DROP TABLE IF EXISTS `sub_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sub_categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `category_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sub_categories_category_id_dc42080e_fk_categories_id` (`category_id`),
  CONSTRAINT `sub_categories_category_id_dc42080e_fk_categories_id` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sub_categories`
--

LOCK TABLES `sub_categories` WRITE;
/*!40000 ALTER TABLE `sub_categories` DISABLE KEYS */;
INSERT INTO `sub_categories` VALUES (1,'소파',1),(2,'리클라이너 소파',1),(3,'거실수납장/TV장',1),(4,'거실/소파테이블',1),(5,'의자',1),(6,'침대',2),(7,'매트리스',2),(8,'화장대/콘솔',2),(9,'서랍장',2),(10,'거울',2),(11,'협탁',2),(12,'드레스룸',3),(13,'옷장',3),(14,'행거',3),(15,'붙박이장',3),(16,'서랍장',3),(17,'식탁',4),(18,'홈바/아일랜드식탁',4),(19,'식탁/주방의자',4),(20,'주방수납',4),(21,'레인지대',4),(22,'책상',5),(23,'책장',5),(24,'학생/오피스의자',5),(25,'오피스수납용품',5),(26,'선반',6),(27,'수납장',6),(28,'진열장/장식장',6),(29,'쫘식테이블',7),(30,'사이드테이블',7),(31,'접이식테이블',7),(32,'아웃도어테이블',7),(33,'일반의자',8),(34,'좌식의자',8),(35,'안락의자/흔들의자',8),(36,'스툴',8),(37,'밴치',8),(38,'발받침',8),(39,'유아동책상/테이블',9),(40,'유아동수납',9),(41,'유아동소파/의자',9),(42,'유아동침대',9),(43,'유아동놀이기구외',9),(44,'침구세트',10),(45,'차렵이불',10),(46,'이불커버',10),(47,'이불솜',10),(48,'요/토퍼',10),(49,'배게커버/솜',10),(50,'바디필로우/롱쿠션',10),(51,'매트리스커버',10),(52,'홑이블/겹이불',10),(53,'패드/스프레드',10),(54,'암막커튼',11),(55,'일반커튼',11),(56,'레이스/속커튼',11),(57,'블라인드/롤스크린',11),(58,'가리개커튼',11),(59,'바린스/주방커튼',11),(60,'커튼부자재',11),(61,'캐노피',11),(62,'러그',12),(63,'샤기카페트',12),(64,'페르시안카페트',12),(65,'면/라틴/핸드메이드',12),(66,'발매트',12),(67,'주방/다용도매트',12),(68,'PVC/사이질록',12),(69,'놀이/안전매트',12),(70,'피크닉매트',12),(71,'원목/대자리/쿨매트',12),(72,'큐션',13),(73,'방석/대방석',13),(74,'쿠션/방석솜',13),(75,'담요/블랭킷',14),(76,'실내화',14),(77,'소파패드',14),(78,'소파커버',14),(79,'홈웨어',14),(80,'선풍기/에어컨커버',14),(81,'티슈커버',14),(82,'기타',14),(83,'공간별조명',18),(84,'LED평판등',18),(85,'팬던트등/포인트조명',18),(86,'레일조명',18),(87,'정스탠드',18),(88,'딘스텐드',18),(89,'데스크스탠드',18),(90,'벽조명',18),(91,'무드등/장식조명',18),(92,'매입등/센서등',18),(93,'형광등/조명부속품',18),(94,'일반시계',19),(95,'벽시계',19),(96,'알람/탁상시계',19),(97,'욕실방수시계',19),(98,'타이머/스탑워치',19),(99,'식물',20),(100,'조화',20),(101,'플라워',20),(102,'리스/가랜드',20),(103,'화병/화분',20),(104,'부케/화관/웨딩',20),(105,'기타가드닝용품',20),(106,'트레이/보석함',24),(107,'미니어처/DIY',24),(108,'모빌/가랜드',24),(109,'장식인형',24),(110,'마그넷/도어벨',24),(111,'워터볼',24),(112,'오르골',24),(113,'도어사인',24),(114,'파티/이벤트용품',24),(115,'기타장식용품',24);
/*!40000 ALTER TABLE `sub_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tags` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `email` varchar(254) COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(1000) COLLATE utf8mb4_general_ci NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `profile_image_url` varchar(1000) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-11-23 13:11:56
