import pandas as pd
import numpy as np
from conversion import sql_to_dataframe, connect, get_coordinates
import streamlit as st
from st_aggrid import AgGrid, JsCode
from st_aggrid.grid_options_builder import GridOptionsBuilder
import queries 
import altair as alt
import geopandas as gpd
from geopy.geocoders import Nominatim
from streamlit_folium import folium_static
import folium
import pickle

g = [0]
a = [0]
y = [0]
r = [0]

file_path = "my_list.pkl"

query1 = queries.get_query_1()
column_names1 = ["ID", 
                "First Name", 
                "Last Name", 
                "Country", 
                "Market Value (Eur)", 
                "Height", 
                "Foot", 
                "Last Season", 
                "Image URL"]

#opening the connection
conn1 = connect()
df1 = sql_to_dataframe(conn1, query1, column_names1)

style = "<style>h2 {text-align: center;}</style>"
st.markdown("<h1 style='text-align: center; color: darkred;'> KICKOFF DATABASE </h1>", unsafe_allow_html=True)
# st.image('Images/home_page.jpg')
centered_image_markdown = """
<div style="display: flex; justify-content: center;">
    <img src="https://media.giphy.com/media/XcAskcEyoyld03drLt/giphy-downsized-large.gif" alt="Your Awesome GIF">
</div>
"""

# Display the centered image using st.markdown
st.markdown(centered_image_markdown, unsafe_allow_html=True)

st.header(":blue[Choose a Player]", divider='grey')

render_image = JsCode('''
                      
    function renderImage(params) {
    // Create a new image element
    var img = new Image();

    // Set the src property to the value of the cell (should be a URL pointing to an image)
    img.src = params.value;

    // Set the width and height of the image to 50 pixels
    img.width = 50;
    img.height = 50;

    // Return the image element
    return img;
    }
'''
)

# Build GridOptions object
options_builder = GridOptionsBuilder.from_dataframe(df1)
options_builder.configure_column('Image URL', cellRenderer = render_image)
options_builder.configure_selection(selection_mode="single", use_checkbox=True)
grid_options = options_builder.build()

# Create AgGrid component
grid = AgGrid(df1, 
                gridOptions = grid_options,
                allow_unsafe_jscode=True,
                height=200, width=500, theme='streamlit')

sel_row = grid["selected_rows"]

st.subheader(":blue[Player Info]", divider='grey')

with open(file_path, 'rb') as file:
    loaded_list = pickle.load(file)

if sel_row:
  with st.expander("Player Selected", expanded=True):
    id = sel_row[0]["ID"]
    player_full_name = sel_row[0]['First Name'] + ' ' + sel_row[0]['Last Name']
    selected_country = sel_row[0]['Country'] 
    col1, col2 = st.columns(2)
    img = sel_row[0]['Image URL']
    col1.image(sel_row[0]['Image URL'], caption=player_full_name)
    col2.write(f"Height       : :blue[{sel_row[0]['Height']}]")
    if sel_row[0]['Foot'] == 'l':
      foot_manual = 'Left'
    elif sel_row[0]['Foot'] == 'r':
      foot_manual = 'Right'
    else:
      foot_manual = 'Not Available'
    col2.write(f"Foot         : :blue[{foot_manual}]")
    col2.write(f"Last Season  : :blue[{sel_row[0]['Last Season']}]")
    col2.write(f"Market Value : € :blue[{sel_row[0]['Market Value (Eur)']}]")
    conn5 = connect()
    query5 = queries.get_query_5(id)
    column_names5 = ["Name",
                    "Goals",
                    "Assists",
                    "Yellow Cards",
                    "Red Cards",
                    "Play Time",]
    df5 = sql_to_dataframe(conn5, query5, column_names5)
    if df5.empty:
      df5.loc[0] = [0] * len(df5.columns)
    loaded_list['g'].append(df5['Goals'][0])
    loaded_list['a'].append(df5['Assists'][0])
    loaded_list['y'].append(df5['Yellow Cards'][0])
    loaded_list['r'].append(df5['Red Cards'][0])
    col1, col2, col3, col4 = st.columns(4)
    col1.metric(column_names5[1], df5['Goals'], delta = (str(int(df5['Goals'][0]) - int(loaded_list['g'][0]))))
    col2.metric(column_names5[2], df5['Assists'], delta = (str(int(df5['Assists'][0]) - int(loaded_list['g'][0]))))
    col3.metric(column_names5[3], df5['Yellow Cards'], delta = (str(int(df5['Yellow Cards'][0]) - int(loaded_list['g'][0]))))
    col4.metric(column_names5[4], df5['Red Cards'], delta = (str(int(df5['Red Cards'][0]) - int(loaded_list['g'][0]))))
    st.info(sel_row[0]['Country']) 
    loaded_list['g'].pop(0)
    loaded_list['a'].pop(0)
    loaded_list['y'].pop(0)
    loaded_list['r'].pop(0)
    coordinates = get_coordinates(selected_country)
    m = folium.Map(location=coordinates, zoom_start=4)
    folium.Marker(coordinates, popup=selected_country).add_to(m)
    folium_static(m)
    
with open(file_path, 'wb') as file:
    # Use pickle.dump() to store the list in the file
    pickle.dump(loaded_list, file)

st.subheader(":blue[Player Performance as per Position]", divider='grey')

query2 = queries.get_query_2()
column_names2 = ["Unique Position"]
conn2 = connect()
df2 = sql_to_dataframe(conn2, query2, column_names2)


position_chosen = str(st.sidebar.selectbox('Select Position:', df2))


conn3 = connect()
query3 = queries.get_query_3(position_chosen)
column_names3 = ["Player name",
    "Goals Per Match",
    "Yellow Cards Per Match",
    "Red Cards Per Match",
    "Play Time Per Match",
    "Overall Rank",
    "Position"]
df3 = sql_to_dataframe(conn3, query3, column_names3)
st.dataframe(df3)

conn4 = connect()
query4 = queries.get_query_4()
column_names4 = ["Competition",
    "Best Competition Player",
    "Goals"]
df4 = sql_to_dataframe(conn4, query4, column_names4)

df4['Competition'] = df4['Competition'].astype('category')

chart = alt.Chart(df4).mark_circle().encode(
    x='Best Competition Player',
    y='Goals',
    color='Goals',
    tooltip=['Competition', 'Best Competition Player', 'Goals']
).interactive()

st.subheader(":blue[Goals per Competition]", divider='grey')

st.altair_chart(chart, theme="streamlit",  use_container_width=True)
