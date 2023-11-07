source("code/04a_OutputCSV_cases.R")
source("code/04b_OutputCSV_deaths.R")


Lydia_simpleARIMA <- rbind(Lydia_simpleARIMA_cases, Lydia_simpleARIMA_deaths)

write.csv(Lydia_simpleARIMA, paste0("./data-processed/", Sys.Date(),"-Lydia-simpleARIMA.csv"), row.names=FALSE)

