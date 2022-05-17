library(tidyverse)
library(dplyr)
library(readxl)
library(lubridate)
library(ggplot2)
library(tidytext)
library(hrbrthemes)
library(viridis)

setwd("/Users/izankhan/Desktop/Project-Insect-Carnivore-main/data")
ladybug_clean <- read_excel ("Ladybug Data.xlsx", sheet = 1)
ladybug_scan <- read.csv("Scan Ladybug Data.csv")

#change column name to join data
colnames(ladybug_scan)[8] <- "SCANCODE"
colnames(ladybug_clean)[8] <- "SCANCODE"


ladybug_state <- left_join(ladybug_clean,
                          ladybug_scan %>% dplyr::select(SCANCODE, stateProvince),
                          by = "SCANCODE")

## Fixing naming errors in the data
ladybug_clean <- ladybug_clean %>%
  dplyr::mutate(Species = ifelse((Species == 'Coccinella semtempuncata') | (Species == 'coccinella semtempuncata') | (Species == 'coccinella septempunctata') | (Species == 'Coccinella septempunctata') , 'Coccinella Septempunctata', Species))%>%
  dplyr::mutate(Species = ifelse((Species == 'Colemegilla maculata') | (Species == 'coleomegilla maculata') , "Coleomegilla maculata", Species)) %>%
  dplyr::mutate(Species = ifelse((Species == 'cycloneda munda') | (Species == 'Cycloneda Munda') , "Cycloneda munda", Species)) %>%
  dplyr::mutate(Species = ifelse((Species == 'Harminia axyridis') | (Species == 'harmonia axyrids') | (Species == 'Harmonia axyrisis') | (Species == 'harmonia axyridis'), "Harmonia axyridis", Species)) %>%
  dplyr::mutate(Species = ifelse((Species == 'hippodamia convergens') | (Species == 'Hippodamia covergence') , "Hippodamia convergens", Species)) %>%
  dplyr::mutate(Species = ifelse((Species == 'hippodamia parenthesis') , "Hippodamia parenthesis", Species)) %>%
  dplyr::mutate(Species = ifelse((Species == 'Propylea quatuordecimpuncata'), 'Propylea quatuordecimpunctata', Species)) %>%
  
  dplyr::mutate(collector = ifelse((collector == 'J Hughes') | (collector == 'J. Hughees') | (collector == 'j. hughes') | (collector == 'j. Hughes') | (collector == 'J. hughes') | (collector == 'jack hughes') | (collector == 'J. Hughes') , 'Jack Hughes', collector))%>%
  dplyr::mutate(collector = ifelse((collector == 'm gorsegner') | (collector == 'M. Gorsegner') | (collector == 'm. gorsegner') | (collector == 'M. gorsegner') | (collector == 'M.Gorsegner') , 'Marissa Gorsegner', collector))%>%
  dplyr::mutate(collector = ifelse((collector == 'O. Ruffatto') | (collector == 'o. ruffattto') | (collector == 'o. ruffatto') | (collector == 'O. ruffatto') | (collector == 'OliviaRuffatto') , 'Olivia Ruffatto', collector))%>%
  dplyr::mutate(collector = ifelse((collector == 'v cervantes') | (collector == 'V. Cervantes') | (collector == 'v. cervantes') | (collector == 'V. cervantes') | (collector == 'V.Cervantes') | (collector == 'Veronica Cervatnes') , 'Veronica Cervantes', collector))%>%
  
  dplyr::mutate(identifier = ifelse((identifier == 'J. Hughes') | (identifier == 'J. hughes') | (identifier == 'jack hughes') | (identifier == 'j. hughes') , 'Jack Hughes', identifier))%>%
  dplyr::mutate(identifier = ifelse((identifier == 'M. Gorsegner') | (identifier == 'm. Gorsegner') , 'Marissa Gorsegner', identifier))%>%
  dplyr::mutate(identifier = ifelse((identifier == 'O RUffatto') | (identifier == 'O. Ruffatto') | (identifier == 'O Ruffatto') | (identifier == 'o. ruffatto') | (identifier == 'O. ruffatto') , 'Olivia Ruffatto', identifier))%>%
  dplyr::mutate(identifier = ifelse((identifier == 'V. Cervantes') | (identifier == 'V. cervantes') | (identifier == 'v. cervantes') | (identifier == 'v. Cervantes') , 'Veronica Cervantes', identifier))%>%
  
  dplyr::mutate(plot = ifelse((plot == 'Lp-PR-5') , 'LP-PR-5', plot))%>%
  
  dplyr::select('Species', 'plot','A_E_V', 'date',  'coordinates', 'collector', 'identifier', 'SCANCODE')

##Species and their counts
df_speciesCount <- ladybug_clean %>%
  dplyr:: count(Species)

df_collectorCount <- ladybug_clean %>%
  dplyr:: count(collector)

df_identifierCount <- ladybug_clean %>%
  dplyr:: count(identifier)

## character to factor so different labels are displayed
ladybug_clean$Species <- as.factor(ladybug_clean$Species) 
ladybug_clean$plot <- as.factor(ladybug_clean$plot) 
ladybug_clean$A_E_V <- as.factor(ladybug_clean$A_E_V) 
ladybug_clean$collector <- as.factor(ladybug_clean$collector) 
ladybug_clean$identifier <- as.factor(ladybug_clean$identifier)

### Get hihg level overview of data ###
str(ladybug_clean)
summary(ladybug_clean)
class(ladybug_clean)

#view(ladybug_clean)
tail(ladybug_clean)


#plot
summary(ladybug_clean$Species)

#Removing numbers at the end to concise the data
ladybug_clean$plot <- str_replace_all(ladybug_clean$plot, c("-1" = "", "-2" = "", "-3" = "", "-4" = "", "-5" = ""))

# plot species by 'plot'
ladybug_species_count <- ladybug_clean %>%
  count(Species, plot)

ladybug_species_count %>%
  mutate(Species = reorder_within(
    x = Species,
    by = n,
    within = plot
    )) %>%
  ggplot(aes(x = Species, y= n , fill = plot )) +
  geom_col(show.legend = FALSE) +
  scale_x_reordered() +
  coord_flip() +
  facet_wrap(~ plot, scales = "free") +
  labs(x="Species", y = "Count")

#plot species by 'identifier'
ladybug_identifier_count <- ladybug_clean %>%
  count(Species, identifier)

ladybug_identifier_count %>%

  ggplot(aes(x = Species, y= n , fill = identifier )) +
  geom_col(show.legend = FALSE) +
  scale_x_reordered() +
  coord_flip() +
  facet_wrap(~ identifier) +
  labs(x="Species", y = "Count")

#Cleaning Data to reduce errors
ladybug_state <- ladybug_state %>%
  dplyr::mutate(stateProvince = ifelse((stateProvince == 'IL')  , 'Illinois', stateProvince))%>%
  dplyr::mutate(stateProvince = ifelse((stateProvince == 'IA') | (stateProvince == 'Ia') , 'Iowa', stateProvince))%>%
  
  dplyr::select('Species', 'plot','stateProvince')

ladybug_state_count <- ladybug_state %>%
  count(stateProvince, Species)

##remove NA values
ladybug_state_count <- ladybug_state_count[complete.cases(ladybug_state_count), ]

## Statewise individual graph
ladybug_state_count %>%
  ggplot(aes(x = Species, y= n , fill = stateProvince )) +
  geom_col(show.legend = FALSE) +
  scale_x_reordered() +
  coord_flip() +
  facet_wrap(~ stateProvince) +
  labs(x="Species", y = "Count")

##Stacked graph for species by state
ggplot(ladybug_state_count, aes(fill=stateProvince, y=n, x=Species)) + 
  geom_bar(position="stack", stat="identity") +
  coord_flip() +
  labs(x="Species", y = "Count")

