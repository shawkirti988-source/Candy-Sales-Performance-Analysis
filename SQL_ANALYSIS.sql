use candy_project;
select * from candy_sales;
select * from candy_products;
select * from product_summary;


select division, `product name`, round(`unit price`*total_units,2) as total_sp, round(`unit cost`*total_units,2) as total_cp,
round((`unit price`*total_units)- (`unit cost`*total_units),2) as total_profit,
round((((`unit price`*total_units)- (`unit cost`*total_units))/(`unit cost`*total_units))*100,2) as profit_percent 
from product_summary
where division="chocolate";

select division, `product name`, round(`unit price`*total_units,2) as total_sp, round(`unit cost`*total_units,2) as total_cp,
round((`unit price`*total_units)- (`unit cost`*total_units),2) as total_profit,
round((((`unit price`*total_units)- (`unit cost`*total_units))/(`unit cost`*total_units))*100,2) as profit_percent 
from product_summary
where division="sugar";


select division, `product name`, round(`unit price`*total_units,2) as total_sp, round(`unit cost`*total_units,2) as total_cp,
round((`unit price`*total_units)- (`unit cost`*total_units),2) as total_profit,
round((((`unit price`*total_units)- (`unit cost`*total_units))/(`unit cost`*total_units))*100,2) as profit_percent 
from product_summary
where division="other";

with k as (select division, `product name`, `unit price`, `unit cost`, total_units,
sum(total_units) over (partition by division) as division_wise_total_units_sold
from product_summary)

select * , round((total_units/division_wise_total_units_sold)*100,2) as unit_percent_contribution
from k
where division= "chocolate";


with k as (select division, `product name`, `unit price`, `unit cost`, total_units,
sum(total_units) over (partition by division) as division_wise_total_units_sold
from product_summary)

select * , round((total_units/division_wise_total_units_sold)*100,2) as unit_percent_contribution
from k
where division= "sugar";


with k as (select division, `product name`, `unit price`, `unit cost`, total_units,
sum(total_units) over (partition by division) as division_wise_total_units_sold
from product_summary)

select * , round((total_units/division_wise_total_units_sold)*100,2) as unit_percent_contribution
from k
where division= "other";



with k as (select division, `product name`, `unit price`, `unit cost`,`unit price`*total_units as total_revenue,
sum(`unit price`*total_units) over ( partition by division) as division_wise_total_revenue
from product_summary)

select *, round((total_revenue/division_wise_total_revenue)*100,2) as revenue_percent_contribution
from k
where division= "chocolate";


with k as (select division, `product name`, `unit price`, `unit cost`,`unit price`*total_units as total_revenue,
sum(`unit price`*total_units) over ( partition by division) as division_wise_total_revenue
from product_summary)

select *, round((total_revenue/division_wise_total_revenue)*100,2) as revenue_percent_contribution
from k
where division= "sugar";


with k as (select division, `product name`, `unit price`, `unit cost`,`unit price`*total_units as total_revenue,
sum(`unit price`*total_units) over ( partition by division) as division_wise_total_revenue
from product_summary)

select *, round((total_revenue/division_wise_total_revenue)*100,2) as revenue_percent_contribution
from k
where division= "other";


/*2.Are there any seasonal patterns in products sales quantities?(helps  in stock planning and avoid loss and helps in promotion)*/

select * from candy_sales;

USE CANDY_PROJECT;
select year(order_date) as year, month(order_date) as month, division, `product name`, sum(units) as units_sold
from candy_sales
where division ="chocolate"
group by year(order_date), month(order_date), division, `product name`
order by year(order_date) , month(order_date);



with k as (select year(order_date) as year, month(order_date) as month, division, sum(units) as units_sold
from candy_sales
where division ="sugar"
group by year(order_date), month(order_date), division
order by year(order_date) ,month(order_date))
select *,
(units_sold/ sum(units_sold) over (partition by year))*100 as unit_percent_sold
from k;


with k as (select year(order_date) as year, month(order_date) as month, division, sum(units) as units_sold
from candy_sales
where division ="chocolate"
group by year(order_date), month(order_date), division
order by year(order_date) ,month(order_date))
select *,
(units_sold/ sum(units_sold) over (partition by year))*100 as unit_percent_sold
from k;


with k as (select year(order_date) as year, month(order_date) as month, division, sum(units) as units_sold
from candy_sales
where division ="other"
group by year(order_date), month(order_date), division
order by year(order_date) ,month(order_date))
select *,
(units_sold/ sum(units_sold) over (partition by year))*100 as unit_percent_sold
from k;




/*3.Are low sales linked to specific region or is it across all locations?(helps target region specific market)*/

select * from product_summary;
select * from candy_sales;

select region, division, sum(units) as units_sold
from candy_sales
where division = "chocolate"
group by region, division
order by region;  

select region, division, sum(units) as units_sold
from candy_sales
where division = "sugar"
group by region, division
order by region;  


select region, division, sum(units) as units_sold
from candy_sales
where division = "other"
group by region, division
order by region;  


select region, division,`product name`, sum(units) as units_sold
from candy_sales
where Division="chocolate" and region ="gulf"
group by region, division, `product name`
order by region;  


select region, division,`product name`, sum(units) as units_sold
from candy_sales
where Division="chocolate" and region ="interior"
group by region, division, `product name`
order by region;  


select region, division,`product name`, sum(units) as units_sold
from candy_sales
where Division="chocolate" and region ="pacific"
group by region, division, `product name`
order by region;  


select region, division,`product name`, sum(units) as units_sold
from candy_sales
where Division="chocolate" and region ="atlantic"
group by region, division, `product name`
order by region;  


select region, division,`product name`, sum(units) as units_sold
from candy_sales
where Division="sugar" and region ="gulf"
group by region, division, `product name`
order by region;  


select region, division,`product name`, sum(units) as units_sold
from candy_sales
where Division="sugar" and region ="interior"
group by region, division, `product name`
order by region;  

select region, division,`product name`, sum(units) as units_sold
from candy_sales
where Division="sugar" and region ="pacific"
group by region, division, `product name`
order by region;  


select region, division,`product name`, sum(units) as units_sold
from candy_sales
where Division="sugar" and region ="atlantic"
group by region, division, `product name`
order by region;  


select region, division,`product name`, sum(units) as units_sold
from candy_sales
where Division="other" and region ="gulf"
group by region, division, `product name`
order by region;  


select region, division,`product name`, sum(units) as units_sold
from candy_sales
where Division="other" and region ="interior"
group by region, division, `product name`
order by region;  


select region, division,`product name`, sum(units) as units_sold
from candy_sales
where Division="other" and region ="pacific"
group by region, division, `product name`
order by region;  


select region, division,`product name`, sum(units) as units_sold
from candy_sales
where Division="other" and region ="atlantic"
group by region, division, `product name`
order by region;  



/*6.target wise sales'  (if target not met then we need to focus that category and it exceed its target then what we did to achieve that)*/

select * from candy_targets;
select * from candy_sales;

alter table candy_sales
drop column sp;
select * from product_summary;


select * from candy_targets;
select * from product_summary;
select * from candy_sales;

select year(order_date) as year, s.division, round(sum(s.sales),2)total_sales, t.target
from candy_sales as s inner join candy_targets as t
on s.division=t.division
where year(order_date)=2021
group by year(order_date),s.division, t.target;


select year(order_date) as year, division, `product name`,round(sum(sales),2) as sales
from candy_sales
where year(order_date)=2021 and division="chocolate"
group by year(order_date), division, `product name`;


select year(order_date) as year, division, `product name`,round(sum(sales),2) as sales
from candy_sales
where year(order_date)=2021 and division="sugar"
group by year(order_date), division, `product name`;


select year(order_date) as year, division, `product name`,round(sum(sales),2) as sales
from candy_sales
where year(order_date)=2021 and division="other"
group by year(order_date), division, `product name`;


select year(order_date) as year, s.division, round(sum(s.sales),2) as total_sales, t.target
from candy_sales as s inner join candy_targets as t
on s.division=t.division
where year(order_date)=2022
group by year(order_date),s.division, t.target;


select year(order_date) as year, division, `product name`,round(sum(sales),2) as sales
from candy_sales
where year(order_date)=2022 and division="chocolate"
group by year(order_date), division, `product name`;


select year(order_date) as year, division, `product name`,round(sum(sales),2) as sales
from candy_sales
where year(order_date)=2022 and division="sugar"
group by year(order_date), division, `product name`;


select year(order_date) as year, division, `product name`,round(sum(sales),2) as sales
from candy_sales
where year(order_date)=2022 and division="other"
group by year(order_date), division, `product name`;




select year(order_date) as yaer, s.division, round(sum(s.sales),2) as total_sales, t.target
from candy_sales as s inner join candy_targets as t
on s.division=t.division
where year(order_date)=2023
group by year(order_date),s.division, t.target;


select year(order_date) as year, division, `product name`,round(sum(sales),2) as sales
from candy_sales
where year(order_date)=2023 and division="chocolate"
group by year(order_date), division, `product name`;


select year(order_date) as year, division, `product name`,round(sum(sales),2) as sales
from candy_sales
where year(order_date)=2023 and division="sugar"
group by year(order_date), division, `product name`;



select year(order_date) as year, division, `product name`,round(sum(sales),2) as sales
from candy_sales
where year(order_date)=2023 and division="other"
group by year(order_date), division, `product name`;




select year(order_date) as year, s.division, round(sum(s.sales),2) as total_sales, t.target
from candy_sales as s inner join candy_targets as t
on s.division=t.division
where year(order_date)=2024
group by year(order_date),s.division, t.target;



select year(order_date) as year, division, `product name`,round(sum(sales),2) as sales
from candy_sales
where year(order_date)=2024 and division="chocolate"
group by year(order_date), division, `product name`;


select year(order_date) as year, division, `product name`,round(sum(sales),2) as sales
from candy_sales
where year(order_date)=2024 and division="sugar"
group by year(order_date), division, `product name`;



select year(order_date) as year, division, `product name`,round(sum(sales),2) as sales
from candy_sales
where year(order_date)=2024 and division="other"
group by year(order_date), division, `product name`;


select city, division, sum(units) as units_sold
from candy_sales
where division = "chocolate"
group by city, division
order by units_sold desc;

  select city, division, sum(units) as units_sold
from candy_sales
where division = "sugar"
group by city, division
order by units_sold desc;


select city, division, sum(units) as units_sold
from candy_sales
where division = "other"
group by city, division
order by units_sold desc;