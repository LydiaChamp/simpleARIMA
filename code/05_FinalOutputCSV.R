source("code/04a_OutputCSV_cases.R")
source("code/04b_OutputCSV_deaths.R")


Lydia_simpleARIMA <- cbind(Lydia_simpleARIMA_cases, Lydia_simpleARIMA_deaths)

write.csv(Lydia_simpleARIMA, "./output/2023-10-16-Lydia-simpleARIMA.csv", row.names=FALSE)
