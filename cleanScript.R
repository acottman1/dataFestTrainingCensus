#remove special characters, commas from character data and save it to a DF
clean <- function(x){
  as.numeric( gsub('[^a-zA-Z0-9.]', '', x))
}
dat$avg_Agg_HH_INC_ACS_13_17 <- clean(dat$avg_Agg_HH_INC_ACS_13_17)
str(dat)


