-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 08, 2019 at 01:31 PM
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
(1, 3, 1, 5, 5, '2019-07-13 19:00:00', '2019-07-19 19:00:00', 1, 0, '2019-07-07 23:56:56', '2019-07-08 02:33:53'),
(2, 4, 2, 5, 5, '2019-06-27 19:00:00', '2019-07-06 19:00:00', 0, 1, '2019-07-07 23:58:19', '2019-07-08 02:33:53'),
(3, 4, 2, 5, 5, '2019-06-27 19:00:00', '2019-07-07 19:00:00', 1, 1, '2019-07-08 00:56:11', '2019-07-08 00:56:11'),
(7, 4, 1, 5, 5, '2019-07-03 19:00:00', '2019-07-07 19:00:00', 1, 1, '2019-07-08 01:00:01', '2019-07-08 01:00:01'),
(8, 4, 2, 1, 1, '2019-07-04 19:00:00', '2019-07-11 19:00:00', 1, 1, '2019-07-08 01:00:12', '2019-07-08 01:00:12'),
(23, 4, 13, 5, 5, '2019-07-13 19:00:00', '2019-07-19 19:00:00', 1, 0, '2019-07-08 04:31:36', '2019-07-08 04:31:36');

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
(1, 'image_1562561536.jpeg', 1, 3, '2019-07-07 23:52:16', '2019-07-07 23:52:16'),
(2, 'image_1562581050.jpeg', 1, 4, '2019-07-08 05:17:30', '2019-07-08 05:17:30'),
(3, 'image_1562581592.jpeg', 0, 4, '2019-07-08 05:26:32', '2019-07-08 05:26:32');

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
(1, 'Amir Mujtaba', 'amirmujtaba@gmail.com', 'Lahore, Pakistan', '03034969407', 'Some requirements', NULL, '2019-07-07 23:56:56', '2019-07-07 23:56:56'),
(2, 'Rehan Ali', 'rehanali@gmail.com', 'Lahore, Pakistan', '03034969407', 'Some requirements', 62, '2019-07-07 23:58:19', '2019-07-07 23:58:19'),
(13, 'Fahad Ali', 'fahadali@gmail.com', 'Lahore, Pakistan', '03034969407', 'Some requirements', NULL, '2019-07-08 04:31:36', '2019-07-08 04:31:36');

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

--
-- Dumping data for table `customer_pets`
--

INSERT INTO `customer_pets` (`id`, `catName`, `dogName`, `dateOfBirth`, `image`, `customerId`, `createdAt`, `updatedAt`) VALUES
(1, 'Sandy', NULL, '05-03-2019', 'image_1562567088.jpeg', 1, '2019-07-08 01:24:48', '2019-07-08 01:24:48'),
(2, NULL, 'Hardy', '07-08-2018', 'image_1562567145.jpeg', 1, '2019-07-08 01:25:45', '2019-07-08 01:25:45');

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

INSERT INTO `users` (`id`, `username`, `email`, `password`, `remember_token`, `roleId`, `resetPasswordToken`, `createdResetPToken`, `avatarFilePath`, `deviceToken`, `onlineStatus`, `verified`, `googleLogin`, `facebookLogin`, `language`, `createdAt`, `updatedAt`) VALUES
(1, 'super.admin@admin.com', 'super.admin@admin.com', '$2y$10$VwROsyn0bDr5gTh/rnCCG.5JN3kZTAWEEUZPJLHfiZf.84ZLdPtwq', 'J4Wo5S1I3oG53IGMe2ttEW2YFKojus9tizVBsMCr59YPTrbQqUd00YudN4Og', 1, NULL, NULL, NULL, NULL, 0, 1, NULL, NULL, 'English', '2019-06-27 11:25:48', '2019-06-26 19:00:00'),
(60, 'shahidmalik', 'shahidmalik@gmail.com', '$2y$10$qRFLGV14wCaQljSIe4eRSuFCVtw.L7N7CTVc0bmZCqd.WWZvW1j6G', NULL, 2, NULL, NULL, NULL, NULL, 0, 1, NULL, NULL, 'English', '2019-07-08 04:54:20', '2019-07-07 23:54:20'),
(61, 'numanhashmi', 'numanhashmi@gmail.com', '$2y$10$pMy7MlKP4zunnALI1lPdMOdhv53Af/oynJW3OzWOSjK3SkoRRDXiW', NULL, 2, NULL, NULL, NULL, NULL, 0, 1, NULL, NULL, 'English', '2019-07-07 23:48:49', '2019-07-07 23:48:49'),
(62, 'rehanali', 'rehanali@gmail.com', '$2y$10$YczHE2D2NmjeYtVzjeks5ebpLSIphNya5TnT4IvaAKYnVxuysrFVi', NULL, 3, NULL, NULL, NULL, NULL, 0, 1, NULL, NULL, 'English', '2019-07-07 23:58:19', '2019-07-07 23:58:19'),
(63, 'usamakhan', 'usamakhan@gmail.com', '$2y$10$8erHrQ/iC4MR/yjtOxSRy.hok97iQubRMDGbQLOS6R2okh9I5VLNC', NULL, 2, NULL, NULL, NULL, NULL, 0, 1, NULL, NULL, 'English', '2019-07-08 01:44:48', '2019-07-08 01:44:48'),
(75, 'arshadriaz', 'arshadriaz@gmail.com', '$2y$10$j679QpEJBt74kyVCpOPLi.fvXEFpW7mHpOW6AU8Jp3LEIjXgO3YBK', NULL, 2, NULL, NULL, NULL, NULL, 0, 1, NULL, NULL, 'English', '2019-07-08 04:42:31', '2019-07-08 04:42:31');

-- --------------------------------------------------------

--
-- Table structure for table `venues`
--

CREATE TABLE `venues` (
  `id` int(10) NOT NULL,
  `buisnessName` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `address` varchar(100) NOT NULL,
  `postcode` int(10) NOT NULL,
  `phoneNumber` varchar(50) NOT NULL,
  `buisnessDescription` varchar(500) NOT NULL,
  `facilities` varchar(500) NOT NULL,
  `serviceRate` varchar(50) NOT NULL,
  `discountAvailable` varchar(50) NOT NULL,
  `totalCats` int(100) NOT NULL,
  `totalDogs` int(100) NOT NULL,
  `type` varchar(50) NOT NULL,
  `isPaid` varchar(50) DEFAULT NULL,
  `isAvailable` int(10) NOT NULL DEFAULT '1',
  `userId` int(10) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `venues`
--

INSERT INTO `venues` (`id`, `buisnessName`, `email`, `address`, `postcode`, `phoneNumber`, `buisnessDescription`, `facilities`, `serviceRate`, `discountAvailable`, `totalCats`, `totalDogs`, `type`, `isPaid`, `isAvailable`, `userId`, `createdAt`, `updatedAt`) VALUES
(3, 'Cattery', 'shahidmalik@gmail.com', 'Lahore, Pakistan', 53720, '03034969407', 'Some Description about the buisness of cattery and kennel', 'some facilities', '100', '50%', 15, 15, 'kennel', '8.25GBP+VAT', 1, 60, '2019-07-07 23:48:21', '2019-07-08 04:31:36'),
(4, 'Cattery', 'numanhashmi@gmail.com', 'Lahore, Pakistan', 53720, '03034969407', 'Some Description about the buisness of cattery and kennel', 'some facilities', '200', '50%', 9, 9, 'kennel', '8.25GBP+VAT', 1, 61, '2019-07-07 23:49:21', '2019-07-08 02:33:53'),
(5, 'Kennel', 'usamakhan@gmail.com', 'Multan, Pakistan', 452041, '03218840489', 'Some Description about the buisness of cattery and kennel', 'some facilities', '50', '50%', 20, 20, 'kennel', NULL, 1, 63, '2019-07-08 01:45:51', '2019-07-08 01:45:51'),
(18, 'Cattery & Kennel Service Providers', 'arshadriaz@gmail.com', 'Faisalabad, Pakistan', 452041, '03218840489', 'Some Description about the buisness of cattery and kennel', 'some facilities', '50', '50%', 20, 20, 'kennel', '5.24', 1, 75, '2019-07-08 04:43:16', '2019-07-08 04:43:16');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `cattery_images`
--
ALTER TABLE `cattery_images`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `customer_pets`
--
ALTER TABLE `customer_pets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `peak_dates`
--
ALTER TABLE `peak_dates`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=69;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;

--
-- AUTO_INCREMENT for table `venues`
--
ALTER TABLE `venues`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
