drop table if exists zepto;

create table zepto(
sku_id serial primary key,
Category varchar(120),
name varchar(150) NOT NULL,
mrp numeric(8,2),
discountPercent numeric(5,2),
availableQuantity integer,
discountedSellingPrice numeric(8,2),
weightInGms integer,
outOfStock boolean,
quantity integer
);

select count(*) from zepto;

select * from zepto

--null values
select * from zepto
where name is null
or
category is null
or
mrp is null
or
discountpercent is null
or
availablequantity is null
or
discountedsellingprice is null
or
weightingms is null
or
outofstock is null
or 
quantity is null;

-- different products

select distinct category from zepto order by category;

-- product in stock and out of stock

select outofstock, count(sku_id) 
from zepto 
group by outofstock

-- product name present multiple times

select name, count(sku_id) as "number of sku_id"
from zepto
group by name 
having count(sku_id) > 1
order by count(sku_id) desc;

--Data cleaning
-- product with the price = 0

select * from zepto
where
mrp = 0 or discountedsellingprice = 0

--delete
delete from zepto where mrp = 0;

--convet paise to rupees
update zepto 
set mrp = mrp/100.0,
discountedsellingprice = discountedsellingprice/100.0

select mrp,discountedsellingprice from zepto; 

--businesss questions

--1. top 10 selling product based on discount percentage

select distinct name, mrp, discountpercent
from zepto
order by discountpercent desc
limit 10;

--2. products of highest mrp but out of stock

select distinct name, mrp
from zepto
where outofstock = True and mrp > 300
order by mrp;

--3. total revenue by the category

select category, sum(discountedsellingprice * availablequantity) as Tot_revenue
from zepto
group by category
order by Tot_revenue;

--4. find produc with mrp is greater than 500 and dicount percent is less than 10

select name, mrp, discountpercent 
from zepto
where mrp > 500 and discountpercent < 10
order by mrp desc;

--5. top 5 category offering the hightst average discount percentage

select category, round(avg(discountpercent),2) as Highestdiscount 
from zepto
group by category
order by Highestdiscount desc
limit 5;

--6 find the price per gram, which as more than 100grms, and sort by best value

select distinct name, weightingms, discountedsellingprice, 
round(discountedsellingprice / weightingms,2) as pricepergms
from zepto
where weightingms > 100
order by pricepergms desc;

--7. group the products into category lile low medium bulk

select distinct name, weightingms, 
case when weightingms < 1000 then 'low'
   when weightingms < 5000 then'medium'
   else 'Bulk'
   end as weight_cat
from zepto;

--8 total weight by category

select category, sum(weightingms * availablequantity) as Total_weight
from zepto
group by category
order by Total_weight;