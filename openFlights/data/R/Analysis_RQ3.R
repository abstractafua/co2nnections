# Research Q3 : Assigning distance & calculating C02 emmision weights for routes

# Minimize Scope : Extract a list of canadian airports
canadian_airports <- clean_airports[clean_airports$Country == "Canada", ]

# Save airports as a csv file for reference
write.csv(canadian_airports, "canadian_airports.csv", row.names = FALSE)

# Extract canadian routes only (Routes within canada)
canadian_routes <- routes[routes$SourceAirport %in% canadian_airports$IATA | routes$DestAirport %in% canadian_airports$IATA, ]

# Save routes as a csv file to be used later in analysis
write.csv(canadian_routes, "canadian_routes.csv", row.names = FALSE)

# Assign distances to routes
distance <- read.csv("airport_distances.csv")