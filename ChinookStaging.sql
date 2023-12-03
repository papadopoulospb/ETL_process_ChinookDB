USE master
GO
if exists (select * from sysdatabases where name='ChinookStaging')
		alter database ChinookStaging set single_user with rollback immediate
		drop database ChinookStaging
go

CREATE DATABASE ChinookStaging
GO

USE ChinookStaging
GO

DROP TABLE IF EXISTS ChinookStaging.[dbo].[Track]; --the products that company sell 
DROP TABLE IF EXISTS ChinookStaging.[dbo].Sales;   --this is invoice (order) information 
DROP TABLE IF EXISTS ChinookStaging.[dbo].[Customer];
DROP TABLE IF EXISTS ChinookStaging.[dbo].[Employee];
DROP TABLE IF EXISTS ChinookStaging.[dbo].DimDate;


-----------------------------
-- GET DATA FROM EMPLOYEES --
-----------------------------

SELECT [EmployeeId]
      ,[LastName]
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
      ,[Email]
INTO ChinookStaging.[dbo].[Employee]
FROM [Chinook].[dbo].[Employee] ;

-----------------------------
-- GET DATA FROM CUSTOMERS --
-----------------------------

SELECT [CustomerId]
      ,[FirstName]
      ,[LastName]
      ,[Company]
      ,[Address]
      ,[City]
      ,[State]
      ,[Country]
      ,[PostalCode]
      ,[Phone]
      ,[Fax]
      ,[Email]
      ,[SupportRepId]
INTO ChinookStaging.[dbo].[Customer]
FROM [Chinook].[dbo].[Customer];

-----------------------------
-- GET DATA FROM TRACK --
-----------------------------
SELECT t.[TrackId]
      ,t.[Name] as TrackName
      ,a.[Title] as AlbumTitle
	  ,artist.[Name] as ArtistName 
      ,mt.[Name] as MediaTypeName
      ,g.[Name] as GenreName
      ,t.[Composer]
      ,t.[Milliseconds]
      ,t.[Bytes]
--	  ,p.[Name] as PlayListName 
INTO ChinookStaging.[dbo].[Track] 
FROM [Chinook].[dbo].[Track] as t
INNER JOIN Chinook.[dbo].[Album] a ON a.AlbumId = t.AlbumId 
INNER JOIN Chinook.[dbo].[Artist] artist ON artist.ArtistId = a.ArtistId

INNER JOIN [Chinook].[dbo].[MediaType] mt ON mt.MediaTypeId=t.MediaTypeId

INNER JOIN [Chinook].[dbo].[Genre] g ON g.GenreId = t.GenreId 
/*
INNER JOIN Chinook.[dbo].[PlaylistTrack] plt ON plt.TrackId = t.TrackId
INNER JOIN [Chinook].[dbo].[Playlist] p ON p.PlaylistId = plt.PlaylistId ;
*/
--i comment the above 2 rows to face many-to-many cardinality to DW . This need fixing !!!

-----------------------------
-- GET DATA FROM INVOICE --
-----------------------------

SELECT il.[TrackId]      -- productID
      ,i.[InvoiceId]     -- the order (timologio)
      ,i.[CustomerId]    -- the customer that made the order
	  ,e.[EmployeeId]    --the employee who helped the customer for the order
      ,i.[InvoiceDate]   -- the date
      ,il.[UnitPrice]    -- track price
      ,il.[Quantity]     -- track quantity - always 1
INTO ChinookStaging.[dbo].Sales 
FROM [Chinook].[dbo].[Invoice] i
INNER JOIN [Chinook].[dbo].[InvoiceLine] il ON il.InvoiceId = i.InvoiceId
INNER JOIN [Chinook].[dbo].[Customer] c ON c.CustomerId = i.CustomerId
INNER JOIN [Chinook].[dbo].[Employee] e ON e.EmployeeId = c.SupportRepId ;


SELECT MIN([InvoiceDate]) minDate, MAX([InvoiceDate]) maxDate FROM Sales;



