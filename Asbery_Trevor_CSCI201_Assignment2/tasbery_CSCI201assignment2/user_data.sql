DROP DATABASE IF EXISTS user_data;
CREATE DATABASE user_data;
USE user_data;

CREATE TABLE `user_details` (
  `email` varchar(300) NOT NULL,
  `name` varchar(300) NOT NULL,
  `password` varchar(300) NOT NULL,
  PRIMARY KEY (`email`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
