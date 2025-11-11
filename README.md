# co2nnections
Network Model of Celebrity Private Jet Emissions


In a world where the average individual is shamed into using paper straws and pushed to decipher recycling instructions, the 1% emits tons of carbon into our ozone layer. This disproportionate contribution is oftentimes overlooked. 

Although some twitter pages have gained recent popularity by tracking famous people’s individual private jet emissions (for example, @ElonJets and @SwiftJetNextDay), they fail to capture the underlying network structure of this bling ring of pollution. The novelty of this project lies in shifting away from individual blame to modeling the use of private jets as a more impactful pollution network. 

This network based project will hopefully bring forth a sort of environmental accountability in order to address the problem of gas emissions among a sample of prominent celebrities via private plane data. I aim to do this through answering these four pivotal research questions :

Research Questions
What is the average degree of the private jet emission network? 
Who are the most central " flyers" in the private jet ecosystem (by centrality measures)
How do total emissions and flight frequency vary among top celebrities, and can we identify clusters of high-emission individuals? 
What clique could have flown to similar destinations through shared routes together rather than solo in one plane? (tentative*)

*Because route-level data is not easily available, this analysis will mainly focus on emission-based and behavioral similarities rather than direct flight connections.

Data Sourcing 

Data will be taken from multiple sources such as  : 
Primary Source : Celebrity Private Jet Tracker  (https://celebrityprivatejettracker.com/leaderboard/)
FlightRadar24 (flightradar24.com)
JetSpy (JetSpy.com)
@SwiftJetNextDay on Twitter (X) 
Graph Definitions 

Nodes: Individual celebrities with recorded private jet activity.
Edges: Weighted and Unweighted connections representing similarity in emission behavior 
Metrics 
For each celebrity, I will collect data on their publicly reported total flight emissions (CO2), total distance flown, and number of flights taken in the past few years (etc.).
Analysis 
All analyses will be conducted in R using the igraph package. The process will begin with gathering and cleaning emission and flight data from sources. I will then build an emission similarity network by connecting celebrities whose total CO₂ emissions or flight frequencies fall within a defined range. Once the network is built, I plan to calculate key metrics such as degree, betweenness, and closeness centrality to identify the most influential nodes, and to detect clusters of high- and low-emission celebrities. Lastly, I will generate network visualizations to support and interpret the concentration of carbon emissions within the celebrity private jet ecosystem.
Timeline (TBC)
Project Requirements & Scope → Project Proposal
	Week 1 (October 19th, 2025 - October 25th, 2025)
Data → (Sourcing and Refinement)
Week 2 (October 26th, 2025 - November 1st, 2025)
Analysis I → (Research Questions 1 ) 
Week 3 (November 3rd, 2025 - November 7th, 2025)
Analysis II → (Research Questions 2 & 3) 
Week 4 & 5 (November 10th, 2025 - November 23rd, 2025)
Analysis III → (Research Question 4 & Conclusion/Key Findings) 
Week 6 (November 24th, 2025 - November 30th, 2025)
Review Phase → Week 7 (December 1st, 2025 - December 7th, 2025)
