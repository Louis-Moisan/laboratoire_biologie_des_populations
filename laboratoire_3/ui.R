#--- Activer les librairies nécessaires ---#
library(shiny) # Transforme code R en application
library(shinydashboard) # Thématique de mise en page
library(plotly) #Graphiques
library(DT) #Tableaux
library(rhandsontable)

#--- Définir l'interface de l'utilisateur
ui <- dashboardPage(
  
#--- Définir le titre de la page web
dashboardHeader(title = "Laboratoire 3"),
  
#--- Définir la liste déroulante sur le côté de la page
dashboardSidebar(
    #Définir les exercices du laboratoire dans la liste déroulante
    sidebarMenu(
      id = "tabs",
      menuItem("Exercice 3.1", tabName = "exercice_3_1"),
      menuItem("Exercice 3.2", tabName = "exercice_3_2"),
      menuItem("Exercice 3.3", tabName = "exercice_3_3"),
      menuItem("Exercice 3.4", tabName = "exercice_3_4"),
      menuItem("Exercice 3.5", tabName = "exercice_3_5"),
      menuItem("Exercice A", tabName = "exercice_A"),
      menuItem("Exercice B", tabName = "exercice_B"),
      menuItem("Exercice C", tabName = "exercice_C")
    )
  ),
  
#--- Définir le contenu de la page web
dashboardBody(
    #Préciser la taille des marges gauche et droite
    style = "margin-left: 40px; margin-right: 40px;",
    tabItems(
      
      
#---------------------#
##### Exercice 3.1 ####
#---------------------#
#--- Nom de l'objet de la page dans R
tabItem(tabName = "exercice_3_1",  

#--- Ajouter une section pour intégrer des boîtes et du texte
fluidRow(
  #Définir le titre de l'exercice
  titlePanel("Exercice 3.1: L’expérience de Gause avec Paramecium"),
  #Taille du texte, justifier et ajouter de l'espace en dessous
  style = "text-align: justify; font-size: 16px; margin-bottom: 20px;",
    
    #--- Ajouter une boîte pour la mise en contexte
     box(width = 12,
     p("Dans cet exercice nous allons essayer de modéliser la croissance de la population de Paramecium de l’expérience de Gause en utilisant RAMAS Ecolab.")
         )
    ),

#--- Ajouter une image de boeuf musqué
fluidRow(
  style = "text-align: center; font-size: 16px; margin-bottom: 20px;",
  tags$figure(
    class = "centerFigure",
    tags$img(
    src = "paramecia.jpg",
    width = 250)
    )
  ),

#--- Étape 1
fluidRow(
  style = "text-align: justify; font-size: 16px; margin-bottom: 20px;", 
  box(width=12,
   p(HTML("<b>Étape 1</b>: Nous commencerons avec un modèle déterministe, donc nous réglerons le nombre de répétitions à 0 (c’est de cette manière que l’on indique au programme de faire une simulation déterministe). La durée sera de 25 jours (25 unités de temps). Le programme n’a pas besoin de savoir que les unités de temps sont en jours. Entrez ensuite 2 comme taille de population initiale. Sélectionnez ensuite la compétition par exploitation («scramble competition») comme type de densité-dépendance. Il faut ensuite saisir le taux de croissance. En présence de densité-dépendance, le taux de croisssance que l'on doit saisir est le taux de croissance maximale de la population lorsque les effets densité-dépendants sont très faibles ou nulls, donc lorsque la population est de petite taille. Ce paramètre devrait être plus grand que 1. Nous estimerons ce paramètre par essai/erreur. Faites un premier essai avec 1,5. Notez que c’est le taux de croissance par jour puisque notre unité de temps est de un jour. Le troisième paramètre est la capacité biotique, K, qui équivaut à la taille de la population à l’équilibre. Estimez ce nombre d’après le nombre moyen d’individus après le jour 12 sur la figure 3.8 (ci-dessous) et entrez le dans la ligne correspondant à la capacité de support. 
")),
   column(width=8,
          plotOutput("plot_3_1_1")),
   column(width=4,
          numericInput("timeSteps_3_1_1", "Nombre d'années:", min = 1, max = 100, value = 1),
          numericInput("initialAbundance_3_1_1", "Taille de population initiale:", min = 1, max = 10000, value = 1),
          numericInput("growth_rate_3_1_1", "Taux de croissance (R):", min = 0, max = 20, value = 1),
          radioButtons("competition_3_1_1", label = "Densité-dépendance", choices = list("exponentielle" = "exponential", "exploitation" = "scramble", "interférence"= "contest", "plafond"= "ceiling"), selected = "exponential"),
          numericInput("carrying_capacity_3_1_1", "Capacité biotique (K):", min = 1, max = 100000, value = 1),
          numericInput("replicates_3_1_1", "Réplications:", min = 0, max = 1000, value = 1)
      )
    )
  ),

#--- Ajouter une image de boeuf musqué
fluidRow(
  style = "text-align: center; font-size: 16px; margin-bottom: 20px;",
  tags$figure(
    class = "centerFigure",
    tags$img(
      src = "figure_3_8.png",
      width = 500)
  )
),

#--- Étape 2
fluidRow(
  style = "text-align: justify; font-size: 16px; margin-bottom: 20px;", 
  box(width=12,
      p(HTML("<b>Étape 2</b>: La trajectoire prédite ressemble-t-elle à la trajectoire observée dans la figure 3.8? Est-ce qu’elle atteint la capacité de support autour du douzième jour comme le faisait la population expérimentale? Si elle atteint la capacité de support plus tôt, cela veut dire que le taux de croissance que l’on a estimé est trop rapide. Si elle atteint la capacité de support après le douzième jour, c’est que le taux de croissance estimé est trop lent.")),

#--- Étape 3
      p(HTML("<b>Étape 3</b>: Répétez l’étape 2 en changeant le taux de croissance en fonction des résultats que vous obtenez jusqu’à ce que vous trouviez le R (taux de croissance) qui permet d’obtenir une vitesse de croissance semblable à celle de la population expérimentale (fig. 3.8).
	Comparez la dynamique de la population prédite par votre modèle et les observations réelles de la figure 3.8 et ce, spécialement pour la deuxième partie du graphique (après le douzième jour).")),

#--- Étape 3
p(HTML("<b>Étape 4</b>: Réglez la taille de la population initiale à 800, et faites tourner une autre simulation. Décrivez la trajectoire de population."))
    )
  )
), #end tab item 3.1

      
#--------------------#
#### Exercice 3.2 ####
#--------------------#
tabItem(tabName = "exercice_3_2",

fluidRow(
  titlePanel("Exercice 3.2: Ajouter de la stochasticité à la densité dépendance"),
  style = "text-align: justify; font-size: 16px; margin-bottom: 10px;",
          
#--- Mise en contexte
  box(width = 12,
    p("Dans l’exercice précédent nous avons ignoré la variabilité. Ajouter de la stochasticité à un modèle densité dépendant peut se faire de plusieurs manières. Dans cet exercice nous allons intégrer la stochasticité démographique."),
    p("Dans ses expériences, Gause essaya de garder les conditions de son laboratoire stables et a certainement réussi à maintenir constantes la température, la lumière, l’humidité, la nourriture, etc. Malgré cela, nous observons des variations considérables dans la taille de la population de Paramecium. Cette variabilité peut être due à la stochasticité démographique dont nous avons discuté au chapitre 2. Pour tester cette hypothèse, nous pouvons ajouter de la stochasticité démographique au modèle que vous avez développé à l’exercice précédent.")
    )
  ),
  
#--- Étape 1
fluidRow(
  style = "text-align: justify; font-size: 16px; margin-bottom: 10px;",
  box(width = 12,
     p(HTML("<b>Étape 1.</b> "))   
    )
  ),

#--- Étape 2
fluidRow(
  style = "text-align: justify; font-size: 16px; margin-bottom: 10px;",
  box(width = 12,
    p(HTML("<b>Étape 2</b>: "))
    )
  ),
  
#--- Étape 3
fluidRow(
  style = "text-align: justify; font-size: 16px; margin-bottom: 10px;",
  box(width = 12,
    p(HTML("<b>Étape 3.</b>"))   
    )
  ),
  
#--- Étape 5
fluidRow(
  style = "text-align: justify; font-size: 16px; margin-bottom: 10px;",
  box(width = 12,
    p(HTML("<b>Étape 4.</b>"))
    )
  )
), #end tabitem 3.2
    
      
#--------------------#
#### Exercice 3.3 ####
#--------------------#
tabItem(tabName = "exercice_3_3",
        
fluidRow(
  titlePanel("Exercice 3.3: Explorer les différences entre types de densité dépendance"),
  style = "text-align: justify; font-size: 16px; margin-bottom: 10px;",
  box(width = 12,
    p("Dans cet exercice ...")
    )
   )
),#tab item 3.3


#--------------------#
#### Exercice 3.4 ####
#--------------------#
tabItem(tabName = "exercice_3_4",
        
        fluidRow(
          titlePanel("Exercice 3.4: Démontrer le chaos (voir pdf explications supplémentaires sur moodle)"),
          style = "text-align: justify; font-size: 16px; margin-bottom: 10px;",
          box(width = 12,
              p("Dans cet exercice ...")
          )
        )
),#tab item 3.4


#--------------------#
#### Exercice 3.5 ####
#--------------------#
tabItem(tabName = "exercice_3_5",
        
fluidRow(
  titlePanel("Exercice 3.5: Densité dépendance et récolte"),
    style = "text-align: justify; font-size: 16px; margin-bottom: 10px;",
    box(width = 12,
    p("Dans cet exercice ...")
    )
   )
),#tab item 3.5


#------------------#
#### Exercice A ####
#------------------#
tabItem(tabName = "exercice_A",
        
        fluidRow(
          titlePanel("Exercice A: Compétition par exploitation parmi les poissons"),
          style = "text-align: justify; font-size: 16px; margin-bottom: 10px;",
          box(width = 12,
              p("Dans cet exercice ...")
          )
        )
),#tab item A


#------------------#
#### Exercice B ####
#------------------#
tabItem(tabName = "exercice_B",
        
        fluidRow(
          titlePanel("Exercice B: Compétition par exploitation parmi les poissons"),
          style = "text-align: justify; font-size: 16px; margin-bottom: 10px;",
          box(width = 12,
              p("Dans cet exercice ...")
          )
        )
),#tab item B


#------------------#
#### Exercice C ####
#------------------#
tabItem(tabName = "exercice_C",
        
        fluidRow(
          titlePanel("Exercice C: Compétition par exploitation parmi les poissons"),
          style = "text-align: justify; font-size: 16px; margin-bottom: 10px;",
          box(width = 12,
              p("Dans cet exercice ...")
          )
        )
)#tab item C

        ) #TabItems
      ) #Dashboardbody
)#DashboardPage