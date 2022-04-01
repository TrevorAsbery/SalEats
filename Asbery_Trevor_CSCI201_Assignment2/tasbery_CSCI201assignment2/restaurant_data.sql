DROP DATABASE IF EXISTS restaurant_data;
CREATE DATABASE restaurant_data;
USE restaurant_data;

CREATE TABLE `Category` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(45) NOT NULL,
  `restaurant_id` varchar(45) NOT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `category_id_UNIQUE` (`category_id`),
  KEY `restaurant_id_idx` (`restaurant_id`),
  CONSTRAINT `restaurant_id` FOREIGN KEY (`restaurant_id`) REFERENCES `Restaurant` (`restaurant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `Rating_details` (
  `rating_id` int NOT NULL AUTO_INCREMENT,
  `review_count` int NOT NULL,
  `rating` varchar(45) NOT NULL,
  PRIMARY KEY (`rating_id`),
  UNIQUE KEY `Rating_details_UNIQUE` (`rating_id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `Restaurant` (
  `restaurant_id` varchar(45) NOT NULL,
  `restaurant_name` varchar(45) NOT NULL,
  `details_id` int NOT NULL,
  `rating_id` int NOT NULL,
  PRIMARY KEY (`restaurant_id`),
  UNIQUE KEY `restaurant_UNIQUE` (`restaurant_id`),
  KEY `details_id_idx` (`details_id`),
  KEY `rating_id_idx` (`rating_id`),
  CONSTRAINT `details_id` FOREIGN KEY (`details_id`) REFERENCES `Restaurant_details` (`details_id`),
  CONSTRAINT `rating_id` FOREIGN KEY (`rating_id`) REFERENCES `Rating_details` (`rating_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `Restaurant_details` (
  `details_id` int NOT NULL AUTO_INCREMENT,
  `image_url` varchar(150) NOT NULL,
  `address` varchar(150) NOT NULL,
  `phone_no` varchar(45) NOT NULL,
  `estimated_price` varchar(45) NOT NULL,
  `yelp_url` varchar(500) NOT NULL,
  PRIMARY KEY (`details_id`),
  UNIQUE KEY `details_id_UNIQUE` (`details_id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


