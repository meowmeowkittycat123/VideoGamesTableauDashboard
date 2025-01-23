🎮 Video Games Analysis Project

📄 Overview

This project focuses on analyzing video game sales and trends using SQL for data extraction and manipulation, and Tableau for visualization. The objective is to explore key insights such as release trends, sales performance, and genre popularity across different years and platforms. 

📊 Features

SQL Queries: Extracted and transformed data for meaningful analysis. VideoGamesQuery.sql 

[Tableau Dashboard](https://public.tableau.com/app/profile/jesslyn.lee/viz/Book1_17374859012250/Dashboard3?publish=yes)


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



