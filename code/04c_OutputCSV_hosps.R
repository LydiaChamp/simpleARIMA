source("code/03c_simpleARIMAhospss.R")

Lydia_simpleARIMA_hosps <- data.frame(forecast_date = date(2880),
                                       target = character(2880),
                                       target_end_date = date(2880),
                                       location = character(2880),
                                       type = character(2880),
                                       quantile = numeric(2880),
                                       value = numeric(2880))

Lydia_simpleARIMA_hosps$forecast_date <- rep("2023-10-16", N_rows_per_country*N_countries_hosp)
Lydia_simpleARIMA_hosps$forecast_date <- as.Date(Lydia_simpleARIMA_hosps$forecast_date)

Lydia_simpleARIMA_hosps$target <- rep(c("0 wk ahead inc case", "1 wk ahead inc case", "2 wk ahead inc case", "3 wk ahead inc case"),
                                       each = N_quantiles*N_countries_hosp)

for (i in 1:2880){
  Lydia_simpleARIMA_hosps$target_end_date[i] <- ifelse(Lydia_simpleARIMA_hosps$target[i] == "0 wk ahead inc case", Lydia_simpleARIMA_hosps$forecast_date[i] + days(5),
                                                        ifelse(Lydia_simpleARIMA_hosps$target[i] == "1 wk ahead inc case", Lydia_simpleARIMA_hosps$forecast_date[i] + days(5+7),
                                                               ifelse(Lydia_simpleARIMA_hosps$target[i] == "2 wk ahead inc case", Lydia_simpleARIMA_hosps$forecast_date[i] + days(5+14),
                                                                      ifelse(Lydia_simpleARIMA_hosps$target[i] == "3 wk ahead inc case", Lydia_simpleARIMA_hosps$forecast_date[i] + days(5+21)))))
}

Lydia_simpleARIMA_hosps$location <- rep(unique(data_hosps$country_code), each = N_rows_per_country)

Lydia_simpleARIMA_hosps$type <- rep(c("point", rep("quantile", 23)), N_weeks_ahead*N_indicators*N_countries_hosp)

Lydia_simpleARIMA_hosps$quantile <- rep(c(NA, 0.01, 0.025, seq(0.05, 0.95, by = 0.05), 0.975, 0.99), 
                                         N_weeks_ahead*N_indicators*N_countries_hosp)


Lydia_simpleARIMA_hosps$value <- ifelse(hosps < 0, 0, hosps)
Lydia_simpleARIMA_hosps$value <- round(Lydia_simpleARIMA_hosps$value, 0)


write.csv(Lydia_simpleARIMA_hosps, "./output/2023-10-16-Lydia-simpleARIMA_hosps.csv", row.names=FALSE)
