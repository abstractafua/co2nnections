library(igraph)
library(geosphere)

# Calculate jet fuel emissions per route
emission_factor <- 0.035 # kg jet fuel per passenger-km 
canadian_routes_with_distances$jet_fuel_emission <- canadian_routes_with_distances$distance * emission_factor

# Community detection
graph <- graph_from_data_frame(canadian_routes, directed = FALSE)
communities <- cluster_louvain(g)

# Highlight high emission routes
high_emission_routes <- canadian_routes_with_distances[order(-canadian_routes_with_distances$jet_fuel_emission), ]

# Plot
plot(graph, 
     edge.width=canadian_routes_with_distances$jet_fuel_emission/100, 
     vertex.color=communities$membership,
     vertex.label.cex = 0.03,
     vertex.size=5)

# Print top communities and routes for intervention
print(head(high_emission_routes, 10))