#--------------------------------------------------------------#
#### Fonction pour modéliser la croissance d'une population ####
#--------------------------------------------------------------#
#Auteur: Louis Moisan
#Date: 21 Août 2024
#Dependencies:
library(stats)


exponential_growth <- function(
    duration, #Nombre de pas de temps (ex: années)
    initial_abundance, #Abondance initiale
    survival, #Taux de survie moyen
    fecundity, #Taux de fécondité moyen
    growth_rate, #Taux de croissance
    standard_deviation_R, #Écart-type du taux de croissance (stochasticité environnementale)
    demographic_stochasticity, #Stochasticité démographique (TRUE or FALSE)
    number_replicates) #Nombre de réplications ou simulations à effectuer
{
  
  #---------------------------------------------#
  #### Définir certains paramètres du modèles####  
  #---------------------------------------------#
  #Extraire un vecteur des pas de temps (ex: 0,1,2,3...)
  time_steps <- seq(0, duration)
  
  #Calculer le taux de croissance maximale (Rmax)
  if(is.null(growth_rate)== FALSE){
    R <- growth_rate
  }else {
    R <- fecundity+survival
  }
  
  
  #Si le nombre de réplications est fixé à 0
  if(number_replicates == 0) {
    number_replicates <- 1 #Redéfinir le nombre de réplication à 1, mais
    demographic_stochasticity <- FALSE #ne pas considérer la stochasticité démographique et
    standard_deviation_R <- 0 #ne pas considérer la stochasticité environnementale
  }
  
  #Créer un cadre de données ("data frame") vide pour stocker les données
  output_df <- data.frame()
  
  #----------------------------#
  #### Lancer la simulation ####
  #----------------------------#
  #pour chaque simulation
  for (i in 1:number_replicates){
    
    #et pour chaque pas de temps au sein d'une simulation
    for (t in time_steps){
      
      #si le premier pas de temps est 0, assigner la taille de population initiale comme taille de population
      if (t == 0) {
        population_size <- initial_abundance
        
        #sinon calculer la taille de la population
      } else {
        
        #Si la population était de 0 au pas de temps précédent (éteinte), alors sauter les étapes suivantes et maintenir la taille de la population à 0 pour le reste des pas de temps.
        if(population_size==0){
          population_size= 0
          
          #Si ce n'est pas le cas, alors calculer la taille de la population
        } else { 
          
          #----------------------------------------#
          ##### Stochasticité environnementale #####
          #----------------------------------------#                           
          #!!! Note !!! Si l'écart-type de R est défini à 0 (sans stochasticité environnementale), les étapes suivantes n'affecteront pas les valeurs des paramètres du modèle et la stochasticité environnementale ne sera pas considérée.
          R_annual <-  rnorm(1, mean = R, sd = standard_deviation_R)
          R_annual <- ifelse(R_annual < 0, 0, R_annual)              
          
          
          #------------------------------------------#
          ##### Avec Stochasticité démographique #####
          #------------------------------------------#
          #Avec stochasticité démographique
          if(demographic_stochasticity == TRUE){
            #https://www.sciencedirect.com/science/article/pii/0304380091901038
            
            #Calculer le coefficient de changement du taux de croissance par rapport au taux de croissance moyen pour ensuite déterminer les taux de survie et de fécondité annuels. (ex: 75 % ou 110 % le taux de croissance moyen) 
            coef_environmental_stochas <- R_annual/R
            
            #Déterminer le taux de survie annuel à partir du taux de survie moyen et du coefficient de changement du taux de croissance
            survival_annual <- survival*coef_environmental_stochas
            #Si le taux de survie ajusté est plus petit que 0 (négatif), le maintenir à 0 et s'il est plus grand que 1, le maintenir à 1.
            survival_annual <- ifelse(survival_annual < 0, 0, ifelse(survival_annual > 1, 1, survival_annual))
            
            #Déterminer la fécondité annuelle selon survie et taux de croissance
            fecundity_annual<- (R_annual- survival_annual)
            
            #Effectuer un tirage binomiale (0 ou 1) pour chaque individu pour déterminer réellement combien d'individus ont survécus
            survivors <- rbinom(population_size, 1, survival_annual)
            #Calculer ensuite combien de jeunes sont produit par individu avec le taux de fécondité ajusté, cette fois-ci on utilise une distribution de Poisson, car certains individus peuvent faire plus qu'un jeune en une année
            offspring <- rpois(population_size, fecundity_annual)
            
            #Déterminer la taille de population obtenue en considérant le nombre de survivants et le nombre de jeunes produits
            population_size <- sum(survivors) + sum(offspring)
          }
          
          #------------------------------------------#      
          ##### Sans stochasticité démographique #####
          #------------------------------------------#   
          if(demographic_stochasticity == FALSE){
            population_size <- round(population_size * R_annual, digits=0)
          } 
        }
      }
          #----------------------------------------------------------------#
          ##### Ajouter les données au cdre de données ("data frame") ######
          #----------------------------------------------------------------#
      #Ajouter le taille de population calculée au cadre de données
      output_df <- rbind(output_df, data.frame(Time = t, Population = population_size, Replicate = i))
    }
  }
  #La fonction retourne un object "data frame" comprenant les colonnes: "Time", "Population" et "Replicate"
  return(output_df)
} 
