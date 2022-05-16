library(tidyverse)
library(dplyr)
library(readxl)
library(lubridate)
library(ggplot2)
library(Hmisc)

rm(list = ls())

setwd("C:/Users/chinh/Junior class code only/DATA-332-01/Butterfly R")

df_cleanButterfly <- read_excel("Data/Cleaned Data LWA .xlsx", sheet = 1)
df_originalButterfly <- read_excel("Data/CompletePierisData_2022-03-09.xlsx", sheet = 1)

df_newCleanButterfly <- df_cleanButterfly[-c(51), ]

LWwidthMale <- df_newCleanButterfly %>%
  dplyr::filter(sex=='male') %>%
  dplyr::select('sex', 'LW width')

mean_LWwidthMale <- round(mean(LWwidthMale$'LW width'), digits = 3)

LWwidthFemale <- df_newCleanButterfly %>%
  dplyr::filter(sex=='female') %>%
  dplyr::select('sex', 'LW width')

mean_LWwidthFemale <- round(mean(LWwidthFemale$'LW width'), digits = 3)

mean_LWwidth <- data.frame(gender=c("Female", "Male"), width=c(mean_LWwidthFemale, mean_LWwidthMale))

ggplot(mean_LWwidth, aes(x=gender, y=width))+
  geom_bar(stat="identity", fill="steelblue")+
  geom_text(aes(label=width), vjust=-0.3, size=3.5)+
  theme_minimal()+
  ylim(0,15)+
  labs(title = "Mean of LW width by gender")

df_butterflyAllColumns <- merge(df_newCleanButterfly, df_originalButterfly, by.x = "core ID", 
                                by.y = "coreid", all.x = TRUE)

countryName <- df_butterflyAllColumns$`dwc:country`[df_butterflyAllColumns$`dwc:country` == "USA"] <- 
  "United States"

countriesLWapex <- df_butterflyAllColumns %>%
  dplyr::select('dwc:country', 'LW apex A')

countryLWapexMean <- aggregate(countriesLWapex$`LW apex A`, list(countriesLWapex$`dwc:country`), mean)

names(countryLWapexMean)[1] <- 'Country'
names(countryLWapexMean)[2] <- 'Mean'

countryLWapexMean$Mean <- round(countryLWapexMean$Mean, digits = 3)

ggplot(countryLWapexMean, aes(x=Country, y=Mean))+
  geom_bar(stat="identity", fill="green")+
  geom_text(aes(label=Mean), vjust=-0.3, size=3.5)+
  theme_minimal()+
  ylim(0,12)+
  labs(title = "Mean of LW Apex by country")


df_RWlengthByYear <- df_butterflyAllColumns %>%
  dplyr::select('dwc:year', 'RW length')

year_order <- order(df_RWlengthByYear$`dwc:year`)
year_ascendingorder <- df_RWlengthByYear[year_order,]

names(year_ascendingorder)[1] <- 'Years'

lastseventyfive_years <- year_ascendingorder %>%
  dplyr::filter(Years>'1947')

RWlengthgroupby_year <- data.frame(aggregate(lastseventyfive_years$`RW length`, 
                                             by = list(lastseventyfive_years$Years),
                                             max))

names(RWlengthgroupby_year)[1] <- 'Year'
names(RWlengthgroupby_year)[2] <- 'Max_RW_Length'

ggplot(data = RWlengthgroupby_year, aes(x=Year, y=Max_RW_Length, group = 1))+
  geom_line(color='red')+
  geom_point()+
  labs(title = "Line Chart of Maximum RW length by years")+
  geom_text(aes(label=Max_RW_Length), vjust=-0.5, size=2.5)

