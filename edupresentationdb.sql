-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: edupresentationdb
-- ------------------------------------------------------
-- Server version	8.0.39

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
-- Table structure for table `analytics`
--

DROP TABLE IF EXISTS `analytics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `analytics` (
  `id` int NOT NULL AUTO_INCREMENT,
  `teacher_id` int NOT NULL,
  `course_id` int NOT NULL,
  `metric_name` varchar(255) NOT NULL,
  `value` int NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_analytics_teacher` (`teacher_id`),
  KEY `fk_analytics_course` (`course_id`),
  KEY `idx-analytics-teacher_id` (`teacher_id`),
  KEY `idx-analytics-course_id` (`course_id`),
  KEY `idx-analytics-metric_name` (`metric_name`),
  KEY `idx-analytics-created_at` (`created_at`),
  CONSTRAINT `fk-analytics-course_id` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_code`) ON DELETE CASCADE,
  CONSTRAINT `fk-analytics-teacher_id` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`memberID`) ON DELETE CASCADE,
  CONSTRAINT `fk_analytics_course` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_code`),
  CONSTRAINT `fk_analytics_teacher` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`memberID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `analytics`
--

LOCK TABLES `analytics` WRITE;
/*!40000 ALTER TABLE `analytics` DISABLE KEYS */;
INSERT INTO `analytics` VALUES (5,2,1,'Attendance',85,'2025-05-10 10:00:00'),(6,2,4,'Score',90,'2025-05-10 11:00:00'),(7,2,8,'Participation',100,'2025-05-09 23:22:52');
/*!40000 ALTER TABLE `analytics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `analytics_metrics`
--

DROP TABLE IF EXISTS `analytics_metrics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `analytics_metrics` (
  `id` int NOT NULL AUTO_INCREMENT,
  `metric_key` varchar(100) NOT NULL,
  `metric_name` varchar(255) NOT NULL,
  `metric_description` text,
  `category` varchar(100) NOT NULL,
  `calculation_method` text COMMENT 'SQL or method description for calculation',
  `unit` varchar(50) DEFAULT NULL COMMENT '%, score, hours, etc.',
  `min_value` decimal(8,2) DEFAULT '0.00',
  `max_value` decimal(8,2) DEFAULT '100.00',
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `metric_key` (`metric_key`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `analytics_metrics`
--

LOCK TABLES `analytics_metrics` WRITE;
/*!40000 ALTER TABLE `analytics_metrics` DISABLE KEYS */;
INSERT INTO `analytics_metrics` VALUES (1,'attendance_percentage','Attendance Rate','Percentage of classes attended by students','Performance','COUNT(attendance_records) / COUNT(total_classes) * 100','%',0.00,100.00,1,'2025-07-31 21:34:08','2025-07-31 21:34:08'),(2,'quiz_average_score','Quiz Performance Average','Average score across all quizzes','Performance','AVG(quiz_attempts.score)','score',0.00,100.00,1,'2025-07-31 21:34:08','2025-07-31 21:34:08'),(3,'assignment_completion_rate','Assignment Completion Rate','Percentage of assignments completed on time','Performance','COUNT(completed_assignments) / COUNT(total_assignments) * 100','%',0.00,100.00,1,'2025-07-31 21:34:08','2025-07-31 21:34:08'),(4,'assignment_quality_score','Assignment Quality Score','Average quality score of submitted assignments','Performance','AVG(assignment_grades.score)','score',0.00,100.00,1,'2025-07-31 21:34:08','2025-07-31 21:34:08'),(5,'exam_performance_average','Exam Performance Average','Average performance in examinations','Performance','AVG(exam_results.score)','score',0.00,100.00,1,'2025-07-31 21:34:08','2025-07-31 21:34:08'),(6,'student_improvement_rate','Student Improvement Rate','Rate of improvement over time','Performance','LATEST_SCORE - INITIAL_SCORE / INITIAL_SCORE * 100','%',-100.00,100.00,1,'2025-07-31 21:34:08','2025-07-31 21:34:08'),(7,'class_participation_rate','Class Participation Rate','Active participation in class discussions','Engagement','COUNT(participation_records) / COUNT(class_sessions) * 100','%',0.00,100.00,1,'2025-07-31 21:34:08','2025-07-31 21:34:08'),(8,'questions_asked_frequency','Questions Asked Frequency','Average number of questions asked per session','Engagement','COUNT(questions) / COUNT(sessions)','count',0.00,50.00,1,'2025-07-31 21:34:08','2025-07-31 21:34:08'),(9,'discussion_engagement_score','Discussion Engagement Score','Quality and frequency of discussion participation','Engagement','WEIGHTED_AVERAGE(discussion_posts.quality_score)','score',0.00,100.00,1,'2025-07-31 21:34:08','2025-07-31 21:34:08'),(10,'learning_resource_usage','Learning Resource Usage','Percentage of available resources accessed','Engagement','COUNT(accessed_resources) / COUNT(total_resources) * 100','%',0.00,100.00,1,'2025-07-31 21:34:08','2025-07-31 21:34:08'),(11,'online_activity_duration','Online Activity Duration','Average time spent on learning platform','Engagement','AVG(session_duration)','hours',0.00,24.00,1,'2025-07-31 21:34:08','2025-07-31 21:34:08'),(12,'concept_mastery_percentage','Concept Mastery Level','Percentage of key concepts mastered','Learning Outcomes','COUNT(mastered_concepts) / COUNT(total_concepts) * 100','%',0.00,100.00,1,'2025-07-31 21:34:08','2025-07-31 21:34:08'),(13,'skill_development_progress','Skill Development Progress','Progress in developing required skills','Learning Outcomes','SKILL_ASSESSMENT_AVERAGE','score',0.00,100.00,1,'2025-07-31 21:34:08','2025-07-31 21:34:08'),(14,'critical_thinking_score','Critical Thinking Score','Assessment of critical thinking abilities','Learning Outcomes','AVG(critical_thinking_assessments.score)','score',0.00,100.00,1,'2025-07-31 21:34:08','2025-07-31 21:34:08'),(15,'collaboration_effectiveness','Collaboration Effectiveness','Effectiveness in group work and collaboration','Learning Outcomes','AVG(group_work_evaluations.score)','score',0.00,100.00,1,'2025-07-31 21:34:08','2025-07-31 21:34:08'),(16,'submission_timeliness_rate','On-Time Submission Rate','Percentage of assignments submitted on time','Behavioral','COUNT(on_time_submissions) / COUNT(total_submissions) * 100','%',0.00,100.00,1,'2025-07-31 21:34:08','2025-07-31 21:34:08'),(17,'help_seeking_frequency','Help-Seeking Frequency','Frequency of seeking help when needed','Behavioral','COUNT(help_requests) / COUNT(difficult_topics)','ratio',0.00,5.00,1,'2025-07-31 21:34:08','2025-07-31 21:34:08'),(18,'peer_interaction_quality','Peer Interaction Quality','Quality of interactions with peers','Behavioral','AVG(peer_evaluation_scores)','score',0.00,100.00,1,'2025-07-31 21:34:08','2025-07-31 21:34:08'),(19,'self_directed_learning_hours','Self-Directed Learning','Hours spent on independent learning','Behavioral','SUM(self_study_time)','hours',0.00,168.00,1,'2025-07-31 21:34:08','2025-07-31 21:34:08'),(20,'content_comprehension_rate','Content Comprehension Rate','Understanding of course content','Course-Specific','AVG(comprehension_test_scores)','%',0.00,100.00,1,'2025-07-31 21:34:08','2025-07-31 21:34:08'),(21,'practical_application_score','Practical Application Score','Ability to apply theoretical knowledge','Course-Specific','AVG(practical_assignment_scores)','score',0.00,100.00,1,'2025-07-31 21:34:08','2025-07-31 21:34:08'),(22,'research_project_quality','Research Project Quality','Quality of research and projects','Course-Specific','AVG(research_project_grades)','score',0.00,100.00,1,'2025-07-31 21:34:08','2025-07-31 21:34:08'),(23,'presentation_skills_score','Presentation Skills Score','Effectiveness in presentations','Course-Specific','AVG(presentation_evaluations)','score',0.00,100.00,1,'2025-07-31 21:34:08','2025-07-31 21:34:08'),(24,'at_risk_student_indicator','At-Risk Student Indicator','Likelihood of academic difficulty','Risk Assessment','CALCULATED_RISK_SCORE','score',0.00,100.00,1,'2025-07-31 21:34:08','2025-07-31 21:34:08'),(25,'additional_support_needed','Additional Support Needed','Level of additional support required','Risk Assessment','SUPPORT_NEEDS_ASSESSMENT','level',0.00,10.00,1,'2025-07-31 21:34:08','2025-07-31 21:34:08'),(26,'learning_difficulty_level','Learning Difficulty Level','Identified learning challenges','Risk Assessment','DIFFICULTY_ASSESSMENT_SCORE','level',0.00,10.00,1,'2025-07-31 21:34:08','2025-07-31 21:34:08'),(27,'student_motivation_level','Student Motivation Level','Overall motivation and engagement level','Risk Assessment','MOTIVATION_SURVEY_AVERAGE','score',0.00,100.00,1,'2025-07-31 21:34:08','2025-07-31 21:34:08');
/*!40000 ALTER TABLE `analytics_metrics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_assignment`
--

DROP TABLE IF EXISTS `auth_assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_assignment` (
  `item_name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `user_id` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `created_at` int DEFAULT NULL,
  PRIMARY KEY (`item_name`,`user_id`),
  KEY `idx-auth_assignment-user_id` (`user_id`),
  CONSTRAINT `auth_assignment_ibfk_1` FOREIGN KEY (`item_name`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_assignment`
--

LOCK TABLES `auth_assignment` WRITE;
/*!40000 ALTER TABLE `auth_assignment` DISABLE KEYS */;
INSERT INTO `auth_assignment` VALUES ('admin','1',1743256612),('teacher','2',1743256618);
/*!40000 ALTER TABLE `auth_assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_item`
--

DROP TABLE IF EXISTS `auth_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_item` (
  `name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `type` smallint NOT NULL,
  `description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `rule_name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `data` blob,
  `created_at` int DEFAULT NULL,
  `updated_at` int DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `rule_name` (`rule_name`),
  KEY `idx-auth_item-type` (`type`),
  CONSTRAINT `auth_item_ibfk_1` FOREIGN KEY (`rule_name`) REFERENCES `auth_rule` (`name`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_item`
--

LOCK TABLES `auth_item` WRITE;
/*!40000 ALTER TABLE `auth_item` DISABLE KEYS */;
INSERT INTO `auth_item` VALUES ('admin',1,NULL,NULL,NULL,1743256612,1743256612),('createQuiz',2,'Create a quiz',NULL,NULL,1743256612,1743256612),('manageAllQuizzes',2,'Manage all quizzes',NULL,NULL,1743256612,1743256612),('manageOwnQuizzes',2,'Manage own quizzes',NULL,NULL,1743256612,1743256612),('teacher',1,NULL,NULL,NULL,1743256612,1743256612);
/*!40000 ALTER TABLE `auth_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_item_child`
--

DROP TABLE IF EXISTS `auth_item_child`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_item_child` (
  `parent` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `child` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`parent`,`child`),
  KEY `child` (`child`),
  CONSTRAINT `auth_item_child_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `auth_item_child_ibfk_2` FOREIGN KEY (`child`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_item_child`
--

LOCK TABLES `auth_item_child` WRITE;
/*!40000 ALTER TABLE `auth_item_child` DISABLE KEYS */;
INSERT INTO `auth_item_child` VALUES ('teacher','createQuiz'),('admin','manageAllQuizzes'),('teacher','manageOwnQuizzes'),('admin','teacher');
/*!40000 ALTER TABLE `auth_item_child` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_rule`
--

DROP TABLE IF EXISTS `auth_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_rule` (
  `name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `data` blob,
  `created_at` int DEFAULT NULL,
  `updated_at` int DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_rule`
--

LOCK TABLES `auth_rule` WRITE;
/*!40000 ALTER TABLE `auth_rule` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact`
--

DROP TABLE IF EXISTS `contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `body` text NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact`
--

LOCK TABLES `contact` WRITE;
/*!40000 ALTER TABLE `contact` DISABLE KEYS */;
INSERT INTO `contact` VALUES (1,'sabeen','sabeenzahra1122@gmail.com','education','good progress','2025-06-05 07:51:48');
/*!40000 ALTER TABLE `contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_student`
--

DROP TABLE IF EXISTS `course_student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_student` (
  `idCourse_Student` int NOT NULL AUTO_INCREMENT,
  `CourseID` int NOT NULL,
  `Student_ID` int NOT NULL,
  PRIMARY KEY (`idCourse_Student`),
  KEY `StudentEnrollCourse2_idx` (`Student_ID`),
  KEY `StudentEnrollCourse1_idx` (`CourseID`),
  CONSTRAINT `StudentEnrollCourse1` FOREIGN KEY (`CourseID`) REFERENCES `courses` (`course_code`),
  CONSTRAINT `StudentEnrollCourse2` FOREIGN KEY (`Student_ID`) REFERENCES `student` (`memberID`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_student`
--

LOCK TABLES `course_student` WRITE;
/*!40000 ALTER TABLE `course_student` DISABLE KEYS */;
INSERT INTO `course_student` VALUES (1,1,1),(35,1,3),(36,1,3),(46,12,3);
/*!40000 ALTER TABLE `course_student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_teacher`
--

DROP TABLE IF EXISTS `course_teacher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_teacher` (
  `idCourse_Teacher` int NOT NULL AUTO_INCREMENT,
  `Course_id` int NOT NULL,
  `Teacher_id` int NOT NULL,
  `otp` int DEFAULT NULL,
  `expiryTime` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idCourse_Teacher`),
  KEY `fk_ct_teacher_idx` (`Teacher_id`),
  KEY `fk_ct_course_idx` (`Course_id`),
  CONSTRAINT `fk_ct_course` FOREIGN KEY (`Course_id`) REFERENCES `courses` (`course_code`),
  CONSTRAINT `fk_ct_teacher` FOREIGN KEY (`Teacher_id`) REFERENCES `teacher` (`memberID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_teacher`
--

LOCK TABLES `course_teacher` WRITE;
/*!40000 ALTER TABLE `course_teacher` DISABLE KEYS */;
INSERT INTO `course_teacher` VALUES (1,1,2,309814,'2025-07-31 23:57:00'),(3,4,2,NULL,NULL),(7,8,2,NULL,NULL),(8,9,2,NULL,NULL),(9,10,2,NULL,NULL),(10,11,2,NULL,NULL),(11,12,2,NULL,NULL);
/*!40000 ALTER TABLE `course_teacher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `courses` (
  `course_code` int NOT NULL AUTO_INCREMENT,
  `course_name` varchar(100) NOT NULL,
  `course_description` text NOT NULL,
  PRIMARY KEY (`course_code`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses`
--

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
INSERT INTO `courses` VALUES (1,'Web Engineering','Student will be able to design fully functional websites.'),(4,'Mobile Application Development','Student will be able to develop a user friendly mobile application.'),(8,'Professional Practices',''),(9,'Social Work',''),(10,'Enterprises Systems',''),(11,'Data Encryption and Security','Encryption decryption techniques'),(12,'FYP','Final Year Project of the student mandatory to get the degree.');
/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `learning_unit`
--

DROP TABLE IF EXISTS `learning_unit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `learning_unit` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) DEFAULT NULL,
  `Description` varchar(1500) DEFAULT NULL,
  `Sequence_number` int DEFAULT NULL,
  `Topic_id` int DEFAULT NULL,
  `Subject_id` int DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `Sub_id_idx` (`Subject_id`),
  KEY `Topic_id_idx` (`Topic_id`),
  CONSTRAINT `Sub_id` FOREIGN KEY (`Subject_id`) REFERENCES `courses` (`course_code`),
  CONSTRAINT `Topic_id` FOREIGN KEY (`Topic_id`) REFERENCES `topic` (`topicID`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `learning_unit`
--

LOCK TABLES `learning_unit` WRITE;
/*!40000 ALTER TABLE `learning_unit` DISABLE KEYS */;
INSERT INTO `learning_unit` VALUES (1,'Introduction to HTML','Basic concepts and structure of HTML',1,1,NULL),(2,'HTML Elements','Understanding different HTML elements',2,1,NULL),(3,'HTML Forms','Learning how to create forms in HTML',3,1,NULL),(10,'HTML Structure','Provides a skeleton to a website',4,1,NULL),(11,'Ciphers','Ceaser Cipher',2,9,NULL),(13,'Introduction','Submitted to: Mam Asma Sajjad',1,10,NULL);
/*!40000 ALTER TABLE `learning_unit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lesson`
--

DROP TABLE IF EXISTS `lesson`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lesson` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Title` varchar(100) DEFAULT NULL,
  `Objective` varchar(500) DEFAULT NULL,
  `Description` varchar(100) DEFAULT NULL,
  `Type` varchar(45) DEFAULT NULL,
  `Sequence_num` int DEFAULT NULL,
  `LU_id` int DEFAULT NULL,
  `course_code` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `LU_Id_idx` (`LU_id`),
  CONSTRAINT `LU_Id` FOREIGN KEY (`LU_id`) REFERENCES `learning_unit` (`Id`),
  CONSTRAINT `chk_Type1` CHECK ((`Type` in (_utf8mb4'theory',_utf8mb4'practical',_utf8mb4'assessment')))
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lesson`
--

LOCK TABLES `lesson` WRITE;
/*!40000 ALTER TABLE `lesson` DISABLE KEYS */;
INSERT INTO `lesson` VALUES (1,'HTML Basics','Learn about HTML structure','Introduction to HTML tags and attributes','Theory',1,1,'1'),(2,'Working with HTML Elements','Understand various HTML elements','Detailed discussion on block and inline elements','Assessment',2,2,'1'),(3,'HTML Forms and Inputs','Learn how to create HTML forms','Explanation of form elements like input, select, and textarea','Practical',3,3,'1'),(13,'Ceaser Cipher','A student should be able to generate a stong pass-code for there ID\'s','Key description, Plain Text, Private Public key','theory',1,11,'1'),(14,'About Application','To Remove the Gap Between Old Teaching methodologies with new ones','Edu Presentation Platform','theory',1,13,'12'),(18,'Lesson','Testing','Test Lesson','practical',2,11,'1');
/*!40000 ALTER TABLE `lesson` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lesson_plan`
--

DROP TABLE IF EXISTS `lesson_plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lesson_plan` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `course_id` int NOT NULL,
  `teacher_id` int NOT NULL,
  `description` text,
  `duration` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_lesson_plan_course` (`course_id`),
  KEY `fk_lesson_plan_teacher` (`teacher_id`),
  CONSTRAINT `fk_lesson_plan_course` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_code`),
  CONSTRAINT `fk_lesson_plan_teacher` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`memberID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lesson_plan`
--

LOCK TABLES `lesson_plan` WRITE;
/*!40000 ALTER TABLE `lesson_plan` DISABLE KEYS */;
INSERT INTO `lesson_plan` VALUES (1,'Before Mids',1,2,'<table>\r\n	<thead>\r\n		<tr>\r\n			<th><strong>Week</strong></th>\r\n			<th><strong>Topics</strong></th>\r\n			<th><strong>Outcomes</strong></th>\r\n			<th><strong>Lab Activities</strong></th>\r\n		</tr>\r\n	</thead>\r\n	<tbody>\r\n		<tr>\r\n			<td><strong>Week 1</strong></td>\r\n			<td><strong>Introduction to Web Engineering</strong> - History &amp; evolution of the web - Types of websites (static/dynamic) - Web Engineering vs Web Development</td>\r\n			<td>Understand the discipline, processes, and stakeholders involved</td>\r\n			<td>Explore examples of static vs dynamic websites</td>\r\n		</tr>\r\n		<tr>\r\n			<td><strong>Week 2</strong></td>\r\n			<td><strong>Web Architecture &amp; Protocols</strong> - Client-server model - HTTP/HTTPS - DNS &amp; IP basics</td>\r\n			<td>Describe the architecture and protocols supporting the web</td>\r\n			<td>Use browser dev tools to inspect HTTP requests</td>\r\n		</tr>\r\n		<tr>\r\n			<td><strong>Week 3</strong></td>\r\n			<td><strong>HTML Basics</strong> - Semantic tags - Forms, tables, media embedding</td>\r\n			<td>Build a structured static web page using HTML</td>\r\n			<td>Create a basic portfolio homepage in HTML</td>\r\n		</tr>\r\n		<tr>\r\n			<td><strong>Week 4</strong></td>\r\n			<td><strong>CSS Styling</strong> - Inline, internal, external CSS - Box model - Positioning, Flexbox, Grid</td>\r\n			<td>Style HTML content effectively</td>\r\n			<td>Style the Week 3 portfolio with responsive design</td>\r\n		</tr>\r\n		<tr>\r\n			<td><strong>Week 5</strong></td>\r\n			<td><strong>JavaScript Basics</strong> - Variables, data types, conditions - Functions and events - DOM manipulation intro</td>\r\n			<td>Add interactivity to webpages using JS</td>\r\n			<td>Create a to-do list or form validator</td>\r\n		</tr>\r\n		<tr>\r\n			<td><strong>Week 6</strong></td>\r\n			<td><strong>Web Development Tools</strong> - Developer tools (Chrome DevTools) - Version control (Git/GitHub intro) - IDEs, code formatters</td>\r\n			<td>Use professional tools to manage and debug code</td>\r\n			<td>Push a mini project to GitHub, inspect site in DevTools</td>\r\n		</tr>\r\n		<tr>\r\n			<td><strong>Week 7</strong></td>\r\n			<td><strong>Responsive Design &amp; Bootstrap Intro</strong> - Media queries - Mobile-first design - Bootstrap classes</td>\r\n			<td>Create responsive designs across devices</td>\r\n			<td>Redesign previous lab using Bootstrap 5</td>\r\n		</tr>\r\n		<tr>\r\n			<td><strong>Week 8</strong></td>\r\n			<td><strong>Review &amp; Practice</strong> - Quick recap of all topics - Common HTML/CSS/JS mistakes - Prepare for MCQs &amp; coding tasks</td>\r\n			<td>Solidify understanding through revision</td>\r\n			<td>Mock test and hands-on practice problems</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n',NULL,'2025-08-01 08:45:07','2025-08-01 08:45:07'),(2,'After Mids',10,2,'<p>All</p>\r\n',NULL,'2025-08-01 08:48:58','2025-08-01 08:48:58');
/*!40000 ALTER TABLE `lesson_plan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migration`
--

DROP TABLE IF EXISTS `migration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migration` (
  `version` varchar(180) NOT NULL,
  `apply_time` int NOT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migration`
--

LOCK TABLES `migration` WRITE;
/*!40000 ALTER TABLE `migration` DISABLE KEYS */;
INSERT INTO `migration` VALUES ('m000000_000000_base',1709989999),('m130524_201442_init',1739017489),('m140506_102106_rbac_init',1743251207),('m170907_052038_rbac_add_index_on_auth_assignment_user_id',1743251207),('m180523_151638_rbac_updates_indexes_without_prefix',1743251207),('m190124_110200_add_verification_token_column_to_user_table',1739017489),('m200409_110543_rbac_update_mssql_trigger',1743251207),('m240731_221400_add_teacher_id_to_notifications',1754000101),('m250131_000000_create_analytics_table',1753997213),('m250131_010000_create_analytics_metrics_table',1753997648),('m250131_020000_create_student_activity_table',1753997854),('m250329_122705_init_rbac_data',1743251302),('m250329_150000_sync_quiz_attempt_table',1743195613),('m250330_000000_init_rbac_system',1743251302),('m250406_123456_add_profile_image_to_user',1743936814),('m250706_185634_add_course_id_to_quiz_attempt',1751828265),('m250706_190145_add_course_id_to_quiz_attempt',1751828529),('m250710_000000_fix_presentation_nullable_fields',1752181843),('m250710_200528_add_course_id_to_lesson',1752179464),('m250801_083910_m250801_133909_check_lesson_plan_table',1754037807),('m250801_084227_create_lesson_plan_table',1754037898),('m250801_084332_alter_lesson_plan_table',1754037907),('m250801_120000_create_website_statistics_table',1754049777);
/*!40000 ALTER TABLE `migration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL,
  `message` text NOT NULL,
  `type` varchar(50) NOT NULL,
  `related_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_read` tinyint(1) DEFAULT '0',
  `teacher_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `student_id` (`student_id`),
  KEY `fk-notifications-teacher_id` (`teacher_id`),
  CONSTRAINT `fk-notifications-teacher_id` FOREIGN KEY (`teacher_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` VALUES (3,1,'A new live session \'Session 4\' has been created for your course.','live_session',22,'2025-05-18 11:45:03',0,NULL),(8,1,'A new live session \'Session 5\' has been created for your course.','live_session',23,'2025-05-31 09:35:44',0,NULL),(9,3,'A new live session \'Session 5\' has been created for your course.','live_session',23,'2025-05-31 09:35:44',0,NULL),(10,3,'A new live session \'Session 5\' has been created for your course.','live_session',23,'2025-05-31 09:35:44',0,NULL),(11,1,'A new live session \'Session 5\' has been created for your course.','live_session',24,'2025-05-31 16:16:18',0,NULL),(12,3,'A new live session \'Session 5\' has been created for your course.','live_session',24,'2025-05-31 16:16:18',0,NULL),(13,3,'A new live session \'Session 5\' has been created for your course.','live_session',24,'2025-05-31 16:16:18',0,NULL),(14,1,'A new live session \'Session 6\' has been created for your course.','live_session',25,'2025-06-05 16:00:26',0,NULL),(15,3,'A new live session \'Session 6\' has been created for your course.','live_session',25,'2025-06-05 16:00:26',0,NULL),(16,3,'A new live session \'Session 6\' has been created for your course.','live_session',25,'2025-06-05 16:00:26',0,NULL),(17,1,'A new live session \'Session 7\' has been created for your course.','live_session',26,'2025-06-05 16:32:04',0,NULL),(18,3,'A new live session \'Session 7\' has been created for your course.','live_session',26,'2025-06-05 16:32:04',0,NULL),(19,3,'A new live session \'Session 7\' has been created for your course.','live_session',26,'2025-06-05 16:32:04',0,NULL),(20,1,'A new live session \'Session 8\' has been created for your course.','live_session',27,'2025-06-05 17:27:06',0,NULL),(21,3,'A new live session \'Session 8\' has been created for your course.','live_session',27,'2025-06-05 17:27:06',0,NULL),(22,3,'A new live session \'Session 8\' has been created for your course.','live_session',27,'2025-06-05 17:27:06',0,NULL),(23,1,'A new live session \'Session 8\' has been created for your course.','live_session',28,'2025-06-05 17:31:07',0,NULL),(24,3,'A new live session \'Session 8\' has been created for your course.','live_session',28,'2025-06-05 17:31:07',0,NULL),(25,3,'A new live session \'Session 8\' has been created for your course.','live_session',28,'2025-06-05 17:31:07',0,NULL),(26,1,'A new live session \'Session 9\' has been created for your course.','live_session',29,'2025-06-05 17:36:41',0,NULL),(27,3,'A new live session \'Session 9\' has been created for your course.','live_session',29,'2025-06-05 17:36:41',0,NULL),(28,3,'A new live session \'Session 9\' has been created for your course.','live_session',29,'2025-06-05 17:36:41',0,NULL),(29,1,'A new live session \'Session 6\' has been created for your course.','live_session',30,'2025-06-05 17:46:14',0,NULL),(30,3,'A new live session \'Session 6\' has been created for your course.','live_session',30,'2025-06-05 17:46:14',0,NULL),(31,3,'A new live session \'Session 6\' has been created for your course.','live_session',30,'2025-06-05 17:46:14',0,NULL),(32,1,'A new live session \'Session 7\' has been created for your course.','live_session',31,'2025-06-05 18:56:45',0,NULL),(33,3,'A new live session \'Session 7\' has been created for your course.','live_session',31,'2025-06-05 18:56:45',0,NULL),(34,3,'A new live session \'Session 7\' has been created for your course.','live_session',31,'2025-06-05 18:56:45',0,NULL),(35,1,'A new live session \'Session 8\' has been created for your course.','live_session',32,'2025-06-06 11:19:57',0,NULL),(36,3,'A new live session \'Session 8\' has been created for your course.','live_session',32,'2025-06-06 11:19:57',0,NULL),(37,3,'A new live session \'Session 8\' has been created for your course.','live_session',32,'2025-06-06 11:19:57',0,NULL),(38,1,'A new live session \'Session 9\' has been created for your course.','live_session',33,'2025-06-06 13:35:23',0,NULL),(39,3,'A new live session \'Session 9\' has been created for your course.','live_session',33,'2025-06-06 13:35:23',0,NULL),(40,3,'A new live session \'Session 9\' has been created for your course.','live_session',33,'2025-06-06 13:35:23',0,NULL),(41,1,'A new quiz \'Abc\' has been added to your course.','quiz',11,'2025-07-04 12:30:34',0,NULL),(42,3,'A new quiz \'Abc\' has been added to your course.','quiz',11,'2025-07-04 12:30:34',0,NULL),(43,3,'A new quiz \'Abc\' has been added to your course.','quiz',11,'2025-07-04 12:30:34',0,NULL),(44,1,'A new quiz \'HTML\' has been added to your course.','quiz',12,'2025-07-04 21:54:04',0,NULL),(45,3,'A new quiz \'HTML\' has been added to your course.','quiz',12,'2025-07-04 21:54:04',0,NULL),(46,3,'A new quiz \'HTML\' has been added to your course.','quiz',12,'2025-07-04 21:54:04',0,NULL),(47,1,'A new quiz \'Abc\' has been added to your course.','quiz',13,'2025-07-05 09:16:47',0,NULL),(48,3,'A new quiz \'Abc\' has been added to your course.','quiz',13,'2025-07-05 09:16:47',0,NULL),(49,3,'A new quiz \'Abc\' has been added to your course.','quiz',13,'2025-07-05 09:16:47',0,NULL),(50,1,'A new quiz \'HTML\' has been added to your course.','quiz',14,'2025-07-05 09:32:30',0,NULL),(51,3,'A new quiz \'HTML\' has been added to your course.','quiz',14,'2025-07-05 09:32:30',0,NULL),(52,3,'A new quiz \'HTML\' has been added to your course.','quiz',14,'2025-07-05 09:32:30',0,NULL),(53,1,'A new quiz \'X\' has been added to your course.','quiz',17,'2025-07-05 10:36:45',0,NULL),(54,3,'A new quiz \'X\' has been added to your course.','quiz',17,'2025-07-05 10:36:45',0,NULL),(55,3,'A new quiz \'X\' has been added to your course.','quiz',17,'2025-07-05 10:36:45',0,NULL),(56,1,'A new quiz \'X\' has been added to your course.','quiz',18,'2025-07-05 10:38:43',0,NULL),(57,3,'A new quiz \'X\' has been added to your course.','quiz',18,'2025-07-05 10:38:43',0,NULL),(58,3,'A new quiz \'X\' has been added to your course.','quiz',18,'2025-07-05 10:38:43',0,NULL),(59,1,'A new quiz \'X\' has been added to your course.','quiz',19,'2025-07-05 11:14:16',0,NULL),(60,3,'A new quiz \'X\' has been added to your course.','quiz',19,'2025-07-05 11:14:16',0,NULL),(61,3,'A new quiz \'X\' has been added to your course.','quiz',19,'2025-07-05 11:14:16',0,NULL),(62,1,'A new live session \'Session 8\' has been created for your course.','live_session',34,'2025-07-06 23:23:32',0,NULL),(63,3,'A new live session \'Session 8\' has been created for your course.','live_session',34,'2025-07-06 23:23:32',0,NULL),(64,3,'A new live session \'Session 8\' has been created for your course.','live_session',34,'2025-07-06 23:23:32',0,NULL),(75,3,'Your enrollment request for course ID 11 has been rejected.','enrollment_response',62,'2025-07-18 02:22:55',0,NULL),(76,1,'A new learning unit \'ewt\' has been added to your course.','learning_unit',14,'2025-07-31 09:48:38',0,NULL),(77,3,'A new learning unit \'ewt\' has been added to your course.','learning_unit',14,'2025-07-31 09:48:38',0,NULL),(78,3,'A new learning unit \'ewt\' has been added to your course.','learning_unit',14,'2025-07-31 09:48:38',0,NULL),(79,1,'A new learning unit \'ewt\' has been added to your course.','learning_unit',15,'2025-07-31 10:25:47',0,NULL),(80,3,'A new learning unit \'ewt\' has been added to your course.','learning_unit',15,'2025-07-31 10:25:47',0,NULL),(81,3,'A new learning unit \'ewt\' has been added to your course.','learning_unit',15,'2025-07-31 10:25:47',0,NULL),(82,3,'A new live session \'Session 12\' has been created for your course.','live_session',36,'2025-07-31 22:17:11',0,NULL),(83,1,'A new learning unit \'ewt\' has been added to your course.','learning_unit',16,'2025-08-01 10:33:13',0,NULL),(84,3,'A new learning unit \'ewt\' has been added to your course.','learning_unit',16,'2025-08-01 10:33:13',0,NULL),(85,3,'A new learning unit \'ewt\' has been added to your course.','learning_unit',16,'2025-08-01 10:33:13',0,NULL),(86,1,'A new lesson \'Lesson\' has been added to your course.','lesson',18,'2025-08-01 11:37:30',0,NULL),(87,3,'A new lesson \'Lesson\' has been added to your course.','lesson',18,'2025-08-01 11:37:30',0,NULL),(88,3,'A new lesson \'Lesson\' has been added to your course.','lesson',18,'2025-08-01 11:37:30',0,NULL),(89,1,'A new presentation \'HTML Basics\' has been added to your course.','presentation',62,'2025-08-01 14:23:14',0,NULL),(90,3,'A new presentation \'HTML Basics\' has been added to your course.','presentation',62,'2025-08-01 14:23:14',0,NULL),(91,3,'A new presentation \'HTML Basics\' has been added to your course.','presentation',62,'2025-08-01 14:23:14',0,NULL),(92,1,'A new presentation \'HTML Basics\' has been added to your course.','presentation',63,'2025-08-01 14:28:17',0,NULL),(93,3,'A new presentation \'HTML Basics\' has been added to your course.','presentation',63,'2025-08-01 14:28:17',0,NULL),(94,3,'A new presentation \'HTML Basics\' has been added to your course.','presentation',63,'2025-08-01 14:28:17',0,NULL),(95,1,'A new live session \'Session 11\' has been created for your course.','live_session',37,'2025-08-01 14:39:11',0,NULL),(96,3,'A new live session \'Session 11\' has been created for your course.','live_session',37,'2025-08-01 14:39:11',0,NULL),(97,3,'A new live session \'Session 11\' has been created for your course.','live_session',37,'2025-08-01 14:39:11',0,NULL),(98,1,'A new presentation \'test\' has been added to your course.','presentation',64,'2025-08-01 18:12:49',0,NULL),(99,3,'A new presentation \'test\' has been added to your course.','presentation',64,'2025-08-01 18:12:49',0,NULL),(100,3,'A new presentation \'test\' has been added to your course.','presentation',64,'2025-08-01 18:12:49',0,NULL),(101,3,'A new presentation \'Test Application\' has been added to your course.','presentation',66,'2025-08-02 14:01:44',0,NULL),(102,1,'A new presentation \'Teest HTML Basics\' has been added to your course.','presentation',67,'2025-08-02 14:02:10',0,NULL),(103,3,'A new presentation \'Teest HTML Basics\' has been added to your course.','presentation',67,'2025-08-02 14:02:10',0,NULL),(104,3,'A new presentation \'Teest HTML Basics\' has been added to your course.','presentation',67,'2025-08-02 14:02:10',0,NULL),(105,1,'A new presentation \'test\' has been added to your course.','presentation',68,'2025-08-02 18:20:01',0,NULL),(106,3,'A new presentation \'test\' has been added to your course.','presentation',68,'2025-08-02 18:20:02',0,NULL),(107,3,'A new presentation \'test\' has been added to your course.','presentation',68,'2025-08-02 18:20:02',0,NULL);
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `presentable`
--

DROP TABLE IF EXISTS `presentable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `presentable` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `lesson_id` int DEFAULT NULL,
  `Type` varchar(100) NOT NULL,
  `Location` longtext,
  `Format_type` varchar(45) DEFAULT NULL,
  `Sequence_num` int DEFAULT NULL,
  `Teachable_id` int DEFAULT NULL,
  `template_id` int DEFAULT NULL,
  `text_content` text,
  `file_size` bigint DEFAULT NULL COMMENT 'File size in bytes',
  `file_type` varchar(100) DEFAULT NULL COMMENT 'MIME type of uploaded file',
  `original_filename` varchar(255) DEFAULT NULL COMMENT 'Original filename before upload',
  PRIMARY KEY (`Id`),
  KEY `TA_id_idx` (`Teachable_id`),
  KEY `fk_presentable_lesson` (`lesson_id`),
  KEY `template_id` (`template_id`),
  KEY `idx_type_format` (`Type`,`Format_type`),
  KEY `idx_location` (`Location`(100)),
  CONSTRAINT `fk_presentable_lesson` FOREIGN KEY (`lesson_id`) REFERENCES `lesson` (`Id`),
  CONSTRAINT `presentable_ibfk_1` FOREIGN KEY (`template_id`) REFERENCES `presentable_template` (`id`),
  CONSTRAINT `TA_id` FOREIGN KEY (`Teachable_id`) REFERENCES `teachable` (`Id`),
  CONSTRAINT `chk_Format_type` CHECK ((`Format_type` in (_utf8mb4'isTitle',_utf8mb4'isSubHeading',_utf8mb4'isNormalText'))),
  CONSTRAINT `chk_Type` CHECK ((`Type` in (_utf8mb4'isText',_utf8mb4'isLink',_utf8mb4'isAudio',_utf8mb4'isVideo',_utf8mb4'isPhoto')))
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `presentable`
--

LOCK TABLES `presentable` WRITE;
/*!40000 ALTER TABLE `presentable` DISABLE KEYS */;
INSERT INTO `presentable` VALUES (1,1,'isText',NULL,'isTitle',1,1,1,NULL,NULL,NULL,NULL),(2,1,'isLink','https://www.w3schools.com/html/','isNormalText',2,1,1,NULL,NULL,NULL,NULL),(3,1,'isText',NULL,'isTitle',1,2,1,NULL,NULL,NULL,NULL),(4,1,'isVideo','uploads/presentables/1742606339_HTML Tags, Attributes and Elements.mp4','isSubHeading',2,2,1,NULL,NULL,NULL,NULL),(5,1,'isText',NULL,'isTitle',1,3,1,NULL,NULL,NULL,NULL),(6,1,'isText',NULL,'isTitle',1,4,1,NULL,NULL,NULL,NULL),(7,1,'isText',NULL,'isTitle',1,5,1,NULL,NULL,NULL,NULL),(22,14,'isPhoto','uploads/presentables/1752143640_logo.png','isSubHeading',1,17,16,NULL,NULL,NULL,NULL),(23,14,'isText','The Educational Presentation Platform is a centralized system designed for LearnApp.Online to modernize the teaching process by integrating content management, live sessions, and assessments into a unified experience for hybrid and in-person classrooms.\r\n','isNormalText',2,17,21,NULL,NULL,NULL,NULL),(24,NULL,'isText','JHDkbsjkfaskjf','isTitle',1,NULL,19,NULL,NULL,NULL,NULL),(25,NULL,'isAudio','uploads/presentables/1754044107_powerup.mp3','isTitle',1,NULL,19,NULL,NULL,NULL,NULL),(26,1,'isAudio','uploads/presentables/1754144893_powerup.mp3','isSubHeading',25,1,13,NULL,NULL,NULL,NULL),(27,1,'isVideo','uploads/presentables/1754144943_Screen Recording 2025-07-20 202910.mp4','isTitle',24,1,15,NULL,NULL,NULL,NULL),(28,1,'isAudio','uploads/presentables/1754146183_merged_zcVBeSloLYbgpPws_1747160761.wav','isNormalText',3,1,6,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `presentable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `presentable_template`
--

DROP TABLE IF EXISTS `presentable_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `presentable_template` (
  `id` int NOT NULL AUTO_INCREMENT,
  `horizontal_alignment` varchar(45) DEFAULT NULL,
  `vertical_alignment` varchar(45) DEFAULT NULL,
  `top_margin` int DEFAULT NULL,
  `left_margin` int DEFAULT NULL,
  `font_style` varchar(45) DEFAULT NULL,
  `font_color` varchar(45) DEFAULT NULL,
  `indentation` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `presentable_template`
--

LOCK TABLES `presentable_template` WRITE;
/*!40000 ALTER TABLE `presentable_template` DISABLE KEYS */;
INSERT INTO `presentable_template` VALUES (1,'left','top',20,30,'Arial','#000000',10),(2,'center','center',15,15,'Times New Roman','#FFFFFF',5),(3,'right','bottom',25,40,'Georgia','#333333',15),(4,'left','center',10,20,'Verdana','#FFFFFF',8),(5,'center','top',30,10,'Helvetica','#000000',12),(6,'right','center',20,35,'Courier New','#FFFFFF',10),(7,'left','bottom',15,25,'Trebuchet MS','#333333',5),(8,'center','center',25,15,'Garamond','#FFFFFF',15),(9,'right','top',10,30,'Impact','#000000',8),(10,'left','center',20,20,'Comic Sans MS','#FFFFFF',10),(11,'center','bottom',30,10,'Arial Narrow','#333333',12),(12,'right','center',15,35,'Book Antiqua','#FFFFFF',5),(13,'left','top',25,15,'Calibri','#000000',15),(14,'center','center',10,30,'Palatino','#FFFFFF',8),(15,'right','bottom',20,20,'Futura','#333333',10),(16,'left','center',30,10,'Gill Sans','#FFFFFF',12),(17,'center','top',15,35,'Lato','#000000',5),(18,'right','center',25,15,'Montserrat','#FFFFFF',15),(19,'left','bottom',10,30,'Open Sans','#333333',8),(20,'center','center',20,20,'Raleway','#FFFFFF',10),(21,'left','middle',5,5,'bold italic','#ff0000',5),(22,'center','top',0,0,'normal','#e1ff00',0);
/*!40000 ALTER TABLE `presentable_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `presentation`
--

DROP TABLE IF EXISTS `presentation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `presentation` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text,
  `teacher_id` int NOT NULL,
  `course_id` int NOT NULL,
  `created_by` int DEFAULT NULL,
  `creation_date` datetime DEFAULT NULL,
  `pres_temp_id` int DEFAULT NULL,
  `lesson_id` int DEFAULT NULL,
  `presentable_id` int DEFAULT NULL,
  `teachable_id` int DEFAULT NULL,
  `session_id` int DEFAULT NULL,
  `presentable_temp_id` int DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `Pr_T_id_idx` (`pres_temp_id`),
  KEY `sess_id_idx` (`session_id`),
  KEY `fk_presentation_teacher` (`teacher_id`),
  KEY `fk_presentation_course` (`course_id`),
  KEY `fk_presentation_teachable` (`teachable_id`),
  KEY `fk_presentable_temp_id` (`presentable_temp_id`),
  CONSTRAINT `fk_presentable_temp_id` FOREIGN KEY (`presentable_temp_id`) REFERENCES `presentable_template` (`id`),
  CONSTRAINT `fk_presentation_course` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_code`),
  CONSTRAINT `fk_presentation_teachable` FOREIGN KEY (`teachable_id`) REFERENCES `teachable` (`Id`),
  CONSTRAINT `fk_presentation_teacher` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`memberID`),
  CONSTRAINT `Pr_T_id` FOREIGN KEY (`pres_temp_id`) REFERENCES `presentation_template` (`Id`),
  CONSTRAINT `sess_id` FOREIGN KEY (`session_id`) REFERENCES `session` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `presentation`
--

LOCK TABLES `presentation` WRITE;
/*!40000 ALTER TABLE `presentation` DISABLE KEYS */;
INSERT INTO `presentation` VALUES (54,'Presentation for Lesson 11','Covers the fundamentals of HTML',2,1,2,'2025-07-03 12:05:46',18,1,1,1,37,NULL),(61,'About Application','✅ Achievements:\r\n\r\nDelivered a working platform with real-time sync\r\n\r\nIncreased teacher efficiency & student interaction',2,12,2,'2025-07-11 00:02:30',16,14,22,17,36,NULL);
/*!40000 ALTER TABLE `presentation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `presentation_template`
--

DROP TABLE IF EXISTS `presentation_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `presentation_template` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) DEFAULT NULL,
  `background_color` varchar(45) DEFAULT NULL,
  `Font` varchar(45) DEFAULT NULL,
  `slide_arrangement` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `presentation_template`
--

LOCK TABLES `presentation_template` WRITE;
/*!40000 ALTER TABLE `presentation_template` DISABLE KEYS */;
INSERT INTO `presentation_template` VALUES (1,'Light Classic','#FFFFFF','Roboto','fade'),(2,'Dark Modern','#1C2526','Helvetica','slide'),(3,'Soft Gray','#E5E5E5','Lato','zoom'),(4,'Deep Blue','#0A3D62','Montserrat','bounce'),(5,'Bright White','#F5F5F5','Open Sans','vertical'),(6,'Midnight Black','#121212','Raleway','horizontal'),(7,'Warm Ivory','#FFF8E7','Poppins','rotate'),(8,'Cool Slate','#2E4057','Noto Sans','flip'),(9,'Clean White','#FFFFFF','Roboto','pulse'),(10,'Charcoal','#333333','Helvetica','fade'),(11,'Light Beige','#F5F5DC','Lato','slide'),(12,'Dark Teal','#0A4C5A','Montserrat','zoom'),(13,'Pure White','#FFFFFF','Open Sans','bounce'),(14,'Deep Purple','#3C2F5F','Raleway','vertical'),(15,'Soft Cream','#FDF5E6','Poppins','horizontal'),(16,'Forest Green','#1B4332','Noto Sans','rotate'),(17,'Bright White','#F5F5F5','Roboto','flip'),(18,'Dark Indigo','#2B2D42','Helvetica','pulse'),(19,'Light Gray','#E8ECEF','Lato','fade'),(20,'Dark Gray','#343A40','Montserrat','slide'),(21,'New Template','#70d4ff','Lucida Sans','Horizontal'),(22,'trial','#fcd4d4','Courier New','Vertical');
/*!40000 ALTER TABLE `presentation_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quiz`
--

DROP TABLE IF EXISTS `quiz`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quiz` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `presentation_id` int DEFAULT NULL,
  `lesson_id` int DEFAULT NULL,
  `session_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `status` enum('draft','assigned','completed') NOT NULL DEFAULT 'draft',
  `questions_json` text,
  `open_time` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `Prsntn_id_idx` (`presentation_id`),
  KEY `Ses_id_idx` (`session_id`),
  CONSTRAINT `Prs_id` FOREIGN KEY (`presentation_id`) REFERENCES `presentation` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `Ses_id_new` FOREIGN KEY (`session_id`) REFERENCES `session` (`Id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quiz`
--

LOCK TABLES `quiz` WRITE;
/*!40000 ALTER TABLE `quiz` DISABLE KEYS */;
INSERT INTO `quiz` VALUES (23,'Sample Quiz','2025-07-28 21:30:00','2025-07-28 22:30:00',54,1,29,2,'assigned','[{\"text\":\"Is the Earth flat?\",\"type\":\"true_false\",\"correct_answer\":\"false\"},{\"text\":\"What is 2 + 2?\",\"type\":\"short_answer\",\"correct_answer\":\"4\"}]',NULL),(24,'HTML','2025-07-21 14:00:00','2025-07-21 15:00:00',54,1,29,2,'assigned','[{\"text\":\"What does HTML stands for\",\"type\":\"multiple_choice\",\"options\":[{\"text\":\"Hyper Text Makeup Language\",\"correct\":false},{\"text\":\"Hyper Text Markup Language\",\"correct\":true},{\"text\":\"Hi Text Marked Location\",\"correct\":false}],\"correct_answer\":\"1\"},{\"text\":\"Html is a language.\",\"type\":\"true_false\",\"correct_answer\":\"false\"},{\"text\":\"Whrite three uses of html in website making.\",\"type\":\"short_answer\",\"correct_answer\":\"Structure, Hyperlinks, Embedding Media\"}]',NULL);
/*!40000 ALTER TABLE `quiz` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quiz_attempt`
--

DROP TABLE IF EXISTS `quiz_attempt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quiz_attempt` (
  `id` int NOT NULL AUTO_INCREMENT,
  `quiz_id` int NOT NULL,
  `course_id` varchar(255) DEFAULT NULL,
  `student_id` int NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime DEFAULT NULL,
  `score` decimal(5,2) DEFAULT NULL,
  `status` enum('not_started','in_progress','submitted','graded') DEFAULT 'not_started',
  `time_spent` int DEFAULT NULL COMMENT 'In seconds',
  `max_score` decimal(5,2) DEFAULT NULL,
  `answers_json` text,
  `attempt_number` int DEFAULT '1',
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `quiz_id` (`quiz_id`),
  KEY `student_id` (`student_id`),
  KEY `idx_quiz_attempt_course_id` (`course_id`),
  CONSTRAINT `quiz_attempt_ibfk_1` FOREIGN KEY (`quiz_id`) REFERENCES `quiz` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `quiz_attempt_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quiz_attempt`
--

LOCK TABLES `quiz_attempt` WRITE;
/*!40000 ALTER TABLE `quiz_attempt` DISABLE KEYS */;
INSERT INTO `quiz_attempt` VALUES (2,23,'1',3,'2025-07-06 13:11:48','2025-07-06 13:48:15',2.00,'submitted',2187,3.00,'[\"1\",\"true\",\"4\"]',1,'::1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36','2025-07-06 11:11:48','2025-07-06 19:09:17'),(4,24,NULL,3,'2025-07-21 11:54:23','2025-07-21 11:56:41',1.00,'submitted',138,3.00,'[\"1\",\"true\",\"HTML is useful in describing structure. It is useful to embed media.\"]',1,'::1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36','2025-07-21 09:54:24','2025-07-21 09:56:41');
/*!40000 ALTER TABLE `quiz_attempt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `session`
--

DROP TABLE IF EXISTS `session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `session` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `scheduled_time` datetime DEFAULT NULL,
  `presentation_id` int NOT NULL DEFAULT '1',
  `quiz_id` int DEFAULT NULL,
  `teacher_id` int NOT NULL,
  `status` enum('scheduled','started','ended','cancelled') DEFAULT 'scheduled',
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `duration` int DEFAULT NULL,
  `presentation_saved` tinyint DEFAULT '0',
  `name` varchar(255) DEFAULT NULL,
  `current_slide_h` int DEFAULT NULL,
  `current_slide_v` int DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `PR_idx` (`presentation_id`),
  KEY `TC_idx` (`teacher_id`),
  KEY `Q_idx` (`quiz_id`),
  CONSTRAINT `session_ibfk_1` FOREIGN KEY (`presentation_id`) REFERENCES `presentation` (`Id`) ON DELETE RESTRICT,
  CONSTRAINT `session_ibfk_2` FOREIGN KEY (`quiz_id`) REFERENCES `quiz` (`Id`) ON DELETE SET NULL,
  CONSTRAINT `session_ibfk_3` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`memberID`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `session`
--

LOCK TABLES `session` WRITE;
/*!40000 ALTER TABLE `session` DISABLE KEYS */;
INSERT INTO `session` VALUES (19,'2025-05-10 09:47:27',54,NULL,2,'ended','2025-05-10 09:47:31','2025-05-10 12:49:31',182,1,'Session 1',NULL,NULL),(20,'2025-05-18 10:59:15',54,NULL,2,'scheduled','2025-05-18 13:58:00',NULL,62,0,'Session 2',NULL,NULL),(21,'2025-05-18 11:06:15',54,NULL,2,'scheduled','2025-06-11 12:37:18',NULL,62,0,'Session 3',NULL,NULL),(27,'2025-06-05 17:27:06',54,NULL,2,'started','2025-06-05 20:28:00',NULL,NULL,1,'Session 8 (UPDATED) (UPDATED)',9,0),(29,'2025-06-05 17:36:41',54,NULL,2,'started','2025-06-05 20:45:00',NULL,NULL,1,'Session 9 (UPDATED)',4,0),(34,'2025-07-06 23:23:32',54,NULL,2,'scheduled','2025-07-10 01:21:19',NULL,NULL,1,'Session 8',NULL,NULL),(35,'2025-07-11 01:21:15',61,NULL,2,'started','2025-07-11 01:21:19',NULL,NULL,1,'Session 9',0,0),(36,'2025-08-01 01:17:00',61,NULL,2,'scheduled',NULL,NULL,NULL,1,'Session 12',NULL,NULL),(37,'2025-08-01 17:39:00',54,NULL,2,'started','2025-08-02 18:54:24',NULL,NULL,1,'Session 11',NULL,NULL);
/*!40000 ALTER TABLE `session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `session_student`
--

DROP TABLE IF EXISTS `session_student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `session_student` (
  `session_id` int NOT NULL,
  `student_id` int NOT NULL,
  PRIMARY KEY (`session_id`,`student_id`),
  KEY `student_id_idx` (`student_id`),
  CONSTRAINT `sess` FOREIGN KEY (`session_id`) REFERENCES `session` (`Id`),
  CONSTRAINT `std` FOREIGN KEY (`student_id`) REFERENCES `student` (`memberID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `session_student`
--

LOCK TABLES `session_student` WRITE;
/*!40000 ALTER TABLE `session_student` DISABLE KEYS */;
/*!40000 ALTER TABLE `session_student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `slide`
--

DROP TABLE IF EXISTS `slide`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `slide` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `lesson_id` int DEFAULT NULL,
  `Title` varchar(1000) DEFAULT NULL,
  `Content` varchar(5000) DEFAULT NULL,
  `Sequence_num` int DEFAULT NULL,
  `Presentable_id` int DEFAULT NULL,
  `Presentation_id` int DEFAULT NULL,
  `Teachable_id` int DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `P_id_idx` (`Presentation_id`),
  KEY `fk_slide_teachable` (`Teachable_id`),
  KEY `fk_slide_lesson` (`lesson_id`),
  CONSTRAINT `fk_slide_lesson` FOREIGN KEY (`lesson_id`) REFERENCES `lesson` (`Id`),
  CONSTRAINT `fk_slide_presentation` FOREIGN KEY (`Presentation_id`) REFERENCES `presentation` (`Id`),
  CONSTRAINT `fk_slide_teachable` FOREIGN KEY (`Teachable_id`) REFERENCES `teachable` (`Id`),
  CONSTRAINT `P_id` FOREIGN KEY (`Presentation_id`) REFERENCES `presentation` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `Teachable_id` FOREIGN KEY (`Teachable_id`) REFERENCES `teachable` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `slide`
--

LOCK TABLES `slide` WRITE;
/*!40000 ALTER TABLE `slide` DISABLE KEYS */;
INSERT INTO `slide` VALUES (1,1,'Introduction to HTML','Do You Know About HTML?',1,1,54,1),(2,1,'HTML Tags','Basic HTML Tags Explained',2,2,54,1),(3,1,'Attributes','How HTML attributes work',3,3,54,1),(4,1,'HTML Elements','Understanding elements',4,4,54,2),(5,1,'Block vs Inline Elements','Types of HTML elements',5,4,54,2),(6,1,'Forms Introduction','Basics of HTML forms',6,5,54,3),(7,1,'Input Types','Different input types in HTML',7,6,54,3),(8,1,'Form Validation','Client-side form validation techniques',8,5,54,3),(9,1,'HTML Tables','Why use tables?',9,6,54,4),(10,1,'Table Structure','Understanding table elements',10,6,54,4),(11,1,'Table Styling','Applying CSS to tables',11,6,54,4),(12,1,'HTML Semantic Elements','Why use semantic elements?',12,7,54,5),(13,1,'Header & Footer','Using header and footer tags',13,7,54,5),(14,1,'Main & Section','Structuring content properly',14,7,54,5),(15,1,'Nav & Aside','Navigation and sidebar elements',15,7,54,5),(16,1,'Practical Example','Building a simple HTML page',16,4,54,2),(17,1,'Forms in Action','Creating a real-world form',17,5,54,3),(18,1,'Interactive Tables','Making tables responsive',18,6,54,4),(19,1,'Accessibility in HTML','Making web content accessible',19,7,54,5),(20,1,'Conclusion','Recap of HTML fundamentals',20,1,54,1),(51,14,'Introduction','? Key Features:\r\n\r\nTeaching Material Management\r\nLesson Presentations\r\nReal-Time Live Sessions\r\nQuiz & Student Feedback Integration',3,23,NULL,17),(52,14,'Title Slide','Educational Presentation Platform\r\nPresented by: Noorulain Hamid (616-FBAS/BSIT/F21)\r\nUnder Supervision of: Dr. Asma Sajjad\r\nBS Information Technology – Final Year Project\r\nInternational Islamic University Islamabad',1,22,NULL,17),(53,14,'Table of Content','Introduction\r\nProblem Statement\r\nObjective & Scope\r\nFeatures & Modules\r\nSystem Architecture\r\nUse Cases & Diagrams\r\nScreenshots/Demo\r\nTechnologies Used\r\nChallenges & Testing\r\nConclusion & Future Work',2,22,NULL,17),(54,14,'\n                            \n                            \n                            \n                            \n                            \n                            \n                            \n                            \n                            \n                            \n                            \n                            \n                            \n                            \n                            \n                            \n                            \n                            Title Slide                                                                                                                                                                                                                                                                                                                                                                                                                             ','Educational Presentation Platform\r\n\r\nSuggested By: Dr Zaheer\r\nPresented by: \r\n\r\nNoorulain Hamid (616-FBAS/BSIT/F21)\r\n\r\nIqra Shaheen (634-FBAS/BSIT/F21)\r\n\r\nSabeen Zahra (610-FBAS/BSIT/F21)\r\nUnder Supervision of: Dr. Asma Sajjad\r\nBS Information Technology – Final Year Project\r\n\r\nInternational Islamic University Islamabad',1,22,61,17),(55,14,'\n                            \n                            \n                            \n                            \n                            \n                            \n                            \n                            \n                            \n                            \n                            \n                            \n                            \n                            \n                            \n                            \n                            \n                            Table of Content                                                                                                                                                                                                                                                                                                                                                                                                                        ','Introduction\r\n\r\nProblem Statement\r\n\r\nObjective &amp; Scope\r\n\r\nFeatures &amp; Modules\r\n\r\nSystem Architecture\r\n\r\nUse Cases &amp; Diagrams\r\n\r\nScreenshots/Demo\r\n\r\nTechnologies Used\r\n\r\nChallenges &amp; Testing\r\n\r\n                                                                                Conclusion &amp; Future Work',2,22,61,17),(56,14,'\n                            \n                            \n                            \n                            \n                            \n                            \n                            \n                            \n                            \n                            \n                            \n                            \n                            \n                            \n                            \n                            \n                            \n                            Introduction                                                                                                                                                                                                                                                                                                                                                                                                                            ','? Key Features:\r\nTeaching Material Management\r\n\r\nLesson Presentations\r\n\r\nReal-Time Live Sessions\r\n\r\n                                                                        Quiz &amp; Student Feedback Integration',3,23,61,17),(82,1,'Test Video','Just Testing Video Slide',4,26,NULL,1);
/*!40000 ALTER TABLE `slide` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student` (
  `memberID` int NOT NULL,
  `session_id` int DEFAULT NULL,
  `attendance_status` enum('pending','joined','left') DEFAULT 'pending' COMMENT 'Tracks student participation in session',
  `profile_image` varchar(255) DEFAULT NULL COMMENT 'Profile image path for the student',
  PRIMARY KEY (`memberID`),
  KEY `student_ibfk_1` (`session_id`),
  CONSTRAINT `fk_student_user` FOREIGN KEY (`memberID`) REFERENCES `user` (`id`),
  CONSTRAINT `student_ibfk_1` FOREIGN KEY (`session_id`) REFERENCES `session` (`Id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES (1,NULL,'pending',NULL),(3,NULL,'pending',NULL);
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_activity`
--

DROP TABLE IF EXISTS `student_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_activity` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL,
  `course_id` varchar(255) DEFAULT NULL,
  `activity_type` varchar(100) NOT NULL,
  `activity_data` json DEFAULT NULL COMMENT 'JSON data for flexible activity tracking',
  `duration_minutes` int DEFAULT '0',
  `score` decimal(5,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx-student_activity-student_id` (`student_id`),
  KEY `idx-student_activity-course_id` (`course_id`),
  KEY `idx-student_activity-activity_type` (`activity_type`),
  KEY `idx-student_activity-created_at` (`created_at`),
  CONSTRAINT `fk-student_activity-student_id` FOREIGN KEY (`student_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_activity`
--

LOCK TABLES `student_activity` WRITE;
/*!40000 ALTER TABLE `student_activity` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_join_requests`
--

DROP TABLE IF EXISTS `student_join_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_join_requests` (
  `idStudent_join_Requests` int NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL,
  `teacher_id` int NOT NULL,
  `course_id` int NOT NULL,
  `status` enum('pending','approved') NOT NULL DEFAULT 'pending',
  `date_sent` date DEFAULT NULL,
  `firstname` varchar(45) DEFAULT NULL,
  `lastname` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idStudent_join_Requests`),
  KEY `fk_student_join_requests_student` (`student_id`),
  CONSTRAINT `fk_student_join_requests_student` FOREIGN KEY (`student_id`) REFERENCES `student` (`memberID`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_join_requests`
--

LOCK TABLES `student_join_requests` WRITE;
/*!40000 ALTER TABLE `student_join_requests` DISABLE KEYS */;
INSERT INTO `student_join_requests` VALUES (51,3,2,8,'approved','2025-07-17','ali',NULL),(59,3,2,12,'approved','2025-07-17','ali',NULL),(63,3,2,8,'pending','2025-08-01','ali',NULL),(64,3,2,4,'pending','2025-08-01','ali',NULL),(65,3,2,11,'pending','2025-08-01','ali',NULL);
/*!40000 ALTER TABLE `student_join_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teachable`
--

DROP TABLE IF EXISTS `teachable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teachable` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Content` varchar(500) DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `Sequence_num` int DEFAULT NULL,
  `Less_id` int DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teachable`
--

LOCK TABLES `teachable` WRITE;
/*!40000 ALTER TABLE `teachable` DISABLE KEYS */;
INSERT INTO `teachable` VALUES (1,'HTML Introduction Content',2,1,1),(2,'HTML Elements Content',2,2,1),(3,'HTML Forms Content',2,3,1),(4,'HTML Tables Content',2,4,1),(5,'HTML Semantic Elements',2,5,1),(17,'I am Teachable - Here to teach you how to use this application',2,1,14),(18,'I am testing the teachable',2,1,3);
/*!40000 ALTER TABLE `teachable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teacher`
--

DROP TABLE IF EXISTS `teacher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teacher` (
  `memberID` int NOT NULL,
  `specialization` varchar(255) DEFAULT NULL COMMENT 'Teacher''s area of expertise (e.g., Web Development, Math)',
  `bio` text COMMENT 'Short biography or description of the teacher',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Record creation timestamp',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record last updated timestamp',
  `name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `profile_image` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`memberID`),
  CONSTRAINT `f_teacher_user` FOREIGN KEY (`memberID`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teacher`
--

LOCK TABLES `teacher` WRITE;
/*!40000 ALTER TABLE `teacher` DISABLE KEYS */;
INSERT INTO `teacher` VALUES (2,'Software Engineering','Recent Grad. and Teaching Assistant @ LearnApp.online','2025-03-12 14:58:23','2025-08-01 13:01:15','Iman Younis','iman@gmail.com','/uploads/profiles/teacher_2_1752961590.png'),(4,NULL,NULL,'2025-03-12 14:58:23','2025-03-12 14:58:23','',NULL,NULL),(19,NULL,NULL,'2025-07-31 19:51:05','2025-07-31 19:51:05','sabeen','sabeenzahra11@gmail.com',NULL);
/*!40000 ALTER TABLE `teacher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `topic`
--

DROP TABLE IF EXISTS `topic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `topic` (
  `topicID` int NOT NULL AUTO_INCREMENT,
  `topic_title` varchar(45) NOT NULL,
  `topic_description` longtext NOT NULL,
  `learning_target` mediumtext NOT NULL,
  `course_code` int NOT NULL,
  `sequence_num` int NOT NULL,
  `tip` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`topicID`),
  KEY `fk_topic_course_idx` (`course_code`),
  CONSTRAINT `fk_topic_course` FOREIGN KEY (`course_code`) REFERENCES `courses` (`course_code`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `topic`
--

LOCK TABLES `topic` WRITE;
/*!40000 ALTER TABLE `topic` DISABLE KEYS */;
INSERT INTO `topic` VALUES (1,'html','introduction to html','learn basics of web page design',1,1,'consists of tags'),(3,'css','styling and layout','color schemes',1,2,'download style sheet'),(7,'Computer Reliability','To which extent we can rely on systems','Should know the basics of relying on modern technology',8,1,'Review Presentation of PP (unit 1)'),(8,'Computer Crime and security','Threats to our systems and how to provide security against them','Student must be able to practically defend his own system security',8,2,'See Presentation of unit 2'),(9,'Enryption Techniques','CIphers','A student should be able to enrypt data using ceaser cipher , mono',11,1,'see presentation '),(10,'Presentation','To Present to the Panel.','Showcase of FYP',12,1,'LLMs');
/*!40000 ALTER TABLE `topic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(45) DEFAULT NULL,
  `username` varchar(45) DEFAULT NULL,
  `password_hash` varchar(255) NOT NULL,
  `password_reset_token` varchar(255) DEFAULT NULL,
  `verification_token` varchar(255) DEFAULT NULL,
  `status` smallint NOT NULL,
  `created_at` varchar(100) DEFAULT NULL,
  `updated_at` varchar(100) DEFAULT NULL,
  `role` varchar(45) DEFAULT NULL,
  `auth_key` varchar(32) NOT NULL,
  `profile_image` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `password_reset_token_UNIQUE` (`password_reset_token`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `username_UNIQUE` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'daniel@gmail.com','daniel','$2y$13$6nwLUD1afLp/H7KwG6Uwgu5ilPE3YzuD8Bwt7VNDy.UCV6jCU75Au',NULL,'EOkuHHZIGnejevNapY99yVrlZKovomPh_1738711502',10,'1738711502','1738711502','student','aiMbC-8D6BK68qHadGwW3S2JFfN3XXHC',NULL),(2,'iman@gmail.com','iman','$2y$13$Nw9OBudBHDK1upaw/D.aduh2QNO1FryBov84PYTD6mIiuTO6miyQW',NULL,'-cR_tgbv-GYsNNRtZX4B5dVa_JtyAda3_1738712867',10,'1738712867','1754053023','teacher','Ozf5Yi_UbNuDHgq4YWV9l5C5_SZIow8c','/uploads/profiles/teacher_2_1752961590.png'),(3,'ali@gmail.com','ali','$2y$13$gFEdOriHFGb.KqGulLIyWu3iw5npQ5s9lnPfVoRJLkaF2SYqUO85W',NULL,'sJCNdKwfVtUzl7JmLKESlMDdcNxrsQb1_1738897434',10,'1738897434','1738897434','student','mfbbmBWkb4cQoxyCc8nUGEA_os7egoKM',NULL),(4,'saba@gmail.com','saba','$2y$13$FR6aGs6YwtIQe5k0lQ53Yel54StNti7QaQm8seVppKsxZS2qxFRj6',NULL,'Z1RkkILuCs3K4sMs_RgbiVe6kzlFY-iN_1738897568',10,'1738897568','1738897568','teacher','gPBFwSGDTe3sf2SFcjCyyoyLWXgyv7sX',NULL),(5,'noor03awan@gmail.com','noor','$2y$13$rqWD2rbV.jo.U7471AHjNeSyKEAhFgWcPedfwKEXJmaHg2RwGbEJu','KjtfCx_i5XtcaNPDtcaHAf3DwYQMz9of_1754054115','InBCRppO9ehclCT5MrGaYdIaR_NTtNn1_1741814512',10,'1741814512','1754054115','teacher','AyZIVp3f43m4g5LDQIBf9Q9ZchlPtGaN',NULL),(6,'iiqrashaheen@gmail.com','iqra','$2y$13$59Tq4psJqhS/mB.02s2a.u8hvu03LO.KQwa458hLr0bFnvn6Pb1jW',NULL,'vt_BFGuT05M57R8o6GRvcHRwZbbLQkWZ_1741814743',10,'1741814743','1741814743','teacher','9_1H7kzqYdHxPGYOtb1etQtub1lUXjkw',NULL),(19,'sabeenzahra11@gmail.com','sabeen','$2y$13$IdYi.awLW.hqj4Jvvb2wQukknlppnuJy71I5Si9U9znP8PTDQiUea',NULL,'8LAY4SGbJ2oV129YQYK5PyFtGUuIBavP_1753991465',10,'1753991465','1753991465','teacher','_gbfH9g94R6SEXUwMrtkmhGZvFMvE8sH',NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usr_ses`
--

DROP TABLE IF EXISTS `usr_ses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usr_ses` (
  `User_Id` int NOT NULL,
  `Session_Id` int NOT NULL,
  `Joining_Date` datetime DEFAULT NULL,
  `Status` varchar(45) DEFAULT NULL,
  KEY `Usr_Id_idx` (`User_Id`),
  KEY `Session_Id_idx` (`Session_Id`),
  CONSTRAINT `Session_Id` FOREIGN KEY (`Session_Id`) REFERENCES `session` (`Id`),
  CONSTRAINT `Usr_Id` FOREIGN KEY (`User_Id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='								';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usr_ses`
--

LOCK TABLES `usr_ses` WRITE;
/*!40000 ALTER TABLE `usr_ses` DISABLE KEYS */;
/*!40000 ALTER TABLE `usr_ses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usr_sub`
--

DROP TABLE IF EXISTS `usr_sub`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usr_sub` (
  `User_Id` int NOT NULL,
  `Subject_Id` int NOT NULL,
  KEY `User_Id_idx` (`User_Id`),
  KEY `Subject_Id_idx` (`Subject_Id`),
  CONSTRAINT `Subject_Id` FOREIGN KEY (`Subject_Id`) REFERENCES `courses` (`course_code`),
  CONSTRAINT `User_Id` FOREIGN KEY (`User_Id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usr_sub`
--

LOCK TABLES `usr_sub` WRITE;
/*!40000 ALTER TABLE `usr_sub` DISABLE KEYS */;
/*!40000 ALTER TABLE `usr_sub` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `website_statistics`
--

DROP TABLE IF EXISTS `website_statistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `website_statistics` (
  `id` int NOT NULL AUTO_INCREMENT,
  `stat_key` varchar(100) NOT NULL,
  `stat_name` varchar(255) NOT NULL,
  `stat_value` decimal(10,2) NOT NULL,
  `stat_type` varchar(50) NOT NULL DEFAULT 'number',
  `display_format` varchar(100) DEFAULT NULL,
  `description` text,
  `category` varchar(100) DEFAULT 'general',
  `is_active` tinyint(1) DEFAULT '1',
  `sort_order` int DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `stat_key` (`stat_key`),
  KEY `idx-website_statistics-stat_key` (`stat_key`),
  KEY `idx-website_statistics-category` (`category`),
  KEY `idx-website_statistics-is_active` (`is_active`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `website_statistics`
--

LOCK TABLES `website_statistics` WRITE;
/*!40000 ALTER TABLE `website_statistics` DISABLE KEYS */;
INSERT INTO `website_statistics` VALUES (1,'teacher_satisfaction_rate','Teacher Satisfaction Rate',87.00,'percentage','{value}%','Based on educator surveys','satisfaction',1,1,'2025-08-01 12:02:57','2025-08-01 12:02:57'),(2,'active_schools','Active Schools',3500.00,'number','{value}','Across countries worldwide','reach',1,2,'2025-08-01 12:02:57','2025-08-01 12:02:57'),(3,'annual_renewal_rate','Annual Renewal Rate',92.00,'percentage','{value}%','Highest in educational technology','retention',1,3,'2025-08-01 12:02:57','2025-08-01 12:02:57'),(4,'educator_surveys','Educator Surveys',1200.00,'number','{value}+','Total surveys conducted','research',1,4,'2025-08-01 12:02:57','2025-08-01 12:02:57'),(5,'countries_served','Countries Served',42.00,'number','{value}','Countries worldwide','reach',1,5,'2025-08-01 12:02:57','2025-08-01 12:02:57'),(6,'total_educators','Total Educators',10000.00,'number','{value}+','Educators creating engaging lessons','users',1,6,'2025-08-01 12:02:57','2025-08-01 12:02:57');
/*!40000 ALTER TABLE `website_statistics` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-08-03  0:51:27
