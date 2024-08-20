#---------------------------------------------------------------#
#### Function to calculate probability of extinction decline ####
#---------------------------------------------------------------#
explosion_increase <- function(
    data_frame){ # A given data frame with a column Time, Population and Replicate

#Extract the number of replicates
number_replicates= length(unique(data_frame$Replicate))

#Calculate probability of going under a given population treshold
explosion_increase_df <- data_frame %>% 
  #Remove initial population size
  dplyr::filter(Time>0) %>% 
  #Retain only the minimum reach in each simulation or replicate
  dplyr::group_by(Replicate) %>% 
  dplyr::summarise(maximum= max(Population)) %>% 
  #Order the minimum values
  dplyr::arrange(maximum) %>% 
  #Extract the number of times the minimum has been reached
  dplyr::group_by(maximum) %>% 
  dplyr::summarise(frequency= n()) %>% 
  dplyr::ungroup() %>% 
  #Calculate the cumulative frequency
  dplyr::mutate(cumulative_freq=cumsum(frequency)) %>% 
  #Transform into probability by dividing with the total number of replicates
  dplyr::mutate(probability= cumulative_freq/number_replicates) %>% 
  dplyr::select(maximum, probability)
  
  return(explosion_increase_df)
}

