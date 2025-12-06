# Research Q2 : Which canadian airports are the most central according to degree, betweenness, and closeness centrality?

# Make a table of centrality measures and airports
# Confirm if the network shows high connectivity (many edges) or sparse connectivity?
# In this question I will reduce the scope to only include Canadian airports in order to focus on their connectivity.
# I referenced this R documentation for the plots and writing CSV files :
# https://www.rdocumentation.org/packages/graphics/versions/3.6.2/topics/barplot and
# https://www.rdocumentation.org/packages/AlphaPart/versions/0.9.8/topics/write.csv


# Minimize Scope : Extract a list of canadian airports and canadian routes
canadian_airports <- clean_airports[clean_airports$Country == "Canada", ]

# Classifying routes as canadian if both the source and destination are in the list of canadian airports
canadian_routes <- edges[edges$from %in% canadian_airports$IATA &
                           edges$to %in% canadian_airports$IATA, ]
# Create graph object 
canadian_airports_graph <- graph_from_data_frame(canadian_routes, directed = TRUE)

# Plot graph
plot(canadian_airports_graph, 
     vertex.size = 5,
     vertex.label = V(canadian_airports_graph)$name,  
     vertex.label.cex = 0.2,  
     vertex.label.color = "darkblue",
     vertex.color = "lightblue",
     edge.arrow.size = 0.1,
     edge.arrow.width = 0.4,
     layout = layout_with_fr,
     main = "Canadian Domestic Flight Network (Fruchterman-Reingold Layout)")


# Save as csv for future reference
write.csv(canadian_airports, "canadian_airports.csv", row.names = FALSE)

# Calculate centrality measures
degree_centrality <- degree(canadian_airports_graph)
betweenness_centrality <- betweenness(canadian_airports_graph)
closeness_centrality <- closeness(canadian_airports_graph)

# Combine measures into a data frame
centrality_measures <- data.frame(
  Airport = V(canadian_airports_graph)$name,
  Degree = degree_centrality,
  Betweenness = betweenness_centrality,
  Closeness = closeness_centrality
)


# List top 5 airports by each centrality measure
top_5_degree <- head(centrality_measures[order(centrality_measures$Degree, decreasing = TRUE), ], 5)
top_5_betweenness <-head(centrality_measures[order(centrality_measures$Betweenness, decreasing = TRUE), ], 5)
top_5_closeness <- head(centrality_measures[order(centrality_measures$Closeness, decreasing = TRUE), ], 5)


# Save to csv for appendix table
write.csv(centrality_measures, "centrality_measures.csv", row.names = FALSE)

# Visualize with Bar Plots

barplot(top_5_degree$Degree, names.arg = top_5_degree$Airport, main = "Top 5 Airports by Degree Centrality", col = "blue")
barplot(top_5_betweenness$Betweenness, names.arg = top_5_betweenness$Airport, main = "Top 5 Airports by Betweenness Centrality", col = "red")
barplot(top_5_closeness$Closeness, names.arg = top_5_closeness$Airport, main = "Top 5 Airports by Closeness Centrality", col = "green")