# KickOff- Building the Ultimate Football Data Repository
![hippo](https://github.com/nitinshivakumar/KickOff--Building-the-Ultimate-Football-Repository/blob/main/Website/Images/giphy.gif)
## Data Source
The data used in this project was obtained through web scraping techniques using Python and Beautiful Soup from the website [Transfermarkt](https://www.transfermarkt.com).

## Files Included 
 -  
   - `create_database` : SQL script to create the necessary database.
   - `create.sql`: SQL script to create the necessary tables.
   - `load.sql`: SQL script to load the scraped data into the created tables.
   - `index_creating_file.sql` : SQL script to create the necessary indexes for the created tables to improve the performance.
   - `Kickoff_Database_Backup.sql` : SQL script to restore the final database.
   - `data/`: Sub-directory containing all the data files in CSV format.
      -  `appearances.csv` 
      -  `clubs_code.csv` 
      -  `clubs.csv` 
      -  `competition_current_club.csv` 
      -  `competitions_country.csv` 
      -  `competitions_domestic_league.csv` 
      -  `competitions_type.csv` 
      -  `competitions.csv` 
      -  `games_away_club.csv` 
      -  `games_home_club.csv` 
      -  `games.csv` 
      -  `player_birth.csv` 
      -  `player_code.csv` 
      -  `player_position.csv` 
      -  `pl`ayers.csv`
   -  `Problem - Queries/`: I have successfully designed and implemented a set of SQL queries to perform various operations on the dataset obtained from Transfermarkt.com. The queries cover inserting, deleting, updating, and selecting data from the database.
   - `Website/`: 
      - `app.py`: Main file for the web application.
      - `conversion.py`: Module containing functions for connecting to the PostgreSQL database.
      - `dmql_venv/`: Virtual environment for managing dependencies.
      - `Images/`: Folder containing images used in the website.
      - `queries.py`: Module with functions implementing various SQL queries.
   - `Report/`: The folder contains the report.
   - demo.MOV : The video demo which contains the presentation of our project.


## Data Import Process
1. **Web Scraping:**
   - The data was scraped from Transfermarkt.com using Python and Beautiful Soup. The scraping script can be found in the Python file `web_scraping_script.py`.

2. **Database Setup:**
   - The PostgreSQL database was created using the following steps:
     - Database Name: `<your_database_name>`
     - Username: `<your_username>`
     - Password: `<your_password>`

3. **SQL Scripts:**
   - `create.sql`: Defines the database schema and tables based on the scraped data.
   - `load.sql`: Loads the data from CSV files into the respective tables.

4. **Execution:**
   - Execute the `create.sql` script to set up the database schema.
   - Execute the `load.sql` script to populate the tables with the scraped data.

5. **Queries:**
   - Various SQL queries are available in `queries.sql` to analyze and retrieve information from the imported data.

## Dependencies

This web application is built using various Python libraries and modules to provide functionality such as database interaction, data visualization, and geographical mapping. Below is a list of dependencies used in the application:
- **Python (>=3.6):** The core programming language used for developing the web application.
- **pandas (>=1.0.0):** A powerful data manipulation library used for working with tabular data.
- **numpy (>=1.18.0):** A library for numerical operations, providing support for large, multi-dimensional arrays and matrices.
- **psycopg2 (>=2.8.6):** A PostgreSQL adapter for Python, used for connecting to and interacting with the PostgreSQL database.
- **streamlit (>=0.79.0):** A popular Python library for creating web applications with minimal code.
- **st_aggrid (>=0.3.0):** A Streamlit component for embedding interactive Ag-Grid tables in web applications.
- **altair (>=4.1.0):** A declarative statistical visualization library for creating interactive visualizations in Python.
- **geopandas (>=0.8.0):** An extension of the pandas library for working with geospatial data.
- **geopy (>=2.0.0):** A Python client for several popular geocoding web services.
- **streamlit_folium (>=0.2.2):** A Streamlit component for embedding Folium maps in web applications.
- **folium (>=0.12.0):** A Python library for creating Leaflet maps.
- **pickle (>=4.0.0):** A module for serializing and deserializing Python objects, used for storing and retrieving data.
- **queries.py:** A module containing functions for executing SQL queries on the database.
- **conversion.py:** A module with functions for connecting to the PostgreSQL database and converting SQL results to pandas DataFrames.

Ensure to install these dependencies before running the web application. You can use the following command to install the dependencies using pip:

```bash
pip install pandas numpy psycopg2 streamlit st_aggrid altair geopandas geopy streamlit_folium folium
```

## Notes
- Make sure to update the database connection details (database name, username, password) in the scripts before execution.

## Website
- Use the following command to run : "streamlit run app.py"

#Video Link :
If in case you are not able to open our video then please get it from the below link.
https://buffalo.box.com/s/y05gg3kkm18xor37veoh8fp68xyqocof

Feel free to reach out for any further clarifications or issues.
