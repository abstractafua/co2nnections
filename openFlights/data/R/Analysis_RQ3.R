# Research Q3 : Assigning distance & calculating C02 emmision weights for routes

# To Answer this research question I will be using the geosphere package
# in order to calculate the great-circle distance between airports.
# The formula to calculate the distance is called distHaversine and was sourced from R documentation 
# See : https://www.rdocumentation.org/packages/geosphere/versions/1.5-20/topics/distHaversine

install.packages('geosphere')
library(geosphere)


# Match source and destination coordinates from canadian routes
source_coords <- canadian_airports[match(edges$from, vertices$name), ]
dest_coords   <- canadian_airports[match(edges$to, vertices$name), ]

# Initialize longitude latitude points 1 and points 2 
p1 <- cbind(source_coords$Longitude, source_coords$Latitude)
p2 <- cbind(dest_coords$Longitude, dest_coords$Latitude)

# Calculate distance from two points in Canada
distance <- distHaversine(p1, p2)
max(distance/1000)

# Build Data Frame
canadian_routes_with_distances <- data.frame(
  source = edges$from,
  destination = edges$to,
  distance = distance / 1000 # To get in kilometers instead of meters I divided by 1000
)

# create unique route pairs
canadian_routes_with_distances$route_pair <- paste(
  pmin(canadian_routes_with_distances$source, canadian_routes_with_distances$destination),
  pmax(canadian_routes_with_distances$source, canadian_routes_with_distances$destination),
  sep = "-"
)

# Remove duplicate route pairs
unique_routes <- canadian_routes_with_distances[!duplicated(canadian_routes_with_distances$route_pair), ]


# Print top 10 furthest routes 
print("Top 10 longest Canadian routes:")
head(unique_routes[order(unique_routes$distance, decreasing=TRUE),], 10)

print(paste("Average distance:", round(mean(canadian_routes_with_distances$distance), 2), "km"))
print(paste("Median distance:", round(median(canadian_routes_with_distances$distance), 2), "km"))