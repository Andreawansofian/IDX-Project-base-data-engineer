CREATE TABLE DimAccount (
    Account_ID INT PRIMARY KEY,
    Customer_ID INT,
    Account_Type VARCHAR(50),
	Balance INT,
	Date_opened Date,
	Status VARCHAR(50)
	FOREIGN KEY (Customer_ID) REFERENCES DimCustomer(Customer_ID)
);

CREATE TABLE DimCustomer (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(100),
    Address VARCHAR(255),
    City_Name VARCHAR(100),
    State_Name VARCHAR(100),
	Age VARCHAR(100),
	Gender VARCHAR(50),
	Email VARCHAR(100),
);

CREATE TABLE DimBranch (
    Branch_ID INT PRIMARY KEY,
    Branch_Name VARCHAR(100),
    Branch_location VARCHAR(100)
);

CREATE TABLE FactTransaction (
    Transaction_ID INT PRIMARY KEY,
    Account_ID INT,
    Transaction_Date DATE,
	Amount INT,
	Transaction_type VARCHAR(100),
	Branch_ID INT,
    FOREIGN KEY (Account_ID) REFERENCES DimAccount (Account_ID),
    FOREIGN KEY (Branch_ID) REFERENCES DimBranch (Branch_ID)
);

