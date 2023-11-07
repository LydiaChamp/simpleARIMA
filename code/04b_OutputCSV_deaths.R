#source("code/03b_simpleARIMAdeaths.R")

Lydia_simpleARIMA_deaths <- data.frame(forecast_date = date(2880),
                                      target = character(2880),
                                      target_end_date = date(2880),
                                      location = character(2880),
                                      type = character(2880),
                                      quantile = numeric(2880),
                                      value = numeric(2880))

Lydia_simpleARIMA_deaths$forecast_date <- rep(Sys.Date(), N_rows_per_country*N_countries)
Lydia_simpleARIMA_deaths$forecast_date <- as.Date(Lydia_simpleARIMA_deaths$forecast_date)

Lydia_simpleARIMA_deaths$target <- rep(rep(c("1 wk ahead inc death", "2 wk ahead inc death", "3 wk ahead inc death", "4 wk ahead inc death"),
                                      each = N_quantiles), N_countries)

for (i in 1:2880){
  Lydia_simpleARIMA_deaths$target_end_date[i] <- ifelse(Lydia_simpleARIMA_deaths$target[i] == "1 wk ahead inc death", Lydia_simpleARIMA_deaths$forecast_date[i] + days(5),
                                                       ifelse(Lydia_simpleARIMA_deaths$target[i] == "2 wk ahead inc death", Lydia_simpleARIMA_deaths$forecast_date[i] + days(5+7),
                                                              ifelse(Lydia_simpleARIMA_deaths$target[i] == "3 wk ahead inc death", Lydia_simpleARIMA_deaths$forecast_date[i] + days(5+14),
                                                                     ifelse(Lydia_simpleARIMA_deaths$target[i] == "4 wk ahead inc death", Lydia_simpleARIMA_deaths$forecast_date[i] + days(5+21)))))
}

Lydia_simpleARIMA_deaths$location <- rep(unique(data_deaths$location), each = N_rows_per_country)

Lydia_simpleARIMA_deaths$type <- rep(c("point", rep("quantile", 23)), N_weeks_ahead*N_indicators*N_countries)

Lydia_simpleARIMA_deaths$quantile <- rep(c(NA, 0.01, 0.025, seq(0.05, 0.95, by = 0.05), 0.975, 0.99), 
                                        N_weeks_ahead*N_indicators*N_countries)


Lydia_simpleARIMA_deaths$value <- ifelse(deaths < 0, 0, deaths)
Lydia_simpleARIMA_deaths$value <- round(Lydia_simpleARIMA_deaths$value, 0)

