CREATE DATABASE Supply_Chain_Management;

USE Supply_Chain_Management;

CREATE TABLE Client (
    client_id INT PRIMARY KEY,
    name VARCHAR(255),
    address TEXT
);

CREATE TABLE Shipment (
    shipment_id INT PRIMARY KEY,
    origin VARCHAR(255),
    destination VARCHAR(255),
    weight DECIMAL(10,2),
    content_description TEXT,
    shipment_date DATE,
    sender_id INT,
    receiver_id INT,
    FOREIGN KEY (sender_id) REFERENCES Client(client_id),
    FOREIGN KEY (receiver_id) REFERENCES Client(client_id)
);

CREATE TABLE Carrier (
    carrier_id INT PRIMARY KEY,
    name VARCHAR(255),
    type ENUM('air', 'land', 'sea'),
    contact_info TEXT
);

CREATE TABLE Warehouse (
    warehouse_id INT PRIMARY KEY,
    location VARCHAR(255),
    capacity INT
);

CREATE TABLE Employee (
    employee_id INT PRIMARY KEY,
    name VARCHAR(255),
    role VARCHAR(100),
    warehouse_id INT,
    carrier_id INT,
    CHECK (
        (warehouse_id IS NOT NULL AND carrier_id IS NULL) OR 
        (warehouse_id IS NULL AND carrier_id IS NOT NULL)
    ),
    FOREIGN KEY (warehouse_id) REFERENCES Warehouse(warehouse_id),
    FOREIGN KEY (carrier_id) REFERENCES Carrier(carrier_id)
);

CREATE TABLE Delivery (
    delivery_id INT PRIMARY KEY AUTO_INCREMENT,
    shipment_id INT,
    delivery_date DATE,
    delivery_status VARCHAR(100),  
    receiver_signature VARCHAR(255),
    remarks TEXT,
    FOREIGN KEY (shipment_id) REFERENCES Shipment(shipment_id)
);

INSERT INTO Carrier VALUES (101, 'FedEx', 'air', 'contact@fedex.com');
INSERT INTO Carrier VALUES (102, 'DHL Express', 'land', 'support@dhl.com');
INSERT INTO Carrier VALUES (103, 'Maersk', 'sea', 'info@maersk.com');
INSERT INTO Carrier VALUES (104, 'Blue Dart', 'air', 'help@bluedart.com');
INSERT INTO Carrier VALUES (105, 'RoadRunner Logistics', 'land', 'roadrunner@logistics.com');

INSERT INTO Client VALUES (1, 'ACME Corp', 'New York, USA');
INSERT INTO Client VALUES (2, 'GlobalTech Ltd', 'London, UK');
INSERT INTO Client VALUES (3, 'Nippon Logistics', 'Tokyo, Japan');
INSERT INTO Client VALUES (4, 'Continental Traders', 'Berlin, Germany');
INSERT INTO Client VALUES (5, 'IndoMart Pvt Ltd', 'Mumbai, India');

INSERT INTO Warehouse VALUES (201, 'Chicago, USA', 1000);
INSERT INTO Warehouse VALUES (202, 'Rotterdam, Netherlands', 800);
INSERT INTO Warehouse VALUES (203, 'Singapore', 1200);
INSERT INTO Warehouse VALUES (204, 'Dubai, UAE', 1500);
INSERT INTO Warehouse VALUES (205, 'Chennai, India', 900);

INSERT INTO Employee VALUES (301, 'John Smith', 'Warehouse Staff', 201, NULL);
INSERT INTO Employee VALUES (302, 'Alice Brown', 'Carrier Crew', NULL, 101);
INSERT INTO Employee VALUES (303, 'Liam Chen', 'Warehouse Staff', 202, NULL);
INSERT INTO Employee VALUES (304, 'Fatima Noor', 'Carrier Crew', NULL, 104);
INSERT INTO Employee VALUES (305, 'Rajesh Kumar', 'Warehouse Staff', 205, NULL);