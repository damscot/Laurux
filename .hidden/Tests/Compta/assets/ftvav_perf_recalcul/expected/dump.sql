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
-- données
## Fiches_Art (art_code	art_design	art_fam	art_four	art_cequ	art_cbarre	art_cfour	art_pbht	art_tr	art_paht	art_coef	art_pvht	art_tva	art_pvttc	art_cdarr	art_pvar	art_dec	art_stocke	art_qte	art_dpa	art_dfour	art_pmp	art_com	art_stkdep	art_nbd	art_design2	art_ect	art_eco	art_pauaht	art_txconv	art_stkmin	art_stkmax	art_suspendu	art_cpp	art_copp	qte1	qte2	rem1	qte3	qte4	rem2	qte5	qte6	rem3	qte7	qte8	rem4	qte9	qte10	rem5	qte11	qte12	rem6	art_frais	art_prvt	art_etiq	art_poids	art_mincom	art_vol	art_poids2	art_photo	art_crst	art_mat	art_marque	art_impcar	art_casier	art_pvcons	art_prdcomp	art_impdetail	art_remcas1	art_remcas2	art_remcas3	art_datefbt	art_pbfbt	art_ddatefbt	art_centrale	art_refcentrale	art_bonus	art_colvte	art_pvht2	art_cn8	art_crpl1	art_crpl2	art_ect2	art_eco2	art_depg	art_cnsg	art_ua	art_uv	art_refliee	art_ddate	art_cdate	export	art_bredu	art_bredudate	art_breducond	art_bredumnt)
001	Produit 2.10	01	401001		2148413200001		10	0	10	2.2000	22	1	22.46	0,01	NULL	0	0	0	0	NULL	10	NULL	NULL	2		0	NULL	10	1.0000	0	0	0	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	10.000	1	0.000	0	Kg	NULL			0		0		0.000	0	0	0.00	0.00	0.00	2001-01-02	NULL	NULL			0.00	NULL	NULL			NULL	0	NULL	0	0			NULL	NULL	2018-01-01 00:00:00	0	0	NULL	NULL	0.00
002	Produit 7.00	02	401001		2640636100002		10	0	10	2.0000	20	2	21.4	0,01	NULL	0	0	0	0	NULL	10	NULL	NULL	2		0	NULL	10	1.0000	0	0	0	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	10.000	1	0.000	0	Kg	NULL			0		0		0.000	0	0	0.00	0.00	0.00	2001-01-02	NULL	NULL			0.00	NULL	NULL			NULL	0	NULL	0	0			NULL	NULL	2018-01-01 00:00:00	0	0	NULL	NULL	0.00
003	produit 20.00	03	401001				0	0	0	1.0000	0	3	0	0,01	NULL	0	0	0	0	NULL	0	NULL	0	2		0	NULL	0	1.0000	0	0	0	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	0.000	1	0.000	2	Kg	NULL			0		0		0.000	0	0	0.00	0.00	0.00	2001-01-02	0.000	NULL			0.00	NULL	NULL			NULL	0	NULL	0	0				NULL	2018-01-01 00:00:00	0	0	NULL	NULL	0.00
TP05	Perf arrondi 0,05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.37	3	12.5475	0,05	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	2	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	0	NULL	NULL	0.00
TP50	Perf arrondi 0,50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.3	3	10.05	0,50	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	2	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	0	NULL	NULL	0.00
## Fiches_Bl (numbl	type	cdclibl	cvclibl	nmclibl	pnmclibl	adr1bl	adr2bl	cpbl	villebl	tvar	datebl	rmobl	rartbl	exobl	remmobl	remartbl	marge_art	marge_mo	totalht	imp	acpt	mreg	reg	ech	numfac	dtefac	retro	numserie	codep	mtreg	totalttc	desg1	desg2	marque	typemat	htbl	cdep	livraison	tel	reg2	mtreg2	acquitte	numtick	email	gestbl)
910001	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910002	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910003	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910004	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910005	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910006	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910007	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910008	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910009	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910010	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910011	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910012	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910013	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910014	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910015	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910016	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910017	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910018	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910019	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910020	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910021	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910022	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910023	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910024	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910025	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910026	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910027	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910028	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910029	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910030	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910031	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910032	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910033	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910034	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910035	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910036	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910037	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910038	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910039	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910040	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910041	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910042	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910043	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910044	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910045	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910046	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910047	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910048	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910049	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910050	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910051	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910052	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910053	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910054	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910055	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910056	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910057	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910058	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910059	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910060	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910061	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910062	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910063	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910064	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910065	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910066	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910067	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910068	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910069	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910070	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910071	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910072	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910073	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910074	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910075	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910076	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910077	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910078	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910079	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910080	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910081	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910082	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910083	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910084	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910085	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910086	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910087	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910088	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910089	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910090	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910091	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910092	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910093	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910094	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910095	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910096	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910097	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910098	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910099	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910100	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910101	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910102	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910103	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910104	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910105	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910106	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910107	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910108	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910109	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910110	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910111	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910112	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910113	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910114	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910115	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910116	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910117	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910118	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910119	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910120	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910121	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910122	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910123	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910124	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910125	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910126	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910127	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910128	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910129	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910130	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910131	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910132	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910133	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910134	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910135	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910136	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910137	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910138	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910139	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910140	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910141	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910142	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910143	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910144	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910145	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910146	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910147	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910148	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910149	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910150	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910151	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910152	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910153	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910154	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910155	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910156	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910157	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910158	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910159	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910160	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910161	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910162	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910163	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910164	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910165	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910166	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910167	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910168	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910169	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910170	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910171	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910172	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910173	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910174	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910175	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910176	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910177	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910178	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910179	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910180	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910181	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910182	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910183	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910184	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910185	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910186	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910187	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910188	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910189	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910190	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910191	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910192	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910193	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910194	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910195	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910196	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910197	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910198	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910199	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910200	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910201	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910202	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910203	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910204	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910205	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910206	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910207	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910208	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910209	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910210	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910211	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910212	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910213	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910214	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910215	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910216	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910217	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910218	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910219	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910220	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910221	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910222	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910223	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910224	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910225	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910226	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910227	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910228	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910229	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910230	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910231	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910232	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910233	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910234	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910235	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910236	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910237	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910238	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910239	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910240	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910241	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910242	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910243	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910244	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910245	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910246	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910247	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910248	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910249	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910250	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910251	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910252	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910253	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910254	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910255	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910256	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910257	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910258	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910259	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910260	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910261	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910262	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910263	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910264	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910265	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910266	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910267	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910268	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910269	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910270	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910271	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910272	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910273	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910274	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910275	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910276	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910277	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910278	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910279	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910280	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910281	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910282	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910283	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910284	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910285	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910286	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910287	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910288	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910289	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910290	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910291	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910292	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910293	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910294	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910295	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910296	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910297	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910298	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910299	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910300	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910301	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910302	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910303	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910304	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910305	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910306	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910307	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910308	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910309	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910310	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910311	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910312	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910313	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910314	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910315	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910316	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910317	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910318	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910319	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910320	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910321	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910322	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910323	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910324	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910325	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910326	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910327	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910328	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910329	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910330	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910331	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910332	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910333	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910334	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910335	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910336	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910337	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910338	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910339	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910340	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910341	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910342	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910343	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910344	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910345	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910346	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910347	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910348	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910349	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910350	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910351	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910352	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910353	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910354	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910355	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910356	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910357	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910358	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910359	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910360	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910361	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910362	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910363	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910364	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910365	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910366	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910367	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910368	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910369	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910370	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910371	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910372	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910373	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910374	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910375	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910376	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910377	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910378	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910379	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910380	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910381	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910382	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910383	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910384	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910385	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910386	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910387	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910388	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910389	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910390	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910391	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910392	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910393	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910394	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910395	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910396	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910397	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910398	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910399	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910400	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910401	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910402	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910403	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910404	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910405	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910406	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910407	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910408	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910409	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910410	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910411	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910412	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910413	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910414	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910415	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910416	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910417	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910418	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910419	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910420	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910421	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910422	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910423	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910424	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910425	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910426	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910427	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910428	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910429	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910430	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910431	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910432	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910433	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910434	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910435	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910436	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910437	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910438	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910439	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910440	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910441	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910442	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910443	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910444	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910445	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910446	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910447	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910448	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910449	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910450	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910451	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910452	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910453	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910454	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910455	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910456	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910457	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910458	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910459	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910460	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910461	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910462	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910463	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910464	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910465	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910466	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910467	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910468	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910469	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910470	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910471	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910472	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910473	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910474	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910475	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910476	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910477	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910478	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910479	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910480	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910481	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910482	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910483	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910484	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910485	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910486	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910487	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910488	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910489	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910490	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910491	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910492	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910493	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910494	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910495	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910496	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910497	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910498	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910499	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
910500	B	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2026-01-10 10:00:00	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	0.00
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
705000	Sous-traitance	G	0	NULL	0	0	3	21.00	1			0	0	0	0	NULL
706100	Ventes MO	G	0	NULL	0	0	3	21.00	1			0	0	0	0	NULL
706105	Prestations services 7.00	G	0	NULL	0	0	NULL	NULL	0	NULL	NULL	0	0	NULL	0	NULL
706110	Prestations services 20.00	G	0	NULL	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	NULL
707000	Ventes marchandises 2.10	G	0	NULL	0	0	1	2.10	1			0	0	0	0	NULL
707010	Ventes marchandises 7.00	G	0	NULL	0	0	2	7.00	1	NULL	NULL	0	0	0	0	NULL
707020	Ventes marchandises 20.00	G	0	NULL	0	0	3	21.00	1	NULL	NULL	0	0	0	0	NULL
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
03	Produits 20.00	707020	1.800	3	21	709000	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	707020	NULL	NULL	707020	0
10	Mo 20.00	706100	2.000	3	21	709000	NULL	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	706100	NULL	NULL	706100	0
11	MO 7.00	706105	1.000	3	21	709000	0	0	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	706105	NULL	NULL	706105	0
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
## Fiches_Ligbl (num_ligbl	numlig_ligbl	code_ligbl	libel_ligbl	fam_ligbl	pu_ligbl	dec_ligbl	qte_ligbl	brut_ligbl	rem_ligbl	netht_ligbl	tx_ligbl	nettc_ligbl	typel_ligbl	tm_ligbl	com_ligbl	block_ligbl	pdstotal_ligbl	mrgart_ligbl	mrgmo_ligbl	mtx_ligfac	four_ligbl	refl_ligbl	tour_ligbl	dte_ligbl)
910001	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.02	3	25,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910001	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.11	3	46.1131	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910001	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.03	3	41,1765	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910001	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.04	3	56,9185	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910001	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.05	3	12,1605	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910001	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.06	3	27,9050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910001	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.07	3	43,6450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910001	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.08	3	59,3850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910001	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.09	3	15,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910001	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.10	3	30.371	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910002	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.03	3	33,9165	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910002	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.12	3	54.5952	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910002	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.04	3	49,6585	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910002	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.05	3	4,9005	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910002	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.06	3	20,6425	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910002	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.07	3	36,3850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910002	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.08	3	52,1250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910002	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.09	3	7,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910002	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.10	3	23,100	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910002	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.11	3	38.8531	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910003	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.04	3	42,3985	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910003	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.13	3	2.5773	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910003	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.05	3	58,1405	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910003	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.06	3	13,3825	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910003	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.07	3	29,1245	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910003	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.08	3	44,8650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910003	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.09	3	61,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910003	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.10	3	15,850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910003	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.11	3	31,5950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910003	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.12	3	47.3352	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910004	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.05	3	50,8805	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910004	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.14	3	11.0594	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910004	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.06	3	6,1225	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910004	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.07	3	21,8645	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910004	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.08	3	37,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910004	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.09	3	53,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910004	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.10	3	9,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910004	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.11	3	24,3350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910004	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.12	3	40,0750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910004	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.13	3	55.8173	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910005	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.06	3	59,3625	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910005	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.15	3	19.5415	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910005	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.07	3	14,6045	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910005	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.08	3	30,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910005	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.09	3	46,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910005	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.10	3	1,350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910005	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.11	3	17,0750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910005	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.12	3	32,8150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910005	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.13	3	48,5550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910005	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.14	3	3.7994	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910006	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.07	3	7,3445	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910006	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.16	3	28.0236	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910006	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.08	3	23,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910006	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.09	3	38,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910006	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.10	3	54,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910006	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.11	3	9,8150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910006	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.12	3	25,5550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910006	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.13	3	41,2950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910006	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.14	3	57,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910006	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.15	3	12.2815	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910007	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.08	3	15,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910007	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.17	3	36.5057	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910007	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.09	3	31,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910007	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.10	3	47,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910007	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.11	3	2,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910007	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.12	3	18,2950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910007	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.13	3	34,0350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910007	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.14	3	50,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910007	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.15	3	5,0200	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910007	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.16	3	20.7636	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910008	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.09	3	24,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910008	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.18	3	44.9878	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910008	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.10	3	40,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910008	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.11	3	55,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910008	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.12	3	11,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910008	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.13	3	26,7750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910008	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.14	3	43,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910008	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.15	3	58,2600	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910008	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.16	3	13,5050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910008	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.17	3	29.2457	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910009	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.10	3	32,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910009	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.19	3	53.4699	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910009	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.11	3	48,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910009	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.12	3	3,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910009	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.13	3	19,5175	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910009	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.14	3	35,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910009	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.15	3	51,0000	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910009	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.16	3	6,2450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910009	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.17	3	21,9850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910009	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.18	3	37.7278	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910010	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.11	3	41,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910010	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.20	3	1.452	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910010	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.12	3	57,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910010	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.13	3	12,2575	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910010	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.14	3	27,9995	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910010	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.15	3	43,7400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910010	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.16	3	59,4850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910010	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.17	3	14,7250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910010	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.18	3	30,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910010	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.19	3	46.2099	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910011	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.12	3	49,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910011	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.21	3	9.9341	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910011	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.13	3	4,9975	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910011	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.14	3	20,7395	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910011	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.15	3	36,4815	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910011	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.16	3	52,2250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910011	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.17	3	7,4650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910011	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.18	3	23,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910011	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.19	3	39,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910011	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.20	3	54.692	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910012	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.13	3	58,2375	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910012	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.22	3	18.4162	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910012	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.14	3	13,4795	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910012	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.15	3	29,2215	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910012	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.16	3	44,9635	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910012	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.17	3	60,7050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910012	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.18	3	16,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910012	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.19	3	32,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910012	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.20	3	47,450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910012	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.21	3	2.6741	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910013	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.14	3	6,2195	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910013	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.23	3	26.8983	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910013	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.15	3	21,9615	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910013	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.16	3	37,7035	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910013	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.17	3	53,4455	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910013	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.18	3	9,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910013	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.19	3	24,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910013	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.20	3	40,150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910013	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.21	3	55,9150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910013	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.22	3	11.1562	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910014	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.15	3	14,7015	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910014	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.24	3	35.3804	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910014	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.16	3	30,4435	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910014	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.17	3	46,1855	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910014	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.18	3	1,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910014	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.19	3	17,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910014	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.20	3	32,900	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910014	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.21	3	48,6550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910014	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.22	3	3,8950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910014	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.23	3	19.6383	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910015	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.16	3	23,1835	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910015	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.25	3	43.8625	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910015	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.17	3	38,9255	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910015	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.18	3	54,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910015	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.19	3	9,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910015	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.20	3	25,650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910015	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.21	3	41,3950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910015	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.22	3	57,1350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910015	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.23	3	12,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910015	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.24	3	28.1204	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910016	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.17	3	31,6655	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910016	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.26	3	52.3446	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910016	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.18	3	47,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910016	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.19	3	2,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910016	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.20	3	18,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910016	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.21	3	34,1350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910016	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.22	3	49,8750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910016	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.23	3	5,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910016	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.24	3	20,8600	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910016	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.25	3	36.6025	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910017	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.18	3	40,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910017	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.27	3	60.8267	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910017	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.19	3	55,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910017	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.20	3	11,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910017	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.21	3	26,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910017	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.22	3	42,6150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910017	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.23	3	58,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910017	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.24	3	13,6000	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910017	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.25	3	29,3400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910017	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.26	3	45.0846	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910018	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.19	3	48,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910018	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.28	3	8.8088	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910018	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.20	3	3,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910018	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.21	3	19,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910018	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.22	3	35,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910018	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.23	3	51,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910018	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.24	3	6,3400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910018	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.25	3	22,0800	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910018	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.26	3	37,8250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910018	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.27	3	53.5667	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910019	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.20	3	57,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910019	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.29	3	17.2909	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910019	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.21	3	12,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910019	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.22	3	28,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910019	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.23	3	43,8385	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910019	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.24	3	59,5800	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910019	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.25	3	14,8200	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910019	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.26	3	30,5650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910019	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.27	3	46,3050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910019	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.28	3	1.5488	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910020	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.21	3	5,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910020	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.30	3	25.773	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910020	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.22	3	20,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910020	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.23	3	36,5785	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910020	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.24	3	52,3205	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910020	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.25	3	7,5600	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910020	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.26	3	23,3050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910020	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.27	3	39,0450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910020	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.28	3	55,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910020	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.29	3	10.0309	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910021	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.22	3	13,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910021	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.31	3	34.2551	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910021	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.23	3	29,3185	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910021	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.24	3	45,0605	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910021	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.25	3	60,8025	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910021	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.26	3	16,0450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910021	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.27	3	31,7850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910021	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.28	3	48,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910021	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.29	3	2,7700	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910021	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.30	3	18.513	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910022	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.23	3	22,0585	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910022	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.32	3	42.7372	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910022	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.24	3	37,8005	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910022	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.25	3	53,5425	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910022	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.26	3	8,7845	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910022	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.27	3	24,5250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910022	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.28	3	40,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910022	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.29	3	56,0100	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910022	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.30	3	11,250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910022	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.31	3	26.9951	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910023	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.24	3	30,5405	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910023	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.33	3	51.2193	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910023	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.25	3	46,2825	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910023	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.26	3	1,5245	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910023	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.27	3	17,2665	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910023	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.28	3	33,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910023	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.29	3	48,7500	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910023	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.30	3	4,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910023	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.31	3	19,7350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910023	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.32	3	35.4772	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910024	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.25	3	39,0225	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910024	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.34	3	59.7014	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910024	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.26	3	54,7645	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910024	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.27	3	10,0065	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910024	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.28	3	25,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910024	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.29	3	41,4900	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910024	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.30	3	57,250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910024	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.31	3	12,4750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910024	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.32	3	28,2150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910024	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.33	3	43.9593	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910025	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.26	3	47,5045	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910025	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.35	3	7.6835	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910025	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.27	3	2,7465	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910025	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.28	3	18,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910025	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.29	3	34,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910025	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.30	3	49,950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910025	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.31	3	5,2150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910025	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.32	3	20,9550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910025	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.33	3	37,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910025	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.34	3	52.4414	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910026	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.27	3	55,9865	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910026	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.36	3	16.1656	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910026	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.28	3	11,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910026	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.29	3	27,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910026	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.30	3	42,715	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910026	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.31	3	58,4550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910026	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.32	3	13,6950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910026	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.33	3	29,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910026	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.34	3	45,1800	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910026	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.35	3	60.9235	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910027	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.28	3	4,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910027	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.37	3	24.6477	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910027	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.29	3	19,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910027	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.30	3	35,455	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910027	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.31	3	51,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910027	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.32	3	6,4350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910027	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.33	3	22,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910027	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.34	3	37,9200	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910027	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.35	3	53,6650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910027	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.36	3	8.9056	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910028	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.29	3	12,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910028	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.38	3	33.1298	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910028	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.30	3	28,195	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910028	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.31	3	43,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910028	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.32	3	59,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910028	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.33	3	15,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910028	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.34	3	30,6600	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910028	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.35	3	46,4050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910028	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.36	3	1,6450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910028	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.37	3	17.3877	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910029	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.30	3	20,935	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910029	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.39	3	41.6119	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910029	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.31	3	36,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910029	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.32	3	52,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910029	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.33	3	7,6595	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910029	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.34	3	23,4000	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910029	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.35	3	39,1450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910029	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.36	3	54,8850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910029	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.37	3	10,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910029	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.38	3	25.8698	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910030	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.31	3	29,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910030	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.40	3	50.094	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910030	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.32	3	45,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910030	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.33	3	60,8995	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910030	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.34	3	16,1415	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910030	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.35	3	31,8850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910030	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.36	3	47,6250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910030	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.37	3	3,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910030	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.38	3	19,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910030	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.39	3	34.3519	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910031	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.32	3	37,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910031	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.41	3	58.5761	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910031	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.33	3	53,6395	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910031	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.34	3	8,8815	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910031	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.35	3	24,6235	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910031	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.36	3	40,3650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910031	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.37	3	56,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910031	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.38	3	11,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910031	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.39	3	27,0900	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910031	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.40	3	42.834	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910032	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.33	3	46,3795	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910032	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.42	3	6.5582	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910032	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.34	3	1,6215	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910032	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.35	3	17,3635	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910032	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.36	3	33,1055	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910032	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.37	3	49,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910032	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.38	3	4,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910032	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.39	3	19,8300	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910032	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.40	3	35,550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910032	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.41	3	51.3161	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910033	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.34	3	54,8615	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910033	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.43	3	15.0403	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910033	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.35	3	10,1035	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910033	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.36	3	25,8455	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910033	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.37	3	41,5875	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910033	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.38	3	57,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910033	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.39	3	12,5700	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910033	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.40	3	28,300	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910033	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.41	3	44,0550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910033	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.42	3	59.7982	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910034	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.35	3	2,8435	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910034	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.44	3	23.5224	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910034	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.36	3	18,5855	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910034	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.37	3	34,3275	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910034	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.38	3	50,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910034	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.39	3	5,3100	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910034	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.40	3	21,050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910034	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.41	3	36,7950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910034	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.42	3	53,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910034	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.43	3	7.7803	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910035	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.36	3	11,3255	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910035	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.45	3	32.0045	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910035	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.37	3	27,0675	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910035	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.38	3	42,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910035	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.39	3	58,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910035	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.40	3	14,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910035	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.41	3	29,5350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910035	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.42	3	45,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910035	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.43	3	61,0200	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910035	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.44	3	16.2624	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910036	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.37	3	19,8075	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910036	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.46	3	40.4866	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910036	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.38	3	35,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910036	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.39	3	51,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910036	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.40	3	6,535	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910036	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.41	3	22,2750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910036	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.42	3	38,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910036	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.43	3	53,7600	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910036	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.44	3	9,0000	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910036	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.45	3	24.7445	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910037	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.38	3	28,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910037	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.47	3	48.9687	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910037	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.39	3	44,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910037	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.40	3	59,775	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910037	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.41	3	15,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910037	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.42	3	31,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910037	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.43	3	46,5000	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910037	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.44	3	1,7400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910037	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.45	3	17,4850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910037	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.46	3	33.2266	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910038	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.39	3	36,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910038	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.48	3	57.4508	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910038	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.40	3	52,515	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910038	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.41	3	7,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910038	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.42	3	23,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910038	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.43	3	39,2400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910038	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.44	3	54,9800	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910038	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.45	3	10,2250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910038	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.46	3	25,9650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910038	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.47	3	41.7087	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910039	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.40	3	45,255	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910039	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.49	3	5.4329	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910039	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.41	3	61,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910039	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.42	3	16,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910039	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.43	3	31,9805	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910039	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.44	3	47,7200	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910039	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.45	3	2,9650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910039	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.46	3	18,7050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910039	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.47	3	34,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910039	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.48	3	50.1908	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910040	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.41	3	53,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910040	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.50	3	13.915	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910040	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.42	3	9,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910040	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.43	3	24,7205	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910040	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.44	3	40,4625	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910040	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.45	3	56,2050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910040	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.46	3	11,4450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910040	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.47	3	27,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910040	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.48	3	42,9300	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910040	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.49	3	58.6729	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910041	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.42	3	1,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910041	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.51	3	22.3971	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910041	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.43	3	17,4605	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910041	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.44	3	33,2025	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910041	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.45	3	48,9445	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910041	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.46	3	4,1850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910041	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.47	3	20,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910041	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.48	3	35,6700	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910041	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.49	3	51,4150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910041	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.50	3	6.655	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910042	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.43	3	10,2005	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910042	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.52	3	30.8792	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910042	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.44	3	25,9425	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910042	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.45	3	41,6845	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910042	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.46	3	57,4265	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910042	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.47	3	13,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910042	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.48	3	28,4100	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910042	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.49	3	44,1550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910042	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.50	3	60,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910042	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.51	3	15.1371	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910043	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.44	3	18,6825	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910043	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.53	3	39.3613	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910043	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.45	3	34,4245	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910043	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.46	3	50,1665	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910043	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.47	3	5,4085	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910043	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.48	3	21,1500	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910043	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.49	3	36,8950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910043	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.50	3	52,650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910043	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.51	3	7,8750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910043	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.52	3	23.6192	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910044	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.45	3	27,1645	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910044	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.54	3	47.8434	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910044	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.46	3	42,9065	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910044	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.47	3	58,6485	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910044	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.48	3	13,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910044	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.49	3	29,6350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910044	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.50	3	45,350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910044	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.51	3	61,1150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910044	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.52	3	16,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910044	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.53	3	32.1013	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910045	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.46	3	35,6465	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910045	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.55	3	56.3255	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910045	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.47	3	51,3885	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910045	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.48	3	6,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910045	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.49	3	22,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910045	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.50	3	38,100	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910045	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.51	3	53,8550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910045	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.52	3	9,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910045	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.53	3	24,8400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910045	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.54	3	40.5834	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910046	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.47	3	44,1285	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910046	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.56	3	4.3076	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910046	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.48	3	59,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910046	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.49	3	15,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910046	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.50	3	30,855	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910046	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.51	3	46,5950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910046	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.52	3	2,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910046	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.53	3	17,5800	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910046	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.54	3	33,3250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910046	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.55	3	49.0655	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910047	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.48	3	52,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910047	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.57	3	12.7897	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910047	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.49	3	7,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910047	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.50	3	23,595	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910047	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.51	3	39,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910047	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.52	3	55,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910047	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.53	3	10,3200	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910047	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.54	3	26,0650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910047	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.55	3	41,8050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910047	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.56	3	57.5476	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910048	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.49	3	61,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910048	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.58	3	21.2718	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910048	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.50	3	16,335	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910048	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.51	3	32,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910048	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.52	3	47,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910048	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.53	3	3,0600	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910048	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.54	3	18,8050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910048	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.55	3	34,5450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910048	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.56	3	50,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910048	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.57	3	5.5297	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910049	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.50	3	9,075	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910049	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.59	3	29.7539	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910049	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.51	3	24,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910049	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.52	3	40,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910049	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.53	3	56,3015	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910049	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.54	3	11,5450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910049	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.55	3	27,2850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910049	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.56	3	43,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910049	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.57	3	59,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910049	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.58	3	14.0118	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910050	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.51	3	17,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910050	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.60	3	38.236	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910050	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.52	3	33,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910050	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.53	3	49,0415	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910050	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.54	3	4,2835	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910050	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.55	3	20,0250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910050	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.56	3	36,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910050	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.57	3	52,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910050	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.58	3	6,7500	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910050	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.59	3	22.4939	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910051	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.52	3	26,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910051	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.61	3	46.7181	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910051	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.53	3	41,7815	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910051	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.54	3	57,5235	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910051	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.55	3	12,7655	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910051	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.56	3	29,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910051	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.57	3	44,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910051	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.58	3	59,9900	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910051	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.59	3	15,2350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910051	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.60	3	30.976	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910052	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.53	3	34,5215	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910052	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.62	3	55.2002	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910052	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.54	3	50,2635	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910052	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.55	3	5,5055	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910052	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.56	3	21,2475	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910052	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.57	3	37,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910052	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.58	3	52,7300	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910052	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.59	3	7,9750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910052	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.60	3	23,700	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910052	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.61	3	39.4581	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910053	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.54	3	43,0035	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910053	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.63	3	3.1823	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910053	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.55	3	58,7455	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910053	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.56	3	13,9875	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910053	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.57	3	29,7295	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910053	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.58	3	45,4700	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910053	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.59	3	61,2150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910053	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.60	3	16,450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910053	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.61	3	32,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910053	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.62	3	47.9402	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910054	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.55	3	51,4855	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910054	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.64	3	11.6644	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910054	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.56	3	6,7275	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910054	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.57	3	22,4695	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910054	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.58	3	38,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910054	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.59	3	53,9550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910054	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.60	3	9,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910054	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.61	3	25,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910054	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.62	3	40,6800	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910054	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.63	3	56.4223	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910055	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.56	3	59,9675	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910055	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.65	3	20.1465	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910055	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.57	3	15,2095	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910055	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.58	3	31,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910055	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.59	3	46,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910055	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.60	3	1,950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910055	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.61	3	18,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910055	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.62	3	33,4200	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910055	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.63	3	49,1600	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910055	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.64	3	4.4044	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910056	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.57	3	7,9495	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910056	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.66	3	28.6286	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910056	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.58	3	23,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910056	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.59	3	39,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910056	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.60	3	55,175	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910056	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.61	3	10,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910056	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.62	3	26,1600	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910056	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.63	3	41,9000	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910056	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.64	3	57,6450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910056	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.65	3	12.8865	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910057	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.58	3	16,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910057	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.67	3	37.1107	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910057	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.59	3	32,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910057	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.60	3	47,915	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910057	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.61	3	3,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910057	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.62	3	18,9000	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910057	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.63	3	34,6400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910057	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.64	3	50,3850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910057	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.65	3	5,6250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910057	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.66	3	21.3686	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910058	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.59	3	24,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910058	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.68	3	45.5928	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910058	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.60	3	40,655	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910058	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.61	3	56,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910058	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.62	3	11,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910058	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.63	3	27,3800	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910058	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.64	3	43,1250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910058	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.65	3	58,8650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910058	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.66	3	14,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910058	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.67	3	29.8507	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910059	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.60	3	33,395	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910059	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.69	3	54.0749	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910059	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.61	3	49,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910059	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.62	3	4,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910059	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.63	3	20,1225	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910059	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.64	3	35,8650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910059	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.65	3	51,6050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910059	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.66	3	7,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910059	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.67	3	22,5900	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910059	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.68	3	38.3328	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910060	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.61	3	41,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910060	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.70	3	2.057	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910060	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.62	3	57,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910060	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.63	3	12,8625	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910060	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.64	3	28,6045	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910060	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.65	3	44,3450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910060	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.66	3	60,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910060	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.67	3	15,3300	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910060	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.68	3	31,0750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910060	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.69	3	46.8149	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910061	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.62	3	50,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910061	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.71	3	10.5391	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910061	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.63	3	5,6025	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910061	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.64	3	21,3445	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910061	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.65	3	37,0865	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910061	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.66	3	53,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910061	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.67	3	8,0700	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910061	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.68	3	23,8150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910061	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.69	3	39,5550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910061	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.70	3	55.297	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910062	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.63	3	58,8425	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910062	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.72	3	19.0212	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910062	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.64	3	14,0845	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910062	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.65	3	29,8265	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910062	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.66	3	45,5685	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910062	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.67	3	61,3100	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910062	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.68	3	16,5550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910062	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.69	3	32,2950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910062	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.70	3	48,050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910062	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.71	3	3.2791	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910063	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.64	3	6,8245	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910063	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.73	3	27.5033	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910063	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.65	3	22,5665	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910063	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.66	3	38,3085	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910063	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.67	3	54,0505	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910063	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.68	3	9,2950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910063	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.69	3	25,0350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910063	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.70	3	41,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910063	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.71	3	57,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910063	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.72	3	11.7612	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910064	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.65	3	15,3065	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910064	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.74	3	35.9854	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910064	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.66	3	31,0485	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910064	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.67	3	46,7905	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910064	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.68	3	2,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910064	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.69	3	17,7750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910064	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.70	3	33,500	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910064	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.71	3	49,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910064	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.72	3	4,5000	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910064	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.73	3	20.2433	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910065	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.66	3	23,7885	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910065	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.75	3	44.4675	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910065	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.67	3	39,5305	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910065	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.68	3	55,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910065	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.69	3	10,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910065	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.70	3	26,250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910065	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.71	3	42,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910065	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.72	3	57,7400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910065	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.73	3	12,9850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910065	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.74	3	28.7254	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910066	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.67	3	32,2705	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910066	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.76	3	52.9496	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910066	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.68	3	48,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910066	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.69	3	3,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910066	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.70	3	18,995	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910066	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.71	3	35,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910066	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.72	3	50,4800	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910066	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.73	3	5,7250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910066	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.74	3	21,4650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910066	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.75	3	37.2075	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910067	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.68	3	40,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910067	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.77	3	61.4317	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910067	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.69	3	56,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910067	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.70	3	11,735	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910067	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.71	3	27,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910067	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.72	3	43,2200	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910067	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.73	3	58,9650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910067	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.74	3	14,2050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910067	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.75	3	29,9450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910067	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.76	3	45.6896	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910068	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.69	3	49,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910068	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.78	3	9.4138	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910068	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.70	3	4,475	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910068	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.71	3	20,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910068	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.72	3	36,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910068	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.73	3	51,7050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910068	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.74	3	6,9450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910068	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.75	3	22,6850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910068	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.76	3	38,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910068	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.77	3	54.1717	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910069	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.70	3	57,715	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910069	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.79	3	17.8959	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910069	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.71	3	13,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910069	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.72	3	28,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910069	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.73	3	44,4435	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910069	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.74	3	60,1850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910069	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.75	3	15,4250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910069	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.76	3	31,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910069	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.77	3	46,9100	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910069	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.78	3	2.1538	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910070	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.71	3	5,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910070	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.80	3	26.378	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910070	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.72	3	21,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910070	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.73	3	37,1835	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910070	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.74	3	52,9255	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910070	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.75	3	8,1650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910070	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.76	3	24,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910070	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.77	3	39,6500	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910070	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.78	3	55,3950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910070	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.79	3	10.6359	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910071	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.72	3	14,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910071	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.81	3	34.8601	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910071	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.73	3	29,9235	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910071	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.74	3	45,6655	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910071	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.75	3	61,4075	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910071	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.76	3	17,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910071	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.77	3	32,3900	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910071	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.78	3	48,1350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910071	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.79	3	3,3750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910071	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.80	3	19.118	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910072	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.73	3	22,6635	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910072	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.82	3	43.3422	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910072	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.74	3	38,4055	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910072	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.75	3	54,1475	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910072	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.76	3	9,3895	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910072	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.77	3	25,1300	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910072	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.78	3	40,8750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910072	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.79	3	56,6150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910072	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.80	3	11,850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910072	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.81	3	27.6001	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910073	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.74	3	31,1455	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910073	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.83	3	51.8243	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910073	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.75	3	46,8875	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910073	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.76	3	2,1295	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910073	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.77	3	17,8715	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910073	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.78	3	33,6150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910073	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.79	3	49,3550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910073	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.80	3	5,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910073	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.81	3	20,3400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910073	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.82	3	36.0822	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910074	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.75	3	39,6275	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910074	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.84	3	60.3064	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910074	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.76	3	55,3695	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910074	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.77	3	10,6115	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910074	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.78	3	26,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910074	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.79	3	42,0950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910074	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.80	3	57,850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910074	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.81	3	13,0800	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910074	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.82	3	28,8200	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910074	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.83	3	44.5643	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910075	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.76	3	48,1095	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910075	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.85	3	8.2885	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910075	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.77	3	3,3515	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910075	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.78	3	19,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910075	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.79	3	34,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910075	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.80	3	51,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910075	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.81	3	5,8200	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910075	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.82	3	21,5600	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910075	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.83	3	37,3050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910075	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.84	3	53.0464	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910076	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.77	3	56,5915	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910076	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.86	3	16.7706	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910076	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.78	3	11,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910076	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.79	3	27,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910076	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.80	3	43,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910076	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.81	3	59,0600	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910076	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.82	3	14,3000	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910076	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.83	3	30,0450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910076	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.84	3	45,7850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910076	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.85	3	61.5285	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910077	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.78	3	4,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910077	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.87	3	25.2527	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910077	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.79	3	20,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910077	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.80	3	36,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910077	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.81	3	51,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910077	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.82	3	7,0400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910077	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.83	3	22,7850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910077	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.84	3	38,5250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910077	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.85	3	54,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910077	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.86	3	9.5106	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910078	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.79	3	13,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910078	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.88	3	33.7348	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910078	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.80	3	28,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910078	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.81	3	44,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910078	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.82	3	60,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910078	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.83	3	15,5250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910078	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.84	3	31,2650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910078	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.85	3	47,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910078	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.86	3	2,2500	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910078	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.87	3	17.9927	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910079	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.80	3	21,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910079	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.89	3	42.2169	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910079	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.81	3	37,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910079	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.82	3	53,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910079	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.83	3	8,2645	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910079	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.84	3	24,0050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910079	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.85	3	40,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910079	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.86	3	55,4900	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910079	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.87	3	10,7350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910079	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.88	3	26.4748	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910080	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.81	3	30,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910080	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.90	3	50.699	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910080	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.82	3	45,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910080	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.83	3	61,5045	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910080	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.84	3	16,7465	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910080	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.85	3	32,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910080	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.86	3	48,2300	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910080	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.87	3	3,4750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910080	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.88	3	19,2150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910080	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.89	3	34.9569	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910081	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.82	3	38,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910081	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.91	3	59.1811	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910081	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.83	3	54,2445	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910081	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.84	3	9,4865	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910081	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.85	3	25,2285	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910081	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.86	3	40,9700	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910081	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.87	3	56,7150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910081	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.88	3	11,9550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910081	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.89	3	27,6950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910081	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.90	3	43.439	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910082	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.83	3	46,9845	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910082	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.92	3	7.1632	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910082	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.84	3	2,2265	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910082	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.85	3	17,9685	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910082	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.86	3	33,7105	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910082	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.87	3	49,4550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910082	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.88	3	4,6950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910082	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.89	3	20,4350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910082	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.90	3	36,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910082	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.91	3	51.9211	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910083	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.84	3	55,4665	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910083	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.93	3	15.6453	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910083	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.85	3	10,7085	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910083	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.86	3	26,4505	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910083	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.87	3	42,1925	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910083	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.88	3	57,9350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910083	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.89	3	13,1750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910083	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.90	3	28,900	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910083	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.91	3	44,6600	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910083	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.92	3	60.4032	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910084	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.85	3	3,4485	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910084	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.94	3	24.1274	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910084	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.86	3	19,1905	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910084	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.87	3	34,9325	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910084	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.88	3	50,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910084	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.89	3	5,9150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910084	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.90	3	21,650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910084	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.91	3	37,4000	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910084	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.92	3	53,1450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910084	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.93	3	8.3853	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910085	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.86	3	11,9305	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910085	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.95	3	32.6095	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910085	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.87	3	27,6725	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910085	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.88	3	43,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910085	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.89	3	59,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910085	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.90	3	14,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910085	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.91	3	30,1400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910085	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.92	3	45,8850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910085	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.93	3	61,6250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910085	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.94	3	16.8674	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910086	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.87	3	20,4125	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910086	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.96	3	41.0916	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910086	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.88	3	36,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910086	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.89	3	51,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910086	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.90	3	7,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910086	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.91	3	22,8800	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910086	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.92	3	38,6250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910086	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.93	3	54,3650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910086	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.94	3	9,6050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910086	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.95	3	25.3495	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910087	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.88	3	28,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910087	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.97	3	49.5737	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910087	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.89	3	44,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910087	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.90	3	60,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910087	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.91	3	15,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910087	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.92	3	31,3650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910087	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.93	3	47,1050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910087	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.94	3	2,3450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910087	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.95	3	18,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910087	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.96	3	33.8316	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910088	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.89	3	37,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910088	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.98	3	58.0558	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910088	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.90	3	53,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910088	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.91	3	8,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910088	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.92	3	24,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910088	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.93	3	39,8450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910088	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.94	3	55,5850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910088	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.95	3	11,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910088	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.96	3	26,5700	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910088	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.97	3	42.3137	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910089	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.90	3	45,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910089	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.99	3	6.0379	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910089	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.91	3	61,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910089	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.92	3	16,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910089	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.93	3	32,5855	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910089	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.94	3	48,3250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910089	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.95	3	4,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910089	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.96	3	19,3100	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910089	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.97	3	35,0550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910089	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.98	3	50.7958	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910090	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.91	3	54,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910090	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.00	3	13.31	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910090	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.92	3	9,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910090	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.93	3	25,3255	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910090	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.94	3	41,0675	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910090	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.95	3	57,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910090	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.96	3	12,0500	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910090	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.97	3	27,7950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910090	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.98	3	43,5350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910090	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.99	3	59.2779	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910091	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.92	3	2,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910091	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.01	3	21.7921	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910091	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.93	3	18,0655	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910091	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.94	3	33,8075	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910091	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.95	3	49,5495	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910091	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.96	3	4,7900	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910091	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.97	3	20,5350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910091	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.98	3	36,2750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910091	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.99	3	52,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910091	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.00	3	6.05	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910092	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.93	3	10,8055	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910092	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.02	3	30.2742	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910092	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.94	3	26,5475	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910092	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.95	3	42,2895	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910092	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.96	3	58,0315	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910092	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.97	3	13,2750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910092	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.98	3	29,0150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910092	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.99	3	45,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910092	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.00	3	59,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910092	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.01	3	14.5321	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910093	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.94	3	19,2875	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910093	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.03	3	38.7563	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910093	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.95	3	35,0295	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910093	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.96	3	50,7715	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910093	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.97	3	6,0135	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910093	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.98	3	21,7550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910093	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.99	3	37,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910093	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.00	3	52,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910093	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.01	3	7,2700	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910093	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.02	3	23.0142	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910094	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.95	3	27,7695	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910094	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.04	3	47.2384	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910094	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.96	3	43,5115	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910094	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.97	3	59,2535	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910094	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.98	3	14,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910094	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.99	3	30,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910094	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.00	3	45,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910094	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.01	3	60,5100	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910094	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.02	3	15,7550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910094	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.03	3	31.4963	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910095	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.96	3	36,2515	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910095	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.05	3	55.7205	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910095	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.97	3	51,9935	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910095	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.98	3	7,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910095	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.99	3	23,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910095	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.00	3	37,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910095	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.01	3	53,2500	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910095	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.02	3	8,4950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910095	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.03	3	24,2350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910095	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.04	3	39.9784	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910096	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.97	3	44,7335	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910096	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.06	3	3.7026	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910096	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.98	3	60,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910096	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.99	3	15,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910096	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.00	3	30,25	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910096	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.01	3	45,9900	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910096	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.02	3	1,2350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910096	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.03	3	16,9750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910096	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.04	3	33,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910096	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.05	3	48.4605	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910097	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.98	3	53,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910097	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.07	3	12.1847	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910097	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.99	3	8,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910097	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.00	3	23,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910097	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.01	3	38,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910097	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.02	3	54,4750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910097	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.03	3	9,7150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910097	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.04	3	25,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910097	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.05	3	41,2000	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910097	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.06	3	56.9426	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910098	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.99	3	61,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910098	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.08	3	20.6668	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910098	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.00	3	15,75	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910098	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.01	3	31,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910098	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.02	3	47,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910098	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.03	3	2,4550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910098	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.04	3	18,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910098	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.05	3	33,9400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910098	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.06	3	49,6850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910098	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.07	3	4.9247	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910099	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.00	3	8,45	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910099	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.09	3	29.1489	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910099	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.01	3	24,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910099	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.02	3	40,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910099	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.03	3	55,6965	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910099	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.04	3	11,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910099	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.05	3	26,6800	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910099	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.06	3	42,4250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910099	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.07	3	58,1650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910099	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.08	3	13.4068	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910100	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.01	3	17,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910100	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.10	3	37.631	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910100	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.02	3	32,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910100	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.03	3	48,4365	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910100	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.04	3	3,6785	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910100	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.05	3	19,4200	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910100	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.06	3	35,1650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910100	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.07	3	50,9050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910100	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.08	3	6,1450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910100	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.09	3	21.8889	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910101	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.02	3	25,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910101	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.11	3	46.1131	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910101	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.03	3	41,1765	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910101	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.04	3	56,9185	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910101	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.05	3	12,1605	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910101	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.06	3	27,9050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910101	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.07	3	43,6450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910101	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.08	3	59,3850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910101	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.09	3	15,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910101	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.10	3	30.371	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910102	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.03	3	33,9165	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910102	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.12	3	54.5952	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910102	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.04	3	49,6585	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910102	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.05	3	4,9005	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910102	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.06	3	20,6425	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910102	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.07	3	36,3850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910102	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.08	3	52,1250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910102	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.09	3	7,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910102	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.10	3	23,100	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910102	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.11	3	38.8531	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910103	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.04	3	42,3985	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910103	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.13	3	2.5773	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910103	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.05	3	58,1405	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910103	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.06	3	13,3825	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910103	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.07	3	29,1245	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910103	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.08	3	44,8650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910103	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.09	3	61,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910103	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.10	3	15,850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910103	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.11	3	31,5950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910103	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.12	3	47.3352	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910104	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.05	3	50,8805	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910104	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.14	3	11.0594	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910104	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.06	3	6,1225	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910104	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.07	3	21,8645	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910104	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.08	3	37,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910104	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.09	3	53,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910104	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.10	3	9,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910104	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.11	3	24,3350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910104	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.12	3	40,0750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910104	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.13	3	55.8173	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910105	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.06	3	59,3625	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910105	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.15	3	19.5415	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910105	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.07	3	14,6045	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910105	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.08	3	30,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910105	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.09	3	46,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910105	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.10	3	1,350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910105	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.11	3	17,0750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910105	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.12	3	32,8150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910105	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.13	3	48,5550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910105	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.14	3	3.7994	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910106	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.07	3	7,3445	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910106	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.16	3	28.0236	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910106	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.08	3	23,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910106	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.09	3	38,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910106	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.10	3	54,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910106	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.11	3	9,8150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910106	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.12	3	25,5550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910106	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.13	3	41,2950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910106	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.14	3	57,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910106	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.15	3	12.2815	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910107	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.08	3	15,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910107	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.17	3	36.5057	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910107	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.09	3	31,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910107	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.10	3	47,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910107	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.11	3	2,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910107	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.12	3	18,2950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910107	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.13	3	34,0350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910107	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.14	3	50,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910107	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.15	3	5,0200	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910107	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.16	3	20.7636	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910108	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.09	3	24,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910108	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.18	3	44.9878	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910108	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.10	3	40,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910108	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.11	3	55,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910108	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.12	3	11,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910108	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.13	3	26,7750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910108	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.14	3	43,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910108	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.15	3	58,2600	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910108	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.16	3	13,5050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910108	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.17	3	29.2457	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910109	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.10	3	32,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910109	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.19	3	53.4699	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910109	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.11	3	48,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910109	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.12	3	3,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910109	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.13	3	19,5175	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910109	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.14	3	35,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910109	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.15	3	51,0000	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910109	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.16	3	6,2450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910109	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.17	3	21,9850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910109	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.18	3	37.7278	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910110	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.11	3	41,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910110	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.20	3	1.452	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910110	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.12	3	57,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910110	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.13	3	12,2575	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910110	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.14	3	27,9995	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910110	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.15	3	43,7400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910110	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.16	3	59,4850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910110	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.17	3	14,7250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910110	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.18	3	30,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910110	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.19	3	46.2099	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910111	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.12	3	49,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910111	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.21	3	9.9341	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910111	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.13	3	4,9975	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910111	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.14	3	20,7395	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910111	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.15	3	36,4815	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910111	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.16	3	52,2250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910111	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.17	3	7,4650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910111	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.18	3	23,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910111	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.19	3	39,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910111	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.20	3	54.692	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910112	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.13	3	58,2375	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910112	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.22	3	18.4162	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910112	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.14	3	13,4795	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910112	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.15	3	29,2215	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910112	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.16	3	44,9635	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910112	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.17	3	60,7050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910112	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.18	3	16,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910112	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.19	3	32,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910112	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.20	3	47,450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910112	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.21	3	2.6741	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910113	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.14	3	6,2195	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910113	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.23	3	26.8983	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910113	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.15	3	21,9615	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910113	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.16	3	37,7035	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910113	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.17	3	53,4455	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910113	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.18	3	9,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910113	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.19	3	24,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910113	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.20	3	40,150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910113	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.21	3	55,9150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910113	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.22	3	11.1562	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910114	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.15	3	14,7015	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910114	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.24	3	35.3804	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910114	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.16	3	30,4435	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910114	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.17	3	46,1855	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910114	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.18	3	1,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910114	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.19	3	17,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910114	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.20	3	32,900	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910114	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.21	3	48,6550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910114	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.22	3	3,8950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910114	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.23	3	19.6383	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910115	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.16	3	23,1835	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910115	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.25	3	43.8625	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910115	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.17	3	38,9255	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910115	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.18	3	54,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910115	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.19	3	9,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910115	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.20	3	25,650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910115	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.21	3	41,3950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910115	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.22	3	57,1350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910115	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.23	3	12,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910115	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.24	3	28.1204	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910116	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.17	3	31,6655	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910116	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.26	3	52.3446	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910116	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.18	3	47,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910116	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.19	3	2,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910116	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.20	3	18,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910116	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.21	3	34,1350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910116	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.22	3	49,8750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910116	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.23	3	5,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910116	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.24	3	20,8600	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910116	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.25	3	36.6025	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910117	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.18	3	40,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910117	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.27	3	60.8267	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910117	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.19	3	55,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910117	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.20	3	11,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910117	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.21	3	26,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910117	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.22	3	42,6150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910117	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.23	3	58,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910117	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.24	3	13,6000	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910117	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.25	3	29,3400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910117	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.26	3	45.0846	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910118	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.19	3	48,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910118	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.28	3	8.8088	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910118	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.20	3	3,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910118	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.21	3	19,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910118	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.22	3	35,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910118	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.23	3	51,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910118	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.24	3	6,3400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910118	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.25	3	22,0800	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910118	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.26	3	37,8250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910118	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.27	3	53.5667	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910119	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.20	3	57,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910119	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.29	3	17.2909	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910119	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.21	3	12,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910119	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.22	3	28,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910119	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.23	3	43,8385	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910119	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.24	3	59,5800	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910119	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.25	3	14,8200	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910119	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.26	3	30,5650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910119	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.27	3	46,3050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910119	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.28	3	1.5488	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910120	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.21	3	5,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910120	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.30	3	25.773	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910120	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.22	3	20,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910120	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.23	3	36,5785	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910120	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.24	3	52,3205	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910120	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.25	3	7,5600	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910120	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.26	3	23,3050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910120	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.27	3	39,0450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910120	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.28	3	55,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910120	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.29	3	10.0309	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910121	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.22	3	13,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910121	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.31	3	34.2551	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910121	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.23	3	29,3185	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910121	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.24	3	45,0605	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910121	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.25	3	60,8025	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910121	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.26	3	16,0450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910121	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.27	3	31,7850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910121	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.28	3	48,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910121	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.29	3	2,7700	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910121	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.30	3	18.513	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910122	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.23	3	22,0585	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910122	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.32	3	42.7372	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910122	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.24	3	37,8005	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910122	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.25	3	53,5425	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910122	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.26	3	8,7845	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910122	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.27	3	24,5250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910122	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.28	3	40,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910122	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.29	3	56,0100	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910122	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.30	3	11,250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910122	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.31	3	26.9951	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910123	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.24	3	30,5405	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910123	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.33	3	51.2193	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910123	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.25	3	46,2825	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910123	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.26	3	1,5245	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910123	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.27	3	17,2665	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910123	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.28	3	33,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910123	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.29	3	48,7500	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910123	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.30	3	4,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910123	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.31	3	19,7350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910123	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.32	3	35.4772	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910124	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.25	3	39,0225	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910124	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.34	3	59.7014	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910124	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.26	3	54,7645	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910124	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.27	3	10,0065	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910124	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.28	3	25,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910124	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.29	3	41,4900	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910124	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.30	3	57,250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910124	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.31	3	12,4750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910124	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.32	3	28,2150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910124	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.33	3	43.9593	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910125	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.26	3	47,5045	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910125	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.35	3	7.6835	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910125	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.27	3	2,7465	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910125	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.28	3	18,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910125	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.29	3	34,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910125	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.30	3	49,950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910125	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.31	3	5,2150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910125	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.32	3	20,9550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910125	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.33	3	37,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910125	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.34	3	52.4414	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910126	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.27	3	55,9865	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910126	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.36	3	16.1656	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910126	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.28	3	11,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910126	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.29	3	27,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910126	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.30	3	42,715	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910126	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.31	3	58,4550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910126	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.32	3	13,6950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910126	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.33	3	29,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910126	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.34	3	45,1800	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910126	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.35	3	60.9235	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910127	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.28	3	4,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910127	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.37	3	24.6477	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910127	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.29	3	19,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910127	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.30	3	35,455	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910127	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.31	3	51,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910127	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.32	3	6,4350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910127	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.33	3	22,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910127	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.34	3	37,9200	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910127	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.35	3	53,6650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910127	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.36	3	8.9056	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910128	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.29	3	12,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910128	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.38	3	33.1298	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910128	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.30	3	28,195	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910128	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.31	3	43,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910128	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.32	3	59,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910128	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.33	3	15,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910128	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.34	3	30,6600	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910128	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.35	3	46,4050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910128	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.36	3	1,6450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910128	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.37	3	17.3877	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910129	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.30	3	20,935	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910129	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.39	3	41.6119	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910129	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.31	3	36,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910129	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.32	3	52,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910129	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.33	3	7,6595	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910129	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.34	3	23,4000	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910129	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.35	3	39,1450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910129	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.36	3	54,8850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910129	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.37	3	10,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910129	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.38	3	25.8698	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910130	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.31	3	29,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910130	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.40	3	50.094	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910130	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.32	3	45,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910130	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.33	3	60,8995	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910130	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.34	3	16,1415	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910130	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.35	3	31,8850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910130	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.36	3	47,6250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910130	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.37	3	3,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910130	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.38	3	19,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910130	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.39	3	34.3519	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910131	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.32	3	37,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910131	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.41	3	58.5761	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910131	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.33	3	53,6395	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910131	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.34	3	8,8815	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910131	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.35	3	24,6235	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910131	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.36	3	40,3650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910131	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.37	3	56,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910131	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.38	3	11,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910131	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.39	3	27,0900	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910131	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.40	3	42.834	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910132	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.33	3	46,3795	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910132	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.42	3	6.5582	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910132	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.34	3	1,6215	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910132	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.35	3	17,3635	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910132	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.36	3	33,1055	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910132	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.37	3	49,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910132	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.38	3	4,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910132	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.39	3	19,8300	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910132	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.40	3	35,550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910132	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.41	3	51.3161	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910133	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.34	3	54,8615	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910133	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.43	3	15.0403	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910133	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.35	3	10,1035	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910133	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.36	3	25,8455	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910133	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.37	3	41,5875	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910133	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.38	3	57,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910133	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.39	3	12,5700	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910133	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.40	3	28,300	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910133	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.41	3	44,0550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910133	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.42	3	59.7982	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910134	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.35	3	2,8435	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910134	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.44	3	23.5224	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910134	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.36	3	18,5855	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910134	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.37	3	34,3275	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910134	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.38	3	50,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910134	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.39	3	5,3100	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910134	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.40	3	21,050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910134	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.41	3	36,7950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910134	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.42	3	53,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910134	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.43	3	7.7803	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910135	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.36	3	11,3255	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910135	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.45	3	32.0045	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910135	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.37	3	27,0675	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910135	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.38	3	42,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910135	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.39	3	58,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910135	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.40	3	14,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910135	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.41	3	29,5350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910135	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.42	3	45,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910135	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.43	3	61,0200	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910135	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.44	3	16.2624	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910136	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.37	3	19,8075	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910136	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.46	3	40.4866	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910136	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.38	3	35,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910136	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.39	3	51,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910136	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.40	3	6,535	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910136	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.41	3	22,2750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910136	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.42	3	38,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910136	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.43	3	53,7600	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910136	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.44	3	9,0000	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910136	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.45	3	24.7445	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910137	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.38	3	28,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910137	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.47	3	48.9687	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910137	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.39	3	44,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910137	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.40	3	59,775	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910137	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.41	3	15,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910137	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.42	3	31,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910137	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.43	3	46,5000	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910137	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.44	3	1,7400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910137	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.45	3	17,4850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910137	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.46	3	33.2266	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910138	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.39	3	36,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910138	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.48	3	57.4508	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910138	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.40	3	52,515	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910138	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.41	3	7,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910138	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.42	3	23,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910138	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.43	3	39,2400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910138	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.44	3	54,9800	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910138	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.45	3	10,2250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910138	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.46	3	25,9650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910138	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.47	3	41.7087	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910139	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.40	3	45,255	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910139	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.49	3	5.4329	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910139	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.41	3	61,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910139	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.42	3	16,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910139	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.43	3	31,9805	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910139	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.44	3	47,7200	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910139	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.45	3	2,9650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910139	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.46	3	18,7050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910139	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.47	3	34,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910139	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.48	3	50.1908	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910140	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.41	3	53,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910140	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.50	3	13.915	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910140	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.42	3	9,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910140	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.43	3	24,7205	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910140	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.44	3	40,4625	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910140	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.45	3	56,2050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910140	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.46	3	11,4450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910140	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.47	3	27,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910140	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.48	3	42,9300	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910140	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.49	3	58.6729	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910141	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.42	3	1,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910141	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.51	3	22.3971	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910141	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.43	3	17,4605	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910141	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.44	3	33,2025	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910141	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.45	3	48,9445	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910141	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.46	3	4,1850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910141	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.47	3	20,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910141	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.48	3	35,6700	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910141	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.49	3	51,4150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910141	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.50	3	6.655	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910142	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.43	3	10,2005	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910142	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.52	3	30.8792	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910142	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.44	3	25,9425	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910142	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.45	3	41,6845	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910142	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.46	3	57,4265	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910142	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.47	3	13,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910142	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.48	3	28,4100	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910142	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.49	3	44,1550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910142	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.50	3	60,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910142	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.51	3	15.1371	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910143	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.44	3	18,6825	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910143	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.53	3	39.3613	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910143	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.45	3	34,4245	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910143	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.46	3	50,1665	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910143	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.47	3	5,4085	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910143	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.48	3	21,1500	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910143	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.49	3	36,8950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910143	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.50	3	52,650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910143	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.51	3	7,8750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910143	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.52	3	23.6192	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910144	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.45	3	27,1645	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910144	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.54	3	47.8434	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910144	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.46	3	42,9065	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910144	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.47	3	58,6485	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910144	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.48	3	13,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910144	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.49	3	29,6350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910144	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.50	3	45,350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910144	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.51	3	61,1150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910144	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.52	3	16,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910144	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.53	3	32.1013	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910145	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.46	3	35,6465	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910145	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.55	3	56.3255	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910145	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.47	3	51,3885	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910145	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.48	3	6,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910145	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.49	3	22,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910145	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.50	3	38,100	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910145	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.51	3	53,8550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910145	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.52	3	9,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910145	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.53	3	24,8400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910145	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.54	3	40.5834	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910146	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.47	3	44,1285	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910146	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.56	3	4.3076	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910146	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.48	3	59,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910146	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.49	3	15,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910146	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.50	3	30,855	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910146	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.51	3	46,5950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910146	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.52	3	2,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910146	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.53	3	17,5800	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910146	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.54	3	33,3250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910146	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.55	3	49.0655	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910147	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.48	3	52,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910147	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.57	3	12.7897	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910147	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.49	3	7,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910147	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.50	3	23,595	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910147	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.51	3	39,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910147	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.52	3	55,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910147	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.53	3	10,3200	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910147	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.54	3	26,0650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910147	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.55	3	41,8050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910147	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.56	3	57.5476	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910148	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.49	3	61,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910148	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.58	3	21.2718	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910148	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.50	3	16,335	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910148	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.51	3	32,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910148	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.52	3	47,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910148	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.53	3	3,0600	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910148	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.54	3	18,8050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910148	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.55	3	34,5450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910148	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.56	3	50,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910148	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.57	3	5.5297	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910149	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.50	3	9,075	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910149	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.59	3	29.7539	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910149	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.51	3	24,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910149	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.52	3	40,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910149	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.53	3	56,3015	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910149	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.54	3	11,5450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910149	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.55	3	27,2850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910149	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.56	3	43,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910149	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.57	3	59,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910149	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.58	3	14.0118	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910150	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.51	3	17,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910150	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.60	3	38.236	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910150	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.52	3	33,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910150	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.53	3	49,0415	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910150	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.54	3	4,2835	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910150	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.55	3	20,0250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910150	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.56	3	36,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910150	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.57	3	52,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910150	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.58	3	6,7500	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910150	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.59	3	22.4939	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910151	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.52	3	26,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910151	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.61	3	46.7181	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910151	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.53	3	41,7815	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910151	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.54	3	57,5235	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910151	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.55	3	12,7655	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910151	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.56	3	29,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910151	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.57	3	44,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910151	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.58	3	59,9900	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910151	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.59	3	15,2350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910151	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.60	3	30.976	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910152	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.53	3	34,5215	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910152	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.62	3	55.2002	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910152	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.54	3	50,2635	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910152	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.55	3	5,5055	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910152	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.56	3	21,2475	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910152	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.57	3	37,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910152	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.58	3	52,7300	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910152	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.59	3	7,9750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910152	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.60	3	23,700	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910152	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.61	3	39.4581	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910153	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.54	3	43,0035	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910153	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.63	3	3.1823	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910153	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.55	3	58,7455	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910153	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.56	3	13,9875	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910153	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.57	3	29,7295	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910153	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.58	3	45,4700	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910153	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.59	3	61,2150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910153	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.60	3	16,450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910153	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.61	3	32,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910153	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.62	3	47.9402	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910154	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.55	3	51,4855	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910154	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.64	3	11.6644	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910154	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.56	3	6,7275	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910154	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.57	3	22,4695	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910154	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.58	3	38,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910154	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.59	3	53,9550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910154	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.60	3	9,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910154	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.61	3	25,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910154	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.62	3	40,6800	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910154	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.63	3	56.4223	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910155	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.56	3	59,9675	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910155	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.65	3	20.1465	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910155	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.57	3	15,2095	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910155	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.58	3	31,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910155	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.59	3	46,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910155	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.60	3	1,950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910155	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.61	3	18,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910155	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.62	3	33,4200	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910155	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.63	3	49,1600	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910155	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.64	3	4.4044	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910156	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.57	3	7,9495	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910156	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.66	3	28.6286	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910156	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.58	3	23,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910156	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.59	3	39,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910156	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.60	3	55,175	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910156	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.61	3	10,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910156	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.62	3	26,1600	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910156	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.63	3	41,9000	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910156	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.64	3	57,6450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910156	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.65	3	12.8865	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910157	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.58	3	16,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910157	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.67	3	37.1107	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910157	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.59	3	32,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910157	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.60	3	47,915	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910157	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.61	3	3,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910157	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.62	3	18,9000	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910157	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.63	3	34,6400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910157	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.64	3	50,3850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910157	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.65	3	5,6250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910157	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.66	3	21.3686	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910158	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.59	3	24,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910158	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.68	3	45.5928	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910158	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.60	3	40,655	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910158	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.61	3	56,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910158	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.62	3	11,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910158	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.63	3	27,3800	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910158	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.64	3	43,1250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910158	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.65	3	58,8650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910158	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.66	3	14,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910158	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.67	3	29.8507	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910159	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.60	3	33,395	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910159	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.69	3	54.0749	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910159	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.61	3	49,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910159	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.62	3	4,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910159	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.63	3	20,1225	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910159	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.64	3	35,8650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910159	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.65	3	51,6050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910159	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.66	3	7,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910159	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.67	3	22,5900	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910159	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.68	3	38.3328	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910160	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.61	3	41,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910160	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.70	3	2.057	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910160	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.62	3	57,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910160	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.63	3	12,8625	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910160	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.64	3	28,6045	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910160	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.65	3	44,3450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910160	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.66	3	60,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910160	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.67	3	15,3300	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910160	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.68	3	31,0750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910160	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.69	3	46.8149	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910161	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.62	3	50,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910161	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.71	3	10.5391	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910161	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.63	3	5,6025	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910161	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.64	3	21,3445	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910161	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.65	3	37,0865	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910161	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.66	3	53,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910161	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.67	3	8,0700	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910161	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.68	3	23,8150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910161	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.69	3	39,5550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910161	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.70	3	55.297	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910162	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.63	3	58,8425	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910162	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.72	3	19.0212	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910162	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.64	3	14,0845	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910162	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.65	3	29,8265	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910162	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.66	3	45,5685	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910162	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.67	3	61,3100	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910162	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.68	3	16,5550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910162	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.69	3	32,2950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910162	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.70	3	48,050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910162	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.71	3	3.2791	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910163	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.64	3	6,8245	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910163	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.73	3	27.5033	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910163	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.65	3	22,5665	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910163	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.66	3	38,3085	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910163	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.67	3	54,0505	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910163	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.68	3	9,2950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910163	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.69	3	25,0350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910163	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.70	3	41,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910163	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.71	3	57,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910163	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.72	3	11.7612	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910164	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.65	3	15,3065	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910164	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.74	3	35.9854	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910164	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.66	3	31,0485	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910164	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.67	3	46,7905	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910164	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.68	3	2,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910164	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.69	3	17,7750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910164	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.70	3	33,500	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910164	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.71	3	49,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910164	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.72	3	4,5000	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910164	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.73	3	20.2433	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910165	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.66	3	23,7885	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910165	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.75	3	44.4675	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910165	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.67	3	39,5305	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910165	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.68	3	55,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910165	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.69	3	10,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910165	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.70	3	26,250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910165	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.71	3	42,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910165	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.72	3	57,7400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910165	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.73	3	12,9850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910165	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.74	3	28.7254	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910166	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.67	3	32,2705	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910166	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.76	3	52.9496	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910166	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.68	3	48,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910166	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.69	3	3,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910166	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.70	3	18,995	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910166	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.71	3	35,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910166	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.72	3	50,4800	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910166	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.73	3	5,7250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910166	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.74	3	21,4650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910166	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.75	3	37.2075	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910167	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.68	3	40,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910167	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.77	3	61.4317	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910167	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.69	3	56,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910167	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.70	3	11,735	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910167	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.71	3	27,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910167	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.72	3	43,2200	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910167	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.73	3	58,9650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910167	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.74	3	14,2050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910167	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.75	3	29,9450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910167	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.76	3	45.6896	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910168	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.69	3	49,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910168	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.78	3	9.4138	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910168	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.70	3	4,475	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910168	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.71	3	20,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910168	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.72	3	36,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910168	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.73	3	51,7050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910168	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.74	3	6,9450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910168	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.75	3	22,6850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910168	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.76	3	38,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910168	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.77	3	54.1717	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910169	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.70	3	57,715	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910169	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.79	3	17.8959	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910169	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.71	3	13,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910169	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.72	3	28,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910169	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.73	3	44,4435	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910169	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.74	3	60,1850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910169	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.75	3	15,4250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910169	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.76	3	31,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910169	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.77	3	46,9100	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910169	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.78	3	2.1538	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910170	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.71	3	5,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910170	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.80	3	26.378	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910170	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.72	3	21,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910170	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.73	3	37,1835	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910170	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.74	3	52,9255	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910170	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.75	3	8,1650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910170	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.76	3	24,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910170	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.77	3	39,6500	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910170	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.78	3	55,3950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910170	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.79	3	10.6359	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910171	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.72	3	14,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910171	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.81	3	34.8601	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910171	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.73	3	29,9235	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910171	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.74	3	45,6655	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910171	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.75	3	61,4075	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910171	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.76	3	17,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910171	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.77	3	32,3900	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910171	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.78	3	48,1350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910171	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.79	3	3,3750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910171	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.80	3	19.118	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910172	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.73	3	22,6635	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910172	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.82	3	43.3422	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910172	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.74	3	38,4055	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910172	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.75	3	54,1475	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910172	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.76	3	9,3895	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910172	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.77	3	25,1300	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910172	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.78	3	40,8750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910172	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.79	3	56,6150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910172	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.80	3	11,850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910172	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.81	3	27.6001	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910173	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.74	3	31,1455	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910173	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.83	3	51.8243	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910173	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.75	3	46,8875	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910173	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.76	3	2,1295	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910173	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.77	3	17,8715	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910173	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.78	3	33,6150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910173	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.79	3	49,3550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910173	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.80	3	5,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910173	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.81	3	20,3400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910173	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.82	3	36.0822	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910174	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.75	3	39,6275	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910174	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.84	3	60.3064	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910174	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.76	3	55,3695	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910174	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.77	3	10,6115	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910174	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.78	3	26,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910174	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.79	3	42,0950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910174	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.80	3	57,850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910174	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.81	3	13,0800	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910174	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.82	3	28,8200	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910174	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.83	3	44.5643	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910175	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.76	3	48,1095	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910175	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.85	3	8.2885	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910175	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.77	3	3,3515	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910175	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.78	3	19,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910175	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.79	3	34,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910175	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.80	3	51,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910175	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.81	3	5,8200	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910175	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.82	3	21,5600	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910175	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.83	3	37,3050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910175	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.84	3	53.0464	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910176	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.77	3	56,5915	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910176	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.86	3	16.7706	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910176	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.78	3	11,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910176	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.79	3	27,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910176	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.80	3	43,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910176	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.81	3	59,0600	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910176	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.82	3	14,3000	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910176	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.83	3	30,0450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910176	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.84	3	45,7850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910176	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.85	3	61.5285	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910177	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.78	3	4,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910177	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.87	3	25.2527	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910177	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.79	3	20,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910177	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.80	3	36,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910177	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.81	3	51,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910177	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.82	3	7,0400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910177	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.83	3	22,7850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910177	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.84	3	38,5250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910177	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.85	3	54,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910177	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.86	3	9.5106	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910178	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.79	3	13,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910178	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.88	3	33.7348	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910178	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.80	3	28,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910178	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.81	3	44,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910178	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.82	3	60,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910178	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.83	3	15,5250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910178	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.84	3	31,2650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910178	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.85	3	47,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910178	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.86	3	2,2500	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910178	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.87	3	17.9927	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910179	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.80	3	21,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910179	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.89	3	42.2169	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910179	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.81	3	37,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910179	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.82	3	53,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910179	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.83	3	8,2645	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910179	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.84	3	24,0050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910179	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.85	3	40,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910179	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.86	3	55,4900	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910179	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.87	3	10,7350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910179	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.88	3	26.4748	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910180	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.81	3	30,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910180	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.90	3	50.699	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910180	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.82	3	45,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910180	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.83	3	61,5045	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910180	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.84	3	16,7465	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910180	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.85	3	32,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910180	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.86	3	48,2300	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910180	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.87	3	3,4750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910180	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.88	3	19,2150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910180	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.89	3	34.9569	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910181	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.82	3	38,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910181	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.91	3	59.1811	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910181	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.83	3	54,2445	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910181	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.84	3	9,4865	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910181	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.85	3	25,2285	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910181	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.86	3	40,9700	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910181	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.87	3	56,7150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910181	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.88	3	11,9550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910181	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.89	3	27,6950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910181	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.90	3	43.439	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910182	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.83	3	46,9845	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910182	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.92	3	7.1632	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910182	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.84	3	2,2265	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910182	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.85	3	17,9685	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910182	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.86	3	33,7105	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910182	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.87	3	49,4550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910182	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.88	3	4,6950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910182	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.89	3	20,4350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910182	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.90	3	36,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910182	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.91	3	51.9211	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910183	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.84	3	55,4665	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910183	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.93	3	15.6453	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910183	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.85	3	10,7085	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910183	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.86	3	26,4505	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910183	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.87	3	42,1925	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910183	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.88	3	57,9350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910183	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.89	3	13,1750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910183	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.90	3	28,900	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910183	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.91	3	44,6600	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910183	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.92	3	60.4032	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910184	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.85	3	3,4485	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910184	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.94	3	24.1274	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910184	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.86	3	19,1905	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910184	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.87	3	34,9325	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910184	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.88	3	50,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910184	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.89	3	5,9150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910184	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.90	3	21,650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910184	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.91	3	37,4000	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910184	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.92	3	53,1450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910184	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.93	3	8.3853	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910185	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.86	3	11,9305	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910185	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.95	3	32.6095	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910185	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.87	3	27,6725	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910185	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.88	3	43,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910185	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.89	3	59,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910185	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.90	3	14,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910185	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.91	3	30,1400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910185	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.92	3	45,8850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910185	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.93	3	61,6250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910185	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.94	3	16.8674	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910186	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.87	3	20,4125	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910186	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.96	3	41.0916	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910186	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.88	3	36,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910186	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.89	3	51,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910186	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.90	3	7,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910186	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.91	3	22,8800	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910186	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.92	3	38,6250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910186	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.93	3	54,3650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910186	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.94	3	9,6050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910186	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.95	3	25.3495	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910187	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.88	3	28,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910187	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.97	3	49.5737	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910187	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.89	3	44,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910187	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.90	3	60,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910187	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.91	3	15,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910187	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.92	3	31,3650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910187	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.93	3	47,1050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910187	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.94	3	2,3450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910187	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.95	3	18,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910187	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.96	3	33.8316	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910188	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.89	3	37,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910188	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.98	3	58.0558	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910188	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.90	3	53,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910188	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.91	3	8,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910188	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.92	3	24,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910188	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.93	3	39,8450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910188	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.94	3	55,5850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910188	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.95	3	11,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910188	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.96	3	26,5700	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910188	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.97	3	42.3137	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910189	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.90	3	45,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910189	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.99	3	6.0379	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910189	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.91	3	61,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910189	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.92	3	16,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910189	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.93	3	32,5855	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910189	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.94	3	48,3250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910189	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.95	3	4,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910189	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.96	3	19,3100	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910189	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.97	3	35,0550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910189	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.98	3	50.7958	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910190	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.91	3	54,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910190	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.00	3	13.31	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910190	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.92	3	9,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910190	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.93	3	25,3255	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910190	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.94	3	41,0675	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910190	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.95	3	57,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910190	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.96	3	12,0500	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910190	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.97	3	27,7950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910190	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.98	3	43,5350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910190	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.99	3	59.2779	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910191	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.92	3	2,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910191	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.01	3	21.7921	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910191	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.93	3	18,0655	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910191	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.94	3	33,8075	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910191	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.95	3	49,5495	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910191	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.96	3	4,7900	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910191	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.97	3	20,5350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910191	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.98	3	36,2750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910191	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.99	3	52,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910191	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.00	3	6.05	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910192	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.93	3	10,8055	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910192	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.02	3	30.2742	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910192	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.94	3	26,5475	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910192	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.95	3	42,2895	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910192	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.96	3	58,0315	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910192	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.97	3	13,2750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910192	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.98	3	29,0150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910192	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.99	3	45,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910192	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.00	3	59,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910192	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.01	3	14.5321	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910193	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.94	3	19,2875	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910193	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.03	3	38.7563	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910193	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.95	3	35,0295	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910193	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.96	3	50,7715	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910193	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.97	3	6,0135	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910193	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.98	3	21,7550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910193	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.99	3	37,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910193	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.00	3	52,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910193	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.01	3	7,2700	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910193	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.02	3	23.0142	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910194	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.95	3	27,7695	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910194	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.04	3	47.2384	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910194	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.96	3	43,5115	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910194	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.97	3	59,2535	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910194	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.98	3	14,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910194	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.99	3	30,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910194	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.00	3	45,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910194	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.01	3	60,5100	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910194	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.02	3	15,7550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910194	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.03	3	31.4963	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910195	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.96	3	36,2515	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910195	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.05	3	55.7205	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910195	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.97	3	51,9935	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910195	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.98	3	7,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910195	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.99	3	23,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910195	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.00	3	37,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910195	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.01	3	53,2500	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910195	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.02	3	8,4950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910195	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.03	3	24,2350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910195	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.04	3	39.9784	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910196	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.97	3	44,7335	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910196	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.06	3	3.7026	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910196	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.98	3	60,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910196	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.99	3	15,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910196	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.00	3	30,25	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910196	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.01	3	45,9900	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910196	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.02	3	1,2350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910196	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.03	3	16,9750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910196	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.04	3	33,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910196	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.05	3	48.4605	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910197	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.98	3	53,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910197	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.07	3	12.1847	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910197	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.99	3	8,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910197	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.00	3	23,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910197	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.01	3	38,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910197	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.02	3	54,4750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910197	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.03	3	9,7150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910197	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.04	3	25,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910197	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.05	3	41,2000	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910197	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.06	3	56.9426	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910198	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.99	3	61,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910198	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.08	3	20.6668	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910198	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.00	3	15,75	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910198	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.01	3	31,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910198	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.02	3	47,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910198	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.03	3	2,4550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910198	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.04	3	18,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910198	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.05	3	33,9400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910198	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.06	3	49,6850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910198	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.07	3	4.9247	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910199	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.00	3	8,45	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910199	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.09	3	29.1489	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910199	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.01	3	24,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910199	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.02	3	40,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910199	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.03	3	55,6965	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910199	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.04	3	11,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910199	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.05	3	26,6800	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910199	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.06	3	42,4250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910199	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.07	3	58,1650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910199	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.08	3	13.4068	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910200	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.01	3	17,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910200	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.10	3	37.631	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910200	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.02	3	32,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910200	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.03	3	48,4365	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910200	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.04	3	3,6785	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910200	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.05	3	19,4200	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910200	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.06	3	35,1650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910200	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.07	3	50,9050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910200	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.08	3	6,1450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910200	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.09	3	21.8889	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910201	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.02	3	25,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910201	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.11	3	46.1131	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910201	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.03	3	41,1765	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910201	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.04	3	56,9185	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910201	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.05	3	12,1605	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910201	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.06	3	27,9050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910201	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.07	3	43,6450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910201	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.08	3	59,3850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910201	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.09	3	15,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910201	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.10	3	30.371	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910202	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.03	3	33,9165	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910202	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.12	3	54.5952	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910202	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.04	3	49,6585	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910202	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.05	3	4,9005	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910202	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.06	3	20,6425	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910202	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.07	3	36,3850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910202	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.08	3	52,1250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910202	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.09	3	7,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910202	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.10	3	23,100	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910202	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.11	3	38.8531	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910203	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.04	3	42,3985	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910203	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.13	3	2.5773	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910203	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.05	3	58,1405	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910203	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.06	3	13,3825	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910203	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.07	3	29,1245	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910203	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.08	3	44,8650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910203	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.09	3	61,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910203	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.10	3	15,850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910203	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.11	3	31,5950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910203	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.12	3	47.3352	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910204	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.05	3	50,8805	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910204	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.14	3	11.0594	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910204	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.06	3	6,1225	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910204	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.07	3	21,8645	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910204	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.08	3	37,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910204	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.09	3	53,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910204	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.10	3	9,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910204	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.11	3	24,3350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910204	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.12	3	40,0750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910204	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.13	3	55.8173	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910205	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.06	3	59,3625	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910205	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.15	3	19.5415	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910205	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.07	3	14,6045	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910205	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.08	3	30,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910205	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.09	3	46,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910205	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.10	3	1,350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910205	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.11	3	17,0750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910205	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.12	3	32,8150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910205	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.13	3	48,5550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910205	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.14	3	3.7994	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910206	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.07	3	7,3445	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910206	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.16	3	28.0236	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910206	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.08	3	23,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910206	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.09	3	38,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910206	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.10	3	54,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910206	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.11	3	9,8150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910206	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.12	3	25,5550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910206	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.13	3	41,2950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910206	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.14	3	57,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910206	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.15	3	12.2815	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910207	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.08	3	15,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910207	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.17	3	36.5057	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910207	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.09	3	31,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910207	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.10	3	47,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910207	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.11	3	2,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910207	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.12	3	18,2950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910207	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.13	3	34,0350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910207	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.14	3	50,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910207	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.15	3	5,0200	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910207	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.16	3	20.7636	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910208	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.09	3	24,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910208	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.18	3	44.9878	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910208	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.10	3	40,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910208	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.11	3	55,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910208	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.12	3	11,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910208	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.13	3	26,7750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910208	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.14	3	43,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910208	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.15	3	58,2600	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910208	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.16	3	13,5050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910208	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.17	3	29.2457	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910209	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.10	3	32,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910209	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.19	3	53.4699	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910209	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.11	3	48,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910209	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.12	3	3,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910209	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.13	3	19,5175	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910209	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.14	3	35,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910209	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.15	3	51,0000	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910209	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.16	3	6,2450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910209	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.17	3	21,9850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910209	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.18	3	37.7278	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910210	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.11	3	41,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910210	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.20	3	1.452	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910210	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.12	3	57,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910210	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.13	3	12,2575	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910210	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.14	3	27,9995	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910210	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.15	3	43,7400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910210	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.16	3	59,4850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910210	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.17	3	14,7250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910210	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.18	3	30,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910210	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.19	3	46.2099	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910211	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.12	3	49,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910211	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.21	3	9.9341	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910211	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.13	3	4,9975	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910211	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.14	3	20,7395	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910211	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.15	3	36,4815	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910211	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.16	3	52,2250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910211	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.17	3	7,4650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910211	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.18	3	23,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910211	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.19	3	39,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910211	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.20	3	54.692	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910212	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.13	3	58,2375	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910212	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.22	3	18.4162	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910212	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.14	3	13,4795	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910212	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.15	3	29,2215	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910212	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.16	3	44,9635	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910212	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.17	3	60,7050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910212	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.18	3	16,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910212	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.19	3	32,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910212	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.20	3	47,450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910212	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.21	3	2.6741	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910213	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.14	3	6,2195	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910213	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.23	3	26.8983	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910213	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.15	3	21,9615	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910213	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.16	3	37,7035	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910213	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.17	3	53,4455	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910213	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.18	3	9,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910213	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.19	3	24,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910213	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.20	3	40,150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910213	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.21	3	55,9150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910213	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.22	3	11.1562	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910214	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.15	3	14,7015	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910214	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.24	3	35.3804	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910214	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.16	3	30,4435	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910214	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.17	3	46,1855	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910214	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.18	3	1,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910214	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.19	3	17,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910214	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.20	3	32,900	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910214	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.21	3	48,6550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910214	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.22	3	3,8950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910214	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.23	3	19.6383	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910215	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.16	3	23,1835	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910215	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.25	3	43.8625	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910215	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.17	3	38,9255	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910215	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.18	3	54,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910215	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.19	3	9,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910215	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.20	3	25,650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910215	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.21	3	41,3950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910215	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.22	3	57,1350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910215	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.23	3	12,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910215	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.24	3	28.1204	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910216	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.17	3	31,6655	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910216	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.26	3	52.3446	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910216	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.18	3	47,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910216	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.19	3	2,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910216	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.20	3	18,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910216	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.21	3	34,1350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910216	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.22	3	49,8750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910216	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.23	3	5,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910216	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.24	3	20,8600	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910216	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.25	3	36.6025	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910217	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.18	3	40,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910217	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.27	3	60.8267	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910217	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.19	3	55,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910217	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.20	3	11,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910217	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.21	3	26,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910217	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.22	3	42,6150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910217	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.23	3	58,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910217	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.24	3	13,6000	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910217	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.25	3	29,3400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910217	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.26	3	45.0846	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910218	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.19	3	48,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910218	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.28	3	8.8088	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910218	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.20	3	3,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910218	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.21	3	19,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910218	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.22	3	35,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910218	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.23	3	51,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910218	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.24	3	6,3400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910218	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.25	3	22,0800	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910218	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.26	3	37,8250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910218	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.27	3	53.5667	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910219	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.20	3	57,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910219	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.29	3	17.2909	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910219	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.21	3	12,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910219	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.22	3	28,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910219	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.23	3	43,8385	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910219	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.24	3	59,5800	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910219	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.25	3	14,8200	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910219	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.26	3	30,5650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910219	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.27	3	46,3050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910219	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.28	3	1.5488	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910220	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.21	3	5,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910220	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.30	3	25.773	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910220	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.22	3	20,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910220	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.23	3	36,5785	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910220	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.24	3	52,3205	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910220	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.25	3	7,5600	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910220	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.26	3	23,3050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910220	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.27	3	39,0450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910220	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.28	3	55,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910220	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.29	3	10.0309	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910221	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.22	3	13,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910221	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.31	3	34.2551	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910221	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.23	3	29,3185	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910221	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.24	3	45,0605	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910221	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.25	3	60,8025	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910221	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.26	3	16,0450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910221	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.27	3	31,7850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910221	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.28	3	48,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910221	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.29	3	2,7700	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910221	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.30	3	18.513	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910222	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.23	3	22,0585	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910222	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.32	3	42.7372	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910222	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.24	3	37,8005	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910222	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.25	3	53,5425	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910222	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.26	3	8,7845	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910222	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.27	3	24,5250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910222	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.28	3	40,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910222	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.29	3	56,0100	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910222	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.30	3	11,250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910222	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.31	3	26.9951	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910223	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.24	3	30,5405	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910223	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.33	3	51.2193	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910223	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.25	3	46,2825	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910223	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.26	3	1,5245	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910223	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.27	3	17,2665	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910223	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.28	3	33,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910223	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.29	3	48,7500	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910223	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.30	3	4,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910223	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.31	3	19,7350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910223	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.32	3	35.4772	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910224	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.25	3	39,0225	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910224	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.34	3	59.7014	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910224	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.26	3	54,7645	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910224	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.27	3	10,0065	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910224	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.28	3	25,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910224	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.29	3	41,4900	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910224	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.30	3	57,250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910224	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.31	3	12,4750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910224	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.32	3	28,2150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910224	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.33	3	43.9593	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910225	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.26	3	47,5045	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910225	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.35	3	7.6835	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910225	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.27	3	2,7465	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910225	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.28	3	18,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910225	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.29	3	34,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910225	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.30	3	49,950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910225	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.31	3	5,2150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910225	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.32	3	20,9550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910225	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.33	3	37,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910225	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.34	3	52.4414	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910226	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.27	3	55,9865	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910226	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.36	3	16.1656	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910226	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.28	3	11,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910226	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.29	3	27,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910226	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.30	3	42,715	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910226	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.31	3	58,4550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910226	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.32	3	13,6950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910226	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.33	3	29,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910226	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.34	3	45,1800	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910226	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.35	3	60.9235	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910227	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.28	3	4,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910227	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.37	3	24.6477	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910227	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.29	3	19,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910227	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.30	3	35,455	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910227	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.31	3	51,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910227	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.32	3	6,4350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910227	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.33	3	22,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910227	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.34	3	37,9200	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910227	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.35	3	53,6650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910227	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.36	3	8.9056	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910228	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.29	3	12,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910228	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.38	3	33.1298	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910228	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.30	3	28,195	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910228	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.31	3	43,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910228	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.32	3	59,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910228	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.33	3	15,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910228	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.34	3	30,6600	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910228	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.35	3	46,4050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910228	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.36	3	1,6450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910228	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.37	3	17.3877	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910229	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.30	3	20,935	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910229	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.39	3	41.6119	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910229	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.31	3	36,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910229	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.32	3	52,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910229	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.33	3	7,6595	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910229	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.34	3	23,4000	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910229	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.35	3	39,1450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910229	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.36	3	54,8850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910229	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.37	3	10,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910229	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.38	3	25.8698	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910230	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.31	3	29,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910230	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.40	3	50.094	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910230	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.32	3	45,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910230	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.33	3	60,8995	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910230	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.34	3	16,1415	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910230	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.35	3	31,8850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910230	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.36	3	47,6250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910230	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.37	3	3,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910230	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.38	3	19,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910230	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.39	3	34.3519	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910231	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.32	3	37,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910231	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.41	3	58.5761	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910231	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.33	3	53,6395	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910231	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.34	3	8,8815	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910231	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.35	3	24,6235	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910231	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.36	3	40,3650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910231	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.37	3	56,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910231	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.38	3	11,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910231	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.39	3	27,0900	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910231	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.40	3	42.834	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910232	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.33	3	46,3795	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910232	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.42	3	6.5582	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910232	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.34	3	1,6215	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910232	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.35	3	17,3635	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910232	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.36	3	33,1055	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910232	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.37	3	49,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910232	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.38	3	4,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910232	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.39	3	19,8300	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910232	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.40	3	35,550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910232	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.41	3	51.3161	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910233	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.34	3	54,8615	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910233	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.43	3	15.0403	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910233	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.35	3	10,1035	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910233	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.36	3	25,8455	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910233	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.37	3	41,5875	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910233	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.38	3	57,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910233	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.39	3	12,5700	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910233	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.40	3	28,300	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910233	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.41	3	44,0550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910233	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.42	3	59.7982	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910234	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.35	3	2,8435	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910234	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.44	3	23.5224	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910234	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.36	3	18,5855	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910234	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.37	3	34,3275	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910234	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.38	3	50,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910234	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.39	3	5,3100	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910234	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.40	3	21,050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910234	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.41	3	36,7950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910234	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.42	3	53,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910234	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.43	3	7.7803	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910235	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.36	3	11,3255	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910235	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.45	3	32.0045	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910235	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.37	3	27,0675	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910235	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.38	3	42,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910235	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.39	3	58,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910235	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.40	3	14,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910235	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.41	3	29,5350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910235	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.42	3	45,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910235	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.43	3	61,0200	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910235	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.44	3	16.2624	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910236	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.37	3	19,8075	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910236	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.46	3	40.4866	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910236	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.38	3	35,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910236	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.39	3	51,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910236	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.40	3	6,535	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910236	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.41	3	22,2750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910236	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.42	3	38,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910236	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.43	3	53,7600	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910236	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.44	3	9,0000	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910236	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.45	3	24.7445	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910237	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.38	3	28,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910237	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.47	3	48.9687	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910237	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.39	3	44,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910237	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.40	3	59,775	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910237	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.41	3	15,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910237	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.42	3	31,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910237	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.43	3	46,5000	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910237	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.44	3	1,7400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910237	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.45	3	17,4850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910237	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.46	3	33.2266	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910238	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.39	3	36,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910238	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.48	3	57.4508	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910238	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.40	3	52,515	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910238	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.41	3	7,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910238	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.42	3	23,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910238	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.43	3	39,2400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910238	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.44	3	54,9800	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910238	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.45	3	10,2250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910238	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.46	3	25,9650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910238	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.47	3	41.7087	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910239	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.40	3	45,255	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910239	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.49	3	5.4329	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910239	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.41	3	61,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910239	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.42	3	16,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910239	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.43	3	31,9805	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910239	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.44	3	47,7200	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910239	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.45	3	2,9650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910239	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.46	3	18,7050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910239	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.47	3	34,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910239	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.48	3	50.1908	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910240	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.41	3	53,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910240	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.50	3	13.915	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910240	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.42	3	9,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910240	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.43	3	24,7205	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910240	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.44	3	40,4625	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910240	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.45	3	56,2050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910240	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.46	3	11,4450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910240	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.47	3	27,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910240	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.48	3	42,9300	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910240	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.49	3	58.6729	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910241	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.42	3	1,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910241	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.51	3	22.3971	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910241	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.43	3	17,4605	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910241	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.44	3	33,2025	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910241	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.45	3	48,9445	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910241	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.46	3	4,1850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910241	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.47	3	20,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910241	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.48	3	35,6700	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910241	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.49	3	51,4150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910241	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.50	3	6.655	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910242	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.43	3	10,2005	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910242	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.52	3	30.8792	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910242	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.44	3	25,9425	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910242	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.45	3	41,6845	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910242	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.46	3	57,4265	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910242	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.47	3	13,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910242	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.48	3	28,4100	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910242	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.49	3	44,1550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910242	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.50	3	60,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910242	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.51	3	15.1371	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910243	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.44	3	18,6825	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910243	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.53	3	39.3613	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910243	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.45	3	34,4245	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910243	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.46	3	50,1665	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910243	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.47	3	5,4085	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910243	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.48	3	21,1500	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910243	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.49	3	36,8950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910243	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.50	3	52,650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910243	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.51	3	7,8750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910243	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.52	3	23.6192	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910244	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.45	3	27,1645	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910244	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.54	3	47.8434	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910244	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.46	3	42,9065	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910244	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.47	3	58,6485	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910244	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.48	3	13,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910244	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.49	3	29,6350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910244	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.50	3	45,350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910244	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.51	3	61,1150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910244	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.52	3	16,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910244	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.53	3	32.1013	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910245	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.46	3	35,6465	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910245	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.55	3	56.3255	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910245	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.47	3	51,3885	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910245	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.48	3	6,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910245	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.49	3	22,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910245	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.50	3	38,100	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910245	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.51	3	53,8550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910245	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.52	3	9,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910245	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.53	3	24,8400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910245	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.54	3	40.5834	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910246	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.47	3	44,1285	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910246	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.56	3	4.3076	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910246	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.48	3	59,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910246	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.49	3	15,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910246	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.50	3	30,855	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910246	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.51	3	46,5950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910246	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.52	3	2,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910246	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.53	3	17,5800	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910246	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.54	3	33,3250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910246	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.55	3	49.0655	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910247	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.48	3	52,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910247	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.57	3	12.7897	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910247	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.49	3	7,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910247	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.50	3	23,595	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910247	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.51	3	39,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910247	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.52	3	55,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910247	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.53	3	10,3200	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910247	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.54	3	26,0650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910247	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.55	3	41,8050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910247	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.56	3	57.5476	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910248	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.49	3	61,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910248	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.58	3	21.2718	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910248	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.50	3	16,335	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910248	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.51	3	32,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910248	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.52	3	47,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910248	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.53	3	3,0600	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910248	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.54	3	18,8050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910248	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.55	3	34,5450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910248	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.56	3	50,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910248	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.57	3	5.5297	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910249	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.50	3	9,075	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910249	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.59	3	29.7539	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910249	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.51	3	24,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910249	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.52	3	40,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910249	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.53	3	56,3015	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910249	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.54	3	11,5450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910249	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.55	3	27,2850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910249	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.56	3	43,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910249	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.57	3	59,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910249	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.58	3	14.0118	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910250	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.51	3	17,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910250	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.60	3	38.236	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910250	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.52	3	33,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910250	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.53	3	49,0415	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910250	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.54	3	4,2835	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910250	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.55	3	20,0250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910250	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.56	3	36,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910250	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.57	3	52,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910250	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.58	3	6,7500	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910250	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.59	3	22.4939	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910251	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.52	3	26,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910251	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.61	3	46.7181	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910251	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.53	3	41,7815	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910251	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.54	3	57,5235	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910251	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.55	3	12,7655	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910251	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.56	3	29,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910251	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.57	3	44,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910251	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.58	3	59,9900	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910251	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.59	3	15,2350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910251	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.60	3	30.976	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910252	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.53	3	34,5215	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910252	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.62	3	55.2002	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910252	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.54	3	50,2635	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910252	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.55	3	5,5055	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910252	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.56	3	21,2475	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910252	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.57	3	37,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910252	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.58	3	52,7300	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910252	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.59	3	7,9750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910252	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.60	3	23,700	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910252	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.61	3	39.4581	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910253	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.54	3	43,0035	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910253	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.63	3	3.1823	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910253	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.55	3	58,7455	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910253	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.56	3	13,9875	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910253	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.57	3	29,7295	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910253	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.58	3	45,4700	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910253	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.59	3	61,2150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910253	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.60	3	16,450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910253	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.61	3	32,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910253	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.62	3	47.9402	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910254	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.55	3	51,4855	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910254	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.64	3	11.6644	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910254	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.56	3	6,7275	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910254	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.57	3	22,4695	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910254	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.58	3	38,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910254	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.59	3	53,9550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910254	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.60	3	9,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910254	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.61	3	25,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910254	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.62	3	40,6800	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910254	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.63	3	56.4223	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910255	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.56	3	59,9675	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910255	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.65	3	20.1465	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910255	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.57	3	15,2095	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910255	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.58	3	31,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910255	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.59	3	46,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910255	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.60	3	1,950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910255	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.61	3	18,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910255	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.62	3	33,4200	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910255	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.63	3	49,1600	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910255	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.64	3	4.4044	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910256	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.57	3	7,9495	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910256	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.66	3	28.6286	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910256	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.58	3	23,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910256	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.59	3	39,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910256	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.60	3	55,175	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910256	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.61	3	10,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910256	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.62	3	26,1600	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910256	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.63	3	41,9000	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910256	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.64	3	57,6450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910256	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.65	3	12.8865	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910257	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.58	3	16,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910257	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.67	3	37.1107	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910257	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.59	3	32,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910257	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.60	3	47,915	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910257	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.61	3	3,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910257	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.62	3	18,9000	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910257	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.63	3	34,6400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910257	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.64	3	50,3850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910257	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.65	3	5,6250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910257	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.66	3	21.3686	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910258	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.59	3	24,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910258	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.68	3	45.5928	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910258	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.60	3	40,655	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910258	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.61	3	56,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910258	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.62	3	11,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910258	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.63	3	27,3800	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910258	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.64	3	43,1250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910258	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.65	3	58,8650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910258	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.66	3	14,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910258	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.67	3	29.8507	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910259	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.60	3	33,395	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910259	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.69	3	54.0749	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910259	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.61	3	49,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910259	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.62	3	4,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910259	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.63	3	20,1225	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910259	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.64	3	35,8650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910259	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.65	3	51,6050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910259	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.66	3	7,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910259	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.67	3	22,5900	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910259	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.68	3	38.3328	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910260	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.61	3	41,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910260	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.70	3	2.057	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910260	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.62	3	57,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910260	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.63	3	12,8625	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910260	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.64	3	28,6045	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910260	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.65	3	44,3450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910260	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.66	3	60,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910260	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.67	3	15,3300	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910260	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.68	3	31,0750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910260	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.69	3	46.8149	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910261	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.62	3	50,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910261	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.71	3	10.5391	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910261	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.63	3	5,6025	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910261	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.64	3	21,3445	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910261	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.65	3	37,0865	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910261	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.66	3	53,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910261	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.67	3	8,0700	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910261	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.68	3	23,8150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910261	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.69	3	39,5550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910261	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.70	3	55.297	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910262	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.63	3	58,8425	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910262	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.72	3	19.0212	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910262	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.64	3	14,0845	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910262	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.65	3	29,8265	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910262	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.66	3	45,5685	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910262	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.67	3	61,3100	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910262	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.68	3	16,5550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910262	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.69	3	32,2950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910262	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.70	3	48,050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910262	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.71	3	3.2791	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910263	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.64	3	6,8245	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910263	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.73	3	27.5033	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910263	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.65	3	22,5665	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910263	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.66	3	38,3085	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910263	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.67	3	54,0505	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910263	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.68	3	9,2950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910263	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.69	3	25,0350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910263	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.70	3	41,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910263	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.71	3	57,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910263	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.72	3	11.7612	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910264	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.65	3	15,3065	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910264	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.74	3	35.9854	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910264	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.66	3	31,0485	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910264	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.67	3	46,7905	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910264	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.68	3	2,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910264	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.69	3	17,7750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910264	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.70	3	33,500	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910264	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.71	3	49,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910264	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.72	3	4,5000	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910264	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.73	3	20.2433	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910265	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.66	3	23,7885	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910265	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.75	3	44.4675	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910265	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.67	3	39,5305	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910265	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.68	3	55,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910265	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.69	3	10,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910265	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.70	3	26,250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910265	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.71	3	42,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910265	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.72	3	57,7400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910265	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.73	3	12,9850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910265	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.74	3	28.7254	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910266	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.67	3	32,2705	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910266	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.76	3	52.9496	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910266	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.68	3	48,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910266	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.69	3	3,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910266	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.70	3	18,995	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910266	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.71	3	35,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910266	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.72	3	50,4800	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910266	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.73	3	5,7250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910266	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.74	3	21,4650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910266	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.75	3	37.2075	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910267	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.68	3	40,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910267	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.77	3	61.4317	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910267	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.69	3	56,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910267	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.70	3	11,735	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910267	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.71	3	27,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910267	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.72	3	43,2200	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910267	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.73	3	58,9650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910267	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.74	3	14,2050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910267	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.75	3	29,9450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910267	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.76	3	45.6896	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910268	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.69	3	49,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910268	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.78	3	9.4138	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910268	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.70	3	4,475	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910268	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.71	3	20,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910268	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.72	3	36,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910268	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.73	3	51,7050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910268	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.74	3	6,9450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910268	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.75	3	22,6850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910268	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.76	3	38,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910268	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.77	3	54.1717	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910269	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.70	3	57,715	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910269	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.79	3	17.8959	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910269	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.71	3	13,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910269	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.72	3	28,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910269	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.73	3	44,4435	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910269	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.74	3	60,1850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910269	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.75	3	15,4250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910269	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.76	3	31,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910269	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.77	3	46,9100	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910269	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.78	3	2.1538	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910270	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.71	3	5,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910270	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.80	3	26.378	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910270	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.72	3	21,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910270	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.73	3	37,1835	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910270	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.74	3	52,9255	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910270	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.75	3	8,1650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910270	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.76	3	24,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910270	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.77	3	39,6500	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910270	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.78	3	55,3950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910270	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.79	3	10.6359	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910271	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.72	3	14,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910271	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.81	3	34.8601	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910271	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.73	3	29,9235	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910271	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.74	3	45,6655	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910271	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.75	3	61,4075	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910271	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.76	3	17,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910271	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.77	3	32,3900	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910271	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.78	3	48,1350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910271	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.79	3	3,3750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910271	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.80	3	19.118	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910272	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.73	3	22,6635	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910272	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.82	3	43.3422	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910272	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.74	3	38,4055	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910272	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.75	3	54,1475	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910272	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.76	3	9,3895	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910272	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.77	3	25,1300	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910272	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.78	3	40,8750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910272	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.79	3	56,6150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910272	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.80	3	11,850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910272	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.81	3	27.6001	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910273	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.74	3	31,1455	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910273	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.83	3	51.8243	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910273	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.75	3	46,8875	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910273	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.76	3	2,1295	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910273	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.77	3	17,8715	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910273	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.78	3	33,6150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910273	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.79	3	49,3550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910273	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.80	3	5,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910273	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.81	3	20,3400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910273	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.82	3	36.0822	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910274	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.75	3	39,6275	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910274	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.84	3	60.3064	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910274	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.76	3	55,3695	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910274	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.77	3	10,6115	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910274	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.78	3	26,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910274	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.79	3	42,0950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910274	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.80	3	57,850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910274	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.81	3	13,0800	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910274	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.82	3	28,8200	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910274	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.83	3	44.5643	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910275	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.76	3	48,1095	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910275	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.85	3	8.2885	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910275	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.77	3	3,3515	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910275	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.78	3	19,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910275	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.79	3	34,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910275	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.80	3	51,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910275	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.81	3	5,8200	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910275	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.82	3	21,5600	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910275	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.83	3	37,3050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910275	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.84	3	53.0464	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910276	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.77	3	56,5915	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910276	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.86	3	16.7706	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910276	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.78	3	11,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910276	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.79	3	27,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910276	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.80	3	43,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910276	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.81	3	59,0600	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910276	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.82	3	14,3000	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910276	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.83	3	30,0450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910276	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.84	3	45,7850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910276	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.85	3	61.5285	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910277	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.78	3	4,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910277	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.87	3	25.2527	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910277	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.79	3	20,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910277	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.80	3	36,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910277	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.81	3	51,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910277	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.82	3	7,0400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910277	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.83	3	22,7850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910277	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.84	3	38,5250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910277	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.85	3	54,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910277	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.86	3	9.5106	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910278	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.79	3	13,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910278	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.88	3	33.7348	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910278	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.80	3	28,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910278	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.81	3	44,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910278	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.82	3	60,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910278	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.83	3	15,5250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910278	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.84	3	31,2650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910278	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.85	3	47,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910278	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.86	3	2,2500	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910278	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.87	3	17.9927	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910279	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.80	3	21,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910279	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.89	3	42.2169	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910279	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.81	3	37,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910279	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.82	3	53,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910279	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.83	3	8,2645	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910279	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.84	3	24,0050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910279	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.85	3	40,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910279	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.86	3	55,4900	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910279	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.87	3	10,7350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910279	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.88	3	26.4748	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910280	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.81	3	30,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910280	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.90	3	50.699	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910280	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.82	3	45,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910280	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.83	3	61,5045	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910280	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.84	3	16,7465	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910280	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.85	3	32,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910280	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.86	3	48,2300	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910280	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.87	3	3,4750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910280	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.88	3	19,2150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910280	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.89	3	34.9569	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910281	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.82	3	38,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910281	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.91	3	59.1811	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910281	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.83	3	54,2445	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910281	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.84	3	9,4865	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910281	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.85	3	25,2285	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910281	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.86	3	40,9700	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910281	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.87	3	56,7150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910281	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.88	3	11,9550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910281	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.89	3	27,6950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910281	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.90	3	43.439	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910282	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.83	3	46,9845	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910282	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.92	3	7.1632	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910282	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.84	3	2,2265	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910282	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.85	3	17,9685	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910282	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.86	3	33,7105	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910282	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.87	3	49,4550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910282	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.88	3	4,6950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910282	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.89	3	20,4350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910282	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.90	3	36,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910282	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.91	3	51.9211	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910283	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.84	3	55,4665	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910283	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.93	3	15.6453	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910283	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.85	3	10,7085	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910283	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.86	3	26,4505	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910283	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.87	3	42,1925	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910283	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.88	3	57,9350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910283	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.89	3	13,1750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910283	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.90	3	28,900	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910283	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.91	3	44,6600	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910283	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.92	3	60.4032	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910284	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.85	3	3,4485	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910284	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.94	3	24.1274	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910284	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.86	3	19,1905	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910284	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.87	3	34,9325	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910284	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.88	3	50,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910284	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.89	3	5,9150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910284	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.90	3	21,650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910284	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.91	3	37,4000	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910284	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.92	3	53,1450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910284	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.93	3	8.3853	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910285	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.86	3	11,9305	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910285	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.95	3	32.6095	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910285	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.87	3	27,6725	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910285	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.88	3	43,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910285	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.89	3	59,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910285	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.90	3	14,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910285	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.91	3	30,1400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910285	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.92	3	45,8850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910285	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.93	3	61,6250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910285	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.94	3	16.8674	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910286	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.87	3	20,4125	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910286	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.96	3	41.0916	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910286	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.88	3	36,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910286	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.89	3	51,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910286	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.90	3	7,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910286	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.91	3	22,8800	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910286	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.92	3	38,6250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910286	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.93	3	54,3650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910286	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.94	3	9,6050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910286	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.95	3	25.3495	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910287	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.88	3	28,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910287	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.97	3	49.5737	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910287	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.89	3	44,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910287	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.90	3	60,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910287	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.91	3	15,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910287	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.92	3	31,3650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910287	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.93	3	47,1050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910287	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.94	3	2,3450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910287	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.95	3	18,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910287	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.96	3	33.8316	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910288	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.89	3	37,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910288	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.98	3	58.0558	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910288	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.90	3	53,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910288	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.91	3	8,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910288	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.92	3	24,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910288	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.93	3	39,8450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910288	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.94	3	55,5850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910288	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.95	3	11,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910288	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.96	3	26,5700	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910288	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.97	3	42.3137	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910289	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.90	3	45,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910289	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.99	3	6.0379	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910289	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.91	3	61,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910289	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.92	3	16,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910289	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.93	3	32,5855	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910289	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.94	3	48,3250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910289	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.95	3	4,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910289	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.96	3	19,3100	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910289	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.97	3	35,0550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910289	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.98	3	50.7958	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910290	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.91	3	54,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910290	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.00	3	13.31	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910290	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.92	3	9,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910290	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.93	3	25,3255	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910290	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.94	3	41,0675	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910290	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.95	3	57,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910290	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.96	3	12,0500	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910290	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.97	3	27,7950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910290	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.98	3	43,5350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910290	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.99	3	59.2779	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910291	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.92	3	2,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910291	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.01	3	21.7921	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910291	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.93	3	18,0655	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910291	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.94	3	33,8075	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910291	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.95	3	49,5495	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910291	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.96	3	4,7900	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910291	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.97	3	20,5350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910291	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.98	3	36,2750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910291	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.99	3	52,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910291	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.00	3	6.05	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910292	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.93	3	10,8055	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910292	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.02	3	30.2742	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910292	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.94	3	26,5475	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910292	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.95	3	42,2895	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910292	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.96	3	58,0315	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910292	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.97	3	13,2750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910292	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.98	3	29,0150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910292	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.99	3	45,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910292	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.00	3	59,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910292	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.01	3	14.5321	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910293	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.94	3	19,2875	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910293	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.03	3	38.7563	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910293	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.95	3	35,0295	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910293	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.96	3	50,7715	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910293	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.97	3	6,0135	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910293	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.98	3	21,7550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910293	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.99	3	37,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910293	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.00	3	52,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910293	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.01	3	7,2700	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910293	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.02	3	23.0142	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910294	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.95	3	27,7695	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910294	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.04	3	47.2384	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910294	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.96	3	43,5115	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910294	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.97	3	59,2535	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910294	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.98	3	14,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910294	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.99	3	30,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910294	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.00	3	45,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910294	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.01	3	60,5100	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910294	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.02	3	15,7550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910294	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.03	3	31.4963	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910295	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.96	3	36,2515	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910295	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.05	3	55.7205	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910295	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.97	3	51,9935	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910295	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.98	3	7,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910295	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.99	3	23,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910295	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.00	3	37,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910295	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.01	3	53,2500	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910295	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.02	3	8,4950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910295	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.03	3	24,2350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910295	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.04	3	39.9784	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910296	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.97	3	44,7335	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910296	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.06	3	3.7026	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910296	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.98	3	60,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910296	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.99	3	15,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910296	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.00	3	30,25	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910296	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.01	3	45,9900	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910296	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.02	3	1,2350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910296	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.03	3	16,9750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910296	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.04	3	33,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910296	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.05	3	48.4605	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910297	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.98	3	53,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910297	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.07	3	12.1847	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910297	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.99	3	8,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910297	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.00	3	23,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910297	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.01	3	38,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910297	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.02	3	54,4750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910297	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.03	3	9,7150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910297	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.04	3	25,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910297	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.05	3	41,2000	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910297	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.06	3	56.9426	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910298	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.99	3	61,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910298	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.08	3	20.6668	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910298	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.00	3	15,75	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910298	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.01	3	31,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910298	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.02	3	47,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910298	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.03	3	2,4550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910298	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.04	3	18,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910298	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.05	3	33,9400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910298	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.06	3	49,6850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910298	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.07	3	4.9247	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910299	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.00	3	8,45	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910299	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.09	3	29.1489	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910299	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.01	3	24,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910299	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.02	3	40,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910299	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.03	3	55,6965	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910299	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.04	3	11,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910299	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.05	3	26,6800	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910299	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.06	3	42,4250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910299	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.07	3	58,1650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910299	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.08	3	13.4068	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910300	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.01	3	17,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910300	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.10	3	37.631	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910300	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.02	3	32,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910300	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.03	3	48,4365	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910300	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.04	3	3,6785	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910300	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.05	3	19,4200	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910300	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.06	3	35,1650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910300	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.07	3	50,9050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910300	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.08	3	6,1450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910300	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.09	3	21.8889	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910301	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.02	3	25,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910301	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.11	3	46.1131	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910301	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.03	3	41,1765	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910301	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.04	3	56,9185	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910301	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.05	3	12,1605	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910301	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.06	3	27,9050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910301	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.07	3	43,6450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910301	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.08	3	59,3850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910301	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.09	3	15,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910301	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.10	3	30.371	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910302	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.03	3	33,9165	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910302	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.12	3	54.5952	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910302	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.04	3	49,6585	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910302	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.05	3	4,9005	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910302	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.06	3	20,6425	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910302	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.07	3	36,3850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910302	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.08	3	52,1250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910302	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.09	3	7,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910302	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.10	3	23,100	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910302	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.11	3	38.8531	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910303	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.04	3	42,3985	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910303	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.13	3	2.5773	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910303	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.05	3	58,1405	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910303	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.06	3	13,3825	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910303	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.07	3	29,1245	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910303	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.08	3	44,8650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910303	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.09	3	61,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910303	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.10	3	15,850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910303	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.11	3	31,5950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910303	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.12	3	47.3352	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910304	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.05	3	50,8805	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910304	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.14	3	11.0594	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910304	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.06	3	6,1225	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910304	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.07	3	21,8645	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910304	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.08	3	37,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910304	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.09	3	53,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910304	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.10	3	9,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910304	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.11	3	24,3350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910304	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.12	3	40,0750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910304	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.13	3	55.8173	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910305	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.06	3	59,3625	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910305	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.15	3	19.5415	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910305	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.07	3	14,6045	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910305	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.08	3	30,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910305	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.09	3	46,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910305	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.10	3	1,350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910305	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.11	3	17,0750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910305	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.12	3	32,8150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910305	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.13	3	48,5550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910305	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.14	3	3.7994	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910306	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.07	3	7,3445	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910306	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.16	3	28.0236	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910306	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.08	3	23,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910306	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.09	3	38,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910306	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.10	3	54,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910306	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.11	3	9,8150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910306	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.12	3	25,5550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910306	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.13	3	41,2950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910306	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.14	3	57,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910306	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.15	3	12.2815	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910307	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.08	3	15,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910307	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.17	3	36.5057	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910307	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.09	3	31,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910307	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.10	3	47,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910307	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.11	3	2,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910307	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.12	3	18,2950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910307	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.13	3	34,0350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910307	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.14	3	50,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910307	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.15	3	5,0200	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910307	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.16	3	20.7636	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910308	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.09	3	24,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910308	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.18	3	44.9878	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910308	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.10	3	40,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910308	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.11	3	55,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910308	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.12	3	11,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910308	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.13	3	26,7750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910308	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.14	3	43,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910308	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.15	3	58,2600	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910308	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.16	3	13,5050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910308	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.17	3	29.2457	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910309	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.10	3	32,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910309	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.19	3	53.4699	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910309	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.11	3	48,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910309	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.12	3	3,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910309	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.13	3	19,5175	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910309	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.14	3	35,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910309	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.15	3	51,0000	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910309	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.16	3	6,2450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910309	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.17	3	21,9850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910309	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.18	3	37.7278	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910310	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.11	3	41,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910310	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.20	3	1.452	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910310	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.12	3	57,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910310	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.13	3	12,2575	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910310	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.14	3	27,9995	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910310	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.15	3	43,7400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910310	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.16	3	59,4850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910310	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.17	3	14,7250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910310	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.18	3	30,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910310	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.19	3	46.2099	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910311	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.12	3	49,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910311	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.21	3	9.9341	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910311	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.13	3	4,9975	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910311	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.14	3	20,7395	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910311	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.15	3	36,4815	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910311	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.16	3	52,2250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910311	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.17	3	7,4650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910311	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.18	3	23,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910311	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.19	3	39,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910311	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.20	3	54.692	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910312	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.13	3	58,2375	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910312	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.22	3	18.4162	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910312	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.14	3	13,4795	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910312	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.15	3	29,2215	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910312	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.16	3	44,9635	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910312	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.17	3	60,7050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910312	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.18	3	16,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910312	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.19	3	32,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910312	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.20	3	47,450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910312	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.21	3	2.6741	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910313	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.14	3	6,2195	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910313	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.23	3	26.8983	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910313	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.15	3	21,9615	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910313	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.16	3	37,7035	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910313	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.17	3	53,4455	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910313	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.18	3	9,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910313	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.19	3	24,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910313	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.20	3	40,150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910313	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.21	3	55,9150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910313	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.22	3	11.1562	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910314	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.15	3	14,7015	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910314	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.24	3	35.3804	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910314	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.16	3	30,4435	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910314	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.17	3	46,1855	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910314	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.18	3	1,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910314	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.19	3	17,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910314	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.20	3	32,900	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910314	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.21	3	48,6550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910314	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.22	3	3,8950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910314	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.23	3	19.6383	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910315	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.16	3	23,1835	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910315	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.25	3	43.8625	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910315	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.17	3	38,9255	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910315	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.18	3	54,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910315	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.19	3	9,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910315	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.20	3	25,650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910315	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.21	3	41,3950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910315	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.22	3	57,1350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910315	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.23	3	12,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910315	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.24	3	28.1204	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910316	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.17	3	31,6655	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910316	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.26	3	52.3446	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910316	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.18	3	47,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910316	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.19	3	2,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910316	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.20	3	18,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910316	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.21	3	34,1350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910316	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.22	3	49,8750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910316	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.23	3	5,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910316	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.24	3	20,8600	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910316	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.25	3	36.6025	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910317	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.18	3	40,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910317	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.27	3	60.8267	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910317	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.19	3	55,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910317	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.20	3	11,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910317	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.21	3	26,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910317	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.22	3	42,6150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910317	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.23	3	58,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910317	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.24	3	13,6000	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910317	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.25	3	29,3400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910317	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.26	3	45.0846	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910318	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.19	3	48,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910318	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.28	3	8.8088	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910318	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.20	3	3,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910318	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.21	3	19,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910318	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.22	3	35,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910318	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.23	3	51,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910318	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.24	3	6,3400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910318	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.25	3	22,0800	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910318	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.26	3	37,8250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910318	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.27	3	53.5667	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910319	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.20	3	57,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910319	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.29	3	17.2909	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910319	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.21	3	12,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910319	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.22	3	28,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910319	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.23	3	43,8385	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910319	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.24	3	59,5800	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910319	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.25	3	14,8200	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910319	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.26	3	30,5650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910319	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.27	3	46,3050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910319	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.28	3	1.5488	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910320	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.21	3	5,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910320	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.30	3	25.773	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910320	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.22	3	20,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910320	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.23	3	36,5785	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910320	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.24	3	52,3205	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910320	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.25	3	7,5600	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910320	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.26	3	23,3050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910320	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.27	3	39,0450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910320	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.28	3	55,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910320	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.29	3	10.0309	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910321	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.22	3	13,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910321	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.31	3	34.2551	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910321	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.23	3	29,3185	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910321	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.24	3	45,0605	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910321	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.25	3	60,8025	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910321	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.26	3	16,0450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910321	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.27	3	31,7850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910321	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.28	3	48,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910321	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.29	3	2,7700	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910321	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.30	3	18.513	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910322	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.23	3	22,0585	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910322	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.32	3	42.7372	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910322	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.24	3	37,8005	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910322	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.25	3	53,5425	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910322	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.26	3	8,7845	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910322	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.27	3	24,5250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910322	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.28	3	40,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910322	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.29	3	56,0100	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910322	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.30	3	11,250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910322	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.31	3	26.9951	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910323	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.24	3	30,5405	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910323	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.33	3	51.2193	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910323	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.25	3	46,2825	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910323	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.26	3	1,5245	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910323	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.27	3	17,2665	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910323	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.28	3	33,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910323	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.29	3	48,7500	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910323	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.30	3	4,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910323	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.31	3	19,7350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910323	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.32	3	35.4772	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910324	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.25	3	39,0225	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910324	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.34	3	59.7014	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910324	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.26	3	54,7645	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910324	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.27	3	10,0065	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910324	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.28	3	25,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910324	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.29	3	41,4900	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910324	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.30	3	57,250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910324	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.31	3	12,4750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910324	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.32	3	28,2150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910324	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.33	3	43.9593	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910325	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.26	3	47,5045	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910325	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.35	3	7.6835	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910325	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.27	3	2,7465	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910325	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.28	3	18,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910325	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.29	3	34,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910325	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.30	3	49,950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910325	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.31	3	5,2150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910325	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.32	3	20,9550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910325	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.33	3	37,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910325	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.34	3	52.4414	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910326	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.27	3	55,9865	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910326	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.36	3	16.1656	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910326	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.28	3	11,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910326	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.29	3	27,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910326	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.30	3	42,715	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910326	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.31	3	58,4550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910326	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.32	3	13,6950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910326	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.33	3	29,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910326	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.34	3	45,1800	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910326	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.35	3	60.9235	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910327	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.28	3	4,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910327	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.37	3	24.6477	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910327	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.29	3	19,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910327	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.30	3	35,455	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910327	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.31	3	51,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910327	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.32	3	6,4350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910327	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.33	3	22,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910327	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.34	3	37,9200	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910327	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.35	3	53,6650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910327	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.36	3	8.9056	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910328	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.29	3	12,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910328	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.38	3	33.1298	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910328	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.30	3	28,195	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910328	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.31	3	43,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910328	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.32	3	59,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910328	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.33	3	15,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910328	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.34	3	30,6600	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910328	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.35	3	46,4050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910328	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.36	3	1,6450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910328	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.37	3	17.3877	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910329	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.30	3	20,935	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910329	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.39	3	41.6119	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910329	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.31	3	36,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910329	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.32	3	52,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910329	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.33	3	7,6595	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910329	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.34	3	23,4000	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910329	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.35	3	39,1450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910329	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.36	3	54,8850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910329	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.37	3	10,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910329	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.38	3	25.8698	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910330	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.31	3	29,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910330	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.40	3	50.094	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910330	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.32	3	45,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910330	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.33	3	60,8995	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910330	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.34	3	16,1415	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910330	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.35	3	31,8850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910330	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.36	3	47,6250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910330	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.37	3	3,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910330	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.38	3	19,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910330	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.39	3	34.3519	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910331	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.32	3	37,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910331	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.41	3	58.5761	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910331	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.33	3	53,6395	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910331	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.34	3	8,8815	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910331	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.35	3	24,6235	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910331	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.36	3	40,3650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910331	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.37	3	56,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910331	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.38	3	11,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910331	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.39	3	27,0900	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910331	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.40	3	42.834	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910332	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.33	3	46,3795	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910332	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.42	3	6.5582	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910332	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.34	3	1,6215	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910332	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.35	3	17,3635	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910332	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.36	3	33,1055	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910332	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.37	3	49,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910332	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.38	3	4,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910332	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.39	3	19,8300	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910332	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.40	3	35,550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910332	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.41	3	51.3161	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910333	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.34	3	54,8615	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910333	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.43	3	15.0403	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910333	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.35	3	10,1035	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910333	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.36	3	25,8455	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910333	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.37	3	41,5875	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910333	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.38	3	57,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910333	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.39	3	12,5700	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910333	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.40	3	28,300	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910333	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.41	3	44,0550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910333	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.42	3	59.7982	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910334	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.35	3	2,8435	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910334	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.44	3	23.5224	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910334	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.36	3	18,5855	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910334	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.37	3	34,3275	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910334	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.38	3	50,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910334	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.39	3	5,3100	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910334	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.40	3	21,050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910334	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.41	3	36,7950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910334	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.42	3	53,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910334	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.43	3	7.7803	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910335	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.36	3	11,3255	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910335	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.45	3	32.0045	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910335	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.37	3	27,0675	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910335	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.38	3	42,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910335	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.39	3	58,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910335	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.40	3	14,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910335	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.41	3	29,5350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910335	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.42	3	45,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910335	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.43	3	61,0200	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910335	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.44	3	16.2624	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910336	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.37	3	19,8075	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910336	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.46	3	40.4866	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910336	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.38	3	35,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910336	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.39	3	51,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910336	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.40	3	6,535	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910336	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.41	3	22,2750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910336	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.42	3	38,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910336	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.43	3	53,7600	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910336	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.44	3	9,0000	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910336	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.45	3	24.7445	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910337	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.38	3	28,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910337	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.47	3	48.9687	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910337	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.39	3	44,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910337	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.40	3	59,775	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910337	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.41	3	15,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910337	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.42	3	31,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910337	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.43	3	46,5000	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910337	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.44	3	1,7400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910337	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.45	3	17,4850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910337	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.46	3	33.2266	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910338	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.39	3	36,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910338	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.48	3	57.4508	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910338	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.40	3	52,515	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910338	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.41	3	7,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910338	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.42	3	23,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910338	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.43	3	39,2400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910338	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.44	3	54,9800	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910338	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.45	3	10,2250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910338	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.46	3	25,9650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910338	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.47	3	41.7087	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910339	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.40	3	45,255	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910339	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.49	3	5.4329	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910339	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.41	3	61,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910339	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.42	3	16,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910339	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.43	3	31,9805	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910339	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.44	3	47,7200	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910339	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.45	3	2,9650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910339	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.46	3	18,7050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910339	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.47	3	34,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910339	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.48	3	50.1908	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910340	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.41	3	53,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910340	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.50	3	13.915	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910340	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.42	3	9,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910340	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.43	3	24,7205	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910340	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.44	3	40,4625	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910340	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.45	3	56,2050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910340	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.46	3	11,4450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910340	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.47	3	27,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910340	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.48	3	42,9300	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910340	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.49	3	58.6729	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910341	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.42	3	1,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910341	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.51	3	22.3971	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910341	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.43	3	17,4605	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910341	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.44	3	33,2025	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910341	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.45	3	48,9445	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910341	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.46	3	4,1850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910341	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.47	3	20,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910341	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.48	3	35,6700	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910341	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.49	3	51,4150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910341	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.50	3	6.655	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910342	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.43	3	10,2005	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910342	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.52	3	30.8792	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910342	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.44	3	25,9425	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910342	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.45	3	41,6845	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910342	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.46	3	57,4265	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910342	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.47	3	13,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910342	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.48	3	28,4100	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910342	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.49	3	44,1550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910342	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.50	3	60,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910342	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.51	3	15.1371	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910343	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.44	3	18,6825	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910343	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.53	3	39.3613	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910343	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.45	3	34,4245	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910343	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.46	3	50,1665	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910343	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.47	3	5,4085	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910343	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.48	3	21,1500	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910343	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.49	3	36,8950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910343	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.50	3	52,650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910343	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.51	3	7,8750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910343	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.52	3	23.6192	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910344	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.45	3	27,1645	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910344	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.54	3	47.8434	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910344	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.46	3	42,9065	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910344	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.47	3	58,6485	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910344	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.48	3	13,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910344	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.49	3	29,6350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910344	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.50	3	45,350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910344	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.51	3	61,1150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910344	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.52	3	16,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910344	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.53	3	32.1013	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910345	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.46	3	35,6465	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910345	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.55	3	56.3255	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910345	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.47	3	51,3885	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910345	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.48	3	6,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910345	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.49	3	22,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910345	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.50	3	38,100	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910345	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.51	3	53,8550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910345	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.52	3	9,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910345	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.53	3	24,8400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910345	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.54	3	40.5834	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910346	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.47	3	44,1285	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910346	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.56	3	4.3076	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910346	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.48	3	59,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910346	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.49	3	15,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910346	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.50	3	30,855	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910346	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.51	3	46,5950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910346	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.52	3	2,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910346	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.53	3	17,5800	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910346	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.54	3	33,3250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910346	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.55	3	49.0655	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910347	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.48	3	52,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910347	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.57	3	12.7897	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910347	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.49	3	7,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910347	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.50	3	23,595	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910347	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.51	3	39,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910347	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.52	3	55,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910347	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.53	3	10,3200	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910347	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.54	3	26,0650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910347	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.55	3	41,8050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910347	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.56	3	57.5476	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910348	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.49	3	61,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910348	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.58	3	21.2718	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910348	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.50	3	16,335	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910348	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.51	3	32,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910348	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.52	3	47,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910348	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.53	3	3,0600	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910348	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.54	3	18,8050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910348	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.55	3	34,5450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910348	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.56	3	50,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910348	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.57	3	5.5297	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910349	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.50	3	9,075	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910349	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.59	3	29.7539	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910349	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.51	3	24,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910349	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.52	3	40,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910349	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.53	3	56,3015	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910349	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.54	3	11,5450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910349	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.55	3	27,2850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910349	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.56	3	43,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910349	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.57	3	59,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910349	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.58	3	14.0118	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910350	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.51	3	17,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910350	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.60	3	38.236	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910350	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.52	3	33,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910350	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.53	3	49,0415	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910350	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.54	3	4,2835	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910350	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.55	3	20,0250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910350	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.56	3	36,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910350	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.57	3	52,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910350	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.58	3	6,7500	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910350	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.59	3	22.4939	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910351	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.52	3	26,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910351	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.61	3	46.7181	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910351	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.53	3	41,7815	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910351	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.54	3	57,5235	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910351	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.55	3	12,7655	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910351	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.56	3	29,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910351	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.57	3	44,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910351	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.58	3	59,9900	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910351	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.59	3	15,2350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910351	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.60	3	30.976	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910352	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.53	3	34,5215	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910352	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.62	3	55.2002	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910352	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.54	3	50,2635	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910352	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.55	3	5,5055	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910352	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.56	3	21,2475	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910352	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.57	3	37,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910352	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.58	3	52,7300	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910352	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.59	3	7,9750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910352	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.60	3	23,700	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910352	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.61	3	39.4581	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910353	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.54	3	43,0035	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910353	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.63	3	3.1823	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910353	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.55	3	58,7455	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910353	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.56	3	13,9875	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910353	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.57	3	29,7295	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910353	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.58	3	45,4700	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910353	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.59	3	61,2150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910353	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.60	3	16,450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910353	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.61	3	32,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910353	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.62	3	47.9402	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910354	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.55	3	51,4855	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910354	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.64	3	11.6644	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910354	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.56	3	6,7275	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910354	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.57	3	22,4695	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910354	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.58	3	38,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910354	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.59	3	53,9550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910354	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.60	3	9,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910354	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.61	3	25,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910354	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.62	3	40,6800	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910354	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.63	3	56.4223	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910355	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.56	3	59,9675	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910355	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.65	3	20.1465	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910355	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.57	3	15,2095	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910355	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.58	3	31,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910355	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.59	3	46,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910355	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.60	3	1,950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910355	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.61	3	18,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910355	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.62	3	33,4200	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910355	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.63	3	49,1600	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910355	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.64	3	4.4044	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910356	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.57	3	7,9495	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910356	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.66	3	28.6286	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910356	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.58	3	23,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910356	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.59	3	39,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910356	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.60	3	55,175	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910356	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.61	3	10,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910356	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.62	3	26,1600	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910356	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.63	3	41,9000	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910356	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.64	3	57,6450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910356	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.65	3	12.8865	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910357	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.58	3	16,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910357	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.67	3	37.1107	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910357	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.59	3	32,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910357	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.60	3	47,915	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910357	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.61	3	3,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910357	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.62	3	18,9000	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910357	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.63	3	34,6400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910357	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.64	3	50,3850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910357	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.65	3	5,6250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910357	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.66	3	21.3686	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910358	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.59	3	24,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910358	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.68	3	45.5928	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910358	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.60	3	40,655	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910358	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.61	3	56,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910358	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.62	3	11,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910358	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.63	3	27,3800	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910358	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.64	3	43,1250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910358	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.65	3	58,8650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910358	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.66	3	14,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910358	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.67	3	29.8507	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910359	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.60	3	33,395	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910359	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.69	3	54.0749	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910359	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.61	3	49,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910359	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.62	3	4,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910359	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.63	3	20,1225	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910359	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.64	3	35,8650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910359	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.65	3	51,6050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910359	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.66	3	7,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910359	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.67	3	22,5900	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910359	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.68	3	38.3328	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910360	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.61	3	41,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910360	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.70	3	2.057	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910360	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.62	3	57,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910360	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.63	3	12,8625	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910360	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.64	3	28,6045	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910360	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.65	3	44,3450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910360	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.66	3	60,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910360	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.67	3	15,3300	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910360	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.68	3	31,0750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910360	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.69	3	46.8149	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910361	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.62	3	50,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910361	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.71	3	10.5391	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910361	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.63	3	5,6025	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910361	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.64	3	21,3445	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910361	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.65	3	37,0865	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910361	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.66	3	53,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910361	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.67	3	8,0700	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910361	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.68	3	23,8150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910361	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.69	3	39,5550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910361	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.70	3	55.297	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910362	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.63	3	58,8425	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910362	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.72	3	19.0212	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910362	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.64	3	14,0845	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910362	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.65	3	29,8265	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910362	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.66	3	45,5685	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910362	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.67	3	61,3100	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910362	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.68	3	16,5550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910362	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.69	3	32,2950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910362	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.70	3	48,050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910362	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.71	3	3.2791	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910363	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.64	3	6,8245	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910363	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.73	3	27.5033	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910363	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.65	3	22,5665	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910363	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.66	3	38,3085	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910363	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.67	3	54,0505	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910363	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.68	3	9,2950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910363	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.69	3	25,0350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910363	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.70	3	41,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910363	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.71	3	57,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910363	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.72	3	11.7612	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910364	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.65	3	15,3065	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910364	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.74	3	35.9854	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910364	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.66	3	31,0485	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910364	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.67	3	46,7905	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910364	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.68	3	2,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910364	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.69	3	17,7750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910364	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.70	3	33,500	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910364	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.71	3	49,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910364	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.72	3	4,5000	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910364	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.73	3	20.2433	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910365	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.66	3	23,7885	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910365	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.75	3	44.4675	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910365	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.67	3	39,5305	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910365	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.68	3	55,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910365	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.69	3	10,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910365	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.70	3	26,250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910365	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.71	3	42,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910365	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.72	3	57,7400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910365	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.73	3	12,9850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910365	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.74	3	28.7254	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910366	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.67	3	32,2705	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910366	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.76	3	52.9496	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910366	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.68	3	48,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910366	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.69	3	3,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910366	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.70	3	18,995	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910366	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.71	3	35,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910366	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.72	3	50,4800	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910366	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.73	3	5,7250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910366	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.74	3	21,4650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910366	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.75	3	37.2075	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910367	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.68	3	40,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910367	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.77	3	61.4317	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910367	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.69	3	56,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910367	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.70	3	11,735	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910367	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.71	3	27,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910367	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.72	3	43,2200	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910367	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.73	3	58,9650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910367	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.74	3	14,2050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910367	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.75	3	29,9450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910367	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.76	3	45.6896	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910368	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.69	3	49,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910368	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.78	3	9.4138	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910368	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.70	3	4,475	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910368	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.71	3	20,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910368	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.72	3	36,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910368	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.73	3	51,7050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910368	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.74	3	6,9450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910368	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.75	3	22,6850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910368	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.76	3	38,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910368	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.77	3	54.1717	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910369	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.70	3	57,715	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910369	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.79	3	17.8959	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910369	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.71	3	13,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910369	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.72	3	28,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910369	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.73	3	44,4435	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910369	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.74	3	60,1850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910369	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.75	3	15,4250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910369	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.76	3	31,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910369	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.77	3	46,9100	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910369	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.78	3	2.1538	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910370	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.71	3	5,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910370	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.80	3	26.378	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910370	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.72	3	21,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910370	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.73	3	37,1835	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910370	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.74	3	52,9255	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910370	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.75	3	8,1650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910370	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.76	3	24,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910370	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.77	3	39,6500	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910370	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.78	3	55,3950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910370	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.79	3	10.6359	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910371	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.72	3	14,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910371	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.81	3	34.8601	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910371	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.73	3	29,9235	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910371	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.74	3	45,6655	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910371	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.75	3	61,4075	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910371	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.76	3	17,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910371	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.77	3	32,3900	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910371	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.78	3	48,1350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910371	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.79	3	3,3750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910371	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.80	3	19.118	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910372	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.73	3	22,6635	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910372	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.82	3	43.3422	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910372	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.74	3	38,4055	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910372	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.75	3	54,1475	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910372	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.76	3	9,3895	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910372	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.77	3	25,1300	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910372	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.78	3	40,8750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910372	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.79	3	56,6150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910372	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.80	3	11,850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910372	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.81	3	27.6001	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910373	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.74	3	31,1455	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910373	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.83	3	51.8243	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910373	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.75	3	46,8875	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910373	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.76	3	2,1295	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910373	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.77	3	17,8715	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910373	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.78	3	33,6150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910373	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.79	3	49,3550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910373	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.80	3	5,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910373	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.81	3	20,3400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910373	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.82	3	36.0822	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910374	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.75	3	39,6275	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910374	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.84	3	60.3064	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910374	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.76	3	55,3695	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910374	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.77	3	10,6115	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910374	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.78	3	26,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910374	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.79	3	42,0950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910374	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.80	3	57,850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910374	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.81	3	13,0800	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910374	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.82	3	28,8200	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910374	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.83	3	44.5643	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910375	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.76	3	48,1095	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910375	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.85	3	8.2885	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910375	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.77	3	3,3515	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910375	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.78	3	19,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910375	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.79	3	34,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910375	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.80	3	51,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910375	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.81	3	5,8200	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910375	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.82	3	21,5600	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910375	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.83	3	37,3050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910375	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.84	3	53.0464	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910376	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.77	3	56,5915	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910376	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.86	3	16.7706	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910376	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.78	3	11,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910376	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.79	3	27,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910376	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.80	3	43,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910376	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.81	3	59,0600	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910376	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.82	3	14,3000	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910376	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.83	3	30,0450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910376	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.84	3	45,7850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910376	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.85	3	61.5285	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910377	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.78	3	4,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910377	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.87	3	25.2527	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910377	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.79	3	20,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910377	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.80	3	36,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910377	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.81	3	51,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910377	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.82	3	7,0400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910377	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.83	3	22,7850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910377	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.84	3	38,5250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910377	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.85	3	54,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910377	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.86	3	9.5106	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910378	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.79	3	13,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910378	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.88	3	33.7348	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910378	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.80	3	28,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910378	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.81	3	44,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910378	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.82	3	60,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910378	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.83	3	15,5250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910378	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.84	3	31,2650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910378	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.85	3	47,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910378	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.86	3	2,2500	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910378	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.87	3	17.9927	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910379	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.80	3	21,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910379	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.89	3	42.2169	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910379	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.81	3	37,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910379	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.82	3	53,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910379	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.83	3	8,2645	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910379	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.84	3	24,0050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910379	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.85	3	40,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910379	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.86	3	55,4900	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910379	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.87	3	10,7350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910379	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.88	3	26.4748	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910380	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.81	3	30,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910380	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.90	3	50.699	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910380	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.82	3	45,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910380	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.83	3	61,5045	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910380	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.84	3	16,7465	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910380	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.85	3	32,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910380	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.86	3	48,2300	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910380	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.87	3	3,4750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910380	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.88	3	19,2150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910380	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.89	3	34.9569	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910381	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.82	3	38,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910381	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.91	3	59.1811	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910381	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.83	3	54,2445	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910381	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.84	3	9,4865	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910381	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.85	3	25,2285	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910381	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.86	3	40,9700	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910381	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.87	3	56,7150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910381	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.88	3	11,9550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910381	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.89	3	27,6950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910381	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.90	3	43.439	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910382	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.83	3	46,9845	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910382	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.92	3	7.1632	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910382	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.84	3	2,2265	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910382	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.85	3	17,9685	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910382	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.86	3	33,7105	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910382	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.87	3	49,4550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910382	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.88	3	4,6950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910382	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.89	3	20,4350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910382	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.90	3	36,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910382	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.91	3	51.9211	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910383	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.84	3	55,4665	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910383	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.93	3	15.6453	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910383	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.85	3	10,7085	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910383	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.86	3	26,4505	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910383	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.87	3	42,1925	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910383	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.88	3	57,9350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910383	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.89	3	13,1750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910383	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.90	3	28,900	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910383	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.91	3	44,6600	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910383	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.92	3	60.4032	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910384	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.85	3	3,4485	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910384	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.94	3	24.1274	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910384	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.86	3	19,1905	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910384	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.87	3	34,9325	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910384	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.88	3	50,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910384	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.89	3	5,9150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910384	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.90	3	21,650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910384	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.91	3	37,4000	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910384	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.92	3	53,1450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910384	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.93	3	8.3853	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910385	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.86	3	11,9305	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910385	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.95	3	32.6095	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910385	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.87	3	27,6725	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910385	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.88	3	43,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910385	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.89	3	59,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910385	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.90	3	14,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910385	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.91	3	30,1400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910385	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.92	3	45,8850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910385	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.93	3	61,6250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910385	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.94	3	16.8674	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910386	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.87	3	20,4125	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910386	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.96	3	41.0916	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910386	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.88	3	36,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910386	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.89	3	51,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910386	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.90	3	7,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910386	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.91	3	22,8800	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910386	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.92	3	38,6250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910386	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.93	3	54,3650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910386	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.94	3	9,6050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910386	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.95	3	25.3495	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910387	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.88	3	28,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910387	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.97	3	49.5737	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910387	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.89	3	44,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910387	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.90	3	60,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910387	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.91	3	15,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910387	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.92	3	31,3650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910387	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.93	3	47,1050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910387	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.94	3	2,3450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910387	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.95	3	18,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910387	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.96	3	33.8316	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910388	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.89	3	37,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910388	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.98	3	58.0558	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910388	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.90	3	53,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910388	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.91	3	8,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910388	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.92	3	24,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910388	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.93	3	39,8450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910388	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.94	3	55,5850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910388	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.95	3	11,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910388	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.96	3	26,5700	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910388	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.97	3	42.3137	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910389	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.90	3	45,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910389	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.99	3	6.0379	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910389	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.91	3	61,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910389	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.92	3	16,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910389	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.93	3	32,5855	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910389	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.94	3	48,3250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910389	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.95	3	4,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910389	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.96	3	19,3100	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910389	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.97	3	35,0550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910389	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.98	3	50.7958	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910390	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.91	3	54,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910390	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.00	3	13.31	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910390	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.92	3	9,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910390	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.93	3	25,3255	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910390	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.94	3	41,0675	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910390	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.95	3	57,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910390	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.96	3	12,0500	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910390	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.97	3	27,7950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910390	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.98	3	43,5350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910390	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.99	3	59.2779	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910391	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.92	3	2,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910391	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.01	3	21.7921	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910391	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.93	3	18,0655	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910391	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.94	3	33,8075	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910391	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.95	3	49,5495	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910391	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.96	3	4,7900	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910391	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.97	3	20,5350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910391	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.98	3	36,2750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910391	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.99	3	52,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910391	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.00	3	6.05	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910392	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.93	3	10,8055	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910392	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.02	3	30.2742	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910392	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.94	3	26,5475	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910392	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.95	3	42,2895	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910392	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.96	3	58,0315	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910392	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.97	3	13,2750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910392	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.98	3	29,0150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910392	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.99	3	45,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910392	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.00	3	59,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910392	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.01	3	14.5321	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910393	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.94	3	19,2875	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910393	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.03	3	38.7563	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910393	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.95	3	35,0295	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910393	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.96	3	50,7715	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910393	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.97	3	6,0135	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910393	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.98	3	21,7550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910393	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.99	3	37,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910393	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.00	3	52,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910393	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.01	3	7,2700	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910393	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.02	3	23.0142	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910394	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.95	3	27,7695	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910394	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.04	3	47.2384	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910394	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.96	3	43,5115	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910394	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.97	3	59,2535	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910394	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.98	3	14,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910394	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.99	3	30,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910394	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.00	3	45,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910394	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.01	3	60,5100	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910394	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.02	3	15,7550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910394	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.03	3	31.4963	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910395	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.96	3	36,2515	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910395	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.05	3	55.7205	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910395	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.97	3	51,9935	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910395	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.98	3	7,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910395	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.99	3	23,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910395	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.00	3	37,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910395	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.01	3	53,2500	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910395	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.02	3	8,4950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910395	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.03	3	24,2350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910395	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.04	3	39.9784	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910396	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.97	3	44,7335	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910396	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.06	3	3.7026	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910396	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.98	3	60,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910396	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.99	3	15,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910396	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.00	3	30,25	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910396	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.01	3	45,9900	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910396	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.02	3	1,2350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910396	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.03	3	16,9750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910396	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.04	3	33,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910396	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.05	3	48.4605	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910397	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.98	3	53,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910397	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.07	3	12.1847	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910397	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.99	3	8,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910397	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.00	3	23,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910397	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.01	3	38,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910397	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.02	3	54,4750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910397	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.03	3	9,7150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910397	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.04	3	25,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910397	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.05	3	41,2000	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910397	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.06	3	56.9426	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910398	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.99	3	61,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910398	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.08	3	20.6668	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910398	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.00	3	15,75	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910398	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.01	3	31,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910398	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.02	3	47,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910398	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.03	3	2,4550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910398	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.04	3	18,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910398	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.05	3	33,9400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910398	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.06	3	49,6850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910398	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.07	3	4.9247	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910399	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.00	3	8,45	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910399	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.09	3	29.1489	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910399	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.01	3	24,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910399	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.02	3	40,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910399	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.03	3	55,6965	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910399	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.04	3	11,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910399	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.05	3	26,6800	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910399	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.06	3	42,4250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910399	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.07	3	58,1650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910399	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.08	3	13.4068	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910400	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.01	3	17,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910400	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.10	3	37.631	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910400	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.02	3	32,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910400	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.03	3	48,4365	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910400	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.04	3	3,6785	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910400	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.05	3	19,4200	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910400	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.06	3	35,1650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910400	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.07	3	50,9050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910400	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.08	3	6,1450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910400	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.09	3	21.8889	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910401	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.02	3	25,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910401	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.11	3	46.1131	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910401	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.03	3	41,1765	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910401	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.04	3	56,9185	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910401	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.05	3	12,1605	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910401	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.06	3	27,9050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910401	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.07	3	43,6450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910401	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.08	3	59,3850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910401	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.09	3	15,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910401	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.10	3	30.371	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910402	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.03	3	33,9165	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910402	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.12	3	54.5952	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910402	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.04	3	49,6585	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910402	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.05	3	4,9005	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910402	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.06	3	20,6425	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910402	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.07	3	36,3850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910402	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.08	3	52,1250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910402	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.09	3	7,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910402	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.10	3	23,100	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910402	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.11	3	38.8531	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910403	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.04	3	42,3985	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910403	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.13	3	2.5773	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910403	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.05	3	58,1405	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910403	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.06	3	13,3825	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910403	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.07	3	29,1245	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910403	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.08	3	44,8650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910403	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.09	3	61,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910403	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.10	3	15,850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910403	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.11	3	31,5950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910403	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.12	3	47.3352	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910404	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.05	3	50,8805	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910404	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.14	3	11.0594	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910404	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.06	3	6,1225	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910404	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.07	3	21,8645	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910404	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.08	3	37,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910404	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.09	3	53,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910404	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.10	3	9,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910404	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.11	3	24,3350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910404	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.12	3	40,0750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910404	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.13	3	55.8173	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910405	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.06	3	59,3625	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910405	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.15	3	19.5415	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910405	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.07	3	14,6045	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910405	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.08	3	30,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910405	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.09	3	46,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910405	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.10	3	1,350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910405	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.11	3	17,0750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910405	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.12	3	32,8150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910405	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.13	3	48,5550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910405	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.14	3	3.7994	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910406	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.07	3	7,3445	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910406	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.16	3	28.0236	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910406	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.08	3	23,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910406	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.09	3	38,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910406	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.10	3	54,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910406	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.11	3	9,8150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910406	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.12	3	25,5550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910406	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.13	3	41,2950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910406	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.14	3	57,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910406	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.15	3	12.2815	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910407	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.08	3	15,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910407	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.17	3	36.5057	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910407	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.09	3	31,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910407	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.10	3	47,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910407	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.11	3	2,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910407	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.12	3	18,2950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910407	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.13	3	34,0350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910407	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.14	3	50,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910407	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.15	3	5,0200	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910407	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.16	3	20.7636	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910408	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.09	3	24,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910408	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.18	3	44.9878	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910408	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.10	3	40,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910408	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.11	3	55,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910408	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.12	3	11,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910408	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.13	3	26,7750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910408	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.14	3	43,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910408	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.15	3	58,2600	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910408	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.16	3	13,5050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910408	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.17	3	29.2457	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910409	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.10	3	32,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910409	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.19	3	53.4699	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910409	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.11	3	48,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910409	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.12	3	3,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910409	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.13	3	19,5175	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910409	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.14	3	35,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910409	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.15	3	51,0000	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910409	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.16	3	6,2450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910409	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.17	3	21,9850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910409	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.18	3	37.7278	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910410	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.11	3	41,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910410	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.20	3	1.452	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910410	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.12	3	57,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910410	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.13	3	12,2575	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910410	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.14	3	27,9995	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910410	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.15	3	43,7400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910410	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.16	3	59,4850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910410	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.17	3	14,7250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910410	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.18	3	30,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910410	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.19	3	46.2099	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910411	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.12	3	49,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910411	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.21	3	9.9341	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910411	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.13	3	4,9975	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910411	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.14	3	20,7395	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910411	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.15	3	36,4815	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910411	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.16	3	52,2250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910411	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.17	3	7,4650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910411	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.18	3	23,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910411	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.19	3	39,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910411	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.20	3	54.692	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910412	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.13	3	58,2375	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910412	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.22	3	18.4162	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910412	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.14	3	13,4795	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910412	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.15	3	29,2215	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910412	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.16	3	44,9635	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910412	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.17	3	60,7050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910412	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.18	3	16,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910412	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.19	3	32,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910412	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.20	3	47,450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910412	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.21	3	2.6741	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910413	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.14	3	6,2195	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910413	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.23	3	26.8983	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910413	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.15	3	21,9615	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910413	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.16	3	37,7035	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910413	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.17	3	53,4455	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910413	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.18	3	9,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910413	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.19	3	24,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910413	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.20	3	40,150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910413	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.21	3	55,9150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910413	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.22	3	11.1562	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910414	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.15	3	14,7015	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910414	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.24	3	35.3804	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910414	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.16	3	30,4435	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910414	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.17	3	46,1855	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910414	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.18	3	1,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910414	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.19	3	17,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910414	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.20	3	32,900	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910414	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.21	3	48,6550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910414	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.22	3	3,8950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910414	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.23	3	19.6383	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910415	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.16	3	23,1835	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910415	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.25	3	43.8625	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910415	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.17	3	38,9255	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910415	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.18	3	54,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910415	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.19	3	9,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910415	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.20	3	25,650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910415	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.21	3	41,3950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910415	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.22	3	57,1350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910415	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.23	3	12,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910415	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.24	3	28.1204	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910416	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.17	3	31,6655	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910416	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.26	3	52.3446	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910416	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.18	3	47,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910416	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.19	3	2,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910416	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.20	3	18,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910416	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.21	3	34,1350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910416	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.22	3	49,8750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910416	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.23	3	5,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910416	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.24	3	20,8600	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910416	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.25	3	36.6025	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910417	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.18	3	40,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910417	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.27	3	60.8267	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910417	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.19	3	55,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910417	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.20	3	11,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910417	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.21	3	26,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910417	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.22	3	42,6150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910417	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.23	3	58,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910417	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.24	3	13,6000	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910417	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.25	3	29,3400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910417	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.26	3	45.0846	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910418	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.19	3	48,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910418	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.28	3	8.8088	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910418	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.20	3	3,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910418	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.21	3	19,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910418	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.22	3	35,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910418	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.23	3	51,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910418	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.24	3	6,3400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910418	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.25	3	22,0800	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910418	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.26	3	37,8250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910418	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.27	3	53.5667	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910419	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.20	3	57,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910419	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.29	3	17.2909	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910419	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.21	3	12,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910419	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.22	3	28,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910419	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.23	3	43,8385	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910419	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.24	3	59,5800	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910419	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.25	3	14,8200	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910419	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.26	3	30,5650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910419	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.27	3	46,3050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910419	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.28	3	1.5488	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910420	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.21	3	5,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910420	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.30	3	25.773	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910420	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.22	3	20,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910420	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.23	3	36,5785	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910420	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.24	3	52,3205	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910420	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.25	3	7,5600	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910420	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.26	3	23,3050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910420	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.27	3	39,0450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910420	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.28	3	55,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910420	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.29	3	10.0309	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910421	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.22	3	13,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910421	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.31	3	34.2551	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910421	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.23	3	29,3185	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910421	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.24	3	45,0605	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910421	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.25	3	60,8025	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910421	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.26	3	16,0450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910421	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.27	3	31,7850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910421	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.28	3	48,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910421	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.29	3	2,7700	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910421	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.30	3	18.513	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910422	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.23	3	22,0585	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910422	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.32	3	42.7372	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910422	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.24	3	37,8005	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910422	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.25	3	53,5425	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910422	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.26	3	8,7845	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910422	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.27	3	24,5250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910422	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.28	3	40,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910422	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.29	3	56,0100	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910422	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.30	3	11,250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910422	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.31	3	26.9951	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910423	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.24	3	30,5405	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910423	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.33	3	51.2193	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910423	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.25	3	46,2825	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910423	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.26	3	1,5245	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910423	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.27	3	17,2665	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910423	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.28	3	33,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910423	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.29	3	48,7500	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910423	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.30	3	4,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910423	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.31	3	19,7350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910423	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.32	3	35.4772	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910424	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.25	3	39,0225	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910424	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.34	3	59.7014	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910424	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.26	3	54,7645	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910424	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.27	3	10,0065	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910424	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.28	3	25,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910424	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.29	3	41,4900	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910424	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.30	3	57,250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910424	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.31	3	12,4750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910424	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.32	3	28,2150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910424	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.33	3	43.9593	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910425	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.26	3	47,5045	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910425	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.35	3	7.6835	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910425	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.27	3	2,7465	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910425	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.28	3	18,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910425	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.29	3	34,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910425	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.30	3	49,950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910425	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.31	3	5,2150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910425	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.32	3	20,9550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910425	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.33	3	37,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910425	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.34	3	52.4414	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910426	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.27	3	55,9865	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910426	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.36	3	16.1656	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910426	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.28	3	11,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910426	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.29	3	27,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910426	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.30	3	42,715	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910426	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.31	3	58,4550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910426	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.32	3	13,6950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910426	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.33	3	29,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910426	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.34	3	45,1800	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910426	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.35	3	60.9235	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910427	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.28	3	4,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910427	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.37	3	24.6477	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910427	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.29	3	19,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910427	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.30	3	35,455	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910427	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.31	3	51,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910427	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.32	3	6,4350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910427	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.33	3	22,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910427	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.34	3	37,9200	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910427	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.35	3	53,6650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910427	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.36	3	8.9056	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910428	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.29	3	12,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910428	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.38	3	33.1298	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910428	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.30	3	28,195	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910428	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.31	3	43,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910428	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.32	3	59,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910428	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.33	3	15,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910428	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.34	3	30,6600	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910428	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.35	3	46,4050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910428	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.36	3	1,6450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910428	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.37	3	17.3877	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910429	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.30	3	20,935	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910429	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.39	3	41.6119	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910429	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.31	3	36,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910429	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.32	3	52,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910429	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.33	3	7,6595	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910429	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.34	3	23,4000	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910429	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.35	3	39,1450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910429	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.36	3	54,8850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910429	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.37	3	10,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910429	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.38	3	25.8698	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910430	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.31	3	29,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910430	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.40	3	50.094	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910430	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.32	3	45,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910430	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.33	3	60,8995	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910430	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.34	3	16,1415	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910430	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.35	3	31,8850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910430	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.36	3	47,6250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910430	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.37	3	3,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910430	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.38	3	19,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910430	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.39	3	34.3519	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910431	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.32	3	37,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910431	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.41	3	58.5761	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910431	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.33	3	53,6395	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910431	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.34	3	8,8815	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910431	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.35	3	24,6235	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910431	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.36	3	40,3650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910431	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.37	3	56,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910431	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.38	3	11,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910431	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.39	3	27,0900	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910431	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.40	3	42.834	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910432	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.33	3	46,3795	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910432	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.42	3	6.5582	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910432	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.34	3	1,6215	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910432	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.35	3	17,3635	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910432	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.36	3	33,1055	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910432	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.37	3	49,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910432	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.38	3	4,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910432	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.39	3	19,8300	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910432	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.40	3	35,550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910432	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.41	3	51.3161	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910433	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.34	3	54,8615	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910433	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.43	3	15.0403	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910433	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.35	3	10,1035	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910433	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.36	3	25,8455	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910433	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.37	3	41,5875	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910433	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.38	3	57,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910433	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.39	3	12,5700	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910433	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.40	3	28,300	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910433	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.41	3	44,0550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910433	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.42	3	59.7982	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910434	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.35	3	2,8435	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910434	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.44	3	23.5224	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910434	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.36	3	18,5855	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910434	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.37	3	34,3275	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910434	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.38	3	50,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910434	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.39	3	5,3100	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910434	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.40	3	21,050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910434	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.41	3	36,7950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910434	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.42	3	53,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910434	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.43	3	7.7803	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910435	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.36	3	11,3255	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910435	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.45	3	32.0045	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910435	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.37	3	27,0675	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910435	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.38	3	42,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910435	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.39	3	58,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910435	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.40	3	14,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910435	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.41	3	29,5350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910435	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.42	3	45,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910435	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.43	3	61,0200	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910435	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.44	3	16.2624	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910436	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.37	3	19,8075	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910436	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.46	3	40.4866	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910436	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.38	3	35,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910436	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.39	3	51,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910436	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.40	3	6,535	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910436	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.41	3	22,2750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910436	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.42	3	38,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910436	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.43	3	53,7600	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910436	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.44	3	9,0000	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910436	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.45	3	24.7445	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910437	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.38	3	28,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910437	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.47	3	48.9687	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910437	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.39	3	44,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910437	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.40	3	59,775	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910437	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.41	3	15,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910437	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.42	3	31,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910437	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.43	3	46,5000	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910437	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.44	3	1,7400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910437	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.45	3	17,4850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910437	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.46	3	33.2266	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910438	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.39	3	36,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910438	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.48	3	57.4508	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910438	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.40	3	52,515	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910438	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.41	3	7,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910438	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.42	3	23,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910438	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.43	3	39,2400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910438	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.44	3	54,9800	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910438	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.45	3	10,2250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910438	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.46	3	25,9650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910438	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.47	3	41.7087	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910439	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.40	3	45,255	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910439	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.49	3	5.4329	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910439	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.41	3	61,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910439	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.42	3	16,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910439	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.43	3	31,9805	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910439	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.44	3	47,7200	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910439	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.45	3	2,9650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910439	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.46	3	18,7050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910439	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.47	3	34,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910439	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.48	3	50.1908	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910440	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.41	3	53,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910440	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.50	3	13.915	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910440	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.42	3	9,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910440	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.43	3	24,7205	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910440	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.44	3	40,4625	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910440	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.45	3	56,2050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910440	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.46	3	11,4450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910440	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.47	3	27,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910440	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.48	3	42,9300	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910440	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.49	3	58.6729	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910441	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.42	3	1,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910441	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.51	3	22.3971	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910441	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.43	3	17,4605	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910441	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.44	3	33,2025	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910441	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.45	3	48,9445	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910441	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.46	3	4,1850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910441	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.47	3	20,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910441	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.48	3	35,6700	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910441	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.49	3	51,4150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910441	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.50	3	6.655	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910442	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.43	3	10,2005	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910442	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.52	3	30.8792	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910442	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.44	3	25,9425	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910442	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.45	3	41,6845	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910442	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.46	3	57,4265	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910442	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.47	3	13,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910442	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.48	3	28,4100	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910442	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.49	3	44,1550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910442	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.50	3	60,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910442	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.51	3	15.1371	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910443	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.44	3	18,6825	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910443	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.53	3	39.3613	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910443	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.45	3	34,4245	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910443	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.46	3	50,1665	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910443	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.47	3	5,4085	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910443	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.48	3	21,1500	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910443	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.49	3	36,8950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910443	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.50	3	52,650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910443	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.51	3	7,8750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910443	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.52	3	23.6192	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910444	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.45	3	27,1645	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910444	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.54	3	47.8434	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910444	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.46	3	42,9065	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910444	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.47	3	58,6485	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910444	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.48	3	13,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910444	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.49	3	29,6350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910444	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.50	3	45,350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910444	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.51	3	61,1150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910444	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.52	3	16,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910444	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.53	3	32.1013	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910445	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.46	3	35,6465	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910445	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.55	3	56.3255	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910445	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.47	3	51,3885	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910445	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.48	3	6,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910445	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.49	3	22,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910445	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.50	3	38,100	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910445	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.51	3	53,8550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910445	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.52	3	9,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910445	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.53	3	24,8400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910445	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.54	3	40.5834	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910446	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.47	3	44,1285	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910446	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.56	3	4.3076	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910446	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.48	3	59,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910446	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.49	3	15,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910446	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.50	3	30,855	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910446	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.51	3	46,5950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910446	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.52	3	2,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910446	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.53	3	17,5800	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910446	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.54	3	33,3250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910446	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.55	3	49.0655	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910447	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.48	3	52,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910447	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.57	3	12.7897	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910447	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.49	3	7,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910447	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.50	3	23,595	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910447	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.51	3	39,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910447	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.52	3	55,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910447	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.53	3	10,3200	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910447	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.54	3	26,0650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910447	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.55	3	41,8050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910447	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.56	3	57.5476	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910448	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.49	3	61,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910448	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.58	3	21.2718	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910448	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.50	3	16,335	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910448	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.51	3	32,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910448	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.52	3	47,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910448	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.53	3	3,0600	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910448	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.54	3	18,8050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910448	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.55	3	34,5450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910448	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.56	3	50,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910448	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.57	3	5.5297	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910449	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.50	3	9,075	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910449	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.59	3	29.7539	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910449	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.51	3	24,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910449	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.52	3	40,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910449	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.53	3	56,3015	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910449	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.54	3	11,5450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910449	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.55	3	27,2850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910449	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.56	3	43,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910449	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.57	3	59,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910449	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.58	3	14.0118	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910450	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.51	3	17,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910450	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.60	3	38.236	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910450	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.52	3	33,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910450	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.53	3	49,0415	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910450	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.54	3	4,2835	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910450	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.55	3	20,0250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910450	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.56	3	36,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910450	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.57	3	52,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910450	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.58	3	6,7500	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910450	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.59	3	22.4939	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910451	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.52	3	26,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910451	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.61	3	46.7181	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910451	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.53	3	41,7815	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910451	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.54	3	57,5235	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910451	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.55	3	12,7655	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910451	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.56	3	29,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910451	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.57	3	44,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910451	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.58	3	59,9900	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910451	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.59	3	15,2350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910451	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.60	3	30.976	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910452	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.53	3	34,5215	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910452	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.62	3	55.2002	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910452	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.54	3	50,2635	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910452	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.55	3	5,5055	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910452	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.56	3	21,2475	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910452	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.57	3	37,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910452	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.58	3	52,7300	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910452	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.59	3	7,9750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910452	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.60	3	23,700	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910452	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.61	3	39.4581	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910453	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.54	3	43,0035	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910453	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.63	3	3.1823	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910453	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.55	3	58,7455	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910453	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.56	3	13,9875	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910453	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.57	3	29,7295	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910453	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.58	3	45,4700	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910453	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.59	3	61,2150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910453	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.60	3	16,450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910453	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.61	3	32,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910453	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.62	3	47.9402	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910454	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.55	3	51,4855	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910454	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.64	3	11.6644	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910454	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.56	3	6,7275	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910454	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.57	3	22,4695	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910454	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.58	3	38,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910454	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.59	3	53,9550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910454	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.60	3	9,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910454	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.61	3	25,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910454	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.62	3	40,6800	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910454	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.63	3	56.4223	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910455	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.56	3	59,9675	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910455	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.65	3	20.1465	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910455	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.57	3	15,2095	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910455	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.58	3	31,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910455	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.59	3	46,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910455	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.60	3	1,950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910455	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.61	3	18,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910455	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.62	3	33,4200	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910455	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.63	3	49,1600	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910455	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.64	3	4.4044	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910456	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.57	3	7,9495	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910456	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.66	3	28.6286	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910456	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.58	3	23,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910456	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.59	3	39,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910456	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.60	3	55,175	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910456	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.61	3	10,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910456	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.62	3	26,1600	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910456	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.63	3	41,9000	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910456	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.64	3	57,6450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910456	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.65	3	12.8865	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910457	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.58	3	16,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910457	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.67	3	37.1107	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910457	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.59	3	32,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910457	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.60	3	47,915	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910457	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.61	3	3,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910457	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.62	3	18,9000	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910457	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.63	3	34,6400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910457	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.64	3	50,3850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910457	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.65	3	5,6250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910457	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.66	3	21.3686	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910458	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.59	3	24,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910458	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.68	3	45.5928	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910458	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.60	3	40,655	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910458	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.61	3	56,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910458	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.62	3	11,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910458	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.63	3	27,3800	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910458	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.64	3	43,1250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910458	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.65	3	58,8650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910458	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.66	3	14,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910458	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.67	3	29.8507	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910459	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.60	3	33,395	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910459	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.69	3	54.0749	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910459	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.61	3	49,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910459	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.62	3	4,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910459	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.63	3	20,1225	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910459	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.64	3	35,8650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910459	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.65	3	51,6050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910459	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.66	3	7,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910459	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.67	3	22,5900	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910459	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.68	3	38.3328	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910460	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.61	3	41,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910460	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.70	3	2.057	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910460	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.62	3	57,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910460	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.63	3	12,8625	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910460	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.64	3	28,6045	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910460	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.65	3	44,3450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910460	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.66	3	60,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910460	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.67	3	15,3300	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910460	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.68	3	31,0750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910460	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.69	3	46.8149	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910461	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.62	3	50,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910461	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.71	3	10.5391	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910461	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.63	3	5,6025	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910461	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.64	3	21,3445	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910461	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.65	3	37,0865	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910461	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.66	3	53,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910461	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.67	3	8,0700	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910461	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.68	3	23,8150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910461	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.69	3	39,5550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910461	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.70	3	55.297	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910462	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.63	3	58,8425	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910462	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.72	3	19.0212	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910462	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.64	3	14,0845	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910462	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.65	3	29,8265	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910462	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.66	3	45,5685	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910462	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.67	3	61,3100	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910462	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.68	3	16,5550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910462	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.69	3	32,2950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910462	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.70	3	48,050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910462	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.71	3	3.2791	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910463	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.64	3	6,8245	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910463	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.73	3	27.5033	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910463	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.65	3	22,5665	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910463	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.66	3	38,3085	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910463	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.67	3	54,0505	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910463	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.68	3	9,2950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910463	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.69	3	25,0350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910463	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.70	3	41,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910463	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.71	3	57,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910463	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.72	3	11.7612	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910464	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.65	3	15,3065	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910464	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.74	3	35.9854	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910464	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.66	3	31,0485	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910464	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.67	3	46,7905	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910464	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.68	3	2,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910464	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.69	3	17,7750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910464	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.70	3	33,500	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910464	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.71	3	49,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910464	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.72	3	4,5000	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910464	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.73	3	20.2433	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910465	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.66	3	23,7885	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910465	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.75	3	44.4675	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910465	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.67	3	39,5305	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910465	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.68	3	55,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910465	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.69	3	10,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910465	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.70	3	26,250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910465	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.71	3	42,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910465	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.72	3	57,7400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910465	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.73	3	12,9850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910465	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.74	3	28.7254	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910466	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.67	3	32,2705	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910466	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.76	3	52.9496	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910466	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.68	3	48,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910466	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.69	3	3,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910466	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.70	3	18,995	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910466	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.71	3	35,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910466	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.72	3	50,4800	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910466	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.73	3	5,7250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910466	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.74	3	21,4650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910466	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.75	3	37.2075	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910467	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.68	3	40,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910467	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.77	3	61.4317	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910467	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.69	3	56,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910467	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.70	3	11,735	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910467	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.71	3	27,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910467	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.72	3	43,2200	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910467	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.73	3	58,9650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910467	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.74	3	14,2050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910467	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.75	3	29,9450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910467	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.76	3	45.6896	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910468	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.69	3	49,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910468	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.78	3	9.4138	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910468	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.70	3	4,475	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910468	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.71	3	20,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910468	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.72	3	36,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910468	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.73	3	51,7050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910468	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.74	3	6,9450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910468	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.75	3	22,6850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910468	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.76	3	38,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910468	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.77	3	54.1717	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910469	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.70	3	57,715	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910469	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.79	3	17.8959	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910469	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.71	3	13,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910469	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.72	3	28,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910469	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.73	3	44,4435	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910469	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.74	3	60,1850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910469	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.75	3	15,4250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910469	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.76	3	31,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910469	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.77	3	46,9100	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910469	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.78	3	2.1538	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910470	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.71	3	5,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910470	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.80	3	26.378	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910470	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.72	3	21,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910470	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.73	3	37,1835	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910470	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.74	3	52,9255	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910470	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.75	3	8,1650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910470	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.76	3	24,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910470	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.77	3	39,6500	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910470	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.78	3	55,3950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910470	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.79	3	10.6359	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910471	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.72	3	14,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910471	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.81	3	34.8601	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910471	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.73	3	29,9235	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910471	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.74	3	45,6655	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910471	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.75	3	61,4075	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910471	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.76	3	17,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910471	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.77	3	32,3900	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910471	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.78	3	48,1350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910471	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.79	3	3,3750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910471	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.80	3	19.118	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910472	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.73	3	22,6635	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910472	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.82	3	43.3422	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910472	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.74	3	38,4055	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910472	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.75	3	54,1475	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910472	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.76	3	9,3895	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910472	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.77	3	25,1300	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910472	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.78	3	40,8750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910472	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.79	3	56,6150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910472	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.80	3	11,850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910472	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.81	3	27.6001	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910473	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.74	3	31,1455	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910473	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.83	3	51.8243	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910473	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.75	3	46,8875	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910473	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.76	3	2,1295	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910473	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.77	3	17,8715	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910473	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.78	3	33,6150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910473	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.79	3	49,3550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910473	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.80	3	5,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910473	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.81	3	20,3400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910473	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.82	3	36.0822	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910474	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.75	3	39,6275	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910474	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.84	3	60.3064	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910474	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.76	3	55,3695	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910474	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.77	3	10,6115	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910474	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.78	3	26,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910474	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.79	3	42,0950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910474	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.80	3	57,850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910474	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.81	3	13,0800	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910474	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.82	3	28,8200	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910474	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.83	3	44.5643	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910475	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.76	3	48,1095	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910475	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.85	3	8.2885	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910475	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.77	3	3,3515	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910475	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.78	3	19,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910475	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.79	3	34,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910475	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.80	3	51,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910475	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.81	3	5,8200	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910475	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.82	3	21,5600	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910475	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.83	3	37,3050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910475	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.84	3	53.0464	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910476	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.77	3	56,5915	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910476	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.86	3	16.7706	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910476	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.78	3	11,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910476	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.79	3	27,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910476	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.80	3	43,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910476	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.81	3	59,0600	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910476	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.82	3	14,3000	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910476	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.83	3	30,0450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910476	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.84	3	45,7850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910476	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.85	3	61.5285	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910477	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.78	3	4,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910477	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.87	3	25.2527	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910477	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.79	3	20,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910477	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.80	3	36,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910477	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.81	3	51,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910477	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.82	3	7,0400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910477	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.83	3	22,7850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910477	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.84	3	38,5250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910477	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.85	3	54,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910477	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.86	3	9.5106	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910478	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.79	3	13,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910478	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.88	3	33.7348	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910478	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.80	3	28,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910478	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.81	3	44,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910478	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.82	3	60,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910478	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.83	3	15,5250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910478	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.84	3	31,2650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910478	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.85	3	47,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910478	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.86	3	2,2500	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910478	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.87	3	17.9927	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910479	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.80	3	21,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910479	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.89	3	42.2169	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910479	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.81	3	37,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910479	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.82	3	53,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910479	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.83	3	8,2645	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910479	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.84	3	24,0050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910479	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.85	3	40,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910479	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.86	3	55,4900	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910479	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.87	3	10,7350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910479	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.88	3	26.4748	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910480	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.81	3	30,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910480	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.90	3	50.699	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910480	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.82	3	45,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910480	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.83	3	61,5045	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910480	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.84	3	16,7465	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910480	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.85	3	32,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910480	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.86	3	48,2300	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910480	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.87	3	3,4750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910480	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.88	3	19,2150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910480	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.89	3	34.9569	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910481	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.82	3	38,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910481	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.91	3	59.1811	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910481	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.83	3	54,2445	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910481	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.84	3	9,4865	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910481	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.85	3	25,2285	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910481	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.86	3	40,9700	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910481	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.87	3	56,7150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910481	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.88	3	11,9550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910481	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.89	3	27,6950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910481	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.90	3	43.439	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910482	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.83	3	46,9845	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910482	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.92	3	7.1632	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910482	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.84	3	2,2265	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910482	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.85	3	17,9685	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910482	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.86	3	33,7105	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910482	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.87	3	49,4550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910482	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.88	3	4,6950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910482	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.89	3	20,4350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910482	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.90	3	36,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910482	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.91	3	51.9211	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910483	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.84	3	55,4665	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910483	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.93	3	15.6453	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910483	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.85	3	10,7085	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910483	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.86	3	26,4505	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910483	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.87	3	42,1925	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910483	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.88	3	57,9350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910483	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.89	3	13,1750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910483	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.90	3	28,900	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910483	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.91	3	44,6600	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910483	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.92	3	60.4032	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910484	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.85	3	3,4485	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910484	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.94	3	24.1274	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910484	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.86	3	19,1905	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910484	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.87	3	34,9325	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910484	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.88	3	50,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910484	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.89	3	5,9150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910484	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.90	3	21,650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910484	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.91	3	37,4000	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910484	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.92	3	53,1450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910484	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.93	3	8.3853	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910485	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.86	3	11,9305	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910485	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.95	3	32.6095	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910485	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.87	3	27,6725	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910485	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.88	3	43,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910485	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.89	3	59,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910485	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.90	3	14,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910485	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.91	3	30,1400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910485	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.92	3	45,8850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910485	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.93	3	61,6250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910485	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.94	3	16.8674	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910486	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.87	3	20,4125	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910486	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.96	3	41.0916	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910486	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.88	3	36,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910486	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.89	3	51,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910486	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.90	3	7,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910486	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.91	3	22,8800	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910486	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.92	3	38,6250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910486	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.93	3	54,3650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910486	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.94	3	9,6050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910486	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.95	3	25.3495	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910487	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.88	3	28,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910487	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.97	3	49.5737	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910487	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.89	3	44,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910487	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.90	3	60,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910487	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.91	3	15,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910487	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.92	3	31,3650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910487	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.93	3	47,1050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910487	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.94	3	2,3450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910487	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.95	3	18,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910487	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.96	3	33.8316	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910488	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.89	3	37,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910488	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.98	3	58.0558	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910488	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.90	3	53,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910488	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.91	3	8,40	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910488	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.92	3	24,10	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910488	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.93	3	39,8450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910488	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.94	3	55,5850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910488	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.95	3	11,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910488	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.96	3	26,5700	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910488	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.97	3	42.3137	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910489	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.90	3	45,90	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910489	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.99	3	6.0379	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910489	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.91	3	61,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910489	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.92	3	16,80	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910489	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.93	3	32,5855	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910489	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.94	3	48,3250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910489	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.95	3	4,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910489	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.96	3	19,3100	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910489	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.97	3	35,0550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910489	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.98	3	50.7958	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910490	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.91	3	54,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910490	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.00	3	13.31	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910490	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.92	3	9,60	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910490	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.93	3	25,3255	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910490	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.94	3	41,0675	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910490	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.95	3	57,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910490	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.96	3	12,0500	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910490	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.97	3	27,7950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910490	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.98	3	43,5350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910490	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.99	3	59.2779	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910491	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.92	3	2,30	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910491	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.01	3	21.7921	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910491	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.93	3	18,0655	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910491	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.94	3	33,8075	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910491	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.95	3	49,5495	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910491	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.96	3	4,7900	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910491	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.97	3	20,5350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910491	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.98	3	36,2750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910491	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.99	3	52,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910491	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.00	3	6.05	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910492	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.93	3	10,8055	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910492	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.02	3	30.2742	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910492	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.94	3	26,5475	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910492	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.95	3	42,2895	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910492	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.96	3	58,0315	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910492	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.97	3	13,2750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910492	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	23.98	3	29,0150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910492	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.99	3	45,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910492	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.00	3	59,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910492	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.01	3	14.5321	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910493	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.94	3	19,2875	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910493	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.03	3	38.7563	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910493	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.95	3	35,0295	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910493	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.96	3	50,7715	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910493	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.97	3	6,0135	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910493	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.98	3	21,7550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910493	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	30.99	3	37,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910493	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.00	3	52,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910493	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.01	3	7,2700	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910493	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.02	3	23.0142	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910494	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.95	3	27,7695	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910494	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.04	3	47.2384	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910494	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.96	3	43,5115	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910494	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.97	3	59,2535	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910494	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.98	3	14,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910494	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.99	3	30,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910494	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	37.00	3	45,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910494	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.01	3	60,5100	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910494	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.02	3	15,7550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910494	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.03	3	31.4963	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910495	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.96	3	36,2515	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910495	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.05	3	55.7205	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910495	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.97	3	51,9935	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910495	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.98	3	7,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910495	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.99	3	23,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910495	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.00	3	37,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910495	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	44.01	3	53,2500	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910495	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.02	3	8,4950	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910495	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.03	3	24,2350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910495	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.04	3	39.9784	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910496	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	36.97	3	44,7335	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910496	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.06	3	3.7026	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910496	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	49.98	3	60,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910496	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	12.99	3	15,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910496	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	25.00	3	30,25	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910496	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	38.01	3	45,9900	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910496	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	1.02	3	1,2350	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910496	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.03	3	16,9750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910496	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.04	3	33,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910496	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.05	3	48.4605	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910497	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	43.98	3	53,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910497	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	10.07	3	12.1847	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910497	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	6.99	3	8,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910497	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	19.00	3	23,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910497	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	32.01	3	38,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910497	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	45.02	3	54,4750	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910497	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	8.03	3	9,7150	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910497	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	21.04	3	25,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910497	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	34.05	3	41,2000	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910497	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	47.06	3	56.9426	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910498	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	50.99	3	61,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910498	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	17.08	3	20.6668	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910498	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	13.00	3	15,75	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910498	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	26.01	3	31,50	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910498	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	39.02	3	47,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910498	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	2.03	3	2,4550	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910498	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	15.04	3	18,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910498	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	28.05	3	33,9400	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910498	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	41.06	3	49,6850	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910498	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	4.07	3	4.9247	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910499	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	7.00	3	8,45	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910499	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	24.09	3	29.1489	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910499	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	20.01	3	24,20	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910499	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	33.02	3	40,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910499	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	46.03	3	55,6965	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910499	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	9.04	3	11,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910499	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	22.05	3	26,6800	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910499	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	35.06	3	42,4250	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910499	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	48.07	3	58,1650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910499	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	11.08	3	13.4068	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910500	1	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	14.01	3	17,00	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910500	10	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	31.10	3	37.631	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910500	2	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	27.02	3	32,70	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910500	3	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	40.03	3	48,4365	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910500	4	TP05	NULL	NULL	NULL	NULL	NULL	NULL	NULL	3.04	3	3,6785	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910500	5	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	16.05	3	19,4200	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910500	6	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	29.06	3	35,1650	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910500	7	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	42.07	3	50,9050	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910500	8	TP50	NULL	NULL	NULL	NULL	NULL	NULL	NULL	5.08	3	6,1450	A	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
910500	9	04	NULL	NULL	NULL	NULL	NULL	NULL	NULL	18.09	3	21.8889	M	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL	NULL
## Fiches_Mo (mo_code	mo_design	mo_fam	mo_four	mo_txcd	mo_txht	mo_tva	mo_tempmont	mo_montant	mo_valeurht	mo_cdarr	mo_valeurttc	mo_prvt	mo_marge	mo_impcar	mo_crst)
01	Mo T1	10	401001	1	28	3	1	1	0	0,01	0	14.000	14.000	NULL	NULL
02	Mo T2	10	401001	2	31	3	1	1	0	0,01	0	15.000	16.000	NULL	NULL
03	Mo T3	10	401001	3	35	3	1	1	0	0,01	0	18.000	17.000	NULL	NULL
04	Forfait changement poulie	10	401001	1	28	3	0	NULL	35	0,01	42.35	14.000	0.000	0	NULL
05	Changement poulie	10	401001	1	28	3	1	1.2	NULL	0,01	NULL	14.000	16.800	0	NULL
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
3	21.00	445730
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
