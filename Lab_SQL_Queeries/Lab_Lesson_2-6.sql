# Instructions

#1. Get release years.
select distinct release_year from sakila.film;

#2. Get all films with ARMAGEDDON in the title.

select * from film
where title regexp 'ARMAGEDDON'; #6

#3. Get all films which title ends with APOLLO.

select * from film
where title regexp 'APOLLO$'; #5

#4. Get 10 the longest films.

select * from film
order by length DESC
limit 10;

#5. How many films include Behind the Scenes content?

select count(*) from film
where special_features regexp 'Behind the Scenes'; #538

# 6. Drop column picture from staff.

alter table staff
drop column picture;

#7. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.

select * from customer
where last_name regexp 'SANDERS';

	#alternative #where first_name = 'TAMMY' and where last_name = "SANDERS"

insert into staff
values ('3', 'Tammy', 'Sanders', '79', 'TAMMY.SANDERS@sakilacustomer.org', '2', '1', 'Tammy', '', current_date);

#8. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. You can use current date for the rental_date column in the rental table. Hint: Check the columns in the table rental and see what information you would need to add there. You can query those pieces of information. For eg., you would notice that you need customer_id information as well. To get that you can use the following query:

select * from sakila.customer
where first_name = 'CHARLOTTE' and last_name = 'HUNTER';

select max(rental_id) from rental;
select film_id from film
where title = 'ACADEMY DINOSAUR'; #1
select inventory_id from inventory
where film_id = '1';

insert into rental
values ('16050', current_date, '1', '130', current_date, '3', current_date);

# 9. Delete non-active users, but first, create a backup table deleted_users to store customer_id, email, 
# and the date for the users that would be deleted. Follow these steps:

	# Check if there are any non-active users
    
select count(*) from sakila.customer
where active = '0';
    
	# Create a table backup table as suggested
    
create table backup_table
(customer_id INT, email VARCHAR(50), date_of_deletion DATE);

drop table backup_table;
    
	# Insert the non active users in the table backup table

insert into backup_table (customer_id, email, date_of_deletion)
select customer_id, email, current_date
from customer
where active = '0'; 

	# Delete the non active users from the table customer

delete from customer 
where active = '0';



