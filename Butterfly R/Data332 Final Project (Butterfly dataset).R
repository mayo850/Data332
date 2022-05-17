# libraries used
library(tidyverse)
library(dplyr)
library(readxl)
library(lubridate)
library(ggplot2)
library(Hmisc)

rm(list = ls())

# set up the directory
setwd("C:/Users/chinh/Junior class code only/DATA-332-01/Butterfly R")

# add the files
df_cleanButterfly <- read_excel("Data/Cleaned Data LWA .xlsx", sheet = 1)
df_originalButterfly <- read_excel("Data/CompletePierisData_2022-03-09.xlsx", sheet = 1)

# removed extra empty row the data set had
df_newCleanButterfly <- df_cleanButterfly[-c(51), ]

# clean and filter the data for LW width male
LWwidthMale <- df_newCleanButterfly %>%
  dplyr::filter(sex=='male') %>%
  dplyr::select('sex', 'LW width')

# calculate mean for male
mean_LWwidthMale <- round(mean(LWwidthMale$'LW width'), digits = 3)

# clean and filter the data for LW width female
LWwidthFemale <- df_newCleanButterfly %>%
  dplyr::filter(sex=='female') %>%
  dplyr::select('sex', 'LW width')

# calculate mean for female
mean_LWwidthFemale <- round(mean(LWwidthFemale$'LW width'), digits = 3)

# creating a dataframe of means for graph
mean_LWwidth <- data.frame(gender=c("Female", "Male"), width=c(mean_LWwidthFemale, mean_LWwidthMale))

# creating the graph for mean of LW width according to gender
ggplot(mean_LWwidth, aes(x=gender, y=width))+
  geom_bar(stat="identity", fill="steelblue")+
  geom_text(aes(label=width), vjust=-0.3, size=3.5)+
  theme_minimal()+
  ylim(0,15)+
  labs(title = "Mean of LW width by gender")

# adding all the columns of original data set to clean data set provided (This function is basically a vlookup)
df_butterflyAllColumns <- merge(df_newCleanButterfly, df_originalButterfly, by.x = "core ID", 
                                by.y = "coreid", all.x = TRUE)

# cleaning the new data set by using conditional statement to make sure USA is United States
countryName <- df_butterflyAllColumns$`dwc:country`[df_butterflyAllColumns$`dwc:country` == "USA"] <- 
  "United States"

# filtering data for LW apex by country
countriesLWapex <- df_butterflyAllColumns %>%
  dplyr::select('dwc:country', 'LW apex A')

# this line makes a new data frame of mean of LW apex by country
countryLWapexMean <- aggregate(countriesLWapex$`LW apex A`, list(countriesLWapex$`dwc:country`), mean)

# assigning column names to the new data frame that was created
names(countryLWapexMean)[1] <- 'Country'
names(countryLWapexMean)[2] <- 'Mean'

# rounding off values of mean
countryLWapexMean$Mean <- round(countryLWapexMean$Mean, digits = 3)

# visualization of LW apex by country 
ggplot(countryLWapexMean, aes(x=Country, y=Mean))+
  geom_bar(stat="identity", fill="green")+
  geom_text(aes(label=Mean), vjust=-0.3, size=3.5)+
  theme_minimal()+
  ylim(0,12)+
  labs(title = "Mean of LW Apex by country")

# filter the data for the RW length by year
df_RWlengthByYear <- df_butterflyAllColumns %>%
  dplyr::select('dwc:year', 'RW length')

# ordering the data in ascending order
year_order <- order(df_RWlengthByYear$`dwc:year`)
year_ascendingorder <- df_RWlengthByYear[year_order,]

# 'dwc:year' was giving error in R when making new dataframe so changed name from dwc:year to years for first column
names(year_ascendingorder)[1] <- 'Years'

# filtering the years to only get data from 1947 to 2022
lastseventyfive_years <- year_ascendingorder %>%
  dplyr::filter(Years>'1947')

# creating a new data frame which has maximum value for each year 
# (There were multiple records for each year this line collect only the max value of each year)
RWlengthgroupby_year <- data.frame(aggregate(lastseventyfive_years$`RW length`, 
                                             by = list(lastseventyfive_years$Years),
                                             max))

# assigning the names to columns of new dataframe created
names(RWlengthgroupby_year)[1] <- 'Year'
names(RWlengthgroupby_year)[2] <- 'Max_RW_Length'

# visualization of max RW length by year
ggplot(data = RWlengthgroupby_year, aes(x=Year, y=Max_RW_Length, group = 1))+
  geom_line(color='red')+
  geom_point()+
  labs(title = "Line Chart of Maximum RW length by years")+
  geom_text(aes(label=Max_RW_Length), vjust=-0.5, size=2.5)

