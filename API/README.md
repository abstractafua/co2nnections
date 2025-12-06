- This Readme instructs on how the api verve key is used to extract distances between two airports using iata codes

### How it works
https://docs.apiverve.com/vervekit/mock


### Steps to produce 

# Step 1
Generate free API key https://dashboard.apiverve.com/overview

"Because of limited resources, distances will only be extracted from Canadian Airline routes."

# Step 2
Create mock endpoint 

[docs/MockEndpoint.png]

# Step 3
Install requirements.txt

Run `pip3 -r requirements.txt` in project route

# Step 4 
Extract canadian IATA codes from routes.dat and the 
Run a simple api call inputing these IATA codes in the requests
See `get_distances.py` 





