# Data332


# Team UMI Final Project

This final assignment consists of two final projects; 
1) Project-Insect Carnivore
2) Cabbage Butterfly

## Description

Raw data was provided in the form of .csv and .xlsx, the contributers used R Studio to clean the data and answer different questions. Exploratory Data Analysis was the key. The basic goal of EDA is to assist in the analysis of data before making any assumptions. It can aid in the detection of evident errors, as well as a better understanding of data patterns, the detection of outliers or unusual events, and the discovery of interesting relationships between variables. 

## Getting Started

## data clean up 

Our team struggled the most with data clean up and it is the most important part of any analysis. The reason we struggled so much was because we didn't know
what kindoff information we needed to present with the visualizations. Moreover, there were alot of rows in data sets so it is was hard to point out if the column of 
data is clean or not. To tackle this problem we collaborated as a team and first walk through the columns together to see if the data in them is clean or not.
Then we used filters in R, mutate function, select function, conditional statements and packages such as dplyr to clean both the datasets. In butterfly data set merge
function was used which is similar to vlook up in excel. This function was used to look up ID in the data set that wasn't tidy and then took columns from that data set
and joined them to tidy dataset. Lady bug dataset had alot of data which wasn't in correct format such as state had 'IA' and 'Ia' these were changed to 'Iowa' by 
the help of ifelse statement. This was helpful for making graphs with correct labels.

### Dependencies

* R or R Studio the collaborators of this project specifically used R Studio.
* Collaborator who worked on the Ladybug project used a Mac.

### Installing

* https://www.rstudio.com/
* Download R Studio from the aforementioned website.

### Executing program

Just download the library mentioned and run the program, it's as simple as that.



## Authors

Izan Khan 
izankhan18@augustana.edu
309-317-5552

Umer Aziz
umeraziz19@augustana.edu
312-912-1766

Azee
571-531-2728

# Code Snippets
### VISUALIZATIONS FOR LADY BUG DATASET

Graph showing Species count by plot type:
  This graph represents count of different species grouped by their plot, i.e. LP-AG, LP-GA, LP-GF, LP-GM, LP-GU, LP-IC and LP-PR. The graph was further sorted by number and the names of species were modified to eliminate spelling errors.
  
<img width="949" alt="Count_Species_Plot" src="https://user-images.githubusercontent.com/90479591/168454969-751d44fb-a528-487f-abb7-f2ebb40dd0b4.png">

Graph Showing Species Count by indentifier:
  This graph counts species according to their identifier. The purpose the graph serves is so anyone who wants to ask questions about a certain species they could just look at the visualization provided and could ask the identifier any question they have.
  
<img width="949" alt="Graph_Identifier" src="https://user-images.githubusercontent.com/90479591/168454974-8e435237-3705-49a8-8484-c9bfc8490cdb.png">

Graph showing species count based on State/Province:
  This last visualization is a graph that shows the number of species and the state they were found on. This could tell the audience which side of the river a specific species is found more on.
  
<img width="945" alt="Screen Shot 2022-05-17 at 5 53 37 PM" src="https://user-images.githubusercontent.com/90479591/168925207-baa7e86a-170b-453b-9463-284debaa3969.png">


### VISUALIZATIONS FOR BUTTERFLY DATASET

Line chart showing Maximum RW length by years:

We decided to use line chart for max RW length by years because we had alot of values so, it wouldn't be suitable to use other form of charts or graph.
We wanted to track the small changes over short period of time which is easier to show in line chart. Moreover, last 75 years is a good amount of time to
check max RW length. We found out that the max RW length has decreased compared to 1950s

![Line Chart of Maximum RW length by years](https://user-images.githubusercontent.com/61089434/168660025-4a7991db-ae9e-4267-b04d-5497ab9f35d2.png)

Graph showing mean of LW Apex by country:

Our group was curious to see what affect does location have on butterflies so we made bar graph of mean of LW apex by country to see that. 
We found out from the graph that the countries that have high temps with alot of rain have high avg of LW apex. This could be because it is 
hard for butterflies to survive in cold weather.

![Mean of LW Apex by country](https://user-images.githubusercontent.com/61089434/168660060-35058032-e176-45e9-91a8-11494d594c00.png)

Graph showing mean of LW width by gender:

Our group was curious to see how does gender affect characteristics of a butterfly so we made bar graph of mean of
LW width by gender to see that. The graph showed that female have high mean LW width compared to male this could be because females have to 
take care of their babies so they use their long wings to protect them.

![Mean of LW width by gender](https://user-images.githubusercontent.com/61089434/168660100-a8173d14-8202-4424-81a3-2628679c72e6.png)




