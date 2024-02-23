#Activer le package shinydashboard
library(shinydashboard)
library(plotly)
library(DT)

#Définir l'interface de l'utilisateur
ui <- dashboardPage(
  #Définir le titre de la page web
  dashboardHeader(title = "Laboratoire 2"),
  
  #Définir les différents exercices du laboratoires
  dashboardSidebar(
    # Sidebar menu with items for each exercise
    sidebarMenu(
      id = "tabs",
      menuItem("Exercice 2.1", tabName = "exercise_2_1"),
      menuItem("Exercice 2.2", tabName = "exercise_2_2"),
      menuItem("Exercice 2.3", tabName = "exercise_2_3"),
      menuItem("Exercice 2.4", tabName = "exercise_2_4")
    )
  ),
  
  #Définir le contenu de la page web
  dashboardBody(
    #Préciser la taille des marges gauche et droite
    style = "margin-left: 40px; margin-right: 40px;",
    tabItems(
      
      
      #-------------------#
      ##### Exercice 2.1 ####
      #-------------------#
      tabItem(tabName = "exercise_2_1",  #Nom de l'objet de la page dans R
              #--- Titre et mise en contexte
              fluidRow(
                #Définir le titre de la première section
                titlePanel("Exercice 2.1 : Tenir compte de la stochasticité démographique"),
                #Taille du texte, justifier et ajouter de l'espace en dessous
                style = "text-align: justify; font-size: 16px; margin-bottom: 40px;", 
                box(width = 12, #Définir la taille de l'a boîte pour l'encadré pour le texte
                    #Ajouter la mise en contexte
                    p("Dans cet exercice, vous allez prédire le changement dans la taille de la population de bœufs musqués entre 1936 et 1937, en tenant compte de la stochasticité démographique. Pour cet exercice, vous aurez besoin de générer des nombres aléatoires uniformes."),
                    img(src = "boeuf_musque.jpeg", width= "300px", align = "center"),
                )
              ),
              fluidRow(
                style = "text-align: justify; font-size: 16px; margin-bottom: 20px;", 
                box(width=12,
                    p(HTML("<b>Étape 1</b>: La population de bœufs musqués comprenait 31 individus en 1936. Écrivez ce nombre (N=31) sur un bout de papier. Les étapes qui suivent (1.1 et 1.2) devront être répétées 31 fois, une fois pour chaque bœuf musqué sur Nunivak Island en 1936. Pour chaque répétition, utilisez une nouvelle paire de nombres aléatoires.")),
                    p(HTML("<b>Étape 1.1</b>: Utilisez le premier nombre aléatoire pour décider si l’animal produit un jeune ou non. Si le premier nombre aléatoire est inférieur au taux de fécondité (f=0.227), alors augmentez N de 1, sinon, laissez le inchangé.")),
                    p(HTML("<b>Étape 1.2</b>: Utilisez le deuxième nombre pour décider si l’animal survit ou meurt. Si le deuxième nombre est supérieur au taux de survie (s=0.921), alors diminuez N de 1, sinon, laissez le inchangé.")),
                    p(HTML("<b>Étape 2</b>: Après avoir répété les étapes ci-dessus 31 fois, notez le N final. C’est votre estimation de la taille de la population de bœufs musqués en 1937.")),
                    p(HTML("<b>Étape 3</b>: Répétez les étapes 1 et 2 quatre fois, pour un total de cinq essais. Vous aurez cinq estimations de la taille de la population de bœufs musqués en 1937. Commentez la variabilité parmi les résultats des cinq essais."))
                    )
                  ),
              
              #--- Ajouter boîte pour tirer des nombres aléatoires
              fluidRow(
                style = "margin-bottom: 40px;",
              actionButton("generateButton", "Tirer une probabilité aléatoire de survie et de fécondité pour un individu"),
              dataTableOutput("numbersTable")
              )
            ),
      
      
      #------------------#
      #### Exercice 2.2 ####
      #------------------#
      tabItem(tabName = "exercise_2_2",
              fluidRow(
                #Définir le titre de section
                titlePanel("Exercice 2.2: Construire un modèle pour le bœuf musqué"),
                style = "text-align: justify; font-size: 16px; margin-bottom: 10px;", 
                box(width = 12,
                    #Ajouter la mise en contexte
                    p(HTML("<b>Étape 1</b>:Entrez les paramètres suivants pour faire une simulation déterministe")),
                    p(HTML("<ol>
                             <li>Réplications= 0</li>
                             <li>Nombre d'années (time steps)= 12</li>
                             <li>Abondance initiale= 31</li>
                             <li>Taux de croissance= 1.148</li>
                             <li>Densité dépendance: aucune (croissance exponentielle)</li>
                           </ol>"
                           )),
                    p(HTML("<i>NOTES: En utilisant une réplication de 0 (scénario déterministe) cela signifie qu'on fait une seule simulation et nous avons alors aucun réplicat. Il est donc impossible de calculer une moyenne et un écart type sur les simulations effectuées.</i>"))
                )
              ),
              
              fluidRow(
                box(width = 12,
                column(width=8,
                      plotOutput("growthPlot_2_2")),
                column(width=4,
  numericInput("timeSteps_2_2", "Nombre d'années:", min = 1, max = 100, value = 1),
  numericInput("initialAbundance_2_2", "Taille de population initiale:", min = 1, max = 1000, value = 1),
  numericInput("growthRate_2_2", "Taux de croissance:", min = 0, max = 10, value = 1),
  numericInput("replicates_2_2", "Réplications:", min = 0, max = 1000, value = 1),
  radioButtons("stochasticite_2_2", label = "Stochasticité démographique",
               choices = list("Oui" = TRUE, "Non" = FALSE),
               selected = "yes"),
  numericInput("survival_2_2", "Taux de survie (s):", min = 0, max = 1, value = 1),
  numericInput("fecondity_2_2", "Fécondité (f):", min = 0, max = 20, value = 1),
  numericInput("sd_R_2_2", "Écart-type de R (stochasticité environnementale:", min = 0, max = 20, value = 0)
  
  #POISSON DISTRIBUTION POUR FÉCONDITÉ DANS RAMAS
  #DISTRIBUTION NORMALE MORTALITÉ 
  
              )
            )
          )
        ),
      
      
      
      #------------------#
      #### Exercice 2.3 ####
      #------------------#
      tabItem(tabName = "exercise_2_3",
              fluidRow(
                #Définir le titre de section
                titlePanel("Exercice 2.3: Construire des courbes de risque"),
                style = "text-align: justify; font-size: 16px; margin-bottom: 10px;", 
                box(width = 12,
                    #Ajouter la mise en contexte
                    p("La baleine bleue est peut-être le plus grand animal n’ayant jamais vécu sur terre, mesurant jusqu’à 33 mètres (110 pieds) et pesant jusqu’à 17 tonnes (38000 livres). Il y a 3 populations distinctes de baleines bleues, soit celles habitant l’Atlantique Nord, le Pacifique Nord et l’hémisphère sud. Les 2 populations nordiques restent isolées l’une de l’autre de part les continents séparant les 2 océans. Les populations du nord et du sud restent également isolées les unes des autres, car chacune migre vers les tropiques seulement durant les mois froids de leur hémisphère respectif. Avant l’exploitation par l’homme, 90% des baleines bleues vivait dans l’hémisphère sud, avec un effectif de 150 000 à 210 000 individus. Au cours des deux derniers siècles, les activités de chasse ont fait pression essentiellement sur cette population.")
              )
            )
          ),#tab item 2.3
      #------------------#
      #### Exercice 2.3 ####
      #------------------#
      tabItem(tabName = "exercise_2_4",
              fluidRow(
                #Définir le titre de section
                titlePanel("Exercice 2.4: Analyse de sensibilité"),
                style = "text-align: justify; font-size: 16px; margin-bottom: 10px;", 
                box(width = 12,
                    #Ajouter la mise en contexte
                    p("La baleine bleue est peut-être le plus grand animal n’ayant jamais vécu sur terre, mesurant jusqu’à 33 mètres (110 pieds) et pesant jusqu’à 17 tonnes (38000 livres). Il y a 3 populations distinctes de baleines bleues, soit celles habitant l’Atlantique Nord, le Pacifique Nord et l’hémisphère sud. Les 2 populations nordiques restent isolées l’une de l’autre de part les continents séparant les 2 océans. Les populations du nord et du sud restent également isolées les unes des autres, car chacune migre vers les tropiques seulement durant les mois froids de leur hémisphère respectif. Avant l’exploitation par l’homme, 90% des baleines bleues vivait dans l’hémisphère sud, avec un effectif de 150 000 à 210 000 individus. Au cours des deux derniers siècles, les activités de chasse ont fait pression essentiellement sur cette population.")
                )
              )
            )#tab item 2.4
          ) #TabItems
        ) #Dashboardbody
      ) #DashboardPage
