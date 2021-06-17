# 1. Inspect the database structure and find the best-fitting table to analyse for the next task.

# 2. Use the RANK() and the table of your choice rank films by length (filter out the rows that have nulls or 0s in 
	# length column). In your output, only select the columns title, length, and the rank.
        
create view films_length as
select f.title as film_title, f.length as film_length, f.rating as film_rating, fa.actor_id as actor_id
from film f
join film_actor fa
on f.film_id= fa.film_id
where f.length is not null or length <> '';

select distinct film_title, film_length,
dense_rank() over (order by film_length desc) as 'ranking'
from films_length
order by ranking;
    
# 3. Build on top of the previous query and rank films by length within the rating category (filter out the rows 
	# that have nulls or 0s in length column). In your output, only select the columns title, length, rating and
    # the rank.
    
select distinct film_title, film_length, film_rating,
dense_rank() over (partition by film_length order by film_rating desc) as 'ranking'
from films_length
where film_length is not null or film_length <> ''
order by ranking;
    
# 4. How many films are there for each of the categories? Inspect the database structure and use appropriate join 
	# to write this query.

select c.name, count(film_id)
from film_category fc
join category c
on fc.category_id = c.category_id
group by c.name;
    
# 5. Which actor has appeared in the most films?

select a.first_name, a.last_name,
rank() over (order by f.film_id desc) as 'ranking'
from actor a
join film_actor fa
on a.actor_id = fa.actor_id
join film f
on fa.film_id=f.film_id;

# 6. Most active customer (the customer that has rented the most number of films)

select c.first_name, c.last_name,
rank() over (order by r.rental_id desc) as 'ranking'
from customer c
join rental r
on c.customer_id = r.customer_id;

# Bonus: Which is the most rented film? The answer is Bucket Brotherhood This query might require using more 
	#	than one join statement. Give it a try. We will talk about queries with multiple join statements later in 
	#	the lessons.
    
select f.title,
rank() over (order by r.rental_id desc) as 'ranking'
from film f
join inventory i
on f.film_id = i.film_id
join rental r
on i.inventory_id=r.inventory_id;