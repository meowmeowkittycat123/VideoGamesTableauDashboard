SELECT * FROM videogames.data;


#Replacing Blanks with NULLS
SELECT *
FROM videogames.data
WHERE Rating = '';

UPDATE videogames.data
SET Rating = NULL
WHERE Rating = '';

SELECT *
FROM videogames.data
WHERE (Genres = '[]' OR Genres = "")
   OR (Summary = '' OR Summary = "")
   OR (Reviews = '[]' OR Reviews = "");
   
UPDATE videogames.data
SET 
    Genres = NULL,
    Summary = NULL,
    Reviews = NULL,
    Release_Date_Cleaned = NULL
WHERE (Genres = '[]' OR Genres = "")
   OR (Summary = '' OR Summary = "")
   OR (Reviews = '[]' OR Reviews = "");


#Check Duplicates 

SELECT Title, Summary, Reviews, "Release Date", COUNT(*)
FROM videogames.data
GROUP BY Title, Summary, Reviews, "Release Date"
HAVING COUNT(*) >1;

SELECT *
FROM videogames.data
WHERE Title = "Elden Ring";

#Removing Duplicates

WITH CTE AS (
    SELECT 
        Title, 
        Summary, 
        Reviews,
        "Release Date",
        ROW_NUMBER() OVER (PARTITION BY Title, Summary, Reviews, "Release Date" ORDER BY Title) AS rn #unique sequential integer (rn) to each duplicate combination. eg. rn=1 for first occurance, rn =2 for second occurance
    FROM videogames.data
)
DELETE FROM videogames.data
WHERE (Title, Summary, Reviews, "Release Date" ) IN (SELECT Title, Summary, Reviews, "Release Date" 
FROM CTE
WHERE rn > 1);   # check for rows where rn >2 and delete

#Task 1 : What are the top Team of the most popular video games? 

SELECT genre, COUNT(*) AS genre_Count
FROM videogames.data
GROUP BY genre;

#Add Columns
ALTER TABLE videogames.data
ADD COLUMN genre1 VARCHAR(255),
ADD COLUMN genre2 VARCHAR(255),
ADD COLUMN genre3 VARCHAR(255),
ADD COLUMN genre4 VARCHAR(255),
ADD COLUMN genre5 VARCHAR(255);

#Split the values into each genre 
UPDATE videogames.data
SET 
    genre1 = TRIM(REPLACE(SUBSTRING_INDEX(Genres, ',', 1), '"', '')),
    genre2 = CASE 
                WHEN LENGTH(Genres) - LENGTH(REPLACE(Genres, ',', '')) >= 1 THEN TRIM(REPLACE(SUBSTRING_INDEX(SUBSTRING_INDEX(Genres, ',', 2), ',', -1), '"', ''))
                ELSE NULL 
             END,
    genre3 = CASE 
                WHEN LENGTH(Genres) - LENGTH(REPLACE(Genres, ',', '')) >= 2 THEN TRIM(REPLACE(SUBSTRING_INDEX(SUBSTRING_INDEX(Genres, ',', 3), ',', -1), '"', ''))
                ELSE NULL 
             END,
    genre4 = CASE 
                WHEN LENGTH(Genres) - LENGTH(REPLACE(Genres, ',', '')) >= 3 THEN TRIM(REPLACE(SUBSTRING_INDEX(SUBSTRING_INDEX(Genres, ',', 4), ',', -1), '"', ''))
                ELSE NULL 
             END,
    genre5 = CASE 
                WHEN LENGTH(Genres) - LENGTH(REPLACE(Genres, ',', '')) >= 4 THEN TRIM(REPLACE(SUBSTRING_INDEX(SUBSTRING_INDEX(Genres, ',', 5), ',', -1), '"', ''))
                ELSE NULL 
             END;
             

#Remove the square brackets and quotation marks 

UPDATE videogames.data
SET 
    genre1 = REPLACE(REPLACE(REPLACE(genre1, "'", ''), '[', ''), ']', ''),
    genre2 = CASE 
                WHEN genre2 IS NOT NULL THEN REPLACE(REPLACE(REPLACE(genre2, "'", ''), '[', ''), ']', '')
                ELSE NULL 
             END,
    genre3 = CASE 
                WHEN genre3 IS NOT NULL THEN REPLACE(REPLACE(REPLACE(genre3, "'", ''), '[', ''), ']', '')
                ELSE NULL 
             END,
    genre4 = CASE 
                WHEN genre4 IS NOT NULL THEN REPLACE(REPLACE(REPLACE(genre4, "'", ''), '[', ''), ']', '')
                ELSE NULL 
             END,
    genre5 = CASE 
                WHEN genre5 IS NOT NULL THEN REPLACE(REPLACE(REPLACE(genre5, "'", ''), '[', ''), ']', '')
                ELSE NULL 
             END;


#Count the Occurance of each genre, Create View
CREATE VIEW TopgenreReleased AS
SELECT Genres, COUNT(*) AS genre_count
FROM (
    SELECT genre1 AS Genres FROM videogames.data WHERE genre1 IS NOT NULL
    UNION ALL
    SELECT genre2 AS Genres FROM videogames.data WHERE genre2 IS NOT NULL
    UNION ALL
    SELECT genre3 AS Genres FROM videogames.data WHERE genre3 IS NOT NULL
    UNION ALL
    SELECT genre4 AS Genres FROM videogames.data WHERE genre4 IS NOT NULL
    UNION ALL
    SELECT genre5 AS Genres FROM videogames.data WHERE genre5 IS NOT NULL
) AS all_genre
GROUP BY Genres
ORDER BY genre_count desc;

#Task 2 : What are the top companies of the most popular video games? 

SELECT Team, COUNT(*) AS Team_Count
FROM videogames.data
GROUP BY Team;

#Setting Blanks in "Team" to NULL
SELECT *
FROM videogames.data
WHERE Team  = '';

UPDATE videogames.data
SET Team = NULL
WHERE Team = '';


#Add Columns (Because only at most 2 teams) 
ALTER TABLE videogames.data
ADD COLUMN team1 VARCHAR(255),
ADD COLUMN team2 VARCHAR(255);

#Split the values into each Team 
UPDATE videogames.data
SET 
    team1 = TRIM(REPLACE(SUBSTRING_INDEX(Team, ',', 1), '"', '')),
    team2 = CASE 
                WHEN LENGTH(Team) - LENGTH(REPLACE(Team, ',', '')) >= 1 THEN TRIM(REPLACE(SUBSTRING_INDEX(SUBSTRING_INDEX(Team, ',', 2), ',', -1), '"', ''))
                ELSE NULL 
             END;
             
#Remove the square brackets and quotation marks 

UPDATE videogames.data
SET 
    team1 = REPLACE(REPLACE(REPLACE(team1, "'", ''), '[', ''), ']', ''),
    team2 = CASE 
                WHEN team2 IS NOT NULL THEN REPLACE(REPLACE(REPLACE(team2, "'", ''), '[', ''), ']', '')
                ELSE NULL 
             END;


#Count the Occurance of each Team, Create View
CREATE VIEW TopCompanies AS
SELECT team, COUNT(*) AS team_count
FROM (
    SELECT team1 AS team FROM videogames.data WHERE team1 IS NOT NULL
    UNION ALL
    SELECT team2 AS team FROM videogames.data WHERE team2 IS NOT NULL
) AS all_Team
GROUP BY team
ORDER BY team_count desc;


SELECT * FROM videogames.topcompanies;

#Fixing Team Names that have Typos
UPDATE videogames.data
SET team = REPLACE(team, '\u016b', 'ū')
WHERE team LIKE '%\\u016b%';

UPDATE videogames.data
SET team = REPLACE(team, '\\351', 'é')
WHERE team LIKE '%\\351%';

#Task 3 What are the teams that produces highest ratings for all of their games? 

#Calculate the average ratings for each team. Join team 1 and team 2 using UNION 
CREATE VIEW topteams AS
SELECT team, AVG(rating) AS average_rating 
FROM (
    SELECT team1 AS team, rating FROM videogames.data
    UNION ALL
    SELECT team2 AS team, rating FROM videogames.data
) AS combined_teams
GROUP BY team
ORDER BY average_rating desc;


#Task 4 Find the Best Rated Games in Each Genre


#Joining the 5 genre columns into 1 
CREATE VIEW topratedgames AS
WITH normalized_genres AS (
    SELECT Title, genre1 AS genre, Rating FROM videogames.data
    UNION ALL
    SELECT Title, genre2 AS genre, Rating FROM videogames.data
    UNION ALL
    SELECT Title, genre3 AS genre, Rating FROM videogames.data
    UNION ALL
    SELECT Title, genre4 AS genre, Rating FROM videogames.data
    UNION ALL
    SELECT Title, genre5 AS genre, Rating FROM videogames.data
),
max_ratings AS (                                                      #Selecting only the rows with the max ratings for each genre
    SELECT genre, MAX(Rating) AS max_rating
    FROM normalized_genres
    WHERE genre IS NOT NULL AND genre != '' AND genre != '[]'
    GROUP BY genre
)
SELECT ng.genre, ng.Title, ng.Rating
FROM normalized_genres ng
JOIN max_ratings mr
    ON ng.genre = mr.genre AND ng.Rating = mr.max_rating
ORDER BY Rating desc;

#Task 5 Find the Title that has the highest number of plays in Each Genre
CREATE VIEW highestplays AS
WITH normalized_genres AS (                                                  #Use of CTE
    SELECT Title, genre1 AS genre, Plays FROM videogames.data
    UNION ALL
    SELECT Title, genre2 AS genre, Plays FROM videogames.data
    UNION ALL
    SELECT Title, genre3 AS genre, Plays FROM videogames.data
    UNION ALL
    SELECT Title, genre4 AS genre, Plays FROM videogames.data
    UNION ALL
    SELECT Title, genre5 AS genre, Plays FROM videogames.data
),
max_plays AS (
    SELECT genre, MAX(Plays) AS max_plays
    FROM normalized_genres
    WHERE genre IS NOT NULL AND genre != '' AND genre != '[]'
    GROUP BY genre
)
SELECT ng.genre, ng.Title, ng.Plays
FROM normalized_genres ng
JOIN max_plays mp
    ON ng.genre = mp.genre AND ng.Plays = mp.max_plays
ORDER BY Plays desc;
###END -----------------

#Changing Manually the Values of these 2 rows as they had accented characters. 
UPDATE videogames.data
SET Title =  'Pokemon Diamond'
WHERE MyUnknownColumn = '608';

UPDATE videogames.data
SET Title =  'Pokemon Anil'
WHERE MyUnknownColumn = '1349';

#Checking
SELECT title
FROM videogames.data
WHERE title LIKE '%Pokemon%';







