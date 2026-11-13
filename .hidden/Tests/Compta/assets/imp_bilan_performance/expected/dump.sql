-- schéma
/*M!999999\- enable the sandbox mode */ 
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Comptes` (
  `compte` char(8) NOT NULL,
  `intitule` varchar(40) DEFAULT NULL,
  `solde` decimal(14,4) NOT NULL,
  `solde2` decimal(14,4) NOT NULL,
  `annee` char(2) DEFAULT NULL,
  `numrub` char(5) DEFAULT NULL,
  `intitrub` varchar(40) DEFAULT NULL,
  `type` char(1) DEFAULT NULL,
  `detail` char(1) DEFAULT NULL,
  `Col1` char(14) DEFAULT NULL,
  `Col2` char(14) DEFAULT NULL,
  `col3` char(14) DEFAULT NULL,
  `col4` char(14) DEFAULT NULL,
  `amortissement` tinyint(1) DEFAULT NULL,
  `amortissement2` tinyint(1) DEFAULT NULL,
  `actif` tinyint(1) DEFAULT NULL,
  `actif2` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`compte`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Corsage` (
  `acode` char(8) NOT NULL,
  `ncode` char(8) DEFAULT NULL,
  PRIMARY KEY (`acode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Docs_Ged` (
  `type` tinyint(4) DEFAULT NULL,
  `code` varchar(15) DEFAULT NULL,
  `compte` char(8) DEFAULT NULL,
  `origin` varchar(15) DEFAULT NULL,
  `url` tinytext NOT NULL,
  `filename` tinytext DEFAULT NULL,
  `mime` tinytext NOT NULL,
  `date` datetime NOT NULL,
  `ttc` decimal(12,2) DEFAULT NULL,
  `ht` decimal(12,2) DEFAULT NULL,
  `lind` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`lind`),
  KEY `idx_code` (`code`,`type`,`compte`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Docs_Tag` (
  `doc_lind` int(11) NOT NULL,
  `tag_lind` int(11) NOT NULL,
  PRIMARY KEY (`doc_lind`,`tag_lind`),
  KEY `idx_tag` (`tag_lind`,`doc_lind`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Acomptes` (
  `lind` int(11) NOT NULL AUTO_INCREMENT,
  `intitule` varchar(35) DEFAULT NULL,
  `type` varchar(15) DEFAULT NULL,
  `dte` datetime DEFAULT NULL,
  `cli_code` char(8) DEFAULT NULL,
  `ntk` char(7) DEFAULT NULL,
  `montant` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`lind`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_AdrlivBL` (
  `numbl` char(6) NOT NULL,
  `nom` varchar(90) DEFAULT NULL,
  `adr1` varchar(35) DEFAULT NULL,
  `adr2` varchar(35) DEFAULT NULL,
  `cp` char(5) DEFAULT NULL,
  `ville` varchar(35) DEFAULT NULL,
  PRIMARY KEY (`numbl`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_AdrlivC` (
  `num` int(11) NOT NULL AUTO_INCREMENT,
  `code` int(11) NOT NULL,
  `rs_soc` char(9) DEFAULT NULL,
  `nom` varchar(35) DEFAULT NULL,
  `pnm` varchar(35) DEFAULT NULL,
  `adr1` varchar(35) DEFAULT NULL,
  `adr2` varchar(35) DEFAULT NULL,
  `cd_ptl` char(5) DEFAULT NULL,
  `ville` varchar(35) DEFAULT NULL,
  `tourne` char(15) DEFAULT NULL,
  PRIMARY KEY (`num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Agenda` (
  `lind` int(11) NOT NULL AUTO_INCREMENT,
  `daction` varchar(20) DEFAULT NULL,
  `haction` varchar(20) DEFAULT NULL,
  `iaction` mediumtext DEFAULT NULL,
  `nuser` varchar(35) DEFAULT NULL,
  PRIMARY KEY (`lind`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Analytiques` (
  `lind` int(11) NOT NULL AUTO_INCREMENT,
  `code` char(3) DEFAULT NULL,
  `compte` char(8) DEFAULT NULL,
  `pourcent` int(11) DEFAULT NULL,
  PRIMARY KEY (`lind`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Art` (
  `art_code` varchar(15) NOT NULL,
  `art_design` varchar(50) DEFAULT NULL,
  `art_fam` char(20) DEFAULT NULL,
  `art_four` varchar(8) DEFAULT NULL,
  `art_cequ` varchar(15) DEFAULT NULL,
  `art_cbarre` varchar(15) DEFAULT NULL,
  `art_cfour` varchar(25) DEFAULT NULL,
  `art_pbht` double DEFAULT NULL,
  `art_tr` double DEFAULT NULL,
  `art_paht` double DEFAULT NULL,
  `art_coef` decimal(7,4) DEFAULT NULL,
  `art_pvht` double DEFAULT NULL,
  `art_tva` char(2) DEFAULT NULL,
  `art_pvttc` double DEFAULT NULL,
  `art_cdarr` varchar(4) DEFAULT NULL,
  `art_pvar` double DEFAULT NULL,
  `art_dec` varchar(1) DEFAULT NULL,
  `art_stocke` tinyint(1) DEFAULT NULL,
  `art_qte` double DEFAULT NULL,
  `art_dpa` double DEFAULT NULL,
  `art_dfour` varchar(8) DEFAULT NULL,
  `art_pmp` double DEFAULT NULL,
  `art_com` double DEFAULT NULL,
  `art_stkdep` double DEFAULT NULL,
  `art_nbd` varchar(1) DEFAULT NULL,
  `art_design2` varchar(50) DEFAULT NULL,
  `art_ect` int(11) DEFAULT NULL,
  `art_eco` double DEFAULT NULL,
  `art_pauaht` double DEFAULT NULL,
  `art_txconv` decimal(7,4) DEFAULT NULL,
  `art_stkmin` double DEFAULT NULL,
  `art_stkmax` double DEFAULT NULL,
  `art_suspendu` tinyint(1) DEFAULT NULL,
  `art_cpp` tinyint(1) DEFAULT NULL,
  `art_copp` double DEFAULT NULL,
  `qte1` double DEFAULT NULL,
  `qte2` double DEFAULT NULL,
  `rem1` double DEFAULT NULL,
  `qte3` double DEFAULT NULL,
  `qte4` double DEFAULT NULL,
  `rem2` double DEFAULT NULL,
  `qte5` double DEFAULT NULL,
  `qte6` double DEFAULT NULL,
  `rem3` double DEFAULT NULL,
  `qte7` double DEFAULT NULL,
  `qte8` double DEFAULT NULL,
  `rem4` double DEFAULT NULL,
  `qte9` double DEFAULT NULL,
  `qte10` double DEFAULT NULL,
  `rem5` double DEFAULT NULL,
  `qte11` double DEFAULT NULL,
  `qte12` double DEFAULT NULL,
  `rem6` double DEFAULT NULL,
  `art_frais` double DEFAULT NULL,
  `art_prvt` decimal(12,3) DEFAULT NULL,
  `art_etiq` tinyint(1) DEFAULT NULL,
  `art_poids` decimal(11,3) DEFAULT NULL,
  `art_mincom` varchar(12) DEFAULT NULL,
  `art_vol` char(5) DEFAULT NULL,
  `art_poids2` decimal(11,3) DEFAULT NULL,
  `art_photo` text DEFAULT NULL,
  `art_crst` mediumtext DEFAULT NULL,
  `art_mat` tinyint(1) DEFAULT NULL,
  `art_marque` varchar(20) DEFAULT NULL,
  `art_impcar` tinyint(1) DEFAULT NULL,
  `art_casier` char(5) DEFAULT NULL,
  `art_pvcons` decimal(12,3) DEFAULT NULL,
  `art_prdcomp` tinyint(1) DEFAULT NULL,
  `art_impdetail` tinyint(1) DEFAULT NULL,
  `art_remcas1` decimal(5,2) DEFAULT NULL,
  `art_remcas2` decimal(5,2) DEFAULT NULL,
  `art_remcas3` decimal(5,2) DEFAULT NULL,
  `art_datefbt` date DEFAULT NULL,
  `art_pbfbt` decimal(12,3) DEFAULT NULL,
  `art_ddatefbt` date DEFAULT NULL,
  `art_centrale` char(2) DEFAULT NULL,
  `art_refcentrale` char(13) DEFAULT NULL,
  `art_bonus` decimal(5,2) DEFAULT NULL,
  `art_colvte` decimal(12,3) DEFAULT NULL,
  `art_pvht2` decimal(12,3) DEFAULT NULL,
  `art_cn8` char(12) DEFAULT NULL,
  `art_crpl1` char(15) DEFAULT NULL,
  `art_crpl2` char(15) DEFAULT NULL,
  `art_ect2` tinyint(1) DEFAULT NULL,
  `art_eco2` decimal(6,3) DEFAULT NULL,
  `art_depg` tinyint(4) DEFAULT NULL,
  `art_cnsg` tinyint(4) DEFAULT NULL,
  `art_ua` char(5) DEFAULT NULL,
  `art_uv` char(5) DEFAULT NULL,
  `art_refliee` char(15) DEFAULT NULL,
  `art_ddate` datetime DEFAULT NULL,
  `art_cdate` datetime DEFAULT NULL,
  `export` tinyint(4) DEFAULT 0,
  `art_bredu` tinyint(4) DEFAULT 0,
  `art_bredudate` date DEFAULT NULL,
  `art_breducond` text DEFAULT NULL,
  `art_bredumnt` decimal(15,2) DEFAULT 0.00,
  PRIMARY KEY (`art_code`),
  KEY `idx_fam` (`art_fam`),
  KEY `idx_cfour` (`art_cfour`,`art_four`),
  KEY `idx_four` (`art_four`),
  KEY `idx_cequ` (`art_cequ`),
  KEY `idx_cbarre` (`art_cbarre`),
  KEY `idx_refcentrale` (`art_refcentrale`,`art_centrale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_ArtPromo` (
  `code_promo` char(6) NOT NULL,
  `code` varchar(15) NOT NULL,
  `libelle` varchar(50) DEFAULT NULL,
  `pmp` decimal(12,3) DEFAULT NULL,
  `pht` decimal(12,3) DEFAULT NULL,
  `pttc` decimal(12,3) DEFAULT NULL,
  `qte` decimal(12,3) DEFAULT NULL,
  PRIMARY KEY (`code_promo`,`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Avoirs` (
  `lind` int(11) NOT NULL AUTO_INCREMENT,
  `intitule` varchar(35) DEFAULT NULL,
  `montant` decimal(12,2) DEFAULT NULL,
  `ntk` char(7) DEFAULT NULL,
  `dte` datetime DEFAULT NULL,
  `type` varchar(15) DEFAULT NULL,
  `cli_code` char(8) DEFAULT NULL,
  PRIMARY KEY (`lind`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Banques` (
  `banques_code` int(2) NOT NULL,
  `banques_nom` varchar(35) DEFAULT NULL,
  `banques_dmln` varchar(35) DEFAULT NULL,
  `banques_nume` char(6) DEFAULT NULL,
  `banques_codeb` varchar(5) DEFAULT NULL,
  `banques_codeg` varchar(5) DEFAULT NULL,
  `banques_numcpt` varchar(11) DEFAULT NULL,
  `banques_numsiren` varchar(15) DEFAULT NULL,
  `banques_adr` char(1) DEFAULT NULL,
  `banques_txt` mediumtext DEFAULT NULL,
  `banques_fenrg` char(6) DEFAULT NULL,
  `banques_mail` varchar(35) DEFAULT NULL,
  `banques_ref` varchar(11) DEFAULT NULL,
  `banques_entete` varchar(150) DEFAULT NULL,
  `banques_corps` mediumtext DEFAULT NULL,
  `banques_reftireur` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`banques_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Bl` (
  `numbl` varchar(6) NOT NULL,
  `type` varchar(1) DEFAULT NULL,
  `cdclibl` varchar(8) DEFAULT NULL,
  `cvclibl` varchar(9) DEFAULT NULL,
  `nmclibl` varchar(35) DEFAULT NULL,
  `pnmclibl` varchar(35) DEFAULT NULL,
  `adr1bl` varchar(35) DEFAULT NULL,
  `adr2bl` varchar(35) DEFAULT NULL,
  `cpbl` varchar(5) DEFAULT NULL,
  `villebl` varchar(35) DEFAULT NULL,
  `tvar` int(11) DEFAULT NULL,
  `datebl` datetime DEFAULT NULL,
  `rmobl` varchar(6) DEFAULT NULL,
  `rartbl` varchar(6) DEFAULT NULL,
  `exobl` int(11) DEFAULT NULL,
  `remmobl` double DEFAULT NULL,
  `remartbl` double DEFAULT NULL,
  `marge_art` double DEFAULT NULL,
  `marge_mo` double DEFAULT NULL,
  `totalht` double DEFAULT NULL,
  `imp` tinyint(1) DEFAULT NULL,
  `acpt` varchar(12) DEFAULT NULL,
  `mreg` varchar(10) DEFAULT NULL,
  `reg` varchar(15) DEFAULT NULL,
  `ech` datetime DEFAULT NULL,
  `numfac` varchar(10) DEFAULT NULL,
  `dtefac` datetime DEFAULT NULL,
  `retro` tinyint(1) DEFAULT NULL,
  `numserie` varchar(15) DEFAULT NULL,
  `codep` varchar(15) DEFAULT NULL,
  `mtreg` varchar(12) DEFAULT NULL,
  `totalttc` double DEFAULT NULL,
  `desg1` varchar(50) DEFAULT NULL,
  `desg2` varchar(50) DEFAULT NULL,
  `marque` varchar(15) DEFAULT NULL,
  `typemat` varchar(15) DEFAULT NULL,
  `htbl` tinyint(4) DEFAULT NULL,
  `cdep` varchar(37) DEFAULT NULL,
  `livraison` tinyint(1) DEFAULT NULL,
  `tel` varchar(16) DEFAULT NULL,
  `reg2` varchar(15) DEFAULT NULL,
  `mtreg2` varchar(12) DEFAULT NULL,
  `acquitte` tinyint(1) DEFAULT NULL,
  `numtick` char(7) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `gestbl` decimal(5,2) DEFAULT 0.00,
  PRIMARY KEY (`numbl`),
  KEY `idx_cdcli` (`cdclibl`,`type`),
  KEY `idx_type_date` (`type`,`datebl`),
  KEY `idx_numfac` (`numfac`),
  KEY `idx_numtick` (`numtick`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_BlM` (
  `numbl` char(6) NOT NULL,
  `type` char(1) DEFAULT NULL,
  `cdclibl` char(8) DEFAULT NULL,
  `cvclibl` varchar(9) DEFAULT NULL,
  `nmclibl` varchar(35) DEFAULT NULL,
  `pnmclibl` varchar(35) DEFAULT NULL,
  `adr1bl` varchar(35) DEFAULT NULL,
  `adr2bl` varchar(35) DEFAULT NULL,
  `cpbl` char(5) DEFAULT NULL,
  `villebl` varchar(35) DEFAULT NULL,
  `tvar` tinyint(4) DEFAULT NULL,
  `datebl` datetime DEFAULT NULL,
  `rmobl` char(6) DEFAULT NULL,
  `rartbl` char(5) DEFAULT NULL,
  `exobl` tinyint(4) DEFAULT NULL,
  `remmobl` decimal(12,2) DEFAULT NULL,
  `remartbl` decimal(12,2) DEFAULT NULL,
  `marge_art` decimal(12,2) DEFAULT NULL,
  `marge_mo` decimal(12,2) DEFAULT NULL,
  `totalht` decimal(12,2) DEFAULT NULL,
  `imp` tinyint(1) DEFAULT NULL,
  `acpt` varchar(12) DEFAULT NULL,
  `mreg` varchar(10) DEFAULT NULL,
  `reg` varchar(15) DEFAULT NULL,
  `ech` date DEFAULT NULL,
  `numfac` char(10) DEFAULT NULL,
  `dtefac` date DEFAULT NULL,
  `retro` tinyint(4) DEFAULT NULL,
  `numserie` varchar(15) DEFAULT NULL,
  `codep` varchar(15) DEFAULT NULL,
  `mtreg` varchar(12) DEFAULT NULL,
  `totalttc` decimal(12,2) DEFAULT NULL,
  `desg1` varchar(50) DEFAULT NULL,
  `desg2` varchar(50) DEFAULT NULL,
  `marque` varchar(15) DEFAULT NULL,
  `typemat` varchar(15) DEFAULT NULL,
  `htbl` tinyint(4) DEFAULT NULL,
  `cdep` varchar(37) DEFAULT NULL,
  `livraison` tinyint(1) DEFAULT NULL,
  `tel` varchar(16) DEFAULT NULL,
  `reg2` varchar(15) DEFAULT NULL,
  `mtreg2` varchar(12) DEFAULT NULL,
  `acquitte` tinyint(1) DEFAULT NULL,
  `numtick` char(7) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `gestbl` decimal(5,2) DEFAULT 0.00,
  PRIMARY KEY (`numbl`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Bordereaux` (
  `lind` int(11) NOT NULL AUTO_INCREMENT,
  `banque` int(1) DEFAULT NULL,
  `codeentree` int(1) DEFAULT NULL,
  `dateremise` date DEFAULT NULL,
  `refremise` char(11) DEFAULT NULL,
  `datevaleur` date DEFAULT NULL,
  `ech1` date DEFAULT NULL,
  `ech2` date DEFAULT NULL,
  `bordereau` int(11) DEFAULT NULL,
  `tot` decimal(12,2) DEFAULT NULL,
  `etat` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`lind`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_BordereauxC` (
  `lind` int(11) NOT NULL AUTO_INCREMENT,
  `banque` int(1) DEFAULT NULL,
  `dateremise` date DEFAULT NULL,
  `bordereau` int(11) DEFAULT NULL,
  `montant` decimal(12,2) DEFAULT NULL,
  `etat` tinyint(1) DEFAULT NULL,
  `code` char(8) DEFAULT NULL,
  `nom` varchar(35) DEFAULT NULL,
  `nfacture` char(10) DEFAULT NULL,
  PRIMARY KEY (`lind`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Caisses` (
  `lind` int(11) NOT NULL AUTO_INCREMENT,
  `code` char(2) DEFAULT NULL,
  `intitule` varchar(30) DEFAULT NULL,
  `dteov` datetime DEFAULT NULL,
  `dtefm` datetime DEFAULT NULL,
  `fndc` decimal(12,2) DEFAULT NULL,
  `tkz` tinyint(1) DEFAULT NULL,
  `connecte` tinyint(1) DEFAULT NULL,
  `imp` char(15) DEFAULT NULL,
  `typeimp` char(10) DEFAULT NULL,
  `type` char(20) DEFAULT NULL,
  `ecole` tinyint(4) DEFAULT NULL,
  `poste` varchar(30) DEFAULT NULL,
  `depot` char(8) DEFAULT NULL,
  `fndtotp` decimal(15,2) DEFAULT NULL,
  `fndtotg` decimal(15,2) DEFAULT NULL,
  `cutk` char(7) DEFAULT NULL,
  `vdr_code` char(2) DEFAULT NULL,
  PRIMARY KEY (`lind`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Carte` (
  `code` char(13) NOT NULL,
  `rs_soc` char(9) DEFAULT NULL,
  `nom` varchar(35) DEFAULT NULL,
  `pnm` varchar(35) DEFAULT NULL,
  `adr1` varchar(35) DEFAULT NULL,
  `adr2` varchar(35) DEFAULT NULL,
  `cd_ptl` char(5) DEFAULT NULL,
  `ville` varchar(35) DEFAULT NULL,
  `email` varchar(40) DEFAULT NULL,
  `tel_bur` varchar(16) DEFAULT NULL,
  `tel_dom` varchar(16) DEFAULT NULL,
  `tel_poste` varchar(16) DEFAULT NULL,
  `pble` varchar(16) DEFAULT NULL,
  `fx1` varchar(16) DEFAULT NULL,
  `fx2` varchar(16) DEFAULT NULL,
  `datec` date DEFAULT NULL,
  `datef` date DEFAULT NULL,
  `rem` tinyint(4) DEFAULT NULL,
  `promo` tinyint(4) DEFAULT NULL,
  `tp1` decimal(12,3) DEFAULT NULL,
  `tp2` decimal(12,3) DEFAULT NULL,
  `tg1` decimal(12,3) DEFAULT NULL,
  `tg2` decimal(12,3) DEFAULT NULL,
  `obs` mediumtext DEFAULT NULL,
  `cb` char(13) DEFAULT NULL,
  `divers` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_CdBarre` (
  `codep` varchar(15) NOT NULL,
  `codeb` char(13) NOT NULL,
  PRIMARY KEY (`codep`,`codeb`),
  KEY `idx_codeb` (`codeb`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_CdFour` (
  `codep` char(15) NOT NULL,
  `codef` char(13) NOT NULL,
  PRIMARY KEY (`codep`,`codef`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Centrales` (
  `code` char(2) NOT NULL,
  `libelle` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Cequ` (
  `codep` char(15) NOT NULL,
  `codequ` char(15) NOT NULL,
  PRIMARY KEY (`codep`,`codequ`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Cli` (
  `cli_code` int(11) NOT NULL DEFAULT 0,
  `cli_col` varchar(1) DEFAULT NULL,
  `cli_rs_soc` varchar(12) DEFAULT NULL,
  `cli_nom` varchar(35) DEFAULT NULL,
  `cli_pnm` varchar(35) DEFAULT NULL,
  `cli_adr1` varchar(35) DEFAULT NULL,
  `cli_adr2` varchar(35) DEFAULT NULL,
  `cli_cd_ptl` varchar(5) DEFAULT NULL,
  `cli_ville` varchar(35) DEFAULT NULL,
  `cli_email` varchar(150) DEFAULT NULL,
  `cli_tel_bur` varchar(16) DEFAULT NULL,
  `cli_tel_dom` varchar(16) DEFAULT NULL,
  `cli_tel_poste` varchar(16) DEFAULT NULL,
  `cli_pble` varchar(16) DEFAULT NULL,
  `cli_fx1` varchar(16) DEFAULT NULL,
  `cli_fx2` varchar(16) DEFAULT NULL,
  `cli_plaf_ecrs` varchar(10) DEFAULT NULL,
  `cli_cd_bq` varchar(5) DEFAULT NULL,
  `cli_cd_gch` varchar(5) DEFAULT NULL,
  `cli_dmln` varchar(30) DEFAULT NULL,
  `cli_cle_rib` varchar(2) DEFAULT NULL,
  `cli_num_cpt` char(11) DEFAULT NULL,
  `cli_dom` varchar(25) DEFAULT NULL,
  `cli_cd_ent` varchar(1) DEFAULT NULL,
  `cli_cd_acc` varchar(1) DEFAULT NULL,
  `cli_ref_tir` varchar(10) DEFAULT NULL,
  `cli_id_tva` varchar(15) DEFAULT NULL,
  `cli_cd_soc` varchar(2) DEFAULT NULL,
  `cli_cd_cli` varchar(16) DEFAULT NULL,
  `cli_co_vtl` varchar(255) DEFAULT NULL,
  `cli_rlvc` int(11) DEFAULT NULL,
  `cli_rlvf` int(11) DEFAULT NULL,
  `cli_dt_rlc` datetime DEFAULT NULL,
  `cli_nm_int` varchar(25) DEFAULT NULL,
  `cli_obs` mediumtext DEFAULT NULL,
  `cli_collectif` varchar(8) DEFAULT NULL,
  `cli_rmo` varchar(6) DEFAULT NULL,
  `cli_rart` varchar(6) DEFAULT NULL,
  `cli_exo` int(11) DEFAULT NULL,
  `cli_cdech` varchar(2) DEFAULT NULL,
  `cli_typec` char(2) DEFAULT NULL,
  `cli_expl` char(1) DEFAULT NULL,
  `cli_pays` char(40) DEFAULT NULL,
  `cli_statut` char(2) DEFAULT NULL,
  `cli_rs_soc2` char(9) DEFAULT NULL,
  `cli_nom2` varchar(35) DEFAULT NULL,
  `cli_pnm2` varchar(35) DEFAULT NULL,
  `cli_adr12` varchar(35) DEFAULT NULL,
  `cli_adr22` varchar(35) DEFAULT NULL,
  `cli_cd_ptl2` char(5) DEFAULT NULL,
  `cli_ville2` varchar(35) DEFAULT NULL,
  `cli_cnt1` char(17) DEFAULT NULL,
  `cli_cnt2` char(40) DEFAULT NULL,
  `cli_cnt3` char(25) DEFAULT NULL,
  `cli_cnt4` char(17) DEFAULT NULL,
  `cli_cnt5` char(40) DEFAULT NULL,
  `cli_cnt6` char(25) DEFAULT NULL,
  `cli_cnt7` char(17) DEFAULT NULL,
  `cli_cnt8` char(40) DEFAULT NULL,
  `cli_cnt9` char(25) DEFAULT NULL,
  `cli_cnt10` char(17) DEFAULT NULL,
  `cli_cnt11` char(40) DEFAULT NULL,
  `cli_cnt12` char(25) DEFAULT NULL,
  `cli_cnt13` char(17) DEFAULT NULL,
  `cli_cnt14` char(40) DEFAULT NULL,
  `cli_cnt15` char(25) DEFAULT NULL,
  `cli_reg` char(15) DEFAULT NULL,
  `cli_copie` tinyint(1) DEFAULT NULL,
  `cli_actif` tinyint(1) DEFAULT NULL,
  `cli_div` tinyint(1) DEFAULT NULL,
  `cli_iban` char(30) DEFAULT NULL,
  `cli_bic` char(11) DEFAULT NULL,
  `cli_coop` tinyint(1) DEFAULT NULL,
  `cli_rum` char(30) DEFAULT NULL,
  `cli_datab` char(2) DEFAULT NULL,
  `cli_aban` varchar(15) DEFAULT NULL,
  `cli_sage` char(10) DEFAULT NULL,
  `cli_livraison` tinyint(1) DEFAULT NULL,
  `cli_comm` char(2) DEFAULT NULL,
  `cli_autoent` tinyint(1) DEFAULT NULL,
  `cli_tour` char(15) DEFAULT NULL,
  `cli_gestion` decimal(5,2) DEFAULT 0.00,
  `cli_regr` char(1) DEFAULT NULL,
  `cli_siret` char(14) DEFAULT NULL,
  `libel_def` tinytext DEFAULT NULL,
  `tag_def` tinytext DEFAULT NULL,
  PRIMARY KEY (`cli_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Cli_Vtl` (
  `code` varchar(8) NOT NULL,
  `code_vtl` varchar(8) NOT NULL,
  `intitule_vtl` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`code`,`code_vtl`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Clid` (
  `adr` varchar(200) DEFAULT NULL,
  `ddate` date DEFAULT NULL,
  `lind` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`lind`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_ClientCaisse` (
  `lInd` tinyint(4) NOT NULL AUTO_INCREMENT,
  `code` varchar(8) DEFAULT NULL,
  `nom` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`lInd`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_CoeffTypec` (
  `lind` int(11) NOT NULL AUTO_INCREMENT,
  `coder` char(2) DEFAULT NULL,
  `codef` char(20) DEFAULT NULL,
  `coeff` decimal(6,3) DEFAULT NULL,
  PRIMARY KEY (`lind`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_ComMail` (
  `numcom` char(2) NOT NULL,
  `intitule` mediumtext DEFAULT NULL,
  PRIMARY KEY (`numcom`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Commentaires` (
  `numcom` varchar(2) NOT NULL,
  `intitule` mediumtext DEFAULT NULL,
  PRIMARY KEY (`numcom`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Commerciaux` (
  `lind` int(11) NOT NULL AUTO_INCREMENT,
  `code` char(2) DEFAULT NULL,
  `nom` char(35) DEFAULT NULL,
  `prenom` char(35) DEFAULT NULL,
  `comm` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`lind`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Comptes` (
  `compte_cc` int(11) NOT NULL DEFAULT 0,
  `intitule_cc` varchar(40) DEFAULT NULL,
  `type_cc` varchar(1) DEFAULT NULL,
  `coll` int(11) DEFAULT NULL,
  `coll_cc` varchar(8) DEFAULT NULL,
  `cent_cc` int(11) DEFAULT NULL,
  `comptr_cc` int(11) DEFAULT NULL,
  `code_tvente` char(2) DEFAULT NULL,
  `taux_tvente` varchar(5) DEFAULT NULL,
  `gen_tv` int(11) DEFAULT NULL,
  `code_tachat` char(2) DEFAULT NULL,
  `taux_tachat` varchar(5) DEFAULT NULL,
  `gen_ta` int(11) DEFAULT NULL,
  `solde` double DEFAULT NULL,
  `soldep` double DEFAULT NULL,
  `cprincipal` tinyint(1) DEFAULT NULL,
  `lettrable` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`compte_cc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_ContactC` (
  `num` int(11) NOT NULL AUTO_INCREMENT,
  `code` int(11) NOT NULL,
  `nom` varchar(35) DEFAULT NULL,
  `pnm` varchar(35) DEFAULT NULL,
  `fonction` varchar(35) DEFAULT NULL,
  `tel` varchar(16) DEFAULT NULL,
  `mail` varchar(150) DEFAULT NULL,
  `portable` char(16) DEFAULT NULL,
  PRIMARY KEY (`num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_ContactF` (
  `num` int(11) NOT NULL AUTO_INCREMENT,
  `code` int(11) NOT NULL,
  `nom` varchar(35) DEFAULT NULL,
  `pnm` varchar(35) DEFAULT NULL,
  `fonction` varchar(35) DEFAULT NULL,
  `tel` varchar(16) DEFAULT NULL,
  `mail` varchar(150) DEFAULT NULL,
  `portable` char(16) DEFAULT NULL,
  PRIMARY KEY (`num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Cpostaux` (
  `lind` int(11) NOT NULL AUTO_INCREMENT,
  `cp` char(5) DEFAULT NULL,
  `burdist` char(35) DEFAULT NULL,
  PRIMARY KEY (`lind`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Depots` (
  `code` char(8) NOT NULL,
  `libelle` varchar(35) DEFAULT NULL,
  `adr1` varchar(35) DEFAULT NULL,
  `adr2` varchar(35) DEFAULT NULL,
  `cp` char(5) DEFAULT NULL,
  `ville` varchar(35) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Docactif` (
  `doc_type` char(12) NOT NULL,
  `doc_num` char(25) NOT NULL,
  `user_name` varchar(50) DEFAULT NULL,
  `process_id` int(11) DEFAULT NULL,
  `machine_id` varchar(50) DEFAULT NULL,
  `host_id` varchar(50) DEFAULT NULL,
  `userdb_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`doc_type`,`doc_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Echeances` (
  `num` varchar(2) NOT NULL,
  `libell` varchar(20) DEFAULT NULL,
  `duree` varchar(2) DEFAULT NULL,
  `finmois` tinyint(1) DEFAULT NULL,
  `jours` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_EntMat` (
  `numserie` varchar(15) NOT NULL,
  `codep` varchar(15) NOT NULL,
  `libelle` mediumtext DEFAULT NULL,
  `bloc` char(6) DEFAULT NULL,
  `numbl` char(6) NOT NULL,
  `marque` varchar(20) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  `design` varchar(50) DEFAULT NULL,
  `design2` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`numserie`,`codep`,`numbl`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_EntTicketz` (
  `lInd` int(11) NOT NULL AUTO_INCREMENT,
  `caisse` char(2) DEFAULT NULL,
  `numero` char(7) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `client` varchar(30) DEFAULT NULL,
  `scheque` char(1) DEFAULT NULL,
  `mcheque` char(12) DEFAULT NULL,
  `nmcheque` varchar(30) DEFAULT NULL,
  `scarte` char(1) DEFAULT NULL,
  `nmcarte` varchar(30) DEFAULT NULL,
  `mcarte` char(12) DEFAULT NULL,
  `sespeces` char(1) DEFAULT NULL,
  `mespeces` char(12) DEFAULT NULL,
  `scredit` char(1) DEFAULT NULL,
  `mcredit` char(12) DEFAULT NULL,
  `nmcredit` varchar(30) DEFAULT NULL,
  `sbachat` char(1) DEFAULT NULL,
  `mbachat` char(12) DEFAULT NULL,
  `scavoir` char(1) DEFAULT NULL,
  `mavoir` char(12) DEFAULT NULL,
  `nmavoir` varchar(30) DEFAULT NULL,
  `mht` char(12) DEFAULT NULL,
  `mtva` char(12) DEFAULT NULL,
  `mttc` char(12) DEFAULT NULL,
  `statut` char(1) DEFAULT NULL,
  `savoir` char(1) DEFAULT NULL,
  `type` char(1) DEFAULT NULL,
  `mrem` char(12) DEFAULT NULL,
  `vendeur` varchar(35) DEFAULT NULL,
  `carte` char(13) DEFAULT NULL,
  `points` decimal(12,3) DEFAULT NULL,
  `sbonus` char(1) DEFAULT NULL,
  `mbonus` char(12) DEFAULT NULL,
  `sresto` char(1) DEFAULT NULL,
  `mresto` char(12) DEFAULT NULL,
  `nom` varchar(35) DEFAULT NULL,
  `retro` tinyint(1) DEFAULT NULL,
  `suppr` tinyint(1) DEFAULT NULL,
  `control` varchar(40) DEFAULT NULL,
  `prev_numero` char(7) DEFAULT NULL,
  `sautre` char(1) DEFAULT NULL,
  `mautre` char(12) DEFAULT NULL,
  PRIMARY KEY (`lInd`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Entcom` (
  `four` varchar(8) NOT NULL,
  `numcom` varchar(15) NOT NULL,
  `ddate` datetime DEFAULT NULL,
  `montant` double DEFAULT NULL,
  `reliquat` tinyint(1) DEFAULT NULL,
  `montantttc` varchar(12) DEFAULT NULL,
  `anomalie` tinyint(1) DEFAULT NULL,
  `commentaire` mediumtext DEFAULT NULL,
  PRIMARY KEY (`four`,`numcom`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Entrecpt` (
  `four` varchar(8) NOT NULL,
  `numrecpt` varchar(15) NOT NULL,
  `ddate` datetime DEFAULT NULL,
  `montant` decimal(12,3) DEFAULT NULL,
  `validee` tinyint(2) DEFAULT 0,
  `mttc` decimal(12,3) DEFAULT NULL,
  `anomalie` tinyint(1) DEFAULT NULL,
  `commentaire` mediumtext DEFAULT NULL,
  PRIMARY KEY (`four`,`numrecpt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_EtiGond` (
  `code` varchar(25) NOT NULL,
  `nombre` decimal(12,0) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_EtiProd` (
  `code` varchar(25) NOT NULL,
  `nombre` decimal(12,0) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Etiquettes` (
  `code` char(1) NOT NULL,
  `nblargeur` decimal(2,0) DEFAULT NULL,
  `nbhauteur` decimal(2,0) DEFAULT NULL,
  `largeur` decimal(5,0) DEFAULT NULL,
  `hauteur` decimal(5,0) DEFAULT NULL,
  `mrghaut` decimal(5,0) DEFAULT NULL,
  `mrgauche` decimal(5,0) DEFAULT NULL,
  `esplargeur` decimal(5,0) DEFAULT NULL,
  `esphauteur` decimal(5,0) DEFAULT NULL,
  `libelle` char(25) DEFAULT NULL,
  `page` varchar(20) NOT NULL,
  PRIMARY KEY (`code`,`page`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Fam` (
  `code_fam` char(20) NOT NULL,
  `libell_fam` varchar(30) DEFAULT NULL,
  `compt_fam` varchar(8) DEFAULT NULL,
  `coef_fam` decimal(6,3) DEFAULT NULL,
  `cdtva_fam` char(2) DEFAULT NULL,
  `txtva_fam` double DEFAULT NULL,
  `cptrem_fam` varchar(10) DEFAULT NULL,
  `ect_fam` double DEFAULT NULL,
  `rem_fam` double DEFAULT NULL,
  `qte1` double DEFAULT NULL,
  `qte2` double DEFAULT NULL,
  `rem1` double DEFAULT NULL,
  `qte3` double DEFAULT NULL,
  `qte4` double DEFAULT NULL,
  `rem2` double DEFAULT NULL,
  `qte5` double DEFAULT NULL,
  `qte6` double DEFAULT NULL,
  `rem3` double DEFAULT NULL,
  `qte7` double DEFAULT NULL,
  `qte8` double DEFAULT NULL,
  `rem4` double DEFAULT NULL,
  `qte9` double DEFAULT NULL,
  `qte10` double DEFAULT NULL,
  `rem5` double DEFAULT NULL,
  `qte11` double DEFAULT NULL,
  `qte12` double DEFAULT NULL,
  `rem6` double DEFAULT NULL,
  `compt2_fam` char(8) DEFAULT NULL,
  `compt3_fam` char(8) DEFAULT NULL,
  `compt4_fam` char(8) DEFAULT NULL,
  `compt5_fam` char(8) DEFAULT NULL,
  `export` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`code_fam`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_FamDep` (
  `lind` int(11) NOT NULL AUTO_INCREMENT,
  `fam` char(20) DEFAULT NULL,
  `compte` char(8) DEFAULT NULL,
  `depot` char(8) DEFAULT NULL,
  PRIMARY KEY (`lind`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Four` (
  `fo_code` int(11) NOT NULL DEFAULT 0,
  `fo_col` varchar(1) DEFAULT NULL,
  `fo_rs_soc` varchar(12) DEFAULT NULL,
  `fo_nom` varchar(35) DEFAULT NULL,
  `fo_pnm` varchar(35) DEFAULT NULL,
  `fo_adr1` varchar(35) DEFAULT NULL,
  `fo_adr2` varchar(35) DEFAULT NULL,
  `fo_cd_ptl` varchar(5) DEFAULT NULL,
  `fo_ville` varchar(35) DEFAULT NULL,
  `fo_email` varchar(150) DEFAULT NULL,
  `fo_tel_std` varchar(16) DEFAULT NULL,
  `fo_tel_bur` varchar(16) DEFAULT NULL,
  `fo_tel_post` varchar(16) DEFAULT NULL,
  `fo_pble` varchar(16) DEFAULT NULL,
  `fo_fx1` varchar(16) DEFAULT NULL,
  `fo_fx2` varchar(16) DEFAULT NULL,
  `fo_plaf_ecrs` varchar(10) DEFAULT NULL,
  `fo_obs` mediumtext DEFAULT NULL,
  `fo_cd_bq` varchar(5) DEFAULT NULL,
  `fo_cd_gch` varchar(5) DEFAULT NULL,
  `fo_cle_rib` varchar(2) DEFAULT NULL,
  `fo_num_cpt` char(11) DEFAULT NULL,
  `fo_dom` varchar(25) DEFAULT NULL,
  `fo_id_tva` varchar(15) DEFAULT NULL,
  `fo_cd_soc` varchar(2) DEFAULT NULL,
  `fo_site` varchar(40) DEFAULT NULL,
  `fo_cd_cli` varchar(16) DEFAULT NULL,
  `fo_co_vtl` varchar(255) DEFAULT NULL,
  `fo_collectif` varchar(8) DEFAULT NULL,
  `fo_cdech` varchar(2) DEFAULT NULL,
  `fo_pays` char(40) DEFAULT NULL,
  `fo_franco` decimal(12,2) DEFAULT NULL,
  `fo_centrale` tinyint(1) DEFAULT NULL,
  `fo_cnt1` char(17) DEFAULT NULL,
  `fo_cnt2` char(40) DEFAULT NULL,
  `fo_cnt3` char(25) DEFAULT NULL,
  `fo_cnt4` char(17) DEFAULT NULL,
  `fo_cnt5` char(40) DEFAULT NULL,
  `fo_cnt6` char(25) DEFAULT NULL,
  `fo_cnt7` char(17) DEFAULT NULL,
  `fo_cnt8` char(40) DEFAULT NULL,
  `fo_cnt9` char(25) DEFAULT NULL,
  `fo_cnt10` char(17) DEFAULT NULL,
  `fo_cnt11` char(40) DEFAULT NULL,
  `fo_cnt12` char(25) DEFAULT NULL,
  `fo_cnt13` char(17) DEFAULT NULL,
  `fo_cnt14` char(40) DEFAULT NULL,
  `fo_cnt15` char(25) DEFAULT NULL,
  `fo_ccentrale` char(2) DEFAULT NULL,
  `fo_copie` tinyint(1) DEFAULT NULL,
  `fo_mincom` decimal(12,2) DEFAULT NULL,
  `fo_iban` char(30) DEFAULT NULL,
  `fo_bic` char(11) DEFAULT NULL,
  `fo_exo` tinyint(1) DEFAULT NULL,
  `fo_fport` decimal(12,2) DEFAULT NULL,
  `fo_cb` varchar(13) DEFAULT NULL,
  `libel_def` tinytext DEFAULT NULL,
  `tag_def` tinytext DEFAULT NULL,
  PRIMARY KEY (`fo_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Four_Vtl` (
  `code` varchar(8) NOT NULL,
  `code_vtl` varchar(8) NOT NULL,
  `intitule_vtl` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`code`,`code_vtl`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_HisEntTickets` (
  `lInd` int(11) NOT NULL AUTO_INCREMENT,
  `caisse` char(2) DEFAULT NULL,
  `numero` char(7) DEFAULT NULL,
  `client` varchar(30) DEFAULT NULL,
  `scheque` char(1) DEFAULT NULL,
  `mcheque` char(12) DEFAULT NULL,
  `nmcheque` varchar(30) DEFAULT NULL,
  `scarte` char(1) DEFAULT NULL,
  `nmcarte` varchar(30) DEFAULT NULL,
  `mcarte` char(12) DEFAULT NULL,
  `sespeces` char(1) DEFAULT NULL,
  `mespeces` char(12) DEFAULT NULL,
  `scredit` char(1) DEFAULT NULL,
  `mcredit` char(12) DEFAULT NULL,
  `nmcredit` varchar(30) DEFAULT NULL,
  `sbachat` char(1) DEFAULT NULL,
  `mbachat` char(12) DEFAULT NULL,
  `scavoir` char(1) DEFAULT NULL,
  `mavoir` char(12) DEFAULT NULL,
  `nmavoir` varchar(30) DEFAULT NULL,
  `mht` char(12) DEFAULT NULL,
  `mtva` char(12) DEFAULT NULL,
  `mttc` char(12) DEFAULT NULL,
  `savoir` char(1) DEFAULT NULL,
  `vendeur` varchar(35) DEFAULT NULL,
  `carte` char(13) DEFAULT NULL,
  `points` decimal(12,3) DEFAULT NULL,
  `sbonus` char(1) DEFAULT NULL,
  `mbonus` char(12) DEFAULT NULL,
  `sresto` char(1) DEFAULT NULL,
  `mresto` char(12) DEFAULT NULL,
  `nom` varchar(35) DEFAULT NULL,
  `suppr` tinyint(1) DEFAULT NULL,
  `control` varchar(40) DEFAULT NULL,
  `type` char(1) DEFAULT NULL,
  `retro` tinyint(1) DEFAULT NULL,
  `prev_numero` char(7) DEFAULT NULL,
  `sautre` char(1) DEFAULT NULL,
  `mautre` char(12) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  PRIMARY KEY (`lInd`),
  KEY `idx_numero` (`numero`),
  KEY `idx_date` (`date`,`client`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_HisInvT` (
  `inv_num` int(11) NOT NULL,
  `inv_code` char(15) NOT NULL,
  `inv_qtestock` decimal(12,2) DEFAULT NULL,
  `inv_qtecomptee` decimal(12,2) DEFAULT NULL,
  `inv_date` date DEFAULT NULL,
  PRIMARY KEY (`inv_num`,`inv_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_HisLigTickets` (
  `lInd` int(11) NOT NULL AUTO_INCREMENT,
  `numero` char(7) DEFAULT NULL,
  `numlig` char(6) DEFAULT NULL,
  `code` varchar(15) DEFAULT NULL,
  `intitule` varchar(50) DEFAULT NULL,
  `montant` char(12) DEFAULT NULL,
  `qte` char(12) DEFAULT NULL,
  `type` char(2) DEFAULT NULL,
  `fam` char(20) DEFAULT NULL,
  `mht` char(12) DEFAULT NULL,
  `mrem` char(12) DEFAULT NULL,
  `tva` varchar(12) DEFAULT NULL,
  `mtva` char(12) DEFAULT NULL,
  `block` char(6) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  PRIMARY KEY (`lInd`),
  KEY `idx_numero` (`numero`,`block`,`type`),
  KEY `idx_date` (`date`,`code`),
  KEY `idx_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_HisentMat` (
  `numserie` char(15) NOT NULL,
  `codep` varchar(15) NOT NULL,
  `marque` varchar(20) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  `design` varchar(50) DEFAULT NULL,
  `design2` varchar(50) DEFAULT NULL,
  `libelle` mediumtext DEFAULT NULL,
  `bloc` char(6) DEFAULT NULL,
  `numfac` char(10) NOT NULL,
  PRIMARY KEY (`numserie`,`codep`,`numfac`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_HistoFac` (
  `numfac` varchar(10) NOT NULL,
  `cdclifac` varchar(8) DEFAULT NULL,
  `cvclifac` varchar(12) DEFAULT NULL,
  `nmclifac` varchar(35) DEFAULT NULL,
  `pnmclifac` varchar(35) DEFAULT NULL,
  `adr1fac` varchar(35) DEFAULT NULL,
  `adr2fac` varchar(35) DEFAULT NULL,
  `cpfac` varchar(5) DEFAULT NULL,
  `villefac` varchar(35) DEFAULT NULL,
  `datefac` datetime DEFAULT NULL,
  `rmofac` varchar(6) DEFAULT NULL,
  `rartfac` varchar(5) DEFAULT NULL,
  `exofac` int(11) DEFAULT NULL,
  `remmofac` varchar(10) DEFAULT NULL,
  `remartfac` varchar(10) DEFAULT NULL,
  `totfac` decimal(12,2) DEFAULT NULL,
  `reg` varchar(15) DEFAULT NULL,
  `ech` datetime DEFAULT NULL,
  `numerobl` varchar(6) DEFAULT NULL,
  `acpt` varchar(12) DEFAULT NULL,
  `mreg` varchar(10) DEFAULT NULL,
  `marge_mo` decimal(12,2) DEFAULT NULL,
  `marge_art` decimal(12,2) DEFAULT NULL,
  `numserie` varchar(15) DEFAULT NULL,
  `codep` varchar(15) DEFAULT NULL,
  `mtreg` char(12) DEFAULT NULL,
  `totfacttc` decimal(12,2) DEFAULT NULL,
  `cdep` varchar(37) DEFAULT NULL,
  `acquitte` tinyint(1) DEFAULT NULL,
  `gestfac` decimal(5,2) DEFAULT 0.00,
  PRIMARY KEY (`numfac`),
  KEY `idx_cdcli` (`cdclifac`,`datefac`),
  KEY `idx_datefac` (`datefac`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_HistoFacM` (
  `numfac` varchar(10) NOT NULL,
  `cdclifac` varchar(8) DEFAULT NULL,
  `cvclifac` varchar(9) DEFAULT NULL,
  `nmclifac` varchar(35) DEFAULT NULL,
  `pnmclifac` varchar(35) DEFAULT NULL,
  `adr1fac` varchar(35) DEFAULT NULL,
  `adr2fac` varchar(35) DEFAULT NULL,
  `cpfac` varchar(5) DEFAULT NULL,
  `villefac` varchar(35) DEFAULT NULL,
  `datefac` datetime DEFAULT NULL,
  `rmofac` varchar(6) DEFAULT NULL,
  `rartfac` varchar(5) DEFAULT NULL,
  `exofac` int(11) DEFAULT NULL,
  `remmofac` varchar(10) DEFAULT NULL,
  `remartfac` varchar(10) DEFAULT NULL,
  `totfac` double DEFAULT NULL,
  `reg` varchar(15) DEFAULT NULL,
  `ech` datetime DEFAULT NULL,
  `numerobl` varchar(6) DEFAULT NULL,
  `acpt` varchar(12) DEFAULT NULL,
  `mreg` varchar(10) DEFAULT NULL,
  `marge_mo` decimal(12,2) DEFAULT NULL,
  `marge_art` decimal(12,2) DEFAULT NULL,
  `numserie` varchar(15) DEFAULT NULL,
  `codep` varchar(15) DEFAULT NULL,
  `mtreg` varchar(12) DEFAULT NULL,
  `totfacttc` decimal(12,2) DEFAULT NULL,
  `cdep` varchar(37) DEFAULT NULL,
  `acquitte` tinyint(1) DEFAULT NULL,
  `gestfac` decimal(5,2) DEFAULT 0.00,
  PRIMARY KEY (`numfac`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_HistoLigfac` (
  `num_ligfac` varchar(10) NOT NULL,
  `numlig_ligfac` varchar(6) NOT NULL,
  `code_ligfac` varchar(15) DEFAULT NULL,
  `libel_ligfac` varchar(50) DEFAULT NULL,
  `fam_ligfac` char(20) DEFAULT NULL,
  `pu_ligfac` varchar(10) DEFAULT NULL,
  `qte_ligfac` varchar(6) DEFAULT NULL,
  `brut_ligfac` varchar(10) DEFAULT NULL,
  `rem_ligfac` varchar(6) DEFAULT NULL,
  `netht_ligfac` varchar(10) DEFAULT NULL,
  `tx_ligfac` varchar(1) DEFAULT NULL,
  `nettc_ligfac` varchar(10) DEFAULT NULL,
  `typel_ligfac` char(2) DEFAULT NULL,
  `tm_ligfac` varchar(1) DEFAULT NULL,
  `com_ligfac` mediumtext DEFAULT NULL,
  `bloc` varchar(30) DEFAULT NULL,
  `mtx_ligfac` char(5) DEFAULT NULL,
  `mrgart_ligfac` decimal(12,3) DEFAULT NULL,
  `mrgmo_ligfac` decimal(12,3) DEFAULT NULL,
  `tour_ligfac` char(15) DEFAULT NULL,
  `dtligbl_ligfac` datetime DEFAULT NULL,
  `numbl_ligfac` char(6) DEFAULT NULL,
  PRIMARY KEY (`num_ligfac`,`numlig_ligfac`),
  KEY `idx_code` (`code_ligfac`,`typel_ligfac`),
  KEY `idx_dtligbl` (`dtligbl_ligfac`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_HistoLigfacM` (
  `num_ligfac` char(10) NOT NULL,
  `numlig_ligfac` char(6) NOT NULL,
  `code_ligfac` varchar(15) DEFAULT NULL,
  `libel_ligfac` varchar(50) DEFAULT NULL,
  `fam_ligfac` char(20) DEFAULT NULL,
  `pu_ligfac` char(12) DEFAULT NULL,
  `qte_ligfac` char(6) DEFAULT NULL,
  `brut_ligfac` char(12) DEFAULT NULL,
  `rem_ligfac` char(6) DEFAULT NULL,
  `netht_ligfac` char(12) DEFAULT NULL,
  `tx_ligfac` char(1) DEFAULT NULL,
  `nettc_ligfac` char(12) DEFAULT NULL,
  `typel_ligfac` char(2) DEFAULT NULL,
  `tm_ligfac` char(1) DEFAULT NULL,
  `com_ligfac` mediumtext DEFAULT NULL,
  `bloc` varchar(30) DEFAULT NULL,
  `mtx_ligfac` char(5) DEFAULT NULL,
  `mrgart_ligfac` decimal(12,3) DEFAULT NULL,
  `mrgmo_ligfac` decimal(12,3) DEFAULT NULL,
  `tour_ligfac` char(15) DEFAULT NULL,
  `dtligbl_ligfac` datetime DEFAULT NULL,
  `numbl_ligfac` char(6) DEFAULT NULL,
  PRIMARY KEY (`num_ligfac`,`numlig_ligfac`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Identite` (
  `code` char(2) NOT NULL,
  `libelle` char(9) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_ImpArtDef` (
  `num` int(11) NOT NULL,
  `nom` varchar(50) DEFAULT NULL,
  `cfour` char(8) DEFAULT NULL,
  `nfour` varchar(50) DEFAULT NULL,
  `cfam` char(20) DEFAULT NULL,
  `nfam` varchar(50) DEFAULT NULL,
  `adrfic` varchar(100) DEFAULT NULL,
  `typesep` char(1) DEFAULT NULL,
  `sep` char(1) DEFAULT NULL,
  PRIMARY KEY (`num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_ImpArtDef2` (
  `num` int(11) NOT NULL,
  `posorg_1` char(4) DEFAULT NULL,
  `col_1` varchar(50) DEFAULT NULL,
  `db_1` int(11) DEFAULT NULL,
  `lg_1` int(11) DEFAULT NULL,
  `pos_1` int(11) DEFAULT NULL,
  `posorg_2` char(4) DEFAULT NULL,
  `col_2` varchar(50) DEFAULT NULL,
  `db_2` int(11) DEFAULT NULL,
  `lg_2` int(11) DEFAULT NULL,
  `pos_2` int(11) DEFAULT NULL,
  `posorg_3` char(4) DEFAULT NULL,
  `col_3` varchar(50) DEFAULT NULL,
  `db_3` int(11) DEFAULT NULL,
  `lg_3` int(11) DEFAULT NULL,
  `pos_3` int(11) DEFAULT NULL,
  `posorg_4` char(4) DEFAULT NULL,
  `col_4` varchar(50) DEFAULT NULL,
  `db_4` int(11) DEFAULT NULL,
  `lg_4` int(11) DEFAULT NULL,
  `pos_4` int(11) DEFAULT NULL,
  `posorg_5` char(4) DEFAULT NULL,
  `col_5` varchar(50) DEFAULT NULL,
  `db_5` int(11) DEFAULT NULL,
  `lg_5` int(11) DEFAULT NULL,
  `pos_5` int(11) DEFAULT NULL,
  `posorg_6` char(4) DEFAULT NULL,
  `col_6` varchar(50) DEFAULT NULL,
  `db_6` int(11) DEFAULT NULL,
  `lg_6` int(11) DEFAULT NULL,
  `pos_6` int(11) DEFAULT NULL,
  `posorg_7` char(4) DEFAULT NULL,
  `col_7` varchar(50) DEFAULT NULL,
  `db_7` int(11) DEFAULT NULL,
  `lg_7` int(11) DEFAULT NULL,
  `pos_7` int(11) DEFAULT NULL,
  `posorg_8` char(4) DEFAULT NULL,
  `col_8` varchar(50) DEFAULT NULL,
  `db_8` int(11) DEFAULT NULL,
  `lg_8` int(11) DEFAULT NULL,
  `pos_8` int(11) DEFAULT NULL,
  `posorg_9` char(4) DEFAULT NULL,
  `col_9` varchar(50) DEFAULT NULL,
  `db_9` int(11) DEFAULT NULL,
  `lg_9` int(11) DEFAULT NULL,
  `pos_9` int(11) DEFAULT NULL,
  `posorg_10` char(4) DEFAULT NULL,
  `col_10` varchar(50) DEFAULT NULL,
  `db_10` int(11) DEFAULT NULL,
  `lg_10` int(11) DEFAULT NULL,
  `pos_10` int(11) DEFAULT NULL,
  `posorg_11` char(4) DEFAULT NULL,
  `col_11` varchar(50) DEFAULT NULL,
  `db_11` int(11) DEFAULT NULL,
  `lg_11` int(11) DEFAULT NULL,
  `pos_11` int(11) DEFAULT NULL,
  `posorg_12` char(4) DEFAULT NULL,
  `col_12` varchar(50) DEFAULT NULL,
  `db_12` int(11) DEFAULT NULL,
  `lg_12` int(11) DEFAULT NULL,
  `pos_12` int(11) DEFAULT NULL,
  `posorg_13` char(4) DEFAULT NULL,
  `col_13` varchar(50) DEFAULT NULL,
  `db_13` int(11) DEFAULT NULL,
  `lg_13` int(11) DEFAULT NULL,
  `pos_13` int(11) DEFAULT NULL,
  `posorg_14` char(4) DEFAULT NULL,
  `col_14` varchar(50) DEFAULT NULL,
  `db_14` int(11) DEFAULT NULL,
  `lg_14` int(11) DEFAULT NULL,
  `pos_14` int(11) DEFAULT NULL,
  `posorg_15` char(4) DEFAULT NULL,
  `col_15` varchar(50) DEFAULT NULL,
  `db_15` int(11) DEFAULT NULL,
  `lg_15` int(11) DEFAULT NULL,
  `pos_15` int(11) DEFAULT NULL,
  `posorg_16` char(4) DEFAULT NULL,
  `col_16` varchar(50) DEFAULT NULL,
  `db_16` int(11) DEFAULT NULL,
  `lg_16` int(11) DEFAULT NULL,
  `pos_16` int(11) DEFAULT NULL,
  `posorg_17` char(4) DEFAULT NULL,
  `col_17` varchar(50) DEFAULT NULL,
  `db_17` int(11) DEFAULT NULL,
  `lg_17` int(11) DEFAULT NULL,
  `pos_17` int(11) DEFAULT NULL,
  `posorg_18` char(4) DEFAULT NULL,
  `col_18` varchar(50) DEFAULT NULL,
  `db_18` int(11) DEFAULT NULL,
  `lg_18` int(11) DEFAULT NULL,
  `pos_18` int(11) DEFAULT NULL,
  `posorg_19` char(4) DEFAULT NULL,
  `col_19` varchar(50) DEFAULT NULL,
  `db_19` int(11) DEFAULT NULL,
  `lg_19` int(11) DEFAULT NULL,
  `pos_19` int(11) DEFAULT NULL,
  `posorg_20` char(4) DEFAULT NULL,
  `col_20` varchar(50) DEFAULT NULL,
  `db_20` int(11) DEFAULT NULL,
  `lg_20` int(11) DEFAULT NULL,
  `pos_20` int(11) DEFAULT NULL,
  `posorg_21` char(4) DEFAULT NULL,
  `col_21` varchar(50) DEFAULT NULL,
  `db_21` int(11) DEFAULT NULL,
  `lg_21` int(11) DEFAULT NULL,
  `pos_21` int(11) DEFAULT NULL,
  `posorg_22` char(4) DEFAULT NULL,
  `col_22` varchar(50) DEFAULT NULL,
  `db_22` int(11) DEFAULT NULL,
  `lg_22` int(11) DEFAULT NULL,
  `pos_22` int(11) DEFAULT NULL,
  `posorg_23` char(4) DEFAULT NULL,
  `col_23` varchar(50) DEFAULT NULL,
  `db_23` int(11) DEFAULT NULL,
  `lg_23` int(11) DEFAULT NULL,
  `pos_23` int(11) DEFAULT NULL,
  `posorg_24` char(4) DEFAULT NULL,
  `col_24` varchar(50) DEFAULT NULL,
  `db_24` int(11) DEFAULT NULL,
  `lg_24` int(11) DEFAULT NULL,
  `pos_24` int(11) DEFAULT NULL,
  `posorg_25` char(4) DEFAULT NULL,
  `col_25` varchar(50) DEFAULT NULL,
  `db_25` int(11) DEFAULT NULL,
  `lg_25` int(11) DEFAULT NULL,
  `pos_25` int(11) DEFAULT NULL,
  `posorg_26` char(4) DEFAULT NULL,
  `col_26` varchar(50) DEFAULT NULL,
  `db_26` int(11) DEFAULT NULL,
  `lg_26` int(11) DEFAULT NULL,
  `pos_26` int(11) DEFAULT NULL,
  `posorg_27` char(4) DEFAULT NULL,
  `col_27` varchar(50) DEFAULT NULL,
  `db_27` int(11) DEFAULT NULL,
  `lg_27` int(11) DEFAULT NULL,
  `pos_27` int(11) DEFAULT NULL,
  `posorg_28` char(4) DEFAULT NULL,
  `col_28` varchar(50) DEFAULT NULL,
  `db_28` int(11) DEFAULT NULL,
  `lg_28` int(11) DEFAULT NULL,
  `pos_28` int(11) DEFAULT NULL,
  `posorg_29` char(4) DEFAULT NULL,
  `col_29` varchar(50) DEFAULT NULL,
  `db_29` int(11) DEFAULT NULL,
  `lg_29` int(11) DEFAULT NULL,
  `pos_29` int(11) DEFAULT NULL,
  `posorg_30` char(4) DEFAULT NULL,
  `col_30` varchar(50) DEFAULT NULL,
  `db_30` int(11) DEFAULT NULL,
  `lg_30` int(11) DEFAULT NULL,
  `pos_30` int(11) DEFAULT NULL,
  `posorg_31` char(4) DEFAULT NULL,
  `col_31` varchar(50) DEFAULT NULL,
  `db_31` int(11) DEFAULT NULL,
  `lg_31` int(11) DEFAULT NULL,
  `pos_31` int(11) DEFAULT NULL,
  `posorg_32` char(4) DEFAULT NULL,
  `col_32` varchar(50) DEFAULT NULL,
  `db_32` int(11) DEFAULT NULL,
  `lg_32` int(11) DEFAULT NULL,
  `pos_32` int(11) DEFAULT NULL,
  PRIMARY KEY (`num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Journaux` (
  `code_jo` varchar(2) NOT NULL,
  `libelle_jo` varchar(30) DEFAULT NULL,
  `type_jo` varchar(2) DEFAULT NULL,
  `cde_banque` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`code_jo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Lcr` (
  `lind` int(11) NOT NULL AUTO_INCREMENT,
  `code` char(8) DEFAULT NULL,
  `nom` varchar(35) DEFAULT NULL,
  `montant` char(12) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `datech` date DEFAULT NULL,
  `numfac` char(12) DEFAULT NULL,
  `acceptee` int(11) DEFAULT NULL,
  `ecartee` int(11) DEFAULT NULL,
  `banque` varchar(35) DEFAULT NULL,
  `codeentree` int(1) DEFAULT NULL,
  `bordereau` varchar(35) DEFAULT NULL,
  PRIMARY KEY (`lind`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_LibelAvoirs` (
  `lInd` tinyint(4) NOT NULL AUTO_INCREMENT,
  `libelav` char(250) DEFAULT NULL,
  PRIMARY KEY (`lInd`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_LibelFac` (
  `mind` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `txtfac` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`mind`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_LibelTicket` (
  `lInd` tinyint(4) NOT NULL AUTO_INCREMENT,
  `libeltk` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`lInd`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Libelles` (
  `num` varchar(2) NOT NULL,
  `intitule` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_LigTicketz` (
  `lInd` int(11) NOT NULL AUTO_INCREMENT,
  `numero` char(7) DEFAULT NULL,
  `numlig` char(6) DEFAULT NULL,
  `code` varchar(15) DEFAULT NULL,
  `intitule` varchar(50) DEFAULT NULL,
  `montant` char(12) DEFAULT NULL,
  `qte` char(12) DEFAULT NULL,
  `type` char(2) DEFAULT NULL,
  `fam` char(20) DEFAULT NULL,
  `mht` char(12) DEFAULT NULL,
  `mrem` char(12) DEFAULT NULL,
  `mtva` char(12) DEFAULT NULL,
  `block` char(6) DEFAULT NULL,
  `tva` varchar(12) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  PRIMARY KEY (`lInd`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Ligabon` (
  `numero` varchar(15) DEFAULT NULL,
  `compte` varchar(10) DEFAULT NULL,
  `intitule` varchar(40) DEFAULT NULL,
  `debit` tinytext DEFAULT NULL,
  `credit` tinytext DEFAULT NULL,
  `lig` int(11) DEFAULT NULL,
  `lind` int(11) NOT NULL AUTO_INCREMENT,
  `libelle` tinytext DEFAULT NULL,
  `numDoc` tinytext DEFAULT NULL,
  `numLot` tinytext DEFAULT NULL,
  PRIMARY KEY (`lind`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Ligbl` (
  `num_ligbl` varchar(6) NOT NULL,
  `numlig_ligbl` varchar(6) NOT NULL,
  `code_ligbl` varchar(15) DEFAULT NULL,
  `libel_ligbl` varchar(50) DEFAULT NULL,
  `fam_ligbl` char(20) DEFAULT NULL,
  `pu_ligbl` varchar(12) DEFAULT NULL,
  `dec_ligbl` varchar(1) DEFAULT NULL,
  `qte_ligbl` varchar(12) DEFAULT NULL,
  `brut_ligbl` varchar(12) DEFAULT NULL,
  `rem_ligbl` varchar(6) DEFAULT NULL,
  `netht_ligbl` varchar(12) DEFAULT NULL,
  `tx_ligbl` char(2) DEFAULT NULL,
  `nettc_ligbl` varchar(12) DEFAULT NULL,
  `typel_ligbl` char(2) DEFAULT NULL,
  `tm_ligbl` varchar(1) DEFAULT NULL,
  `com_ligbl` mediumtext DEFAULT NULL,
  `block_ligbl` varchar(30) DEFAULT NULL,
  `pdstotal_ligbl` decimal(12,3) DEFAULT NULL,
  `mrgart_ligbl` decimal(12,3) DEFAULT NULL,
  `mrgmo_ligbl` decimal(12,3) DEFAULT NULL,
  `mtx_ligfac` char(5) DEFAULT NULL,
  `four_ligbl` varchar(8) DEFAULT NULL,
  `refl_ligbl` varchar(40) DEFAULT NULL,
  `tour_ligbl` char(15) DEFAULT NULL,
  `dte_ligbl` datetime DEFAULT NULL,
  PRIMARY KEY (`num_ligbl`,`numlig_ligbl`),
  KEY `idx_code` (`code_ligbl`,`typel_ligbl`),
  KEY `idx_dte` (`dte_ligbl`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_LigblM` (
  `num_ligbl` varchar(6) NOT NULL,
  `numlig_ligbl` varchar(6) NOT NULL,
  `code_ligbl` varchar(15) DEFAULT NULL,
  `libel_ligbl` varchar(50) DEFAULT NULL,
  `fam_ligbl` char(20) DEFAULT NULL,
  `pu_ligbl` varchar(12) DEFAULT NULL,
  `dec_ligbl` varchar(1) DEFAULT NULL,
  `qte_ligbl` varchar(12) DEFAULT NULL,
  `brut_ligbl` varchar(12) DEFAULT NULL,
  `rem_ligbl` varchar(6) DEFAULT NULL,
  `netht_ligbl` varchar(12) DEFAULT NULL,
  `tx_ligbl` char(2) DEFAULT NULL,
  `nettc_ligbl` varchar(12) DEFAULT NULL,
  `typel_ligbl` char(2) DEFAULT NULL,
  `tm_ligbl` varchar(1) DEFAULT NULL,
  `com_ligbl` mediumtext DEFAULT NULL,
  `block_ligbl` varchar(30) DEFAULT NULL,
  `pdstotal_ligbl` decimal(12,3) DEFAULT NULL,
  `mrgart_ligbl` decimal(12,3) DEFAULT NULL,
  `mrgmo_ligbl` decimal(12,3) DEFAULT NULL,
  `mtx_ligfac` char(5) DEFAULT NULL,
  `four_ligbl` varchar(8) DEFAULT NULL,
  `refl_ligbl` varchar(40) DEFAULT NULL,
  `tour_ligbl` char(15) DEFAULT NULL,
  `dte_ligbl` datetime DEFAULT NULL,
  PRIMARY KEY (`num_ligbl`,`numlig_ligbl`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Ligcom` (
  `code` varchar(25) DEFAULT NULL,
  `design` varchar(50) DEFAULT NULL,
  `numcom` varchar(15) DEFAULT NULL,
  `four` varchar(8) DEFAULT NULL,
  `qte` decimal(9,3) DEFAULT NULL,
  `pbht` decimal(12,3) DEFAULT NULL,
  `rm` decimal(6,2) DEFAULT NULL,
  `paht` decimal(12,3) DEFAULT NULL,
  `datecom` datetime DEFAULT NULL,
  `lind` int(11) NOT NULL AUTO_INCREMENT,
  `frais` decimal(12,3) DEFAULT NULL,
  `prvt` decimal(12,3) DEFAULT NULL,
  `nligne` char(4) DEFAULT NULL,
  `coda` char(15) DEFAULT NULL,
  `pattc` decimal(12,3) DEFAULT NULL,
  `txconv` decimal(10,4) DEFAULT 1.0000,
  `majtarif` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`lind`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Ligrecpt` (
  `code` varchar(25) NOT NULL,
  `design` varchar(50) DEFAULT NULL,
  `numrecpt` varchar(15) NOT NULL,
  `four` varchar(8) NOT NULL,
  `daterecpt` datetime NOT NULL,
  `qte` decimal(9,3) DEFAULT NULL,
  `pbht` decimal(12,3) DEFAULT NULL,
  `rm` decimal(6,2) DEFAULT NULL,
  `paht` decimal(12,3) DEFAULT NULL,
  `frais` decimal(12,3) DEFAULT NULL,
  `prvt` decimal(12,3) DEFAULT NULL,
  `nligne` varchar(4) NOT NULL,
  `pattc` decimal(12,3) DEFAULT NULL,
  `txconv` decimal(10,4) DEFAULT 1.0000,
  `majtarif` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`code`,`numrecpt`,`four`,`daterecpt`,`nligne`),
  KEY `idx_numrecpt` (`numrecpt`,`four`,`daterecpt`,`nligne`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Marques` (
  `lind` int(11) NOT NULL AUTO_INCREMENT,
  `code` char(5) DEFAULT NULL,
  `intitule` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`lind`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Materiels` (
  `mat_serie` char(30) NOT NULL,
  `mat_code` char(15) NOT NULL,
  `mat_design` char(50) DEFAULT NULL,
  `mat_design2` char(50) DEFAULT NULL,
  `mat_fam` char(20) DEFAULT NULL,
  `mat_four` char(8) DEFAULT NULL,
  `mat_cequ` char(15) DEFAULT NULL,
  `mat_cbarre` char(15) DEFAULT NULL,
  `mat_cfour` char(25) DEFAULT NULL,
  `mat_paht` decimal(12,3) DEFAULT NULL,
  `mat_frais` decimal(7,3) DEFAULT NULL,
  `mat_prvt` decimal(7,3) DEFAULT NULL,
  `mat_coef` decimal(7,4) DEFAULT NULL,
  `mat_pvht` decimal(12,3) DEFAULT NULL,
  `mat_tva` decimal(10,3) DEFAULT NULL,
  `mat_pvttc` decimal(12,3) DEFAULT NULL,
  `mat_cdarr` char(4) DEFAULT NULL,
  `mat_pvar` decimal(12,3) DEFAULT NULL,
  `mat_dec` char(1) DEFAULT NULL,
  `mat_nbd` char(1) DEFAULT NULL,
  `mat_qte` char(1) DEFAULT NULL,
  `mat_dpa` decimal(10,2) DEFAULT NULL,
  `mat_dfour` char(8) DEFAULT NULL,
  `mat_pmp` decimal(10,2) DEFAULT NULL,
  `mat_com` decimal(12,3) DEFAULT NULL,
  `mat_ect` tinyint(1) DEFAULT NULL,
  `mat_eco` decimal(5,2) DEFAULT NULL,
  `mat_poids` decimal(11,3) DEFAULT NULL,
  `mat_poids2` decimal(11,3) DEFAULT NULL,
  `mat_photo` char(20) DEFAULT NULL,
  `mat_crst` mediumtext DEFAULT NULL,
  `mat_vendu` tinyint(1) DEFAULT NULL,
  `mat_rcpt` char(15) DEFAULT NULL,
  `mat_bl` char(15) DEFAULT NULL,
  `mat_marque` char(20) DEFAULT NULL,
  `mat_type` char(20) DEFAULT NULL,
  `mat_cli` char(8) DEFAULT NULL,
  `mat_matdiv` int(1) DEFAULT NULL,
  `mat_dtevte` date DEFAULT NULL,
  `mat_dateg1` date DEFAULT NULL,
  `mat_chkgarantie` tinyint(1) DEFAULT NULL,
  `mat_ddate` datetime DEFAULT NULL,
  PRIMARY KEY (`mat_serie`,`mat_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Mats` (
  `mat_serie` char(30) NOT NULL,
  `mat_code` char(15) NOT NULL,
  `mat_design` char(50) DEFAULT NULL,
  `mat_design2` char(50) DEFAULT NULL,
  `mat_fam` char(20) DEFAULT NULL,
  `mat_four` char(8) DEFAULT NULL,
  `mat_cequ` char(15) DEFAULT NULL,
  `mat_cbarre` char(15) DEFAULT NULL,
  `mat_cfour` char(25) DEFAULT NULL,
  `mat_paht` decimal(12,3) DEFAULT NULL,
  `mat_frais` decimal(7,3) DEFAULT NULL,
  `mat_prvt` decimal(7,3) DEFAULT NULL,
  `mat_coef` decimal(6,3) DEFAULT NULL,
  `mat_pvht` decimal(12,3) DEFAULT NULL,
  `mat_tva` decimal(10,3) DEFAULT NULL,
  `mat_pvttc` decimal(12,3) DEFAULT NULL,
  `mat_cdarr` char(4) DEFAULT NULL,
  `mat_pvar` decimal(12,3) DEFAULT NULL,
  `mat_dec` char(1) DEFAULT NULL,
  `mat_nbd` char(1) DEFAULT NULL,
  `mat_qte` char(1) DEFAULT NULL,
  `mat_dpa` decimal(10,2) DEFAULT NULL,
  `mat_dfour` char(8) DEFAULT NULL,
  `mat_pmp` decimal(10,2) DEFAULT NULL,
  `mat_ddate` char(10) DEFAULT NULL,
  `mat_com` decimal(12,3) DEFAULT NULL,
  `mat_ect` tinyint(1) DEFAULT NULL,
  `mat_eco` decimal(5,2) DEFAULT NULL,
  `mat_poids` decimal(11,3) DEFAULT NULL,
  `mat_poids2` decimal(11,3) DEFAULT NULL,
  `mat_photo` char(20) DEFAULT NULL,
  `mat_crst` mediumtext DEFAULT NULL,
  `mat_rcpt` char(15) DEFAULT NULL,
  PRIMARY KEY (`mat_serie`,`mat_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Mo` (
  `mo_code` varchar(15) NOT NULL,
  `mo_design` varchar(50) DEFAULT NULL,
  `mo_fam` char(20) DEFAULT NULL,
  `mo_four` int(11) DEFAULT NULL,
  `mo_txcd` varchar(2) DEFAULT NULL,
  `mo_txht` double DEFAULT NULL,
  `mo_tva` char(2) DEFAULT NULL,
  `mo_tempmont` varchar(1) DEFAULT NULL,
  `mo_montant` double DEFAULT NULL,
  `mo_valeurht` double DEFAULT NULL,
  `mo_cdarr` varchar(4) DEFAULT NULL,
  `mo_valeurttc` double DEFAULT NULL,
  `mo_prvt` decimal(12,3) DEFAULT NULL,
  `mo_marge` decimal(12,3) DEFAULT NULL,
  `mo_impcar` tinyint(1) DEFAULT NULL,
  `mo_crst` mediumtext DEFAULT NULL,
  PRIMARY KEY (`mo_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Mvt` (
  `jour` varchar(2) DEFAULT NULL,
  `numero` int(11) NOT NULL,
  `numerodef` int(11) DEFAULT NULL,
  `compte` varchar(8) NOT NULL,
  `collectif` tinyint(1) DEFAULT NULL,
  `intitule` varchar(40) DEFAULT NULL,
  `dte` datetime NOT NULL,
  `datee` datetime DEFAULT NULL,
  `dateech` datetime DEFAULT NULL,
  `numcol` varchar(3) DEFAULT NULL,
  `numdoc` char(10) DEFAULT NULL,
  `numlot` char(10) DEFAULT NULL,
  `libelle` varchar(50) DEFAULT NULL,
  `montantd` decimal(12,2) DEFAULT NULL,
  `montantc` decimal(12,2) DEFAULT NULL,
  `validee` tinyint(1) DEFAULT NULL,
  `provisoire` tinyint(1) DEFAULT NULL,
  `tresorerie` tinyint(1) DEFAULT NULL,
  `pointee` tinyint(1) DEFAULT NULL,
  `nrlv` int(11) DEFAULT NULL,
  `lettree` tinyint(1) DEFAULT NULL,
  `cloturee` tinyint(1) DEFAULT NULL,
  `relance` int(11) DEFAULT NULL,
  `lind` int(11) NOT NULL AUTO_INCREMENT,
  `dteval` datetime DEFAULT NULL,
  `export` char(1) DEFAULT NULL,
  `control` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`lind`),
  KEY `idx_jour` (`jour`,`dte`),
  KEY `idx_numero` (`numero`,`compte`),
  KEY `idx_compte` (`compte`,`dte`),
  KEY `idx_numlot` (`numlot`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Mvt1` (
  `jour` varchar(2) DEFAULT NULL,
  `numero` int(11) NOT NULL,
  `compte` varchar(8) NOT NULL,
  `collectif` tinyint(1) DEFAULT NULL,
  `intitule` varchar(40) DEFAULT NULL,
  `dte` datetime NOT NULL,
  `datee` datetime DEFAULT NULL,
  `numdoc` char(10) DEFAULT NULL,
  `numlot` char(10) DEFAULT NULL,
  `libelle` varchar(50) DEFAULT NULL,
  `montantd` decimal(12,2) DEFAULT NULL,
  `montantc` decimal(12,2) DEFAULT NULL,
  `validee` tinyint(1) DEFAULT NULL,
  `provisoire` tinyint(1) DEFAULT NULL,
  `tresorerie` tinyint(1) DEFAULT NULL,
  `pointee` tinyint(1) DEFAULT NULL,
  `nrlv` int(11) DEFAULT NULL,
  `lettree` tinyint(1) DEFAULT NULL,
  `cloturee` tinyint(1) DEFAULT NULL,
  `relance` int(11) DEFAULT NULL,
  `control` varchar(40) DEFAULT NULL,
  `numerodef` int(11) DEFAULT NULL,
  `dateech` datetime DEFAULT NULL,
  `numcol` varchar(3) DEFAULT NULL,
  `dteval` datetime DEFAULT NULL,
  `export` char(1) DEFAULT NULL,
  `lind` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`lind`),
  KEY `idx_jour` (`jour`,`dte`),
  KEY `idx_numero` (`numero`,`compte`),
  KEY `idx_compte` (`compte`,`dte`),
  KEY `idx_numlot` (`numlot`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Mvt2` (
  `jour` varchar(2) DEFAULT NULL,
  `numero` int(11) NOT NULL,
  `compte` varchar(8) NOT NULL,
  `collectif` tinyint(1) DEFAULT NULL,
  `intitule` varchar(40) DEFAULT NULL,
  `dte` datetime NOT NULL,
  `datee` datetime DEFAULT NULL,
  `numdoc` char(10) DEFAULT NULL,
  `numlot` char(10) DEFAULT NULL,
  `libelle` varchar(50) DEFAULT NULL,
  `montantd` decimal(12,2) DEFAULT NULL,
  `montantc` decimal(12,2) DEFAULT NULL,
  `validee` tinyint(1) DEFAULT NULL,
  `provisoire` tinyint(1) DEFAULT NULL,
  `tresorerie` tinyint(1) DEFAULT NULL,
  `pointee` tinyint(1) DEFAULT NULL,
  `nrlv` int(11) DEFAULT NULL,
  `lettree` tinyint(1) DEFAULT NULL,
  `cloturee` tinyint(1) DEFAULT NULL,
  `relance` int(11) DEFAULT NULL,
  `control` varchar(40) DEFAULT NULL,
  `numerodef` int(11) DEFAULT NULL,
  `dateech` datetime DEFAULT NULL,
  `numcol` varchar(3) DEFAULT NULL,
  `dteval` datetime DEFAULT NULL,
  `export` char(1) DEFAULT NULL,
  `lind` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`lind`),
  KEY `idx_jour` (`jour`,`dte`),
  KEY `idx_numero` (`numero`,`compte`),
  KEY `idx_compte` (`compte`,`dte`),
  KEY `idx_numlot` (`numlot`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Mvt3` (
  `jour` varchar(2) DEFAULT NULL,
  `numero` int(11) NOT NULL,
  `compte` varchar(8) NOT NULL,
  `collectif` tinyint(1) DEFAULT NULL,
  `intitule` varchar(40) DEFAULT NULL,
  `dte` datetime NOT NULL,
  `datee` datetime DEFAULT NULL,
  `numdoc` char(10) DEFAULT NULL,
  `numlot` char(10) DEFAULT NULL,
  `libelle` varchar(50) DEFAULT NULL,
  `montantd` decimal(12,2) DEFAULT NULL,
  `montantc` decimal(12,2) DEFAULT NULL,
  `validee` tinyint(1) DEFAULT NULL,
  `provisoire` tinyint(1) DEFAULT NULL,
  `tresorerie` tinyint(1) DEFAULT NULL,
  `pointee` tinyint(1) DEFAULT NULL,
  `nrlv` int(11) DEFAULT NULL,
  `lettree` tinyint(1) DEFAULT NULL,
  `cloturee` tinyint(1) DEFAULT NULL,
  `relance` int(11) DEFAULT NULL,
  `control` varchar(40) DEFAULT NULL,
  `numerodef` int(11) DEFAULT NULL,
  `dateech` datetime DEFAULT NULL,
  `numcol` varchar(3) DEFAULT NULL,
  `dteval` datetime DEFAULT NULL,
  `export` char(1) DEFAULT NULL,
  `lind` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`lind`),
  KEY `idx_jour` (`jour`,`dte`),
  KEY `idx_numero` (`numero`,`compte`),
  KEY `idx_compte` (`compte`,`dte`),
  KEY `idx_numlot` (`numlot`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Mvt4` (
  `jour` varchar(2) DEFAULT NULL,
  `numero` int(11) NOT NULL,
  `compte` varchar(8) NOT NULL,
  `collectif` tinyint(1) DEFAULT NULL,
  `intitule` varchar(40) DEFAULT NULL,
  `dte` datetime NOT NULL,
  `datee` datetime DEFAULT NULL,
  `numdoc` char(10) DEFAULT NULL,
  `numlot` char(10) DEFAULT NULL,
  `libelle` varchar(50) DEFAULT NULL,
  `montantd` decimal(12,2) DEFAULT NULL,
  `montantc` decimal(12,2) DEFAULT NULL,
  `validee` tinyint(1) DEFAULT NULL,
  `provisoire` tinyint(1) DEFAULT NULL,
  `tresorerie` tinyint(1) DEFAULT NULL,
  `pointee` tinyint(1) DEFAULT NULL,
  `nrlv` int(11) DEFAULT NULL,
  `lettree` tinyint(1) DEFAULT NULL,
  `cloturee` tinyint(1) DEFAULT NULL,
  `relance` int(11) DEFAULT NULL,
  `control` varchar(40) DEFAULT NULL,
  `numerodef` int(11) DEFAULT NULL,
  `dateech` datetime DEFAULT NULL,
  `numcol` varchar(3) DEFAULT NULL,
  `dteval` datetime DEFAULT NULL,
  `export` char(1) DEFAULT NULL,
  `lind` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`lind`),
  KEY `idx_jour` (`jour`,`dte`),
  KEY `idx_numero` (`numero`,`compte`),
  KEY `idx_compte` (`compte`,`dte`),
  KEY `idx_numlot` (`numlot`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Mvt5` (
  `jour` varchar(2) DEFAULT NULL,
  `numero` int(11) NOT NULL,
  `compte` varchar(8) NOT NULL,
  `collectif` tinyint(1) DEFAULT NULL,
  `intitule` varchar(40) DEFAULT NULL,
  `dte` datetime NOT NULL,
  `datee` datetime DEFAULT NULL,
  `numdoc` char(10) DEFAULT NULL,
  `numlot` char(10) DEFAULT NULL,
  `libelle` varchar(50) DEFAULT NULL,
  `montantd` decimal(12,2) DEFAULT NULL,
  `montantc` decimal(12,2) DEFAULT NULL,
  `validee` tinyint(1) DEFAULT NULL,
  `provisoire` tinyint(1) DEFAULT NULL,
  `tresorerie` tinyint(1) DEFAULT NULL,
  `pointee` tinyint(1) DEFAULT NULL,
  `nrlv` int(11) DEFAULT NULL,
  `lettree` tinyint(1) DEFAULT NULL,
  `cloturee` tinyint(1) DEFAULT NULL,
  `relance` int(11) DEFAULT NULL,
  `control` varchar(40) DEFAULT NULL,
  `numerodef` int(11) DEFAULT NULL,
  `dateech` datetime DEFAULT NULL,
  `numcol` varchar(3) DEFAULT NULL,
  `dteval` datetime DEFAULT NULL,
  `export` char(1) DEFAULT NULL,
  `lind` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`lind`),
  KEY `idx_jour` (`jour`,`dte`),
  KEY `idx_numero` (`numero`,`compte`),
  KEY `idx_compte` (`compte`,`dte`),
  KEY `idx_numlot` (`numlot`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_MvtA` (
  `numero` int(11) NOT NULL,
  `compte` varchar(8) NOT NULL,
  `intitule` varchar(40) DEFAULT NULL,
  `dte` datetime NOT NULL,
  `numdoc` char(10) DEFAULT NULL,
  `libelle` varchar(50) DEFAULT NULL,
  `pourcent` char(5) DEFAULT NULL,
  `montantd` decimal(12,2) DEFAULT NULL,
  `montantc` decimal(12,2) DEFAULT NULL,
  `jour` varchar(2) DEFAULT NULL,
  `poste` char(3) DEFAULT NULL,
  `validee` tinyint(1) DEFAULT NULL,
  `lind` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`lind`),
  KEY `idx_numero` (`numero`,`compte`),
  KEY `idx_compte` (`compte`,`dte`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_MvtA1` (
  `numero` int(11) NOT NULL,
  `compte` varchar(8) NOT NULL,
  `intitule` varchar(40) DEFAULT NULL,
  `dte` datetime NOT NULL,
  `numdoc` char(10) DEFAULT NULL,
  `libelle` varchar(50) DEFAULT NULL,
  `pourcent` char(5) DEFAULT NULL,
  `montantd` decimal(12,2) DEFAULT NULL,
  `montantc` decimal(12,2) DEFAULT NULL,
  `jour` varchar(2) DEFAULT NULL,
  `poste` char(3) DEFAULT NULL,
  `validee` tinyint(1) DEFAULT NULL,
  `lind` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`lind`),
  KEY `idx_numero` (`numero`,`compte`),
  KEY `idx_compte` (`compte`,`dte`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_MvtA2` (
  `numero` int(11) NOT NULL,
  `compte` varchar(8) NOT NULL,
  `intitule` varchar(40) DEFAULT NULL,
  `dte` datetime NOT NULL,
  `numdoc` char(10) DEFAULT NULL,
  `libelle` varchar(50) DEFAULT NULL,
  `pourcent` char(5) DEFAULT NULL,
  `montantd` decimal(12,2) DEFAULT NULL,
  `montantc` decimal(12,2) DEFAULT NULL,
  `jour` varchar(2) DEFAULT NULL,
  `poste` char(3) DEFAULT NULL,
  `validee` tinyint(1) DEFAULT NULL,
  `lind` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`lind`),
  KEY `idx_numero` (`numero`,`compte`),
  KEY `idx_compte` (`compte`,`dte`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_MvtA3` (
  `numero` int(11) NOT NULL,
  `compte` varchar(8) NOT NULL,
  `intitule` varchar(40) DEFAULT NULL,
  `dte` datetime NOT NULL,
  `numdoc` char(10) DEFAULT NULL,
  `libelle` varchar(50) DEFAULT NULL,
  `pourcent` char(5) DEFAULT NULL,
  `montantd` decimal(12,2) DEFAULT NULL,
  `montantc` decimal(12,2) DEFAULT NULL,
  `jour` varchar(2) DEFAULT NULL,
  `poste` char(3) DEFAULT NULL,
  `validee` tinyint(1) DEFAULT NULL,
  `lind` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`lind`),
  KEY `idx_numero` (`numero`,`compte`),
  KEY `idx_compte` (`compte`,`dte`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_MvtA4` (
  `numero` int(11) NOT NULL,
  `compte` varchar(8) NOT NULL,
  `intitule` varchar(40) DEFAULT NULL,
  `dte` datetime NOT NULL,
  `numdoc` char(10) DEFAULT NULL,
  `libelle` varchar(50) DEFAULT NULL,
  `pourcent` char(5) DEFAULT NULL,
  `montantd` decimal(12,2) DEFAULT NULL,
  `montantc` decimal(12,2) DEFAULT NULL,
  `jour` varchar(2) DEFAULT NULL,
  `poste` char(3) DEFAULT NULL,
  `validee` tinyint(1) DEFAULT NULL,
  `lind` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`lind`),
  KEY `idx_numero` (`numero`,`compte`),
  KEY `idx_compte` (`compte`,`dte`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_MvtA5` (
  `numero` int(11) NOT NULL,
  `compte` varchar(8) NOT NULL,
  `intitule` varchar(40) DEFAULT NULL,
  `dte` datetime NOT NULL,
  `numdoc` char(10) DEFAULT NULL,
  `libelle` varchar(50) DEFAULT NULL,
  `pourcent` char(5) DEFAULT NULL,
  `montantd` decimal(12,2) DEFAULT NULL,
  `montantc` decimal(12,2) DEFAULT NULL,
  `jour` varchar(2) DEFAULT NULL,
  `poste` char(3) DEFAULT NULL,
  `validee` tinyint(1) DEFAULT NULL,
  `lind` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`lind`),
  KEY `idx_numero` (`numero`,`compte`),
  KEY `idx_compte` (`compte`,`dte`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_MvtM` (
  `jour` varchar(2) DEFAULT NULL,
  `numero` int(11) NOT NULL,
  `numerodef` int(11) DEFAULT NULL,
  `compte` varchar(8) NOT NULL,
  `collectif` tinyint(1) DEFAULT NULL,
  `intitule` varchar(40) DEFAULT NULL,
  `dte` datetime NOT NULL,
  `datee` datetime DEFAULT NULL,
  `dateech` datetime DEFAULT NULL,
  `numcol` varchar(3) DEFAULT NULL,
  `numdoc` char(10) DEFAULT NULL,
  `numlot` char(10) DEFAULT NULL,
  `libelle` varchar(50) DEFAULT NULL,
  `montantd` decimal(12,2) DEFAULT NULL,
  `montantc` decimal(12,2) DEFAULT NULL,
  `validee` tinyint(1) DEFAULT NULL,
  `provisoire` tinyint(1) DEFAULT NULL,
  `tresorerie` tinyint(1) DEFAULT NULL,
  `pointee` tinyint(1) DEFAULT NULL,
  `nrlv` int(11) DEFAULT NULL,
  `lettree` tinyint(1) DEFAULT NULL,
  `cloturee` tinyint(1) DEFAULT NULL,
  `dteval` datetime DEFAULT NULL,
  `relance` int(11) DEFAULT NULL,
  `export` char(1) DEFAULT NULL,
  `control` varchar(40) DEFAULT NULL,
  `lind2` int(11) DEFAULT NULL,
  `lind` int(11) NOT NULL AUTO_INCREMENT,
  `datem` datetime DEFAULT NULL,
  `supprimee` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`lind`),
  KEY `idx_numero` (`numero`,`lind2`),
  KEY `idx_dte` (`dte`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_MvtM1` (
  `jour` varchar(2) DEFAULT NULL,
  `numero` int(11) NOT NULL,
  `numerodef` int(11) DEFAULT NULL,
  `compte` varchar(8) NOT NULL,
  `collectif` tinyint(1) DEFAULT NULL,
  `intitule` varchar(40) DEFAULT NULL,
  `dte` datetime NOT NULL,
  `datee` datetime DEFAULT NULL,
  `dateech` datetime DEFAULT NULL,
  `numcol` varchar(3) DEFAULT NULL,
  `numdoc` char(10) DEFAULT NULL,
  `numlot` char(10) DEFAULT NULL,
  `libelle` varchar(50) DEFAULT NULL,
  `montantd` decimal(12,2) DEFAULT NULL,
  `montantc` decimal(12,2) DEFAULT NULL,
  `validee` tinyint(1) DEFAULT NULL,
  `provisoire` tinyint(1) DEFAULT NULL,
  `tresorerie` tinyint(1) DEFAULT NULL,
  `pointee` tinyint(1) DEFAULT NULL,
  `nrlv` int(11) DEFAULT NULL,
  `lettree` tinyint(1) DEFAULT NULL,
  `cloturee` tinyint(1) DEFAULT NULL,
  `dteval` datetime DEFAULT NULL,
  `relance` int(11) DEFAULT NULL,
  `export` char(1) DEFAULT NULL,
  `control` varchar(40) DEFAULT NULL,
  `lind2` int(11) DEFAULT NULL,
  `lind` int(11) NOT NULL AUTO_INCREMENT,
  `supprimee` tinyint(1) DEFAULT NULL,
  `datem` datetime DEFAULT NULL,
  PRIMARY KEY (`lind`),
  KEY `idx_numero` (`numero`,`lind2`),
  KEY `idx_dte` (`dte`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_MvtM2` (
  `jour` varchar(2) DEFAULT NULL,
  `numero` int(11) NOT NULL,
  `numerodef` int(11) DEFAULT NULL,
  `compte` varchar(8) NOT NULL,
  `collectif` tinyint(1) DEFAULT NULL,
  `intitule` varchar(40) DEFAULT NULL,
  `dte` datetime NOT NULL,
  `datee` datetime DEFAULT NULL,
  `dateech` datetime DEFAULT NULL,
  `numcol` varchar(3) DEFAULT NULL,
  `numdoc` char(10) DEFAULT NULL,
  `numlot` char(10) DEFAULT NULL,
  `libelle` varchar(50) DEFAULT NULL,
  `montantd` decimal(12,2) DEFAULT NULL,
  `montantc` decimal(12,2) DEFAULT NULL,
  `validee` tinyint(1) DEFAULT NULL,
  `provisoire` tinyint(1) DEFAULT NULL,
  `tresorerie` tinyint(1) DEFAULT NULL,
  `pointee` tinyint(1) DEFAULT NULL,
  `nrlv` int(11) DEFAULT NULL,
  `lettree` tinyint(1) DEFAULT NULL,
  `cloturee` tinyint(1) DEFAULT NULL,
  `dteval` datetime DEFAULT NULL,
  `relance` int(11) DEFAULT NULL,
  `export` char(1) DEFAULT NULL,
  `control` varchar(40) DEFAULT NULL,
  `lind2` int(11) DEFAULT NULL,
  `lind` int(11) NOT NULL AUTO_INCREMENT,
  `supprimee` tinyint(1) DEFAULT NULL,
  `datem` datetime DEFAULT NULL,
  PRIMARY KEY (`lind`),
  KEY `idx_numero` (`numero`,`lind2`),
  KEY `idx_dte` (`dte`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_MvtM3` (
  `jour` varchar(2) DEFAULT NULL,
  `numero` int(11) NOT NULL,
  `numerodef` int(11) DEFAULT NULL,
  `compte` varchar(8) NOT NULL,
  `collectif` tinyint(1) DEFAULT NULL,
  `intitule` varchar(40) DEFAULT NULL,
  `dte` datetime NOT NULL,
  `datee` datetime DEFAULT NULL,
  `dateech` datetime DEFAULT NULL,
  `numcol` varchar(3) DEFAULT NULL,
  `numdoc` char(10) DEFAULT NULL,
  `numlot` char(10) DEFAULT NULL,
  `libelle` varchar(50) DEFAULT NULL,
  `montantd` decimal(12,2) DEFAULT NULL,
  `montantc` decimal(12,2) DEFAULT NULL,
  `validee` tinyint(1) DEFAULT NULL,
  `provisoire` tinyint(1) DEFAULT NULL,
  `tresorerie` tinyint(1) DEFAULT NULL,
  `pointee` tinyint(1) DEFAULT NULL,
  `nrlv` int(11) DEFAULT NULL,
  `lettree` tinyint(1) DEFAULT NULL,
  `cloturee` tinyint(1) DEFAULT NULL,
  `dteval` datetime DEFAULT NULL,
  `relance` int(11) DEFAULT NULL,
  `export` char(1) DEFAULT NULL,
  `control` varchar(40) DEFAULT NULL,
  `lind2` int(11) DEFAULT NULL,
  `lind` int(11) NOT NULL AUTO_INCREMENT,
  `supprimee` tinyint(1) DEFAULT NULL,
  `datem` datetime DEFAULT NULL,
  PRIMARY KEY (`lind`),
  KEY `idx_numero` (`numero`,`lind2`),
  KEY `idx_dte` (`dte`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_MvtM4` (
  `jour` varchar(2) DEFAULT NULL,
  `numero` int(11) NOT NULL,
  `numerodef` int(11) DEFAULT NULL,
  `compte` varchar(8) NOT NULL,
  `collectif` tinyint(1) DEFAULT NULL,
  `intitule` varchar(40) DEFAULT NULL,
  `dte` datetime NOT NULL,
  `datee` datetime DEFAULT NULL,
  `dateech` datetime DEFAULT NULL,
  `numcol` varchar(3) DEFAULT NULL,
  `numdoc` char(10) DEFAULT NULL,
  `numlot` char(10) DEFAULT NULL,
  `libelle` varchar(50) DEFAULT NULL,
  `montantd` decimal(12,2) DEFAULT NULL,
  `montantc` decimal(12,2) DEFAULT NULL,
  `validee` tinyint(1) DEFAULT NULL,
  `provisoire` tinyint(1) DEFAULT NULL,
  `tresorerie` tinyint(1) DEFAULT NULL,
  `pointee` tinyint(1) DEFAULT NULL,
  `nrlv` int(11) DEFAULT NULL,
  `lettree` tinyint(1) DEFAULT NULL,
  `cloturee` tinyint(1) DEFAULT NULL,
  `dteval` datetime DEFAULT NULL,
  `relance` int(11) DEFAULT NULL,
  `export` char(1) DEFAULT NULL,
  `control` varchar(40) DEFAULT NULL,
  `lind2` int(11) DEFAULT NULL,
  `lind` int(11) NOT NULL AUTO_INCREMENT,
  `supprimee` tinyint(1) DEFAULT NULL,
  `datem` datetime DEFAULT NULL,
  PRIMARY KEY (`lind`),
  KEY `idx_numero` (`numero`,`lind2`),
  KEY `idx_dte` (`dte`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_MvtM5` (
  `jour` varchar(2) DEFAULT NULL,
  `numero` int(11) NOT NULL,
  `numerodef` int(11) DEFAULT NULL,
  `compte` varchar(8) NOT NULL,
  `collectif` tinyint(1) DEFAULT NULL,
  `intitule` varchar(40) DEFAULT NULL,
  `dte` datetime NOT NULL,
  `datee` datetime DEFAULT NULL,
  `dateech` datetime DEFAULT NULL,
  `numcol` varchar(3) DEFAULT NULL,
  `numdoc` char(10) DEFAULT NULL,
  `numlot` char(10) DEFAULT NULL,
  `libelle` varchar(50) DEFAULT NULL,
  `montantd` decimal(12,2) DEFAULT NULL,
  `montantc` decimal(12,2) DEFAULT NULL,
  `validee` tinyint(1) DEFAULT NULL,
  `provisoire` tinyint(1) DEFAULT NULL,
  `tresorerie` tinyint(1) DEFAULT NULL,
  `pointee` tinyint(1) DEFAULT NULL,
  `nrlv` int(11) DEFAULT NULL,
  `lettree` tinyint(1) DEFAULT NULL,
  `cloturee` tinyint(1) DEFAULT NULL,
  `dteval` datetime DEFAULT NULL,
  `relance` int(11) DEFAULT NULL,
  `export` char(1) DEFAULT NULL,
  `control` varchar(40) DEFAULT NULL,
  `lind2` int(11) DEFAULT NULL,
  `lind` int(11) NOT NULL AUTO_INCREMENT,
  `supprimee` tinyint(1) DEFAULT NULL,
  `datem` datetime DEFAULT NULL,
  PRIMARY KEY (`lind`),
  KEY `idx_numero` (`numero`,`lind2`),
  KEY `idx_dte` (`dte`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Mvtexp` (
  `mind` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(15) DEFAULT NULL,
  `daterecpt` datetime NOT NULL,
  `qtep` varchar(10) DEFAULT NULL,
  `qtem` varchar(10) DEFAULT NULL,
  `com` varchar(35) DEFAULT NULL,
  PRIMARY KEY (`mind`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Mvtexpdc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mind` int(11) NOT NULL,
  `code` char(15) DEFAULT NULL,
  `daterecpt` datetime NOT NULL,
  `qtep` char(10) DEFAULT NULL,
  `qtem` char(10) DEFAULT NULL,
  `com` varchar(35) DEFAULT NULL,
  `type` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Numabon` (
  `numero` int(11) NOT NULL,
  `intitule` varchar(30) DEFAULT NULL,
  `type` char(1) DEFAULT NULL,
  `typem` char(1) DEFAULT NULL,
  `compteur` int(11) DEFAULT 0,
  PRIMARY KEY (`numero`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Parametres` (
  `ind` int(11) NOT NULL DEFAULT 0,
  `dteclec` date DEFAULT NULL,
  `dteclec1` date DEFAULT NULL,
  `dteclec2` date DEFAULT NULL,
  `dteclec3` date DEFAULT NULL,
  `dteclec4` date DEFAULT NULL,
  `dteclec5` date DEFAULT NULL,
  `dtepp` varchar(7) DEFAULT NULL,
  `dtepec` varchar(7) DEFAULT NULL,
  `dtepc` date DEFAULT NULL,
  `dtetdec` date DEFAULT NULL,
  `dtefedec` date DEFAULT NULL,
  `cptrplus` varchar(8) DEFAULT NULL,
  `cptrmoins` varchar(8) DEFAULT NULL,
  `jdr` varchar(2) DEFAULT NULL,
  `cptrsplus` varchar(8) DEFAULT NULL,
  `cptrsmoins` varchar(8) DEFAULT NULL,
  `numecriture` int(11) DEFAULT NULL,
  `dnc` int(11) DEFAULT NULL,
  `dnbon` varchar(8) DEFAULT NULL,
  `dnfac` varchar(6) DEFAULT NULL,
  `dndevis` varchar(8) DEFAULT NULL,
  `jrnal` varchar(2) DEFAULT NULL,
  `son` int(11) NOT NULL DEFAULT 0,
  `dnf` int(11) DEFAULT NULL,
  `numecriture1` int(11) DEFAULT NULL,
  `numecriture2` int(11) DEFAULT NULL,
  `numecriture3` int(11) DEFAULT NULL,
  `coretro` varchar(5) DEFAULT NULL,
  `dncom` varchar(5) DEFAULT NULL,
  `devise` varchar(8) DEFAULT NULL,
  `jrnal2` varchar(2) DEFAULT NULL,
  `jrnal3` varchar(2) DEFAULT NULL,
  `jrnal4` char(2) DEFAULT NULL,
  `dteinv` date DEFAULT NULL,
  `jrnal5` char(2) DEFAULT NULL,
  `dnbr` char(8) DEFAULT NULL,
  `nfac` tinyint(1) DEFAULT NULL,
  `version` char(5) DEFAULT NULL,
  `conf` blob DEFAULT NULL,
  `frais` decimal(6,2) DEFAULT NULL,
  `cptfrais` char(8) DEFAULT NULL,
  `tvafrais` char(2) DEFAULT NULL,
  `dntk` char(7) DEFAULT NULL,
  `cutk` char(7) DEFAULT NULL,
  `dnart` varchar(15) DEFAULT NULL,
  `ecart` decimal(6,2) DEFAULT 0.00,
  `jrnod` char(2) DEFAULT NULL,
  PRIMARY KEY (`ind`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Postes` (
  `lind` int(11) NOT NULL AUTO_INCREMENT,
  `code` char(3) DEFAULT NULL,
  `intitulep` char(35) DEFAULT NULL,
  PRIMARY KEY (`lind`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_PrdComp` (
  `codep` varchar(15) NOT NULL,
  `codec` varchar(50) NOT NULL,
  `libelle` varchar(50) DEFAULT NULL,
  `qte` varchar(50) DEFAULT NULL,
  `mo` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`codep`,`codec`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Promo` (
  `code` varchar(15) NOT NULL,
  `libelle` varchar(50) DEFAULT NULL,
  `datedeb` date DEFAULT NULL,
  `datefin` date DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Rappro` (
  `cpt` varchar(8) NOT NULL,
  `nreleve` int(11) NOT NULL DEFAULT 0,
  `date_releve` datetime DEFAULT NULL,
  `date_rappro` datetime DEFAULT NULL,
  `solde` double DEFAULT NULL,
  PRIMARY KEY (`cpt`,`nreleve`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Reglements` (
  `code` char(2) NOT NULL,
  `libel` varchar(20) DEFAULT NULL,
  `journal` char(2) DEFAULT NULL,
  `cptint` char(8) DEFAULT NULL,
  `bordereaux` tinyint(1) DEFAULT 0,
  `lcr` int(11) DEFAULT 0,
  `caisse` int(11) DEFAULT 0,
  `decaissement` tinyint(1) DEFAULT 0,
  `regroup` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_RemCliFam` (
  `codec` char(8) NOT NULL,
  `codef` char(20) NOT NULL,
  `remise` decimal(6,3) DEFAULT NULL,
  PRIMARY KEY (`codec`,`codef`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_RemTypec` (
  `lind` int(11) NOT NULL AUTO_INCREMENT,
  `coder` char(2) DEFAULT NULL,
  `codef` char(20) DEFAULT NULL,
  `remise` decimal(6,3) DEFAULT NULL,
  PRIMARY KEY (`lind`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Rpl1` (
  `codep` char(15) NOT NULL,
  `coderpl1` char(15) NOT NULL,
  PRIMARY KEY (`codep`,`coderpl1`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Rpl2` (
  `codep` char(15) NOT NULL,
  `coderpl2` char(15) NOT NULL,
  PRIMARY KEY (`codep`,`coderpl2`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_RubCompt` (
  `numrub` char(8) NOT NULL,
  `compte1` char(8) NOT NULL,
  `compte2` char(8) DEFAULT NULL,
  `amortissement` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`numrub`,`compte1`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Rubriques` (
  `numrub` char(8) NOT NULL,
  `intitule` varchar(70) DEFAULT NULL,
  `type` char(2) DEFAULT NULL,
  `detail` char(2) DEFAULT NULL,
  `num` char(2) DEFAULT NULL,
  PRIMARY KEY (`numrub`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Sdepots` (
  `mind` int(11) NOT NULL AUTO_INCREMENT,
  `code` char(2) DEFAULT NULL,
  `cart` char(15) DEFAULT NULL,
  `date` date NOT NULL,
  `type` char(1) DEFAULT NULL,
  `qte` char(10) DEFAULT NULL,
  `com` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`mind`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Sms` (
  `numcom` char(2) NOT NULL,
  `intitule` mediumtext DEFAULT NULL,
  PRIMARY KEY (`numcom`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Societes` (
  `cd_sc` varchar(2) NOT NULL,
  `type_sc` char(9) DEFAULT NULL,
  `int_sc` varchar(35) DEFAULT NULL,
  `adr1_sc` varchar(35) DEFAULT NULL,
  `adr2_sc` varchar(35) DEFAULT NULL,
  `cp_sc` varchar(5) DEFAULT NULL,
  `burdis_sc` varchar(35) DEFAULT NULL,
  `email_sc` char(50) DEFAULT NULL,
  `rcs_sc` varchar(12) DEFAULT NULL,
  `villerc_sc` varchar(15) DEFAULT NULL,
  `siret_sc` varchar(15) DEFAULT NULL,
  `tvaintra_sc` varchar(15) DEFAULT NULL,
  `cap_sc` varchar(15) DEFAULT NULL,
  `ape_sc` varchar(5) DEFAULT NULL,
  `tel_sc` varchar(16) DEFAULT NULL,
  `fax_sc` varchar(16) DEFAULT NULL,
  `site` varchar(40) DEFAULT NULL,
  `port_sc` char(16) DEFAULT NULL,
  `banq` char(30) DEFAULT NULL,
  `bic` char(11) DEFAULT NULL,
  `libre` char(35) DEFAULT NULL,
  PRIMARY KEY (`cd_sc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_SousComptes` (
  `code` char(8) DEFAULT NULL,
  `code_vtl` char(8) NOT NULL,
  `intitule_vtl` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`code_vtl`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Statut` (
  `code` char(2) NOT NULL,
  `libelle` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_StkDepots` (
  `coded` char(8) NOT NULL,
  `codea` varchar(15) NOT NULL,
  `qte` decimal(12,3) DEFAULT NULL,
  PRIMARY KEY (`coded`,`codea`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Suivis` (
  `lind` int(11) NOT NULL AUTO_INCREMENT,
  `code` char(8) DEFAULT NULL,
  `nom` varchar(70) DEFAULT NULL,
  `numdev` char(12) DEFAULT NULL,
  `datedev` date DEFAULT NULL,
  `numfac` char(12) DEFAULT NULL,
  `datefac` date DEFAULT NULL,
  `qte` decimal(12,2) DEFAULT NULL,
  `pu` decimal(12,2) DEFAULT NULL,
  `total` decimal(12,2) DEFAULT NULL,
  `margemo` decimal(12,2) DEFAULT NULL,
  `ach` decimal(12,2) DEFAULT NULL,
  `vtes` decimal(12,2) DEFAULT NULL,
  `qte2` decimal(12,2) DEFAULT NULL,
  `pu2` decimal(12,2) DEFAULT NULL,
  `total2` decimal(12,2) DEFAULT NULL,
  `margemo2` decimal(12,2) DEFAULT NULL,
  `ach2` decimal(12,2) DEFAULT NULL,
  `vtes2` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`lind`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Taches` (
  `lind` int(11) NOT NULL AUTO_INCREMENT,
  `numdoc` varchar(10) DEFAULT NULL,
  `nom` char(8) DEFAULT NULL,
  `poste` varchar(40) DEFAULT NULL,
  `numcli` char(8) DEFAULT NULL,
  `nomcli` varchar(40) DEFAULT NULL,
  `texte` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`lind`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Tag` (
  `tag` tinytext NOT NULL,
  `lind` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`lind`),
  KEY `idx_tag` (`tag`(64))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_TarTemp` (
  `art` varchar(15) NOT NULL,
  `dtmaj` tinyint(1) DEFAULT 0,
  `date` datetime DEFAULT NULL,
  `pbht` decimal(12,3) DEFAULT NULL,
  `rm` decimal(6,2) DEFAULT NULL,
  `paht` decimal(12,3) DEFAULT NULL,
  `frais` decimal(12,3) DEFAULT NULL,
  `pxrev` decimal(12,3) DEFAULT NULL,
  `txconv` decimal(10,4) DEFAULT NULL,
  `temp_type` int(11) NOT NULL DEFAULT 0,
  `code` varchar(10) NOT NULL,
  `temp_coef` decimal(7,4) DEFAULT NULL,
  `temp_sup` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`art`,`temp_type`,`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_TarTypcli` (
  `lind` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(10) DEFAULT NULL,
  `cart` varchar(15) DEFAULT NULL,
  `coef` decimal(7,4) DEFAULT NULL,
  PRIMARY KEY (`lind`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Tarcli` (
  `lind` int(11) NOT NULL AUTO_INCREMENT,
  `ccli` varchar(10) DEFAULT NULL,
  `cart` varchar(15) DEFAULT NULL,
  `coef` decimal(7,4) DEFAULT NULL,
  PRIMARY KEY (`lind`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Tleg` (
  `lind` int(11) NOT NULL AUTO_INCREMENT,
  `intitule` mediumtext DEFAULT NULL,
  PRIMARY KEY (`lind`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Touches` (
  `touche` char(6) NOT NULL,
  `libelle` char(30) DEFAULT NULL,
  `code` char(15) DEFAULT NULL,
  `tva` decimal(5,2) DEFAULT NULL,
  `coul` int(11) DEFAULT NULL,
  `fond` varchar(100) DEFAULT NULL,
  `touche_s` tinyint(1) DEFAULT NULL,
  `cai` char(2) NOT NULL,
  PRIMARY KEY (`touche`,`cai`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Traites` (
  `lind` int(11) NOT NULL AUTO_INCREMENT,
  `code` char(8) DEFAULT NULL,
  `montant` char(12) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `datech` date DEFAULT NULL,
  `numfac` char(12) DEFAULT NULL,
  `imp` tinyint(4) DEFAULT NULL,
  `nom` varchar(35) DEFAULT NULL,
  `acceptee` int(1) DEFAULT NULL,
  `ecartee` int(1) DEFAULT NULL,
  PRIMARY KEY (`lind`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Tvaac` (
  `code_tva` char(2) NOT NULL,
  `taux_tva` varchar(5) DEFAULT NULL,
  `cc_tva` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`code_tva`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Tvaav` (
  `code_tva` char(2) NOT NULL,
  `taux_tva` varchar(5) DEFAULT NULL,
  `cc_tva` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`code_tva`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_TxtMail` (
  `lind` int(11) NOT NULL AUTO_INCREMENT,
  `intitule` mediumtext DEFAULT NULL,
  PRIMARY KEY (`lind`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Txt_Relances` (
  `niveau` int(11) NOT NULL DEFAULT 0,
  `libell1` mediumtext DEFAULT NULL,
  `libell2` mediumtext DEFAULT NULL,
  PRIMARY KEY (`niveau`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Txtmo` (
  `code_txtmo` char(5) NOT NULL,
  `tx_txtmo` char(10) DEFAULT NULL,
  `libell_txtmo` varchar(25) DEFAULT NULL,
  `compt_txtmo` varchar(8) DEFAULT NULL,
  `prvt_txtmo` decimal(12,3) DEFAULT NULL,
  PRIMARY KEY (`code_txtmo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Typec` (
  `code` varchar(2) NOT NULL,
  `libelle` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Users` (
  `lind` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(20) DEFAULT NULL,
  `poste` varchar(35) DEFAULT NULL,
  PRIMARY KEY (`lind`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_Vendeurs` (
  `lind` int(11) NOT NULL AUTO_INCREMENT,
  `code` char(2) DEFAULT NULL,
  `nom` varchar(35) DEFAULT NULL,
  `mdp` varchar(15) DEFAULT NULL,
  `admin` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`lind`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fiches_tourne` (
  `code` char(15) NOT NULL,
  `tourne` char(50) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Mails_Cli` (
  `code` varchar(8) NOT NULL,
  `mail` varchar(150) NOT NULL,
  PRIMARY KEY (`code`,`mail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Mails_Four` (
  `code` varchar(8) NOT NULL,
  `mail` varchar(150) NOT NULL,
  PRIMARY KEY (`code`,`mail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `centralisation` (
  `numrub` char(5) NOT NULL,
  `intitrub` char(70) DEFAULT NULL,
  `type` char(1) DEFAULT NULL,
  `detail` char(1) DEFAULT NULL,
  `compte` char(8) DEFAULT NULL,
  `intitcpt` char(50) DEFAULT NULL,
  `Col1` char(12) DEFAULT NULL,
  `Col2` char(12) DEFAULT NULL,
  `col3` char(12) DEFAULT NULL,
  `col4` char(12) DEFAULT NULL,
  `amortissement` tinyint(1) NOT NULL,
  `amortissement2` tinyint(1) NOT NULL,
  `actif` tinyint(1) DEFAULT NULL,
  `actif2` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`numrub`,`amortissement`,`amortissement2`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
-- données
## Comptes (compte	intitule	solde	solde2	annee	numrub	intitrub	type	detail	Col1	Col2	col3	col4	amortissement	amortissement2	actif	actif2)
101000	Capital	0.0000	0.0000	N	B1040	Capital social	L	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL
106800	Autres reserves	0.0000	0.0000	N	B1160	Autres	L	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL
108000	Exploitant	0.0000	0.0000	N	B1040	Capital social	L	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL
110000	Report a nouveau credit	0.0000	0.0000	N	B1180	NULL	L	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL
119000	Report a nouveau debit	0.0000	0.0000	N	B1180	NULL	L	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL
120000	Resultat. Benefices	0.0000	0.0000	N	B1200	NULL	L	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL
129000	Resultat. Perte	0.0000	0.0000	N	B1200	NULL	L	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL
168800	Interets courus	0.0000	0.0000	N	B1340	NULL	L	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL
211000	Terrain	8606.8000	1500.6000	N	B0130	Terrains	L	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL
213000	Construction	8743.7600	2167.9400	N	B0140	Constructions	L	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL
213500	Inst. Gen. Agen. Ame.	0.0000	0.0000	N	B0140	Constructions	L	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL
218200	Materiel de transport	7792.7600	1844.2800	N	B0160	Autres	L	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL
218300	Materiel bureau informatique	7383.2400	529.6200	N	B0160	Autres	L	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL
218400	Mobilier	9113.2400	1353.4800	N	B0160	Autres	L	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL
218820	Amortissement materiels de transport	0.0000	0.0000	N	NULL	NULL	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
231000	Immobilisation en cours	0.0000	0.0000	N	NULL	NULL	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
231500	Amenagement en cours	0.0000	0.0000	N	NULL	NULL	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
261000	Titres de participation	0.0000	0.0000	N	B0200	Participations	L	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL
266000	Autres formes de participation	0.0000	0.0000	N	B0200	Participations	L	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL
275000	Depots et cautionnements	0.0000	0.0000	N	B0240	Autres	L	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL
281300	Amortissement construction	0.0000	0.0000	N	B0140	Constructions	L	NULL	NULL	NULL	NULL	NULL	1	NULL	NULL	NULL
281400	Amortissement mobilier	0.0000	0.0000	N	B0160	Autres	L	NULL	NULL	NULL	NULL	NULL	1	NULL	NULL	NULL
281500	Amortissement materiel de bureau	0.0000	0.0000	N	B0150	Installations techniques, materiels et o	L	NULL	NULL	NULL	NULL	NULL	1	NULL	NULL	NULL
281600	Amortissement materiel de transport	0.0000	0.0000	N	NULL	NULL	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
281700	Amortissement materiel informatique	0.0000	0.0000	N	NULL	NULL	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
335000	Travaux en cours	0.0000	0.0000	N	B0290	En-cours de production de biens	L	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL
370000	Stock marchandises	0.0000	0.0000	N	B0320	Marchandises	L	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL
397000	Provision depreciation stock	0.0000	0.0000	N	B0320	Marchandises	L	NULL	NULL	NULL	NULL	NULL	1	NULL	NULL	NULL
401000	Collectif fournisseur	0.0000	0.0000	N	B1440	NULL	L	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL
408000	Factures non parvenues	0.0000	0.0000	N	NULL	NULL	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
408100	Fournisseurs factures non parvenues	0.0000	0.0000	N	B1440	NULL	L	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL
409600	Fourniseurs emballages a rendre	0.0000	0.0000	N	B1500	NULL	L	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL
409700	Avoirs non parvenus	0.0000	0.0000	N	B1500	NULL	L	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL
411000	Collectif client	0.0000	0.0000	N	B1500	NULL	L	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL
416000	Clients douteux	0.0000	0.0000	N	B0360	Creances clients et comptes rattaches	L	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL
419100	Clients avances et acomptes reçus	0.0000	0.0000	N	B1420	NULL	L	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL
419700	Clients autres avoirs	0.0000	0.0000	N	B1500	NULL	L	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL
421000	Remuneration employes	0.0000	0.0000	N	B1460	NULL	L	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL
428200	Provisions conges payes	0.0000	0.0000	N	B1460	NULL	L	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL
437100	Organismes sociaux	0.0000	0.0000	N	B1460	NULL	L	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL
437200	Retraite employes	0.0000	0.0000	N	B1460	NULL	L	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL
444000	Impots societes	0.0000	0.0000	N	B1460	NULL	L	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL
445510	Tva a decaisser	0.0000	0.0000	N	B1460	NULL	L	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL
445620	Tva deductible sur immobilisation	0.0000	0.0000	N	B0370	Créances associés et comptes rattaché	L	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL
445660	Tva sur achat 2.10	0.0000	0.0000	N	B0370	Créances associés et comptes rattaché	L	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL
445670	Tva sur achat 5.50	0.0000	0.0000	N	B0370	Créances associés et comptes rattaché	L	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL
445680	Tva sur achat 19.60	0.0000	0.0000	N	B0370	Créances associés et comptes rattaché	L	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL
445710	Tva sur ventes 2.10	41866.6400	7792.3500	N	B1460	NULL	L	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL
445720	Tva sur ventes 5.50	0.0000	0.0000	N	B1460	NULL	L	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL
445730	Tva sur ventes 19.60	0.0000	0.0000	N	B1460	NULL	L	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL
468700	Débiteurs divers produits à recevoir	0.0000	0.0000	N	B0370	Créances associés et comptes rattaché	L	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL
471000	Compte d'attente	0.0000	0.0000	N	B1500	NULL	L	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL
491000	Provisions pour creances	0.0000	0.0000	N	NULL	NULL	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
512000	Banque	-40179.6200	-7507.7100	N	B1380	NULL	L	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL
512001	Banque 2	-41639.8000	-7395.9200	N	B1380	NULL	L	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL
518600	Interets courus	0.0000	0.0000	N	B1380	NULL	L	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL
530000	Caisse	41686.4400	8858.5000	N	B0430	Disponibilités	L	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL
580000	Virements internes	0.0000	0.0000	N	B1380	NULL	L	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL
580001	Virements internes cartes	0.0000	0.0000	N	B1380	NULL	L	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL
580002	Virements internes chèques	0.0000	0.0000	N	B1380	NULL	L	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL
580003	Virements internes autres	0.0000	0.0000	N	B1380	NULL	L	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL
## Fiches_Art (art_code	art_design	art_fam	art_four	art_cequ	art_cbarre	art_cfour	art_pbht	art_tr	art_paht	art_coef	art_pvht	art_tva	art_pvttc	art_cdarr	art_pvar	art_dec	art_stocke	art_qte	art_dpa	art_dfour	art_pmp	art_com	art_stkdep	art_nbd	art_design2	art_ect	art_eco	art_pauaht	art_txconv	art_stkmin	art_stkmax	art_suspendu	art_cpp	art_copp	qte1	qte2	rem1	qte3	qte4	rem2	qte5	qte6	rem3	qte7	qte8	rem4	qte9	qte10	rem5	qte11	qte12	rem6	art_frais	art_prvt	art_etiq	art_poids	art_mincom	art_vol	art_poids2	art_photo	art_crst	art_mat	art_marque	art_impcar	art_casier	art_pvcons	art_prdcomp	art_impdetail	art_remcas1	art_remcas2	art_remcas3	art_datefbt	art_pbfbt	art_ddatefbt	art_centrale	art_refcentrale	art_bonus	art_colvte	art_pvht2	art_cn8	art_crpl1	art_crpl2	art_ect2	art_eco2	art_depg	art_cnsg	art_ua	art_uv	art_refliee	art_ddate	art_cdate	export	art_bredu	art_bredudate	art_breducond	art_bredumnt)
001	Produit 2.10	01	401001		2148413200001		10	0	10	2.2000	22	1	22.46	0,01	NULL	0	0	0	0	NULL	10	NULL	NULL	2		0	NULL	10	1.0000	0	0	0	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	10.000	1	0.000	0	Kg	NULL			0		0		0.000	0	0	0.00	0.00	0.00	2001-01-02	NULL	NULL			0.00	NULL	NULL			NULL	0	NULL	0	0			NULL	NULL	2018-01-01 00:00:00	0	0	NULL	NULL	0.00
002	Produit 7.00	02	401001		2640636100002		10	0	10	2.0000	20	2	21.4	0,01	NULL	0	0	0	0	NULL	10	NULL	NULL	2		0	NULL	10	1.0000	0	0	0	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	10.000	1	0.000	0	Kg	NULL			0		0		0.000	0	0	0.00	0.00	0.00	2001-01-02	NULL	NULL			0.00	NULL	NULL			NULL	0	NULL	0	0			NULL	NULL	2018-01-01 00:00:00	0	0	NULL	NULL	0.00
003	produit 20.00	03	401001				0	0	0	1.0000	0	3	0	0,01	NULL	0	0	0	0	NULL	0	NULL	0	2		0	NULL	0	1.0000	0	0	0	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	0.000	1	0.000	2	Kg	NULL			0		0		0.000	0	0	0.00	0.00	0.00	2001-01-02	0.000	NULL			0.00	NULL	NULL			NULL	0	NULL	0	0				NULL	2018-01-01 00:00:00	0	0	NULL	NULL	0.00
## Fiches_CdBarre (codep	codeb)
001	2148413200001
002	2640636100002
003	
## Fiches_Cli (cli_code	cli_col	cli_rs_soc	cli_nom	cli_pnm	cli_adr1	cli_adr2	cli_cd_ptl	cli_ville	cli_email	cli_tel_bur	cli_tel_dom	cli_tel_poste	cli_pble	cli_fx1	cli_fx2	cli_plaf_ecrs	cli_cd_bq	cli_cd_gch	cli_dmln	cli_cle_rib	cli_num_cpt	cli_dom	cli_cd_ent	cli_cd_acc	cli_ref_tir	cli_id_tva	cli_cd_soc	cli_cd_cli	cli_co_vtl	cli_rlvc	cli_rlvf	cli_dt_rlc	cli_nm_int	cli_obs	cli_collectif	cli_rmo	cli_rart	cli_exo	cli_cdech	cli_typec	cli_expl	cli_pays	cli_statut	cli_rs_soc2	cli_nom2	cli_pnm2	cli_adr12	cli_adr22	cli_cd_ptl2	cli_ville2	cli_cnt1	cli_cnt2	cli_cnt3	cli_cnt4	cli_cnt5	cli_cnt6	cli_cnt7	cli_cnt8	cli_cnt9	cli_cnt10	cli_cnt11	cli_cnt12	cli_cnt13	cli_cnt14	cli_cnt15	cli_reg	cli_copie	cli_actif	cli_div	cli_iban	cli_bic	cli_coop	cli_rum	cli_datab	cli_aban	cli_sage	cli_livraison	cli_comm	cli_autoent	cli_tour	cli_gestion	cli_regr	cli_siret	libel_def	tag_def)
411001	NULL		A Divers 																			NULL					NULL	NULL	NULL	0	0	NULL	NULL		411000	0,00	0,00	0	00		2	France									NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL		0	0	-1			0					0		NULL	NULL	0.00	S	NULL	NULL	NULL
411002	NULL		B Divers 																			NULL					NULL	NULL	NULL	0	0	NULL	NULL		411000	0,00	0,00	0	00		2	France									NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL		0	0	-1			0					0		NULL	NULL	0.00	S	NULL	NULL	NULL
411003	NULL	NULL	C Divers 	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	0	NULL	NULL	NULL	411000	0,00	0,00	0	00	NULL	2	France	NULL																							NULL	0	0	-1	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00	S	NULL	NULL	NULL
411004	NULL		D Divers 																			NULL					NULL	NULL	NULL	0	0	NULL	NULL		411000	0,00	0,00	0	00		2	France		NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL		0	0	-1			0					0		0	NULL	0.00	S	NULL	NULL	NULL
411005	NULL		E Divers 																			NULL					NULL	NULL	NULL	0	0	NULL	NULL		411000	0,00	0,00	0	00		2	France		NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL		0	0	-1			0					0		0	NULL	0.00	S	NULL	NULL	NULL
411006	NULL		F Divers 																			NULL					NULL	NULL	NULL	0	0	NULL	NULL		411000	0,00	0,00	0	00		2	France		NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL		0	0	-1			0					0		0	NULL	0.00	S	NULL	NULL	NULL
411007	NULL	NULL	G Divers 	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	0	NULL	NULL	NULL	411000	0,00	0,00	0	00	NULL	2	France	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	0	-1	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00	S	NULL	NULL	NULL
411008	NULL	NULL	H Divers 	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	0	NULL	NULL	NULL	411000	0,00	0,00	0	00	NULL	2	France	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	0	-1	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00	S	NULL	NULL	NULL
411009	NULL	NULL	I Divers 	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	0	NULL	NULL	NULL	411000	0,00	0,00	0	00	NULL	2	France	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	0	-1	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00	S	NULL	NULL	NULL
411010	NULL	NULL	J Divers 	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	0	NULL	NULL	NULL	411000	0,00	0,00	0	00	NULL	2	France	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	0	-1	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00	S	NULL	NULL	NULL
411011	NULL	NULL	K Divers 	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	0	NULL	NULL	NULL	411000	0,00	0,00	0	00	NULL	2	France	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	0	-1	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00	S	NULL	NULL	NULL
411012	NULL	NULL	L Divers 	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	0	NULL	NULL	NULL	411000	0,00	0,00	0	00	NULL	2	France	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	0	-1	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00	S	NULL	NULL	NULL
411013	NULL	NULL	M Divers 	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	0	NULL	NULL	NULL	411000	0,00	0,00	0	00	NULL	2	France	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	0	-1	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00	S	NULL	NULL	NULL
411014	NULL	NULL	N Divers 	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	0	NULL	NULL	NULL	411000	0,00	0,00	0	00	NULL	2	France	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	0	-1	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00	S	NULL	NULL	NULL
411015	NULL	NULL	O Divers 	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	0	NULL	NULL	NULL	411000	0,00	0,00	0	00	NULL	2	France	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	0	-1	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00	S	NULL	NULL	NULL
411016	NULL	NULL	P Divers 	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	0	NULL	NULL	NULL	411000	0,00	0,00	0	00	NULL	2	France	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	0	-1	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00	S	NULL	NULL	NULL
411017	NULL	NULL	Q Divers 	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	0	NULL	NULL	NULL	411000	0,00	0,00	0	00	NULL	2	France	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	0	-1	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00	S	NULL	NULL	NULL
411018	NULL	NULL	R Divers 	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	0	NULL	NULL	NULL	411000	0,00	0,00	0	00	NULL	2	France	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	0	-1	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00	S	NULL	NULL	NULL
411019	NULL	NULL	S Divers 	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	0	NULL	NULL	NULL	411000	0,00	0,00	0	00	NULL	2	France	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	0	-1	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00	S	NULL	NULL	NULL
411020	NULL	NULL	T Divers 	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	0	NULL	NULL	NULL	411000	0,00	0,00	0	00	NULL	2	France	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	0	-1	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00	S	NULL	NULL	NULL
411021	NULL	NULL	U Divers 	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	0	NULL	NULL	NULL	411000	0,00	0,00	0	00	NULL	2	France	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	0	-1	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00	S	NULL	NULL	NULL
411022	NULL	NULL	V Divers 	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	0	NULL	NULL	NULL	411000	0,00	0,00	0	00	NULL	2	France	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	0	-1	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00	S	NULL	NULL	NULL
411023	NULL	NULL	W Divers 	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	0	NULL	NULL	NULL	411000	0,00	0,00	0	00	NULL	2	France	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	0	-1	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00	S	NULL	NULL	NULL
411024	NULL	NULL	X Divers 	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	0	NULL	NULL	NULL	411000	0,00	0,00	0	00	NULL	2	France	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	0	-1	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00	S	NULL	NULL	NULL
411025	NULL	NULL	Y Divers 	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	0	NULL	NULL	NULL	411000	0,00	0,00	0	00	NULL	2	France	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	0	-1	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00	S	NULL	NULL	NULL
411026	NULL	NULL	Z Divers 	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	0	NULL	NULL	NULL	411000	0,00	0,00	0	00	NULL	2	France	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	0	-1	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00	S	NULL	NULL	NULL
411027	NULL		********** Test **************																			NULL					NULL	NULL	NULL	0	0	NULL	NULL		411000	0,00	0,00	0						NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL		-1	0	0			NULL	775B4C4E4965735B494F				0		NULL	NULL	0.00	S	NULL	NULL	NULL
## Fiches_Cli_Vtl (code	code_vtl	intitule_vtl)
411001	707000	Ventes marchandises
## Fiches_Commentaires (numcom	intitule)
01	Garantie 6 mois pieces et main d'oeuvre
02	Garantie 12 mois pieces et main d'oeuvre
## Fiches_Comptes (compte_cc	intitule_cc	type_cc	coll	coll_cc	cent_cc	comptr_cc	code_tvente	taux_tvente	gen_tv	code_tachat	taux_tachat	gen_ta	solde	soldep	cprincipal	lettrable)
101000	Capital	B	0	NULL	0	0			0			0	0	0	0	NULL
106800	Autres reserves	B	0	NULL	0	0			0			0	0	0	0	NULL
108000	Exploitant	B	0	NULL	0	0			0			0	0	0	0	NULL
110000	Report a nouveau credit	B	0	NULL	0	0			0			0	0	0	0	NULL
119000	Report a nouveau debit	B	0	NULL	0	0			0			0	0	0	0	NULL
120000	Resultat. Benefices	B	0	NULL	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	NULL
129000	Resultat. Perte	B	0	NULL	0	0			0			0	0	0	0	NULL
168800	Interets courus	B	0	NULL	0	0			0			0	0	0	0	NULL
211000	Terrain	B	0	NULL	0	0			0			0	0	0	0	NULL
213000	Construction	B	0	NULL	0	0			0			0	0	0	0	NULL
213500	Inst. Gen. Agen. Ame.	B	0	NULL	0	0			0			0	0	0	0	NULL
218200	Materiel de transport	B	0	NULL	0	0			0			0	0	0	0	NULL
218300	Materiel bureau informatique	B	0	NULL	0	0			0			0	0	0	0	NULL
218400	Mobilier	B	0	NULL	0	0			0			0	0	0	0	NULL
218820	Amortissement materiels de transport	B	0	NULL	0	0			0			0	0	0	0	NULL
231000	Immobilisation en cours	B	0	NULL	0	0			0			0	0	0	0	NULL
231500	Amenagement en cours	B	0	NULL	0	0			0			0	0	0	0	NULL
261000	Titres de participation	B	0	NULL	0	0			0			0	0	0	0	NULL
266000	Autres formes de participation	B	0	NULL	0	0			0			0	0	0	0	NULL
275000	Depots et cautionnements	B	0	NULL	0	0			0			0	0	0	0	NULL
281300	Amortissement construction	B	0	NULL	0	0			0			0	0	0	0	NULL
281400	Amortissement mobilier	B	0	NULL	0	0			0			0	0	0	0	NULL
281500	Amortissement materiel de bureau	B	0	NULL	0	0			0			0	0	0	0	NULL
281600	Amortissement materiel de transport	B	0	NULL	0	0			0			0	0	0	0	NULL
281700	Amortissement materiel informatique	B	0	NULL	0	0			0			0	0	0	0	NULL
335000	Travaux en cours	B	0	NULL	0	0			0			0	0	0	0	NULL
370000	Stock marchandises	B	0	NULL	0	0			0			0	0	0	0	NULL
397000	Provision depreciation stock	B	0	NULL	0	0			0			0	0	0	0	NULL
401000	Collectif fournisseur	B	1	NULL	1	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	0	0	NULL
401001	A Divers 	F	0	401000	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	1
401002	B Divers 	F	0	401000	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	1
401003	C Divers 	F	0	401000	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	1
401004	D Divers 	F	0	401000	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	1
401005	E Divers 	F	0	401000	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	1
401006	F Divers 	F	0	401000	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	1
401007	G Divers 	F	0	401000	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	1
401008	H Divers 	F	0	401000	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	1
401009	I Divers 	F	0	401000	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	1
401010	J Divers 	F	0	401000	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	1
401011	K Divers 	F	0	401000	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	1
401012	L Divers 	F	0	401000	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	1
401013	M Divers 	F	0	401000	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	1
401014	N Divers 	F	0	401000	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	1
401015	O Divers 	F	0	401000	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	1
401016	P Divers 	F	0	401000	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	1
401017	Q Divers 	F	0	401000	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	1
401018	R Divers 	F	0	401000	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	1
401019	S Divers 	F	0	401000	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	1
401020	T Divers 	F	0	401000	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	1
401021	U Divers 	F	0	401000	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	1
401022	V Divers 	F	0	401000	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	1
401023	W Divers 	F	0	401000	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	1
401024	X Divers 	F	0	401000	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	1
401025	Y Divers 	F	0	401000	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	1
401026	Z Divers 	F	0	401000	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	1
408000	Factures non parvenues	B	0	NULL	0	0			0			0	0	0	0	NULL
408100	Fournisseurs factures non parvenues	B	0	NULL	0	0			0			0	0	0	0	NULL
409600	Fourniseurs emballages a rendre	B	0	NULL	0	0			0			0	0	0	0	NULL
409700	Avoirs non parvenus	B	0	NULL	0	0			0			0	0	0	0	NULL
411000	Collectif client	B	1	NULL	1	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	0	0	NULL
411001	A Divers 	C	0	411000	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	1
411002	B Divers 	C	0	411000	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	1
411003	C Divers 	C	0	411000	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	1
411004	D Divers 	C	0	411000	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	1
411005	E Divers 	C	0	411000	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	1
411006	F Divers 	C	0	411000	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	1
411007	G Divers 	C	0	411000	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	1
411008	H Divers 	C	0	411000	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	1
411009	I Divers 	C	0	411000	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	1
411010	J Divers 	C	0	411000	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	1
411011	K Divers 	C	0	411000	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	1
411012	L Divers 	C	0	411000	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	1
411013	M Divers 	C	0	411000	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	1
411014	N Divers 	C	0	411000	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	1
411015	O Divers 	C	0	411000	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	1
411016	P Divers 	C	0	411000	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	1
411017	Q Divers 	C	0	411000	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	1
411018	R Divers 	C	0	411000	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	1
411019	S Divers 	C	0	411000	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	1
411020	T Divers 	C	0	411000	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	1
411021	U Divers 	C	0	411000	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	1
411022	V Divers 	C	0	411000	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	1
411023	W Divers 	C	0	411000	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	1
411024	X Divers 	C	0	411000	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	1
411025	Y Divers 	C	0	411000	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	1
411026	Z Divers 	C	0	411000	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	1
411027	********** Test **************	C	0	411000	0	0	NULL	NULL	0	NULL	NULL	0	0	0	NULL	1
416000	Clients douteux	B	0	NULL	0	0			0			0	0	0	0	NULL
419100	Clients avances et acomptes reçus	B	0	NULL	0	0	NULL	NULL	0	NULL	NULL	0	0	0	NULL	1
419700	Clients autres avoirs	B	0	NULL	0	0	NULL	NULL	0	NULL	NULL	0	0	0	NULL	1
421000	Remuneration employes	B	0	NULL	0	0			0			0	0	0	0	NULL
428200	Provisions conges payes	B	0	NULL	0	0			0			0	0	0	0	NULL
437100	Organismes sociaux	B	0	NULL	0	0			0			0	0	0	0	NULL
437200	Retraite employes	B	0	NULL	0	0			0			0	0	0	0	NULL
444000	Impots societes	B	0	NULL	0	0			0			0	0	0	0	NULL
445510	Tva a decaisser	B	0	NULL	0	0			0			0	0	0	0	NULL
445620	Tva deductible sur immobilisation	B	0	NULL	0	0			0			0	0	0	0	NULL
445660	Tva sur achat 2.10	B	0	NULL	1	0			0			0	0	0	0	NULL
445670	Tva sur achat 5.50	B	0	NULL	1	0			0			0	0	0	0	NULL
445680	Tva sur achat 19.60	B	0	NULL	1	0			0			0	0	0	0	NULL
445710	Tva sur ventes 2.10	B	0	NULL	1	0			0			0	0	0	0	NULL
445720	Tva sur ventes 5.50	B	0	NULL	1	0			0			0	0	0	0	NULL
445730	Tva sur ventes 19.60	B	0	NULL	1	0			0			0	0	0	0	NULL
468700	Débiteurs divers produits à recevoir	B	0	NULL	0	0	NULL	NULL	0	NULL	NULL	0	0	0	NULL	1
471000	Compte d'attente	B	0	NULL	0	0			0			0	0	0	0	NULL
491000	Provisions pour creances	B	0	NULL	0	0			0			0	0	0	0	NULL
512000	Banque	B	0	NULL	0	1			0			0	0	0	0	NULL
512001	Banque 2	B	0	NULL	0	1			0			0	0	0	0	NULL
518600	Interets courus	B	0	NULL	0	0			0			0	0	0	0	NULL
530000	Caisse	B	0	NULL	0	-1			0			0	0	0	0	NULL
580000	Virements internes	B	0	NULL	0	0			0			0	0	0	0	NULL
580001	Virements internes cartes	B	0	NULL	0	0			0			0	0	NULL	0	NULL
580002	Virements internes chèques	B	0	NULL	0	0			0			0	0	NULL	0	NULL
580003	Virements internes autres	B	0	NULL	0	0			0			0	0	NULL	0	NULL
602100	Matieres consommables	G	0	NULL	0	0			0			0	0	0	0	NULL
603700	Variations de stock	G	0	NULL	0	0			0			0	0	0	0	NULL
604000	Achats de sous-traitance	G	0	NULL	0	0			0			0	0	0	0	NULL
605000	Sous traitance	G	0	NULL	0	0			0	3	19.60	1	0	0	0	NULL
606100	Fournitures non stockables	G	0	NULL	0	0			0			0	0	0	0	NULL
606110	Electricite	G	0	NULL	0	0			0	3	19.60	1	0	0	0	NULL
606120	Gaz	G	0	NULL	0	0			0			0	0	0	0	NULL
606130	Eau, assainissement	G	0	NULL	0	0			0	3	19.60	1	0	0	0	NULL
606150	Carburant	G	0	NULL	0	0			0			0	0	0	0	NULL
606170	Gas-oil	G	0	NULL	0	0			0	3	19.60	1	0	0	0	NULL
606300	Fournitures entretien	G	0	NULL	0	0			0	3	19.60	1	0	0	0	NULL
606306	Petit outillage	G	0	NULL	0	0	NULL	NULL	0	3	19.60	1	0	NULL	0	NULL
606400	Fournitures administratives	G	0	NULL	0	0			0	3	19.60	1	0	0	0	NULL
606410	Fournitures informatiques	G	0	NULL	0	0			0	3	19.60	1	0	0	0	NULL
606800	Matieres consommables	G	0	NULL	0	0			0	3	19.60	1	0	0	0	NULL
606810	Produits entretien	G	0	NULL	0	0			0	3	19.60	1	0	0	0	NULL
607000	Achat de marchandises 2.10	G	0	NULL	0	0			0	1	2.10	1	0	0	0	NULL
607010	Achat de marchandises 7.00	G	0	NULL	0	0	NULL	NULL	0	2	5.50	1	0	0	0	NULL
607020	Achat de marchandises 20.00	G	0	NULL	0	0	NULL	NULL	0	3	19.60	1	0	0	0	NULL
609700	RRR obtenus	G	0	NULL	0	0			0			0	0	0	0	NULL
612200	Credit bail mobilier	G	0	NULL	0	0			0			0	0	0	0	NULL
613200	Locations immobiliers	G	0	NULL	0	0			0			0	0	0	0	NULL
622603	Centre agree de gestion	G	0	NULL	0	0			0	3	19.60	1	0	0	0	NULL
622604	Honoraires divers	G	0	NULL	0	0			0	3	19.60	1	0	0	0	NULL
622605	Comptable	G	0	NULL	0	0			0	3	19.60	1	0	0	0	NULL
622700	Frais actes et contentieux	G	0	NULL	0	0			0			0	0	0	0	NULL
623100	Annonces	G	0	NULL	0	0			0	3	19.60	1	0	0	0	NULL
623400	Cadeaux clientele	G	0	NULL	0	0			0	3	19.60	1	0	0	0	NULL
623700	Publicite	G	0	NULL	0	0			0	3	19.60	1	0	0	0	NULL
623705	Publicite exo	G	0	NULL	0	0			0			0	0	0	0	NULL
623800	Dons	G	0	NULL	0	0			0	3	19.60	1	0	0	0	NULL
625100	Voyages et deplacements	G	0	NULL	0	0			0	3	19.60	1	0	0	0	NULL
625500	Frais internet	G	0	NULL	0	0			0	3	19.60	1	0	0	0	NULL
625600	Missions	G	0	NULL	0	0			0	3	19.60	1	0	0	0	NULL
626100	Frais postaux	G	0	NULL	0	0			0			0	0	0	0	NULL
627000	Frais bancaires	G	0	NULL	0	0			0			0	0	0	0	NULL
627200	Frais/emis emprunt	G	0	NULL	0	0			0			0	0	0	0	NULL
627800	Frais factures	G	0	NULL	0	0			0	3	19.60	1	0	0	0	NULL
631200	Taxe apprentissage	G	0	NULL	0	0			0			0	0	0	0	NULL
633300	Participation employeur formation prof.	G	0	NULL	0	0			0			0	0	0	0	NULL
635110	Taxe professionnelle	G	0	NULL	0	0			0			0	0	0	0	NULL
635120	Taxe fonciere	G	0	NULL	0	0			0			0	0	0	0	NULL
635150	Taxes diveres	G	0	NULL	0	0			0			0	0	0	0	NULL
637100	Contibution sociale solidarite	G	0	NULL	0	0			0			0	0	0	0	NULL
637810	Csg deductible	G	0	NULL	0	0			0			0	0	0	0	NULL
637820	Csg non deductible	G	0	NULL	0	0			0			0	0	0	0	NULL
641100	Salaires bruts	G	0	NULL	0	0			0			0	0	0	0	NULL
641110	Salaires productifs	G	0	NULL	0	0			0			0	0	0	0	NULL
641200	Charges personnels conges payes	G	0	NULL	0	0			0			0	0	0	0	NULL
641400	Remboursement maladie	G	0	NULL	0	0			0			0	0	0	0	NULL
644000	Remuneration exploitant	G	0	NULL	0	0			0			0	0	0	0	NULL
645000	Charges SS et prevoyance	G	0	NULL	0	0			0			0	0	0	0	NULL
645320	Retraite employes	G	0	NULL	0	0			0			0	0	0	0	NULL
645500	Provisions charges conges	G	0	NULL	0	0			0			0	0	0	0	NULL
645800	Charges sociales	G	0	NULL	0	0			0			0	0	0	0	NULL
646200	Cotisations maladies	G	0	NULL	0	0			0			0	0	0	0	NULL
646210	Maladie complementaire	G	0	NULL	0	0			0			0	0	0	0	NULL
646300	Cotisations retraite	G	0	NULL	0	0			0			0	0	0	0	NULL
647500	Medecine du travail	G	0	NULL	0	0			0			0	0	0	0	NULL
654100	Pertes/créances irr. e.	G	0	NULL	0	0			0			0	0	0	0	NULL
658000	Charges diverses gestion	G	0	NULL	0	0			0			0	0	0	0	NULL
661100	Interets sur emprunts	G	0	NULL	0	0			0			0	0	0	0	NULL
671000	Charges exceptionnelles/Opération gesti	G	0	NULL	0	0			0			0	0	0	0	NULL
671800	Pertes stock	G	0	NULL	0	0			0			0	0	0	0	NULL
678000	Charges exceptionnelles	G	0	NULL	0	0			0			0	0	0	0	NULL
681120	Dotations amortissements	G	0	NULL	0	0			0			0	0	0	0	NULL
681730	Depreciation stock	G	0	NULL	0	0			0			0	0	0	0	NULL
695100	Impots sur les benefices	G	0	NULL	0	0			0			0	0	0	0	NULL
705000	Sous-traitance	G	0	NULL	0	0	3	20.00	1			0	0	0	0	NULL
706100	Ventes MO	G	0	NULL	0	0	3	20.00	1			0	0	0	0	NULL
706105	Prestations services 7.00	G	0	NULL	0	0	NULL	NULL	0	NULL	NULL	0	0	NULL	0	NULL
706110	Prestations services 20.00	G	0	NULL	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	NULL
707000	Ventes marchandises 2.10	G	0	NULL	0	0	1	2.10	1			0	0	0	0	NULL
707010	Ventes marchandises 7.00	G	0	NULL	0	0	2	7.00	1	NULL	NULL	0	0	0	0	NULL
707020	Ventes marchandises 20.00	G	0	NULL	0	0	3	20.00	1	NULL	NULL	0	0	0	0	NULL
709000	RRR accordes	G	0	NULL	0	0			0			0	0	0	0	NULL
709700	RRR accordés	G	0	NULL	0	0			0			0	0	0	0	NULL
722000	Production immobilisée	G	0	NULL	0	0			0			0	0	0	0	NULL
758000	Produits sur gestion courante	G	0	NULL	1	0			0			0	0	0	0	NULL
791000	Transferts charges	G	0	NULL	0	0			0			0	0	0	0	NULL
## Fiches_Depots (code	libelle	adr1	adr2	cp	ville)
01	Magasin				
02	Dépot 1				
## Fiches_Echeances (num	libell	duree	finmois	jours)
00	Comptant	00	0	00
01	30 jours fin de mois	30	1	00
02	30 jours le 5	30	0	05
03	30 jours le 10	30	0	10
04	30 jours le 15	30	0	15
05	30 jours le 20	30	0	20
06	30 jours le 25	30	0	25
07	30 jours	30	0	00
08	60 jours fin de mois	60	1	00
09	60 jours le 5	60	0	05
10	60 jours le 10	60	0	10
11	60 jours le 15	60	0	15
12	60 jours le 20	60	0	20
13	60 jours le 25	60	0	25
14	60 jours	60	0	00
15	45 jours	45	0	00
## Fiches_Etiquettes (code	nblargeur	nbhauteur	largeur	hauteur	mrghaut	mrgauche	esplargeur	esphauteur	libelle	page)
1	4	10	485	254	215	80	0	0	Article	A4 Portrait
2	2	8	1005	370	0	0	0	0	Gondole	A4 Portrait
3	2	8	1005	370	0	0	0	0	Client enveloppe	A4 Portrait
4	2	4	991	677	2	2	0	0	Client colis	A4 Portrait
5	1	1	250	250	0	0	0	0	Casier Dymo	A4 Portrait
## Fiches_Fam (code_fam	libell_fam	compt_fam	coef_fam	cdtva_fam	txtva_fam	cptrem_fam	ect_fam	rem_fam	qte1	qte2	rem1	qte3	qte4	rem2	qte5	qte6	rem3	qte7	qte8	rem4	qte9	qte10	rem5	qte11	qte12	rem6	compt2_fam	compt3_fam	compt4_fam	compt5_fam	export)
01	Produits 2.10	707000	2.200	1	2.1	709000	0	0	0	10	0	10.01	50	2	50.01	100	4	100.01	500	10	500.01	9999999.99	15	10000000	NULL	NULL	707000	606130	707010	707000	0
02	Produits 7.00	707010	2.000	2	7	709000	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	707010	NULL	NULL	707010	0
03	Produits 20.00	707020	1.800	3	20	709000	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	707020	NULL	NULL	707020	0
10	Mo 20.00	706100	2.000	3	20	709000	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	706100	NULL	NULL	706100	0
11	MO 7.00	706105	1.000	3	20	709000	0	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	706105	NULL	NULL	706105	0
## Fiches_FamDep (lind	fam	compte	depot)
1	01	707000	
## Fiches_Four (fo_code	fo_col	fo_rs_soc	fo_nom	fo_pnm	fo_adr1	fo_adr2	fo_cd_ptl	fo_ville	fo_email	fo_tel_std	fo_tel_bur	fo_tel_post	fo_pble	fo_fx1	fo_fx2	fo_plaf_ecrs	fo_obs	fo_cd_bq	fo_cd_gch	fo_cle_rib	fo_num_cpt	fo_dom	fo_id_tva	fo_cd_soc	fo_site	fo_cd_cli	fo_co_vtl	fo_collectif	fo_cdech	fo_pays	fo_franco	fo_centrale	fo_cnt1	fo_cnt2	fo_cnt3	fo_cnt4	fo_cnt5	fo_cnt6	fo_cnt7	fo_cnt8	fo_cnt9	fo_cnt10	fo_cnt11	fo_cnt12	fo_cnt13	fo_cnt14	fo_cnt15	fo_ccentrale	fo_copie	fo_mincom	fo_iban	fo_bic	fo_exo	fo_fport	fo_cb	libel_def	tag_def)
401001	F	NULL	A Divers 	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	401000	00	NULL	0.00	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	0.00	NULL	NULL	NULL	NULL	NULL	NULL	NULL
401002	F	NULL	B Divers 	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	401000	00	NULL	0.00	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	0.00	NULL	NULL	NULL	NULL	NULL	NULL	NULL
401003	F	NULL	C Divers 	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	401000	00	NULL	0.00	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
401004	F	NULL	D Divers 	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	401000	00	NULL	0.00	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	0.00	NULL	NULL	0	NULL	NULL	NULL	NULL
401005	F	NULL	E Divers 	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	401000	00	NULL	0.00	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
401006	F	NULL	F Divers 	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	401000	00	NULL	0.00	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
401007	F	NULL	G Divers 	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	401000	00	NULL	0.00	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
401008	F	NULL	H Divers 	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	401000	00	NULL	0.00	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
401009	F	NULL	I Divers 	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	401000	00	NULL	0.00	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
401010	F	NULL	J Divers 	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	401000	00	NULL	0.00	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
401011	F	NULL	K Divers 	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	401000	00	NULL	0.00	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
401012	F	NULL	L Divers 	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	401000	00	NULL	0.00	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
401013	F	NULL	M Divers 	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	401000	00	NULL	0.00	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
401014	F	NULL	N Divers 	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	401000	00	NULL	0.00	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
401015	F	NULL	O Divers 	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	401000	00	NULL	0.00	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
401016	F		P Divers 													NULL								NULL			NULL	401000	00		0.00	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL		0	0.00			0	0.00		NULL	NULL
401017	F	NULL	Q Divers 	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	401000	00	NULL	0.00	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
401018	F	NULL	R Divers 	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	401000	00	NULL	0.00	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
401019	F	NULL	S Divers 	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	401000	00	NULL	0.00	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
401020	F	NULL	T Divers 	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	401000	00	NULL	0.00	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
401021	F	NULL	U Divers 	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	401000	00	NULL	0.00	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
401022	F	NULL	V Divers 	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	401000	00	NULL	0.00	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
401023	F		W Divers 													NULL								NULL			NULL	401000	00		0.00	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL		0	0.00			0	0.00		NULL	NULL
401024	F	NULL	X Divers 	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	401000	00	NULL	0.00	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
401025	F	NULL	Y Divers 	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	401000	00	NULL	0.00	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
401026	F	NULL	Z Divers 	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	401000	00	NULL	0.00	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
## Fiches_Four_Vtl (code	code_vtl	intitule_vtl)
401001	607000	Achat de marchandises
## Fiches_Identite (code	libelle)
01	SARL
02	EARL
03	SA
04	EURL
05	SNC
06	SE
07	M.
08	Mme
09	Mme et M.
10	Gaec
11	CI
12	GIE
13	SAS
14	SASU
15	SCI
16	SCM
17	SCOP
18	SCP
19	SEL
20	SDF
21	SCS
22	SELARL
23	SEP
## Fiches_Journaux (code_jo	libelle_jo	type_jo	cde_banque)
10	OD	OD	
50	Banque	TR	512000
53	Caisse	TR	530000
60	Achat	AC	
70	Ventes	VE	
90	A nouveaux	OD	
## Fiches_LibelFac (mind	txtfac)

1	
## Fiches_Libelles (num	intitule)
1	Facture
2	Avoir
3	Cheque
4	Carte
## Fiches_Mo (mo_code	mo_design	mo_fam	mo_four	mo_txcd	mo_txht	mo_tva	mo_tempmont	mo_montant	mo_valeurht	mo_cdarr	mo_valeurttc	mo_prvt	mo_marge	mo_impcar	mo_crst)
01	Mo T1	10	401001	1	28	3	1	1	0	0,01	0	14.000	14.000	NULL	NULL
02	Mo T2	10	401001	2	31	3	1	1	0	0,01	0	15.000	16.000	NULL	NULL
03	Mo T3	10	401001	3	35	3	1	1	0	0,01	0	18.000	17.000	NULL	NULL
04	Forfait changement poulie	10	401001	1	28	3	0	NULL	35	0,01	42	14.000	0.000	0	NULL
05	Changement poulie	10	401001	1	28	3	1	1.2	NULL	0,01	NULL	14.000	16.800	0	NULL
## Fiches_Mvt (jour	numero	numerodef	compte	collectif	intitule	dte	datee	dateech	numcol	numdoc	numlot	libelle	montantd	montantc	validee	provisoire	tresorerie	pointee	nrlv	lettree	cloturee	relance	lind	dteval	export	control)
51	10	10	401010	0	Perf 401010	2018-04-08 00:00:00	NULL	NULL	NULL	P10	NULL	Perf 10	343.17	0.00	1	0	0	0	NULL	0	0	NULL	19	NULL	NULL	NULL
51	10	10	512000	0	Perf 512000	2018-04-08 00:00:00	NULL	NULL	NULL	P10	NULL	Perf 10	0.00	343.17	1	0	0	0	NULL	0	0	NULL	20	NULL	NULL	NULL
51	100	100	401022	0	Perf 401022	2018-04-22 00:00:00	NULL	NULL	NULL	P100	NULL	Perf 100	703.87	0.00	1	0	0	0	NULL	0	0	NULL	199	NULL	NULL	NULL
51	100	100	512000	0	Perf 512000	2018-04-22 00:00:00	NULL	NULL	NULL	P100	NULL	Perf 100	0.00	703.87	1	0	0	0	NULL	0	0	NULL	200	NULL	NULL	NULL
51	105	105	411024	0	Perf 411024	2018-03-01 00:00:00	NULL	NULL	NULL	P105	NULL	Perf 105	0.00	888.52	1	0	0	0	NULL	0	0	NULL	210	NULL	NULL	NULL
51	105	105	530000	0	Perf 530000	2018-03-01 00:00:00	NULL	NULL	NULL	P105	NULL	Perf 105	888.52	0.00	1	0	0	0	NULL	0	0	NULL	209	NULL	NULL	NULL
51	106	106	401002	0	Perf 401002	2018-04-08 00:00:00	NULL	NULL	NULL	P106	NULL	Perf 106	925.65	0.00	1	0	0	0	NULL	0	0	NULL	211	NULL	NULL	NULL
51	106	106	512000	0	Perf 512000	2018-04-08 00:00:00	NULL	NULL	NULL	P106	NULL	Perf 106	0.00	925.65	1	0	0	0	NULL	0	0	NULL	212	NULL	NULL	NULL
51	111	111	411003	0	Perf 411003	2018-03-15 00:00:00	NULL	NULL	NULL	P111	NULL	Perf 111	0.00	120.30	1	0	0	0	NULL	0	0	NULL	222	NULL	NULL	NULL
51	111	111	530000	0	Perf 530000	2018-03-15 00:00:00	NULL	NULL	NULL	P111	NULL	Perf 111	120.30	0.00	1	0	0	0	NULL	0	0	NULL	221	NULL	NULL	NULL
51	112	112	401008	0	Perf 401008	2018-04-22 00:00:00	NULL	NULL	NULL	P112	NULL	Perf 112	157.43	0.00	1	0	0	0	NULL	0	0	NULL	223	NULL	NULL	NULL
51	112	112	512000	0	Perf 512000	2018-04-22 00:00:00	NULL	NULL	NULL	P112	NULL	Perf 112	0.00	157.43	1	0	0	0	NULL	0	0	NULL	224	NULL	NULL	NULL
51	117	117	411009	0	Perf 411009	2018-03-01 00:00:00	NULL	NULL	NULL	P117	NULL	Perf 117	0.00	342.08	1	0	0	0	NULL	0	0	NULL	234	NULL	NULL	NULL
51	117	117	530000	0	Perf 530000	2018-03-01 00:00:00	NULL	NULL	NULL	P117	NULL	Perf 117	342.08	0.00	1	0	0	0	NULL	0	0	NULL	233	NULL	NULL	NULL
51	118	118	401014	0	Perf 401014	2018-04-08 00:00:00	NULL	NULL	NULL	P118	NULL	Perf 118	379.21	0.00	1	0	0	0	NULL	0	0	NULL	235	NULL	NULL	NULL
51	118	118	512000	0	Perf 512000	2018-04-08 00:00:00	NULL	NULL	NULL	P118	NULL	Perf 118	0.00	379.21	1	0	0	0	NULL	0	0	NULL	236	NULL	NULL	NULL
51	123	123	411015	0	Perf 411015	2018-03-15 00:00:00	NULL	NULL	NULL	P123	NULL	Perf 123	0.00	564.86	1	0	0	0	NULL	0	0	NULL	246	NULL	NULL	NULL
51	123	123	530000	0	Perf 530000	2018-03-15 00:00:00	NULL	NULL	NULL	P123	NULL	Perf 123	564.86	0.00	1	0	0	0	NULL	0	0	NULL	245	NULL	NULL	NULL
51	124	124	401020	0	Perf 401020	2018-04-22 00:00:00	NULL	NULL	NULL	P124	NULL	Perf 124	601.99	0.00	1	0	0	0	NULL	0	0	NULL	247	NULL	NULL	NULL
51	124	124	512000	0	Perf 512000	2018-04-22 00:00:00	NULL	NULL	NULL	P124	NULL	Perf 124	0.00	601.99	1	0	0	0	NULL	0	0	NULL	248	NULL	NULL	NULL
51	129	129	411021	0	Perf 411021	2018-03-01 00:00:00	NULL	NULL	NULL	P129	NULL	Perf 129	0.00	786.64	1	0	0	0	NULL	0	0	NULL	258	NULL	NULL	NULL
51	129	129	530000	0	Perf 530000	2018-03-01 00:00:00	NULL	NULL	NULL	P129	NULL	Perf 129	786.64	0.00	1	0	0	0	NULL	0	0	NULL	257	NULL	NULL	NULL
51	130	130	401026	0	Perf 401026	2018-04-08 00:00:00	NULL	NULL	NULL	P130	NULL	Perf 130	823.77	0.00	1	0	0	0	NULL	0	0	NULL	259	NULL	NULL	NULL
51	130	130	512000	0	Perf 512000	2018-04-08 00:00:00	NULL	NULL	NULL	P130	NULL	Perf 130	0.00	823.77	1	0	0	0	NULL	0	0	NULL	260	NULL	NULL	NULL
51	135	135	411027	0	Perf 411027	2018-03-15 00:00:00	NULL	NULL	NULL	P135	NULL	Perf 135	0.00	18.42	1	0	0	0	NULL	0	0	NULL	270	NULL	NULL	NULL
51	135	135	530000	0	Perf 530000	2018-03-15 00:00:00	NULL	NULL	NULL	P135	NULL	Perf 135	18.42	0.00	1	0	0	0	NULL	0	0	NULL	269	NULL	NULL	NULL
51	136	136	401006	0	Perf 401006	2018-04-22 00:00:00	NULL	NULL	NULL	P136	NULL	Perf 136	55.55	0.00	1	0	0	0	NULL	0	0	NULL	271	NULL	NULL	NULL
51	136	136	512000	0	Perf 512000	2018-04-22 00:00:00	NULL	NULL	NULL	P136	NULL	Perf 136	0.00	55.55	1	0	0	0	NULL	0	0	NULL	272	NULL	NULL	NULL
51	141	141	411006	0	Perf 411006	2018-03-01 00:00:00	NULL	NULL	NULL	P141	NULL	Perf 141	0.00	240.20	1	0	0	0	NULL	0	0	NULL	282	NULL	NULL	NULL
51	141	141	530000	0	Perf 530000	2018-03-01 00:00:00	NULL	NULL	NULL	P141	NULL	Perf 141	240.20	0.00	1	0	0	0	NULL	0	0	NULL	281	NULL	NULL	NULL
51	142	142	401012	0	Perf 401012	2018-04-08 00:00:00	NULL	NULL	NULL	P142	NULL	Perf 142	277.33	0.00	1	0	0	0	NULL	0	0	NULL	283	NULL	NULL	NULL
51	142	142	512000	0	Perf 512000	2018-04-08 00:00:00	NULL	NULL	NULL	P142	NULL	Perf 142	0.00	277.33	1	0	0	0	NULL	0	0	NULL	284	NULL	NULL	NULL
51	147	147	411012	0	Perf 411012	2018-03-15 00:00:00	NULL	NULL	NULL	P147	NULL	Perf 147	0.00	462.98	1	0	0	0	NULL	0	0	NULL	294	NULL	NULL	NULL
51	147	147	530000	0	Perf 530000	2018-03-15 00:00:00	NULL	NULL	NULL	P147	NULL	Perf 147	462.98	0.00	1	0	0	0	NULL	0	0	NULL	293	NULL	NULL	NULL
51	148	148	401018	0	Perf 401018	2018-04-22 00:00:00	NULL	NULL	NULL	P148	NULL	Perf 148	499.11	0.00	1	0	0	0	NULL	0	0	NULL	295	NULL	NULL	NULL
51	148	148	512000	0	Perf 512000	2018-04-22 00:00:00	NULL	NULL	NULL	P148	NULL	Perf 148	0.00	499.11	1	0	0	0	NULL	0	0	NULL	296	NULL	NULL	NULL
51	15	15	411015	0	Perf 411015	2018-03-15 00:00:00	NULL	NULL	NULL	P15	NULL	Perf 15	0.00	528.82	1	0	0	0	NULL	0	0	NULL	30	NULL	NULL	NULL
51	15	15	530000	0	Perf 530000	2018-03-15 00:00:00	NULL	NULL	NULL	P15	NULL	Perf 15	528.82	0.00	1	0	0	0	NULL	0	0	NULL	29	NULL	NULL	NULL
51	153	153	411018	0	Perf 411018	2018-03-01 00:00:00	NULL	NULL	NULL	P153	NULL	Perf 153	0.00	684.76	1	0	0	0	NULL	0	0	NULL	306	NULL	NULL	NULL
51	153	153	530000	0	Perf 530000	2018-03-01 00:00:00	NULL	NULL	NULL	P153	NULL	Perf 153	684.76	0.00	1	0	0	0	NULL	0	0	NULL	305	NULL	NULL	NULL
51	154	154	401024	0	Perf 401024	2018-04-08 00:00:00	NULL	NULL	NULL	P154	NULL	Perf 154	721.89	0.00	1	0	0	0	NULL	0	0	NULL	307	NULL	NULL	NULL
51	154	154	512000	0	Perf 512000	2018-04-08 00:00:00	NULL	NULL	NULL	P154	NULL	Perf 154	0.00	721.89	1	0	0	0	NULL	0	0	NULL	308	NULL	NULL	NULL
51	159	159	411024	0	Perf 411024	2018-03-15 00:00:00	NULL	NULL	NULL	P159	NULL	Perf 159	0.00	906.54	1	0	0	0	NULL	0	0	NULL	318	NULL	NULL	NULL
51	159	159	530000	0	Perf 530000	2018-03-15 00:00:00	NULL	NULL	NULL	P159	NULL	Perf 159	906.54	0.00	1	0	0	0	NULL	0	0	NULL	317	NULL	NULL	NULL
51	16	16	401016	0	Perf 401016	2018-04-22 00:00:00	NULL	NULL	NULL	P16	NULL	Perf 16	565.95	0.00	1	0	0	0	NULL	0	0	NULL	31	NULL	NULL	NULL
51	16	16	512000	0	Perf 512000	2018-04-22 00:00:00	NULL	NULL	NULL	P16	NULL	Perf 16	0.00	565.95	1	0	0	0	NULL	0	0	NULL	32	NULL	NULL	NULL
51	160	160	401004	0	Perf 401004	2018-04-22 00:00:00	NULL	NULL	NULL	P160	NULL	Perf 160	943.67	0.00	1	0	0	0	NULL	0	0	NULL	319	NULL	NULL	NULL
51	160	160	512000	0	Perf 512000	2018-04-22 00:00:00	NULL	NULL	NULL	P160	NULL	Perf 160	0.00	943.67	1	0	0	0	NULL	0	0	NULL	320	NULL	NULL	NULL
51	165	165	411003	0	Perf 411003	2018-03-01 00:00:00	NULL	NULL	NULL	P165	NULL	Perf 165	0.00	138.32	1	0	0	0	NULL	0	0	NULL	330	NULL	NULL	NULL
51	165	165	530000	0	Perf 530000	2018-03-01 00:00:00	NULL	NULL	NULL	P165	NULL	Perf 165	138.32	0.00	1	0	0	0	NULL	0	0	NULL	329	NULL	NULL	NULL
51	166	166	401010	0	Perf 401010	2018-04-08 00:00:00	NULL	NULL	NULL	P166	NULL	Perf 166	175.45	0.00	1	0	0	0	NULL	0	0	NULL	331	NULL	NULL	NULL
51	166	166	512000	0	Perf 512000	2018-04-08 00:00:00	NULL	NULL	NULL	P166	NULL	Perf 166	0.00	175.45	1	0	0	0	NULL	0	0	NULL	332	NULL	NULL	NULL
51	171	171	411009	0	Perf 411009	2018-03-15 00:00:00	NULL	NULL	NULL	P171	NULL	Perf 171	0.00	360.10	1	0	0	0	NULL	0	0	NULL	342	NULL	NULL	NULL
51	171	171	530000	0	Perf 530000	2018-03-15 00:00:00	NULL	NULL	NULL	P171	NULL	Perf 171	360.10	0.00	1	0	0	0	NULL	0	0	NULL	341	NULL	NULL	NULL
51	172	172	401016	0	Perf 401016	2018-04-22 00:00:00	NULL	NULL	NULL	P172	NULL	Perf 172	397.23	0.00	1	0	0	0	NULL	0	0	NULL	343	NULL	NULL	NULL
51	172	172	512000	0	Perf 512000	2018-04-22 00:00:00	NULL	NULL	NULL	P172	NULL	Perf 172	0.00	397.23	1	0	0	0	NULL	0	0	NULL	344	NULL	NULL	NULL
51	177	177	411015	0	Perf 411015	2018-03-01 00:00:00	NULL	NULL	NULL	P177	NULL	Perf 177	0.00	582.88	1	0	0	0	NULL	0	0	NULL	354	NULL	NULL	NULL
51	177	177	530000	0	Perf 530000	2018-03-01 00:00:00	NULL	NULL	NULL	P177	NULL	Perf 177	582.88	0.00	1	0	0	0	NULL	0	0	NULL	353	NULL	NULL	NULL
51	178	178	401022	0	Perf 401022	2018-04-08 00:00:00	NULL	NULL	NULL	P178	NULL	Perf 178	619.01	0.00	1	0	0	0	NULL	0	0	NULL	355	NULL	NULL	NULL
51	178	178	512000	0	Perf 512000	2018-04-08 00:00:00	NULL	NULL	NULL	P178	NULL	Perf 178	0.00	619.01	1	0	0	0	NULL	0	0	NULL	356	NULL	NULL	NULL
51	183	183	411021	0	Perf 411021	2018-03-15 00:00:00	NULL	NULL	NULL	P183	NULL	Perf 183	0.00	804.66	1	0	0	0	NULL	0	0	NULL	366	NULL	NULL	NULL
51	183	183	530000	0	Perf 530000	2018-03-15 00:00:00	NULL	NULL	NULL	P183	NULL	Perf 183	804.66	0.00	1	0	0	0	NULL	0	0	NULL	365	NULL	NULL	NULL
51	184	184	401002	0	Perf 401002	2018-04-22 00:00:00	NULL	NULL	NULL	P184	NULL	Perf 184	841.79	0.00	1	0	0	0	NULL	0	0	NULL	367	NULL	NULL	NULL
51	184	184	512000	0	Perf 512000	2018-04-22 00:00:00	NULL	NULL	NULL	P184	NULL	Perf 184	0.00	841.79	1	0	0	0	NULL	0	0	NULL	368	NULL	NULL	NULL
51	189	189	411027	0	Perf 411027	2018-03-01 00:00:00	NULL	NULL	NULL	P189	NULL	Perf 189	0.00	36.44	1	0	0	0	NULL	0	0	NULL	378	NULL	NULL	NULL
51	189	189	530000	0	Perf 530000	2018-03-01 00:00:00	NULL	NULL	NULL	P189	NULL	Perf 189	36.44	0.00	1	0	0	0	NULL	0	0	NULL	377	NULL	NULL	NULL
51	190	190	401008	0	Perf 401008	2018-04-08 00:00:00	NULL	NULL	NULL	P190	NULL	Perf 190	73.57	0.00	1	0	0	0	NULL	0	0	NULL	379	NULL	NULL	NULL
51	190	190	512000	0	Perf 512000	2018-04-08 00:00:00	NULL	NULL	NULL	P190	NULL	Perf 190	0.00	73.57	1	0	0	0	NULL	0	0	NULL	380	NULL	NULL	NULL
51	195	195	411006	0	Perf 411006	2018-03-15 00:00:00	NULL	NULL	NULL	P195	NULL	Perf 195	0.00	258.22	1	0	0	0	NULL	0	0	NULL	390	NULL	NULL	NULL
51	195	195	530000	0	Perf 530000	2018-03-15 00:00:00	NULL	NULL	NULL	P195	NULL	Perf 195	258.22	0.00	1	0	0	0	NULL	0	0	NULL	389	NULL	NULL	NULL
51	196	196	401014	0	Perf 401014	2018-04-22 00:00:00	NULL	NULL	NULL	P196	NULL	Perf 196	295.35	0.00	1	0	0	0	NULL	0	0	NULL	391	NULL	NULL	NULL
51	196	196	512000	0	Perf 512000	2018-04-22 00:00:00	NULL	NULL	NULL	P196	NULL	Perf 196	0.00	295.35	1	0	0	0	NULL	0	0	NULL	392	NULL	NULL	NULL
51	201	201	411012	0	Perf 411012	2018-03-01 00:00:00	NULL	NULL	NULL	P201	NULL	Perf 201	0.00	480.00	1	0	0	0	NULL	0	0	NULL	402	NULL	NULL	NULL
51	201	201	530000	0	Perf 530000	2018-03-01 00:00:00	NULL	NULL	NULL	P201	NULL	Perf 201	480.00	0.00	1	0	0	0	NULL	0	0	NULL	401	NULL	NULL	NULL
51	202	202	401020	0	Perf 401020	2018-04-08 00:00:00	NULL	NULL	NULL	P202	NULL	Perf 202	517.13	0.00	1	0	0	0	NULL	0	0	NULL	403	NULL	NULL	NULL
51	202	202	512000	0	Perf 512000	2018-04-08 00:00:00	NULL	NULL	NULL	P202	NULL	Perf 202	0.00	517.13	1	0	0	0	NULL	0	0	NULL	404	NULL	NULL	NULL
51	207	207	411018	0	Perf 411018	2018-03-15 00:00:00	NULL	NULL	NULL	P207	NULL	Perf 207	0.00	702.78	1	0	0	0	NULL	0	0	NULL	414	NULL	NULL	NULL
51	207	207	530000	0	Perf 530000	2018-03-15 00:00:00	NULL	NULL	NULL	P207	NULL	Perf 207	702.78	0.00	1	0	0	0	NULL	0	0	NULL	413	NULL	NULL	NULL
51	208	208	401026	0	Perf 401026	2018-04-22 00:00:00	NULL	NULL	NULL	P208	NULL	Perf 208	739.91	0.00	1	0	0	0	NULL	0	0	NULL	415	NULL	NULL	NULL
51	208	208	512000	0	Perf 512000	2018-04-22 00:00:00	NULL	NULL	NULL	P208	NULL	Perf 208	0.00	739.91	1	0	0	0	NULL	0	0	NULL	416	NULL	NULL	NULL
51	21	21	411021	0	Perf 411021	2018-03-01 00:00:00	NULL	NULL	NULL	P21	NULL	Perf 21	0.00	750.60	1	0	0	0	NULL	0	0	NULL	42	NULL	NULL	NULL
51	21	21	530000	0	Perf 530000	2018-03-01 00:00:00	NULL	NULL	NULL	P21	NULL	Perf 21	750.60	0.00	1	0	0	0	NULL	0	0	NULL	41	NULL	NULL	NULL
51	213	213	411024	0	Perf 411024	2018-03-01 00:00:00	NULL	NULL	NULL	P213	NULL	Perf 213	0.00	924.56	1	0	0	0	NULL	0	0	NULL	426	NULL	NULL	NULL
51	213	213	530000	0	Perf 530000	2018-03-01 00:00:00	NULL	NULL	NULL	P213	NULL	Perf 213	924.56	0.00	1	0	0	0	NULL	0	0	NULL	425	NULL	NULL	NULL
51	214	214	401006	0	Perf 401006	2018-04-08 00:00:00	NULL	NULL	NULL	P214	NULL	Perf 214	961.69	0.00	1	0	0	0	NULL	0	0	NULL	427	NULL	NULL	NULL
51	214	214	512000	0	Perf 512000	2018-04-08 00:00:00	NULL	NULL	NULL	P214	NULL	Perf 214	0.00	961.69	1	0	0	0	NULL	0	0	NULL	428	NULL	NULL	NULL
51	219	219	411003	0	Perf 411003	2018-03-15 00:00:00	NULL	NULL	NULL	P219	NULL	Perf 219	0.00	156.34	1	0	0	0	NULL	0	0	NULL	438	NULL	NULL	NULL
51	219	219	530000	0	Perf 530000	2018-03-15 00:00:00	NULL	NULL	NULL	P219	NULL	Perf 219	156.34	0.00	1	0	0	0	NULL	0	0	NULL	437	NULL	NULL	NULL
51	22	22	401022	0	Perf 401022	2018-04-08 00:00:00	NULL	NULL	NULL	P22	NULL	Perf 22	787.73	0.00	1	0	0	0	NULL	0	0	NULL	43	NULL	NULL	NULL
51	22	22	512000	0	Perf 512000	2018-04-08 00:00:00	NULL	NULL	NULL	P22	NULL	Perf 22	0.00	787.73	1	0	0	0	NULL	0	0	NULL	44	NULL	NULL	NULL
51	220	220	401012	0	Perf 401012	2018-04-22 00:00:00	NULL	NULL	NULL	P220	NULL	Perf 220	193.47	0.00	1	0	0	0	NULL	0	0	NULL	439	NULL	NULL	NULL
51	220	220	512000	0	Perf 512000	2018-04-22 00:00:00	NULL	NULL	NULL	P220	NULL	Perf 220	0.00	193.47	1	0	0	0	NULL	0	0	NULL	440	NULL	NULL	NULL
51	225	225	411009	0	Perf 411009	2018-03-01 00:00:00	NULL	NULL	NULL	P225	NULL	Perf 225	0.00	378.12	1	0	0	0	NULL	0	0	NULL	450	NULL	NULL	NULL
51	225	225	530000	0	Perf 530000	2018-03-01 00:00:00	NULL	NULL	NULL	P225	NULL	Perf 225	378.12	0.00	1	0	0	0	NULL	0	0	NULL	449	NULL	NULL	NULL
51	226	226	401018	0	Perf 401018	2018-04-08 00:00:00	NULL	NULL	NULL	P226	NULL	Perf 226	415.25	0.00	1	0	0	0	NULL	0	0	NULL	451	NULL	NULL	NULL
51	226	226	512000	0	Perf 512000	2018-04-08 00:00:00	NULL	NULL	NULL	P226	NULL	Perf 226	0.00	415.25	1	0	0	0	NULL	0	0	NULL	452	NULL	NULL	NULL
51	231	231	411015	0	Perf 411015	2018-03-15 00:00:00	NULL	NULL	NULL	P231	NULL	Perf 231	0.00	600.90	1	0	0	0	NULL	0	0	NULL	462	NULL	NULL	NULL
51	231	231	530000	0	Perf 530000	2018-03-15 00:00:00	NULL	NULL	NULL	P231	NULL	Perf 231	600.90	0.00	1	0	0	0	NULL	0	0	NULL	461	NULL	NULL	NULL
51	232	232	401024	0	Perf 401024	2018-04-22 00:00:00	NULL	NULL	NULL	P232	NULL	Perf 232	637.03	0.00	1	0	0	0	NULL	0	0	NULL	463	NULL	NULL	NULL
51	232	232	512000	0	Perf 512000	2018-04-22 00:00:00	NULL	NULL	NULL	P232	NULL	Perf 232	0.00	637.03	1	0	0	0	NULL	0	0	NULL	464	NULL	NULL	NULL
51	237	237	411021	0	Perf 411021	2018-03-01 00:00:00	NULL	NULL	NULL	P237	NULL	Perf 237	0.00	822.68	1	0	0	0	NULL	0	0	NULL	474	NULL	NULL	NULL
51	237	237	530000	0	Perf 530000	2018-03-01 00:00:00	NULL	NULL	NULL	P237	NULL	Perf 237	822.68	0.00	1	0	0	0	NULL	0	0	NULL	473	NULL	NULL	NULL
51	238	238	401004	0	Perf 401004	2018-04-08 00:00:00	NULL	NULL	NULL	P238	NULL	Perf 238	859.81	0.00	1	0	0	0	NULL	0	0	NULL	475	NULL	NULL	NULL
51	238	238	512000	0	Perf 512000	2018-04-08 00:00:00	NULL	NULL	NULL	P238	NULL	Perf 238	0.00	859.81	1	0	0	0	NULL	0	0	NULL	476	NULL	NULL	NULL
51	243	243	411027	0	Perf 411027	2018-03-15 00:00:00	NULL	NULL	NULL	P243	NULL	Perf 243	0.00	54.46	1	0	0	0	NULL	0	0	NULL	486	NULL	NULL	NULL
51	243	243	530000	0	Perf 530000	2018-03-15 00:00:00	NULL	NULL	NULL	P243	NULL	Perf 243	54.46	0.00	1	0	0	0	NULL	0	0	NULL	485	NULL	NULL	NULL
51	244	244	401010	0	Perf 401010	2018-04-22 00:00:00	NULL	NULL	NULL	P244	NULL	Perf 244	91.59	0.00	1	0	0	0	NULL	0	0	NULL	487	NULL	NULL	NULL
51	244	244	512000	0	Perf 512000	2018-04-22 00:00:00	NULL	NULL	NULL	P244	NULL	Perf 244	0.00	91.59	1	0	0	0	NULL	0	0	NULL	488	NULL	NULL	NULL
51	249	249	411006	0	Perf 411006	2018-03-01 00:00:00	NULL	NULL	NULL	P249	NULL	Perf 249	0.00	276.24	1	0	0	0	NULL	0	0	NULL	498	NULL	NULL	NULL
51	249	249	530000	0	Perf 530000	2018-03-01 00:00:00	NULL	NULL	NULL	P249	NULL	Perf 249	276.24	0.00	1	0	0	0	NULL	0	0	NULL	497	NULL	NULL	NULL
51	250	250	401016	0	Perf 401016	2018-04-08 00:00:00	NULL	NULL	NULL	P250	NULL	Perf 250	313.37	0.00	1	0	0	0	NULL	0	0	NULL	499	NULL	NULL	NULL
51	250	250	512000	0	Perf 512000	2018-04-08 00:00:00	NULL	NULL	NULL	P250	NULL	Perf 250	0.00	313.37	1	0	0	0	NULL	0	0	NULL	500	NULL	NULL	NULL
51	255	255	411012	0	Perf 411012	2018-03-15 00:00:00	NULL	NULL	NULL	P255	NULL	Perf 255	0.00	498.02	1	0	0	0	NULL	0	0	NULL	510	NULL	NULL	NULL
51	255	255	530000	0	Perf 530000	2018-03-15 00:00:00	NULL	NULL	NULL	P255	NULL	Perf 255	498.02	0.00	1	0	0	0	NULL	0	0	NULL	509	NULL	NULL	NULL
51	256	256	401022	0	Perf 401022	2018-04-22 00:00:00	NULL	NULL	NULL	P256	NULL	Perf 256	535.15	0.00	1	0	0	0	NULL	0	0	NULL	511	NULL	NULL	NULL
51	256	256	512000	0	Perf 512000	2018-04-22 00:00:00	NULL	NULL	NULL	P256	NULL	Perf 256	0.00	535.15	1	0	0	0	NULL	0	0	NULL	512	NULL	NULL	NULL
51	261	261	411018	0	Perf 411018	2018-03-01 00:00:00	NULL	NULL	NULL	P261	NULL	Perf 261	0.00	720.80	1	0	0	0	NULL	0	0	NULL	522	NULL	NULL	NULL
51	261	261	530000	0	Perf 530000	2018-03-01 00:00:00	NULL	NULL	NULL	P261	NULL	Perf 261	720.80	0.00	1	0	0	0	NULL	0	0	NULL	521	NULL	NULL	NULL
51	262	262	401002	0	Perf 401002	2018-04-08 00:00:00	NULL	NULL	NULL	P262	NULL	Perf 262	757.93	0.00	1	0	0	0	NULL	0	0	NULL	523	NULL	NULL	NULL
51	262	262	512000	0	Perf 512000	2018-04-08 00:00:00	NULL	NULL	NULL	P262	NULL	Perf 262	0.00	757.93	1	0	0	0	NULL	0	0	NULL	524	NULL	NULL	NULL
51	267	267	411024	0	Perf 411024	2018-03-15 00:00:00	NULL	NULL	NULL	P267	NULL	Perf 267	0.00	942.58	1	0	0	0	NULL	0	0	NULL	534	NULL	NULL	NULL
51	267	267	530000	0	Perf 530000	2018-03-15 00:00:00	NULL	NULL	NULL	P267	NULL	Perf 267	942.58	0.00	1	0	0	0	NULL	0	0	NULL	533	NULL	NULL	NULL
51	268	268	401008	0	Perf 401008	2018-04-22 00:00:00	NULL	NULL	NULL	P268	NULL	Perf 268	979.71	0.00	1	0	0	0	NULL	0	0	NULL	535	NULL	NULL	NULL
51	268	268	512000	0	Perf 512000	2018-04-22 00:00:00	NULL	NULL	NULL	P268	NULL	Perf 268	0.00	979.71	1	0	0	0	NULL	0	0	NULL	536	NULL	NULL	NULL
51	27	27	411027	0	Perf 411027	2018-03-15 00:00:00	NULL	NULL	NULL	P27	NULL	Perf 27	0.00	972.38	1	0	0	0	NULL	0	0	NULL	54	NULL	NULL	NULL
51	27	27	530000	0	Perf 530000	2018-03-15 00:00:00	NULL	NULL	NULL	P27	NULL	Perf 27	972.38	0.00	1	0	0	0	NULL	0	0	NULL	53	NULL	NULL	NULL
51	273	273	411003	0	Perf 411003	2018-03-01 00:00:00	NULL	NULL	NULL	P273	NULL	Perf 273	0.00	174.36	1	0	0	0	NULL	0	0	NULL	546	NULL	NULL	NULL
51	273	273	530000	0	Perf 530000	2018-03-01 00:00:00	NULL	NULL	NULL	P273	NULL	Perf 273	174.36	0.00	1	0	0	0	NULL	0	0	NULL	545	NULL	NULL	NULL
51	274	274	401014	0	Perf 401014	2018-04-08 00:00:00	NULL	NULL	NULL	P274	NULL	Perf 274	211.49	0.00	1	0	0	0	NULL	0	0	NULL	547	NULL	NULL	NULL
51	274	274	512000	0	Perf 512000	2018-04-08 00:00:00	NULL	NULL	NULL	P274	NULL	Perf 274	0.00	211.49	1	0	0	0	NULL	0	0	NULL	548	NULL	NULL	NULL
51	279	279	411009	0	Perf 411009	2018-03-15 00:00:00	NULL	NULL	NULL	P279	NULL	Perf 279	0.00	396.14	1	0	0	0	NULL	0	0	NULL	558	NULL	NULL	NULL
51	279	279	530000	0	Perf 530000	2018-03-15 00:00:00	NULL	NULL	NULL	P279	NULL	Perf 279	396.14	0.00	1	0	0	0	NULL	0	0	NULL	557	NULL	NULL	NULL
51	28	28	401002	0	Perf 401002	2018-04-22 00:00:00	NULL	NULL	NULL	P28	NULL	Perf 28	19.51	0.00	1	0	0	0	NULL	0	0	NULL	55	NULL	NULL	NULL
51	28	28	512000	0	Perf 512000	2018-04-22 00:00:00	NULL	NULL	NULL	P28	NULL	Perf 28	0.00	19.51	1	0	0	0	NULL	0	0	NULL	56	NULL	NULL	NULL
51	280	280	401020	0	Perf 401020	2018-04-22 00:00:00	NULL	NULL	NULL	P280	NULL	Perf 280	433.27	0.00	1	0	0	0	NULL	0	0	NULL	559	NULL	NULL	NULL
51	280	280	512000	0	Perf 512000	2018-04-22 00:00:00	NULL	NULL	NULL	P280	NULL	Perf 280	0.00	433.27	1	0	0	0	NULL	0	0	NULL	560	NULL	NULL	NULL
51	285	285	411015	0	Perf 411015	2018-03-01 00:00:00	NULL	NULL	NULL	P285	NULL	Perf 285	0.00	618.92	1	0	0	0	NULL	0	0	NULL	570	NULL	NULL	NULL
51	285	285	530000	0	Perf 530000	2018-03-01 00:00:00	NULL	NULL	NULL	P285	NULL	Perf 285	618.92	0.00	1	0	0	0	NULL	0	0	NULL	569	NULL	NULL	NULL
51	286	286	401026	0	Perf 401026	2018-04-08 00:00:00	NULL	NULL	NULL	P286	NULL	Perf 286	655.05	0.00	1	0	0	0	NULL	0	0	NULL	571	NULL	NULL	NULL
51	286	286	512000	0	Perf 512000	2018-04-08 00:00:00	NULL	NULL	NULL	P286	NULL	Perf 286	0.00	655.05	1	0	0	0	NULL	0	0	NULL	572	NULL	NULL	NULL
51	291	291	411021	0	Perf 411021	2018-03-15 00:00:00	NULL	NULL	NULL	P291	NULL	Perf 291	0.00	840.70	1	0	0	0	NULL	0	0	NULL	582	NULL	NULL	NULL
51	291	291	530000	0	Perf 530000	2018-03-15 00:00:00	NULL	NULL	NULL	P291	NULL	Perf 291	840.70	0.00	1	0	0	0	NULL	0	0	NULL	581	NULL	NULL	NULL
51	292	292	401006	0	Perf 401006	2018-04-22 00:00:00	NULL	NULL	NULL	P292	NULL	Perf 292	877.83	0.00	1	0	0	0	NULL	0	0	NULL	583	NULL	NULL	NULL
51	292	292	512000	0	Perf 512000	2018-04-22 00:00:00	NULL	NULL	NULL	P292	NULL	Perf 292	0.00	877.83	1	0	0	0	NULL	0	0	NULL	584	NULL	NULL	NULL
51	297	0	411027	0	Perf 411027	2018-03-01 00:00:00	NULL	NULL	NULL	P297	NULL	Perf 297	0.00	72.48	0	0	0	0	NULL	0	0	NULL	594	NULL	NULL	NULL
51	297	0	530000	0	Perf 530000	2018-03-01 00:00:00	NULL	NULL	NULL	P297	NULL	Perf 297	72.48	0.00	0	0	0	0	NULL	0	0	NULL	593	NULL	NULL	NULL
51	298	298	401012	0	Perf 401012	2018-04-08 00:00:00	NULL	NULL	NULL	P298	NULL	Perf 298	109.61	0.00	1	0	0	0	NULL	0	0	NULL	595	NULL	NULL	NULL
51	298	298	512000	0	Perf 512000	2018-04-08 00:00:00	NULL	NULL	NULL	P298	NULL	Perf 298	0.00	109.61	1	0	0	0	NULL	0	0	NULL	596	NULL	NULL	NULL
51	3	3	411003	0	Perf 411003	2018-03-15 00:00:00	NULL	NULL	NULL	P3	NULL	Perf 3	0.00	84.26	1	0	0	0	NULL	0	0	NULL	6	NULL	NULL	NULL
51	3	3	530000	0	Perf 530000	2018-03-15 00:00:00	NULL	NULL	NULL	P3	NULL	Perf 3	84.26	0.00	1	0	0	0	NULL	0	0	NULL	5	NULL	NULL	NULL
51	303	303	411006	0	Perf 411006	2018-03-15 00:00:00	NULL	NULL	NULL	P303	NULL	Perf 303	0.00	294.26	1	0	0	0	NULL	0	0	NULL	606	NULL	NULL	NULL
51	303	303	530000	0	Perf 530000	2018-03-15 00:00:00	NULL	NULL	NULL	P303	NULL	Perf 303	294.26	0.00	1	0	0	0	NULL	0	0	NULL	605	NULL	NULL	NULL
51	304	304	401018	0	Perf 401018	2018-04-22 00:00:00	NULL	NULL	NULL	P304	NULL	Perf 304	331.39	0.00	1	0	0	0	NULL	0	0	NULL	607	NULL	NULL	NULL
51	304	304	512000	0	Perf 512000	2018-04-22 00:00:00	NULL	NULL	NULL	P304	NULL	Perf 304	0.00	331.39	1	0	0	0	NULL	0	0	NULL	608	NULL	NULL	NULL
51	309	309	411012	0	Perf 411012	2018-03-01 00:00:00	NULL	NULL	NULL	P309	NULL	Perf 309	0.00	516.04	1	0	0	0	NULL	0	0	NULL	618	NULL	NULL	NULL
51	309	309	530000	0	Perf 530000	2018-03-01 00:00:00	NULL	NULL	NULL	P309	NULL	Perf 309	516.04	0.00	1	0	0	0	NULL	0	0	NULL	617	NULL	NULL	NULL
51	310	310	401024	0	Perf 401024	2018-04-08 00:00:00	NULL	NULL	NULL	P310	NULL	Perf 310	553.17	0.00	1	0	0	0	NULL	0	0	NULL	619	NULL	NULL	NULL
51	310	310	512000	0	Perf 512000	2018-04-08 00:00:00	NULL	NULL	NULL	P310	NULL	Perf 310	0.00	553.17	1	0	0	0	NULL	0	0	NULL	620	NULL	NULL	NULL
51	315	315	411018	0	Perf 411018	2018-03-15 00:00:00	NULL	NULL	NULL	P315	NULL	Perf 315	0.00	738.82	1	0	0	0	NULL	0	0	NULL	630	NULL	NULL	NULL
51	315	315	530000	0	Perf 530000	2018-03-15 00:00:00	NULL	NULL	NULL	P315	NULL	Perf 315	738.82	0.00	1	0	0	0	NULL	0	0	NULL	629	NULL	NULL	NULL
51	316	316	401004	0	Perf 401004	2018-04-22 00:00:00	NULL	NULL	NULL	P316	NULL	Perf 316	775.95	0.00	1	0	0	0	NULL	0	0	NULL	631	NULL	NULL	NULL
51	316	316	512000	0	Perf 512000	2018-04-22 00:00:00	NULL	NULL	NULL	P316	NULL	Perf 316	0.00	775.95	1	0	0	0	NULL	0	0	NULL	632	NULL	NULL	NULL
51	321	321	411024	0	Perf 411024	2018-03-01 00:00:00	NULL	NULL	NULL	P321	NULL	Perf 321	0.00	960.60	1	0	0	0	NULL	0	0	NULL	642	NULL	NULL	NULL
51	321	321	530000	0	Perf 530000	2018-03-01 00:00:00	NULL	NULL	NULL	P321	NULL	Perf 321	960.60	0.00	1	0	0	0	NULL	0	0	NULL	641	NULL	NULL	NULL
51	322	322	401010	0	Perf 401010	2018-04-08 00:00:00	NULL	NULL	NULL	P322	NULL	Perf 322	997.73	0.00	1	0	0	0	NULL	0	0	NULL	643	NULL	NULL	NULL
51	322	322	512000	0	Perf 512000	2018-04-08 00:00:00	NULL	NULL	NULL	P322	NULL	Perf 322	0.00	997.73	1	0	0	0	NULL	0	0	NULL	644	NULL	NULL	NULL
51	327	327	411003	0	Perf 411003	2018-03-15 00:00:00	NULL	NULL	NULL	P327	NULL	Perf 327	0.00	192.38	1	0	0	0	NULL	0	0	NULL	654	NULL	NULL	NULL
51	327	327	530000	0	Perf 530000	2018-03-15 00:00:00	NULL	NULL	NULL	P327	NULL	Perf 327	192.38	0.00	1	0	0	0	NULL	0	0	NULL	653	NULL	NULL	NULL
51	328	328	401016	0	Perf 401016	2018-04-22 00:00:00	NULL	NULL	NULL	P328	NULL	Perf 328	229.51	0.00	1	0	0	0	NULL	0	0	NULL	655	NULL	NULL	NULL
51	328	328	512000	0	Perf 512000	2018-04-22 00:00:00	NULL	NULL	NULL	P328	NULL	Perf 328	0.00	229.51	1	0	0	0	NULL	0	0	NULL	656	NULL	NULL	NULL
51	33	33	411006	0	Perf 411006	2018-03-01 00:00:00	NULL	NULL	NULL	P33	NULL	Perf 33	0.00	204.16	1	0	0	0	NULL	0	0	NULL	66	NULL	NULL	NULL
51	33	33	530000	0	Perf 530000	2018-03-01 00:00:00	NULL	NULL	NULL	P33	NULL	Perf 33	204.16	0.00	1	0	0	0	NULL	0	0	NULL	65	NULL	NULL	NULL
51	333	333	411009	0	Perf 411009	2018-03-01 00:00:00	NULL	NULL	NULL	P333	NULL	Perf 333	0.00	414.16	1	0	0	0	NULL	0	0	NULL	666	NULL	NULL	NULL
51	333	333	530000	0	Perf 530000	2018-03-01 00:00:00	NULL	NULL	NULL	P333	NULL	Perf 333	414.16	0.00	1	0	0	0	NULL	0	0	NULL	665	NULL	NULL	NULL
51	334	334	401022	0	Perf 401022	2018-04-08 00:00:00	NULL	NULL	NULL	P334	NULL	Perf 334	451.29	0.00	1	0	0	0	NULL	0	0	NULL	667	NULL	NULL	NULL
51	334	334	512000	0	Perf 512000	2018-04-08 00:00:00	NULL	NULL	NULL	P334	NULL	Perf 334	0.00	451.29	1	0	0	0	NULL	0	0	NULL	668	NULL	NULL	NULL
51	339	339	411015	0	Perf 411015	2018-03-15 00:00:00	NULL	NULL	NULL	P339	NULL	Perf 339	0.00	636.94	1	0	0	0	NULL	0	0	NULL	678	NULL	NULL	NULL
51	339	339	530000	0	Perf 530000	2018-03-15 00:00:00	NULL	NULL	NULL	P339	NULL	Perf 339	636.94	0.00	1	0	0	0	NULL	0	0	NULL	677	NULL	NULL	NULL
51	34	34	401008	0	Perf 401008	2018-04-08 00:00:00	NULL	NULL	NULL	P34	NULL	Perf 34	241.29	0.00	1	0	0	0	NULL	0	0	NULL	67	NULL	NULL	NULL
51	34	34	512000	0	Perf 512000	2018-04-08 00:00:00	NULL	NULL	NULL	P34	NULL	Perf 34	0.00	241.29	1	0	0	0	NULL	0	0	NULL	68	NULL	NULL	NULL
51	340	340	401002	0	Perf 401002	2018-04-22 00:00:00	NULL	NULL	NULL	P340	NULL	Perf 340	673.07	0.00	1	0	0	0	NULL	0	0	NULL	679	NULL	NULL	NULL
51	340	340	512000	0	Perf 512000	2018-04-22 00:00:00	NULL	NULL	NULL	P340	NULL	Perf 340	0.00	673.07	1	0	0	0	NULL	0	0	NULL	680	NULL	NULL	NULL
51	345	345	411021	0	Perf 411021	2018-03-01 00:00:00	NULL	NULL	NULL	P345	NULL	Perf 345	0.00	858.72	1	0	0	0	NULL	0	0	NULL	690	NULL	NULL	NULL
51	345	345	530000	0	Perf 530000	2018-03-01 00:00:00	NULL	NULL	NULL	P345	NULL	Perf 345	858.72	0.00	1	0	0	0	NULL	0	0	NULL	689	NULL	NULL	NULL
51	346	346	401008	0	Perf 401008	2018-04-08 00:00:00	NULL	NULL	NULL	P346	NULL	Perf 346	895.85	0.00	1	0	0	0	NULL	0	0	NULL	691	NULL	NULL	NULL
51	346	346	512000	0	Perf 512000	2018-04-08 00:00:00	NULL	NULL	NULL	P346	NULL	Perf 346	0.00	895.85	1	0	0	0	NULL	0	0	NULL	692	NULL	NULL	NULL
51	351	351	411027	0	Perf 411027	2018-03-15 00:00:00	NULL	NULL	NULL	P351	NULL	Perf 351	0.00	90.50	1	0	0	0	NULL	0	0	NULL	702	NULL	NULL	NULL
51	351	351	530000	0	Perf 530000	2018-03-15 00:00:00	NULL	NULL	NULL	P351	NULL	Perf 351	90.50	0.00	1	0	0	0	NULL	0	0	NULL	701	NULL	NULL	NULL
51	352	352	401014	0	Perf 401014	2018-04-22 00:00:00	NULL	NULL	NULL	P352	NULL	Perf 352	127.63	0.00	1	0	0	0	NULL	0	0	NULL	703	NULL	NULL	NULL
51	352	352	512000	0	Perf 512000	2018-04-22 00:00:00	NULL	NULL	NULL	P352	NULL	Perf 352	0.00	127.63	1	0	0	0	NULL	0	0	NULL	704	NULL	NULL	NULL
51	357	357	411006	0	Perf 411006	2018-03-01 00:00:00	NULL	NULL	NULL	P357	NULL	Perf 357	0.00	312.28	1	0	0	0	NULL	0	0	NULL	714	NULL	NULL	NULL
51	357	357	530000	0	Perf 530000	2018-03-01 00:00:00	NULL	NULL	NULL	P357	NULL	Perf 357	312.28	0.00	1	0	0	0	NULL	0	0	NULL	713	NULL	NULL	NULL
51	358	358	401020	0	Perf 401020	2018-04-08 00:00:00	NULL	NULL	NULL	P358	NULL	Perf 358	349.41	0.00	1	0	0	0	NULL	0	0	NULL	715	NULL	NULL	NULL
51	358	358	512000	0	Perf 512000	2018-04-08 00:00:00	NULL	NULL	NULL	P358	NULL	Perf 358	0.00	349.41	1	0	0	0	NULL	0	0	NULL	716	NULL	NULL	NULL
51	363	363	411012	0	Perf 411012	2018-03-15 00:00:00	NULL	NULL	NULL	P363	NULL	Perf 363	0.00	534.06	1	0	0	0	NULL	0	0	NULL	726	NULL	NULL	NULL
51	363	363	530000	0	Perf 530000	2018-03-15 00:00:00	NULL	NULL	NULL	P363	NULL	Perf 363	534.06	0.00	1	0	0	0	NULL	0	0	NULL	725	NULL	NULL	NULL
51	364	364	401026	0	Perf 401026	2018-04-22 00:00:00	NULL	NULL	NULL	P364	NULL	Perf 364	571.19	0.00	1	0	0	0	NULL	0	0	NULL	727	NULL	NULL	NULL
51	364	364	512000	0	Perf 512000	2018-04-22 00:00:00	NULL	NULL	NULL	P364	NULL	Perf 364	0.00	571.19	1	0	0	0	NULL	0	0	NULL	728	NULL	NULL	NULL
51	369	369	411018	0	Perf 411018	2018-03-01 00:00:00	NULL	NULL	NULL	P369	NULL	Perf 369	0.00	756.84	1	0	0	0	NULL	0	0	NULL	738	NULL	NULL	NULL
51	369	369	530000	0	Perf 530000	2018-03-01 00:00:00	NULL	NULL	NULL	P369	NULL	Perf 369	756.84	0.00	1	0	0	0	NULL	0	0	NULL	737	NULL	NULL	NULL
51	370	370	401006	0	Perf 401006	2018-04-08 00:00:00	NULL	NULL	NULL	P370	NULL	Perf 370	793.97	0.00	1	0	0	0	NULL	0	0	NULL	739	NULL	NULL	NULL
51	370	370	512000	0	Perf 512000	2018-04-08 00:00:00	NULL	NULL	NULL	P370	NULL	Perf 370	0.00	793.97	1	0	0	0	NULL	0	0	NULL	740	NULL	NULL	NULL
51	375	375	411024	0	Perf 411024	2018-03-15 00:00:00	NULL	NULL	NULL	P375	NULL	Perf 375	0.00	978.62	1	0	0	0	NULL	0	0	NULL	750	NULL	NULL	NULL
51	375	375	530000	0	Perf 530000	2018-03-15 00:00:00	NULL	NULL	NULL	P375	NULL	Perf 375	978.62	0.00	1	0	0	0	NULL	0	0	NULL	749	NULL	NULL	NULL
51	376	376	401012	0	Perf 401012	2018-04-22 00:00:00	NULL	NULL	NULL	P376	NULL	Perf 376	25.75	0.00	1	0	0	0	NULL	0	0	NULL	751	NULL	NULL	NULL
51	376	376	512000	0	Perf 512000	2018-04-22 00:00:00	NULL	NULL	NULL	P376	NULL	Perf 376	0.00	25.75	1	0	0	0	NULL	0	0	NULL	752	NULL	NULL	NULL
51	381	381	411003	0	Perf 411003	2018-03-01 00:00:00	NULL	NULL	NULL	P381	NULL	Perf 381	0.00	210.40	1	0	0	0	NULL	0	0	NULL	762	NULL	NULL	NULL
51	381	381	530000	0	Perf 530000	2018-03-01 00:00:00	NULL	NULL	NULL	P381	NULL	Perf 381	210.40	0.00	1	0	0	0	NULL	0	0	NULL	761	NULL	NULL	NULL
51	382	382	401018	0	Perf 401018	2018-04-08 00:00:00	NULL	NULL	NULL	P382	NULL	Perf 382	247.53	0.00	1	0	0	0	NULL	0	0	NULL	763	NULL	NULL	NULL
51	382	382	512000	0	Perf 512000	2018-04-08 00:00:00	NULL	NULL	NULL	P382	NULL	Perf 382	0.00	247.53	1	0	0	0	NULL	0	0	NULL	764	NULL	NULL	NULL
51	387	387	411009	0	Perf 411009	2018-03-15 00:00:00	NULL	NULL	NULL	P387	NULL	Perf 387	0.00	432.18	1	0	0	0	NULL	0	0	NULL	774	NULL	NULL	NULL
51	387	387	530000	0	Perf 530000	2018-03-15 00:00:00	NULL	NULL	NULL	P387	NULL	Perf 387	432.18	0.00	1	0	0	0	NULL	0	0	NULL	773	NULL	NULL	NULL
51	388	388	401024	0	Perf 401024	2018-04-22 00:00:00	NULL	NULL	NULL	P388	NULL	Perf 388	469.31	0.00	1	0	0	0	NULL	0	0	NULL	775	NULL	NULL	NULL
51	388	388	512000	0	Perf 512000	2018-04-22 00:00:00	NULL	NULL	NULL	P388	NULL	Perf 388	0.00	469.31	1	0	0	0	NULL	0	0	NULL	776	NULL	NULL	NULL
51	39	39	411012	0	Perf 411012	2018-03-15 00:00:00	NULL	NULL	NULL	P39	NULL	Perf 39	0.00	426.94	1	0	0	0	NULL	0	0	NULL	78	NULL	NULL	NULL
51	39	39	530000	0	Perf 530000	2018-03-15 00:00:00	NULL	NULL	NULL	P39	NULL	Perf 39	426.94	0.00	1	0	0	0	NULL	0	0	NULL	77	NULL	NULL	NULL
51	393	393	411015	0	Perf 411015	2018-03-01 00:00:00	NULL	NULL	NULL	P393	NULL	Perf 393	0.00	654.96	1	0	0	0	NULL	0	0	NULL	786	NULL	NULL	NULL
51	393	393	530000	0	Perf 530000	2018-03-01 00:00:00	NULL	NULL	NULL	P393	NULL	Perf 393	654.96	0.00	1	0	0	0	NULL	0	0	NULL	785	NULL	NULL	NULL
51	394	0	401004	0	Perf 401004	2018-04-08 00:00:00	NULL	NULL	NULL	P394	NULL	Perf 394	691.09	0.00	0	0	0	0	NULL	0	0	NULL	787	NULL	NULL	NULL
51	394	0	512000	0	Perf 512000	2018-04-08 00:00:00	NULL	NULL	NULL	P394	NULL	Perf 394	0.00	691.09	0	0	0	0	NULL	0	0	NULL	788	NULL	NULL	NULL
51	399	399	411021	0	Perf 411021	2018-03-15 00:00:00	NULL	NULL	NULL	P399	NULL	Perf 399	0.00	876.74	1	0	0	0	NULL	0	0	NULL	798	NULL	NULL	NULL
51	399	399	530000	0	Perf 530000	2018-03-15 00:00:00	NULL	NULL	NULL	P399	NULL	Perf 399	876.74	0.00	1	0	0	0	NULL	0	0	NULL	797	NULL	NULL	NULL
51	4	4	401004	0	Perf 401004	2018-04-22 00:00:00	NULL	NULL	NULL	P4	NULL	Perf 4	121.39	0.00	1	0	0	0	NULL	0	0	NULL	7	NULL	NULL	NULL
51	4	4	512000	0	Perf 512000	2018-04-22 00:00:00	NULL	NULL	NULL	P4	NULL	Perf 4	0.00	121.39	1	0	0	0	NULL	0	0	NULL	8	NULL	NULL	NULL
51	40	40	401014	0	Perf 401014	2018-04-22 00:00:00	NULL	NULL	NULL	P40	NULL	Perf 40	463.07	0.00	1	0	0	0	NULL	0	0	NULL	79	NULL	NULL	NULL
51	40	40	512000	0	Perf 512000	2018-04-22 00:00:00	NULL	NULL	NULL	P40	NULL	Perf 40	0.00	463.07	1	0	0	0	NULL	0	0	NULL	80	NULL	NULL	NULL
51	400	400	401010	0	Perf 401010	2018-04-22 00:00:00	NULL	NULL	NULL	P400	NULL	Perf 400	913.87	0.00	1	0	0	0	NULL	0	0	NULL	799	NULL	NULL	NULL
51	400	400	512000	0	Perf 512000	2018-04-22 00:00:00	NULL	NULL	NULL	P400	NULL	Perf 400	0.00	913.87	1	0	0	0	NULL	0	0	NULL	800	NULL	NULL	NULL
51	405	405	411027	0	Perf 411027	2018-03-01 00:00:00	NULL	NULL	NULL	P405	NULL	Perf 405	0.00	108.52	1	0	0	0	NULL	0	0	NULL	810	NULL	NULL	NULL
51	405	405	530000	0	Perf 530000	2018-03-01 00:00:00	NULL	NULL	NULL	P405	NULL	Perf 405	108.52	0.00	1	0	0	0	NULL	0	0	NULL	809	NULL	NULL	NULL
51	406	406	401016	0	Perf 401016	2018-04-08 00:00:00	NULL	NULL	NULL	P406	NULL	Perf 406	145.65	0.00	1	0	0	0	NULL	0	0	NULL	811	NULL	NULL	NULL
51	406	406	512000	0	Perf 512000	2018-04-08 00:00:00	NULL	NULL	NULL	P406	NULL	Perf 406	0.00	145.65	1	0	0	0	NULL	0	0	NULL	812	NULL	NULL	NULL
51	411	411	411006	0	Perf 411006	2018-03-15 00:00:00	NULL	NULL	NULL	P411	NULL	Perf 411	0.00	330.30	1	0	0	0	NULL	0	0	NULL	822	NULL	NULL	NULL
51	411	411	530000	0	Perf 530000	2018-03-15 00:00:00	NULL	NULL	NULL	P411	NULL	Perf 411	330.30	0.00	1	0	0	0	NULL	0	0	NULL	821	NULL	NULL	NULL
51	412	412	401022	0	Perf 401022	2018-04-22 00:00:00	NULL	NULL	NULL	P412	NULL	Perf 412	367.43	0.00	1	0	0	0	NULL	0	0	NULL	823	NULL	NULL	NULL
51	412	412	512000	0	Perf 512000	2018-04-22 00:00:00	NULL	NULL	NULL	P412	NULL	Perf 412	0.00	367.43	1	0	0	0	NULL	0	0	NULL	824	NULL	NULL	NULL
51	417	417	411012	0	Perf 411012	2018-03-01 00:00:00	NULL	NULL	NULL	P417	NULL	Perf 417	0.00	552.08	1	0	0	0	NULL	0	0	NULL	834	NULL	NULL	NULL
51	417	417	530000	0	Perf 530000	2018-03-01 00:00:00	NULL	NULL	NULL	P417	NULL	Perf 417	552.08	0.00	1	0	0	0	NULL	0	0	NULL	833	NULL	NULL	NULL
51	418	418	401002	0	Perf 401002	2018-04-08 00:00:00	NULL	NULL	NULL	P418	NULL	Perf 418	589.21	0.00	1	0	0	0	NULL	0	0	NULL	835	NULL	NULL	NULL
51	418	418	512000	0	Perf 512000	2018-04-08 00:00:00	NULL	NULL	NULL	P418	NULL	Perf 418	0.00	589.21	1	0	0	0	NULL	0	0	NULL	836	NULL	NULL	NULL
51	423	423	411018	0	Perf 411018	2018-03-15 00:00:00	NULL	NULL	NULL	P423	NULL	Perf 423	0.00	774.86	1	0	0	0	NULL	0	0	NULL	846	NULL	NULL	NULL
51	423	423	530000	0	Perf 530000	2018-03-15 00:00:00	NULL	NULL	NULL	P423	NULL	Perf 423	774.86	0.00	1	0	0	0	NULL	0	0	NULL	845	NULL	NULL	NULL
51	424	424	401008	0	Perf 401008	2018-04-22 00:00:00	NULL	NULL	NULL	P424	NULL	Perf 424	811.99	0.00	1	0	0	0	NULL	0	0	NULL	847	NULL	NULL	NULL
51	424	424	512000	0	Perf 512000	2018-04-22 00:00:00	NULL	NULL	NULL	P424	NULL	Perf 424	0.00	811.99	1	0	0	0	NULL	0	0	NULL	848	NULL	NULL	NULL
51	429	429	411024	0	Perf 411024	2018-03-01 00:00:00	NULL	NULL	NULL	P429	NULL	Perf 429	0.00	996.64	1	0	0	0	NULL	0	0	NULL	858	NULL	NULL	NULL
51	429	429	530000	0	Perf 530000	2018-03-01 00:00:00	NULL	NULL	NULL	P429	NULL	Perf 429	996.64	0.00	1	0	0	0	NULL	0	0	NULL	857	NULL	NULL	NULL
51	430	430	401014	0	Perf 401014	2018-04-08 00:00:00	NULL	NULL	NULL	P430	NULL	Perf 430	43.77	0.00	1	0	0	0	NULL	0	0	NULL	859	NULL	NULL	NULL
51	430	430	512000	0	Perf 512000	2018-04-08 00:00:00	NULL	NULL	NULL	P430	NULL	Perf 430	0.00	43.77	1	0	0	0	NULL	0	0	NULL	860	NULL	NULL	NULL
51	435	435	411003	0	Perf 411003	2018-03-15 00:00:00	NULL	NULL	NULL	P435	NULL	Perf 435	0.00	228.42	1	0	0	0	NULL	0	0	NULL	870	NULL	NULL	NULL
51	435	435	530000	0	Perf 530000	2018-03-15 00:00:00	NULL	NULL	NULL	P435	NULL	Perf 435	228.42	0.00	1	0	0	0	NULL	0	0	NULL	869	NULL	NULL	NULL
51	436	436	401020	0	Perf 401020	2018-04-22 00:00:00	NULL	NULL	NULL	P436	NULL	Perf 436	265.55	0.00	1	0	0	0	NULL	0	0	NULL	871	NULL	NULL	NULL
51	436	436	512000	0	Perf 512000	2018-04-22 00:00:00	NULL	NULL	NULL	P436	NULL	Perf 436	0.00	265.55	1	0	0	0	NULL	0	0	NULL	872	NULL	NULL	NULL
51	441	441	411009	0	Perf 411009	2018-03-01 00:00:00	NULL	NULL	NULL	P441	NULL	Perf 441	0.00	450.20	1	0	0	0	NULL	0	0	NULL	882	NULL	NULL	NULL
51	441	441	530000	0	Perf 530000	2018-03-01 00:00:00	NULL	NULL	NULL	P441	NULL	Perf 441	450.20	0.00	1	0	0	0	NULL	0	0	NULL	881	NULL	NULL	NULL
51	442	442	401026	0	Perf 401026	2018-04-08 00:00:00	NULL	NULL	NULL	P442	NULL	Perf 442	487.33	0.00	1	0	0	0	NULL	0	0	NULL	883	NULL	NULL	NULL
51	442	442	512000	0	Perf 512000	2018-04-08 00:00:00	NULL	NULL	NULL	P442	NULL	Perf 442	0.00	487.33	1	0	0	0	NULL	0	0	NULL	884	NULL	NULL	NULL
51	447	447	411015	0	Perf 411015	2018-03-15 00:00:00	NULL	NULL	NULL	P447	NULL	Perf 447	0.00	672.98	1	0	0	0	NULL	0	0	NULL	894	NULL	NULL	NULL
51	447	447	530000	0	Perf 530000	2018-03-15 00:00:00	NULL	NULL	NULL	P447	NULL	Perf 447	672.98	0.00	1	0	0	0	NULL	0	0	NULL	893	NULL	NULL	NULL
51	448	448	401006	0	Perf 401006	2018-04-22 00:00:00	NULL	NULL	NULL	P448	NULL	Perf 448	709.11	0.00	1	0	0	0	NULL	0	0	NULL	895	NULL	NULL	NULL
51	448	448	512000	0	Perf 512000	2018-04-22 00:00:00	NULL	NULL	NULL	P448	NULL	Perf 448	0.00	709.11	1	0	0	0	NULL	0	0	NULL	896	NULL	NULL	NULL
51	45	45	411018	0	Perf 411018	2018-03-01 00:00:00	NULL	NULL	NULL	P45	NULL	Perf 45	0.00	648.72	1	0	0	0	NULL	0	0	NULL	90	NULL	NULL	NULL
51	45	45	530000	0	Perf 530000	2018-03-01 00:00:00	NULL	NULL	NULL	P45	NULL	Perf 45	648.72	0.00	1	0	0	0	NULL	0	0	NULL	89	NULL	NULL	NULL
51	453	453	411021	0	Perf 411021	2018-03-01 00:00:00	NULL	NULL	NULL	P453	NULL	Perf 453	0.00	894.76	1	0	0	0	NULL	0	0	NULL	906	NULL	NULL	NULL
51	453	453	530000	0	Perf 530000	2018-03-01 00:00:00	NULL	NULL	NULL	P453	NULL	Perf 453	894.76	0.00	1	0	0	0	NULL	0	0	NULL	905	NULL	NULL	NULL
51	454	454	401012	0	Perf 401012	2018-04-08 00:00:00	NULL	NULL	NULL	P454	NULL	Perf 454	931.89	0.00	1	0	0	0	NULL	0	0	NULL	907	NULL	NULL	NULL
51	454	454	512000	0	Perf 512000	2018-04-08 00:00:00	NULL	NULL	NULL	P454	NULL	Perf 454	0.00	931.89	1	0	0	0	NULL	0	0	NULL	908	NULL	NULL	NULL
51	459	459	411027	0	Perf 411027	2018-03-15 00:00:00	NULL	NULL	NULL	P459	NULL	Perf 459	0.00	126.54	1	0	0	0	NULL	0	0	NULL	918	NULL	NULL	NULL
51	459	459	530000	0	Perf 530000	2018-03-15 00:00:00	NULL	NULL	NULL	P459	NULL	Perf 459	126.54	0.00	1	0	0	0	NULL	0	0	NULL	917	NULL	NULL	NULL
51	46	46	401020	0	Perf 401020	2018-04-08 00:00:00	NULL	NULL	NULL	P46	NULL	Perf 46	685.85	0.00	1	0	0	0	NULL	0	0	NULL	91	NULL	NULL	NULL
51	46	46	512000	0	Perf 512000	2018-04-08 00:00:00	NULL	NULL	NULL	P46	NULL	Perf 46	0.00	685.85	1	0	0	0	NULL	0	0	NULL	92	NULL	NULL	NULL
51	460	460	401018	0	Perf 401018	2018-04-22 00:00:00	NULL	NULL	NULL	P460	NULL	Perf 460	163.67	0.00	1	0	0	0	NULL	0	0	NULL	919	NULL	NULL	NULL
51	460	460	512000	0	Perf 512000	2018-04-22 00:00:00	NULL	NULL	NULL	P460	NULL	Perf 460	0.00	163.67	1	0	0	0	NULL	0	0	NULL	920	NULL	NULL	NULL
51	465	465	411006	0	Perf 411006	2018-03-01 00:00:00	NULL	NULL	NULL	P465	NULL	Perf 465	0.00	348.32	1	0	0	0	NULL	0	0	NULL	930	NULL	NULL	NULL
51	465	465	530000	0	Perf 530000	2018-03-01 00:00:00	NULL	NULL	NULL	P465	NULL	Perf 465	348.32	0.00	1	0	0	0	NULL	0	0	NULL	929	NULL	NULL	NULL
51	466	466	401024	0	Perf 401024	2018-04-08 00:00:00	NULL	NULL	NULL	P466	NULL	Perf 466	385.45	0.00	1	0	0	0	NULL	0	0	NULL	931	NULL	NULL	NULL
51	466	466	512000	0	Perf 512000	2018-04-08 00:00:00	NULL	NULL	NULL	P466	NULL	Perf 466	0.00	385.45	1	0	0	0	NULL	0	0	NULL	932	NULL	NULL	NULL
51	471	471	411012	0	Perf 411012	2018-03-15 00:00:00	NULL	NULL	NULL	P471	NULL	Perf 471	0.00	570.10	1	0	0	0	NULL	0	0	NULL	942	NULL	NULL	NULL
51	471	471	530000	0	Perf 530000	2018-03-15 00:00:00	NULL	NULL	NULL	P471	NULL	Perf 471	570.10	0.00	1	0	0	0	NULL	0	0	NULL	941	NULL	NULL	NULL
51	472	472	401004	0	Perf 401004	2018-04-22 00:00:00	NULL	NULL	NULL	P472	NULL	Perf 472	607.23	0.00	1	0	0	0	NULL	0	0	NULL	943	NULL	NULL	NULL
51	472	472	512000	0	Perf 512000	2018-04-22 00:00:00	NULL	NULL	NULL	P472	NULL	Perf 472	0.00	607.23	1	0	0	0	NULL	0	0	NULL	944	NULL	NULL	NULL
51	477	477	411018	0	Perf 411018	2018-03-01 00:00:00	NULL	NULL	NULL	P477	NULL	Perf 477	0.00	792.88	1	0	0	0	NULL	0	0	NULL	954	NULL	NULL	NULL
51	477	477	530000	0	Perf 530000	2018-03-01 00:00:00	NULL	NULL	NULL	P477	NULL	Perf 477	792.88	0.00	1	0	0	0	NULL	0	0	NULL	953	NULL	NULL	NULL
51	478	478	401010	0	Perf 401010	2018-04-08 00:00:00	NULL	NULL	NULL	P478	NULL	Perf 478	829.01	0.00	1	0	0	0	NULL	0	0	NULL	955	NULL	NULL	NULL
51	478	478	512000	0	Perf 512000	2018-04-08 00:00:00	NULL	NULL	NULL	P478	NULL	Perf 478	0.00	829.01	1	0	0	0	NULL	0	0	NULL	956	NULL	NULL	NULL
51	483	483	411024	0	Perf 411024	2018-03-15 00:00:00	NULL	NULL	NULL	P483	NULL	Perf 483	0.00	24.66	1	0	0	0	NULL	0	0	NULL	966	NULL	NULL	NULL
51	483	483	530000	0	Perf 530000	2018-03-15 00:00:00	NULL	NULL	NULL	P483	NULL	Perf 483	24.66	0.00	1	0	0	0	NULL	0	0	NULL	965	NULL	NULL	NULL
51	484	484	401016	0	Perf 401016	2018-04-22 00:00:00	NULL	NULL	NULL	P484	NULL	Perf 484	61.79	0.00	1	0	0	0	NULL	0	0	NULL	967	NULL	NULL	NULL
51	484	484	512000	0	Perf 512000	2018-04-22 00:00:00	NULL	NULL	NULL	P484	NULL	Perf 484	0.00	61.79	1	0	0	0	NULL	0	0	NULL	968	NULL	NULL	NULL
51	489	489	411003	0	Perf 411003	2018-03-01 00:00:00	NULL	NULL	NULL	P489	NULL	Perf 489	0.00	246.44	1	0	0	0	NULL	0	0	NULL	978	NULL	NULL	NULL
51	489	489	530000	0	Perf 530000	2018-03-01 00:00:00	NULL	NULL	NULL	P489	NULL	Perf 489	246.44	0.00	1	0	0	0	NULL	0	0	NULL	977	NULL	NULL	NULL
51	490	490	401022	0	Perf 401022	2018-04-08 00:00:00	NULL	NULL	NULL	P490	NULL	Perf 490	283.57	0.00	1	0	0	0	NULL	0	0	NULL	979	NULL	NULL	NULL
51	490	490	512000	0	Perf 512000	2018-04-08 00:00:00	NULL	NULL	NULL	P490	NULL	Perf 490	0.00	283.57	1	0	0	0	NULL	0	0	NULL	980	NULL	NULL	NULL
51	495	495	411009	0	Perf 411009	2018-03-15 00:00:00	NULL	NULL	NULL	P495	NULL	Perf 495	0.00	468.22	1	0	0	0	NULL	0	0	NULL	990	NULL	NULL	NULL
51	495	495	530000	0	Perf 530000	2018-03-15 00:00:00	NULL	NULL	NULL	P495	NULL	Perf 495	468.22	0.00	1	0	0	0	NULL	0	0	NULL	989	NULL	NULL	NULL
51	496	496	401002	0	Perf 401002	2018-04-22 00:00:00	NULL	NULL	NULL	P496	NULL	Perf 496	505.35	0.00	1	0	0	0	NULL	0	0	NULL	991	NULL	NULL	NULL
51	496	496	512000	0	Perf 512000	2018-04-22 00:00:00	NULL	NULL	NULL	P496	NULL	Perf 496	0.00	505.35	1	0	0	0	NULL	0	0	NULL	992	NULL	NULL	NULL
51	51	51	411024	0	Perf 411024	2018-03-15 00:00:00	NULL	NULL	NULL	P51	NULL	Perf 51	0.00	870.50	1	0	0	0	NULL	0	0	NULL	102	NULL	NULL	NULL
51	51	51	530000	0	Perf 530000	2018-03-15 00:00:00	NULL	NULL	NULL	P51	NULL	Perf 51	870.50	0.00	1	0	0	0	NULL	0	0	NULL	101	NULL	NULL	NULL
51	52	52	401026	0	Perf 401026	2018-04-22 00:00:00	NULL	NULL	NULL	P52	NULL	Perf 52	907.63	0.00	1	0	0	0	NULL	0	0	NULL	103	NULL	NULL	NULL
51	52	52	512000	0	Perf 512000	2018-04-22 00:00:00	NULL	NULL	NULL	P52	NULL	Perf 52	0.00	907.63	1	0	0	0	NULL	0	0	NULL	104	NULL	NULL	NULL
51	57	57	411003	0	Perf 411003	2018-03-01 00:00:00	NULL	NULL	NULL	P57	NULL	Perf 57	0.00	102.28	1	0	0	0	NULL	0	0	NULL	114	NULL	NULL	NULL
51	57	57	530000	0	Perf 530000	2018-03-01 00:00:00	NULL	NULL	NULL	P57	NULL	Perf 57	102.28	0.00	1	0	0	0	NULL	0	0	NULL	113	NULL	NULL	NULL
51	58	58	401006	0	Perf 401006	2018-04-08 00:00:00	NULL	NULL	NULL	P58	NULL	Perf 58	139.41	0.00	1	0	0	0	NULL	0	0	NULL	115	NULL	NULL	NULL
51	58	58	512000	0	Perf 512000	2018-04-08 00:00:00	NULL	NULL	NULL	P58	NULL	Perf 58	0.00	139.41	1	0	0	0	NULL	0	0	NULL	116	NULL	NULL	NULL
51	63	63	411009	0	Perf 411009	2018-03-15 00:00:00	NULL	NULL	NULL	P63	NULL	Perf 63	0.00	324.06	1	0	0	0	NULL	0	0	NULL	126	NULL	NULL	NULL
51	63	63	530000	0	Perf 530000	2018-03-15 00:00:00	NULL	NULL	NULL	P63	NULL	Perf 63	324.06	0.00	1	0	0	0	NULL	0	0	NULL	125	NULL	NULL	NULL
51	64	64	401012	0	Perf 401012	2018-04-22 00:00:00	NULL	NULL	NULL	P64	NULL	Perf 64	361.19	0.00	1	0	0	0	NULL	0	0	NULL	127	NULL	NULL	NULL
51	64	64	512000	0	Perf 512000	2018-04-22 00:00:00	NULL	NULL	NULL	P64	NULL	Perf 64	0.00	361.19	1	0	0	0	NULL	0	0	NULL	128	NULL	NULL	NULL
51	69	69	411015	0	Perf 411015	2018-03-01 00:00:00	NULL	NULL	NULL	P69	NULL	Perf 69	0.00	546.84	1	0	0	0	NULL	0	0	NULL	138	NULL	NULL	NULL
51	69	69	530000	0	Perf 530000	2018-03-01 00:00:00	NULL	NULL	NULL	P69	NULL	Perf 69	546.84	0.00	1	0	0	0	NULL	0	0	NULL	137	NULL	NULL	NULL
51	70	70	401018	0	Perf 401018	2018-04-08 00:00:00	NULL	NULL	NULL	P70	NULL	Perf 70	583.97	0.00	1	0	0	0	NULL	0	0	NULL	139	NULL	NULL	NULL
51	70	70	512000	0	Perf 512000	2018-04-08 00:00:00	NULL	NULL	NULL	P70	NULL	Perf 70	0.00	583.97	1	0	0	0	NULL	0	0	NULL	140	NULL	NULL	NULL
51	75	75	411021	0	Perf 411021	2018-03-15 00:00:00	NULL	NULL	NULL	P75	NULL	Perf 75	0.00	768.62	1	0	0	0	NULL	0	0	NULL	150	NULL	NULL	NULL
51	75	75	530000	0	Perf 530000	2018-03-15 00:00:00	NULL	NULL	NULL	P75	NULL	Perf 75	768.62	0.00	1	0	0	0	NULL	0	0	NULL	149	NULL	NULL	NULL
51	76	76	401024	0	Perf 401024	2018-04-22 00:00:00	NULL	NULL	NULL	P76	NULL	Perf 76	805.75	0.00	1	0	0	0	NULL	0	0	NULL	151	NULL	NULL	NULL
51	76	76	512000	0	Perf 512000	2018-04-22 00:00:00	NULL	NULL	NULL	P76	NULL	Perf 76	0.00	805.75	1	0	0	0	NULL	0	0	NULL	152	NULL	NULL	NULL
51	81	81	411027	0	Perf 411027	2018-03-01 00:00:00	NULL	NULL	NULL	P81	NULL	Perf 81	0.00	990.40	1	0	0	0	NULL	0	0	NULL	162	NULL	NULL	NULL
51	81	81	530000	0	Perf 530000	2018-03-01 00:00:00	NULL	NULL	NULL	P81	NULL	Perf 81	990.40	0.00	1	0	0	0	NULL	0	0	NULL	161	NULL	NULL	NULL
51	82	82	401004	0	Perf 401004	2018-04-08 00:00:00	NULL	NULL	NULL	P82	NULL	Perf 82	37.53	0.00	1	0	0	0	NULL	0	0	NULL	163	NULL	NULL	NULL
51	82	82	512000	0	Perf 512000	2018-04-08 00:00:00	NULL	NULL	NULL	P82	NULL	Perf 82	0.00	37.53	1	0	0	0	NULL	0	0	NULL	164	NULL	NULL	NULL
51	87	87	411006	0	Perf 411006	2018-03-15 00:00:00	NULL	NULL	NULL	P87	NULL	Perf 87	0.00	222.18	1	0	0	0	NULL	0	0	NULL	174	NULL	NULL	NULL
51	87	87	530000	0	Perf 530000	2018-03-15 00:00:00	NULL	NULL	NULL	P87	NULL	Perf 87	222.18	0.00	1	0	0	0	NULL	0	0	NULL	173	NULL	NULL	NULL
51	88	88	401010	0	Perf 401010	2018-04-22 00:00:00	NULL	NULL	NULL	P88	NULL	Perf 88	259.31	0.00	1	0	0	0	NULL	0	0	NULL	175	NULL	NULL	NULL
51	88	88	512000	0	Perf 512000	2018-04-22 00:00:00	NULL	NULL	NULL	P88	NULL	Perf 88	0.00	259.31	1	0	0	0	NULL	0	0	NULL	176	NULL	NULL	NULL
51	9	9	411009	0	Perf 411009	2018-03-01 00:00:00	NULL	NULL	NULL	P9	NULL	Perf 9	0.00	306.04	1	0	0	0	NULL	0	0	NULL	18	NULL	NULL	NULL
51	9	9	530000	0	Perf 530000	2018-03-01 00:00:00	NULL	NULL	NULL	P9	NULL	Perf 9	306.04	0.00	1	0	0	0	NULL	0	0	NULL	17	NULL	NULL	NULL
51	93	93	411012	0	Perf 411012	2018-03-01 00:00:00	NULL	NULL	NULL	P93	NULL	Perf 93	0.00	444.96	1	0	0	0	NULL	0	0	NULL	186	NULL	NULL	NULL
51	93	93	530000	0	Perf 530000	2018-03-01 00:00:00	NULL	NULL	NULL	P93	NULL	Perf 93	444.96	0.00	1	0	0	0	NULL	0	0	NULL	185	NULL	NULL	NULL
51	94	94	401016	0	Perf 401016	2018-04-08 00:00:00	NULL	NULL	NULL	P94	NULL	Perf 94	481.09	0.00	1	0	0	0	NULL	0	0	NULL	187	NULL	NULL	NULL
51	94	94	512000	0	Perf 512000	2018-04-08 00:00:00	NULL	NULL	NULL	P94	NULL	Perf 94	0.00	481.09	1	0	0	0	NULL	0	0	NULL	188	NULL	NULL	NULL
51	99	99	411018	0	Perf 411018	2018-03-15 00:00:00	NULL	NULL	NULL	P99	NULL	Perf 99	0.00	666.74	1	0	0	0	NULL	0	0	NULL	198	NULL	NULL	NULL
51	99	99	530000	0	Perf 530000	2018-03-15 00:00:00	NULL	NULL	NULL	P99	NULL	Perf 99	666.74	0.00	1	0	0	0	NULL	0	0	NULL	197	NULL	NULL	NULL
60	104	104	401026	0	Perf 401026	2018-02-22 00:00:00	NULL	NULL	NULL	P104	NULL	Perf 104	0.00	851.39	1	0	0	0	NULL	0	0	NULL	208	NULL	NULL	NULL
60	104	104	606100	0	Perf 606100	2018-02-22 00:00:00	NULL	NULL	NULL	P104	NULL	Perf 104	851.39	0.00	1	0	0	0	NULL	0	0	NULL	207	NULL	NULL	NULL
60	110	110	401006	0	Perf 401006	2018-02-08 00:00:00	NULL	NULL	NULL	P110	NULL	Perf 110	0.00	83.17	1	0	0	0	NULL	0	0	NULL	220	NULL	NULL	NULL
60	110	110	606100	0	Perf 606100	2018-02-08 00:00:00	NULL	NULL	NULL	P110	NULL	Perf 110	83.17	0.00	1	0	0	0	NULL	0	0	NULL	219	NULL	NULL	NULL
60	116	116	401012	0	Perf 401012	2018-02-22 00:00:00	NULL	NULL	NULL	P116	NULL	Perf 116	0.00	305.95	1	0	0	0	NULL	0	0	NULL	232	NULL	NULL	NULL
60	116	116	606100	0	Perf 606100	2018-02-22 00:00:00	NULL	NULL	NULL	P116	NULL	Perf 116	305.95	0.00	1	0	0	0	NULL	0	0	NULL	231	NULL	NULL	NULL
60	122	122	401018	0	Perf 401018	2018-02-08 00:00:00	NULL	NULL	NULL	P122	NULL	Perf 122	0.00	527.73	1	0	0	0	NULL	0	0	NULL	244	NULL	NULL	NULL
60	122	122	606100	0	Perf 606100	2018-02-08 00:00:00	NULL	NULL	NULL	P122	NULL	Perf 122	527.73	0.00	1	0	0	0	NULL	0	0	NULL	243	NULL	NULL	NULL
60	128	128	401024	0	Perf 401024	2018-02-22 00:00:00	NULL	NULL	NULL	P128	NULL	Perf 128	0.00	749.51	1	0	0	0	NULL	0	0	NULL	256	NULL	NULL	NULL
60	128	128	606100	0	Perf 606100	2018-02-22 00:00:00	NULL	NULL	NULL	P128	NULL	Perf 128	749.51	0.00	1	0	0	0	NULL	0	0	NULL	255	NULL	NULL	NULL
60	134	134	401004	0	Perf 401004	2018-02-08 00:00:00	NULL	NULL	NULL	P134	NULL	Perf 134	0.00	971.29	1	0	0	0	NULL	0	0	NULL	268	NULL	NULL	NULL
60	134	134	606100	0	Perf 606100	2018-02-08 00:00:00	NULL	NULL	NULL	P134	NULL	Perf 134	971.29	0.00	1	0	0	0	NULL	0	0	NULL	267	NULL	NULL	NULL
60	14	14	401014	0	Perf 401014	2018-02-08 00:00:00	NULL	NULL	NULL	P14	NULL	Perf 14	0.00	491.69	1	0	0	0	NULL	0	0	NULL	28	NULL	NULL	NULL
60	14	14	606100	0	Perf 606100	2018-02-08 00:00:00	NULL	NULL	NULL	P14	NULL	Perf 14	491.69	0.00	1	0	0	0	NULL	0	0	NULL	27	NULL	NULL	NULL
60	140	140	401010	0	Perf 401010	2018-02-22 00:00:00	NULL	NULL	NULL	P140	NULL	Perf 140	0.00	203.07	1	0	0	0	NULL	0	0	NULL	280	NULL	NULL	NULL
60	140	140	606100	0	Perf 606100	2018-02-22 00:00:00	NULL	NULL	NULL	P140	NULL	Perf 140	203.07	0.00	1	0	0	0	NULL	0	0	NULL	279	NULL	NULL	NULL
60	146	146	401016	0	Perf 401016	2018-02-08 00:00:00	NULL	NULL	NULL	P146	NULL	Perf 146	0.00	425.85	1	0	0	0	NULL	0	0	NULL	292	NULL	NULL	NULL
60	146	146	606100	0	Perf 606100	2018-02-08 00:00:00	NULL	NULL	NULL	P146	NULL	Perf 146	425.85	0.00	1	0	0	0	NULL	0	0	NULL	291	NULL	NULL	NULL
60	152	152	401022	0	Perf 401022	2018-02-22 00:00:00	NULL	NULL	NULL	P152	NULL	Perf 152	0.00	647.63	1	0	0	0	NULL	0	0	NULL	304	NULL	NULL	NULL
60	152	152	606100	0	Perf 606100	2018-02-22 00:00:00	NULL	NULL	NULL	P152	NULL	Perf 152	647.63	0.00	1	0	0	0	NULL	0	0	NULL	303	NULL	NULL	NULL
60	158	158	401002	0	Perf 401002	2018-02-08 00:00:00	NULL	NULL	NULL	P158	NULL	Perf 158	0.00	869.41	1	0	0	0	NULL	0	0	NULL	316	NULL	NULL	NULL
60	158	158	606100	0	Perf 606100	2018-02-08 00:00:00	NULL	NULL	NULL	P158	NULL	Perf 158	869.41	0.00	1	0	0	0	NULL	0	0	NULL	315	NULL	NULL	NULL
60	164	164	401008	0	Perf 401008	2018-02-22 00:00:00	NULL	NULL	NULL	P164	NULL	Perf 164	0.00	101.19	1	0	0	0	NULL	0	0	NULL	328	NULL	NULL	NULL
60	164	164	606100	0	Perf 606100	2018-02-22 00:00:00	NULL	NULL	NULL	P164	NULL	Perf 164	101.19	0.00	1	0	0	0	NULL	0	0	NULL	327	NULL	NULL	NULL
60	170	170	401014	0	Perf 401014	2018-02-08 00:00:00	NULL	NULL	NULL	P170	NULL	Perf 170	0.00	323.97	1	0	0	0	NULL	0	0	NULL	340	NULL	NULL	NULL
60	170	170	606100	0	Perf 606100	2018-02-08 00:00:00	NULL	NULL	NULL	P170	NULL	Perf 170	323.97	0.00	1	0	0	0	NULL	0	0	NULL	339	NULL	NULL	NULL
60	176	176	401020	0	Perf 401020	2018-02-22 00:00:00	NULL	NULL	NULL	P176	NULL	Perf 176	0.00	545.75	1	0	0	0	NULL	0	0	NULL	352	NULL	NULL	NULL
60	176	176	606100	0	Perf 606100	2018-02-22 00:00:00	NULL	NULL	NULL	P176	NULL	Perf 176	545.75	0.00	1	0	0	0	NULL	0	0	NULL	351	NULL	NULL	NULL
60	182	182	401026	0	Perf 401026	2018-02-08 00:00:00	NULL	NULL	NULL	P182	NULL	Perf 182	0.00	767.53	1	0	0	0	NULL	0	0	NULL	364	NULL	NULL	NULL
60	182	182	606100	0	Perf 606100	2018-02-08 00:00:00	NULL	NULL	NULL	P182	NULL	Perf 182	767.53	0.00	1	0	0	0	NULL	0	0	NULL	363	NULL	NULL	NULL
60	188	188	401006	0	Perf 401006	2018-02-22 00:00:00	NULL	NULL	NULL	P188	NULL	Perf 188	0.00	989.31	1	0	0	0	NULL	0	0	NULL	376	NULL	NULL	NULL
60	188	188	606100	0	Perf 606100	2018-02-22 00:00:00	NULL	NULL	NULL	P188	NULL	Perf 188	989.31	0.00	1	0	0	0	NULL	0	0	NULL	375	NULL	NULL	NULL
60	194	194	401012	0	Perf 401012	2018-02-08 00:00:00	NULL	NULL	NULL	P194	NULL	Perf 194	0.00	221.09	1	0	0	0	NULL	0	0	NULL	388	NULL	NULL	NULL
60	194	194	606100	0	Perf 606100	2018-02-08 00:00:00	NULL	NULL	NULL	P194	NULL	Perf 194	221.09	0.00	1	0	0	0	NULL	0	0	NULL	387	NULL	NULL	NULL
60	2	2	401002	0	Perf 401002	2018-02-08 00:00:00	NULL	NULL	NULL	P2	NULL	Perf 2	0.00	47.13	1	0	0	0	NULL	0	0	NULL	4	NULL	NULL	NULL
60	2	2	606100	0	Perf 606100	2018-02-08 00:00:00	NULL	NULL	NULL	P2	NULL	Perf 2	47.13	0.00	1	0	0	0	NULL	0	0	NULL	3	NULL	NULL	NULL
60	20	20	401020	0	Perf 401020	2018-02-22 00:00:00	NULL	NULL	NULL	P20	NULL	Perf 20	0.00	713.47	1	0	0	0	NULL	0	0	NULL	40	NULL	NULL	NULL
60	20	20	606100	0	Perf 606100	2018-02-22 00:00:00	NULL	NULL	NULL	P20	NULL	Perf 20	713.47	0.00	1	0	0	0	NULL	0	0	NULL	39	NULL	NULL	NULL
60	200	0	401018	0	Perf 401018	2018-02-22 00:00:00	NULL	NULL	NULL	P200	NULL	Perf 200	0.00	443.87	0	0	0	0	NULL	0	0	NULL	400	NULL	NULL	NULL
60	200	0	606100	0	Perf 606100	2018-02-22 00:00:00	NULL	NULL	NULL	P200	NULL	Perf 200	443.87	0.00	0	0	0	0	NULL	0	0	NULL	399	NULL	NULL	NULL
60	206	206	401024	0	Perf 401024	2018-02-08 00:00:00	NULL	NULL	NULL	P206	NULL	Perf 206	0.00	665.65	1	0	0	0	NULL	0	0	NULL	412	NULL	NULL	NULL
60	206	206	606100	0	Perf 606100	2018-02-08 00:00:00	NULL	NULL	NULL	P206	NULL	Perf 206	665.65	0.00	1	0	0	0	NULL	0	0	NULL	411	NULL	NULL	NULL
60	212	212	401004	0	Perf 401004	2018-02-22 00:00:00	NULL	NULL	NULL	P212	NULL	Perf 212	0.00	887.43	1	0	0	0	NULL	0	0	NULL	424	NULL	NULL	NULL
60	212	212	606100	0	Perf 606100	2018-02-22 00:00:00	NULL	NULL	NULL	P212	NULL	Perf 212	887.43	0.00	1	0	0	0	NULL	0	0	NULL	423	NULL	NULL	NULL
60	218	218	401010	0	Perf 401010	2018-02-08 00:00:00	NULL	NULL	NULL	P218	NULL	Perf 218	0.00	119.21	1	0	0	0	NULL	0	0	NULL	436	NULL	NULL	NULL
60	218	218	606100	0	Perf 606100	2018-02-08 00:00:00	NULL	NULL	NULL	P218	NULL	Perf 218	119.21	0.00	1	0	0	0	NULL	0	0	NULL	435	NULL	NULL	NULL
60	224	224	401016	0	Perf 401016	2018-02-22 00:00:00	NULL	NULL	NULL	P224	NULL	Perf 224	0.00	341.99	1	0	0	0	NULL	0	0	NULL	448	NULL	NULL	NULL
60	224	224	606100	0	Perf 606100	2018-02-22 00:00:00	NULL	NULL	NULL	P224	NULL	Perf 224	341.99	0.00	1	0	0	0	NULL	0	0	NULL	447	NULL	NULL	NULL
60	230	230	401022	0	Perf 401022	2018-02-08 00:00:00	NULL	NULL	NULL	P230	NULL	Perf 230	0.00	563.77	1	0	0	0	NULL	0	0	NULL	460	NULL	NULL	NULL
60	230	230	606100	0	Perf 606100	2018-02-08 00:00:00	NULL	NULL	NULL	P230	NULL	Perf 230	563.77	0.00	1	0	0	0	NULL	0	0	NULL	459	NULL	NULL	NULL
60	236	236	401002	0	Perf 401002	2018-02-22 00:00:00	NULL	NULL	NULL	P236	NULL	Perf 236	0.00	785.55	1	0	0	0	NULL	0	0	NULL	472	NULL	NULL	NULL
60	236	236	606100	0	Perf 606100	2018-02-22 00:00:00	NULL	NULL	NULL	P236	NULL	Perf 236	785.55	0.00	1	0	0	0	NULL	0	0	NULL	471	NULL	NULL	NULL
60	242	242	401008	0	Perf 401008	2018-02-08 00:00:00	NULL	NULL	NULL	P242	NULL	Perf 242	0.00	17.33	1	0	0	0	NULL	0	0	NULL	484	NULL	NULL	NULL
60	242	242	606100	0	Perf 606100	2018-02-08 00:00:00	NULL	NULL	NULL	P242	NULL	Perf 242	17.33	0.00	1	0	0	0	NULL	0	0	NULL	483	NULL	NULL	NULL
60	248	248	401014	0	Perf 401014	2018-02-22 00:00:00	NULL	NULL	NULL	P248	NULL	Perf 248	0.00	239.11	1	0	0	0	NULL	0	0	NULL	496	NULL	NULL	NULL
60	248	248	606100	0	Perf 606100	2018-02-22 00:00:00	NULL	NULL	NULL	P248	NULL	Perf 248	239.11	0.00	1	0	0	0	NULL	0	0	NULL	495	NULL	NULL	NULL
60	254	254	401020	0	Perf 401020	2018-02-08 00:00:00	NULL	NULL	NULL	P254	NULL	Perf 254	0.00	461.89	1	0	0	0	NULL	0	0	NULL	508	NULL	NULL	NULL
60	254	254	606100	0	Perf 606100	2018-02-08 00:00:00	NULL	NULL	NULL	P254	NULL	Perf 254	461.89	0.00	1	0	0	0	NULL	0	0	NULL	507	NULL	NULL	NULL
60	26	26	401026	0	Perf 401026	2018-02-08 00:00:00	NULL	NULL	NULL	P26	NULL	Perf 26	0.00	935.25	1	0	0	0	NULL	0	0	NULL	52	NULL	NULL	NULL
60	26	26	606100	0	Perf 606100	2018-02-08 00:00:00	NULL	NULL	NULL	P26	NULL	Perf 26	935.25	0.00	1	0	0	0	NULL	0	0	NULL	51	NULL	NULL	NULL
60	260	260	401026	0	Perf 401026	2018-02-22 00:00:00	NULL	NULL	NULL	P260	NULL	Perf 260	0.00	683.67	1	0	0	0	NULL	0	0	NULL	520	NULL	NULL	NULL
60	260	260	606100	0	Perf 606100	2018-02-22 00:00:00	NULL	NULL	NULL	P260	NULL	Perf 260	683.67	0.00	1	0	0	0	NULL	0	0	NULL	519	NULL	NULL	NULL
60	266	266	401006	0	Perf 401006	2018-02-08 00:00:00	NULL	NULL	NULL	P266	NULL	Perf 266	0.00	905.45	1	0	0	0	NULL	0	0	NULL	532	NULL	NULL	NULL
60	266	266	606100	0	Perf 606100	2018-02-08 00:00:00	NULL	NULL	NULL	P266	NULL	Perf 266	905.45	0.00	1	0	0	0	NULL	0	0	NULL	531	NULL	NULL	NULL
60	272	272	401012	0	Perf 401012	2018-02-22 00:00:00	NULL	NULL	NULL	P272	NULL	Perf 272	0.00	137.23	1	0	0	0	NULL	0	0	NULL	544	NULL	NULL	NULL
60	272	272	606100	0	Perf 606100	2018-02-22 00:00:00	NULL	NULL	NULL	P272	NULL	Perf 272	137.23	0.00	1	0	0	0	NULL	0	0	NULL	543	NULL	NULL	NULL
60	278	278	401018	0	Perf 401018	2018-02-08 00:00:00	NULL	NULL	NULL	P278	NULL	Perf 278	0.00	359.01	1	0	0	0	NULL	0	0	NULL	556	NULL	NULL	NULL
60	278	278	606100	0	Perf 606100	2018-02-08 00:00:00	NULL	NULL	NULL	P278	NULL	Perf 278	359.01	0.00	1	0	0	0	NULL	0	0	NULL	555	NULL	NULL	NULL
60	284	284	401024	0	Perf 401024	2018-02-22 00:00:00	NULL	NULL	NULL	P284	NULL	Perf 284	0.00	581.79	1	0	0	0	NULL	0	0	NULL	568	NULL	NULL	NULL
60	284	284	606100	0	Perf 606100	2018-02-22 00:00:00	NULL	NULL	NULL	P284	NULL	Perf 284	581.79	0.00	1	0	0	0	NULL	0	0	NULL	567	NULL	NULL	NULL
60	290	290	401004	0	Perf 401004	2018-02-08 00:00:00	NULL	NULL	NULL	P290	NULL	Perf 290	0.00	803.57	1	0	0	0	NULL	0	0	NULL	580	NULL	NULL	NULL
60	290	290	606100	0	Perf 606100	2018-02-08 00:00:00	NULL	NULL	NULL	P290	NULL	Perf 290	803.57	0.00	1	0	0	0	NULL	0	0	NULL	579	NULL	NULL	NULL
60	296	296	401010	0	Perf 401010	2018-02-22 00:00:00	NULL	NULL	NULL	P296	NULL	Perf 296	0.00	35.35	1	0	0	0	NULL	0	0	NULL	592	NULL	NULL	NULL
60	296	296	606100	0	Perf 606100	2018-02-22 00:00:00	NULL	NULL	NULL	P296	NULL	Perf 296	35.35	0.00	1	0	0	0	NULL	0	0	NULL	591	NULL	NULL	NULL
60	302	302	401016	0	Perf 401016	2018-02-08 00:00:00	NULL	NULL	NULL	P302	NULL	Perf 302	0.00	257.13	1	0	0	0	NULL	0	0	NULL	604	NULL	NULL	NULL
60	302	302	606100	0	Perf 606100	2018-02-08 00:00:00	NULL	NULL	NULL	P302	NULL	Perf 302	257.13	0.00	1	0	0	0	NULL	0	0	NULL	603	NULL	NULL	NULL
60	308	308	401022	0	Perf 401022	2018-02-22 00:00:00	NULL	NULL	NULL	P308	NULL	Perf 308	0.00	479.91	1	0	0	0	NULL	0	0	NULL	616	NULL	NULL	NULL
60	308	308	606100	0	Perf 606100	2018-02-22 00:00:00	NULL	NULL	NULL	P308	NULL	Perf 308	479.91	0.00	1	0	0	0	NULL	0	0	NULL	615	NULL	NULL	NULL
60	314	314	401002	0	Perf 401002	2018-02-08 00:00:00	NULL	NULL	NULL	P314	NULL	Perf 314	0.00	701.69	1	0	0	0	NULL	0	0	NULL	628	NULL	NULL	NULL
60	314	314	606100	0	Perf 606100	2018-02-08 00:00:00	NULL	NULL	NULL	P314	NULL	Perf 314	701.69	0.00	1	0	0	0	NULL	0	0	NULL	627	NULL	NULL	NULL
60	32	32	401006	0	Perf 401006	2018-02-22 00:00:00	NULL	NULL	NULL	P32	NULL	Perf 32	0.00	167.03	1	0	0	0	NULL	0	0	NULL	64	NULL	NULL	NULL
60	32	32	606100	0	Perf 606100	2018-02-22 00:00:00	NULL	NULL	NULL	P32	NULL	Perf 32	167.03	0.00	1	0	0	0	NULL	0	0	NULL	63	NULL	NULL	NULL
60	320	320	401008	0	Perf 401008	2018-02-22 00:00:00	NULL	NULL	NULL	P320	NULL	Perf 320	0.00	923.47	1	0	0	0	NULL	0	0	NULL	640	NULL	NULL	NULL
60	320	320	606100	0	Perf 606100	2018-02-22 00:00:00	NULL	NULL	NULL	P320	NULL	Perf 320	923.47	0.00	1	0	0	0	NULL	0	0	NULL	639	NULL	NULL	NULL
60	326	326	401014	0	Perf 401014	2018-02-08 00:00:00	NULL	NULL	NULL	P326	NULL	Perf 326	0.00	155.25	1	0	0	0	NULL	0	0	NULL	652	NULL	NULL	NULL
60	326	326	606100	0	Perf 606100	2018-02-08 00:00:00	NULL	NULL	NULL	P326	NULL	Perf 326	155.25	0.00	1	0	0	0	NULL	0	0	NULL	651	NULL	NULL	NULL
60	332	332	401020	0	Perf 401020	2018-02-22 00:00:00	NULL	NULL	NULL	P332	NULL	Perf 332	0.00	377.03	1	0	0	0	NULL	0	0	NULL	664	NULL	NULL	NULL
60	332	332	606100	0	Perf 606100	2018-02-22 00:00:00	NULL	NULL	NULL	P332	NULL	Perf 332	377.03	0.00	1	0	0	0	NULL	0	0	NULL	663	NULL	NULL	NULL
60	338	338	401026	0	Perf 401026	2018-02-08 00:00:00	NULL	NULL	NULL	P338	NULL	Perf 338	0.00	599.81	1	0	0	0	NULL	0	0	NULL	676	NULL	NULL	NULL
60	338	338	606100	0	Perf 606100	2018-02-08 00:00:00	NULL	NULL	NULL	P338	NULL	Perf 338	599.81	0.00	1	0	0	0	NULL	0	0	NULL	675	NULL	NULL	NULL
60	344	344	401006	0	Perf 401006	2018-02-22 00:00:00	NULL	NULL	NULL	P344	NULL	Perf 344	0.00	821.59	1	0	0	0	NULL	0	0	NULL	688	NULL	NULL	NULL
60	344	344	606100	0	Perf 606100	2018-02-22 00:00:00	NULL	NULL	NULL	P344	NULL	Perf 344	821.59	0.00	1	0	0	0	NULL	0	0	NULL	687	NULL	NULL	NULL
60	350	350	401012	0	Perf 401012	2018-02-08 00:00:00	NULL	NULL	NULL	P350	NULL	Perf 350	0.00	53.37	1	0	0	0	NULL	0	0	NULL	700	NULL	NULL	NULL
60	350	350	606100	0	Perf 606100	2018-02-08 00:00:00	NULL	NULL	NULL	P350	NULL	Perf 350	53.37	0.00	1	0	0	0	NULL	0	0	NULL	699	NULL	NULL	NULL
60	356	356	401018	0	Perf 401018	2018-02-22 00:00:00	NULL	NULL	NULL	P356	NULL	Perf 356	0.00	275.15	1	0	0	0	NULL	0	0	NULL	712	NULL	NULL	NULL
60	356	356	606100	0	Perf 606100	2018-02-22 00:00:00	NULL	NULL	NULL	P356	NULL	Perf 356	275.15	0.00	1	0	0	0	NULL	0	0	NULL	711	NULL	NULL	NULL
60	362	362	401024	0	Perf 401024	2018-02-08 00:00:00	NULL	NULL	NULL	P362	NULL	Perf 362	0.00	497.93	1	0	0	0	NULL	0	0	NULL	724	NULL	NULL	NULL
60	362	362	606100	0	Perf 606100	2018-02-08 00:00:00	NULL	NULL	NULL	P362	NULL	Perf 362	497.93	0.00	1	0	0	0	NULL	0	0	NULL	723	NULL	NULL	NULL
60	368	368	401004	0	Perf 401004	2018-02-22 00:00:00	NULL	NULL	NULL	P368	NULL	Perf 368	0.00	719.71	1	0	0	0	NULL	0	0	NULL	736	NULL	NULL	NULL
60	368	368	606100	0	Perf 606100	2018-02-22 00:00:00	NULL	NULL	NULL	P368	NULL	Perf 368	719.71	0.00	1	0	0	0	NULL	0	0	NULL	735	NULL	NULL	NULL
60	374	374	401010	0	Perf 401010	2018-02-08 00:00:00	NULL	NULL	NULL	P374	NULL	Perf 374	0.00	941.49	1	0	0	0	NULL	0	0	NULL	748	NULL	NULL	NULL
60	374	374	606100	0	Perf 606100	2018-02-08 00:00:00	NULL	NULL	NULL	P374	NULL	Perf 374	941.49	0.00	1	0	0	0	NULL	0	0	NULL	747	NULL	NULL	NULL
60	38	38	401012	0	Perf 401012	2018-02-08 00:00:00	NULL	NULL	NULL	P38	NULL	Perf 38	0.00	389.81	1	0	0	0	NULL	0	0	NULL	76	NULL	NULL	NULL
60	38	38	606100	0	Perf 606100	2018-02-08 00:00:00	NULL	NULL	NULL	P38	NULL	Perf 38	389.81	0.00	1	0	0	0	NULL	0	0	NULL	75	NULL	NULL	NULL
60	380	380	401016	0	Perf 401016	2018-02-22 00:00:00	NULL	NULL	NULL	P380	NULL	Perf 380	0.00	173.27	1	0	0	0	NULL	0	0	NULL	760	NULL	NULL	NULL
60	380	380	606100	0	Perf 606100	2018-02-22 00:00:00	NULL	NULL	NULL	P380	NULL	Perf 380	173.27	0.00	1	0	0	0	NULL	0	0	NULL	759	NULL	NULL	NULL
60	386	386	401022	0	Perf 401022	2018-02-08 00:00:00	NULL	NULL	NULL	P386	NULL	Perf 386	0.00	395.05	1	0	0	0	NULL	0	0	NULL	772	NULL	NULL	NULL
60	386	386	606100	0	Perf 606100	2018-02-08 00:00:00	NULL	NULL	NULL	P386	NULL	Perf 386	395.05	0.00	1	0	0	0	NULL	0	0	NULL	771	NULL	NULL	NULL
60	392	392	401002	0	Perf 401002	2018-02-22 00:00:00	NULL	NULL	NULL	P392	NULL	Perf 392	0.00	617.83	1	0	0	0	NULL	0	0	NULL	784	NULL	NULL	NULL
60	392	392	606100	0	Perf 606100	2018-02-22 00:00:00	NULL	NULL	NULL	P392	NULL	Perf 392	617.83	0.00	1	0	0	0	NULL	0	0	NULL	783	NULL	NULL	NULL
60	398	398	401008	0	Perf 401008	2018-02-08 00:00:00	NULL	NULL	NULL	P398	NULL	Perf 398	0.00	839.61	1	0	0	0	NULL	0	0	NULL	796	NULL	NULL	NULL
60	398	398	606100	0	Perf 606100	2018-02-08 00:00:00	NULL	NULL	NULL	P398	NULL	Perf 398	839.61	0.00	1	0	0	0	NULL	0	0	NULL	795	NULL	NULL	NULL
60	404	404	401014	0	Perf 401014	2018-02-22 00:00:00	NULL	NULL	NULL	P404	NULL	Perf 404	0.00	71.39	1	0	0	0	NULL	0	0	NULL	808	NULL	NULL	NULL
60	404	404	606100	0	Perf 606100	2018-02-22 00:00:00	NULL	NULL	NULL	P404	NULL	Perf 404	71.39	0.00	1	0	0	0	NULL	0	0	NULL	807	NULL	NULL	NULL
60	410	410	401020	0	Perf 401020	2018-02-08 00:00:00	NULL	NULL	NULL	P410	NULL	Perf 410	0.00	293.17	1	0	0	0	NULL	0	0	NULL	820	NULL	NULL	NULL
60	410	410	606100	0	Perf 606100	2018-02-08 00:00:00	NULL	NULL	NULL	P410	NULL	Perf 410	293.17	0.00	1	0	0	0	NULL	0	0	NULL	819	NULL	NULL	NULL
60	416	416	401026	0	Perf 401026	2018-02-22 00:00:00	NULL	NULL	NULL	P416	NULL	Perf 416	0.00	515.95	1	0	0	0	NULL	0	0	NULL	832	NULL	NULL	NULL
60	416	416	606100	0	Perf 606100	2018-02-22 00:00:00	NULL	NULL	NULL	P416	NULL	Perf 416	515.95	0.00	1	0	0	0	NULL	0	0	NULL	831	NULL	NULL	NULL
60	422	422	401006	0	Perf 401006	2018-02-08 00:00:00	NULL	NULL	NULL	P422	NULL	Perf 422	0.00	737.73	1	0	0	0	NULL	0	0	NULL	844	NULL	NULL	NULL
60	422	422	606100	0	Perf 606100	2018-02-08 00:00:00	NULL	NULL	NULL	P422	NULL	Perf 422	737.73	0.00	1	0	0	0	NULL	0	0	NULL	843	NULL	NULL	NULL
60	428	428	401012	0	Perf 401012	2018-02-22 00:00:00	NULL	NULL	NULL	P428	NULL	Perf 428	0.00	959.51	1	0	0	0	NULL	0	0	NULL	856	NULL	NULL	NULL
60	428	428	606100	0	Perf 606100	2018-02-22 00:00:00	NULL	NULL	NULL	P428	NULL	Perf 428	959.51	0.00	1	0	0	0	NULL	0	0	NULL	855	NULL	NULL	NULL
60	434	434	401018	0	Perf 401018	2018-02-08 00:00:00	NULL	NULL	NULL	P434	NULL	Perf 434	0.00	191.29	1	0	0	0	NULL	0	0	NULL	868	NULL	NULL	NULL
60	434	434	606100	0	Perf 606100	2018-02-08 00:00:00	NULL	NULL	NULL	P434	NULL	Perf 434	191.29	0.00	1	0	0	0	NULL	0	0	NULL	867	NULL	NULL	NULL
60	44	44	401018	0	Perf 401018	2018-02-22 00:00:00	NULL	NULL	NULL	P44	NULL	Perf 44	0.00	611.59	1	0	0	0	NULL	0	0	NULL	88	NULL	NULL	NULL
60	44	44	606100	0	Perf 606100	2018-02-22 00:00:00	NULL	NULL	NULL	P44	NULL	Perf 44	611.59	0.00	1	0	0	0	NULL	0	0	NULL	87	NULL	NULL	NULL
60	440	440	401024	0	Perf 401024	2018-02-22 00:00:00	NULL	NULL	NULL	P440	NULL	Perf 440	0.00	413.07	1	0	0	0	NULL	0	0	NULL	880	NULL	NULL	NULL
60	440	440	606100	0	Perf 606100	2018-02-22 00:00:00	NULL	NULL	NULL	P440	NULL	Perf 440	413.07	0.00	1	0	0	0	NULL	0	0	NULL	879	NULL	NULL	NULL
60	446	446	401004	0	Perf 401004	2018-02-08 00:00:00	NULL	NULL	NULL	P446	NULL	Perf 446	0.00	635.85	1	0	0	0	NULL	0	0	NULL	892	NULL	NULL	NULL
60	446	446	606100	0	Perf 606100	2018-02-08 00:00:00	NULL	NULL	NULL	P446	NULL	Perf 446	635.85	0.00	1	0	0	0	NULL	0	0	NULL	891	NULL	NULL	NULL
60	452	452	401010	0	Perf 401010	2018-02-22 00:00:00	NULL	NULL	NULL	P452	NULL	Perf 452	0.00	857.63	1	0	0	0	NULL	0	0	NULL	904	NULL	NULL	NULL
60	452	452	606100	0	Perf 606100	2018-02-22 00:00:00	NULL	NULL	NULL	P452	NULL	Perf 452	857.63	0.00	1	0	0	0	NULL	0	0	NULL	903	NULL	NULL	NULL
60	458	458	401016	0	Perf 401016	2018-02-08 00:00:00	NULL	NULL	NULL	P458	NULL	Perf 458	0.00	89.41	1	0	0	0	NULL	0	0	NULL	916	NULL	NULL	NULL
60	458	458	606100	0	Perf 606100	2018-02-08 00:00:00	NULL	NULL	NULL	P458	NULL	Perf 458	89.41	0.00	1	0	0	0	NULL	0	0	NULL	915	NULL	NULL	NULL
60	464	464	401022	0	Perf 401022	2018-02-22 00:00:00	NULL	NULL	NULL	P464	NULL	Perf 464	0.00	311.19	1	0	0	0	NULL	0	0	NULL	928	NULL	NULL	NULL
60	464	464	606100	0	Perf 606100	2018-02-22 00:00:00	NULL	NULL	NULL	P464	NULL	Perf 464	311.19	0.00	1	0	0	0	NULL	0	0	NULL	927	NULL	NULL	NULL
60	470	470	401002	0	Perf 401002	2018-02-08 00:00:00	NULL	NULL	NULL	P470	NULL	Perf 470	0.00	533.97	1	0	0	0	NULL	0	0	NULL	940	NULL	NULL	NULL
60	470	470	606100	0	Perf 606100	2018-02-08 00:00:00	NULL	NULL	NULL	P470	NULL	Perf 470	533.97	0.00	1	0	0	0	NULL	0	0	NULL	939	NULL	NULL	NULL
60	476	476	401008	0	Perf 401008	2018-02-22 00:00:00	NULL	NULL	NULL	P476	NULL	Perf 476	0.00	755.75	1	0	0	0	NULL	0	0	NULL	952	NULL	NULL	NULL
60	476	476	606100	0	Perf 606100	2018-02-22 00:00:00	NULL	NULL	NULL	P476	NULL	Perf 476	755.75	0.00	1	0	0	0	NULL	0	0	NULL	951	NULL	NULL	NULL
60	482	482	401014	0	Perf 401014	2018-02-08 00:00:00	NULL	NULL	NULL	P482	NULL	Perf 482	0.00	977.53	1	0	0	0	NULL	0	0	NULL	964	NULL	NULL	NULL
60	482	482	606100	0	Perf 606100	2018-02-08 00:00:00	NULL	NULL	NULL	P482	NULL	Perf 482	977.53	0.00	1	0	0	0	NULL	0	0	NULL	963	NULL	NULL	NULL
60	488	488	401020	0	Perf 401020	2018-02-22 00:00:00	NULL	NULL	NULL	P488	NULL	Perf 488	0.00	209.31	1	0	0	0	NULL	0	0	NULL	976	NULL	NULL	NULL
60	488	488	606100	0	Perf 606100	2018-02-22 00:00:00	NULL	NULL	NULL	P488	NULL	Perf 488	209.31	0.00	1	0	0	0	NULL	0	0	NULL	975	NULL	NULL	NULL
60	494	494	401026	0	Perf 401026	2018-02-08 00:00:00	NULL	NULL	NULL	P494	NULL	Perf 494	0.00	431.09	1	0	0	0	NULL	0	0	NULL	988	NULL	NULL	NULL
60	494	494	606100	0	Perf 606100	2018-02-08 00:00:00	NULL	NULL	NULL	P494	NULL	Perf 494	431.09	0.00	1	0	0	0	NULL	0	0	NULL	987	NULL	NULL	NULL
60	50	50	401024	0	Perf 401024	2018-02-08 00:00:00	NULL	NULL	NULL	P50	NULL	Perf 50	0.00	833.37	1	0	0	0	NULL	0	0	NULL	100	NULL	NULL	NULL
60	50	50	606100	0	Perf 606100	2018-02-08 00:00:00	NULL	NULL	NULL	P50	NULL	Perf 50	833.37	0.00	1	0	0	0	NULL	0	0	NULL	99	NULL	NULL	NULL
60	500	500	401006	0	Perf 401006	2018-02-22 00:00:00	NULL	NULL	NULL	P500	NULL	Perf 500	0.00	653.87	1	0	0	0	NULL	0	0	NULL	1000	NULL	NULL	NULL
60	500	500	606100	0	Perf 606100	2018-02-22 00:00:00	NULL	NULL	NULL	P500	NULL	Perf 500	653.87	0.00	1	0	0	0	NULL	0	0	NULL	999	NULL	NULL	NULL
60	56	56	401004	0	Perf 401004	2018-02-22 00:00:00	NULL	NULL	NULL	P56	NULL	Perf 56	0.00	65.15	1	0	0	0	NULL	0	0	NULL	112	NULL	NULL	NULL
60	56	56	606100	0	Perf 606100	2018-02-22 00:00:00	NULL	NULL	NULL	P56	NULL	Perf 56	65.15	0.00	1	0	0	0	NULL	0	0	NULL	111	NULL	NULL	NULL
60	62	62	401010	0	Perf 401010	2018-02-08 00:00:00	NULL	NULL	NULL	P62	NULL	Perf 62	0.00	287.93	1	0	0	0	NULL	0	0	NULL	124	NULL	NULL	NULL
60	62	62	606100	0	Perf 606100	2018-02-08 00:00:00	NULL	NULL	NULL	P62	NULL	Perf 62	287.93	0.00	1	0	0	0	NULL	0	0	NULL	123	NULL	NULL	NULL
60	68	68	401016	0	Perf 401016	2018-02-22 00:00:00	NULL	NULL	NULL	P68	NULL	Perf 68	0.00	509.71	1	0	0	0	NULL	0	0	NULL	136	NULL	NULL	NULL
60	68	68	606100	0	Perf 606100	2018-02-22 00:00:00	NULL	NULL	NULL	P68	NULL	Perf 68	509.71	0.00	1	0	0	0	NULL	0	0	NULL	135	NULL	NULL	NULL
60	74	74	401022	0	Perf 401022	2018-02-08 00:00:00	NULL	NULL	NULL	P74	NULL	Perf 74	0.00	731.49	1	0	0	0	NULL	0	0	NULL	148	NULL	NULL	NULL
60	74	74	606100	0	Perf 606100	2018-02-08 00:00:00	NULL	NULL	NULL	P74	NULL	Perf 74	731.49	0.00	1	0	0	0	NULL	0	0	NULL	147	NULL	NULL	NULL
60	8	8	401008	0	Perf 401008	2018-02-22 00:00:00	NULL	NULL	NULL	P8	NULL	Perf 8	0.00	269.91	1	0	0	0	NULL	0	0	NULL	16	NULL	NULL	NULL
60	8	8	606100	0	Perf 606100	2018-02-22 00:00:00	NULL	NULL	NULL	P8	NULL	Perf 8	269.91	0.00	1	0	0	0	NULL	0	0	NULL	15	NULL	NULL	NULL
60	80	80	401002	0	Perf 401002	2018-02-22 00:00:00	NULL	NULL	NULL	P80	NULL	Perf 80	0.00	953.27	1	0	0	0	NULL	0	0	NULL	160	NULL	NULL	NULL
60	80	80	606100	0	Perf 606100	2018-02-22 00:00:00	NULL	NULL	NULL	P80	NULL	Perf 80	953.27	0.00	1	0	0	0	NULL	0	0	NULL	159	NULL	NULL	NULL
60	86	86	401008	0	Perf 401008	2018-02-08 00:00:00	NULL	NULL	NULL	P86	NULL	Perf 86	0.00	185.05	1	0	0	0	NULL	0	0	NULL	172	NULL	NULL	NULL
60	86	86	606100	0	Perf 606100	2018-02-08 00:00:00	NULL	NULL	NULL	P86	NULL	Perf 86	185.05	0.00	1	0	0	0	NULL	0	0	NULL	171	NULL	NULL	NULL
60	92	92	401014	0	Perf 401014	2018-02-22 00:00:00	NULL	NULL	NULL	P92	NULL	Perf 92	0.00	407.83	1	0	0	0	NULL	0	0	NULL	184	NULL	NULL	NULL
60	92	92	606100	0	Perf 606100	2018-02-22 00:00:00	NULL	NULL	NULL	P92	NULL	Perf 92	407.83	0.00	1	0	0	0	NULL	0	0	NULL	183	NULL	NULL	NULL
60	98	98	401020	0	Perf 401020	2018-02-08 00:00:00	NULL	NULL	NULL	P98	NULL	Perf 98	0.00	629.61	1	0	0	0	NULL	0	0	NULL	196	NULL	NULL	NULL
60	98	98	606100	0	Perf 606100	2018-02-08 00:00:00	NULL	NULL	NULL	P98	NULL	Perf 98	629.61	0.00	1	0	0	0	NULL	0	0	NULL	195	NULL	NULL	NULL
70	1	1	411001	0	Perf 411001	2018-01-01 00:00:00	NULL	NULL	NULL	P1	NULL	Perf 1	10.00	0.00	1	0	0	0	NULL	0	0	NULL	1	NULL	NULL	NULL
70	1	1	707000	0	Perf 707000	2018-01-01 00:00:00	NULL	NULL	NULL	P1	NULL	Perf 1	0.00	10.00	1	0	0	0	NULL	0	0	NULL	2	NULL	NULL	NULL
70	103	0	411022	0	Perf 411022	2018-01-15 00:00:00	NULL	NULL	NULL	P103	NULL	Perf 103	814.26	0.00	0	0	0	0	NULL	0	0	NULL	205	NULL	NULL	NULL
70	103	0	707000	0	Perf 707000	2018-01-15 00:00:00	NULL	NULL	NULL	P103	NULL	Perf 103	0.00	814.26	0	0	0	0	NULL	0	0	NULL	206	NULL	NULL	NULL
70	109	109	411001	0	Perf 411001	2018-01-01 00:00:00	NULL	NULL	NULL	P109	NULL	Perf 109	46.04	0.00	1	0	0	0	NULL	0	0	NULL	217	NULL	NULL	NULL
70	109	109	707000	0	Perf 707000	2018-01-01 00:00:00	NULL	NULL	NULL	P109	NULL	Perf 109	0.00	46.04	1	0	0	0	NULL	0	0	NULL	218	NULL	NULL	NULL
70	115	115	411007	0	Perf 411007	2018-01-15 00:00:00	NULL	NULL	NULL	P115	NULL	Perf 115	268.82	0.00	1	0	0	0	NULL	0	0	NULL	229	NULL	NULL	NULL
70	115	115	707000	0	Perf 707000	2018-01-15 00:00:00	NULL	NULL	NULL	P115	NULL	Perf 115	0.00	268.82	1	0	0	0	NULL	0	0	NULL	230	NULL	NULL	NULL
70	121	121	411013	0	Perf 411013	2018-01-01 00:00:00	NULL	NULL	NULL	P121	NULL	Perf 121	490.60	0.00	1	0	0	0	NULL	0	0	NULL	241	NULL	NULL	NULL
70	121	121	707000	0	Perf 707000	2018-01-01 00:00:00	NULL	NULL	NULL	P121	NULL	Perf 121	0.00	490.60	1	0	0	0	NULL	0	0	NULL	242	NULL	NULL	NULL
70	127	127	411019	0	Perf 411019	2018-01-15 00:00:00	NULL	NULL	NULL	P127	NULL	Perf 127	712.38	0.00	1	0	0	0	NULL	0	0	NULL	253	NULL	NULL	NULL
70	127	127	707000	0	Perf 707000	2018-01-15 00:00:00	NULL	NULL	NULL	P127	NULL	Perf 127	0.00	712.38	1	0	0	0	NULL	0	0	NULL	254	NULL	NULL	NULL
70	13	13	411013	0	Perf 411013	2018-01-01 00:00:00	NULL	NULL	NULL	P13	NULL	Perf 13	454.56	0.00	1	0	0	0	NULL	0	0	NULL	25	NULL	NULL	NULL
70	13	13	707000	0	Perf 707000	2018-01-01 00:00:00	NULL	NULL	NULL	P13	NULL	Perf 13	0.00	454.56	1	0	0	0	NULL	0	0	NULL	26	NULL	NULL	NULL
70	133	133	411025	0	Perf 411025	2018-01-01 00:00:00	NULL	NULL	NULL	P133	NULL	Perf 133	934.16	0.00	1	0	0	0	NULL	0	0	NULL	265	NULL	NULL	NULL
70	133	133	707000	0	Perf 707000	2018-01-01 00:00:00	NULL	NULL	NULL	P133	NULL	Perf 133	0.00	934.16	1	0	0	0	NULL	0	0	NULL	266	NULL	NULL	NULL
70	139	139	411004	0	Perf 411004	2018-01-15 00:00:00	NULL	NULL	NULL	P139	NULL	Perf 139	166.94	0.00	1	0	0	0	NULL	0	0	NULL	277	NULL	NULL	NULL
70	139	139	707000	0	Perf 707000	2018-01-15 00:00:00	NULL	NULL	NULL	P139	NULL	Perf 139	0.00	166.94	1	0	0	0	NULL	0	0	NULL	278	NULL	NULL	NULL
70	145	145	411010	0	Perf 411010	2018-01-01 00:00:00	NULL	NULL	NULL	P145	NULL	Perf 145	388.72	0.00	1	0	0	0	NULL	0	0	NULL	289	NULL	NULL	NULL
70	145	145	707000	0	Perf 707000	2018-01-01 00:00:00	NULL	NULL	NULL	P145	NULL	Perf 145	0.00	388.72	1	0	0	0	NULL	0	0	NULL	290	NULL	NULL	NULL
70	151	151	411016	0	Perf 411016	2018-01-15 00:00:00	NULL	NULL	NULL	P151	NULL	Perf 151	610.50	0.00	1	0	0	0	NULL	0	0	NULL	301	NULL	NULL	NULL
70	151	151	707000	0	Perf 707000	2018-01-15 00:00:00	NULL	NULL	NULL	P151	NULL	Perf 151	0.00	610.50	1	0	0	0	NULL	0	0	NULL	302	NULL	NULL	NULL
70	157	157	411022	0	Perf 411022	2018-01-01 00:00:00	NULL	NULL	NULL	P157	NULL	Perf 157	832.28	0.00	1	0	0	0	NULL	0	0	NULL	313	NULL	NULL	NULL
70	157	157	707000	0	Perf 707000	2018-01-01 00:00:00	NULL	NULL	NULL	P157	NULL	Perf 157	0.00	832.28	1	0	0	0	NULL	0	0	NULL	314	NULL	NULL	NULL
70	163	163	411001	0	Perf 411001	2018-01-15 00:00:00	NULL	NULL	NULL	P163	NULL	Perf 163	64.06	0.00	1	0	0	0	NULL	0	0	NULL	325	NULL	NULL	NULL
70	163	163	707000	0	Perf 707000	2018-01-15 00:00:00	NULL	NULL	NULL	P163	NULL	Perf 163	0.00	64.06	1	0	0	0	NULL	0	0	NULL	326	NULL	NULL	NULL
70	169	169	411007	0	Perf 411007	2018-01-01 00:00:00	NULL	NULL	NULL	P169	NULL	Perf 169	286.84	0.00	1	0	0	0	NULL	0	0	NULL	337	NULL	NULL	NULL
70	169	169	707000	0	Perf 707000	2018-01-01 00:00:00	NULL	NULL	NULL	P169	NULL	Perf 169	0.00	286.84	1	0	0	0	NULL	0	0	NULL	338	NULL	NULL	NULL
70	175	175	411013	0	Perf 411013	2018-01-15 00:00:00	NULL	NULL	NULL	P175	NULL	Perf 175	508.62	0.00	1	0	0	0	NULL	0	0	NULL	349	NULL	NULL	NULL
70	175	175	707000	0	Perf 707000	2018-01-15 00:00:00	NULL	NULL	NULL	P175	NULL	Perf 175	0.00	508.62	1	0	0	0	NULL	0	0	NULL	350	NULL	NULL	NULL
70	181	181	411019	0	Perf 411019	2018-01-01 00:00:00	NULL	NULL	NULL	P181	NULL	Perf 181	730.40	0.00	1	0	0	0	NULL	0	0	NULL	361	NULL	NULL	NULL
70	181	181	707000	0	Perf 707000	2018-01-01 00:00:00	NULL	NULL	NULL	P181	NULL	Perf 181	0.00	730.40	1	0	0	0	NULL	0	0	NULL	362	NULL	NULL	NULL
70	187	187	411025	0	Perf 411025	2018-01-15 00:00:00	NULL	NULL	NULL	P187	NULL	Perf 187	952.18	0.00	1	0	0	0	NULL	0	0	NULL	373	NULL	NULL	NULL
70	187	187	707000	0	Perf 707000	2018-01-15 00:00:00	NULL	NULL	NULL	P187	NULL	Perf 187	0.00	952.18	1	0	0	0	NULL	0	0	NULL	374	NULL	NULL	NULL
70	19	19	411019	0	Perf 411019	2018-01-15 00:00:00	NULL	NULL	NULL	P19	NULL	Perf 19	676.34	0.00	1	0	0	0	NULL	0	0	NULL	37	NULL	NULL	NULL
70	19	19	707000	0	Perf 707000	2018-01-15 00:00:00	NULL	NULL	NULL	P19	NULL	Perf 19	0.00	676.34	1	0	0	0	NULL	0	0	NULL	38	NULL	NULL	NULL
70	193	193	411004	0	Perf 411004	2018-01-01 00:00:00	NULL	NULL	NULL	P193	NULL	Perf 193	184.96	0.00	1	0	0	0	NULL	0	0	NULL	385	NULL	NULL	NULL
70	193	193	707000	0	Perf 707000	2018-01-01 00:00:00	NULL	NULL	NULL	P193	NULL	Perf 193	0.00	184.96	1	0	0	0	NULL	0	0	NULL	386	NULL	NULL	NULL
70	199	199	411010	0	Perf 411010	2018-01-15 00:00:00	NULL	NULL	NULL	P199	NULL	Perf 199	406.74	0.00	1	0	0	0	NULL	0	0	NULL	397	NULL	NULL	NULL
70	199	199	707000	0	Perf 707000	2018-01-15 00:00:00	NULL	NULL	NULL	P199	NULL	Perf 199	0.00	406.74	1	0	0	0	NULL	0	0	NULL	398	NULL	NULL	NULL
70	205	205	411016	0	Perf 411016	2018-01-01 00:00:00	NULL	NULL	NULL	P205	NULL	Perf 205	628.52	0.00	1	0	0	0	NULL	0	0	NULL	409	NULL	NULL	NULL
70	205	205	707000	0	Perf 707000	2018-01-01 00:00:00	NULL	NULL	NULL	P205	NULL	Perf 205	0.00	628.52	1	0	0	0	NULL	0	0	NULL	410	NULL	NULL	NULL
70	211	211	411022	0	Perf 411022	2018-01-15 00:00:00	NULL	NULL	NULL	P211	NULL	Perf 211	850.30	0.00	1	0	0	0	NULL	0	0	NULL	421	NULL	NULL	NULL
70	211	211	707000	0	Perf 707000	2018-01-15 00:00:00	NULL	NULL	NULL	P211	NULL	Perf 211	0.00	850.30	1	0	0	0	NULL	0	0	NULL	422	NULL	NULL	NULL
70	217	217	411001	0	Perf 411001	2018-01-01 00:00:00	NULL	NULL	NULL	P217	NULL	Perf 217	82.08	0.00	1	0	0	0	NULL	0	0	NULL	433	NULL	NULL	NULL
70	217	217	707000	0	Perf 707000	2018-01-01 00:00:00	NULL	NULL	NULL	P217	NULL	Perf 217	0.00	82.08	1	0	0	0	NULL	0	0	NULL	434	NULL	NULL	NULL
70	223	223	411007	0	Perf 411007	2018-01-15 00:00:00	NULL	NULL	NULL	P223	NULL	Perf 223	304.86	0.00	1	0	0	0	NULL	0	0	NULL	445	NULL	NULL	NULL
70	223	223	707000	0	Perf 707000	2018-01-15 00:00:00	NULL	NULL	NULL	P223	NULL	Perf 223	0.00	304.86	1	0	0	0	NULL	0	0	NULL	446	NULL	NULL	NULL
70	229	229	411013	0	Perf 411013	2018-01-01 00:00:00	NULL	NULL	NULL	P229	NULL	Perf 229	526.64	0.00	1	0	0	0	NULL	0	0	NULL	457	NULL	NULL	NULL
70	229	229	707000	0	Perf 707000	2018-01-01 00:00:00	NULL	NULL	NULL	P229	NULL	Perf 229	0.00	526.64	1	0	0	0	NULL	0	0	NULL	458	NULL	NULL	NULL
70	235	235	411019	0	Perf 411019	2018-01-15 00:00:00	NULL	NULL	NULL	P235	NULL	Perf 235	748.42	0.00	1	0	0	0	NULL	0	0	NULL	469	NULL	NULL	NULL
70	235	235	707000	0	Perf 707000	2018-01-15 00:00:00	NULL	NULL	NULL	P235	NULL	Perf 235	0.00	748.42	1	0	0	0	NULL	0	0	NULL	470	NULL	NULL	NULL
70	241	241	411025	0	Perf 411025	2018-01-01 00:00:00	NULL	NULL	NULL	P241	NULL	Perf 241	970.20	0.00	1	0	0	0	NULL	0	0	NULL	481	NULL	NULL	NULL
70	241	241	707000	0	Perf 707000	2018-01-01 00:00:00	NULL	NULL	NULL	P241	NULL	Perf 241	0.00	970.20	1	0	0	0	NULL	0	0	NULL	482	NULL	NULL	NULL
70	247	247	411004	0	Perf 411004	2018-01-15 00:00:00	NULL	NULL	NULL	P247	NULL	Perf 247	202.98	0.00	1	0	0	0	NULL	0	0	NULL	493	NULL	NULL	NULL
70	247	247	707000	0	Perf 707000	2018-01-15 00:00:00	NULL	NULL	NULL	P247	NULL	Perf 247	0.00	202.98	1	0	0	0	NULL	0	0	NULL	494	NULL	NULL	NULL
70	25	25	411025	0	Perf 411025	2018-01-01 00:00:00	NULL	NULL	NULL	P25	NULL	Perf 25	898.12	0.00	1	0	0	0	NULL	0	0	NULL	49	NULL	NULL	NULL
70	25	25	707000	0	Perf 707000	2018-01-01 00:00:00	NULL	NULL	NULL	P25	NULL	Perf 25	0.00	898.12	1	0	0	0	NULL	0	0	NULL	50	NULL	NULL	NULL
70	253	253	411010	0	Perf 411010	2018-01-01 00:00:00	NULL	NULL	NULL	P253	NULL	Perf 253	424.76	0.00	1	0	0	0	NULL	0	0	NULL	505	NULL	NULL	NULL
70	253	253	707000	0	Perf 707000	2018-01-01 00:00:00	NULL	NULL	NULL	P253	NULL	Perf 253	0.00	424.76	1	0	0	0	NULL	0	0	NULL	506	NULL	NULL	NULL
70	259	259	411016	0	Perf 411016	2018-01-15 00:00:00	NULL	NULL	NULL	P259	NULL	Perf 259	646.54	0.00	1	0	0	0	NULL	0	0	NULL	517	NULL	NULL	NULL
70	259	259	707000	0	Perf 707000	2018-01-15 00:00:00	NULL	NULL	NULL	P259	NULL	Perf 259	0.00	646.54	1	0	0	0	NULL	0	0	NULL	518	NULL	NULL	NULL
70	265	265	411022	0	Perf 411022	2018-01-01 00:00:00	NULL	NULL	NULL	P265	NULL	Perf 265	868.32	0.00	1	0	0	0	NULL	0	0	NULL	529	NULL	NULL	NULL
70	265	265	707000	0	Perf 707000	2018-01-01 00:00:00	NULL	NULL	NULL	P265	NULL	Perf 265	0.00	868.32	1	0	0	0	NULL	0	0	NULL	530	NULL	NULL	NULL
70	271	271	411001	0	Perf 411001	2018-01-15 00:00:00	NULL	NULL	NULL	P271	NULL	Perf 271	100.10	0.00	1	0	0	0	NULL	0	0	NULL	541	NULL	NULL	NULL
70	271	271	707000	0	Perf 707000	2018-01-15 00:00:00	NULL	NULL	NULL	P271	NULL	Perf 271	0.00	100.10	1	0	0	0	NULL	0	0	NULL	542	NULL	NULL	NULL
70	277	277	411007	0	Perf 411007	2018-01-01 00:00:00	NULL	NULL	NULL	P277	NULL	Perf 277	322.88	0.00	1	0	0	0	NULL	0	0	NULL	553	NULL	NULL	NULL
70	277	277	707000	0	Perf 707000	2018-01-01 00:00:00	NULL	NULL	NULL	P277	NULL	Perf 277	0.00	322.88	1	0	0	0	NULL	0	0	NULL	554	NULL	NULL	NULL
70	283	283	411013	0	Perf 411013	2018-01-15 00:00:00	NULL	NULL	NULL	P283	NULL	Perf 283	544.66	0.00	1	0	0	0	NULL	0	0	NULL	565	NULL	NULL	NULL
70	283	283	707000	0	Perf 707000	2018-01-15 00:00:00	NULL	NULL	NULL	P283	NULL	Perf 283	0.00	544.66	1	0	0	0	NULL	0	0	NULL	566	NULL	NULL	NULL
70	289	289	411019	0	Perf 411019	2018-01-01 00:00:00	NULL	NULL	NULL	P289	NULL	Perf 289	766.44	0.00	1	0	0	0	NULL	0	0	NULL	577	NULL	NULL	NULL
70	289	289	707000	0	Perf 707000	2018-01-01 00:00:00	NULL	NULL	NULL	P289	NULL	Perf 289	0.00	766.44	1	0	0	0	NULL	0	0	NULL	578	NULL	NULL	NULL
70	295	295	411025	0	Perf 411025	2018-01-15 00:00:00	NULL	NULL	NULL	P295	NULL	Perf 295	988.22	0.00	1	0	0	0	NULL	0	0	NULL	589	NULL	NULL	NULL
70	295	295	707000	0	Perf 707000	2018-01-15 00:00:00	NULL	NULL	NULL	P295	NULL	Perf 295	0.00	988.22	1	0	0	0	NULL	0	0	NULL	590	NULL	NULL	NULL
70	301	301	411004	0	Perf 411004	2018-01-01 00:00:00	NULL	NULL	NULL	P301	NULL	Perf 301	220.00	0.00	1	0	0	0	NULL	0	0	NULL	601	NULL	NULL	NULL
70	301	301	707000	0	Perf 707000	2018-01-01 00:00:00	NULL	NULL	NULL	P301	NULL	Perf 301	0.00	220.00	1	0	0	0	NULL	0	0	NULL	602	NULL	NULL	NULL
70	307	307	411010	0	Perf 411010	2018-01-15 00:00:00	NULL	NULL	NULL	P307	NULL	Perf 307	442.78	0.00	1	0	0	0	NULL	0	0	NULL	613	NULL	NULL	NULL
70	307	307	707000	0	Perf 707000	2018-01-15 00:00:00	NULL	NULL	NULL	P307	NULL	Perf 307	0.00	442.78	1	0	0	0	NULL	0	0	NULL	614	NULL	NULL	NULL
70	31	31	411004	0	Perf 411004	2018-01-15 00:00:00	NULL	NULL	NULL	P31	NULL	Perf 31	130.90	0.00	1	0	0	0	NULL	0	0	NULL	61	NULL	NULL	NULL
70	31	31	707000	0	Perf 707000	2018-01-15 00:00:00	NULL	NULL	NULL	P31	NULL	Perf 31	0.00	130.90	1	0	0	0	NULL	0	0	NULL	62	NULL	NULL	NULL
70	313	313	411016	0	Perf 411016	2018-01-01 00:00:00	NULL	NULL	NULL	P313	NULL	Perf 313	664.56	0.00	1	0	0	0	NULL	0	0	NULL	625	NULL	NULL	NULL
70	313	313	707000	0	Perf 707000	2018-01-01 00:00:00	NULL	NULL	NULL	P313	NULL	Perf 313	0.00	664.56	1	0	0	0	NULL	0	0	NULL	626	NULL	NULL	NULL
70	319	319	411022	0	Perf 411022	2018-01-15 00:00:00	NULL	NULL	NULL	P319	NULL	Perf 319	886.34	0.00	1	0	0	0	NULL	0	0	NULL	637	NULL	NULL	NULL
70	319	319	707000	0	Perf 707000	2018-01-15 00:00:00	NULL	NULL	NULL	P319	NULL	Perf 319	0.00	886.34	1	0	0	0	NULL	0	0	NULL	638	NULL	NULL	NULL
70	325	325	411001	0	Perf 411001	2018-01-01 00:00:00	NULL	NULL	NULL	P325	NULL	Perf 325	118.12	0.00	1	0	0	0	NULL	0	0	NULL	649	NULL	NULL	NULL
70	325	325	707000	0	Perf 707000	2018-01-01 00:00:00	NULL	NULL	NULL	P325	NULL	Perf 325	0.00	118.12	1	0	0	0	NULL	0	0	NULL	650	NULL	NULL	NULL
70	331	331	411007	0	Perf 411007	2018-01-15 00:00:00	NULL	NULL	NULL	P331	NULL	Perf 331	340.90	0.00	1	0	0	0	NULL	0	0	NULL	661	NULL	NULL	NULL
70	331	331	707000	0	Perf 707000	2018-01-15 00:00:00	NULL	NULL	NULL	P331	NULL	Perf 331	0.00	340.90	1	0	0	0	NULL	0	0	NULL	662	NULL	NULL	NULL
70	337	337	411013	0	Perf 411013	2018-01-01 00:00:00	NULL	NULL	NULL	P337	NULL	Perf 337	562.68	0.00	1	0	0	0	NULL	0	0	NULL	673	NULL	NULL	NULL
70	337	337	707000	0	Perf 707000	2018-01-01 00:00:00	NULL	NULL	NULL	P337	NULL	Perf 337	0.00	562.68	1	0	0	0	NULL	0	0	NULL	674	NULL	NULL	NULL
70	343	343	411019	0	Perf 411019	2018-01-15 00:00:00	NULL	NULL	NULL	P343	NULL	Perf 343	784.46	0.00	1	0	0	0	NULL	0	0	NULL	685	NULL	NULL	NULL
70	343	343	707000	0	Perf 707000	2018-01-15 00:00:00	NULL	NULL	NULL	P343	NULL	Perf 343	0.00	784.46	1	0	0	0	NULL	0	0	NULL	686	NULL	NULL	NULL
70	349	349	411025	0	Perf 411025	2018-01-01 00:00:00	NULL	NULL	NULL	P349	NULL	Perf 349	16.24	0.00	1	0	0	0	NULL	0	0	NULL	697	NULL	NULL	NULL
70	349	349	707000	0	Perf 707000	2018-01-01 00:00:00	NULL	NULL	NULL	P349	NULL	Perf 349	0.00	16.24	1	0	0	0	NULL	0	0	NULL	698	NULL	NULL	NULL
70	355	355	411004	0	Perf 411004	2018-01-15 00:00:00	NULL	NULL	NULL	P355	NULL	Perf 355	238.02	0.00	1	0	0	0	NULL	0	0	NULL	709	NULL	NULL	NULL
70	355	355	707000	0	Perf 707000	2018-01-15 00:00:00	NULL	NULL	NULL	P355	NULL	Perf 355	0.00	238.02	1	0	0	0	NULL	0	0	NULL	710	NULL	NULL	NULL
70	361	361	411010	0	Perf 411010	2018-01-01 00:00:00	NULL	NULL	NULL	P361	NULL	Perf 361	460.80	0.00	1	0	0	0	NULL	0	0	NULL	721	NULL	NULL	NULL
70	361	361	707000	0	Perf 707000	2018-01-01 00:00:00	NULL	NULL	NULL	P361	NULL	Perf 361	0.00	460.80	1	0	0	0	NULL	0	0	NULL	722	NULL	NULL	NULL
70	367	367	411016	0	Perf 411016	2018-01-15 00:00:00	NULL	NULL	NULL	P367	NULL	Perf 367	682.58	0.00	1	0	0	0	NULL	0	0	NULL	733	NULL	NULL	NULL
70	367	367	707000	0	Perf 707000	2018-01-15 00:00:00	NULL	NULL	NULL	P367	NULL	Perf 367	0.00	682.58	1	0	0	0	NULL	0	0	NULL	734	NULL	NULL	NULL
70	37	37	411010	0	Perf 411010	2018-01-01 00:00:00	NULL	NULL	NULL	P37	NULL	Perf 37	352.68	0.00	1	0	0	0	NULL	0	0	NULL	73	NULL	NULL	NULL
70	37	37	707000	0	Perf 707000	2018-01-01 00:00:00	NULL	NULL	NULL	P37	NULL	Perf 37	0.00	352.68	1	0	0	0	NULL	0	0	NULL	74	NULL	NULL	NULL
70	373	373	411022	0	Perf 411022	2018-01-01 00:00:00	NULL	NULL	NULL	P373	NULL	Perf 373	904.36	0.00	1	0	0	0	NULL	0	0	NULL	745	NULL	NULL	NULL
70	373	373	707000	0	Perf 707000	2018-01-01 00:00:00	NULL	NULL	NULL	P373	NULL	Perf 373	0.00	904.36	1	0	0	0	NULL	0	0	NULL	746	NULL	NULL	NULL
70	379	379	411001	0	Perf 411001	2018-01-15 00:00:00	NULL	NULL	NULL	P379	NULL	Perf 379	136.14	0.00	1	0	0	0	NULL	0	0	NULL	757	NULL	NULL	NULL
70	379	379	707000	0	Perf 707000	2018-01-15 00:00:00	NULL	NULL	NULL	P379	NULL	Perf 379	0.00	136.14	1	0	0	0	NULL	0	0	NULL	758	NULL	NULL	NULL
70	385	385	411007	0	Perf 411007	2018-01-01 00:00:00	NULL	NULL	NULL	P385	NULL	Perf 385	358.92	0.00	1	0	0	0	NULL	0	0	NULL	769	NULL	NULL	NULL
70	385	385	707000	0	Perf 707000	2018-01-01 00:00:00	NULL	NULL	NULL	P385	NULL	Perf 385	0.00	358.92	1	0	0	0	NULL	0	0	NULL	770	NULL	NULL	NULL
70	391	391	411013	0	Perf 411013	2018-01-15 00:00:00	NULL	NULL	NULL	P391	NULL	Perf 391	580.70	0.00	1	0	0	0	NULL	0	0	NULL	781	NULL	NULL	NULL
70	391	391	707000	0	Perf 707000	2018-01-15 00:00:00	NULL	NULL	NULL	P391	NULL	Perf 391	0.00	580.70	1	0	0	0	NULL	0	0	NULL	782	NULL	NULL	NULL
70	397	397	411019	0	Perf 411019	2018-01-01 00:00:00	NULL	NULL	NULL	P397	NULL	Perf 397	802.48	0.00	1	0	0	0	NULL	0	0	NULL	793	NULL	NULL	NULL
70	397	397	707000	0	Perf 707000	2018-01-01 00:00:00	NULL	NULL	NULL	P397	NULL	Perf 397	0.00	802.48	1	0	0	0	NULL	0	0	NULL	794	NULL	NULL	NULL
70	403	403	411025	0	Perf 411025	2018-01-15 00:00:00	NULL	NULL	NULL	P403	NULL	Perf 403	34.26	0.00	1	0	0	0	NULL	0	0	NULL	805	NULL	NULL	NULL
70	403	403	707000	0	Perf 707000	2018-01-15 00:00:00	NULL	NULL	NULL	P403	NULL	Perf 403	0.00	34.26	1	0	0	0	NULL	0	0	NULL	806	NULL	NULL	NULL
70	409	409	411004	0	Perf 411004	2018-01-01 00:00:00	NULL	NULL	NULL	P409	NULL	Perf 409	256.04	0.00	1	0	0	0	NULL	0	0	NULL	817	NULL	NULL	NULL
70	409	409	707000	0	Perf 707000	2018-01-01 00:00:00	NULL	NULL	NULL	P409	NULL	Perf 409	0.00	256.04	1	0	0	0	NULL	0	0	NULL	818	NULL	NULL	NULL
70	415	415	411010	0	Perf 411010	2018-01-15 00:00:00	NULL	NULL	NULL	P415	NULL	Perf 415	478.82	0.00	1	0	0	0	NULL	0	0	NULL	829	NULL	NULL	NULL
70	415	415	707000	0	Perf 707000	2018-01-15 00:00:00	NULL	NULL	NULL	P415	NULL	Perf 415	0.00	478.82	1	0	0	0	NULL	0	0	NULL	830	NULL	NULL	NULL
70	421	421	411016	0	Perf 411016	2018-01-01 00:00:00	NULL	NULL	NULL	P421	NULL	Perf 421	700.60	0.00	1	0	0	0	NULL	0	0	NULL	841	NULL	NULL	NULL
70	421	421	707000	0	Perf 707000	2018-01-01 00:00:00	NULL	NULL	NULL	P421	NULL	Perf 421	0.00	700.60	1	0	0	0	NULL	0	0	NULL	842	NULL	NULL	NULL
70	427	427	411022	0	Perf 411022	2018-01-15 00:00:00	NULL	NULL	NULL	P427	NULL	Perf 427	922.38	0.00	1	0	0	0	NULL	0	0	NULL	853	NULL	NULL	NULL
70	427	427	707000	0	Perf 707000	2018-01-15 00:00:00	NULL	NULL	NULL	P427	NULL	Perf 427	0.00	922.38	1	0	0	0	NULL	0	0	NULL	854	NULL	NULL	NULL
70	43	43	411016	0	Perf 411016	2018-01-15 00:00:00	NULL	NULL	NULL	P43	NULL	Perf 43	574.46	0.00	1	0	0	0	NULL	0	0	NULL	85	NULL	NULL	NULL
70	43	43	707000	0	Perf 707000	2018-01-15 00:00:00	NULL	NULL	NULL	P43	NULL	Perf 43	0.00	574.46	1	0	0	0	NULL	0	0	NULL	86	NULL	NULL	NULL
70	433	433	411001	0	Perf 411001	2018-01-01 00:00:00	NULL	NULL	NULL	P433	NULL	Perf 433	154.16	0.00	1	0	0	0	NULL	0	0	NULL	865	NULL	NULL	NULL
70	433	433	707000	0	Perf 707000	2018-01-01 00:00:00	NULL	NULL	NULL	P433	NULL	Perf 433	0.00	154.16	1	0	0	0	NULL	0	0	NULL	866	NULL	NULL	NULL
70	439	439	411007	0	Perf 411007	2018-01-15 00:00:00	NULL	NULL	NULL	P439	NULL	Perf 439	376.94	0.00	1	0	0	0	NULL	0	0	NULL	877	NULL	NULL	NULL
70	439	439	707000	0	Perf 707000	2018-01-15 00:00:00	NULL	NULL	NULL	P439	NULL	Perf 439	0.00	376.94	1	0	0	0	NULL	0	0	NULL	878	NULL	NULL	NULL
70	445	445	411013	0	Perf 411013	2018-01-01 00:00:00	NULL	NULL	NULL	P445	NULL	Perf 445	598.72	0.00	1	0	0	0	NULL	0	0	NULL	889	NULL	NULL	NULL
70	445	445	707000	0	Perf 707000	2018-01-01 00:00:00	NULL	NULL	NULL	P445	NULL	Perf 445	0.00	598.72	1	0	0	0	NULL	0	0	NULL	890	NULL	NULL	NULL
70	451	451	411019	0	Perf 411019	2018-01-15 00:00:00	NULL	NULL	NULL	P451	NULL	Perf 451	820.50	0.00	1	0	0	0	NULL	0	0	NULL	901	NULL	NULL	NULL
70	451	451	707000	0	Perf 707000	2018-01-15 00:00:00	NULL	NULL	NULL	P451	NULL	Perf 451	0.00	820.50	1	0	0	0	NULL	0	0	NULL	902	NULL	NULL	NULL
70	457	457	411025	0	Perf 411025	2018-01-01 00:00:00	NULL	NULL	NULL	P457	NULL	Perf 457	52.28	0.00	1	0	0	0	NULL	0	0	NULL	913	NULL	NULL	NULL
70	457	457	707000	0	Perf 707000	2018-01-01 00:00:00	NULL	NULL	NULL	P457	NULL	Perf 457	0.00	52.28	1	0	0	0	NULL	0	0	NULL	914	NULL	NULL	NULL
70	463	463	411004	0	Perf 411004	2018-01-15 00:00:00	NULL	NULL	NULL	P463	NULL	Perf 463	274.06	0.00	1	0	0	0	NULL	0	0	NULL	925	NULL	NULL	NULL
70	463	463	707000	0	Perf 707000	2018-01-15 00:00:00	NULL	NULL	NULL	P463	NULL	Perf 463	0.00	274.06	1	0	0	0	NULL	0	0	NULL	926	NULL	NULL	NULL
70	469	469	411010	0	Perf 411010	2018-01-01 00:00:00	NULL	NULL	NULL	P469	NULL	Perf 469	496.84	0.00	1	0	0	0	NULL	0	0	NULL	937	NULL	NULL	NULL
70	469	469	707000	0	Perf 707000	2018-01-01 00:00:00	NULL	NULL	NULL	P469	NULL	Perf 469	0.00	496.84	1	0	0	0	NULL	0	0	NULL	938	NULL	NULL	NULL
70	475	475	411016	0	Perf 411016	2018-01-15 00:00:00	NULL	NULL	NULL	P475	NULL	Perf 475	718.62	0.00	1	0	0	0	NULL	0	0	NULL	949	NULL	NULL	NULL
70	475	475	707000	0	Perf 707000	2018-01-15 00:00:00	NULL	NULL	NULL	P475	NULL	Perf 475	0.00	718.62	1	0	0	0	NULL	0	0	NULL	950	NULL	NULL	NULL
70	481	481	411022	0	Perf 411022	2018-01-01 00:00:00	NULL	NULL	NULL	P481	NULL	Perf 481	940.40	0.00	1	0	0	0	NULL	0	0	NULL	961	NULL	NULL	NULL
70	481	481	707000	0	Perf 707000	2018-01-01 00:00:00	NULL	NULL	NULL	P481	NULL	Perf 481	0.00	940.40	1	0	0	0	NULL	0	0	NULL	962	NULL	NULL	NULL
70	487	487	411001	0	Perf 411001	2018-01-15 00:00:00	NULL	NULL	NULL	P487	NULL	Perf 487	172.18	0.00	1	0	0	0	NULL	0	0	NULL	973	NULL	NULL	NULL
70	487	487	707000	0	Perf 707000	2018-01-15 00:00:00	NULL	NULL	NULL	P487	NULL	Perf 487	0.00	172.18	1	0	0	0	NULL	0	0	NULL	974	NULL	NULL	NULL
70	49	49	411022	0	Perf 411022	2018-01-01 00:00:00	NULL	NULL	NULL	P49	NULL	Perf 49	796.24	0.00	1	0	0	0	NULL	0	0	NULL	97	NULL	NULL	NULL
70	49	49	707000	0	Perf 707000	2018-01-01 00:00:00	NULL	NULL	NULL	P49	NULL	Perf 49	0.00	796.24	1	0	0	0	NULL	0	0	NULL	98	NULL	NULL	NULL
70	493	493	411007	0	Perf 411007	2018-01-01 00:00:00	NULL	NULL	NULL	P493	NULL	Perf 493	394.96	0.00	1	0	0	0	NULL	0	0	NULL	985	NULL	NULL	NULL
70	493	493	707000	0	Perf 707000	2018-01-01 00:00:00	NULL	NULL	NULL	P493	NULL	Perf 493	0.00	394.96	1	0	0	0	NULL	0	0	NULL	986	NULL	NULL	NULL
70	499	499	411013	0	Perf 411013	2018-01-15 00:00:00	NULL	NULL	NULL	P499	NULL	Perf 499	616.74	0.00	1	0	0	0	NULL	0	0	NULL	997	NULL	NULL	NULL
70	499	499	707000	0	Perf 707000	2018-01-15 00:00:00	NULL	NULL	NULL	P499	NULL	Perf 499	0.00	616.74	1	0	0	0	NULL	0	0	NULL	998	NULL	NULL	NULL
70	55	55	411001	0	Perf 411001	2018-01-15 00:00:00	NULL	NULL	NULL	P55	NULL	Perf 55	28.02	0.00	1	0	0	0	NULL	0	0	NULL	109	NULL	NULL	NULL
70	55	55	707000	0	Perf 707000	2018-01-15 00:00:00	NULL	NULL	NULL	P55	NULL	Perf 55	0.00	28.02	1	0	0	0	NULL	0	0	NULL	110	NULL	NULL	NULL
70	61	61	411007	0	Perf 411007	2018-01-01 00:00:00	NULL	NULL	NULL	P61	NULL	Perf 61	250.80	0.00	1	0	0	0	NULL	0	0	NULL	121	NULL	NULL	NULL
70	61	61	707000	0	Perf 707000	2018-01-01 00:00:00	NULL	NULL	NULL	P61	NULL	Perf 61	0.00	250.80	1	0	0	0	NULL	0	0	NULL	122	NULL	NULL	NULL
70	67	67	411013	0	Perf 411013	2018-01-15 00:00:00	NULL	NULL	NULL	P67	NULL	Perf 67	472.58	0.00	1	0	0	0	NULL	0	0	NULL	133	NULL	NULL	NULL
70	67	67	707000	0	Perf 707000	2018-01-15 00:00:00	NULL	NULL	NULL	P67	NULL	Perf 67	0.00	472.58	1	0	0	0	NULL	0	0	NULL	134	NULL	NULL	NULL
70	7	7	411007	0	Perf 411007	2018-01-15 00:00:00	NULL	NULL	NULL	P7	NULL	Perf 7	232.78	0.00	1	0	0	0	NULL	0	0	NULL	13	NULL	NULL	NULL
70	7	7	707000	0	Perf 707000	2018-01-15 00:00:00	NULL	NULL	NULL	P7	NULL	Perf 7	0.00	232.78	1	0	0	0	NULL	0	0	NULL	14	NULL	NULL	NULL
70	73	73	411019	0	Perf 411019	2018-01-01 00:00:00	NULL	NULL	NULL	P73	NULL	Perf 73	694.36	0.00	1	0	0	0	NULL	0	0	NULL	145	NULL	NULL	NULL
70	73	73	707000	0	Perf 707000	2018-01-01 00:00:00	NULL	NULL	NULL	P73	NULL	Perf 73	0.00	694.36	1	0	0	0	NULL	0	0	NULL	146	NULL	NULL	NULL
70	79	79	411025	0	Perf 411025	2018-01-15 00:00:00	NULL	NULL	NULL	P79	NULL	Perf 79	916.14	0.00	1	0	0	0	NULL	0	0	NULL	157	NULL	NULL	NULL
70	79	79	707000	0	Perf 707000	2018-01-15 00:00:00	NULL	NULL	NULL	P79	NULL	Perf 79	0.00	916.14	1	0	0	0	NULL	0	0	NULL	158	NULL	NULL	NULL
70	85	85	411004	0	Perf 411004	2018-01-01 00:00:00	NULL	NULL	NULL	P85	NULL	Perf 85	148.92	0.00	1	0	0	0	NULL	0	0	NULL	169	NULL	NULL	NULL
70	85	85	707000	0	Perf 707000	2018-01-01 00:00:00	NULL	NULL	NULL	P85	NULL	Perf 85	0.00	148.92	1	0	0	0	NULL	0	0	NULL	170	NULL	NULL	NULL
70	91	91	411010	0	Perf 411010	2018-01-15 00:00:00	NULL	NULL	NULL	P91	NULL	Perf 91	370.70	0.00	1	0	0	0	NULL	0	0	NULL	181	NULL	NULL	NULL
70	91	91	707000	0	Perf 707000	2018-01-15 00:00:00	NULL	NULL	NULL	P91	NULL	Perf 91	0.00	370.70	1	0	0	0	NULL	0	0	NULL	182	NULL	NULL	NULL
70	97	97	411016	0	Perf 411016	2018-01-01 00:00:00	NULL	NULL	NULL	P97	NULL	Perf 97	592.48	0.00	1	0	0	0	NULL	0	0	NULL	193	NULL	NULL	NULL
70	97	97	707000	0	Perf 707000	2018-01-01 00:00:00	NULL	NULL	NULL	P97	NULL	Perf 97	0.00	592.48	1	0	0	0	NULL	0	0	NULL	194	NULL	NULL	NULL
80	101	101	211000	0	Perf 211000	2018-05-01 00:00:00	NULL	NULL	NULL	P101	NULL	Perf 101	740.00	0.00	1	0	0	0	NULL	0	0	NULL	201	NULL	NULL	NULL
80	101	101	512001	0	Perf 512001	2018-05-01 00:00:00	NULL	NULL	NULL	P101	NULL	Perf 101	0.00	740.00	1	0	0	0	NULL	0	0	NULL	202	NULL	NULL	NULL
80	102	102	401024	0	Perf 401024	2018-06-08 00:00:00	NULL	NULL	NULL	P102	NULL	Perf 102	0.00	777.13	1	0	0	0	NULL	0	0	NULL	204	NULL	NULL	NULL
80	102	102	445710	0	Perf 445710	2018-06-08 00:00:00	NULL	NULL	NULL	P102	NULL	Perf 102	777.13	0.00	1	0	0	0	NULL	0	0	NULL	203	NULL	NULL	NULL
80	107	107	213000	0	Perf 213000	2018-05-15 00:00:00	NULL	NULL	NULL	P107	NULL	Perf 107	962.78	0.00	1	0	0	0	NULL	0	0	NULL	213	NULL	NULL	NULL
80	107	107	512001	0	Perf 512001	2018-05-15 00:00:00	NULL	NULL	NULL	P107	NULL	Perf 107	0.00	962.78	1	0	0	0	NULL	0	0	NULL	214	NULL	NULL	NULL
80	108	108	401004	0	Perf 401004	2018-06-22 00:00:00	NULL	NULL	NULL	P108	NULL	Perf 108	0.00	999.91	1	0	0	0	NULL	0	0	NULL	216	NULL	NULL	NULL
80	108	108	445710	0	Perf 445710	2018-06-22 00:00:00	NULL	NULL	NULL	P108	NULL	Perf 108	999.91	0.00	1	0	0	0	NULL	0	0	NULL	215	NULL	NULL	NULL
80	11	11	211000	0	Perf 211000	2018-05-15 00:00:00	NULL	NULL	NULL	P11	NULL	Perf 11	380.30	0.00	1	0	0	0	NULL	0	0	NULL	21	NULL	NULL	NULL
80	11	11	512001	0	Perf 512001	2018-05-15 00:00:00	NULL	NULL	NULL	P11	NULL	Perf 11	0.00	380.30	1	0	0	0	NULL	0	0	NULL	22	NULL	NULL	NULL
80	113	113	218200	0	Perf 218200	2018-05-01 00:00:00	NULL	NULL	NULL	P113	NULL	Perf 113	194.56	0.00	1	0	0	0	NULL	0	0	NULL	225	NULL	NULL	NULL
80	113	113	512001	0	Perf 512001	2018-05-01 00:00:00	NULL	NULL	NULL	P113	NULL	Perf 113	0.00	194.56	1	0	0	0	NULL	0	0	NULL	226	NULL	NULL	NULL
80	114	114	401010	0	Perf 401010	2018-06-08 00:00:00	NULL	NULL	NULL	P114	NULL	Perf 114	0.00	231.69	1	0	0	0	NULL	0	0	NULL	228	NULL	NULL	NULL
80	114	114	445710	0	Perf 445710	2018-06-08 00:00:00	NULL	NULL	NULL	P114	NULL	Perf 114	231.69	0.00	1	0	0	0	NULL	0	0	NULL	227	NULL	NULL	NULL
80	119	119	218300	0	Perf 218300	2018-05-15 00:00:00	NULL	NULL	NULL	P119	NULL	Perf 119	416.34	0.00	1	0	0	0	NULL	0	0	NULL	237	NULL	NULL	NULL
80	119	119	512001	0	Perf 512001	2018-05-15 00:00:00	NULL	NULL	NULL	P119	NULL	Perf 119	0.00	416.34	1	0	0	0	NULL	0	0	NULL	238	NULL	NULL	NULL
80	12	12	401012	0	Perf 401012	2018-06-22 00:00:00	NULL	NULL	NULL	P12	NULL	Perf 12	0.00	417.43	1	0	0	0	NULL	0	0	NULL	24	NULL	NULL	NULL
80	12	12	445710	0	Perf 445710	2018-06-22 00:00:00	NULL	NULL	NULL	P12	NULL	Perf 12	417.43	0.00	1	0	0	0	NULL	0	0	NULL	23	NULL	NULL	NULL
80	120	120	401016	0	Perf 401016	2018-06-22 00:00:00	NULL	NULL	NULL	P120	NULL	Perf 120	0.00	453.47	1	0	0	0	NULL	0	0	NULL	240	NULL	NULL	NULL
80	120	120	445710	0	Perf 445710	2018-06-22 00:00:00	NULL	NULL	NULL	P120	NULL	Perf 120	453.47	0.00	1	0	0	0	NULL	0	0	NULL	239	NULL	NULL	NULL
80	125	125	218400	0	Perf 218400	2018-05-01 00:00:00	NULL	NULL	NULL	P125	NULL	Perf 125	638.12	0.00	1	0	0	0	NULL	0	0	NULL	249	NULL	NULL	NULL
80	125	125	512001	0	Perf 512001	2018-05-01 00:00:00	NULL	NULL	NULL	P125	NULL	Perf 125	0.00	638.12	1	0	0	0	NULL	0	0	NULL	250	NULL	NULL	NULL
80	126	126	401022	0	Perf 401022	2018-06-08 00:00:00	NULL	NULL	NULL	P126	NULL	Perf 126	0.00	675.25	1	0	0	0	NULL	0	0	NULL	252	NULL	NULL	NULL
80	126	126	445710	0	Perf 445710	2018-06-08 00:00:00	NULL	NULL	NULL	P126	NULL	Perf 126	675.25	0.00	1	0	0	0	NULL	0	0	NULL	251	NULL	NULL	NULL
80	131	131	211000	0	Perf 211000	2018-05-15 00:00:00	NULL	NULL	NULL	P131	NULL	Perf 131	860.90	0.00	1	0	0	0	NULL	0	0	NULL	261	NULL	NULL	NULL
80	131	131	512001	0	Perf 512001	2018-05-15 00:00:00	NULL	NULL	NULL	P131	NULL	Perf 131	0.00	860.90	1	0	0	0	NULL	0	0	NULL	262	NULL	NULL	NULL
80	132	132	401002	0	Perf 401002	2018-06-22 00:00:00	NULL	NULL	NULL	P132	NULL	Perf 132	0.00	897.03	1	0	0	0	NULL	0	0	NULL	264	NULL	NULL	NULL
80	132	132	445710	0	Perf 445710	2018-06-22 00:00:00	NULL	NULL	NULL	P132	NULL	Perf 132	897.03	0.00	1	0	0	0	NULL	0	0	NULL	263	NULL	NULL	NULL
80	137	137	213000	0	Perf 213000	2018-05-01 00:00:00	NULL	NULL	NULL	P137	NULL	Perf 137	92.68	0.00	1	0	0	0	NULL	0	0	NULL	273	NULL	NULL	NULL
80	137	137	512001	0	Perf 512001	2018-05-01 00:00:00	NULL	NULL	NULL	P137	NULL	Perf 137	0.00	92.68	1	0	0	0	NULL	0	0	NULL	274	NULL	NULL	NULL
80	138	138	401008	0	Perf 401008	2018-06-08 00:00:00	NULL	NULL	NULL	P138	NULL	Perf 138	0.00	129.81	1	0	0	0	NULL	0	0	NULL	276	NULL	NULL	NULL
80	138	138	445710	0	Perf 445710	2018-06-08 00:00:00	NULL	NULL	NULL	P138	NULL	Perf 138	129.81	0.00	1	0	0	0	NULL	0	0	NULL	275	NULL	NULL	NULL
80	143	143	218200	0	Perf 218200	2018-05-15 00:00:00	NULL	NULL	NULL	P143	NULL	Perf 143	314.46	0.00	1	0	0	0	NULL	0	0	NULL	285	NULL	NULL	NULL
80	143	143	512001	0	Perf 512001	2018-05-15 00:00:00	NULL	NULL	NULL	P143	NULL	Perf 143	0.00	314.46	1	0	0	0	NULL	0	0	NULL	286	NULL	NULL	NULL
80	144	144	401014	0	Perf 401014	2018-06-22 00:00:00	NULL	NULL	NULL	P144	NULL	Perf 144	0.00	351.59	1	0	0	0	NULL	0	0	NULL	288	NULL	NULL	NULL
80	144	144	445710	0	Perf 445710	2018-06-22 00:00:00	NULL	NULL	NULL	P144	NULL	Perf 144	351.59	0.00	1	0	0	0	NULL	0	0	NULL	287	NULL	NULL	NULL
80	149	149	218300	0	Perf 218300	2018-05-01 00:00:00	NULL	NULL	NULL	P149	NULL	Perf 149	536.24	0.00	1	0	0	0	NULL	0	0	NULL	297	NULL	NULL	NULL
80	149	149	512001	0	Perf 512001	2018-05-01 00:00:00	NULL	NULL	NULL	P149	NULL	Perf 149	0.00	536.24	1	0	0	0	NULL	0	0	NULL	298	NULL	NULL	NULL
80	150	150	401020	0	Perf 401020	2018-06-08 00:00:00	NULL	NULL	NULL	P150	NULL	Perf 150	0.00	573.37	1	0	0	0	NULL	0	0	NULL	300	NULL	NULL	NULL
80	150	150	445710	0	Perf 445710	2018-06-08 00:00:00	NULL	NULL	NULL	P150	NULL	Perf 150	573.37	0.00	1	0	0	0	NULL	0	0	NULL	299	NULL	NULL	NULL
80	155	155	218400	0	Perf 218400	2018-05-15 00:00:00	NULL	NULL	NULL	P155	NULL	Perf 155	758.02	0.00	1	0	0	0	NULL	0	0	NULL	309	NULL	NULL	NULL
80	155	155	512001	0	Perf 512001	2018-05-15 00:00:00	NULL	NULL	NULL	P155	NULL	Perf 155	0.00	758.02	1	0	0	0	NULL	0	0	NULL	310	NULL	NULL	NULL
80	156	156	401026	0	Perf 401026	2018-06-22 00:00:00	NULL	NULL	NULL	P156	NULL	Perf 156	0.00	795.15	1	0	0	0	NULL	0	0	NULL	312	NULL	NULL	NULL
80	156	156	445710	0	Perf 445710	2018-06-22 00:00:00	NULL	NULL	NULL	P156	NULL	Perf 156	795.15	0.00	1	0	0	0	NULL	0	0	NULL	311	NULL	NULL	NULL
80	161	161	211000	0	Perf 211000	2018-05-01 00:00:00	NULL	NULL	NULL	P161	NULL	Perf 161	980.80	0.00	1	0	0	0	NULL	0	0	NULL	321	NULL	NULL	NULL
80	161	161	512001	0	Perf 512001	2018-05-01 00:00:00	NULL	NULL	NULL	P161	NULL	Perf 161	0.00	980.80	1	0	0	0	NULL	0	0	NULL	322	NULL	NULL	NULL
80	162	162	401006	0	Perf 401006	2018-06-08 00:00:00	NULL	NULL	NULL	P162	NULL	Perf 162	0.00	27.93	1	0	0	0	NULL	0	0	NULL	324	NULL	NULL	NULL
80	162	162	445710	0	Perf 445710	2018-06-08 00:00:00	NULL	NULL	NULL	P162	NULL	Perf 162	27.93	0.00	1	0	0	0	NULL	0	0	NULL	323	NULL	NULL	NULL
80	167	167	213000	0	Perf 213000	2018-05-15 00:00:00	NULL	NULL	NULL	P167	NULL	Perf 167	212.58	0.00	1	0	0	0	NULL	0	0	NULL	333	NULL	NULL	NULL
80	167	167	512001	0	Perf 512001	2018-05-15 00:00:00	NULL	NULL	NULL	P167	NULL	Perf 167	0.00	212.58	1	0	0	0	NULL	0	0	NULL	334	NULL	NULL	NULL
80	168	168	401012	0	Perf 401012	2018-06-22 00:00:00	NULL	NULL	NULL	P168	NULL	Perf 168	0.00	249.71	1	0	0	0	NULL	0	0	NULL	336	NULL	NULL	NULL
80	168	168	445710	0	Perf 445710	2018-06-22 00:00:00	NULL	NULL	NULL	P168	NULL	Perf 168	249.71	0.00	1	0	0	0	NULL	0	0	NULL	335	NULL	NULL	NULL
80	17	17	213000	0	Perf 213000	2018-05-01 00:00:00	NULL	NULL	NULL	P17	NULL	Perf 17	602.08	0.00	1	0	0	0	NULL	0	0	NULL	33	NULL	NULL	NULL
80	17	17	512001	0	Perf 512001	2018-05-01 00:00:00	NULL	NULL	NULL	P17	NULL	Perf 17	0.00	602.08	1	0	0	0	NULL	0	0	NULL	34	NULL	NULL	NULL
80	173	173	218200	0	Perf 218200	2018-05-01 00:00:00	NULL	NULL	NULL	P173	NULL	Perf 173	434.36	0.00	1	0	0	0	NULL	0	0	NULL	345	NULL	NULL	NULL
80	173	173	512001	0	Perf 512001	2018-05-01 00:00:00	NULL	NULL	NULL	P173	NULL	Perf 173	0.00	434.36	1	0	0	0	NULL	0	0	NULL	346	NULL	NULL	NULL
80	174	174	401018	0	Perf 401018	2018-06-08 00:00:00	NULL	NULL	NULL	P174	NULL	Perf 174	0.00	471.49	1	0	0	0	NULL	0	0	NULL	348	NULL	NULL	NULL
80	174	174	445710	0	Perf 445710	2018-06-08 00:00:00	NULL	NULL	NULL	P174	NULL	Perf 174	471.49	0.00	1	0	0	0	NULL	0	0	NULL	347	NULL	NULL	NULL
80	179	179	218300	0	Perf 218300	2018-05-15 00:00:00	NULL	NULL	NULL	P179	NULL	Perf 179	656.14	0.00	1	0	0	0	NULL	0	0	NULL	357	NULL	NULL	NULL
80	179	179	512001	0	Perf 512001	2018-05-15 00:00:00	NULL	NULL	NULL	P179	NULL	Perf 179	0.00	656.14	1	0	0	0	NULL	0	0	NULL	358	NULL	NULL	NULL
80	18	18	401018	0	Perf 401018	2018-06-08 00:00:00	NULL	NULL	NULL	P18	NULL	Perf 18	0.00	639.21	1	0	0	0	NULL	0	0	NULL	36	NULL	NULL	NULL
80	18	18	445710	0	Perf 445710	2018-06-08 00:00:00	NULL	NULL	NULL	P18	NULL	Perf 18	639.21	0.00	1	0	0	0	NULL	0	0	NULL	35	NULL	NULL	NULL
80	180	180	401024	0	Perf 401024	2018-06-22 00:00:00	NULL	NULL	NULL	P180	NULL	Perf 180	0.00	693.27	1	0	0	0	NULL	0	0	NULL	360	NULL	NULL	NULL
80	180	180	445710	0	Perf 445710	2018-06-22 00:00:00	NULL	NULL	NULL	P180	NULL	Perf 180	693.27	0.00	1	0	0	0	NULL	0	0	NULL	359	NULL	NULL	NULL
80	185	185	218400	0	Perf 218400	2018-05-01 00:00:00	NULL	NULL	NULL	P185	NULL	Perf 185	878.92	0.00	1	0	0	0	NULL	0	0	NULL	369	NULL	NULL	NULL
80	185	185	512001	0	Perf 512001	2018-05-01 00:00:00	NULL	NULL	NULL	P185	NULL	Perf 185	0.00	878.92	1	0	0	0	NULL	0	0	NULL	370	NULL	NULL	NULL
80	186	186	401004	0	Perf 401004	2018-06-08 00:00:00	NULL	NULL	NULL	P186	NULL	Perf 186	0.00	915.05	1	0	0	0	NULL	0	0	NULL	372	NULL	NULL	NULL
80	186	186	445710	0	Perf 445710	2018-06-08 00:00:00	NULL	NULL	NULL	P186	NULL	Perf 186	915.05	0.00	1	0	0	0	NULL	0	0	NULL	371	NULL	NULL	NULL
80	191	191	211000	0	Perf 211000	2018-05-15 00:00:00	NULL	NULL	NULL	P191	NULL	Perf 191	110.70	0.00	1	0	0	0	NULL	0	0	NULL	381	NULL	NULL	NULL
80	191	191	512001	0	Perf 512001	2018-05-15 00:00:00	NULL	NULL	NULL	P191	NULL	Perf 191	0.00	110.70	1	0	0	0	NULL	0	0	NULL	382	NULL	NULL	NULL
80	192	192	401010	0	Perf 401010	2018-06-22 00:00:00	NULL	NULL	NULL	P192	NULL	Perf 192	0.00	147.83	1	0	0	0	NULL	0	0	NULL	384	NULL	NULL	NULL
80	192	192	445710	0	Perf 445710	2018-06-22 00:00:00	NULL	NULL	NULL	P192	NULL	Perf 192	147.83	0.00	1	0	0	0	NULL	0	0	NULL	383	NULL	NULL	NULL
80	197	197	213000	0	Perf 213000	2018-05-01 00:00:00	NULL	NULL	NULL	P197	NULL	Perf 197	332.48	0.00	1	0	0	0	NULL	0	0	NULL	393	NULL	NULL	NULL
80	197	197	512001	0	Perf 512001	2018-05-01 00:00:00	NULL	NULL	NULL	P197	NULL	Perf 197	0.00	332.48	1	0	0	0	NULL	0	0	NULL	394	NULL	NULL	NULL
80	198	198	401016	0	Perf 401016	2018-06-08 00:00:00	NULL	NULL	NULL	P198	NULL	Perf 198	0.00	369.61	1	0	0	0	NULL	0	0	NULL	396	NULL	NULL	NULL
80	198	198	445710	0	Perf 445710	2018-06-08 00:00:00	NULL	NULL	NULL	P198	NULL	Perf 198	369.61	0.00	1	0	0	0	NULL	0	0	NULL	395	NULL	NULL	NULL
80	203	203	218200	0	Perf 218200	2018-05-15 00:00:00	NULL	NULL	NULL	P203	NULL	Perf 203	554.26	0.00	1	0	0	0	NULL	0	0	NULL	405	NULL	NULL	NULL
80	203	203	512001	0	Perf 512001	2018-05-15 00:00:00	NULL	NULL	NULL	P203	NULL	Perf 203	0.00	554.26	1	0	0	0	NULL	0	0	NULL	406	NULL	NULL	NULL
80	204	204	401022	0	Perf 401022	2018-06-22 00:00:00	NULL	NULL	NULL	P204	NULL	Perf 204	0.00	591.39	1	0	0	0	NULL	0	0	NULL	408	NULL	NULL	NULL
80	204	204	445710	0	Perf 445710	2018-06-22 00:00:00	NULL	NULL	NULL	P204	NULL	Perf 204	591.39	0.00	1	0	0	0	NULL	0	0	NULL	407	NULL	NULL	NULL
80	209	209	218300	0	Perf 218300	2018-05-01 00:00:00	NULL	NULL	NULL	P209	NULL	Perf 209	776.04	0.00	1	0	0	0	NULL	0	0	NULL	417	NULL	NULL	NULL
80	209	209	512001	0	Perf 512001	2018-05-01 00:00:00	NULL	NULL	NULL	P209	NULL	Perf 209	0.00	776.04	1	0	0	0	NULL	0	0	NULL	418	NULL	NULL	NULL
80	210	210	401002	0	Perf 401002	2018-06-08 00:00:00	NULL	NULL	NULL	P210	NULL	Perf 210	0.00	813.17	1	0	0	0	NULL	0	0	NULL	420	NULL	NULL	NULL
80	210	210	445710	0	Perf 445710	2018-06-08 00:00:00	NULL	NULL	NULL	P210	NULL	Perf 210	813.17	0.00	1	0	0	0	NULL	0	0	NULL	419	NULL	NULL	NULL
80	215	215	218400	0	Perf 218400	2018-05-15 00:00:00	NULL	NULL	NULL	P215	NULL	Perf 215	998.82	0.00	1	0	0	0	NULL	0	0	NULL	429	NULL	NULL	NULL
80	215	215	512001	0	Perf 512001	2018-05-15 00:00:00	NULL	NULL	NULL	P215	NULL	Perf 215	0.00	998.82	1	0	0	0	NULL	0	0	NULL	430	NULL	NULL	NULL
80	216	216	401008	0	Perf 401008	2018-06-22 00:00:00	NULL	NULL	NULL	P216	NULL	Perf 216	0.00	45.95	1	0	0	0	NULL	0	0	NULL	432	NULL	NULL	NULL
80	216	216	445710	0	Perf 445710	2018-06-22 00:00:00	NULL	NULL	NULL	P216	NULL	Perf 216	45.95	0.00	1	0	0	0	NULL	0	0	NULL	431	NULL	NULL	NULL
80	221	221	211000	0	Perf 211000	2018-05-01 00:00:00	NULL	NULL	NULL	P221	NULL	Perf 221	230.60	0.00	1	0	0	0	NULL	0	0	NULL	441	NULL	NULL	NULL
80	221	221	512001	0	Perf 512001	2018-05-01 00:00:00	NULL	NULL	NULL	P221	NULL	Perf 221	0.00	230.60	1	0	0	0	NULL	0	0	NULL	442	NULL	NULL	NULL
80	222	222	401014	0	Perf 401014	2018-06-08 00:00:00	NULL	NULL	NULL	P222	NULL	Perf 222	0.00	267.73	1	0	0	0	NULL	0	0	NULL	444	NULL	NULL	NULL
80	222	222	445710	0	Perf 445710	2018-06-08 00:00:00	NULL	NULL	NULL	P222	NULL	Perf 222	267.73	0.00	1	0	0	0	NULL	0	0	NULL	443	NULL	NULL	NULL
80	227	227	213000	0	Perf 213000	2018-05-15 00:00:00	NULL	NULL	NULL	P227	NULL	Perf 227	452.38	0.00	1	0	0	0	NULL	0	0	NULL	453	NULL	NULL	NULL
80	227	227	512001	0	Perf 512001	2018-05-15 00:00:00	NULL	NULL	NULL	P227	NULL	Perf 227	0.00	452.38	1	0	0	0	NULL	0	0	NULL	454	NULL	NULL	NULL
80	228	228	401020	0	Perf 401020	2018-06-22 00:00:00	NULL	NULL	NULL	P228	NULL	Perf 228	0.00	489.51	1	0	0	0	NULL	0	0	NULL	456	NULL	NULL	NULL
80	228	228	445710	0	Perf 445710	2018-06-22 00:00:00	NULL	NULL	NULL	P228	NULL	Perf 228	489.51	0.00	1	0	0	0	NULL	0	0	NULL	455	NULL	NULL	NULL
80	23	23	218200	0	Perf 218200	2018-05-15 00:00:00	NULL	NULL	NULL	P23	NULL	Perf 23	824.86	0.00	1	0	0	0	NULL	0	0	NULL	45	NULL	NULL	NULL
80	23	23	512001	0	Perf 512001	2018-05-15 00:00:00	NULL	NULL	NULL	P23	NULL	Perf 23	0.00	824.86	1	0	0	0	NULL	0	0	NULL	46	NULL	NULL	NULL
80	233	233	218200	0	Perf 218200	2018-05-01 00:00:00	NULL	NULL	NULL	P233	NULL	Perf 233	674.16	0.00	1	0	0	0	NULL	0	0	NULL	465	NULL	NULL	NULL
80	233	233	512001	0	Perf 512001	2018-05-01 00:00:00	NULL	NULL	NULL	P233	NULL	Perf 233	0.00	674.16	1	0	0	0	NULL	0	0	NULL	466	NULL	NULL	NULL
80	234	234	401026	0	Perf 401026	2018-06-08 00:00:00	NULL	NULL	NULL	P234	NULL	Perf 234	0.00	711.29	1	0	0	0	NULL	0	0	NULL	468	NULL	NULL	NULL
80	234	234	445710	0	Perf 445710	2018-06-08 00:00:00	NULL	NULL	NULL	P234	NULL	Perf 234	711.29	0.00	1	0	0	0	NULL	0	0	NULL	467	NULL	NULL	NULL
80	239	239	218300	0	Perf 218300	2018-05-15 00:00:00	NULL	NULL	NULL	P239	NULL	Perf 239	896.94	0.00	1	0	0	0	NULL	0	0	NULL	477	NULL	NULL	NULL
80	239	239	512001	0	Perf 512001	2018-05-15 00:00:00	NULL	NULL	NULL	P239	NULL	Perf 239	0.00	896.94	1	0	0	0	NULL	0	0	NULL	478	NULL	NULL	NULL
80	24	24	401024	0	Perf 401024	2018-06-22 00:00:00	NULL	NULL	NULL	P24	NULL	Perf 24	0.00	861.99	1	0	0	0	NULL	0	0	NULL	48	NULL	NULL	NULL
80	24	24	445710	0	Perf 445710	2018-06-22 00:00:00	NULL	NULL	NULL	P24	NULL	Perf 24	861.99	0.00	1	0	0	0	NULL	0	0	NULL	47	NULL	NULL	NULL
80	240	240	401006	0	Perf 401006	2018-06-22 00:00:00	NULL	NULL	NULL	P240	NULL	Perf 240	0.00	933.07	1	0	0	0	NULL	0	0	NULL	480	NULL	NULL	NULL
80	240	240	445710	0	Perf 445710	2018-06-22 00:00:00	NULL	NULL	NULL	P240	NULL	Perf 240	933.07	0.00	1	0	0	0	NULL	0	0	NULL	479	NULL	NULL	NULL
80	245	245	218400	0	Perf 218400	2018-05-01 00:00:00	NULL	NULL	NULL	P245	NULL	Perf 245	128.72	0.00	1	0	0	0	NULL	0	0	NULL	489	NULL	NULL	NULL
80	245	245	512001	0	Perf 512001	2018-05-01 00:00:00	NULL	NULL	NULL	P245	NULL	Perf 245	0.00	128.72	1	0	0	0	NULL	0	0	NULL	490	NULL	NULL	NULL
80	246	246	401012	0	Perf 401012	2018-06-08 00:00:00	NULL	NULL	NULL	P246	NULL	Perf 246	0.00	165.85	1	0	0	0	NULL	0	0	NULL	492	NULL	NULL	NULL
80	246	246	445710	0	Perf 445710	2018-06-08 00:00:00	NULL	NULL	NULL	P246	NULL	Perf 246	165.85	0.00	1	0	0	0	NULL	0	0	NULL	491	NULL	NULL	NULL
80	251	251	211000	0	Perf 211000	2018-05-15 00:00:00	NULL	NULL	NULL	P251	NULL	Perf 251	350.50	0.00	1	0	0	0	NULL	0	0	NULL	501	NULL	NULL	NULL
80	251	251	512001	0	Perf 512001	2018-05-15 00:00:00	NULL	NULL	NULL	P251	NULL	Perf 251	0.00	350.50	1	0	0	0	NULL	0	0	NULL	502	NULL	NULL	NULL
80	252	252	401018	0	Perf 401018	2018-06-22 00:00:00	NULL	NULL	NULL	P252	NULL	Perf 252	0.00	387.63	1	0	0	0	NULL	0	0	NULL	504	NULL	NULL	NULL
80	252	252	445710	0	Perf 445710	2018-06-22 00:00:00	NULL	NULL	NULL	P252	NULL	Perf 252	387.63	0.00	1	0	0	0	NULL	0	0	NULL	503	NULL	NULL	NULL
80	257	257	213000	0	Perf 213000	2018-05-01 00:00:00	NULL	NULL	NULL	P257	NULL	Perf 257	572.28	0.00	1	0	0	0	NULL	0	0	NULL	513	NULL	NULL	NULL
80	257	257	512001	0	Perf 512001	2018-05-01 00:00:00	NULL	NULL	NULL	P257	NULL	Perf 257	0.00	572.28	1	0	0	0	NULL	0	0	NULL	514	NULL	NULL	NULL
80	258	258	401024	0	Perf 401024	2018-06-08 00:00:00	NULL	NULL	NULL	P258	NULL	Perf 258	0.00	609.41	1	0	0	0	NULL	0	0	NULL	516	NULL	NULL	NULL
80	258	258	445710	0	Perf 445710	2018-06-08 00:00:00	NULL	NULL	NULL	P258	NULL	Perf 258	609.41	0.00	1	0	0	0	NULL	0	0	NULL	515	NULL	NULL	NULL
80	263	263	218200	0	Perf 218200	2018-05-15 00:00:00	NULL	NULL	NULL	P263	NULL	Perf 263	794.06	0.00	1	0	0	0	NULL	0	0	NULL	525	NULL	NULL	NULL
80	263	263	512001	0	Perf 512001	2018-05-15 00:00:00	NULL	NULL	NULL	P263	NULL	Perf 263	0.00	794.06	1	0	0	0	NULL	0	0	NULL	526	NULL	NULL	NULL
80	264	264	401004	0	Perf 401004	2018-06-22 00:00:00	NULL	NULL	NULL	P264	NULL	Perf 264	0.00	831.19	1	0	0	0	NULL	0	0	NULL	528	NULL	NULL	NULL
80	264	264	445710	0	Perf 445710	2018-06-22 00:00:00	NULL	NULL	NULL	P264	NULL	Perf 264	831.19	0.00	1	0	0	0	NULL	0	0	NULL	527	NULL	NULL	NULL
80	269	269	218300	0	Perf 218300	2018-05-01 00:00:00	NULL	NULL	NULL	P269	NULL	Perf 269	26.84	0.00	1	0	0	0	NULL	0	0	NULL	537	NULL	NULL	NULL
80	269	269	512001	0	Perf 512001	2018-05-01 00:00:00	NULL	NULL	NULL	P269	NULL	Perf 269	0.00	26.84	1	0	0	0	NULL	0	0	NULL	538	NULL	NULL	NULL
80	270	270	401010	0	Perf 401010	2018-06-08 00:00:00	NULL	NULL	NULL	P270	NULL	Perf 270	0.00	63.97	1	0	0	0	NULL	0	0	NULL	540	NULL	NULL	NULL
80	270	270	445710	0	Perf 445710	2018-06-08 00:00:00	NULL	NULL	NULL	P270	NULL	Perf 270	63.97	0.00	1	0	0	0	NULL	0	0	NULL	539	NULL	NULL	NULL
80	275	275	218400	0	Perf 218400	2018-05-15 00:00:00	NULL	NULL	NULL	P275	NULL	Perf 275	248.62	0.00	1	0	0	0	NULL	0	0	NULL	549	NULL	NULL	NULL
80	275	275	512001	0	Perf 512001	2018-05-15 00:00:00	NULL	NULL	NULL	P275	NULL	Perf 275	0.00	248.62	1	0	0	0	NULL	0	0	NULL	550	NULL	NULL	NULL
80	276	276	401016	0	Perf 401016	2018-06-22 00:00:00	NULL	NULL	NULL	P276	NULL	Perf 276	0.00	285.75	1	0	0	0	NULL	0	0	NULL	552	NULL	NULL	NULL
80	276	276	445710	0	Perf 445710	2018-06-22 00:00:00	NULL	NULL	NULL	P276	NULL	Perf 276	285.75	0.00	1	0	0	0	NULL	0	0	NULL	551	NULL	NULL	NULL
80	281	281	211000	0	Perf 211000	2018-05-01 00:00:00	NULL	NULL	NULL	P281	NULL	Perf 281	470.40	0.00	1	0	0	0	NULL	0	0	NULL	561	NULL	NULL	NULL
80	281	281	512001	0	Perf 512001	2018-05-01 00:00:00	NULL	NULL	NULL	P281	NULL	Perf 281	0.00	470.40	1	0	0	0	NULL	0	0	NULL	562	NULL	NULL	NULL
80	282	282	401022	0	Perf 401022	2018-06-08 00:00:00	NULL	NULL	NULL	P282	NULL	Perf 282	0.00	507.53	1	0	0	0	NULL	0	0	NULL	564	NULL	NULL	NULL
80	282	282	445710	0	Perf 445710	2018-06-08 00:00:00	NULL	NULL	NULL	P282	NULL	Perf 282	507.53	0.00	1	0	0	0	NULL	0	0	NULL	563	NULL	NULL	NULL
80	287	287	213000	0	Perf 213000	2018-05-15 00:00:00	NULL	NULL	NULL	P287	NULL	Perf 287	692.18	0.00	1	0	0	0	NULL	0	0	NULL	573	NULL	NULL	NULL
80	287	287	512001	0	Perf 512001	2018-05-15 00:00:00	NULL	NULL	NULL	P287	NULL	Perf 287	0.00	692.18	1	0	0	0	NULL	0	0	NULL	574	NULL	NULL	NULL
80	288	288	401002	0	Perf 401002	2018-06-22 00:00:00	NULL	NULL	NULL	P288	NULL	Perf 288	0.00	729.31	1	0	0	0	NULL	0	0	NULL	576	NULL	NULL	NULL
80	288	288	445710	0	Perf 445710	2018-06-22 00:00:00	NULL	NULL	NULL	P288	NULL	Perf 288	729.31	0.00	1	0	0	0	NULL	0	0	NULL	575	NULL	NULL	NULL
80	29	29	218300	0	Perf 218300	2018-05-01 00:00:00	NULL	NULL	NULL	P29	NULL	Perf 29	56.64	0.00	1	0	0	0	NULL	0	0	NULL	57	NULL	NULL	NULL
80	29	29	512001	0	Perf 512001	2018-05-01 00:00:00	NULL	NULL	NULL	P29	NULL	Perf 29	0.00	56.64	1	0	0	0	NULL	0	0	NULL	58	NULL	NULL	NULL
80	293	293	218200	0	Perf 218200	2018-05-01 00:00:00	NULL	NULL	NULL	P293	NULL	Perf 293	914.96	0.00	1	0	0	0	NULL	0	0	NULL	585	NULL	NULL	NULL
80	293	293	512001	0	Perf 512001	2018-05-01 00:00:00	NULL	NULL	NULL	P293	NULL	Perf 293	0.00	914.96	1	0	0	0	NULL	0	0	NULL	586	NULL	NULL	NULL
80	294	294	401008	0	Perf 401008	2018-06-08 00:00:00	NULL	NULL	NULL	P294	NULL	Perf 294	0.00	951.09	1	0	0	0	NULL	0	0	NULL	588	NULL	NULL	NULL
80	294	294	445710	0	Perf 445710	2018-06-08 00:00:00	NULL	NULL	NULL	P294	NULL	Perf 294	951.09	0.00	1	0	0	0	NULL	0	0	NULL	587	NULL	NULL	NULL
80	299	299	218300	0	Perf 218300	2018-05-15 00:00:00	NULL	NULL	NULL	P299	NULL	Perf 299	146.74	0.00	1	0	0	0	NULL	0	0	NULL	597	NULL	NULL	NULL
80	299	299	512001	0	Perf 512001	2018-05-15 00:00:00	NULL	NULL	NULL	P299	NULL	Perf 299	0.00	146.74	1	0	0	0	NULL	0	0	NULL	598	NULL	NULL	NULL
80	30	30	401004	0	Perf 401004	2018-06-08 00:00:00	NULL	NULL	NULL	P30	NULL	Perf 30	0.00	93.77	1	0	0	0	NULL	0	0	NULL	60	NULL	NULL	NULL
80	30	30	445710	0	Perf 445710	2018-06-08 00:00:00	NULL	NULL	NULL	P30	NULL	Perf 30	93.77	0.00	1	0	0	0	NULL	0	0	NULL	59	NULL	NULL	NULL
80	300	300	401014	0	Perf 401014	2018-06-22 00:00:00	NULL	NULL	NULL	P300	NULL	Perf 300	0.00	183.87	1	0	0	0	NULL	0	0	NULL	600	NULL	NULL	NULL
80	300	300	445710	0	Perf 445710	2018-06-22 00:00:00	NULL	NULL	NULL	P300	NULL	Perf 300	183.87	0.00	1	0	0	0	NULL	0	0	NULL	599	NULL	NULL	NULL
80	305	305	218400	0	Perf 218400	2018-05-01 00:00:00	NULL	NULL	NULL	P305	NULL	Perf 305	368.52	0.00	1	0	0	0	NULL	0	0	NULL	609	NULL	NULL	NULL
80	305	305	512001	0	Perf 512001	2018-05-01 00:00:00	NULL	NULL	NULL	P305	NULL	Perf 305	0.00	368.52	1	0	0	0	NULL	0	0	NULL	610	NULL	NULL	NULL
80	306	306	401020	0	Perf 401020	2018-06-08 00:00:00	NULL	NULL	NULL	P306	NULL	Perf 306	0.00	405.65	1	0	0	0	NULL	0	0	NULL	612	NULL	NULL	NULL
80	306	306	445710	0	Perf 445710	2018-06-08 00:00:00	NULL	NULL	NULL	P306	NULL	Perf 306	405.65	0.00	1	0	0	0	NULL	0	0	NULL	611	NULL	NULL	NULL
80	311	311	211000	0	Perf 211000	2018-05-15 00:00:00	NULL	NULL	NULL	P311	NULL	Perf 311	590.30	0.00	1	0	0	0	NULL	0	0	NULL	621	NULL	NULL	NULL
80	311	311	512001	0	Perf 512001	2018-05-15 00:00:00	NULL	NULL	NULL	P311	NULL	Perf 311	0.00	590.30	1	0	0	0	NULL	0	0	NULL	622	NULL	NULL	NULL
80	312	312	401026	0	Perf 401026	2018-06-22 00:00:00	NULL	NULL	NULL	P312	NULL	Perf 312	0.00	627.43	1	0	0	0	NULL	0	0	NULL	624	NULL	NULL	NULL
80	312	312	445710	0	Perf 445710	2018-06-22 00:00:00	NULL	NULL	NULL	P312	NULL	Perf 312	627.43	0.00	1	0	0	0	NULL	0	0	NULL	623	NULL	NULL	NULL
80	317	317	213000	0	Perf 213000	2018-05-01 00:00:00	NULL	NULL	NULL	P317	NULL	Perf 317	812.08	0.00	1	0	0	0	NULL	0	0	NULL	633	NULL	NULL	NULL
80	317	317	512001	0	Perf 512001	2018-05-01 00:00:00	NULL	NULL	NULL	P317	NULL	Perf 317	0.00	812.08	1	0	0	0	NULL	0	0	NULL	634	NULL	NULL	NULL
80	318	318	401006	0	Perf 401006	2018-06-08 00:00:00	NULL	NULL	NULL	P318	NULL	Perf 318	0.00	849.21	1	0	0	0	NULL	0	0	NULL	636	NULL	NULL	NULL
80	318	318	445710	0	Perf 445710	2018-06-08 00:00:00	NULL	NULL	NULL	P318	NULL	Perf 318	849.21	0.00	1	0	0	0	NULL	0	0	NULL	635	NULL	NULL	NULL
80	323	323	218200	0	Perf 218200	2018-05-15 00:00:00	NULL	NULL	NULL	P323	NULL	Perf 323	44.86	0.00	1	0	0	0	NULL	0	0	NULL	645	NULL	NULL	NULL
80	323	323	512001	0	Perf 512001	2018-05-15 00:00:00	NULL	NULL	NULL	P323	NULL	Perf 323	0.00	44.86	1	0	0	0	NULL	0	0	NULL	646	NULL	NULL	NULL
80	324	324	401012	0	Perf 401012	2018-06-22 00:00:00	NULL	NULL	NULL	P324	NULL	Perf 324	0.00	81.99	1	0	0	0	NULL	0	0	NULL	648	NULL	NULL	NULL
80	324	324	445710	0	Perf 445710	2018-06-22 00:00:00	NULL	NULL	NULL	P324	NULL	Perf 324	81.99	0.00	1	0	0	0	NULL	0	0	NULL	647	NULL	NULL	NULL
80	329	329	218300	0	Perf 218300	2018-05-01 00:00:00	NULL	NULL	NULL	P329	NULL	Perf 329	266.64	0.00	1	0	0	0	NULL	0	0	NULL	657	NULL	NULL	NULL
80	329	329	512001	0	Perf 512001	2018-05-01 00:00:00	NULL	NULL	NULL	P329	NULL	Perf 329	0.00	266.64	1	0	0	0	NULL	0	0	NULL	658	NULL	NULL	NULL
80	330	330	401018	0	Perf 401018	2018-06-08 00:00:00	NULL	NULL	NULL	P330	NULL	Perf 330	0.00	303.77	1	0	0	0	NULL	0	0	NULL	660	NULL	NULL	NULL
80	330	330	445710	0	Perf 445710	2018-06-08 00:00:00	NULL	NULL	NULL	P330	NULL	Perf 330	303.77	0.00	1	0	0	0	NULL	0	0	NULL	659	NULL	NULL	NULL
80	335	335	218400	0	Perf 218400	2018-05-15 00:00:00	NULL	NULL	NULL	P335	NULL	Perf 335	488.42	0.00	1	0	0	0	NULL	0	0	NULL	669	NULL	NULL	NULL
80	335	335	512001	0	Perf 512001	2018-05-15 00:00:00	NULL	NULL	NULL	P335	NULL	Perf 335	0.00	488.42	1	0	0	0	NULL	0	0	NULL	670	NULL	NULL	NULL
80	336	336	401024	0	Perf 401024	2018-06-22 00:00:00	NULL	NULL	NULL	P336	NULL	Perf 336	0.00	525.55	1	0	0	0	NULL	0	0	NULL	672	NULL	NULL	NULL
80	336	336	445710	0	Perf 445710	2018-06-22 00:00:00	NULL	NULL	NULL	P336	NULL	Perf 336	525.55	0.00	1	0	0	0	NULL	0	0	NULL	671	NULL	NULL	NULL
80	341	341	211000	0	Perf 211000	2018-05-01 00:00:00	NULL	NULL	NULL	P341	NULL	Perf 341	710.20	0.00	1	0	0	0	NULL	0	0	NULL	681	NULL	NULL	NULL
80	341	341	512001	0	Perf 512001	2018-05-01 00:00:00	NULL	NULL	NULL	P341	NULL	Perf 341	0.00	710.20	1	0	0	0	NULL	0	0	NULL	682	NULL	NULL	NULL
80	342	342	401004	0	Perf 401004	2018-06-08 00:00:00	NULL	NULL	NULL	P342	NULL	Perf 342	0.00	747.33	1	0	0	0	NULL	0	0	NULL	684	NULL	NULL	NULL
80	342	342	445710	0	Perf 445710	2018-06-08 00:00:00	NULL	NULL	NULL	P342	NULL	Perf 342	747.33	0.00	1	0	0	0	NULL	0	0	NULL	683	NULL	NULL	NULL
80	347	347	213000	0	Perf 213000	2018-05-15 00:00:00	NULL	NULL	NULL	P347	NULL	Perf 347	932.98	0.00	1	0	0	0	NULL	0	0	NULL	693	NULL	NULL	NULL
80	347	347	512001	0	Perf 512001	2018-05-15 00:00:00	NULL	NULL	NULL	P347	NULL	Perf 347	0.00	932.98	1	0	0	0	NULL	0	0	NULL	694	NULL	NULL	NULL
80	348	348	401010	0	Perf 401010	2018-06-22 00:00:00	NULL	NULL	NULL	P348	NULL	Perf 348	0.00	969.11	1	0	0	0	NULL	0	0	NULL	696	NULL	NULL	NULL
80	348	348	445710	0	Perf 445710	2018-06-22 00:00:00	NULL	NULL	NULL	P348	NULL	Perf 348	969.11	0.00	1	0	0	0	NULL	0	0	NULL	695	NULL	NULL	NULL
80	35	35	218400	0	Perf 218400	2018-05-15 00:00:00	NULL	NULL	NULL	P35	NULL	Perf 35	278.42	0.00	1	0	0	0	NULL	0	0	NULL	69	NULL	NULL	NULL
80	35	35	512001	0	Perf 512001	2018-05-15 00:00:00	NULL	NULL	NULL	P35	NULL	Perf 35	0.00	278.42	1	0	0	0	NULL	0	0	NULL	70	NULL	NULL	NULL
80	353	353	218200	0	Perf 218200	2018-05-01 00:00:00	NULL	NULL	NULL	P353	NULL	Perf 353	164.76	0.00	1	0	0	0	NULL	0	0	NULL	705	NULL	NULL	NULL
80	353	353	512001	0	Perf 512001	2018-05-01 00:00:00	NULL	NULL	NULL	P353	NULL	Perf 353	0.00	164.76	1	0	0	0	NULL	0	0	NULL	706	NULL	NULL	NULL
80	354	354	401016	0	Perf 401016	2018-06-08 00:00:00	NULL	NULL	NULL	P354	NULL	Perf 354	0.00	201.89	1	0	0	0	NULL	0	0	NULL	708	NULL	NULL	NULL
80	354	354	445710	0	Perf 445710	2018-06-08 00:00:00	NULL	NULL	NULL	P354	NULL	Perf 354	201.89	0.00	1	0	0	0	NULL	0	0	NULL	707	NULL	NULL	NULL
80	359	359	218300	0	Perf 218300	2018-05-15 00:00:00	NULL	NULL	NULL	P359	NULL	Perf 359	386.54	0.00	1	0	0	0	NULL	0	0	NULL	717	NULL	NULL	NULL
80	359	359	512001	0	Perf 512001	2018-05-15 00:00:00	NULL	NULL	NULL	P359	NULL	Perf 359	0.00	386.54	1	0	0	0	NULL	0	0	NULL	718	NULL	NULL	NULL
80	36	36	401010	0	Perf 401010	2018-06-22 00:00:00	NULL	NULL	NULL	P36	NULL	Perf 36	0.00	315.55	1	0	0	0	NULL	0	0	NULL	72	NULL	NULL	NULL
80	36	36	445710	0	Perf 445710	2018-06-22 00:00:00	NULL	NULL	NULL	P36	NULL	Perf 36	315.55	0.00	1	0	0	0	NULL	0	0	NULL	71	NULL	NULL	NULL
80	360	360	401022	0	Perf 401022	2018-06-22 00:00:00	NULL	NULL	NULL	P360	NULL	Perf 360	0.00	423.67	1	0	0	0	NULL	0	0	NULL	720	NULL	NULL	NULL
80	360	360	445710	0	Perf 445710	2018-06-22 00:00:00	NULL	NULL	NULL	P360	NULL	Perf 360	423.67	0.00	1	0	0	0	NULL	0	0	NULL	719	NULL	NULL	NULL
80	365	365	218400	0	Perf 218400	2018-05-01 00:00:00	NULL	NULL	NULL	P365	NULL	Perf 365	608.32	0.00	1	0	0	0	NULL	0	0	NULL	729	NULL	NULL	NULL
80	365	365	512001	0	Perf 512001	2018-05-01 00:00:00	NULL	NULL	NULL	P365	NULL	Perf 365	0.00	608.32	1	0	0	0	NULL	0	0	NULL	730	NULL	NULL	NULL
80	366	366	401002	0	Perf 401002	2018-06-08 00:00:00	NULL	NULL	NULL	P366	NULL	Perf 366	0.00	645.45	1	0	0	0	NULL	0	0	NULL	732	NULL	NULL	NULL
80	366	366	445710	0	Perf 445710	2018-06-08 00:00:00	NULL	NULL	NULL	P366	NULL	Perf 366	645.45	0.00	1	0	0	0	NULL	0	0	NULL	731	NULL	NULL	NULL
80	371	371	211000	0	Perf 211000	2018-05-15 00:00:00	NULL	NULL	NULL	P371	NULL	Perf 371	830.10	0.00	1	0	0	0	NULL	0	0	NULL	741	NULL	NULL	NULL
80	371	371	512001	0	Perf 512001	2018-05-15 00:00:00	NULL	NULL	NULL	P371	NULL	Perf 371	0.00	830.10	1	0	0	0	NULL	0	0	NULL	742	NULL	NULL	NULL
80	372	372	401008	0	Perf 401008	2018-06-22 00:00:00	NULL	NULL	NULL	P372	NULL	Perf 372	0.00	867.23	1	0	0	0	NULL	0	0	NULL	744	NULL	NULL	NULL
80	372	372	445710	0	Perf 445710	2018-06-22 00:00:00	NULL	NULL	NULL	P372	NULL	Perf 372	867.23	0.00	1	0	0	0	NULL	0	0	NULL	743	NULL	NULL	NULL
80	377	377	213000	0	Perf 213000	2018-05-01 00:00:00	NULL	NULL	NULL	P377	NULL	Perf 377	62.88	0.00	1	0	0	0	NULL	0	0	NULL	753	NULL	NULL	NULL
80	377	377	512001	0	Perf 512001	2018-05-01 00:00:00	NULL	NULL	NULL	P377	NULL	Perf 377	0.00	62.88	1	0	0	0	NULL	0	0	NULL	754	NULL	NULL	NULL
80	378	378	401014	0	Perf 401014	2018-06-08 00:00:00	NULL	NULL	NULL	P378	NULL	Perf 378	0.00	99.01	1	0	0	0	NULL	0	0	NULL	756	NULL	NULL	NULL
80	378	378	445710	0	Perf 445710	2018-06-08 00:00:00	NULL	NULL	NULL	P378	NULL	Perf 378	99.01	0.00	1	0	0	0	NULL	0	0	NULL	755	NULL	NULL	NULL
80	383	383	218200	0	Perf 218200	2018-05-15 00:00:00	NULL	NULL	NULL	P383	NULL	Perf 383	284.66	0.00	1	0	0	0	NULL	0	0	NULL	765	NULL	NULL	NULL
80	383	383	512001	0	Perf 512001	2018-05-15 00:00:00	NULL	NULL	NULL	P383	NULL	Perf 383	0.00	284.66	1	0	0	0	NULL	0	0	NULL	766	NULL	NULL	NULL
80	384	384	401020	0	Perf 401020	2018-06-22 00:00:00	NULL	NULL	NULL	P384	NULL	Perf 384	0.00	321.79	1	0	0	0	NULL	0	0	NULL	768	NULL	NULL	NULL
80	384	384	445710	0	Perf 445710	2018-06-22 00:00:00	NULL	NULL	NULL	P384	NULL	Perf 384	321.79	0.00	1	0	0	0	NULL	0	0	NULL	767	NULL	NULL	NULL
80	389	389	218300	0	Perf 218300	2018-05-01 00:00:00	NULL	NULL	NULL	P389	NULL	Perf 389	506.44	0.00	1	0	0	0	NULL	0	0	NULL	777	NULL	NULL	NULL
80	389	389	512001	0	Perf 512001	2018-05-01 00:00:00	NULL	NULL	NULL	P389	NULL	Perf 389	0.00	506.44	1	0	0	0	NULL	0	0	NULL	778	NULL	NULL	NULL
80	390	390	401026	0	Perf 401026	2018-06-08 00:00:00	NULL	NULL	NULL	P390	NULL	Perf 390	0.00	543.57	1	0	0	0	NULL	0	0	NULL	780	NULL	NULL	NULL
80	390	390	445710	0	Perf 445710	2018-06-08 00:00:00	NULL	NULL	NULL	P390	NULL	Perf 390	543.57	0.00	1	0	0	0	NULL	0	0	NULL	779	NULL	NULL	NULL
80	395	395	218400	0	Perf 218400	2018-05-15 00:00:00	NULL	NULL	NULL	P395	NULL	Perf 395	728.22	0.00	1	0	0	0	NULL	0	0	NULL	789	NULL	NULL	NULL
80	395	395	512001	0	Perf 512001	2018-05-15 00:00:00	NULL	NULL	NULL	P395	NULL	Perf 395	0.00	728.22	1	0	0	0	NULL	0	0	NULL	790	NULL	NULL	NULL
80	396	396	401006	0	Perf 401006	2018-06-22 00:00:00	NULL	NULL	NULL	P396	NULL	Perf 396	0.00	765.35	1	0	0	0	NULL	0	0	NULL	792	NULL	NULL	NULL
80	396	396	445710	0	Perf 445710	2018-06-22 00:00:00	NULL	NULL	NULL	P396	NULL	Perf 396	765.35	0.00	1	0	0	0	NULL	0	0	NULL	791	NULL	NULL	NULL
80	401	401	211000	0	Perf 211000	2018-05-01 00:00:00	NULL	NULL	NULL	P401	NULL	Perf 401	950.00	0.00	1	0	0	0	NULL	0	0	NULL	801	NULL	NULL	NULL
80	401	401	512001	0	Perf 512001	2018-05-01 00:00:00	NULL	NULL	NULL	P401	NULL	Perf 401	0.00	950.00	1	0	0	0	NULL	0	0	NULL	802	NULL	NULL	NULL
80	402	402	401012	0	Perf 401012	2018-06-08 00:00:00	NULL	NULL	NULL	P402	NULL	Perf 402	0.00	987.13	1	0	0	0	NULL	0	0	NULL	804	NULL	NULL	NULL
80	402	402	445710	0	Perf 445710	2018-06-08 00:00:00	NULL	NULL	NULL	P402	NULL	Perf 402	987.13	0.00	1	0	0	0	NULL	0	0	NULL	803	NULL	NULL	NULL
80	407	407	213000	0	Perf 213000	2018-05-15 00:00:00	NULL	NULL	NULL	P407	NULL	Perf 407	182.78	0.00	1	0	0	0	NULL	0	0	NULL	813	NULL	NULL	NULL
80	407	407	512001	0	Perf 512001	2018-05-15 00:00:00	NULL	NULL	NULL	P407	NULL	Perf 407	0.00	182.78	1	0	0	0	NULL	0	0	NULL	814	NULL	NULL	NULL
80	408	408	401018	0	Perf 401018	2018-06-22 00:00:00	NULL	NULL	NULL	P408	NULL	Perf 408	0.00	219.91	1	0	0	0	NULL	0	0	NULL	816	NULL	NULL	NULL
80	408	408	445710	0	Perf 445710	2018-06-22 00:00:00	NULL	NULL	NULL	P408	NULL	Perf 408	219.91	0.00	1	0	0	0	NULL	0	0	NULL	815	NULL	NULL	NULL
80	41	41	211000	0	Perf 211000	2018-05-01 00:00:00	NULL	NULL	NULL	P41	NULL	Perf 41	500.20	0.00	1	0	0	0	NULL	0	0	NULL	81	NULL	NULL	NULL
80	41	41	512001	0	Perf 512001	2018-05-01 00:00:00	NULL	NULL	NULL	P41	NULL	Perf 41	0.00	500.20	1	0	0	0	NULL	0	0	NULL	82	NULL	NULL	NULL
80	413	413	218200	0	Perf 218200	2018-05-01 00:00:00	NULL	NULL	NULL	P413	NULL	Perf 413	404.56	0.00	1	0	0	0	NULL	0	0	NULL	825	NULL	NULL	NULL
80	413	413	512001	0	Perf 512001	2018-05-01 00:00:00	NULL	NULL	NULL	P413	NULL	Perf 413	0.00	404.56	1	0	0	0	NULL	0	0	NULL	826	NULL	NULL	NULL
80	414	414	401024	0	Perf 401024	2018-06-08 00:00:00	NULL	NULL	NULL	P414	NULL	Perf 414	0.00	441.69	1	0	0	0	NULL	0	0	NULL	828	NULL	NULL	NULL
80	414	414	445710	0	Perf 445710	2018-06-08 00:00:00	NULL	NULL	NULL	P414	NULL	Perf 414	441.69	0.00	1	0	0	0	NULL	0	0	NULL	827	NULL	NULL	NULL
80	419	419	218300	0	Perf 218300	2018-05-15 00:00:00	NULL	NULL	NULL	P419	NULL	Perf 419	626.34	0.00	1	0	0	0	NULL	0	0	NULL	837	NULL	NULL	NULL
80	419	419	512001	0	Perf 512001	2018-05-15 00:00:00	NULL	NULL	NULL	P419	NULL	Perf 419	0.00	626.34	1	0	0	0	NULL	0	0	NULL	838	NULL	NULL	NULL
80	42	42	401016	0	Perf 401016	2018-06-08 00:00:00	NULL	NULL	NULL	P42	NULL	Perf 42	0.00	537.33	1	0	0	0	NULL	0	0	NULL	84	NULL	NULL	NULL
80	42	42	445710	0	Perf 445710	2018-06-08 00:00:00	NULL	NULL	NULL	P42	NULL	Perf 42	537.33	0.00	1	0	0	0	NULL	0	0	NULL	83	NULL	NULL	NULL
80	420	420	401004	0	Perf 401004	2018-06-22 00:00:00	NULL	NULL	NULL	P420	NULL	Perf 420	0.00	663.47	1	0	0	0	NULL	0	0	NULL	840	NULL	NULL	NULL
80	420	420	445710	0	Perf 445710	2018-06-22 00:00:00	NULL	NULL	NULL	P420	NULL	Perf 420	663.47	0.00	1	0	0	0	NULL	0	0	NULL	839	NULL	NULL	NULL
80	425	425	218400	0	Perf 218400	2018-05-01 00:00:00	NULL	NULL	NULL	P425	NULL	Perf 425	848.12	0.00	1	0	0	0	NULL	0	0	NULL	849	NULL	NULL	NULL
80	425	425	512001	0	Perf 512001	2018-05-01 00:00:00	NULL	NULL	NULL	P425	NULL	Perf 425	0.00	848.12	1	0	0	0	NULL	0	0	NULL	850	NULL	NULL	NULL
80	426	426	401010	0	Perf 401010	2018-06-08 00:00:00	NULL	NULL	NULL	P426	NULL	Perf 426	0.00	885.25	1	0	0	0	NULL	0	0	NULL	852	NULL	NULL	NULL
80	426	426	445710	0	Perf 445710	2018-06-08 00:00:00	NULL	NULL	NULL	P426	NULL	Perf 426	885.25	0.00	1	0	0	0	NULL	0	0	NULL	851	NULL	NULL	NULL
80	431	431	211000	0	Perf 211000	2018-05-15 00:00:00	NULL	NULL	NULL	P431	NULL	Perf 431	80.90	0.00	1	0	0	0	NULL	0	0	NULL	861	NULL	NULL	NULL
80	431	431	512001	0	Perf 512001	2018-05-15 00:00:00	NULL	NULL	NULL	P431	NULL	Perf 431	0.00	80.90	1	0	0	0	NULL	0	0	NULL	862	NULL	NULL	NULL
80	432	432	401016	0	Perf 401016	2018-06-22 00:00:00	NULL	NULL	NULL	P432	NULL	Perf 432	0.00	117.03	1	0	0	0	NULL	0	0	NULL	864	NULL	NULL	NULL
80	432	432	445710	0	Perf 445710	2018-06-22 00:00:00	NULL	NULL	NULL	P432	NULL	Perf 432	117.03	0.00	1	0	0	0	NULL	0	0	NULL	863	NULL	NULL	NULL
80	437	437	213000	0	Perf 213000	2018-05-01 00:00:00	NULL	NULL	NULL	P437	NULL	Perf 437	302.68	0.00	1	0	0	0	NULL	0	0	NULL	873	NULL	NULL	NULL
80	437	437	512001	0	Perf 512001	2018-05-01 00:00:00	NULL	NULL	NULL	P437	NULL	Perf 437	0.00	302.68	1	0	0	0	NULL	0	0	NULL	874	NULL	NULL	NULL
80	438	438	401022	0	Perf 401022	2018-06-08 00:00:00	NULL	NULL	NULL	P438	NULL	Perf 438	0.00	339.81	1	0	0	0	NULL	0	0	NULL	876	NULL	NULL	NULL
80	438	438	445710	0	Perf 445710	2018-06-08 00:00:00	NULL	NULL	NULL	P438	NULL	Perf 438	339.81	0.00	1	0	0	0	NULL	0	0	NULL	875	NULL	NULL	NULL
80	443	443	218200	0	Perf 218200	2018-05-15 00:00:00	NULL	NULL	NULL	P443	NULL	Perf 443	524.46	0.00	1	0	0	0	NULL	0	0	NULL	885	NULL	NULL	NULL
80	443	443	512001	0	Perf 512001	2018-05-15 00:00:00	NULL	NULL	NULL	P443	NULL	Perf 443	0.00	524.46	1	0	0	0	NULL	0	0	NULL	886	NULL	NULL	NULL
80	444	444	401002	0	Perf 401002	2018-06-22 00:00:00	NULL	NULL	NULL	P444	NULL	Perf 444	0.00	561.59	1	0	0	0	NULL	0	0	NULL	888	NULL	NULL	NULL
80	444	444	445710	0	Perf 445710	2018-06-22 00:00:00	NULL	NULL	NULL	P444	NULL	Perf 444	561.59	0.00	1	0	0	0	NULL	0	0	NULL	887	NULL	NULL	NULL
80	449	449	218300	0	Perf 218300	2018-05-01 00:00:00	NULL	NULL	NULL	P449	NULL	Perf 449	746.24	0.00	1	0	0	0	NULL	0	0	NULL	897	NULL	NULL	NULL
80	449	449	512001	0	Perf 512001	2018-05-01 00:00:00	NULL	NULL	NULL	P449	NULL	Perf 449	0.00	746.24	1	0	0	0	NULL	0	0	NULL	898	NULL	NULL	NULL
80	450	450	401008	0	Perf 401008	2018-06-08 00:00:00	NULL	NULL	NULL	P450	NULL	Perf 450	0.00	783.37	1	0	0	0	NULL	0	0	NULL	900	NULL	NULL	NULL
80	450	450	445710	0	Perf 445710	2018-06-08 00:00:00	NULL	NULL	NULL	P450	NULL	Perf 450	783.37	0.00	1	0	0	0	NULL	0	0	NULL	899	NULL	NULL	NULL
80	455	455	218400	0	Perf 218400	2018-05-15 00:00:00	NULL	NULL	NULL	P455	NULL	Perf 455	968.02	0.00	1	0	0	0	NULL	0	0	NULL	909	NULL	NULL	NULL
80	455	455	512001	0	Perf 512001	2018-05-15 00:00:00	NULL	NULL	NULL	P455	NULL	Perf 455	0.00	968.02	1	0	0	0	NULL	0	0	NULL	910	NULL	NULL	NULL
80	456	456	401014	0	Perf 401014	2018-06-22 00:00:00	NULL	NULL	NULL	P456	NULL	Perf 456	0.00	15.15	1	0	0	0	NULL	0	0	NULL	912	NULL	NULL	NULL
80	456	456	445710	0	Perf 445710	2018-06-22 00:00:00	NULL	NULL	NULL	P456	NULL	Perf 456	15.15	0.00	1	0	0	0	NULL	0	0	NULL	911	NULL	NULL	NULL
80	461	461	211000	0	Perf 211000	2018-05-01 00:00:00	NULL	NULL	NULL	P461	NULL	Perf 461	200.80	0.00	1	0	0	0	NULL	0	0	NULL	921	NULL	NULL	NULL
80	461	461	512001	0	Perf 512001	2018-05-01 00:00:00	NULL	NULL	NULL	P461	NULL	Perf 461	0.00	200.80	1	0	0	0	NULL	0	0	NULL	922	NULL	NULL	NULL
80	462	462	401020	0	Perf 401020	2018-06-08 00:00:00	NULL	NULL	NULL	P462	NULL	Perf 462	0.00	237.93	1	0	0	0	NULL	0	0	NULL	924	NULL	NULL	NULL
80	462	462	445710	0	Perf 445710	2018-06-08 00:00:00	NULL	NULL	NULL	P462	NULL	Perf 462	237.93	0.00	1	0	0	0	NULL	0	0	NULL	923	NULL	NULL	NULL
80	467	467	213000	0	Perf 213000	2018-05-15 00:00:00	NULL	NULL	NULL	P467	NULL	Perf 467	422.58	0.00	1	0	0	0	NULL	0	0	NULL	933	NULL	NULL	NULL
80	467	467	512001	0	Perf 512001	2018-05-15 00:00:00	NULL	NULL	NULL	P467	NULL	Perf 467	0.00	422.58	1	0	0	0	NULL	0	0	NULL	934	NULL	NULL	NULL
80	468	468	401026	0	Perf 401026	2018-06-22 00:00:00	NULL	NULL	NULL	P468	NULL	Perf 468	0.00	459.71	1	0	0	0	NULL	0	0	NULL	936	NULL	NULL	NULL
80	468	468	445710	0	Perf 445710	2018-06-22 00:00:00	NULL	NULL	NULL	P468	NULL	Perf 468	459.71	0.00	1	0	0	0	NULL	0	0	NULL	935	NULL	NULL	NULL
80	47	47	213000	0	Perf 213000	2018-05-15 00:00:00	NULL	NULL	NULL	P47	NULL	Perf 47	722.98	0.00	1	0	0	0	NULL	0	0	NULL	93	NULL	NULL	NULL
80	47	47	512001	0	Perf 512001	2018-05-15 00:00:00	NULL	NULL	NULL	P47	NULL	Perf 47	0.00	722.98	1	0	0	0	NULL	0	0	NULL	94	NULL	NULL	NULL
80	473	473	218200	0	Perf 218200	2018-05-01 00:00:00	NULL	NULL	NULL	P473	NULL	Perf 473	644.36	0.00	1	0	0	0	NULL	0	0	NULL	945	NULL	NULL	NULL
80	473	473	512001	0	Perf 512001	2018-05-01 00:00:00	NULL	NULL	NULL	P473	NULL	Perf 473	0.00	644.36	1	0	0	0	NULL	0	0	NULL	946	NULL	NULL	NULL
80	474	474	401006	0	Perf 401006	2018-06-08 00:00:00	NULL	NULL	NULL	P474	NULL	Perf 474	0.00	681.49	1	0	0	0	NULL	0	0	NULL	948	NULL	NULL	NULL
80	474	474	445710	0	Perf 445710	2018-06-08 00:00:00	NULL	NULL	NULL	P474	NULL	Perf 474	681.49	0.00	1	0	0	0	NULL	0	0	NULL	947	NULL	NULL	NULL
80	479	479	218300	0	Perf 218300	2018-05-15 00:00:00	NULL	NULL	NULL	P479	NULL	Perf 479	866.14	0.00	1	0	0	0	NULL	0	0	NULL	957	NULL	NULL	NULL
80	479	479	512001	0	Perf 512001	2018-05-15 00:00:00	NULL	NULL	NULL	P479	NULL	Perf 479	0.00	866.14	1	0	0	0	NULL	0	0	NULL	958	NULL	NULL	NULL
80	48	48	401022	0	Perf 401022	2018-06-22 00:00:00	NULL	NULL	NULL	P48	NULL	Perf 48	0.00	759.11	1	0	0	0	NULL	0	0	NULL	96	NULL	NULL	NULL
80	48	48	445710	0	Perf 445710	2018-06-22 00:00:00	NULL	NULL	NULL	P48	NULL	Perf 48	759.11	0.00	1	0	0	0	NULL	0	0	NULL	95	NULL	NULL	NULL
80	480	480	401012	0	Perf 401012	2018-06-22 00:00:00	NULL	NULL	NULL	P480	NULL	Perf 480	0.00	903.27	1	0	0	0	NULL	0	0	NULL	960	NULL	NULL	NULL
80	480	480	445710	0	Perf 445710	2018-06-22 00:00:00	NULL	NULL	NULL	P480	NULL	Perf 480	903.27	0.00	1	0	0	0	NULL	0	0	NULL	959	NULL	NULL	NULL
80	485	485	218400	0	Perf 218400	2018-05-01 00:00:00	NULL	NULL	NULL	P485	NULL	Perf 485	98.92	0.00	1	0	0	0	NULL	0	0	NULL	969	NULL	NULL	NULL
80	485	485	512001	0	Perf 512001	2018-05-01 00:00:00	NULL	NULL	NULL	P485	NULL	Perf 485	0.00	98.92	1	0	0	0	NULL	0	0	NULL	970	NULL	NULL	NULL
80	486	486	401018	0	Perf 401018	2018-06-08 00:00:00	NULL	NULL	NULL	P486	NULL	Perf 486	0.00	135.05	1	0	0	0	NULL	0	0	NULL	972	NULL	NULL	NULL
80	486	486	445710	0	Perf 445710	2018-06-08 00:00:00	NULL	NULL	NULL	P486	NULL	Perf 486	135.05	0.00	1	0	0	0	NULL	0	0	NULL	971	NULL	NULL	NULL
80	491	0	211000	0	Perf 211000	2018-05-15 00:00:00	NULL	NULL	NULL	P491	NULL	Perf 491	320.70	0.00	0	0	0	0	NULL	0	0	NULL	981	NULL	NULL	NULL
80	491	0	512001	0	Perf 512001	2018-05-15 00:00:00	NULL	NULL	NULL	P491	NULL	Perf 491	0.00	320.70	0	0	0	0	NULL	0	0	NULL	982	NULL	NULL	NULL
80	492	492	401024	0	Perf 401024	2018-06-22 00:00:00	NULL	NULL	NULL	P492	NULL	Perf 492	0.00	357.83	1	0	0	0	NULL	0	0	NULL	984	NULL	NULL	NULL
80	492	492	445710	0	Perf 445710	2018-06-22 00:00:00	NULL	NULL	NULL	P492	NULL	Perf 492	357.83	0.00	1	0	0	0	NULL	0	0	NULL	983	NULL	NULL	NULL
80	497	497	213000	0	Perf 213000	2018-05-01 00:00:00	NULL	NULL	NULL	P497	NULL	Perf 497	542.48	0.00	1	0	0	0	NULL	0	0	NULL	993	NULL	NULL	NULL
80	497	497	512001	0	Perf 512001	2018-05-01 00:00:00	NULL	NULL	NULL	P497	NULL	Perf 497	0.00	542.48	1	0	0	0	NULL	0	0	NULL	994	NULL	NULL	NULL
80	498	498	401004	0	Perf 401004	2018-06-08 00:00:00	NULL	NULL	NULL	P498	NULL	Perf 498	0.00	579.61	1	0	0	0	NULL	0	0	NULL	996	NULL	NULL	NULL
80	498	498	445710	0	Perf 445710	2018-06-08 00:00:00	NULL	NULL	NULL	P498	NULL	Perf 498	579.61	0.00	1	0	0	0	NULL	0	0	NULL	995	NULL	NULL	NULL
80	5	5	218400	0	Perf 218400	2018-05-01 00:00:00	NULL	NULL	NULL	P5	NULL	Perf 5	158.52	0.00	1	0	0	0	NULL	0	0	NULL	9	NULL	NULL	NULL
80	5	5	512001	0	Perf 512001	2018-05-01 00:00:00	NULL	NULL	NULL	P5	NULL	Perf 5	0.00	158.52	1	0	0	0	NULL	0	0	NULL	10	NULL	NULL	NULL
80	53	53	218200	0	Perf 218200	2018-05-01 00:00:00	NULL	NULL	NULL	P53	NULL	Perf 53	944.76	0.00	1	0	0	0	NULL	0	0	NULL	105	NULL	NULL	NULL
80	53	53	512001	0	Perf 512001	2018-05-01 00:00:00	NULL	NULL	NULL	P53	NULL	Perf 53	0.00	944.76	1	0	0	0	NULL	0	0	NULL	106	NULL	NULL	NULL
80	54	54	401002	0	Perf 401002	2018-06-08 00:00:00	NULL	NULL	NULL	P54	NULL	Perf 54	0.00	981.89	1	0	0	0	NULL	0	0	NULL	108	NULL	NULL	NULL
80	54	54	445710	0	Perf 445710	2018-06-08 00:00:00	NULL	NULL	NULL	P54	NULL	Perf 54	981.89	0.00	1	0	0	0	NULL	0	0	NULL	107	NULL	NULL	NULL
80	59	59	218300	0	Perf 218300	2018-05-15 00:00:00	NULL	NULL	NULL	P59	NULL	Perf 59	176.54	0.00	1	0	0	0	NULL	0	0	NULL	117	NULL	NULL	NULL
80	59	59	512001	0	Perf 512001	2018-05-15 00:00:00	NULL	NULL	NULL	P59	NULL	Perf 59	0.00	176.54	1	0	0	0	NULL	0	0	NULL	118	NULL	NULL	NULL
80	6	0	401006	0	Perf 401006	2018-06-08 00:00:00	NULL	NULL	NULL	P6	NULL	Perf 6	0.00	195.65	0	0	0	0	NULL	0	0	NULL	12	NULL	NULL	NULL
80	6	0	445710	0	Perf 445710	2018-06-08 00:00:00	NULL	NULL	NULL	P6	NULL	Perf 6	195.65	0.00	0	0	0	0	NULL	0	0	NULL	11	NULL	NULL	NULL
80	60	60	401008	0	Perf 401008	2018-06-22 00:00:00	NULL	NULL	NULL	P60	NULL	Perf 60	0.00	213.67	1	0	0	0	NULL	0	0	NULL	120	NULL	NULL	NULL
80	60	60	445710	0	Perf 445710	2018-06-22 00:00:00	NULL	NULL	NULL	P60	NULL	Perf 60	213.67	0.00	1	0	0	0	NULL	0	0	NULL	119	NULL	NULL	NULL
80	65	65	218400	0	Perf 218400	2018-05-01 00:00:00	NULL	NULL	NULL	P65	NULL	Perf 65	398.32	0.00	1	0	0	0	NULL	0	0	NULL	129	NULL	NULL	NULL
80	65	65	512001	0	Perf 512001	2018-05-01 00:00:00	NULL	NULL	NULL	P65	NULL	Perf 65	0.00	398.32	1	0	0	0	NULL	0	0	NULL	130	NULL	NULL	NULL
80	66	66	401014	0	Perf 401014	2018-06-08 00:00:00	NULL	NULL	NULL	P66	NULL	Perf 66	0.00	435.45	1	0	0	0	NULL	0	0	NULL	132	NULL	NULL	NULL
80	66	66	445710	0	Perf 445710	2018-06-08 00:00:00	NULL	NULL	NULL	P66	NULL	Perf 66	435.45	0.00	1	0	0	0	NULL	0	0	NULL	131	NULL	NULL	NULL
80	71	71	211000	0	Perf 211000	2018-05-15 00:00:00	NULL	NULL	NULL	P71	NULL	Perf 71	620.10	0.00	1	0	0	0	NULL	0	0	NULL	141	NULL	NULL	NULL
80	71	71	512001	0	Perf 512001	2018-05-15 00:00:00	NULL	NULL	NULL	P71	NULL	Perf 71	0.00	620.10	1	0	0	0	NULL	0	0	NULL	142	NULL	NULL	NULL
80	72	72	401020	0	Perf 401020	2018-06-22 00:00:00	NULL	NULL	NULL	P72	NULL	Perf 72	0.00	657.23	1	0	0	0	NULL	0	0	NULL	144	NULL	NULL	NULL
80	72	72	445710	0	Perf 445710	2018-06-22 00:00:00	NULL	NULL	NULL	P72	NULL	Perf 72	657.23	0.00	1	0	0	0	NULL	0	0	NULL	143	NULL	NULL	NULL
80	77	77	213000	0	Perf 213000	2018-05-01 00:00:00	NULL	NULL	NULL	P77	NULL	Perf 77	842.88	0.00	1	0	0	0	NULL	0	0	NULL	153	NULL	NULL	NULL
80	77	77	512001	0	Perf 512001	2018-05-01 00:00:00	NULL	NULL	NULL	P77	NULL	Perf 77	0.00	842.88	1	0	0	0	NULL	0	0	NULL	154	NULL	NULL	NULL
80	78	78	401026	0	Perf 401026	2018-06-08 00:00:00	NULL	NULL	NULL	P78	NULL	Perf 78	0.00	879.01	1	0	0	0	NULL	0	0	NULL	156	NULL	NULL	NULL
80	78	78	445710	0	Perf 445710	2018-06-08 00:00:00	NULL	NULL	NULL	P78	NULL	Perf 78	879.01	0.00	1	0	0	0	NULL	0	0	NULL	155	NULL	NULL	NULL
80	83	83	218200	0	Perf 218200	2018-05-15 00:00:00	NULL	NULL	NULL	P83	NULL	Perf 83	74.66	0.00	1	0	0	0	NULL	0	0	NULL	165	NULL	NULL	NULL
80	83	83	512001	0	Perf 512001	2018-05-15 00:00:00	NULL	NULL	NULL	P83	NULL	Perf 83	0.00	74.66	1	0	0	0	NULL	0	0	NULL	166	NULL	NULL	NULL
80	84	84	401006	0	Perf 401006	2018-06-22 00:00:00	NULL	NULL	NULL	P84	NULL	Perf 84	0.00	111.79	1	0	0	0	NULL	0	0	NULL	168	NULL	NULL	NULL
80	84	84	445710	0	Perf 445710	2018-06-22 00:00:00	NULL	NULL	NULL	P84	NULL	Perf 84	111.79	0.00	1	0	0	0	NULL	0	0	NULL	167	NULL	NULL	NULL
80	89	89	218300	0	Perf 218300	2018-05-01 00:00:00	NULL	NULL	NULL	P89	NULL	Perf 89	296.44	0.00	1	0	0	0	NULL	0	0	NULL	177	NULL	NULL	NULL
80	89	89	512001	0	Perf 512001	2018-05-01 00:00:00	NULL	NULL	NULL	P89	NULL	Perf 89	0.00	296.44	1	0	0	0	NULL	0	0	NULL	178	NULL	NULL	NULL
80	90	90	401012	0	Perf 401012	2018-06-08 00:00:00	NULL	NULL	NULL	P90	NULL	Perf 90	0.00	333.57	1	0	0	0	NULL	0	0	NULL	180	NULL	NULL	NULL
80	90	90	445710	0	Perf 445710	2018-06-08 00:00:00	NULL	NULL	NULL	P90	NULL	Perf 90	333.57	0.00	1	0	0	0	NULL	0	0	NULL	179	NULL	NULL	NULL
80	95	95	218400	0	Perf 218400	2018-05-15 00:00:00	NULL	NULL	NULL	P95	NULL	Perf 95	518.22	0.00	1	0	0	0	NULL	0	0	NULL	189	NULL	NULL	NULL
80	95	95	512001	0	Perf 512001	2018-05-15 00:00:00	NULL	NULL	NULL	P95	NULL	Perf 95	0.00	518.22	1	0	0	0	NULL	0	0	NULL	190	NULL	NULL	NULL
80	96	96	401018	0	Perf 401018	2018-06-22 00:00:00	NULL	NULL	NULL	P96	NULL	Perf 96	0.00	555.35	1	0	0	0	NULL	0	0	NULL	192	NULL	NULL	NULL
80	96	96	445710	0	Perf 445710	2018-06-22 00:00:00	NULL	NULL	NULL	P96	NULL	Perf 96	555.35	0.00	1	0	0	0	NULL	0	0	NULL	191	NULL	NULL	NULL
## Fiches_Mvt1 (jour	numero	compte	collectif	intitule	dte	datee	numdoc	numlot	libelle	montantd	montantc	validee	provisoire	tresorerie	pointee	nrlv	lettree	cloturee	relance	control	numerodef	dateech	numcol	dteval	export	lind)
51	1003	411003	0	Perf 411003	2017-03-15 00:00:00	NULL	P1003	NULL	Perf 1003	0.00	84.26	1	0	0	0	NULL	0	1	NULL	NULL	1003	NULL	NULL	NULL	NULL	6
51	1003	530000	0	Perf 530000	2017-03-15 00:00:00	NULL	P1003	NULL	Perf 1003	84.26	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1003	NULL	NULL	NULL	NULL	5
51	1004	401004	0	Perf 401004	2017-04-22 00:00:00	NULL	P1004	NULL	Perf 1004	121.39	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1004	NULL	NULL	NULL	NULL	7
51	1004	512000	0	Perf 512000	2017-04-22 00:00:00	NULL	P1004	NULL	Perf 1004	0.00	121.39	1	0	0	0	NULL	0	1	NULL	NULL	1004	NULL	NULL	NULL	NULL	8
51	1009	411009	0	Perf 411009	2017-09-01 00:00:00	NULL	P1009	NULL	Perf 1009	0.00	306.04	1	0	0	0	NULL	0	1	NULL	NULL	1009	NULL	NULL	NULL	NULL	18
51	1009	530000	0	Perf 530000	2017-09-01 00:00:00	NULL	P1009	NULL	Perf 1009	306.04	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1009	NULL	NULL	NULL	NULL	17
51	1010	401010	0	Perf 401010	2017-10-08 00:00:00	NULL	P1010	NULL	Perf 1010	343.17	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1010	NULL	NULL	NULL	NULL	19
51	1010	512000	0	Perf 512000	2017-10-08 00:00:00	NULL	P1010	NULL	Perf 1010	0.00	343.17	1	0	0	0	NULL	0	1	NULL	NULL	1010	NULL	NULL	NULL	NULL	20
51	1015	411015	0	Perf 411015	2017-03-15 00:00:00	NULL	P1015	NULL	Perf 1015	0.00	528.82	1	0	0	0	NULL	0	1	NULL	NULL	1015	NULL	NULL	NULL	NULL	30
51	1015	530000	0	Perf 530000	2017-03-15 00:00:00	NULL	P1015	NULL	Perf 1015	528.82	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1015	NULL	NULL	NULL	NULL	29
51	1016	401016	0	Perf 401016	2017-04-22 00:00:00	NULL	P1016	NULL	Perf 1016	565.95	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1016	NULL	NULL	NULL	NULL	31
51	1016	512000	0	Perf 512000	2017-04-22 00:00:00	NULL	P1016	NULL	Perf 1016	0.00	565.95	1	0	0	0	NULL	0	1	NULL	NULL	1016	NULL	NULL	NULL	NULL	32
51	1021	411021	0	Perf 411021	2017-09-01 00:00:00	NULL	P1021	NULL	Perf 1021	0.00	750.60	1	0	0	0	NULL	0	1	NULL	NULL	1021	NULL	NULL	NULL	NULL	42
51	1021	530000	0	Perf 530000	2017-09-01 00:00:00	NULL	P1021	NULL	Perf 1021	750.60	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1021	NULL	NULL	NULL	NULL	41
51	1022	401022	0	Perf 401022	2017-10-08 00:00:00	NULL	P1022	NULL	Perf 1022	787.73	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1022	NULL	NULL	NULL	NULL	43
51	1022	512000	0	Perf 512000	2017-10-08 00:00:00	NULL	P1022	NULL	Perf 1022	0.00	787.73	1	0	0	0	NULL	0	1	NULL	NULL	1022	NULL	NULL	NULL	NULL	44
51	1027	411027	0	Perf 411027	2017-03-15 00:00:00	NULL	P1027	NULL	Perf 1027	0.00	972.38	1	0	0	0	NULL	0	1	NULL	NULL	1027	NULL	NULL	NULL	NULL	54
51	1027	530000	0	Perf 530000	2017-03-15 00:00:00	NULL	P1027	NULL	Perf 1027	972.38	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1027	NULL	NULL	NULL	NULL	53
51	1028	401002	0	Perf 401002	2017-04-22 00:00:00	NULL	P1028	NULL	Perf 1028	19.51	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1028	NULL	NULL	NULL	NULL	55
51	1028	512000	0	Perf 512000	2017-04-22 00:00:00	NULL	P1028	NULL	Perf 1028	0.00	19.51	1	0	0	0	NULL	0	1	NULL	NULL	1028	NULL	NULL	NULL	NULL	56
51	1033	411006	0	Perf 411006	2017-09-01 00:00:00	NULL	P1033	NULL	Perf 1033	0.00	204.16	1	0	0	0	NULL	0	1	NULL	NULL	1033	NULL	NULL	NULL	NULL	66
51	1033	530000	0	Perf 530000	2017-09-01 00:00:00	NULL	P1033	NULL	Perf 1033	204.16	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1033	NULL	NULL	NULL	NULL	65
51	1034	401008	0	Perf 401008	2017-10-08 00:00:00	NULL	P1034	NULL	Perf 1034	241.29	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1034	NULL	NULL	NULL	NULL	67
51	1034	512000	0	Perf 512000	2017-10-08 00:00:00	NULL	P1034	NULL	Perf 1034	0.00	241.29	1	0	0	0	NULL	0	1	NULL	NULL	1034	NULL	NULL	NULL	NULL	68
51	1039	411012	0	Perf 411012	2017-03-15 00:00:00	NULL	P1039	NULL	Perf 1039	0.00	426.94	1	0	0	0	NULL	0	1	NULL	NULL	1039	NULL	NULL	NULL	NULL	78
51	1039	530000	0	Perf 530000	2017-03-15 00:00:00	NULL	P1039	NULL	Perf 1039	426.94	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1039	NULL	NULL	NULL	NULL	77
51	1040	401014	0	Perf 401014	2017-04-22 00:00:00	NULL	P1040	NULL	Perf 1040	463.07	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1040	NULL	NULL	NULL	NULL	79
51	1040	512000	0	Perf 512000	2017-04-22 00:00:00	NULL	P1040	NULL	Perf 1040	0.00	463.07	1	0	0	0	NULL	0	1	NULL	NULL	1040	NULL	NULL	NULL	NULL	80
51	1045	411018	0	Perf 411018	2017-09-01 00:00:00	NULL	P1045	NULL	Perf 1045	0.00	648.72	1	0	0	0	NULL	0	1	NULL	NULL	1045	NULL	NULL	NULL	NULL	90
51	1045	530000	0	Perf 530000	2017-09-01 00:00:00	NULL	P1045	NULL	Perf 1045	648.72	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1045	NULL	NULL	NULL	NULL	89
51	1046	401020	0	Perf 401020	2017-10-08 00:00:00	NULL	P1046	NULL	Perf 1046	685.85	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1046	NULL	NULL	NULL	NULL	91
51	1046	512000	0	Perf 512000	2017-10-08 00:00:00	NULL	P1046	NULL	Perf 1046	0.00	685.85	1	0	0	0	NULL	0	1	NULL	NULL	1046	NULL	NULL	NULL	NULL	92
51	1051	411024	0	Perf 411024	2017-03-15 00:00:00	NULL	P1051	NULL	Perf 1051	0.00	870.50	1	0	0	0	NULL	0	1	NULL	NULL	1051	NULL	NULL	NULL	NULL	102
51	1051	530000	0	Perf 530000	2017-03-15 00:00:00	NULL	P1051	NULL	Perf 1051	870.50	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1051	NULL	NULL	NULL	NULL	101
51	1052	401026	0	Perf 401026	2017-04-22 00:00:00	NULL	P1052	NULL	Perf 1052	907.63	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1052	NULL	NULL	NULL	NULL	103
51	1052	512000	0	Perf 512000	2017-04-22 00:00:00	NULL	P1052	NULL	Perf 1052	0.00	907.63	1	0	0	0	NULL	0	1	NULL	NULL	1052	NULL	NULL	NULL	NULL	104
51	1057	411003	0	Perf 411003	2017-09-01 00:00:00	NULL	P1057	NULL	Perf 1057	0.00	102.28	1	0	0	0	NULL	0	1	NULL	NULL	1057	NULL	NULL	NULL	NULL	114
51	1057	530000	0	Perf 530000	2017-09-01 00:00:00	NULL	P1057	NULL	Perf 1057	102.28	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1057	NULL	NULL	NULL	NULL	113
51	1058	401006	0	Perf 401006	2017-10-08 00:00:00	NULL	P1058	NULL	Perf 1058	139.41	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1058	NULL	NULL	NULL	NULL	115
51	1058	512000	0	Perf 512000	2017-10-08 00:00:00	NULL	P1058	NULL	Perf 1058	0.00	139.41	1	0	0	0	NULL	0	1	NULL	NULL	1058	NULL	NULL	NULL	NULL	116
51	1063	411009	0	Perf 411009	2017-03-15 00:00:00	NULL	P1063	NULL	Perf 1063	0.00	324.06	1	0	0	0	NULL	0	1	NULL	NULL	1063	NULL	NULL	NULL	NULL	126
51	1063	530000	0	Perf 530000	2017-03-15 00:00:00	NULL	P1063	NULL	Perf 1063	324.06	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1063	NULL	NULL	NULL	NULL	125
51	1064	401012	0	Perf 401012	2017-04-22 00:00:00	NULL	P1064	NULL	Perf 1064	361.19	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1064	NULL	NULL	NULL	NULL	127
51	1064	512000	0	Perf 512000	2017-04-22 00:00:00	NULL	P1064	NULL	Perf 1064	0.00	361.19	1	0	0	0	NULL	0	1	NULL	NULL	1064	NULL	NULL	NULL	NULL	128
51	1069	411015	0	Perf 411015	2017-09-01 00:00:00	NULL	P1069	NULL	Perf 1069	0.00	546.84	1	0	0	0	NULL	0	1	NULL	NULL	1069	NULL	NULL	NULL	NULL	138
51	1069	530000	0	Perf 530000	2017-09-01 00:00:00	NULL	P1069	NULL	Perf 1069	546.84	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1069	NULL	NULL	NULL	NULL	137
51	1070	401018	0	Perf 401018	2017-10-08 00:00:00	NULL	P1070	NULL	Perf 1070	583.97	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1070	NULL	NULL	NULL	NULL	139
51	1070	512000	0	Perf 512000	2017-10-08 00:00:00	NULL	P1070	NULL	Perf 1070	0.00	583.97	1	0	0	0	NULL	0	1	NULL	NULL	1070	NULL	NULL	NULL	NULL	140
51	1075	411021	0	Perf 411021	2017-03-15 00:00:00	NULL	P1075	NULL	Perf 1075	0.00	768.62	1	0	0	0	NULL	0	1	NULL	NULL	1075	NULL	NULL	NULL	NULL	150
51	1075	530000	0	Perf 530000	2017-03-15 00:00:00	NULL	P1075	NULL	Perf 1075	768.62	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1075	NULL	NULL	NULL	NULL	149
51	1076	401024	0	Perf 401024	2017-04-22 00:00:00	NULL	P1076	NULL	Perf 1076	805.75	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1076	NULL	NULL	NULL	NULL	151
51	1076	512000	0	Perf 512000	2017-04-22 00:00:00	NULL	P1076	NULL	Perf 1076	0.00	805.75	1	0	0	0	NULL	0	1	NULL	NULL	1076	NULL	NULL	NULL	NULL	152
51	1081	411027	0	Perf 411027	2017-09-01 00:00:00	NULL	P1081	NULL	Perf 1081	0.00	990.40	1	0	0	0	NULL	0	1	NULL	NULL	1081	NULL	NULL	NULL	NULL	162
51	1081	530000	0	Perf 530000	2017-09-01 00:00:00	NULL	P1081	NULL	Perf 1081	990.40	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1081	NULL	NULL	NULL	NULL	161
51	1082	401004	0	Perf 401004	2017-10-08 00:00:00	NULL	P1082	NULL	Perf 1082	37.53	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1082	NULL	NULL	NULL	NULL	163
51	1082	512000	0	Perf 512000	2017-10-08 00:00:00	NULL	P1082	NULL	Perf 1082	0.00	37.53	1	0	0	0	NULL	0	1	NULL	NULL	1082	NULL	NULL	NULL	NULL	164
51	1087	411006	0	Perf 411006	2017-03-15 00:00:00	NULL	P1087	NULL	Perf 1087	0.00	222.18	1	0	0	0	NULL	0	1	NULL	NULL	1087	NULL	NULL	NULL	NULL	174
51	1087	530000	0	Perf 530000	2017-03-15 00:00:00	NULL	P1087	NULL	Perf 1087	222.18	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1087	NULL	NULL	NULL	NULL	173
51	1088	401010	0	Perf 401010	2017-04-22 00:00:00	NULL	P1088	NULL	Perf 1088	259.31	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1088	NULL	NULL	NULL	NULL	175
51	1088	512000	0	Perf 512000	2017-04-22 00:00:00	NULL	P1088	NULL	Perf 1088	0.00	259.31	1	0	0	0	NULL	0	1	NULL	NULL	1088	NULL	NULL	NULL	NULL	176
51	1093	411012	0	Perf 411012	2017-09-01 00:00:00	NULL	P1093	NULL	Perf 1093	0.00	444.96	1	0	0	0	NULL	0	1	NULL	NULL	1093	NULL	NULL	NULL	NULL	186
51	1093	530000	0	Perf 530000	2017-09-01 00:00:00	NULL	P1093	NULL	Perf 1093	444.96	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1093	NULL	NULL	NULL	NULL	185
51	1094	401016	0	Perf 401016	2017-10-08 00:00:00	NULL	P1094	NULL	Perf 1094	481.09	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1094	NULL	NULL	NULL	NULL	187
51	1094	512000	0	Perf 512000	2017-10-08 00:00:00	NULL	P1094	NULL	Perf 1094	0.00	481.09	1	0	0	0	NULL	0	1	NULL	NULL	1094	NULL	NULL	NULL	NULL	188
51	1099	411018	0	Perf 411018	2017-03-15 00:00:00	NULL	P1099	NULL	Perf 1099	0.00	666.74	1	0	0	0	NULL	0	1	NULL	NULL	1099	NULL	NULL	NULL	NULL	198
51	1099	530000	0	Perf 530000	2017-03-15 00:00:00	NULL	P1099	NULL	Perf 1099	666.74	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1099	NULL	NULL	NULL	NULL	197
51	1100	401022	0	Perf 401022	2017-04-22 00:00:00	NULL	P1100	NULL	Perf 1100	703.87	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1100	NULL	NULL	NULL	NULL	199
51	1100	512000	0	Perf 512000	2017-04-22 00:00:00	NULL	P1100	NULL	Perf 1100	0.00	703.87	1	0	0	0	NULL	0	1	NULL	NULL	1100	NULL	NULL	NULL	NULL	200
60	1002	401002	0	Perf 401002	2017-02-08 00:00:00	NULL	P1002	NULL	Perf 1002	0.00	47.13	1	0	0	0	NULL	0	1	NULL	NULL	1002	NULL	NULL	NULL	NULL	4
60	1002	606100	0	Perf 606100	2017-02-08 00:00:00	NULL	P1002	NULL	Perf 1002	47.13	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1002	NULL	NULL	NULL	NULL	3
60	1008	401008	0	Perf 401008	2017-08-22 00:00:00	NULL	P1008	NULL	Perf 1008	0.00	269.91	1	0	0	0	NULL	0	1	NULL	NULL	1008	NULL	NULL	NULL	NULL	16
60	1008	606100	0	Perf 606100	2017-08-22 00:00:00	NULL	P1008	NULL	Perf 1008	269.91	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1008	NULL	NULL	NULL	NULL	15
60	1014	401014	0	Perf 401014	2017-02-08 00:00:00	NULL	P1014	NULL	Perf 1014	0.00	491.69	1	0	0	0	NULL	0	1	NULL	NULL	1014	NULL	NULL	NULL	NULL	28
60	1014	606100	0	Perf 606100	2017-02-08 00:00:00	NULL	P1014	NULL	Perf 1014	491.69	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1014	NULL	NULL	NULL	NULL	27
60	1020	401020	0	Perf 401020	2017-08-22 00:00:00	NULL	P1020	NULL	Perf 1020	0.00	713.47	1	0	0	0	NULL	0	1	NULL	NULL	1020	NULL	NULL	NULL	NULL	40
60	1020	606100	0	Perf 606100	2017-08-22 00:00:00	NULL	P1020	NULL	Perf 1020	713.47	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1020	NULL	NULL	NULL	NULL	39
60	1026	401026	0	Perf 401026	2017-02-08 00:00:00	NULL	P1026	NULL	Perf 1026	0.00	935.25	1	0	0	0	NULL	0	1	NULL	NULL	1026	NULL	NULL	NULL	NULL	52
60	1026	606100	0	Perf 606100	2017-02-08 00:00:00	NULL	P1026	NULL	Perf 1026	935.25	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1026	NULL	NULL	NULL	NULL	51
60	1032	401006	0	Perf 401006	2017-08-22 00:00:00	NULL	P1032	NULL	Perf 1032	0.00	167.03	1	0	0	0	NULL	0	1	NULL	NULL	1032	NULL	NULL	NULL	NULL	64
60	1032	606100	0	Perf 606100	2017-08-22 00:00:00	NULL	P1032	NULL	Perf 1032	167.03	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1032	NULL	NULL	NULL	NULL	63
60	1038	401012	0	Perf 401012	2017-02-08 00:00:00	NULL	P1038	NULL	Perf 1038	0.00	389.81	1	0	0	0	NULL	0	1	NULL	NULL	1038	NULL	NULL	NULL	NULL	76
60	1038	606100	0	Perf 606100	2017-02-08 00:00:00	NULL	P1038	NULL	Perf 1038	389.81	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1038	NULL	NULL	NULL	NULL	75
60	1044	401018	0	Perf 401018	2017-08-22 00:00:00	NULL	P1044	NULL	Perf 1044	0.00	611.59	1	0	0	0	NULL	0	1	NULL	NULL	1044	NULL	NULL	NULL	NULL	88
60	1044	606100	0	Perf 606100	2017-08-22 00:00:00	NULL	P1044	NULL	Perf 1044	611.59	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1044	NULL	NULL	NULL	NULL	87
60	1050	401024	0	Perf 401024	2017-02-08 00:00:00	NULL	P1050	NULL	Perf 1050	0.00	833.37	1	0	0	0	NULL	0	1	NULL	NULL	1050	NULL	NULL	NULL	NULL	100
60	1050	606100	0	Perf 606100	2017-02-08 00:00:00	NULL	P1050	NULL	Perf 1050	833.37	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1050	NULL	NULL	NULL	NULL	99
60	1056	401004	0	Perf 401004	2017-08-22 00:00:00	NULL	P1056	NULL	Perf 1056	0.00	65.15	1	0	0	0	NULL	0	1	NULL	NULL	1056	NULL	NULL	NULL	NULL	112
60	1056	606100	0	Perf 606100	2017-08-22 00:00:00	NULL	P1056	NULL	Perf 1056	65.15	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1056	NULL	NULL	NULL	NULL	111
60	1062	401010	0	Perf 401010	2017-02-08 00:00:00	NULL	P1062	NULL	Perf 1062	0.00	287.93	1	0	0	0	NULL	0	1	NULL	NULL	1062	NULL	NULL	NULL	NULL	124
60	1062	606100	0	Perf 606100	2017-02-08 00:00:00	NULL	P1062	NULL	Perf 1062	287.93	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1062	NULL	NULL	NULL	NULL	123
60	1068	401016	0	Perf 401016	2017-08-22 00:00:00	NULL	P1068	NULL	Perf 1068	0.00	509.71	1	0	0	0	NULL	0	1	NULL	NULL	1068	NULL	NULL	NULL	NULL	136
60	1068	606100	0	Perf 606100	2017-08-22 00:00:00	NULL	P1068	NULL	Perf 1068	509.71	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1068	NULL	NULL	NULL	NULL	135
60	1074	401022	0	Perf 401022	2017-02-08 00:00:00	NULL	P1074	NULL	Perf 1074	0.00	731.49	1	0	0	0	NULL	0	1	NULL	NULL	1074	NULL	NULL	NULL	NULL	148
60	1074	606100	0	Perf 606100	2017-02-08 00:00:00	NULL	P1074	NULL	Perf 1074	731.49	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1074	NULL	NULL	NULL	NULL	147
60	1080	401002	0	Perf 401002	2017-08-22 00:00:00	NULL	P1080	NULL	Perf 1080	0.00	953.27	1	0	0	0	NULL	0	1	NULL	NULL	1080	NULL	NULL	NULL	NULL	160
60	1080	606100	0	Perf 606100	2017-08-22 00:00:00	NULL	P1080	NULL	Perf 1080	953.27	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1080	NULL	NULL	NULL	NULL	159
60	1086	401008	0	Perf 401008	2017-02-08 00:00:00	NULL	P1086	NULL	Perf 1086	0.00	185.05	1	0	0	0	NULL	0	1	NULL	NULL	1086	NULL	NULL	NULL	NULL	172
60	1086	606100	0	Perf 606100	2017-02-08 00:00:00	NULL	P1086	NULL	Perf 1086	185.05	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1086	NULL	NULL	NULL	NULL	171
60	1092	401014	0	Perf 401014	2017-08-22 00:00:00	NULL	P1092	NULL	Perf 1092	0.00	407.83	1	0	0	0	NULL	0	1	NULL	NULL	1092	NULL	NULL	NULL	NULL	184
60	1092	606100	0	Perf 606100	2017-08-22 00:00:00	NULL	P1092	NULL	Perf 1092	407.83	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1092	NULL	NULL	NULL	NULL	183
60	1098	401020	0	Perf 401020	2017-02-08 00:00:00	NULL	P1098	NULL	Perf 1098	0.00	629.61	1	0	0	0	NULL	0	1	NULL	NULL	1098	NULL	NULL	NULL	NULL	196
60	1098	606100	0	Perf 606100	2017-02-08 00:00:00	NULL	P1098	NULL	Perf 1098	629.61	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1098	NULL	NULL	NULL	NULL	195
70	1001	411001	0	Perf 411001	2017-01-01 00:00:00	NULL	P1001	NULL	Perf 1001	10.00	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1001	NULL	NULL	NULL	NULL	1
70	1001	707000	0	Perf 707000	2017-01-01 00:00:00	NULL	P1001	NULL	Perf 1001	0.00	10.00	1	0	0	0	NULL	0	1	NULL	NULL	1001	NULL	NULL	NULL	NULL	2
70	1007	411007	0	Perf 411007	2017-07-15 00:00:00	NULL	P1007	NULL	Perf 1007	232.78	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1007	NULL	NULL	NULL	NULL	13
70	1007	707000	0	Perf 707000	2017-07-15 00:00:00	NULL	P1007	NULL	Perf 1007	0.00	232.78	1	0	0	0	NULL	0	1	NULL	NULL	1007	NULL	NULL	NULL	NULL	14
70	1013	411013	0	Perf 411013	2017-01-01 00:00:00	NULL	P1013	NULL	Perf 1013	454.56	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1013	NULL	NULL	NULL	NULL	25
70	1013	707000	0	Perf 707000	2017-01-01 00:00:00	NULL	P1013	NULL	Perf 1013	0.00	454.56	1	0	0	0	NULL	0	1	NULL	NULL	1013	NULL	NULL	NULL	NULL	26
70	1019	411019	0	Perf 411019	2017-07-15 00:00:00	NULL	P1019	NULL	Perf 1019	676.34	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1019	NULL	NULL	NULL	NULL	37
70	1019	707000	0	Perf 707000	2017-07-15 00:00:00	NULL	P1019	NULL	Perf 1019	0.00	676.34	1	0	0	0	NULL	0	1	NULL	NULL	1019	NULL	NULL	NULL	NULL	38
70	1025	411025	0	Perf 411025	2017-01-01 00:00:00	NULL	P1025	NULL	Perf 1025	898.12	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1025	NULL	NULL	NULL	NULL	49
70	1025	707000	0	Perf 707000	2017-01-01 00:00:00	NULL	P1025	NULL	Perf 1025	0.00	898.12	1	0	0	0	NULL	0	1	NULL	NULL	1025	NULL	NULL	NULL	NULL	50
70	1031	411004	0	Perf 411004	2017-07-15 00:00:00	NULL	P1031	NULL	Perf 1031	130.90	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1031	NULL	NULL	NULL	NULL	61
70	1031	707000	0	Perf 707000	2017-07-15 00:00:00	NULL	P1031	NULL	Perf 1031	0.00	130.90	1	0	0	0	NULL	0	1	NULL	NULL	1031	NULL	NULL	NULL	NULL	62
70	1037	411010	0	Perf 411010	2017-01-01 00:00:00	NULL	P1037	NULL	Perf 1037	352.68	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1037	NULL	NULL	NULL	NULL	73
70	1037	707000	0	Perf 707000	2017-01-01 00:00:00	NULL	P1037	NULL	Perf 1037	0.00	352.68	1	0	0	0	NULL	0	1	NULL	NULL	1037	NULL	NULL	NULL	NULL	74
70	1043	411016	0	Perf 411016	2017-07-15 00:00:00	NULL	P1043	NULL	Perf 1043	574.46	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1043	NULL	NULL	NULL	NULL	85
70	1043	707000	0	Perf 707000	2017-07-15 00:00:00	NULL	P1043	NULL	Perf 1043	0.00	574.46	1	0	0	0	NULL	0	1	NULL	NULL	1043	NULL	NULL	NULL	NULL	86
70	1049	411022	0	Perf 411022	2017-01-01 00:00:00	NULL	P1049	NULL	Perf 1049	796.24	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1049	NULL	NULL	NULL	NULL	97
70	1049	707000	0	Perf 707000	2017-01-01 00:00:00	NULL	P1049	NULL	Perf 1049	0.00	796.24	1	0	0	0	NULL	0	1	NULL	NULL	1049	NULL	NULL	NULL	NULL	98
70	1055	411001	0	Perf 411001	2017-07-15 00:00:00	NULL	P1055	NULL	Perf 1055	28.02	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1055	NULL	NULL	NULL	NULL	109
70	1055	707000	0	Perf 707000	2017-07-15 00:00:00	NULL	P1055	NULL	Perf 1055	0.00	28.02	1	0	0	0	NULL	0	1	NULL	NULL	1055	NULL	NULL	NULL	NULL	110
70	1061	411007	0	Perf 411007	2017-01-01 00:00:00	NULL	P1061	NULL	Perf 1061	250.80	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1061	NULL	NULL	NULL	NULL	121
70	1061	707000	0	Perf 707000	2017-01-01 00:00:00	NULL	P1061	NULL	Perf 1061	0.00	250.80	1	0	0	0	NULL	0	1	NULL	NULL	1061	NULL	NULL	NULL	NULL	122
70	1067	411013	0	Perf 411013	2017-07-15 00:00:00	NULL	P1067	NULL	Perf 1067	472.58	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1067	NULL	NULL	NULL	NULL	133
70	1067	707000	0	Perf 707000	2017-07-15 00:00:00	NULL	P1067	NULL	Perf 1067	0.00	472.58	1	0	0	0	NULL	0	1	NULL	NULL	1067	NULL	NULL	NULL	NULL	134
70	1073	411019	0	Perf 411019	2017-01-01 00:00:00	NULL	P1073	NULL	Perf 1073	694.36	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1073	NULL	NULL	NULL	NULL	145
70	1073	707000	0	Perf 707000	2017-01-01 00:00:00	NULL	P1073	NULL	Perf 1073	0.00	694.36	1	0	0	0	NULL	0	1	NULL	NULL	1073	NULL	NULL	NULL	NULL	146
70	1079	411025	0	Perf 411025	2017-07-15 00:00:00	NULL	P1079	NULL	Perf 1079	916.14	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1079	NULL	NULL	NULL	NULL	157
70	1079	707000	0	Perf 707000	2017-07-15 00:00:00	NULL	P1079	NULL	Perf 1079	0.00	916.14	1	0	0	0	NULL	0	1	NULL	NULL	1079	NULL	NULL	NULL	NULL	158
70	1085	411004	0	Perf 411004	2017-01-01 00:00:00	NULL	P1085	NULL	Perf 1085	148.92	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1085	NULL	NULL	NULL	NULL	169
70	1085	707000	0	Perf 707000	2017-01-01 00:00:00	NULL	P1085	NULL	Perf 1085	0.00	148.92	1	0	0	0	NULL	0	1	NULL	NULL	1085	NULL	NULL	NULL	NULL	170
70	1091	411010	0	Perf 411010	2017-07-15 00:00:00	NULL	P1091	NULL	Perf 1091	370.70	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1091	NULL	NULL	NULL	NULL	181
70	1091	707000	0	Perf 707000	2017-07-15 00:00:00	NULL	P1091	NULL	Perf 1091	0.00	370.70	1	0	0	0	NULL	0	1	NULL	NULL	1091	NULL	NULL	NULL	NULL	182
70	1097	411016	0	Perf 411016	2017-01-01 00:00:00	NULL	P1097	NULL	Perf 1097	592.48	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1097	NULL	NULL	NULL	NULL	193
70	1097	707000	0	Perf 707000	2017-01-01 00:00:00	NULL	P1097	NULL	Perf 1097	0.00	592.48	1	0	0	0	NULL	0	1	NULL	NULL	1097	NULL	NULL	NULL	NULL	194
80	1005	218400	0	Perf 218400	2017-05-01 00:00:00	NULL	P1005	NULL	Perf 1005	158.52	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1005	NULL	NULL	NULL	NULL	9
80	1005	512001	0	Perf 512001	2017-05-01 00:00:00	NULL	P1005	NULL	Perf 1005	0.00	158.52	1	0	0	0	NULL	0	1	NULL	NULL	1005	NULL	NULL	NULL	NULL	10
80	1006	401006	0	Perf 401006	2017-06-08 00:00:00	NULL	P1006	NULL	Perf 1006	0.00	195.65	0	0	0	0	NULL	0	1	NULL	NULL	0	NULL	NULL	NULL	NULL	12
80	1006	445710	0	Perf 445710	2017-06-08 00:00:00	NULL	P1006	NULL	Perf 1006	195.65	0.00	0	0	0	0	NULL	0	1	NULL	NULL	0	NULL	NULL	NULL	NULL	11
80	1011	211000	0	Perf 211000	2017-11-15 00:00:00	NULL	P1011	NULL	Perf 1011	380.30	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1011	NULL	NULL	NULL	NULL	21
80	1011	512001	0	Perf 512001	2017-11-15 00:00:00	NULL	P1011	NULL	Perf 1011	0.00	380.30	1	0	0	0	NULL	0	1	NULL	NULL	1011	NULL	NULL	NULL	NULL	22
80	1012	401012	0	Perf 401012	2017-12-22 00:00:00	NULL	P1012	NULL	Perf 1012	0.00	417.43	1	0	0	0	NULL	0	1	NULL	NULL	1012	NULL	NULL	NULL	NULL	24
80	1012	445710	0	Perf 445710	2017-12-22 00:00:00	NULL	P1012	NULL	Perf 1012	417.43	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1012	NULL	NULL	NULL	NULL	23
80	1017	213000	0	Perf 213000	2017-05-01 00:00:00	NULL	P1017	NULL	Perf 1017	602.08	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1017	NULL	NULL	NULL	NULL	33
80	1017	512001	0	Perf 512001	2017-05-01 00:00:00	NULL	P1017	NULL	Perf 1017	0.00	602.08	1	0	0	0	NULL	0	1	NULL	NULL	1017	NULL	NULL	NULL	NULL	34
80	1018	401018	0	Perf 401018	2017-06-08 00:00:00	NULL	P1018	NULL	Perf 1018	0.00	639.21	1	0	0	0	NULL	0	1	NULL	NULL	1018	NULL	NULL	NULL	NULL	36
80	1018	445710	0	Perf 445710	2017-06-08 00:00:00	NULL	P1018	NULL	Perf 1018	639.21	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1018	NULL	NULL	NULL	NULL	35
80	1023	218200	0	Perf 218200	2017-11-15 00:00:00	NULL	P1023	NULL	Perf 1023	824.86	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1023	NULL	NULL	NULL	NULL	45
80	1023	512001	0	Perf 512001	2017-11-15 00:00:00	NULL	P1023	NULL	Perf 1023	0.00	824.86	1	0	0	0	NULL	0	1	NULL	NULL	1023	NULL	NULL	NULL	NULL	46
80	1024	401024	0	Perf 401024	2017-12-22 00:00:00	NULL	P1024	NULL	Perf 1024	0.00	861.99	1	0	0	0	NULL	0	1	NULL	NULL	1024	NULL	NULL	NULL	NULL	48
80	1024	445710	0	Perf 445710	2017-12-22 00:00:00	NULL	P1024	NULL	Perf 1024	861.99	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1024	NULL	NULL	NULL	NULL	47
80	1029	218300	0	Perf 218300	2017-05-01 00:00:00	NULL	P1029	NULL	Perf 1029	56.64	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1029	NULL	NULL	NULL	NULL	57
80	1029	512001	0	Perf 512001	2017-05-01 00:00:00	NULL	P1029	NULL	Perf 1029	0.00	56.64	1	0	0	0	NULL	0	1	NULL	NULL	1029	NULL	NULL	NULL	NULL	58
80	1030	401004	0	Perf 401004	2017-06-08 00:00:00	NULL	P1030	NULL	Perf 1030	0.00	93.77	1	0	0	0	NULL	0	1	NULL	NULL	1030	NULL	NULL	NULL	NULL	60
80	1030	445710	0	Perf 445710	2017-06-08 00:00:00	NULL	P1030	NULL	Perf 1030	93.77	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1030	NULL	NULL	NULL	NULL	59
80	1035	218400	0	Perf 218400	2017-11-15 00:00:00	NULL	P1035	NULL	Perf 1035	278.42	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1035	NULL	NULL	NULL	NULL	69
80	1035	512001	0	Perf 512001	2017-11-15 00:00:00	NULL	P1035	NULL	Perf 1035	0.00	278.42	1	0	0	0	NULL	0	1	NULL	NULL	1035	NULL	NULL	NULL	NULL	70
80	1036	401010	0	Perf 401010	2017-12-22 00:00:00	NULL	P1036	NULL	Perf 1036	0.00	315.55	1	0	0	0	NULL	0	1	NULL	NULL	1036	NULL	NULL	NULL	NULL	72
80	1036	445710	0	Perf 445710	2017-12-22 00:00:00	NULL	P1036	NULL	Perf 1036	315.55	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1036	NULL	NULL	NULL	NULL	71
80	1041	211000	0	Perf 211000	2017-05-01 00:00:00	NULL	P1041	NULL	Perf 1041	500.20	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1041	NULL	NULL	NULL	NULL	81
80	1041	512001	0	Perf 512001	2017-05-01 00:00:00	NULL	P1041	NULL	Perf 1041	0.00	500.20	1	0	0	0	NULL	0	1	NULL	NULL	1041	NULL	NULL	NULL	NULL	82
80	1042	401016	0	Perf 401016	2017-06-08 00:00:00	NULL	P1042	NULL	Perf 1042	0.00	537.33	1	0	0	0	NULL	0	1	NULL	NULL	1042	NULL	NULL	NULL	NULL	84
80	1042	445710	0	Perf 445710	2017-06-08 00:00:00	NULL	P1042	NULL	Perf 1042	537.33	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1042	NULL	NULL	NULL	NULL	83
80	1047	213000	0	Perf 213000	2017-11-15 00:00:00	NULL	P1047	NULL	Perf 1047	722.98	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1047	NULL	NULL	NULL	NULL	93
80	1047	512001	0	Perf 512001	2017-11-15 00:00:00	NULL	P1047	NULL	Perf 1047	0.00	722.98	1	0	0	0	NULL	0	1	NULL	NULL	1047	NULL	NULL	NULL	NULL	94
80	1048	401022	0	Perf 401022	2017-12-22 00:00:00	NULL	P1048	NULL	Perf 1048	0.00	759.11	1	0	0	0	NULL	0	1	NULL	NULL	1048	NULL	NULL	NULL	NULL	96
80	1048	445710	0	Perf 445710	2017-12-22 00:00:00	NULL	P1048	NULL	Perf 1048	759.11	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1048	NULL	NULL	NULL	NULL	95
80	1053	218200	0	Perf 218200	2017-05-01 00:00:00	NULL	P1053	NULL	Perf 1053	944.76	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1053	NULL	NULL	NULL	NULL	105
80	1053	512001	0	Perf 512001	2017-05-01 00:00:00	NULL	P1053	NULL	Perf 1053	0.00	944.76	1	0	0	0	NULL	0	1	NULL	NULL	1053	NULL	NULL	NULL	NULL	106
80	1054	401002	0	Perf 401002	2017-06-08 00:00:00	NULL	P1054	NULL	Perf 1054	0.00	981.89	1	0	0	0	NULL	0	1	NULL	NULL	1054	NULL	NULL	NULL	NULL	108
80	1054	445710	0	Perf 445710	2017-06-08 00:00:00	NULL	P1054	NULL	Perf 1054	981.89	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1054	NULL	NULL	NULL	NULL	107
80	1059	218300	0	Perf 218300	2017-11-15 00:00:00	NULL	P1059	NULL	Perf 1059	176.54	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1059	NULL	NULL	NULL	NULL	117
80	1059	512001	0	Perf 512001	2017-11-15 00:00:00	NULL	P1059	NULL	Perf 1059	0.00	176.54	1	0	0	0	NULL	0	1	NULL	NULL	1059	NULL	NULL	NULL	NULL	118
80	1060	401008	0	Perf 401008	2017-12-22 00:00:00	NULL	P1060	NULL	Perf 1060	0.00	213.67	1	0	0	0	NULL	0	1	NULL	NULL	1060	NULL	NULL	NULL	NULL	120
80	1060	445710	0	Perf 445710	2017-12-22 00:00:00	NULL	P1060	NULL	Perf 1060	213.67	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1060	NULL	NULL	NULL	NULL	119
80	1065	218400	0	Perf 218400	2017-05-01 00:00:00	NULL	P1065	NULL	Perf 1065	398.32	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1065	NULL	NULL	NULL	NULL	129
80	1065	512001	0	Perf 512001	2017-05-01 00:00:00	NULL	P1065	NULL	Perf 1065	0.00	398.32	1	0	0	0	NULL	0	1	NULL	NULL	1065	NULL	NULL	NULL	NULL	130
80	1066	401014	0	Perf 401014	2017-06-08 00:00:00	NULL	P1066	NULL	Perf 1066	0.00	435.45	1	0	0	0	NULL	0	1	NULL	NULL	1066	NULL	NULL	NULL	NULL	132
80	1066	445710	0	Perf 445710	2017-06-08 00:00:00	NULL	P1066	NULL	Perf 1066	435.45	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1066	NULL	NULL	NULL	NULL	131
80	1071	211000	0	Perf 211000	2017-11-15 00:00:00	NULL	P1071	NULL	Perf 1071	620.10	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1071	NULL	NULL	NULL	NULL	141
80	1071	512001	0	Perf 512001	2017-11-15 00:00:00	NULL	P1071	NULL	Perf 1071	0.00	620.10	1	0	0	0	NULL	0	1	NULL	NULL	1071	NULL	NULL	NULL	NULL	142
80	1072	401020	0	Perf 401020	2017-12-22 00:00:00	NULL	P1072	NULL	Perf 1072	0.00	657.23	1	0	0	0	NULL	0	1	NULL	NULL	1072	NULL	NULL	NULL	NULL	144
80	1072	445710	0	Perf 445710	2017-12-22 00:00:00	NULL	P1072	NULL	Perf 1072	657.23	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1072	NULL	NULL	NULL	NULL	143
80	1077	213000	0	Perf 213000	2017-05-01 00:00:00	NULL	P1077	NULL	Perf 1077	842.88	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1077	NULL	NULL	NULL	NULL	153
80	1077	512001	0	Perf 512001	2017-05-01 00:00:00	NULL	P1077	NULL	Perf 1077	0.00	842.88	1	0	0	0	NULL	0	1	NULL	NULL	1077	NULL	NULL	NULL	NULL	154
80	1078	401026	0	Perf 401026	2017-06-08 00:00:00	NULL	P1078	NULL	Perf 1078	0.00	879.01	1	0	0	0	NULL	0	1	NULL	NULL	1078	NULL	NULL	NULL	NULL	156
80	1078	445710	0	Perf 445710	2017-06-08 00:00:00	NULL	P1078	NULL	Perf 1078	879.01	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1078	NULL	NULL	NULL	NULL	155
80	1083	218200	0	Perf 218200	2017-11-15 00:00:00	NULL	P1083	NULL	Perf 1083	74.66	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1083	NULL	NULL	NULL	NULL	165
80	1083	512001	0	Perf 512001	2017-11-15 00:00:00	NULL	P1083	NULL	Perf 1083	0.00	74.66	1	0	0	0	NULL	0	1	NULL	NULL	1083	NULL	NULL	NULL	NULL	166
80	1084	401006	0	Perf 401006	2017-12-22 00:00:00	NULL	P1084	NULL	Perf 1084	0.00	111.79	1	0	0	0	NULL	0	1	NULL	NULL	1084	NULL	NULL	NULL	NULL	168
80	1084	445710	0	Perf 445710	2017-12-22 00:00:00	NULL	P1084	NULL	Perf 1084	111.79	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1084	NULL	NULL	NULL	NULL	167
80	1089	218300	0	Perf 218300	2017-05-01 00:00:00	NULL	P1089	NULL	Perf 1089	296.44	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1089	NULL	NULL	NULL	NULL	177
80	1089	512001	0	Perf 512001	2017-05-01 00:00:00	NULL	P1089	NULL	Perf 1089	0.00	296.44	1	0	0	0	NULL	0	1	NULL	NULL	1089	NULL	NULL	NULL	NULL	178
80	1090	401012	0	Perf 401012	2017-06-08 00:00:00	NULL	P1090	NULL	Perf 1090	0.00	333.57	1	0	0	0	NULL	0	1	NULL	NULL	1090	NULL	NULL	NULL	NULL	180
80	1090	445710	0	Perf 445710	2017-06-08 00:00:00	NULL	P1090	NULL	Perf 1090	333.57	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1090	NULL	NULL	NULL	NULL	179
80	1095	218400	0	Perf 218400	2017-11-15 00:00:00	NULL	P1095	NULL	Perf 1095	518.22	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1095	NULL	NULL	NULL	NULL	189
80	1095	512001	0	Perf 512001	2017-11-15 00:00:00	NULL	P1095	NULL	Perf 1095	0.00	518.22	1	0	0	0	NULL	0	1	NULL	NULL	1095	NULL	NULL	NULL	NULL	190
80	1096	401018	0	Perf 401018	2017-12-22 00:00:00	NULL	P1096	NULL	Perf 1096	0.00	555.35	1	0	0	0	NULL	0	1	NULL	NULL	1096	NULL	NULL	NULL	NULL	192
80	1096	445710	0	Perf 445710	2017-12-22 00:00:00	NULL	P1096	NULL	Perf 1096	555.35	0.00	1	0	0	0	NULL	0	1	NULL	NULL	1096	NULL	NULL	NULL	NULL	191
## Fiches_Parametres (ind	dteclec	dteclec1	dteclec2	dteclec3	dteclec4	dteclec5	dtepp	dtepec	dtepc	dtetdec	dtefedec	cptrplus	cptrmoins	jdr	cptrsplus	cptrsmoins	numecriture	dnc	dnbon	dnfac	dndevis	jrnal	son	dnf	numecriture1	numecriture2	numecriture3	coretro	dncom	devise	jrnal2	jrnal3	jrnal4	dteinv	jrnal5	dnbr	nfac	version	conf	frais	cptfrais	tvafrais	dntk	cutk	dnart	ecart	jrnod)
0	2018-12-31	2017-12-31	2016-12-31	2015-12-31	2014-12-31	2013-12-31	12.2017	01.2018	2017-12-31	2017-12-31	2017-12-31	758000	658000	90	120000	129000	0	411027	000000	000000	000000	70	0	401026	0	0	0	1,00	NULL	Euros	53	50	70	NULL	60	NULL	0	3.69	NULL	0.00	NULL	NULL	0000001	0000001	003	0.00	10
## Fiches_Reglements (code	libel	journal	cptint	bordereaux	lcr	caisse	decaissement	regroup)
01	Espèces	53	NULL	0	0	0	0	1
05	Chèque	50	580002	0	0	0	0	1
10	Carte	50	580001	0	0	0	0	1
15	Paypal	50	NULL	0	0	0	0	1
20	Virement	50	NULL	0	0	0	0	1
25	Prélèvement	50	NULL	0	0	0	0	1
30	Traite	50	NULL	0	2	0	0	1
35	Lcr	50	NULL	0	1	0	0	1
40	Autre	50	580003	0	0	0	0	1
## Fiches_RubCompt (numrub	compte1	compte2	amortissement)
B0030	109	10999999	0
B0050	201	20199999	0
B0050	2800	28019999	1
B0060	203	20399999	0
B0060	2803	28039999	1
B0070	205	20599999	0
B0070	2805	28059999	0
B0070	2905	29059999	1
B0080	206	20799999	0
B0080	2807	28079999	0
B0080	2906	29079999	1
B0090	208	20899999	0
B0090	2808	28089999	1
B0090	2908	29089999	1
B0110	237	23799999	0
B0130	211	21299999	0
B0130	2811	28119999	0
B0130	2812	28129999	1
B0130	2911	29119999	0
B0140	213	21499999	0
B0140	2813	28139999	1
B0150	215	21599999	0
B0150	2815	28159999	1
B0160	210	21099999	0
B0160	218	21810799	0
B0160	218108	21810899	1
B0160	218200	21870799	0
B0160	218708	21870899	1
B0160	2810	28109999	0
B0160	2814	28149999	1
B0160	2818	28189999	1
B0160	2910	29109999	1
B0180	238	23899999	0
B0200	261	26199999	0
B0200	266	26699999	0
B0200	2961	29619999	0
B0200	2966	29669999	0
B0210	267	26899999	0
B0210	2967	29689999	0
B0220	271	27299999	0
B0220	27682	27682999	0
B0220	2971	29729999	0
B0230	274	27499999	0
B0230	27684	27684999	0
B0230	2974	29749999	0
B0240	270	27099999	0
B0240	275	27599999	0
B0240	2761	27619999	0
B0240	27685	27685999	0
B0240	27688	27688999	0
B0240	2970	29709999	0
B0240	2975	29759999	1
B0240	2976	29769999	0
B0280	30	32999999	0
B0280	391	39299999	1
B0290	33	33999999	0
B0290	393	39399999	1
B0300	34	34999999	0
B0300	394	39499999	1
B0310	35	35999999	0
B0310	395	39599999	1
B0320	37	37999999	0
B0320	397	39799999	1
B0340	409	40999999	0
B0360	4091	40919999	0
B0360	411	41199999	0
B0360	413	41399999	0
B0360	416	41899999	0
B0370	400	40299999	0
B0370	422	42299999	0
B0370	425	42599999	0
B0370	4287	42879999	0
B0370	431	43199999	0
B0370	437	43799999	0
B0370	4387	43879999	0
B0370	440	44199999	0
B0370	443	44499999	0
B0370	4452	44529999	0
B0370	4455	44569999	0
B0370	4487	44879999	0
B0370	451	45199999	0
B0370	455	45599999	0
B0370	4561	45619999	0
B0370	4563	45649999	0
B0370	4566	45679999	0
B0370	458	45899999	0
B0370	460	46099999	0
B0370	462	46299999	0
B0370	465	46599999	0
B0370	467	46799999	0
B0370	4687	46879999	0
B0370	470	47199999	0
B0370	478	47899999	0
B0370	495	49699999	0
B0370	496	49699999	1
B0380	4562	45629999	0
B0400	502	50299999	0
B0410	500	50199999	0
B0410	503	50899999	0
B0410	59	59999999	1
B0430	510	51299999	0
B0430	514	51799999	0
B0430	5187	51879999	0
B0430	519	51999999	0
B0430	53	54999999	0
B0430	58	58999999	0
B0450	486	48699999	0
B0480	481	48199999	0
B0500	169	16999999	0
B0520	476	47699999	0
B1040	101	10129999	0
B1040	108	10899999	0
B1050	1013	10139999	0
B1070	104	10499999	0
B1090	105	10599999	0
B1130	1061	10619999	0
B1140	1063	10639999	0
B1150	1062	10629999	0
B1150	1064	10649999	0
B1160	1068	10689999	0
B1180	11	11999999	0
B1180	88	89999999	0
B1200	12	12999999	0
B1200	6	79999999	0
B1220	13	13999999	0
B1240	14	14999999	0
B1280	150	15199999	0
B1300	153	15399999	0
B1300	155	15899999	0
B1340	161	16199999	0
B1340	16880	16881999	0
B1360	163	16399999	0
B1360	164	16499999	0
B1360	16883	16883999	0
B1360	16884	16884999	0
B1380	510	51299999	0
B1380	514	51799999	0
B1380	5186	51869999	0
B1380	519	51999999	0
B1380	58	58999999	0
B1400	160	16099999	0
B1400	165	16699999	0
B1400	1675	16759999	0
B1400	1681	16819999	0
B1400	1685	16859999	0
B1400	1687	16879999	0
B1400	16885	16885999	0
B1400	16887	16888999	0
B1400	17	17999999	0
B1400	426	42699999	0
B1400	451	45199999	0
B1400	455	45599999	0
B1400	4561	45619999	0
B1400	4563	45649999	0
B1400	4566	45679999	0
B1400	458	45899999	0
B1420	4190	41919999	0
B1440	400	40399999	0
B1440	4081	40819999	0
B1440	40881	40881999	0
B1460	421	42499999	0
B1460	427	42899999	0
B1460	4282	42829999	0
B1460	4284	42849999	0
B1460	4286	42869999	0
B1460	430	43199999	0
B1460	437	43799999	0
B1460	4382	43829999	0
B1460	4386	43869999	0
B1460	442	44499999	0
B1460	4452	44529999	0
B1460	4455	44559999	0
B1460	4457	44579999	0
B1460	44584	44584999	0
B1460	44587	44587999	0
B1460	446	44699999	0
B1460	447	44799999	0
B1460	4481	44829999	0
B1460	4486	44869999	0
B1460	457	45799999	0
B1480	269	26999999	0
B1480	279	27999999	0
B1480	404	40599999	0
B1480	4084	40849999	0
B1480	40884	40884999	0
B1500	409	40999999	0
B1500	410	41199999	0
B1500	4196	41989999	0
B1500	464	46499999	0
B1500	467	46799999	0
B1500	4686	46869999	0
B1500	470	47199999	0
B1500	478	47899999	0
B1520	487	48799999	0
B1550	477	47799999	0
R0040	607	60799999	0
R0040	6087	60879999	0
R0040	6097	60979999	0
R0040	67207	67207999	0
R0050	6037	60379999	0
R0080	601	60199999	0
R0080	6081	60819999	0
R0080	6090	60909999	0
R0080	6091	60919999	0
R0080	672	67299999	0
R0090	602	60299999	0
R0090	6082	60829999	0
R0090	6092	60929999	0
R0090	67202	67202999	0
R0100	6031	60319999	0
R0100	6032	60329999	0
R0110	604	60499999	0
R0110	605	NULL	0
R0110	6084	60849999	0
R0110	6085	60859999	0
R0110	6094	60949999	0
R0110	6095	60959999	0
R0110	67204	67204999	0
R0110	67205	67205999	0
R0110	67206	67206999	0
R0120	606	60699999	0
R0120	6086	60869999	0
R0120	6098	60989999	0
R0140	621	62199999	0
R0140	67221	67221999	0
R0150	6122	61229999	0
R0150	6125	61259999	0
R0150	6732	67329999	0
R0150	6735	67359999	0
R0160	611	61199999	0
R0160	613	61399999	0
R0160	614	61999999	0
R0160	622	62999999	0
R0160	6721	67219999	0
R0160	67228	67228999	0
R0180	631	63199999	0
R0180	633	63399999	0
R0180	67231	67231999	0
R0190	635	63599999	0
R0190	637	63799999	0
R0190	67235	67235999	0
R0210	641	64199999	0
R0210	644	64499999	0
R0210	67241	67241999	0
R0220	645	64899999	0
R0220	67245	67245999	0
R0240	6811	68129999	0
R0250	6816	68169999	0
R0260	6817	68179999	0
R0270	6815	68159999	0
R0290	651	65199999	0
R0290	653	65499999	0
R0290	658	65899999	0
R0290	67258	67258999	0
R0340	686	68699999	0
R0350	661	66199999	0
R0350	664	66599999	0
R0350	668	66899999	0
R0350	67261	67261999	0
R0360	666	66699999	0
R0360	67266	67266999	0
R0370	667	66799999	0
R0390	671	67199999	0
R0410	675	67599999	0
R0420	678	67899999	0
R0440	6872	68769999	0
R0450	6871	68719999	0
R0450	6875	68769999	0
R0490	695	69599999	0
R0490	697	69799999	0
R1040	707	70799999	0
R1040	7097	70979999	0
R1040	77207	77207999	0
R1060	701	70399999	0
R1060	7091	70929999	0
R1060	77201	77201999	0
R1070	704	70499999	0
R1070	7094	70949999	0
R1070	7314	73149999	0
R1070	7394	73949999	0
R1070	77204	77204999	0
R1080	705	70699999	0
R1080	708	70899999	0
R1080	7095	70969999	0
R1080	7098	70989999	0
R1080	7315	73159999	0
R1080	7395	73959999	0
R1080	77205	77205999	0
R1120	7133	71339999	0
R1130	7134	71349999	0
R1140	7135	71359999	0
R1160	72	72999999	0
R1180	74	74999999	0
R1180	77240	77240999	0
R1200	781	78199999	0
R1220	791	79199999	0
R1240	751	75399999	0
R1240	758	75899999	0
R1240	77208	77208999	0
R1240	77258	77258999	0
R1310	755	75599999	0
R1360	761	76199999	0
R1360	77261	77261999	0
R1370	762	76299999	0
R1370	77262	77262999	0
R1380	763	76599999	0
R1380	768	76899999	0
R1380	77263	77263999	0
R1390	786	78699999	0
R1390	796	79699999	0
R1400	766	76699999	0
R1400	77266	77266999	0
R1410	767	76799999	0
R1460	771	77199999	0
R1480	775	77599999	0
R1490	777	77799999	0
R1500	778	77899999	0
R1510	787	78799999	0
R1510	797	79799999	0
S0030	707	70799999	0
S0040	7097	70979999	0
S0050	6037	60379999	0
S0050	607	60799999	0
S0050	6087	60879999	0
S0050	6097	60979999	0
S0070	701	70699999	0
S0070	708	70899999	0
S0070	709	70999999	0
S0080	713	71399999	0
S0090	72	72999999	0
S0120	601	60299999	0
S0120	6031	60329999	0
S0120	604	60699999	0
S0120	6081	60829999	0
S0120	6084	60869999	0
S0120	6090	60909999	0
S0120	6091	60939999	0
S0120	6094	60969999	0
S0120	6098	60989999	0
S0120	61	61999999	0
S0120	62	62999999	0
S0150	74	74999999	0
S0160	63	63999999	0
S0170	64	64999999	0
S0200	781	78199999	0
S0205	791	79199999	0
S0210	681	68199999	0
S0220	75	75999999	0
S0230	65	65999999	0
S0270	755	75599999	0
S0280	655	65599999	0
S0290	76	76999999	0
S0290	786	78699999	0
S0290	796	79699999	0
S0300	66	66999999	0
S0300	686	68699999	0
S0330	77	77999999	0
S0330	787	78799999	0
S0330	797	79799999	0
S0340	67	67999999	0
S0340	687	68799999	0
S0360	691	69199999	0
S0370	695	69599999	0
S0390	775	77599999	0
S0400	675	67599999	0
## Fiches_Rubriques (numrub	intitule	type	detail	num)
B0010	BILAN - ACTIF	T	NULL	NULL
B0020	ACTIF IMMOBILISE	E	N	NULL
B0025	Capital souscrit non-appele	E	N	NULL
B0030	NULL	L	NULL	NULL
B0050	Frais d' etablissement	L	NULL	NULL
B0060	Frais de recherche et de developpement	L	NULL	NULL
B0070	Concessions, brevets, licences, marques, procedes, logiciels, etc...	L	NULL	NULL
B0080	Fonds commerciaux	L	NULL	NULL
B0090	Autres	L	NULL	NULL
B0095	Immobilisations incorporelles	E	NULL	NULL
B0110	Avances et acomptes	L	NULL	NULL
B0115	Immobilisations incorporelles en cours	E	NULL	NULL
B0130	Terrains	L	NULL	NULL
B0140	Constructions	L	NULL	NULL
B0150	Installations techniques, materiels et outillages industriels	L	NULL	NULL
B0160	Autres	L	NULL	NULL
B0165	Immobilisations corporelles	E	NULL	NULL
B0180	Avances et acomptes	L	NULL	NULL
B0190	Immobilisations financieres	L	NULL	NULL
B0200	Participations	L	NULL	NULL
B0210	Creances rattachees a des participations	L	NULL	NULL
B0220	Autres titres immobilises	L	NULL	NULL
B0230	Prets	L	NULL	NULL
B0240	Autres	L	NULL	NULL
B0245	Immobilisations corporelles en cours	E	NULL	NULL
B0250	TOTAL I	S	NULL	NULL
B0260	ACTIF CIRCULANT	E	NULL	NULL
B0280	Matieres premieres et autres approvisionnements	L	NULL	NULL
B0290	En-cours de production de biens	L	NULL	NULL
B0300	En-cours de production de services	L	NULL	NULL
B0310	Produits intermediaires et finis	L	NULL	NULL
B0320	Marchandises	L	NULL	NULL
B0330	Avances et acomptes verses sur commande	L	NULL	NULL
B0340	Avances et acomptes versés	L	NULL	NULL
B0345	Stocks et en-cours	E	NULL	NULL
B0360	Creances clients et comptes rattaches	L	NULL	NULL
B0370	Créances associés et comptes rattachés	L	NULL	NULL
B0375	Créances sociales	L	NULL	NULL
B0380	Capital souscrit - appele non verse	L	NULL	NULL
B0390	Valeurs mobilieres de placement :	E	NULL	NULL
B0400	Actions propres	L	NULL	NULL
B0410	Autres titres	L	NULL	NULL
B0415	Creances	E	NULL	NULL
B0430	Disponibilités	L		
B0435	Disponibilités	E		
B0450	Charges constatées d' avance	L	NULL	NULL
B0455	Charges constatées d' avance	E	NULL	NULL
B0460	TOTAL II	S	NULL	NULL
B0475	Charges a repartir sur plusieurs exercices (III)	E	NULL	NULL
B0480	NULL	L	NULL	NULL
B0500	NULL	L	NULL	NULL
B0505	Primes de remboursement des emprunts (IV)	E	NULL	NULL
B0520	NULL	L	NULL	NULL
B0525	Ecarts de conversion Actif (V)	E	NULL	NULL
B0530	TOTAL GENERAL (I+II+III+IV+V)	O	NULL	NULL
B1010	BILAN - PASSIF	T	NULL	NULL
B1020	CAPITAUX PROPRES	E	NULL	NULL
B1040	Capital social	L	NULL	NULL
B1050	dont verse :	L	N	NULL
B1055	Capital	E	NULL	NULL
B1070	NULL	L	NULL	NULL
B1075	Primes d' emission, de fusion, d' apport	E	NULL	NULL
B1090	NULL	L	NULL	NULL
B1095	Ecarts de reevaluation	E	NULL	NULL
B1110	NULL	L	NULL	NULL
B1115	Ecarts d' equivalence	E	NULL	NULL
B1130	Reserve legale	L	NULL	NULL
B1140	Reserves statutaires ou contractuelles	L	NULL	NULL
B1150	Reserves reglementees	L	NULL	NULL
B1160	Autres	L	NULL	NULL
B1165	Reserves :	E	NULL	NULL
B1180	NULL	L	NULL	NULL
B1185	Report a nouveau	E	NULL	NULL
B1200	NULL	L	NULL	NULL
B1205	Resultat de l' exercice (benefice ou perte )	E	NULL	NULL
B1220	NULL	L	NULL	NULL
B1225	Subventions d' investissements	E	NULL	NULL
B1240	NULL	L	NULL	NULL
B1245	Provisions reglementees	E	NULL	NULL
B1250	TOTAL I	S	NULL	NULL
B1260	PROVISIONS POUR RISQUES ET CHARGES	E	NULL	NULL
B1280	NULL	L	NULL	NULL
B1285	Provisions pour risques	E	NULL	NULL
B1300	NULL	L	NULL	NULL
B1305	Provisions pour charges	E	NULL	NULL
B1310	TOTAL II	S	NULL	NULL
B1320	DETTES	E	NULL	NULL
B1340	NULL	L	NULL	NULL
B1345	Emprunts obligatoires converties	E	NULL	NULL
B1360	NULL	L	NULL	NULL
B1365	Autres emprunts obligataires	E	NULL	NULL
B1380	NULL	L	NULL	NULL
B1385	Emprunts et dettes aupres des etablissements de credit	E	NULL	NULL
B1400	NULL	L	NULL	NULL
B1405	Emprunts et dettes financieres divers	E	NULL	NULL
B1420	NULL	L	NULL	NULL
B1425	Avances et acomptes reçus sur commandes en cours	E	NULL	NULL
B1440	NULL	L	NULL	NULL
B1445	Dettes fournisseurs et comptes rattaches	E	NULL	NULL
B1460	NULL	L	NULL	NULL
B1465	Dettes fiscales et sociales	E	NULL	NULL
B1480	NULL	L	NULL	NULL
B1485	Dettes sur immobilisations et comptes rattaches	E	NULL	NULL
B1500	NULL	L	NULL	NULL
B1505	Autres dettes	E	NULL	NULL
B1520	NULL	L	NULL	NULL
B1525	Produits constates d' avance	E	NULL	NULL
B1530	TOTAL III	S	N	NULL
B1550	NULL	L	NULL	NULL
B1555	Ecarts de conversion Passif (IV)	E	N	NULL
B1560	TOTAL GENERAL (I+II+III+IV)	O	N	NULL
R0010	COMPTE DE RESULTAT - CHARGES	T	NULL	NULL
R0020	CHARGES D'EXPLOITATION	E	NULL	NULL
R0030	Cout d'achat des marchandises vendues dans l'exercice	E	N	NULL
R0040	Achats de marchandises	L	NULL	NULL
R0050	Variations des stocks de marchandises	L	NULL	NULL
R0060	Consommations de l'exercice en provenance des tiers	E	N	NULL
R0070	Achats stockes d'approvisionnements :	L	NULL	NULL
R0080	Matieres premières	L	NULL	NULL
R0090	Autres approvisionnements	L	NULL	NULL
R0100	Variations des stocks d'approvisionnements	L	NULL	NULL
R0110	Achats de sous-traitances	L	NULL	NULL
R0120	Achats non stockes de matieres et fournitures	L	NULL	NULL
R0130	Services exterieurs :	L	NULL	NULL
R0140	Personnel exterieur	L	NULL	NULL
R0150	Loyers en credit-bail	L	NULL	NULL
R0160	Autres	L	NULL	NULL
R0170	Impots, taxes, et versements assimiles	E	N	NULL
R0180	Sur remunerations	L	NULL	NULL
R0190	Autres	L	NULL	NULL
R0200	Charges de personnel	E	N	NULL
R0210	Salaires et traitements	L	NULL	NULL
R0220	Charges sociales	L	NULL	NULL
R0230	Dotations aux amortissements et aux provisions	E	N	NULL
R0240	Sur immobilisations : Dotations aux amortissements	L	NULL	NULL
R0250	Sur immobilisations : Dotations aux provisions	L	NULL	NULL
R0260	Sur actif circulant : Dotations aux provisions	L	NULL	NULL
R0270	Pour risques et charges : Dotations aux provisions	L	NULL	NULL
R0280	Autres charges	E	N	NULL
R0290	NULL	L	NULL	NULL
R0300	TOTAL I	S	NULL	NULL
R0310	QUOTES-PARTS DE RESULTAT SUR OP FAITES EN COMMUN (II)	E	NULL	NULL
R0320	NULL	I	NULL	NULL
R0330	CHARGES FINANCIERES (III)	E	N	NULL
R0340	Dotations aux amortissemnts et aux provisions	L	NULL	NULL
R0350	Interets et charges assimilees	L	NULL	NULL
R0360	Differences negatives de change	L	NULL	NULL
R0370	Charges nettes/cessions de valeurs mobilieres de placement	L	NULL	NULL
R0380	CHARGES EXCEPTIONNELLES (IV)	E	N	NULL
R0390	Sur operations de gestion	L	NULL	NULL
R0400	Sur operations en capital :	L	NULL	NULL
R0410	Valeurs comptables des elements immob et financiers cede	L	NULL	NULL
R0420	Autres	L	NULL	NULL
R0430	Dotations aux amortissements et aux provisions :	L	NULL	NULL
R0440	Dotations aux provisions reglementees	L	NULL	NULL
R0450	Dotations aux amortissements et autres provisions	L	NULL	NULL
R0460	PARTICIPATION DES SALARIES AUX FRUITS DE L'EXPANSION (V)	E	NULL	NULL
R0470	NULL	L	NULL	NULL
R0480	IMPOTS SUR LES BENEFICES (VI)	E	N	NULL
R0490	NULL	L	NULL	NULL
R0700	TOTAL DES CHARGES (I+II+II+IV+V+VI)	O	NULL	NULL
R0800	SOLDE CREDITEUR = Bénefice (VII)	C	NULL	NULL
R0900	TOTAL GENERAL (I+II+III+IV+V+VI+VII)	R	NULL	NULL
R1010	COMPTE DE RESULTAT - PRODUITS	T	NULL	NULL
R1020	PRODUITS D'EXPLOITATION :	E	NULL	NULL
R1030	Ventes de marchandises	E	N	NULL
R1040	NULL	L	NULL	NULL
R1050	Production vendue	E	N	NULL
R1060	Ventes	L	NULL	NULL
R1070	Travaux	L	NULL	NULL
R1080	Prestations de services	L	NULL	NULL
R1090	MONTANT NET DU CHIFFRE D'AFFAIRES :	S	NULL	NULL
R1100	Dont a l'exportation :	E	N	NULL
R1105	NULL	L	NULL	NULL
R1110	Production stockee	E	N	NULL
R1120	En cours de production de biens	L	NULL	NULL
R1130	En cours de production de services	L	NULL	NULL
R1140	produits	L	NULL	NULL
R1150	Production immobilisee	E	N	NULL
R1160	NULL	L	NULL	NULL
R1170	Subvention d'exploitation	E	N	NULL
R1180	NULL	L	NULL	NULL
R1190	Reprises sur provisions (et amortissements)	E	N	NULL
R1200	NULL	L	NULL	NULL
R1210	Transferts de charges	E	N	NULL
R1220	NULL	L	NULL	NULL
R1230	Autres produits	E	N	NULL
R1240	NULL	L	NULL	NULL
R1250	TOTAL I	S	NULL	NULL
R1300	QUOTES-PARTS DE RESULTAT SUR OP. FAITES EN COMMUN (II)	E	NULL	NULL
R1310	NULL	L	NULL	NULL
R1350	PRODUITS FINANCIERS (III)	E	N	NULL
R1360	Departicipations	L	NULL	NULL
R1370	D'autres valeurs mobilieres et creances de l'actif immobilier	L	NULL	NULL
R1380	Autres interets et produits assimiles	L	NULL	NULL
R1390	Reprises sur provisions et transferts de charges financiere	L	NULL	NULL
R1400	Differences positives de change	L	NULL	NULL
R1410	Produits nets sur cessions de valeurs mobilieres de placement	L	NULL	NULL
R1450	PRODUITS EXCEPTIONNELS (IV)	E	N	NULL
R1460	Sur operations de gestion	L	NULL	NULL
R1470	Sur operations en capital :	L	NULL	NULL
R1480	produits des cessions d'elements d'actif	L	NULL	NULL
R1490	Subventions d'investissement virees aux resultats de l'exercice	L	NULL	NULL
R1500	Autres	L	NULL	NULL
R1510	Reprises sur provisions et transferts de charges exceptionnelles	L	NULL	NULL
R1700	TOTAL DES PRODUITS (I+II+III+IV)	O	NULL	NULL
R1800	SOLDE DEBITEUR = PERTE (V)	D	NULL	NULL
R1810	TOTAL GENERAL(I+II+III+IV+V)	G	NULL	NULL
S0010	SOLDES INTERMEDIAIRES DE GESTION	T	NULL	NULL
S0020	Marge commerciale	E	N	NULL
S0030	Ventes de marchandises	L	O	P
S0040	RRR sur ventes	L	O	P
S0050	Cout direct d'achat	L	O	A
S0060	Marge commerciale	E	N	NULL
S0070	Production vendue	L	O	P
S0080	Production stockee	L	O	P
S0090	Production immobilisee	L	N	P
S0100	Produits nets partiels sur operations a long terme	L	NULL	NULL
S0105	Production de l'exercice	E	N	P
S0110	Production de l'exercice	L	N	R
S0115	Marge commerciale	L	N	A
S0120	Consommations en provenance de tiers	L	O	A
S0130	Valeur ajoutée	E	N	NULL
S0135	Valeur ajoutée	L	N	R
S0140	NULL	NULL	NULL	NULL
S0150	Subventions d'exploitation	L	O	P
S0160	Impots, taxes, et versements assimiles	L	O	A
S0170	Charges de personnel	L	O	A
S0180	Excédent brut d'exploitation	E	N	NULL
S0190	Excédent brut d'exploitation	L	N	R
S0195	Insuffisance brute d'exploitation	NULL	NULL	NULL
S0200	Reprises sur ammortissements et provisions d'exploitation	L	O	P
S0205	Transferts de charges d'exploitation	L	O	P
S0210	Dotations aux amortissements et provisions d'exploitation	L	O	A
S0220	Autres produits de gestion courante	L	O	P
S0230	Autres charges de gestion courante	L	O	A
S0240	Transferts de charges d'exploitation	NULL	NULL	NULL
S0250	Résultat d'exploitation	E	N	NULL
S0260	Résultat d'exploitation	L	N	R
S0270	Quotes-parts de resultat sur operations faites en commun	L	O	P
S0280	Quotes-parts de resultat sur operations faites en commun	L	O	A
S0290	Produits financiers	L	O	P
S0300	Charges financieres	L	O	A
S0310	Résultat courant avant impots	E	N	NULL
S0315	Résultat courant avant impots	L	N	P
S0320	Résultat courant avant impots	L	N	A
S0330	Produits exceptionnels	L	O	P
S0340	Charges exceptionnelles	L	O	A
S0350	Résultat exceptionnel	E	N	NULL
S0354	Résultat courant avant impots	L	N	R
S0358	Résultat exceptionnel	L	N	R
S0360	Participations des salaries aux resultats de l'exercice	L	O	A
S0370	Impots sur les benefices	L	O	A
S0380	Résultat de l'exercice	E	N	NULL
S0390	Produits cessions d'éléments d'actif	L	O	P
S0400	Valeur comptable éléments cédés	L	O	A
S0410	Plus et moins-values sur cessions d'éléments d'actif	E	N	NULL
## Fiches_Societes (cd_sc	type_sc	int_sc	adr1_sc	adr2_sc	cp_sc	burdis_sc	email_sc	rcs_sc	villerc_sc	siret_sc	tvaintra_sc	cap_sc	ape_sc	tel_sc	fax_sc	site	port_sc	banq	bic	libre)
01	NULL	Laurux	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	06	NULL	NULL	NULL
## Fiches_Tleg (lind	intitule)
1	RESERVE DE PROPRIETE: Le vendeur se réserve la proprieté des marchandises jusqu'au paiement intégral de leur prix en principal et intérêts, par l'acheteur.
Aucune piece n'est reprise apres 8 jours de livraison, les pieces commandées spécialement ne sont jamais reprises. Sauf application des règles obligatoires de compétence a l'égard des non
La responsabilité des marchandises est transferée dès leur délivrance. Nos marchandises voyagent aux risques et périls des destinataires.
commercants, toutes contestations seront transmises aux juridictions du siege de notre entreprise.
## Fiches_Tvaac (code_tva	taux_tva	cc_tva)
1	2.10	445660
2	5.50	445670
3	19.60	445680
## Fiches_Tvaav (code_tva	taux_tva	cc_tva)
1	2.10	445710
2	7.00	445720
3	20.00	445730
## Fiches_Txt_Relances (niveau	libell1	libell2)










	
	
	
1	Messieurs,
2	Messieurs,
3	Messieurs,
A notre grand regret, étant donné nos bonnes relations pécédentes, il nous faut vous informer que si
Esperant que vous ne nous laisserez pas recourir à ces moyens extrêmes, recevez, Messieurs, nos 
L'examen de votre compte nous a permis de constater que les factures ci-dessous ne nous ont pas été
La comptabilité
La comptabilité
La comptabilité
Nous avons eu l'honneur dernièrement de vous demander le réglement des factures ci-dessous et nous 
Nous sommes très surpris que vous ayez laissé sans réponse nos précédentes lettres .
Nous vous remercions de faire le nécessaire et d'agréer, Messieurs, nos sincères salutations.
Nous vous remercions, afin de nous éviter des frais supplémentaires et de ne pas compliquer notre 
Recevez, Messieurs, nos sincères salutations.
comptabilité, de nous envoyer, par retour de courrier, le montant de ces factures.
nous ne recevons pas le montant du solde de votre compte, dans la huitaine, nous serons obligés de
prétendre au recouvrement de notre créance par les voies de droit.
réglées à ce jour :
sincères salutations.
sommes surpris de ne pas avoir reçu de réponse.
## Fiches_Txtmo (code_txtmo	tx_txtmo	libell_txtmo	compt_txtmo	prvt_txtmo)
1	28	Mecanique T1	706100	14.000
2	31	Mecanique T2	706100	15.000
3	35	Mecanique T3	706100	18.000
## Fiches_Typec (code	libelle)
01	Macon
02	Plombier
03	Agriculteur
## centralisation (numrub	intitrub	type	detail	compte	intitcpt	Col1	Col2	col3	col4	amortissement	amortissement2	actif	actif2)
B0010	BILAN - ACTIF	T	NULL	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B0020	ACTIF IMMOBILISE	E	N	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B0025	Capital souscrit non-appele	E	N	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B0050	Frais d' etablissement	L	N	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B0060	Frais de recherche et de developpement	L	N	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B0070	Concessions, brevets, licences, marques, procedes, logiciels, etc...	L	N	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B0080	Fonds commerciaux	L	N	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B0090	Autres	L	N	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B0095	Immobilisations incorporelles	E	NULL	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B0110	Avances et acomptes	L	N	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B0115	Immobilisations incorporelles en cours	E	NULL	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B0130	Terrains	L	O	211000	Terrain	10107.4	0	8606.8	0	0	0	0	NULL
B0140	Constructions	L	O	213500	Inst. Gen. Agen. Ame.	8743.76	0	8743.76	0	0	0	0	NULL
B0150	Installations techniques, materiels et outillages industriels	L	O	281500	Amortissement materiel de bureau	0	0	0	0	0	0	0	NULL
B0160	Autres	L	O	218400	Mobilier	25642.72	0	24289.24	0	0	0	0	NULL
B0165	Immobilisations corporelles	E	NULL	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B0180	Avances et acomptes	L	N	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B0190	Immobilisations financieres	L	N	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B0200	Participations	L	O	266000	Autres formes de participation	0	0	0	0	0	0	0	NULL
B0210	Creances rattachees a des participations	L	N	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B0220	Autres titres immobilises	L	N	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B0230	Prets	L	N	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B0240	Autres	L	O	275000	Depots et cautionnements	0	0	0	0	0	0	0	NULL
B0245	Immobilisations corporelles en cours	E	NULL	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B0250	TOTAL I	S	NULL	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B0260	ACTIF CIRCULANT	E	NULL	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B0280	Matieres premieres et autres approvisionnements	L	N	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B0290	En-cours de production de biens	L	O	335000	Travaux en cours	0	0	0	0	0	0	0	NULL
B0300	En-cours de production de services	L	N	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B0310	Produits intermediaires et finis	L	N	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B0320	Marchandises	L	O	397000	Provision depreciation stock	0	0	0	0	0	0	0	NULL
B0330	Avances et acomptes verses sur commande	L	N	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B0340	Avances et acomptes versés	L	O	409700	Avoirs non parvenus	0	0	0	0	0	0	0	NULL
B0345	Stocks et en-cours	E	NULL	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B0360	Creances clients et comptes rattaches	L	N	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B0370	Créances associés et comptes rattachés	L	N	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B0375	Créances sociales	L	N	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B0380	Capital souscrit - appele non verse	L	N	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B0390	Valeurs mobilieres de placement :	E	NULL	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B0400	Actions propres	L	N	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B0410	Autres titres	L	N	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B0415	Creances	E	NULL	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B0430	Disponibilités	L	O	530000	Caisse	50544.94	0	41686.44	0	0	0	0	NULL
B0435	Disponibilités	E	NULL	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B0450	Charges constatées d' avance	L	N	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B0455	Charges constatées d' avance	E	NULL	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B0460	TOTAL II	S	NULL	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B0475	Charges a repartir sur plusieurs exercices (III)	E	NULL	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B0505	Primes de remboursement des emprunts (IV)	E	NULL	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B0525	Ecarts de conversion Actif (V)	E	NULL	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B0530	TOTAL GENERAL (I+II+III+IV+V)	O	NULL	NULL	NULL	14903.63	0	81819.42	0	0	0	NULL	NULL
B1010	BILAN - PASSIF	T	NULL	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B1020	CAPITAUX PROPRES	E	NULL	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B1040	Capital social	L	O	108000	Exploitant	0	0	0	0	0	0	0	NULL
B1050	dont verse :	L	N	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B1055	Capital	E	NULL	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B1075	Primes d' emission, de fusion, d' apport	E	NULL	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B1095	Ecarts de reevaluation	E	NULL	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B1115	Ecarts d' equivalence	E	NULL	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B1130	Reserve legale	L	N	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B1140	Reserves statutaires ou contractuelles	L	N	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B1150	Reserves reglementees	L	N	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B1160	Autres	L	O	106800	Autres reserves	0	0	0	0	0	0	0	NULL
B1165	Reserves :	E	NULL	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B1180	NULL	L	O	119000	Report a nouveau debit	NULL	NULL	0	0	0	0	0	NULL
B1185	Report a nouveau	E	NULL	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B1200	NULL	L	O	129000	Resultat. Perte	NULL	NULL	0	0	0	0	0	NULL
B1205	Resultat de l' exercice (benefice ou perte )	E	NULL	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B1225	Subventions d' investissements	E	NULL	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B1245	Provisions reglementees	E	NULL	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B1250	TOTAL I	S	NULL	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B1260	PROVISIONS POUR RISQUES ET CHARGES	E	NULL	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B1285	Provisions pour risques	E	NULL	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B1305	Provisions pour charges	E	NULL	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B1310	TOTAL II	S	NULL	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B1320	DETTES	E	NULL	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B1340	NULL	L	O	168800	Interets courus	NULL	NULL	0	0	0	0	0	NULL
B1345	Emprunts obligatoires converties	E	NULL	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B1365	Autres emprunts obligataires	E	NULL	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B1380	NULL	L	O	512001	Banque 2	89215.34	NULL	81819.42	0	0	0	0	NULL
B1385	Emprunts et dettes aupres des etablissements de credit	E	NULL	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B1405	Emprunts et dettes financieres divers	E	NULL	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B1420	NULL	L	O	419100	Clients avances et acomptes reçus	NULL	NULL	0	0	0	0	0	NULL
B1425	Avances et acomptes reçus sur commandes en cours	E	NULL	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B1440	NULL	L	O	408100	Fournisseurs factures non parvenues	NULL	NULL	0	0	0	0	0	NULL
B1445	Dettes fournisseurs et comptes rattaches	E	NULL	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B1460	NULL	L	O	445730	Tva sur ventes 19.60	NULL	NULL	0	0	0	0	0	NULL
B1465	Dettes fiscales et sociales	E	NULL	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B1485	Dettes sur immobilisations et comptes rattaches	E	NULL	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B1500	NULL	L	O	471000	Compte d'attente	NULL	NULL	0	0	0	0	0	NULL
B1505	Autres dettes	E	NULL	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B1525	Produits constates d' avance	E	NULL	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B1530	TOTAL III	S	N	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B1555	Ecarts de conversion Passif (IV)	E	N	NULL	NULL	0	0	0	0	0	0	NULL	NULL
B1560	TOTAL GENERAL (I+II+III+IV)	O	N	NULL	NULL	0	0	0	0	0	0	NULL	NULL
