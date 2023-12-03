/* SQL Script to make relationships in DW - Star Schema - many-to-one cardinality */

USE ChinookDW;
Go
ALTER TABLE FactSales ADD  constraint [FactSalesDimDateInvoice] FOREIGN KEY (InvoiceDateKey)
    REFERENCES DimDate(DateKey);


ALTER TABLE FactSales ADD  constraint [FactSalesDimCustomer]  FOREIGN KEY (CustomerKey)
    REFERENCES DimCustomer (CustomerKey);

ALTER TABLE FactSales ADD  constraint [FactSalesDimEmployee] FOREIGN KEY (EmployeeKey)
    REFERENCES DimEmployee (EmployeeKey);

ALTER TABLE FactSales ADD constraint [FactSalesDimTrack] FOREIGN KEY (TrackKey)
    REFERENCES DimTrack (TrackKey);

