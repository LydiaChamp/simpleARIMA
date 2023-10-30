# ---- Load libraries ----
library(readr)
library(dplyr)
library(tidyverse)
library(forecast)
library(countrycode)

# ---- Load Data ----
#data <- read_csv("data/data.csv")
#View(data)
data_cases <- read_csv("data/truth_ECDC-Incident Cases.csv")
data_deaths <- read_csv("data/truth_ECDC-Incident Deaths.csv")

#data_hosps <- read_csv("data/weekly-hospital-admissions-covid.csv")
#View(data_hosps)

options(scipen=99)

