-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 27, 2019 at 03:05 PM
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
-- Table structure for table `suplliers`
--

CREATE TABLE `suplliers` (
  `id` int(10) NOT NULL,
  `buisnessName` varchar(50) NOT NULL,
  `address` varchar(100) NOT NULL,
  `phoneNumber` varchar(50) NOT NULL,
  `buisnessDescription` varchar(500) NOT NULL,
  `facilities` varchar(500) NOT NULL,
  `serviceaRate` varchar(50) NOT NULL,
  `discountAvailable` varchar(50) NOT NULL,
  `type` varchar(50) NOT NULL,
  `userId` int(10) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `suplliers`
--

INSERT INTO `suplliers` (`id`, `buisnessName`, `address`, `phoneNumber`, `buisnessDescription`, `facilities`, `serviceaRate`, `discountAvailable`, `type`, `userId`, `createdAt`, `updatedAt`) VALUES
(1, 'Cattery', 'Lahore, Pakistan', '03034969407', 'Some Description about the buisness of cattery and kennel', 'some facilities', '10', '50%', 'kennel', 16, '2019-06-27 08:01:35', '2019-06-27 08:01:35');

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
(16, 'umarraza', 'umarraza2200@gmail.com', '$2y$10$UQJYtPDhLTQw2dm8iSBOd.7n3ya4kxLdw2kjNov4aL9GFsrLYUy0m', NULL, 2, NULL, NULL, NULL, NULL, 0, 1, NULL, NULL, 'English', '2019-06-27 07:45:31', '2019-06-27 07:45:31');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `suplliers`
--
ALTER TABLE `suplliers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `suplliers`
--
ALTER TABLE `suplliers`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
