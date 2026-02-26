CREATE DATABASE  IF NOT EXISTS `vegmart` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `vegmart`;
-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: vegmart
-- ------------------------------------------------------
-- Server version	8.0.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `categoryId` int NOT NULL AUTO_INCREMENT,
  `categoryDescription` varchar(1000) DEFAULT NULL,
  `cImage` varchar(255) DEFAULT NULL,
  `categoryName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`categoryId`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (2,'Leafy vegetables, also known as leafy greens, are the edible leaves of plants, often including their petioles and shoots when tender. They are a cornerstone of a healthy diet, valued for being low in calories and high in essential nutrients like vitamins A, C, E, K, fiber, and various minerals','leafy4.png','Leafy Vegetables'),(3,'Root vegetables are edible plant parts that grow underground, absorbing nutrients from the soil, and include true roots, tubers, bulbs, and rhizomes. They are a good source of fiber, vitamins (such as A, B, and C), and antioxidants, and they are versatile in the kitchen, often prepared by roasting, boiling, or mashing, and are known for their long shelf life. ','root.png','Root Vegetables'),(4,'Fresh vegetables are nutrient-rich plants that are excellent sources of vitamins, minerals, and fiber, which support overall health and help reduce the risk of chronic diseases. They are generally low in calories and fat and are often eaten raw, cooked, or in dishes like soups and stews. Choosing fresh, in-season vegetables with bright colors and crisp textures ensures the best nutritional value and flavor. \r\n','fresh.png','Fresh vegetables'),(5,'Frozen vegetables are a healthy and convenient way to eat vegetables, often picked at peak ripeness and flash-frozen to preserve nutrients, making them nutritionally comparable to or even better than fresh in some cases. Key considerations include checking labels for added salt, sugar, or sauces, and understanding that some water-soluble vitamins may slightly decrease during the pre-freezing blanching process, though overall nutrient retention is high. They offer benefits like reduced food waste, year-round availability, and convenience since they are pre-cleaned and chopped. ','frozen.png','Frozen vegetables'),(6,'Exotic vegetables are non-native varieties that are becoming popular due to their unique flavors and high nutritional value. Examples include broccoli, zucchini, asparagus, and various lettuces, which are often grown in controlled environments like greenhouses to suit their specific climate needs. Their higher cost is due to limited production quantities, and they are used in salads, international cuisine, and as garnishes. \r\n','exotic.png','Exotic Vegetables'),(7,'Allium vegetables are a group of plants belonging to the Allium genus, including common varieties like garlic, onions, leeks, chives, and scallions. They are valued for their distinct flavors in cooking and have a history of use in traditional medicine for potential health benefits like antioxidant and anti-inflammatory effects. ','alliumm.png','Allium Vegetables');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_item`
--

DROP TABLE IF EXISTS `order_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_item` (
  `orderItemId` int NOT NULL AUTO_INCREMENT,
  `order_id` int DEFAULT NULL,
  `quantity` int NOT NULL,
  `vegetable_id` int DEFAULT NULL,
  PRIMARY KEY (`orderItemId`),
  KEY `FKt4dc2r9nbvbujrljv3e23iibt` (`order_id`),
  KEY `FK5yrmbqr3ei0jehkfxnee4muhp` (`vegetable_id`),
  CONSTRAINT `FK5yrmbqr3ei0jehkfxnee4muhp` FOREIGN KEY (`vegetable_id`) REFERENCES `vegetable` (`vegetableId`),
  CONSTRAINT `FKt4dc2r9nbvbujrljv3e23iibt` FOREIGN KEY (`order_id`) REFERENCES `orders` (`orderId`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_item`
--

LOCK TABLES `order_item` WRITE;
/*!40000 ALTER TABLE `order_item` DISABLE KEYS */;
INSERT INTO `order_item` VALUES (1,1,1,4),(2,1,1,5),(3,1,1,6),(4,2,1,4),(5,2,1,5),(6,2,1,6),(7,2,1,7),(20,7,4,5),(25,11,1,4),(42,23,7,4),(43,23,7,7),(48,27,1,4),(49,28,1,12),(52,31,1,9),(53,32,1,11),(54,33,2,4),(55,33,1,5),(56,34,1,5),(57,35,1,5),(58,36,1,5),(59,37,1,6),(60,37,1,11),(61,38,1,5),(62,38,1,6),(63,39,10,18),(64,39,9,6),(65,40,33,5),(66,41,1,5),(67,41,1,7),(68,42,1,14),(69,43,1,14),(70,44,1,14),(71,45,1,14),(72,46,1,14),(73,47,1,7),(74,48,1,6),(75,49,1,6),(76,49,1,7),(77,50,1,13),(78,51,1,7),(79,52,1,7),(80,53,2,5),(81,54,1,7),(82,55,1,5),(83,56,1,6),(84,56,1,7),(85,57,1,6),(86,57,1,7),(87,58,2,6);
/*!40000 ALTER TABLE `order_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `buyer_id` int DEFAULT NULL,
  `orderId` int NOT NULL AUTO_INCREMENT,
  `totalAmount` double NOT NULL,
  `orderDate` datetime(6) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `paymentMode` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`orderId`),
  KEY `FKhtx3insd5ge6w486omk4fnk54` (`buyer_id`),
  CONSTRAINT `FKhtx3insd5ge6w486omk4fnk54` FOREIGN KEY (`buyer_id`) REFERENCES `users` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,1,93.55,'2025-12-07 19:26:58.155000','Order Delivered','COD'),(1,2,122.95,'2025-12-07 19:32:23.393000','Out for Delivery','ONLINE'),(1,7,111.4,'2025-12-07 21:42:24.830000','Order Received','ONLINE'),(1,11,54.7,'2025-12-08 14:26:00.564000','Order Processing','COD'),(1,23,348.7,'2025-12-10 15:00:28.692000','Order Packed','COD'),(1,27,54.7,'2025-12-10 15:12:05.882000','Order processing','COD'),(1,28,79.9,'2025-12-10 15:13:02.970000','Out for Delivery','ONLINE'),(1,31,54.7,'2025-12-11 10:34:00.002000','Order Processing','ONLINE'),(1,32,70.45,'2025-12-11 10:43:34.169000','Order processing','ONLINE'),(1,33,87.25,'2025-12-11 15:11:53.636000','Order Processing','COD'),(1,34,57.85,'2025-12-11 15:21:39.688000','Order Processing','COD'),(1,35,57.85,'2025-12-11 15:24:33.188000','Order Processing','ONLINE'),(1,36,57.85,'2025-12-11 15:25:00.135000','Order Packed','COD'),(1,37,91.45,'2025-12-23 19:43:10.357000','Order processing','COD'),(11,38,78.85,'2025-12-24 13:56:43.569000','Order processing','COD'),(1,39,271,'2025-12-24 14:09:49.725000','Order processing','COD'),(11,40,589.05,'2025-12-28 12:53:59.872000','Out for Delivery','COD'),(11,41,87.25,'2025-12-28 15:39:00.893000','Order Processing','ONLINE'),(11,42,70.45,'2025-12-28 16:24:51.881000','Order Processing','ONLINE'),(11,43,70.45,'2025-12-28 16:26:55.444000','Order Processing','ONLINE'),(11,44,70.45,'2025-12-28 16:33:08.374000','Order Processing','ONLINE'),(11,45,70.45,'2025-12-28 16:47:32.564000','Order Processing','ONLINE'),(11,46,70.45,'2025-12-28 16:50:04.317000','Order Processing','ONLINE'),(11,47,69.4,'2025-12-28 17:03:29.475000','Order Processing','ONLINE'),(11,48,61,'2025-12-28 17:07:47.717000','Order Processing','ONLINE'),(11,49,90.4,'2025-12-28 17:24:19.257000','Order Processing','ONLINE'),(11,50,85.15,'2025-12-28 17:29:35.045000','Order Processing','ONLINE'),(11,51,69.4,'2025-12-28 17:34:16.250000','Order Processing','ONLINE'),(11,52,69.4,'2025-12-29 10:34:18.037000','Order Processing','COD'),(1,53,75.7,'2025-12-29 13:55:17.842000','Order Processing','ONLINE'),(1,54,69.4,'2026-01-05 13:47:38.713000','Order Delivered','ONLINE'),(1,55,67.85,'2026-01-06 11:51:22.130000','Order Delivered','ONLINE'),(11,56,100.4,'2026-01-06 15:37:32.311000','Order Packed','COD'),(16,57,100.4,'2026-01-11 14:49:13.702000','Order Processing','ONLINE'),(16,58,92,'2026-01-11 14:52:25.007000','Order Delivered','COD');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `paymentId` int NOT NULL AUTO_INCREMENT,
  `amount` double NOT NULL,
  `createdAt` datetime(6) DEFAULT NULL,
  `paymentMethod` varchar(255) DEFAULT NULL,
  `paymentStatus` varchar(255) DEFAULT NULL,
  `razorpayPaymentId` varchar(255) DEFAULT NULL,
  `userId` int NOT NULL,
  `order_id` int NOT NULL,
  PRIMARY KEY (`paymentId`),
  KEY `FK81gagumt0r8y3rmudcgpbk42l` (`order_id`),
  CONSTRAINT `FK81gagumt0r8y3rmudcgpbk42l` FOREIGN KEY (`order_id`) REFERENCES `orders` (`orderId`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (1,90.4,'2025-12-28 17:24:19.511000','ONLINE','SUCCESS','pay_Rx1R0cYalwwUfq',11,49),(2,85.15,'2025-12-28 17:29:35.374000','ONLINE','SUCCESS','pay_Rx1WZU2ZbRLffS',11,50),(3,69.4,'2025-12-28 17:34:16.307000','ONLINE','SUCCESS','pay_Rx1bWLdP2dTyl6',11,51),(4,75.7,'2025-12-29 13:55:17.896000','ONLINE','SUCCESS','pay_RxMPL84Mq7RyMZ',1,53),(5,69.4,'2026-01-05 13:47:39.042000','ONLINE','SUCCESS','pay_S0819vfFgYOwwy',1,54),(6,67.85,'2026-01-06 11:51:22.395000','ONLINE','SUCCESS','pay_S0UZSWoJMWsfQg',1,55),(7,100.4,'2026-01-11 14:49:13.743000','ONLINE','SUCCESS','pay_S2WGzFrtT8gZaB',16,57);
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `userId` int NOT NULL AUTO_INCREMENT,
  `address` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `userType` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'21/10,pardeshipura,indore','palakjain88277@gmail.com','8827718837','Palak Jain','123456','admin'),(11,'indore','yash1234@gmail.com','9876543210','yash','123456','normal'),(15,'N/A','yashh123@gmail.com','8823456789','yash','123456','admin'),(16,'pune','adarshjain9390@gmail.com','8907654654','adarsh jain','123456','normal');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vegetable`
--

DROP TABLE IF EXISTS `vegetable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vegetable` (
  `category_id` int DEFAULT NULL,
  `discount` int NOT NULL,
  `price` double NOT NULL,
  `quantityInStock` int NOT NULL,
  `vegetableId` int NOT NULL AUTO_INCREMENT,
  `description` varchar(1000) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `pImage` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`vegetableId`),
  KEY `FK5q5cesi67gvbqtjn47wb6m2bp` (`category_id`),
  CONSTRAINT `FK5q5cesi67gvbqtjn47wb6m2bp` FOREIGN KEY (`category_id`) REFERENCES `category` (`categoryId`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vegetable`
--

LOCK TABLES `vegetable` WRITE;
/*!40000 ALTER TABLE `vegetable` DISABLE KEYS */;
INSERT INTO `vegetable` VALUES (2,3,15,0,4,'Coriander is an annual herb from the parsley family, used for both its fresh leaves (known as cilantro) and its dried seeds. While cilantro has a fresh, citrusy taste and is used in dishes like salads, stews, and sauces, the dried seeds have a warm, earthy flavor, often used in spices. The leaves are an excellent source of vitamins C and K, as well as minerals like potassium and iron, while the plant as a whole can be used in cooking, and some believe it has medicinal qualities. ','Coriander','corianderr.jpg'),(2,12,20,8,5,'Cabbage is a dense, leafy cruciferous vegetable, closely related to broccoli and kale, that comes in green, red, and purple varieties. It is low in calories and a good source of vitamins C and K, fiber, and various minerals, which may support digestive and heart health. Cabbage can be eaten raw in salads or cooked in various dishes like stews, stir-fries, or fermented into sauerkraut and kimchi','Cabbage','cabbage.jpg'),(6,20,25,1,6,'Broccoli is an edible green plant from the cabbage family, known for its dense flower heads, stalks, and leaves, which are eaten as a vegetable. It is a nutrient-rich food, high in vitamins C and K, as well as fiber, and can be prepared in many ways, including raw, steamed, roasted, or stir-fried. ','Broccoli','broccoli.jpg'),(2,5,30,17,7,'Spinach is a green, leafy vegetable that is highly nutritious and can be eaten raw or cooked. It is a good source of vitamins A, C, K, and folate, as well as minerals like iron, calcium, and magnesium. Spinach is part of the amaranth family and is valued for its high levels of antioxidants and its benefits for bone, heart, and eye health. ','Spinach','Spinach-leaves-vitamins-source-person.webp'),(2,3,15,18,9,'Curry leaves are aromatic leaves from the Murraya koenigii plant, widely used in Indian and Southeast Asian cuisines for their distinctive flavor. They are a staple in many dishes, where they are often sautÃ©ed in oil to add a slightly citrusy essence to curries, dals, and chutneys. In addition to their culinary use, curry leaves are packed with nutrients like vitamins A, C, and E, calcium, and iron, and they are valued in traditional medicine for their potential health benefits','Curry Leaves','curry.jpg'),(3,5,30,38,10,'Carrots are crunchy, nutritious root vegetables from the Apiaceae family, native to Europe and Asia. They are a good source of beta-carotene (which the body converts to vitamin A), fiber, vitamin K1, and antioxidants, and are linked to benefits like improved eye health and reduced risk of certain cancers. Carrots can be eaten raw or cooked, and come in a variety of colors, including orange, purple, white, red, and yellow.','Carrot','carrot.avif'),(3,2,30,48,11,'Potato is India\'s fourth most important food crop and is a popular, versatile staple, introduced by Portuguese traders in the 17th century. It is a major source of carbohydrates, vitamins (especially C and B6), and minerals like potassium. Uttar Pradesh, West Bengal, and Bihar are the top producing states, with production concentrated in the Indo-Gangetic plains. ','Potato','potato.jpg'),(3,5,40,98,12,'Onions are low-calorie, nutrient-dense vegetables rich in antioxidants like quercetin and sulfur compounds, which may help lower cancer risk, improve heart health by regulating blood pressure and cholesterol, and reduce inflammation. They are a good source of vitamins C and B6, folate, potassium, and fiber, supporting immune function, bone health, and digestive health. ','Onion','onion.jpg'),(3,3,45,16,13,'Beetroot is a nutrient-dense root vegetable that supports heart health, improves exercise performance, and aids digestion due to its high content of nitrates, fiber, vitamins, and minerals like folate, potassium, and vitamin C. Key benefits include helping to lower blood pressure, reducing inflammation, and supporting brain function. Beets can be eaten raw, boiled, or roasted, and adding them to your diet is a great way to enhance overall well-being. ','Beetroot (Beet)','beet.jpg'),(3,2,30,4,14,'A turnip is a root vegetable with a white, fleshy taproot, often with a purple top, that is eaten raw or cooked. It is a nutrient-rich, low-calorie cruciferous vegetable related to broccoli and kale, and it can be eaten in both its root and leafy green forms. Younger turnips are milder, while larger, mature ones can have a stronger, more bitter flavor that mellows when cooked. ','Turnip','turnip.jpg'),(3,4,25,40,15,'Ginger is technically the rhizome (underground stem) of a plant, which is botanically considered a vegetable, but it is most commonly used as a spice in cooking and for medicinal purposes. While it\'s used in dishes with vegetables, it functions more as a seasoning or herb than a primary vegetable ingredient. ','Ginger','ginger.jpg'),(5,4,30,99,16,'peas are considered a vegetable in cooking, even though they are botanically a fruit and part of the legume family. Fresh or frozen peas are commonly used as a vegetable in many dishes, while dried peas are treated more like a pulse or legume. They are a good source of protein, fiber, and vitamins and are a cool-season crop grown widely around the world. ','Peas','peas.jpg'),(6,90,45,15,18,'Kale is a nutritious, leafy green vegetable belonging to the cabbage family and the Brassica family, known for its high vitamin content and use in dishes like salads, smoothies, and soups. It is a cruciferous vegetable with leaves that can be green or purple, and either flat or curly. Varieties include curly kale, red kale, and lacinato (or Tuscan) kale. ','kale','kale.jpg'),(4,2,25,50,19,'The tomato is prized as a nutrient-dense culinary vegetable that is botanically classified as a fruit. It is an exceptional source of the antioxidant lycopene, along with Vitamin C and potassium, which are essential for heart health and immune support . From versatile Roma sauce tomatoes to sweet snacking cherries, thousands of varieties exist to suit diverse global cuisines. For the best flavor and texture, these vibrant berries should be stored at room temperature rather than in the refrigerator.','Tomato','tomatoes-1296x728-feature.jpg'),(4,2,30,50,20,'Cucumbers are botanically fruits (berries) that grow from flowers and contain seeds but are used culinarily as savory vegetables in salads and pickles, making them both, depending on context; they\'re known for high water content, crispness, and benefits like hydration, vitamins (K), and antioxidants, belonging to the gourd family with melons and squash. ','Cucumber','Screenshot (55).png');
/*!40000 ALTER TABLE `vegetable` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-02-26 16:48:43
