/* This SQL script make changes in Chinook database */

USE [Chinook]
GO



/* Update Employee with EmployeeId=2 */
UPDATE [dbo].[Employee] SET 
Title = 'Data Engineer' ,
ReportsTo = 1,
City='Athens',
State='Athens',
Country = 'Greece',
PostalCode='1111'
WHERE EmployeeId=2 ;

/* Update Employee with EmployeeId=2 */
UPDATE [dbo].[Employee] SET 
Title = 'Data Analyst' ,
ReportsTo = 1,
City='Athens',
State='Athens',
Country = 'Greece',
PostalCode='1111'
WHERE EmployeeId=3 ;

SELECT * FROM [dbo].[Employee] WHERE [EmployeeId]=2 ; 

/* Insert Employee */

INSERT INTO [dbo].[Employee] ([EmployeeId],[LastName]
      ,[FirstName]
      ,[Title]
      ,[ReportsTo]
      ,[BirthDate]
      ,[HireDate]
      ,[Address]
      ,[City]
      ,[State]
      ,[Country]
      ,[PostalCode]
      ,[Phone]
      ,[Fax]
      ,[Email])
VALUES(9,'Cruise', 'Tom','Business Analyst',1,'1980-01-01','2013-12-23 00:00:00.000','Smith 70','NY',NULL,'USA',NULL,'1234',NULL,'cruise@cruise.com');

INSERT INTO [dbo].[Employee] ([EmployeeId],[LastName]
      ,[FirstName]
      ,[Title]
      ,[ReportsTo]
      ,[BirthDate]
      ,[HireDate]
      ,[Address]
      ,[City]
      ,[State]
      ,[Country]
      ,[PostalCode]
      ,[Phone]
      ,[Fax]
      ,[Email])
VALUES(10,'Stark', 'Tony','Mechanical Engineer',1,'1980-01-01','2013-12-23 00:00:00.000','Smith 70','NY',NULL,'USA',NULL,'1234',NULL,'cruise@cruise.com');



SELECT * FROM [dbo].[Employee] ;

/* Insert new Invoice */

INSERT INTO [dbo].[Invoice]([InvoiceId],[CustomerId],[InvoiceDate],[Total])
VALUES(413 , 1 , '2013-12-24', 2.97 );
declare  @InsertedInvoice int =413;


--SELECT * FROM [dbo].[Invoice] WHERE [InvoiceDate]>='2013-12-22 00:00:00.000'

INSERT INTO [dbo].[InvoiceLine](
[InvoiceLineId]
      ,[InvoiceId]
      ,[TrackId]
      ,[UnitPrice]
      ,[Quantity])
	  OUTPUT
inserted.[InvoiceLineId],  inserted.[InvoiceId],  inserted.[TrackId],  inserted.[UnitPrice],  inserted.[Quantity]

VALUES(2241,@InsertedInvoice,1,0.99,1),
	  (2242,@InsertedInvoice,2,0.99,1),
	  (2243,@InsertedInvoice,3,0.99,1);
	  