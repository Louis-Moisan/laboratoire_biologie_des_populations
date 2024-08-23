#--- Activer les librairies nécessaires
library(dplyr) #manipulation de données
library(kableExtra) #mise en forme tableau
library(rhandsontable) #mise en forme tableau

#Fonction utilisée pour transformer le input en un output donné. Par exemple un jeu de donnée excel en un tableau ou un graphique
server <- function(input, output) {

  
#-------------------------#
#### Fonction générale ####
#-------------------------#
  #--- Créer un graphique de la trajectoire de population (Taille de la population en fonction du temps)
graph_trajectoire_population <- function(data){
  renderPlotly({
    plot_ly(data(), x = ~Time, y = ~Population, type = 'scatter', mode = 'lines+markers') %>%
      layout(title = "Trajectoire de population",
             xaxis = list(title = "Temps (t)"),
             yaxis = list(title = "Taille de la population (N)"))
  })
}


#--------------------#
#### Exercice 1.2 ####
#--------------------#
# Define a reactive expression that updates when the actionButton is clicked
#Define Time zone
Sys.setenv(TZ="America/Montreal")

observeEvent(input$Timedepart, {
  # Store the current time in a reactive value
  depart<- Sys.time()
  
  # Update the output to display the current time
  output$depart <- renderText({
    format(depart, "%H:%M:%S")
  })
})

# Define a reactive expression that updates when the actionButton is clicked
observeEvent(input$Timeend, {
  # Store the current time in a reactive value
  end <- depart<- Sys.time()
  # Update the output to display the current time
  output$end <- renderText({
    format(end, "%H:%M:%S")
  })
})


#--- Table 1.3
table_1_3_df <- data.frame(
    `Année` = c("t", c(1800, 1850, 1870, 1890, 1910, 1930, 1950, 1970, 1975, 1980, 1985, 1990, 1995)),
    `Population (milliards)` = c("N(t)", c("0,91", "1,13", "1,30", "1,49", "1,70", "2,02", "2,51", "3,62", "3,97", "4,41", "4,84", "5,29", "5,75")),
    `Intervalle de temps` = c("T","-",c(50,20,20), c(rep("", times= 9))),
    `Population au recensement précédent` = c("N(t-T)","-" ,c("0,91", "1,13", "1,30", "1,49", "1,70", "2,02", "2,51", "3,62", "3,97", "4,41", "4,84", "5,29")),
    `Taux de croissance en T années` = c("N(t)/N(t-T)","-","1,24176", rep("", times=11)),
    `Taux de croissance annuel (R)` = c("[N(t)/N(t-T)]^(1/T)", "-", "1,00434", rep("", times=11)),
    # Avoid converting strings to factors
    check.names = FALSE)

output$table_1_3 <- function() {
  table_1_3_df %>% 
    knitr::kable("html") %>%
    kable_styling("striped", full_width = F)
}

#--- Plot and table 
# Initial empty data frame with specified column names
data_1_3 <- data.frame(Annee= as.integer(c(1850, 1870, 1890, 1910, 1930, 1950, 1970, 1975, 1980, 1985, 1990, 1995)), Taux_croissance_annuel=  round(c(1.00434 ,rep(NA, times= 11)), digits = 5), check.names = FALSE)

# Reactive value to store and update the data
reactiveData_1_3 <- reactiveVal(data_1_3)

# Render the rhandsontable
output$editableTable_1_3 <- renderRHandsontable({
  rhandsontable(reactiveData_1_3(), rowHeaders = NULL) %>% 
    hot_col("Taux_croissance_annuel", format = "0.0000")
})

# Update the data when the table is edited
observeEvent(input$editableTable_1_3, {
  df <- hot_to_r(input$editableTable_1_3)
  if (!is.null(df)) {
    reactiveData_1_3(df)
  }
})

# Render the plot based on the updated data
output$plot_sub_table_1_3 <- renderPlot({
  validData_1_3 <- reactiveData_1_3()[!is.na(reactiveData_1_3()$Taux_croissance_annuel), ]
  ggplot(validData_1_3, aes(x = Annee, y = Taux_croissance_annuel)) +
    geom_line(color= "steelblue4", size=1) +
    geom_point(color= "steelblue4", size=2) +
    theme_minimal() +
    labs(x = "Année", y = "Taux de croissance annuel")
})


#--- Table 1.4
table_1_4_df <- data.frame(
  `Année` = c(1975, 1985, 1995),
  `Taille de la population (milliards)` = c("3,97", "4,84", "5,75"),
  `Taux de croissance annuel (R)` = c("", "",""),
  `Nombre d’individus en plus chaque année` = c("", "", ""),
  # Avoid converting strings to factors
  check.names = FALSE)

output$table_1_4 <- function() {
  table_1_4_df %>% 
    knitr::kable("html") %>%
    kable_styling("striped", full_width = F)
}


#--------------------#
#### Exercice 1.3 ####
#--------------------#
#--- Table 1.5
table_1_5_df <- data.frame(
  `Année` = c(1995, 2005, 2015, 2025, 2035),
  `Fécondité (f)` = c("0,0273", "", "", "", ""),
  `Taux de croissance annuel (R)` = c("", "", "", "", 1),
  `Taux de croissance par décennie (R^10)` = c("", "", "", "", 1),
  `Population au début de la décade (milliards)` = c("5,75" ,"", "", "", ""),
  `Population à la fin de la décade (milliards)` = c("" ,"", "", "", ""),
  # Avoid converting strings to factors
  check.names = FALSE)

output$table_1_5 <- function() {
  table_1_5_df %>% 
    knitr::kable("html") %>%
    kable_styling("striped", full_width = F)
}


#------------------#
#### Exercice B ####
#------------------#
# Reactive expression for population calculation
  population_data_B <- reactive({
    time_steps_B <- 1:input$time_steps_B
    population_B <-  round(input$population_initiale_B * (input$taux_croissance_B ^ time_steps_B), digits = 0)
    data.frame(Time = time_steps_B, Population = population_B)
  })
  
  # Render the plot
  output$population_plot_B <- graph_trajectoire_population(population_data_B)
  
  # Render the table
  output$population_table_B <- renderDataTable({
    population_data_B()
  })
  
  
  #------------------#
  #### Exercice C ####
  #------------------#
  # Reactive expression for population calculation
  population_data_C <- reactive({
    time_steps_C <- 1:input$time_steps_C
    population_C <- round(input$population_initiale_C * ((input$taux_fecondite_C+ input$taux_survie_C) ^ time_steps_C), digits = 0)
    data.frame(Time = time_steps_C, Population = population_C)
  })
  
  # Render the plot
  output$population_plot_C <- graph_trajectoire_population(population_data_C)
  
  # Render the table
  output$population_table_C <- renderDataTable({
    population_data_C()
  })
  
  
  #------------------#
  #### Exercice D ####
  #------------------#
  # Reactive expression for population calculation
  population_data_D <- reactive({
    time_steps_D <- 1:input$time_steps_D
    population_D <- round(input$population_initiale_D * ((input$taux_fecondite_D+ input$taux_survie_D) ^ time_steps_D), digits = 0)
    data.frame(Time = time_steps_D, Population = population_D)
  })
  
  # Render the plot
  output$population_plot_D <- graph_trajectoire_population(population_data_D)
  
  # Render the table
  output$population_table_D <- renderDataTable({
    population_data_D()
  })
}