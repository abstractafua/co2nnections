# Research Q3 : Assigning distance & calculating C02 emmision weights for routes

# To Answer this research question I will be using the geosphere package
# in order to calculate the great-circle distance between airports.
# The formula to calculate the distance is called distHaversine and was sourced from R documentation 
# See : https://www.rdocumentation.org/packages/geosphere/versions/1.5-20/topics/distHaversine

install.packages('geosphere')

library(geosphere)

# Match source and destination coordinates from canadian routes
source_coords <- canadian_airports[match(canadian_routes$SourceAirport, canadian_airports$IATA), ]
dest_coords   <- canadian_airports[match(canadian_routes$DestAirport, canadian_airports$IATA), ]

# Initialize points 1 and points 2 
p1 <- cbind(source_coords$Longitude, source_coords$Latitude)
p2 <- cbind(dest_coords$Longitude, dest_coords$Latitude)

# Calculate distance from two points in Canada...Only include overlapping longitude and latitude
distance <- distHaversine(p1, p2)

# Build Data Frame
canadian_routes_with_distances <- data.frame(
    source = canadian_routes$SourceAirport,
    destination = canadian_routes$DestAirport,
    distance = distance / 1000 # To get in kilometers I divided by 1000
)

# Save to a csv file to view structure
write.csv(canadian_routes_with_distances, "canadian_routes_with_distances.csv", row.names = FALSE)

# Print top 5 furthest routes 

head(canadian_routes_with_distances[order(canadian_routes_with_distances$distance), decreasing=TRUE], 5)