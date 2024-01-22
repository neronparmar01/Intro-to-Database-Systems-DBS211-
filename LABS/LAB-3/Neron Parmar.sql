

CREATE TABLE L5_MOVIES
(
m_id INT PRIMARY KEY NOT NULL,
title VARCHAR(35),
release_year INT NOT NULL,
dirctor INT NOT NULL ,
score DECIMAL(3,2) NOT NULL
);
 
CREATE TABLE L5_ACTORS
(
a_id INT PRIMARY KEY NOT NULL,
first_name VARCHAR(20) NOT NULL, 
last_name VARCHAR(30) NOT NULL
);

CREATE TABLE L5_CASTINGS
(
movie_id int,
actor_id int,
PRIMARY KEY(movie_id, actor_id),
CONSTRAINT FK_movies_actors FOREIGN KEY(actor_id) REFERENCES L5_ACTORS(a_id),
CONSTRAINT FK_movies_casting FOREIGN KEY (movie_id) REFERENCES L5_MOVIES(m_id)
);

CREATE TABLE L5_DIRECTORS
(
director_id INT PRIMARY KEY,
first_name VARCHAR(20) NOT NULL,
last_name VARCHAR(30) NOT NULL
);

ALTER TABLE L5_MOVIES
ADD CONSTRAINTS FK_movies
FOREIGN KEY () REFERENCES director(L5_DIRECTORS);