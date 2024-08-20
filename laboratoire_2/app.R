# Shiny App: Laboratoire 2
# Auteur: Louis Moisan
# Date: 18 Janvier 2024

#Faire rouler le script pour l'interface de l'utilisateur
source("ui.R")

#Faire rouler le script pour les graphiques et tableaux dynamiques
source("server.R")

# Run the application
shinyApp(ui = ui, server = server)

