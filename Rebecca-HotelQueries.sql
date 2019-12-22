USE hotel;


-- 1. Write a query that returns a list of reservations that end in July 2023, including the name of the guest, the room number(s), and the reservation dates.
SELECT 
	guests.name,
    allroomsreservation.roomNumber,
    reservations.dateIn,
    reservations.dateOut
FROM guests
INNER JOIN reservations ON guests.guestId = reservations.guestId
INNER JOIN allroomsreservation ON reservations.reservationId = allroomsreservation.reservationId
WHERE reservations.dateOut BETWEEN '2023-07-01' AND '2023-07-31';
		/* Results
        Rebecca Paasch	205	2023-06-28	2023-07-02
		Walter Holaway	204	2023-07-13	2023-07-14
		Wilfred Vise	401	2023-07-18	2023-07-21
		Bettyanne Seery	303	2023-07-28	2023-07-29 */

-- 2. Write a query that returns a list of all reservations for rooms with a jacuzzi, displaying the guest's name, the room number, and the dates of the reservation.
SELECT 
	guests.name,
    allroomsreservation.roomNumber,
    reservations.dateIn,
    reservations.dateOut
FROM guests
INNER JOIN reservations ON guests.guestId = reservations.guestId
INNER JOIN allroomsreservation ON reservations.reservationId = allroomsreservation.reservationId
INNER JOIN roomammenities ON allroomsreservation.roomNumber = roomammenities.roomNumber
INNER JOIN ammenities ON roomammenities.ammenitiesId = ammenities.ammenitiesId
WHERE ammenities.ammenityName = 'jacuzzi'; 
/*Results:
	Maritza Tilton	401	2023-05-30	2023-06-02
	Wilfred Vise	401	2023-07-18	2023-07-21
	Duane Cullison	401	2023-11-22	2023-11-25 */
    
    
-- 3. Write a query that returns all the rooms reserved for a specific guest, including the guest's name, the room(s) reserved, the starting date of the reservation, and how many people were included in the reservation. (Choose a guest's name from the existing data.)
SELECT 
	g.name,
    a.roomNumber,
    r.dateIn,
    SUM(r.numKids + r.numAdults) totalPeople
FROM guests g
INNER JOIN reservations r ON g.guestId = r.guestId
INNER JOIN allroomsreservation a ON r.reservationId = a.reservationId
WHERE g.name = 'Rebecca Paasch'; 
	/* Results:
		Rebecca Paasch	307	2023-03-17	4 */

-- 4. Write a query that returns a list of rooms, reservation ID, and per-room cost for each reservation. The results should include all rooms, whether or not there is a reservation associated with the room.
SELECT 
    s.roomNumber, 
    SUM(CASE
		WHEN a.reservationId IS NULL
			THEN s.basePrice + m.additionalPrice
            END) totalPrice,
	SUM(CASE 
		WHEN a.reservationId IS NOT NULL
			AND (r.numKids + r.numAdults) <= s.maxOccupancy
            THEN s.basePrice + m.additionalPrice
            END) totalPrice,
    SUM(CASE 
		WHEN a.reservationId IS NOT NULL 
			AND (r.numKids + r.numAdults) > s.maxOccupancy
			THEN s.basePrice + m.additionalPrice  + (((r.numKids + r.numAdults)- s.maxOccupancy)*s.extraPersonPrice)
            END) totalPrice,
    a.reservationId
FROM
    rooms s
INNER JOIN 
	roomammenities t ON s.roomNumber = t.roomNumber
INNER JOIN
    ammenities m ON t.ammenitiesId = m.ammenitiesId
LEFT OUTER JOIN
    allroomsreservation a ON s.roomNumber = a.roomNumber
INNER JOIN 
	reservations r ON a.reservationId = r.reservationId
WHERE
    s.roomNumber IS NOT NULL; 

-- 5. Write a query that returns all the rooms accommodating at least three guests and that are reserved on any date in April 2023.
SELECT
	a.roomNumber
FROM allroomsreservation a
INNER JOIN reservations r ON a.reservationId = r.reservationId
INNER JOIN rooms s ON a.roomNumber = s.roomNumber
WHERE s.maxOccupancy >= 3 
	AND ((r.dateIn BETWEEN '2023-04-01' AND '2023-04-30') OR (r.dateOut BETWEEN '2023-04-01' AND '2023-04-30'));
	/*Results:
		301 */
        
-- 6. Write a query that returns a list of all guest names and the number of reservations per guest, sorted starting with the guest with the most reservations and then by the guest's last name.
SELECT 
	g.name,
    COUNT(r.reservationId) numberReservations
FROM reservations r 
INNER JOIN guests g ON r.guestId = g.guestId
GROUP BY g.name
ORDER BY numberReservations DESC, SUBSTRING_INDEX(g.name, ' ', -1 );
	/*Results:
	Bettyanne Seery	3
	Mack Simmer	3
	Duane Cullison	2
	Walter Holaway	2
	Aurore Lipton	2
	Rebecca Paasch	2
	Maritza Tilton	2
	Wilfred Vise	2
	Karie Yang	2
	Zachery Leuchtefeld	1
	Joleen Tison	1 */

-- 7. Write a query that displays the name, address, and phone number of a guest based on their phone number. (Choose a phone number from the existing data.)
SELECT 
	g.name,
    CONCAT(g.streetApartmentNumber, ' ', g.streetName) address,
    g.phone
FROM guests g 
WHERE g.phone LIKE '(330) 418-8524';
	/*Results:
		Rebecca Paasch	909 Watterson Trl	(330) 418-8524 */