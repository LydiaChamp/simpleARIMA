#source("code/03a_simpleARIMAcases.R")

Lydia_simpleARIMA_cases <- data.frame(forecast_date = date(2880),
                                      target = character(2880),
                                      target_end_date = date(2880),
                                      location = character(2880),
                                      type = character(2880),
                                      quantile = numeric(2880),
                                      value = numeric(2880))

Lydia_simpleARIMA_cases$forecast_date <- rep(Sys.Date() - 1, N_rows_per_country*N_countries)
Lydia_simpleARIMA_cases$forecast_date <- as.Date(Lydia_simpleARIMA_cases$forecast_date)

Lydia_simpleARIMA_cases$target <- rep(rep(c("0 wk ahead inc case", "1 wk ahead inc case", "2 wk ahead inc case", "3 wk ahead inc case"),
                                      each = N_quantiles), N_countries)

for (i in 1:2880){
  Lydia_simpleARIMA_cases$target_end_date[i] <- ifelse(Lydia_simpleARIMA_cases$target[i] == "0 wk ahead inc case", Lydia_simpleARIMA_cases$forecast_date[i] - days(3),
                                                       ifelse(Lydia_simpleARIMA_cases$target[i] == "1 wk ahead inc case", Lydia_simpleARIMA_cases$forecast_date[i] - days(3) + days(7),
                                                              ifelse(Lydia_simpleARIMA_cases$target[i] == "2 wk ahead inc case", Lydia_simpleARIMA_cases$forecast_date[i] - days(3) + days(14),
                                                                     ifelse(Lydia_simpleARIMA_cases$target[i] == "3 wk ahead inc case", Lydia_simpleARIMA_cases$forecast_date[i] - days(3) + days(21)))))
}

Lydia_simpleARIMA_cases$location <- rep(unique(data_cases$location), each = N_rows_per_country)

Lydia_simpleARIMA_cases$type <- rep(c("point", rep("quantile", 23)), N_weeks_ahead*N_indicators*N_countries)

Lydia_simpleARIMA_cases$quantile <- rep(c(NA, 0.01, 0.025, seq(0.05, 0.95, by = 0.05), 0.975, 0.99), 
                                        N_weeks_ahead*N_indicators*N_countries)


Lydia_simpleARIMA_cases$value <- ifelse(cases < 0, 0, cases)
Lydia_simpleARIMA_cases$value <- round(Lydia_simpleARIMA_cases$value, 0)
