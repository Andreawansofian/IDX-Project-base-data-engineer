

--- Daily Transaction
CREATE PROCEDURE DailyTransaction
    @start_date DATE,
    @end_date DATE
AS
BEGIN
    SELECT
        Transaction_Date AS [Date],
        COUNT(*) AS TotalTransactions,
        SUM(Amount) AS TotalAmount
    FROM
        FactTransaction
    WHERE
        Transaction_Date BETWEEN @start_date AND @end_date
    GROUP BY
        Transaction_Date;
END;

exec DailyTransaction '2024-01-17', '2024-01-22'

---- Balance Per Customer

CREATE PROCEDURE BalancePerCustomer
    @name VARCHAR(100)
AS
BEGIN
    SELECT
        dc.Customer_Name,
        da.Account_Type,
        da.Balance,
        da.Balance - ISNULL(SUM(CASE WHEN ft.Transaction_type = 'Deposit' THEN ft.Amount ELSE -ft.Amount END), 0) AS CurrentBalance
    FROM
        DimCustomer dc
    INNER JOIN
        DimAccount da ON dc.Customer_ID = da.Customer_ID
    LEFT JOIN
        FactTransaction ft ON da.Account_ID = ft.Account_ID
    WHERE
        dc.Customer_Name = @name
        AND da.Status = 'active'
    GROUP BY
        dc.Customer_Name,
        da.Account_Type,
        da.Balance;
END;

exec BalancePerCustomer @Name = 'SHELLY JUWITA'




