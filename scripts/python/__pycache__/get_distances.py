import pandas as pd
import requests
import os
from dotenv import load_dotenv

load_dotenv('.env')
API_KEY = os.getenv('KEY')
API_URL = "https://api.apiverve.com/v1/mockserver/2fcda263bcbf8f7e/api/airportdistance"  # Mock endpoint

# Load airport routes
routes = pd.read_csv('openFlights/data/routes.dat', header=None)
routes.columns = ["Airline","AirlineID","SourceAirport","SourceID","DestAirport","DestID","Codeshare","Stops","Equipment"]

output = []
# Iterate over route rows and clean data like done in RQ1 Analysis
for idx, row in routes.iterrows():
    iata1 = row['SourceAirport']
    iata2 = row['DestAirport']
    if iata1 == "\\N" or iata2 == "\\N": # If either source or destination is null remove
        continue 
    payload = {"iata1": iata1, "iata2": iata2}
    headers = {"Content-Type": "application/json"}
    try: # Attempt to call API
        response = requests.post(API_URL, json=payload, headers=headers)
        data = response.json()
        if data["status"] == "ok" and data["error"] is None:
            distance_miles = data["data"]["distanceMiles"]
            distance_km = data["data"]["distanceKm"]
        else:
            distance_miles = None
            distance_km = None
    except Exception as e:
        distance_miles = None
        distance_km = None

    output.append({
        "SourceAirport": iata1,
        "DestAirport": iata2,
        "DistanceMiles": distance_miles,
        "DistanceKm": distance_km
    })

# Save results
df_out = pd.DataFrame(output)
df_out.to_csv('airport_distances.csv', index=False)
print("Distances saved")