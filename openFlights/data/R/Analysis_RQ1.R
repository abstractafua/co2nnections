library(igraph)

# RQ 1 : What is the average degree of the worldwide airline directed network and what does it reveal about air connectivity?

# Load Airports 
airports <- read.csv("/Users/afuafrempong/co2nnections/data/airports.dat", header = FALSE)

# Make column names/headings
colnames(airports) <- c("AirportID","Name","City","Country","IATA","ICAO",
                        "Latitude","Longitude","Altitude","Timezone",
                        "DST","TzDB","Type","Source") # These column names are infered from https://openflights.org/data.php

# Load routes
routes <- read.csv("/Users/afuafrempong/co2nnections/data/routes.dat", header = FALSE)

# Make column names/headings
colnames(routes) <- c("Airline","AirlineID","SourceAirport","SourceID",
                      "DestAirport","DestID","Codeshare","Stops","Equipment")


# For routes I want to remove any row that contains empty source airport, airport ID and or destination airport as this missing data may impact analysis
clean_routes <- routes[routes$SourceAirport != "\\N" & routes$DestAirport != "\\N" & routes$AirlineID != "\\N", ]

# For airports I want to remove any row that has empty airport IATA 3 letter code since it may not be verified
clean_airports <- airports[airports$IATA != "\\N", ]

# Keep routes that share/have paired IATA values with airport list since some have ICAO
clean_routes <- clean_routes[clean_routes$SourceAirport %in% clean_airports$IATA & clean_routes$DestAirport %in% clean_airports$IATA,]

# Assign edges for graph with only source & destination columns
edges <- data.frame(
  from = clean_routes$SourceAirport,
  to   = clean_routes$DestAirport
)

# Assign vertices for graph with only IATA code
vertices <- data.frame(
  name = clean_airports$IATA
)

# Make directed graph from data frame
graph <- graph_from_data_frame(edges, vertices, directed = TRUE)

# Plot graph
plot(graph, vertex.size=0.5,
     vertex.label=NA,
     edge.arrow.size=0.15,
     layout=layout_with_fr,
     main = "Worldwide Airline Network (Fruchterman-Reingold Layout)")

# Number of nodes (airports)
node_count <- vcount(graph)
print("Node Count :")
node_count

# Number of edges (routes)
edge_count <- ecount(graph)
print("Edge Count :")
edge_count

# Average degree of undirected network
graph <- graph_from_data_frame(edges, vertices, directed = FALSE)
print("Average degree of undirected network :")
mean(degree(graph))


# Make graph directional
graph <- graph_from_data_frame(edges, vertices, directed = TRUE)

# Average in-degree of network
in_deg <- degree(graph, mode = "in", )
print("Average in-degree of network :")
mean(in_deg)

# Average out-degree of network
out_deg <- degree(graph, mode ="out", )
print("Average out-degree of network :")
mean(out_deg)

# Make a table of degree and print head 10 descending in-degree and then out-degree
degree_table <- data.frame(
  Airport = V(graph)$name,
  in_degree = in_deg,
  out_degree = out_deg
)

# Top departing airports sorted by in degree
top_sources <-degree_table[order(degree_table$in_degree,decreasing = TRUE),]
print("Top 10 Airports by In-Degree: ")
head(top_sources, 10)

# To arrival airports sorted by out degree
top_destinations <- degree_table[order(degree_table$out_degree,decreasing = TRUE),]
print("Top 10 Airports by Out-Degree: ")
head(top_destinations, 10)


# Histogram Plots for degrees

hist(in_deg,
     breaks = 50,
     main = "In-Degree Distribution of Global Airline Network",
     xlab = "In-Degree",
     col = "lightblue")

hist(out_deg,
     breaks = 50,
     main = "Out-Degree Distribution of Global Airline Network",
     xlab = "Out-Degree",
     col = "lightblue")