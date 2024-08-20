#-------------------------------------------------------#
#### Function to model population exponential growth ####
#-------------------------------------------------------#
exponential_growth <- function(
    duration, #Number of time step
    initial_abundance, #Initial population abundance
    survival, #Average survival rate
    fecundity, #Average fecundity rate
    standard_deviation_R, #Equivalent of environmental stochasticity
    demographic_stochasticity, #TRUE or FALSE
    number_replicates) #number of simulation to be run, only useful when using stochasticity
  {
 

#----------------------------#
#### Set model parameters ####  
#----------------------------#
#time steps
time_steps <- seq(0, duration)

#if replicate set at 0, then automatically run only a single determinist simulation
  if(number_replicates == 0) {
    number_replicates <- 1
    demographic_stochasticity <- FALSE #set demographic stochasticity to null
    standard_deviation_R <- 0 #set environmental stochasticity to null
  }


#---------------------#
#### Run the model ####
#---------------------#
# Create a data frame to store the output
output_df <- data.frame()
  
#If demographic stochasticity is considered
if(demographic_stochasticity == TRUE){
  
  #For each simulation (or replicate)
    for (i in 1:number_replicates){
      
      #And for each time step
      for (t in time_steps){
        
        #if time step is 0 define population size as initial population size
        if (t == 0) {
          population_size <- initial_abundance
          
        #else estimate population size at next time step
        } else {
          
          #If population was at 0 last step (extinct) skip next steps population size will be maintained at 0
          if(population_size==0){
            population_size= 0
         
          #If not, calculate population size while considering stochasticity
            } else { 
              
            #--- Environmental stochasticity ---#
             R_annual <-  rnorm(1, mean = (survival+fecundity), sd = standard_deviation_R)
             coef_environmental_stochas <- R_annual/(survival+fecundity)
             
            #Adjust annual survival based on standard deviation of R (environmental stochasticity) 
            survival_annual <- survival*coef_environmental_stochas
            #If survival is less than 0 set at 0 and if survival is more than 1 set to 1
            survival_annual <- ifelse(survival_annual < 0, 0, ifelse(survival_annual > 1, 1, survival_annual))
            
            #Adjust annual fecundity based on standard deviation of R (environmental stochasticity) 
            fecundity_annual<- fecundity*coef_environmental_stochas
            fecundity_annual <- ifelse(fecundity_annual < 0, 0, fecundity_annual)
            
            #--- Demographic stochasticity ---#
            #calculate the number of survivor annually using a binomial distribution (yes or no)
            survivors <- rbinom(population_size, 1, survival_annual)
            #calculate the number of offspring annually using a poisson distribution (left skewed)
            offspring <- rpois(sum(survivors), fecundity_annual)
            #Recalculate total annual population size
            population_size <- sum(survivors) + sum(offspring)
          }
        }
#--- Add the data of the given time step and simulation in the data frame        
  output_df <- rbind(output_df, data.frame(Time = t, Population = population_size, Replicate = i))
      }
    }

# If demographic stochasticity is set to FALSE, then run a determinist simulation
  }else {
    for (i in 1:number_replicates) {
      for (t in time_steps) { # Loop over each time step
        if (t == 0) {
          # if first time step use initial abundance as population size
          population_size <- initial_abundance
        } else {
          
          #--- Environmental stochasticity
          #Adjust growth rate based on standard deviation of R (environmental stochasticity) 
          growth_rate_annual <- rnorm(1, mean = (fecundity+survival), sd = standard_deviation_R)
          #If growth rate is less than 0 set at 0
          growth_rate_annual <- ifelse(growth_rate_annual < 0, 0, growth_rate_annual)
          
          #Estimate population size at next step using new growth rate
          population_size <- round(population_size * growth_rate_annual, digits=0)
        }
        output_df <- rbind(output_df, data.frame(Time = t, Population = population_size, Replicate = i))
      }
    }
  }
return(output_df)
} 
