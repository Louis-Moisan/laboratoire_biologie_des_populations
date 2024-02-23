server <- function(input, output) {

#--------------------#
#### Exercice 2.1 ####
#--------------------#
  # Store generated numbers and count
  generatedData <- reactiveValues(
    survival = round(runif(1), digits= 3),
    fecundity = round(runif(1), digits= 3),
    individual = 1
  )
  
  # Generate random numbers and update the table
  observeEvent(input$generateButton, {
    survival <- round(runif(1), digits= 3)
    fecundity <- round(runif(1), digits = 3)
    
    generatedData$survival <- c(generatedData$survival, survival)
    generatedData$fecundity <- c(generatedData$fecundity, fecundity)
    generatedData$individual <- c(generatedData$individual, input$generateButton)
  })
  
  # Display the table
  output$numbersTable <- renderDataTable({
    data.frame(
      Individu = 1:length(generatedData$individual),
      `survie` = generatedData$survival,
      `fécondité` = generatedData$fecundity
    )
  })


#--------------------#
#### Exercice 2.2 ####
#--------------------#
output$growthPlot_2_2 <- renderPlot({
  #time steps
  time_steps <- seq(0, input$timeSteps_2_2)
  #Abondance initiale
  initial_abundance <- input$initialAbundance_2_2
  #Taux de croissance
  growth_rate <- input$growthRate_2_2
  #Réplicats
  num_replicates <- input$replicates_2_2
    #Si 0 donc déterministe et une seule courbe
  if(num_replicates == 0){
    num_replicates <- 1
  }
  #Stochasticité démographique
  
  #stochasticite_2_2
  #Survie
  #survival_2_2
  #fécondité
 # fecondity_2_2
  
  
  
  # Create an empty data frame to store all replicates data
  df_2_2 <- data.frame()
  
  for (i in 1:num_replicates) {
    population_size <- initial_abundance * exp(growth_rate * time_steps)
    df_2_2 <- rbind(df_2_2, data.frame(Time = time_steps, Population = population_size, Replicate = as.factor(i)))
  }
  
  ggplot(df_2_2, aes(x = round(Time, digits= 0), y =  round(Population, digits= 0), color = Replicate)) +
    geom_line() +
    labs(x = "Années", y = "Taille de population") +
    theme_minimal()+
    theme(legend.position = "none")
})

}