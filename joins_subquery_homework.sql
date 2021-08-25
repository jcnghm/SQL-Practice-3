-- Question 1: List all customers who live in Texas (use JOINs)
SELECT first_name, last_name, address.district
FROM customer
FULL JOIN address
ON customer.address_id = address.address_id
WHERE address.district = 'Texas';

-- Bonus: Which customer lives in Dallas?
SELECT first_name, last_name, city.city
FROM customer
FULL JOIN address
ON customer.address_id = address.address_id
FULL JOIN city
ON address.city_id = city.city_id
WHERE city.city = 'Dallas';


-- Question 2: Get all payments above $6.99 with the Customer's Full Name
-- Payments with full names
SELECT first_name, last_name, payment.amount
FROM customer
FULL JOIN payment
ON customer.customer_id = payment.customer_id
WHERE payment.amount > 6.99;

-- Count of payments
SELECT COUNT(amount)
FROM customer
FULL JOIN payment
ON customer.customer_id = payment.customer_id
WHERE payment.amount > 6.99;


-- Question 3: Show all customers names who have made payments over $175(use subqueries)
SELECT first_name, last_name, SUM(payment.amount)
FROM customer
FULL JOIN payment
ON customer.customer_id = payment.customer_id
WHERE customer.customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
)
GROUP BY first_name, last_name
ORDER BY SUM(payment.amount) DESC;


-- Question 4: List all customers that live in Nepal (use the city table)
SELECT first_name, last_name, country.country
FROM customer
FULL JOIN address
ON customer.address_id = address.address_id
FULL JOIN city
ON address.city_id = city.city_id
FULL JOIN country
ON city.country_id = country.country_id
WHERE country.country = 'Nepal';


-- Question 5: Which staff member had the most transactions?
SELECT first_name, last_name, COUNT(payment.amount)
FROM staff
FULL JOIN payment
ON staff.staff_id = payment.staff_id
GROUP BY staff.first_name, staff.last_name
ORDER BY COUNT(payment.amount) DESC;


-- Question 6: How many movies of each rating are there?
SELECT rating, COUNT(title)
FROM film
GROUP BY rating
ORDER BY COUNT(title) DESC;


-- Question 7: Show all customers who have made a single payment above $6.99 (Use Subqueries)
SELECT first_name, last_name
FROM customer
FULL JOIN payment
ON customer.customer_id = payment.customer_id
WHERE payment.amount IN (
	SELECT payment.amount
	FROM payment
	WHERE payment.amount > 6.99
	GROUP BY payment.amount
)
GROUP BY first_name, last_name
HAVING COUNT(amount) = 1;


--Question 8: How many free rentals did our stores give away?
SELECT COUNT(amount) AS num_free_rental
FROM payment
WHERE amount = 0.00;




