import pandas as pd
import psycopg2
import sys
from geopy.geocoders import Nominatim
from streamlit_folium import folium_static
import psycopg2
import sys

def connect():
    """ Connect to database """
    conn = None
    try:
        print('Connecting…')
        conn = psycopg2.connect(
            database="Kickoff_Database",
            user="postgres",
            host='localhost',
            password="1970",
            port=5432
        )
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
        sys.exit(1)
    # finally:
    #     if conn is not None:
    #         conn.close()
    #         print("Connection closed.")

    print("All good, Connection successful!")
    return conn

# Example usage:
# conn = connect()


def sql_to_dataframe(conn, query, column_names):
    """ 
    Import data from a PostgreSQL database using a SELECT query 
    """
    cursor = conn.cursor()
    try:
        cursor.execute(query)
        # The execute returns a list of tuples:
        tuples_list = cursor.fetchall()
    except (Exception, psycopg2.DatabaseError) as error:
        print("Error: %s" % error)
        return None  # Return None if an error occurs
    finally:
        cursor.close()

    # Now we need to transform the list into a pandas DataFrame:
    df = pd.DataFrame(tuples_list, columns=column_names)
    return df

def get_coordinates(country):
  geolocator = Nominatim(user_agent="geo_locator")
  location = geolocator.geocode(country)
  return location.latitude, location.longitude


    

    
