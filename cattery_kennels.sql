-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 03, 2019 at 03:18 PM
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
(15, 3, 22, 5, 5, '2019-07-03 19:00:00', '2019-07-10 19:00:00', 1, 1, '2019-07-01 00:06:06', '2019-07-01 00:06:06'),
(16, 3, 22, 3, 3, '2019-07-01 19:00:00', '2019-07-04 19:00:00', 1, 1, '2019-07-01 00:07:21', '2019-07-01 00:07:21'),
(26, 4, 23, 5, 5, '2019-07-07 19:00:00', '2019-07-15 19:00:00', 1, 1, '2019-07-01 07:11:50', '2019-07-01 07:11:50'),
(33, 4, 23, 7, 2, '2019-06-27 19:00:00', '2019-06-30 19:00:00', 1, 1, '2019-07-01 07:26:32', '2019-07-01 07:26:32'),
(35, 4, 42, 10, 5, '2019-07-09 19:00:00', '2019-07-14 19:00:00', 1, 0, '2019-07-03 01:17:06', '2019-07-03 01:17:06'),
(36, 4, 43, 2, 3, '2019-07-12 19:00:00', '2019-07-16 19:00:00', 1, 0, '2019-07-03 01:18:00', '2019-07-03 01:18:00'),
(37, 4, 44, 1, 1, '2019-07-11 19:00:00', '2019-07-15 19:00:00', 1, 0, '2019-07-03 01:18:41', '2019-07-03 01:18:41'),
(38, 3, 45, 2, 2, '2019-07-10 19:00:00', '2019-07-19 19:00:00', 1, 0, '2019-07-03 01:19:29', '2019-07-03 01:19:29'),
(39, 3, 46, 3, 5, '2019-07-14 19:00:00', '2019-07-22 19:00:00', 1, 1, '2019-07-03 01:20:52', '2019-07-03 01:20:52'),
(40, 3, 47, 3, 5, '2019-06-28 19:00:00', '2019-07-05 19:00:00', 1, 1, '2019-07-03 05:36:04', '2019-07-03 05:36:04'),
(41, 3, 48, 3, 5, '2019-06-23 19:00:00', '2019-07-04 19:00:00', 1, 1, '2019-07-03 05:37:38', '2019-07-03 05:37:38');

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
(33, 'Mujtaba Rehman', 'mujtaba@gmail.com', 'Lahore, Pakistan', '03034969407', 'Sandy', 'Some requirements', 49, '2019-07-01 07:11:50', '2019-07-01 07:11:50'),
(40, 'Malik Hamza', 'malikhamza@gmail.com', 'Lahore, Pakistan', '03034969407', 'Sandy', 'Some requirements', 56, '2019-07-01 07:26:32', '2019-07-01 07:26:32'),
(42, 'angel', 'angel@gmail.com', 'Lahore, Pakistan', '03034969407', 'Sandy', 'Some requirements', NULL, '2019-07-03 01:17:06', '2019-07-03 01:17:06'),
(43, 'baby', 'babyl@gmail.com', 'Lahore, Pakistan', '03034969407', 'Sandy', 'Some requirements', NULL, '2019-07-03 01:18:00', '2019-07-03 01:18:00'),
(44, 'Hippophobia', 'hippophobia@gmail.com', 'Lahore, Pakistan', '03034969407', 'Sandy', 'Some requirements', NULL, '2019-07-03 01:18:41', '2019-07-03 01:18:41'),
(45, 'Iwantamaste', 'lwantamaste@gmail.com', 'Lahore, Pakistan', '03034969407', 'Sandy', 'Some requirements', NULL, '2019-07-03 01:19:29', '2019-07-03 01:19:29'),
(46, 'Breacche', 'breacche@gmail.com', 'Lahore, Pakistan', '03034969407', 'Sandy', 'Some requirements', 57, '2019-07-03 01:20:52', '2019-07-03 01:20:52'),
(47, 'johncena', 'johncena@gmail.com', 'Lahore, Pakistan', '03034969407', 'Sandy', 'Some requirements', 58, '2019-07-03 05:36:04', '2019-07-03 05:36:04'),
(48, 'romanriengs', 'romanriengs@gmail.com', 'Lahore, Pakistan', '03034969407', 'Sandy', 'Some requirements', 59, '2019-07-03 05:37:38', '2019-07-03 05:37:38');

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
(56, 'malikhamza', 'malikhamza@gmail.com', '$2y$10$8YDQqyUig6H7AkGvHiU.WumbLyxjfkc5hwGLUzii5s.WSNU2ZDE..', NULL, 3, NULL, NULL, NULL, NULL, 0, 1, NULL, NULL, 'English', '2019-07-01 07:26:32', '2019-07-01 07:26:32'),
(57, 'baby', 'breacche@gmail.com', '$2y$10$cNC2DGh71xlBdj3H9g6VJuz2oarnKTLf4Ag2SaFNnpdUQZPmfCOAa', NULL, 3, NULL, NULL, NULL, NULL, 0, 1, NULL, NULL, 'English', '2019-07-03 01:20:52', '2019-07-03 01:20:52'),
(58, 'johncena', 'johncena@gmail.com', '$2y$10$K1Xa/QhKbJxZ2p9aUVSvPuo2pm6a99lkWhzDw6BXOc8Jdk19RWIQe', NULL, 3, NULL, NULL, NULL, NULL, 0, 1, NULL, NULL, 'English', '2019-07-03 05:36:04', '2019-07-03 05:36:04'),
(59, 'romanriengs', 'romanriengs@gmail.com', '$2y$10$o/nzqPvIwnbV5QSreRIYEODRhXk.CBrufp88cL0hMbkUqDWJp6kxa', NULL, 3, NULL, NULL, NULL, NULL, 0, 1, NULL, NULL, 'English', '2019-07-03 05:37:38', '2019-07-03 05:37:38');

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
(3, 'Cattery', 'shahidmalik@gmail.com', 'Lahore, Pakistan', 53720, '03034969407', 'Some Description about the buisness of cattery and kennel', 'some facilities', '2500', '50%', 9, 3, 'kennel', '8.25GBP+VAT', 1, 16, '2019-07-01 00:03:15', '2019-07-03 05:37:38'),
(4, 'Cattery', 'shaheenkhan@gmail.com', 'Karachi, Pakistan', 45231, '03218840489', 'Some Description about the buisness of cattery and kennel', 'some facilities', '1500', '50%', -13, -9, 'kennel', '8.25GBP+VAT', 0, 39, '2019-07-01 01:44:40', '2019-07-03 01:18:41');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `cattery_images`
--
ALTER TABLE `cattery_images`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT for table `venues`
--
ALTER TABLE `venues`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
