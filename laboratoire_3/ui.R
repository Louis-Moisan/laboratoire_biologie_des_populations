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
   p(HTML("<b>Étape 1</b>: Nous commencerons avec un modèle déterministe (sans stochasticité). La durée sera de 25 jours (25 unités de temps). Entrez ensuite 2 comme taille de population initiale. Sélectionnez ensuite la compétition par exploitation («scramble competition») comme type de densité-dépendance. Il faut ensuite saisir le taux de croissance. En présence de densité-dépendance, le taux de croisssance que l'on doit saisir est le taux de croissance maximale de la population lorsque les effets densité-dépendants sont très faibles ou nulls, donc lorsque la population est de petite taille. Ce paramètre devrait être plus grand que 1. Nous estimerons ce paramètre par essai/erreur. Faites un premier essai avec 1,5. Notez que c’est le taux de croissance par jour puisque notre unité de temps est de un jour. Le troisième paramètre est la capacité biotique, K, qui équivaut à la taille de la population à l’équilibre. Estimez ce nombre d’après le nombre moyen d’individus après le jour 12 sur la figure 3.8 (ci-dessous) et entrez le dans la ligne correspondant à la capacité de support. 
")),
   column(width=8,
          plotOutput("plot_3_1_1")),
   column(width=4,
          numericInput("timeSteps_3_1_1", "Nombre de jours:", min = 1, max = 100, value = 1),
          numericInput("initialAbundance_3_1_1", "Taille de population initiale:", min = 1, max = 10000, value = 1),
          numericInput("growth_rate_3_1_1", "Taux de croissance (R):", min = 0, max = 20, value = 1),
          radioButtons("competition_3_1_1", label = "Densité-dépendance", choices = list("exponentielle" = "exponential", "exploitation" = "scramble", "interférence"= "contest", "plafond"= "ceiling"), selected = "exponential"),
          numericInput("carrying_capacity_3_1_1", "Capacité biotique (K):", min = 1, max = 100000, value = 1)
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
      p(HTML("<b>Étape 3</b>: Répétez le modèle à l’étape 1 en changeant le taux de croissance en fonction des résultats que vous obtenez jusqu’à ce que vous trouviez le R (taux de croissance) qui permet d’obtenir une vitesse de croissance semblable à celle de la population expérimentale (fig. 3.8).
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
     p(HTML("<b>Étape 1:</b> Réutilisez les paramètres du modèle de l'exercice 3.1, mais cette fois en activant la stochasticité démographique. Le nombre de répétitions doit être plus grand que zéro (disons 10). Il s’agit ensuite de spécifier le taux de survie et de fecondité. Comme nous l’avons discuté au chapitre 1, le taux de croissance (R) est égal à la somme de la survie et de la fécondité puisque le nombre d’individus à la prochaine unité de temps est la somme du nombre des individus au temps présent qui survivent jusqu’à la prochaine unité de temps et du nombre de jeunes qu’ils produisent et qui survivent jusqu’à la prochaine unité de temps. Quand on lance une simulation déterministe, comme nous l’avons fait à l’exercice précédent, nous n’avons pas besoin de connaître les taux de survie et de fécondité, du moment que l’on connaît leur somme (c'est-à-dire le taux de croissance global). Par contre, si on veut ajouter de la stochasticité démographique,  il nous faut préciser le taux de survie (et de ce fait, le taux de fécondité).")),
     p("Dans le cas de Paramecium, on suppose que toute reproduction est asexuée (par fission binaire). Dans ce cas (comme dans celui des bactéries du lab 1), on peut supposer que la survie est de zéro et que le taux de croissance est égal au taux de fécondité. Le taux de croissance que vous avez trouvé par essai/erreur à l’exercice précédent était sans doute proche de 2, puisque la fission binaire produit 2 «jeunes» à partir de 1 «parent».")
    ),
  column(width=8,
         plotOutput("plot_3_2_1")),
  column(width=4,
         numericInput("timeSteps_3_2_1", "Nombre de jours:", min = 1, max = 100, value = 1),
         numericInput("initialAbundance_3_2_1", "Taille de population initiale:", min = 1, max = 10000, value = 1),
         numericInput("survival_3_2_1", "Taux de survie (s):", min = 0, max = 1, value = 0),
         numericInput("fecundity_3_2_1", "Taux de fécondité (f):", min = 0, max = 20, value = 0),
         radioButtons("competition_3_2_1", label = "Densité-dépendance", choices = list("exponentielle" = "exponential", "exploitation" = "scramble", "interférence"= "contest", "plafond"= "ceiling"), selected = "exponential"),
         numericInput("carrying_capacity_3_2_1", "Capacité biotique (K):", min = 1, max = 100000, value = 1),
         radioButtons("stochasticite_3_2_1", label = "Stochasticité démographique", choices = list("Oui" = TRUE, "Non" = FALSE), selected = FALSE),
         numericInput("replicates_3_2_1", "Réplications:", min = 0, max = 1000, value = 1)
  ),
  
  box(width = 12,
      p(HTML("<b>Étape 2:</b> Lancez une simulation en indiquant une abondance initiale de 2. Comparez les trajectoires obtenues avec la stochasticité démographique au résultat observé expérimentalement."))
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
    p("Dans cet exercice nous explorerons l’effet d’une augmentation du taux de croissance sur la dynamique d’un modèle de compétition par exploitation («scramble»). Nous explorerons ensuite l’effet du type de densité dépendance sur la dynamique d’une population tout en conservant une capacité biotique et un taux de croissance maximum constants.")
    ),
  
#--- Étape 1
  box(width = 12,
      p(HTML("<b>Étape 1:</b> Entrez les valeurs des paramètres du modèle déterministe de <i>Paramecium</i> que vous avez développé dans l’exercice 3.1. Sélectionnez ensuite le type de densité dépendance exploitation («scramble») et changez le taux de croissance à 10. Regardez la trajectoire et décrivez ce que vous observez?")),
      column(width=8,
             plotOutput("plot_3_3_1")),
      column(width=4,
             numericInput("timeSteps_3_3_1", "Nombre de jours:", min = 1, max = 100, value = 1),
             numericInput("initialAbundance_3_3_1", "Taille de population initiale:", min = 1, max = 10000, value = 1),
             numericInput("growth_rate_3_3_1", "Taux de croissance (R):", min = 0, max = 50, value = 0),
             radioButtons("competition_3_3_1", label = "Densité-dépendance", choices = list("exponentielle" = "exponential", "exploitation" = "scramble", "interférence"= "contest", "plafond"= "ceiling"), selected = "exponential"),
             numericInput("carrying_capacity_3_3_1", "Capacité biotique (K):", min = 1, max = 100000, value = 1)
      )
  ),

#--- Étape 2
box(width = 12,
    p(HTML("<b>Étape 2:</b> Répétez l’étape 1 plusieurs fois en augmentant progressivement le taux de croissance de 10 à 20.Quels changements observez-vous?"))
),

#--- Étape 3
box(width = 12,
    p(HTML("<b>Étape 3:</b> Changez maintenant le type de densité dépendance pour  interférence («contest») et répétez la simulation avec le taux de croissance que vous avez utilisé en dernier à l’étape 2. Quelle est la différence entre les trajectoires?"))
),

#--- Étape 4
box(width = 12,
    p(HTML("<b>Étape 4:</b> Changez le type de densité dépendance avec plafond («ceiling») et répétez la simulation avec le taux de croissance que vous avez utilisé à l’étape 3. Quelle est la différence entre les trajectoires?"))
    )
  )
),#tab item 3.3


#--------------------#
#### Exercice 3.4 ####
#--------------------#
tabItem(tabName = "exercice_3_4",
  fluidRow(
    titlePanel("Exercice 3.4: Démontrer le chaos"),
    style = "text-align: justify; font-size: 16px; margin-bottom: 10px;",
      box(width = 12,
        p(HTML("Pour cet exercice, vous aurez à utilisez la courbe de densité dépendance illustrée à la figure 3.16 du livre Applied Population Ecology (ci-bas) pour tracer la trajectoire de la population sur 10 unités de temps. Vous pouvez vous référer à l’exemple présenté dans figure 3.5  du livre Applied Population Ecology basé sur une courbe de recrutement différente.")),
        p(HTML("* Les deux premières unités de temps vous sont déjà indiquées sur la figure 3.16 et <b>des explications supplémentaires sont disponibles sur moodle au besoin</b>.")),
        tags$figure(
          class = "centerFigure",
          tags$img(
            src = "figure_3_5.png",
            width = 300)
          )
    )
   ),
  
#--- Ajouter figure 3.16
  fluidRow(
    style = "text-align: center; font-size: 16px; margin-bottom: 20px;",
    tags$figure(
      class = "centerFigure",
      tags$img(
        src = "figure_3_16.png",
        width = 500)
    )
  ),
  
#--- Étape 1
  fluidRow(
    style = "text-align: justify; font-size: 16px; margin-bottom: 10px;",
    box(width = 12,
        p(HTML("<b>Étape 1:</b> Entrez les valeurs de taille de population que vous aurez déterminées pour chaque pas de temps dans le tableau ci-dessous afin d'obtenir le graphique de la trajectoire de population, comme le graphique B de la figure 3.5. Qu’observez-vous?"))
      )
    ),

fluidRow(
  style = "text-align: justify; font-size: 16px; margin-bottom: 40px;",
  #Saisie des données dans le tableau
  column(width=4,  rHandsontableOutput("editableTable_3_4_1")),
  #Visualisation des données en graphique
  column(width=7,  plotOutput("plot_sub_table_3_4_1"))
),
    
#--- Étape 2
fluidRow(style = "text-align: justify; font-size: 16px; margin-bottom: 40px;",
    box(width=12,
        p(HTML("<b>Étape 2:</b> Modélisez maintenant la trajectoire de population en déterminant les valeurs des paramètres.
               <ol>
                  <li>Utilisez un modèle déterministe</li>
                  <li>Le type de densité dépendance peut-être déterminé d’après la forme de la courbe obtenue à l’étape 1.</li>
                  <li>La capacité biotique est représentée par une intersection sur la figure 3.16.</li>
                  <li>L’abondance initiale est indiquée sur l’axe des x.</li>
                  <li>Le Rmax est représenté par la pente de la courbe 3.16 proche de l’origine et est assez élevé. Estimez la pente et utilisez cette valeur comme taux de croissance dans le modèle. Procédez par essai/ erreur afin de trouver le Rmax exacte en comparant la trajectoire de population donnée par Ramas avec celle obtenu à l’étape 2 (trouver le Rmax qui vous permet d’obtenir les valeurs les plus semblables possibles). </li>
                  </ol>")),
        column(width=8,
               plotOutput("plot_3_4_2")),
        column(width=4,
               numericInput("timeSteps_3_4_2", "Nombre de jours:", min = 1, max = 100, value = 1),
               numericInput("initialAbundance_3_4_2", "Taille de population initiale:", min = 1, max = 10000, value = 1),
               numericInput("growth_rate_3_4_2", "Taux de croissance (R):", min = 0, max = 50, value = 0),
               radioButtons("competition_3_4_2", label = "Densité-dépendance", choices = list("exponentielle" = "exponential", "exploitation" = "scramble", "interférence"= "contest", "plafond"= "ceiling"), selected = "exponential"),
               numericInput("carrying_capacity_3_4_2", "Capacité biotique (K):", min = 1, max = 100000, value = 1),
               radioButtons("stochasticite_3_4_2", label = "Stochasticité démographique", choices = list("Oui" = TRUE, "Non" = FALSE), selected = FALSE),
        )
        ),

#--- Étape 3
box(width=12,
    p(HTML("<b>Étape 3:</b> Changez maintenant l’abondance initiale. Cette trajectoire est-elle similaire à celle que vous avez dessinée à l’étape 2?"))
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
    p("Dans cet exercice, vous allez explorer les effets de deux types de récolte (leurs effets densité dépendants). Supposez que vous pêchez une espèce de poisson dont le taux de survie naturel moyen est de 0,6 et dont la taille de population fluctue entre 2 000 et 14 000. À la fin de chaque année, vous pêchez 1 000 individus, quelque soit le nombre d’individus présents dans la population.")
    ),

#--- Étape 1
  box(width = 12,
      p(HTML("<b>Étape 1:</b> Calculez le taux de survie général de cette espèce (c'est-à-dire la proportion qui survit à la fois aux causes de mortalité naturelles et à la pêche), en fonction de la taille de la population. Copiez le tableau ci-dessous dans Excel pour le compléter. Si les valeurs se retrouvent toutes sur une même ligne, veuillez coller le tableau dans excel en utilisant les touches (ctrl + shift + v)  pour coller en tant que valeurs. Pour chaque année, calculez d’abord le nombre de poissons qui survivent aux causes naturelles de mortalité. Retirez ensuite 1 000 individus pour simuler la pêche et divisez le nombre restant par le nombre de poissons qu’il y avait au début de l’année. Dans le tableau, le calcul pour N= 10 000 est donné en exemple.")),
      tableOutput("table_3_5_1")
  ),

#--- Étape 2
  box(width = 12,
      p(HTML("<b>Étape 2:</b> Tracez la courbe du taux de survie général en fonction de la taille de la population en copiant et collant les valeurs calculées sur Excel."))
  )
   ),

fluidRow(
  style = "text-align: justify; font-size: 16px; margin-bottom: 40px;",
  #Saisie des données dans le tableau
  column(width=5,  rHandsontableOutput("editableTable_3_5_2")),
  #Visualisation des données en graphique
  column(width=7,  plotOutput("plot_sub_table_3_5_2"))
),

#--- Étape 3
fluidRow(
  style = "text-align: justify; font-size: 16px; margin-bottom: 40px;",
  box(width=12,
  p(HTML("<b>Étape 3:</b> Supposez maintenant que la stratégie de pêche est d’enlever 40% des poissons qui survivent aux causes naturelles de mortalité au lieu d’enlever un nombre fixe de poissons. Saissisez le taux de survie dans le tableau ci-bas pour ajouter la courbe sur la figure précédente. Comparez les deux courbes.")),
column(width=6,  rHandsontableOutput("editableTable_3_5_3"))
    )
  ),

#--- Étape 4
fluidRow(
  style = "text-align: justify; font-size: 16px; margin-bottom: 40px;",
  box(width=12,
      p(HTML("<b>Étape 4:</b> Discutez des effets à long terme de ces deux stratégies de pêche sur la pérennité de la population."))
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
              p(HTML("<b>Mise en contexte</b>")),
              p("Dans cet exercice, vous allez simuler la compétition au sein d’une population de poissons lune dans un lac du New Hampshire. Ce poisson se nourrit de plancton, et la population étant en croissance, tous les individus sont affectés également par la forte densité. Utilisant la compétition par exploitation et différentes abondances initiales, vous allez évaluer les effets de la densité dépendance sur une petite population de poissons.")
          )
        ),
        
#--- Ajouter image crapet soleil
        fluidRow(
          style = "text-align: center; font-size: 16px; margin-bottom: 20px;",
          tags$figure(
            class = "centerFigure",
            tags$img(
              src = "sunfish.jpg",
              width = 400)
          )
        ),
          
#--- Étape 1
fluidRow(
  style = "text-align: justify; font-size: 16px; margin-bottom: 10px;",
          box(width = 12,
              p(HTML("<b>Étape 1:</b> Effectuez un modèle de croissance de population avec densité dépendance en saisissant les valeurs de paramètres suivants:
              <ol>
                  <li>Nombre d'années: 20 années</li>
                  <li>Abondance initiale: 10 individus</li>
                  <li>Taux de croissance (R): 2.5</li>
                  <li>Type de densité-dépendance: compétition par exploitation («scramble»)</li>
                  <li>Capacité biotique (K): 500 individus</li>
                  </ol>
                     ")),
              column(width=8,
                     plotOutput("plot_A")),
              column(width=4,
                     numericInput("timeSteps_A", "Nombre d'années:", min = 1, max = 100, value = 1),
                     numericInput("initialAbundance_A", "Taille de population initiale:", min = 1, max = 10000, value = 1),
                     numericInput("growth_rate_A", "Taux de croissance (R):", min = 0, max = 50, value = 0),
                     radioButtons("competition_A", label = "Densité-dépendance", choices = list("exponentielle" = "exponential", "exploitation" = "scramble", "interférence"= "contest", "plafond"= "ceiling"), selected = "exponential"),
                     numericInput("carrying_capacity_A", "Capacité biotique (K):", min = 1, max = 100000, value = 1)
              ),
              column(width = 12,
                     tableOutput("table_A"))
          )
    ),

#--- Étape 2
    fluidRow(
      style = "text-align: justify; font-size: 16px; margin-bottom: 10px;",
        box(width = 12,
          p(HTML("<b>Étape 2:</b> Notez la taille de population obtenue aux pas de temps (0,5,10,15 et 20 ans) dans le tableau ci-dessous. Répétez ensuite en utilisant une abondance initiale de 450 individus, soit près de la capacité biotique. Finalement, répétez en utilisant une abondance initiale se situant au-dessus de la capacité biotique, soit de 700 individus.")),
          column(width=12,  rHandsontableOutput("editableTable_A_2"))
          ),
      
#--- Questions
      box(width = 12,
          p(HTML("<b>Questions:</b> 
                 <ol>
                  <li>Avec une abondance initiale de 10, combien faut-il de temps pour que la population atteigne 500 individus?</li>
                  <li>Avec une abondance initiale de 450, combien faut-il de temps pour que la population atteigne 500 individus?</li>
                  <li>Qu’arrive-t-il à la population au cours du temps lorsque l’abondance initiale dépasse la capacité de soutien du lac?</li>
                  <li>Comment, d’après vous, les poissons affectent-ils leur environnement lorsqu’ils vivent à très haute densité?</li>
                  </ol>")),
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
              p(HTML("<b>Mise en contexte</b>")),
              p("Dans cet exercice, vous allez simuler la croissance d’une population de balbuzards pêcheurs. Le balbuzard est un rapace qui se reproduit dans des milieux humides d’eau salée sur les côtes d’Amérique du Nord et d’Europe. Ils sont très sensibles au développement humain qui résultent souvent en une diminution du nombre des arbres morts sur lesquels ils nichent. Il y a environ 20 ans, il ne restait qu’environ 30 balbuzards sur toute l’île de Long Island, New York. Un effort de conservation a été mis en place pour sauver la population en installant des plates-formes artificielles dans les zones humides. Chez cette espèce, seules les femelles qui peuvent disposer d’un nid seront capables de se reproduire. Même si les autres oiseaux ne peuvent pas se reproduire, ils peuvent tout de même trouver de la nourriture et survivre. En plus de disposer d’un nombre de plates-formes de reproduction limité, les individus doivent aussi compétitionner pour l’accès aux ressources alimentaires. En supposant que l’environnement est constant, la croissance après la mise en place des plates-formes devrait ressembler à de la compétition par interférence.")
          )
        ),
        
#--- Ajouter image crapet soleil
    fluidRow(
      style = "text-align: center; font-size: 16px; margin-bottom: 20px;",
      tags$figure(
       class = "centerFigure",
       tags$img(
       src = "osprey.jpg",
       width = 600)
          )
        ),

#--- Étape 1
    fluidRow(
      style = "text-align: justify; font-size: 16px; margin-bottom: 10px;",
      box(width = 12,
          p(HTML("<b>Étape 1:</b> Effectuez un modèle de croissance de population avec densité dépendance en saisissant les valeurs de paramètres suivants:
              <ol>
                  <li>Nombre d'années: 20 années</li>
                  <li>Abondance initiale: 30 individus</li>
                  <li>Taux de croissance (R): 1.3</li>
                  <li>Type de densité-dépendance: compétition par interférence («contest»)</li>
                  <li>Capacité biotique (K): 300 individus</li>
                  </ol>
                     ")),
          column(width=8,
                 plotOutput("plot_B")),
          column(width=4,
                 numericInput("timeSteps_B", "Nombre d'années:", min = 1, max = 100, value = 1),
                 numericInput("initialAbundance_B", "Taille de population initiale:", min = 1, max = 10000, value = 1),
                 numericInput("growth_rate_B", "Taux de croissance (R):", min = 0, max = 50, value = 0),
                 radioButtons("competition_B", label = "Densité-dépendance", choices = list("exponentielle" = "exponential", "exploitation" = "scramble", "interférence"= "contest", "plafond"= "ceiling"), selected = "exponential"),
                 numericInput("carrying_capacity_B", "Capacité biotique (K):", min = 1, max = 100000, value = 1)
          ),
          column(width = 12,
                 tableOutput("table_B"))
      )
  ),

#--- Étape 2
fluidRow(
  style = "text-align: justify; font-size: 16px; margin-bottom: 10px;",
  box(width = 12,
      p(HTML("<b>Étape 2:</b> Notez la taille de population obtenue aux pas de temps (0,5,10,15 et 20 ans) dans le tableau ci-dessous. Répétez ensuite en utilisant une capacité biotique de 100, 50 puis 3000 individus.")),
      column(width=12,  rHandsontableOutput("editableTable_B_2"))
  ),
  
  #--- Questions
  box(width = 12,
      p(HTML("<b>Questions:</b> 
                 <ol>
                  <li>Avec une capacité biotique de 300, combien faut-il de temps pour que la population atteigne 100 individus?</li>
                  <li>Avec une capacité biotique de 3000, combien faut-il de temps pour que la population atteigne 100 individus?</li>
                  <li>Quel est l’effet général sur la population d’une augmentation de la capacité biotique lorsqu’il y a de la compétition par interférence?</li>
                  <li>Est-ce que la population se rapproche toujours de la capacité biotique dans vos trajectoires? Pourquoi ne le ferait-elle pas?</li>
                  <li>Si la population de balbuzards de Long Island est effectivement limitée pas de la compétition par interférence pour les sites de nidification, comment les gestionnaires devrait-il utiliser cette information pour aider cette population de se rétablir plus rapidement?</li>
                  </ol>")),
  )
)
),#tab item B


#------------------#
#### Exercice C ####
#------------------#
tabItem(tabName = "exercice_C",
        
        fluidRow(
          titlePanel("Exercice C: Modèles de densité dépendance avec plafond chez la bernacle"),
          style = "text-align: justify; font-size: 16px; margin-bottom: 10px;",
          box(width = 12,
          p(HTML("<b>Mise en contexte</b>")),
          p("Dans cet exercice, vous allez regarder comment un modèle avec plafond affecte la croissance des populations. Dans cette simulation, vous allez prédire la croissance d’une population de bernacles vivant sur une côte rocheuse. Les bernacles sont des petits crustacés qui vivent dans la zone intertidale et se nourrissent en filtrant les détritus lors des marées hautes. Les larves de bernacles (stades immatures) sont planctoniques et nagent librement dans l’eau, se nourrissant de détritus et d’algues. Une fois adultes, elles se fixent sur une surface dure et se construisent une coquille dure calcifiée. Une fois que les adultes se sont fixés sur un substrat, ils ne peuvent plus bouger. Si les larves ne trouvent pas de place lorsqu’elles deviennent adultes, elles mourront et ne pourront jamais se reproduire. Imaginez des bernacles introduites sur une côte rocheuse initialement dépourvue de bernacles. La capacité biotique dans ce modèle est déterminée par la surface disponible. Tous les individus qui trouvent une place pour se fixer ont la même chance de se reproduire et de survivre, même à forte densité. Le taux de croissance de la population a de bonnes chances de rester au dessus de 1 tant que tout l’espace disponible n’est pas occupé. La dynamique de cette population de bernacles imite le modèle avec plafond, en supposant que tout le reste dans l’environnement reste constant.")
          )
        ),

#--- Ajouter image crapet soleil
fluidRow(
  style = "text-align: center; font-size: 16px; margin-bottom: 20px;",
  tags$figure(
    class = "centerFigure",
    tags$img(
      src = "barnacle.jpg",
      width = 300)
    )
  ),

#--- Étape 1
fluidRow(
  style = "text-align: justify; font-size: 16px; margin-bottom: 10px;",
  box(width = 12,
      p(HTML("<b>Étape 1:</b> Effectuez un modèle de croissance de population avec densité dépendance en saisissant les valeurs de paramètres suivants:
              <ol>
                  <li>Nombre d'années: 20 années</li>
                  <li>Abondance initiale: 50 individus</li>
                  <li>Taux de croissance (R): 1.8</li>
                  <li>Type de densité-dépendance: compétition par interférence avec plafond («ceiling»)</li>
                  <li>Capacité biotique (K): 100 000 individus</li>
                  </ol>
                     ")),
      column(width=8,
             plotOutput("plot_C")),
      column(width=4,
             numericInput("timeSteps_C", "Nombre d'années:", min = 1, max = 100, value = 1),
             numericInput("initialAbundance_C", "Taille de population initiale:", min = 1, max = 10000, value = 1),
             numericInput("growth_rate_C", "Taux de croissance (R):", min = 0, max = 50, value = 0),
             radioButtons("competition_C", label = "Densité-dépendance", choices = list("exponentielle" = "exponential", "exploitation" = "scramble", "interférence"= "contest", "plafond"= "ceiling"), selected = "exponential"),
             numericInput("carrying_capacity_C", "Capacité biotique (K):", min = 1, max = 100000, value = 1)
      ),
      column(width = 12,
             tableOutput("table_C"))
  )
),

#--- Étape 2
fluidRow(
  style = "text-align: justify; font-size: 16px; margin-bottom: 10px;",
  box(width = 12,
      p(HTML("<b>Étape 2:</b> Notez la taille de population obtenue aux pas de temps (0, 5, 10, 15 et 20 ans) dans le tableau ci-dessous. Répétez ensuite en utilisant un taux de croissance de 1.6.")),
      column(width=12,  rHandsontableOutput("editableTable_C_2"))
  )
),

#--- Étape 3
fluidRow(
  style = "text-align: justify; font-size: 16px; margin-bottom: 10px;",
  box(width = 12,
      p(HTML("<b>Étape 3:</b> Répétez l'étape 2, mais cette fois en utilisant le modèle de compétition par interférence avec plafond («contest»).")),
      column(width=12,  rHandsontableOutput("editableTable_C_3"))
  )
),

#--- Questions
fluidRow(
box(width = 12,
    p(HTML("<b>Questions:</b> 
                 <ol>
                  <li>Combien de temps cela prendrait-il à la population de bernacles pour doubler sa taille en supposant un modèle avec plafond et un taux de croissance de 1.60? Combien de temps cela prendrait-il pour atteindre le plafond dans ces conditions?</li>
                  <li>Comment varie le temps nécessaire pour atteindre le plafond lorsque vous changez le taux de croissance pour 1.8?</li>
                  <li>Pour un taux de croissance de 1.60, combien de temps cela prendrait-il pour atteindre la capacité biotique avec un modèle de compétition avec interférence? Avec un modèle avec plafond? Pourquoi y a-t-il une différence?</li>
                  </ol>"))
    )
  )
)#tab item C



        ) #TabItems
      ) #Dashboardbody
)#DashboardPage