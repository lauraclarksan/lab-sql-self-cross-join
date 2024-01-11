-- Lab 3 Unit 3
-- 1. Get all pairs of actors that worked together
select * from disp;

select * from sakila.film_actor f1
join sakila.film_actor f2
on f1.actor_id = f2.actor_id
and f1.film_id < f2.film_id;

-- 2. Get all pairs of customers that have rented the same film more than 3 times
create temporary table inventory_and_rental as
select a.rental_id, a.inventory_id, a.customer_id, b.film_id from sakila.rental as a
join sakila.inventory as b
on a.inventory_id = b.inventory_id;

-- had to create subqueries because I kept getting the Error Code: 1137. Can't reopen table 'a'

select a.customer_id as customer1, b.customer_id as customer2, a.film_id from (select a.rental_id, a.inventory_id, a.customer_id, b.film_id from sakila.rental as a
join sakila.inventory as b
on a.inventory_id = b.inventory_id) as a
join (select a.rental_id, a.inventory_id, a.customer_id, b.film_id from sakila.rental as a
join sakila.inventory as b
on a.inventory_id = b.inventory_id) as b
on a.film_id = b.film_id
and a.customer_id < b.customer_id
group by customer1, customer2, a.film_id
having count(a.rental_id) > 3;

-- 3. Get all possible pairs of actors and films
create temporary table actor_list
select distinct actor_id from sakila.actor;

create temporary table film_list
select distinct film_id from sakila.film;

select * from actor_list
cross join film_list;