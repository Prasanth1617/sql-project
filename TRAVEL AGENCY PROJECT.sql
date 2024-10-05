-- drop database Travel_agency;
-- show databases;
create database Travel_agency;
use Travel_agency;
-- Create Customers Table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15)
);

-- Create Destinations Table
CREATE TABLE destinations (
    destination_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    country VARCHAR(100),
    description TEXT
);

-- Create Packages Table
CREATE TABLE packages (
    package_id INT PRIMARY KEY AUTO_INCREMENT,
    destination_id INT,
    price DECIMAL(10, 2),
    details TEXT,
    FOREIGN KEY (destination_id) REFERENCES destinations(destination_id)
);

-- Create Bookings Table
CREATE TABLE bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    package_id INT,
    booking_date DATETIME,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (package_id) REFERENCES packages(package_id)
);

-- Create Reviews Table
CREATE TABLE reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    package_id INT,
    rating INT CHECK (rating >= 1 AND rating <= 5),
    comment TEXT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (package_id) REFERENCES packages(package_id)
);

-- Create Payments Table
CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT,
    amount DECIMAL(10, 2),
    payment_date DATETIME,
    payment_method VARCHAR(50),
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
);

-- Create Agents Table
CREATE TABLE agents (
    agent_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15)
);

-- Create Agent_Commissions Table
CREATE TABLE agent_commissions (
    commission_id INT PRIMARY KEY AUTO_INCREMENT,
    agent_id INT,
    booking_id INT,
    commission_amount DECIMAL(10, 2),
    FOREIGN KEY (agent_id) REFERENCES agents(agent_id),
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
);


INSERT INTO customers (first_name, last_name, email, phone)
VALUES 
('Prasanth', 'U', 'prasanthpsh72@gmail.com', '9488676296'),
('Mano', 'P', 'manobala@gmail.com', '7708893456'),
('Vijay', 'M', 'vijay@gmail.com', '8604267865'),
('Jeevan', 'A', 'Jeevanog@gmail.com', '9994987269'),
('Suresh', 'M', 'sureshson@gmail.com', '9442654776'),
('Ganesha', 'M', 'maals@gmail.com', '9842684885'),
('Mukesh', 'P', 'mukki@gmail.com', '7708865378');


INSERT INTO destinations (name, country, description)
VALUES 
('Tokyo', 'Japan', 'A bustling metropolis known for its skyscrapers and traditional temples.'),
('Paris', 'France', 'The city of lights and love.'),
('New York', 'USA', 'The Big Apple, known for its skyline and vibrant culture.'),
('Sydney', 'Australia', 'Famous for its Sydney Opera House and beautiful harbor.'),
('Cairo', 'Egypt', 'Home to ancient pyramids and rich history.'),
('Rio de Janeiro', 'Brazil', 'Famous for its carnival festival and stunning beaches.'),
('Cape Town', 'South Africa', 'Known for its stunning landscapes and Table Mountain.');


INSERT INTO packages (destination_id, price, details)
VALUES 
(1, 1200.00, '5 days in Tokyo with hotel and sightseeing included.'),
(2, 1500.00, '7 days in Paris with guided tours and meals included.'),
(3, 1000.00, '4 days in New York with Broadway tickets and hotel stay.'),
(4, 1300.00, '6 days in Sydney with a harbor cruise and city tours.'),
(5, 900.00, '5 days in Cairo with guided tours of the pyramids.'),
(6, 1100.00, '6 days in Rio de Janeiro with beach activities and tours.'),
(7, 1400.00, '5 days in Cape Town with a visit to Table Mountain.');


INSERT INTO bookings (customer_id, package_id, booking_date)
VALUES 
(1, 1, NOW()),
(2, 2, NOW()),
(3, 3, NOW()),
(4, 4, NOW()),
(5, 5, NOW()),
(6, 6, NOW()),
(7, 7, NOW());


INSERT INTO reviews (customer_id, package_id, rating, comment)
VALUES 
(1, 1, 5, 'Amazing experience in Tokyo!'),
(2, 2, 4, 'Loved the Eiffel Tower tour.'),
(3, 3, 5, 'Broadway shows were a highlight!'),
(4, 4, 4, 'Sydney was beautiful, loved the harbor!'),
(5, 5, 5, 'The pyramids were breathtaking!'),
(6, 6, 5, 'Rio’s beaches are stunning!'),
(7, 7, 5, 'Cape Town was incredible, especially Table Mountain!');


INSERT INTO payments (booking_id, amount, payment_date, payment_method)
VALUES 
(1, 1200.00, NOW(), 'Credit Card'),
(2, 1500.00, NOW(), 'PayPal'),
(3, 1000.00, NOW(), 'Credit Card'),
(4, 1300.00, NOW(), 'Debit Card'),
(5, 900.00, NOW(), 'Credit Card'),
(6, 1100.00, NOW(), 'PayPal'),
(7, 1400.00, NOW(), 'Credit Card');


INSERT INTO agents (first_name, last_name, email, phone)
VALUES 
('AAAA', 'J', 'aaaa@gmail.com', '9876543210'),
('BBBB', 'S', 'bbbb@gmail.com', '9998987567'),
('CCCC', 'L', 'cccc@gmail.com', '7709876654'),
('DDDD', 'G', 'dddd@gmail.com', '8790076543'),
('EEEE', 'M', 'eeee@gmail.com', '9907754328'),
('FFFF', 'A', 'ffff@gmail.com', '7609854326'),
('GGGG', 'T', 'gggg@gmail.com', '9488768960');



INSERT INTO agent_commissions (agent_id, booking_id, commission_amount)
VALUES 
(1, 1, 100.00),
(2, 2, 150.00),
(3, 3, 80.00),
(4, 4, 130.00),
(5, 5, 90.00),
(6, 6, 110.00),
(7, 7, 120.00);

-- 1. Stored Procedure for Get Average Rating

/* CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAverageRating`()
BEGIN
    SELECT p.package_id, AVG(r.rating) AS average_rating
    FROM packages p
    LEFT JOIN reviews r ON p.package_id = r.package_id
    GROUP BY p.package_id;
END*/

CALL GetAverageRating();


-- 2. Stored Procedure for Get Average Rating Per Package


/*CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAverageRatingPerPackage`()
BEGIN
    SELECT p.package_id, p.details, AVG(r.rating) AS average_rating
    FROM packages p
    LEFT JOIN reviews r ON p.package_id = r.package_id
    GROUP BY p.package_id
    ORDER BY average_rating DESC;
END */

CALL GetAverageRatingPerPackage();


-- 3. Stored Procedure for Get Bookings By Agent


/*CREATE DEFINER=`root`@`localhost` PROCEDURE `GetBookingsByAgent`(IN agentId INT)
BEGIN
    SELECT b.booking_id, c.first_name, c.last_name, p.details
    FROM bookings b
    JOIN packages p ON b.package_id = p.package_id
    JOIN customers c ON b.customer_id = c.customer_id
    JOIN agent_commissions ac ON b.booking_id = ac.booking_id
    WHERE ac.agent_id = agentId;  -- Use the passed agent ID
END*/

CALL GetBookingsByAgent(1);


-- 4. Stored Procedure for Get Customer Bookings


/*CREATE DEFINER=`root`@`localhost` PROCEDURE `GetCustomerBookings`()
BEGIN
    SELECT c.customer_id, c.first_name, c.last_name, b.booking_id, p.details
    FROM customers c
    LEFT JOIN bookings b ON c.customer_id = b.customer_id
    LEFT JOIN packages p ON b.package_id = p.package_id;
END*/

CALL GetCustomerBookings();


-- 5. Stored Procedure for Get Total Commission By Agent

/*CREATE DEFINER=`root`@`localhost` PROCEDURE `GetTotalCommissionByAgent`()
BEGIN
    SELECT a.agent_id, a.first_name, a.last_name, SUM(ac.commission_amount) AS total_commission
    FROM agents a
    LEFT JOIN agent_commissions ac ON a.agent_id = ac.agent_id
    GROUP BY a.agent_id;
END*/

CALL GetTotalCommissionByAgent();


-- 6. Stored Procedure for Get Total Sales By Destination


/*CREATE DEFINER=`root`@`localhost` PROCEDURE `GetTotalSalesByDestination`()
BEGIN
    SELECT d.name, SUM(p.price) AS total_sales
    FROM destinations d
    JOIN packages p ON d.destination_id = p.destination_id
    JOIN bookings b ON p.package_id = b.package_id
    GROUP BY d.name;
END*/

CALL GetTotalSalesByDestination();


SELECT c.customer_id, c.first_name, c.last_name, b.booking_id, p.details
FROM customers c
LEFT JOIN bookings b ON c.customer_id = b.customer_id
LEFT JOIN packages p ON b.package_id = p.package_id;


SELECT p.package_id, AVG(r.rating) AS average_rating
FROM packages p
LEFT JOIN reviews r ON p.package_id = r.package_id
GROUP BY p.package_id;


SELECT d.name, SUM(p.price) AS total_sales
FROM destinations d
JOIN packages p ON d.destination_id = p.destination_id
JOIN bookings b ON p.package_id = b.package_id
GROUP BY d.name;


SELECT p.payment_id, p.amount, p.payment_date, p.payment_method
FROM payments p
JOIN bookings b ON p.booking_id = b.booking_id
WHERE b.customer_id = 1;  -- Change the customer ID as needed


SELECT a.agent_id, a.first_name, a.last_name, SUM(ac.commission_amount) AS total_commission
FROM agents a
LEFT JOIN agent_commissions ac ON a.agent_id = ac.agent_id
GROUP BY a.agent_id;

SELECT b.booking_id, c.first_name, c.last_name, p.details
FROM bookings b
JOIN packages p ON b.package_id = p.package_id
JOIN customers c ON b.customer_id = c.customer_id
JOIN agent_commissions ac ON b.booking_id = ac.booking_id
WHERE ac.agent_id = 1;  -- Change the agent ID as needed


SELECT p.package_id, p.details, AVG(r.rating) AS average_rating
FROM packages p
LEFT JOIN reviews r ON p.package_id = r.package_id
GROUP BY p.package_id
ORDER BY average_rating DESC;


SELECT c.customer_id, c.first_name, c.last_name, b.booking_id, p.details
FROM bookings b
RIGHT JOIN customers c ON b.customer_id = c.customer_id
RIGHT JOIN packages p ON b.package_id = p.package_id;
