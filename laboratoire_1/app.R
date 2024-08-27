# Shiny App: Laboratoire 1 - Croissance de population
# Auteur: Louis Moisan
# Création: 18 Janvier 2024
# Mise à jour: 19 Août 2024

# 1. Faire rouler le script pour l'interface de l'utilisateur
source("ui.R")

# 2. Faire rouler le script pour les graphiques et tableaux dynamiques
source("server.R")

# 3. Faire rouler l'application
shinyApp(ui = ui, server = server)

