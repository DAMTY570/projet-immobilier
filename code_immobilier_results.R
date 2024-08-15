data <- read.csv('indices_prix.csv')
View(data)

library(dplyr)
data$X <- substring(data$X, 1, nchar(data$X) - 7)
data$X <- gsub("_+$", "", data$X)
df <- data %>%
  pivot_wider(names_from = X, values_from = indice_prix)

df$date <- paste(df$mois, df$annee, sep = "-")
df$date <- as.Date(paste0("01-", df$date), format = "%d-%m-%Y")

df <- select(df, date, everything()[-227])
df <- select(df, -annee,-mois)

install.packages("dynlm")
library(dynlm)

str(df)
df <- ts(df, frequency = 12)


################
# plot paris
###############
paris_plot <- dplyr::select(df,
                           "Paris_appart",
                           "periph_Paris_appart",
                           "dep_93_appart")

paris_plot <- ts(paris_plot, frequency = 12, start = c(2010,1), end = c(2020,12))
                          
plot(paris_plot,ylim=c(-10,20),
     xlab = 'Années',
     ylab = '',
     main = "Évolution de l'indice de prix au mètre carré pour Paris")

#############
# plot bordeaux
#############

bordeaux_plot <- dplyr::select(df,
                            "Bordeaux_appart",
                            "periph_Bordeaux_appart",
                            "dep_33_appart")

bordeaux_plot <- ts(bordeaux_plot, frequency = 12, start = c(2010,1), end = c(2020,12))

plot(bordeaux_plot,ylim=c(-10,20),
     xlab = 'Années',
     ylab = c('sup','supp','su'),
     main = "Évolution de l'indice de prix au mètre carré pour Bordeaux")

##########
# Nice plot
##########
nice_plot <- dplyr::select(df,
                               "Nice_appart",
                               "periph_Nice_appart",
                               "dep_06_appart")

nice_plot <- ts(nice_plot, frequency = 12, start = c(2010,1), end = c(2020,12))

plot(nice_plot,ylim=c(-10,20),
     xlab = 'Années',
     ylab = c('sup','supp','su'),
     main = "Évolution de l'indice de prix au mètre carré pour Nice")

##########
# Toulon plot
##########
toulon_plot <- dplyr::select(df,
                           "Toulon_appart",
                           "periph_Toulon_appart",
                           "dep_83_appart")

toulon_plot <- ts(toulon_plot, frequency = 12, start = c(2010,1), end = c(2020,12))

plot(toulon_plot,ylim=c(-10,20),
     xlab = 'Années',
     ylab = c('sup','supp','su'),
     main = "Évolution de l'indice de prix au mètre carré pour Toulon")

toulon <- lm(log(periph_Toulon_appart) ~ log(Toulon_appart),
                 data = df)
summary(toulon)
paris <- lm(log(periph_Paris_appart) ~ log(Paris_appart),
             data = df)
summary(paris)
toulouse <- lm(log(periph_Toulouse_appart) ~ log(Toulouse_appart),
             data = df)
summary(toulouse)
marseille <- lm(log(periph_Marseille_appart) ~ log(Marseille_appart) + log(Aix_appart),
             data = df)
summary(marseille)
Lyon <- lm(log(periph_Lyon_appart) ~ log(Lyon_appart),
            data = df)
summary(Lyon)
Nice <- lm(log(periph_Nice_appart) ~ log(Nice_appart) + log(Cannes_appart),
               data = df)
summary(Nice)
Nantes <- lm(log(periph_Nantes_appart) ~ log(Nantes_appart),
             data = df)
summary(Nantes)
Bordeaux <- lm(log(periph_Bordeaux_appart) ~ log(Bordeaux_appart),
               data = df)
summary(Bordeaux)
Lille <- lm(log(periph_Lille_appart) ~ log(Lille_appart) + log(Roubaix_Tourcoing_appart),
               data = df)
summary(Lille)
Rennes <- lm(log(periph_Rennes_appart) ~ log(Rennes_appart),
               data = df)
summary(Rennes)


toulon <- lm(log(periph_Toulon_maison) ~ log(Toulon_maison),
             data = df)
summary(toulon)
paris <- lm(log(periph_Paris_maison) ~ log(Paris_maison),
            data = df)
summary(paris)
toulouse <- lm(log(periph_Toulouse_maison) ~ log(Toulouse_maison),
               data = df)
summary(toulouse)
marseille <- lm(log(periph_Marseille_maison) ~ log(Marseille_maison) + log(Aix_maison),
                data = df)
summary(marseille)
Lyon <- lm(log(periph_Lyon_maison) ~ log(Lyon_maison),
           data = df)
summary(Lyon)
Nice <- lm(log(periph_Nice_maison) ~ log(Nice_maison) + log(Cannes_maison),
           data = df)
summary(Nice)
Nantes <- lm(log(periph_Nantes_maison) ~ log(Nantes_maison),
             data = df)
summary(Nantes)
Bordeaux <- lm(log(periph_Bordeaux_maison) ~ log(Bordeaux_maison),
               data = df)
summary(Bordeaux)
Lille <- lm(log(periph_Lille_maison) ~ log(Lille_maison) + log(Roubaix_Tourcoing_maison),
            data = df)
summary(Lille)
Rennes <- lm(log(periph_Rennes_maison) ~ log(Rennes_maison),
             data = df)
summary(Rennes)

villes <- c('Paris',
'Marseille',
'Lyon',
'Toulouse',
'Nice',
'Nantes',
'Bordeaux',
'Lille',
'Rennes',
'Toulon',
'Cannes',
'Aix',
'Roubaix_Tourcoing')

estimates_appart <- c(1.00458,0.22489,0.67100,0.71755,0.72588,0.67296,0.55645,0.09238,0.71649,0.55398,0.40329,0.50755,0.41833)
estimates_maison <- c(0.63734,0.50553,0.82177,0.76049,0.41451,0.78203,0.80199,0.65197,0.58853,0.86983,0.08822,0.50246,0.35654)


results <- data.frame(villes,estimates_appart,estimates_maison)

knitr::kable(results, "latex")

.labs = results$villes
install.packages("ggrepel")
library(ggrepel)


ggplot(results, aes(x = estimates_appart, y = estimates_maison)) +
  geom_point(aes(color = villes)) +
  geom_label_repel(aes(label = .labs,  color = villes), size = 3)+
  theme_bw()+
  theme(legend.position = "none")+
  labs(title = "Résultat des estimations du prix au mètre carré de la périphérie en fonction de leurs villes-centre",
       subtitle = "Les prix sont estimés en log")




toulon <- lm(log(dep_83_appart) ~ log(Toulon_appart),
             data = df)
summary(toulon)
paris <- lm(log(dep_78_appart) ~ log(Paris_appart),
            data = df)
summary(paris)
toulouse <- lm(log(dep_31_appart) ~ log(Toulouse_appart),
               data = df)
summary(toulouse)
marseille <- lm(log(dep_13_appart) ~ log(Marseille_appart) + log(Aix_appart),
                data = df)
summary(marseille)
Lyon <- lm(log(dep_69_appart) ~ log(Lyon_appart),
           data = df)
summary(Lyon)
Nice <- lm(log(dep_06_appart) ~ log(Nice_appart) + log(Cannes_appart),
           data = df)
summary(Nice)
Nantes <- lm(log(dep_44_appart) ~ log(Nantes_appart),
             data = df)
summary(Nantes)
Bordeaux <- lm(log(dep_33_appart) ~ log(Bordeaux_appart),
               data = df)
summary(Bordeaux)
Lille <- lm(log(dep_59_appart) ~ log(Lille_appart) + log(Roubaix_Tourcoing_appart),
            data = df)
summary(Lille)
Rennes <- lm(log(dep_35_appart) ~ log(Rennes_appart),
             data = df)
summary(Rennes)



estimates_appart <- c(0.25573,0.50547,0.06815,-0.16740,0.31173,0.4779,0.17842,-1.02539,0.44524,0.55575,0.60011,0.22578,1.30466)
estimates_maison <- c(0.26974,0.47244,0.54696,0.33233,0.07566,0.43212,0.48725,0.02312,0.38224,0.72771,0.16442,0.41384,0.67853)


results <- data.frame(villes,estimates_appart,estimates_maison)

ggplot(results, aes(x = estimates_appart, y = estimates_maison)) +
  geom_point(aes(color = villes)) +
  geom_label_repel(aes(label = .labs,  color = villes), size = 3)+
  theme_bw()+
  theme(legend.position = "none")+
  labs(title = "Résultat des estimations du prix au mètre carré de la zone rurale en fonction de leurs villes-centre",
       subtitle = "Les prix sont estimés en log")

villes <- c('Paris',
            'Marseille',
            'Lyon',
            'Toulouse',
            'Nice',
            'Nantes',
            'Bordeaux',
            'Lille',
            'Rennes',
            'Toulon',
            'Cannes',
            'Aix',
            'Roubaix_Tourcoing')

toulon <- lm(log(dep_83_maison) ~ log(Toulon_maison),
             data = df)
summary(toulon)
paris <- lm(log(dep_78_maison) ~ log(Paris_maison),
            data = df)
summary(paris)
toulouse <- lm(log(dep_31_maison) ~ log(Toulouse_maison),
               data = df)
summary(toulouse)
marseille <- lm(log(dep_13_maison) ~ log(Marseille_maison) + log(Aix_maison),
                data = df)
summary(marseille)
Lyon <- lm(log(dep_69_maison) ~ log(Lyon_maison),
           data = df)
summary(Lyon)
Nice <- lm(log(dep_06_maison) ~ log(Nice_maison) + log(Cannes_maison),
           data = df)
summary(Nice)
Nantes <- lm(log(dep_44_maison) ~ log(Nantes_maison),
             data = df)
summary(Nantes)
Bordeaux <- lm(log(dep_33_maison) ~ log(Bordeaux_maison),
               data = df)
summary(Bordeaux)
Lille <- lm(log(dep_59_maison) ~ log(Lille_maison) + log(Roubaix_Tourcoing_maison),
            data = df)
summary(Lille)
Rennes <- lm(log(dep_35_maison) ~ log(Rennes_maison),
             data = df)
summary(Rennes)


knitr::kable(results, "latex")
