CREATE TABLE Person(
    ID INT PRIMARY KEY,
    FirstName VARCHAR(255),
    LastName VARCHAR(255),
    Address VARCHAR(255),
    SSN VARCHAR(255),
    Phone VARCHAR(255),
    ClubID INT,
)

CREATE TABLE Hiker(
    ID INT PRIMARY KEY,
    HighestPeek VARCHAR(255),
    FOREIGN KEY (ID) REFERENCES Person(ID)
    FOREIGN KEY (ClubID) REFERENCES Club(ID)
);

CREATE TABLE Guide(
    ID INT PRIMARY KEY,
    Specialization VARCHAR(255),
    FOREIGN KEY (ID) REFERENCES Person(ID)
);

CREATE TABLE Certification(
    ID INT PRIMARY KEY,
    Name VARCHAR(255),
    IssueDate DATE,
    ExpirationDate DATE,
    Grade VARCHAR(1),
    Academy VARCHAR(255),
    GuideID INT,
    FOREIGN KEY (GuideID) REFERENCES Guide(ID)
);

CREATE TABLE Employment(
    StartDate DATE PRIMARY KEY,
    EndDate DATE,
    CompanyID INT,
    GuideID INT,
    FOREIGN KEY (CompanyID) REFERENCES Company(ID),
    FOREIGN KEY (GuideID) REFERENCES Guide(ID)
)

CREATE TABLE Company (
    ID INT PRIMARY KEY,
    Name VARCHAR(255)
);

CREATE TABLE Product (
    ID INT PRIMARY KEY,
    Price DECIMAL(10, 2),
    CompanyID INT,
    FOREIGN KEY (CompanyID) REFERENCES Company(ID)
);

CREATE TABLE Package (
    ID INT PRIMARY KEY,
    Difficulty VARCHAR(50)
    Name VARCHAR(255),
    FOREIGN KEY (ID) REFERENCES Product(ID)
);

CREATE TABLE Destination (
    ID INT PRIMARY KEY,
    Name VARCHAR(255),
    TractName VARCHAR(255),
    Distance INT,
    Difficulty VARCHAR(255),
    Elevation INT,
    FOREIGN KEY (ID) REFERENCES Product(ID)
);

CREATE TABLE Trip (
    ID INT PRIMARY KEY,
    StartDate DATE,
    GuideID INT,
    HikerID INT,
    DestinationID INT,
    FOREIGN KEY (HikerID) REFERENCES Hiker(ID),
    FOREIGN KEY (GuideID) REFERENCES Guide(ID),
    FOREIGN KEY (DestinationID) REFERENCES Destination(ID)
);

CREATE TABLE Club (
    ID INT PRIMARY KEY,
    Name VARCHAR(255),
    EstDate DATE
);

CREATE TABLE MemberOf (
    HikerID INT,
    ClubID INT,
    PRIMARY KEY (HikerID, ClubID),
    FOREIGN KEY (HikerID) REFERENCES Hiker(ID),
    FOREIGN KEY (ClubID) REFERENCES Club(ID)
);

CREATE TABLE Representative (
    ID INT PRIMARY KEY,
    Name VARCHAR(255),
    BrandID INT,
    FOREIGN KEY (BrandID) REFERENCES Brand(ID)
);

CREATE TABLE Brand (
    ID INT PRIMARY KEY,
    Name VARCHAR(255),
    Payment VARCHAR(255)
)

CREATE TABLE Rates (
    HikerID INT,
    TripID INT,
    Rating INT,
    Date DATE,
    PRIMARY KEY (HikerID, TripID, Date),
    FOREIGN KEY (HikerID) REFERENCES Hiker(ID),
    FOREIGN KEY (TripID) REFERENCES Trip(ID)
);

