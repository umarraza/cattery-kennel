-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 01, 2019 at 03:29 PM
-- Server version: 10.1.38-MariaDB
-- PHP Version: 7.3.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cattery&kennels`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `id` int(11) NOT NULL,
  `venueId` int(11) NOT NULL,
  `customerId` int(11) NOT NULL,
  `noOfCats` int(10) NOT NULL,
  `noOfDogs` int(10) NOT NULL,
  `checkIn` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `checkOut` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isActive` tinyint(3) DEFAULT NULL,
  `isRegistered` tinyint(3) DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`id`, `venueId`, `customerId`, `noOfCats`, `noOfDogs`, `checkIn`, `checkOut`, `isActive`, `isRegistered`, `createdAt`, `updatedAt`) VALUES
(1, 1, 1, 2, 3, '2019-07-31 19:00:00', '2019-08-11 23:58:01', 1, 1, '2019-08-01 00:05:23', '2019-08-01 00:05:23'),
(2, 1, 2, 2, 3, '2019-07-31 23:58:01', '2019-08-11 23:58:01', 0, 0, '2019-08-01 01:20:52', '2019-08-01 01:20:52'),
(4, 1, 3, 5, 5, '2019-08-03 19:00:00', '2019-08-09 19:00:00', 1, 1, '2019-08-01 04:41:39', '2019-08-01 04:41:39'),
(5, 1, 3, 5, 5, '2019-07-02 19:00:00', '2019-07-11 19:00:00', 0, 1, '2019-08-01 04:41:56', '2019-08-01 04:41:56');

-- --------------------------------------------------------

--
-- Table structure for table `cattery_images`
--

CREATE TABLE `cattery_images` (
  `id` int(10) NOT NULL,
  `imageName` varchar(100) NOT NULL,
  `isProfile` int(11) NOT NULL,
  `venueId` int(10) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cattery_images`
--

INSERT INTO `cattery_images` (`id`, `imageName`, `isProfile`, `venueId`, `createdAt`, `updatedAt`) VALUES
(1, 'image_1564635822.jpeg', 1, 1, '2019-08-01 00:03:42', '2019-08-01 00:03:42');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` int(10) NOT NULL,
  `bookerName` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `address` varchar(100) NOT NULL,
  `phoneNumber` varchar(50) NOT NULL,
  `requirements` varchar(200) NOT NULL,
  `userId` int(10) DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `bookerName`, `email`, `address`, `phoneNumber`, `requirements`, `userId`, `createdAt`, `updatedAt`) VALUES
(1, 'Numan ALi', 'numan@gmail.com', 'Lahore, Pakistan', '03034969407', 'Some requirements', 87, '2019-08-01 00:05:23', '2019-08-01 00:05:23'),
(2, 'Numan ALi', 'numan@gmail.com', 'Lahore, Pakistan', '03034969407', 'Some requirements', NULL, '2019-08-01 01:20:52', '2019-08-01 01:20:52'),
(3, 'Numan ALi', 'numan@gmail.com', 'Lahore, Pakistan', '03034969407', 'Some requirements', NULL, '2019-08-01 02:03:14', '2019-08-01 02:03:14');

-- --------------------------------------------------------

--
-- Table structure for table `customer_pets`
--

CREATE TABLE `customer_pets` (
  `id` int(11) NOT NULL,
  `catName` varchar(50) DEFAULT NULL,
  `dogName` varchar(50) DEFAULT NULL,
  `dateOfBirth` varchar(50) NOT NULL,
  `image` varchar(50) NOT NULL,
  `customerId` int(10) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `peak_dates`
--

CREATE TABLE `peak_dates` (
  `id` int(10) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `occurence` int(10) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(10) NOT NULL,
  `description` varchar(200) NOT NULL,
  `label` varchar(50) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updatedAt` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `description`, `label`, `createdAt`, `updatedAt`) VALUES
(1, 'Super Admin', 'super_admin', '2019-05-02 12:33:33', '0000-00-00 00:00:00'),
(2, 'Supplier', 'Supplier', '2019-06-27 12:30:56', '0000-00-00 00:00:00'),
(3, 'Customer', 'Customer', '2019-06-27 12:31:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) NOT NULL,
  `username` varchar(100) NOT NULL,
  `fullName` varchar(50) NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `roleId` int(10) NOT NULL,
  `resetPasswordToken` varchar(255) DEFAULT NULL,
  `createdResetPToken` timestamp NULL DEFAULT NULL,
  `avatarFilePath` varchar(200) DEFAULT NULL,
  `deviceToken` varchar(200) DEFAULT NULL,
  `onlineStatus` tinyint(3) NOT NULL DEFAULT '0',
  `verified` tinyint(3) NOT NULL,
  `googleLogin` varchar(250) DEFAULT NULL,
  `facebookLogin` varchar(250) DEFAULT NULL,
  `language` varchar(20) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updatedAt` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `fullName`, `email`, `password`, `remember_token`, `roleId`, `resetPasswordToken`, `createdResetPToken`, `avatarFilePath`, `deviceToken`, `onlineStatus`, `verified`, `googleLogin`, `facebookLogin`, `language`, `createdAt`, `updatedAt`) VALUES
(1, 'super.admin@admin.com', '', 'super.admin@admin.com', '$2y$10$VwROsyn0bDr5gTh/rnCCG.5JN3kZTAWEEUZPJLHfiZf.84ZLdPtwq', 'J4Wo5S1I3oG53IGMe2ttEW2YFKojus9tizVBsMCr59YPTrbQqUd00YudN4Og', 1, NULL, NULL, NULL, NULL, 0, 1, NULL, NULL, 'English', '2019-06-27 11:25:48', '2019-06-26 19:00:00'),
(86, 'anasmahmood', 'anas mahmood', 'anasmahmood@stackcru.com', '$2y$10$YHWwFqt9k8K1PVVG7xXAdubcdqyM9ZcB4CU6BzhXJAF0ar5xeOwYe', NULL, 2, NULL, NULL, NULL, NULL, 0, 1, NULL, NULL, 'English', '2019-07-31 23:58:01', '2019-07-31 23:58:01'),
(87, 'numanali', 'Numan ALi', 'numan@gmail.com', '$2y$10$GQR0QOcjbZQFr7TROt9wc.QCk9wOwKHop7Sj4HyJypKK3J9sr8dYW', NULL, 3, NULL, NULL, NULL, NULL, 0, 1, NULL, NULL, 'English', '2019-08-01 00:05:23', '2019-08-01 00:05:23'),
(88, 'haris123', 'Haris Ayyaz', 'harisayyaz@gmail.com', '$2y$10$OX5o6O8mWEFqjFZzU3I/qOVRVd6QqjMnsCn5IJTJ6y7hBhKdD3OdW', NULL, 3, NULL, NULL, NULL, NULL, 0, 1, NULL, NULL, 'English', '2019-08-01 02:18:58', '2019-08-01 02:18:58'),
(89, 'umarraza2200', 'umar raza', 'umarraza2200@gmail.com', '$2y$10$EHh25PqYx3TFelC/SzH2kuirdYR5P3gPzPTP7JGixJW/yApLlCql6', NULL, 3, NULL, NULL, NULL, NULL, 0, 1, NULL, NULL, 'English', '2019-08-01 06:44:17', '2019-08-01 06:44:17'),
(90, 'anasmahmood1', 'anas mahmood baig', 'anasmahmood+1@stackcru.com', '$2y$10$GxwEENNoIJrau0yhDzoOzeZRsG75GkyKwVZ2dpNbcLzRv6.k0ZAIq', NULL, 2, NULL, NULL, NULL, NULL, 0, 1, NULL, NULL, 'English', '2019-08-01 06:45:19', '2019-08-01 06:45:19');

-- --------------------------------------------------------

--
-- Table structure for table `venues`
--

CREATE TABLE `venues` (
  `id` int(10) NOT NULL,
  `buisnessName` varchar(50) NOT NULL,
  `address` varchar(100) NOT NULL,
  `postcode` int(10) NOT NULL,
  `phoneNumber` varchar(50) NOT NULL,
  `buisnessDescription` varchar(500) DEFAULT NULL,
  `discountDescription` varchar(500) DEFAULT NULL,
  `facilities` varchar(500) NOT NULL,
  `serviceRate` varchar(50) NOT NULL,
  `discountAvailable` varchar(50) NOT NULL,
  `totalCats` int(100) NOT NULL,
  `totalDogs` int(100) NOT NULL,
  `type` varchar(50) DEFAULT NULL,
  `isPaid` varchar(10) NOT NULL,
  `isAvailable` int(10) NOT NULL DEFAULT '1',
  `userId` int(10) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `venues`
--

INSERT INTO `venues` (`id`, `buisnessName`, `address`, `postcode`, `phoneNumber`, `buisnessDescription`, `discountDescription`, `facilities`, `serviceRate`, `discountAvailable`, `totalCats`, `totalDogs`, `type`, `isPaid`, `isAvailable`, `userId`, `createdAt`, `updatedAt`) VALUES
(1, 'my cattery and kennel', '26/b g1 johar town lahore', 54000, '03249470780', NULL, NULL, 'cleaning and air conditioned', '1000', 'yes', 4, 1, NULL, '1', 1, 86, '2019-08-01 00:01:26', '2019-08-01 04:41:56'),
(2, 'EFRF', 'sdsdfg', 54000, 'sdfg', NULL, NULL, 'dfg', 'fdg', 'no', 20, 20, NULL, '0', 1, 90, '2019-08-01 06:55:16', '2019-08-01 06:55:16');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cattery_images`
--
ALTER TABLE `cattery_images`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customer_pets`
--
ALTER TABLE `customer_pets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `peak_dates`
--
ALTER TABLE `peak_dates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `venues`
--
ALTER TABLE `venues`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `cattery_images`
--
ALTER TABLE `cattery_images`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `customer_pets`
--
ALTER TABLE `customer_pets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `peak_dates`
--
ALTER TABLE `peak_dates`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=91;

--
-- AUTO_INCREMENT for table `venues`
--
ALTER TABLE `venues`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
