-- MySQL dump 10.13  Distrib 8.0.22, for osx10.15 (x86_64)
--
-- Host: localhost    Database: adios
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
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `additional_products`
--

LOCK TABLES `additional_products` WRITE;
/*!40000 ALTER TABLE `additional_products` DISABLE KEYS */;
INSERT INTO `additional_products` VALUES (1,1,17),(2,1,29),(3,1,38),(4,1,49),(5,2,17),(6,2,29),(7,2,38),(8,2,49),(9,3,17),(10,3,29),(11,3,38),(12,3,49),(13,4,17),(14,4,29),(15,4,38),(16,4,49),(17,5,17),(18,5,29),(19,5,38),(20,5,49),(21,6,17),(22,6,29),(23,6,38),(24,6,49),(25,7,17),(26,7,29),(27,7,38),(28,7,49),(29,8,17),(30,8,29),(31,8,38),(32,8,49),(33,9,17),(34,9,29),(35,9,38),(36,9,49),(37,10,17),(38,10,29),(39,10,38),(40,10,49),(41,11,17),(42,11,29),(43,11,38),(44,11,49),(45,12,17),(46,12,29),(47,12,38),(48,12,49),(49,13,17),(50,13,29),(51,13,38),(52,13,49),(53,14,17),(54,14,29),(55,14,38),(56,14,49),(57,15,17),(58,15,29),(59,15,38),(60,15,49);
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
INSERT INTO `categories` VALUES (1,'소파/거실가구',1),(2,'침실가구',1),(3,'드레스룸',1),(4,'주방가구',1),(5,'학생/서재가구',1),(6,'수납가구',1),(7,'테이블',1),(8,'의자/스툴',1),(9,'유아동가구',1),(10,'침구',2),(11,'커튼/블라인드',2),(12,'카페트/러그',2),(13,'쿠션/방석',2),(14,'홈패브릭',2),(15,'주방패브릭',2),(16,'공예/취미',2),(17,'유아용패브릭',2),(18,'조명',3),(19,'시계',3),(20,'플라워/식물',3),(21,'홈겔러리',3),(22,'월데코/장식',3),(23,'캔들/디퓨져',3),(24,'장식소품',3),(25,'데스크/디자인문구',3),(26,'크리스마스',3),(27,'주방가전',4),(28,'생활가전',4),(29,'청소가전',4),(30,'이미용가전',4),(31,'음향/영상가전',4),(32,'계절가전',4),(33,'렌탈',4),(34,'수납장/서랍장',5),(35,'리빙박스/수납함',5),(36,'바구니/바스켓',5),(37,'행거',5),(38,'선반',5),(39,'옷것이/옷정리',5),(40,'화장대/테이블정리',5),(41,'현관/신발정리',5),(42,'욕실용품',6),(43,'수건/타월',6),(44,'청소용품',6),(45,'세탁용품',6),(46,'생필품',6),(47,'생활잡화',6),(48,'그릇/홈세트',7),(49,'국내도자기그릇',7),(50,'수저/커트러리',7),(51,'컵/잔/텀블러',7),(52,'냄비/프라이팬',7),(53,'조리도구/도마',7),(54,'칼/커팅기구',7),(55,'주방수납/정리',7),(56,'식기건조대',7),(57,'보관/용기/도시락',7),(58,'주방잡화',7),(59,'커피용품/베이킹',7),(60,'수입주방용품',7),(61,'페인트/부자재',8),(62,'벽지/시트지',8),(63,'바닥재',8),(64,'타일/파벽돌',8),(65,'목재',8),(66,'공구',8),(67,'몰딩/걸레받이',8),(68,'가구부속품',8),(69,'손잡이/방문/유리',8),(70,'접착제/보수용품',8),(71,'수도/전기',8),(72,'디자이너키친',8),(73,'주방',9),(74,'종합시공',9),(75,'중문/도어',9),(76,'욕실',9),(77,'창호/폴딩도어',9),(78,'빌트인수납',9),(79,'철거/홈케어',9),(80,'페인트',9),(81,'마루',9),(82,'강아지 리빙',10),(83,'강아지 외출',10),(84,'강아지 위생/배변',10),(85,'강아지 미용/목욕',10),(86,'강아지 장난감',10),(87,'강아지 패션',10),(88,'강아지 푸드',10),(89,'고양이 리빙',10),(90,'고양이 위생/배변',10),(91,'고양이 미용/목욕',10),(92,'고양이 장난감',10),(93,'고양이 패션/외출',10),(94,'고양이 푸드',10),(95,'관상어',10),(96,'캠핑가구',11),(97,'캠핑주방용품',11),(98,'캠핑생활용품',11);
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
INSERT INTO `collections` VALUES (1,'연두퍼니쳐 3중침대(SS/Q)',1,1),(2,'민짱 침대 풀세트(S/SS/D/Q/K)',2,1),(3,'모던 승윤 디자인 원목 컬랙션',4,1),(4,'뮤즈 가구 침대 컬랙션',5,1),(5,'공주들을 위한 침대 컬랙션',6,1),(6,'혁명적인 공부를 위한 책상 컬랙션',7,1),(7,'정규표현 데스크의 기준모음',8,1),(8,'장고공부는 여기서 데스크',9,1),(9,'두연을 거꾸로하면 연두 데스크 모음',1,1),(10,'정시에 민짱 기상시킨다 시계 모음',2,1),(11,'노드는 실시간에 강하다시계 모음',3,1),(12,'시키면 승윤이 만들어 준다시계 모음',4,1),(13,'뮤직듣기 좋은 소파 컬렉션',5,1),(14,'공주도 여기서 잔다 소파 컬랙션',6,1),(15,'혁명적인 휴식을 위한 소파 컬랙션',7,1),(16,'장고 공부하다 이거 덥고 자면 딱 모음',8,2),(17,'연두네 이불 모음 ',1,2),(18,'영국에서 가져온 이불 되판다 모음 ',2,2);
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
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'contenttypes','contenttype'),(31,'order','cart'),(30,'order','order'),(29,'order','status'),(3,'post','comment'),(4,'post','post'),(5,'post','postimage'),(6,'post','posttag'),(8,'post','productinpost'),(7,'post','tag'),(19,'product','additionalproduct'),(9,'product','category'),(10,'product','collection'),(20,'product','color'),(22,'product','colorset'),(11,'product','menu'),(12,'product','product'),(18,'product','productdetail'),(17,'product','productimage'),(16,'product','review'),(13,'product','seller'),(15,'product','share'),(21,'product','size'),(14,'product','subcategory'),(2,'sessions','session'),(28,'user','collectionbookmark'),(27,'user','follow'),(26,'user','like'),(25,'user','postbookmark'),(24,'user','productbookmark'),(23,'user','user');
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
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2020-11-24 06:43:33.962160'),(2,'contenttypes','0002_remove_content_type_name','2020-11-24 06:43:33.997327'),(3,'user','0001_initial','2020-11-24 06:43:34.012013'),(4,'product','0001_initial','2020-11-24 06:43:34.263591'),(5,'post','0001_initial','2020-11-24 06:43:34.492911'),(6,'user','0002_auto_20201118_1544','2020-11-24 06:43:34.788681'),(7,'user','0003_auto_20201118_1924','2020-11-24 06:43:35.049536'),(8,'user','0004_auto_20201118_2028','2020-11-24 06:43:35.182750'),(9,'order','0001_initial','2020-11-24 06:43:35.240013'),(10,'post','0002_auto_20201118_1544','2020-11-24 06:43:35.576058'),(11,'post','0003_auto_20201122_0033','2020-11-24 06:43:35.594058'),(12,'product','0002_auto_20201120_1750','2020-11-24 06:43:35.645836'),(13,'product','0003_auto_20201120_1752','2020-11-24 06:43:35.750746'),(14,'product','0004_auto_20201120_1755','2020-11-24 06:43:35.844767'),(15,'product','0005_auto_20201122_0029','2020-11-24 06:43:36.048303'),(16,'product','0006_auto_20201122_0033','2020-11-24 06:43:36.091936'),(17,'product','0007_auto_20201122_0043','2020-11-24 06:43:36.161901'),(18,'product','0008_auto_20201122_2227','2020-11-24 06:43:36.253363'),(19,'product','0009_auto_20201123_1117','2020-11-24 06:43:36.375265'),(20,'product','0010_auto_20201124_0852','2020-11-24 06:43:36.504791'),(21,'product','0011_auto_20201124_1310','2020-11-24 06:43:36.589801'),(22,'sessions','0001_initial','2020-11-24 06:43:36.640664'),(23,'user','0005_collectionbookmark','2020-11-24 06:43:36.673510'),(24,'user','0006_auto_20201122_2235','2020-11-24 06:43:36.891709');
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
-- Table structure for table `product_colorset`
--

DROP TABLE IF EXISTS `product_colorset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_colorset` (
  `id` int NOT NULL AUTO_INCREMENT,
  `color_id` int NOT NULL,
  `product_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_colorset_color_id_16244c58_fk_colors_id` (`color_id`),
  KEY `product_colorset_product_id_8aba688a_fk_products_id` (`product_id`),
  CONSTRAINT `product_colorset_color_id_16244c58_fk_colors_id` FOREIGN KEY (`color_id`) REFERENCES `colors` (`id`),
  CONSTRAINT `product_colorset_product_id_8aba688a_fk_products_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_colorset`
--

LOCK TABLES `product_colorset` WRITE;
/*!40000 ALTER TABLE `product_colorset` DISABLE KEYS */;
INSERT INTO `product_colorset` VALUES (1,1,1),(2,2,1),(3,3,1),(4,4,1),(5,5,1);
/*!40000 ALTER TABLE `product_colorset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_details`
--

DROP TABLE IF EXISTS `product_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `size_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_details_product_id_ba410f7b_fk_products_id` (`product_id`),
  KEY `product_details_size_id_44d25bd7_fk_sizes_id` (`size_id`),
  CONSTRAINT `product_details_product_id_ba410f7b_fk_products_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `product_details_size_id_44d25bd7_fk_sizes_id` FOREIGN KEY (`size_id`) REFERENCES `sizes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_details`
--

LOCK TABLES `product_details` WRITE;
/*!40000 ALTER TABLE `product_details` DISABLE KEYS */;
INSERT INTO `product_details` VALUES (1,1,152000.00,1),(2,1,239000.00,2),(3,1,321000.00,3),(4,1,489000.00,4),(5,2,432000.00,2),(6,3,239000.00,3),(7,4,286000.00,4),(8,5,552000.00,1),(9,6,351000.00,2),(10,7,231000.00,3),(11,8,524000.00,4),(12,9,321000.00,1),(13,10,193000.00,2),(14,11,238000.00,3),(15,12,489000.00,4),(16,13,294000.00,1),(17,14,432000.00,2),(18,15,112000.00,8),(19,16,152000.00,9),(20,17,432000.00,8),(21,18,239000.00,9),(22,19,286000.00,8),(23,20,552000.00,9),(24,21,351000.00,8),(25,22,231000.00,9),(26,23,524000.00,8),(27,24,321000.00,9),(28,25,193000.00,8),(29,26,238000.00,9),(30,27,489000.00,8),(31,28,294000.00,NULL),(32,29,432000.00,NULL),(33,30,112000.00,NULL),(34,31,152000.00,NULL),(35,32,432000.00,NULL),(36,33,239000.00,NULL),(37,34,286000.00,NULL),(38,35,552000.00,NULL),(39,36,351000.00,NULL),(40,37,231000.00,5),(41,38,524000.00,6),(42,39,321000.00,7),(43,40,193000.00,5),(44,41,238000.00,6),(45,42,489000.00,7),(46,43,294000.00,5),(47,44,432000.00,6),(48,45,112000.00,7),(49,46,152000.00,5),(50,47,432000.00,6),(51,48,239000.00,1),(52,49,286000.00,2),(53,50,552000.00,3),(54,51,351000.00,4),(55,52,231000.00,1),(56,53,524000.00,2),(57,54,321000.00,3),(58,55,193000.00,4),(59,56,238000.00,1),(60,57,489000.00,2),(61,58,294000.00,3);
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
INSERT INTO `products` VALUES (1,'we코드 침대',2,2,1,2,1),(2,'아리보 침대',2,2,1,2,1),(3,'브랑스 침대',2,2,1,2,1),(4,'라리비 침대',2,1,1,2,1),(5,'시몽스 침대',2,1,1,2,1),(6,'힌들릐 침대',1,1,1,2,1),(7,'마리티 침대',1,3,1,2,1),(8,'스킨디 침대',1,3,1,2,1),(9,'엘카스르 침대',4,3,1,2,1),(10,'실버라인 침대',4,4,1,2,1),(11,'라르망 침대',4,4,1,2,1),(12,'아라시아 침대',4,4,1,2,1),(13,'소렌토 침대',4,5,1,2,1),(14,'가솔린 침대',4,6,1,2,1),(15,'아르매 침대',4,6,1,2,1),(16,'카르데 데스크',6,6,2,5,1),(17,'프라그미 데스크',6,5,2,5,1),(18,'코날 와이 데스크',6,5,2,5,1),(19,'잼마 데스크',7,5,2,5,1),(20,'아크마 데스크',7,4,2,5,1),(21,'위나스 데스크',7,4,2,5,1),(22,'리동식 혁명 데스크',8,4,2,5,1),(23,'오르카 데스크',8,3,2,5,1),(24,'여서밥노 데스크',8,3,2,5,1),(25,'ALLON 데스크',8,3,2,5,1),(26,'제이슨 토큰 데스크',8,2,2,5,1),(27,'련두 동무 데스크',8,2,2,5,1),(28,'민쨩 시계',10,2,3,20,3),(29,'공주노레잇 시계',10,1,3,20,3),(30,'플라이트 시계',10,1,3,20,3),(31,'북유럽 타이완 시계',11,1,3,20,3),(32,'헬로 아날로그 시계',11,9,3,20,3),(33,'벤자민 시계',11,9,3,20,3),(34,'루마니 시계',12,9,3,20,3),(35,'롤렉스 시계',12,8,3,20,3),(36,'무소음 시계',12,8,3,20,3),(37,'리반 소파',13,8,4,1,1),(38,'아구라 패브릭 소파',13,7,4,1,1),(39,'최고급 럭셔리 빈티지 소파',13,7,4,1,1),(40,'메이바비 소파',14,7,4,1,1),(41,'무빙 숄더 소파',14,6,4,1,1),(42,'하이스 소파',14,6,4,1,1),(43,'장수 돌 소파',15,6,4,1,1),(44,'오로라 소파',15,5,4,1,1),(45,'레이나 소파',15,5,4,1,1),(46,'바니바니 소파',15,5,4,1,1),(47,'당근당근 소파',15,4,4,1,1),(48,'세이비 침구',16,4,5,11,1),(49,'무비 차렵 이불',16,4,5,11,2),(50,'게드 알러지 케어 이불',16,3,5,11,2),(51,'말로우 캉캉 침구',17,3,5,11,2),(52,'고밀도 SQL 이불',17,3,5,11,2),(53,'에브리나잇 코튼 침구',17,2,5,11,2),(54,'댱고 디피컬트 침구',18,2,5,11,2),(55,'프랜드플라워 침구',18,2,5,11,2),(56,'내츄럴 모던 침구',18,1,5,11,2),(57,'마르코 침구',16,1,5,11,2),(58,'로맨틱 혁명 순면 침구',16,1,5,11,2);
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
  `durability` decimal(2,1) NOT NULL,
  `afforability` decimal(2,1) NOT NULL,
  `design` decimal(2,1) NOT NULL,
  `delivery` decimal(2,1) NOT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sub_categories`
--

LOCK TABLES `sub_categories` WRITE;
/*!40000 ALTER TABLE `sub_categories` DISABLE KEYS */;
INSERT INTO `sub_categories` VALUES (1,'침대',2),(2,'책상',5),(3,'일반시계',19),(4,'소파',1),(5,'침구세트',10);
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

-- Dump completed on 2020-11-24 16:11:41
