CREATE DATABASE IF NOT EXISTS hotel;
USE hotel;
CREATE TABLE `rooms` ( 
	`roomNumber` INT NOT NULL PRIMARY KEY,
    `roomType` VARCHAR(30) NOT NULL,

    `standardOccupancy` INT,
    `maxOccupancy` INT,
    `basePrice` DECIMAL(7,2),
    `extraPersonPrice` DECIMAL(7,2)
    );
    
ALTER TABLE `rooms` 
	ADD COLUMN(
		`ADA` BOOLEAN NOT NULL
        );

CREATE TABLE `ammenities` (
	`ammenitiesId` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `ammenityName` VARCHAR (50) NOT NULL,
    `additionalPrice` DECIMAL (5,2)
    );
    
CREATE TABLE `roomAmmenities` (
	`id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `roomNumber` INT NOT NULL,
    `ammenitiesId` INT NOT NULL,
    FOREIGN KEY fk_rooms_roomNumber (roomNumber)
		references rooms(roomNumber),
	FOREIGN KEY fk_ammenities_ammenitiesId (ammenitiesId)
		references ammenities(ammenitiesId)
        );
        
CREATE TABLE `guests` (
	`guestId` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(75),
    `streetApartmentNumber` VARCHAR(25),
    `streetName` VARCHAR (30),
    `city` VARCHAR (25),
    `state` VARCHAR (12),
    `zipcode` CHAR(5)
    );
   
ALTER TABLE `guests`
	ADD COLUMN (
		`phone` INT
        );
        
ALTER TABLE `guests`
	MODIFY `phone` VARCHAR(12);
        
ALTER TABLE `guests`
	MODIFY `phone` VARCHAR(20);
    
CREATE TABLE `reservations` (
	`reservationId` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `roomNumber` INT NOT NULL,
    `guestId` INT NOT NULL,
    `dateIn` DATE NOT NULL,
    `dateOut` DATE NOT NULL,
    `numKids` INT,
    `numAdults` INT NOT NULL,
    `totalPrice` DECIMAL(10,2),
    FOREIGN KEY fk_rooms_roomNumber (roomNumber)
		REFERENCES rooms(roomNumber),
	FOREIGN KEY fk_guests_guestId (guestId)
		REFERENCES guests(guestId)
        );
        

CREATE TABLE `allRoomsReservation` (
	`guestReservationId` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `roomNumber` INT NOT NULL,
    `reservationId` INT NOT NULL,
    FOREIGN KEY fk_rooms_roomNumber (roomNumber)
		REFERENCES rooms(roomNumber),
	FOREIGN KEY fk_reservations_reservationId (reservationId)
		REFERENCES reservations(reservationId)
        );
        
ALTER TABLE `allroomsreservation`
	DROP FOREIGN KEY allroomsreservation_ibfk_2;

ALTER TABLE `reservations`
	DROP FOREIGN KEY reservations_ibfk_1,
    DROP COLUMN `roomNumber`;
    
ALTER TABLE `allroomsreservation`
	MODIFY COLUMN `reservationId` INT,
    MODIFY COLUMN `roomNumber` INT;

