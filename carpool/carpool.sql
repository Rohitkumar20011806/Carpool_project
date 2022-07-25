-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jul 15, 2022 at 08:16 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `carpool`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `booking_history` (IN `user` VARCHAR(255))   BEGIN
select * FROM booking_history where passenger_id = (SELECT id from user where username = user);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `ad_details`
--

CREATE TABLE `ad_details` (
  `ad_id` int(10) NOT NULL,
  `id` int(11) NOT NULL,
  `post_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `phno` varchar(10) NOT NULL,
  `open_for_booking` char(1) NOT NULL DEFAULT 'y'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `ad_details`
--

INSERT INTO `ad_details` (`ad_id`, `id`, `post_time`, `phno`, `open_for_booking`) VALUES
(67, 45, '2022-06-17 08:30:00', '8796541235', 'y'),
(68, 46, '2022-06-17 08:31:41', '7896541230', 'y'),
(69, 47, '2022-06-20 03:30:00', '7896541235', 'y'),
(70, 48, '2022-07-13 09:08:16', '9654871230', 'y'),
(71, 49, '2022-07-13 09:09:46', '7896541237', 'y'),
(72, 50, '2022-07-13 09:20:02', '6587941234', 'y'),
(73, 51, '2022-07-14 08:25:00', '7865491230', 'n'),
(74, 62, '2022-07-14 17:29:35', '9520222311', 'y');

-- --------------------------------------------------------

--
-- Table structure for table `booking_history`
--

CREATE TABLE `booking_history` (
  `ad_id` int(11) NOT NULL,
  `driver_id` int(11) NOT NULL,
  `driver_name` varchar(255) NOT NULL,
  `passenger_id` int(11) NOT NULL,
  `origin` varchar(255) NOT NULL,
  `destination` varchar(255) NOT NULL,
  `vehicle_no` varchar(255) NOT NULL,
  `vehicle_name` varchar(255) NOT NULL,
  `book_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `booking_history`
--

INSERT INTO `booking_history` (`ad_id`, `driver_id`, `driver_name`, `passenger_id`, `origin`, `destination`, `vehicle_no`, `vehicle_name`, `book_time`) VALUES
(71, 49, 'Himanshu Bisht', 62, 'Raipur', 'Premnagar', 'UK02 4325', 'Royal Enfield', '2022-07-13 15:00:00'),
(73, 51, 'Himanshu', 62, 'Pacific Mall', 'Raipur\r\n', 'UK07 3322', 'Innova', '2022-07-14 13:00:12');

-- --------------------------------------------------------

--
-- Table structure for table `passenger_details`
--

CREATE TABLE `passenger_details` (
  `ad_id` int(11) NOT NULL,
  `id` int(11) NOT NULL,
  `book_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `passenger_details`
--

INSERT INTO `passenger_details` (`ad_id`, `id`, `book_time`) VALUES
(73, 62, '2022-07-14 07:30:12');

--
-- Triggers `passenger_details`
--
DELIMITER $$
CREATE TRIGGER `close_booking` AFTER INSERT ON `passenger_details` FOR EACH ROW UPDATE ad_details set open_for_booking='n' where ad_id = NEW.ad_id
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `route_details`
--

CREATE TABLE `route_details` (
  `ad_id` int(10) NOT NULL,
  `origin` varchar(255) NOT NULL,
  `destination` varchar(255) NOT NULL,
  `departure_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `route_details`
--

INSERT INTO `route_details` (`ad_id`, `origin`, `destination`, `departure_time`) VALUES
(67, 'GEHU', 'ISBT', '2022-06-17 14:00:00'),
(68, 'MIYANWALA', 'TUNWALA', '2022-06-17 14:01:00'),
(69, 'Herbertpur', 'Vikasnagar', '2022-06-20 09:00:00'),
(70, 'Ring Road', 'Mussoorie', '2022-07-13 15:00:00'),
(71, 'Raipur', 'Premnagar', '2022-07-13 15:00:00'),
(72, 'Patelnagar', 'Raipur', '2022-07-13 15:00:00'),
(73, 'Pacific Mall', 'Raipur', '2022-07-14 14:00:00'),
(74, 'Vikasnagar', 'ISBT', '2022-07-15 02:03:00');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(10) NOT NULL,
  `username` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `name`, `password`) VALUES
(45, 'rohan', 'Rohan Rawat', 'h6m3a4'),
(46, 'Aditya', 'Aditya Gaba', 'aaa'),
(47, 'Priya', 'Priya Pantwal', 'abc'),
(48, 'Kartik', 'Kartik Jain', 'wer'),
(49, 'Himanshu', 'Himanshu Bisht', 'aaa'),
(50, 'Khushi', 'Khushi Panwar', '124356'),
(51, 'Rohit', 'Rohit Nautiyal', 'cca'),
(52, 'Hitesh', 'Hitesh Kandpal', 'asdf'),
(53, 'kirti', 'Kirti Gusain', '9421ef'),
(54, 'Ritik', 'Ritik Naithani', 'kupec'),
(55, 'Komal', 'Komal Bisht', 'h9i6m3a4'),
(56, 'Mukesh', 'Mukesh Joshi', '12345'),
(57, 'Saurabh', 'Saurabh Vij', '94123'),
(58, 'pooja', 'Pooja rawat', '423130'),
(61, 'yash', 'Yash Negi', '9411535'),
(62, 'Himanshu318', 'Himanshu Pantwal', '9634749893');

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_details`
--

CREATE TABLE `vehicle_details` (
  `ad_id` int(10) NOT NULL,
  `vehicle_type` varchar(255) NOT NULL,
  `vehicle_name` varchar(255) NOT NULL,
  `vehicle_no` varchar(255) NOT NULL,
  `seats` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `vehicle_details`
--

INSERT INTO `vehicle_details` (`ad_id`, `vehicle_type`, `vehicle_name`, `vehicle_no`, `seats`) VALUES
(67, 'Bike', 'KTM RC', 'UK02 3322', 1),
(68, 'Car', 'Verna', 'UK02 4325', 2),
(69, 'Car', 'i10', 'UK11 6548', 2),
(70, 'Car', 'Tiago', 'UK02 4325', 2),
(71, 'Bike', 'Royal Enfield', 'UK02 4325', 1),
(72, 'Car', 'Swift Dezire', 'UK07 4325', 2),
(73, 'Car', 'Innova', 'UK07 3322', 2),
(74, 'BIKE', 'ktm', 'uk076767', 3);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ad_details`
--
ALTER TABLE `ad_details`
  ADD PRIMARY KEY (`ad_id`),
  ADD KEY `id` (`id`);

--
-- Indexes for table `booking_history`
--
ALTER TABLE `booking_history`
  ADD PRIMARY KEY (`ad_id`),
  ADD KEY `driver_id` (`driver_id`),
  ADD KEY `passenger_id` (`passenger_id`);

--
-- Indexes for table `passenger_details`
--
ALTER TABLE `passenger_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ad_id` (`ad_id`);

--
-- Indexes for table `route_details`
--
ALTER TABLE `route_details`
  ADD PRIMARY KEY (`ad_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vehicle_details`
--
ALTER TABLE `vehicle_details`
  ADD PRIMARY KEY (`ad_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ad_details`
--
ALTER TABLE `ad_details`
  MODIFY `ad_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT for table `booking_history`
--
ALTER TABLE `booking_history`
  MODIFY `ad_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `ad_details`
--
ALTER TABLE `ad_details`
  ADD CONSTRAINT `ad_details_ibfk_1` FOREIGN KEY (`id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `booking_history`
--
ALTER TABLE `booking_history`
  ADD CONSTRAINT `booking_history_ibfk_1` FOREIGN KEY (`ad_id`) REFERENCES `ad_details` (`ad_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `booking_history_ibfk_2` FOREIGN KEY (`driver_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `booking_history_ibfk_3` FOREIGN KEY (`passenger_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `passenger_details`
--
ALTER TABLE `passenger_details`
  ADD CONSTRAINT `passenger_details_ibfk_1` FOREIGN KEY (`ad_id`) REFERENCES `ad_details` (`ad_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `passenger_details_ibfk_2` FOREIGN KEY (`id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `route_details`
--
ALTER TABLE `route_details`
  ADD CONSTRAINT `route_details_ibfk_1` FOREIGN KEY (`ad_id`) REFERENCES `ad_details` (`ad_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `vehicle_details`
--
ALTER TABLE `vehicle_details`
  ADD CONSTRAINT `vehicle_details_ibfk_1` FOREIGN KEY (`ad_id`) REFERENCES `ad_details` (`ad_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
