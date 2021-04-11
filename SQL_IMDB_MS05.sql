USE imdb;

/* Now that you have imported the data sets, let’s explore some of the tables. 
 To begin with, it is beneficial to know the shape of the tables and whether any column has null values.
 Further in this segment, you will take a look at 'movies' and 'genre' tables.*/



-- Segment 1:




-- Q1. Find the total number of rows in each table of the schema?
-- Type your code below:

USE imdb 

SELECT 
	COUNT(*) as CountOfRow_tab1 
FROM director_mapping;     

#answer 3867 

SELECT 
	COUNT(*) as CountOfRow_tab2
FROM genre;   

#answer 14662

SELECT 
	COUNT(*) as CountOfRow_tab3 
FROM movie;  

#answer 7997

SELECT 
	COUNT(*) as CountOfRow_tab4
FROM names;  

#answer 25735

SELECT 
	COUNT(*) as CountOfRow_tab5
FROM ratings;  

#answer 7997 

SELECT 
	COUNT(*) as CountOfRow_tab6
FROM role_mapping;  

#answer 15615

-- Q2. Which columns in the movie table have null values?
-- Type your code below:

 

select 
count(*) - count(movie_id) as 'Null', 
count(movie_id) as 'Not Null' from director_mapping;

#answer 0 nulls 

select 
count(*) - count(name_id) as 'Null', 
count(name_id) as 'Not Null' from director_mapping;

#answer 0 nulls 



select 
count(*) - count(genre) as 'Null', 
count(genre) as 'Not Null' from genre;

#answer 0 nulls 



select 
count(*) - count(title) as 'Null', 
count(title) as 'Not Null' from movie;

#answer 0 nulls  

select 
count(*) - count(year) as 'Null', 
count(year) as 'Not Null' from movie;

#answer 0 nulls  


select 
count(*) - count(date_published) as 'Null', 
count(date_published) as 'Not Null' from movie;

#answer 0 nulls  


select 
count(*) - count(duration) as 'Null', 
count(duration) as 'Not Null' from movie;

#answer 0 nulls  


select 
count(*) - count(country) as 'Null', 
count(country) as 'Not Null' from movie;

#answer 20 nulls  


select 
count(*) - count(worlwide_gross_income) as 'Null', 
count(worlwide_gross_income) as 'Not Null' from movie;

#answer 3724 nulls  

select 
count(*) - count(languages) as 'Null', 
count(languages) as 'Not Null' from movie;

#answer 194 nulls  


select 
count(*) - count(production_company) as 'Null', 
count(production_company) as 'Not Null' from movie;

#answer 528 nulls  




-- Now as you can see four columns of the movie table has null values. Let's look at the at the movies released each year. 
-- Q3. Find the total number of movies released each year? How does the trend look month wise? (Output expected)

/* Output format for the first part:

+---------------+-------------------+
| Year			|	number_of_movies|
+-------------------+----------------
|	2017		|	2134			|
|	2018		|		.			|
|	2019		|		.			|
+---------------+-------------------+



Output format for the second part of the question:
+---------------+-------------------+
|	month_num	|	number_of_movies|
+---------------+----------------
|	1			|	 134			|
|	2			|	 231			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:


select 
	year as Year,
    COUNT(title) as number_of_movies
from movie
group by 
	year
order by 
	year desc;     


select 
	MONTH(date_published) as month_num,
    COUNT(title) as number_of_movies
from movie
group by 
	MONTH(date_published)
order by 
	MONTH(date_published) ,
    COUNT(title) desc;  



/*The highest number of movies is produced in the month of March.
So, now that you have understood the month-wise trend of movies, let’s take a look at the other details in the movies table. 
We know USA and India produces huge number of movies each year. Lets find the number of movies produced by USA or India for the last year.*/
  
-- Q4. How many movies were produced in the USA or India in the year 2019??
-- Type your code below:

select 
	count(year(date_published)) as NoOfMovies, 
    country,
    year as YearPublished
from 
	movie 
where 
	year(date_published)='2019'  
group by 
	country,
    year
having 
	country like '%India%' or country like '%USA%'; 	
		


/* USA and India produced more than a thousand movies(you know the exact number!) in the year 2019.
Exploring table Genre would be fun!! 
Let’s find out the different genres in the dataset.*/

-- Q5. Find the unique list of the genres present in the data set?
-- Type your code below:

select count(distinct(genre)) as NoOfUniqueGenres
from genre 

# answer - 13 


/* So, RSVP Movies plans to make a movie of one of these genres.
Now, wouldn’t you want to know which genre had the highest number of movies produced in the last year?
Combining both the movie and genres table can give more interesting insights. */

-- Q6.Which genre had the highest number of movies produced overall?
-- Type your code below:

select 
	count(id) as NoOfMovies, 
    genre as GenreName
from 
	movie as m
inner join 
	genre as g
on 
	m.id=g.movie_id 
group by 
	genre
order by 
	NoOfMovies desc;  

#answer - genre drama 4285
		
/* So, based on the insight that you just drew, RSVP Movies should focus on the ‘Drama’ genre. 
But wait, it is too early to decide. A movie can belong to two or more genres. 
So, let’s find out the count of movies that belong to only one genre.*/

-- Q7. How many movies belong to only one genre?
-- Type your code below:
SELECT 
    COUNT(*) AS singleGenre
FROM
    (SELECT 
        movie_id
    FROM
        genre
    GROUP BY movie_id
    HAVING COUNT(DISTINCT genre) = 1) AS T;    
    
    
/* There are more than three thousand movies which has only one genre associated with them.
So, this figure appears significant. 
Now, let's find out the possible duration of RSVP Movies’ next project.*/

-- Q8.What is the average duration of movies in each genre? 
-- (Note: The same movie can belong to multiple genres.)


/* Output format:

+---------------+-------------------+
| genre			|	avg_duration	|
+-------------------+----------------
|	thriller	|		105			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:



select 
	genre as genre,
    round(avg(duration),2) as AvgDuration
from 
	genre as g 
inner join
	movie as m 
on 
	g.movie_id=m.id 
group by 
	genre
order by 
	round(avg(duration),2) DESC ;  	



/* Now you know, movies of genre 'Drama' (produced highest in number in 2019) has the average duration of 106.77 mins.
Lets find where the movies of genre 'thriller' on the basis of number of movies.*/

-- Q9.What is the rank of the ‘thriller’ genre of movies among all the genres in terms of number of movies produced? 
-- (Hint: Use the Rank function)


/* Output format:
+---------------+-------------------+---------------------+
| genre			|		movie_count	|		genre_rank    |	
+---------------+-------------------+---------------------+
|drama			|	2312			|			2		  |
+---------------+-------------------+---------------------+*/
-- Type your code below:


select 
	genre, 
    count(movie_id) as movie_count, 
    rank() over(order by genre desc) as genre_rank 

from
	genre
where 
	genre='thriller';	



#answer - rank 1 

/*Thriller movies is in top 3 among all genres in terms of number of movies
 In the previous segment, you analysed the movies and genres tables. 
 In this segment, you will analyse the ratings table as well.
To start with lets get the min and max values of different columns in the table*/


SELECT
  
  min(avg_rating) as minA,
  max(avg_rating) as maxA,
  min(total_votes) as minB,
  max(total_votes) as maxB,
  min(median_rating) as minC,
  max(median_rating) as maxC

FROM
  ratings;
  
  
-- Segment 2:




-- Q10.  Find the minimum and maximum values in  each column of the ratings table except the movie_id column?
/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+
| min_avg_rating|	max_avg_rating	|	min_total_votes   |	max_total_votes 	 |min_median_rating|min_median_rating|
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+
|		0		|			5		|	       177		  |	   2000	    		 |		0	       |	8			 |
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+*/
-- Type your code below:


SELECT
  
  min(avg_rating) as min_avg_rating,
  max(avg_rating) as max_avg_rating,
  min(total_votes) as min_total_votes,
  max(total_votes) as max_total_votes,
  min(median_rating) as min_median_rating,
  max(median_rating) as max_median_rating

FROM
  ratings;



    

/* So, the minimum and maximum values in each column of the ratings table are in the expected range. 
This implies there are no outliers in the table. 
Now, let’s find out the top 10 movies based on average rating.*/

-- Q11. Which are the top 10 movies based on average rating?
/* Output format:
+---------------+-------------------+---------------------+
| title			|		avg_rating	|		movie_rank    |
+---------------+-------------------+---------------------+
| Fan			|		9.6			|			5	  	  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
+---------------+-------------------+---------------------+*/
-- Type your code below:
-- It's ok if RANK() or DENSE_RANK() is used too


select 
	title as title, 
    avg_rating as avg_rating, 
    dense_rank() over(order by avg_rating desc) as movie_drank 
from
	movie as m
inner join 
    ratings as r
on 
	m.id=r.movie_id	
group by 
	avg_rating, 
    title
order by 
	movie_drank asc; 
    


/* Do you find you favourite movie FAN in the top 10 movies with an average rating of 9.6? If not, please check your code again!!
So, now that you know the top 10 movies, do you think character actors and filler actors can be from these movies?
Summarising the ratings table based on the movie counts by median rating can give an excellent insight.*/

-- Q12. Summarise the ratings table based on the movie counts by median ratings.
/* Output format:

+---------------+-------------------+
| median_rating	|	movie_count		|
+-------------------+----------------
|	1			|		105			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:
-- Order by is good to have

select 
	
    median_rating as median_rating, 
    COUNT(movie_id) as movie_count 
from 
	ratings
group by 
	median_rating
order by 
	median_rating desc;  



/* Movies with a median rating of 7 is highest in number. 
Now, let's find out the production house with which RSVP Movies can partner for its next project.*/

-- Q13. Which production house has produced the most number of hit movies (average rating > 8)??
/* Output format:
+------------------+-------------------+---------------------+
|production_company|movie_count	       |	prod_company_rank|
+------------------+-------------------+---------------------+
| The Archers	   |		1		   |			1	  	 |
+------------------+-------------------+---------------------+*/
-- Type your code below:


with ghf as 
 (select 
	m.production_company,
    count(m.id) as movie_count, 
    row_number() OVER (ORDER BY count(m.id) DESC) AS prod_company_rank
 from 
	movie as m
left join 
	ratings as r
on 
	m.id=r.movie_id
where 
	avg_rating>8 and production_company is not null
 group by 
	m.production_company) 
select *
from ghf
limit 1;   
 
 


-- It's ok if RANK() or DENSE_RANK() is used too
-- Answer can be Dream Warrior Pictures or National Theatre Live or both

-- Q14. How many movies released in each genre during March 2017 in the USA had more than 1,000 votes?
/* Output format:

+---------------+-------------------+
| genre			|	movie_count		|
+-------------------+----------------
|	thriller	|		105			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:

select 
	genre, 
	count(title) as movie_count
from 
	movie as m 
inner join 
	genre as g 	
on 
	m.id=g.movie_id 
inner join 
	ratings as r
on 
	m.id=r.movie_id
   
where
	country like lower('%USA%') and MONTH(date_published)=3 and YEAR(date_published)=2017 and total_votes>1000
group by 
	genre
order by 
	count(title) desc; 




-- Lets try to analyse with a unique problem statement.
-- Q15. Find movies of each genre that start with the word ‘The’ and which have an average rating > 8?
/* Output format:
+---------------+-------------------+---------------------+
| title			|		avg_rating	|		genre	      |
+---------------+-------------------+---------------------+
| Theeran		|		8.3			|		Thriller	  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
+---------------+-------------------+---------------------+*/
-- Type your code below:


select 
	title,
    genre,  
    avg_rating
from 
	movie as m 
inner join 
	genre as g 	
on 
	m.id=g.movie_id 
inner join 
	ratings as r
on 
	m.id=r.movie_id    
where 
	title like 'The%' and avg_rating>8; 



-- You should also try your hand at median rating and check whether the ‘median rating’ column gives any significant insights.
-- Q16. Of the movies released between 1 April 2018 and 1 April 2019, how many were given a median rating of 8?
-- Type your code below:

with ght as 
(select 
	count(title) as NoOfTitles,
    date_published,
    median_rating
from 
	movie as m 
inner join 
	ratings as r
on 
	m.id=r.movie_id    
where 
	median_rating=8
group by 
	
	date_published, 
    median_rating
having 
	date_published between '2018-04-01' AND  '2019-04-01' 	
order by
	median_rating desc)
    
select sum(NoOfTitles)  
from ght 



-- Once again, try to solve the problem given below.
-- Q17. Do German movies get more votes than Italian movies? 
-- Hint: Here you have to find the total number of votes for both German and Italian movies.
-- Type your code below:


select 
	sum(total_votes) as TotalVot,
    country
from 
	movie as m 
inner join 
	ratings as r
on 
	m.id=r.movie_id
where
	country='Germany' or country='Italy'
group by
	country	;   



-- Answer is Yes

/* Now that you have analysed the movies, genres and ratings tables, let us now analyse another table, the names table. 
Let’s begin by searching for null values in the tables.*/




-- Segment 3:



-- Q18. Which columns in the names table have null values??
/*Hint: You can find null values for individual columns or follow below output format
+---------------+-------------------+---------------------+----------------------+
| name_nulls	|	height_nulls	|date_of_birth_nulls  |known_for_movies_nulls|
+---------------+-------------------+---------------------+----------------------+
|		0		|			123		|	       1234		  |	   12345	    	 |
+---------------+-------------------+---------------------+----------------------+*/
-- Type your code below:

select 
count(*) - count(name) as 'name_nulls', 
count(*) - count(height) as 'height_nulls', 
count(*) - count(date_of_birth) as 'date_of_birth_nulls', 
count(*) - count(known_for_movies) as 'known_for_movies_nulls'
from 
	names; 


/* There are no Null value in the column 'name'.
The director is the most important person in a movie crew. 
Let’s find out the top three directors in the top three genres who can be hired by RSVP Movies.*/

-- Q19. Who are the top three directors in the top three genres whose movies have an average rating > 8?
-- (Hint: The top three genres would have the most number of movies with an average rating > 8.)
/* Output format:

+---------------+-------------------+
| director_name	|	movie_count		|
+---------------+-------------------|
|James Mangold	|		4			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:


with dir_summ as 

(select 
	n.name as director_name,
    count(m.id) as movie_count,
    g.genre as genre 
from 
	names as n 
inner join     
	director_mapping as dm
on 
	n.id=dm.name_id
inner join     
	movie as m
on 
	dm.movie_id=m.id	
inner join
	ratings as r 
on
	m.id=r.movie_id 
inner join 
	genre as g 
on 
	m.id=g.movie_id 	
where 
	avg_rating>=8 
group by 
		director_name,
        genre 
order by 
		count(m.id) desc)

select 
	director_name, 
    movie_count
from 
	dir_summ
where 
	genre='Drama'  or  genre='Comedy' or genre='Thriller'; 


/* James Mangold can be hired as the director for RSVP's next project. Do you remeber his movies, 'Logan' and 'The Wolverine'. 
Now, let’s find out the top two actors.*/

-- Q20. Who are the top two actors whose movies have a median rating >= 8?
/* Output format:

+---------------+-------------------+
| actor_name	|	movie_count		|
+-------------------+----------------
|Christain Bale	|		10			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:


select 
	n.name as actor_name,
    count(m.id) as movie_count
from 
	names as n 
inner join     
	role_mapping as rm
on 
	n.id=rm.name_id
inner join     
	movie as m
on 
	rm.movie_id=m.id	
inner join
	ratings as r 
on
	m.id=r.movie_id 
where 
	median_rating>=8 and category='actor'
group by 
		actor_name
order by 
		count(m.id) desc;
        
  


/* Have you find your favourite actor 'Mohanlal' in the list. If no, please check your code again. 
RSVP Movies plans to partner with other global production houses. 
Let’s find out the top three production houses in the world.*/

-- Q21. Which are the top three production houses based on the number of votes received by their movies?
/* Output format:
+------------------+--------------------+---------------------+
|production_company|vote_count			|		prod_comp_rank|
+------------------+--------------------+---------------------+
| The Archers		|		830			|		1	  		  |
|	.				|		.			|			.		  |
|	.				|		.			|			.		  |
+-------------------+-------------------+---------------------+*/
-- Type your code below:

select 
	production_company,
    total_votes as vote_count,  
	DENSE_RANK() OVER(ORDER BY(total_votes) DESC) AS prod_comp_rank 

from 
	movie as m 
inner join 
	ratings as r
on 
	m.id=r.movie_id; 


/*Yes Marvel Studios rules the movie world.
So, these are the top three production houses based on the number of votes received by the movies they have produced.

Since RSVP Movies is based out of Mumbai, India also wants to woo its local audience. 
RSVP Movies also wants to hire a few Indian actors for its upcoming project to give a regional feel. 
Let’s find who these actors could be.*/

-- Q22. Rank actors with movies released in India based on their average ratings. Which actor is at the top of the list?
-- Note: The actor should have acted in at least five Indian movies. 
-- (Hint: You should use the weighted average based on votes. If the ratings clash, then the total number of votes should act as the tie breaker.)

/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actor_name	|	total_votes		|	movie_count		  |	actor_avg_rating 	 |actor_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Yogi Babu	|			3455	|	       11		  |	   8.42	    		 |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:
use imdb 


WITH actor_dets as 

(select 
	n.name as actor_name,
    count(m.id) as movie_count,
    m.country as country_rel,
    SUM(r.total_votes) as total_votes,
    sum(r.avg_rating), 
    cast(sum(r.avg_rating * r.total_votes) / sum(r.total_votes) as decimal(8, 2)) as actor_avg_rating
    
from 
	names as n 
inner join     
	role_mapping as rm
on 
	n.id=rm.name_id
inner join     
	movie as m
on 
	rm.movie_id=m.id	
inner join
	ratings as r 
on
	m.id=r.movie_id 
where 
	category='actor'  
group by 
		actor_name,
        country
having 
	country like '%India%'
order by 
		count(m.id) desc)

select 
	actor_name, 
    total_votes, 
    movie_count,
    actor_avg_rating,
    DENSE_RANK() OVER(ORDER BY(actor_avg_rating) DESC) AS actor_rank
    
from 
	actor_dets
order by 
	actor_rank; 




-- Top actor is Vijay Sethupathi

-- Q23.Find out the top five actresses in Hindi movies released in India based on their average ratings? 
-- Note: The actresses should have acted in at least three Indian movies. 
-- (Hint: You should use the weighted average based on votes. If the ratings clash, then the total number of votes should act as the tie breaker.)
/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actress_name	|	total_votes		|	movie_count		  |	actress_avg_rating 	 |actress_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Tabu		|			3455	|	       11		  |	   8.42	    		 |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:


WITH actress_ratings AS
(
SELECT 
	n.name as actress_name,
    SUM(r.total_votes) AS total_votes,
    COUNT(m.id) as movie_count,
	ROUND(
		SUM(r.avg_rating*r.total_votes)
        /
		SUM(r.total_votes)
			,2) AS actress_avg_rating
FROM
	names AS n
		INNER JOIN
	role_mapping AS a
		ON n.id=a.name_id
			INNER JOIN
        movie AS m
			ON a.movie_id = m.id
				INNER JOIN
            ratings AS r
				ON m.id=r.movie_id
WHERE category = 'actress' AND LOWER(languages) like '%hindi%'
GROUP BY actress_name
)
SELECT *,
	ROW_NUMBER() OVER (ORDER BY actress_avg_rating DESC, total_votes DESC) AS actress_rank
FROM
	actress_ratings
WHERE movie_count>=3
LIMIT 5;




/* Taapsee Pannu tops with average rating 7.74. 
Now let us divide all the thriller movies in the following categories and find out their numbers.*/


/* Q24. Select thriller movies as per avg rating and classify them in the following category: 

			Rating > 8: Superhit movies
			Rating between 7 and 8: Hit movies
			Rating between 5 and 7: One-time-watch movies
			Rating < 5: Flop movies
--------------------------------------------------------------------------------------------*/
-- Type your code below:

       
WITH xyz AS 
	(select 
		title as movie_name, 
		genre as genre, 
		avg_rating as rating 
	from 
		movie as m 
	inner join 
		genre as g 
	on 
		m.id=g.movie_id 
	inner join 
		ratings as r 
	on 
		m.id=r.movie_id) 

	SELECT *,  
	CASE
	WHEN rating  > 8 THEN 'superhit'
	WHEN rating >7 and rating<8 THEN 'hitmovies' 
	WHEN rating >6 and rating<7  THEN 'One-time-watch movies'
	ELSE 'flopmovies'
	END as label
	from xyz;  



/* Until now, you have analysed various tables of the data set. 
Now, you will perform some tasks that will give you a broader understanding of the data in this segment.*/

-- Segment 4:

-- Q25. What is the genre-wise running total and moving average of the average movie duration? 
-- (Note: You need to show the output table in the question.) 
/* Output format:
+---------------+-------------------+---------------------+----------------------+
| genre			|	avg_duration	|running_total_duration|moving_avg_duration  |
+---------------+-------------------+---------------------+----------------------+
|	comdy		|			145		|	       106.2	  |	   128.42	    	 |
|		.		|			.		|	       .		  |	   .	    		 |
|		.		|			.		|	       .		  |	   .	    		 |
|		.		|			.		|	       .		  |	   .	    		 |
+---------------+-------------------+---------------------+----------------------+*/
-- Type your code below:

WITH genre_details AS 

(select 
	genre, 
    avg(duration) as  avg_duration 
from 
	movie as m
inner join 
	genre as g 
on 
	m.id=g.movie_id 
group by 
	genre)	

select *, 
	SUM(avg_duration)  over w1 as running_total_duration, 
	AVG(avg_duration) over w2 as moving_avg_duration

from genre_details
window w1 as (order by genre rows unbounded preceding),   
w2 as (order by genre rows 6 preceding);     



-- Round is good to have and not a must have; Same thing applies to sorting


-- Let us find top 5 movies of each year with top 3 genres.

-- Q26. Which are the five highest-grossing movies of each year that belong to the top three genres? 
-- (Note: The top 3 genres would have the most number of movies.)

/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| genre			|	year			|	movie_name		  |worldwide_gross_income|movie_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	comedy		|			2017	|	       indian	  |	   $103244842	     |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:

-- Top 3 Genres based on most number of movies

WITH top_genres as 
    
(select 
	genre,
    count(m.id) as movie_count,
    RANK() OVER(ORDER BY(count(m.id)) DESC) AS genre_rank
 from 
	genre as g 
 left join 
	movie as m 
 on 
	g.movie_id=m.id 
 group by 
	genre)
    , 
    
 top_grossing as 
 
 (select 
		g.genre,
        m.year,
        m.title as movie_name,
        m.worlwide_gross_income,
        rank() over (partition by g.genre,year) as movie_rank
        
        
	from 
		movie as m 
	inner join 
		genre as g
	on 	
		g.movie_id=m.id
	where 
 		
        g.genre='Thriller' or g.genre='Drama' or g.genre='Comedy' )
    
    
 select *
 from 
	top_grossing
 where 
	movie_rank<=5 and worlwide_gross_income is not null; 
 


-- Finally, let’s find out the names of the top two production houses that have produced the highest number of hits among multilingual movies.
-- Q27.  Which are the top two production houses that have produced the highest number of hits (median rating >= 8) among multilingual movies?
/* Output format:
+-------------------+-------------------+---------------------+
|production_company |movie_count		|		prod_comp_rank|
+-------------------+-------------------+---------------------+
| The Archers		|		830			|		1	  		  |
|	.				|		.			|			.		  |
|	.				|		.			|			.		  |
+-------------------+-------------------+---------------------+*/
-- Type your code below:

WITH top_prod AS
(
SELECT 
    m.production_company,
    COUNT(m.id) AS movie_count,
    ROW_NUMBER() OVER (ORDER BY COUNT(m.id) DESC) AS prod_company_rank
FROM
    movie AS m
        LEFT JOIN
    ratings AS r
		ON m.id = r.movie_id
WHERE median_rating>=8 AND m.production_company IS NOT NULL AND POSITION(',' IN languages)>0
GROUP BY m.production_company
)
SELECT 
    *
FROM
    top_prod
WHERE
    prod_company_rank <= 2;


	

-- Multilingual is the important piece in the above question. It was created using POSITION(',' IN languages)>0 logic
-- If there is a comma, that means the movie is of more than one language


-- Q28. Who are the top 3 actresses based on number of Super Hit movies (average rating >8) in drama genre?
/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actress_name	|	total_votes		|	movie_count		  |actress_avg_rating	 |actress_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Laura Dern	|			1016	|	       1		  |	   9.60			     |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:

use imdb 

WITH actress_ratings AS
(
SELECT 
	n.name as actress_name,
    SUM(r.total_votes) AS total_votes,
    COUNT(m.id) as movie_count,
	ROUND(
		SUM(r.avg_rating*r.total_votes)
        /
		SUM(r.total_votes)
			,2) AS actress_avg_rating
FROM
	names AS n
		INNER JOIN
	role_mapping AS a
		ON n.id=a.name_id
			INNER JOIN
        movie AS m
			ON a.movie_id = m.id
				INNER JOIN
            ratings AS r
				ON m.id=r.movie_id
					INNER JOIN
				genre AS g
				ON m.id=g.movie_id
WHERE category = 'actress' AND lower(g.genre) ='drama'
GROUP BY actress_name
)
SELECT *,
	ROW_NUMBER() OVER (ORDER BY actress_avg_rating DESC, total_votes DESC) AS actress_rank
FROM
	actress_ratings
LIMIT 3;

SELECT 
	n.name as actress_name,
    SUM(r.total_votes) AS total_votes,
    COUNT(m.id) as movie_count,
	ROUND(
		SUM(r.avg_rating*r.total_votes)
        /
		SUM(r.total_votes)
			,2) AS actress_avg_rating
FROM
	names AS n
		INNER JOIN
	role_mapping AS a
		ON n.id=a.name_id
			INNER JOIN
        movie AS m
			ON a.movie_id = m.id
				INNER JOIN
            ratings AS r
				ON m.id=r.movie_id
					INNER JOIN
				genre AS g
				ON m.id=g.movie_id
WHERE category = 'actress' AND lower(g.genre) ='drama'
GROUP BY actress_name;



/* Q29. Get the following details for top 9 directors (based on number of movies)
Director id
Name
Number of movies
Average inter movie duration in days
Average movie ratings
Total votes
Min rating
Max rating
total movie durations

Format:
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+
| director_id	|	director_name	|	number_of_movies  |	avg_inter_movie_days |	avg_rating	| total_votes  | min_rating	| max_rating | total_duration |
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+
|nm1777967		|	A.L. Vijay		|			5		  |	       177			 |	   5.65	    |	1754	   |	3.7		|	6.9		 |		613		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+

--------------------------------------------------------------------------------------------*/
-- Type you code below:


WITH top_directors AS
(
SELECT 
	n.id as director_id,
    n.name as director_name,
	COUNT(m.id) AS movie_count,
    RANK() OVER (ORDER BY COUNT(m.id) DESC) as director_rank
FROM
	names AS n
		INNER JOIN
	director_mapping AS d
		ON n.id=d.name_id
			INNER JOIN
        movie AS m
			ON d.movie_id = m.id
GROUP BY n.id
),
movie_summary AS
(
SELECT
	n.id as director_id,
    n.name as director_name,
    m.id AS movie_id,
    m.date_published,
	r.avg_rating,
    r.total_votes,
    m.duration,
    LEAD(date_published) OVER (PARTITION BY n.id ORDER BY m.date_published) AS next_date_published,
    DATEDIFF(LEAD(date_published) OVER (PARTITION BY n.id ORDER BY m.date_published),date_published) AS inter_movie_days
FROM
	names AS n
		INNER JOIN
	director_mapping AS d
		ON n.id=d.name_id
			INNER JOIN
        movie AS m
			ON d.movie_id = m.id
				INNER JOIN
            ratings AS r
				ON m.id=r.movie_id
WHERE n.id IN (SELECT director_id FROM top_directors WHERE director_rank<=9)
)
SELECT 
	director_id,
	director_name,
	COUNT(DISTINCT movie_id) as number_of_movies,
	ROUND(AVG(inter_movie_days),0) AS avg_inter_movie_days,
	ROUND(
	SUM(avg_rating*total_votes)
	/
	SUM(total_votes)
		,2) AS avg_rating,
    SUM(total_votes) AS total_votes,
    MIN(avg_rating) AS min_rating,
    MAX(avg_rating) AS max_rating,
    SUM(duration) AS total_duration
FROM 
movie_summary
GROUP BY director_id
ORDER BY number_of_movies DESC, avg_rating DESC;




