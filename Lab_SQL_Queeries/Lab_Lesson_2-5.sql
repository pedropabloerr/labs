#Instructions

# 1. Select all the actors with the first name ‘Scarlett’.

select * from actor
where first_name regexp'SCARLETT'; 

# 2. How many films (movies) are available for rent and how many films have been rented?

select count(film_id) from film; #1000
SELECT count(rental_id) from rental; #16044

#3. What are the shortest and longest movie duration? Name the values max_duration and min_duration.

select min(length) as min_duration from film; #46 minutes
select max(length) as max_duration from film; #185 minutes

#4. What's the average movie duration expressed in format (hours, minutes)?

select round(avg(length/60)) as length_hours_avg,
round(avg(length%60)) as length_minutes_avg
from film; #2:30

select time_format(sec_to_time(round(avg(length)*60)), '%H:%i') from film;

#5. How many distinct (different) actors' last names are there?

select distinct count(last_name) from actor; #200

#6. Since how many days has the company been operating (check DATEDIFF() function)?

select datediff(max(rental_date), min(rental_date)) from rental; #266

#7. Show rental info with additional columns month and weekday. Get 20 results.

select *, month(rental_date) as only_month, 
day(rental_date) as only_day
from rental
limit 20;

#8. Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.

select *, date_format(convert(substring_index(rental_date, ' ', 1), date), '%W'),
case
when date_format(convert(substring_index(rental_date, ' ', 1), date), '%W') = 'Saturday' then 'Weekend'
when date_format(convert(substring_index(rental_date, ' ', 1), date), '%W') = 'Sunday' then 'Weekend'
else 'Weekday'
end as 'day_type'
from rental;

#9.How many rentals were in the last month of activity?

select count(*) from rental
where date(rental_date) between '2005-07-24' and '2005-08-23'; #8942




