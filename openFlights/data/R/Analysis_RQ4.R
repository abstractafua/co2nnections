library(igraph)
library(geosphere)

# Calculate emissions for each route
emission_factor <- 11.8 # 11.8L fuel per km
canadian_routes_with_distances$jet_fuel_emission <- canadian_routes_with_distances$distance * emission_factor

# Create data frame for graph
routes_for_graph <- data.frame(
  from = canadian_routes_with_distances$source,
  to = canadian_routes_with_distances$destination,
  weight = canadian_routes_with_distances$jet_fuel_emission
)

# Create undirected graph
graph <- graph_from_data_frame(routes_for_graph, directed = FALSE)

# Find communities (groups of connected airports)
communities <- cluster_louvain(graph)

# Get which community each airport belongs to
airport_community <- communities$membership
names(airport_community) <- V(graph)$name

# Print which airports are in each community
print("Airports in each community:")
for(i in 1:max(airport_community)) {
  airports_in_group <- names(airport_community)[airport_community == i]
  print(paste("Community", i, ":", paste(airports_in_group, collapse = ", ")))
}

# Calculate total emissions for each community
community_emissions <- c()  # Empty list to store results

for(i in 1:max(airport_community)) {
  # Find airports in community
  airports_in_group <- names(airport_community)[airport_community == i]
  
  # Find routes in  community
  routes_in_group <- routes_for_graph[
    routes_for_graph$from %in% airports_in_group & 
      routes_for_graph$to %in% airports_in_group, ]
  
  # Sum up emissions for community
  total_emissions <- sum(routes_in_group$weight)
  community_emissions[i] <- total_emissions
}

# Print emissions by community
print("Emissions by community:")
for(i in 1:length(community_emissions)) {
  print( round(community_emissions[i], 2))
}

# Find highest emitting community
highest_community <- max(community_emissions)
print( highest_community)

# Plot with community colors
plot(graph, 
     vertex.color = airport_community,
     vertex.label = V(graph)$name,
     vertex.label.cex = 0.08,
     vertex.size = 8,
     layout = layout_with_fr,
     main = "Communities Detection by Color")

# Find top 5 highest emission routes
high_emission_routes <- routes_for_graph[order(routes_for_graph$weight, decreasing = TRUE), ]
print("Top 5 highest emission routes:")
print(head(high_emission_routes, 5))

# Summary statistics
total_emissions <- sum(routes_for_graph$weight)
average_emissions <- mean(routes_for_graph$weight)

print("Summary:")
print(paste("Average emissions per route:", round(average_emissions, 2), "kg"))
print(paste("Number of communities found:", max(airport_community)))