-- phpMyAdmin SQL Dump
-- version 4.9.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Aug 14, 2021 at 12:04 PM
-- Server version: 10.3.16-MariaDB
-- PHP Version: 7.3.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `id16149761_central_db`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`id16149761_user`@`%` PROCEDURE `addAccount` (IN `uname` VARCHAR(10), IN `acc_type` VARCHAR(10), IN `balance` DOUBLE, IN `j_uname` VARCHAR(10), OUT `acc_id` INT)  NO SQL
BEGIN
	DECLARE `_rollback` BOOL DEFAULT 0;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `_rollback` = 1;
    START TRANSACTION;
        INSERT INTO account (acc_type, balance) VALUES(acc_type,balance);
        SET acc_id = LAST_INSERT_ID();
        INSERT INTO user_to_acc (uname, acc_id)  VALUES(uname, acc_id);
        IF acc_type = 'joint' THEN
        	INSERT INTO user_to_acc (uname, acc_id)  VALUES(j_uname, acc_id);
        END IF;
        SELECT acc_id;
    IF `_rollback` THEN
        ROLLBACK;
    ELSE
        COMMIT;
    END IF;
END$$

CREATE DEFINER=`id16149761_user`@`%` PROCEDURE `updateAccount` (IN `acc` INT, IN `amnt` DOUBLE, IN `periodic` BOOLEAN)  BEGIN
	DECLARE `_rollback` BOOL DEFAULT 0;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `_rollback` = 1;
    START TRANSACTION;
        IF periodic THEN
        	UPDATE account SET balance = amnt WHERE acc_id=acc;
        ELSE
        	SET @balance = (SELECT balance FROM account WHERE acc_id=acc);
            UPDATE account SET balance = @balance + amnt WHERE acc_id=acc;
            INSERT INTO log (acc_id, amount) VALUES (acc, amnt);
        END IF;
    IF `_rollback` THEN
        ROLLBACK;
    ELSE
        COMMIT;
    END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `account`
--

CREATE TABLE `account` (
  `acc_id` int(11) NOT NULL,
  `acc_type` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `balance` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `account`
--

INSERT INTO `account` (`acc_id`, `acc_type`, `balance`) VALUES
(3, 'joint', 17882),
(13, 'adult', 42423),
(19, 'adult', 2890),
(24, 'senior', 1334),
(25, 'adult', 1500);

--
-- Triggers `account`
--
DELIMITER $$
CREATE TRIGGER `delete_user_to_acc_on_acc_delete` BEFORE DELETE ON `account` FOR EACH ROW DELETE FROM user_to_acc WHERE acc_id = OLD.acc_id
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `agent`
--

CREATE TABLE `agent` (
  `agent_id` int(11) NOT NULL,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `agent`
--

INSERT INTO `agent` (`agent_id`, `name`) VALUES
(12, 'name'),
(14, 'name');

-- --------------------------------------------------------

--
-- Table structure for table `fd_account`
--

CREATE TABLE `fd_account` (
  `fd_acc_id` int(11) NOT NULL,
  `acc_id` int(11) NOT NULL,
  `balance` double NOT NULL,
  `period` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `fd_account`
--

INSERT INTO `fd_account` (`fd_acc_id`, `acc_id`, `balance`, `period`) VALUES
(22, 19, 4000, 12),
(23, 24, 3500, 36);

-- --------------------------------------------------------

--
-- Table structure for table `fd_plan`
--

CREATE TABLE `fd_plan` (
  `period` int(11) NOT NULL,
  `interest` decimal(4,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `fd_plan`
--

INSERT INTO `fd_plan` (`period`, `interest`) VALUES
(6, 13.00),
(12, 14.00),
(36, 15.00);

-- --------------------------------------------------------

--
-- Table structure for table `interest_rates`
--

CREATE TABLE `interest_rates` (
  `acc_type` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `interest` decimal(4,2) NOT NULL,
  `min` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `interest_rates`
--

INSERT INTO `interest_rates` (`acc_type`, `interest`, `min`) VALUES
('adult', 10.00, 1000),
('children', 12.00, 0),
('joint', 7.00, 5000),
('senior', 13.00, 1000),
('teen', 11.00, 500);

-- --------------------------------------------------------

--
-- Table structure for table `log`
--
-- Error reading structure for table id16149761_central_db.log: #1932 - Table 'id16149761_central_db.log' doesn't exist in engine
-- Error reading data for table id16149761_central_db.log: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near 'FROM `id16149761_central_db`.`log`' at line 1

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `uname` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'customer',
  `agent_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`uname`, `name`, `password`, `type`, `agent_id`) VALUES
('chan123', 'Chandler Bing', '61532745cddbf89676ce3844ac091721', 'customer', 12),
('joey123', 'Joey Tribbiani', 'f1998b83278879af72f0cebf0fb0a3aa', 'customer', 14),
('mon123', 'Monica Geller', '4c85b3625c95b8bf313d47934599eef5', 'customer', 14),
('phoebe123', 'Phoebe Buffay', '5a7c5156c0f64867b607abf66f3bbe1f', 'customer', 12),
('rach123', 'Rachel Greene', '14b5b099098de0c68164ad2eeec35409', 'customer', 14),
('ross123', 'Ross Geller', '87f9c39b9e3f358174d58a584c2727b4', 'manager', 12);

-- --------------------------------------------------------

--
-- Table structure for table `user_to_acc`
--

CREATE TABLE `user_to_acc` (
  `uname` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `acc_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `user_to_acc`
--

INSERT INTO `user_to_acc` (`uname`, `acc_id`) VALUES
('chan123', 3),
('joey123', 3),
('phoebe123', 19),
('phoebe123', 24),
('phoebe123', 25),
('rach123', 13);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `account`
--
ALTER TABLE `account`
  ADD PRIMARY KEY (`acc_id`),
  ADD KEY `acc_type` (`acc_type`);

--
-- Indexes for table `agent`
--
ALTER TABLE `agent`
  ADD PRIMARY KEY (`agent_id`);

--
-- Indexes for table `fd_account`
--
ALTER TABLE `fd_account`
  ADD PRIMARY KEY (`fd_acc_id`),
  ADD KEY `acc_id` (`acc_id`),
  ADD KEY `period` (`period`);

--
-- Indexes for table `fd_plan`
--
ALTER TABLE `fd_plan`
  ADD PRIMARY KEY (`period`);

--
-- Indexes for table `interest_rates`
--
ALTER TABLE `interest_rates`
  ADD PRIMARY KEY (`acc_type`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`uname`),
  ADD KEY `agent_id` (`agent_id`);

--
-- Indexes for table `user_to_acc`
--
ALTER TABLE `user_to_acc`
  ADD PRIMARY KEY (`uname`,`acc_id`),
  ADD KEY `acc_id` (`acc_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `account`
--
ALTER TABLE `account`
  MODIFY `acc_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `agent`
--
ALTER TABLE `agent`
  MODIFY `agent_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `fd_account`
--
ALTER TABLE `fd_account`
  MODIFY `fd_acc_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `account`
--
ALTER TABLE `account`
  ADD CONSTRAINT `account_ibfk_1` FOREIGN KEY (`acc_type`) REFERENCES `interest_rates` (`acc_type`);

--
-- Constraints for table `fd_account`
--
ALTER TABLE `fd_account`
  ADD CONSTRAINT `fd_account_ibfk_1` FOREIGN KEY (`acc_id`) REFERENCES `account` (`acc_id`),
  ADD CONSTRAINT `fd_account_ibfk_3` FOREIGN KEY (`period`) REFERENCES `fd_plan` (`period`);

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`agent_id`) REFERENCES `agent` (`agent_id`);

--
-- Constraints for table `user_to_acc`
--
ALTER TABLE `user_to_acc`
  ADD CONSTRAINT `user_to_acc_ibfk_1` FOREIGN KEY (`acc_id`) REFERENCES `account` (`acc_id`),
  ADD CONSTRAINT `user_to_acc_ibfk_2` FOREIGN KEY (`uname`) REFERENCES `user` (`uname`);

DELIMITER $$
--
-- Events
--
CREATE DEFINER=`id16149761_user`@`%` EVENT `savings_24` ON SCHEDULE EVERY 1 MONTH STARTS '2021-03-03 03:09:50' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE account SET balance = ((SELECT balance FROM account WHERE acc_id = '24') * 1.0108333333333) WHERE acc_id = '24'$$

CREATE DEFINER=`id16149761_user`@`%` EVENT `event_22` ON SCHEDULE EVERY 1 MONTH STARTS '2021-03-01 14:01:02' ENDS '2022-03-01 14:01:02' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE account SET balance = ((SELECT balance FROM account WHERE acc_id = '19') + 46.666666666667) WHERE acc_id = '19'$$

CREATE DEFINER=`id16149761_user`@`%` EVENT `savings_25` ON SCHEDULE EVERY 1 MONTH STARTS '2021-03-03 07:49:55' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE account SET balance = ((SELECT balance FROM account WHERE acc_id = '25') * 1.0083333333333) WHERE acc_id = '25'$$

CREATE DEFINER=`id16149761_user`@`%` EVENT `event_23` ON SCHEDULE EVERY 1 MONTH STARTS '2021-03-03 08:10:16' ENDS '2024-03-03 08:10:16' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE account SET balance = ((SELECT balance FROM account WHERE acc_id = '24') + 43.75) WHERE acc_id = '24'$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
