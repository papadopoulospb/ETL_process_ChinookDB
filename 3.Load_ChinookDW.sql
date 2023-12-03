/* --RUN THIS SCRIPT ONLY TO LOAD THE DATA WAREHOUSE FROM STAGING FOR THE FIRST TIME--*/
USE ChinookDW

DELETE FROM FactSales;
DELETE FROM DimTrack;
DELETE FROM DimCustomer;
DELETE FROM DimEmployee;


-- Load DimEmployee Table 
INSERT INTO DimEmployee (EmployeeID, EmployeeName, EmployeeTitle, EmployeeManagerName, EmployeeBirthDate, HireDate,
	EmployeeAddress, EmployeeCity, EmployeeState, EmployeeCountry, EmployeePostalCode, EmployeePhone, EmployeeFax,
	EmployeeEmail,[RowStartDate])
  SELECT e1.EmployeeID, e1.[FirstName] + ' ' + e1.[LastName], e1.Title, COALESCE(manager.[FirstName]+' '+manager.[LastName],'N/A') , CAST (e1.[BirthDate] as DATE) , CAST (e1.[HireDate] as DATE),
	e1.[Address] , e1.[City] , COALESCE(e1.[State],'N/A') , e1.[Country], COALESCE(e1.[PostalCode],'N/A') ,e1.[Phone] , COALESCE(e1.[Fax],'N/A') ,e1.[Email],  CAST (e1.[HireDate] as DATE)

  FROM ChinookStaging.dbo.Employee e1
  LEFT JOIN ChinookStaging.dbo.Employee manager ON manager.[EmployeeId] = e1.[ReportsTo]





--Load DimCustomer Table

INSERT INTO DimCustomer(CustomerID,[CustomerFullName], [CustomerCompany], [CustomerAddress], [CustomerCity], [CustomerState], [CustomerCountry],
 [CustomerPostalCode], [CustomerFax], [CustomerEmail],[SupportBy])

    SELECT c.CustomerID, c.[FirstName]+' '+c.[LastName], COALESCE([Company],'N/A') , c.[Address], c.[City], COALESCE(c.[State], 'N/A') , c.[Country],
	COALESCE(c.[PostalCode],'N/A') , COALESCE(c.[Fax] , 'N/A') , c.[Email] , e.FirstName+' '+e.LastName

    FROM ChinookStaging.dbo.Customer c
	INNER JOIN ChinookStaging.dbo.Employee as e ON c.SupportRepId=e.EmployeeId



--Load DimTrack Table
INSERT INTO DimTrack
([TrackID], [TrackName], [AlbumTitle], [ArtistName], [MediaTypeName], [GenreName],[Composer],[Milliseconds],[Bytes])
SELECT [TrackId],[TrackName],[AlbumTitle],[ArtistName],COALESCE([MediaTypeName],'N/A'),COALESCE([GenreName],'N/A'),
COALESCE([Composer],'N/A'),[Milliseconds],[Bytes]
FROM ChinookStaging.dbo.Track


--Load FactSales table
INSERT INTO FactSales(
[TrackKey],[EmployeeKey],[CustomerKey],[InvoiceDateKey],[InvoiceID],[UnitPrice],[Quantity],[PartialAmount]
)
SELECT t.[TrackKey] , e.[EmployeeKey], c.[CustomerKey], 
CAST(FORMAT([InvoiceDate],'yyyyMMdd') AS INT), 
[InvoiceID], [UnitPrice], [Quantity], [UnitPrice]*[Quantity]

FROM ChinookStaging.dbo.Sales s
INNER JOIN  ChinookDW.dbo.DimTrack t ON s.TrackId = t.TrackId
INNER JOIN ChinookDW.dbo.DimEmployee e ON e.EmployeeId=s.EmployeeId
INNER JOIN ChinookDW.dbo.DimCustomer c ON c.CustomerId = s.CustomerId


select * from DimTrack;
select * from DimCustomer;
Select * from DimEmployee;
Select * from DimDate;
select * from FactSales  ;
