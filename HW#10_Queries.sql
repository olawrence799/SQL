use sakila;

# 1a)
select first_name, last_name
from actor;

# 1b)
alter table actor
add `Actor Name` varchar(255) after last_update;
update actor set `Actor Name` = concat(first_name, ' ',last_name);

# 2a)
select actor_id, first_name, last_name
from actor
where first_name = 'Joe';

# 2b)
select `Actor Name` from actor where last_name like '%GEN%';

# 2c)
select `Actor Name` from actor where last_name like '%LI%'
order by last_name, first_name;

# 2d)
select country_id, country
from country
where country in ('Afghanistan', 'Bangladesh', 'China');

# 3a)
alter table actor
add middle_name varchar(255) after first_name;

# 3b)
alter table actor modify column middle_name blob;

# 3c)
alter table actor drop middle_name;

# 4a)
select last_name, count(last_name) from actor
group by last_name;

# 4b)
select last_name, count(last_name) from actor
group by last_name
having count(last_name) >= 2;

# 4c)
update actor
set first_name = 'HARPO'
where first_name = 'Groucho'
and last_name = 'Williams';
update actor set `Actor Name` = concat(first_name, ' ',last_name);

# 4d)
update actor
set first_name = case when first_name = 'HARPO' then 'GROUCHO' else 'MUCHO GROUCHO' end
where actor_id = 172;

# 5a)
show create table address;

# 6a)
select s.staff_id, s.first_name, s.last_name, a.address
from staff s
join address a
on s.address_id = a.address_id;

# 6b)
select s.staff_id, s.first_name, s.last_name, sum(p.amount) as 'total amount rung up'
from staff s
join payment p
on s.staff_id = p.staff_id
where year(p.payment_date) = '2005'
and month(p.payment_date) = '8'
group by s.staff_id;

# 6c)
select f.film_id, f.title, count(fa.actor_id) as 'Number of Actors'
from film f
inner join film_actor fa
on f.film_id = fa.film_id
group by f.film_id;

# 6d)
select f.title, count(f.title) as 'Number of Copies'
from inventory i
join film f
on i.film_id = f.film_id
where f.title = 'Hunchback Impossible'
group by f.title;

# 6e)
select c.first_name, c.last_name, sum(p.amount) as 'Total Paid'
from payment p
join customer c
on p.customer_id = c.customer_id
group by c.last_name, c.first_name
order by c.last_name;

# 7a)
select title
from film
where title like 'K%' or title like 'Q%'
and language_id in
 (
 select language_id
 from language
 where name = 'English'
 );
 
# 7b)
select `Actor Name`
from actor
where actor_id in
 (
 select actor_id
 from film_actor
 where film_id in
  (select film_id
  from film
  where title = 'Alone Trip'
  )
 );

# 7c)
select c.first_name, c.last_name, c.email
from customer c
join address a
on c.address_id = a.address_id
join city i
on a.city_id = i.city_id
join country n
on i.country_id = n.country_id
where n.country = 'Canada';

# 7d)
select f.title, c.name as 'Category Name'
from film f
join film_category fc
on f.film_id = fc.film_id
join category c
on fc.category_id = c.category_id
where name = 'Family';

# 7e)
select f.title, count(i.inventory_id) as 'Rentals'
from film f
join inventory i
on f.film_id = i.film_id
join rental r
on i.inventory_id = r.inventory_id
group by f.title
order by Rentals desc;

# 7f)
select s.store_id, sum(p.amount) as 'Total Payments ($)'
from payment p
left join staff s
on p.staff_id = s.staff_id
group by s.store_id;

# 7g)
select s.store_id, c.city, n.country
from store s
left join address a
on s.address_id = a.address_id
left join city c
on a.city_id = c.city_id
left join country n
on c.country_id = n.country_id;

# 7h)
select c.name, sum(p.amount) as 'Total Gross Revenue'
from rental r
join payment p
on r.rental_id = p.rental_id
join inventory i
on r.inventory_id = i.inventory_id
join film_category fc
on i.film_id = fc.film_id
join category c
on fc.category_id = c.category_id
group by c.name
order by sum(p.amount) desc limit 5;

# 8a)
create view Top_5_Genres as
select c.name, sum(p.amount) as 'Total Gross Revenue'
from rental r
join payment p
on r.rental_id = p.rental_id
join inventory i
on r.inventory_id = i.inventory_id
join film_category fc
on i.film_id = fc.film_id
join category c
on fc.category_id = c.category_id
group by c.name
order by sum(p.amount) desc limit 5;

# 8b)
select * from Top_5_Genres;

# 8c)
drop view Top_5_Genres;