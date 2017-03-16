--Nombre de clients
select count(CLI_ID)
from CLIENT;

--Les clients triés sur le titre et le nom
select TIT_CODE as 'Civilité', CLI_NOM as 'Nom du client'
from CLIENT
order by TIT_CODE, CLI_NOM asc;

--Les clients triés sur le libellé du titre et le nom
select TIT_LIBELLE as 'Civilité', CLI_NOM as 'Nom du client'
from CLIENT, TITRE
where CLIENT.TIT_CODE = TITRE.TIT_CODE
order by TIT_LIBELLE asc, CLI_NOM asc;

--Les clients commençant par 'B'
select CLI_ID as 'Numéro client', TIT_CODE as 'Civilité', CLI_NOM as 'Nom du client'
from CLIENT
where upper(CLI_NOM) like upper('B%');

--Les clients homonymes


--Nombre de titres différents
select distinct(TIT_CODE) as 'Les différentes civilités'
from TITRE;

--Nombre d'enseignes
select count(CLI_ENSEIGNE)
from CLIENT;

--Les clients qui représentent une enseigne 
select *
from CLIENT
where CLI_ENSEIGNE not null;

--Les clients qui représentent une enseigne de transports
select *
from CLIENT
where upper(CLI_ENSEIGNE) like upper('%transports%');

--Nombre d'hommes,Nombres de femmes, de demoiselles, Nombres de sociétés
select SUM( CASE WHEN TIT_CODE = 'M.' THEN 1 ELSE 0 END ) as "Nombre d'hommes",
SUM( CASE WHEN TIT_CODE = 'Mme.' THEN 1 ELSE 0 END ) as 'Nombre de femmes',
SUM( CASE WHEN TIT_CODE = 'Melle.' THEN 1 ELSE 0 END ) as 'Nombre de demoiselles',
count(distinct(CLI_ENSEIGNE)) as 'Nombre de sociétés'
from CLIENT;

--Nombre d''emails
select count(EML_ID) as "Nombre d'emails"
from EMAIL;

--Client sans email 
select CLI_ID as 'Numéro du client sans adresse mail', TIT_CODE as 'Civilité', CLI_NOM as 'Nom du client sans adresse mail'
from CLIENT as C
where CLI_ID not in ( select CLI_ID from EMAIL where CLI_ID = C.CLI_ID);

--Clients sans téléphone 
select CLI_ID as 'Numéro du client sans téléphone', TIT_CODE as 'Civilité', CLI_NOM as 'Nom du client sans téléphone'
from CLIENT as C
where CLI_ID not in ( select CLI_ID from TELEPHONE where CLI_ID = C.CLI_ID);

--Les phones des clients
select CLIENT.CLI_ID as 'Numéro du client', TIT_CODE as 'Civilité', CLI_NOM as 'Nom du client', TEL_NUMERO as 'Numéro de téléphone du client'
from CLIENT, TELEPHONE
where CLIENT.CLI_ID = TELEPHONE.CLI_ID;

--Ventilation des phones par catégorie
select SUM( CASE WHEN TYP_CODE = 'TEL' THEN 1 ELSE 0 END ) as "Nombre de téléphones fixes",
SUM( CASE WHEN TYP_CODE = 'GSM' THEN 1 ELSE 0 END ) as 'Nombre de téléphones portables',
SUM( CASE WHEN TYP_CODE = 'FAX' THEN 1 ELSE 0 END ) as 'Nombre de télécopieurs'
from TELEPHONE;

--Les clients ayant plusieurs téléphones


--Clients sans adresse:
select CLI_ID as 'Numéro du client sans adresse', TIT_CODE as 'Civilité', CLI_NOM as 'Nom du client sans adresse'
from CLIENT as C
where CLI_ID not in ( select CLI_ID from ADRESSE where CLI_ID = C.CLI_ID);

--Clients sans adresse mais au moins avec mail ou phone 
select CLI_ID as 'Numéro du client sans adresse', TIT_CODE as 'Civilité', CLI_NOM as 'Nom du client sans adresse'
from CLIENT as C
where CLI_ID not in ( select CLI_ID from ADRESSE where CLI_ID = C.CLI_ID)
and ( ( CLI_ID in ( select CLI_ID from EMAIL where CLI_ID = C.CLI_ID )) OR ( CLI_ID in ( select CLI_ID from TELEPHONE where CLI_ID = C.CLI_ID )) );

--Dernier tarif renseigné
select max(TRF_DATE_DEBUT) as 'Dernier tarif renseigné'
from TARIF;

--Tarif débutant le plus tôt


--Différentes Années des tarifs
select distinct(strftime('%Y',TRF_DATE_DEBUT)) as 'Années de début des tarifs'
from TARIF;

--Nombre de chambres de l'hotel 
select count(CHB_ID) as "Nombre de chambres de l'hotel"
from CHAMBRE;

--Nombre de chambres par étage
select SUM( CASE WHEN CHB_ETAGE = 'RDC' THEN 1 ELSE 0 END ) as "Nombre de chambres au RDC",
SUM( CASE WHEN CHB_ETAGE = '1er' THEN 1 ELSE 0 END ) as 'Nombre de chambres au premier étage',
SUM( CASE WHEN CHB_ETAGE = '2e' THEN 1 ELSE 0 END ) as 'Nombre de chambres au deuxième étage'
from CHAMBRE;

--Chambres sans telephone
select CHB_NUMERO as 'Chambres sans téléphone'
from CHAMBRE
where CHB_POSTE_TEL is null;

--Existence d'une chambre n°13 ?
select *
from CHAMBRE
where CHB_NUMERO = 13;		--pas top je sais, pas top du tout

--Chambres avec sdb
select CHB_NUMERO as 'Chambres avec salle de bain'
from CHAMBRE
where CHB_BAIN <> 0;

--Chambres avec douche
select CHB_NUMERO as 'Chambres avec douche'
from CHAMBRE
where CHB_DOUCHE <> 0;

--Chambres avec WC


--Chambres sans WC séparés
select CHB_NUMERO as 'Chambres avec WC séparés'
from CHAMBRE
where CHB_WC <> 0;

--Quels sont les étages qui ont des chambres sans WC séparés ?

--Nombre d'équipements sanitaires par chambre trié par ce nombre d'équipement croissant

--Chambres les plus équipées et leur capacité

--Repartition des chambres en fonction du nombre d'équipements et de leur capacité

--Nombre de clients ayant utilisé une chambre

--Clients n'ayant jamais utilisé une chambre (sans facture)

--Nom et prénom des clients qui ont une facture

--Nom, prénom, telephone des clients qui ont une facture

--Attention si email car pas obligatoire : jointure externe

--Adresse où envoyer factures aux clients

--Répartition des factures par mode de paiement (libellé)

--Répartition des factures par mode de paiement 

--Différence entre ces 2 requêtes ? 

--Factures sans mode de paiement 

--Repartition des factures par Années

--Repartition des clients par ville

--Montant TTC de chaque ligne de facture (avec remises)

--Classement du montant total TTC (avec remises) des factures

--Tarif moyen des chambres par années croissantes

--Tarif moyen des chambres par étage et années croissantes

--Chambre la plus cher et en quelle année

--Chambre la plus cher par année 

--Clasement décroissant des réservation des chambres 

--Classement décroissant des meilleurs clients par nombre de réservations

--Classement des meilleurs clients par le montant total des factures

--Factures payées le jour de leur édition

--Facture dates et Délai entre date de paiement et date d'édition de la facture