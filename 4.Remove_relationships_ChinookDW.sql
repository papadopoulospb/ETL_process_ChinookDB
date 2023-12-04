/* SQL Script to remove relationships between FactSales and Dimension Tables in ChinookDW */
use ChinookDW
GO

ALTER TABLE FactSales DROP CONSTRAINT [FactSalesDimCustomer];

ALTER TABLE FactSales DROP CONSTRAINT [FactSalesDimDateInvoice];

ALTER TABLE FactSales DROP CONSTRAINT [FactSalesDimEmployee];

ALTER TABLE FactSales DROP CONSTRAINT [FactSalesDimTrack] ;