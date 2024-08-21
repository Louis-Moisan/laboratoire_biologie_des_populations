#----------------------------------------------------------------------------#
#### Fonction pour modéliser la croissance exponentielle d'une population ####
#----------------------------------------------------------------------------#
#Auteur: Louis Moisan
#Date: 21 Août 2024
#Dependencies:
library(stats)


exponential_growth <- function(
    duration, #Nombre de pas de temps (ex: années)
    initial_abundance, #Abondance initiale
    survival, #Taux de survie moyen
    fecundity, #Taux de fécondité moyen
    standard_deviation_R, #Écart-type du taux de croissance (stochasticité environnementale)
    demographic_stochasticity, #Stochasticité démographique (TRUE or FALSE)
    number_replicates) #Nombre de réplications ou simulations à effectuer
  {
 

#----------------------------------------#
#### Définir les paramètres du modèles####  
#----------------------------------------#
#Extraire un vecteur des pas de temps (ex: 0,1,2,3...)
time_steps <- seq(0, duration)

#Si le nombre de réplications est fixé à 0
  if(number_replicates == 0) {
    number_replicates <- 1 #Redéfinir le nombre de réplication à 1, mais
    demographic_stochasticity <- FALSE #ne pas considérer la stochasticité démographique et
    standard_deviation_R <- 0 #ne pas considérer la stochasticité environnementale
  }

#Créer un cadre de données ("data frame") vide pour stocker les données
output_df <- data.frame()


#------------------------------------------#
##### AVEC STOCHASTICITÉ DÉMOGRAPHIQUE #####
#------------------------------------------#
#Si la stochasticité démographique est considérée, alors
if(demographic_stochasticity == TRUE){
  
  #pour chaque simulation
    for (i in 1:number_replicates){
      
      #et pour chaque pas de temps au sein d'une simulation
      for (t in time_steps){
        
        #si le premier pas de temps est 0, assignée la taille de population initiale comme taille de population
        if (t == 0) {
          population_size <- initial_abundance
          
        #sinon calculer la taille de la population
        } else {
          
          #Si la population était de 0 au pas de temps précédent (éteinte), alors sauter les étapes suivantes et maintenir la taille de la population à 0 pour le reste des pas de temps.
          if(population_size==0){
            population_size= 0
         
          #Si ce n'est pas le cas, alors calculer la taille de la population en tenant compte de la stochasticité.
            } else { 
            
  #--------------------------------------#
  #--- STOCHASTICITÉ ENVIRONNEMENTALE ---#
  #--------------------------------------#
  #!!! Note !!! Si l'écart-type de R est défini à 0 (sans stochasticité environnementale), les étapes suivantes n'affecteront pas les valeurs des paramètres du modèle et la stochasticité environnementale ne sera pas considérée. 

  #Échantillonner aléatoirement un taux de croissance annuel pour le pas de temps donné à partir d'une distribution normale centrée sur le taux de croissance (R) moyen et l'écart-type du taux de croissance
  R_annual <-  rnorm(1, mean = (survival+fecundity), sd = standard_deviation_R)
  #Calculer le coefficient de changement du taux de croissance par rapport au taux de croissance moyen pour ensuite déterminer les taux de survie et de fécondité annuels. (ex: 75 % ou 110 % le taux de croissance moyen) 
  coef_environmental_stochas <- R_annual/(survival+fecundity)
             
  #Déterminer le taux de survie annuel à partir du taux de survie moyen et du coefficient de changement du taux de croissance
  survival_annual <- survival*coef_environmental_stochas
  #Si le taux de survie ajusté est plus petit que 0 (négatif), le maintenir à 0 et s'il est plus grand que 1, le maintenir à 1.
  survival_annual <- ifelse(survival_annual < 0, 0, ifelse(survival_annual > 1, 1, survival_annual))
            
  #Faire la même chose pour le taux de fécondité
  fecundity_annual<- fecundity*coef_environmental_stochas
  #Toutefois, ici le taux de fécondité peut être plus grand que 1
  fecundity_annual <- ifelse(fecundity_annual < 0, 0, fecundity_annual)
            
  #-----------------------------------#
  #--- STOCHASTICITÉ DÉMOGRAPHIQUE ---#
  #-----------------------------------#
  #https://www.sciencedirect.com/science/article/pii/0304380091901038
  
  #À partir du nouveau taux de survie ajusté selon la stochasticité environnementale, effectuer un tirage binomiale (0 ou 1) pour chaque individu pour déterminer réellement combien d'individus ont survécus
  survivors <- rbinom(population_size, 1, survival_annual)
  #Calculer ensuite combien de jeunes sont produit par individu avec le taux de fécondité ajusté, cette fois-ci on utilise une distribution de Poisson, car certains individus peuvent faire plus qu'un jeune en une année
  offspring <- rpois(population_size, fecundity_annual)
  #Déterminer la taille de population obtenue en considérant le nombre de survivants et le nombre de jeunes produits
  population_size <- sum(survivors) + sum(offspring)
          }
        }
        
  #Ajouter la taille de population calculée pour le pas de donné dans le cadre de données   
  output_df <- rbind(output_df, data.frame(Time = t, Population = population_size, Replicate = i))
      }
    }

  
#------------------------------------------#
##### SANS STOCHASTICITÉ DÉMOGRAPHIQUE #####
#------------------------------------------#
#Si la stochasticité démographique n'est pas considérée
  }else {
    
    #alors pour chaque réplication ou simulation
    for (i in 1:number_replicates) {
      
      #et pour chaque pas de temps d'une réplication donnée
      for (t in time_steps) {
        
        #Si le pas de temps est le premier (0)
        if (t == 0) {
          #alors utiliser la taille de population initiale, comme taille de population
          population_size <- initial_abundance
        } else {
          
  #--------------------------------------#
  #--- STOCHASTICITÉ ENVIRONNEMENTALE ---#
  #--------------------------------------#
  #Ajuster le taux de croissance annuel en considérant la stochasticité environnementale en pigeant une valeur de taux de croissance annuel à partir d'une distribution normale centrée sur le taux de croissance moyen et avec l'écart-type du taux de croissance.
  growth_rate_annual <- rnorm(1, mean = (fecundity+survival), sd = standard_deviation_R)

  #Si le taux de croissance est plus petit que 0, alors le maintenir à 0
  growth_rate_annual <- ifelse(growth_rate_annual < 0, 0, growth_rate_annual)
          
  #Estimer la taille de population à partir du taux de croissance ajusté avec la stochasticité environnementale
  population_size <- round(population_size * growth_rate_annual, digits=0)
        }
  #Ajouter les données au cdre de données ("data frame")
  output_df <- rbind(output_df, data.frame(Time = t, Population = population_size, Replicate = i))
      }
    }
  }

#La fonction retourne un object "data frame" comprenant les colonnes: "Time", "Population" et "Replicate"
return(output_df)
} 
