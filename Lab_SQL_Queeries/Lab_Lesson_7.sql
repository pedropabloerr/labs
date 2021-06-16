#Instructions

# 1. In the actor table, which are the actors whose last names are not repeated? For example if you would sort the 
	# data in the table actor by last_name, you would see that there is Christian Arkoyd, Kirsten Arkoyd, and 
	# Debbie Arkoyd. These three actors have the same last name. So we do not want to include this last name 
	# in our output. Last name "Astaire" is present only one time with actor "Angelina Astaire", hence we 
	# would want this in our output list.
    
select last_name
from actor
group by last_name
having COUNT(last_name)=1;



# 2. Which last names appear more than once? We would use the same logic as in the previous question but this time 
	# we want to include the last names of the actors where the last name was present more than once.

select last_name
from actor
group by last_name
having COUNT(last_name) > 1;

# 3. Using the rental table, find out how many rentals were processed by each employee.

select staff_id, count(staff_id) as staff_count
from rental
group by staff_id;

		# Staff 1 --> 8040
        # Staff 2 --> 8004
        # Staff 3 (Tammy) --> 1

# 4. Using the film table, find out how many films were released each year

select release_year, count(film_id) as films_by_year
from film
group by release_year;

		#2006: 10000

# 5. Using the film table, find out for each rating how many films were there.

select rating, count(film_id) as film_by_rating
from film
group by rating;

	# R, 195
	# PG-13, 223
	# PG, 194
	# NC-17, 210
	# G, 178


# 6. What is the average length of films for each rating? Round off the average lengths to two decimal places.

select rating, round(avg(length), 2) as length_average
from film
group by rating;

	# PG, 112.01
	# G, 111.05
	# NC-17, 113.23
	# PG-13, 120.44
	# R, 118.66


# 7. Which kind of movies (based on rating) have an average duration of two hours or more?

select rating, round(avg(length), 2) as length_longer_2_hours
from film
group by rating

	# PG-13, 120.44
having length_longer_2_hours > 120;

