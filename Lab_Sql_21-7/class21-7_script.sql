# 1. Write a SELECT statement that lists the customerid along with their account number, type, 
# the city the customer lives in and their postalcode.

select * from address; # postal code and city
select * from customer; #customer id and type and account number
select * from customeraddress; # joining fields custID and addressID

select c.CustomerID, c.CustomerType, c.AccountNumber, 
a.City, a.PostalCode
from customer c
join customeraddress ca using (CustomerID)
join address a using(AddressID);

# 2. Write a SELECT statement that lists the 20 most recently launched products, their name and colour.

select Name, ProductNumber, Color from product
order by SellStartDate desc
Limit 20;

# 3. Write a SELECT statement that shows how many products are on each shelf on 2/5/98.

select shelf, count(distinct ProductID)
from productinventory
where ModifiedDate= '1998-05-02 00:00:00'
group by Shelf;

# 4. I am trying to track down a vendor email address… his name is Stuart and he works 
	# at G&K Bicycle Corp. Can you help?
    
select * from adventureworks.contact
where FirstName='Stuart';

select c.EmailAddress from contact c
join vendorcontact vc using(ContactID)
join vendor v using(VendorID)
where c.FirstName = 'Stuart'
and v.Name= 'G & K Bicycle Corp.';


# 5. What’s the total sales tax amount for sales to Germany? What’s the top region in Germany by sales tax?

select sum(TaxAmt),cr.Name from salesorderheader
join salesterritory st using (TerritoryID)
join countryregion cr using (CountryRegionCode)
where CountryRegionCode= 'DE';

	#top region
select sp.Name, sum(sh.TaxAmt)
from salesorderheader sh # amounts
join salesterritory st using(TerritoryID) # country - filter
join address on sh.BillToAddressID = AddressID # ship address - to get the region
join stateprovince sp using(StateProvinceID) #region
where st.Name = 'Germany'
group by sp.Name
order by sum(sh.TaxAmt) desc
Limit 1;


# 6. 	Summarise the distinct # transactions by month

select count(distinct TransactionID), month(TransactionDate) from transactionhistory
group by month(TransactionDate);


# 7.  Which ( if any) of the sales people exceeded their sales quota this year and last year?

select salespersonID, Salesquota, SalesYTD from salesperson
where Salesquota < SalesYTD AND SalesQuota < SalesLastYear;

# 8.  Do all products in the inventory have photos in the database and a text product description? 

select count(distinct ProductID) from product; #504
select count(distinct ProductPhotoID) from productproductphoto; #42

	#No. 

# 9.  What's the average unit price of each product name on purchase orders which were not fully, 
	# but at least partially rejected?
    
select p.ProductID, p.Name, avg(p.ListPrice) from product p
join purchaseorderdetail po using (ProductID)
where po.RejectedQty > '1'
group by p.ProductID;
    
# 10. How many engineers are on the employee list? Have they taken any sickleave?


SELECT EmployeeID, Title, SickLeaveHours FROM employee WHERE Title LIKE '%ngineer%' 
and sickleavehours > '0';


# 11. How many days difference on average between the planned and actual end date of workorders 
	# in the painting stages?
    
select avg(DATEDIFF(DueDate, EndDate)) from workorder;

