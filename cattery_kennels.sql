-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 02, 2019 at 03:05 PM
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
(15, 3, 22, 5, 5, '2019-07-01 19:00:00', '2019-07-02 19:00:00', 1, 1, '2019-07-01 00:06:06', '2019-07-01 00:06:06'),
(16, 3, 22, 3, 3, '2019-07-01 19:00:00', '2019-07-01 19:00:00', 1, 1, '2019-07-01 00:07:21', '2019-07-01 00:07:21'),
(26, 4, 17, 5, 5, '2019-06-29 19:00:00', '2019-06-30 19:00:00', 1, 1, '2019-07-01 07:11:50', '2019-07-01 07:11:50'),
(33, 4, 17, 7, 2, '2019-06-27 19:00:00', '2019-06-30 19:00:00', 1, 1, '2019-07-01 07:26:32', '2019-07-01 07:26:32');

-- --------------------------------------------------------

--
-- Table structure for table `cattery_images`
--

CREATE TABLE `cattery_images` (
  `id` int(10) NOT NULL,
  `imageName` varchar(100) NOT NULL,
  `venueId` int(10) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
-- Error reading data for table cattery&kennels.cattery_images: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near 'FROM `cattery&amp;kennels`.`cattery_images`' at line 1

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
  `pets` varchar(2000) NOT NULL,
  `requirements` varchar(200) NOT NULL,
  `userId` int(10) DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `bookerName`, `email`, `address`, `phoneNumber`, `pets`, `requirements`, `userId`, `createdAt`, `updatedAt`) VALUES
(22, 'Kamran Khan', 'kamran120@gmail.com', 'Lahore, Pakistan', '03034969407', 'Sandy', 'Some requirements', 37, '2019-07-01 00:06:06', '2019-07-01 00:06:06'),
(23, 'Akmal Mushtaq', 'akmal120@gmail.com', 'Lahore, Pakistan', '03034969407', 'Sandy', 'Some requirements', 38, '2019-07-01 00:07:21', '2019-07-01 00:07:21'),
(24, 'Mujtaba Rehman', 'mujtaba@gmail.com', 'Lahore, Pakistan', '03034969407', 'Sandy', 'Some requirements', 40, '2019-07-01 07:01:23', '2019-07-01 07:01:23'),
(25, 'Mujtaba Rehman', 'mujtaba@gmail.com', 'Lahore, Pakistan', '03034969407', 'Sandy', 'Some requirements', 41, '2019-07-01 07:02:45', '2019-07-01 07:02:45'),
(30, 'Mujtaba Rehman', 'mujtaba@gmail.com', 'Lahore, Pakistan', '03034969407', 'Sandy', 'Some requirements', 46, '2019-07-01 07:05:18', '2019-07-01 07:05:18'),
(32, 'Mujtaba Rehman', 'mujtaba@gmail.com', 'Lahore, Pakistan', '03034969407', 'Sandy', 'Some requirements', 48, '2019-07-01 07:07:10', '2019-07-01 07:07:10'),
(33, 'Mujtaba Rehman', 'mujtaba@gmail.com', 'Lahore, Pakistan', '03034969407', 'Sandy', 'Some requirements', 49, '2019-07-01 07:11:50', '2019-07-01 07:11:50'),
(34, 'Malik Hamza', 'malikhamza@gmail.com', 'Lahore, Pakistan', '03034969407', 'Sandy', 'Some requirements', 50, '2019-07-01 07:19:28', '2019-07-01 07:19:28'),
(36, 'Malik Hamza', 'malikhamza@gmail.com', 'Lahore, Pakistan', '03034969407', 'Sandy', 'Some requirements', 52, '2019-07-01 07:22:02', '2019-07-01 07:22:02'),
(38, 'Malik Hamza', 'malikhamza@gmail.com', 'Lahore, Pakistan', '03034969407', 'Sandy', 'Some requirements', 54, '2019-07-01 07:23:53', '2019-07-01 07:23:53'),
(40, 'Malik Hamza', 'malikhamza@gmail.com', 'Lahore, Pakistan', '03034969407', 'Sandy', 'Some requirements', 56, '2019-07-01 07:26:32', '2019-07-01 07:26:32');

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
(16, 'shahidmalik', 'shahidmalik@gmail.com', '$2y$10$VysYM2WWEolnSA399bedg.HLHm.Icawn1SMY27vTbBIR0jHPMxowy', NULL, 2, NULL, NULL, NULL, NULL, 0, 1, NULL, NULL, 'English', '2019-07-02 05:11:35', '2019-07-02 00:11:27'),
(37, 'kami', 'kamran120@gmail.com', '$2y$10$ktAzt2.iUc/q5cehiQU/suUQ77R4T56kO1yWNlv1tKwuxzGO3eto2', NULL, 3, NULL, NULL, NULL, NULL, 0, 1, NULL, NULL, 'English', '2019-07-01 00:06:06', '2019-07-01 00:06:06'),
(38, 'akmal2200', 'akmal120@gmail.com', '$2y$10$lQiVJF9ZHNdyRNzp//yqO.wgxRNlyYDlR4Fgleoy9qWDpfafeu0de', NULL, 3, NULL, NULL, NULL, NULL, 0, 1, NULL, NULL, 'English', '2019-07-01 00:07:21', '2019-07-01 00:07:21'),
(39, 'shaheenkhan', 'shaheenkhan@gmail.com', '$2y$10$xA.Iy3eIia9VpXV0fgOnSOxePQvRFm4JuWsphKJJdbtblFT0.V6SC', NULL, 2, NULL, NULL, NULL, NULL, 0, 1, NULL, NULL, 'English', '2019-07-01 01:42:12', '2019-07-01 01:42:12'),
(49, 'mujtaba', 'mujtaba@gmail.com', '$2y$10$1cb8l3inMUoCA.El511Pz.2cogeOC2wlkmtds61wTGnPxJbR9LhZi', NULL, 3, NULL, NULL, NULL, NULL, 0, 1, NULL, NULL, 'English', '2019-07-01 07:11:50', '2019-07-01 07:11:50'),
(56, 'malikhamza', 'malikhamza@gmail.com', '$2y$10$8YDQqyUig6H7AkGvHiU.WumbLyxjfkc5hwGLUzii5s.WSNU2ZDE..', NULL, 3, NULL, NULL, NULL, NULL, 0, 1, NULL, NULL, 'English', '2019-07-01 07:26:32', '2019-07-01 07:26:32');

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
  `isPaid` varchar(50) NOT NULL,
  `isAvailable` int(10) NOT NULL DEFAULT '1',
  `userId` int(10) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `venues`
--

INSERT INTO `venues` (`id`, `buisnessName`, `email`, `address`, `postcode`, `phoneNumber`, `buisnessDescription`, `facilities`, `serviceRate`, `discountAvailable`, `totalCats`, `totalDogs`, `type`, `isPaid`, `isAvailable`, `userId`, `createdAt`, `updatedAt`) VALUES
(3, 'Cattery', 'shahidmalik@gmail.com', 'Lahore, Pakistan', 53720, '03034969407', 'Some Description about the buisness of cattery and kennel', 'some facilities', '2500', '50%', 20, 20, 'kennel', '8.25GBP+VAT', 1, 16, '2019-07-01 00:03:15', '2019-07-01 00:03:15'),
(4, 'Cattery', 'shaheenkhan@gmail.com', 'Karachi, Pakistan', 45231, '03218840489', 'Some Description about the buisness of cattery and kennel', 'some facilities', '1500', '50%', 0, 0, 'kennel', '8.25GBP+VAT', 0, 39, '2019-07-01 01:44:40', '2019-07-01 07:26:32');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `cattery_images`
--
ALTER TABLE `cattery_images`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT for table `venues`
--
ALTER TABLE `venues`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
