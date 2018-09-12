-- phpMyAdmin SQL Dump
-- version 4.6.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Sep 12, 2018 at 03:40 PM
-- Server version: 5.7.12-log
-- PHP Version: 5.6.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `shosho`
--

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE `groups` (
  `id` int(11) NOT NULL,
  `name` text CHARACTER SET utf8 NOT NULL,
  `type` text CHARACTER SET utf8 NOT NULL,
  `duration` text CHARACTER SET utf8 NOT NULL,
  `no_of_users` int(11) NOT NULL,
  `max_no_of_users` int(11) NOT NULL,
  `value` float NOT NULL,
  `group_code` text NOT NULL,
  `group_place` text CHARACTER SET utf8 NOT NULL,
  `created_at` datetime NOT NULL,
  `created_by` text CHARACTER SET utf8 NOT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `groups`
--

INSERT INTO `groups` (`id`, `name`, `type`, `duration`, `no_of_users`, `max_no_of_users`, `value`, `group_code`, `group_place`, `created_at`, `created_by`, `status`) VALUES
(1, 'طقم أساس', '', 'يوميا', 1, 15, 200, 'jkn87ijilkljkjk', 'الهشابة', '2018-07-31 07:00:00', 'Ahmed', 1),
(2, 'صندوق عربية', '', 'إسبوعيا', 3, 12, 100, 'jjjhkj88m', 'الضعين', '2018-07-31 06:00:00', 'علي', 1),
(3, 'شراء بيت', '', 'كل خمسة أيام', 1, 30, 150, 'kmljl89', 'الخرطوم', '2018-07-31 07:00:00', 'KHALID', 1);

-- --------------------------------------------------------

--
-- Table structure for table `group_users`
--

CREATE TABLE `group_users` (
  `id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `user_order` int(11) NOT NULL,
  `join_date_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `group_users`
--

INSERT INTO `group_users` (`id`, `group_id`, `user_id`, `user_order`, `join_date_time`) VALUES
(1, 1, 7, 3, '0000-00-00 00:00:00'),
(2, 2, 7, 2, '0000-00-00 00:00:00'),
(3, 3, 1, 6, '0000-00-00 00:00:00'),
(4, 1, 9, 2, '0000-00-00 00:00:00'),
(5, 3, 7, 0, '0000-00-00 00:00:00'),
(6, 3, 9, 0, '0000-00-00 00:00:00'),
(7, 3, 17, 2, '0000-00-00 00:00:00'),
(8, 3, 2, 2, '0000-00-00 00:00:00'),
(9, 3, 6, 2, '0000-00-00 00:00:00'),
(10, 3, 88, 2, '2018-09-08 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `time` datetime NOT NULL,
  `body` text CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`id`, `group_id`, `user_id`, `time`, `body`) VALUES
(1, 1, 7, '2018-08-09 03:00:00', 'السلام عليكم يا جماعة'),
(2, 1, 7, '2018-08-12 02:00:00', 'كيف حالكم ؟\r\nكويسين إن شاء الله '),
(3, 1, 9, '2018-08-12 04:00:00', 'وعليكم السلام والرحمة :)\r\nكويسين الحمد لله '),
(4, 1, 7, '2018-08-12 11:00:00', 'حنبدأ الشغل بعد ده طيب '),
(5, 1, 7, '2018-09-09 18:44:02', 'hello');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` text CHARACTER SET utf8 NOT NULL,
  `user_name` varchar(31) CHARACTER SET utf8 NOT NULL,
  `password` text CHARACTER SET utf8 NOT NULL,
  `phone` int(11) NOT NULL,
  `state` text CHARACTER SET utf8 NOT NULL,
  `area` text CHARACTER SET utf8 NOT NULL,
  `address` text CHARACTER SET utf8 NOT NULL,
  `job` text CHARACTER SET utf8 NOT NULL,
  `job_place` text CHARACTER SET utf8 NOT NULL,
  `balance` float NOT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `user_name`, `password`, `phone`, `state`, `area`, `address`, `job`, `job_place`, `balance`, `status`) VALUES
(7, 'Ahmed Abdalsalam', 'ahmed', 'ahmed1234', 809524886, '', 'الهلالية', 'fcv\n', 'طالب', 'ahbbhhcf', 0, 1),
(9, 'fccc', 'ahmedy', 'gfchhvg', 688580555, '', 'الحاي الرابع', 'fv', 'موظف', 'gfchhvg', 0, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `group_users`
--
ALTER TABLE `group_users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_name` (`user_name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `groups`
--
ALTER TABLE `groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `group_users`
--
ALTER TABLE `group_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
