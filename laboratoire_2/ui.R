#--- Activer les librairies nécessaires ---#
library(shiny) # Transforme code R en application
library(shinydashboard) # Thématique de mise en page
library(plotly) #Graphiques
library(DT) #Tableaux
library(rhandsontable)

#--- Définir l'interface de l'utilisateur
ui <- dashboardPage(
  
#--- Définir le titre de la page web
dashboardHeader(title = "Laboratoire 2"),
  
#--- Définir la liste déroulante sur le côté de la page
dashboardSidebar(
    #Définir les exercices du laboratoire dans la liste déroulante
    sidebarMenu(
      id = "tabs",
      menuItem("Exercice 2.1", tabName = "exercice_2_1"),
      menuItem("Exercice 2.2", tabName = "exercice_2_2"),
      menuItem("Exercice 2.3", tabName = "exercice_2_3"),
      menuItem("Exercice 2.4", tabName = "exercice_2_4")
    )
  ),
  
#--- Définir le contenu de la page web
dashboardBody(
    #Préciser la taille des marges gauche et droite
    style = "margin-left: 40px; margin-right: 40px;",
    tabItems(
      
      
#---------------------#
##### Exercice 2.1 ####
#---------------------#
#--- Nom de l'objet de la page dans R
tabItem(tabName = "exercice_2_1",  

#--- Ajouter une section pour intégrer des boîtes et du texte
  fluidRow(
    #Définir le titre de l'exercice
    titlePanel("Exercice 2.1 : Tenir compte de la stochasticité démographique"),
                #Taille du texte, justifier et ajouter de l'espace en dessous
                style = "text-align: justify; font-size: 16px; margin-bottom: 20px;",
    
    #--- Ajouter une boîte pour la mise en contexte
     box(width = 12,
         p("Dans cet exercice, vous allez prédire le changement dans la taille de la population de bœufs musqués entre 1936 et 1937, en tenant compte de la stochasticité démographique. Pour cet exercice, vous aurez besoin de générer des nombres aléatoires uniformes.")
         )
    ),

    #--- Ajouter une image de boeuf musqué
      fluidRow(
        style = "text-align: center; font-size: 16px; margin-bottom: 20px;",
          tags$figure(
          class = "centerFigure",
            tags$img(
            src = "muskox.jpg",
            width = 400)
          )
        ),

    #--- Mentionner les étapes en plusieurs paragraphes
      fluidRow(
        style = "text-align: justify; font-size: 16px; margin-bottom: 20px;", 
          box(width=12,
           p(HTML("<b>Étape 1</b>: La population de bœufs musqués comprenait 31 individus en 1936. <b>Écrivez ce nombre (N=31) sur un bout de papier </b>. Les étapes qui suivent (1.1 et 1.2) devront être répétées 31 fois, une fois pour chaque bœuf musqué sur Nunivak Island en 1936. Pour chaque répétition, utilisez une nouvelle paire de nombres aléatoires.")),
           p(HTML("<b>Étape 1.1</b>: Utilisez le premier nombre aléatoire pour décider si l’animal produit un jeune ou non. Si le premier nombre aléatoire est inférieur au taux de fécondité (f=0.227), alors augmentez N de 1, sinon, laissez le inchangé.")),
           p(HTML("<b>Étape 1.2</b>: Utilisez le deuxième nombre pour décider si l’animal survit ou meurt. Si le deuxième nombre est supérieur au taux de survie (s=0.921), alors diminuez N de 1, sinon, laissez le inchangé.")),
           p(HTML("<b>Étape 2</b>: Après avoir répété les étapes ci-dessus 31 fois, notez le N final. C’est votre estimation de la taille de la population de bœufs musqués en 1937.")),
           p(HTML("<b>Étape 3</b>: Répétez les étapes 1 et 2 quatre fois, pour un total de cinq essais. Vous aurez cinq estimations de la taille de la population de bœufs musqués en 1937. Commentez la variabilité parmi les résultats des cinq essais."))
           )
        ),
              
    #--- Ajouter bouton pour tirer des nombres aléatoires
      fluidRow(
       style = "margin-bottom: 40px;",
       #Bouton pour tirer des nombres aléatoires
       actionButton("generateButton", HTML("<b>Tirer une probabilité aléatoire de survie et de fécondité pour un individu</b>"))
       ),

    #--- Ajouter tableaux pour visualiser les nombres tirés
      fluidRow(
        style = "margin-bottom: 40px;",
        #Tableaux avec nombre aléatoire
       dataTableOutput("numbersTable")
    )
),
      
      
#--------------------#
#### Exercice 2.2 ####
#--------------------#
tabItem(tabName = "exercice_2_2",
  fluidRow(
  #Définir le titre de section
  titlePanel("Exercice 2.2: Construire un modèle pour le bœuf musqué"),
  style = "text-align: justify; font-size: 16px; margin-bottom: 10px;",
          
  #--- Étape 1
  box(width = 12,
    p(HTML("<b>Étape 1</b>:Effectuez une simulation déterministe (sans stochasticité) avec les informations suivantes")),
    p(HTML("<ol>
      <li>Nombre d'années (time steps)= 12</li>
      <li>Taille de population initiale (N)= 31</li>
      <li>Taille de survie (s)= 0.921</li>
      <li>Taux de croissance (R)= 1.148</li>
      </ol>")),
             
  #--- Ajouter le graphique avec des curseurs dynamiques
      column(width=8,
          plotOutput("plot_2_2_1")),
      column(width=4,
  numericInput("timeSteps_2_2_1", "Nombre d'années:", min = 1, max = 100, value = 1),
  numericInput("initialAbundance_2_2_1", "Taille de population initiale:", min = 1, max = 1000, value = 1),
  numericInput("survival_2_2_1", "Taux de survie (s):", min = 0, max = 1, value = 1),
  numericInput("fecundity_2_2_1", "Fécondité (f):", min = 0, max = 20, value = 1),
              ),
  column(width=12,
        tableOutput("table_2_2_1"))
    )
  ),
  
  #--- Étape 2
  fluidRow(
    style = "text-align: justify; font-size: 16px; margin-bottom: 10px;",
    box(width = 12,
     p(HTML("<b>Étape 2.</b> Décrivez la trajectoire que vous voyez. Quelle est la taille finale de la population?"))   
    )
  ),
  
  #--- Étape 3
  fluidRow(
    style = "text-align: justify; font-size: 16px; margin-bottom: 10px;",
      box(width = 12,
              p(HTML("<b>Étape 3</b>: Effectuez maintenant une simulation avec de la stochasticité démographique et environmenmtale avec les informations suivantes. La durée de la simulation (nombre d'années), la taille de population initiale, le taux de fécondité et le taux de survie sont les mêmes qu'à l'étape 2 dans le modèle.")),
              p(HTML("<ol>
      <li>Réplications= 100</li>
      <li>Stochasticité démographique= oui</li>
      <li>Écart-type de R (Standard deviation of R)= 0.075</li>
      </ol>")),
   
        column(width=8,
               plotOutput("plot_2_2_3")),
        column(width=4,
               numericInput("replicates_2_2_3", "Réplications:", min = 0, max = 1000, value = 1),
               radioButtons("stochasticite_2_2_3", label = "Stochasticité démographique", choices = list("Oui" = TRUE, "Non" = FALSE), selected = FALSE),
               numericInput("sd_R_2_2_3", "Écart-type de R (stochasticité environnementale):", min = 0, max = 20, value = 0)
               #POISSON DISTRIBUTION POUR FÉCONDITÉ DANS RAMAS
               #DISTRIBUTION NORMALE MORTALITÉ 
      )
    )
  ),
  
  #--- Étape 4
  fluidRow(
    style = "text-align: justify; font-size: 16px; margin-bottom: 10px;",
    box(width = 12,
        p(HTML("<b>Étape 4.</b> Comparez ces trajectoires à celle obtenue lors de la simulation déterministe. Est-ce que l’une de ces trajectoires est identique à la trajectoire déterministe? Quelle est la cause de la différence?"))   
    )
  ),
  
  #--- Étape 5
  fluidRow(
    style = "text-align: justify; font-size: 16px; margin-bottom: 10px;",
    box(width = 12,
        p(HTML("<b>Étape 5.</b> Vous pouvez également visualiser les valeurs moyennes, ainsi que la variation (écart-type) à chaque année à l'aide du graphique ci dessous. De plus, les valeurs minimum, moyennes et maximum sont présentées dans le tableau adjacent.")),
    column(width = 6,
           plotOutput("plot_2_2_5")),
    column(width = 6,
           tableOutput("table_2_2_5"))
    )
  ),

  #--- Ajouter la question étape 6
  fluidRow(
    style = "text-align: justify; font-size: 16px; margin-bottom: 10px;",
    box(width = 12,
      p(HTML("<b>Étape 6.</b>  Décrivez cette trajectoire. Dans quel intervalle varient les tailles de population finales?"))   
    )
  ),
  
  #--- Ajouter la question étape 6
  fluidRow(
    style = "text-align: justify; font-size: 16px; margin-bottom: 10px;",
    box(width = 12,
        p(HTML("<b>Étape 7.</b> Voici une courbe «Extinction/Decline» qui montre la probabilité que la population descende sous un seuil minimale de taille de population au moins une fois au cours des simulations. D’après cette courbe, quel est le risque que la population décline à 31 individus? Il peut être difficile de lire le risque d’après la courbe. Pour déterminer ce nombre précisément, vous pouvez vous référez au tableau adjacent.")),
        column(width = 6,
               plotOutput("plot_2_2_7")),
        column(width = 6,
               tableOutput("table_2_2_7"))
    )
  )
),    
    
      
#--------------------#
#### Exercice 2.3 ####
#--------------------#
tabItem(tabName = "exercice_2_3",
        
  fluidRow(
   titlePanel("Exercice 2.3: Construire des courbes de risque"),
   style = "text-align: justify; font-size: 16px; margin-bottom: 10px;",
    #Ajouter la mise en contexte de l'exercice
     box(width = 12,
      p("Dans cet exercice vous allez construire une courbe de risque de déclin (interval decline risk curve) basée sur le modèle du bœuf musqué de l'exercice 2.2.")
              )
   ),
  
  #--- Ajouter une image de boeuf musqué
  fluidRow(
    style = "text-align: center; font-size: 16px; margin-bottom: 20px;",
    tags$figure(
      class = "centerFigure",
      tags$img(
        src = "muskox2.jpg",
        width = 400)
    )
  ),
   
  #--- Étape 0
  fluidRow(
    style = "text-align: justify; font-size: 16px; margin-bottom: 20px;",
    box(width=12,
        p(HTML("<b>Étape 0:</b> Afin de réaliser l'exercice suivant, veuillez copier et coller le tableau ci-dessous sur Excel afin de le compléter. Si les en-tête de colonnes se retrouvent tous sur une même ligne, veuillez coller le tableau dans excel en utilisant les touches (ctrl + shift + v)  pour coller en tant que valeurs.")),
        column(width = 12,
               tableOutput("table_2_3_0"))
    )
  ),
          
  #--- Étape 1
  fluidRow(
    style = "text-align: justify; font-size: 16px; margin-bottom: 20px;",
      box(width=12,
          p(HTML("<b>Étape 1:</b> Au cours de la prochaine étape nous allons générer des trajectoires uniques. Pour vous y préparer, entrez les valeurs des paramètres ci-dessous. Notez ensuite dans votre tableau Excel la plus petite valeur que la trajectoire de population a atteint entre les unités de temps 1 et 5 de cette unique répétition. (Note: Ignorez l’unité de temps 0 pour laquelle l’abondance est toujours 31).
                  <ol>
                  <li>Nombre d'années= 5 ans</li>
                  <li>Taille de population initiale= 31 individus</li>
                  <li>Taux de survie= 0.921</li>
                  <li>Taux de natalité= 0.227</li>
                  <li>Écart-type de R= 0.075</li>
                  <li>Stochasticité démographique= oui</li>
                  <li>Réplications= 1</li>
                  </ol>")),
          column(width=8,
                 plotOutput("plot_2_3_1")),
          column(width=4,
                numericInput("timeSteps_2_3_1", "Nombre d'années:", min = 1, max = 100, value = 1),
                numericInput("initialAbundance_2_3_1", "Taille de population initiale:", min = 1, max = 1000, value = 1),
                numericInput("survival_2_3_1", "Taux de survie (s):", min = 0, max = 1, value = 1),
                numericInput("fecundity_2_3_1", "Fécondité (f):", min = 0, max = 20, value = 1),
                numericInput("sd_R_2_3_1", "Écart-type de R (stochasticité environnementale):", min = 0, max = 20, value = 0),
                radioButtons("stochasticite_2_3_1", label = "Stochasticité démographique", choices = list("Oui" = TRUE, "Non" = FALSE), selected = FALSE),
                 numericInput("replicates_2_3_1", "Réplications:", min = 0, max = 1000, value = 1)
            ),
          column(width = 12,
                 tableOutput("table_2_3_1"))
            )
          ),
  
  #--- Étape 2
  fluidRow(
    style = "text-align: justify; font-size: 16px; margin-bottom: 20px;",
    box(width=12,
        p(HTML("<b>Étape 2:</b> Répétez ensuite l'étape 1, 20 fois au total pour compléter votre tableau. Vous pouvez obtenir une nouvelle simulation simplement en désactivant et réactivant la stochasticité démographique."))
        ),
    
    box(width=12,
        p(HTML("<b>Étape 3:</b> Vous avez maintenant 20 tailles minimales de population. Classez-les en ordre croissant, puis copiez le tableau ci-dessous dans Excel pour générer des fréquences à partir des résultats de taille minimum de population. Pour se faire, notez par ordre croissant, dans la première colonne du tableau, les tailles de population minimales que vous avez obtenues. Il se peut que vous ayez obtenu plusieurs fois les mêmes tailles de population. Notez-les seulement une fois dans le tableau. Vous utiliserez certainement seulement une partie des lignes du tableau. Dans la deuxième colonne, notez combien de fois vous avez obtenu chacun des nombres notés dans la colonne 1. Dans la troisième colonne, cumulez les nombres de la deuxième colonne (comme dans le tableau 2.1 p. 42 du livre/document PDF Applied Population Ecology). Dans la quatrième colonne, calculez les probabilités en divisant les fréquences cumulées (troisième colonne) par le nombre total d’essais effectués (20). Notez que le tableau construit ici est similaire au tableau 2.1 (p.42), mais vos nombres seront différents puisque vous effectuez ici 20 répétitions alors que le tableau 2.1 a été construit à partir de 10 000 répétitions.")),
        column(width = 12,
               tableOutput("table_2_3_3"))
        )
      ),
  
  #--- Étape 4
  fluidRow(
    style = "text-align: justify; font-size: 16px; margin-bottom: 20px;",
    box(width=12,
        p(HTML("<b>Étape 4:</b> Copiez et collez les valeurs des columnes «Taille de la population (Nc)» et «Probabilité de décliner à Nc» dans le tableau ci-dessous pour obtenir la courbe de risque de déclin.")),
        #Saisie des données dans le tableau
        column(width=6,  rHandsontableOutput("editableTable_2_3_4")),
        #Visualisation des données en graphique
        column(width=6,  plotOutput("plot_2_3_4"))
    )
  )
),#tab item 2.3


#--------------------#
#### Exercice 2.4 ####
#--------------------#
tabItem(tabName = "exercice_2_4",
    fluidRow(
      titlePanel("Exercice 2.4: Analyse de sensibilité"),
      style = "text-align: justify; font-size: 16px; margin-bottom: 10px;", 
      
      #Mise en contexte
      box(width = 12,
       p("Au cours de cet exercice, vous utiliserez le modèle du bœuf musqué de l’exercice 2.2 pour analyser la sensibilité de la probabilité de quasi-explosion aux paramètres du modèle. Notre but est de décider quel paramètre du modèle a le plus d’influence sur la probabilité que la population de bœuf musqué atteigne 150 individus. Vous devrez considérer cette probabilité comme une mesure du succès du projet de réintroduction: supposez que le projet sera considéré comme un succès si la population de bœuf musqué atteint 150 individus au cours des 12 premières années.")
                ),
      
    #--- Étape 1
      box(width = 12,
          p(HTML("<b>Étape 1:</b> Entrez les valeurs des paramètres ci-dessous présentés tel que présenté à l'exercice 2.2.
                  <ol>
                  <li>Nombre d'années= 12 ans</li>
                  <li>Taille de population initiale= 31 individus</li>
                  <li>Taux de survie= 0.921</li>
                  <li>Taux de natalité= 0.227</li>
                  <li>Écart-type de R= 0.075</li>
                  <li>Stochasticité démographique= oui</li>
                  <li>Réplications= 100</li>
                  </ol>")),
          column(width=8,
                 plotOutput("plot_2_4_1")),
          column(width=4,
                 numericInput("timeSteps_2_4_1", "Nombre d'années:", min = 1, max = 100, value = 1),
                 numericInput("initialAbundance_2_4_1", "Taille de population initiale:", min = 1, max = 1000, value = 1),
                 numericInput("survival_2_4_1", "Taux de survie (s):", min = 0, max = 1, value = 1),
                 numericInput("fecundity_2_4_1", "Fécondité (f):", min = 0, max = 20, value = 1),
                 numericInput("sd_R_2_4_1", "Écart-type de R (stochasticité environnementale):", min = 0, max = 20, value = 0),
                 radioButtons("stochasticite_2_4_1", label = "Stochasticité démographique", choices = list("Oui" = TRUE, "Non" = FALSE), selected = FALSE),
                 numericInput("replicates_2_4_1", "Réplications:", min = 0, max = 1000, value = 1)
          ),
          column(width = 12,
                 tableOutput("table_2_4_1"))
      ),
    
    #--- Étape 2
    box(width = 12,
        p(HTML("<b>Étape 2:</b> Visualisez ensuite la courbe du risque de quasi-explosion et notez la probabilité d’atteindre au moins 150 individus dans les 12 prochaines années en utilisant les valeurs présentées dans le tableau.")),
        column(width = 6,
              plotOutput("plot_2_4_2")),
        column(width = 6,
               tableOutput("table_2_4_2"))
                ),
    
    #---Étape 3
    box(width = 12,
        p(HTML("<b>Étape 3:</b> Créez maintenant huit nouveaux modèles basés sur le modèle standard. Pour chaque modèle, augmentez ou diminuez un des quatre paramètres du modèle de 10% (voir ci-dessous) et gardez les autres trois paramètres similaires au modèle standard. Pour chaque modèle, notez les valeurs utilisées pour chaque paramètre ainsi que la probabilité d’atteindre au moins 150 individus dans les 12 prochaines années.")),
      p("*Notez qu’il y a des restrictions. Par exemple, le taux de survie (s) ne peut pas être inférieur à 0 ou supérieur à 1. Aussi, l’abondance initiale doit être un entier. Faites les ajustements ou les approximations nécessaires pour ces paramètres."),
      column(width=12,  rHandsontableOutput("editableTable_2_4_3")),
                ),
    
    #--- Étape 4
    box(width = 12,
        p(HTML("<b>Étape 4:</b> Notez les probabilités d'atteindre au moins 150 individus au cours des 12 prochaines années obtenues pour chaque scénario de valeur haute et basse des paramètres dans le tableau ci-dessous. Par la suite, calculer pour chaque paramètre la différence de probabilité de quasi-explosion entre les scénarios avec valeur basse et haute.")),
        column(width=12,  rHandsontableOutput("editableTable_2_4_4")),
    ),
    
    #--- Étape 5
    box(width = 12,
        p(HTML("<b>Étape 5:</b> 
               <ol>
                  <li>Dans quelle direction chaque paramètre affecte-t-il le résultat? </li>
                  <li>Quel paramètre affecte le plus les résultats quand le changement est de 10%? Qu’est-ce que ce résultat suggère concernant les études de terrain qui tentent d’estimer ces paramètres ou concernant des projets futurs similaires à celui-ci?</li>
               </ol>
      Notez que la sensibilité des résultats à une différence de + ou - 10% de taux de survie, du taux de croissance ou de son écart-type peut être interprétée en terme de précision dans l’estimation de ces paramètres, ou en terme de validité de ces paramètres si un projet similaire était lancé à d’autres endroits. À l’inverse, la sensibilité des résultats à une différence de + ou - 10% dans l’abondance initiale ne peut pas être interprétée en terme de précision: il n’est pas difficile de compter 31 animaux! Par contre, elle peut être interprétée en terme d’effet du nombre initial d’individus introduits sur le succès du projet.")),
    )
              )
            )#tab item 2.4
        ) #TabItems
      ) #Dashboardbody
)#DashboardPage