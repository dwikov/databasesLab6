explain analyze
SELECT film.film_id as film_id, film.title AS title, category.name AS category, film.rating AS rating
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
RIGHT JOIN film ON inventory.film_id = film.film_id
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON category.name = 'Horror' OR category.name = 'Sci-fi'
WHERE inventory.film_id is null AND (film.rating = 'PG-13' OR film.rating = 'R');

-- the most expensive step is the WHERE clause 
-- we can optimze it by adding hash index on the film.rating

explain analyze
select staff.store_id, city.city as city, SUM(amount) as Sum
from payment 
join staff on payment.staff_id = staff.staff_id
join address on staff.address_id = address.address_id
join city on city.city_id = address.city_id
where date_trunc('month',payment_date) = (select date_trunc('month',max(payment_date)) from payment)
group by staff.store_id, city.city
order by Sum desc

-- the most expensive step is 
-- where date_trunc('month',payment_date) = (select date_trunc('month',max(payment_date)) from payment)
-- we can optimize it by adding hash index on payment_date
