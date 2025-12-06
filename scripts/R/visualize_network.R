library(igraph)

# Load data
df <- read.csv("data/celebrity_emissions.csv")

# Create a similarity matrix
sim_matrix <- 1 - dist(scale(df[, c("NAME", "AIRCRAFT_MODEL", " TAIL REGISTRATION", "TOTAL MILES FLOWN", " TOTAL FLIGHTS", " TOTAL FUEL USED ", " TOTAL FLIGHT TIME ", " TOTAL CO2 POLLUTION ")]), method="euclidean")

# Turn into igraph object
g <- graph_from_adjacency_matrix(as.matrix(sim_matrix > 0.9), mode="undirected")

# Plot
plot(g, vertex.label=df$Name)