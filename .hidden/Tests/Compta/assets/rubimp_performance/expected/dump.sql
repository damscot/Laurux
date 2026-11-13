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
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `centralisation` (
  `numrub` char(5) NOT NULL,
  `intitrub` char(70) DEFAULT NULL,
  `type` char(1) DEFAULT NULL,
  `detail` char(1) DEFAULT NULL,
  `compte` char(8) NOT NULL,
  `intitcpt` char(50) DEFAULT NULL,
  `Col1` char(25) DEFAULT NULL,
  `Col2` char(25) DEFAULT NULL,
  `col3` char(25) DEFAULT NULL,
  `col4` char(25) DEFAULT NULL,
  PRIMARY KEY (`numrub`,`compte`)
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
601001	Charge perf 601001	G	0	NULL	0	0			0			0	0	0	0	NULL
601002	Charge perf 601002	G	0	NULL	0	0			0			0	0	0	0	NULL
601003	Charge perf 601003	G	0	NULL	0	0			0			0	0	0	0	NULL
601004	Charge perf 601004	G	0	NULL	0	0			0			0	0	0	0	NULL
601005	Charge perf 601005	G	0	NULL	0	0			0			0	0	0	0	NULL
601006	Charge perf 601006	G	0	NULL	0	0			0			0	0	0	0	NULL
601007	Charge perf 601007	G	0	NULL	0	0			0			0	0	0	0	NULL
601008	Charge perf 601008	G	0	NULL	0	0			0			0	0	0	0	NULL
601009	Charge perf 601009	G	0	NULL	0	0			0			0	0	0	0	NULL
601010	Charge perf 601010	G	0	NULL	0	0			0			0	0	0	0	NULL
601011	Charge perf 601011	G	0	NULL	0	0			0			0	0	0	0	NULL
601012	Charge perf 601012	G	0	NULL	0	0			0			0	0	0	0	NULL
601013	Charge perf 601013	G	0	NULL	0	0			0			0	0	0	0	NULL
601014	Charge perf 601014	G	0	NULL	0	0			0			0	0	0	0	NULL
601015	Charge perf 601015	G	0	NULL	0	0			0			0	0	0	0	NULL
601016	Charge perf 601016	G	0	NULL	0	0			0			0	0	0	0	NULL
601017	Charge perf 601017	G	0	NULL	0	0			0			0	0	0	0	NULL
601018	Charge perf 601018	G	0	NULL	0	0			0			0	0	0	0	NULL
601019	Charge perf 601019	G	0	NULL	0	0			0			0	0	0	0	NULL
601020	Charge perf 601020	G	0	NULL	0	0			0			0	0	0	0	NULL
602100	Matieres consommables	G	0	NULL	0	0			0			0	0	0	0	NULL
603700	Variations de stock	G	0	NULL	0	0			0			0	0	0	0	NULL
604000	Achats de sous-traitance	G	0	NULL	0	0			0			0	0	0	0	NULL
605000	Sous traitance	G	0	NULL	0	0			0	3	19.60	1	0	0	0	NULL
606100	Fournitures non stockables	G	0	NULL	0	0			0			0	0	0	0	NULL
606101	Charge perf 606101	G	0	NULL	0	0			0			0	0	0	0	NULL
606102	Charge perf 606102	G	0	NULL	0	0			0			0	0	0	0	NULL
606103	Charge perf 606103	G	0	NULL	0	0			0			0	0	0	0	NULL
606104	Charge perf 606104	G	0	NULL	0	0			0			0	0	0	0	NULL
606105	Charge perf 606105	G	0	NULL	0	0			0			0	0	0	0	NULL
606106	Charge perf 606106	G	0	NULL	0	0			0			0	0	0	0	NULL
606107	Charge perf 606107	G	0	NULL	0	0			0			0	0	0	0	NULL
606108	Charge perf 606108	G	0	NULL	0	0			0			0	0	0	0	NULL
606109	Charge perf 606109	G	0	NULL	0	0			0			0	0	0	0	NULL
606110	Electricite	G	0	NULL	0	0			0	3	19.60	1	0	0	0	NULL
606111	Charge perf 606111	G	0	NULL	0	0			0			0	0	0	0	NULL
606112	Charge perf 606112	G	0	NULL	0	0			0			0	0	0	0	NULL
606113	Charge perf 606113	G	0	NULL	0	0			0			0	0	0	0	NULL
606114	Charge perf 606114	G	0	NULL	0	0			0			0	0	0	0	NULL
606115	Charge perf 606115	G	0	NULL	0	0			0			0	0	0	0	NULL
606116	Charge perf 606116	G	0	NULL	0	0			0			0	0	0	0	NULL
606117	Charge perf 606117	G	0	NULL	0	0			0			0	0	0	0	NULL
606118	Charge perf 606118	G	0	NULL	0	0			0			0	0	0	0	NULL
606119	Charge perf 606119	G	0	NULL	0	0			0			0	0	0	0	NULL
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
613101	Charge perf 613101	G	0	NULL	0	0			0			0	0	0	0	NULL
613102	Charge perf 613102	G	0	NULL	0	0			0			0	0	0	0	NULL
613103	Charge perf 613103	G	0	NULL	0	0			0			0	0	0	0	NULL
613104	Charge perf 613104	G	0	NULL	0	0			0			0	0	0	0	NULL
613105	Charge perf 613105	G	0	NULL	0	0			0			0	0	0	0	NULL
613106	Charge perf 613106	G	0	NULL	0	0			0			0	0	0	0	NULL
613107	Charge perf 613107	G	0	NULL	0	0			0			0	0	0	0	NULL
613108	Charge perf 613108	G	0	NULL	0	0			0			0	0	0	0	NULL
613109	Charge perf 613109	G	0	NULL	0	0			0			0	0	0	0	NULL
613110	Charge perf 613110	G	0	NULL	0	0			0			0	0	0	0	NULL
613111	Charge perf 613111	G	0	NULL	0	0			0			0	0	0	0	NULL
613112	Charge perf 613112	G	0	NULL	0	0			0			0	0	0	0	NULL
613113	Charge perf 613113	G	0	NULL	0	0			0			0	0	0	0	NULL
613114	Charge perf 613114	G	0	NULL	0	0			0			0	0	0	0	NULL
613115	Charge perf 613115	G	0	NULL	0	0			0			0	0	0	0	NULL
613116	Charge perf 613116	G	0	NULL	0	0			0			0	0	0	0	NULL
613117	Charge perf 613117	G	0	NULL	0	0			0			0	0	0	0	NULL
613118	Charge perf 613118	G	0	NULL	0	0			0			0	0	0	0	NULL
613119	Charge perf 613119	G	0	NULL	0	0			0			0	0	0	0	NULL
613120	Charge perf 613120	G	0	NULL	0	0			0			0	0	0	0	NULL
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
706001	Produit perf 706001	G	0	NULL	0	0			0			0	0	0	0	NULL
706002	Produit perf 706002	G	0	NULL	0	0			0			0	0	0	0	NULL
706003	Produit perf 706003	G	0	NULL	0	0			0			0	0	0	0	NULL
706004	Produit perf 706004	G	0	NULL	0	0			0			0	0	0	0	NULL
706005	Produit perf 706005	G	0	NULL	0	0			0			0	0	0	0	NULL
706006	Produit perf 706006	G	0	NULL	0	0			0			0	0	0	0	NULL
706007	Produit perf 706007	G	0	NULL	0	0			0			0	0	0	0	NULL
706008	Produit perf 706008	G	0	NULL	0	0			0			0	0	0	0	NULL
706009	Produit perf 706009	G	0	NULL	0	0			0			0	0	0	0	NULL
706010	Produit perf 706010	G	0	NULL	0	0			0			0	0	0	0	NULL
706011	Produit perf 706011	G	0	NULL	0	0			0			0	0	0	0	NULL
706012	Produit perf 706012	G	0	NULL	0	0			0			0	0	0	0	NULL
706013	Produit perf 706013	G	0	NULL	0	0			0			0	0	0	0	NULL
706014	Produit perf 706014	G	0	NULL	0	0			0			0	0	0	0	NULL
706015	Produit perf 706015	G	0	NULL	0	0			0			0	0	0	0	NULL
706100	Ventes MO	G	0	NULL	0	0	3	20.00	1			0	0	0	0	NULL
706105	Prestations services 7.00	G	0	NULL	0	0	NULL	NULL	0	NULL	NULL	0	0	NULL	0	NULL
706110	Prestations services 20.00	G	0	NULL	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	NULL
707000	Ventes marchandises 2.10	G	0	NULL	0	0	1	2.10	1			0	0	0	0	NULL
707010	Ventes marchandises 7.00	G	0	NULL	0	0	2	7.00	1	NULL	NULL	0	0	0	0	NULL
707020	Ventes marchandises 20.00	G	0	NULL	0	0	3	20.00	1	NULL	NULL	0	0	0	0	NULL
707101	Produit perf 707101	G	0	NULL	0	0			0			0	0	0	0	NULL
707102	Produit perf 707102	G	0	NULL	0	0			0			0	0	0	0	NULL
707103	Produit perf 707103	G	0	NULL	0	0			0			0	0	0	0	NULL
707104	Produit perf 707104	G	0	NULL	0	0			0			0	0	0	0	NULL
707105	Produit perf 707105	G	0	NULL	0	0			0			0	0	0	0	NULL
707106	Produit perf 707106	G	0	NULL	0	0			0			0	0	0	0	NULL
707107	Produit perf 707107	G	0	NULL	0	0			0			0	0	0	0	NULL
707108	Produit perf 707108	G	0	NULL	0	0			0			0	0	0	0	NULL
707109	Produit perf 707109	G	0	NULL	0	0			0			0	0	0	0	NULL
707110	Produit perf 707110	G	0	NULL	0	0			0			0	0	0	0	NULL
707111	Produit perf 707111	G	0	NULL	0	0			0			0	0	0	0	NULL
707112	Produit perf 707112	G	0	NULL	0	0			0			0	0	0	0	NULL
707113	Produit perf 707113	G	0	NULL	0	0			0			0	0	0	0	NULL
707114	Produit perf 707114	G	0	NULL	0	0			0			0	0	0	0	NULL
707115	Produit perf 707115	G	0	NULL	0	0			0			0	0	0	0	NULL
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
60	101	101	401001	0	A Divers	2018-05-01 00:00:00	NULL	NULL	NULL	AP101	NULL	Achat perf 101	0.00	740.00	1	0	0	0	NULL	0	0	NULL	202	NULL	NULL	NULL
60	101	101	613101	0	Charge perf 613101	2018-05-01 00:00:00	NULL	NULL	NULL	AP101	NULL	Achat perf 101	740.00	0.00	1	0	0	0	NULL	0	0	NULL	201	NULL	NULL	NULL
60	102	102	401001	0	A Divers	2018-06-08 00:00:00	NULL	NULL	NULL	AP102	NULL	Achat perf 102	0.00	777.13	1	0	0	0	NULL	0	0	NULL	204	NULL	NULL	NULL
60	102	102	613102	0	Charge perf 613102	2018-06-08 00:00:00	NULL	NULL	NULL	AP102	NULL	Achat perf 102	777.13	0.00	1	0	0	0	NULL	0	0	NULL	203	NULL	NULL	NULL
60	104	104	401001	0	A Divers	2018-02-22 00:00:00	NULL	NULL	NULL	AP104	NULL	Achat perf 104	0.00	851.39	1	0	0	0	NULL	0	0	NULL	208	NULL	NULL	NULL
60	104	104	613104	0	Charge perf 613104	2018-02-22 00:00:00	NULL	NULL	NULL	AP104	NULL	Achat perf 104	851.39	0.00	1	0	0	0	NULL	0	0	NULL	207	NULL	NULL	NULL
60	105	105	401001	0	A Divers	2018-03-01 00:00:00	NULL	NULL	NULL	AP105	NULL	Achat perf 105	0.00	888.52	1	0	0	0	NULL	0	0	NULL	210	NULL	NULL	NULL
60	105	105	613105	0	Charge perf 613105	2018-03-01 00:00:00	NULL	NULL	NULL	AP105	NULL	Achat perf 105	888.52	0.00	1	0	0	0	NULL	0	0	NULL	209	NULL	NULL	NULL
60	107	107	401001	0	A Divers	2018-05-15 00:00:00	NULL	NULL	NULL	AP107	NULL	Achat perf 107	0.00	962.78	1	0	0	0	NULL	0	0	NULL	214	NULL	NULL	NULL
60	107	107	613107	0	Charge perf 613107	2018-05-15 00:00:00	NULL	NULL	NULL	AP107	NULL	Achat perf 107	962.78	0.00	1	0	0	0	NULL	0	0	NULL	213	NULL	NULL	NULL
60	108	108	401001	0	A Divers	2018-06-22 00:00:00	NULL	NULL	NULL	AP108	NULL	Achat perf 108	0.00	999.91	1	0	0	0	NULL	0	0	NULL	216	NULL	NULL	NULL
60	108	108	613108	0	Charge perf 613108	2018-06-22 00:00:00	NULL	NULL	NULL	AP108	NULL	Achat perf 108	999.91	0.00	1	0	0	0	NULL	0	0	NULL	215	NULL	NULL	NULL
60	11	11	401001	0	A Divers	2018-05-15 00:00:00	NULL	NULL	NULL	AP11	NULL	Achat perf 11	0.00	380.30	1	0	0	0	NULL	0	0	NULL	22	NULL	NULL	NULL
60	11	11	601011	0	Charge perf 601011	2018-05-15 00:00:00	NULL	NULL	NULL	AP11	NULL	Achat perf 11	380.30	0.00	1	0	0	0	NULL	0	0	NULL	21	NULL	NULL	NULL
60	110	110	401001	0	A Divers	2018-02-08 00:00:00	NULL	NULL	NULL	AP110	NULL	Achat perf 110	0.00	83.17	1	0	0	0	NULL	0	0	NULL	220	NULL	NULL	NULL
60	110	110	613110	0	Charge perf 613110	2018-02-08 00:00:00	NULL	NULL	NULL	AP110	NULL	Achat perf 110	83.17	0.00	1	0	0	0	NULL	0	0	NULL	219	NULL	NULL	NULL
60	111	111	401001	0	A Divers	2018-03-15 00:00:00	NULL	NULL	NULL	AP111	NULL	Achat perf 111	0.00	120.30	1	0	0	0	NULL	0	0	NULL	222	NULL	NULL	NULL
60	111	111	613111	0	Charge perf 613111	2018-03-15 00:00:00	NULL	NULL	NULL	AP111	NULL	Achat perf 111	120.30	0.00	1	0	0	0	NULL	0	0	NULL	221	NULL	NULL	NULL
60	113	113	401001	0	A Divers	2018-05-01 00:00:00	NULL	NULL	NULL	AP113	NULL	Achat perf 113	0.00	194.56	1	0	0	0	NULL	0	0	NULL	226	NULL	NULL	NULL
60	113	113	613113	0	Charge perf 613113	2018-05-01 00:00:00	NULL	NULL	NULL	AP113	NULL	Achat perf 113	194.56	0.00	1	0	0	0	NULL	0	0	NULL	225	NULL	NULL	NULL
60	114	114	401001	0	A Divers	2018-06-08 00:00:00	NULL	NULL	NULL	AP114	NULL	Achat perf 114	0.00	231.69	1	0	0	0	NULL	0	0	NULL	228	NULL	NULL	NULL
60	114	114	613114	0	Charge perf 613114	2018-06-08 00:00:00	NULL	NULL	NULL	AP114	NULL	Achat perf 114	231.69	0.00	1	0	0	0	NULL	0	0	NULL	227	NULL	NULL	NULL
60	116	116	401001	0	A Divers	2018-02-22 00:00:00	NULL	NULL	NULL	AP116	NULL	Achat perf 116	0.00	305.95	1	0	0	0	NULL	0	0	NULL	232	NULL	NULL	NULL
60	116	116	613116	0	Charge perf 613116	2018-02-22 00:00:00	NULL	NULL	NULL	AP116	NULL	Achat perf 116	305.95	0.00	1	0	0	0	NULL	0	0	NULL	231	NULL	NULL	NULL
60	117	117	401001	0	A Divers	2018-03-01 00:00:00	NULL	NULL	NULL	AP117	NULL	Achat perf 117	0.00	342.08	1	0	0	0	NULL	0	0	NULL	234	NULL	NULL	NULL
60	117	117	613117	0	Charge perf 613117	2018-03-01 00:00:00	NULL	NULL	NULL	AP117	NULL	Achat perf 117	342.08	0.00	1	0	0	0	NULL	0	0	NULL	233	NULL	NULL	NULL
60	119	119	401001	0	A Divers	2018-05-15 00:00:00	NULL	NULL	NULL	AP119	NULL	Achat perf 119	0.00	416.34	1	0	0	0	NULL	0	0	NULL	238	NULL	NULL	NULL
60	119	119	613119	0	Charge perf 613119	2018-05-15 00:00:00	NULL	NULL	NULL	AP119	NULL	Achat perf 119	416.34	0.00	1	0	0	0	NULL	0	0	NULL	237	NULL	NULL	NULL
60	12	12	401001	0	A Divers	2018-06-22 00:00:00	NULL	NULL	NULL	AP12	NULL	Achat perf 12	0.00	417.43	1	0	0	0	NULL	0	0	NULL	24	NULL	NULL	NULL
60	12	12	601012	0	Charge perf 601012	2018-06-22 00:00:00	NULL	NULL	NULL	AP12	NULL	Achat perf 12	417.43	0.00	1	0	0	0	NULL	0	0	NULL	23	NULL	NULL	NULL
60	120	120	401001	0	A Divers	2018-06-22 00:00:00	NULL	NULL	NULL	AP120	NULL	Achat perf 120	0.00	453.47	1	0	0	0	NULL	0	0	NULL	240	NULL	NULL	NULL
60	120	120	613120	0	Charge perf 613120	2018-06-22 00:00:00	NULL	NULL	NULL	AP120	NULL	Achat perf 120	453.47	0.00	1	0	0	0	NULL	0	0	NULL	239	NULL	NULL	NULL
60	122	122	401001	0	A Divers	2018-02-08 00:00:00	NULL	NULL	NULL	AP122	NULL	Achat perf 122	0.00	527.73	1	0	0	0	NULL	0	0	NULL	244	NULL	NULL	NULL
60	122	122	601002	0	Charge perf 601002	2018-02-08 00:00:00	NULL	NULL	NULL	AP122	NULL	Achat perf 122	527.73	0.00	1	0	0	0	NULL	0	0	NULL	243	NULL	NULL	NULL
60	123	123	401001	0	A Divers	2018-03-15 00:00:00	NULL	NULL	NULL	AP123	NULL	Achat perf 123	0.00	564.86	1	0	0	0	NULL	0	0	NULL	246	NULL	NULL	NULL
60	123	123	601003	0	Charge perf 601003	2018-03-15 00:00:00	NULL	NULL	NULL	AP123	NULL	Achat perf 123	564.86	0.00	1	0	0	0	NULL	0	0	NULL	245	NULL	NULL	NULL
60	125	125	401001	0	A Divers	2018-05-01 00:00:00	NULL	NULL	NULL	AP125	NULL	Achat perf 125	0.00	638.12	1	0	0	0	NULL	0	0	NULL	250	NULL	NULL	NULL
60	125	125	601005	0	Charge perf 601005	2018-05-01 00:00:00	NULL	NULL	NULL	AP125	NULL	Achat perf 125	638.12	0.00	1	0	0	0	NULL	0	0	NULL	249	NULL	NULL	NULL
60	126	126	401001	0	A Divers	2018-06-08 00:00:00	NULL	NULL	NULL	AP126	NULL	Achat perf 126	0.00	675.25	1	0	0	0	NULL	0	0	NULL	252	NULL	NULL	NULL
60	126	126	601006	0	Charge perf 601006	2018-06-08 00:00:00	NULL	NULL	NULL	AP126	NULL	Achat perf 126	675.25	0.00	1	0	0	0	NULL	0	0	NULL	251	NULL	NULL	NULL
60	128	128	401001	0	A Divers	2018-02-22 00:00:00	NULL	NULL	NULL	AP128	NULL	Achat perf 128	0.00	749.51	1	0	0	0	NULL	0	0	NULL	256	NULL	NULL	NULL
60	128	128	601008	0	Charge perf 601008	2018-02-22 00:00:00	NULL	NULL	NULL	AP128	NULL	Achat perf 128	749.51	0.00	1	0	0	0	NULL	0	0	NULL	255	NULL	NULL	NULL
60	129	129	401001	0	A Divers	2018-03-01 00:00:00	NULL	NULL	NULL	AP129	NULL	Achat perf 129	0.00	786.64	1	0	0	0	NULL	0	0	NULL	258	NULL	NULL	NULL
60	129	129	601009	0	Charge perf 601009	2018-03-01 00:00:00	NULL	NULL	NULL	AP129	NULL	Achat perf 129	786.64	0.00	1	0	0	0	NULL	0	0	NULL	257	NULL	NULL	NULL
60	131	131	401001	0	A Divers	2018-05-15 00:00:00	NULL	NULL	NULL	AP131	NULL	Achat perf 131	0.00	860.90	1	0	0	0	NULL	0	0	NULL	262	NULL	NULL	NULL
60	131	131	601011	0	Charge perf 601011	2018-05-15 00:00:00	NULL	NULL	NULL	AP131	NULL	Achat perf 131	860.90	0.00	1	0	0	0	NULL	0	0	NULL	261	NULL	NULL	NULL
60	132	132	401001	0	A Divers	2018-06-22 00:00:00	NULL	NULL	NULL	AP132	NULL	Achat perf 132	0.00	897.03	1	0	0	0	NULL	0	0	NULL	264	NULL	NULL	NULL
60	132	132	601012	0	Charge perf 601012	2018-06-22 00:00:00	NULL	NULL	NULL	AP132	NULL	Achat perf 132	897.03	0.00	1	0	0	0	NULL	0	0	NULL	263	NULL	NULL	NULL
60	134	134	401001	0	A Divers	2018-02-08 00:00:00	NULL	NULL	NULL	AP134	NULL	Achat perf 134	0.00	971.29	1	0	0	0	NULL	0	0	NULL	268	NULL	NULL	NULL
60	134	134	601014	0	Charge perf 601014	2018-02-08 00:00:00	NULL	NULL	NULL	AP134	NULL	Achat perf 134	971.29	0.00	1	0	0	0	NULL	0	0	NULL	267	NULL	NULL	NULL
60	135	135	401001	0	A Divers	2018-03-15 00:00:00	NULL	NULL	NULL	AP135	NULL	Achat perf 135	0.00	18.42	1	0	0	0	NULL	0	0	NULL	270	NULL	NULL	NULL
60	135	135	601015	0	Charge perf 601015	2018-03-15 00:00:00	NULL	NULL	NULL	AP135	NULL	Achat perf 135	18.42	0.00	1	0	0	0	NULL	0	0	NULL	269	NULL	NULL	NULL
60	137	137	401001	0	A Divers	2018-05-01 00:00:00	NULL	NULL	NULL	AP137	NULL	Achat perf 137	0.00	92.68	1	0	0	0	NULL	0	0	NULL	274	NULL	NULL	NULL
60	137	137	601017	0	Charge perf 601017	2018-05-01 00:00:00	NULL	NULL	NULL	AP137	NULL	Achat perf 137	92.68	0.00	1	0	0	0	NULL	0	0	NULL	273	NULL	NULL	NULL
60	138	138	401001	0	A Divers	2018-06-08 00:00:00	NULL	NULL	NULL	AP138	NULL	Achat perf 138	0.00	129.81	1	0	0	0	NULL	0	0	NULL	276	NULL	NULL	NULL
60	138	138	601018	0	Charge perf 601018	2018-06-08 00:00:00	NULL	NULL	NULL	AP138	NULL	Achat perf 138	129.81	0.00	1	0	0	0	NULL	0	0	NULL	275	NULL	NULL	NULL
60	14	14	401001	0	A Divers	2018-02-08 00:00:00	NULL	NULL	NULL	AP14	NULL	Achat perf 14	0.00	491.69	1	0	0	0	NULL	0	0	NULL	28	NULL	NULL	NULL
60	14	14	601014	0	Charge perf 601014	2018-02-08 00:00:00	NULL	NULL	NULL	AP14	NULL	Achat perf 14	491.69	0.00	1	0	0	0	NULL	0	0	NULL	27	NULL	NULL	NULL
60	140	140	401001	0	A Divers	2018-02-22 00:00:00	NULL	NULL	NULL	AP140	NULL	Achat perf 140	0.00	203.07	1	0	0	0	NULL	0	0	NULL	280	NULL	NULL	NULL
60	140	140	601020	0	Charge perf 601020	2018-02-22 00:00:00	NULL	NULL	NULL	AP140	NULL	Achat perf 140	203.07	0.00	1	0	0	0	NULL	0	0	NULL	279	NULL	NULL	NULL
60	141	141	401001	0	A Divers	2018-03-01 00:00:00	NULL	NULL	NULL	AP141	NULL	Achat perf 141	0.00	240.20	1	0	0	0	NULL	0	0	NULL	282	NULL	NULL	NULL
60	141	141	606101	0	Charge perf 606101	2018-03-01 00:00:00	NULL	NULL	NULL	AP141	NULL	Achat perf 141	240.20	0.00	1	0	0	0	NULL	0	0	NULL	281	NULL	NULL	NULL
60	143	143	401001	0	A Divers	2018-05-15 00:00:00	NULL	NULL	NULL	AP143	NULL	Achat perf 143	0.00	314.46	1	0	0	0	NULL	0	0	NULL	286	NULL	NULL	NULL
60	143	143	606103	0	Charge perf 606103	2018-05-15 00:00:00	NULL	NULL	NULL	AP143	NULL	Achat perf 143	314.46	0.00	1	0	0	0	NULL	0	0	NULL	285	NULL	NULL	NULL
60	144	144	401001	0	A Divers	2018-06-22 00:00:00	NULL	NULL	NULL	AP144	NULL	Achat perf 144	0.00	351.59	1	0	0	0	NULL	0	0	NULL	288	NULL	NULL	NULL
60	144	144	606104	0	Charge perf 606104	2018-06-22 00:00:00	NULL	NULL	NULL	AP144	NULL	Achat perf 144	351.59	0.00	1	0	0	0	NULL	0	0	NULL	287	NULL	NULL	NULL
60	146	146	401001	0	A Divers	2018-02-08 00:00:00	NULL	NULL	NULL	AP146	NULL	Achat perf 146	0.00	425.85	1	0	0	0	NULL	0	0	NULL	292	NULL	NULL	NULL
60	146	146	606106	0	Charge perf 606106	2018-02-08 00:00:00	NULL	NULL	NULL	AP146	NULL	Achat perf 146	425.85	0.00	1	0	0	0	NULL	0	0	NULL	291	NULL	NULL	NULL
60	147	147	401001	0	A Divers	2018-03-15 00:00:00	NULL	NULL	NULL	AP147	NULL	Achat perf 147	0.00	462.98	1	0	0	0	NULL	0	0	NULL	294	NULL	NULL	NULL
60	147	147	606107	0	Charge perf 606107	2018-03-15 00:00:00	NULL	NULL	NULL	AP147	NULL	Achat perf 147	462.98	0.00	1	0	0	0	NULL	0	0	NULL	293	NULL	NULL	NULL
60	149	149	401001	0	A Divers	2018-05-01 00:00:00	NULL	NULL	NULL	AP149	NULL	Achat perf 149	0.00	536.24	1	0	0	0	NULL	0	0	NULL	298	NULL	NULL	NULL
60	149	149	606109	0	Charge perf 606109	2018-05-01 00:00:00	NULL	NULL	NULL	AP149	NULL	Achat perf 149	536.24	0.00	1	0	0	0	NULL	0	0	NULL	297	NULL	NULL	NULL
60	15	15	401001	0	A Divers	2018-03-15 00:00:00	NULL	NULL	NULL	AP15	NULL	Achat perf 15	0.00	528.82	1	0	0	0	NULL	0	0	NULL	30	NULL	NULL	NULL
60	15	15	601015	0	Charge perf 601015	2018-03-15 00:00:00	NULL	NULL	NULL	AP15	NULL	Achat perf 15	528.82	0.00	1	0	0	0	NULL	0	0	NULL	29	NULL	NULL	NULL
60	150	150	401001	0	A Divers	2018-06-08 00:00:00	NULL	NULL	NULL	AP150	NULL	Achat perf 150	0.00	573.37	1	0	0	0	NULL	0	0	NULL	300	NULL	NULL	NULL
60	150	150	606110	0	Charge perf 606110	2018-06-08 00:00:00	NULL	NULL	NULL	AP150	NULL	Achat perf 150	573.37	0.00	1	0	0	0	NULL	0	0	NULL	299	NULL	NULL	NULL
60	152	152	401001	0	A Divers	2018-02-22 00:00:00	NULL	NULL	NULL	AP152	NULL	Achat perf 152	0.00	647.63	1	0	0	0	NULL	0	0	NULL	304	NULL	NULL	NULL
60	152	152	606112	0	Charge perf 606112	2018-02-22 00:00:00	NULL	NULL	NULL	AP152	NULL	Achat perf 152	647.63	0.00	1	0	0	0	NULL	0	0	NULL	303	NULL	NULL	NULL
60	153	153	401001	0	A Divers	2018-03-01 00:00:00	NULL	NULL	NULL	AP153	NULL	Achat perf 153	0.00	684.76	1	0	0	0	NULL	0	0	NULL	306	NULL	NULL	NULL
60	153	153	606113	0	Charge perf 606113	2018-03-01 00:00:00	NULL	NULL	NULL	AP153	NULL	Achat perf 153	684.76	0.00	1	0	0	0	NULL	0	0	NULL	305	NULL	NULL	NULL
60	155	155	401001	0	A Divers	2018-05-15 00:00:00	NULL	NULL	NULL	AP155	NULL	Achat perf 155	0.00	758.02	1	0	0	0	NULL	0	0	NULL	310	NULL	NULL	NULL
60	155	155	606115	0	Charge perf 606115	2018-05-15 00:00:00	NULL	NULL	NULL	AP155	NULL	Achat perf 155	758.02	0.00	1	0	0	0	NULL	0	0	NULL	309	NULL	NULL	NULL
60	156	156	401001	0	A Divers	2018-06-22 00:00:00	NULL	NULL	NULL	AP156	NULL	Achat perf 156	0.00	795.15	1	0	0	0	NULL	0	0	NULL	312	NULL	NULL	NULL
60	156	156	606116	0	Charge perf 606116	2018-06-22 00:00:00	NULL	NULL	NULL	AP156	NULL	Achat perf 156	795.15	0.00	1	0	0	0	NULL	0	0	NULL	311	NULL	NULL	NULL
60	158	158	401001	0	A Divers	2018-02-08 00:00:00	NULL	NULL	NULL	AP158	NULL	Achat perf 158	0.00	869.41	1	0	0	0	NULL	0	0	NULL	316	NULL	NULL	NULL
60	158	158	606118	0	Charge perf 606118	2018-02-08 00:00:00	NULL	NULL	NULL	AP158	NULL	Achat perf 158	869.41	0.00	1	0	0	0	NULL	0	0	NULL	315	NULL	NULL	NULL
60	159	159	401001	0	A Divers	2018-03-15 00:00:00	NULL	NULL	NULL	AP159	NULL	Achat perf 159	0.00	906.54	1	0	0	0	NULL	0	0	NULL	318	NULL	NULL	NULL
60	159	159	606119	0	Charge perf 606119	2018-03-15 00:00:00	NULL	NULL	NULL	AP159	NULL	Achat perf 159	906.54	0.00	1	0	0	0	NULL	0	0	NULL	317	NULL	NULL	NULL
60	161	161	401001	0	A Divers	2018-05-01 00:00:00	NULL	NULL	NULL	AP161	NULL	Achat perf 161	0.00	980.80	1	0	0	0	NULL	0	0	NULL	322	NULL	NULL	NULL
60	161	161	613101	0	Charge perf 613101	2018-05-01 00:00:00	NULL	NULL	NULL	AP161	NULL	Achat perf 161	980.80	0.00	1	0	0	0	NULL	0	0	NULL	321	NULL	NULL	NULL
60	162	162	401001	0	A Divers	2018-06-08 00:00:00	NULL	NULL	NULL	AP162	NULL	Achat perf 162	0.00	27.93	1	0	0	0	NULL	0	0	NULL	324	NULL	NULL	NULL
60	162	162	613102	0	Charge perf 613102	2018-06-08 00:00:00	NULL	NULL	NULL	AP162	NULL	Achat perf 162	27.93	0.00	1	0	0	0	NULL	0	0	NULL	323	NULL	NULL	NULL
60	164	164	401001	0	A Divers	2018-02-22 00:00:00	NULL	NULL	NULL	AP164	NULL	Achat perf 164	0.00	101.19	1	0	0	0	NULL	0	0	NULL	328	NULL	NULL	NULL
60	164	164	613104	0	Charge perf 613104	2018-02-22 00:00:00	NULL	NULL	NULL	AP164	NULL	Achat perf 164	101.19	0.00	1	0	0	0	NULL	0	0	NULL	327	NULL	NULL	NULL
60	165	165	401001	0	A Divers	2018-03-01 00:00:00	NULL	NULL	NULL	AP165	NULL	Achat perf 165	0.00	138.32	1	0	0	0	NULL	0	0	NULL	330	NULL	NULL	NULL
60	165	165	613105	0	Charge perf 613105	2018-03-01 00:00:00	NULL	NULL	NULL	AP165	NULL	Achat perf 165	138.32	0.00	1	0	0	0	NULL	0	0	NULL	329	NULL	NULL	NULL
60	167	167	401001	0	A Divers	2018-05-15 00:00:00	NULL	NULL	NULL	AP167	NULL	Achat perf 167	0.00	212.58	1	0	0	0	NULL	0	0	NULL	334	NULL	NULL	NULL
60	167	167	613107	0	Charge perf 613107	2018-05-15 00:00:00	NULL	NULL	NULL	AP167	NULL	Achat perf 167	212.58	0.00	1	0	0	0	NULL	0	0	NULL	333	NULL	NULL	NULL
60	168	168	401001	0	A Divers	2018-06-22 00:00:00	NULL	NULL	NULL	AP168	NULL	Achat perf 168	0.00	249.71	1	0	0	0	NULL	0	0	NULL	336	NULL	NULL	NULL
60	168	168	613108	0	Charge perf 613108	2018-06-22 00:00:00	NULL	NULL	NULL	AP168	NULL	Achat perf 168	249.71	0.00	1	0	0	0	NULL	0	0	NULL	335	NULL	NULL	NULL
60	17	17	401001	0	A Divers	2018-05-01 00:00:00	NULL	NULL	NULL	AP17	NULL	Achat perf 17	0.00	602.08	1	0	0	0	NULL	0	0	NULL	34	NULL	NULL	NULL
60	17	17	601017	0	Charge perf 601017	2018-05-01 00:00:00	NULL	NULL	NULL	AP17	NULL	Achat perf 17	602.08	0.00	1	0	0	0	NULL	0	0	NULL	33	NULL	NULL	NULL
60	170	170	401001	0	A Divers	2018-02-08 00:00:00	NULL	NULL	NULL	AP170	NULL	Achat perf 170	0.00	323.97	1	0	0	0	NULL	0	0	NULL	340	NULL	NULL	NULL
60	170	170	613110	0	Charge perf 613110	2018-02-08 00:00:00	NULL	NULL	NULL	AP170	NULL	Achat perf 170	323.97	0.00	1	0	0	0	NULL	0	0	NULL	339	NULL	NULL	NULL
60	171	171	401001	0	A Divers	2018-03-15 00:00:00	NULL	NULL	NULL	AP171	NULL	Achat perf 171	0.00	360.10	1	0	0	0	NULL	0	0	NULL	342	NULL	NULL	NULL
60	171	171	613111	0	Charge perf 613111	2018-03-15 00:00:00	NULL	NULL	NULL	AP171	NULL	Achat perf 171	360.10	0.00	1	0	0	0	NULL	0	0	NULL	341	NULL	NULL	NULL
60	173	173	401001	0	A Divers	2018-05-01 00:00:00	NULL	NULL	NULL	AP173	NULL	Achat perf 173	0.00	434.36	1	0	0	0	NULL	0	0	NULL	346	NULL	NULL	NULL
60	173	173	613113	0	Charge perf 613113	2018-05-01 00:00:00	NULL	NULL	NULL	AP173	NULL	Achat perf 173	434.36	0.00	1	0	0	0	NULL	0	0	NULL	345	NULL	NULL	NULL
60	174	174	401001	0	A Divers	2018-06-08 00:00:00	NULL	NULL	NULL	AP174	NULL	Achat perf 174	0.00	471.49	1	0	0	0	NULL	0	0	NULL	348	NULL	NULL	NULL
60	174	174	613114	0	Charge perf 613114	2018-06-08 00:00:00	NULL	NULL	NULL	AP174	NULL	Achat perf 174	471.49	0.00	1	0	0	0	NULL	0	0	NULL	347	NULL	NULL	NULL
60	176	176	401001	0	A Divers	2018-02-22 00:00:00	NULL	NULL	NULL	AP176	NULL	Achat perf 176	0.00	545.75	1	0	0	0	NULL	0	0	NULL	352	NULL	NULL	NULL
60	176	176	613116	0	Charge perf 613116	2018-02-22 00:00:00	NULL	NULL	NULL	AP176	NULL	Achat perf 176	545.75	0.00	1	0	0	0	NULL	0	0	NULL	351	NULL	NULL	NULL
60	177	177	401001	0	A Divers	2018-03-01 00:00:00	NULL	NULL	NULL	AP177	NULL	Achat perf 177	0.00	582.88	1	0	0	0	NULL	0	0	NULL	354	NULL	NULL	NULL
60	177	177	613117	0	Charge perf 613117	2018-03-01 00:00:00	NULL	NULL	NULL	AP177	NULL	Achat perf 177	582.88	0.00	1	0	0	0	NULL	0	0	NULL	353	NULL	NULL	NULL
60	179	179	401001	0	A Divers	2018-05-15 00:00:00	NULL	NULL	NULL	AP179	NULL	Achat perf 179	0.00	656.14	1	0	0	0	NULL	0	0	NULL	358	NULL	NULL	NULL
60	179	179	613119	0	Charge perf 613119	2018-05-15 00:00:00	NULL	NULL	NULL	AP179	NULL	Achat perf 179	656.14	0.00	1	0	0	0	NULL	0	0	NULL	357	NULL	NULL	NULL
60	18	18	401001	0	A Divers	2018-06-08 00:00:00	NULL	NULL	NULL	AP18	NULL	Achat perf 18	0.00	639.21	1	0	0	0	NULL	0	0	NULL	36	NULL	NULL	NULL
60	18	18	601018	0	Charge perf 601018	2018-06-08 00:00:00	NULL	NULL	NULL	AP18	NULL	Achat perf 18	639.21	0.00	1	0	0	0	NULL	0	0	NULL	35	NULL	NULL	NULL
60	180	180	401001	0	A Divers	2018-06-22 00:00:00	NULL	NULL	NULL	AP180	NULL	Achat perf 180	0.00	693.27	1	0	0	0	NULL	0	0	NULL	360	NULL	NULL	NULL
60	180	180	613120	0	Charge perf 613120	2018-06-22 00:00:00	NULL	NULL	NULL	AP180	NULL	Achat perf 180	693.27	0.00	1	0	0	0	NULL	0	0	NULL	359	NULL	NULL	NULL
60	182	182	401001	0	A Divers	2018-02-08 00:00:00	NULL	NULL	NULL	AP182	NULL	Achat perf 182	0.00	767.53	1	0	0	0	NULL	0	0	NULL	364	NULL	NULL	NULL
60	182	182	601002	0	Charge perf 601002	2018-02-08 00:00:00	NULL	NULL	NULL	AP182	NULL	Achat perf 182	767.53	0.00	1	0	0	0	NULL	0	0	NULL	363	NULL	NULL	NULL
60	183	183	401001	0	A Divers	2018-03-15 00:00:00	NULL	NULL	NULL	AP183	NULL	Achat perf 183	0.00	804.66	1	0	0	0	NULL	0	0	NULL	366	NULL	NULL	NULL
60	183	183	601003	0	Charge perf 601003	2018-03-15 00:00:00	NULL	NULL	NULL	AP183	NULL	Achat perf 183	804.66	0.00	1	0	0	0	NULL	0	0	NULL	365	NULL	NULL	NULL
60	185	185	401001	0	A Divers	2018-05-01 00:00:00	NULL	NULL	NULL	AP185	NULL	Achat perf 185	0.00	878.92	1	0	0	0	NULL	0	0	NULL	370	NULL	NULL	NULL
60	185	185	601005	0	Charge perf 601005	2018-05-01 00:00:00	NULL	NULL	NULL	AP185	NULL	Achat perf 185	878.92	0.00	1	0	0	0	NULL	0	0	NULL	369	NULL	NULL	NULL
60	186	186	401001	0	A Divers	2018-06-08 00:00:00	NULL	NULL	NULL	AP186	NULL	Achat perf 186	0.00	915.05	1	0	0	0	NULL	0	0	NULL	372	NULL	NULL	NULL
60	186	186	601006	0	Charge perf 601006	2018-06-08 00:00:00	NULL	NULL	NULL	AP186	NULL	Achat perf 186	915.05	0.00	1	0	0	0	NULL	0	0	NULL	371	NULL	NULL	NULL
60	188	188	401001	0	A Divers	2018-02-22 00:00:00	NULL	NULL	NULL	AP188	NULL	Achat perf 188	0.00	989.31	1	0	0	0	NULL	0	0	NULL	376	NULL	NULL	NULL
60	188	188	601008	0	Charge perf 601008	2018-02-22 00:00:00	NULL	NULL	NULL	AP188	NULL	Achat perf 188	989.31	0.00	1	0	0	0	NULL	0	0	NULL	375	NULL	NULL	NULL
60	189	189	401001	0	A Divers	2018-03-01 00:00:00	NULL	NULL	NULL	AP189	NULL	Achat perf 189	0.00	36.44	1	0	0	0	NULL	0	0	NULL	378	NULL	NULL	NULL
60	189	189	601009	0	Charge perf 601009	2018-03-01 00:00:00	NULL	NULL	NULL	AP189	NULL	Achat perf 189	36.44	0.00	1	0	0	0	NULL	0	0	NULL	377	NULL	NULL	NULL
60	191	191	401001	0	A Divers	2018-05-15 00:00:00	NULL	NULL	NULL	AP191	NULL	Achat perf 191	0.00	110.70	1	0	0	0	NULL	0	0	NULL	382	NULL	NULL	NULL
60	191	191	601011	0	Charge perf 601011	2018-05-15 00:00:00	NULL	NULL	NULL	AP191	NULL	Achat perf 191	110.70	0.00	1	0	0	0	NULL	0	0	NULL	381	NULL	NULL	NULL
60	192	192	401001	0	A Divers	2018-06-22 00:00:00	NULL	NULL	NULL	AP192	NULL	Achat perf 192	0.00	147.83	1	0	0	0	NULL	0	0	NULL	384	NULL	NULL	NULL
60	192	192	601012	0	Charge perf 601012	2018-06-22 00:00:00	NULL	NULL	NULL	AP192	NULL	Achat perf 192	147.83	0.00	1	0	0	0	NULL	0	0	NULL	383	NULL	NULL	NULL
60	194	194	401001	0	A Divers	2018-02-08 00:00:00	NULL	NULL	NULL	AP194	NULL	Achat perf 194	0.00	221.09	1	0	0	0	NULL	0	0	NULL	388	NULL	NULL	NULL
60	194	194	601014	0	Charge perf 601014	2018-02-08 00:00:00	NULL	NULL	NULL	AP194	NULL	Achat perf 194	221.09	0.00	1	0	0	0	NULL	0	0	NULL	387	NULL	NULL	NULL
60	195	195	401001	0	A Divers	2018-03-15 00:00:00	NULL	NULL	NULL	AP195	NULL	Achat perf 195	0.00	258.22	1	0	0	0	NULL	0	0	NULL	390	NULL	NULL	NULL
60	195	195	601015	0	Charge perf 601015	2018-03-15 00:00:00	NULL	NULL	NULL	AP195	NULL	Achat perf 195	258.22	0.00	1	0	0	0	NULL	0	0	NULL	389	NULL	NULL	NULL
60	197	197	401001	0	A Divers	2018-05-01 00:00:00	NULL	NULL	NULL	AP197	NULL	Achat perf 197	0.00	332.48	1	0	0	0	NULL	0	0	NULL	394	NULL	NULL	NULL
60	197	197	601017	0	Charge perf 601017	2018-05-01 00:00:00	NULL	NULL	NULL	AP197	NULL	Achat perf 197	332.48	0.00	1	0	0	0	NULL	0	0	NULL	393	NULL	NULL	NULL
60	198	198	401001	0	A Divers	2018-06-08 00:00:00	NULL	NULL	NULL	AP198	NULL	Achat perf 198	0.00	369.61	1	0	0	0	NULL	0	0	NULL	396	NULL	NULL	NULL
60	198	198	601018	0	Charge perf 601018	2018-06-08 00:00:00	NULL	NULL	NULL	AP198	NULL	Achat perf 198	369.61	0.00	1	0	0	0	NULL	0	0	NULL	395	NULL	NULL	NULL
60	2	2	401001	0	A Divers	2018-02-08 00:00:00	NULL	NULL	NULL	AP2	NULL	Achat perf 2	0.00	47.13	1	0	0	0	NULL	0	0	NULL	4	NULL	NULL	NULL
60	2	2	601002	0	Charge perf 601002	2018-02-08 00:00:00	NULL	NULL	NULL	AP2	NULL	Achat perf 2	47.13	0.00	1	0	0	0	NULL	0	0	NULL	3	NULL	NULL	NULL
60	20	20	401001	0	A Divers	2018-02-22 00:00:00	NULL	NULL	NULL	AP20	NULL	Achat perf 20	0.00	713.47	1	0	0	0	NULL	0	0	NULL	40	NULL	NULL	NULL
60	20	20	601020	0	Charge perf 601020	2018-02-22 00:00:00	NULL	NULL	NULL	AP20	NULL	Achat perf 20	713.47	0.00	1	0	0	0	NULL	0	0	NULL	39	NULL	NULL	NULL
60	200	200	401001	0	A Divers	2018-02-22 00:00:00	NULL	NULL	NULL	AP200	NULL	Achat perf 200	0.00	443.87	1	0	0	0	NULL	0	0	NULL	400	NULL	NULL	NULL
60	200	200	601020	0	Charge perf 601020	2018-02-22 00:00:00	NULL	NULL	NULL	AP200	NULL	Achat perf 200	443.87	0.00	1	0	0	0	NULL	0	0	NULL	399	NULL	NULL	NULL
60	201	201	401001	0	A Divers	2018-03-01 00:00:00	NULL	NULL	NULL	AP201	NULL	Achat perf 201	0.00	480.00	1	0	0	0	NULL	0	0	NULL	402	NULL	NULL	NULL
60	201	201	606101	0	Charge perf 606101	2018-03-01 00:00:00	NULL	NULL	NULL	AP201	NULL	Achat perf 201	480.00	0.00	1	0	0	0	NULL	0	0	NULL	401	NULL	NULL	NULL
60	203	203	401001	0	A Divers	2018-05-15 00:00:00	NULL	NULL	NULL	AP203	NULL	Achat perf 203	0.00	554.26	1	0	0	0	NULL	0	0	NULL	406	NULL	NULL	NULL
60	203	203	606103	0	Charge perf 606103	2018-05-15 00:00:00	NULL	NULL	NULL	AP203	NULL	Achat perf 203	554.26	0.00	1	0	0	0	NULL	0	0	NULL	405	NULL	NULL	NULL
60	204	204	401001	0	A Divers	2018-06-22 00:00:00	NULL	NULL	NULL	AP204	NULL	Achat perf 204	0.00	591.39	1	0	0	0	NULL	0	0	NULL	408	NULL	NULL	NULL
60	204	204	606104	0	Charge perf 606104	2018-06-22 00:00:00	NULL	NULL	NULL	AP204	NULL	Achat perf 204	591.39	0.00	1	0	0	0	NULL	0	0	NULL	407	NULL	NULL	NULL
60	206	206	401001	0	A Divers	2018-02-08 00:00:00	NULL	NULL	NULL	AP206	NULL	Achat perf 206	0.00	665.65	1	0	0	0	NULL	0	0	NULL	412	NULL	NULL	NULL
60	206	206	606106	0	Charge perf 606106	2018-02-08 00:00:00	NULL	NULL	NULL	AP206	NULL	Achat perf 206	665.65	0.00	1	0	0	0	NULL	0	0	NULL	411	NULL	NULL	NULL
60	207	207	401001	0	A Divers	2018-03-15 00:00:00	NULL	NULL	NULL	AP207	NULL	Achat perf 207	0.00	702.78	1	0	0	0	NULL	0	0	NULL	414	NULL	NULL	NULL
60	207	207	606107	0	Charge perf 606107	2018-03-15 00:00:00	NULL	NULL	NULL	AP207	NULL	Achat perf 207	702.78	0.00	1	0	0	0	NULL	0	0	NULL	413	NULL	NULL	NULL
60	209	209	401001	0	A Divers	2018-05-01 00:00:00	NULL	NULL	NULL	AP209	NULL	Achat perf 209	0.00	776.04	1	0	0	0	NULL	0	0	NULL	418	NULL	NULL	NULL
60	209	209	606109	0	Charge perf 606109	2018-05-01 00:00:00	NULL	NULL	NULL	AP209	NULL	Achat perf 209	776.04	0.00	1	0	0	0	NULL	0	0	NULL	417	NULL	NULL	NULL
60	21	21	401001	0	A Divers	2018-03-01 00:00:00	NULL	NULL	NULL	AP21	NULL	Achat perf 21	0.00	750.60	1	0	0	0	NULL	0	0	NULL	42	NULL	NULL	NULL
60	21	21	606101	0	Charge perf 606101	2018-03-01 00:00:00	NULL	NULL	NULL	AP21	NULL	Achat perf 21	750.60	0.00	1	0	0	0	NULL	0	0	NULL	41	NULL	NULL	NULL
60	210	210	401001	0	A Divers	2018-06-08 00:00:00	NULL	NULL	NULL	AP210	NULL	Achat perf 210	0.00	813.17	1	0	0	0	NULL	0	0	NULL	420	NULL	NULL	NULL
60	210	210	606110	0	Charge perf 606110	2018-06-08 00:00:00	NULL	NULL	NULL	AP210	NULL	Achat perf 210	813.17	0.00	1	0	0	0	NULL	0	0	NULL	419	NULL	NULL	NULL
60	212	212	401001	0	A Divers	2018-02-22 00:00:00	NULL	NULL	NULL	AP212	NULL	Achat perf 212	0.00	887.43	1	0	0	0	NULL	0	0	NULL	424	NULL	NULL	NULL
60	212	212	606112	0	Charge perf 606112	2018-02-22 00:00:00	NULL	NULL	NULL	AP212	NULL	Achat perf 212	887.43	0.00	1	0	0	0	NULL	0	0	NULL	423	NULL	NULL	NULL
60	213	213	401001	0	A Divers	2018-03-01 00:00:00	NULL	NULL	NULL	AP213	NULL	Achat perf 213	0.00	924.56	1	0	0	0	NULL	0	0	NULL	426	NULL	NULL	NULL
60	213	213	606113	0	Charge perf 606113	2018-03-01 00:00:00	NULL	NULL	NULL	AP213	NULL	Achat perf 213	924.56	0.00	1	0	0	0	NULL	0	0	NULL	425	NULL	NULL	NULL
60	215	215	401001	0	A Divers	2018-05-15 00:00:00	NULL	NULL	NULL	AP215	NULL	Achat perf 215	0.00	998.82	1	0	0	0	NULL	0	0	NULL	430	NULL	NULL	NULL
60	215	215	606115	0	Charge perf 606115	2018-05-15 00:00:00	NULL	NULL	NULL	AP215	NULL	Achat perf 215	998.82	0.00	1	0	0	0	NULL	0	0	NULL	429	NULL	NULL	NULL
60	216	216	401001	0	A Divers	2018-06-22 00:00:00	NULL	NULL	NULL	AP216	NULL	Achat perf 216	0.00	45.95	1	0	0	0	NULL	0	0	NULL	432	NULL	NULL	NULL
60	216	216	606116	0	Charge perf 606116	2018-06-22 00:00:00	NULL	NULL	NULL	AP216	NULL	Achat perf 216	45.95	0.00	1	0	0	0	NULL	0	0	NULL	431	NULL	NULL	NULL
60	218	218	401001	0	A Divers	2018-02-08 00:00:00	NULL	NULL	NULL	AP218	NULL	Achat perf 218	0.00	119.21	1	0	0	0	NULL	0	0	NULL	436	NULL	NULL	NULL
60	218	218	606118	0	Charge perf 606118	2018-02-08 00:00:00	NULL	NULL	NULL	AP218	NULL	Achat perf 218	119.21	0.00	1	0	0	0	NULL	0	0	NULL	435	NULL	NULL	NULL
60	219	219	401001	0	A Divers	2018-03-15 00:00:00	NULL	NULL	NULL	AP219	NULL	Achat perf 219	0.00	156.34	1	0	0	0	NULL	0	0	NULL	438	NULL	NULL	NULL
60	219	219	606119	0	Charge perf 606119	2018-03-15 00:00:00	NULL	NULL	NULL	AP219	NULL	Achat perf 219	156.34	0.00	1	0	0	0	NULL	0	0	NULL	437	NULL	NULL	NULL
60	221	221	401001	0	A Divers	2018-05-01 00:00:00	NULL	NULL	NULL	AP221	NULL	Achat perf 221	0.00	230.60	1	0	0	0	NULL	0	0	NULL	442	NULL	NULL	NULL
60	221	221	613101	0	Charge perf 613101	2018-05-01 00:00:00	NULL	NULL	NULL	AP221	NULL	Achat perf 221	230.60	0.00	1	0	0	0	NULL	0	0	NULL	441	NULL	NULL	NULL
60	222	222	401001	0	A Divers	2018-06-08 00:00:00	NULL	NULL	NULL	AP222	NULL	Achat perf 222	0.00	267.73	1	0	0	0	NULL	0	0	NULL	444	NULL	NULL	NULL
60	222	222	613102	0	Charge perf 613102	2018-06-08 00:00:00	NULL	NULL	NULL	AP222	NULL	Achat perf 222	267.73	0.00	1	0	0	0	NULL	0	0	NULL	443	NULL	NULL	NULL
60	224	224	401001	0	A Divers	2018-02-22 00:00:00	NULL	NULL	NULL	AP224	NULL	Achat perf 224	0.00	341.99	1	0	0	0	NULL	0	0	NULL	448	NULL	NULL	NULL
60	224	224	613104	0	Charge perf 613104	2018-02-22 00:00:00	NULL	NULL	NULL	AP224	NULL	Achat perf 224	341.99	0.00	1	0	0	0	NULL	0	0	NULL	447	NULL	NULL	NULL
60	225	225	401001	0	A Divers	2018-03-01 00:00:00	NULL	NULL	NULL	AP225	NULL	Achat perf 225	0.00	378.12	1	0	0	0	NULL	0	0	NULL	450	NULL	NULL	NULL
60	225	225	613105	0	Charge perf 613105	2018-03-01 00:00:00	NULL	NULL	NULL	AP225	NULL	Achat perf 225	378.12	0.00	1	0	0	0	NULL	0	0	NULL	449	NULL	NULL	NULL
60	227	227	401001	0	A Divers	2018-05-15 00:00:00	NULL	NULL	NULL	AP227	NULL	Achat perf 227	0.00	452.38	1	0	0	0	NULL	0	0	NULL	454	NULL	NULL	NULL
60	227	227	613107	0	Charge perf 613107	2018-05-15 00:00:00	NULL	NULL	NULL	AP227	NULL	Achat perf 227	452.38	0.00	1	0	0	0	NULL	0	0	NULL	453	NULL	NULL	NULL
60	228	228	401001	0	A Divers	2018-06-22 00:00:00	NULL	NULL	NULL	AP228	NULL	Achat perf 228	0.00	489.51	1	0	0	0	NULL	0	0	NULL	456	NULL	NULL	NULL
60	228	228	613108	0	Charge perf 613108	2018-06-22 00:00:00	NULL	NULL	NULL	AP228	NULL	Achat perf 228	489.51	0.00	1	0	0	0	NULL	0	0	NULL	455	NULL	NULL	NULL
60	23	23	401001	0	A Divers	2018-05-15 00:00:00	NULL	NULL	NULL	AP23	NULL	Achat perf 23	0.00	824.86	1	0	0	0	NULL	0	0	NULL	46	NULL	NULL	NULL
60	23	23	606103	0	Charge perf 606103	2018-05-15 00:00:00	NULL	NULL	NULL	AP23	NULL	Achat perf 23	824.86	0.00	1	0	0	0	NULL	0	0	NULL	45	NULL	NULL	NULL
60	230	230	401001	0	A Divers	2018-02-08 00:00:00	NULL	NULL	NULL	AP230	NULL	Achat perf 230	0.00	563.77	1	0	0	0	NULL	0	0	NULL	460	NULL	NULL	NULL
60	230	230	613110	0	Charge perf 613110	2018-02-08 00:00:00	NULL	NULL	NULL	AP230	NULL	Achat perf 230	563.77	0.00	1	0	0	0	NULL	0	0	NULL	459	NULL	NULL	NULL
60	231	231	401001	0	A Divers	2018-03-15 00:00:00	NULL	NULL	NULL	AP231	NULL	Achat perf 231	0.00	600.90	1	0	0	0	NULL	0	0	NULL	462	NULL	NULL	NULL
60	231	231	613111	0	Charge perf 613111	2018-03-15 00:00:00	NULL	NULL	NULL	AP231	NULL	Achat perf 231	600.90	0.00	1	0	0	0	NULL	0	0	NULL	461	NULL	NULL	NULL
60	233	233	401001	0	A Divers	2018-05-01 00:00:00	NULL	NULL	NULL	AP233	NULL	Achat perf 233	0.00	674.16	1	0	0	0	NULL	0	0	NULL	466	NULL	NULL	NULL
60	233	233	613113	0	Charge perf 613113	2018-05-01 00:00:00	NULL	NULL	NULL	AP233	NULL	Achat perf 233	674.16	0.00	1	0	0	0	NULL	0	0	NULL	465	NULL	NULL	NULL
60	234	234	401001	0	A Divers	2018-06-08 00:00:00	NULL	NULL	NULL	AP234	NULL	Achat perf 234	0.00	711.29	1	0	0	0	NULL	0	0	NULL	468	NULL	NULL	NULL
60	234	234	613114	0	Charge perf 613114	2018-06-08 00:00:00	NULL	NULL	NULL	AP234	NULL	Achat perf 234	711.29	0.00	1	0	0	0	NULL	0	0	NULL	467	NULL	NULL	NULL
60	236	236	401001	0	A Divers	2018-02-22 00:00:00	NULL	NULL	NULL	AP236	NULL	Achat perf 236	0.00	785.55	1	0	0	0	NULL	0	0	NULL	472	NULL	NULL	NULL
60	236	236	613116	0	Charge perf 613116	2018-02-22 00:00:00	NULL	NULL	NULL	AP236	NULL	Achat perf 236	785.55	0.00	1	0	0	0	NULL	0	0	NULL	471	NULL	NULL	NULL
60	237	237	401001	0	A Divers	2018-03-01 00:00:00	NULL	NULL	NULL	AP237	NULL	Achat perf 237	0.00	822.68	1	0	0	0	NULL	0	0	NULL	474	NULL	NULL	NULL
60	237	237	613117	0	Charge perf 613117	2018-03-01 00:00:00	NULL	NULL	NULL	AP237	NULL	Achat perf 237	822.68	0.00	1	0	0	0	NULL	0	0	NULL	473	NULL	NULL	NULL
60	239	239	401001	0	A Divers	2018-05-15 00:00:00	NULL	NULL	NULL	AP239	NULL	Achat perf 239	0.00	896.94	1	0	0	0	NULL	0	0	NULL	478	NULL	NULL	NULL
60	239	239	613119	0	Charge perf 613119	2018-05-15 00:00:00	NULL	NULL	NULL	AP239	NULL	Achat perf 239	896.94	0.00	1	0	0	0	NULL	0	0	NULL	477	NULL	NULL	NULL
60	24	24	401001	0	A Divers	2018-06-22 00:00:00	NULL	NULL	NULL	AP24	NULL	Achat perf 24	0.00	861.99	1	0	0	0	NULL	0	0	NULL	48	NULL	NULL	NULL
60	24	24	606104	0	Charge perf 606104	2018-06-22 00:00:00	NULL	NULL	NULL	AP24	NULL	Achat perf 24	861.99	0.00	1	0	0	0	NULL	0	0	NULL	47	NULL	NULL	NULL
60	240	240	401001	0	A Divers	2018-06-22 00:00:00	NULL	NULL	NULL	AP240	NULL	Achat perf 240	0.00	933.07	1	0	0	0	NULL	0	0	NULL	480	NULL	NULL	NULL
60	240	240	613120	0	Charge perf 613120	2018-06-22 00:00:00	NULL	NULL	NULL	AP240	NULL	Achat perf 240	933.07	0.00	1	0	0	0	NULL	0	0	NULL	479	NULL	NULL	NULL
60	242	242	401001	0	A Divers	2018-02-08 00:00:00	NULL	NULL	NULL	AP242	NULL	Achat perf 242	0.00	17.33	1	0	0	0	NULL	0	0	NULL	484	NULL	NULL	NULL
60	242	242	601002	0	Charge perf 601002	2018-02-08 00:00:00	NULL	NULL	NULL	AP242	NULL	Achat perf 242	17.33	0.00	1	0	0	0	NULL	0	0	NULL	483	NULL	NULL	NULL
60	243	243	401001	0	A Divers	2018-03-15 00:00:00	NULL	NULL	NULL	AP243	NULL	Achat perf 243	0.00	54.46	1	0	0	0	NULL	0	0	NULL	486	NULL	NULL	NULL
60	243	243	601003	0	Charge perf 601003	2018-03-15 00:00:00	NULL	NULL	NULL	AP243	NULL	Achat perf 243	54.46	0.00	1	0	0	0	NULL	0	0	NULL	485	NULL	NULL	NULL
60	245	245	401001	0	A Divers	2018-05-01 00:00:00	NULL	NULL	NULL	AP245	NULL	Achat perf 245	0.00	128.72	1	0	0	0	NULL	0	0	NULL	490	NULL	NULL	NULL
60	245	245	601005	0	Charge perf 601005	2018-05-01 00:00:00	NULL	NULL	NULL	AP245	NULL	Achat perf 245	128.72	0.00	1	0	0	0	NULL	0	0	NULL	489	NULL	NULL	NULL
60	246	246	401001	0	A Divers	2018-06-08 00:00:00	NULL	NULL	NULL	AP246	NULL	Achat perf 246	0.00	165.85	1	0	0	0	NULL	0	0	NULL	492	NULL	NULL	NULL
60	246	246	601006	0	Charge perf 601006	2018-06-08 00:00:00	NULL	NULL	NULL	AP246	NULL	Achat perf 246	165.85	0.00	1	0	0	0	NULL	0	0	NULL	491	NULL	NULL	NULL
60	248	248	401001	0	A Divers	2018-02-22 00:00:00	NULL	NULL	NULL	AP248	NULL	Achat perf 248	0.00	239.11	1	0	0	0	NULL	0	0	NULL	496	NULL	NULL	NULL
60	248	248	601008	0	Charge perf 601008	2018-02-22 00:00:00	NULL	NULL	NULL	AP248	NULL	Achat perf 248	239.11	0.00	1	0	0	0	NULL	0	0	NULL	495	NULL	NULL	NULL
60	249	249	401001	0	A Divers	2018-03-01 00:00:00	NULL	NULL	NULL	AP249	NULL	Achat perf 249	0.00	276.24	1	0	0	0	NULL	0	0	NULL	498	NULL	NULL	NULL
60	249	249	601009	0	Charge perf 601009	2018-03-01 00:00:00	NULL	NULL	NULL	AP249	NULL	Achat perf 249	276.24	0.00	1	0	0	0	NULL	0	0	NULL	497	NULL	NULL	NULL
60	251	251	401001	0	A Divers	2018-05-15 00:00:00	NULL	NULL	NULL	AP251	NULL	Achat perf 251	0.00	350.50	1	0	0	0	NULL	0	0	NULL	502	NULL	NULL	NULL
60	251	251	601011	0	Charge perf 601011	2018-05-15 00:00:00	NULL	NULL	NULL	AP251	NULL	Achat perf 251	350.50	0.00	1	0	0	0	NULL	0	0	NULL	501	NULL	NULL	NULL
60	252	252	401001	0	A Divers	2018-06-22 00:00:00	NULL	NULL	NULL	AP252	NULL	Achat perf 252	0.00	387.63	1	0	0	0	NULL	0	0	NULL	504	NULL	NULL	NULL
60	252	252	601012	0	Charge perf 601012	2018-06-22 00:00:00	NULL	NULL	NULL	AP252	NULL	Achat perf 252	387.63	0.00	1	0	0	0	NULL	0	0	NULL	503	NULL	NULL	NULL
60	254	254	401001	0	A Divers	2018-02-08 00:00:00	NULL	NULL	NULL	AP254	NULL	Achat perf 254	0.00	461.89	1	0	0	0	NULL	0	0	NULL	508	NULL	NULL	NULL
60	254	254	601014	0	Charge perf 601014	2018-02-08 00:00:00	NULL	NULL	NULL	AP254	NULL	Achat perf 254	461.89	0.00	1	0	0	0	NULL	0	0	NULL	507	NULL	NULL	NULL
60	255	255	401001	0	A Divers	2018-03-15 00:00:00	NULL	NULL	NULL	AP255	NULL	Achat perf 255	0.00	498.02	1	0	0	0	NULL	0	0	NULL	510	NULL	NULL	NULL
60	255	255	601015	0	Charge perf 601015	2018-03-15 00:00:00	NULL	NULL	NULL	AP255	NULL	Achat perf 255	498.02	0.00	1	0	0	0	NULL	0	0	NULL	509	NULL	NULL	NULL
60	257	257	401001	0	A Divers	2018-05-01 00:00:00	NULL	NULL	NULL	AP257	NULL	Achat perf 257	0.00	572.28	1	0	0	0	NULL	0	0	NULL	514	NULL	NULL	NULL
60	257	257	601017	0	Charge perf 601017	2018-05-01 00:00:00	NULL	NULL	NULL	AP257	NULL	Achat perf 257	572.28	0.00	1	0	0	0	NULL	0	0	NULL	513	NULL	NULL	NULL
60	258	258	401001	0	A Divers	2018-06-08 00:00:00	NULL	NULL	NULL	AP258	NULL	Achat perf 258	0.00	609.41	1	0	0	0	NULL	0	0	NULL	516	NULL	NULL	NULL
60	258	258	601018	0	Charge perf 601018	2018-06-08 00:00:00	NULL	NULL	NULL	AP258	NULL	Achat perf 258	609.41	0.00	1	0	0	0	NULL	0	0	NULL	515	NULL	NULL	NULL
60	26	26	401001	0	A Divers	2018-02-08 00:00:00	NULL	NULL	NULL	AP26	NULL	Achat perf 26	0.00	935.25	1	0	0	0	NULL	0	0	NULL	52	NULL	NULL	NULL
60	26	26	606106	0	Charge perf 606106	2018-02-08 00:00:00	NULL	NULL	NULL	AP26	NULL	Achat perf 26	935.25	0.00	1	0	0	0	NULL	0	0	NULL	51	NULL	NULL	NULL
60	260	260	401001	0	A Divers	2018-02-22 00:00:00	NULL	NULL	NULL	AP260	NULL	Achat perf 260	0.00	683.67	1	0	0	0	NULL	0	0	NULL	520	NULL	NULL	NULL
60	260	260	601020	0	Charge perf 601020	2018-02-22 00:00:00	NULL	NULL	NULL	AP260	NULL	Achat perf 260	683.67	0.00	1	0	0	0	NULL	0	0	NULL	519	NULL	NULL	NULL
60	261	261	401001	0	A Divers	2018-03-01 00:00:00	NULL	NULL	NULL	AP261	NULL	Achat perf 261	0.00	720.80	1	0	0	0	NULL	0	0	NULL	522	NULL	NULL	NULL
60	261	261	606101	0	Charge perf 606101	2018-03-01 00:00:00	NULL	NULL	NULL	AP261	NULL	Achat perf 261	720.80	0.00	1	0	0	0	NULL	0	0	NULL	521	NULL	NULL	NULL
60	263	263	401001	0	A Divers	2018-05-15 00:00:00	NULL	NULL	NULL	AP263	NULL	Achat perf 263	0.00	794.06	1	0	0	0	NULL	0	0	NULL	526	NULL	NULL	NULL
60	263	263	606103	0	Charge perf 606103	2018-05-15 00:00:00	NULL	NULL	NULL	AP263	NULL	Achat perf 263	794.06	0.00	1	0	0	0	NULL	0	0	NULL	525	NULL	NULL	NULL
60	264	264	401001	0	A Divers	2018-06-22 00:00:00	NULL	NULL	NULL	AP264	NULL	Achat perf 264	0.00	831.19	1	0	0	0	NULL	0	0	NULL	528	NULL	NULL	NULL
60	264	264	606104	0	Charge perf 606104	2018-06-22 00:00:00	NULL	NULL	NULL	AP264	NULL	Achat perf 264	831.19	0.00	1	0	0	0	NULL	0	0	NULL	527	NULL	NULL	NULL
60	266	266	401001	0	A Divers	2018-02-08 00:00:00	NULL	NULL	NULL	AP266	NULL	Achat perf 266	0.00	905.45	1	0	0	0	NULL	0	0	NULL	532	NULL	NULL	NULL
60	266	266	606106	0	Charge perf 606106	2018-02-08 00:00:00	NULL	NULL	NULL	AP266	NULL	Achat perf 266	905.45	0.00	1	0	0	0	NULL	0	0	NULL	531	NULL	NULL	NULL
60	267	267	401001	0	A Divers	2018-03-15 00:00:00	NULL	NULL	NULL	AP267	NULL	Achat perf 267	0.00	942.58	1	0	0	0	NULL	0	0	NULL	534	NULL	NULL	NULL
60	267	267	606107	0	Charge perf 606107	2018-03-15 00:00:00	NULL	NULL	NULL	AP267	NULL	Achat perf 267	942.58	0.00	1	0	0	0	NULL	0	0	NULL	533	NULL	NULL	NULL
60	269	269	401001	0	A Divers	2018-05-01 00:00:00	NULL	NULL	NULL	AP269	NULL	Achat perf 269	0.00	26.84	1	0	0	0	NULL	0	0	NULL	538	NULL	NULL	NULL
60	269	269	606109	0	Charge perf 606109	2018-05-01 00:00:00	NULL	NULL	NULL	AP269	NULL	Achat perf 269	26.84	0.00	1	0	0	0	NULL	0	0	NULL	537	NULL	NULL	NULL
60	27	27	401001	0	A Divers	2018-03-15 00:00:00	NULL	NULL	NULL	AP27	NULL	Achat perf 27	0.00	972.38	1	0	0	0	NULL	0	0	NULL	54	NULL	NULL	NULL
60	27	27	606107	0	Charge perf 606107	2018-03-15 00:00:00	NULL	NULL	NULL	AP27	NULL	Achat perf 27	972.38	0.00	1	0	0	0	NULL	0	0	NULL	53	NULL	NULL	NULL
60	270	270	401001	0	A Divers	2018-06-08 00:00:00	NULL	NULL	NULL	AP270	NULL	Achat perf 270	0.00	63.97	1	0	0	0	NULL	0	0	NULL	540	NULL	NULL	NULL
60	270	270	606110	0	Charge perf 606110	2018-06-08 00:00:00	NULL	NULL	NULL	AP270	NULL	Achat perf 270	63.97	0.00	1	0	0	0	NULL	0	0	NULL	539	NULL	NULL	NULL
60	272	272	401001	0	A Divers	2018-02-22 00:00:00	NULL	NULL	NULL	AP272	NULL	Achat perf 272	0.00	137.23	1	0	0	0	NULL	0	0	NULL	544	NULL	NULL	NULL
60	272	272	606112	0	Charge perf 606112	2018-02-22 00:00:00	NULL	NULL	NULL	AP272	NULL	Achat perf 272	137.23	0.00	1	0	0	0	NULL	0	0	NULL	543	NULL	NULL	NULL
60	273	273	401001	0	A Divers	2018-03-01 00:00:00	NULL	NULL	NULL	AP273	NULL	Achat perf 273	0.00	174.36	1	0	0	0	NULL	0	0	NULL	546	NULL	NULL	NULL
60	273	273	606113	0	Charge perf 606113	2018-03-01 00:00:00	NULL	NULL	NULL	AP273	NULL	Achat perf 273	174.36	0.00	1	0	0	0	NULL	0	0	NULL	545	NULL	NULL	NULL
60	275	275	401001	0	A Divers	2018-05-15 00:00:00	NULL	NULL	NULL	AP275	NULL	Achat perf 275	0.00	248.62	1	0	0	0	NULL	0	0	NULL	550	NULL	NULL	NULL
60	275	275	606115	0	Charge perf 606115	2018-05-15 00:00:00	NULL	NULL	NULL	AP275	NULL	Achat perf 275	248.62	0.00	1	0	0	0	NULL	0	0	NULL	549	NULL	NULL	NULL
60	276	276	401001	0	A Divers	2018-06-22 00:00:00	NULL	NULL	NULL	AP276	NULL	Achat perf 276	0.00	285.75	1	0	0	0	NULL	0	0	NULL	552	NULL	NULL	NULL
60	276	276	606116	0	Charge perf 606116	2018-06-22 00:00:00	NULL	NULL	NULL	AP276	NULL	Achat perf 276	285.75	0.00	1	0	0	0	NULL	0	0	NULL	551	NULL	NULL	NULL
60	278	278	401001	0	A Divers	2018-02-08 00:00:00	NULL	NULL	NULL	AP278	NULL	Achat perf 278	0.00	359.01	1	0	0	0	NULL	0	0	NULL	556	NULL	NULL	NULL
60	278	278	606118	0	Charge perf 606118	2018-02-08 00:00:00	NULL	NULL	NULL	AP278	NULL	Achat perf 278	359.01	0.00	1	0	0	0	NULL	0	0	NULL	555	NULL	NULL	NULL
60	279	279	401001	0	A Divers	2018-03-15 00:00:00	NULL	NULL	NULL	AP279	NULL	Achat perf 279	0.00	396.14	1	0	0	0	NULL	0	0	NULL	558	NULL	NULL	NULL
60	279	279	606119	0	Charge perf 606119	2018-03-15 00:00:00	NULL	NULL	NULL	AP279	NULL	Achat perf 279	396.14	0.00	1	0	0	0	NULL	0	0	NULL	557	NULL	NULL	NULL
60	281	281	401001	0	A Divers	2018-05-01 00:00:00	NULL	NULL	NULL	AP281	NULL	Achat perf 281	0.00	470.40	1	0	0	0	NULL	0	0	NULL	562	NULL	NULL	NULL
60	281	281	613101	0	Charge perf 613101	2018-05-01 00:00:00	NULL	NULL	NULL	AP281	NULL	Achat perf 281	470.40	0.00	1	0	0	0	NULL	0	0	NULL	561	NULL	NULL	NULL
60	282	282	401001	0	A Divers	2018-06-08 00:00:00	NULL	NULL	NULL	AP282	NULL	Achat perf 282	0.00	507.53	1	0	0	0	NULL	0	0	NULL	564	NULL	NULL	NULL
60	282	282	613102	0	Charge perf 613102	2018-06-08 00:00:00	NULL	NULL	NULL	AP282	NULL	Achat perf 282	507.53	0.00	1	0	0	0	NULL	0	0	NULL	563	NULL	NULL	NULL
60	284	284	401001	0	A Divers	2018-02-22 00:00:00	NULL	NULL	NULL	AP284	NULL	Achat perf 284	0.00	581.79	1	0	0	0	NULL	0	0	NULL	568	NULL	NULL	NULL
60	284	284	613104	0	Charge perf 613104	2018-02-22 00:00:00	NULL	NULL	NULL	AP284	NULL	Achat perf 284	581.79	0.00	1	0	0	0	NULL	0	0	NULL	567	NULL	NULL	NULL
60	285	285	401001	0	A Divers	2018-03-01 00:00:00	NULL	NULL	NULL	AP285	NULL	Achat perf 285	0.00	618.92	1	0	0	0	NULL	0	0	NULL	570	NULL	NULL	NULL
60	285	285	613105	0	Charge perf 613105	2018-03-01 00:00:00	NULL	NULL	NULL	AP285	NULL	Achat perf 285	618.92	0.00	1	0	0	0	NULL	0	0	NULL	569	NULL	NULL	NULL
60	287	287	401001	0	A Divers	2018-05-15 00:00:00	NULL	NULL	NULL	AP287	NULL	Achat perf 287	0.00	692.18	1	0	0	0	NULL	0	0	NULL	574	NULL	NULL	NULL
60	287	287	613107	0	Charge perf 613107	2018-05-15 00:00:00	NULL	NULL	NULL	AP287	NULL	Achat perf 287	692.18	0.00	1	0	0	0	NULL	0	0	NULL	573	NULL	NULL	NULL
60	288	288	401001	0	A Divers	2018-06-22 00:00:00	NULL	NULL	NULL	AP288	NULL	Achat perf 288	0.00	729.31	1	0	0	0	NULL	0	0	NULL	576	NULL	NULL	NULL
60	288	288	613108	0	Charge perf 613108	2018-06-22 00:00:00	NULL	NULL	NULL	AP288	NULL	Achat perf 288	729.31	0.00	1	0	0	0	NULL	0	0	NULL	575	NULL	NULL	NULL
60	29	29	401001	0	A Divers	2018-05-01 00:00:00	NULL	NULL	NULL	AP29	NULL	Achat perf 29	0.00	56.64	1	0	0	0	NULL	0	0	NULL	58	NULL	NULL	NULL
60	29	29	606109	0	Charge perf 606109	2018-05-01 00:00:00	NULL	NULL	NULL	AP29	NULL	Achat perf 29	56.64	0.00	1	0	0	0	NULL	0	0	NULL	57	NULL	NULL	NULL
60	290	290	401001	0	A Divers	2018-02-08 00:00:00	NULL	NULL	NULL	AP290	NULL	Achat perf 290	0.00	803.57	1	0	0	0	NULL	0	0	NULL	580	NULL	NULL	NULL
60	290	290	613110	0	Charge perf 613110	2018-02-08 00:00:00	NULL	NULL	NULL	AP290	NULL	Achat perf 290	803.57	0.00	1	0	0	0	NULL	0	0	NULL	579	NULL	NULL	NULL
60	291	291	401001	0	A Divers	2018-03-15 00:00:00	NULL	NULL	NULL	AP291	NULL	Achat perf 291	0.00	840.70	1	0	0	0	NULL	0	0	NULL	582	NULL	NULL	NULL
60	291	291	613111	0	Charge perf 613111	2018-03-15 00:00:00	NULL	NULL	NULL	AP291	NULL	Achat perf 291	840.70	0.00	1	0	0	0	NULL	0	0	NULL	581	NULL	NULL	NULL
60	293	293	401001	0	A Divers	2018-05-01 00:00:00	NULL	NULL	NULL	AP293	NULL	Achat perf 293	0.00	914.96	1	0	0	0	NULL	0	0	NULL	586	NULL	NULL	NULL
60	293	293	613113	0	Charge perf 613113	2018-05-01 00:00:00	NULL	NULL	NULL	AP293	NULL	Achat perf 293	914.96	0.00	1	0	0	0	NULL	0	0	NULL	585	NULL	NULL	NULL
60	294	294	401001	0	A Divers	2018-06-08 00:00:00	NULL	NULL	NULL	AP294	NULL	Achat perf 294	0.00	951.09	1	0	0	0	NULL	0	0	NULL	588	NULL	NULL	NULL
60	294	294	613114	0	Charge perf 613114	2018-06-08 00:00:00	NULL	NULL	NULL	AP294	NULL	Achat perf 294	951.09	0.00	1	0	0	0	NULL	0	0	NULL	587	NULL	NULL	NULL
60	296	296	401001	0	A Divers	2018-02-22 00:00:00	NULL	NULL	NULL	AP296	NULL	Achat perf 296	0.00	35.35	1	0	0	0	NULL	0	0	NULL	592	NULL	NULL	NULL
60	296	296	613116	0	Charge perf 613116	2018-02-22 00:00:00	NULL	NULL	NULL	AP296	NULL	Achat perf 296	35.35	0.00	1	0	0	0	NULL	0	0	NULL	591	NULL	NULL	NULL
60	297	297	401001	0	A Divers	2018-03-01 00:00:00	NULL	NULL	NULL	AP297	NULL	Achat perf 297	0.00	72.48	1	0	0	0	NULL	0	0	NULL	594	NULL	NULL	NULL
60	297	297	613117	0	Charge perf 613117	2018-03-01 00:00:00	NULL	NULL	NULL	AP297	NULL	Achat perf 297	72.48	0.00	1	0	0	0	NULL	0	0	NULL	593	NULL	NULL	NULL
60	299	299	401001	0	A Divers	2018-05-15 00:00:00	NULL	NULL	NULL	AP299	NULL	Achat perf 299	0.00	146.74	1	0	0	0	NULL	0	0	NULL	598	NULL	NULL	NULL
60	299	299	613119	0	Charge perf 613119	2018-05-15 00:00:00	NULL	NULL	NULL	AP299	NULL	Achat perf 299	146.74	0.00	1	0	0	0	NULL	0	0	NULL	597	NULL	NULL	NULL
60	3	3	401001	0	A Divers	2018-03-15 00:00:00	NULL	NULL	NULL	AP3	NULL	Achat perf 3	0.00	84.26	1	0	0	0	NULL	0	0	NULL	6	NULL	NULL	NULL
60	3	3	601003	0	Charge perf 601003	2018-03-15 00:00:00	NULL	NULL	NULL	AP3	NULL	Achat perf 3	84.26	0.00	1	0	0	0	NULL	0	0	NULL	5	NULL	NULL	NULL
60	30	30	401001	0	A Divers	2018-06-08 00:00:00	NULL	NULL	NULL	AP30	NULL	Achat perf 30	0.00	93.77	1	0	0	0	NULL	0	0	NULL	60	NULL	NULL	NULL
60	30	30	606110	0	Charge perf 606110	2018-06-08 00:00:00	NULL	NULL	NULL	AP30	NULL	Achat perf 30	93.77	0.00	1	0	0	0	NULL	0	0	NULL	59	NULL	NULL	NULL
60	300	300	401001	0	A Divers	2018-06-22 00:00:00	NULL	NULL	NULL	AP300	NULL	Achat perf 300	0.00	183.87	1	0	0	0	NULL	0	0	NULL	600	NULL	NULL	NULL
60	300	300	613120	0	Charge perf 613120	2018-06-22 00:00:00	NULL	NULL	NULL	AP300	NULL	Achat perf 300	183.87	0.00	1	0	0	0	NULL	0	0	NULL	599	NULL	NULL	NULL
60	302	302	401001	0	A Divers	2018-02-08 00:00:00	NULL	NULL	NULL	AP302	NULL	Achat perf 302	0.00	257.13	1	0	0	0	NULL	0	0	NULL	604	NULL	NULL	NULL
60	302	302	601002	0	Charge perf 601002	2018-02-08 00:00:00	NULL	NULL	NULL	AP302	NULL	Achat perf 302	257.13	0.00	1	0	0	0	NULL	0	0	NULL	603	NULL	NULL	NULL
60	303	303	401001	0	A Divers	2018-03-15 00:00:00	NULL	NULL	NULL	AP303	NULL	Achat perf 303	0.00	294.26	1	0	0	0	NULL	0	0	NULL	606	NULL	NULL	NULL
60	303	303	601003	0	Charge perf 601003	2018-03-15 00:00:00	NULL	NULL	NULL	AP303	NULL	Achat perf 303	294.26	0.00	1	0	0	0	NULL	0	0	NULL	605	NULL	NULL	NULL
60	305	305	401001	0	A Divers	2018-05-01 00:00:00	NULL	NULL	NULL	AP305	NULL	Achat perf 305	0.00	368.52	1	0	0	0	NULL	0	0	NULL	610	NULL	NULL	NULL
60	305	305	601005	0	Charge perf 601005	2018-05-01 00:00:00	NULL	NULL	NULL	AP305	NULL	Achat perf 305	368.52	0.00	1	0	0	0	NULL	0	0	NULL	609	NULL	NULL	NULL
60	306	306	401001	0	A Divers	2018-06-08 00:00:00	NULL	NULL	NULL	AP306	NULL	Achat perf 306	0.00	405.65	1	0	0	0	NULL	0	0	NULL	612	NULL	NULL	NULL
60	306	306	601006	0	Charge perf 601006	2018-06-08 00:00:00	NULL	NULL	NULL	AP306	NULL	Achat perf 306	405.65	0.00	1	0	0	0	NULL	0	0	NULL	611	NULL	NULL	NULL
60	308	308	401001	0	A Divers	2018-02-22 00:00:00	NULL	NULL	NULL	AP308	NULL	Achat perf 308	0.00	479.91	1	0	0	0	NULL	0	0	NULL	616	NULL	NULL	NULL
60	308	308	601008	0	Charge perf 601008	2018-02-22 00:00:00	NULL	NULL	NULL	AP308	NULL	Achat perf 308	479.91	0.00	1	0	0	0	NULL	0	0	NULL	615	NULL	NULL	NULL
60	309	309	401001	0	A Divers	2018-03-01 00:00:00	NULL	NULL	NULL	AP309	NULL	Achat perf 309	0.00	516.04	1	0	0	0	NULL	0	0	NULL	618	NULL	NULL	NULL
60	309	309	601009	0	Charge perf 601009	2018-03-01 00:00:00	NULL	NULL	NULL	AP309	NULL	Achat perf 309	516.04	0.00	1	0	0	0	NULL	0	0	NULL	617	NULL	NULL	NULL
60	311	311	401001	0	A Divers	2018-05-15 00:00:00	NULL	NULL	NULL	AP311	NULL	Achat perf 311	0.00	590.30	1	0	0	0	NULL	0	0	NULL	622	NULL	NULL	NULL
60	311	311	601011	0	Charge perf 601011	2018-05-15 00:00:00	NULL	NULL	NULL	AP311	NULL	Achat perf 311	590.30	0.00	1	0	0	0	NULL	0	0	NULL	621	NULL	NULL	NULL
60	312	312	401001	0	A Divers	2018-06-22 00:00:00	NULL	NULL	NULL	AP312	NULL	Achat perf 312	0.00	627.43	1	0	0	0	NULL	0	0	NULL	624	NULL	NULL	NULL
60	312	312	601012	0	Charge perf 601012	2018-06-22 00:00:00	NULL	NULL	NULL	AP312	NULL	Achat perf 312	627.43	0.00	1	0	0	0	NULL	0	0	NULL	623	NULL	NULL	NULL
60	314	314	401001	0	A Divers	2018-02-08 00:00:00	NULL	NULL	NULL	AP314	NULL	Achat perf 314	0.00	701.69	1	0	0	0	NULL	0	0	NULL	628	NULL	NULL	NULL
60	314	314	601014	0	Charge perf 601014	2018-02-08 00:00:00	NULL	NULL	NULL	AP314	NULL	Achat perf 314	701.69	0.00	1	0	0	0	NULL	0	0	NULL	627	NULL	NULL	NULL
60	315	315	401001	0	A Divers	2018-03-15 00:00:00	NULL	NULL	NULL	AP315	NULL	Achat perf 315	0.00	738.82	1	0	0	0	NULL	0	0	NULL	630	NULL	NULL	NULL
60	315	315	601015	0	Charge perf 601015	2018-03-15 00:00:00	NULL	NULL	NULL	AP315	NULL	Achat perf 315	738.82	0.00	1	0	0	0	NULL	0	0	NULL	629	NULL	NULL	NULL
60	317	317	401001	0	A Divers	2018-05-01 00:00:00	NULL	NULL	NULL	AP317	NULL	Achat perf 317	0.00	812.08	1	0	0	0	NULL	0	0	NULL	634	NULL	NULL	NULL
60	317	317	601017	0	Charge perf 601017	2018-05-01 00:00:00	NULL	NULL	NULL	AP317	NULL	Achat perf 317	812.08	0.00	1	0	0	0	NULL	0	0	NULL	633	NULL	NULL	NULL
60	318	318	401001	0	A Divers	2018-06-08 00:00:00	NULL	NULL	NULL	AP318	NULL	Achat perf 318	0.00	849.21	1	0	0	0	NULL	0	0	NULL	636	NULL	NULL	NULL
60	318	318	601018	0	Charge perf 601018	2018-06-08 00:00:00	NULL	NULL	NULL	AP318	NULL	Achat perf 318	849.21	0.00	1	0	0	0	NULL	0	0	NULL	635	NULL	NULL	NULL
60	32	32	401001	0	A Divers	2018-02-22 00:00:00	NULL	NULL	NULL	AP32	NULL	Achat perf 32	0.00	167.03	1	0	0	0	NULL	0	0	NULL	64	NULL	NULL	NULL
60	32	32	606112	0	Charge perf 606112	2018-02-22 00:00:00	NULL	NULL	NULL	AP32	NULL	Achat perf 32	167.03	0.00	1	0	0	0	NULL	0	0	NULL	63	NULL	NULL	NULL
60	320	320	401001	0	A Divers	2018-02-22 00:00:00	NULL	NULL	NULL	AP320	NULL	Achat perf 320	0.00	923.47	1	0	0	0	NULL	0	0	NULL	640	NULL	NULL	NULL
60	320	320	601020	0	Charge perf 601020	2018-02-22 00:00:00	NULL	NULL	NULL	AP320	NULL	Achat perf 320	923.47	0.00	1	0	0	0	NULL	0	0	NULL	639	NULL	NULL	NULL
60	321	321	401001	0	A Divers	2018-03-01 00:00:00	NULL	NULL	NULL	AP321	NULL	Achat perf 321	0.00	960.60	1	0	0	0	NULL	0	0	NULL	642	NULL	NULL	NULL
60	321	321	606101	0	Charge perf 606101	2018-03-01 00:00:00	NULL	NULL	NULL	AP321	NULL	Achat perf 321	960.60	0.00	1	0	0	0	NULL	0	0	NULL	641	NULL	NULL	NULL
60	323	323	401001	0	A Divers	2018-05-15 00:00:00	NULL	NULL	NULL	AP323	NULL	Achat perf 323	0.00	44.86	1	0	0	0	NULL	0	0	NULL	646	NULL	NULL	NULL
60	323	323	606103	0	Charge perf 606103	2018-05-15 00:00:00	NULL	NULL	NULL	AP323	NULL	Achat perf 323	44.86	0.00	1	0	0	0	NULL	0	0	NULL	645	NULL	NULL	NULL
60	324	324	401001	0	A Divers	2018-06-22 00:00:00	NULL	NULL	NULL	AP324	NULL	Achat perf 324	0.00	81.99	1	0	0	0	NULL	0	0	NULL	648	NULL	NULL	NULL
60	324	324	606104	0	Charge perf 606104	2018-06-22 00:00:00	NULL	NULL	NULL	AP324	NULL	Achat perf 324	81.99	0.00	1	0	0	0	NULL	0	0	NULL	647	NULL	NULL	NULL
60	326	326	401001	0	A Divers	2018-02-08 00:00:00	NULL	NULL	NULL	AP326	NULL	Achat perf 326	0.00	155.25	1	0	0	0	NULL	0	0	NULL	652	NULL	NULL	NULL
60	326	326	606106	0	Charge perf 606106	2018-02-08 00:00:00	NULL	NULL	NULL	AP326	NULL	Achat perf 326	155.25	0.00	1	0	0	0	NULL	0	0	NULL	651	NULL	NULL	NULL
60	327	327	401001	0	A Divers	2018-03-15 00:00:00	NULL	NULL	NULL	AP327	NULL	Achat perf 327	0.00	192.38	1	0	0	0	NULL	0	0	NULL	654	NULL	NULL	NULL
60	327	327	606107	0	Charge perf 606107	2018-03-15 00:00:00	NULL	NULL	NULL	AP327	NULL	Achat perf 327	192.38	0.00	1	0	0	0	NULL	0	0	NULL	653	NULL	NULL	NULL
60	329	329	401001	0	A Divers	2018-05-01 00:00:00	NULL	NULL	NULL	AP329	NULL	Achat perf 329	0.00	266.64	1	0	0	0	NULL	0	0	NULL	658	NULL	NULL	NULL
60	329	329	606109	0	Charge perf 606109	2018-05-01 00:00:00	NULL	NULL	NULL	AP329	NULL	Achat perf 329	266.64	0.00	1	0	0	0	NULL	0	0	NULL	657	NULL	NULL	NULL
60	33	33	401001	0	A Divers	2018-03-01 00:00:00	NULL	NULL	NULL	AP33	NULL	Achat perf 33	0.00	204.16	1	0	0	0	NULL	0	0	NULL	66	NULL	NULL	NULL
60	33	33	606113	0	Charge perf 606113	2018-03-01 00:00:00	NULL	NULL	NULL	AP33	NULL	Achat perf 33	204.16	0.00	1	0	0	0	NULL	0	0	NULL	65	NULL	NULL	NULL
60	330	330	401001	0	A Divers	2018-06-08 00:00:00	NULL	NULL	NULL	AP330	NULL	Achat perf 330	0.00	303.77	1	0	0	0	NULL	0	0	NULL	660	NULL	NULL	NULL
60	330	330	606110	0	Charge perf 606110	2018-06-08 00:00:00	NULL	NULL	NULL	AP330	NULL	Achat perf 330	303.77	0.00	1	0	0	0	NULL	0	0	NULL	659	NULL	NULL	NULL
60	332	332	401001	0	A Divers	2018-02-22 00:00:00	NULL	NULL	NULL	AP332	NULL	Achat perf 332	0.00	377.03	1	0	0	0	NULL	0	0	NULL	664	NULL	NULL	NULL
60	332	332	606112	0	Charge perf 606112	2018-02-22 00:00:00	NULL	NULL	NULL	AP332	NULL	Achat perf 332	377.03	0.00	1	0	0	0	NULL	0	0	NULL	663	NULL	NULL	NULL
60	333	333	401001	0	A Divers	2018-03-01 00:00:00	NULL	NULL	NULL	AP333	NULL	Achat perf 333	0.00	414.16	1	0	0	0	NULL	0	0	NULL	666	NULL	NULL	NULL
60	333	333	606113	0	Charge perf 606113	2018-03-01 00:00:00	NULL	NULL	NULL	AP333	NULL	Achat perf 333	414.16	0.00	1	0	0	0	NULL	0	0	NULL	665	NULL	NULL	NULL
60	335	335	401001	0	A Divers	2018-05-15 00:00:00	NULL	NULL	NULL	AP335	NULL	Achat perf 335	0.00	488.42	1	0	0	0	NULL	0	0	NULL	670	NULL	NULL	NULL
60	335	335	606115	0	Charge perf 606115	2018-05-15 00:00:00	NULL	NULL	NULL	AP335	NULL	Achat perf 335	488.42	0.00	1	0	0	0	NULL	0	0	NULL	669	NULL	NULL	NULL
60	336	336	401001	0	A Divers	2018-06-22 00:00:00	NULL	NULL	NULL	AP336	NULL	Achat perf 336	0.00	525.55	1	0	0	0	NULL	0	0	NULL	672	NULL	NULL	NULL
60	336	336	606116	0	Charge perf 606116	2018-06-22 00:00:00	NULL	NULL	NULL	AP336	NULL	Achat perf 336	525.55	0.00	1	0	0	0	NULL	0	0	NULL	671	NULL	NULL	NULL
60	338	338	401001	0	A Divers	2018-02-08 00:00:00	NULL	NULL	NULL	AP338	NULL	Achat perf 338	0.00	599.81	1	0	0	0	NULL	0	0	NULL	676	NULL	NULL	NULL
60	338	338	606118	0	Charge perf 606118	2018-02-08 00:00:00	NULL	NULL	NULL	AP338	NULL	Achat perf 338	599.81	0.00	1	0	0	0	NULL	0	0	NULL	675	NULL	NULL	NULL
60	339	339	401001	0	A Divers	2018-03-15 00:00:00	NULL	NULL	NULL	AP339	NULL	Achat perf 339	0.00	636.94	1	0	0	0	NULL	0	0	NULL	678	NULL	NULL	NULL
60	339	339	606119	0	Charge perf 606119	2018-03-15 00:00:00	NULL	NULL	NULL	AP339	NULL	Achat perf 339	636.94	0.00	1	0	0	0	NULL	0	0	NULL	677	NULL	NULL	NULL
60	341	341	401001	0	A Divers	2018-05-01 00:00:00	NULL	NULL	NULL	AP341	NULL	Achat perf 341	0.00	710.20	1	0	0	0	NULL	0	0	NULL	682	NULL	NULL	NULL
60	341	341	613101	0	Charge perf 613101	2018-05-01 00:00:00	NULL	NULL	NULL	AP341	NULL	Achat perf 341	710.20	0.00	1	0	0	0	NULL	0	0	NULL	681	NULL	NULL	NULL
60	342	342	401001	0	A Divers	2018-06-08 00:00:00	NULL	NULL	NULL	AP342	NULL	Achat perf 342	0.00	747.33	1	0	0	0	NULL	0	0	NULL	684	NULL	NULL	NULL
60	342	342	613102	0	Charge perf 613102	2018-06-08 00:00:00	NULL	NULL	NULL	AP342	NULL	Achat perf 342	747.33	0.00	1	0	0	0	NULL	0	0	NULL	683	NULL	NULL	NULL
60	344	344	401001	0	A Divers	2018-02-22 00:00:00	NULL	NULL	NULL	AP344	NULL	Achat perf 344	0.00	821.59	1	0	0	0	NULL	0	0	NULL	688	NULL	NULL	NULL
60	344	344	613104	0	Charge perf 613104	2018-02-22 00:00:00	NULL	NULL	NULL	AP344	NULL	Achat perf 344	821.59	0.00	1	0	0	0	NULL	0	0	NULL	687	NULL	NULL	NULL
60	345	345	401001	0	A Divers	2018-03-01 00:00:00	NULL	NULL	NULL	AP345	NULL	Achat perf 345	0.00	858.72	1	0	0	0	NULL	0	0	NULL	690	NULL	NULL	NULL
60	345	345	613105	0	Charge perf 613105	2018-03-01 00:00:00	NULL	NULL	NULL	AP345	NULL	Achat perf 345	858.72	0.00	1	0	0	0	NULL	0	0	NULL	689	NULL	NULL	NULL
60	347	347	401001	0	A Divers	2018-05-15 00:00:00	NULL	NULL	NULL	AP347	NULL	Achat perf 347	0.00	932.98	1	0	0	0	NULL	0	0	NULL	694	NULL	NULL	NULL
60	347	347	613107	0	Charge perf 613107	2018-05-15 00:00:00	NULL	NULL	NULL	AP347	NULL	Achat perf 347	932.98	0.00	1	0	0	0	NULL	0	0	NULL	693	NULL	NULL	NULL
60	348	348	401001	0	A Divers	2018-06-22 00:00:00	NULL	NULL	NULL	AP348	NULL	Achat perf 348	0.00	969.11	1	0	0	0	NULL	0	0	NULL	696	NULL	NULL	NULL
60	348	348	613108	0	Charge perf 613108	2018-06-22 00:00:00	NULL	NULL	NULL	AP348	NULL	Achat perf 348	969.11	0.00	1	0	0	0	NULL	0	0	NULL	695	NULL	NULL	NULL
60	35	35	401001	0	A Divers	2018-05-15 00:00:00	NULL	NULL	NULL	AP35	NULL	Achat perf 35	0.00	278.42	1	0	0	0	NULL	0	0	NULL	70	NULL	NULL	NULL
60	35	35	606115	0	Charge perf 606115	2018-05-15 00:00:00	NULL	NULL	NULL	AP35	NULL	Achat perf 35	278.42	0.00	1	0	0	0	NULL	0	0	NULL	69	NULL	NULL	NULL
60	350	350	401001	0	A Divers	2018-02-08 00:00:00	NULL	NULL	NULL	AP350	NULL	Achat perf 350	0.00	53.37	1	0	0	0	NULL	0	0	NULL	700	NULL	NULL	NULL
60	350	350	613110	0	Charge perf 613110	2018-02-08 00:00:00	NULL	NULL	NULL	AP350	NULL	Achat perf 350	53.37	0.00	1	0	0	0	NULL	0	0	NULL	699	NULL	NULL	NULL
60	351	351	401001	0	A Divers	2018-03-15 00:00:00	NULL	NULL	NULL	AP351	NULL	Achat perf 351	0.00	90.50	1	0	0	0	NULL	0	0	NULL	702	NULL	NULL	NULL
60	351	351	613111	0	Charge perf 613111	2018-03-15 00:00:00	NULL	NULL	NULL	AP351	NULL	Achat perf 351	90.50	0.00	1	0	0	0	NULL	0	0	NULL	701	NULL	NULL	NULL
60	353	353	401001	0	A Divers	2018-05-01 00:00:00	NULL	NULL	NULL	AP353	NULL	Achat perf 353	0.00	164.76	1	0	0	0	NULL	0	0	NULL	706	NULL	NULL	NULL
60	353	353	613113	0	Charge perf 613113	2018-05-01 00:00:00	NULL	NULL	NULL	AP353	NULL	Achat perf 353	164.76	0.00	1	0	0	0	NULL	0	0	NULL	705	NULL	NULL	NULL
60	354	354	401001	0	A Divers	2018-06-08 00:00:00	NULL	NULL	NULL	AP354	NULL	Achat perf 354	0.00	201.89	1	0	0	0	NULL	0	0	NULL	708	NULL	NULL	NULL
60	354	354	613114	0	Charge perf 613114	2018-06-08 00:00:00	NULL	NULL	NULL	AP354	NULL	Achat perf 354	201.89	0.00	1	0	0	0	NULL	0	0	NULL	707	NULL	NULL	NULL
60	356	356	401001	0	A Divers	2018-02-22 00:00:00	NULL	NULL	NULL	AP356	NULL	Achat perf 356	0.00	275.15	1	0	0	0	NULL	0	0	NULL	712	NULL	NULL	NULL
60	356	356	613116	0	Charge perf 613116	2018-02-22 00:00:00	NULL	NULL	NULL	AP356	NULL	Achat perf 356	275.15	0.00	1	0	0	0	NULL	0	0	NULL	711	NULL	NULL	NULL
60	357	357	401001	0	A Divers	2018-03-01 00:00:00	NULL	NULL	NULL	AP357	NULL	Achat perf 357	0.00	312.28	1	0	0	0	NULL	0	0	NULL	714	NULL	NULL	NULL
60	357	357	613117	0	Charge perf 613117	2018-03-01 00:00:00	NULL	NULL	NULL	AP357	NULL	Achat perf 357	312.28	0.00	1	0	0	0	NULL	0	0	NULL	713	NULL	NULL	NULL
60	359	359	401001	0	A Divers	2018-05-15 00:00:00	NULL	NULL	NULL	AP359	NULL	Achat perf 359	0.00	386.54	1	0	0	0	NULL	0	0	NULL	718	NULL	NULL	NULL
60	359	359	613119	0	Charge perf 613119	2018-05-15 00:00:00	NULL	NULL	NULL	AP359	NULL	Achat perf 359	386.54	0.00	1	0	0	0	NULL	0	0	NULL	717	NULL	NULL	NULL
60	36	36	401001	0	A Divers	2018-06-22 00:00:00	NULL	NULL	NULL	AP36	NULL	Achat perf 36	0.00	315.55	1	0	0	0	NULL	0	0	NULL	72	NULL	NULL	NULL
60	36	36	606116	0	Charge perf 606116	2018-06-22 00:00:00	NULL	NULL	NULL	AP36	NULL	Achat perf 36	315.55	0.00	1	0	0	0	NULL	0	0	NULL	71	NULL	NULL	NULL
60	360	360	401001	0	A Divers	2018-06-22 00:00:00	NULL	NULL	NULL	AP360	NULL	Achat perf 360	0.00	423.67	1	0	0	0	NULL	0	0	NULL	720	NULL	NULL	NULL
60	360	360	613120	0	Charge perf 613120	2018-06-22 00:00:00	NULL	NULL	NULL	AP360	NULL	Achat perf 360	423.67	0.00	1	0	0	0	NULL	0	0	NULL	719	NULL	NULL	NULL
60	362	362	401001	0	A Divers	2018-02-08 00:00:00	NULL	NULL	NULL	AP362	NULL	Achat perf 362	0.00	497.93	1	0	0	0	NULL	0	0	NULL	724	NULL	NULL	NULL
60	362	362	601002	0	Charge perf 601002	2018-02-08 00:00:00	NULL	NULL	NULL	AP362	NULL	Achat perf 362	497.93	0.00	1	0	0	0	NULL	0	0	NULL	723	NULL	NULL	NULL
60	363	363	401001	0	A Divers	2018-03-15 00:00:00	NULL	NULL	NULL	AP363	NULL	Achat perf 363	0.00	534.06	1	0	0	0	NULL	0	0	NULL	726	NULL	NULL	NULL
60	363	363	601003	0	Charge perf 601003	2018-03-15 00:00:00	NULL	NULL	NULL	AP363	NULL	Achat perf 363	534.06	0.00	1	0	0	0	NULL	0	0	NULL	725	NULL	NULL	NULL
60	365	365	401001	0	A Divers	2018-05-01 00:00:00	NULL	NULL	NULL	AP365	NULL	Achat perf 365	0.00	608.32	1	0	0	0	NULL	0	0	NULL	730	NULL	NULL	NULL
60	365	365	601005	0	Charge perf 601005	2018-05-01 00:00:00	NULL	NULL	NULL	AP365	NULL	Achat perf 365	608.32	0.00	1	0	0	0	NULL	0	0	NULL	729	NULL	NULL	NULL
60	366	366	401001	0	A Divers	2018-06-08 00:00:00	NULL	NULL	NULL	AP366	NULL	Achat perf 366	0.00	645.45	1	0	0	0	NULL	0	0	NULL	732	NULL	NULL	NULL
60	366	366	601006	0	Charge perf 601006	2018-06-08 00:00:00	NULL	NULL	NULL	AP366	NULL	Achat perf 366	645.45	0.00	1	0	0	0	NULL	0	0	NULL	731	NULL	NULL	NULL
60	368	368	401001	0	A Divers	2018-02-22 00:00:00	NULL	NULL	NULL	AP368	NULL	Achat perf 368	0.00	719.71	1	0	0	0	NULL	0	0	NULL	736	NULL	NULL	NULL
60	368	368	601008	0	Charge perf 601008	2018-02-22 00:00:00	NULL	NULL	NULL	AP368	NULL	Achat perf 368	719.71	0.00	1	0	0	0	NULL	0	0	NULL	735	NULL	NULL	NULL
60	369	369	401001	0	A Divers	2018-03-01 00:00:00	NULL	NULL	NULL	AP369	NULL	Achat perf 369	0.00	756.84	1	0	0	0	NULL	0	0	NULL	738	NULL	NULL	NULL
60	369	369	601009	0	Charge perf 601009	2018-03-01 00:00:00	NULL	NULL	NULL	AP369	NULL	Achat perf 369	756.84	0.00	1	0	0	0	NULL	0	0	NULL	737	NULL	NULL	NULL
60	371	371	401001	0	A Divers	2018-05-15 00:00:00	NULL	NULL	NULL	AP371	NULL	Achat perf 371	0.00	830.10	1	0	0	0	NULL	0	0	NULL	742	NULL	NULL	NULL
60	371	371	601011	0	Charge perf 601011	2018-05-15 00:00:00	NULL	NULL	NULL	AP371	NULL	Achat perf 371	830.10	0.00	1	0	0	0	NULL	0	0	NULL	741	NULL	NULL	NULL
60	372	372	401001	0	A Divers	2018-06-22 00:00:00	NULL	NULL	NULL	AP372	NULL	Achat perf 372	0.00	867.23	1	0	0	0	NULL	0	0	NULL	744	NULL	NULL	NULL
60	372	372	601012	0	Charge perf 601012	2018-06-22 00:00:00	NULL	NULL	NULL	AP372	NULL	Achat perf 372	867.23	0.00	1	0	0	0	NULL	0	0	NULL	743	NULL	NULL	NULL
60	374	374	401001	0	A Divers	2018-02-08 00:00:00	NULL	NULL	NULL	AP374	NULL	Achat perf 374	0.00	941.49	1	0	0	0	NULL	0	0	NULL	748	NULL	NULL	NULL
60	374	374	601014	0	Charge perf 601014	2018-02-08 00:00:00	NULL	NULL	NULL	AP374	NULL	Achat perf 374	941.49	0.00	1	0	0	0	NULL	0	0	NULL	747	NULL	NULL	NULL
60	375	375	401001	0	A Divers	2018-03-15 00:00:00	NULL	NULL	NULL	AP375	NULL	Achat perf 375	0.00	978.62	1	0	0	0	NULL	0	0	NULL	750	NULL	NULL	NULL
60	375	375	601015	0	Charge perf 601015	2018-03-15 00:00:00	NULL	NULL	NULL	AP375	NULL	Achat perf 375	978.62	0.00	1	0	0	0	NULL	0	0	NULL	749	NULL	NULL	NULL
60	377	377	401001	0	A Divers	2018-05-01 00:00:00	NULL	NULL	NULL	AP377	NULL	Achat perf 377	0.00	62.88	1	0	0	0	NULL	0	0	NULL	754	NULL	NULL	NULL
60	377	377	601017	0	Charge perf 601017	2018-05-01 00:00:00	NULL	NULL	NULL	AP377	NULL	Achat perf 377	62.88	0.00	1	0	0	0	NULL	0	0	NULL	753	NULL	NULL	NULL
60	378	378	401001	0	A Divers	2018-06-08 00:00:00	NULL	NULL	NULL	AP378	NULL	Achat perf 378	0.00	99.01	1	0	0	0	NULL	0	0	NULL	756	NULL	NULL	NULL
60	378	378	601018	0	Charge perf 601018	2018-06-08 00:00:00	NULL	NULL	NULL	AP378	NULL	Achat perf 378	99.01	0.00	1	0	0	0	NULL	0	0	NULL	755	NULL	NULL	NULL
60	38	38	401001	0	A Divers	2018-02-08 00:00:00	NULL	NULL	NULL	AP38	NULL	Achat perf 38	0.00	389.81	1	0	0	0	NULL	0	0	NULL	76	NULL	NULL	NULL
60	38	38	606118	0	Charge perf 606118	2018-02-08 00:00:00	NULL	NULL	NULL	AP38	NULL	Achat perf 38	389.81	0.00	1	0	0	0	NULL	0	0	NULL	75	NULL	NULL	NULL
60	380	380	401001	0	A Divers	2018-02-22 00:00:00	NULL	NULL	NULL	AP380	NULL	Achat perf 380	0.00	173.27	1	0	0	0	NULL	0	0	NULL	760	NULL	NULL	NULL
60	380	380	601020	0	Charge perf 601020	2018-02-22 00:00:00	NULL	NULL	NULL	AP380	NULL	Achat perf 380	173.27	0.00	1	0	0	0	NULL	0	0	NULL	759	NULL	NULL	NULL
60	381	381	401001	0	A Divers	2018-03-01 00:00:00	NULL	NULL	NULL	AP381	NULL	Achat perf 381	0.00	210.40	1	0	0	0	NULL	0	0	NULL	762	NULL	NULL	NULL
60	381	381	606101	0	Charge perf 606101	2018-03-01 00:00:00	NULL	NULL	NULL	AP381	NULL	Achat perf 381	210.40	0.00	1	0	0	0	NULL	0	0	NULL	761	NULL	NULL	NULL
60	383	383	401001	0	A Divers	2018-05-15 00:00:00	NULL	NULL	NULL	AP383	NULL	Achat perf 383	0.00	284.66	1	0	0	0	NULL	0	0	NULL	766	NULL	NULL	NULL
60	383	383	606103	0	Charge perf 606103	2018-05-15 00:00:00	NULL	NULL	NULL	AP383	NULL	Achat perf 383	284.66	0.00	1	0	0	0	NULL	0	0	NULL	765	NULL	NULL	NULL
60	384	384	401001	0	A Divers	2018-06-22 00:00:00	NULL	NULL	NULL	AP384	NULL	Achat perf 384	0.00	321.79	1	0	0	0	NULL	0	0	NULL	768	NULL	NULL	NULL
60	384	384	606104	0	Charge perf 606104	2018-06-22 00:00:00	NULL	NULL	NULL	AP384	NULL	Achat perf 384	321.79	0.00	1	0	0	0	NULL	0	0	NULL	767	NULL	NULL	NULL
60	386	386	401001	0	A Divers	2018-02-08 00:00:00	NULL	NULL	NULL	AP386	NULL	Achat perf 386	0.00	395.05	1	0	0	0	NULL	0	0	NULL	772	NULL	NULL	NULL
60	386	386	606106	0	Charge perf 606106	2018-02-08 00:00:00	NULL	NULL	NULL	AP386	NULL	Achat perf 386	395.05	0.00	1	0	0	0	NULL	0	0	NULL	771	NULL	NULL	NULL
60	387	387	401001	0	A Divers	2018-03-15 00:00:00	NULL	NULL	NULL	AP387	NULL	Achat perf 387	0.00	432.18	1	0	0	0	NULL	0	0	NULL	774	NULL	NULL	NULL
60	387	387	606107	0	Charge perf 606107	2018-03-15 00:00:00	NULL	NULL	NULL	AP387	NULL	Achat perf 387	432.18	0.00	1	0	0	0	NULL	0	0	NULL	773	NULL	NULL	NULL
60	389	389	401001	0	A Divers	2018-05-01 00:00:00	NULL	NULL	NULL	AP389	NULL	Achat perf 389	0.00	506.44	1	0	0	0	NULL	0	0	NULL	778	NULL	NULL	NULL
60	389	389	606109	0	Charge perf 606109	2018-05-01 00:00:00	NULL	NULL	NULL	AP389	NULL	Achat perf 389	506.44	0.00	1	0	0	0	NULL	0	0	NULL	777	NULL	NULL	NULL
60	39	39	401001	0	A Divers	2018-03-15 00:00:00	NULL	NULL	NULL	AP39	NULL	Achat perf 39	0.00	426.94	1	0	0	0	NULL	0	0	NULL	78	NULL	NULL	NULL
60	39	39	606119	0	Charge perf 606119	2018-03-15 00:00:00	NULL	NULL	NULL	AP39	NULL	Achat perf 39	426.94	0.00	1	0	0	0	NULL	0	0	NULL	77	NULL	NULL	NULL
60	390	390	401001	0	A Divers	2018-06-08 00:00:00	NULL	NULL	NULL	AP390	NULL	Achat perf 390	0.00	543.57	1	0	0	0	NULL	0	0	NULL	780	NULL	NULL	NULL
60	390	390	606110	0	Charge perf 606110	2018-06-08 00:00:00	NULL	NULL	NULL	AP390	NULL	Achat perf 390	543.57	0.00	1	0	0	0	NULL	0	0	NULL	779	NULL	NULL	NULL
60	392	392	401001	0	A Divers	2018-02-22 00:00:00	NULL	NULL	NULL	AP392	NULL	Achat perf 392	0.00	617.83	1	0	0	0	NULL	0	0	NULL	784	NULL	NULL	NULL
60	392	392	606112	0	Charge perf 606112	2018-02-22 00:00:00	NULL	NULL	NULL	AP392	NULL	Achat perf 392	617.83	0.00	1	0	0	0	NULL	0	0	NULL	783	NULL	NULL	NULL
60	393	393	401001	0	A Divers	2018-03-01 00:00:00	NULL	NULL	NULL	AP393	NULL	Achat perf 393	0.00	654.96	1	0	0	0	NULL	0	0	NULL	786	NULL	NULL	NULL
60	393	393	606113	0	Charge perf 606113	2018-03-01 00:00:00	NULL	NULL	NULL	AP393	NULL	Achat perf 393	654.96	0.00	1	0	0	0	NULL	0	0	NULL	785	NULL	NULL	NULL
60	395	395	401001	0	A Divers	2018-05-15 00:00:00	NULL	NULL	NULL	AP395	NULL	Achat perf 395	0.00	728.22	1	0	0	0	NULL	0	0	NULL	790	NULL	NULL	NULL
60	395	395	606115	0	Charge perf 606115	2018-05-15 00:00:00	NULL	NULL	NULL	AP395	NULL	Achat perf 395	728.22	0.00	1	0	0	0	NULL	0	0	NULL	789	NULL	NULL	NULL
60	396	396	401001	0	A Divers	2018-06-22 00:00:00	NULL	NULL	NULL	AP396	NULL	Achat perf 396	0.00	765.35	1	0	0	0	NULL	0	0	NULL	792	NULL	NULL	NULL
60	396	396	606116	0	Charge perf 606116	2018-06-22 00:00:00	NULL	NULL	NULL	AP396	NULL	Achat perf 396	765.35	0.00	1	0	0	0	NULL	0	0	NULL	791	NULL	NULL	NULL
60	398	398	401001	0	A Divers	2018-02-08 00:00:00	NULL	NULL	NULL	AP398	NULL	Achat perf 398	0.00	839.61	1	0	0	0	NULL	0	0	NULL	796	NULL	NULL	NULL
60	398	398	606118	0	Charge perf 606118	2018-02-08 00:00:00	NULL	NULL	NULL	AP398	NULL	Achat perf 398	839.61	0.00	1	0	0	0	NULL	0	0	NULL	795	NULL	NULL	NULL
60	399	399	401001	0	A Divers	2018-03-15 00:00:00	NULL	NULL	NULL	AP399	NULL	Achat perf 399	0.00	876.74	1	0	0	0	NULL	0	0	NULL	798	NULL	NULL	NULL
60	399	399	606119	0	Charge perf 606119	2018-03-15 00:00:00	NULL	NULL	NULL	AP399	NULL	Achat perf 399	876.74	0.00	1	0	0	0	NULL	0	0	NULL	797	NULL	NULL	NULL
60	401	401	401001	0	A Divers	2018-05-01 00:00:00	NULL	NULL	NULL	AP401	NULL	Achat perf 401	0.00	950.00	1	0	0	0	NULL	0	0	NULL	802	NULL	NULL	NULL
60	401	401	613101	0	Charge perf 613101	2018-05-01 00:00:00	NULL	NULL	NULL	AP401	NULL	Achat perf 401	950.00	0.00	1	0	0	0	NULL	0	0	NULL	801	NULL	NULL	NULL
60	402	402	401001	0	A Divers	2018-06-08 00:00:00	NULL	NULL	NULL	AP402	NULL	Achat perf 402	0.00	987.13	1	0	0	0	NULL	0	0	NULL	804	NULL	NULL	NULL
60	402	402	613102	0	Charge perf 613102	2018-06-08 00:00:00	NULL	NULL	NULL	AP402	NULL	Achat perf 402	987.13	0.00	1	0	0	0	NULL	0	0	NULL	803	NULL	NULL	NULL
60	404	404	401001	0	A Divers	2018-02-22 00:00:00	NULL	NULL	NULL	AP404	NULL	Achat perf 404	0.00	71.39	1	0	0	0	NULL	0	0	NULL	808	NULL	NULL	NULL
60	404	404	613104	0	Charge perf 613104	2018-02-22 00:00:00	NULL	NULL	NULL	AP404	NULL	Achat perf 404	71.39	0.00	1	0	0	0	NULL	0	0	NULL	807	NULL	NULL	NULL
60	405	405	401001	0	A Divers	2018-03-01 00:00:00	NULL	NULL	NULL	AP405	NULL	Achat perf 405	0.00	108.52	1	0	0	0	NULL	0	0	NULL	810	NULL	NULL	NULL
60	405	405	613105	0	Charge perf 613105	2018-03-01 00:00:00	NULL	NULL	NULL	AP405	NULL	Achat perf 405	108.52	0.00	1	0	0	0	NULL	0	0	NULL	809	NULL	NULL	NULL
60	407	407	401001	0	A Divers	2018-05-15 00:00:00	NULL	NULL	NULL	AP407	NULL	Achat perf 407	0.00	182.78	1	0	0	0	NULL	0	0	NULL	814	NULL	NULL	NULL
60	407	407	613107	0	Charge perf 613107	2018-05-15 00:00:00	NULL	NULL	NULL	AP407	NULL	Achat perf 407	182.78	0.00	1	0	0	0	NULL	0	0	NULL	813	NULL	NULL	NULL
60	408	408	401001	0	A Divers	2018-06-22 00:00:00	NULL	NULL	NULL	AP408	NULL	Achat perf 408	0.00	219.91	1	0	0	0	NULL	0	0	NULL	816	NULL	NULL	NULL
60	408	408	613108	0	Charge perf 613108	2018-06-22 00:00:00	NULL	NULL	NULL	AP408	NULL	Achat perf 408	219.91	0.00	1	0	0	0	NULL	0	0	NULL	815	NULL	NULL	NULL
60	41	41	401001	0	A Divers	2018-05-01 00:00:00	NULL	NULL	NULL	AP41	NULL	Achat perf 41	0.00	500.20	1	0	0	0	NULL	0	0	NULL	82	NULL	NULL	NULL
60	41	41	613101	0	Charge perf 613101	2018-05-01 00:00:00	NULL	NULL	NULL	AP41	NULL	Achat perf 41	500.20	0.00	1	0	0	0	NULL	0	0	NULL	81	NULL	NULL	NULL
60	410	410	401001	0	A Divers	2018-02-08 00:00:00	NULL	NULL	NULL	AP410	NULL	Achat perf 410	0.00	293.17	1	0	0	0	NULL	0	0	NULL	820	NULL	NULL	NULL
60	410	410	613110	0	Charge perf 613110	2018-02-08 00:00:00	NULL	NULL	NULL	AP410	NULL	Achat perf 410	293.17	0.00	1	0	0	0	NULL	0	0	NULL	819	NULL	NULL	NULL
60	411	411	401001	0	A Divers	2018-03-15 00:00:00	NULL	NULL	NULL	AP411	NULL	Achat perf 411	0.00	330.30	1	0	0	0	NULL	0	0	NULL	822	NULL	NULL	NULL
60	411	411	613111	0	Charge perf 613111	2018-03-15 00:00:00	NULL	NULL	NULL	AP411	NULL	Achat perf 411	330.30	0.00	1	0	0	0	NULL	0	0	NULL	821	NULL	NULL	NULL
60	413	413	401001	0	A Divers	2018-05-01 00:00:00	NULL	NULL	NULL	AP413	NULL	Achat perf 413	0.00	404.56	1	0	0	0	NULL	0	0	NULL	826	NULL	NULL	NULL
60	413	413	613113	0	Charge perf 613113	2018-05-01 00:00:00	NULL	NULL	NULL	AP413	NULL	Achat perf 413	404.56	0.00	1	0	0	0	NULL	0	0	NULL	825	NULL	NULL	NULL
60	414	414	401001	0	A Divers	2018-06-08 00:00:00	NULL	NULL	NULL	AP414	NULL	Achat perf 414	0.00	441.69	1	0	0	0	NULL	0	0	NULL	828	NULL	NULL	NULL
60	414	414	613114	0	Charge perf 613114	2018-06-08 00:00:00	NULL	NULL	NULL	AP414	NULL	Achat perf 414	441.69	0.00	1	0	0	0	NULL	0	0	NULL	827	NULL	NULL	NULL
60	416	416	401001	0	A Divers	2018-02-22 00:00:00	NULL	NULL	NULL	AP416	NULL	Achat perf 416	0.00	515.95	1	0	0	0	NULL	0	0	NULL	832	NULL	NULL	NULL
60	416	416	613116	0	Charge perf 613116	2018-02-22 00:00:00	NULL	NULL	NULL	AP416	NULL	Achat perf 416	515.95	0.00	1	0	0	0	NULL	0	0	NULL	831	NULL	NULL	NULL
60	417	417	401001	0	A Divers	2018-03-01 00:00:00	NULL	NULL	NULL	AP417	NULL	Achat perf 417	0.00	552.08	1	0	0	0	NULL	0	0	NULL	834	NULL	NULL	NULL
60	417	417	613117	0	Charge perf 613117	2018-03-01 00:00:00	NULL	NULL	NULL	AP417	NULL	Achat perf 417	552.08	0.00	1	0	0	0	NULL	0	0	NULL	833	NULL	NULL	NULL
60	419	419	401001	0	A Divers	2018-05-15 00:00:00	NULL	NULL	NULL	AP419	NULL	Achat perf 419	0.00	626.34	1	0	0	0	NULL	0	0	NULL	838	NULL	NULL	NULL
60	419	419	613119	0	Charge perf 613119	2018-05-15 00:00:00	NULL	NULL	NULL	AP419	NULL	Achat perf 419	626.34	0.00	1	0	0	0	NULL	0	0	NULL	837	NULL	NULL	NULL
60	42	42	401001	0	A Divers	2018-06-08 00:00:00	NULL	NULL	NULL	AP42	NULL	Achat perf 42	0.00	537.33	1	0	0	0	NULL	0	0	NULL	84	NULL	NULL	NULL
60	42	42	613102	0	Charge perf 613102	2018-06-08 00:00:00	NULL	NULL	NULL	AP42	NULL	Achat perf 42	537.33	0.00	1	0	0	0	NULL	0	0	NULL	83	NULL	NULL	NULL
60	420	420	401001	0	A Divers	2018-06-22 00:00:00	NULL	NULL	NULL	AP420	NULL	Achat perf 420	0.00	663.47	1	0	0	0	NULL	0	0	NULL	840	NULL	NULL	NULL
60	420	420	613120	0	Charge perf 613120	2018-06-22 00:00:00	NULL	NULL	NULL	AP420	NULL	Achat perf 420	663.47	0.00	1	0	0	0	NULL	0	0	NULL	839	NULL	NULL	NULL
60	422	422	401001	0	A Divers	2018-02-08 00:00:00	NULL	NULL	NULL	AP422	NULL	Achat perf 422	0.00	737.73	1	0	0	0	NULL	0	0	NULL	844	NULL	NULL	NULL
60	422	422	601002	0	Charge perf 601002	2018-02-08 00:00:00	NULL	NULL	NULL	AP422	NULL	Achat perf 422	737.73	0.00	1	0	0	0	NULL	0	0	NULL	843	NULL	NULL	NULL
60	423	423	401001	0	A Divers	2018-03-15 00:00:00	NULL	NULL	NULL	AP423	NULL	Achat perf 423	0.00	774.86	1	0	0	0	NULL	0	0	NULL	846	NULL	NULL	NULL
60	423	423	601003	0	Charge perf 601003	2018-03-15 00:00:00	NULL	NULL	NULL	AP423	NULL	Achat perf 423	774.86	0.00	1	0	0	0	NULL	0	0	NULL	845	NULL	NULL	NULL
60	425	425	401001	0	A Divers	2018-05-01 00:00:00	NULL	NULL	NULL	AP425	NULL	Achat perf 425	0.00	848.12	1	0	0	0	NULL	0	0	NULL	850	NULL	NULL	NULL
60	425	425	601005	0	Charge perf 601005	2018-05-01 00:00:00	NULL	NULL	NULL	AP425	NULL	Achat perf 425	848.12	0.00	1	0	0	0	NULL	0	0	NULL	849	NULL	NULL	NULL
60	426	426	401001	0	A Divers	2018-06-08 00:00:00	NULL	NULL	NULL	AP426	NULL	Achat perf 426	0.00	885.25	1	0	0	0	NULL	0	0	NULL	852	NULL	NULL	NULL
60	426	426	601006	0	Charge perf 601006	2018-06-08 00:00:00	NULL	NULL	NULL	AP426	NULL	Achat perf 426	885.25	0.00	1	0	0	0	NULL	0	0	NULL	851	NULL	NULL	NULL
60	428	428	401001	0	A Divers	2018-02-22 00:00:00	NULL	NULL	NULL	AP428	NULL	Achat perf 428	0.00	959.51	1	0	0	0	NULL	0	0	NULL	856	NULL	NULL	NULL
60	428	428	601008	0	Charge perf 601008	2018-02-22 00:00:00	NULL	NULL	NULL	AP428	NULL	Achat perf 428	959.51	0.00	1	0	0	0	NULL	0	0	NULL	855	NULL	NULL	NULL
60	429	429	401001	0	A Divers	2018-03-01 00:00:00	NULL	NULL	NULL	AP429	NULL	Achat perf 429	0.00	996.64	1	0	0	0	NULL	0	0	NULL	858	NULL	NULL	NULL
60	429	429	601009	0	Charge perf 601009	2018-03-01 00:00:00	NULL	NULL	NULL	AP429	NULL	Achat perf 429	996.64	0.00	1	0	0	0	NULL	0	0	NULL	857	NULL	NULL	NULL
60	431	431	401001	0	A Divers	2018-05-15 00:00:00	NULL	NULL	NULL	AP431	NULL	Achat perf 431	0.00	80.90	1	0	0	0	NULL	0	0	NULL	862	NULL	NULL	NULL
60	431	431	601011	0	Charge perf 601011	2018-05-15 00:00:00	NULL	NULL	NULL	AP431	NULL	Achat perf 431	80.90	0.00	1	0	0	0	NULL	0	0	NULL	861	NULL	NULL	NULL
60	432	432	401001	0	A Divers	2018-06-22 00:00:00	NULL	NULL	NULL	AP432	NULL	Achat perf 432	0.00	117.03	1	0	0	0	NULL	0	0	NULL	864	NULL	NULL	NULL
60	432	432	601012	0	Charge perf 601012	2018-06-22 00:00:00	NULL	NULL	NULL	AP432	NULL	Achat perf 432	117.03	0.00	1	0	0	0	NULL	0	0	NULL	863	NULL	NULL	NULL
60	434	434	401001	0	A Divers	2018-02-08 00:00:00	NULL	NULL	NULL	AP434	NULL	Achat perf 434	0.00	191.29	1	0	0	0	NULL	0	0	NULL	868	NULL	NULL	NULL
60	434	434	601014	0	Charge perf 601014	2018-02-08 00:00:00	NULL	NULL	NULL	AP434	NULL	Achat perf 434	191.29	0.00	1	0	0	0	NULL	0	0	NULL	867	NULL	NULL	NULL
60	435	435	401001	0	A Divers	2018-03-15 00:00:00	NULL	NULL	NULL	AP435	NULL	Achat perf 435	0.00	228.42	1	0	0	0	NULL	0	0	NULL	870	NULL	NULL	NULL
60	435	435	601015	0	Charge perf 601015	2018-03-15 00:00:00	NULL	NULL	NULL	AP435	NULL	Achat perf 435	228.42	0.00	1	0	0	0	NULL	0	0	NULL	869	NULL	NULL	NULL
60	437	437	401001	0	A Divers	2018-05-01 00:00:00	NULL	NULL	NULL	AP437	NULL	Achat perf 437	0.00	302.68	1	0	0	0	NULL	0	0	NULL	874	NULL	NULL	NULL
60	437	437	601017	0	Charge perf 601017	2018-05-01 00:00:00	NULL	NULL	NULL	AP437	NULL	Achat perf 437	302.68	0.00	1	0	0	0	NULL	0	0	NULL	873	NULL	NULL	NULL
60	438	438	401001	0	A Divers	2018-06-08 00:00:00	NULL	NULL	NULL	AP438	NULL	Achat perf 438	0.00	339.81	1	0	0	0	NULL	0	0	NULL	876	NULL	NULL	NULL
60	438	438	601018	0	Charge perf 601018	2018-06-08 00:00:00	NULL	NULL	NULL	AP438	NULL	Achat perf 438	339.81	0.00	1	0	0	0	NULL	0	0	NULL	875	NULL	NULL	NULL
60	44	44	401001	0	A Divers	2018-02-22 00:00:00	NULL	NULL	NULL	AP44	NULL	Achat perf 44	0.00	611.59	1	0	0	0	NULL	0	0	NULL	88	NULL	NULL	NULL
60	44	44	613104	0	Charge perf 613104	2018-02-22 00:00:00	NULL	NULL	NULL	AP44	NULL	Achat perf 44	611.59	0.00	1	0	0	0	NULL	0	0	NULL	87	NULL	NULL	NULL
60	440	440	401001	0	A Divers	2018-02-22 00:00:00	NULL	NULL	NULL	AP440	NULL	Achat perf 440	0.00	413.07	1	0	0	0	NULL	0	0	NULL	880	NULL	NULL	NULL
60	440	440	601020	0	Charge perf 601020	2018-02-22 00:00:00	NULL	NULL	NULL	AP440	NULL	Achat perf 440	413.07	0.00	1	0	0	0	NULL	0	0	NULL	879	NULL	NULL	NULL
60	441	441	401001	0	A Divers	2018-03-01 00:00:00	NULL	NULL	NULL	AP441	NULL	Achat perf 441	0.00	450.20	1	0	0	0	NULL	0	0	NULL	882	NULL	NULL	NULL
60	441	441	606101	0	Charge perf 606101	2018-03-01 00:00:00	NULL	NULL	NULL	AP441	NULL	Achat perf 441	450.20	0.00	1	0	0	0	NULL	0	0	NULL	881	NULL	NULL	NULL
60	443	443	401001	0	A Divers	2018-05-15 00:00:00	NULL	NULL	NULL	AP443	NULL	Achat perf 443	0.00	524.46	1	0	0	0	NULL	0	0	NULL	886	NULL	NULL	NULL
60	443	443	606103	0	Charge perf 606103	2018-05-15 00:00:00	NULL	NULL	NULL	AP443	NULL	Achat perf 443	524.46	0.00	1	0	0	0	NULL	0	0	NULL	885	NULL	NULL	NULL
60	444	444	401001	0	A Divers	2018-06-22 00:00:00	NULL	NULL	NULL	AP444	NULL	Achat perf 444	0.00	561.59	1	0	0	0	NULL	0	0	NULL	888	NULL	NULL	NULL
60	444	444	606104	0	Charge perf 606104	2018-06-22 00:00:00	NULL	NULL	NULL	AP444	NULL	Achat perf 444	561.59	0.00	1	0	0	0	NULL	0	0	NULL	887	NULL	NULL	NULL
60	446	446	401001	0	A Divers	2018-02-08 00:00:00	NULL	NULL	NULL	AP446	NULL	Achat perf 446	0.00	635.85	1	0	0	0	NULL	0	0	NULL	892	NULL	NULL	NULL
60	446	446	606106	0	Charge perf 606106	2018-02-08 00:00:00	NULL	NULL	NULL	AP446	NULL	Achat perf 446	635.85	0.00	1	0	0	0	NULL	0	0	NULL	891	NULL	NULL	NULL
60	447	447	401001	0	A Divers	2018-03-15 00:00:00	NULL	NULL	NULL	AP447	NULL	Achat perf 447	0.00	672.98	1	0	0	0	NULL	0	0	NULL	894	NULL	NULL	NULL
60	447	447	606107	0	Charge perf 606107	2018-03-15 00:00:00	NULL	NULL	NULL	AP447	NULL	Achat perf 447	672.98	0.00	1	0	0	0	NULL	0	0	NULL	893	NULL	NULL	NULL
60	449	449	401001	0	A Divers	2018-05-01 00:00:00	NULL	NULL	NULL	AP449	NULL	Achat perf 449	0.00	746.24	1	0	0	0	NULL	0	0	NULL	898	NULL	NULL	NULL
60	449	449	606109	0	Charge perf 606109	2018-05-01 00:00:00	NULL	NULL	NULL	AP449	NULL	Achat perf 449	746.24	0.00	1	0	0	0	NULL	0	0	NULL	897	NULL	NULL	NULL
60	45	45	401001	0	A Divers	2018-03-01 00:00:00	NULL	NULL	NULL	AP45	NULL	Achat perf 45	0.00	648.72	1	0	0	0	NULL	0	0	NULL	90	NULL	NULL	NULL
60	45	45	613105	0	Charge perf 613105	2018-03-01 00:00:00	NULL	NULL	NULL	AP45	NULL	Achat perf 45	648.72	0.00	1	0	0	0	NULL	0	0	NULL	89	NULL	NULL	NULL
60	450	450	401001	0	A Divers	2018-06-08 00:00:00	NULL	NULL	NULL	AP450	NULL	Achat perf 450	0.00	783.37	1	0	0	0	NULL	0	0	NULL	900	NULL	NULL	NULL
60	450	450	606110	0	Charge perf 606110	2018-06-08 00:00:00	NULL	NULL	NULL	AP450	NULL	Achat perf 450	783.37	0.00	1	0	0	0	NULL	0	0	NULL	899	NULL	NULL	NULL
60	452	452	401001	0	A Divers	2018-02-22 00:00:00	NULL	NULL	NULL	AP452	NULL	Achat perf 452	0.00	857.63	1	0	0	0	NULL	0	0	NULL	904	NULL	NULL	NULL
60	452	452	606112	0	Charge perf 606112	2018-02-22 00:00:00	NULL	NULL	NULL	AP452	NULL	Achat perf 452	857.63	0.00	1	0	0	0	NULL	0	0	NULL	903	NULL	NULL	NULL
60	453	453	401001	0	A Divers	2018-03-01 00:00:00	NULL	NULL	NULL	AP453	NULL	Achat perf 453	0.00	894.76	1	0	0	0	NULL	0	0	NULL	906	NULL	NULL	NULL
60	453	453	606113	0	Charge perf 606113	2018-03-01 00:00:00	NULL	NULL	NULL	AP453	NULL	Achat perf 453	894.76	0.00	1	0	0	0	NULL	0	0	NULL	905	NULL	NULL	NULL
60	455	455	401001	0	A Divers	2018-05-15 00:00:00	NULL	NULL	NULL	AP455	NULL	Achat perf 455	0.00	968.02	1	0	0	0	NULL	0	0	NULL	910	NULL	NULL	NULL
60	455	455	606115	0	Charge perf 606115	2018-05-15 00:00:00	NULL	NULL	NULL	AP455	NULL	Achat perf 455	968.02	0.00	1	0	0	0	NULL	0	0	NULL	909	NULL	NULL	NULL
60	456	456	401001	0	A Divers	2018-06-22 00:00:00	NULL	NULL	NULL	AP456	NULL	Achat perf 456	0.00	15.15	1	0	0	0	NULL	0	0	NULL	912	NULL	NULL	NULL
60	456	456	606116	0	Charge perf 606116	2018-06-22 00:00:00	NULL	NULL	NULL	AP456	NULL	Achat perf 456	15.15	0.00	1	0	0	0	NULL	0	0	NULL	911	NULL	NULL	NULL
60	458	458	401001	0	A Divers	2018-02-08 00:00:00	NULL	NULL	NULL	AP458	NULL	Achat perf 458	0.00	89.41	1	0	0	0	NULL	0	0	NULL	916	NULL	NULL	NULL
60	458	458	606118	0	Charge perf 606118	2018-02-08 00:00:00	NULL	NULL	NULL	AP458	NULL	Achat perf 458	89.41	0.00	1	0	0	0	NULL	0	0	NULL	915	NULL	NULL	NULL
60	459	459	401001	0	A Divers	2018-03-15 00:00:00	NULL	NULL	NULL	AP459	NULL	Achat perf 459	0.00	126.54	1	0	0	0	NULL	0	0	NULL	918	NULL	NULL	NULL
60	459	459	606119	0	Charge perf 606119	2018-03-15 00:00:00	NULL	NULL	NULL	AP459	NULL	Achat perf 459	126.54	0.00	1	0	0	0	NULL	0	0	NULL	917	NULL	NULL	NULL
60	461	461	401001	0	A Divers	2018-05-01 00:00:00	NULL	NULL	NULL	AP461	NULL	Achat perf 461	0.00	200.80	1	0	0	0	NULL	0	0	NULL	922	NULL	NULL	NULL
60	461	461	613101	0	Charge perf 613101	2018-05-01 00:00:00	NULL	NULL	NULL	AP461	NULL	Achat perf 461	200.80	0.00	1	0	0	0	NULL	0	0	NULL	921	NULL	NULL	NULL
60	462	462	401001	0	A Divers	2018-06-08 00:00:00	NULL	NULL	NULL	AP462	NULL	Achat perf 462	0.00	237.93	1	0	0	0	NULL	0	0	NULL	924	NULL	NULL	NULL
60	462	462	613102	0	Charge perf 613102	2018-06-08 00:00:00	NULL	NULL	NULL	AP462	NULL	Achat perf 462	237.93	0.00	1	0	0	0	NULL	0	0	NULL	923	NULL	NULL	NULL
60	464	464	401001	0	A Divers	2018-02-22 00:00:00	NULL	NULL	NULL	AP464	NULL	Achat perf 464	0.00	311.19	1	0	0	0	NULL	0	0	NULL	928	NULL	NULL	NULL
60	464	464	613104	0	Charge perf 613104	2018-02-22 00:00:00	NULL	NULL	NULL	AP464	NULL	Achat perf 464	311.19	0.00	1	0	0	0	NULL	0	0	NULL	927	NULL	NULL	NULL
60	465	465	401001	0	A Divers	2018-03-01 00:00:00	NULL	NULL	NULL	AP465	NULL	Achat perf 465	0.00	348.32	1	0	0	0	NULL	0	0	NULL	930	NULL	NULL	NULL
60	465	465	613105	0	Charge perf 613105	2018-03-01 00:00:00	NULL	NULL	NULL	AP465	NULL	Achat perf 465	348.32	0.00	1	0	0	0	NULL	0	0	NULL	929	NULL	NULL	NULL
60	467	467	401001	0	A Divers	2018-05-15 00:00:00	NULL	NULL	NULL	AP467	NULL	Achat perf 467	0.00	422.58	1	0	0	0	NULL	0	0	NULL	934	NULL	NULL	NULL
60	467	467	613107	0	Charge perf 613107	2018-05-15 00:00:00	NULL	NULL	NULL	AP467	NULL	Achat perf 467	422.58	0.00	1	0	0	0	NULL	0	0	NULL	933	NULL	NULL	NULL
60	468	468	401001	0	A Divers	2018-06-22 00:00:00	NULL	NULL	NULL	AP468	NULL	Achat perf 468	0.00	459.71	1	0	0	0	NULL	0	0	NULL	936	NULL	NULL	NULL
60	468	468	613108	0	Charge perf 613108	2018-06-22 00:00:00	NULL	NULL	NULL	AP468	NULL	Achat perf 468	459.71	0.00	1	0	0	0	NULL	0	0	NULL	935	NULL	NULL	NULL
60	47	47	401001	0	A Divers	2018-05-15 00:00:00	NULL	NULL	NULL	AP47	NULL	Achat perf 47	0.00	722.98	1	0	0	0	NULL	0	0	NULL	94	NULL	NULL	NULL
60	47	47	613107	0	Charge perf 613107	2018-05-15 00:00:00	NULL	NULL	NULL	AP47	NULL	Achat perf 47	722.98	0.00	1	0	0	0	NULL	0	0	NULL	93	NULL	NULL	NULL
60	470	470	401001	0	A Divers	2018-02-08 00:00:00	NULL	NULL	NULL	AP470	NULL	Achat perf 470	0.00	533.97	1	0	0	0	NULL	0	0	NULL	940	NULL	NULL	NULL
60	470	470	613110	0	Charge perf 613110	2018-02-08 00:00:00	NULL	NULL	NULL	AP470	NULL	Achat perf 470	533.97	0.00	1	0	0	0	NULL	0	0	NULL	939	NULL	NULL	NULL
60	471	471	401001	0	A Divers	2018-03-15 00:00:00	NULL	NULL	NULL	AP471	NULL	Achat perf 471	0.00	570.10	1	0	0	0	NULL	0	0	NULL	942	NULL	NULL	NULL
60	471	471	613111	0	Charge perf 613111	2018-03-15 00:00:00	NULL	NULL	NULL	AP471	NULL	Achat perf 471	570.10	0.00	1	0	0	0	NULL	0	0	NULL	941	NULL	NULL	NULL
60	473	473	401001	0	A Divers	2018-05-01 00:00:00	NULL	NULL	NULL	AP473	NULL	Achat perf 473	0.00	644.36	1	0	0	0	NULL	0	0	NULL	946	NULL	NULL	NULL
60	473	473	613113	0	Charge perf 613113	2018-05-01 00:00:00	NULL	NULL	NULL	AP473	NULL	Achat perf 473	644.36	0.00	1	0	0	0	NULL	0	0	NULL	945	NULL	NULL	NULL
60	474	474	401001	0	A Divers	2018-06-08 00:00:00	NULL	NULL	NULL	AP474	NULL	Achat perf 474	0.00	681.49	1	0	0	0	NULL	0	0	NULL	948	NULL	NULL	NULL
60	474	474	613114	0	Charge perf 613114	2018-06-08 00:00:00	NULL	NULL	NULL	AP474	NULL	Achat perf 474	681.49	0.00	1	0	0	0	NULL	0	0	NULL	947	NULL	NULL	NULL
60	476	476	401001	0	A Divers	2018-02-22 00:00:00	NULL	NULL	NULL	AP476	NULL	Achat perf 476	0.00	755.75	1	0	0	0	NULL	0	0	NULL	952	NULL	NULL	NULL
60	476	476	613116	0	Charge perf 613116	2018-02-22 00:00:00	NULL	NULL	NULL	AP476	NULL	Achat perf 476	755.75	0.00	1	0	0	0	NULL	0	0	NULL	951	NULL	NULL	NULL
60	477	477	401001	0	A Divers	2018-03-01 00:00:00	NULL	NULL	NULL	AP477	NULL	Achat perf 477	0.00	792.88	1	0	0	0	NULL	0	0	NULL	954	NULL	NULL	NULL
60	477	477	613117	0	Charge perf 613117	2018-03-01 00:00:00	NULL	NULL	NULL	AP477	NULL	Achat perf 477	792.88	0.00	1	0	0	0	NULL	0	0	NULL	953	NULL	NULL	NULL
60	479	479	401001	0	A Divers	2018-05-15 00:00:00	NULL	NULL	NULL	AP479	NULL	Achat perf 479	0.00	866.14	1	0	0	0	NULL	0	0	NULL	958	NULL	NULL	NULL
60	479	479	613119	0	Charge perf 613119	2018-05-15 00:00:00	NULL	NULL	NULL	AP479	NULL	Achat perf 479	866.14	0.00	1	0	0	0	NULL	0	0	NULL	957	NULL	NULL	NULL
60	48	48	401001	0	A Divers	2018-06-22 00:00:00	NULL	NULL	NULL	AP48	NULL	Achat perf 48	0.00	759.11	1	0	0	0	NULL	0	0	NULL	96	NULL	NULL	NULL
60	48	48	613108	0	Charge perf 613108	2018-06-22 00:00:00	NULL	NULL	NULL	AP48	NULL	Achat perf 48	759.11	0.00	1	0	0	0	NULL	0	0	NULL	95	NULL	NULL	NULL
60	480	480	401001	0	A Divers	2018-06-22 00:00:00	NULL	NULL	NULL	AP480	NULL	Achat perf 480	0.00	903.27	1	0	0	0	NULL	0	0	NULL	960	NULL	NULL	NULL
60	480	480	613120	0	Charge perf 613120	2018-06-22 00:00:00	NULL	NULL	NULL	AP480	NULL	Achat perf 480	903.27	0.00	1	0	0	0	NULL	0	0	NULL	959	NULL	NULL	NULL
60	482	482	401001	0	A Divers	2018-02-08 00:00:00	NULL	NULL	NULL	AP482	NULL	Achat perf 482	0.00	977.53	1	0	0	0	NULL	0	0	NULL	964	NULL	NULL	NULL
60	482	482	601002	0	Charge perf 601002	2018-02-08 00:00:00	NULL	NULL	NULL	AP482	NULL	Achat perf 482	977.53	0.00	1	0	0	0	NULL	0	0	NULL	963	NULL	NULL	NULL
60	483	483	401001	0	A Divers	2018-03-15 00:00:00	NULL	NULL	NULL	AP483	NULL	Achat perf 483	0.00	24.66	1	0	0	0	NULL	0	0	NULL	966	NULL	NULL	NULL
60	483	483	601003	0	Charge perf 601003	2018-03-15 00:00:00	NULL	NULL	NULL	AP483	NULL	Achat perf 483	24.66	0.00	1	0	0	0	NULL	0	0	NULL	965	NULL	NULL	NULL
60	485	485	401001	0	A Divers	2018-05-01 00:00:00	NULL	NULL	NULL	AP485	NULL	Achat perf 485	0.00	98.92	1	0	0	0	NULL	0	0	NULL	970	NULL	NULL	NULL
60	485	485	601005	0	Charge perf 601005	2018-05-01 00:00:00	NULL	NULL	NULL	AP485	NULL	Achat perf 485	98.92	0.00	1	0	0	0	NULL	0	0	NULL	969	NULL	NULL	NULL
60	486	486	401001	0	A Divers	2018-06-08 00:00:00	NULL	NULL	NULL	AP486	NULL	Achat perf 486	0.00	135.05	1	0	0	0	NULL	0	0	NULL	972	NULL	NULL	NULL
60	486	486	601006	0	Charge perf 601006	2018-06-08 00:00:00	NULL	NULL	NULL	AP486	NULL	Achat perf 486	135.05	0.00	1	0	0	0	NULL	0	0	NULL	971	NULL	NULL	NULL
60	488	488	401001	0	A Divers	2018-02-22 00:00:00	NULL	NULL	NULL	AP488	NULL	Achat perf 488	0.00	209.31	1	0	0	0	NULL	0	0	NULL	976	NULL	NULL	NULL
60	488	488	601008	0	Charge perf 601008	2018-02-22 00:00:00	NULL	NULL	NULL	AP488	NULL	Achat perf 488	209.31	0.00	1	0	0	0	NULL	0	0	NULL	975	NULL	NULL	NULL
60	489	489	401001	0	A Divers	2018-03-01 00:00:00	NULL	NULL	NULL	AP489	NULL	Achat perf 489	0.00	246.44	1	0	0	0	NULL	0	0	NULL	978	NULL	NULL	NULL
60	489	489	601009	0	Charge perf 601009	2018-03-01 00:00:00	NULL	NULL	NULL	AP489	NULL	Achat perf 489	246.44	0.00	1	0	0	0	NULL	0	0	NULL	977	NULL	NULL	NULL
60	491	491	401001	0	A Divers	2018-05-15 00:00:00	NULL	NULL	NULL	AP491	NULL	Achat perf 491	0.00	320.70	1	0	0	0	NULL	0	0	NULL	982	NULL	NULL	NULL
60	491	491	601011	0	Charge perf 601011	2018-05-15 00:00:00	NULL	NULL	NULL	AP491	NULL	Achat perf 491	320.70	0.00	1	0	0	0	NULL	0	0	NULL	981	NULL	NULL	NULL
60	492	492	401001	0	A Divers	2018-06-22 00:00:00	NULL	NULL	NULL	AP492	NULL	Achat perf 492	0.00	357.83	1	0	0	0	NULL	0	0	NULL	984	NULL	NULL	NULL
60	492	492	601012	0	Charge perf 601012	2018-06-22 00:00:00	NULL	NULL	NULL	AP492	NULL	Achat perf 492	357.83	0.00	1	0	0	0	NULL	0	0	NULL	983	NULL	NULL	NULL
60	494	494	401001	0	A Divers	2018-02-08 00:00:00	NULL	NULL	NULL	AP494	NULL	Achat perf 494	0.00	431.09	1	0	0	0	NULL	0	0	NULL	988	NULL	NULL	NULL
60	494	494	601014	0	Charge perf 601014	2018-02-08 00:00:00	NULL	NULL	NULL	AP494	NULL	Achat perf 494	431.09	0.00	1	0	0	0	NULL	0	0	NULL	987	NULL	NULL	NULL
60	495	495	401001	0	A Divers	2018-03-15 00:00:00	NULL	NULL	NULL	AP495	NULL	Achat perf 495	0.00	468.22	1	0	0	0	NULL	0	0	NULL	990	NULL	NULL	NULL
60	495	495	601015	0	Charge perf 601015	2018-03-15 00:00:00	NULL	NULL	NULL	AP495	NULL	Achat perf 495	468.22	0.00	1	0	0	0	NULL	0	0	NULL	989	NULL	NULL	NULL
60	497	497	401001	0	A Divers	2018-05-01 00:00:00	NULL	NULL	NULL	AP497	NULL	Achat perf 497	0.00	542.48	1	0	0	0	NULL	0	0	NULL	994	NULL	NULL	NULL
60	497	497	601017	0	Charge perf 601017	2018-05-01 00:00:00	NULL	NULL	NULL	AP497	NULL	Achat perf 497	542.48	0.00	1	0	0	0	NULL	0	0	NULL	993	NULL	NULL	NULL
60	498	498	401001	0	A Divers	2018-06-08 00:00:00	NULL	NULL	NULL	AP498	NULL	Achat perf 498	0.00	579.61	1	0	0	0	NULL	0	0	NULL	996	NULL	NULL	NULL
60	498	498	601018	0	Charge perf 601018	2018-06-08 00:00:00	NULL	NULL	NULL	AP498	NULL	Achat perf 498	579.61	0.00	1	0	0	0	NULL	0	0	NULL	995	NULL	NULL	NULL
60	5	5	401001	0	A Divers	2018-05-01 00:00:00	NULL	NULL	NULL	AP5	NULL	Achat perf 5	0.00	158.52	1	0	0	0	NULL	0	0	NULL	10	NULL	NULL	NULL
60	5	5	601005	0	Charge perf 601005	2018-05-01 00:00:00	NULL	NULL	NULL	AP5	NULL	Achat perf 5	158.52	0.00	1	0	0	0	NULL	0	0	NULL	9	NULL	NULL	NULL
60	50	50	401001	0	A Divers	2018-02-08 00:00:00	NULL	NULL	NULL	AP50	NULL	Achat perf 50	0.00	833.37	1	0	0	0	NULL	0	0	NULL	100	NULL	NULL	NULL
60	50	50	613110	0	Charge perf 613110	2018-02-08 00:00:00	NULL	NULL	NULL	AP50	NULL	Achat perf 50	833.37	0.00	1	0	0	0	NULL	0	0	NULL	99	NULL	NULL	NULL
60	500	500	401001	0	A Divers	2018-02-22 00:00:00	NULL	NULL	NULL	AP500	NULL	Achat perf 500	0.00	653.87	1	0	0	0	NULL	0	0	NULL	1000	NULL	NULL	NULL
60	500	500	601020	0	Charge perf 601020	2018-02-22 00:00:00	NULL	NULL	NULL	AP500	NULL	Achat perf 500	653.87	0.00	1	0	0	0	NULL	0	0	NULL	999	NULL	NULL	NULL
60	51	51	401001	0	A Divers	2018-03-15 00:00:00	NULL	NULL	NULL	AP51	NULL	Achat perf 51	0.00	870.50	1	0	0	0	NULL	0	0	NULL	102	NULL	NULL	NULL
60	51	51	613111	0	Charge perf 613111	2018-03-15 00:00:00	NULL	NULL	NULL	AP51	NULL	Achat perf 51	870.50	0.00	1	0	0	0	NULL	0	0	NULL	101	NULL	NULL	NULL
60	53	53	401001	0	A Divers	2018-05-01 00:00:00	NULL	NULL	NULL	AP53	NULL	Achat perf 53	0.00	944.76	1	0	0	0	NULL	0	0	NULL	106	NULL	NULL	NULL
60	53	53	613113	0	Charge perf 613113	2018-05-01 00:00:00	NULL	NULL	NULL	AP53	NULL	Achat perf 53	944.76	0.00	1	0	0	0	NULL	0	0	NULL	105	NULL	NULL	NULL
60	54	54	401001	0	A Divers	2018-06-08 00:00:00	NULL	NULL	NULL	AP54	NULL	Achat perf 54	0.00	981.89	1	0	0	0	NULL	0	0	NULL	108	NULL	NULL	NULL
60	54	54	613114	0	Charge perf 613114	2018-06-08 00:00:00	NULL	NULL	NULL	AP54	NULL	Achat perf 54	981.89	0.00	1	0	0	0	NULL	0	0	NULL	107	NULL	NULL	NULL
60	56	56	401001	0	A Divers	2018-02-22 00:00:00	NULL	NULL	NULL	AP56	NULL	Achat perf 56	0.00	65.15	1	0	0	0	NULL	0	0	NULL	112	NULL	NULL	NULL
60	56	56	613116	0	Charge perf 613116	2018-02-22 00:00:00	NULL	NULL	NULL	AP56	NULL	Achat perf 56	65.15	0.00	1	0	0	0	NULL	0	0	NULL	111	NULL	NULL	NULL
60	57	57	401001	0	A Divers	2018-03-01 00:00:00	NULL	NULL	NULL	AP57	NULL	Achat perf 57	0.00	102.28	1	0	0	0	NULL	0	0	NULL	114	NULL	NULL	NULL
60	57	57	613117	0	Charge perf 613117	2018-03-01 00:00:00	NULL	NULL	NULL	AP57	NULL	Achat perf 57	102.28	0.00	1	0	0	0	NULL	0	0	NULL	113	NULL	NULL	NULL
60	59	59	401001	0	A Divers	2018-05-15 00:00:00	NULL	NULL	NULL	AP59	NULL	Achat perf 59	0.00	176.54	1	0	0	0	NULL	0	0	NULL	118	NULL	NULL	NULL
60	59	59	613119	0	Charge perf 613119	2018-05-15 00:00:00	NULL	NULL	NULL	AP59	NULL	Achat perf 59	176.54	0.00	1	0	0	0	NULL	0	0	NULL	117	NULL	NULL	NULL
60	6	6	401001	0	A Divers	2018-06-08 00:00:00	NULL	NULL	NULL	AP6	NULL	Achat perf 6	0.00	195.65	1	0	0	0	NULL	0	0	NULL	12	NULL	NULL	NULL
60	6	6	601006	0	Charge perf 601006	2018-06-08 00:00:00	NULL	NULL	NULL	AP6	NULL	Achat perf 6	195.65	0.00	1	0	0	0	NULL	0	0	NULL	11	NULL	NULL	NULL
60	60	60	401001	0	A Divers	2018-06-22 00:00:00	NULL	NULL	NULL	AP60	NULL	Achat perf 60	0.00	213.67	1	0	0	0	NULL	0	0	NULL	120	NULL	NULL	NULL
60	60	60	613120	0	Charge perf 613120	2018-06-22 00:00:00	NULL	NULL	NULL	AP60	NULL	Achat perf 60	213.67	0.00	1	0	0	0	NULL	0	0	NULL	119	NULL	NULL	NULL
60	62	62	401001	0	A Divers	2018-02-08 00:00:00	NULL	NULL	NULL	AP62	NULL	Achat perf 62	0.00	287.93	1	0	0	0	NULL	0	0	NULL	124	NULL	NULL	NULL
60	62	62	601002	0	Charge perf 601002	2018-02-08 00:00:00	NULL	NULL	NULL	AP62	NULL	Achat perf 62	287.93	0.00	1	0	0	0	NULL	0	0	NULL	123	NULL	NULL	NULL
60	63	63	401001	0	A Divers	2018-03-15 00:00:00	NULL	NULL	NULL	AP63	NULL	Achat perf 63	0.00	324.06	1	0	0	0	NULL	0	0	NULL	126	NULL	NULL	NULL
60	63	63	601003	0	Charge perf 601003	2018-03-15 00:00:00	NULL	NULL	NULL	AP63	NULL	Achat perf 63	324.06	0.00	1	0	0	0	NULL	0	0	NULL	125	NULL	NULL	NULL
60	65	65	401001	0	A Divers	2018-05-01 00:00:00	NULL	NULL	NULL	AP65	NULL	Achat perf 65	0.00	398.32	1	0	0	0	NULL	0	0	NULL	130	NULL	NULL	NULL
60	65	65	601005	0	Charge perf 601005	2018-05-01 00:00:00	NULL	NULL	NULL	AP65	NULL	Achat perf 65	398.32	0.00	1	0	0	0	NULL	0	0	NULL	129	NULL	NULL	NULL
60	66	66	401001	0	A Divers	2018-06-08 00:00:00	NULL	NULL	NULL	AP66	NULL	Achat perf 66	0.00	435.45	1	0	0	0	NULL	0	0	NULL	132	NULL	NULL	NULL
60	66	66	601006	0	Charge perf 601006	2018-06-08 00:00:00	NULL	NULL	NULL	AP66	NULL	Achat perf 66	435.45	0.00	1	0	0	0	NULL	0	0	NULL	131	NULL	NULL	NULL
60	68	68	401001	0	A Divers	2018-02-22 00:00:00	NULL	NULL	NULL	AP68	NULL	Achat perf 68	0.00	509.71	1	0	0	0	NULL	0	0	NULL	136	NULL	NULL	NULL
60	68	68	601008	0	Charge perf 601008	2018-02-22 00:00:00	NULL	NULL	NULL	AP68	NULL	Achat perf 68	509.71	0.00	1	0	0	0	NULL	0	0	NULL	135	NULL	NULL	NULL
60	69	69	401001	0	A Divers	2018-03-01 00:00:00	NULL	NULL	NULL	AP69	NULL	Achat perf 69	0.00	546.84	1	0	0	0	NULL	0	0	NULL	138	NULL	NULL	NULL
60	69	69	601009	0	Charge perf 601009	2018-03-01 00:00:00	NULL	NULL	NULL	AP69	NULL	Achat perf 69	546.84	0.00	1	0	0	0	NULL	0	0	NULL	137	NULL	NULL	NULL
60	71	71	401001	0	A Divers	2018-05-15 00:00:00	NULL	NULL	NULL	AP71	NULL	Achat perf 71	0.00	620.10	1	0	0	0	NULL	0	0	NULL	142	NULL	NULL	NULL
60	71	71	601011	0	Charge perf 601011	2018-05-15 00:00:00	NULL	NULL	NULL	AP71	NULL	Achat perf 71	620.10	0.00	1	0	0	0	NULL	0	0	NULL	141	NULL	NULL	NULL
60	72	72	401001	0	A Divers	2018-06-22 00:00:00	NULL	NULL	NULL	AP72	NULL	Achat perf 72	0.00	657.23	1	0	0	0	NULL	0	0	NULL	144	NULL	NULL	NULL
60	72	72	601012	0	Charge perf 601012	2018-06-22 00:00:00	NULL	NULL	NULL	AP72	NULL	Achat perf 72	657.23	0.00	1	0	0	0	NULL	0	0	NULL	143	NULL	NULL	NULL
60	74	74	401001	0	A Divers	2018-02-08 00:00:00	NULL	NULL	NULL	AP74	NULL	Achat perf 74	0.00	731.49	1	0	0	0	NULL	0	0	NULL	148	NULL	NULL	NULL
60	74	74	601014	0	Charge perf 601014	2018-02-08 00:00:00	NULL	NULL	NULL	AP74	NULL	Achat perf 74	731.49	0.00	1	0	0	0	NULL	0	0	NULL	147	NULL	NULL	NULL
60	75	75	401001	0	A Divers	2018-03-15 00:00:00	NULL	NULL	NULL	AP75	NULL	Achat perf 75	0.00	768.62	1	0	0	0	NULL	0	0	NULL	150	NULL	NULL	NULL
60	75	75	601015	0	Charge perf 601015	2018-03-15 00:00:00	NULL	NULL	NULL	AP75	NULL	Achat perf 75	768.62	0.00	1	0	0	0	NULL	0	0	NULL	149	NULL	NULL	NULL
60	77	77	401001	0	A Divers	2018-05-01 00:00:00	NULL	NULL	NULL	AP77	NULL	Achat perf 77	0.00	842.88	1	0	0	0	NULL	0	0	NULL	154	NULL	NULL	NULL
60	77	77	601017	0	Charge perf 601017	2018-05-01 00:00:00	NULL	NULL	NULL	AP77	NULL	Achat perf 77	842.88	0.00	1	0	0	0	NULL	0	0	NULL	153	NULL	NULL	NULL
60	78	78	401001	0	A Divers	2018-06-08 00:00:00	NULL	NULL	NULL	AP78	NULL	Achat perf 78	0.00	879.01	1	0	0	0	NULL	0	0	NULL	156	NULL	NULL	NULL
60	78	78	601018	0	Charge perf 601018	2018-06-08 00:00:00	NULL	NULL	NULL	AP78	NULL	Achat perf 78	879.01	0.00	1	0	0	0	NULL	0	0	NULL	155	NULL	NULL	NULL
60	8	8	401001	0	A Divers	2018-02-22 00:00:00	NULL	NULL	NULL	AP8	NULL	Achat perf 8	0.00	269.91	1	0	0	0	NULL	0	0	NULL	16	NULL	NULL	NULL
60	8	8	601008	0	Charge perf 601008	2018-02-22 00:00:00	NULL	NULL	NULL	AP8	NULL	Achat perf 8	269.91	0.00	1	0	0	0	NULL	0	0	NULL	15	NULL	NULL	NULL
60	80	80	401001	0	A Divers	2018-02-22 00:00:00	NULL	NULL	NULL	AP80	NULL	Achat perf 80	0.00	953.27	1	0	0	0	NULL	0	0	NULL	160	NULL	NULL	NULL
60	80	80	601020	0	Charge perf 601020	2018-02-22 00:00:00	NULL	NULL	NULL	AP80	NULL	Achat perf 80	953.27	0.00	1	0	0	0	NULL	0	0	NULL	159	NULL	NULL	NULL
60	81	81	401001	0	A Divers	2018-03-01 00:00:00	NULL	NULL	NULL	AP81	NULL	Achat perf 81	0.00	990.40	1	0	0	0	NULL	0	0	NULL	162	NULL	NULL	NULL
60	81	81	606101	0	Charge perf 606101	2018-03-01 00:00:00	NULL	NULL	NULL	AP81	NULL	Achat perf 81	990.40	0.00	1	0	0	0	NULL	0	0	NULL	161	NULL	NULL	NULL
60	83	83	401001	0	A Divers	2018-05-15 00:00:00	NULL	NULL	NULL	AP83	NULL	Achat perf 83	0.00	74.66	1	0	0	0	NULL	0	0	NULL	166	NULL	NULL	NULL
60	83	83	606103	0	Charge perf 606103	2018-05-15 00:00:00	NULL	NULL	NULL	AP83	NULL	Achat perf 83	74.66	0.00	1	0	0	0	NULL	0	0	NULL	165	NULL	NULL	NULL
60	84	84	401001	0	A Divers	2018-06-22 00:00:00	NULL	NULL	NULL	AP84	NULL	Achat perf 84	0.00	111.79	1	0	0	0	NULL	0	0	NULL	168	NULL	NULL	NULL
60	84	84	606104	0	Charge perf 606104	2018-06-22 00:00:00	NULL	NULL	NULL	AP84	NULL	Achat perf 84	111.79	0.00	1	0	0	0	NULL	0	0	NULL	167	NULL	NULL	NULL
60	86	86	401001	0	A Divers	2018-02-08 00:00:00	NULL	NULL	NULL	AP86	NULL	Achat perf 86	0.00	185.05	1	0	0	0	NULL	0	0	NULL	172	NULL	NULL	NULL
60	86	86	606106	0	Charge perf 606106	2018-02-08 00:00:00	NULL	NULL	NULL	AP86	NULL	Achat perf 86	185.05	0.00	1	0	0	0	NULL	0	0	NULL	171	NULL	NULL	NULL
60	87	87	401001	0	A Divers	2018-03-15 00:00:00	NULL	NULL	NULL	AP87	NULL	Achat perf 87	0.00	222.18	1	0	0	0	NULL	0	0	NULL	174	NULL	NULL	NULL
60	87	87	606107	0	Charge perf 606107	2018-03-15 00:00:00	NULL	NULL	NULL	AP87	NULL	Achat perf 87	222.18	0.00	1	0	0	0	NULL	0	0	NULL	173	NULL	NULL	NULL
60	89	89	401001	0	A Divers	2018-05-01 00:00:00	NULL	NULL	NULL	AP89	NULL	Achat perf 89	0.00	296.44	1	0	0	0	NULL	0	0	NULL	178	NULL	NULL	NULL
60	89	89	606109	0	Charge perf 606109	2018-05-01 00:00:00	NULL	NULL	NULL	AP89	NULL	Achat perf 89	296.44	0.00	1	0	0	0	NULL	0	0	NULL	177	NULL	NULL	NULL
60	9	9	401001	0	A Divers	2018-03-01 00:00:00	NULL	NULL	NULL	AP9	NULL	Achat perf 9	0.00	306.04	1	0	0	0	NULL	0	0	NULL	18	NULL	NULL	NULL
60	9	9	601009	0	Charge perf 601009	2018-03-01 00:00:00	NULL	NULL	NULL	AP9	NULL	Achat perf 9	306.04	0.00	1	0	0	0	NULL	0	0	NULL	17	NULL	NULL	NULL
60	90	90	401001	0	A Divers	2018-06-08 00:00:00	NULL	NULL	NULL	AP90	NULL	Achat perf 90	0.00	333.57	1	0	0	0	NULL	0	0	NULL	180	NULL	NULL	NULL
60	90	90	606110	0	Charge perf 606110	2018-06-08 00:00:00	NULL	NULL	NULL	AP90	NULL	Achat perf 90	333.57	0.00	1	0	0	0	NULL	0	0	NULL	179	NULL	NULL	NULL
60	92	92	401001	0	A Divers	2018-02-22 00:00:00	NULL	NULL	NULL	AP92	NULL	Achat perf 92	0.00	407.83	1	0	0	0	NULL	0	0	NULL	184	NULL	NULL	NULL
60	92	92	606112	0	Charge perf 606112	2018-02-22 00:00:00	NULL	NULL	NULL	AP92	NULL	Achat perf 92	407.83	0.00	1	0	0	0	NULL	0	0	NULL	183	NULL	NULL	NULL
60	93	93	401001	0	A Divers	2018-03-01 00:00:00	NULL	NULL	NULL	AP93	NULL	Achat perf 93	0.00	444.96	1	0	0	0	NULL	0	0	NULL	186	NULL	NULL	NULL
60	93	93	606113	0	Charge perf 606113	2018-03-01 00:00:00	NULL	NULL	NULL	AP93	NULL	Achat perf 93	444.96	0.00	1	0	0	0	NULL	0	0	NULL	185	NULL	NULL	NULL
60	95	95	401001	0	A Divers	2018-05-15 00:00:00	NULL	NULL	NULL	AP95	NULL	Achat perf 95	0.00	518.22	1	0	0	0	NULL	0	0	NULL	190	NULL	NULL	NULL
60	95	95	606115	0	Charge perf 606115	2018-05-15 00:00:00	NULL	NULL	NULL	AP95	NULL	Achat perf 95	518.22	0.00	1	0	0	0	NULL	0	0	NULL	189	NULL	NULL	NULL
60	96	96	401001	0	A Divers	2018-06-22 00:00:00	NULL	NULL	NULL	AP96	NULL	Achat perf 96	0.00	555.35	1	0	0	0	NULL	0	0	NULL	192	NULL	NULL	NULL
60	96	96	606116	0	Charge perf 606116	2018-06-22 00:00:00	NULL	NULL	NULL	AP96	NULL	Achat perf 96	555.35	0.00	1	0	0	0	NULL	0	0	NULL	191	NULL	NULL	NULL
60	98	98	401001	0	A Divers	2018-02-08 00:00:00	NULL	NULL	NULL	AP98	NULL	Achat perf 98	0.00	629.61	1	0	0	0	NULL	0	0	NULL	196	NULL	NULL	NULL
60	98	98	606118	0	Charge perf 606118	2018-02-08 00:00:00	NULL	NULL	NULL	AP98	NULL	Achat perf 98	629.61	0.00	1	0	0	0	NULL	0	0	NULL	195	NULL	NULL	NULL
60	99	99	401001	0	A Divers	2018-03-15 00:00:00	NULL	NULL	NULL	AP99	NULL	Achat perf 99	0.00	666.74	1	0	0	0	NULL	0	0	NULL	198	NULL	NULL	NULL
60	99	99	606119	0	Charge perf 606119	2018-03-15 00:00:00	NULL	NULL	NULL	AP99	NULL	Achat perf 99	666.74	0.00	1	0	0	0	NULL	0	0	NULL	197	NULL	NULL	NULL
70	1	1	411001	0	A Divers	2018-01-01 00:00:00	NULL	NULL	NULL	FP1	NULL	Vente perf 1	10.00	0.00	1	0	0	0	NULL	0	0	NULL	1	NULL	NULL	NULL
70	1	1	706001	0	Produit perf 706001	2018-01-01 00:00:00	NULL	NULL	NULL	FP1	NULL	Vente perf 1	0.00	10.00	1	0	0	0	NULL	0	0	NULL	2	NULL	NULL	NULL
70	10	10	411001	0	A Divers	2018-04-08 00:00:00	NULL	NULL	NULL	FP10	NULL	Vente perf 10	343.17	0.00	1	0	0	0	NULL	0	0	NULL	19	NULL	NULL	NULL
70	10	10	706010	0	Produit perf 706010	2018-04-08 00:00:00	NULL	NULL	NULL	FP10	NULL	Vente perf 10	0.00	343.17	1	0	0	0	NULL	0	0	NULL	20	NULL	NULL	NULL
70	100	100	411001	0	A Divers	2018-04-22 00:00:00	NULL	NULL	NULL	FP100	NULL	Vente perf 100	703.87	0.00	1	0	0	0	NULL	0	0	NULL	199	NULL	NULL	NULL
70	100	100	706010	0	Produit perf 706010	2018-04-22 00:00:00	NULL	NULL	NULL	FP100	NULL	Vente perf 100	0.00	703.87	1	0	0	0	NULL	0	0	NULL	200	NULL	NULL	NULL
70	103	103	411001	0	A Divers	2018-01-15 00:00:00	NULL	NULL	NULL	FP103	NULL	Vente perf 103	814.26	0.00	1	0	0	0	NULL	0	0	NULL	205	NULL	NULL	NULL
70	103	103	706013	0	Produit perf 706013	2018-01-15 00:00:00	NULL	NULL	NULL	FP103	NULL	Vente perf 103	0.00	814.26	1	0	0	0	NULL	0	0	NULL	206	NULL	NULL	NULL
70	106	106	411001	0	A Divers	2018-04-08 00:00:00	NULL	NULL	NULL	FP106	NULL	Vente perf 106	925.65	0.00	1	0	0	0	NULL	0	0	NULL	211	NULL	NULL	NULL
70	106	106	707101	0	Produit perf 707101	2018-04-08 00:00:00	NULL	NULL	NULL	FP106	NULL	Vente perf 106	0.00	925.65	1	0	0	0	NULL	0	0	NULL	212	NULL	NULL	NULL
70	109	109	411001	0	A Divers	2018-01-01 00:00:00	NULL	NULL	NULL	FP109	NULL	Vente perf 109	46.04	0.00	1	0	0	0	NULL	0	0	NULL	217	NULL	NULL	NULL
70	109	109	707104	0	Produit perf 707104	2018-01-01 00:00:00	NULL	NULL	NULL	FP109	NULL	Vente perf 109	0.00	46.04	1	0	0	0	NULL	0	0	NULL	218	NULL	NULL	NULL
70	112	112	411001	0	A Divers	2018-04-22 00:00:00	NULL	NULL	NULL	FP112	NULL	Vente perf 112	157.43	0.00	1	0	0	0	NULL	0	0	NULL	223	NULL	NULL	NULL
70	112	112	707107	0	Produit perf 707107	2018-04-22 00:00:00	NULL	NULL	NULL	FP112	NULL	Vente perf 112	0.00	157.43	1	0	0	0	NULL	0	0	NULL	224	NULL	NULL	NULL
70	115	115	411001	0	A Divers	2018-01-15 00:00:00	NULL	NULL	NULL	FP115	NULL	Vente perf 115	268.82	0.00	1	0	0	0	NULL	0	0	NULL	229	NULL	NULL	NULL
70	115	115	707110	0	Produit perf 707110	2018-01-15 00:00:00	NULL	NULL	NULL	FP115	NULL	Vente perf 115	0.00	268.82	1	0	0	0	NULL	0	0	NULL	230	NULL	NULL	NULL
70	118	118	411001	0	A Divers	2018-04-08 00:00:00	NULL	NULL	NULL	FP118	NULL	Vente perf 118	379.21	0.00	1	0	0	0	NULL	0	0	NULL	235	NULL	NULL	NULL
70	118	118	707113	0	Produit perf 707113	2018-04-08 00:00:00	NULL	NULL	NULL	FP118	NULL	Vente perf 118	0.00	379.21	1	0	0	0	NULL	0	0	NULL	236	NULL	NULL	NULL
70	121	121	411001	0	A Divers	2018-01-01 00:00:00	NULL	NULL	NULL	FP121	NULL	Vente perf 121	490.60	0.00	1	0	0	0	NULL	0	0	NULL	241	NULL	NULL	NULL
70	121	121	706001	0	Produit perf 706001	2018-01-01 00:00:00	NULL	NULL	NULL	FP121	NULL	Vente perf 121	0.00	490.60	1	0	0	0	NULL	0	0	NULL	242	NULL	NULL	NULL
70	124	124	411001	0	A Divers	2018-04-22 00:00:00	NULL	NULL	NULL	FP124	NULL	Vente perf 124	601.99	0.00	1	0	0	0	NULL	0	0	NULL	247	NULL	NULL	NULL
70	124	124	706004	0	Produit perf 706004	2018-04-22 00:00:00	NULL	NULL	NULL	FP124	NULL	Vente perf 124	0.00	601.99	1	0	0	0	NULL	0	0	NULL	248	NULL	NULL	NULL
70	127	127	411001	0	A Divers	2018-01-15 00:00:00	NULL	NULL	NULL	FP127	NULL	Vente perf 127	712.38	0.00	1	0	0	0	NULL	0	0	NULL	253	NULL	NULL	NULL
70	127	127	706007	0	Produit perf 706007	2018-01-15 00:00:00	NULL	NULL	NULL	FP127	NULL	Vente perf 127	0.00	712.38	1	0	0	0	NULL	0	0	NULL	254	NULL	NULL	NULL
70	13	13	411001	0	A Divers	2018-01-01 00:00:00	NULL	NULL	NULL	FP13	NULL	Vente perf 13	454.56	0.00	1	0	0	0	NULL	0	0	NULL	25	NULL	NULL	NULL
70	13	13	706013	0	Produit perf 706013	2018-01-01 00:00:00	NULL	NULL	NULL	FP13	NULL	Vente perf 13	0.00	454.56	1	0	0	0	NULL	0	0	NULL	26	NULL	NULL	NULL
70	130	130	411001	0	A Divers	2018-04-08 00:00:00	NULL	NULL	NULL	FP130	NULL	Vente perf 130	823.77	0.00	1	0	0	0	NULL	0	0	NULL	259	NULL	NULL	NULL
70	130	130	706010	0	Produit perf 706010	2018-04-08 00:00:00	NULL	NULL	NULL	FP130	NULL	Vente perf 130	0.00	823.77	1	0	0	0	NULL	0	0	NULL	260	NULL	NULL	NULL
70	133	133	411001	0	A Divers	2018-01-01 00:00:00	NULL	NULL	NULL	FP133	NULL	Vente perf 133	934.16	0.00	1	0	0	0	NULL	0	0	NULL	265	NULL	NULL	NULL
70	133	133	706013	0	Produit perf 706013	2018-01-01 00:00:00	NULL	NULL	NULL	FP133	NULL	Vente perf 133	0.00	934.16	1	0	0	0	NULL	0	0	NULL	266	NULL	NULL	NULL
70	136	136	411001	0	A Divers	2018-04-22 00:00:00	NULL	NULL	NULL	FP136	NULL	Vente perf 136	55.55	0.00	1	0	0	0	NULL	0	0	NULL	271	NULL	NULL	NULL
70	136	136	707101	0	Produit perf 707101	2018-04-22 00:00:00	NULL	NULL	NULL	FP136	NULL	Vente perf 136	0.00	55.55	1	0	0	0	NULL	0	0	NULL	272	NULL	NULL	NULL
70	139	139	411001	0	A Divers	2018-01-15 00:00:00	NULL	NULL	NULL	FP139	NULL	Vente perf 139	166.94	0.00	1	0	0	0	NULL	0	0	NULL	277	NULL	NULL	NULL
70	139	139	707104	0	Produit perf 707104	2018-01-15 00:00:00	NULL	NULL	NULL	FP139	NULL	Vente perf 139	0.00	166.94	1	0	0	0	NULL	0	0	NULL	278	NULL	NULL	NULL
70	142	142	411001	0	A Divers	2018-04-08 00:00:00	NULL	NULL	NULL	FP142	NULL	Vente perf 142	277.33	0.00	1	0	0	0	NULL	0	0	NULL	283	NULL	NULL	NULL
70	142	142	707107	0	Produit perf 707107	2018-04-08 00:00:00	NULL	NULL	NULL	FP142	NULL	Vente perf 142	0.00	277.33	1	0	0	0	NULL	0	0	NULL	284	NULL	NULL	NULL
70	145	145	411001	0	A Divers	2018-01-01 00:00:00	NULL	NULL	NULL	FP145	NULL	Vente perf 145	388.72	0.00	1	0	0	0	NULL	0	0	NULL	289	NULL	NULL	NULL
70	145	145	707110	0	Produit perf 707110	2018-01-01 00:00:00	NULL	NULL	NULL	FP145	NULL	Vente perf 145	0.00	388.72	1	0	0	0	NULL	0	0	NULL	290	NULL	NULL	NULL
70	148	148	411001	0	A Divers	2018-04-22 00:00:00	NULL	NULL	NULL	FP148	NULL	Vente perf 148	499.11	0.00	1	0	0	0	NULL	0	0	NULL	295	NULL	NULL	NULL
70	148	148	707113	0	Produit perf 707113	2018-04-22 00:00:00	NULL	NULL	NULL	FP148	NULL	Vente perf 148	0.00	499.11	1	0	0	0	NULL	0	0	NULL	296	NULL	NULL	NULL
70	151	151	411001	0	A Divers	2018-01-15 00:00:00	NULL	NULL	NULL	FP151	NULL	Vente perf 151	610.50	0.00	1	0	0	0	NULL	0	0	NULL	301	NULL	NULL	NULL
70	151	151	706001	0	Produit perf 706001	2018-01-15 00:00:00	NULL	NULL	NULL	FP151	NULL	Vente perf 151	0.00	610.50	1	0	0	0	NULL	0	0	NULL	302	NULL	NULL	NULL
70	154	154	411001	0	A Divers	2018-04-08 00:00:00	NULL	NULL	NULL	FP154	NULL	Vente perf 154	721.89	0.00	1	0	0	0	NULL	0	0	NULL	307	NULL	NULL	NULL
70	154	154	706004	0	Produit perf 706004	2018-04-08 00:00:00	NULL	NULL	NULL	FP154	NULL	Vente perf 154	0.00	721.89	1	0	0	0	NULL	0	0	NULL	308	NULL	NULL	NULL
70	157	157	411001	0	A Divers	2018-01-01 00:00:00	NULL	NULL	NULL	FP157	NULL	Vente perf 157	832.28	0.00	1	0	0	0	NULL	0	0	NULL	313	NULL	NULL	NULL
70	157	157	706007	0	Produit perf 706007	2018-01-01 00:00:00	NULL	NULL	NULL	FP157	NULL	Vente perf 157	0.00	832.28	1	0	0	0	NULL	0	0	NULL	314	NULL	NULL	NULL
70	16	16	411001	0	A Divers	2018-04-22 00:00:00	NULL	NULL	NULL	FP16	NULL	Vente perf 16	565.95	0.00	1	0	0	0	NULL	0	0	NULL	31	NULL	NULL	NULL
70	16	16	707101	0	Produit perf 707101	2018-04-22 00:00:00	NULL	NULL	NULL	FP16	NULL	Vente perf 16	0.00	565.95	1	0	0	0	NULL	0	0	NULL	32	NULL	NULL	NULL
70	160	160	411001	0	A Divers	2018-04-22 00:00:00	NULL	NULL	NULL	FP160	NULL	Vente perf 160	943.67	0.00	1	0	0	0	NULL	0	0	NULL	319	NULL	NULL	NULL
70	160	160	706010	0	Produit perf 706010	2018-04-22 00:00:00	NULL	NULL	NULL	FP160	NULL	Vente perf 160	0.00	943.67	1	0	0	0	NULL	0	0	NULL	320	NULL	NULL	NULL
70	163	163	411001	0	A Divers	2018-01-15 00:00:00	NULL	NULL	NULL	FP163	NULL	Vente perf 163	64.06	0.00	1	0	0	0	NULL	0	0	NULL	325	NULL	NULL	NULL
70	163	163	706013	0	Produit perf 706013	2018-01-15 00:00:00	NULL	NULL	NULL	FP163	NULL	Vente perf 163	0.00	64.06	1	0	0	0	NULL	0	0	NULL	326	NULL	NULL	NULL
70	166	166	411001	0	A Divers	2018-04-08 00:00:00	NULL	NULL	NULL	FP166	NULL	Vente perf 166	175.45	0.00	1	0	0	0	NULL	0	0	NULL	331	NULL	NULL	NULL
70	166	166	707101	0	Produit perf 707101	2018-04-08 00:00:00	NULL	NULL	NULL	FP166	NULL	Vente perf 166	0.00	175.45	1	0	0	0	NULL	0	0	NULL	332	NULL	NULL	NULL
70	169	169	411001	0	A Divers	2018-01-01 00:00:00	NULL	NULL	NULL	FP169	NULL	Vente perf 169	286.84	0.00	1	0	0	0	NULL	0	0	NULL	337	NULL	NULL	NULL
70	169	169	707104	0	Produit perf 707104	2018-01-01 00:00:00	NULL	NULL	NULL	FP169	NULL	Vente perf 169	0.00	286.84	1	0	0	0	NULL	0	0	NULL	338	NULL	NULL	NULL
70	172	172	411001	0	A Divers	2018-04-22 00:00:00	NULL	NULL	NULL	FP172	NULL	Vente perf 172	397.23	0.00	1	0	0	0	NULL	0	0	NULL	343	NULL	NULL	NULL
70	172	172	707107	0	Produit perf 707107	2018-04-22 00:00:00	NULL	NULL	NULL	FP172	NULL	Vente perf 172	0.00	397.23	1	0	0	0	NULL	0	0	NULL	344	NULL	NULL	NULL
70	175	175	411001	0	A Divers	2018-01-15 00:00:00	NULL	NULL	NULL	FP175	NULL	Vente perf 175	508.62	0.00	1	0	0	0	NULL	0	0	NULL	349	NULL	NULL	NULL
70	175	175	707110	0	Produit perf 707110	2018-01-15 00:00:00	NULL	NULL	NULL	FP175	NULL	Vente perf 175	0.00	508.62	1	0	0	0	NULL	0	0	NULL	350	NULL	NULL	NULL
70	178	178	411001	0	A Divers	2018-04-08 00:00:00	NULL	NULL	NULL	FP178	NULL	Vente perf 178	619.01	0.00	1	0	0	0	NULL	0	0	NULL	355	NULL	NULL	NULL
70	178	178	707113	0	Produit perf 707113	2018-04-08 00:00:00	NULL	NULL	NULL	FP178	NULL	Vente perf 178	0.00	619.01	1	0	0	0	NULL	0	0	NULL	356	NULL	NULL	NULL
70	181	181	411001	0	A Divers	2018-01-01 00:00:00	NULL	NULL	NULL	FP181	NULL	Vente perf 181	730.40	0.00	1	0	0	0	NULL	0	0	NULL	361	NULL	NULL	NULL
70	181	181	706001	0	Produit perf 706001	2018-01-01 00:00:00	NULL	NULL	NULL	FP181	NULL	Vente perf 181	0.00	730.40	1	0	0	0	NULL	0	0	NULL	362	NULL	NULL	NULL
70	184	184	411001	0	A Divers	2018-04-22 00:00:00	NULL	NULL	NULL	FP184	NULL	Vente perf 184	841.79	0.00	1	0	0	0	NULL	0	0	NULL	367	NULL	NULL	NULL
70	184	184	706004	0	Produit perf 706004	2018-04-22 00:00:00	NULL	NULL	NULL	FP184	NULL	Vente perf 184	0.00	841.79	1	0	0	0	NULL	0	0	NULL	368	NULL	NULL	NULL
70	187	187	411001	0	A Divers	2018-01-15 00:00:00	NULL	NULL	NULL	FP187	NULL	Vente perf 187	952.18	0.00	1	0	0	0	NULL	0	0	NULL	373	NULL	NULL	NULL
70	187	187	706007	0	Produit perf 706007	2018-01-15 00:00:00	NULL	NULL	NULL	FP187	NULL	Vente perf 187	0.00	952.18	1	0	0	0	NULL	0	0	NULL	374	NULL	NULL	NULL
70	19	19	411001	0	A Divers	2018-01-15 00:00:00	NULL	NULL	NULL	FP19	NULL	Vente perf 19	676.34	0.00	1	0	0	0	NULL	0	0	NULL	37	NULL	NULL	NULL
70	19	19	707104	0	Produit perf 707104	2018-01-15 00:00:00	NULL	NULL	NULL	FP19	NULL	Vente perf 19	0.00	676.34	1	0	0	0	NULL	0	0	NULL	38	NULL	NULL	NULL
70	190	190	411001	0	A Divers	2018-04-08 00:00:00	NULL	NULL	NULL	FP190	NULL	Vente perf 190	73.57	0.00	1	0	0	0	NULL	0	0	NULL	379	NULL	NULL	NULL
70	190	190	706010	0	Produit perf 706010	2018-04-08 00:00:00	NULL	NULL	NULL	FP190	NULL	Vente perf 190	0.00	73.57	1	0	0	0	NULL	0	0	NULL	380	NULL	NULL	NULL
70	193	193	411001	0	A Divers	2018-01-01 00:00:00	NULL	NULL	NULL	FP193	NULL	Vente perf 193	184.96	0.00	1	0	0	0	NULL	0	0	NULL	385	NULL	NULL	NULL
70	193	193	706013	0	Produit perf 706013	2018-01-01 00:00:00	NULL	NULL	NULL	FP193	NULL	Vente perf 193	0.00	184.96	1	0	0	0	NULL	0	0	NULL	386	NULL	NULL	NULL
70	196	196	411001	0	A Divers	2018-04-22 00:00:00	NULL	NULL	NULL	FP196	NULL	Vente perf 196	295.35	0.00	1	0	0	0	NULL	0	0	NULL	391	NULL	NULL	NULL
70	196	196	707101	0	Produit perf 707101	2018-04-22 00:00:00	NULL	NULL	NULL	FP196	NULL	Vente perf 196	0.00	295.35	1	0	0	0	NULL	0	0	NULL	392	NULL	NULL	NULL
70	199	199	411001	0	A Divers	2018-01-15 00:00:00	NULL	NULL	NULL	FP199	NULL	Vente perf 199	406.74	0.00	1	0	0	0	NULL	0	0	NULL	397	NULL	NULL	NULL
70	199	199	707104	0	Produit perf 707104	2018-01-15 00:00:00	NULL	NULL	NULL	FP199	NULL	Vente perf 199	0.00	406.74	1	0	0	0	NULL	0	0	NULL	398	NULL	NULL	NULL
70	202	202	411001	0	A Divers	2018-04-08 00:00:00	NULL	NULL	NULL	FP202	NULL	Vente perf 202	517.13	0.00	1	0	0	0	NULL	0	0	NULL	403	NULL	NULL	NULL
70	202	202	707107	0	Produit perf 707107	2018-04-08 00:00:00	NULL	NULL	NULL	FP202	NULL	Vente perf 202	0.00	517.13	1	0	0	0	NULL	0	0	NULL	404	NULL	NULL	NULL
70	205	205	411001	0	A Divers	2018-01-01 00:00:00	NULL	NULL	NULL	FP205	NULL	Vente perf 205	628.52	0.00	1	0	0	0	NULL	0	0	NULL	409	NULL	NULL	NULL
70	205	205	707110	0	Produit perf 707110	2018-01-01 00:00:00	NULL	NULL	NULL	FP205	NULL	Vente perf 205	0.00	628.52	1	0	0	0	NULL	0	0	NULL	410	NULL	NULL	NULL
70	208	208	411001	0	A Divers	2018-04-22 00:00:00	NULL	NULL	NULL	FP208	NULL	Vente perf 208	739.91	0.00	1	0	0	0	NULL	0	0	NULL	415	NULL	NULL	NULL
70	208	208	707113	0	Produit perf 707113	2018-04-22 00:00:00	NULL	NULL	NULL	FP208	NULL	Vente perf 208	0.00	739.91	1	0	0	0	NULL	0	0	NULL	416	NULL	NULL	NULL
70	211	211	411001	0	A Divers	2018-01-15 00:00:00	NULL	NULL	NULL	FP211	NULL	Vente perf 211	850.30	0.00	1	0	0	0	NULL	0	0	NULL	421	NULL	NULL	NULL
70	211	211	706001	0	Produit perf 706001	2018-01-15 00:00:00	NULL	NULL	NULL	FP211	NULL	Vente perf 211	0.00	850.30	1	0	0	0	NULL	0	0	NULL	422	NULL	NULL	NULL
70	214	214	411001	0	A Divers	2018-04-08 00:00:00	NULL	NULL	NULL	FP214	NULL	Vente perf 214	961.69	0.00	1	0	0	0	NULL	0	0	NULL	427	NULL	NULL	NULL
70	214	214	706004	0	Produit perf 706004	2018-04-08 00:00:00	NULL	NULL	NULL	FP214	NULL	Vente perf 214	0.00	961.69	1	0	0	0	NULL	0	0	NULL	428	NULL	NULL	NULL
70	217	217	411001	0	A Divers	2018-01-01 00:00:00	NULL	NULL	NULL	FP217	NULL	Vente perf 217	82.08	0.00	1	0	0	0	NULL	0	0	NULL	433	NULL	NULL	NULL
70	217	217	706007	0	Produit perf 706007	2018-01-01 00:00:00	NULL	NULL	NULL	FP217	NULL	Vente perf 217	0.00	82.08	1	0	0	0	NULL	0	0	NULL	434	NULL	NULL	NULL
70	22	22	411001	0	A Divers	2018-04-08 00:00:00	NULL	NULL	NULL	FP22	NULL	Vente perf 22	787.73	0.00	1	0	0	0	NULL	0	0	NULL	43	NULL	NULL	NULL
70	22	22	707107	0	Produit perf 707107	2018-04-08 00:00:00	NULL	NULL	NULL	FP22	NULL	Vente perf 22	0.00	787.73	1	0	0	0	NULL	0	0	NULL	44	NULL	NULL	NULL
70	220	220	411001	0	A Divers	2018-04-22 00:00:00	NULL	NULL	NULL	FP220	NULL	Vente perf 220	193.47	0.00	1	0	0	0	NULL	0	0	NULL	439	NULL	NULL	NULL
70	220	220	706010	0	Produit perf 706010	2018-04-22 00:00:00	NULL	NULL	NULL	FP220	NULL	Vente perf 220	0.00	193.47	1	0	0	0	NULL	0	0	NULL	440	NULL	NULL	NULL
70	223	223	411001	0	A Divers	2018-01-15 00:00:00	NULL	NULL	NULL	FP223	NULL	Vente perf 223	304.86	0.00	1	0	0	0	NULL	0	0	NULL	445	NULL	NULL	NULL
70	223	223	706013	0	Produit perf 706013	2018-01-15 00:00:00	NULL	NULL	NULL	FP223	NULL	Vente perf 223	0.00	304.86	1	0	0	0	NULL	0	0	NULL	446	NULL	NULL	NULL
70	226	226	411001	0	A Divers	2018-04-08 00:00:00	NULL	NULL	NULL	FP226	NULL	Vente perf 226	415.25	0.00	1	0	0	0	NULL	0	0	NULL	451	NULL	NULL	NULL
70	226	226	707101	0	Produit perf 707101	2018-04-08 00:00:00	NULL	NULL	NULL	FP226	NULL	Vente perf 226	0.00	415.25	1	0	0	0	NULL	0	0	NULL	452	NULL	NULL	NULL
70	229	229	411001	0	A Divers	2018-01-01 00:00:00	NULL	NULL	NULL	FP229	NULL	Vente perf 229	526.64	0.00	1	0	0	0	NULL	0	0	NULL	457	NULL	NULL	NULL
70	229	229	707104	0	Produit perf 707104	2018-01-01 00:00:00	NULL	NULL	NULL	FP229	NULL	Vente perf 229	0.00	526.64	1	0	0	0	NULL	0	0	NULL	458	NULL	NULL	NULL
70	232	232	411001	0	A Divers	2018-04-22 00:00:00	NULL	NULL	NULL	FP232	NULL	Vente perf 232	637.03	0.00	1	0	0	0	NULL	0	0	NULL	463	NULL	NULL	NULL
70	232	232	707107	0	Produit perf 707107	2018-04-22 00:00:00	NULL	NULL	NULL	FP232	NULL	Vente perf 232	0.00	637.03	1	0	0	0	NULL	0	0	NULL	464	NULL	NULL	NULL
70	235	235	411001	0	A Divers	2018-01-15 00:00:00	NULL	NULL	NULL	FP235	NULL	Vente perf 235	748.42	0.00	1	0	0	0	NULL	0	0	NULL	469	NULL	NULL	NULL
70	235	235	707110	0	Produit perf 707110	2018-01-15 00:00:00	NULL	NULL	NULL	FP235	NULL	Vente perf 235	0.00	748.42	1	0	0	0	NULL	0	0	NULL	470	NULL	NULL	NULL
70	238	238	411001	0	A Divers	2018-04-08 00:00:00	NULL	NULL	NULL	FP238	NULL	Vente perf 238	859.81	0.00	1	0	0	0	NULL	0	0	NULL	475	NULL	NULL	NULL
70	238	238	707113	0	Produit perf 707113	2018-04-08 00:00:00	NULL	NULL	NULL	FP238	NULL	Vente perf 238	0.00	859.81	1	0	0	0	NULL	0	0	NULL	476	NULL	NULL	NULL
70	241	241	411001	0	A Divers	2018-01-01 00:00:00	NULL	NULL	NULL	FP241	NULL	Vente perf 241	970.20	0.00	1	0	0	0	NULL	0	0	NULL	481	NULL	NULL	NULL
70	241	241	706001	0	Produit perf 706001	2018-01-01 00:00:00	NULL	NULL	NULL	FP241	NULL	Vente perf 241	0.00	970.20	1	0	0	0	NULL	0	0	NULL	482	NULL	NULL	NULL
70	244	244	411001	0	A Divers	2018-04-22 00:00:00	NULL	NULL	NULL	FP244	NULL	Vente perf 244	91.59	0.00	1	0	0	0	NULL	0	0	NULL	487	NULL	NULL	NULL
70	244	244	706004	0	Produit perf 706004	2018-04-22 00:00:00	NULL	NULL	NULL	FP244	NULL	Vente perf 244	0.00	91.59	1	0	0	0	NULL	0	0	NULL	488	NULL	NULL	NULL
70	247	247	411001	0	A Divers	2018-01-15 00:00:00	NULL	NULL	NULL	FP247	NULL	Vente perf 247	202.98	0.00	1	0	0	0	NULL	0	0	NULL	493	NULL	NULL	NULL
70	247	247	706007	0	Produit perf 706007	2018-01-15 00:00:00	NULL	NULL	NULL	FP247	NULL	Vente perf 247	0.00	202.98	1	0	0	0	NULL	0	0	NULL	494	NULL	NULL	NULL
70	25	25	411001	0	A Divers	2018-01-01 00:00:00	NULL	NULL	NULL	FP25	NULL	Vente perf 25	898.12	0.00	1	0	0	0	NULL	0	0	NULL	49	NULL	NULL	NULL
70	25	25	707110	0	Produit perf 707110	2018-01-01 00:00:00	NULL	NULL	NULL	FP25	NULL	Vente perf 25	0.00	898.12	1	0	0	0	NULL	0	0	NULL	50	NULL	NULL	NULL
70	250	250	411001	0	A Divers	2018-04-08 00:00:00	NULL	NULL	NULL	FP250	NULL	Vente perf 250	313.37	0.00	1	0	0	0	NULL	0	0	NULL	499	NULL	NULL	NULL
70	250	250	706010	0	Produit perf 706010	2018-04-08 00:00:00	NULL	NULL	NULL	FP250	NULL	Vente perf 250	0.00	313.37	1	0	0	0	NULL	0	0	NULL	500	NULL	NULL	NULL
70	253	253	411001	0	A Divers	2018-01-01 00:00:00	NULL	NULL	NULL	FP253	NULL	Vente perf 253	424.76	0.00	1	0	0	0	NULL	0	0	NULL	505	NULL	NULL	NULL
70	253	253	706013	0	Produit perf 706013	2018-01-01 00:00:00	NULL	NULL	NULL	FP253	NULL	Vente perf 253	0.00	424.76	1	0	0	0	NULL	0	0	NULL	506	NULL	NULL	NULL
70	256	256	411001	0	A Divers	2018-04-22 00:00:00	NULL	NULL	NULL	FP256	NULL	Vente perf 256	535.15	0.00	1	0	0	0	NULL	0	0	NULL	511	NULL	NULL	NULL
70	256	256	707101	0	Produit perf 707101	2018-04-22 00:00:00	NULL	NULL	NULL	FP256	NULL	Vente perf 256	0.00	535.15	1	0	0	0	NULL	0	0	NULL	512	NULL	NULL	NULL
70	259	259	411001	0	A Divers	2018-01-15 00:00:00	NULL	NULL	NULL	FP259	NULL	Vente perf 259	646.54	0.00	1	0	0	0	NULL	0	0	NULL	517	NULL	NULL	NULL
70	259	259	707104	0	Produit perf 707104	2018-01-15 00:00:00	NULL	NULL	NULL	FP259	NULL	Vente perf 259	0.00	646.54	1	0	0	0	NULL	0	0	NULL	518	NULL	NULL	NULL
70	262	262	411001	0	A Divers	2018-04-08 00:00:00	NULL	NULL	NULL	FP262	NULL	Vente perf 262	757.93	0.00	1	0	0	0	NULL	0	0	NULL	523	NULL	NULL	NULL
70	262	262	707107	0	Produit perf 707107	2018-04-08 00:00:00	NULL	NULL	NULL	FP262	NULL	Vente perf 262	0.00	757.93	1	0	0	0	NULL	0	0	NULL	524	NULL	NULL	NULL
70	265	265	411001	0	A Divers	2018-01-01 00:00:00	NULL	NULL	NULL	FP265	NULL	Vente perf 265	868.32	0.00	1	0	0	0	NULL	0	0	NULL	529	NULL	NULL	NULL
70	265	265	707110	0	Produit perf 707110	2018-01-01 00:00:00	NULL	NULL	NULL	FP265	NULL	Vente perf 265	0.00	868.32	1	0	0	0	NULL	0	0	NULL	530	NULL	NULL	NULL
70	268	268	411001	0	A Divers	2018-04-22 00:00:00	NULL	NULL	NULL	FP268	NULL	Vente perf 268	979.71	0.00	1	0	0	0	NULL	0	0	NULL	535	NULL	NULL	NULL
70	268	268	707113	0	Produit perf 707113	2018-04-22 00:00:00	NULL	NULL	NULL	FP268	NULL	Vente perf 268	0.00	979.71	1	0	0	0	NULL	0	0	NULL	536	NULL	NULL	NULL
70	271	271	411001	0	A Divers	2018-01-15 00:00:00	NULL	NULL	NULL	FP271	NULL	Vente perf 271	100.10	0.00	1	0	0	0	NULL	0	0	NULL	541	NULL	NULL	NULL
70	271	271	706001	0	Produit perf 706001	2018-01-15 00:00:00	NULL	NULL	NULL	FP271	NULL	Vente perf 271	0.00	100.10	1	0	0	0	NULL	0	0	NULL	542	NULL	NULL	NULL
70	274	274	411001	0	A Divers	2018-04-08 00:00:00	NULL	NULL	NULL	FP274	NULL	Vente perf 274	211.49	0.00	1	0	0	0	NULL	0	0	NULL	547	NULL	NULL	NULL
70	274	274	706004	0	Produit perf 706004	2018-04-08 00:00:00	NULL	NULL	NULL	FP274	NULL	Vente perf 274	0.00	211.49	1	0	0	0	NULL	0	0	NULL	548	NULL	NULL	NULL
70	277	277	411001	0	A Divers	2018-01-01 00:00:00	NULL	NULL	NULL	FP277	NULL	Vente perf 277	322.88	0.00	1	0	0	0	NULL	0	0	NULL	553	NULL	NULL	NULL
70	277	277	706007	0	Produit perf 706007	2018-01-01 00:00:00	NULL	NULL	NULL	FP277	NULL	Vente perf 277	0.00	322.88	1	0	0	0	NULL	0	0	NULL	554	NULL	NULL	NULL
70	28	28	411001	0	A Divers	2018-04-22 00:00:00	NULL	NULL	NULL	FP28	NULL	Vente perf 28	19.51	0.00	1	0	0	0	NULL	0	0	NULL	55	NULL	NULL	NULL
70	28	28	707113	0	Produit perf 707113	2018-04-22 00:00:00	NULL	NULL	NULL	FP28	NULL	Vente perf 28	0.00	19.51	1	0	0	0	NULL	0	0	NULL	56	NULL	NULL	NULL
70	280	280	411001	0	A Divers	2018-04-22 00:00:00	NULL	NULL	NULL	FP280	NULL	Vente perf 280	433.27	0.00	1	0	0	0	NULL	0	0	NULL	559	NULL	NULL	NULL
70	280	280	706010	0	Produit perf 706010	2018-04-22 00:00:00	NULL	NULL	NULL	FP280	NULL	Vente perf 280	0.00	433.27	1	0	0	0	NULL	0	0	NULL	560	NULL	NULL	NULL
70	283	283	411001	0	A Divers	2018-01-15 00:00:00	NULL	NULL	NULL	FP283	NULL	Vente perf 283	544.66	0.00	1	0	0	0	NULL	0	0	NULL	565	NULL	NULL	NULL
70	283	283	706013	0	Produit perf 706013	2018-01-15 00:00:00	NULL	NULL	NULL	FP283	NULL	Vente perf 283	0.00	544.66	1	0	0	0	NULL	0	0	NULL	566	NULL	NULL	NULL
70	286	286	411001	0	A Divers	2018-04-08 00:00:00	NULL	NULL	NULL	FP286	NULL	Vente perf 286	655.05	0.00	1	0	0	0	NULL	0	0	NULL	571	NULL	NULL	NULL
70	286	286	707101	0	Produit perf 707101	2018-04-08 00:00:00	NULL	NULL	NULL	FP286	NULL	Vente perf 286	0.00	655.05	1	0	0	0	NULL	0	0	NULL	572	NULL	NULL	NULL
70	289	289	411001	0	A Divers	2018-01-01 00:00:00	NULL	NULL	NULL	FP289	NULL	Vente perf 289	766.44	0.00	1	0	0	0	NULL	0	0	NULL	577	NULL	NULL	NULL
70	289	289	707104	0	Produit perf 707104	2018-01-01 00:00:00	NULL	NULL	NULL	FP289	NULL	Vente perf 289	0.00	766.44	1	0	0	0	NULL	0	0	NULL	578	NULL	NULL	NULL
70	292	292	411001	0	A Divers	2018-04-22 00:00:00	NULL	NULL	NULL	FP292	NULL	Vente perf 292	877.83	0.00	1	0	0	0	NULL	0	0	NULL	583	NULL	NULL	NULL
70	292	292	707107	0	Produit perf 707107	2018-04-22 00:00:00	NULL	NULL	NULL	FP292	NULL	Vente perf 292	0.00	877.83	1	0	0	0	NULL	0	0	NULL	584	NULL	NULL	NULL
70	295	295	411001	0	A Divers	2018-01-15 00:00:00	NULL	NULL	NULL	FP295	NULL	Vente perf 295	988.22	0.00	1	0	0	0	NULL	0	0	NULL	589	NULL	NULL	NULL
70	295	295	707110	0	Produit perf 707110	2018-01-15 00:00:00	NULL	NULL	NULL	FP295	NULL	Vente perf 295	0.00	988.22	1	0	0	0	NULL	0	0	NULL	590	NULL	NULL	NULL
70	298	298	411001	0	A Divers	2018-04-08 00:00:00	NULL	NULL	NULL	FP298	NULL	Vente perf 298	109.61	0.00	1	0	0	0	NULL	0	0	NULL	595	NULL	NULL	NULL
70	298	298	707113	0	Produit perf 707113	2018-04-08 00:00:00	NULL	NULL	NULL	FP298	NULL	Vente perf 298	0.00	109.61	1	0	0	0	NULL	0	0	NULL	596	NULL	NULL	NULL
70	301	301	411001	0	A Divers	2018-01-01 00:00:00	NULL	NULL	NULL	FP301	NULL	Vente perf 301	220.00	0.00	1	0	0	0	NULL	0	0	NULL	601	NULL	NULL	NULL
70	301	301	706001	0	Produit perf 706001	2018-01-01 00:00:00	NULL	NULL	NULL	FP301	NULL	Vente perf 301	0.00	220.00	1	0	0	0	NULL	0	0	NULL	602	NULL	NULL	NULL
70	304	304	411001	0	A Divers	2018-04-22 00:00:00	NULL	NULL	NULL	FP304	NULL	Vente perf 304	331.39	0.00	1	0	0	0	NULL	0	0	NULL	607	NULL	NULL	NULL
70	304	304	706004	0	Produit perf 706004	2018-04-22 00:00:00	NULL	NULL	NULL	FP304	NULL	Vente perf 304	0.00	331.39	1	0	0	0	NULL	0	0	NULL	608	NULL	NULL	NULL
70	307	307	411001	0	A Divers	2018-01-15 00:00:00	NULL	NULL	NULL	FP307	NULL	Vente perf 307	442.78	0.00	1	0	0	0	NULL	0	0	NULL	613	NULL	NULL	NULL
70	307	307	706007	0	Produit perf 706007	2018-01-15 00:00:00	NULL	NULL	NULL	FP307	NULL	Vente perf 307	0.00	442.78	1	0	0	0	NULL	0	0	NULL	614	NULL	NULL	NULL
70	31	31	411001	0	A Divers	2018-01-15 00:00:00	NULL	NULL	NULL	FP31	NULL	Vente perf 31	130.90	0.00	1	0	0	0	NULL	0	0	NULL	61	NULL	NULL	NULL
70	31	31	706001	0	Produit perf 706001	2018-01-15 00:00:00	NULL	NULL	NULL	FP31	NULL	Vente perf 31	0.00	130.90	1	0	0	0	NULL	0	0	NULL	62	NULL	NULL	NULL
70	310	310	411001	0	A Divers	2018-04-08 00:00:00	NULL	NULL	NULL	FP310	NULL	Vente perf 310	553.17	0.00	1	0	0	0	NULL	0	0	NULL	619	NULL	NULL	NULL
70	310	310	706010	0	Produit perf 706010	2018-04-08 00:00:00	NULL	NULL	NULL	FP310	NULL	Vente perf 310	0.00	553.17	1	0	0	0	NULL	0	0	NULL	620	NULL	NULL	NULL
70	313	313	411001	0	A Divers	2018-01-01 00:00:00	NULL	NULL	NULL	FP313	NULL	Vente perf 313	664.56	0.00	1	0	0	0	NULL	0	0	NULL	625	NULL	NULL	NULL
70	313	313	706013	0	Produit perf 706013	2018-01-01 00:00:00	NULL	NULL	NULL	FP313	NULL	Vente perf 313	0.00	664.56	1	0	0	0	NULL	0	0	NULL	626	NULL	NULL	NULL
70	316	316	411001	0	A Divers	2018-04-22 00:00:00	NULL	NULL	NULL	FP316	NULL	Vente perf 316	775.95	0.00	1	0	0	0	NULL	0	0	NULL	631	NULL	NULL	NULL
70	316	316	707101	0	Produit perf 707101	2018-04-22 00:00:00	NULL	NULL	NULL	FP316	NULL	Vente perf 316	0.00	775.95	1	0	0	0	NULL	0	0	NULL	632	NULL	NULL	NULL
70	319	319	411001	0	A Divers	2018-01-15 00:00:00	NULL	NULL	NULL	FP319	NULL	Vente perf 319	886.34	0.00	1	0	0	0	NULL	0	0	NULL	637	NULL	NULL	NULL
70	319	319	707104	0	Produit perf 707104	2018-01-15 00:00:00	NULL	NULL	NULL	FP319	NULL	Vente perf 319	0.00	886.34	1	0	0	0	NULL	0	0	NULL	638	NULL	NULL	NULL
70	322	322	411001	0	A Divers	2018-04-08 00:00:00	NULL	NULL	NULL	FP322	NULL	Vente perf 322	997.73	0.00	1	0	0	0	NULL	0	0	NULL	643	NULL	NULL	NULL
70	322	322	707107	0	Produit perf 707107	2018-04-08 00:00:00	NULL	NULL	NULL	FP322	NULL	Vente perf 322	0.00	997.73	1	0	0	0	NULL	0	0	NULL	644	NULL	NULL	NULL
70	325	325	411001	0	A Divers	2018-01-01 00:00:00	NULL	NULL	NULL	FP325	NULL	Vente perf 325	118.12	0.00	1	0	0	0	NULL	0	0	NULL	649	NULL	NULL	NULL
70	325	325	707110	0	Produit perf 707110	2018-01-01 00:00:00	NULL	NULL	NULL	FP325	NULL	Vente perf 325	0.00	118.12	1	0	0	0	NULL	0	0	NULL	650	NULL	NULL	NULL
70	328	328	411001	0	A Divers	2018-04-22 00:00:00	NULL	NULL	NULL	FP328	NULL	Vente perf 328	229.51	0.00	1	0	0	0	NULL	0	0	NULL	655	NULL	NULL	NULL
70	328	328	707113	0	Produit perf 707113	2018-04-22 00:00:00	NULL	NULL	NULL	FP328	NULL	Vente perf 328	0.00	229.51	1	0	0	0	NULL	0	0	NULL	656	NULL	NULL	NULL
70	331	331	411001	0	A Divers	2018-01-15 00:00:00	NULL	NULL	NULL	FP331	NULL	Vente perf 331	340.90	0.00	1	0	0	0	NULL	0	0	NULL	661	NULL	NULL	NULL
70	331	331	706001	0	Produit perf 706001	2018-01-15 00:00:00	NULL	NULL	NULL	FP331	NULL	Vente perf 331	0.00	340.90	1	0	0	0	NULL	0	0	NULL	662	NULL	NULL	NULL
70	334	334	411001	0	A Divers	2018-04-08 00:00:00	NULL	NULL	NULL	FP334	NULL	Vente perf 334	451.29	0.00	1	0	0	0	NULL	0	0	NULL	667	NULL	NULL	NULL
70	334	334	706004	0	Produit perf 706004	2018-04-08 00:00:00	NULL	NULL	NULL	FP334	NULL	Vente perf 334	0.00	451.29	1	0	0	0	NULL	0	0	NULL	668	NULL	NULL	NULL
70	337	337	411001	0	A Divers	2018-01-01 00:00:00	NULL	NULL	NULL	FP337	NULL	Vente perf 337	562.68	0.00	1	0	0	0	NULL	0	0	NULL	673	NULL	NULL	NULL
70	337	337	706007	0	Produit perf 706007	2018-01-01 00:00:00	NULL	NULL	NULL	FP337	NULL	Vente perf 337	0.00	562.68	1	0	0	0	NULL	0	0	NULL	674	NULL	NULL	NULL
70	34	34	411001	0	A Divers	2018-04-08 00:00:00	NULL	NULL	NULL	FP34	NULL	Vente perf 34	241.29	0.00	1	0	0	0	NULL	0	0	NULL	67	NULL	NULL	NULL
70	34	34	706004	0	Produit perf 706004	2018-04-08 00:00:00	NULL	NULL	NULL	FP34	NULL	Vente perf 34	0.00	241.29	1	0	0	0	NULL	0	0	NULL	68	NULL	NULL	NULL
70	340	340	411001	0	A Divers	2018-04-22 00:00:00	NULL	NULL	NULL	FP340	NULL	Vente perf 340	673.07	0.00	1	0	0	0	NULL	0	0	NULL	679	NULL	NULL	NULL
70	340	340	706010	0	Produit perf 706010	2018-04-22 00:00:00	NULL	NULL	NULL	FP340	NULL	Vente perf 340	0.00	673.07	1	0	0	0	NULL	0	0	NULL	680	NULL	NULL	NULL
70	343	343	411001	0	A Divers	2018-01-15 00:00:00	NULL	NULL	NULL	FP343	NULL	Vente perf 343	784.46	0.00	1	0	0	0	NULL	0	0	NULL	685	NULL	NULL	NULL
70	343	343	706013	0	Produit perf 706013	2018-01-15 00:00:00	NULL	NULL	NULL	FP343	NULL	Vente perf 343	0.00	784.46	1	0	0	0	NULL	0	0	NULL	686	NULL	NULL	NULL
70	346	346	411001	0	A Divers	2018-04-08 00:00:00	NULL	NULL	NULL	FP346	NULL	Vente perf 346	895.85	0.00	1	0	0	0	NULL	0	0	NULL	691	NULL	NULL	NULL
70	346	346	707101	0	Produit perf 707101	2018-04-08 00:00:00	NULL	NULL	NULL	FP346	NULL	Vente perf 346	0.00	895.85	1	0	0	0	NULL	0	0	NULL	692	NULL	NULL	NULL
70	349	349	411001	0	A Divers	2018-01-01 00:00:00	NULL	NULL	NULL	FP349	NULL	Vente perf 349	16.24	0.00	1	0	0	0	NULL	0	0	NULL	697	NULL	NULL	NULL
70	349	349	707104	0	Produit perf 707104	2018-01-01 00:00:00	NULL	NULL	NULL	FP349	NULL	Vente perf 349	0.00	16.24	1	0	0	0	NULL	0	0	NULL	698	NULL	NULL	NULL
70	352	352	411001	0	A Divers	2018-04-22 00:00:00	NULL	NULL	NULL	FP352	NULL	Vente perf 352	127.63	0.00	1	0	0	0	NULL	0	0	NULL	703	NULL	NULL	NULL
70	352	352	707107	0	Produit perf 707107	2018-04-22 00:00:00	NULL	NULL	NULL	FP352	NULL	Vente perf 352	0.00	127.63	1	0	0	0	NULL	0	0	NULL	704	NULL	NULL	NULL
70	355	355	411001	0	A Divers	2018-01-15 00:00:00	NULL	NULL	NULL	FP355	NULL	Vente perf 355	238.02	0.00	1	0	0	0	NULL	0	0	NULL	709	NULL	NULL	NULL
70	355	355	707110	0	Produit perf 707110	2018-01-15 00:00:00	NULL	NULL	NULL	FP355	NULL	Vente perf 355	0.00	238.02	1	0	0	0	NULL	0	0	NULL	710	NULL	NULL	NULL
70	358	358	411001	0	A Divers	2018-04-08 00:00:00	NULL	NULL	NULL	FP358	NULL	Vente perf 358	349.41	0.00	1	0	0	0	NULL	0	0	NULL	715	NULL	NULL	NULL
70	358	358	707113	0	Produit perf 707113	2018-04-08 00:00:00	NULL	NULL	NULL	FP358	NULL	Vente perf 358	0.00	349.41	1	0	0	0	NULL	0	0	NULL	716	NULL	NULL	NULL
70	361	361	411001	0	A Divers	2018-01-01 00:00:00	NULL	NULL	NULL	FP361	NULL	Vente perf 361	460.80	0.00	1	0	0	0	NULL	0	0	NULL	721	NULL	NULL	NULL
70	361	361	706001	0	Produit perf 706001	2018-01-01 00:00:00	NULL	NULL	NULL	FP361	NULL	Vente perf 361	0.00	460.80	1	0	0	0	NULL	0	0	NULL	722	NULL	NULL	NULL
70	364	364	411001	0	A Divers	2018-04-22 00:00:00	NULL	NULL	NULL	FP364	NULL	Vente perf 364	571.19	0.00	1	0	0	0	NULL	0	0	NULL	727	NULL	NULL	NULL
70	364	364	706004	0	Produit perf 706004	2018-04-22 00:00:00	NULL	NULL	NULL	FP364	NULL	Vente perf 364	0.00	571.19	1	0	0	0	NULL	0	0	NULL	728	NULL	NULL	NULL
70	367	367	411001	0	A Divers	2018-01-15 00:00:00	NULL	NULL	NULL	FP367	NULL	Vente perf 367	682.58	0.00	1	0	0	0	NULL	0	0	NULL	733	NULL	NULL	NULL
70	367	367	706007	0	Produit perf 706007	2018-01-15 00:00:00	NULL	NULL	NULL	FP367	NULL	Vente perf 367	0.00	682.58	1	0	0	0	NULL	0	0	NULL	734	NULL	NULL	NULL
70	37	37	411001	0	A Divers	2018-01-01 00:00:00	NULL	NULL	NULL	FP37	NULL	Vente perf 37	352.68	0.00	1	0	0	0	NULL	0	0	NULL	73	NULL	NULL	NULL
70	37	37	706007	0	Produit perf 706007	2018-01-01 00:00:00	NULL	NULL	NULL	FP37	NULL	Vente perf 37	0.00	352.68	1	0	0	0	NULL	0	0	NULL	74	NULL	NULL	NULL
70	370	370	411001	0	A Divers	2018-04-08 00:00:00	NULL	NULL	NULL	FP370	NULL	Vente perf 370	793.97	0.00	1	0	0	0	NULL	0	0	NULL	739	NULL	NULL	NULL
70	370	370	706010	0	Produit perf 706010	2018-04-08 00:00:00	NULL	NULL	NULL	FP370	NULL	Vente perf 370	0.00	793.97	1	0	0	0	NULL	0	0	NULL	740	NULL	NULL	NULL
70	373	373	411001	0	A Divers	2018-01-01 00:00:00	NULL	NULL	NULL	FP373	NULL	Vente perf 373	904.36	0.00	1	0	0	0	NULL	0	0	NULL	745	NULL	NULL	NULL
70	373	373	706013	0	Produit perf 706013	2018-01-01 00:00:00	NULL	NULL	NULL	FP373	NULL	Vente perf 373	0.00	904.36	1	0	0	0	NULL	0	0	NULL	746	NULL	NULL	NULL
70	376	376	411001	0	A Divers	2018-04-22 00:00:00	NULL	NULL	NULL	FP376	NULL	Vente perf 376	25.75	0.00	1	0	0	0	NULL	0	0	NULL	751	NULL	NULL	NULL
70	376	376	707101	0	Produit perf 707101	2018-04-22 00:00:00	NULL	NULL	NULL	FP376	NULL	Vente perf 376	0.00	25.75	1	0	0	0	NULL	0	0	NULL	752	NULL	NULL	NULL
70	379	379	411001	0	A Divers	2018-01-15 00:00:00	NULL	NULL	NULL	FP379	NULL	Vente perf 379	136.14	0.00	1	0	0	0	NULL	0	0	NULL	757	NULL	NULL	NULL
70	379	379	707104	0	Produit perf 707104	2018-01-15 00:00:00	NULL	NULL	NULL	FP379	NULL	Vente perf 379	0.00	136.14	1	0	0	0	NULL	0	0	NULL	758	NULL	NULL	NULL
70	382	382	411001	0	A Divers	2018-04-08 00:00:00	NULL	NULL	NULL	FP382	NULL	Vente perf 382	247.53	0.00	1	0	0	0	NULL	0	0	NULL	763	NULL	NULL	NULL
70	382	382	707107	0	Produit perf 707107	2018-04-08 00:00:00	NULL	NULL	NULL	FP382	NULL	Vente perf 382	0.00	247.53	1	0	0	0	NULL	0	0	NULL	764	NULL	NULL	NULL
70	385	385	411001	0	A Divers	2018-01-01 00:00:00	NULL	NULL	NULL	FP385	NULL	Vente perf 385	358.92	0.00	1	0	0	0	NULL	0	0	NULL	769	NULL	NULL	NULL
70	385	385	707110	0	Produit perf 707110	2018-01-01 00:00:00	NULL	NULL	NULL	FP385	NULL	Vente perf 385	0.00	358.92	1	0	0	0	NULL	0	0	NULL	770	NULL	NULL	NULL
70	388	388	411001	0	A Divers	2018-04-22 00:00:00	NULL	NULL	NULL	FP388	NULL	Vente perf 388	469.31	0.00	1	0	0	0	NULL	0	0	NULL	775	NULL	NULL	NULL
70	388	388	707113	0	Produit perf 707113	2018-04-22 00:00:00	NULL	NULL	NULL	FP388	NULL	Vente perf 388	0.00	469.31	1	0	0	0	NULL	0	0	NULL	776	NULL	NULL	NULL
70	391	391	411001	0	A Divers	2018-01-15 00:00:00	NULL	NULL	NULL	FP391	NULL	Vente perf 391	580.70	0.00	1	0	0	0	NULL	0	0	NULL	781	NULL	NULL	NULL
70	391	391	706001	0	Produit perf 706001	2018-01-15 00:00:00	NULL	NULL	NULL	FP391	NULL	Vente perf 391	0.00	580.70	1	0	0	0	NULL	0	0	NULL	782	NULL	NULL	NULL
70	394	394	411001	0	A Divers	2018-04-08 00:00:00	NULL	NULL	NULL	FP394	NULL	Vente perf 394	691.09	0.00	1	0	0	0	NULL	0	0	NULL	787	NULL	NULL	NULL
70	394	394	706004	0	Produit perf 706004	2018-04-08 00:00:00	NULL	NULL	NULL	FP394	NULL	Vente perf 394	0.00	691.09	1	0	0	0	NULL	0	0	NULL	788	NULL	NULL	NULL
70	397	397	411001	0	A Divers	2018-01-01 00:00:00	NULL	NULL	NULL	FP397	NULL	Vente perf 397	802.48	0.00	1	0	0	0	NULL	0	0	NULL	793	NULL	NULL	NULL
70	397	397	706007	0	Produit perf 706007	2018-01-01 00:00:00	NULL	NULL	NULL	FP397	NULL	Vente perf 397	0.00	802.48	1	0	0	0	NULL	0	0	NULL	794	NULL	NULL	NULL
70	4	4	411001	0	A Divers	2018-04-22 00:00:00	NULL	NULL	NULL	FP4	NULL	Vente perf 4	121.39	0.00	1	0	0	0	NULL	0	0	NULL	7	NULL	NULL	NULL
70	4	4	706004	0	Produit perf 706004	2018-04-22 00:00:00	NULL	NULL	NULL	FP4	NULL	Vente perf 4	0.00	121.39	1	0	0	0	NULL	0	0	NULL	8	NULL	NULL	NULL
70	40	40	411001	0	A Divers	2018-04-22 00:00:00	NULL	NULL	NULL	FP40	NULL	Vente perf 40	463.07	0.00	1	0	0	0	NULL	0	0	NULL	79	NULL	NULL	NULL
70	40	40	706010	0	Produit perf 706010	2018-04-22 00:00:00	NULL	NULL	NULL	FP40	NULL	Vente perf 40	0.00	463.07	1	0	0	0	NULL	0	0	NULL	80	NULL	NULL	NULL
70	400	400	411001	0	A Divers	2018-04-22 00:00:00	NULL	NULL	NULL	FP400	NULL	Vente perf 400	913.87	0.00	1	0	0	0	NULL	0	0	NULL	799	NULL	NULL	NULL
70	400	400	706010	0	Produit perf 706010	2018-04-22 00:00:00	NULL	NULL	NULL	FP400	NULL	Vente perf 400	0.00	913.87	1	0	0	0	NULL	0	0	NULL	800	NULL	NULL	NULL
70	403	403	411001	0	A Divers	2018-01-15 00:00:00	NULL	NULL	NULL	FP403	NULL	Vente perf 403	34.26	0.00	1	0	0	0	NULL	0	0	NULL	805	NULL	NULL	NULL
70	403	403	706013	0	Produit perf 706013	2018-01-15 00:00:00	NULL	NULL	NULL	FP403	NULL	Vente perf 403	0.00	34.26	1	0	0	0	NULL	0	0	NULL	806	NULL	NULL	NULL
70	406	406	411001	0	A Divers	2018-04-08 00:00:00	NULL	NULL	NULL	FP406	NULL	Vente perf 406	145.65	0.00	1	0	0	0	NULL	0	0	NULL	811	NULL	NULL	NULL
70	406	406	707101	0	Produit perf 707101	2018-04-08 00:00:00	NULL	NULL	NULL	FP406	NULL	Vente perf 406	0.00	145.65	1	0	0	0	NULL	0	0	NULL	812	NULL	NULL	NULL
70	409	409	411001	0	A Divers	2018-01-01 00:00:00	NULL	NULL	NULL	FP409	NULL	Vente perf 409	256.04	0.00	1	0	0	0	NULL	0	0	NULL	817	NULL	NULL	NULL
70	409	409	707104	0	Produit perf 707104	2018-01-01 00:00:00	NULL	NULL	NULL	FP409	NULL	Vente perf 409	0.00	256.04	1	0	0	0	NULL	0	0	NULL	818	NULL	NULL	NULL
70	412	412	411001	0	A Divers	2018-04-22 00:00:00	NULL	NULL	NULL	FP412	NULL	Vente perf 412	367.43	0.00	1	0	0	0	NULL	0	0	NULL	823	NULL	NULL	NULL
70	412	412	707107	0	Produit perf 707107	2018-04-22 00:00:00	NULL	NULL	NULL	FP412	NULL	Vente perf 412	0.00	367.43	1	0	0	0	NULL	0	0	NULL	824	NULL	NULL	NULL
70	415	415	411001	0	A Divers	2018-01-15 00:00:00	NULL	NULL	NULL	FP415	NULL	Vente perf 415	478.82	0.00	1	0	0	0	NULL	0	0	NULL	829	NULL	NULL	NULL
70	415	415	707110	0	Produit perf 707110	2018-01-15 00:00:00	NULL	NULL	NULL	FP415	NULL	Vente perf 415	0.00	478.82	1	0	0	0	NULL	0	0	NULL	830	NULL	NULL	NULL
70	418	418	411001	0	A Divers	2018-04-08 00:00:00	NULL	NULL	NULL	FP418	NULL	Vente perf 418	589.21	0.00	1	0	0	0	NULL	0	0	NULL	835	NULL	NULL	NULL
70	418	418	707113	0	Produit perf 707113	2018-04-08 00:00:00	NULL	NULL	NULL	FP418	NULL	Vente perf 418	0.00	589.21	1	0	0	0	NULL	0	0	NULL	836	NULL	NULL	NULL
70	421	421	411001	0	A Divers	2018-01-01 00:00:00	NULL	NULL	NULL	FP421	NULL	Vente perf 421	700.60	0.00	1	0	0	0	NULL	0	0	NULL	841	NULL	NULL	NULL
70	421	421	706001	0	Produit perf 706001	2018-01-01 00:00:00	NULL	NULL	NULL	FP421	NULL	Vente perf 421	0.00	700.60	1	0	0	0	NULL	0	0	NULL	842	NULL	NULL	NULL
70	424	424	411001	0	A Divers	2018-04-22 00:00:00	NULL	NULL	NULL	FP424	NULL	Vente perf 424	811.99	0.00	1	0	0	0	NULL	0	0	NULL	847	NULL	NULL	NULL
70	424	424	706004	0	Produit perf 706004	2018-04-22 00:00:00	NULL	NULL	NULL	FP424	NULL	Vente perf 424	0.00	811.99	1	0	0	0	NULL	0	0	NULL	848	NULL	NULL	NULL
70	427	427	411001	0	A Divers	2018-01-15 00:00:00	NULL	NULL	NULL	FP427	NULL	Vente perf 427	922.38	0.00	1	0	0	0	NULL	0	0	NULL	853	NULL	NULL	NULL
70	427	427	706007	0	Produit perf 706007	2018-01-15 00:00:00	NULL	NULL	NULL	FP427	NULL	Vente perf 427	0.00	922.38	1	0	0	0	NULL	0	0	NULL	854	NULL	NULL	NULL
70	43	43	411001	0	A Divers	2018-01-15 00:00:00	NULL	NULL	NULL	FP43	NULL	Vente perf 43	574.46	0.00	1	0	0	0	NULL	0	0	NULL	85	NULL	NULL	NULL
70	43	43	706013	0	Produit perf 706013	2018-01-15 00:00:00	NULL	NULL	NULL	FP43	NULL	Vente perf 43	0.00	574.46	1	0	0	0	NULL	0	0	NULL	86	NULL	NULL	NULL
70	430	430	411001	0	A Divers	2018-04-08 00:00:00	NULL	NULL	NULL	FP430	NULL	Vente perf 430	43.77	0.00	1	0	0	0	NULL	0	0	NULL	859	NULL	NULL	NULL
70	430	430	706010	0	Produit perf 706010	2018-04-08 00:00:00	NULL	NULL	NULL	FP430	NULL	Vente perf 430	0.00	43.77	1	0	0	0	NULL	0	0	NULL	860	NULL	NULL	NULL
70	433	433	411001	0	A Divers	2018-01-01 00:00:00	NULL	NULL	NULL	FP433	NULL	Vente perf 433	154.16	0.00	1	0	0	0	NULL	0	0	NULL	865	NULL	NULL	NULL
70	433	433	706013	0	Produit perf 706013	2018-01-01 00:00:00	NULL	NULL	NULL	FP433	NULL	Vente perf 433	0.00	154.16	1	0	0	0	NULL	0	0	NULL	866	NULL	NULL	NULL
70	436	436	411001	0	A Divers	2018-04-22 00:00:00	NULL	NULL	NULL	FP436	NULL	Vente perf 436	265.55	0.00	1	0	0	0	NULL	0	0	NULL	871	NULL	NULL	NULL
70	436	436	707101	0	Produit perf 707101	2018-04-22 00:00:00	NULL	NULL	NULL	FP436	NULL	Vente perf 436	0.00	265.55	1	0	0	0	NULL	0	0	NULL	872	NULL	NULL	NULL
70	439	439	411001	0	A Divers	2018-01-15 00:00:00	NULL	NULL	NULL	FP439	NULL	Vente perf 439	376.94	0.00	1	0	0	0	NULL	0	0	NULL	877	NULL	NULL	NULL
70	439	439	707104	0	Produit perf 707104	2018-01-15 00:00:00	NULL	NULL	NULL	FP439	NULL	Vente perf 439	0.00	376.94	1	0	0	0	NULL	0	0	NULL	878	NULL	NULL	NULL
70	442	442	411001	0	A Divers	2018-04-08 00:00:00	NULL	NULL	NULL	FP442	NULL	Vente perf 442	487.33	0.00	1	0	0	0	NULL	0	0	NULL	883	NULL	NULL	NULL
70	442	442	707107	0	Produit perf 707107	2018-04-08 00:00:00	NULL	NULL	NULL	FP442	NULL	Vente perf 442	0.00	487.33	1	0	0	0	NULL	0	0	NULL	884	NULL	NULL	NULL
70	445	445	411001	0	A Divers	2018-01-01 00:00:00	NULL	NULL	NULL	FP445	NULL	Vente perf 445	598.72	0.00	1	0	0	0	NULL	0	0	NULL	889	NULL	NULL	NULL
70	445	445	707110	0	Produit perf 707110	2018-01-01 00:00:00	NULL	NULL	NULL	FP445	NULL	Vente perf 445	0.00	598.72	1	0	0	0	NULL	0	0	NULL	890	NULL	NULL	NULL
70	448	448	411001	0	A Divers	2018-04-22 00:00:00	NULL	NULL	NULL	FP448	NULL	Vente perf 448	709.11	0.00	1	0	0	0	NULL	0	0	NULL	895	NULL	NULL	NULL
70	448	448	707113	0	Produit perf 707113	2018-04-22 00:00:00	NULL	NULL	NULL	FP448	NULL	Vente perf 448	0.00	709.11	1	0	0	0	NULL	0	0	NULL	896	NULL	NULL	NULL
70	451	451	411001	0	A Divers	2018-01-15 00:00:00	NULL	NULL	NULL	FP451	NULL	Vente perf 451	820.50	0.00	1	0	0	0	NULL	0	0	NULL	901	NULL	NULL	NULL
70	451	451	706001	0	Produit perf 706001	2018-01-15 00:00:00	NULL	NULL	NULL	FP451	NULL	Vente perf 451	0.00	820.50	1	0	0	0	NULL	0	0	NULL	902	NULL	NULL	NULL
70	454	454	411001	0	A Divers	2018-04-08 00:00:00	NULL	NULL	NULL	FP454	NULL	Vente perf 454	931.89	0.00	1	0	0	0	NULL	0	0	NULL	907	NULL	NULL	NULL
70	454	454	706004	0	Produit perf 706004	2018-04-08 00:00:00	NULL	NULL	NULL	FP454	NULL	Vente perf 454	0.00	931.89	1	0	0	0	NULL	0	0	NULL	908	NULL	NULL	NULL
70	457	457	411001	0	A Divers	2018-01-01 00:00:00	NULL	NULL	NULL	FP457	NULL	Vente perf 457	52.28	0.00	1	0	0	0	NULL	0	0	NULL	913	NULL	NULL	NULL
70	457	457	706007	0	Produit perf 706007	2018-01-01 00:00:00	NULL	NULL	NULL	FP457	NULL	Vente perf 457	0.00	52.28	1	0	0	0	NULL	0	0	NULL	914	NULL	NULL	NULL
70	46	46	411001	0	A Divers	2018-04-08 00:00:00	NULL	NULL	NULL	FP46	NULL	Vente perf 46	685.85	0.00	1	0	0	0	NULL	0	0	NULL	91	NULL	NULL	NULL
70	46	46	707101	0	Produit perf 707101	2018-04-08 00:00:00	NULL	NULL	NULL	FP46	NULL	Vente perf 46	0.00	685.85	1	0	0	0	NULL	0	0	NULL	92	NULL	NULL	NULL
70	460	460	411001	0	A Divers	2018-04-22 00:00:00	NULL	NULL	NULL	FP460	NULL	Vente perf 460	163.67	0.00	1	0	0	0	NULL	0	0	NULL	919	NULL	NULL	NULL
70	460	460	706010	0	Produit perf 706010	2018-04-22 00:00:00	NULL	NULL	NULL	FP460	NULL	Vente perf 460	0.00	163.67	1	0	0	0	NULL	0	0	NULL	920	NULL	NULL	NULL
70	463	463	411001	0	A Divers	2018-01-15 00:00:00	NULL	NULL	NULL	FP463	NULL	Vente perf 463	274.06	0.00	1	0	0	0	NULL	0	0	NULL	925	NULL	NULL	NULL
70	463	463	706013	0	Produit perf 706013	2018-01-15 00:00:00	NULL	NULL	NULL	FP463	NULL	Vente perf 463	0.00	274.06	1	0	0	0	NULL	0	0	NULL	926	NULL	NULL	NULL
70	466	466	411001	0	A Divers	2018-04-08 00:00:00	NULL	NULL	NULL	FP466	NULL	Vente perf 466	385.45	0.00	1	0	0	0	NULL	0	0	NULL	931	NULL	NULL	NULL
70	466	466	707101	0	Produit perf 707101	2018-04-08 00:00:00	NULL	NULL	NULL	FP466	NULL	Vente perf 466	0.00	385.45	1	0	0	0	NULL	0	0	NULL	932	NULL	NULL	NULL
70	469	469	411001	0	A Divers	2018-01-01 00:00:00	NULL	NULL	NULL	FP469	NULL	Vente perf 469	496.84	0.00	1	0	0	0	NULL	0	0	NULL	937	NULL	NULL	NULL
70	469	469	707104	0	Produit perf 707104	2018-01-01 00:00:00	NULL	NULL	NULL	FP469	NULL	Vente perf 469	0.00	496.84	1	0	0	0	NULL	0	0	NULL	938	NULL	NULL	NULL
70	472	472	411001	0	A Divers	2018-04-22 00:00:00	NULL	NULL	NULL	FP472	NULL	Vente perf 472	607.23	0.00	1	0	0	0	NULL	0	0	NULL	943	NULL	NULL	NULL
70	472	472	707107	0	Produit perf 707107	2018-04-22 00:00:00	NULL	NULL	NULL	FP472	NULL	Vente perf 472	0.00	607.23	1	0	0	0	NULL	0	0	NULL	944	NULL	NULL	NULL
70	475	475	411001	0	A Divers	2018-01-15 00:00:00	NULL	NULL	NULL	FP475	NULL	Vente perf 475	718.62	0.00	1	0	0	0	NULL	0	0	NULL	949	NULL	NULL	NULL
70	475	475	707110	0	Produit perf 707110	2018-01-15 00:00:00	NULL	NULL	NULL	FP475	NULL	Vente perf 475	0.00	718.62	1	0	0	0	NULL	0	0	NULL	950	NULL	NULL	NULL
70	478	478	411001	0	A Divers	2018-04-08 00:00:00	NULL	NULL	NULL	FP478	NULL	Vente perf 478	829.01	0.00	1	0	0	0	NULL	0	0	NULL	955	NULL	NULL	NULL
70	478	478	707113	0	Produit perf 707113	2018-04-08 00:00:00	NULL	NULL	NULL	FP478	NULL	Vente perf 478	0.00	829.01	1	0	0	0	NULL	0	0	NULL	956	NULL	NULL	NULL
70	481	481	411001	0	A Divers	2018-01-01 00:00:00	NULL	NULL	NULL	FP481	NULL	Vente perf 481	940.40	0.00	1	0	0	0	NULL	0	0	NULL	961	NULL	NULL	NULL
70	481	481	706001	0	Produit perf 706001	2018-01-01 00:00:00	NULL	NULL	NULL	FP481	NULL	Vente perf 481	0.00	940.40	1	0	0	0	NULL	0	0	NULL	962	NULL	NULL	NULL
70	484	484	411001	0	A Divers	2018-04-22 00:00:00	NULL	NULL	NULL	FP484	NULL	Vente perf 484	61.79	0.00	1	0	0	0	NULL	0	0	NULL	967	NULL	NULL	NULL
70	484	484	706004	0	Produit perf 706004	2018-04-22 00:00:00	NULL	NULL	NULL	FP484	NULL	Vente perf 484	0.00	61.79	1	0	0	0	NULL	0	0	NULL	968	NULL	NULL	NULL
70	487	487	411001	0	A Divers	2018-01-15 00:00:00	NULL	NULL	NULL	FP487	NULL	Vente perf 487	172.18	0.00	1	0	0	0	NULL	0	0	NULL	973	NULL	NULL	NULL
70	487	487	706007	0	Produit perf 706007	2018-01-15 00:00:00	NULL	NULL	NULL	FP487	NULL	Vente perf 487	0.00	172.18	1	0	0	0	NULL	0	0	NULL	974	NULL	NULL	NULL
70	49	49	411001	0	A Divers	2018-01-01 00:00:00	NULL	NULL	NULL	FP49	NULL	Vente perf 49	796.24	0.00	1	0	0	0	NULL	0	0	NULL	97	NULL	NULL	NULL
70	49	49	707104	0	Produit perf 707104	2018-01-01 00:00:00	NULL	NULL	NULL	FP49	NULL	Vente perf 49	0.00	796.24	1	0	0	0	NULL	0	0	NULL	98	NULL	NULL	NULL
70	490	490	411001	0	A Divers	2018-04-08 00:00:00	NULL	NULL	NULL	FP490	NULL	Vente perf 490	283.57	0.00	1	0	0	0	NULL	0	0	NULL	979	NULL	NULL	NULL
70	490	490	706010	0	Produit perf 706010	2018-04-08 00:00:00	NULL	NULL	NULL	FP490	NULL	Vente perf 490	0.00	283.57	1	0	0	0	NULL	0	0	NULL	980	NULL	NULL	NULL
70	493	493	411001	0	A Divers	2018-01-01 00:00:00	NULL	NULL	NULL	FP493	NULL	Vente perf 493	394.96	0.00	1	0	0	0	NULL	0	0	NULL	985	NULL	NULL	NULL
70	493	493	706013	0	Produit perf 706013	2018-01-01 00:00:00	NULL	NULL	NULL	FP493	NULL	Vente perf 493	0.00	394.96	1	0	0	0	NULL	0	0	NULL	986	NULL	NULL	NULL
70	496	496	411001	0	A Divers	2018-04-22 00:00:00	NULL	NULL	NULL	FP496	NULL	Vente perf 496	505.35	0.00	1	0	0	0	NULL	0	0	NULL	991	NULL	NULL	NULL
70	496	496	707101	0	Produit perf 707101	2018-04-22 00:00:00	NULL	NULL	NULL	FP496	NULL	Vente perf 496	0.00	505.35	1	0	0	0	NULL	0	0	NULL	992	NULL	NULL	NULL
70	499	499	411001	0	A Divers	2018-01-15 00:00:00	NULL	NULL	NULL	FP499	NULL	Vente perf 499	616.74	0.00	1	0	0	0	NULL	0	0	NULL	997	NULL	NULL	NULL
70	499	499	707104	0	Produit perf 707104	2018-01-15 00:00:00	NULL	NULL	NULL	FP499	NULL	Vente perf 499	0.00	616.74	1	0	0	0	NULL	0	0	NULL	998	NULL	NULL	NULL
70	52	52	411001	0	A Divers	2018-04-22 00:00:00	NULL	NULL	NULL	FP52	NULL	Vente perf 52	907.63	0.00	1	0	0	0	NULL	0	0	NULL	103	NULL	NULL	NULL
70	52	52	707107	0	Produit perf 707107	2018-04-22 00:00:00	NULL	NULL	NULL	FP52	NULL	Vente perf 52	0.00	907.63	1	0	0	0	NULL	0	0	NULL	104	NULL	NULL	NULL
70	55	55	411001	0	A Divers	2018-01-15 00:00:00	NULL	NULL	NULL	FP55	NULL	Vente perf 55	28.02	0.00	1	0	0	0	NULL	0	0	NULL	109	NULL	NULL	NULL
70	55	55	707110	0	Produit perf 707110	2018-01-15 00:00:00	NULL	NULL	NULL	FP55	NULL	Vente perf 55	0.00	28.02	1	0	0	0	NULL	0	0	NULL	110	NULL	NULL	NULL
70	58	58	411001	0	A Divers	2018-04-08 00:00:00	NULL	NULL	NULL	FP58	NULL	Vente perf 58	139.41	0.00	1	0	0	0	NULL	0	0	NULL	115	NULL	NULL	NULL
70	58	58	707113	0	Produit perf 707113	2018-04-08 00:00:00	NULL	NULL	NULL	FP58	NULL	Vente perf 58	0.00	139.41	1	0	0	0	NULL	0	0	NULL	116	NULL	NULL	NULL
70	61	61	411001	0	A Divers	2018-01-01 00:00:00	NULL	NULL	NULL	FP61	NULL	Vente perf 61	250.80	0.00	1	0	0	0	NULL	0	0	NULL	121	NULL	NULL	NULL
70	61	61	706001	0	Produit perf 706001	2018-01-01 00:00:00	NULL	NULL	NULL	FP61	NULL	Vente perf 61	0.00	250.80	1	0	0	0	NULL	0	0	NULL	122	NULL	NULL	NULL
70	64	64	411001	0	A Divers	2018-04-22 00:00:00	NULL	NULL	NULL	FP64	NULL	Vente perf 64	361.19	0.00	1	0	0	0	NULL	0	0	NULL	127	NULL	NULL	NULL
70	64	64	706004	0	Produit perf 706004	2018-04-22 00:00:00	NULL	NULL	NULL	FP64	NULL	Vente perf 64	0.00	361.19	1	0	0	0	NULL	0	0	NULL	128	NULL	NULL	NULL
70	67	67	411001	0	A Divers	2018-01-15 00:00:00	NULL	NULL	NULL	FP67	NULL	Vente perf 67	472.58	0.00	1	0	0	0	NULL	0	0	NULL	133	NULL	NULL	NULL
70	67	67	706007	0	Produit perf 706007	2018-01-15 00:00:00	NULL	NULL	NULL	FP67	NULL	Vente perf 67	0.00	472.58	1	0	0	0	NULL	0	0	NULL	134	NULL	NULL	NULL
70	7	7	411001	0	A Divers	2018-01-15 00:00:00	NULL	NULL	NULL	FP7	NULL	Vente perf 7	232.78	0.00	1	0	0	0	NULL	0	0	NULL	13	NULL	NULL	NULL
70	7	7	706007	0	Produit perf 706007	2018-01-15 00:00:00	NULL	NULL	NULL	FP7	NULL	Vente perf 7	0.00	232.78	1	0	0	0	NULL	0	0	NULL	14	NULL	NULL	NULL
70	70	70	411001	0	A Divers	2018-04-08 00:00:00	NULL	NULL	NULL	FP70	NULL	Vente perf 70	583.97	0.00	1	0	0	0	NULL	0	0	NULL	139	NULL	NULL	NULL
70	70	70	706010	0	Produit perf 706010	2018-04-08 00:00:00	NULL	NULL	NULL	FP70	NULL	Vente perf 70	0.00	583.97	1	0	0	0	NULL	0	0	NULL	140	NULL	NULL	NULL
70	73	73	411001	0	A Divers	2018-01-01 00:00:00	NULL	NULL	NULL	FP73	NULL	Vente perf 73	694.36	0.00	1	0	0	0	NULL	0	0	NULL	145	NULL	NULL	NULL
70	73	73	706013	0	Produit perf 706013	2018-01-01 00:00:00	NULL	NULL	NULL	FP73	NULL	Vente perf 73	0.00	694.36	1	0	0	0	NULL	0	0	NULL	146	NULL	NULL	NULL
70	76	76	411001	0	A Divers	2018-04-22 00:00:00	NULL	NULL	NULL	FP76	NULL	Vente perf 76	805.75	0.00	1	0	0	0	NULL	0	0	NULL	151	NULL	NULL	NULL
70	76	76	707101	0	Produit perf 707101	2018-04-22 00:00:00	NULL	NULL	NULL	FP76	NULL	Vente perf 76	0.00	805.75	1	0	0	0	NULL	0	0	NULL	152	NULL	NULL	NULL
70	79	79	411001	0	A Divers	2018-01-15 00:00:00	NULL	NULL	NULL	FP79	NULL	Vente perf 79	916.14	0.00	1	0	0	0	NULL	0	0	NULL	157	NULL	NULL	NULL
70	79	79	707104	0	Produit perf 707104	2018-01-15 00:00:00	NULL	NULL	NULL	FP79	NULL	Vente perf 79	0.00	916.14	1	0	0	0	NULL	0	0	NULL	158	NULL	NULL	NULL
70	82	82	411001	0	A Divers	2018-04-08 00:00:00	NULL	NULL	NULL	FP82	NULL	Vente perf 82	37.53	0.00	1	0	0	0	NULL	0	0	NULL	163	NULL	NULL	NULL
70	82	82	707107	0	Produit perf 707107	2018-04-08 00:00:00	NULL	NULL	NULL	FP82	NULL	Vente perf 82	0.00	37.53	1	0	0	0	NULL	0	0	NULL	164	NULL	NULL	NULL
70	85	85	411001	0	A Divers	2018-01-01 00:00:00	NULL	NULL	NULL	FP85	NULL	Vente perf 85	148.92	0.00	1	0	0	0	NULL	0	0	NULL	169	NULL	NULL	NULL
70	85	85	707110	0	Produit perf 707110	2018-01-01 00:00:00	NULL	NULL	NULL	FP85	NULL	Vente perf 85	0.00	148.92	1	0	0	0	NULL	0	0	NULL	170	NULL	NULL	NULL
70	88	88	411001	0	A Divers	2018-04-22 00:00:00	NULL	NULL	NULL	FP88	NULL	Vente perf 88	259.31	0.00	1	0	0	0	NULL	0	0	NULL	175	NULL	NULL	NULL
70	88	88	707113	0	Produit perf 707113	2018-04-22 00:00:00	NULL	NULL	NULL	FP88	NULL	Vente perf 88	0.00	259.31	1	0	0	0	NULL	0	0	NULL	176	NULL	NULL	NULL
70	91	91	411001	0	A Divers	2018-01-15 00:00:00	NULL	NULL	NULL	FP91	NULL	Vente perf 91	370.70	0.00	1	0	0	0	NULL	0	0	NULL	181	NULL	NULL	NULL
70	91	91	706001	0	Produit perf 706001	2018-01-15 00:00:00	NULL	NULL	NULL	FP91	NULL	Vente perf 91	0.00	370.70	1	0	0	0	NULL	0	0	NULL	182	NULL	NULL	NULL
70	94	94	411001	0	A Divers	2018-04-08 00:00:00	NULL	NULL	NULL	FP94	NULL	Vente perf 94	481.09	0.00	1	0	0	0	NULL	0	0	NULL	187	NULL	NULL	NULL
70	94	94	706004	0	Produit perf 706004	2018-04-08 00:00:00	NULL	NULL	NULL	FP94	NULL	Vente perf 94	0.00	481.09	1	0	0	0	NULL	0	0	NULL	188	NULL	NULL	NULL
70	97	97	411001	0	A Divers	2018-01-01 00:00:00	NULL	NULL	NULL	FP97	NULL	Vente perf 97	592.48	0.00	1	0	0	0	NULL	0	0	NULL	193	NULL	NULL	NULL
70	97	97	706007	0	Produit perf 706007	2018-01-01 00:00:00	NULL	NULL	NULL	FP97	NULL	Vente perf 97	0.00	592.48	1	0	0	0	NULL	0	0	NULL	194	NULL	NULL	NULL
## Fiches_Mvt1 (jour	numero	compte	collectif	intitule	dte	datee	numdoc	numlot	libelle	montantd	montantc	validee	provisoire	tresorerie	pointee	nrlv	lettree	cloturee	relance	control	numerodef	dateech	numcol	dteval	export	lind)
60	1002	401001	0	A Divers	2017-02-08 00:00:00	NULL	AP1002	NULL	Achat perf 1002	0.00	47.13	1	0	0	0	NULL	0	0	NULL	NULL	1002	NULL	NULL	NULL	NULL	4
60	1002	601002	0	Charge perf 601002	2017-02-08 00:00:00	NULL	AP1002	NULL	Achat perf 1002	47.13	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1002	NULL	NULL	NULL	NULL	3
60	1003	401001	0	A Divers	2017-03-15 00:00:00	NULL	AP1003	NULL	Achat perf 1003	0.00	84.26	1	0	0	0	NULL	0	0	NULL	NULL	1003	NULL	NULL	NULL	NULL	6
60	1003	601003	0	Charge perf 601003	2017-03-15 00:00:00	NULL	AP1003	NULL	Achat perf 1003	84.26	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1003	NULL	NULL	NULL	NULL	5
60	1005	401001	0	A Divers	2017-05-01 00:00:00	NULL	AP1005	NULL	Achat perf 1005	0.00	158.52	1	0	0	0	NULL	0	0	NULL	NULL	1005	NULL	NULL	NULL	NULL	10
60	1005	601005	0	Charge perf 601005	2017-05-01 00:00:00	NULL	AP1005	NULL	Achat perf 1005	158.52	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1005	NULL	NULL	NULL	NULL	9
60	1006	401001	0	A Divers	2017-06-08 00:00:00	NULL	AP1006	NULL	Achat perf 1006	0.00	195.65	1	0	0	0	NULL	0	0	NULL	NULL	1006	NULL	NULL	NULL	NULL	12
60	1006	601006	0	Charge perf 601006	2017-06-08 00:00:00	NULL	AP1006	NULL	Achat perf 1006	195.65	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1006	NULL	NULL	NULL	NULL	11
60	1008	401001	0	A Divers	2017-08-22 00:00:00	NULL	AP1008	NULL	Achat perf 1008	0.00	269.91	1	0	0	0	NULL	0	0	NULL	NULL	1008	NULL	NULL	NULL	NULL	16
60	1008	601008	0	Charge perf 601008	2017-08-22 00:00:00	NULL	AP1008	NULL	Achat perf 1008	269.91	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1008	NULL	NULL	NULL	NULL	15
60	1009	401001	0	A Divers	2017-09-01 00:00:00	NULL	AP1009	NULL	Achat perf 1009	0.00	306.04	1	0	0	0	NULL	0	0	NULL	NULL	1009	NULL	NULL	NULL	NULL	18
60	1009	601009	0	Charge perf 601009	2017-09-01 00:00:00	NULL	AP1009	NULL	Achat perf 1009	306.04	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1009	NULL	NULL	NULL	NULL	17
60	1011	401001	0	A Divers	2017-11-15 00:00:00	NULL	AP1011	NULL	Achat perf 1011	0.00	380.30	1	0	0	0	NULL	0	0	NULL	NULL	1011	NULL	NULL	NULL	NULL	22
60	1011	601011	0	Charge perf 601011	2017-11-15 00:00:00	NULL	AP1011	NULL	Achat perf 1011	380.30	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1011	NULL	NULL	NULL	NULL	21
60	1012	401001	0	A Divers	2017-12-22 00:00:00	NULL	AP1012	NULL	Achat perf 1012	0.00	417.43	1	0	0	0	NULL	0	0	NULL	NULL	1012	NULL	NULL	NULL	NULL	24
60	1012	601012	0	Charge perf 601012	2017-12-22 00:00:00	NULL	AP1012	NULL	Achat perf 1012	417.43	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1012	NULL	NULL	NULL	NULL	23
60	1014	401001	0	A Divers	2017-02-08 00:00:00	NULL	AP1014	NULL	Achat perf 1014	0.00	491.69	1	0	0	0	NULL	0	0	NULL	NULL	1014	NULL	NULL	NULL	NULL	28
60	1014	601014	0	Charge perf 601014	2017-02-08 00:00:00	NULL	AP1014	NULL	Achat perf 1014	491.69	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1014	NULL	NULL	NULL	NULL	27
60	1015	401001	0	A Divers	2017-03-15 00:00:00	NULL	AP1015	NULL	Achat perf 1015	0.00	528.82	1	0	0	0	NULL	0	0	NULL	NULL	1015	NULL	NULL	NULL	NULL	30
60	1015	601015	0	Charge perf 601015	2017-03-15 00:00:00	NULL	AP1015	NULL	Achat perf 1015	528.82	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1015	NULL	NULL	NULL	NULL	29
60	1017	401001	0	A Divers	2017-05-01 00:00:00	NULL	AP1017	NULL	Achat perf 1017	0.00	602.08	1	0	0	0	NULL	0	0	NULL	NULL	1017	NULL	NULL	NULL	NULL	34
60	1017	601017	0	Charge perf 601017	2017-05-01 00:00:00	NULL	AP1017	NULL	Achat perf 1017	602.08	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1017	NULL	NULL	NULL	NULL	33
60	1018	401001	0	A Divers	2017-06-08 00:00:00	NULL	AP1018	NULL	Achat perf 1018	0.00	639.21	1	0	0	0	NULL	0	0	NULL	NULL	1018	NULL	NULL	NULL	NULL	36
60	1018	601018	0	Charge perf 601018	2017-06-08 00:00:00	NULL	AP1018	NULL	Achat perf 1018	639.21	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1018	NULL	NULL	NULL	NULL	35
60	1020	401001	0	A Divers	2017-08-22 00:00:00	NULL	AP1020	NULL	Achat perf 1020	0.00	713.47	1	0	0	0	NULL	0	0	NULL	NULL	1020	NULL	NULL	NULL	NULL	40
60	1020	601020	0	Charge perf 601020	2017-08-22 00:00:00	NULL	AP1020	NULL	Achat perf 1020	713.47	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1020	NULL	NULL	NULL	NULL	39
60	1021	401001	0	A Divers	2017-09-01 00:00:00	NULL	AP1021	NULL	Achat perf 1021	0.00	750.60	1	0	0	0	NULL	0	0	NULL	NULL	1021	NULL	NULL	NULL	NULL	42
60	1021	606101	0	Charge perf 606101	2017-09-01 00:00:00	NULL	AP1021	NULL	Achat perf 1021	750.60	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1021	NULL	NULL	NULL	NULL	41
60	1023	401001	0	A Divers	2017-11-15 00:00:00	NULL	AP1023	NULL	Achat perf 1023	0.00	824.86	1	0	0	0	NULL	0	0	NULL	NULL	1023	NULL	NULL	NULL	NULL	46
60	1023	606103	0	Charge perf 606103	2017-11-15 00:00:00	NULL	AP1023	NULL	Achat perf 1023	824.86	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1023	NULL	NULL	NULL	NULL	45
60	1024	401001	0	A Divers	2017-12-22 00:00:00	NULL	AP1024	NULL	Achat perf 1024	0.00	861.99	1	0	0	0	NULL	0	0	NULL	NULL	1024	NULL	NULL	NULL	NULL	48
60	1024	606104	0	Charge perf 606104	2017-12-22 00:00:00	NULL	AP1024	NULL	Achat perf 1024	861.99	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1024	NULL	NULL	NULL	NULL	47
60	1026	401001	0	A Divers	2017-02-08 00:00:00	NULL	AP1026	NULL	Achat perf 1026	0.00	935.25	1	0	0	0	NULL	0	0	NULL	NULL	1026	NULL	NULL	NULL	NULL	52
60	1026	606106	0	Charge perf 606106	2017-02-08 00:00:00	NULL	AP1026	NULL	Achat perf 1026	935.25	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1026	NULL	NULL	NULL	NULL	51
60	1027	401001	0	A Divers	2017-03-15 00:00:00	NULL	AP1027	NULL	Achat perf 1027	0.00	972.38	1	0	0	0	NULL	0	0	NULL	NULL	1027	NULL	NULL	NULL	NULL	54
60	1027	606107	0	Charge perf 606107	2017-03-15 00:00:00	NULL	AP1027	NULL	Achat perf 1027	972.38	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1027	NULL	NULL	NULL	NULL	53
60	1029	401001	0	A Divers	2017-05-01 00:00:00	NULL	AP1029	NULL	Achat perf 1029	0.00	56.64	1	0	0	0	NULL	0	0	NULL	NULL	1029	NULL	NULL	NULL	NULL	58
60	1029	606109	0	Charge perf 606109	2017-05-01 00:00:00	NULL	AP1029	NULL	Achat perf 1029	56.64	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1029	NULL	NULL	NULL	NULL	57
60	1030	401001	0	A Divers	2017-06-08 00:00:00	NULL	AP1030	NULL	Achat perf 1030	0.00	93.77	1	0	0	0	NULL	0	0	NULL	NULL	1030	NULL	NULL	NULL	NULL	60
60	1030	606110	0	Charge perf 606110	2017-06-08 00:00:00	NULL	AP1030	NULL	Achat perf 1030	93.77	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1030	NULL	NULL	NULL	NULL	59
60	1032	401001	0	A Divers	2017-08-22 00:00:00	NULL	AP1032	NULL	Achat perf 1032	0.00	167.03	1	0	0	0	NULL	0	0	NULL	NULL	1032	NULL	NULL	NULL	NULL	64
60	1032	606112	0	Charge perf 606112	2017-08-22 00:00:00	NULL	AP1032	NULL	Achat perf 1032	167.03	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1032	NULL	NULL	NULL	NULL	63
60	1033	401001	0	A Divers	2017-09-01 00:00:00	NULL	AP1033	NULL	Achat perf 1033	0.00	204.16	1	0	0	0	NULL	0	0	NULL	NULL	1033	NULL	NULL	NULL	NULL	66
60	1033	606113	0	Charge perf 606113	2017-09-01 00:00:00	NULL	AP1033	NULL	Achat perf 1033	204.16	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1033	NULL	NULL	NULL	NULL	65
60	1035	401001	0	A Divers	2017-11-15 00:00:00	NULL	AP1035	NULL	Achat perf 1035	0.00	278.42	1	0	0	0	NULL	0	0	NULL	NULL	1035	NULL	NULL	NULL	NULL	70
60	1035	606115	0	Charge perf 606115	2017-11-15 00:00:00	NULL	AP1035	NULL	Achat perf 1035	278.42	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1035	NULL	NULL	NULL	NULL	69
60	1036	401001	0	A Divers	2017-12-22 00:00:00	NULL	AP1036	NULL	Achat perf 1036	0.00	315.55	1	0	0	0	NULL	0	0	NULL	NULL	1036	NULL	NULL	NULL	NULL	72
60	1036	606116	0	Charge perf 606116	2017-12-22 00:00:00	NULL	AP1036	NULL	Achat perf 1036	315.55	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1036	NULL	NULL	NULL	NULL	71
60	1038	401001	0	A Divers	2017-02-08 00:00:00	NULL	AP1038	NULL	Achat perf 1038	0.00	389.81	1	0	0	0	NULL	0	0	NULL	NULL	1038	NULL	NULL	NULL	NULL	76
60	1038	606118	0	Charge perf 606118	2017-02-08 00:00:00	NULL	AP1038	NULL	Achat perf 1038	389.81	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1038	NULL	NULL	NULL	NULL	75
60	1039	401001	0	A Divers	2017-03-15 00:00:00	NULL	AP1039	NULL	Achat perf 1039	0.00	426.94	1	0	0	0	NULL	0	0	NULL	NULL	1039	NULL	NULL	NULL	NULL	78
60	1039	606119	0	Charge perf 606119	2017-03-15 00:00:00	NULL	AP1039	NULL	Achat perf 1039	426.94	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1039	NULL	NULL	NULL	NULL	77
60	1041	401001	0	A Divers	2017-05-01 00:00:00	NULL	AP1041	NULL	Achat perf 1041	0.00	500.20	1	0	0	0	NULL	0	0	NULL	NULL	1041	NULL	NULL	NULL	NULL	82
60	1041	613101	0	Charge perf 613101	2017-05-01 00:00:00	NULL	AP1041	NULL	Achat perf 1041	500.20	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1041	NULL	NULL	NULL	NULL	81
60	1042	401001	0	A Divers	2017-06-08 00:00:00	NULL	AP1042	NULL	Achat perf 1042	0.00	537.33	1	0	0	0	NULL	0	0	NULL	NULL	1042	NULL	NULL	NULL	NULL	84
60	1042	613102	0	Charge perf 613102	2017-06-08 00:00:00	NULL	AP1042	NULL	Achat perf 1042	537.33	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1042	NULL	NULL	NULL	NULL	83
60	1044	401001	0	A Divers	2017-08-22 00:00:00	NULL	AP1044	NULL	Achat perf 1044	0.00	611.59	1	0	0	0	NULL	0	0	NULL	NULL	1044	NULL	NULL	NULL	NULL	88
60	1044	613104	0	Charge perf 613104	2017-08-22 00:00:00	NULL	AP1044	NULL	Achat perf 1044	611.59	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1044	NULL	NULL	NULL	NULL	87
60	1045	401001	0	A Divers	2017-09-01 00:00:00	NULL	AP1045	NULL	Achat perf 1045	0.00	648.72	1	0	0	0	NULL	0	0	NULL	NULL	1045	NULL	NULL	NULL	NULL	90
60	1045	613105	0	Charge perf 613105	2017-09-01 00:00:00	NULL	AP1045	NULL	Achat perf 1045	648.72	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1045	NULL	NULL	NULL	NULL	89
60	1047	401001	0	A Divers	2017-11-15 00:00:00	NULL	AP1047	NULL	Achat perf 1047	0.00	722.98	1	0	0	0	NULL	0	0	NULL	NULL	1047	NULL	NULL	NULL	NULL	94
60	1047	613107	0	Charge perf 613107	2017-11-15 00:00:00	NULL	AP1047	NULL	Achat perf 1047	722.98	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1047	NULL	NULL	NULL	NULL	93
60	1048	401001	0	A Divers	2017-12-22 00:00:00	NULL	AP1048	NULL	Achat perf 1048	0.00	759.11	1	0	0	0	NULL	0	0	NULL	NULL	1048	NULL	NULL	NULL	NULL	96
60	1048	613108	0	Charge perf 613108	2017-12-22 00:00:00	NULL	AP1048	NULL	Achat perf 1048	759.11	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1048	NULL	NULL	NULL	NULL	95
60	1050	401001	0	A Divers	2017-02-08 00:00:00	NULL	AP1050	NULL	Achat perf 1050	0.00	833.37	1	0	0	0	NULL	0	0	NULL	NULL	1050	NULL	NULL	NULL	NULL	100
60	1050	613110	0	Charge perf 613110	2017-02-08 00:00:00	NULL	AP1050	NULL	Achat perf 1050	833.37	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1050	NULL	NULL	NULL	NULL	99
60	1051	401001	0	A Divers	2017-03-15 00:00:00	NULL	AP1051	NULL	Achat perf 1051	0.00	870.50	1	0	0	0	NULL	0	0	NULL	NULL	1051	NULL	NULL	NULL	NULL	102
60	1051	613111	0	Charge perf 613111	2017-03-15 00:00:00	NULL	AP1051	NULL	Achat perf 1051	870.50	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1051	NULL	NULL	NULL	NULL	101
60	1053	401001	0	A Divers	2017-05-01 00:00:00	NULL	AP1053	NULL	Achat perf 1053	0.00	944.76	1	0	0	0	NULL	0	0	NULL	NULL	1053	NULL	NULL	NULL	NULL	106
60	1053	613113	0	Charge perf 613113	2017-05-01 00:00:00	NULL	AP1053	NULL	Achat perf 1053	944.76	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1053	NULL	NULL	NULL	NULL	105
60	1054	401001	0	A Divers	2017-06-08 00:00:00	NULL	AP1054	NULL	Achat perf 1054	0.00	981.89	1	0	0	0	NULL	0	0	NULL	NULL	1054	NULL	NULL	NULL	NULL	108
60	1054	613114	0	Charge perf 613114	2017-06-08 00:00:00	NULL	AP1054	NULL	Achat perf 1054	981.89	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1054	NULL	NULL	NULL	NULL	107
60	1056	401001	0	A Divers	2017-08-22 00:00:00	NULL	AP1056	NULL	Achat perf 1056	0.00	65.15	1	0	0	0	NULL	0	0	NULL	NULL	1056	NULL	NULL	NULL	NULL	112
60	1056	613116	0	Charge perf 613116	2017-08-22 00:00:00	NULL	AP1056	NULL	Achat perf 1056	65.15	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1056	NULL	NULL	NULL	NULL	111
60	1057	401001	0	A Divers	2017-09-01 00:00:00	NULL	AP1057	NULL	Achat perf 1057	0.00	102.28	1	0	0	0	NULL	0	0	NULL	NULL	1057	NULL	NULL	NULL	NULL	114
60	1057	613117	0	Charge perf 613117	2017-09-01 00:00:00	NULL	AP1057	NULL	Achat perf 1057	102.28	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1057	NULL	NULL	NULL	NULL	113
60	1059	401001	0	A Divers	2017-11-15 00:00:00	NULL	AP1059	NULL	Achat perf 1059	0.00	176.54	1	0	0	0	NULL	0	0	NULL	NULL	1059	NULL	NULL	NULL	NULL	118
60	1059	613119	0	Charge perf 613119	2017-11-15 00:00:00	NULL	AP1059	NULL	Achat perf 1059	176.54	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1059	NULL	NULL	NULL	NULL	117
60	1060	401001	0	A Divers	2017-12-22 00:00:00	NULL	AP1060	NULL	Achat perf 1060	0.00	213.67	1	0	0	0	NULL	0	0	NULL	NULL	1060	NULL	NULL	NULL	NULL	120
60	1060	613120	0	Charge perf 613120	2017-12-22 00:00:00	NULL	AP1060	NULL	Achat perf 1060	213.67	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1060	NULL	NULL	NULL	NULL	119
60	1062	401001	0	A Divers	2017-02-08 00:00:00	NULL	AP1062	NULL	Achat perf 1062	0.00	287.93	1	0	0	0	NULL	0	0	NULL	NULL	1062	NULL	NULL	NULL	NULL	124
60	1062	601002	0	Charge perf 601002	2017-02-08 00:00:00	NULL	AP1062	NULL	Achat perf 1062	287.93	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1062	NULL	NULL	NULL	NULL	123
60	1063	401001	0	A Divers	2017-03-15 00:00:00	NULL	AP1063	NULL	Achat perf 1063	0.00	324.06	1	0	0	0	NULL	0	0	NULL	NULL	1063	NULL	NULL	NULL	NULL	126
60	1063	601003	0	Charge perf 601003	2017-03-15 00:00:00	NULL	AP1063	NULL	Achat perf 1063	324.06	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1063	NULL	NULL	NULL	NULL	125
60	1065	401001	0	A Divers	2017-05-01 00:00:00	NULL	AP1065	NULL	Achat perf 1065	0.00	398.32	1	0	0	0	NULL	0	0	NULL	NULL	1065	NULL	NULL	NULL	NULL	130
60	1065	601005	0	Charge perf 601005	2017-05-01 00:00:00	NULL	AP1065	NULL	Achat perf 1065	398.32	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1065	NULL	NULL	NULL	NULL	129
60	1066	401001	0	A Divers	2017-06-08 00:00:00	NULL	AP1066	NULL	Achat perf 1066	0.00	435.45	1	0	0	0	NULL	0	0	NULL	NULL	1066	NULL	NULL	NULL	NULL	132
60	1066	601006	0	Charge perf 601006	2017-06-08 00:00:00	NULL	AP1066	NULL	Achat perf 1066	435.45	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1066	NULL	NULL	NULL	NULL	131
60	1068	401001	0	A Divers	2017-08-22 00:00:00	NULL	AP1068	NULL	Achat perf 1068	0.00	509.71	1	0	0	0	NULL	0	0	NULL	NULL	1068	NULL	NULL	NULL	NULL	136
60	1068	601008	0	Charge perf 601008	2017-08-22 00:00:00	NULL	AP1068	NULL	Achat perf 1068	509.71	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1068	NULL	NULL	NULL	NULL	135
60	1069	401001	0	A Divers	2017-09-01 00:00:00	NULL	AP1069	NULL	Achat perf 1069	0.00	546.84	1	0	0	0	NULL	0	0	NULL	NULL	1069	NULL	NULL	NULL	NULL	138
60	1069	601009	0	Charge perf 601009	2017-09-01 00:00:00	NULL	AP1069	NULL	Achat perf 1069	546.84	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1069	NULL	NULL	NULL	NULL	137
60	1071	401001	0	A Divers	2017-11-15 00:00:00	NULL	AP1071	NULL	Achat perf 1071	0.00	620.10	1	0	0	0	NULL	0	0	NULL	NULL	1071	NULL	NULL	NULL	NULL	142
60	1071	601011	0	Charge perf 601011	2017-11-15 00:00:00	NULL	AP1071	NULL	Achat perf 1071	620.10	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1071	NULL	NULL	NULL	NULL	141
60	1072	401001	0	A Divers	2017-12-22 00:00:00	NULL	AP1072	NULL	Achat perf 1072	0.00	657.23	1	0	0	0	NULL	0	0	NULL	NULL	1072	NULL	NULL	NULL	NULL	144
60	1072	601012	0	Charge perf 601012	2017-12-22 00:00:00	NULL	AP1072	NULL	Achat perf 1072	657.23	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1072	NULL	NULL	NULL	NULL	143
60	1074	401001	0	A Divers	2017-02-08 00:00:00	NULL	AP1074	NULL	Achat perf 1074	0.00	731.49	1	0	0	0	NULL	0	0	NULL	NULL	1074	NULL	NULL	NULL	NULL	148
60	1074	601014	0	Charge perf 601014	2017-02-08 00:00:00	NULL	AP1074	NULL	Achat perf 1074	731.49	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1074	NULL	NULL	NULL	NULL	147
60	1075	401001	0	A Divers	2017-03-15 00:00:00	NULL	AP1075	NULL	Achat perf 1075	0.00	768.62	1	0	0	0	NULL	0	0	NULL	NULL	1075	NULL	NULL	NULL	NULL	150
60	1075	601015	0	Charge perf 601015	2017-03-15 00:00:00	NULL	AP1075	NULL	Achat perf 1075	768.62	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1075	NULL	NULL	NULL	NULL	149
60	1077	401001	0	A Divers	2017-05-01 00:00:00	NULL	AP1077	NULL	Achat perf 1077	0.00	842.88	1	0	0	0	NULL	0	0	NULL	NULL	1077	NULL	NULL	NULL	NULL	154
60	1077	601017	0	Charge perf 601017	2017-05-01 00:00:00	NULL	AP1077	NULL	Achat perf 1077	842.88	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1077	NULL	NULL	NULL	NULL	153
60	1078	401001	0	A Divers	2017-06-08 00:00:00	NULL	AP1078	NULL	Achat perf 1078	0.00	879.01	1	0	0	0	NULL	0	0	NULL	NULL	1078	NULL	NULL	NULL	NULL	156
60	1078	601018	0	Charge perf 601018	2017-06-08 00:00:00	NULL	AP1078	NULL	Achat perf 1078	879.01	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1078	NULL	NULL	NULL	NULL	155
60	1080	401001	0	A Divers	2017-08-22 00:00:00	NULL	AP1080	NULL	Achat perf 1080	0.00	953.27	1	0	0	0	NULL	0	0	NULL	NULL	1080	NULL	NULL	NULL	NULL	160
60	1080	601020	0	Charge perf 601020	2017-08-22 00:00:00	NULL	AP1080	NULL	Achat perf 1080	953.27	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1080	NULL	NULL	NULL	NULL	159
60	1081	401001	0	A Divers	2017-09-01 00:00:00	NULL	AP1081	NULL	Achat perf 1081	0.00	990.40	1	0	0	0	NULL	0	0	NULL	NULL	1081	NULL	NULL	NULL	NULL	162
60	1081	606101	0	Charge perf 606101	2017-09-01 00:00:00	NULL	AP1081	NULL	Achat perf 1081	990.40	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1081	NULL	NULL	NULL	NULL	161
60	1083	401001	0	A Divers	2017-11-15 00:00:00	NULL	AP1083	NULL	Achat perf 1083	0.00	74.66	1	0	0	0	NULL	0	0	NULL	NULL	1083	NULL	NULL	NULL	NULL	166
60	1083	606103	0	Charge perf 606103	2017-11-15 00:00:00	NULL	AP1083	NULL	Achat perf 1083	74.66	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1083	NULL	NULL	NULL	NULL	165
60	1084	401001	0	A Divers	2017-12-22 00:00:00	NULL	AP1084	NULL	Achat perf 1084	0.00	111.79	1	0	0	0	NULL	0	0	NULL	NULL	1084	NULL	NULL	NULL	NULL	168
60	1084	606104	0	Charge perf 606104	2017-12-22 00:00:00	NULL	AP1084	NULL	Achat perf 1084	111.79	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1084	NULL	NULL	NULL	NULL	167
60	1086	401001	0	A Divers	2017-02-08 00:00:00	NULL	AP1086	NULL	Achat perf 1086	0.00	185.05	1	0	0	0	NULL	0	0	NULL	NULL	1086	NULL	NULL	NULL	NULL	172
60	1086	606106	0	Charge perf 606106	2017-02-08 00:00:00	NULL	AP1086	NULL	Achat perf 1086	185.05	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1086	NULL	NULL	NULL	NULL	171
60	1087	401001	0	A Divers	2017-03-15 00:00:00	NULL	AP1087	NULL	Achat perf 1087	0.00	222.18	1	0	0	0	NULL	0	0	NULL	NULL	1087	NULL	NULL	NULL	NULL	174
60	1087	606107	0	Charge perf 606107	2017-03-15 00:00:00	NULL	AP1087	NULL	Achat perf 1087	222.18	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1087	NULL	NULL	NULL	NULL	173
60	1089	401001	0	A Divers	2017-05-01 00:00:00	NULL	AP1089	NULL	Achat perf 1089	0.00	296.44	1	0	0	0	NULL	0	0	NULL	NULL	1089	NULL	NULL	NULL	NULL	178
60	1089	606109	0	Charge perf 606109	2017-05-01 00:00:00	NULL	AP1089	NULL	Achat perf 1089	296.44	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1089	NULL	NULL	NULL	NULL	177
60	1090	401001	0	A Divers	2017-06-08 00:00:00	NULL	AP1090	NULL	Achat perf 1090	0.00	333.57	1	0	0	0	NULL	0	0	NULL	NULL	1090	NULL	NULL	NULL	NULL	180
60	1090	606110	0	Charge perf 606110	2017-06-08 00:00:00	NULL	AP1090	NULL	Achat perf 1090	333.57	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1090	NULL	NULL	NULL	NULL	179
60	1092	401001	0	A Divers	2017-08-22 00:00:00	NULL	AP1092	NULL	Achat perf 1092	0.00	407.83	1	0	0	0	NULL	0	0	NULL	NULL	1092	NULL	NULL	NULL	NULL	184
60	1092	606112	0	Charge perf 606112	2017-08-22 00:00:00	NULL	AP1092	NULL	Achat perf 1092	407.83	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1092	NULL	NULL	NULL	NULL	183
60	1093	401001	0	A Divers	2017-09-01 00:00:00	NULL	AP1093	NULL	Achat perf 1093	0.00	444.96	1	0	0	0	NULL	0	0	NULL	NULL	1093	NULL	NULL	NULL	NULL	186
60	1093	606113	0	Charge perf 606113	2017-09-01 00:00:00	NULL	AP1093	NULL	Achat perf 1093	444.96	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1093	NULL	NULL	NULL	NULL	185
60	1095	401001	0	A Divers	2017-11-15 00:00:00	NULL	AP1095	NULL	Achat perf 1095	0.00	518.22	1	0	0	0	NULL	0	0	NULL	NULL	1095	NULL	NULL	NULL	NULL	190
60	1095	606115	0	Charge perf 606115	2017-11-15 00:00:00	NULL	AP1095	NULL	Achat perf 1095	518.22	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1095	NULL	NULL	NULL	NULL	189
60	1096	401001	0	A Divers	2017-12-22 00:00:00	NULL	AP1096	NULL	Achat perf 1096	0.00	555.35	1	0	0	0	NULL	0	0	NULL	NULL	1096	NULL	NULL	NULL	NULL	192
60	1096	606116	0	Charge perf 606116	2017-12-22 00:00:00	NULL	AP1096	NULL	Achat perf 1096	555.35	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1096	NULL	NULL	NULL	NULL	191
60	1098	401001	0	A Divers	2017-02-08 00:00:00	NULL	AP1098	NULL	Achat perf 1098	0.00	629.61	1	0	0	0	NULL	0	0	NULL	NULL	1098	NULL	NULL	NULL	NULL	196
60	1098	606118	0	Charge perf 606118	2017-02-08 00:00:00	NULL	AP1098	NULL	Achat perf 1098	629.61	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1098	NULL	NULL	NULL	NULL	195
60	1099	401001	0	A Divers	2017-03-15 00:00:00	NULL	AP1099	NULL	Achat perf 1099	0.00	666.74	1	0	0	0	NULL	0	0	NULL	NULL	1099	NULL	NULL	NULL	NULL	198
60	1099	606119	0	Charge perf 606119	2017-03-15 00:00:00	NULL	AP1099	NULL	Achat perf 1099	666.74	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1099	NULL	NULL	NULL	NULL	197
70	1001	411001	0	A Divers	2017-01-01 00:00:00	NULL	FP1001	NULL	Vente perf 1001	10.00	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1001	NULL	NULL	NULL	NULL	1
70	1001	706001	0	Produit perf 706001	2017-01-01 00:00:00	NULL	FP1001	NULL	Vente perf 1001	0.00	10.00	1	0	0	0	NULL	0	0	NULL	NULL	1001	NULL	NULL	NULL	NULL	2
70	1004	411001	0	A Divers	2017-04-22 00:00:00	NULL	FP1004	NULL	Vente perf 1004	121.39	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1004	NULL	NULL	NULL	NULL	7
70	1004	706004	0	Produit perf 706004	2017-04-22 00:00:00	NULL	FP1004	NULL	Vente perf 1004	0.00	121.39	1	0	0	0	NULL	0	0	NULL	NULL	1004	NULL	NULL	NULL	NULL	8
70	1007	411001	0	A Divers	2017-07-15 00:00:00	NULL	FP1007	NULL	Vente perf 1007	232.78	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1007	NULL	NULL	NULL	NULL	13
70	1007	706007	0	Produit perf 706007	2017-07-15 00:00:00	NULL	FP1007	NULL	Vente perf 1007	0.00	232.78	1	0	0	0	NULL	0	0	NULL	NULL	1007	NULL	NULL	NULL	NULL	14
70	1010	411001	0	A Divers	2017-10-08 00:00:00	NULL	FP1010	NULL	Vente perf 1010	343.17	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1010	NULL	NULL	NULL	NULL	19
70	1010	706010	0	Produit perf 706010	2017-10-08 00:00:00	NULL	FP1010	NULL	Vente perf 1010	0.00	343.17	1	0	0	0	NULL	0	0	NULL	NULL	1010	NULL	NULL	NULL	NULL	20
70	1013	411001	0	A Divers	2017-01-01 00:00:00	NULL	FP1013	NULL	Vente perf 1013	454.56	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1013	NULL	NULL	NULL	NULL	25
70	1013	706013	0	Produit perf 706013	2017-01-01 00:00:00	NULL	FP1013	NULL	Vente perf 1013	0.00	454.56	1	0	0	0	NULL	0	0	NULL	NULL	1013	NULL	NULL	NULL	NULL	26
70	1016	411001	0	A Divers	2017-04-22 00:00:00	NULL	FP1016	NULL	Vente perf 1016	565.95	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1016	NULL	NULL	NULL	NULL	31
70	1016	707101	0	Produit perf 707101	2017-04-22 00:00:00	NULL	FP1016	NULL	Vente perf 1016	0.00	565.95	1	0	0	0	NULL	0	0	NULL	NULL	1016	NULL	NULL	NULL	NULL	32
70	1019	411001	0	A Divers	2017-07-15 00:00:00	NULL	FP1019	NULL	Vente perf 1019	676.34	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1019	NULL	NULL	NULL	NULL	37
70	1019	707104	0	Produit perf 707104	2017-07-15 00:00:00	NULL	FP1019	NULL	Vente perf 1019	0.00	676.34	1	0	0	0	NULL	0	0	NULL	NULL	1019	NULL	NULL	NULL	NULL	38
70	1022	411001	0	A Divers	2017-10-08 00:00:00	NULL	FP1022	NULL	Vente perf 1022	787.73	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1022	NULL	NULL	NULL	NULL	43
70	1022	707107	0	Produit perf 707107	2017-10-08 00:00:00	NULL	FP1022	NULL	Vente perf 1022	0.00	787.73	1	0	0	0	NULL	0	0	NULL	NULL	1022	NULL	NULL	NULL	NULL	44
70	1025	411001	0	A Divers	2017-01-01 00:00:00	NULL	FP1025	NULL	Vente perf 1025	898.12	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1025	NULL	NULL	NULL	NULL	49
70	1025	707110	0	Produit perf 707110	2017-01-01 00:00:00	NULL	FP1025	NULL	Vente perf 1025	0.00	898.12	1	0	0	0	NULL	0	0	NULL	NULL	1025	NULL	NULL	NULL	NULL	50
70	1028	411001	0	A Divers	2017-04-22 00:00:00	NULL	FP1028	NULL	Vente perf 1028	19.51	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1028	NULL	NULL	NULL	NULL	55
70	1028	707113	0	Produit perf 707113	2017-04-22 00:00:00	NULL	FP1028	NULL	Vente perf 1028	0.00	19.51	1	0	0	0	NULL	0	0	NULL	NULL	1028	NULL	NULL	NULL	NULL	56
70	1031	411001	0	A Divers	2017-07-15 00:00:00	NULL	FP1031	NULL	Vente perf 1031	130.90	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1031	NULL	NULL	NULL	NULL	61
70	1031	706001	0	Produit perf 706001	2017-07-15 00:00:00	NULL	FP1031	NULL	Vente perf 1031	0.00	130.90	1	0	0	0	NULL	0	0	NULL	NULL	1031	NULL	NULL	NULL	NULL	62
70	1034	411001	0	A Divers	2017-10-08 00:00:00	NULL	FP1034	NULL	Vente perf 1034	241.29	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1034	NULL	NULL	NULL	NULL	67
70	1034	706004	0	Produit perf 706004	2017-10-08 00:00:00	NULL	FP1034	NULL	Vente perf 1034	0.00	241.29	1	0	0	0	NULL	0	0	NULL	NULL	1034	NULL	NULL	NULL	NULL	68
70	1037	411001	0	A Divers	2017-01-01 00:00:00	NULL	FP1037	NULL	Vente perf 1037	352.68	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1037	NULL	NULL	NULL	NULL	73
70	1037	706007	0	Produit perf 706007	2017-01-01 00:00:00	NULL	FP1037	NULL	Vente perf 1037	0.00	352.68	1	0	0	0	NULL	0	0	NULL	NULL	1037	NULL	NULL	NULL	NULL	74
70	1040	411001	0	A Divers	2017-04-22 00:00:00	NULL	FP1040	NULL	Vente perf 1040	463.07	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1040	NULL	NULL	NULL	NULL	79
70	1040	706010	0	Produit perf 706010	2017-04-22 00:00:00	NULL	FP1040	NULL	Vente perf 1040	0.00	463.07	1	0	0	0	NULL	0	0	NULL	NULL	1040	NULL	NULL	NULL	NULL	80
70	1043	411001	0	A Divers	2017-07-15 00:00:00	NULL	FP1043	NULL	Vente perf 1043	574.46	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1043	NULL	NULL	NULL	NULL	85
70	1043	706013	0	Produit perf 706013	2017-07-15 00:00:00	NULL	FP1043	NULL	Vente perf 1043	0.00	574.46	1	0	0	0	NULL	0	0	NULL	NULL	1043	NULL	NULL	NULL	NULL	86
70	1046	411001	0	A Divers	2017-10-08 00:00:00	NULL	FP1046	NULL	Vente perf 1046	685.85	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1046	NULL	NULL	NULL	NULL	91
70	1046	707101	0	Produit perf 707101	2017-10-08 00:00:00	NULL	FP1046	NULL	Vente perf 1046	0.00	685.85	1	0	0	0	NULL	0	0	NULL	NULL	1046	NULL	NULL	NULL	NULL	92
70	1049	411001	0	A Divers	2017-01-01 00:00:00	NULL	FP1049	NULL	Vente perf 1049	796.24	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1049	NULL	NULL	NULL	NULL	97
70	1049	707104	0	Produit perf 707104	2017-01-01 00:00:00	NULL	FP1049	NULL	Vente perf 1049	0.00	796.24	1	0	0	0	NULL	0	0	NULL	NULL	1049	NULL	NULL	NULL	NULL	98
70	1052	411001	0	A Divers	2017-04-22 00:00:00	NULL	FP1052	NULL	Vente perf 1052	907.63	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1052	NULL	NULL	NULL	NULL	103
70	1052	707107	0	Produit perf 707107	2017-04-22 00:00:00	NULL	FP1052	NULL	Vente perf 1052	0.00	907.63	1	0	0	0	NULL	0	0	NULL	NULL	1052	NULL	NULL	NULL	NULL	104
70	1055	411001	0	A Divers	2017-07-15 00:00:00	NULL	FP1055	NULL	Vente perf 1055	28.02	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1055	NULL	NULL	NULL	NULL	109
70	1055	707110	0	Produit perf 707110	2017-07-15 00:00:00	NULL	FP1055	NULL	Vente perf 1055	0.00	28.02	1	0	0	0	NULL	0	0	NULL	NULL	1055	NULL	NULL	NULL	NULL	110
70	1058	411001	0	A Divers	2017-10-08 00:00:00	NULL	FP1058	NULL	Vente perf 1058	139.41	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1058	NULL	NULL	NULL	NULL	115
70	1058	707113	0	Produit perf 707113	2017-10-08 00:00:00	NULL	FP1058	NULL	Vente perf 1058	0.00	139.41	1	0	0	0	NULL	0	0	NULL	NULL	1058	NULL	NULL	NULL	NULL	116
70	1061	411001	0	A Divers	2017-01-01 00:00:00	NULL	FP1061	NULL	Vente perf 1061	250.80	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1061	NULL	NULL	NULL	NULL	121
70	1061	706001	0	Produit perf 706001	2017-01-01 00:00:00	NULL	FP1061	NULL	Vente perf 1061	0.00	250.80	1	0	0	0	NULL	0	0	NULL	NULL	1061	NULL	NULL	NULL	NULL	122
70	1064	411001	0	A Divers	2017-04-22 00:00:00	NULL	FP1064	NULL	Vente perf 1064	361.19	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1064	NULL	NULL	NULL	NULL	127
70	1064	706004	0	Produit perf 706004	2017-04-22 00:00:00	NULL	FP1064	NULL	Vente perf 1064	0.00	361.19	1	0	0	0	NULL	0	0	NULL	NULL	1064	NULL	NULL	NULL	NULL	128
70	1067	411001	0	A Divers	2017-07-15 00:00:00	NULL	FP1067	NULL	Vente perf 1067	472.58	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1067	NULL	NULL	NULL	NULL	133
70	1067	706007	0	Produit perf 706007	2017-07-15 00:00:00	NULL	FP1067	NULL	Vente perf 1067	0.00	472.58	1	0	0	0	NULL	0	0	NULL	NULL	1067	NULL	NULL	NULL	NULL	134
70	1070	411001	0	A Divers	2017-10-08 00:00:00	NULL	FP1070	NULL	Vente perf 1070	583.97	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1070	NULL	NULL	NULL	NULL	139
70	1070	706010	0	Produit perf 706010	2017-10-08 00:00:00	NULL	FP1070	NULL	Vente perf 1070	0.00	583.97	1	0	0	0	NULL	0	0	NULL	NULL	1070	NULL	NULL	NULL	NULL	140
70	1073	411001	0	A Divers	2017-01-01 00:00:00	NULL	FP1073	NULL	Vente perf 1073	694.36	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1073	NULL	NULL	NULL	NULL	145
70	1073	706013	0	Produit perf 706013	2017-01-01 00:00:00	NULL	FP1073	NULL	Vente perf 1073	0.00	694.36	1	0	0	0	NULL	0	0	NULL	NULL	1073	NULL	NULL	NULL	NULL	146
70	1076	411001	0	A Divers	2017-04-22 00:00:00	NULL	FP1076	NULL	Vente perf 1076	805.75	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1076	NULL	NULL	NULL	NULL	151
70	1076	707101	0	Produit perf 707101	2017-04-22 00:00:00	NULL	FP1076	NULL	Vente perf 1076	0.00	805.75	1	0	0	0	NULL	0	0	NULL	NULL	1076	NULL	NULL	NULL	NULL	152
70	1079	411001	0	A Divers	2017-07-15 00:00:00	NULL	FP1079	NULL	Vente perf 1079	916.14	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1079	NULL	NULL	NULL	NULL	157
70	1079	707104	0	Produit perf 707104	2017-07-15 00:00:00	NULL	FP1079	NULL	Vente perf 1079	0.00	916.14	1	0	0	0	NULL	0	0	NULL	NULL	1079	NULL	NULL	NULL	NULL	158
70	1082	411001	0	A Divers	2017-10-08 00:00:00	NULL	FP1082	NULL	Vente perf 1082	37.53	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1082	NULL	NULL	NULL	NULL	163
70	1082	707107	0	Produit perf 707107	2017-10-08 00:00:00	NULL	FP1082	NULL	Vente perf 1082	0.00	37.53	1	0	0	0	NULL	0	0	NULL	NULL	1082	NULL	NULL	NULL	NULL	164
70	1085	411001	0	A Divers	2017-01-01 00:00:00	NULL	FP1085	NULL	Vente perf 1085	148.92	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1085	NULL	NULL	NULL	NULL	169
70	1085	707110	0	Produit perf 707110	2017-01-01 00:00:00	NULL	FP1085	NULL	Vente perf 1085	0.00	148.92	1	0	0	0	NULL	0	0	NULL	NULL	1085	NULL	NULL	NULL	NULL	170
70	1088	411001	0	A Divers	2017-04-22 00:00:00	NULL	FP1088	NULL	Vente perf 1088	259.31	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1088	NULL	NULL	NULL	NULL	175
70	1088	707113	0	Produit perf 707113	2017-04-22 00:00:00	NULL	FP1088	NULL	Vente perf 1088	0.00	259.31	1	0	0	0	NULL	0	0	NULL	NULL	1088	NULL	NULL	NULL	NULL	176
70	1091	411001	0	A Divers	2017-07-15 00:00:00	NULL	FP1091	NULL	Vente perf 1091	370.70	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1091	NULL	NULL	NULL	NULL	181
70	1091	706001	0	Produit perf 706001	2017-07-15 00:00:00	NULL	FP1091	NULL	Vente perf 1091	0.00	370.70	1	0	0	0	NULL	0	0	NULL	NULL	1091	NULL	NULL	NULL	NULL	182
70	1094	411001	0	A Divers	2017-10-08 00:00:00	NULL	FP1094	NULL	Vente perf 1094	481.09	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1094	NULL	NULL	NULL	NULL	187
70	1094	706004	0	Produit perf 706004	2017-10-08 00:00:00	NULL	FP1094	NULL	Vente perf 1094	0.00	481.09	1	0	0	0	NULL	0	0	NULL	NULL	1094	NULL	NULL	NULL	NULL	188
70	1097	411001	0	A Divers	2017-01-01 00:00:00	NULL	FP1097	NULL	Vente perf 1097	592.48	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1097	NULL	NULL	NULL	NULL	193
70	1097	706007	0	Produit perf 706007	2017-01-01 00:00:00	NULL	FP1097	NULL	Vente perf 1097	0.00	592.48	1	0	0	0	NULL	0	0	NULL	NULL	1097	NULL	NULL	NULL	NULL	194
70	1100	411001	0	A Divers	2017-04-22 00:00:00	NULL	FP1100	NULL	Vente perf 1100	703.87	0.00	1	0	0	0	NULL	0	0	NULL	NULL	1100	NULL	NULL	NULL	NULL	199
70	1100	706010	0	Produit perf 706010	2017-04-22 00:00:00	NULL	FP1100	NULL	Vente perf 1100	0.00	703.87	1	0	0	0	NULL	0	0	NULL	NULL	1100	NULL	NULL	NULL	NULL	200
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
## centralisation (numrub	intitrub	type	detail	compte	intitcpt	Col1	Col2	col3	col4)
R0010	COMPTE DE RESULTAT - CHARGES	T	NULL	0	NULL	0	0	0	0
R0020	CHARGES D'EXPLOITATION	E	NULL	0	NULL	0	0	0	0
R0030	Cout d'achat des marchandises vendues dans l'exercice	E	N	0	NULL	0	0	0	0
R0040	Achats de marchandises	L	N	0	NULL	0	0	0	0
R0050	Variations des stocks de marchandises	L	N	0	NULL	0	0	0	0
R0060	Consommations de l'exercice en provenance des tiers	E	N	0	NULL	0	0	168093.71	32471.71
R0070	Achats stockes d'approvisionnements :	L	N	0	NULL	0	0	0	0
R0080	Matieres premières	L	0	601002	Charge perf 601002	NULL	NULL	4117.97	335.06
R0080	Matieres premières	L	0	601003	Charge perf 601003	NULL	NULL	3460.14	408.32
R0080	Matieres premières	L	0	601005	Charge perf 601005	NULL	NULL	4126.48	556.84
R0080	Matieres premières	L	0	601006	Charge perf 601006	NULL	NULL	4458.65	631.1
R0080	Matieres premières	L	0	601008	Charge perf 601008	NULL	NULL	5125.99	779.62
R0080	Matieres premières	L	0	601009	Charge perf 601009	NULL	NULL	4468.16	852.88
R0080	Matieres premières	L	0	601011	Charge perf 601011	NULL	NULL	4144.5	1000.4
R0080	Matieres premières	L	0	601012	Charge perf 601012	NULL	NULL	4476.67	1074.66
R0080	Matieres premières	L	0	601014	Charge perf 601014	NULL	NULL	5143.01	1223.18
R0080	Matieres premières	L	0	601015	Charge perf 601015	NULL	NULL	4486.18	1297.44
R0080	Matieres premières	L	0	601017	Charge perf 601017	NULL	NULL	4162.52	1444.96
R0080	Matieres premières	L	0	601018	Charge perf 601018	NULL	NULL	4494.69	1518.22
R0080	Matieres premières	L	0	601020	Charge perf 601020	NULL	NULL	5161.03	1666.74
R0080	Matieres premières	L	N	0	NULL	0	0	0	0
R0090	Autres approvisionnements	L	N	0	NULL	0	0	0	0
R0100	Variations des stocks d'approvisionnements	L	N	0	NULL	0	0	0	0
R0110	Achats de sous-traitances	L	N	0	NULL	0	0	0	0
R0120	Achats non stockes de matieres et fournitures	L	0	606101	Charge perf 606101	NULL	NULL	4803.2	1741
R0120	Achats non stockes de matieres et fournitures	L	0	606103	Charge perf 606103	NULL	NULL	3416.28	899.52
R0120	Achats non stockes de matieres et fournitures	L	0	606104	Charge perf 606104	NULL	NULL	3713.32	973.78
R0120	Achats non stockes de matieres et fournitures	L	0	606106	Charge perf 606106	NULL	NULL	4303.4	1120.3
R0120	Achats non stockes de matieres et fournitures	L	0	606107	Charge perf 606107	NULL	NULL	4600.44	1194.56
R0120	Achats non stockes de matieres et fournitures	L	0	606109	Charge perf 606109	NULL	NULL	3211.52	353.08
R0120	Achats non stockes de matieres et fournitures	L	0	606110	Charge perf 606110	NULL	NULL	3508.56	427.34
R0120	Achats non stockes de matieres et fournitures	L	0	606112	Charge perf 606112	NULL	NULL	4099.64	574.86
R0120	Achats non stockes de matieres et fournitures	L	0	606113	Charge perf 606113	NULL	NULL	4396.68	649.12
R0120	Achats non stockes de matieres et fournitures	L	0	606115	Charge perf 606115	NULL	NULL	4986.76	796.64
R0120	Achats non stockes de matieres et fournitures	L	0	606116	Charge perf 606116	NULL	NULL	3303.8	870.9
R0120	Achats non stockes de matieres et fournitures	L	0	606118	Charge perf 606118	NULL	NULL	3895.88	1019.42
R0120	Achats non stockes de matieres et fournitures	L	0	606119	Charge perf 606119	NULL	NULL	4192.92	1093.68
R0120	Achats non stockes de matieres et fournitures	L	N	0	NULL	0	0	0	0
R0130	Services exterieurs :	L	N	0	NULL	0	0	0	0
R0140	Personnel exterieur	L	N	0	NULL	0	0	0	0
R0150	Loyers en credit-bail	L	N	0	NULL	0	0	0	0
R0160	Autres	L	0	613101	Charge perf 613101	NULL	NULL	4783	500.2
R0160	Autres	L	0	613102	Charge perf 613102	NULL	NULL	4090.04	537.33
R0160	Autres	L	0	613104	Charge perf 613104	NULL	NULL	3692.12	611.59
R0160	Autres	L	0	613105	Charge perf 613105	NULL	NULL	3988.16	648.72
R0160	Autres	L	0	613107	Charge perf 613107	NULL	NULL	4581.24	722.98
R0160	Autres	L	0	613108	Charge perf 613108	NULL	NULL	4876.28	759.11
R0160	Autres	L	0	613110	Charge perf 613110	NULL	NULL	3488.36	833.37
R0160	Autres	L	0	613111	Charge perf 613111	NULL	NULL	3783.4	870.5
R0160	Autres	L	0	613113	Charge perf 613113	NULL	NULL	4376.48	944.76
R0160	Autres	L	0	613114	Charge perf 613114	NULL	NULL	4672.52	981.89
R0160	Autres	L	0	613116	Charge perf 613116	NULL	NULL	3284.6	65.15
R0160	Autres	L	0	613117	Charge perf 613117	NULL	NULL	3579.64	102.28
R0160	Autres	L	0	613119	Charge perf 613119	NULL	NULL	4171.72	176.54
R0160	Autres	L	0	613120	Charge perf 613120	NULL	NULL	4467.76	213.67
R0160	Autres	L	N	0	NULL	0	0	0	0
R0170	Impots, taxes, et versements assimiles	E	N	0	NULL	0	0	0	0
R0180	Sur remunerations	L	N	0	NULL	0	0	0	0
R0190	Autres	L	N	0	NULL	0	0	0	0
R0200	Charges de personnel	E	N	0	NULL	0	0	0	0
R0210	Salaires et traitements	L	N	0	NULL	0	0	0	0
R0220	Charges sociales	L	N	0	NULL	0	0	0	0
R0230	Dotations aux amortissements et aux provisions	E	N	0	NULL	0	0	0	0
R0240	Sur immobilisations : Dotations aux amortissements	L	N	0	NULL	0	0	0	0
R0250	Sur immobilisations : Dotations aux provisions	L	N	0	NULL	0	0	0	0
R0260	Sur actif circulant : Dotations aux provisions	L	N	0	NULL	0	0	0	0
R0270	Pour risques et charges : Dotations aux provisions	L	N	0	NULL	0	0	0	0
R0280	Autres charges	E	N	0	NULL	0	0	0	0
R0300	TOTAL I	S	NULL	0	NULL	0	0	168093.71	32471.71
R0310	QUOTES-PARTS DE RESULTAT SUR OP FAITES EN COMMUN (II)	E	NULL	0	NULL	0	0	0	0
R0330	CHARGES FINANCIERES (III)	E	N	0	NULL	0	0	0	0
R0340	Dotations aux amortissemnts et aux provisions	L	N	0	NULL	0	0	0	0
R0350	Interets et charges assimilees	L	N	0	NULL	0	0	0	0
R0360	Differences negatives de change	L	N	0	NULL	0	0	0	0
R0370	Charges nettes/cessions de valeurs mobilieres de placement	L	N	0	NULL	0	0	0	0
R0380	CHARGES EXCEPTIONNELLES (IV)	E	N	0	NULL	0	0	0	0
R0390	Sur operations de gestion	L	N	0	NULL	0	0	0	0
R0400	Sur operations en capital :	L	N	0	NULL	0	0	0	0
R0410	Valeurs comptables des elements immob et financiers cede	L	N	0	NULL	0	0	0	0
R0420	Autres	L	N	0	NULL	0	0	0	0
R0430	Dotations aux amortissements et aux provisions :	L	N	0	NULL	0	0	0	0
R0440	Dotations aux provisions reglementees	L	N	0	NULL	0	0	0	0
R0450	Dotations aux amortissements et autres provisions	L	N	0	NULL	0	0	0	0
R0460	PARTICIPATION DES SALARIES AUX FRUITS DE L'EXPANSION (V)	E	NULL	0	NULL	0	0	0	0
R0480	IMPOTS SUR LES BENEFICES (VI)	E	N	0	NULL	0	0	0	0
R0700	TOTAL DES CHARGES (I+II+II+IV+V+VI)	O	NULL	0	NULL	0	0	168093.71	32471.71
R0800	SOLDE CREDITEUR = Bénefice (VII)	C	NULL	0	NULL	0	0	0	0
R0900	TOTAL GENERAL (I+II+III+IV+V+VI+VII)	R	NULL	0	NULL	0	0	0	0
R1010	COMPTE DE RESULTAT - PRODUITS	T	NULL	0	NULL	0	0	0	0
R1020	PRODUITS D'EXPLOITATION :	E	NULL	0	NULL	0	0	0	0
R1030	Ventes de marchandises	E	N	0	NULL	0	0	-40090.49	-7672.45
R1040	NULL	L	0	707101	Produit perf 707101	NULL	NULL	-8114.55	-2057.55
R1040	NULL	L	0	707104	Produit perf 707104	NULL	NULL	-8020.18	-2388.72
R1040	NULL	L	0	707107	Produit perf 707107	NULL	NULL	-8189.68	-1732.89
R1040	NULL	L	0	707110	Produit perf 707110	NULL	NULL	-7985.92	-1075.06
R1040	NULL	L	0	707113	Produit perf 707113	NULL	NULL	-7780.16	-418.23
R1050	Production vendue	E	N	0	NULL	0	0	-41963.3	-7435.34
R1060	Ventes	L	N	0	NULL	0	0	0	0
R1070	Travaux	L	N	0	NULL	0	0	0	0
R1080	Prestations de services	L	0	706001	Produit perf 706001	NULL	NULL	-8578.4	-762.4
R1080	Prestations de services	L	0	706004	Produit perf 706004	NULL	NULL	-8486.03	-1204.96
R1080	Prestations de services	L	0	706007	Produit perf 706007	NULL	NULL	-8392.66	-1650.52
R1080	Prestations de services	L	0	706010	Produit perf 706010	NULL	NULL	-8300.29	-2094.08
R1080	Prestations de services	L	0	706013	Produit perf 706013	NULL	NULL	-8205.92	-1723.38
R1080	Prestations de services	L	N	0	NULL	0	0	0	0
R1090	MONTANT NET DU CHIFFRE D'AFFAIRES :	S	NULL	0	NULL	0	0	-82053.79	-15107.79
R1100	Dont a l'exportation :	E	N	0	NULL	0	0	0	0
R1110	Production stockee	E	N	0	NULL	0	0	0	0
R1120	En cours de production de biens	L	N	0	NULL	0	0	0	0
R1130	En cours de production de services	L	N	0	NULL	0	0	0	0
R1140	produits	L	N	0	NULL	0	0	0	0
R1150	Production immobilisee	E	N	0	NULL	0	0	0	0
R1170	Subvention d'exploitation	E	N	0	NULL	0	0	0	0
R1190	Reprises sur provisions (et amortissements)	E	N	0	NULL	0	0	0	0
R1210	Transferts de charges	E	N	0	NULL	0	0	0	0
R1230	Autres produits	E	N	0	NULL	0	0	0	0
R1250	TOTAL I	S	NULL	0	NULL	0	0	-82053.79	-15107.79
R1300	QUOTES-PARTS DE RESULTAT SUR OP. FAITES EN COMMUN (II)	E	NULL	0	NULL	0	0	0	0
R1350	PRODUITS FINANCIERS (III)	E	N	0	NULL	0	0	0	0
R1360	Departicipations	L	N	0	NULL	0	0	0	0
R1370	D'autres valeurs mobilieres et creances de l'actif immobilier	L	N	0	NULL	0	0	0	0
R1380	Autres interets et produits assimiles	L	N	0	NULL	0	0	0	0
R1390	Reprises sur provisions et transferts de charges financiere	L	N	0	NULL	0	0	0	0
R1400	Differences positives de change	L	N	0	NULL	0	0	0	0
R1410	Produits nets sur cessions de valeurs mobilieres de placement	L	N	0	NULL	0	0	0	0
R1450	PRODUITS EXCEPTIONNELS (IV)	E	N	0	NULL	0	0	0	0
R1460	Sur operations de gestion	L	N	0	NULL	0	0	0	0
R1470	Sur operations en capital :	L	N	0	NULL	0	0	0	0
R1480	produits des cessions d'elements d'actif	L	N	0	NULL	0	0	0	0
R1490	Subventions d'investissement virees aux resultats de l'exercice	L	N	0	NULL	0	0	0	0
R1500	Autres	L	N	0	NULL	0	0	0	0
R1510	Reprises sur provisions et transferts de charges exceptionnelles	L	N	0	NULL	0	0	0	0
R1700	TOTAL DES PRODUITS (I+II+III+IV)	O	NULL	0	NULL	0	0	-82053.79	-15107.79
R1800	SOLDE DEBITEUR = PERTE (V)	D	NULL	0	NULL	0	0	-86039.92	17363.92
R1810	TOTAL GENERAL(I+II+III+IV+V)	G	NULL	0	NULL	0	0	168093.71	32471.71
