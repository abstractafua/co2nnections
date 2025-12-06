library(igraph)
library(dplyr)

# Load
airports <- read.csv("/Users/afuafrempong/co2nnections/openFlights/data/airports.dat", header = FALSE)
routes <- read.csv("/Users/afuafrempong/co2nnections/openFlights/data/routes.dat", header = FALSE)

# Rename columns
colnames(airports) <- c("AirportID","Name","City","Country","IATA","ICAO","Latitude","Longitude","Altitude","Timezone","DST","TzDB","Type","Source")
colnames(routes) <- c("Airline","AirlineID","SourceAirport","SourceID","DestAirport","DestID","Codeshare","Stops","Equipment") 

# Clean: keep numeric IDs
routes2 <- routes %>% filter(!is.na(SourceID) & !is.na(DestID)) %>% 
  filter(SourceID != "\\N" & DestID != "\\N") %>%
  mutate(SourceID = as.integer(SourceID), DestID = as.integer(DestID))

airports2 <- airports %>% mutate(AirportID = as.integer(AirportID))

# Build graph
edges <- routes(SourceID, DestID)
g <- graph_from_data_frame(d = edges, vertices = airports, directed = TRUE)

# Basic stats
stats <- list(
  nodes = vcount(g),
  edges = ecount(g),
  avg_degree = mean(degree(g, mode="all")),
  density = edge_density(g),
  diameter = diameter(g, directed = FALSE, weights = NA)
)

print(stats)

# Centralities
deg <- degree(g, mode="all")
bet <- betweenness(g, directed=TRUE)
clos <- closeness(g, mode="all", normalized = TRUE)

V(g)$deg <- deg
V(g)$bet <- bet
V(g)$clos <- clos

# Top-10 tables
top_deg <- sort(deg, decreasing=TRUE)[1:10]
top_bet <- sort(bet, decreasing=TRUE)[1:10]
top_clos <- sort(clos, decreasing=TRUE)[1:10]

write.csv(as.data.frame(top_deg), "figures/top_degree.csv", row.names=TRUE)
write.csv(as.data.frame(top_bet), "figures/top_betweenness.csv", row.names=TRUE)
write.csv(as.data.frame(top_clos), "figures/top_closeness.csv", row.names=TRUE)

# Communities (Louvain on undirected)
comm <- cluster_louvain(as.undirected(g))
V(g)$community <- membership(comm)

# Save small plots
png("figures/network_communities.png", width=1200, height=800)
plot(comm, g, vertex.size=3, vertex.label=NA, main="OpenFlights: Communities")
dev.off()

png("figures/top_degree_bar.png", width=800, height=600)
barplot(top_deg, las=2, main="Top 10 Airports by Degree", ylab="Degree")
dev.off()
