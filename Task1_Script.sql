/*** Task 1 ***/
/* Write an SQL script to create a database to match the Rmap provided.
   Marks will be awarded for the following:
		1.	Creating the database (1 mark)
		2.	Successfully creating new tables (1 mark)
		3.	Including all attributes (1 mark)
		4.	Including constraints (1 mark)
		5.	Correctly creating Primary Keys (1 mark)
		6.	Correctly creating Foreign Keys (1 mark)  */

/* Create the database */
CREATE DATABASE IF NOT EXISTS `OKTOMOOK_RELATIONAL_MODEL`;
USE `OKTOMOOK_RELATIONAL_MODEL`;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;



/* Add tables to the database */
--
-- Table structure for table `Branch`:
--
DROP TABLE IF EXISTS `Branch`;
CREATE TABLE `Branch` (
`branchNumber` int,
`branchName` varchar(100),
`streetNo` int,
`streetName` varchar(100),
`branchCity` varchar(100),
`branchState` varchar(100),
`numberEmployees` int,
PRIMARY KEY (`branchNumber`)
);

--
-- Table structure for table `Publisher`:
--
DROP TABLE IF EXISTS `Publisher`;
CREATE TABLE `Publisher` (
`publisherCode` int,
`publisherName` varchar(100) NOT NULL,
`publisherCity` varchar(100),
`publisherState` enum('QLD', 'VIC', 'NSW', 'SA'),
PRIMARY KEY (`publisherCode`)
);

--
-- Table structure for table `Author`:
--
DROP TABLE IF EXISTS `Author`;
CREATE TABLE `Author` (
`authorID` int,
`firstName` varchar(100),
`lastName` varchar(100),
PRIMARY KEY (`authorID`)
);

--
-- Table structure for table `Book`:
--
DROP TABLE IF EXISTS `Book`;
CREATE TABLE `Book` (
`ISBN` int(13),
`title` varchar(100) NOT NULL,
`publisherCode` int,
`genre` enum('Non-Fiction', 'Science Fiction', 'Fantasy', 'Crime', 'Mystery', 'Young Adult', 'Romance', 'General Fiction'),
`retailPrice` int,
`paperback` bool,
PRIMARY KEY (`ISBN`),
FOREIGN KEY (`publisherCode`) REFERENCES `Publisher` (`publisherCode`)
);

--
-- Table structure for table `Wrote`:
--
DROP TABLE IF EXISTS `Wrote`;
CREATE TABLE `Wrote` (
`ISBN` int(13),
`authorID` int,
`sequenceNumber` int,
PRIMARY KEY (`ISBN`, `authorID`),
FOREIGN KEY (`ISBN`) REFERENCES `Book` (`ISBN`),
FOREIGN KEY (`authorID`) REFERENCES `Author` (`authorID`)
);

--
-- Table structure for table `Inventory`:
--
DROP TABLE IF EXISTS `Inventory`;
CREATE TABLE `Inventory` (
`ISBN` int(13),
`branchNumber` int,
`quantityInStock` int NOT NULL DEFAULT 0,
PRIMARY KEY (`ISBN`, `branchNumber`),
FOREIGN KEY (`ISBN`) REFERENCES `Book` (`ISBN`),
FOREIGN KEY (`branchNumber`) REFERENCES `Branch` (`branchNumber`)
);
