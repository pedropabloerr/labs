#1. Review the tables in the database.
#2. Explore tables by selecting all columns from each table or using the in built review features for your client.
SELECT * FROM sakila.actor;
SELECT * FROM sakila.address;
SELECT * FROM sakila.category;
SELECT * FROM sakila.city;
SELECT * FROM sakila.country;
SELECT * FROM sakila.film;
SELECT * FROM sakila.film_actor;
SELECT * FROM sakila.film_category;
SELECT * FROM sakila.film_text;
SELECT * FROM sakila.inventory;
SELECT * FROM sakila.language;
SELECT * FROM sakila.payment;
SELECT * FROM sakila.rental;
SELECT * FROM sakila.staff;
SELECT * FROM sakila.store;

#3. Select one column from a table. Get film titles.

SELECT title from sakila.film;

#4. Select one column from a table and alias it. Get unique list of film languages under the alias language. Note that we are not asking you to obtain the language per each film, but this is a good time to think about how you might get that information in the future.

SELECT distinct name as language from sakila.language;

#5.1 Find out how many stores does the company have?
select count(distinct store_id) from sakila.store;

#5.2 Find out how many employees staff does the company have?
select count(distinct staff_id) from sakila.staff;

#5.3 Return a list of employee first names only?
SELECT first_name from sakila.staff;