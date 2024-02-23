#Activer le package shinydashboard
library(shiny)
library(shinydashboard)
library(rhandsontable)
library(plotly)
library(DT)

#Définir l'interface de l'utilisateur
ui <- dashboardPage(
  
#--- Définir le titre de la page web
dashboardHeader(title = "Laboratoire 1"),
  
#--- Définir les différents exercices du laboratoires
dashboardSidebar(
    # Sidebar menu with items for each exercise
    sidebarMenu(
      id = "tabs",
      menuItem("Exercice 1.1", tabName = "exercise_1_1"),
      menuItem("Exercice 1.2", tabName = "exercise_1_2"),
      menuItem("Exercice 1.3", tabName = "exercise_1_3"),
      menuItem("Exercice B", tabName = "exercise_b"),
      menuItem("Exercice C", tabName = "exercise_c"),
      menuItem("Exercice D", tabName = "exercise_d")
    )
),
  
#--- Définir le contenu de la page web
dashboardBody(
    #Préciser la taille des marges gauche et droite
    style = "margin-left: 40px; margin-right: 40px;",
    tabItems(
      
#---------------------#
##### Exercice 1.1 ####
#---------------------#
#--- Nom de l'objet de la page dans R
tabItem(tabName = "exercise_1_1",  

fluidRow(
#--- titre de la première section
  titlePanel("Exercice 1.1: Le rétablissement de la baleine bleue"),
  #Taille du texte, justifier et ajouter de l'espace en dessous
  style = "text-align: justify; font-size: 16px; margin-bottom: 40px;",
  
#--- Spécification particulière pour l'Exercice
  box(width = 12, #Définir la largeur de la boîte pour l'encadré pour le texte (12 correspond à la largeur de la page)
  #Ajouter la mise en contexte
  p(HTML("<b>***Exercice à la main (papier, crayon et calculatrice)***</b>"))
  ),

#--- Mise en contexte
  box(width = 12, #Définir la taille de l'a boîte pour l'encadré pour le texte
                    #Ajouter la mise en contexte
                    p("Cet exercice est basé sur l’exemple de la baleine bleue exposé à la section 1.4.3 du livre Applied Population Ecology (APE). La dynamique des populations de baleine bleue et les prédictions de niveau de récolte ont été faits à partir de modèles exponentiels. Le taux de croissance de la population (R) durant la période représentée sur la figure 1.9 était de 0.82, c’est à dire que la population déclinait de 18% par an. Le taux de fécondité de la baleine bleue a été estimé entre 0.06 et 0.14 et la mortalité naturelle autour de 0.04. En absence de récolte, le taux de croissance de la population devrait être entre 1.02 et 1.10. Nous voulons estimer le temps nécessaire pour que la population de baleine bleue se rétablisse à son niveau de 1930, soit à un effectif de 50 000. On suppose que la taille de la population est de 10 000 en 1963."),
      p(uiOutput("whale"))
      ),

#--- Spécifications particulières
  box(width = 12, #Définir la taille de l'a boîte pour l'encadré pour le texte
                        #Ajouter la mise en contexte
                        p(HTML("<b>Écrivez la formule utilisée et calculez le nombre d’années nécessaires au rétablissement de la population.</b><br><br>ASTUCE : Utilisez la formule pour calculer le temps de doublement de la population."))
                ),

#--- Simulations à faire
  box(width = 12, #Définir la taille de l'a boîte pour l'encadré pour le texte
                    #Ajouter la mise en contexte
                    p(HTML("<ul style='list-style-type: lower-alpha;'>
              <li>si son taux de croissance est 1.10</li>
              <li>si son taux de croissance est 1.02</li>
            </ul>"))
              )
            )
          ),
    

#---------------------#
##### Exercice 1.2 ####
#---------------------#
tabItem(tabName = "exercise_1_2",  #Nom de l'objet de la page dans R
              
#--- Titre et mise en contexte
fluidRow(
 #Définir le titre de la première section
 titlePanel("Exercice 1.2: La population humaine de 1800 à 1995"),
 #Taille du texte, justifier et ajouter de l'espace en dessous
 style = "text-align: justify; font-size: 16px; margin-bottom: 40px;", 
 box(width = 12, #Définir la taille de l'a boîte pour l'encadré pour le texte
                    #Ajouter la mise en contexte
                    p("Dans cet exercice, nous allons travailler sur les données de croissance de la population humaine utilisées dans la section 1.4.1 (APE). Pour commencer cet exercice, cliquez sur le bouton «Heure départ» afin de débuter, la durée de l'exercice vous sera utile plus loin au cours de l'exercice."),
     p(actionButton("Timedepart", "Heure départ"),
                         textOutput("depart"))
                )
              ),

#--- Étape 1              
  fluidRow(
  #Taille du texte, justifier et ajouter de l'espace en dessous
  style = "text-align: justify; font-size: 16px; margin-bottom: 40px;", 
    box(width = 12, #Définir la taille de l'a boîte pour l'encadré pour le texte
    #Ajouter la mise en contexte
    p(HTML("<b>Étape 1</b>: Calculez le taux de croissance de la population humaine pour chaque intervalle de temps dans le tableau 1.3. Puisqu’il est important de convertir ces taux de croissance en taux de croissance annuels pour pouvoir les comparer les uns aux autres, notez que le nombre d’années est différent d’un intervalle de temps à un autre: 50 ans au début, 20 ans ensuite et 5 ans pour finir. Utilisez la méthode décrite à la section 1.4.1 (APE) pour calculer le taux de croissance annuel pour la période 1800 à 1850, 1850 à 1870, et ainsi de suite jusqu’à la période 1990 à 1995. <b>Copiez les valeurs du tableau 1.3 suivant dans Excel et complétez le tableau (dans le tableau, le premier taux de croissance est calculé en exemple).</b>")),
    p(HTML("<i>*ASTUCE: Pour élever un nombre à une puissance, la fonction «excel» est la suivante:</i>")),
    p(HTML("<i>=puissance (nombre; puissance)</i>")),
    p(HTML("<i>*Selon votre version d'Excel vérifier si les chiffres sont considérés avec des «.» ou des «,». Vous pouvez les changer rapidement habituellement avec ctrl + h</i>"))
       )
      ),

 #--- Ajouter le tableau 1.3 du document
 fluidRow(
   style = "text-align: justify; font-size: 16px; margin-bottom: 40px;", 
        titlePanel(h4("Tableau 1.3: Calculer le taux de croissance annuel de la population humaine")),
        tableOutput("table_1_3")
        ),

#--- Étape 2
fluidRow(
  style = "text-align: justify; font-size: 16px; margin-bottom: 40px;", 
  box(width = 12,
      p(HTML("<b>Étape 2</b>: Tracez le graphique du taux de croissance annuel en fonction de l’année et commentez la croissance de la population humaine au cours des 2 derniers siècles. Vous pouvez simplement coller vos valeurs calculées dans la colonne taux de croissance annuel pour obtenir le graphique."))
      )
    ),

fluidRow(
  style = "text-align: justify; font-size: 16px; margin-bottom: 40px;", 
      column(width=5,  rHandsontableOutput("editableTable_1_3")),
      column(width=5,  plotOutput("plot_sub_table_1_3"))
      ),
      
#--- Étape 3
fluidRow(
  style = "text-align: justify; font-size: 16px; margin-bottom: 40px;", 
  box(width = 12,
      p(HTML("<b>Étape 3</b>: Il est important de connaître la différence entre croissance relative et absolue. En effet, même si le taux de croissance annuel (une mesure de croissance relative) décline, le nombre d’individus ajoutés à la population chaque année (une mesure de croissance absolue) peut augmenter.<b> Le nombre d’individus ajoutés à la population dans une année est égal à N x (R-1)</b>, où N est la taille de la population et R est le taux de croissance annuel. Par exemple, en 1850 on a 1.13 milliard x 0.00434 = 4.9 million d’individus qui ont été ajoutés à la population. <i>(De manière stricte, ce calcul n’est pas correct puisque les deux nombres utilisés réfèrent à des temps différents: 1.00434 est la croissance moyenne de 1800 à 1850 alors que 1.13 milliard est la taille de la population en 1850. Cependant, pour cet exercice, on considérera que c’est une approximation correcte)</i>.")),
        p("Calculez le nombre d’individus ajoutés à la population humaine chaque année pour 1975, 1985 et 1995 en utilisant le tableau 1.4 ci-dessous. Comparez le changement du taux de croissance annuel avec l’augmentation absolue de la taille de la population par année.")
      )
    ),

fluidRow(
  style = "text-align: justify; font-size: 16px; margin-bottom: 40px;",
  titlePanel(h4("Tableau 1.4: Calculer le nombre d’individus qui s’ajoutent à la population humaine")),
   rHandsontableOutput("editableTable_1_4")
    ),

#--- Étape 4
fluidRow(
  style = "text-align: justify; font-size: 16px; margin-bottom: 40px;",
  box(width=12,
  p(HTML("<b>Étape 4</b>: En utilisant le nombre d’individus ajoutés à la population humaine en 1995, calculez le nombre approximatif d’individus ajoutés à la population")),
  p(actionButton("Timeend", "Heure fin"),
    textOutput("end")),
  p(HTML("<ul style='list-style-type: lower-alpha;'>
              <li>par jour</li>
              <li>par heure</li>
              <li>par minute</li>
              <li>pendant le temps que vous avez passé à faire cet exercice</li>
            </ul>"))
    )
  )
),      

#--------------------#
#### Exercice 1.3 ####
#--------------------#
tabItem(tabName = "exercise_1_3",  #Nom de l'objet de la page dans R
 #--- Titre et mise en contexte
 fluidRow(
 #Définir le titre de la première section
 titlePanel("Exercice 1.3 (optionnel): La population humaine de 1995 à 2035"),
 #Taille du texte, justifier et ajouter de l'espace en dessous
 style = "text-align: justify; font-size: 16px; margin-bottom: 40px;", 
  box(width = 12, #Définir la taille de l'a boîte pour l'encadré pour le texte
   #Ajouter la mise en contexte
   p("Dans cet exercice vous allez examiner un scénario plutôt optimiste de ralentissement et de stabilisation de la population humaine. Spécifiquement, vous allez calculer la taille de la population en 2035, en supposant que le taux de croissance ait atteint d’ici là 1.00 (pas de croissance). Supposez que (i) le taux de fécondité en 1995 est de 0.0273, (ii) le taux de survie ne changera pas dans le futur et que (iii) dans les 40 années suivant 1995, la fécondité va décroître de sorte que le taux de croissance annuel en 2035 atteigne R(2035) = 1.0."),
   p(HTML("<b>Étape 1</b>: En utilisant le R (1995) obtenu à l’exercice précédent, calculez le taux de survie annuel pour 1995 et estimez la décroissance annuelle en fécondité nécessaire pour atteindre R(2035) = 1.0. Supposez que la décroissance est linéaire, c’est à dire que la fécondité décroît d’une quantité équivalente chaque année.")),
   p(HTML("<b>Étape 2</b>: Calculez la fécondité et le taux de croissance annuel pour les années 2005, 2015, 2025 et 2035 et notez-les dans le tableau 1.5 ci-dessous. Notez que le taux de survie est stable.")),
   p(HTML("<b>Étape 3</b>: Calculez les taux de croissance sur 10 ans pour les périodes 1995-2005, 2005-2015, 2015-2025, et 2025-2035. Notez ces résultats dans le tableau 1.5 (entrez le taux de croissance pour 10 ans pour la période 1995-2005 dans la ligne pour 1995, et ainsi de suite).")),
   p(HTML("<i>*ASTUCE: Utilisez le taux de croissance annuel du début de la décennie (ex: R(1995) pour la décennie 1995-2005) pour calculer le taux de croissance sur 10 ans.</i>")),
   p(HTML("<b>Étape 4</b>: Estimez la taille de la population à la fin de chaque période de 10 ans."))
  )
 ),
 
 fluidRow(
   style = "text-align: justify; font-size: 16px; margin-bottom: 40px;",
   titlePanel(h4("Tableau 1.5: Projection de la croissance de la population humaine")),
   rHandsontableOutput("editableTable_1_5")
),
 
 fluidRow(
   #Taille du texte, justifier et ajouter de l'espace en dessous
   style = "text-align: justify; font-size: 16px; margin-bottom: 40px;",
   box(width = 12,
       p("De combien la population a-t-elle augmenté en 40 ans alors que la fécondité diminuait? Si la fécondité avait mis 80 ans au lieu de 40 ans pour diminuer au même niveau, est-ce que la taille finale de la population aurait été plus grande ou plus petite?"))
 )
),


#-------------------#
##### Exercice B ####
#-------------------#
tabItem(tabName = "exercise_b",  #Nom de l'objet de la page dans R
              
#--- Titre et mise en contexte
 fluidRow(
 #Définir le titre de la première section
 titlePanel("Exercice B: Des bactéries aux baleines : croissance sans limite (Modélisation de la croissance exponentielle)"),
 #Taille du texte, justifier et ajouter de l'espace en dessous
 style = "text-align: justify; font-size: 16px; margin-bottom: 40px;", 
  box(width = 12, #Définir la taille de l'a boîte pour l'encadré pour le texte
 #Ajouter la mise en contexte
    p("Dans les prochains exercices, vous allez explorer la dynamique de populations à croissance exponentielle en utilisant un code R de façon interactive à l'aide d'un Shiny App. Tout d’abord, considérons une population de bactéries qui commence avec un seul individu. Cet individu se reproduit de façon asexuée pour produire deux organismes après une période de 20 minutes. Ces deux individus peuvent, après une nouvelle période (unité de temps ou « time step ») de 20 minutes, se reproduire à nouveau, et aboutir à un total de 4 bactéries. Ce processus continue de telle manière qu’après chaque reproduction, le nombre de bactéries double (un évènement de reproduction ne donne pas 2 individus de plus mais double le nombre d’individus vivants à l’étape précédente)."),
    p(uiOutput("bacteria")),
    p(HTML("<b>Questions</b>")),
    p(HTML("<ol>
         <li>Combien de bactéries sont produites à partir d’un seul individu, après 10 événements de reproduction?</li>
         <li>En gardant en mémoire que chaque unité de temps (i.e. reproduction) dure 20 minutes, combien de minutes (ou heures) cela va-t-il prendre pour produire 10 000 bactéries?</li>
       </ol>
       "))
      )
     ),
              
 #--- Ajouter le graphique de trajectoire de population
 fluidRow(
 style = "margin-bottom: 40px;",
 box(width = 8, #Taille du graphique
  plotlyOutput("population_plot_B")
  # Ici indiquer le nom de l'objet du graphique dans R
     ),
 #--- Boîte pour saisir taux de croissance, taille pop init et pas de temps
  box(width = 4,
    numericInput("taux_croissance_B", "Taux de croissance (R)", value = 1),
    numericInput("population_initiale_B", "Taille de population initiale (N)", value = 1),
    numericInput("time_steps_B", "Temps (t)", value = 1)
  )
   ),

  #--- Ajouter un tableau dynamique avec les résultats du graphique
  fluidRow(
    style = "margin-bottom: 100px;",
    box(width = 8,
     dataTableOutput("population_table_B")
                )
              )
            ),
      
#------------------#
#### Exercice C ####
#------------------#
tabItem(tabName = "exercise_c",
  fluidRow(
  #Définir le titre de section
  titlePanel("Exercice C: L’influence des facteurs de mortalité"),
  style = "text-align: justify; font-size: 16px; margin-bottom: 10px;", 
   box(width = 12,
   #Ajouter la mise en contexte
    p("Dans l’exemple précédent, vous avez seulement pris en compte la natalité comme facteur affectant la croissance de la population, et vous avez ignoré la mortalité et les migrations. Maintenant, vous allez ajouter les effets de la mortalité, Cependant, vous allez toujours ignorer les effets de la migration dans cet exercice."),
    p("Imaginez une population de 5000 tamias vivant dans une forêt donnée. Dans des conditions optimales, ces petits mammifères vont se reproduire rapidement, de telle manière que dans un intervalle de 1 an, chaque groupe de 10 tamias donne 4 nouveaux individus. La taux de natalité est égal à 4/10=0.40 nouveaux nés par individu par an. Cependant, durant cette même période de temps, 1 individu de cette population sur 10 meurt. Ainsi, le taux de survie est de 9/10=0.90. Le taux de mortalité est égal à 1 moins le taux de survie, qui vaut donc 0.1 dans cette exemple. Le taux de croissance de cette population sera défini comme suit (supposant qu’il n’y a pas de migration):"),
    p(uiOutput("tamia")),
   
   p(HTML("<b>Questions</b>")),
   p(HTML("<ol>
         <li>Quel était le taux de natalité pour la population de bactéries (simulation précédente) et quel est le taux de natalité pour la population de tamias?</li>
         <li>Quel est le taux de mortalité (1-taux de survie) pour la population de bactéries et pour la population de tamias?</li>
         <li>Observez-vous une croissance exponentielle dans la population de tamias?</li>
         <li>Quel est le taux de croissance (R) pour la population de bactéries? Pour la population de tamias?</li>
         <li>Comparez le taux de croissance de la populations de tamias avec celui des bactéries (Est ce le même? Est-il plus lent? Plus rapide?)</li>
         <li>Quelles sont les conditions pour avoir une croissance exponentielle?</li>
       </ol>
       "))
                )
              ),
 fluidRow(
 style = "font-size: 24px; margin-bottom: 10px;",
  box(width = 12,
   p(HTML("<b>R = f + s</b> ")),
                )
              ),
 fluidRow(
 style = "font-size: 16px; margin-bottom: 10px;",
  box(width = 12,
   p(HTML("<b>Taux de croissance (growth rate)= Taux de natalité (fecundity/birth rate) + Taux de survie (survival rate)</b>"))
                )
              ),
 
 fluidRow(
 style = "text-align: justify; font-size: 16px; margin-bottom: 40px;",
  box(width = 12,
  p("Souvenez-vous que pour obtenir la prochaine taille de la population, il faut multiplier la taille actuelle par le taux de croissance.")
                )
              ),
 
#--- Ajouter le graphique de trajectoire de population
  fluidRow(
  style = "margin-bottom: 40px;",
   box(width = 8, #Taille du graphique
    plotlyOutput("population_plot_C") # Ici indiquer le nom de l'objet du graphique dans R
                ),
#--- Boîte pour saisir taux de croissance, taille pop init et pas de temps
    box(width = 4,
      numericInput("taux_survie_C", "Taux de survie (s)", value= 1),
      numericInput("taux_fecondite_C", "Taux de fécondité (s)", value= 1),
      numericInput("population_initiale_C", "Taille de population initiale (N)", value = 1),
      numericInput("time_steps_C", "Temps (t)", value = 1)
                )
              ),

#--- Ajouter un tableau dynamique avec les résultats du graphique
 fluidRow(
 style = "margin-bottom: 100px;",
  box(width = 8,
    dataTableOutput("population_table_C")
                )
              )
            ),
      
      
#------------------#
#### Exercice D ####
#------------------#
tabItem(tabName = "exercise_d",
  fluidRow(
  #Définir le titre de section
  titlePanel("Exercice D: Modélisation du rétablissement des baleines bleues"),
  style = "text-align: justify; font-size: 16px; margin-bottom: 10px;", 
    box(width = 12,
    #Ajouter la mise en contexte
     p("La baleine bleue est peut-être le plus grand animal n’ayant jamais vécu sur terre, mesurant jusqu’à 33 mètres (110 pieds) et pesant jusqu’à 17 tonnes (38000 livres). Il y a 3 populations distinctes de baleines bleues, soit celles habitant l’Atlantique Nord, le Pacifique Nord et l’hémisphère sud. Les 2 populations nordiques restent isolées l’une de l’autre de part les continents séparant les 2 océans. Les populations du nord et du sud restent également isolées les unes des autres, car chacune migre vers les tropiques seulement durant les mois froids de leur hémisphère respectif. Avant l’exploitation par l’homme, 90% des baleines bleues vivait dans l’hémisphère sud, avec un effectif de 150 000 à 210 000 individus. Au cours des deux derniers siècles, les activités de chasse ont fait pression essentiellement sur cette population."),
    p("Au milieu des années 1920, les technologies de chasse se sont développées. Cela améliora nettement l’efficacité des baleiniers et marqua le début du déclin de la baleine bleue. Les baleines étaient chassées pour leur viande et leur gras. Après 10 ans de chasse, la population a chuté pour atteindre un effectif entre 20 000 et 50 000 individus. En 1965, il ne restait que 14 000 individus et plusieurs pays décidèrent de stopper la chasse par peur d’assister à l’extinction de la baleine bleue."),
    p("Malgré la diminution de la pression de chasse, la baleine bleue a eu du mal à se rétablir à partir de son petit effectif. Le refus de certains pays d’arrêter la pêche et l’augmentation de la récolte du krill, une petite crevette représentant la principale ressource alimentaire des baleines, ont rendu difficile le rétablissement des baleines bleues. En 1989, on estimait qu’environ 500 individus subsistaient dans les océans de l’hémisphère sud. Néanmoins, des rapports récents et plus optimistes ont suggéré que la taille de la population serait probablement en train d’augmenter."),
    p("Si la pêche au krill est contrôlée et que les pressions de la pêche se relâchent, l’habitat pourrait être plus favorable au rétablissement. On estime que les baleines bleues pourraient avoir un taux de survie annuel de 0.96 dans ces conditions. Cela signifie que chaque baleine aurait 96% de chance de survivre jusqu’à l’année suivante. Avec une augmentation tant de la survie que de la fécondité, on suppose que le taux de croissance annuel de la population de baleines serait de 1.02 à 1.10. Ces chiffres signifient que l’abondance de la population augmenterait de 2 à 10% par an. Dans cet exercice, vous simulerez le rétablissement de la population de baleines bleues avec l'application Shiny R."),
    p(HTML("<b>Questions</b>")),
    p(HTML("<ol>
         <li>Combien d’années sont nécessaires pour que la population double (atteigne 1000 individus) selon le taux de croissance le plus optimiste?</li>
         <li>Combien d’années sont nécessaires pour que la population double (atteigne 1000 individus) selon le taux de croissance le moins optimiste?</li>
         <li>De quelle façon le taux de croissance affecte-t-il l’effet de la pêche? Quelles sont les implications pour la protection de la baleine bleue?</li>
         <li>En quoi la modélisation de la croissance d’une population peut-elle être utile pour la conservation des espèces comme la baleine bleue? </li>
       </ol>
       "))
                )
              ),
#--- Ajouter le graphique de trajectoire de population
  fluidRow(
  style = "margin-bottom: 40px;",
    box(width = 8, #Taille du graphique
      plotlyOutput("population_plot_D") # Ici indiquer le nom de l'objet du graphique dans R
                ),
    #--- Boîte pour saisir taux de croissance, taille pop init et pas de temps
     box(width = 4,
      numericInput("taux_survie_D", "Taux de survie (s)", value= 1),
      numericInput("taux_fecondite_D", "Taux de fécondité (s)", value= 1),
      numericInput("population_initiale_D", "Taille de population initiale (N)", value = 1),
      numericInput("time_steps_D", "Temps (t)", value = 1)
                )
              ),
  #--- Ajouter un tableau dynamique avec les résultats du graphique
  fluidRow(
  style = "margin-bottom: 100px;",
    box(width = 8,
     dataTableOutput("population_table_D")
                )
              )
            )
          )
        )
      )
