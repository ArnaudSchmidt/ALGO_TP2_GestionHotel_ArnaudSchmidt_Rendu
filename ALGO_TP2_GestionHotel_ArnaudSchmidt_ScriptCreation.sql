PRAGMA Foreign_keys = ON;

create table TITRE
	(
		TIT_CODE char(8) not null,
		TIT_LIBELLE varchar(32),
		
		primary key (TIT_CODE)
			
	);
	
create table PLANNING
	(
		PLN_JOUR date not null,
		
		primary key (PLN_JOUR)
			
	);
	
create table CHAMBRE
	(
		CHB_ID int(20) not null,
		CHB_NUMERO smallint(3) not null,
		CHB_ETAGE char(3) not null,
		CHB_BAIN int (1) DEFAULT 0,
		CHB_DOUCHE int (1) DEFAULT 0,
		CHB_WC int (1) DEFAULT 0,
		CHB_COUCHAGE smallint(1) not null,
		CHB_POSTE_TEL char(3) not null,
		
		primary key (CHB_ID)
			
	);
	
create table TARIF
	(
		TRF_DATE_DEBUT date not null,
		TRF_TAUX_TAXES real(3,2),
		TRF_PETIT_DEJEUNE real(3,2),
		
		primary key (TRF_DATE_DEBUT)
			
	);
	
create table CHB_TRF
	(
		TRF_CHB_PRIX real(5,2) not null,
		CHB_ID int(20) not null,
		TRF_DATE_DEBUT date not null,
		
		primary key (CHB_ID, TRF_DATE_DEBUT),
			
		foreign key (CHB_ID) references CHAMBRE(CHB_ID),
			
		foreign key (TRF_DATE_DEBUT) references TARIF(TRF_DATE_DEBUT)
			
	);

create table CLIENT
	(
		CLI_ID int(20) not null,
		CLI_NOM char(32),
		CLI_PRENOM varchar(25),
		CLI_ENSEIGNE varchar(100),
		TIT_CODE char(8),
		
		primary key (CLI_ID),
			
		foreign key (TIT_CODE) references TITRE(TIT_CODE)
			
	);
	
create table CLI_PLN_CHB
	(
		CHB_PLN_CLI_NB_PERS smallint(3) not null,
		CHB_PLN_CLI_RESERVE int (1) DEFAULT 0,
		CHB_PLN_CLI_OCCUPE int (1) DEFAULT 0,
		CLI_ID int(20) not null,
		PLN_JOUR date,
		CHB_ID int(20) not null,
		
		primary key (PLN_JOUR, CHB_ID),
			
		foreign key (CLI_ID) references CLIENT(CLI_ID),
			
		foreign key (PLN_JOUR) references PLANNING(PLN_JOUR),
			
		foreign key (CHB_ID) references CHAMBRE(CHB_ID)
			
	);
	
create table ADRESSE
	(
		ADR_ID int(20) not null,
		ADR_LIGNE1 varchar(32) not null,
		ADR_LIGNE2 varchar(32),
		ADR_LIGNE3 varchar(32),
		ADR_LIGNE4 varchar(32),
		ADR_CP char(5) not null,
		ADR_VILLE char(32),
		CLI_ID int(20) not null,
		
		primary key (ADR_ID),
			
		foreign key (CLI_ID) references CLIENT(CLI_ID)
			
	);
	
create table EMAIL
	(
		EML_ID int(20) not null,
		EML_ADRESSE varchar(100) not null,
		EML_LOCALISATION varchar(64),
		CLI_ID int(20) not null,
		
		primary key (EML_ID),
		
		foreign key (CLI_ID) references CLIENT(CLI_ID)
			
	);
	
create table TYPETEL
	(
		TYP_CODE char(8) not null,
		TYP_LIBELLE varchar(32),
		
		primary key (TYP_CODE)
			
	);
	
create table TELEPHONE
	(
		TEL_ID int(20) not null,
		TEL_NUMERO char(20) not null,
		TEL_LOCALISATION varchar(64),
		CLI_ID int(20) not null,
		TYP_CODE char(8) not null,
		
		primary key (TEL_ID),
			
		foreign key (CLI_ID) references CLIENT(CLI_ID),
			
		foreign key (TYP_CODE) references TYPETEL(TYP_CODE)
			
	);

create table MODE_PAIEMENT
	(
		PMT_CODE char(8) not null,
		PMT_LIBELLE varchar(64),
		
		primary key (PMT_CODE)
			
	);
	
create table FACTURE
	(
		FAC_ID int(20) not null,
		FAC_DATE date not null,
		FAC_PMT_DATE date not null,
		CLI_ID int(20) not null,
		PMT_CODE char(8) not null,
		
		primary key (FAC_ID),
			
		foreign key (CLI_ID) references CLIENT(CLI_ID),
			
		foreign key (PMT_CODE) references MODE_PAIEMENT(PMT_CODE)
			
	);
	
create table LIGNE_FACTURE
	(
		LIF_ID int(20) not null,
		LIF_QTE real(5,2),
		LIF_REMISE_POURCENT real(2,2),
		LIF_REMISE_MONTANT real(5,2),
		LIF_MONTANT real(5,2) not null,
		LIF_TAUX_TVA real(2,2),
		FAC_ID int(20) not null,

		primary key (LIF_ID),
			
		foreign key (FAC_ID) references FACTURE(FAC_ID)
			
	);
	