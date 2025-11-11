import requests
from bs4 import BeautifulSoup
import pandas as pd

url = "https://celebrityprivatejettracker.com/leaderboard/"
response = requests.get(url)
soup = BeautifulSoup(response.text, "html.parser")

rows = []
for tr in soup.find_all("tr")[1:]:  # skip header
    cols = [td.get_text(strip=True) for td in tr.find_all("td")]
    if cols:
        rows.append(cols)

df = pd.DataFrame(rows, columns=["NAME", "AIRCRAFT_MODEL", " TAIL REGISTRATION", "TOTAL MILES FLOWN", " TOTAL FLIGHTS", " TOTAL FUEL USED ", " TOTAL FLIGHT TIME ", " TOTAL CO2 POLLUTION "])
df.to_csv("data/celebrity_emissions.csv", index=False)
print(df)