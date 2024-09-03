/* These tasks all use the hotel database */
USE hotel;

/*** Task 2 ***/

/* Query 1 */
/* Write a query to list the hotel number, type, and price of each double or deluxe room with a price more than $99. */
SELECT hotelNo, type, price
FROM room
WHERE price > 99 AND type IN ('double', 'deluxe');

/* Query 2 */
/* Write a query to list the hotel numbers of all hotels that have more than 2 double rooms. */
SELECT hotelNo
FROM room
WHERE type LIKE 'double'
GROUP BY hotelNo HAVING count(hotelNo) > 2;

/* Query 3 */
/* Write a query to list the names of all guests that visited Brisbane in December 2019. */
SELECT guestName
FROM guest
WHERE guestNo = ( SELECT guestNo
				  FROM booking
	              WHERE dateFrom >= '2019-12-01 00:00:00' AND dateTo <= '2019-12-31 00:00:00'
				  AND hotelNo = (SELECT hotelNo
								 FROM hotel
								 WHERE city = 'Brisbane'));

/* Query 4 */
/* Write a query to determine the number of different guests who visited Ridge Hotel. */
SELECT COUNT(distinct guestNo)
FROM booking
WHERE hotelNo = ( SELECT hotelNo
				  FROM hotel
                  WHERE hotelName = 'Ridge Hotel');

/* Query 5 */
/* Write a query that provides the total income from bookings for the Grosvenor Hotel for 2 March this year. */
SELECT SUM(r.price)
FROM room AS r, hotel AS h, booking AS b
WHERE (b.dateTo >= '2020-03-02 00:00:00' AND b.dateFrom <= '2020-03-02 00:00:00')
AND h.hotelName = 'Grosvenor Hotel' AND b.hotelNo = h.hotelNo AND r.hotelNo = h.hotelNo
AND r.roomNo = b.roomNo;

/* Query 6 */
/* Write a query that increases the price of all deluxe rooms in all hotels by 20%. */
UPDATE room
SET price = price + (price * 20 / 100)
WHERE type IN ('deluxe');

/* Query 7 */
/* Write a query to list all details of guests who have stayed locally in a hotel. */
SELECT g.guestNo, guestName, guestAddress
FROM guest AS g, hotel AS h, booking AS b
WHERE g.guestNo = b.guestNo AND b.hotelNo = h.hotelNo AND g.guestAddress = h.city;


/*** Task 3 ***/

/* Insert */
/* Write an INSERT command to add a new hotel. The hotel is called ‘Quest Beachside’ and it’s located in Surfers Paradise. */
-- Get next hotelNo:
SET @nextHotelNo = (SELECT MAX(hotelNo) FROM hotel) + 1;
-- Insert into hotel table:
INSERT INTO hotel (hotelNo, hotelName, city)
VALUES (@nextHotelNo, 'Quest Beachside', 'Surfers Paradise');

/* Delete */
/* Write a DELETE command to remove all the guests details for that haven’t made any hotel bookings. */
DELETE FROM guest
WHERE guestNo NOT IN (SELECT guestNo
					  FROM booking);

/* Update */
/* Write an UPDATE comment to change the address of all guests with the last name ‘Wood’ who live in ‘Brisbane’ to ‘Paris’. */
UPDATE guest
SET guestAddress = 'Paris'
WHERE guestName LIKE '%Wood' AND guestAddress = 'Brisbane';


/*** Task 4 ***/

/* Create Index */
/* Write a command to create an index on roomNo column of the room table. */
-- Create index:
CREATE INDEX roomNo
ON room (roomNo);

/* Create View */
/* Write a command to create a view to list the name and address of all guests that have made a future booking (for June 2020 onwards). */
-- If view exists, drop it:
DROP VIEW IF EXISTS futureGuests;
-- Create view:
CREATE VIEW futureGuests AS
SELECT guestName, guestAddress
FROM guest
WHERE guestNo = ( SELECT guestNo
				  FROM booking
                  WHERE dateFrom >= '2020-06-01 00:00:00' AND dateTo <= '2020-06-30 00:00:00');


/*** Task 5 ***/

/* Working as a Database Administrator for MySQL Hotel, write the following commands for two employees,
Vanessa and Jessica to achieve the following database security requirements.
Assume usernames of employees namely Vanessa and Jessica are vanessa and jessica respectively. */

/* A.	User Vanessa is no longer allowed to add data to the guest table */
REVOKE INSERT
ON guest
FROM 'vanessa'@'localhost';

/* B.	User Vanessa is no longer allowed to delete records from the guest table */
REVOKE DELETE
ON guest
FROM 'jessica'@'localhost';

/* C.	User Jessica must be able to add records to the booking table */
GRANT INSERT
ON booking
TO 'jessica'@'localhost';

/* D.	User Jessica must be able to remove records from the booking table */
GRANT DELETE
ON booking
TO 'jessica'@'localhost';

