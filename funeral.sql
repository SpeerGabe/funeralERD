-- Initialize database
DROP TABLE IF EXISTS Family,Deceased,Item,Service,Clergy,Florist,counselorSession,Payment,Permit,Outsource;

-- Family Table
CREATE TABLE Family (
    familyID INT,
    primaryContactName VARCHAR(100) NOT NULL,
    contactNumber VARCHAR(15) NOT NULL UNIQUE,
    Email VARCHAR(100),
    Address VARCHAR(255),
   familyRequests TEXT,
    CHECK (LENGTH(contactNumber) >= 10),
    Primary Key(familyID)
);

-- Deceased Table
CREATE TABLE Deceased (
    deceasedID INT,
    familyID INT,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    DOB DATE,
    DOD DATE,
    deceasedRequests TEXT,
    Primary Key(deceasedID),
    FOREIGN KEY (familyID) REFERENCES Family(familyID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CHECK (DOB < DOD)
);

-- Service Table
CREATE TABLE Service (
    serviceID INT,
    deceasedID INT,
    location VARCHAR(100),
    outsourceID INT,
    date DATE,
    time TIME,
    Primary Key(serviceID),
    FOREIGN KEY (deceasedID) REFERENCES Deceased(deceasedID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (outsourceID) REFERENCES Outsource(outsourceID)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

-- Clergy Table
CREATE TABLE Clergy (
    clergyID INT,
    Name VARCHAR(100) NOT NULL,
    Religion VARCHAR(50),
    Primary Key(clergyID)
);

-- Florist Table
CREATE TABLE Florist (
    FloristID INT,
    BusinessName VARCHAR(100) NOT NULL,
    Contact_Person VARCHAR(100),
    serviceType VARCHAR(50),
    Cost DECIMAL(10, 2) CHECK (Cost >= 0),
    contactNumber VARCHAR(15) UNIQUE,
    Email VARCHAR(100),
    Primary Key(FloristID)
);

-- Item Table
CREATE TABLE Item (
    Item_ID INT,
    serviceId INT,
    sourceId INT,
    itemType VARCHAR(50) NOT NULL,
    cost DECIMAL(10, 2) CHECK (cost >= 0),
    Primary Key(Item_ID),
    FOREIGN KEY (serviceID) REFERENCES Service(serviceID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Counselor Session Table
CREATE TABLE counselorSession (
    sessionID INT,
    familyID INT,
    counselorName VARCHAR(100),
    date DATE,
    Notes TEXT,
    Primary Key(sessionID),
    FOREIGN KEY (familyID) REFERENCES Family(familyID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Payment Table
CREATE TABLE Payment (
    paymentID INT,
    familyID INT,
    serviceID INT,
    Amount DECIMAL(10, 2) NOT NULL,
    paymentDate DATE,
    paymentMethod VARCHAR(50),
    Primary Key(paymentID),
    FOREIGN KEY (familyID) REFERENCES Family(familyID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (serviceID) REFERENCES Service(serviceID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CHECK (Amount > 0)
);

-- Permit Table
CREATE TABLE Permit (
    documentID INT,
    deceasedID INT,
    documentType VARCHAR(50),
    issuedDate DATE,
    status VARCHAR(50) CHECK (status IN ('Pending', 'Approved', 'Denied')),
    Primary Key(documentID),
    FOREIGN KEY (deceasedID) REFERENCES Deceased(deceasedID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Outsource Table
CREATE TABLE Outsource (
    outsourceID INT,
    clergyID INT,
    floristID INT,
    sourceID INT,
    Primary Key(outsourceID),
    FOREIGN KEY (clergyID) REFERENCES Clergy(clergyID)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    FOREIGN KEY (floristID) REFERENCES Florist(FloristID)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    FOREIGN KEY (sourceID) REFERENCES Item(sourceID)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);
