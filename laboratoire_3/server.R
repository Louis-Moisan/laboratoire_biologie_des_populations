server <- function(input, output) {

#--------------------------#  
#### General librairies ####  
#--------------------------#
library(dplyr)
library(kableExtra)
library(knitr)
library(rhandsontable)
  
#---------------------------#
#### Personnal functions ####  
#---------------------------#
source("functions/single_population_growth.R")
  
#--------------------#
#### Exercice 3.1 ####
#--------------------#
#--- Étape 1 
#Modéliser la dynamique de population
data_3_1_1 <- reactive(
  single_population_growth(
    duration= input$timeSteps_3_1_1, 
    initial_abundance= input$initialAbundance_3_1_1,
    survival= NULL, 
    fecundity= NULL,
    growth_rate= input$growth_rate_3_1_1,
    standard_deviation_R= 0, 
    density_dependence= input$competition_3_1_1, 
    carrying_capacity= input$carrying_capacity_3_1_1, 
    demographic_stochasticity= FALSE, 
    number_replicates= input$replicates_3_1_1
      )
)

#--- Graphique étape 1 
output$plot_3_1_1 <- renderPlot({
  ggplot(data_3_1_1(), aes(x = round(Time, digits= 0), y =  Population)) +
    geom_line() +
    labs(x = "Années (t)", y = "Taille de population (N)") +
    theme_minimal()+
    theme(legend.position = "none")
})  
  
  
}