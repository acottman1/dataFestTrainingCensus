#Select and filter the dataset with a portion of the most predictive elemets of the data.

#select appropriate pakages
#if an error is thrown, install the packages.
#install.packages("tidyverse")
require(tidyverse)
#install.packages("readr")
require(readr)
 
#source the cleaning script
source('cleanScript.R')

#read in the data
blockData <- read_csv('pdb2019bgv6_us.csv')

#filter out everything but VA, MD, and DC entries.
#select the columns needed for visualization and remove the NA's

DMVdata<- blockData %>% 
  filter(State_name %in% c("Virginia", "Maryland", "District of Colombia") ) %>% 
  select(c(1:7,9,15, 193, 196, 199, 202, 205, 208, 211, 214,  220, 223, 226, 229, 232, 235, 238, 242, 262, 264, 266, 268, 270, 272, 301,314, 317, 319, 321, 323, 325, 328, 303, 335, 305 ), Low_Response_Score) %>% drop_na()

#remove the massive dataset
rm(blockData)
#convert the character money columns to useable numeric data
DMVdata[41:42] <- sapply(DMVdata[41:42],clean)

#take the top 20% of each important column .
DMVfilter <- DMVdata %>% filter( Low_Response_Score > quantile(Low_Response_Score, .8) & +
                                  (quantile(pct_ENG_VW_SPAN_ACS_13_17, .80) | +
                                     quantile(pct_Pop_under_5_ACS_13_17, .80) | +
                                     quantile(pct_Diff_HU_1yr_Ago_ACS_13_17, .80) | +
                                     quantile(avg_Agg_HH_INC_ACS_13_17, .2) 
                                  )
)
#write to a csv file touse in tableau or something like that.

write_csv(DMVfilter, "CensusDataFiltered.csv")
