# 1. How many copies of the film Hunchback Impossible exist in the inventory system?

SELECT 
   count(film_id) as counts
FROM
    inventory
WHERE
    film_id = (SELECT 
            film_id
        FROM
            film
        WHERE
            title = 'Hunchback Impossible')
;
			-- Answer is 6

# 2. List all films whose length is longer than the average of all the films.

-- 1 steps: Find out what the average length of all films is 

(select avg(length)
from film);

-- 2 step: from the film table we check the films above the average 
SELECT 
    title, length
FROM
    film
WHERE
    length > (SELECT 
            AVG(length)
        FROM
            film)
;

# 3. Use subqueries to display all actors who appear in the film Alone Trip.

-- 1 step: find out the ID of the movie Alone Trip
-- 2 step: find out all the actos actos_idsassociated to that film_id. 

SELECT 
    first_name, last_name
FROM
    actor
WHERE
    actor_id IN ((SELECT 
            actor_id
        FROM
            film_actor
        WHERE
            film_id = (SELECT 
                    film_id
                FROM
                    film
                WHERE
                    title = 'ALONE TRIP')));


# 4. Sales have been lagging among young families, and you wish to target all family movies for a promotion. 
	#  Identify all movies categorized as family films.

SELECT 
    title
FROM
    film
WHERE
    film_id IN (SELECT 
            film_id
        FROM
            film_category
        WHERE
            category_id IN (SELECT 
                    category_id
                FROM
                    category
                WHERE
                    name = 'family'));



# 5. Get name and email from customers from Canada using subqueries. Do the same with joins.
	## Note that to create a join, you will have to identify the correct tables with their primary keys and 
    ##	foreign keys, that will help you get the relevant information.

	-- with subqueery
select concat(first_name, ' ', last_name) as customer_name, email
from customer
where address_id in
(select
address_id
from address
where city_id in
(SELECT city_id
from city
where country_id in        
(select 
country_id
from country
where counTry= 'CANADA')));

-- with join

select * from customer 
join ( address
join (city
join country using (country_id))
using (city_id))
using (address_id)
where country = 'Canada'; 
    
# 6. Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted
	## in the most number of films. First you will have to find the most prolific actor and then use that 
		## actor_id to find the different films that he/she starred.
        
-- step 1, find the actor_id of the most prolific actor. alter

select count(film_id) as count_film_id, 
actor_id
from actor
join film_actor using (actor_id)
join film using (film_id)
group by actor_id
order by count_film_id desc
limit 1;

 -- 2 step
 
select concat(first_name, ' ', last_name), 
title,
release_year
from 
actor 
JOIN 
film_actor using (actor_id) 
join film using (film_id)
where  
actor_id = 
(select actor_id
from actor
join film_actor using (actor_id)
join film using (film_id)
group by actor_id
order by count(film_id) desc
limit 1);

        
        
# 7. Films rented by most profitable customer. You can use the customer table and payment table to find the 
	# most profitable customer ie the customer that has made the largest sum of payments
    
-- 1step find the id of the most profitable costumer. 

    select customer_id
    from customer
    join payment using (customer_id)
    group by customer_id
    order by sum(amount) desc
    limit 1;
    
 -- 2 step we use this customer id in the rental table, which we will join with inventory and film_inventory table
 
 SELECT 
    film_id, title, amount
FROM
    film
        JOIN
    inventory USING (film_id)
        JOIN
    rental USING (inventory_id)
        JOIN
    payment USING (rental_id)
WHERE
    rental.customer_id = (SELECT 
            customer_id
        FROM
            customer
                JOIN
            payment USING (customer_id)
        GROUP BY customer_id
        ORDER BY SUM(amount) DESC
        LIMIT 1)
ORDER BY rental_date DESC;
    
# 8. Customers who spent more than the average payments.