-- MySQL dump 10.13  Distrib 8.0.31, for macos12.6 (arm64)
--
-- Host: localhost    Database: MNM
-- ------------------------------------------------------
-- Server version	8.0.31

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
-- Table structure for table `Category`
--

DROP TABLE IF EXISTS `Category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Category` (
  `categoryNo` int NOT NULL,
  `categoryName` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`categoryNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Category`
--

LOCK TABLES `Category` WRITE;
/*!40000 ALTER TABLE `Category` DISABLE KEYS */;
INSERT INTO `Category` VALUES (1,'한식'),(2,'중식'),(3,'일식'),(4,'양식'),(5,'기타');
/*!40000 ALTER TABLE `Category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Comment`
--

DROP TABLE IF EXISTS `Comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Comment` (
  `commentNo` int NOT NULL AUTO_INCREMENT,
  `commentText` varchar(100) NOT NULL,
  `commentTime` date NOT NULL,
  `userEmail` varchar(50) NOT NULL,
  `recipeNo` int NOT NULL,
  PRIMARY KEY (`commentNo`),
  KEY `userEmail` (`userEmail`),
  KEY `recipeNo` (`recipeNo`),
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`userEmail`) REFERENCES `User` (`email`),
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`recipeNo`) REFERENCES `Recipe` (`recipeNo`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Comment`
--

LOCK TABLES `Comment` WRITE;
/*!40000 ALTER TABLE `Comment` DISABLE KEYS */;
INSERT INTO `Comment` VALUES (1,'계란찜 맛있겠네용~','2022-12-12','qwe12023@naver.com',12),(2,'그러게용 ㅎㅎ','2022-12-12','qw1023@naber.com',12),(3,'안녕하세용 ㅎㅎ','2022-12-12','qw1023@naber.com',12),(4,'라면은 진리죠','2022-12-12','aslfn1@20ug.com',18),(5,'맛있겠다..','2022-12-12','gilmon718@gmail.com',17),(6,'??? 사진이 짤렷네여','2022-12-12','gilmon718@gmail.com',11),(7,'팔로우했습니다!','2022-12-12','gilmon718@gmail.com',12),(8,'맛잇겟다..','2022-12-12','gilmon718@gmail.com',14),(9,'정말 쉬운 요리네요!','2022-12-12','gilmon718@gmail.com',16),(10,'뽀글이먹고싶다..','2022-12-12','gilmon718@gmail.com',18),(11,'중복이신듯 ??','2022-12-12','gilmon718@gmail.com',19),(12,'감튀는 맥도날드!','2022-12-12','gilmon718@gmail.com',21),(13,'나의 군시절 아침을 먹게해주었던 쏘야.. 추억입니다','2022-12-12','gilmon718@gmail.com',15),(14,'된장물 아닌가요..?','2022-12-12','gilmon718@gmail.com',13),(15,'족발진짜꿀맛..','2022-12-12','gilmon718@gmail.com',26),(16,'ㅇㅈㅇㅈ 족발 짱맛','2022-12-12','aslfn1@20ug.com',26),(17,'이게계란말이지!!!! ','2022-12-12','gilmon718@gmail.com',29),(18,'저는 로제파스타가 좋아요 ^^','2022-12-12','gilmon718@gmail.com',31),(19,'그럼 그거 드세요','2022-12-12','wjf13@maber.com',31),(20,'저는 로제떡볶이가 좋아요 ^^','2022-12-12','wjf13@maber.com',20),(21,'','2022-12-12','jelly503@naver.com',28),(22,' 오 맛있겠다 근데 집에 스트링치즈가 없어요','2022-12-12','jelly503@naver.com',28),(23,'오 간단하니 저도 한번 도전해볼게요!','2022-12-17','jelly503@dongguk.edu',33),(24,'따끈하고 짭짤하니 맛있네요','2022-12-17','jelly503@dongguk.edu',33);
/*!40000 ALTER TABLE `Comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Ingredient`
--

DROP TABLE IF EXISTS `Ingredient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Ingredient` (
  `ingredientId` int NOT NULL AUTO_INCREMENT,
  `ingredientName` varchar(20) NOT NULL,
  `ingredientAmount` varchar(20) NOT NULL,
  `recipeNo` int NOT NULL,
  PRIMARY KEY (`ingredientId`),
  KEY `recipeNo` (`recipeNo`),
  CONSTRAINT `ingredient_ibfk_1` FOREIGN KEY (`recipeNo`) REFERENCES `Recipe` (`recipeNo`)
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Ingredient`
--

LOCK TABLES `Ingredient` WRITE;
/*!40000 ALTER TABLE `Ingredient` DISABLE KEYS */;
INSERT INTO `Ingredient` VALUES (9,'재료1','0',11),(10,'재료2','0',11),(12,'계란','0',12),(13,'된장','0',13),(14,'물','0',13),(15,'유자차','0',14),(16,'꿀','0',14),(17,'소시지','0',15),(18,'야채','0',15),(19,'부추','0',16),(20,'밀가루','0',16),(21,'계란','0',17),(22,'케첩','0',17),(23,'밥','0',17),(24,'맛소금','0',17),(25,'당근','0',17),(26,'계란','0',18),(27,'김치','0',18),(28,'라면','0',18),(29,'떡볶이떡','0',19),(30,'어묵','0',19),(31,'대파','0',19),(32,'설탕','0',19),(33,'고추장','0',19),(34,'간장','0',19),(35,'고춧가루','0',19),(36,'떡볶이떡','0',20),(37,'설탕','0',20),(38,'간장','0',20),(39,'고추장','0',20),(40,'고춧가루 ','0',20),(41,'대파','0',20),(42,'물','0',20),(43,'감자','0',21),(44,'기름','0',21),(45,'식용유','0',21),(46,'전분','0',21),(47,'소금','0',21),(48,'계란','0',23),(55,'닭가슴살','0',24),(56,'밥','0',24),(57,'김','0',24),(58,'한방음료','0',24),(59,'물 ','0',24),(60,'소금','0',24),(61,'오징어','0',25),(62,'통마늘','0',25),(63,'간장','0',25),(64,'올리고당','0',25),(65,'꽈리고추','0',25),(66,'생강','0',25),(67,'양파','0',26),(68,'당근','0',26),(69,'족발','0',26),(70,'파','0',26),(71,'간장','0',26),(72,'감자','0',27),(73,'돼지고기','0',27),(74,'대파','0',27),(75,'양파','0',27),(76,'부침가루','0',27),(77,'소금','0',27),(78,'A지방','0',27),(79,'감자과자','0',28),(80,'스트링치즈','0',28),(81,'체다치즈','0',28),(82,'모짜렐라치즈','0',28),(83,'계란, 당근, 대파, 소금','0',29),(84,'가지','0',30),(85,'설탕','0',30),(86,'다진마늘','0',30),(87,'간장','0',30),(88,'식초','0',30),(89,'버터','0',30),(90,'바질페스토','0',31),(91,'파스타면','0',31),(92,'소금','0',31),(93,'물','0',31),(94,'파마산치즈','0',31),(95,'마늘','0',31),(96,'올리브오일','0',31),(97,'마스카포네','0',32),(98,'커피','0',32),(99,'달걀','0',32),(100,'코코아파우더','0',32),(101,'물','0',32),(102,'생크림','0',32),(103,'에이스과자','0',32),(104,'설탕','0',32),(108,'떡볶이떡','0',33),(109,'파','0',33),(110,'고춧가루','0',33);
/*!40000 ALTER TABLE `Ingredient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Progress`
--

DROP TABLE IF EXISTS `Progress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Progress` (
  `progressId` int NOT NULL AUTO_INCREMENT,
  `progressOrder` int NOT NULL,
  `progressText` varchar(100) NOT NULL,
  `recipeNo` int NOT NULL,
  PRIMARY KEY (`progressId`),
  KEY `recipeNo` (`recipeNo`),
  CONSTRAINT `progress_ibfk_1` FOREIGN KEY (`recipeNo`) REFERENCES `Recipe` (`recipeNo`)
) ENGINE=InnoDB AUTO_INCREMENT=134 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Progress`
--

LOCK TABLES `Progress` WRITE;
/*!40000 ALTER TABLE `Progress` DISABLE KEYS */;
INSERT INTO `Progress` VALUES (25,1,'단계1',11),(26,2,'단계2',11),(27,3,'단계3',11),(29,1,'계란 까넣기',12),(30,1,'물 넣기',13),(31,2,'된장 풀기',13),(32,3,'끓이기',13),(33,1,'물을 끓인다.',14),(34,2,'꿀을 넣는다',14),(35,3,'유자차를 마신다 굿',14),(36,1,'쏘시지 넣기',15),(37,2,'야채 넣기',15),(38,1,'부추넣기',16),(39,1,'밥을 볶고',17),(40,2,'기름도 두르고',17),(41,3,'당근을 썰고 썰고',17),(42,4,'맛소금도 뿌리고',17),(43,1,'면 넣고',18),(44,2,'물을 넣고',18),(45,3,'끓여요 보글 보글',18),(46,1,'떡 400g 냄비에 넣기',19),(47,2,'물 종이컵으로 2컵 넣기(잠길정도로)',19),(48,3,'설탕 4큰술 넣기',19),(49,4,'간장 2큰술 넣기',19),(50,5,'고춧가루 1큰술 넣기',19),(51,6,'고추장 1큰술 듬뿍넣기',19),(52,7,'풀어주고 끓여주기(껄죽해지도록)',19),(53,8,'파 1컵 넣고 섞어주면 완성',19),(54,1,'떡 400g 냄비에 넣어주세요',20),(55,2,'물은 종이컵으로 2컵 넣어주세요',20),(56,3,'설탕 4큰술 넣고',20),(57,4,'간장 2큰술 넣고',20),(58,5,'고춧가루 1큰술 넣고',20),(59,6,'고추장 1큰술 듬뿍넣어서',20),(60,7,'끓여주기 (걸쭉해질때까지)',20),(61,8,'준비해둔 파를 1컵 넣어주세요.',20),(62,9,'섞어주면 완성!',20),(63,1,'감자를 벗긴다',21),(64,2,'감자를 채 썬다',21),(65,3,'기름을 달궈 튀긴다',21),(66,4,'소금을 뿌린다',21),(72,1,'너무나 맛있는 삶은 계란. 물을 끓인다.',23),(74,1,'닭가슴살은 잘게 찢고 밥은 전자레인지에 2분간 돌린다.',24),(75,2,'냄비에 한방음료, 잘게 찢은 닭, 밥을 넣고 끓인다.',24),(76,3,'죽의 농도가 날 때까지 끓인 후 그릇에 담고 김을 잘게 부셔 올려 완성한다.',24),(77,4,'기호에 따라 소금을 첨가한다.',24),(78,1,'반건조 오징이는 껍질을 벗겨 한입 크기로 썰어요.',25),(79,2,'통마늘과 생강은 채 썰고 꽈리고추는 꼭지를 제거하고 반 잘라 준비해요.',25),(80,3,'예열된 팬에 기름을 두르고 생강, 마늘을 넣어 볶아요.',25),(81,4,'간장, 물을 넣고 오징어를 넣어 볶아요.',25),(82,5,'꽈리고추를 넣어 볶은 후 올리고당, 참기름, 깨소금을 넣어 볶아 완성해요.',25),(83,1,'흐르는 물에 돼지 족을 씻어 핏물을 뺀다.',26),(84,2,'끓는 물에 간장을 붓고 양파와 파를 넣어 한소끔 끓인다.',26),(85,3,'위의 단계가 끝나면 돼지 족을 넣는다.',26),(86,4,'족이 말랑해지면 꺼내서 식힌다.',26),(87,5,'적당한 크기로 잘라 완성한다.',26),(88,6,'취향에 따라 소스를 곁들여 먹는다.',26),(89,1,'감자는 껍질을 벗겨 믹서기에 넣기 좋게 잘라요.	',27),(90,2,'대파는 송송 썰고 양파는 얇게 채 썰어 반 잘라 준비해요.',27),(91,3,'믹서기에 감자를 넣고 물을 약간 넣어 곱게 갈아요.',27),(92,4,'볼에 갈아놓은 감자, 돼지고기 다짐육, 대파, 양파, 부침가루, 소금을 넣어 섞어요.',27),(93,5,'팬에 A지방을 올려 기름을 내요.',27),(94,6,'기름이 어느 정도 나오면 감자전 반죽을 올려 앞뒤로 노릇하게 구워 완성해요.',27),(95,1,'그릇에 감자 과자를 담는다.',28),(96,2,'과자 위에 모짜렐라치즈를 뿌리고 스트링치즈, 체다치즈는 찢어 올린다.',28),(97,3,'전자레인지에 1분씩 2번 돌려 완성한다.',28),(98,1,'당근과 대파를 칼로 잘게 썬다',29),(99,2,'후라이팬에 기름을 두르고 달군다',29),(100,3,'계란을 풀고 잘게 썬 당근과 대파를 넣고 섞고 소금을 넣는다',29),(101,4,'계란물을 후라이팬에 붓는다',29),(102,5,'계란이 조금씩 익을 때마다 뒤집개로 조심히 만다',29),(103,1,'가지의 꼭지 부분은 자르고 통으로 두께 1~2cm 크기로 자른다.',30),(104,2,'자른 가지는 그릇에 담아 전자레인지에 4~5분 정도 돌린다.',30),(105,3,'간장, 설탕, 식초, 다진 마늘을 넣고 양념을 만든다.',30),(106,4,'팬에 버터를 넣고 가지를 약불에서 앞뒤로 굽는다.',30),(107,5,'가지의 수분이 빠지고 노릇해지면 양념을 바른다.',30),(108,6,'양념을 바른 가지는 약불에서 앞뒤로 굽는다',30),(109,1,'파스타면을 끓인다. 소금을 조금 넣어 면수 간을 맞춘다.',31),(110,2,'끓는동안 후라이팬에서 마늘을 올리브오일에 기름을 낸다.',31),(111,3,'면을 70%익힌 뒤 빼고, 면수 조금과 바질페스토를 후라이팬에 넣고 볶듯이 나머지를 익혀준다.',31),(112,4,'마지막으로 플레이팅한 뒤 파마산치즈를 뿌려주면 끝',31),(113,1,'커피 2숟가락, 설탕 2숟가락 넣어 물 150ml에 커피를 타서 만들어요.',32),(114,2,'에이스 과자를 커피물에 담가 으깨 준비해요.',32),(115,3,'달걀을 흰자 2개를 이용해 거품기로 머랭을 만들어요.',32),(116,4,'노른자 2개에 설탕 2숟가락을 넣어 설탕이 녹을 때 까지 저어 크림화를 만들어요.',32),(117,5,'크림화한 노른자에 마스카포네와 생크림을 넣고 섞어요.',32),(118,6,'머랭을 함께 섞어 크림을 만들어요.',32),(119,7,'컵에 커피에 으깬 에이스, 크림을 반복해 올려요.	',32),(120,8,'코코아 파우더를 뿌리고 슈가파우더를 조금 뿌려 완성해요.',32),(127,1,'대파는 송송 썬다.',33),(128,2,'팬에 기름을 두르고 떡을 굽듯이 볶는다.',33),(129,3,'송송 썬 대파를 넣고 함께 볶는다.',33),(130,4,'떡이 어느 정도 익으면 설탕을 넣는다.',33),(131,5,'가운데에 자리를 만들어 양념을 넣고 볶는다.',33),(132,6,'후추, 통깨를 뿌려 완성한다.',33),(133,7,'참기름을 조금 더 넣으면 근사한 떡볶이가 된다.',33);
/*!40000 ALTER TABLE `Progress` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipe`
--

DROP TABLE IF EXISTS `recipe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recipe` (
  `recipeNo` int NOT NULL AUTO_INCREMENT,
  `recipeName` varchar(20) NOT NULL,
  `recipeExplain` varchar(100) NOT NULL,
  `recipeCategory` int NOT NULL,
  `forNperson` int NOT NULL,
  `withInTime` int NOT NULL,
  `difficulty` int NOT NULL,
  `recipeUploadTime` date NOT NULL,
  `userEmail` varchar(50) NOT NULL,
  `filename` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`recipeNo`),
  KEY `recipeCategory` (`recipeCategory`),
  KEY `userEmail` (`userEmail`),
  CONSTRAINT `recipe_ibfk_1` FOREIGN KEY (`recipeCategory`) REFERENCES `Category` (`categoryNo`),
  CONSTRAINT `recipe_ibfk_2` FOREIGN KEY (`userEmail`) REFERENCES `User` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipe`
--

LOCK TABLES `recipe` WRITE;
/*!40000 ALTER TABLE `recipe` DISABLE KEYS */;
INSERT INTO `recipe` VALUES (11,'고수','얼큰! 칼칼!',1,1,1,1,'2022-12-11','qwe12023@naver.com',NULL),(12,'계란찜','몽글몽글 계란찜',1,1,1,1,'2022-12-12','qwe12023@naver.com','eggegg.jpg'),(13,'된장찌개','얼큰! 칼칼! 된장찌개!',1,3,1,2,'2022-12-12','qwe12023@naver.com','dj.jpg'),(14,'꿀 유자차 만들기','상콤달콤 꿀 유자차!',1,1,1,1,'2022-12-12','qwe12023@naver.com','KakaoTalk_Photo_2022-12-06-13-47-55.png'),(15,'쏘야','맛있어요',1,3,2,2,'2022-12-12','qwe12023@naver.com','쏘야.jpg'),(16,'부추전','부추전 맛있느 부춴',1,1,1,1,'2022-12-12','qwe12023@naver.com','bcj.jpg'),(17,'오므라이스','계란이 덮인 캐첩 폭폭 오므라이스',3,3,2,3,'2022-12-12','qw1023@naber.com','omraise.jpeg'),(18,'라면','보글보글 맛좋은 라면',5,1,1,1,'2022-12-12','aslfn1@20ug.com','ramen2.jpeg'),(19,'떡볶이','맵고 달달한 떡볶이입니다!',5,1,1,1,'2022-12-12','gilmon718@gmail.com','떡볶이.jpg'),(20,'맛있는 떡볶이','맵고 달달한 떡볶이입니다!',5,1,1,1,'2022-12-12','gilmon718@gmail.com','떡볶이2.jpg'),(21,'감자튀김','콜라와 먹으면 별미',4,2,1,2,'2022-12-12','asdfnn@aonf.com','frypotato1.jpeg'),(23,'삶은 계란','삶은 계란이다. 맛있다.',5,1,1,1,'2022-12-12','aslfn1@20ug.com','cookedegg.jpeg'),(24,'쌍화탕닭죽','만들면서 건강요리 만드는 느낌이 드는건 기분탓???',1,3,3,3,'2022-12-12','gilmon718@gmail.com','쌍화탕닭죽.jpg'),(25,'오징어조림','와 다른 반찬이 필요 없음 bb',1,3,2,3,'2022-12-12','gilmon718@gmail.com','오징어볶음.jpg'),(26,'집에서 족발 만들기','맛있는 족발! 이제 집에서도 만들어봐요~',1,4,4,3,'2022-12-12','jelly503@naver.com','foot1.jpeg'),(27,'감자전','두툼하게 부쳐낸 겉바속촉 감자전 ><',1,2,4,3,'2022-12-12','gilmon718@gmail.com','감자전1.jpg'),(28,'오지치즈후라이','편의점 꿀조합으로 오늘의 간식은 이거~!',5,1,1,3,'2022-12-12','gilmon718@gmail.com','후라이.jpg'),(29,'계란말이','매우 간단한 요리',1,1,1,1,'2022-12-12','sy981006@naver.com','계란말이.jpg'),(30,'가지 스테이크','가지로 만드는 스테이크입니다. ',1,2,1,2,'2022-12-12','gilmon718@gmail.com','가지슽.jpg'),(31,'바질파스타','향긋한 바질 파스타를 만들어볼게요',1,1,1,1,'2022-12-12','wjf13@maber.com','basil1.PNG'),(32,'티라미수','티라미수 레시피!',5,2,4,2,'2022-12-12','gilmon718@gmail.com','티라미수.jpg'),(33,'백종원 떡볶이','어묵이 들어가지 않아도 맛있는 백종원 떡볶이입니다~!',1,3,1,2,'2022-12-17','jelly503@dongguk.edu','testimage.jpeg');
/*!40000 ALTER TABLE `recipe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `email` varchar(50) NOT NULL,
  `nickname` varchar(10) NOT NULL,
  `id` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  `introduce` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('asdfnn@aonf.com','김민수','qw1023','qw1023',NULL),('aslfn1@20ug.com','고진원','qe13','qe13',NULL),('gilmon718@gmail.com','조영재','조영재','dada1963',NULL),('jelly503@dongguk.edu','삼순','samsoon','1234','먹는거 좋아함'),('jelly503@naver.com','onghe','onghe123','1234',NULL),('qw1023@naber.com','재원재원','qw12','qw12','나는 최고! 안녕 나는 최고!나는 최고! 안녕 나는 최고!'),('qwe12023@naver.com','삼순','qwe123','qwe123','삼순이 최고'),('sy981006@naver.com','김미영','popikusa','8e1220',''),('wjf13@maber.com','붕어빵','qnd','931122','팥붕.');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User_Follow`
--

DROP TABLE IF EXISTS `User_Follow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `User_Follow` (
  `follower` varchar(20) NOT NULL,
  `followee` varchar(20) NOT NULL,
  PRIMARY KEY (`follower`,`followee`),
  KEY `followee` (`followee`),
  CONSTRAINT `user_follow_ibfk_1` FOREIGN KEY (`follower`) REFERENCES `User` (`email`),
  CONSTRAINT `user_follow_ibfk_2` FOREIGN KEY (`followee`) REFERENCES `User` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User_Follow`
--

LOCK TABLES `User_Follow` WRITE;
/*!40000 ALTER TABLE `User_Follow` DISABLE KEYS */;
INSERT INTO `User_Follow` VALUES ('jelly503@dongguk.edu','asdfnn@aonf.com'),('aslfn1@20ug.com','qwe12023@naver.com'),('qw1023@naber.com','qwe12023@naver.com'),('gilmon718@gmail.com','wjf13@maber.com');
/*!40000 ALTER TABLE `User_Follow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User_Scrap`
--

DROP TABLE IF EXISTS `User_Scrap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `User_Scrap` (
  `recipeNo` int NOT NULL,
  `userEmail` varchar(50) NOT NULL,
  PRIMARY KEY (`recipeNo`,`userEmail`),
  KEY `userEmail` (`userEmail`),
  CONSTRAINT `user_scrap_ibfk_1` FOREIGN KEY (`recipeNo`) REFERENCES `Recipe` (`recipeNo`),
  CONSTRAINT `user_scrap_ibfk_2` FOREIGN KEY (`userEmail`) REFERENCES `User` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User_Scrap`
--

LOCK TABLES `User_Scrap` WRITE;
/*!40000 ALTER TABLE `User_Scrap` DISABLE KEYS */;
INSERT INTO `User_Scrap` VALUES (12,'aslfn1@20ug.com'),(21,'jelly503@dongguk.edu'),(12,'qw1023@naber.com'),(16,'qw1023@naber.com'),(12,'qwe12023@naver.com');
/*!40000 ALTER TABLE `User_Scrap` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-12-17 21:06:04
