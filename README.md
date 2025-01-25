🎮 Video Games Analysis Project

📄 Overview

This project focuses on analyzing video game sales and trends using SQL for data extraction and manipulation, and Tableau for visualization. The objective is to explore key insights such as release trends, sales performance, and genre popularity across different years and platforms. 

📊 Features

SQL Queries: Extracted and transformed data for meaningful analysis. VideoGamesQuery.sql 

[Tableau Dashboard](https://public.tableau.com/app/profile/jesslyn.lee/viz/videogames_17378098984270/GameInsights?publish=yes)


## Dataset

The data set contains information of video games from Year 1980 - 2023. 

Kaggle: https://www.kaggle.com/datasets/arnabchaki/popular-video-games-1980-2023/code


## Data Cleaning
Duplicates were removed
Blank Values were replaed with NULL 
Certain Title containing accented characters were replaced in the original csv file before cleaning in SQL.  
Additional Columm "Releaase_Date_Cleaned" was added to extract the date in proper YY-MM-DD format before importing into SQL 

Key Analyses:
Most popular genre
Production of games released across time frame
Top rated games
Top rated companies 


```
📂 Project Root  
├── VideoGamesQuery.sql      # SQL queries used for data extraction & cleaning  
├── videogames.twb           # Tableau workbook with all dashboards  
├── games.csv                # Raw dataset used for the project  
├── README.md                # Project documentation (this file)

```

## Results
## Insight #1: Increase Of Production Of Games Over The Years, with Sharp Increase in 2021-2022. 

![image](https://github.com/user-attachments/assets/baf249ec-9441-47ae-916d-c60db91ca2ca)

We can infer that there was a rise of the production of video games from 1980 to 2022. There was a sharp increase in 2021 - 2022, which could be attributed to the COVID-19 pandemic, where the gaming industry saw an unprecedented boom as people spent more time indoors. Game production peaked to meet this demand. However, there was a steep decline from 2022-2023. 
The market may have adjusted, with some projects canceled or delayed due to the return to pre-pandemic lifestyles.

## Insight #2: Most Games Were Released in Q4. 

![image](https://github.com/user-attachments/assets/942bba81-b937-46e2-9f9e-9638c24f1ce0)


There was a trend of increased number of titles released in the fourth quarter. This trend is primarily driven by several strategic and market factors:

- Holiday Season Sales:
Q4 includes the holiday season, particularly Christmas, Black Friday, and Cyber Monday. These are peak times for consumer spending, as people buy gifts, including video games, for themselves or loved ones.
Developers and publishers release games in Q4 to maximize sales during this lucrative period.

- Marketing and Hype Alignment:
Game publishers ramp up marketing campaigns in Q4 to take advantage of higher consumer engagement during the holidays.
The anticipation of blockbuster releases often aligns with year-end sales, ensuring maximum visibility and media coverage.

- End-of-Year Financial Goals:
Many companies aim to boost their revenue before the fiscal year ends (often in Q4). Releasing high-profile games helps meet annual revenue targets and please shareholders.

## Insight #3: Nintendo emerges as the top company with most titles released
![image](https://github.com/user-attachments/assets/b20b704a-874b-4ca2-9324-5b8cda0a2f5c)

This can be attributed to Nintendp's Extensive Catalog of Franchises, which includes several iconic and long-standing franchises, such as Super Mario, The Legend of Zelda, Pokémon, Kirby, and Animal Crossing. These franchises generate multiple titles, including spin-offs and remakes.

Their strategy of revisiting older IPs while introducing new ones helps them maintain a high volume of releases.

Additionally, Nintendo has strong Platform Exclusivity, with many designs and releases exclusively for their own consoles (e.g., Switch, Wii U, 3DS). This ensures their platforms are consistently supported with a steady stream of games.

## Insight #4: Top Average Ratings 

![image](https://github.com/user-attachments/assets/826fb7dc-a8f9-4ace-af92-9b21ccab67ca)

Bay 12 Games, Inlusio Interactive, and Kitfox Games have the highest average ratings of 4.6, making them stand out as consistent leaders in quality.
Other notable teams, such as Konami Digital Entertainment, Aniplex, and Capcom Development Division 1, also perform well with an average rating of 4.5.

Even Distribution in Ratings:
The ratings for the top 20 teams range between 4.3 and 4.6, which is a narrow band. This indicates a high level of competition among these top-performing teams.


## Insight #5: Adventure Titles are the most popular amongst consumers 

![image](https://github.com/user-attachments/assets/889b47a3-57d1-4eec-b0b1-1ca0bf53e5f3)

Adventure Dominates:
The Adventure genre has the highest count, with 525 titles, making it the most popular genre among game developers.
RPG and Shooter in Second and Third:
RPG (262 titles) and Shooter (198 titles) follow as the second and third most popular genres. These genres likely reflect strong consumer demand for immersive storytelling (RPG) and fast-paced action (Shooter).

The dominance of Adventure and RPG suggests that consumers favor narrative-driven and exploration-heavy experiences. This trend aligns with the growth of open-world and story-rich games.

It is also interesting to note that emerging genres like Simulator (71 titles) that weren't available in the past, are gaining traction, possibly due to advancements in game physics and VR.







