-- schéma
/*M!999999\- enable the sandbox mode */ 
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
-- données
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
