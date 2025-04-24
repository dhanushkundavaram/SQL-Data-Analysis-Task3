-- Use the Chinook database
USE Chinook;

-- 1. Top 5 customers by total spending
SELECT CustomerId, SUM(Total) AS TotalSpent
FROM Invoice
GROUP BY CustomerId
ORDER BY TotalSpent DESC
LIMIT 5;

-- 2. Average invoice amount
SELECT AVG(Total) AS AvgInvoiceAmount
FROM Invoice;

-- 3. Number of customers by country
SELECT Country, COUNT(*) AS TotalCustomers
FROM Customer
GROUP BY Country
ORDER BY TotalCustomers DESC;

-- 4. Total sales by genre
SELECT Genre.Name AS Genre, SUM(InvoiceLine.UnitPrice * InvoiceLine.Quantity) AS Revenue
FROM InvoiceLine
JOIN Track ON InvoiceLine.TrackId = Track.TrackId
JOIN Genre ON Track.GenreId = Genre.GenreId
GROUP BY Genre
ORDER BY Revenue DESC;

-- 5. Create a view for artist revenue
CREATE VIEW ArtistRevenue AS
SELECT Artist.Name AS Artist, SUM(InvoiceLine.UnitPrice * InvoiceLine.Quantity) AS TotalRevenue
FROM InvoiceLine
JOIN Track ON InvoiceLine.TrackId = Track.TrackId
JOIN Album ON Track.AlbumId = Album.AlbumId
JOIN Artist ON Album.ArtistId = Artist.ArtistId
GROUP BY Artist;

-- 6. Subquery: Customers who spent more than the average
SELECT CustomerId, TotalSpent
FROM (
  SELECT CustomerId, SUM(Total) AS TotalSpent
  FROM Invoice
  GROUP BY CustomerId
) AS CustomerTotals
WHERE TotalSpent > (
  SELECT AVG(Total)
  FROM Invoice
);

-- 7. Index creation 
CREATE INDEX idx_country ON Customer (Country);
