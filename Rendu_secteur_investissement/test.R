install.packages("RMySQL")

install.packages("DBI")

library(DBI)

bd <- DBI::dbConnect(RMySQL::MySQL(),
                     
                     host = "60s.h.filess.io",
                     
                     port = 3307,
                     
                     username = "projetbddR_branchtail",
                     
                     password = "1d18ad70d67bdfdda2c3b9e8ad2701bfff775fb8",
                     
                     dbname = "projetbddR_branchtail")

dbListTables(bd)

requete <-"SELECT*
FROM Table_Activite 
JOIN Table_Entreprise 
ON (table_activite.code_activite = table_entreprise.code_Activite) 
JOIN Table_Region 
ON (table_entreprise.id_Region = table_region.id_region)
 WHERE (table_entreprise.ca_2022 - table_entreprise.ca_2020) = (
    SELECT MAX(ca_2022 - ca_2020)
    FROM Table_Entreprise
    WHERE ca_2022 IS NOT NULL AND ca_2020 IS NOT NULL
)
;"

resultat <- dbSendQuery(bd, requete)

fetch(resultat)

