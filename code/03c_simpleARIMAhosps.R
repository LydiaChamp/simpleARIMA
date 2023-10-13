# is it the same to aggregate for weeks first and then forecast 4 weeks ahead
# with daily predictions and add them to present week forecasts?

source("code/01_SetUp.R")
source("code/02_DataPreparation.R")


arima_models_bycountry_hosps <- lapply(ts_bycountry_hosps, # iterate over all countries
                                        function(y)
                                          summary(auto.arima(y, 
                                                             seasonal = TRUE, 
                                                             approximation = FALSE, 
                                                             trace = FALSE, 
                                                             stepwise = FALSE)
                                          )
)


#for point forecasts WARNING WHY SO MANY NAs
arima_forecasts_bycountry_hosps <- lapply(arima_models_bycountry_hosps, 
                                           function(model) 
                                             forecast(model, 
                                                      h = 4, 
                                                      level = 0.95)
                                           
)


for (country in 1:N_countries_hosp) {
  
  for (i in 1:N) {
    sim_arima_hosps[i,] <- simulate(arima_models_bycountry_hosps[[country]], nsim = 4)
  }
  quant_hosps[[country]] <- apply(sim_arima_hosps, 2, function(x){ quantile(x, quants) })
  df_hosps[[country]] <- rbind(arima_forecasts_bycountry_hosps[[country]]$mean, quant_hosps[[country]])
}

hosps <- vector()
for (country in 1:N_countries_hosp){
  hosps <- c(hosps, as.vector(df_hosps[[country]]))
}
