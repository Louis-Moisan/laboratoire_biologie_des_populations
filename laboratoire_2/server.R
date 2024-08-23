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
source("functions/exponential_growth.R")  
source("functions/extinction_decline.R")
source("functions/explosion_increase.R")
  
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
    DT::datatable(data.frame(
      Individu = 1:length(generatedData$individual),
      `survie` = generatedData$survival,
      `fécondité` = generatedData$fecundity), options = list(pageLength = 50))
  })


#--------------------#
#### Exercice 2.2 ####
#--------------------#
#--- Étape 1
#Calculer la taille de population pour chaque année
df_2_2_1 <- reactive(
  exponential_growth(
    duration=input$timeSteps_2_2_1, #Number of time step
    initial_abundance=input$initialAbundance_2_2_1 , #Initial population abundance
    survival=input$survival_2_2_1, #Average survival rate
    fecundity=input$fecundity_2_2_1, #Average fecundity rate
    growth_rate= input$survival_2_2_1+input$fecundity_2_2_1,
    standard_deviation_R=0, #Equivalent of environmental stochasticity
    demographic_stochasticity= FALSE, #TRUE or FALSE
    number_replicates=1)
  )  
  
#--- Graphique étape 1  
output$plot_2_2_1 <- renderPlot({
  ggplot(df_2_2_1(), aes(x = round(Time, digits= 0), y =  Population)) +
    geom_line() +
    labs(x = "Années (t)", y = "Taille de population (N)") +
    theme_minimal()+
    theme(legend.position = "none")
})

#--- Tableau étape 1
output$table_2_2_1 <- function() {
  df_2_2_1() %>% 
    dplyr::select(Time, Population) %>% 
    dplyr::rename(`Année`= Time, N= Population) %>% 
    knitr::kable("html") %>%
    kable_styling("striped", full_width = F)
}


#--- Étape 3
#Calculer la taille de population pour chaque année
  df_2_2_3 <- reactive(
    exponential_growth(
    duration=input$timeSteps_2_2_1, #Number of time step
    initial_abundance=input$initialAbundance_2_2_1 , #Initial population abundance
    survival=input$survival_2_2_1, #Average survival rate
    fecundity=input$fecundity_2_2_1, #Average fecundity rate
    growth_rate= input$survival_2_2_1+input$fecundity_2_2_1,
    standard_deviation_R=input$sd_R_2_2_3, #Equivalent of environmental stochasticity
    demographic_stochasticity= input$stochasticite_2_2_3, #TRUE or FALSE
    number_replicates=input$replicates_2_2_3)
    )

#--- Graphique étape 3
output$plot_2_2_3 <- renderPlot({
    ggplot(df_2_2_3(), aes(x = round(Time, digits= 0), y = round(Population, digits=0), group = Replicate, color = Replicate)) +
      geom_line() +
      labs(x = "Années (t)", y = "Taille de population (N)") +
      theme_minimal() +
      theme(legend.position = "none")
  })

#--- Étape 5
 #Extract the min,mean, sd, max of replicates (Simulations)
  df_2_2_5 <- reactive(
    df_2_2_3() %>% 
    dplyr::group_by(Time) %>% 
    dplyr::summarise(minimum= min(Population), moyenne= round(mean(Population), digits=0), `écart-type`= round(sd(Population), digits=0), maximum= max(Population))%>% 
    dplyr::rename(`Année`=Time)
    ) 

#--- Graphique étape 5
output$plot_2_2_5 <- renderPlot({
  ggplot(df_2_2_5(), aes(x=round(`Année`, digits= 0), y=moyenne)) + 
    geom_errorbar(aes(ymin=moyenne-`écart-type`, ymax=moyenne+`écart-type`), width=.1, col="red") +
    geom_line(col= "red") +
    geom_point(col="red")+
    labs(x = "Années (t)", y = "Taille de population (N)") +
    theme_minimal()+
    theme(legend.position = "none")
  })

#--- Tableau étape 5
output$table_2_2_5 <- function() {
  df_2_2_5() %>% 
    knitr::kable("html") %>%
    kable_styling("striped", full_width = F)
}

#--- Étape 7
df_2_2_7 <- reactive(
  extinction_decline(df_2_2_3())
)

#--- Grahique étape 7
output$plot_2_2_7 <- renderPlot({
  
  ggplot(df_2_2_7(), aes(x=minimum, y=probability)) + 
    geom_line(col= "blue") +
    geom_point(col="blue")+
    labs(x = "Taille minimum de population atteinte", y = "Probabilité") +
    theme_minimal()+
    theme(legend.position = "none")
})

#--- Tableau étape 7
output$table_2_2_7 <- function() {
  df_2_2_7() %>% 
    dplyr::rename(`probabilité`= probability) %>% 
    knitr::kable("html") %>%
    kable_styling("striped", full_width = F)
}


#--------------------#
#### Exercice 2.3 ####
#--------------------#
#--- Tableau étape 0
table_2_3_0_df <- data.frame(
  `Simulation`= c(1: 20),
  `Taille minimale de population atteinte (Nc)` = rep("", times=10),
  # Avoid converting strings to factors
  check.names = FALSE)

output$table_2_3_0 <- function() {
  table_2_3_0_df %>% 
    knitr::kable("html") %>%
    kable_styling("striped", full_width = F)
}


#--- Étape 1
#Calculer la taille de population pour chaque année
df_2_3_1 <- reactive(
  exponential_growth(
    duration=input$timeSteps_2_3_1, #Number of time step
    initial_abundance=input$initialAbundance_2_3_1 , #Initial population abundance
    survival=input$survival_2_3_1, #Average survival rate
    fecundity=input$fecundity_2_3_1, #Average fecundity rate
    growth_rate= input$survival_2_3_1+input$fecundity_2_3_1,
    standard_deviation_R=input$sd_R_2_3_1, #Equivalent of environmental stochasticity
    demographic_stochasticity= input$stochasticite_2_3_1, #TRUE or FALSE
    number_replicates=input$replicates_2_3_1)
)

#--- Graphique étape 1
output$plot_2_3_1 <- renderPlot({
  ggplot(df_2_3_1(), aes(x = round(Time, digits= 0), y = round(Population, digits=0), group = Replicate, color = Replicate)) +
    geom_line() +
    labs(x = "Années (t)", y = "Taille de population (N)") +
    theme_minimal() +
    theme(legend.position = "none")
})

#--- Tableau étape 1
output$table_2_3_1 <- function() {
  df_2_3_1() %>% 
    dplyr::filter(Time>0) %>% 
    dplyr::select(-Replicate) %>% 
    dplyr::rename(`Population (N)`= Population, `Année`=Time) %>% 
    knitr::kable("html") %>%
    kable_styling("striped", full_width = F)}

#--- Tableau étape 0
table_2_3_0_df <- data.frame(
  `Simulation`= c(1: 20),
  `Taille minimale de population atteinte (Nc)` = rep("", times=10),
  # Avoid converting strings to factors
  check.names = FALSE)

output$table_2_3_0 <- function() {
  table_2_3_0_df %>% 
    knitr::kable("html") %>%
    kable_styling("striped", full_width = F)
}

#--- Tableau étape 3
table_2_3_3_df <- data.frame(
  `Taille de la population (Nc)`= rep("", times= 10),
  `Nombre de simulations qui atteignent une taille =Nc` = rep("", times=10),
  `Nombre cumulé de simulations (qui atteignent une taille ≤Nc)` = rep("", times=10),
  `Probabilité de décliner à Nc` = rep("", times=10),
  # Avoid converting strings to factors
  check.names = FALSE)

output$table_2_3_3 <- function() {
  table_2_3_3_df %>% 
    knitr::kable("html") %>%
    kable_styling("striped", full_width = F)
}

#--- Étape 4
# Initial empty data frame with specified column names
data_2_3_4 <- data.frame(Taille_minimale_population_Nc= c(0, rep(NA, times= 19)),
                         Probabilite_decliner_Nc= c(0, rep(NA, times= 19)),
                         check.names = FALSE)

# Reactive value to store and update the data
reactiveData_2_3_4 <- reactiveVal(data_2_3_4)

# Render the rhandsontable
output$editableTable_2_3_4 <- renderRHandsontable({
  rhandsontable(reactiveData_2_3_4(), rowHeaders = NULL) %>% 
    hot_col("Probabilite_decliner_Nc", format = "0.0000")
})

# Update the data when the table is edited
observeEvent(input$editableTable_2_3_4, {
  df <- hot_to_r(input$editableTable_2_3_4)
  if (!is.null(df)) {
    reactiveData_2_3_4(df)
  }
})

# Render the plot based on the updated data
output$plot_2_3_4 <- renderPlot({
  validData_2_3_4 <- reactiveData_2_3_4()[!is.na(reactiveData_2_3_4()$Probabilite_decliner_Nc), ]
  ggplot(validData_2_3_4, aes(x = Taille_minimale_population_Nc, y = Probabilite_decliner_Nc)) +
    geom_line(color= "steelblue4", size=1) +
    geom_point(color= "steelblue4", size=2) +
    theme_minimal() +
    labs(x = "Taille minimale de la population (Nc)", y = "Probabilité de décliner à Nc")
})

#--------------------#
#### Exercice 2.4 ####
#--------------------#
#--- Étape 1
#Calculer la taille de population pour chaque année
df_2_4_1 <- reactive(
  exponential_growth(
    duration=input$timeSteps_2_4_1, #Number of time step
    initial_abundance=input$initialAbundance_2_4_1 , #Initial population abundance
    survival=input$survival_2_4_1, #Average survival rate
    fecundity=input$growth_rate_2_4_1-input$survival_2_4_1 , #Average fecundity rate
    growth_rate= input$growth_rate_2_4_1,
    standard_deviation_R=input$sd_R_2_4_1, #Equivalent of environmental stochasticity
    demographic_stochasticity= input$stochasticite_2_4_1, #TRUE or FALSE
    number_replicates=input$replicates_2_4_1)
)

#--- Graphique étape 1
output$plot_2_4_1 <- renderPlot({
  ggplot(df_2_4_1(), aes(x = round(Time, digits= 0), y = round(Population, digits=0), group = Replicate, color = Replicate)) +
    geom_line() +
    labs(x = "Années (t)", y = "Taille de population (N)") +
    theme_minimal() +
    theme(legend.position = "none")
})


#--- Étape 2
df_2_4_2 <- reactive(
  explosion_increase(df_2_4_1())
)

#--- Grahique étape 2
output$plot_2_4_2 <- renderPlot({
  
  ggplot(df_2_4_2(), aes(x=maximum, y=probability)) + 
    geom_line(col= "blue") +
    geom_point(col="blue")+
    labs(x = "Taille maximale de la population atteinte", y = "Probabilité") +
    theme_minimal()+
    theme(legend.position = "none")
})

#--- Tableau étape 2
output$table_2_4_2 <- function() {
  df_2_4_2() %>% 
    dplyr::rename(`probabilité`= probability) %>% 
    knitr::kable("html") %>%
    kable_styling("striped", full_width = F)
}

#--- Étape 3 
data_2_4_3 = data.frame(
  `Paramètre` = c("Abondance initiale (N)", "Taux de croissance (R)", "Taux de survie (s)", "Écart-type de R"),
  Valeur_originale = c(31, 1.148, 0.921, 0.075),
  Valeur_basse = c(28, rep(NA, times= 3)),
  Valeur_haute = c(34, rep(NA, times= 3))
  )

# Reactive value to store and update the data
reactiveData_2_4_3 <- reactiveVal(data_2_4_3)

# Render the rhandsontable
output$editableTable_2_4_3 <- renderRHandsontable({
  rhandsontable(reactiveData_2_4_3(), rowHeaders = NULL) %>% 
    hot_col("Valeur_originale", format = "0.0000") %>% 
    hot_col("Valeur_basse", format = "0.0000") %>% 
    hot_col("Valeur_haute", format = "0.0000") 
})

# Update the data when the table is edited
observeEvent(input$editableTable_2_4_3, {
  df <- hot_to_r(input$editableTable_2_4_3)
  if (!is.null(df)) {
    reactiveData_2_4_3(df)
  }
})


#--- Étape 4 
data_2_4_4 = data.frame(
  `Paramètre` = c("Abondance initiale (N)", "Taux de croissance (R)", "Taux de survie (s)", "Écart-type de R"),
  Probabilite_explosion_valeur_basse = c(0, rep(NA, times= 3)),
  Probabilite_explosion_valeur_haute = c(0, rep(NA, times= 3)),
  Difference= c(0, rep(NA, times= 3))
)

# Reactive value to store and update the data
reactiveData_2_4_4 <- reactiveVal(data_2_4_4)

# Render the rhandsontable
output$editableTable_2_4_4 <- renderRHandsontable({
  rhandsontable(reactiveData_2_4_4(), rowHeaders = NULL) %>% 
    hot_col("Probabilite_explosion_valeur_basse", format = "0.0000") %>% 
    hot_col("Probabilite_explosion_valeur_haute", format = "0.0000") %>% 
    hot_col("Difference", format = "0.0000") 
})

# Update the data when the table is edited
observeEvent(input$editableTable_2_4_4, {
  df <- hot_to_r(input$editableTable_2_4_4)
  if (!is.null(df)) {
    reactiveData_2_4_4(df)
  }
})
}