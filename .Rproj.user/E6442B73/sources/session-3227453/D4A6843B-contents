#source("code/01_SetUp.R")

##################### (use of ECDC data online) #######################
# ---- Remove EU/EEAA ----
# data <- data %>%
#   filter(country != "EU/EEA (total)")

# # ---- ISO-2 geocodes ----
# data$country_code <- countrycode(data$country, origin = "country.name", destination = "iso2c")

# # ---- Data subsets ---- NO NEED IF I USE TRUTH DATA
# data_cases <- subset(data, data$indicator == "cases")
# #View(data_cases)
# 
# data_deaths <- subset(data, data$indicator == "deaths")
# #View(data_deaths)
#########################################################################

# ---- Data for hospitalizations ----
# data_hosps <- data_hosps %>% 
#   filter(!Entity %in% c("England", "Northern Ireland", "Scotland", "Wales", 
#                         "Chile", "Israel", "Malaysia", "Singapore", "South Africa", 
#                         "South Korea", "Switzerland", "United Kingdom", "United States"))
# 
# ## ---- ISO-2 geocodes ----
# data$country_code <- countrycode(data$country, origin = "country.name", destination = "iso2c")
# data_hosps$country_code <- countrycode(data_hosps$Entity, origin = "country.name", destination = "iso2c")

# ts_bycountry_hosps <- data_hosps[, c(1,3,4)] %>%
#   pivot_wider(names_from = Entity, values_from = `Weekly new hospital admissions`) %>%
#   select(-1)
# 
# ts_bycountry_hosps <- ts_bycountry_hosps %>%
#   fill(colnames(ts_bycountry_hosps), .direction = "up")
#########################################################################


# ---- Data truth data ----
## ---- Handle Missing values ----
data_cases <- data_cases %>% 
  fill(value, .direction = "up") # weekly_count IF NO TRUTH DATA

data_deaths <- data_deaths %>% 
  fill(value, .direction = "up") 

## ---- Time series data ----
ts_bycountry_cases <- data_cases[,c(1,3,4)] %>% # c(1,6,7) IF NO TRUTH DATA
  pivot_wider(names_from = location_name, values_from = value) %>% # country, weekly_count IF NO TRUTH DATA
  select(-1)

ts_bycountry_deaths <- data_deaths[,c(1,3,4)] %>%
  pivot_wider(names_from = location_name, values_from = value) %>%
  select(-1)


## ---- Important numbers ----
N_indicators <- 1 # cases (or deaths or hospitalizations)
N_quantiles <- 24 # 23 quantiles + point
N_weeks_ahead <- 4 # forecast for 4 weeks ahead
N_rows_per_country <- N_indicators*N_quantiles*N_weeks_ahead
N_countries <- length(unique(data_cases$location_name))

#N_countries_hosp <- length(unique(data_hosps$country_code))

## ---- Settings for forecast quantile ----
N <- 10000 #iterations
sim_arima_cases <- matrix(0, nrow = N, ncol = 4)
sim_arima_deaths <- matrix(0, nrow = N, ncol = 4)
sim_arima_hosps <- matrix(0, nrow = N, ncol = 4)

quants <- c(0.01, 0.025, seq(0.05, 0.95, by = 0.05), 0.975, 0.99)

quant_cases <- list()
df_cases <- list()

quant_deaths <- list()
df_deaths <- list()

quant_hosps <- list()
df_hosps <- list()
