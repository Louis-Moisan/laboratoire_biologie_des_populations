# Shiny App: Laboratoire 3
# Auteur: Louis Moisan
# Date: 21 Août 2024

#Faire rouler le script pour l'interface de l'utilisateur
source("ui.R")

#Faire rouler le script pour les graphiques et tableaux dynamiques
source("server.R")

# Run the application
shinyApp(ui = ui, server = server)

