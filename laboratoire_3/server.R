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
    number_replicates= 0
      )
)

#--- Graphique étape 1 
output$plot_3_1_1 <- renderPlot({
  ggplot(data_3_1_1(), aes(x = round(Time, digits= 0), y =  Population)) +
    geom_line() +
    labs(x = "Jours (t)", y = "Taille de population (N)") +
    theme_minimal()+
    theme(legend.position = "none")+
    ylim(0,650)
})  


#--------------------#
#### Exercice 3.2 ####
#--------------------#
#--- Étape 1 
#Modéliser la dynamique de population
data_3_2_1 <- reactive(
  single_population_growth(
    duration= input$timeSteps_3_2_1, 
    initial_abundance= input$initialAbundance_3_2_1,
    survival= input$survival_3_2_1, 
    fecundity= input$fecundity_3_2_1,
    growth_rate= input$growth_rate_3_2_1,
    standard_deviation_R= 0, 
    density_dependence= input$competition_3_2_1, 
    carrying_capacity= input$carrying_capacity_3_2_1, 
    demographic_stochasticity= input$stochasticite_3_2_1, 
    number_replicates= input$replicates_3_2_1
  )
)

#--- Graphique étape 1 
output$plot_3_2_1 <- renderPlot({
  ggplot(data_3_2_1(), aes(x = round(Time, digits= 0), y =  Population, color = Replicate, group= Replicate)) +
    geom_line() +
    labs(x = "Jours (t)", y = "Taille de population (N)") +
    theme_minimal()+
    theme(legend.position = "none")+
    ylim(0,650)
})

#--------------------#
#### Exercice 3.3 ####
#--------------------#
#--- Étape 1 
#Modéliser la dynamique de population
data_3_3_1 <- reactive(
  single_population_growth(
    duration= input$timeSteps_3_3_1, 
    initial_abundance= input$initialAbundance_3_3_1,
    survival= NULL, 
    fecundity= NULL,
    growth_rate= input$growth_rate_3_3_1,
    standard_deviation_R= 0, 
    density_dependence= input$competition_3_3_1, 
    carrying_capacity= input$carrying_capacity_3_3_1, 
    demographic_stochasticity= FALSE, 
    number_replicates= 1
  )
)

#--- Graphique étape 1 
output$plot_3_3_1 <- renderPlot({
  ggplot(data_3_3_1(), aes(x = round(Time, digits= 0), y =  Population)) +
    geom_line() +
    labs(x = "Jours (t)", y = "Taille de population (N)") +
    theme_minimal()+
    theme(legend.position = "none")
})

#--------------------#
#### Exercice 3.4 ####
#--------------------#
data_3_4_1 <- data.frame(Temps_t= c(0:10), Taille_population_N= c(500,rep(NA, times= 10)), check.names = FALSE)
reactiveData_3_4_1 <- reactiveVal(data_3_4_1)
# Render the rhandsontable
output$editableTable_3_4_1 <- renderRHandsontable({
  rhandsontable(reactiveData_3_4_1(), rowHeaders = NULL)%>% 
    hot_col("Taille_population_N", format = "1")
})

# Update the data when the table is edited
observeEvent(input$editableTable_3_4_1, {
  df <- hot_to_r(input$editableTable_3_4_1)
  if (!is.null(df)) {
    reactiveData_3_4_1(df)
  }
})

# Render the plot based on the updated data
output$plot_sub_table_3_4_1 <- renderPlot({
  validData_3_4_1 <- reactiveData_3_4_1()[!is.na(reactiveData_3_4_1()$Taille_population_N), ]
  ggplot(validData_3_4_1, aes(x = Temps_t, y = Taille_population_N)) +
    geom_line(color= "steelblue4", size=1) +
    geom_point(color= "steelblue4", size=2) +
    theme_minimal() +
    labs(x = "Temps (t)", y = "Taille de population (N)")
})



#--- Étape 2 
#Modéliser la dynamique de population
data_3_4_2 <- reactive(
  single_population_growth(
    duration= input$timeSteps_3_4_2, 
    initial_abundance= input$initialAbundance_3_4_2,
    survival= NULL, 
    fecundity= NULL,
    growth_rate= input$growth_rate_3_4_2,
    standard_deviation_R= 0, 
    density_dependence= input$competition_3_4_2, 
    carrying_capacity= input$carrying_capacity_3_4_2, 
    demographic_stochasticity= input$stochasticite_3_4_2, 
    number_replicates= 1
  )
)

#--- Graphique étape 1 
output$plot_3_4_2 <- renderPlot({
  ggplot(data_3_4_2(), aes(x = round(Time, digits= 0), y =  Population)) +
    geom_line() +
    labs(x = "Jours (t)", y = "Taille de population (N)") +
    theme_minimal()+
    theme(legend.position = "none")
})


#--------------------#
#### Exercice 3.5 ####
#--------------------#
table_3_5_1_df <- data.frame(
  `Taille de population au début de l’année` = c(2000, 4000, 6000, 8000, 10000, 12000,14000),
  x= rep("x", times= 7),
  `Taux de survie naturelle`= rep("0,6", times= 7),
  `=`= rep("=", times= 7),
  `Nombre de survivants`= c("", "", "", "", 6000, "", ""),
  `-`= rep("-", times= 7),
  `Nombre d'individus récoltés`= rep(1000, times= 7),
  `=`= rep("=", times=7),
  `Nombre d'individus restant`= c("", "", "", "", 5000, "", ""),
  `÷`= rep("÷", times= 7),
  `Taille de population au début de l’année`= c(2000,4000, 6000, 8000, 10000, 12000, 14000),
  `=`= rep("=", times=7),
  `Taux de survie général`= c("", "", "", "", "0,5", "", ""),
  # Avoid converting strings to factors
  check.names = FALSE)

output$table_3_5_1 <- function() {
  table_3_5_1_df %>% 
    knitr::kable("html") %>%
    kable_styling("striped", full_width = F)
}


#--- Étape 2
data_3_5_2 <- data.frame(Taille_population_N= c(2000, 4000, 6000, 8000, 10000, 12000,14000),
                         Taux_survie_s= c(NA, NA, NA, NA, 0.5, NA, NA),
                         Strategie= rep("Nombre fixe", times=7),
                         check.names = FALSE)

reactiveData_3_5_2 <- reactiveVal(data_3_5_2)
# Render the rhandsontable
output$editableTable_3_5_2 <- renderRHandsontable({
  rhandsontable(reactiveData_3_5_2(), rowHeaders = NULL)%>% 
    hot_col("Taille_population_N", format = "0") %>% 
    hot_col("Taux_survie_s", format = "0.0000")
})

# Update the data when the table is edited
observeEvent(input$editableTable_3_5_2, {
  df <- hot_to_r(input$editableTable_3_5_2)
  if (!is.null(df)) {
    reactiveData_3_5_2(df)
  }
})

# Render the plot based on the updated data
output$plot_sub_table_3_5_2 <- renderPlot({
  validData_3_5_2 <- reactiveData_3_5_2()[!is.na(reactiveData_3_5_2()$Taux_survie_s), ]
  
  validData_3_5_3 <- reactiveData_3_5_3()[!is.na(reactiveData_3_5_3()$Taux_survie_s), ]

#Add data of table 3_5_3
  validData <- validData_3_5_2 %>% 
    rbind(validData_3_5_3)
  
  ggplot(validData, aes(x = Taille_population_N, y = Taux_survie_s, col= Strategie)) +
    geom_line(size=1) +
    geom_point(size=2) +
    theme_minimal() +
    labs(x = "Taille de population (N)", y = "Taux de survie (s)")
})

#--- Étape 3
data_3_5_3 <- data.frame(Taille_population_N= c(2000, 4000, 6000, 8000, 10000, 12000,14000),
                         Taux_survie_s= as.numeric(c(NA, NA, NA, NA, NA, NA, NA)),
                         Strategie= rep("Proportion fixe", times=7),
                         check.names = FALSE)

reactiveData_3_5_3 <- reactiveVal(data_3_5_3)
# Render the rhandsontable
output$editableTable_3_5_3 <- renderRHandsontable({
  rhandsontable(reactiveData_3_5_3(), rowHeaders = NULL)%>% 
    hot_col("Taille_population_N", format = "0") %>% 
    hot_col("Taux_survie_s", format = "0.0000")
})

# Update the data when the table is edited
observeEvent(input$editableTable_3_5_3, {
  df <- hot_to_r(input$editableTable_3_5_3)
  if (!is.null(df)) {
    reactiveData_3_5_3(df)
  }
})


#------------------#
#### Exercice A ####
#------------------#
#--- Étape 1 
#Modéliser la dynamique de population
data_A <- reactive(
  single_population_growth(
    duration= input$timeSteps_A, 
    initial_abundance= input$initialAbundance_A,
    survival= NULL, 
    fecundity= NULL,
    growth_rate= input$growth_rate_A,
    standard_deviation_R= 0, 
    density_dependence= input$competition_A, 
    carrying_capacity= input$carrying_capacity_A, 
    demographic_stochasticity= FALSE, 
    number_replicates= 1
  )
)

#--- Graphique étape 1 
output$plot_A <- renderPlot({
  ggplot(data_A(), aes(x = round(Time, digits= 0), y =  Population)) +
    geom_line() +
    labs(x = "Années (t)", y = "Taille de population (N)") +
    theme_minimal()+
    theme(legend.position = "none")
})

#--- Tableau étape 1
output$table_A <- function() {
  data_A() %>% 
    dplyr::select(-Replicate) %>% 
    knitr::kable("html") %>%
    kable_styling("striped", full_width = F)
}

#--- Étape 2
data_A_2 <- data.frame(Temps_t= c(0,5,10,15,20),
                      Abundance_initiale_10= as.numeric(c(NA, NA, NA, NA, NA)),
                      Abundance_initiale_450= as.numeric(c(NA, NA, NA, NA, NA)),
                      Abundance_initiale_700= as.numeric(c(NA, NA, NA, NA, NA)),
                         check.names = FALSE)

reactiveData_A_2 <- reactiveVal(data_A_2)
# Render the rhandsontable
output$editableTable_A_2 <- renderRHandsontable({
  rhandsontable(reactiveData_A_2(), rowHeaders = NULL)%>% 
    hot_col("Temps_t", format = "0") %>% 
    hot_col("Abundance_initiale_10", format = "0") %>% 
    hot_col("Abundance_initiale_450", format = "0") %>% 
    hot_col("Abundance_initiale_700", format = "0")
})

# Update the data when the table is edited
observeEvent(input$editableTable_A_2, {
  df <- hot_to_r(input$editableTable_A_2)
  if (!is.null(df)) {
    reactiveData_A_2(df)
  }
})

#------------------#
#### Exercice B ####
#------------------#
#--- Étape 1 
#Modéliser la dynamique de population
data_B <- reactive(
  single_population_growth(
    duration= input$timeSteps_B, 
    initial_abundance= input$initialAbundance_B,
    survival= NULL, 
    fecundity= NULL,
    growth_rate= input$growth_rate_B,
    standard_deviation_R= 0, 
    density_dependence= input$competition_B, 
    carrying_capacity= input$carrying_capacity_B, 
    demographic_stochasticity= FALSE, 
    number_replicates= 1
  )
)

#--- Graphique étape 1 
output$plot_B <- renderPlot({
  ggplot(data_B(), aes(x = round(Time, digits= 0), y =  Population)) +
    geom_line() +
    labs(x = "Années (t)", y = "Taille de population (N)") +
    theme_minimal()+
    theme(legend.position = "none")
})

#--- Tableau étape 1
output$table_B <- function() {
  data_B() %>% 
    dplyr::select(-Replicate) %>% 
    knitr::kable("html") %>%
    kable_styling("striped", full_width = F)
}

#--- Étape 2
data_B_2 <- data.frame(Temps_t= c(0,5,10,15,20),
                       Capacite_biotique_300= as.numeric(c(NA, NA, NA, NA, NA)),
                       Capacite_biotique_100= as.numeric(c(NA, NA, NA, NA, NA)),
                       Capacite_biotique_50= as.numeric(c(NA, NA, NA, NA, NA)),
                       Capacite_biotique_3000= as.numeric(c(NA, NA, NA, NA, NA)),
                       check.names = FALSE)

reactiveData_B_2 <- reactiveVal(data_B_2)
# Render the rhandsontable
output$editableTable_B_2 <- renderRHandsontable({
  rhandsontable(reactiveData_B_2(), rowHeaders = NULL)%>% 
    hot_col("Temps_t", format = "0") %>% 
    hot_col("Capacite_biotique_300", format = "0") %>% 
    hot_col("Capacite_biotique_100", format = "0") %>% 
    hot_col("Capacite_biotique_50", format = "0") %>% 
    hot_col("Capacite_biotique_3000", format = "0")
})

# Update the data when the table is edited
observeEvent(input$editableTable_B_2, {
  df <- hot_to_r(input$editableTable_B_2)
  if (!is.null(df)) {
    reactiveData_B_2(df)
  }
})


#------------------#
#### Exercice C ####
#------------------#
#--- Étape 1 
#Modéliser la dynamique de population
data_C <- reactive(
  single_population_growth(
    duration= input$timeSteps_C, 
    initial_abundance= input$initialAbundance_C,
    survival= NULL, 
    fecundity= NULL,
    growth_rate= input$growth_rate_C,
    standard_deviation_R= 0, 
    density_dependence= input$competition_C, 
    carrying_capacity= input$carrying_capacity_C, 
    demographic_stochasticity= FALSE, 
    number_replicates= 1
  )
)

#--- Graphique étape 1 
output$plot_C <- renderPlot({
  ggplot(data_C(), aes(x = round(Time, digits= 0), y =  Population)) +
    geom_line() +
    labs(x = "Années (t)", y = "Taille de population (N)") +
    theme_minimal()+
    theme(legend.position = "none")
})

#--- Tableau étape 1
output$table_C <- function() {
  data_C() %>% 
    dplyr::select(-Replicate) %>% 
    knitr::kable("html") %>%
    kable_styling("striped", full_width = F)
}

#--- Étape 2
data_C_2 <- data.frame(Temps_t= c(0,5,10,15,20),
                       Competition= c(rep("interférence avec plafond", times= 5)),
                       Taux_croissance_1.8= as.numeric(rep(NA, times=5)),
                       Taux_croissance_1.6= as.numeric(rep(NA, times=5)),
                       check.names = FALSE)

reactiveData_C_2 <- reactiveVal(data_C_2)
# Render the rhandsontable
output$editableTable_C_2 <- renderRHandsontable({
  rhandsontable(reactiveData_C_2(), rowHeaders = NULL)%>% 
    hot_col("Temps_t", format = "0") %>% 
    hot_col("Taux_croissance_1.8", format = "0") %>% 
    hot_col("Taux_croissance_1.6", format = "0")
})

# Update the data when the table is edited
observeEvent(input$editableTable_C_2, {
  df <- hot_to_r(input$editableTable_C_2)
  if (!is.null(df)) {
    reactiveData_C_2(df)
  }
})

#--- Étape 3
data_C_3 <- data.frame(Temps_t= c(0,5,10,15,20),
                       Competition= c(rep("interférence", times= 5)),
                       Taux_croissance_1.8= as.numeric(rep(NA, times=5)),
                       Taux_croissance_1.6= as.numeric(rep(NA, times=5)),
                       check.names = FALSE)

reactiveData_C_3 <- reactiveVal(data_C_3)
# Render the rhandsontable
output$editableTable_C_3 <- renderRHandsontable({
  rhandsontable(reactiveData_C_3(), rowHeaders = NULL)%>% 
    hot_col("Temps_t", format = "0") %>% 
    hot_col("Taux_croissance_1.8", format = "0") %>% 
    hot_col("Taux_croissance_1.6", format = "0")
})

# Update the data when the table is edited
observeEvent(input$editableTable_C_3, {
  df <- hot_to_r(input$editableTable_C_3)
  if (!is.null(df)) {
    reactiveData_C_3(df)
  }
})
}