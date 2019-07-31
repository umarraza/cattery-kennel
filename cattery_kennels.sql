-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 31, 2019 at 03:17 PM
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
(8, 1, 8, 5, 5, '2019-07-30 19:00:00', '2019-08-04 19:00:00', 1, 0, '2019-07-31 02:29:45', '2019-07-31 02:29:45'),
(10, 1, 10, 2, 3, '2019-07-30 19:00:00', '2019-07-08 19:00:00', 1, 1, '2019-07-31 02:33:37', '2019-07-31 02:33:37');

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
(1, 'image_1564464479.jpeg', 1, 1, '2019-07-30 00:27:59', '2019-07-30 00:27:59');

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
(8, 'Fahad Ali', 'fahadali@gmail.com', 'Lahore, Pakistan', '03034969407', 'Some requirements', NULL, '2019-07-31 02:29:45', '2019-07-31 02:29:45'),
(10, 'Numan ALi', 'numan@gmail.com', 'Lahore, Pakistan', '03034969407', 'Some requirements', 84, '2019-07-31 02:33:37', '2019-07-31 02:33:37');

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
(79, 'umarraza2200', 'Uma Raza', 'umarraza@gmail.com', '$2y$10$xp28/sJS4kULHTKAHYq.EOW.Foni4SM2QcRu/B4sAQYoyLt7yAox6', NULL, 2, NULL, NULL, NULL, NULL, 0, 1, NULL, NULL, 'English', '2019-07-30 00:11:27', '2019-07-30 00:11:27'),
(80, 'anasmahmood', 'anas mahmood', 'anasmahmood@stackcru.com', '$2y$10$I.BYPmAfrYp1MBSSuvYJe.G3QxlZYx4EpDK8/IrNrwfsU.8ZPZiFu', NULL, 2, NULL, NULL, NULL, NULL, 0, 1, NULL, NULL, 'English', '2019-07-30 07:45:24', '2019-07-30 07:45:24'),
(81, 'umarraza22000', 'Uma Raza', 'umarlraza@gmail.com', '$2y$10$zPiFT6pNJV.1NBTYd1xfXO7za2f6h0zzNrZ2y2tv6fZ9ICqYZY7O.', NULL, 2, NULL, NULL, NULL, NULL, 0, 1, NULL, NULL, 'English', '2019-07-30 07:47:07', '2019-07-30 07:47:07'),
(82, 'haris123', 'haris ayyaz', 'harisayyaz@gmail.com', '$2y$10$c9zUf4/EB5CujQXE8YJlyuWFAKRWk3T5X0ZVdClIo9bHvBMoq1.Wa', NULL, 2, NULL, NULL, NULL, NULL, 0, 1, NULL, NULL, 'English', '2019-07-31 01:56:00', '2019-07-31 01:56:00'),
(84, 'numanali', 'Numan ALi', 'numan@gmail.com', '$2y$10$lyCtqg.wDP6.oFZuGOISOusJJLKY4RhF7JyXyeHxzh3ihYhjNDYGu', NULL, 3, NULL, NULL, NULL, NULL, 0, 1, NULL, NULL, 'English', '2019-07-31 02:33:37', '2019-07-31 02:33:37'),
(85, 'arshad', 'Arshad Riaz', 'arshadriaz@gmail.com', '$2y$10$ntWva3ZpFwbXEMa54ktcoOvWm/fD./HGDYkooCHCY0eWdRaYPvqqi', NULL, 2, NULL, NULL, NULL, NULL, 0, 1, NULL, NULL, 'English', '2019-07-31 04:13:54', '2019-07-31 04:13:54');

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
(1, 'cattery and kennel service provider', 'Lahore, Pakistan', 53720, '030345969407', 'Some description of buisness', '', 'some facilities', '10%', '50', 13, 12, 'kennel', '0', 1, 79, '2019-07-30 00:16:38', '2019-07-31 02:33:37'),
(2, 'EFRF', 'sdfsdf', 12323, '123123', NULL, NULL, '123', '123', 'yes', 123, 123, NULL, '0', 1, 80, '2019-07-31 01:27:20', '2019-07-31 01:27:20'),
(4, 'Cattery & Kennel Service Providers', 'Faisalabad, Pakistan', 452041, '03218840489', NULL, NULL, 'some facilities', '50', '50%', 20, 20, NULL, '0', 1, 85, '2019-07-31 04:16:30', '2019-07-31 04:16:30');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `cattery_images`
--
ALTER TABLE `cattery_images`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

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
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=86;

--
-- AUTO_INCREMENT for table `venues`
--
ALTER TABLE `venues`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
