# Fmenu — Architecture

> Source : `.src/Communs/Fmenu.class` (+ `Fmenu.form`)

## Vue d'ensemble

`Fmenu` est la **fenêtre principale de Laurux en mode Gestion** (comptabilité + gestion
commerciale). Elle est instanciée une seule fois par `Start.Lancement` (`Menu = New Fmenu`,
`Start.module:320`) lorsque l'option `-p` (caisse POS) est absente.

Elle cumule quatre rôles :

1. **Démarrage applicatif** (`Form_Open`, CC 54) : ouverture de la connexion SQL (tunnel SSH
   éventuel, `SET NAMES`, `sql_mode` local et global via la commande `mysql`), restauration de test
   (`Start.Restore_Args`), **migrations de schéma** (`Majversion.RecupVersion`,
   `LauruxMaj.Verif_Version`), application des préférences globales (`Prefs.ReadGlobal` /
   `ApplyGlobal`), rappels du jour (promotions, tarifs différés appliqués en base, factures
   périodiques), affichage des tâches de l'utilisateur. En cas d'erreur : diagnostic de la
   configuration, puis `Quit`.
2. **Barre de menus** : environ 235 entrées (`MenuNNN_Click`, plus `brdreg`, `mvst`, `MenuTbq`,
   `MenuLcr`…), chacune ouvrant un écran (`X.Show`, `X.ShowModal`, `New X(...)`), parfois derrière
   un **mot de passe administrateur** (`MDP`) ou un **contrôle de réplication**
   (`Utils.ControlTunnel`). La carte complète est donnée plus bas : elle sert de référence de
   navigation aux scénarios replay de toute l'application.
3. **Raccourcis** : une barre de 21 `ToolButton` (`Panel1`) et une vingtaine de libellés
   cliquables (`lbl*` dans `ScrollView1`, soulignés au survol par l'observateur `OBS`) qui
   rappellent les handlers de menu.
4. **Fermeture** (`form_close`) : verrou, taille d'écran, sauvegarde automatique, tunnel,
   fermeture de la base et `Utils.Exit(True)`.

Nature globale : **GUI** (handlers), avec trois blocs de traitement : `Form_Open` (SQL de
démarrage), `Abonnement` (calcul des factures périodiques à éditer) et `preferences` (écriture des
préférences par défaut).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Soc` | var | Public |  | String | 31 |
| `intitule` | var | Public |  | String | 32 |
| `Version` | var | Public |  | String | 33 |
| `PsX` | var | Public |  | Integer | 34 |
| `PsY` | var | Public |  | Integer | 35 |
| `CpTable` | var | Public |  | New String[5] | 36 |
| `Btunnel` | var | Private |  | Boolean | 37 |
| `$mopt` | var | Private |  | Menuopt | 38 |
| `$keyObserver` | var | Private |  | Observer | 39 |
| `CMenu` | var | Private |  | Object | 40 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 42-57 | Public | 4 | 13 | 0 | méthode spéciale |
| `KeyObserver_Keypress` | 59-69 | Public | 3 | 9 | 0 | handler GUI |
| `Form_Open` | 72-288 | Public | 54 | 189 | 0 | handler GUI |
| `RecupTaches` | 290-307 | Public | 2 | 15 | 0 | portée réductible ? |
| `Coltaches_Data` | 309-321 | Public | 3 | 11 | 0 | handler GUI |
| `ColTaches_KeyPress` | 323-334 | Public | 3 | 10 | 0 | handler GUI |
| `Timer1_Timer` | 336-340 | Public | 1 | 3 | 0 | handler GUI |
| `Abonnement` | 342-420 | Public | 25 | 74 | 0 | portée réductible ? |
| `preferences` | 422-472 | Public | 1 | 48 | 0 | portée réductible ? |
| `Menushowhide` | 474-484 | Public | 2 | 9 | 1 |  |
| `Menu2showhide` | 486-496 | Public | 2 | 9 | 1 |  |
| `Menu3showhide` | 498-512 | Public | 2 | 13 | 1 |  |
| `Menu4showhide` | 514-524 | Public | 2 | 9 | 1 |  |
| `Config` | 526-531 | Public | 1 | 4 | 0 | portée réductible ? |
| `Menu114_Click` | 533-537 | Public | 1 | 3 | 0 | handler GUI |
| `Menu112_Click` | 539-543 | Public | 1 | 3 | 0 | handler GUI |
| `Menu113_Click` | 545-549 | Public | 1 | 3 | 0 | handler GUI |
| `Menu111_Click` | 551-555 | Public | 1 | 3 | 0 | handler GUI |
| `Menu115_Click` | 557-561 | Public | 1 | 3 | 0 | handler GUI |
| `Menu12_Click` | 563-567 | Public | 1 | 3 | 0 | handler GUI |
| `Menu13_Click` | 569-573 | Public | 1 | 3 | 0 | handler GUI |
| `Client_Click` | 575-579 | Public | 1 | 3 | 0 | handler GUI |
| `fournisseur_Click` | 581-585 | Public | 1 | 3 | 0 | handler GUI |
| `compte_Click` | 587-591 | Public | 1 | 3 | 0 | handler GUI |
| `Tva_Click` | 593-597 | Public | 1 | 3 | 0 | portée réductible ? |
| `Tvac_Click` | 599-603 | Public | 1 | 3 | 0 | handler GUI |
| `libellesaisies_Click` | 605-609 | Public | 1 | 3 | 0 | handler GUI |
| `journaux_Click` | 611-615 | Public | 1 | 3 | 0 | portée réductible ? |
| `collectif_Click` | 617-621 | Public | 1 | 3 | 0 | handler GUI |
| `Menu15_Click` | 623-627 | Public | 1 | 3 | 0 | handler GUI |
| `Menu26_Click` | 630-646 | Public | 3 | 14 | 0 | handler GUI |
| `Menu21_Click` | 648-663 | Public | 7 | 12 | 0 | handler GUI |
| `Menu22_Click` | 665-680 | Public | 7 | 12 | 0 | handler GUI |
| `Menu24_Click` | 682-686 | Public | 1 | 3 | 0 | handler GUI |
| `Menu25_Click` | 688-700 | Public | 3 | 11 | 0 | handler GUI |
| `Menu38_Click` | 702-706 | Public | 1 | 3 | 0 | handler GUI |
| `Menu51_Click` | 708-715 | Public | 1 | 5 | 0 | handler GUI |
| `Menu61_Click` | 717-721 | Public | 1 | 3 | 0 | handler GUI |
| `Menu16_Click` | 723-731 | Public | 1 | 5 | 0 | handler GUI |
| `Menu23_Click` | 733-737 | Public | 1 | 3 | 0 | handler GUI |
| `Menu31_Click` | 739-743 | Public | 1 | 3 | 0 | handler GUI |
| `Menu32_Click` | 745-749 | Public | 1 | 3 | 0 | handler GUI |
| `ToolButton1_Click` | 751-757 | Public | 1 | 5 | 0 | handler GUI |
| `Menu46_Click` | 759-771 | Public | 7 | 10 | 0 | handler GUI |
| `Menu27_Click` | 773-777 | Public | 1 | 3 | 0 | handler GUI |
| `Menu49_Click` | 779-783 | Public | 1 | 3 | 0 | handler GUI |
| `Menu50_Click` | 785-789 | Public | 1 | 3 | 0 | handler GUI |
| `Menu30_Click` | 791-795 | Public | 1 | 3 | 0 | handler GUI |
| `Menu52_Click` | 797-801 | Public | 1 | 3 | 0 | handler GUI |
| `Menu40_Click` | 803-807 | Public | 1 | 3 | 0 | handler GUI |
| `Menu54_Click` | 809-813 | Public | 1 | 3 | 0 | handler GUI |
| `Menu57_Click` | 815-819 | Public | 1 | 3 | 0 | handler GUI |
| `Menu59_Click` | 821-825 | Public | 1 | 3 | 0 | handler GUI |
| `Menu65_Click` | 827-839 | Public | 3 | 11 | 0 | handler GUI |
| `Menu60_Click` | 841-853 | Public | 7 | 10 | 0 | handler GUI |
| `Menu73_Click` | 855-859 | Public | 1 | 3 | 0 | handler GUI |
| `Menu74_Click` | 861-865 | Public | 1 | 3 | 0 | handler GUI |
| `Achat_Click` | 867-871 | Public | 1 | 3 | 0 | handler GUI |
| `Menu14_Click` | 873-877 | Public | 1 | 3 | 0 | handler GUI |
| `Menu70_Click` | 879-883 | Public | 1 | 3 | 0 | handler GUI |
| `Menu17_Click` | 885-889 | Public | 1 | 3 | 0 | handler GUI |
| `Menu28_Click` | 891-895 | Public | 1 | 3 | 0 | handler GUI |
| `Article_Click` | 897-901 | Public | 1 | 3 | 0 | handler GUI |
| `Menu10_Click` | 903-907 | Public | 1 | 3 | 0 | handler GUI |
| `Menu37_Click` | 909-913 | Public | 1 | 3 | 0 | handler GUI |
| `Moeuvre_Click` | 915-919 | Public | 1 | 3 | 0 | handler GUI |
| `Menu42_Click` | 921-947 | Public | 12 | 23 | 0 | handler GUI |
| `ToolButton2_Click` | 949-953 | Public | 1 | 3 | 0 | handler GUI |
| `Menu72_Click` | 955-959 | Public | 1 | 3 | 0 | handler GUI |
| `Tvav_Click` | 961-965 | Public | 1 | 3 | 0 | handler GUI |
| `Menu76_Click` | 967-971 | Public | 1 | 3 | 0 | handler GUI |
| `ToolButton3_Click` | 973-977 | Public | 1 | 3 | 0 | handler GUI |
| `ToolButton4_Click` | 979-983 | Public | 1 | 3 | 0 | handler GUI |
| `ToolButton5_Click` | 985-989 | Public | 1 | 3 | 0 | handler GUI |
| `Menu79_Click` | 991-1003 | Public | 7 | 10 | 0 | handler GUI |
| `Mvt_Click` | 1005-1009 | Public | 1 | 3 | 0 | handler GUI |
| `Menu88_Click` | 1011-1023 | Public | 7 | 10 | 0 | handler GUI |
| `com_Click` | 1025-1029 | Public | 1 | 3 | 0 | handler GUI |
| `Menu90_Click` | 1032-1036 | Public | 1 | 3 | 0 | handler GUI |
| `Menu91_Click` | 1038-1042 | Public | 1 | 3 | 0 | handler GUI |
| `Menu92_Click` | 1044-1048 | Public | 1 | 3 | 0 | handler GUI |
| `Menu81_Click` | 1050-1054 | Public | 1 | 3 | 0 | handler GUI |
| `Menu82_Click` | 1056-1060 | Public | 1 | 3 | 0 | handler GUI |
| `Menu84_Click` | 1062-1066 | Public | 1 | 3 | 0 | handler GUI |
| `Menu83_Click` | 1068-1072 | Public | 1 | 3 | 0 | handler GUI |
| `Menu85_Click` | 1074-1081 | Public | 1 | 4 | 0 | handler GUI |
| `Menu93_Click` | 1083-1087 | Public | 1 | 3 | 0 | handler GUI |
| `Menu95_Click` | 1089-1093 | Public | 1 | 3 | 0 | handler GUI |
| `Menu96_Click` | 1095-1099 | Public | 1 | 3 | 0 | handler GUI |
| `Menu97_Click` | 1101-1105 | Public | 1 | 3 | 0 | handler GUI |
| `Menu98_Click` | 1107-1111 | Public | 1 | 3 | 0 | handler GUI |
| `Menu99_Click` | 1113-1119 | Public | 1 | 4 | 0 | handler GUI |
| `Menu100_Click` | 1121-1125 | Public | 1 | 3 | 0 | handler GUI |
| `Menu102_Click` | 1127-1131 | Public | 1 | 3 | 0 | handler GUI |
| `Menu103_Click` | 1133-1137 | Public | 1 | 3 | 0 | handler GUI |
| `Menu104_Click` | 1139-1143 | Public | 1 | 3 | 0 | handler GUI |
| `Menu106_Click` | 1145-1149 | Public | 1 | 3 | 0 | handler GUI |
| `Menu110_Click` | 1151-1166 | Public | 3 | 13 | 0 | handler GUI |
| `Menu329_Click` | 1168-1190 | Public | 4 | 20 | 0 | handler GUI |
| `Menu109_Click` | 1192-1196 | Public | 1 | 3 | 0 | handler GUI |
| `Menu201_Click` | 1198-1202 | Public | 1 | 3 | 0 | handler GUI |
| `Menu117_Click` | 1205-1209 | Public | 1 | 3 | 0 | handler GUI |
| `Menu118_Click` | 1211-1215 | Public | 1 | 3 | 0 | handler GUI |
| `Menu121_Click` | 1217-1221 | Public | 1 | 3 | 0 | handler GUI |
| `form_close` | 1223-1238 | Public | 5 | 14 | 0 | handler GUI |
| `Tsr_Click` | 1240-1244 | Public | 1 | 3 | 0 | handler GUI |
| `Menu122_Click` | 1246-1250 | Public | 1 | 3 | 0 | handler GUI |
| `Menu123_Click` | 1252-1256 | Public | 1 | 3 | 0 | handler GUI |
| `Menu124_Click` | 1258-1262 | Public | 1 | 3 | 0 | handler GUI |
| `journal_Click` | 1264-1268 | Public | 1 | 3 | 0 | handler GUI |
| `Menu101_Click` | 1270-1274 | Public | 1 | 3 | 0 | handler GUI |
| `Menu108_Click` | 1276-1280 | Public | 1 | 3 | 0 | handler GUI |
| `Menu125_Click` | 1282-1286 | Public | 1 | 3 | 0 | handler GUI |
| `Menu126_Click` | 1288-1292 | Public | 1 | 3 | 0 | handler GUI |
| `Menu127_Click` | 1294-1298 | Public | 1 | 3 | 0 | handler GUI |
| `Menu128_Click` | 1300-1304 | Public | 1 | 3 | 0 | handler GUI |
| `ToolButton6_Click` | 1306-1310 | Public | 1 | 3 | 0 | handler GUI |
| `ToolButton7_Click` | 1312-1316 | Public | 1 | 3 | 0 | handler GUI |
| `Menu130_Click` | 1318-1322 | Public | 1 | 3 | 0 | handler GUI |
| `Menu131_Click` | 1324-1328 | Public | 1 | 3 | 0 | handler GUI |
| `Menu132_Click` | 1330-1334 | Public | 1 | 3 | 0 | handler GUI |
| `Menu133_Click` | 1336-1340 | Public | 1 | 3 | 0 | handler GUI |
| `Menu134_Click` | 1342-1346 | Public | 1 | 3 | 0 | handler GUI |
| `Menu141_Click` | 1348-1352 | Public | 1 | 3 | 0 | handler GUI |
| `Menu138_Click` | 1354-1366 | Public | 7 | 10 | 0 | handler GUI |
| `Menu143_Click` | 1368-1372 | Public | 1 | 3 | 0 | handler GUI |
| `Menu145_Click` | 1374-1378 | Public | 1 | 3 | 0 | handler GUI |
| `Menu147_Click` | 1380-1392 | Public | 7 | 10 | 0 | handler GUI |
| `Menu150_Click` | 1394-1406 | Public | 3 | 11 | 0 | handler GUI |
| `Menu154_Click` | 1409-1413 | Public | 1 | 3 | 0 | handler GUI |
| `Menu156_Click` | 1415-1419 | Public | 1 | 3 | 0 | handler GUI |
| `Menu149_Click` | 1421-1425 | Public | 1 | 3 | 0 | handler GUI |
| `SetObserver` | 1427-1440 | Public | 4 | 11 | 0 | portée réductible ? |
| `OBS_Enter` | 1442-1447 | Public | 1 | 4 | 0 | handler GUI |
| `OBS_Leave` | 1449-1454 | Public | 1 | 4 | 0 | handler GUI |
| `lblCli_MouseDown` | 1456-1461 | Public | 1 | 4 | 0 | handler GUI |
| `lblFour_MouseUp` | 1463-1468 | Public | 1 | 4 | 0 | handler GUI |
| `LblFam_MouseUp` | 1470-1475 | Public | 1 | 4 | 0 | handler GUI |
| `lblArt_MouseUp` | 1477-1482 | Public | 1 | 4 | 0 | handler GUI |
| `lblMO_MouseUp` | 1484-1489 | Public | 1 | 4 | 0 | handler GUI |
| `lblFac_MouseUp` | 1491-1496 | Public | 1 | 4 | 0 | handler GUI |
| `lblCom_MouseUp` | 1498-1503 | Public | 1 | 4 | 0 | handler GUI |
| `lblRgl_MouseUp` | 1505-1510 | Public | 1 | 4 | 0 | handler GUI |
| `lbsr_MouseUp` | 1512-1516 | Public | 1 | 3 | 0 | handler GUI |
| `lblVrecpt_MouseUp` | 1518-1523 | Public | 1 | 4 | 0 | handler GUI |
| `Menu153_Click` | 1525-1529 | Public | 1 | 3 | 0 | handler GUI |
| `lblRem_MouseUp` | 1531-1536 | Public | 1 | 4 | 0 | handler GUI |
| `lblArch_MouseDown` | 1538-1543 | Public | 1 | 4 | 0 | handler GUI |
| `lblFacfm_MouseDown` | 1545-1550 | Public | 1 | 4 | 0 | handler GUI |
| `lblClm_MouseDown` | 1552-1557 | Public | 1 | 4 | 0 | handler GUI |
| `lblClm2_MouseDown` | 1559-1564 | Public | 1 | 4 | 0 | handler GUI |
| `Menu152_Click` | 1566-1570 | Public | 1 | 3 | 0 | handler GUI |
| `Menu157_Click` | 1572-1579 | Public | 1 | 5 | 0 | handler GUI |
| `Menu158_Click` | 1581-1588 | Public | 1 | 5 | 0 | handler GUI |
| `Menu161_Click` | 1590-1597 | Public | 1 | 5 | 0 | handler GUI |
| `Menu162_Click` | 1599-1606 | Public | 1 | 5 | 0 | handler GUI |
| `Menu163_Click` | 1608-1612 | Public | 1 | 3 | 0 | handler GUI |
| `Menu164_Click` | 1614-1618 | Public | 1 | 3 | 0 | handler GUI |
| `Menu165_Click` | 1620-1624 | Public | 1 | 3 | 0 | handler GUI |
| `Menu166_Click` | 1626-1638 | Public | 3 | 11 | 0 | handler GUI |
| `Menu168_Click` | 1640-1644 | Public | 1 | 3 | 0 | handler GUI |
| `Menu169_Click` | 1646-1650 | Public | 1 | 3 | 0 | handler GUI |
| `Menu170_Click` | 1652-1656 | Public | 1 | 3 | 0 | handler GUI |
| `Menu171_Click` | 1658-1662 | Public | 1 | 3 | 0 | handler GUI |
| `Menu175_Click` | 1664-1672 | Public | 1 | 6 | 0 | handler GUI |
| `Menu173_Click` | 1674-1687 | Public | 3 | 11 | 0 | handler GUI |
| `Menu63_Click` | 1689-1693 | Public | 1 | 3 | 0 | handler GUI |
| `Menu64_Click` | 1695-1699 | Public | 1 | 3 | 0 | handler GUI |
| `Menu176_Click` | 1701-1705 | Public | 1 | 3 | 0 | handler GUI |
| `Menu181_Click` | 1707-1711 | Public | 1 | 3 | 0 | handler GUI |
| `Menu180_Click` | 1713-1717 | Public | 1 | 3 | 0 | handler GUI |
| `Menu182_Click` | 1719-1723 | Public | 1 | 3 | 0 | handler GUI |
| `Menu184_Click` | 1725-1729 | Public | 1 | 3 | 0 | handler GUI |
| `Menu186_Click` | 1731-1735 | Public | 1 | 3 | 0 | handler GUI |
| `Menu189_Click` | 1737-1741 | Public | 1 | 3 | 0 | handler GUI |
| `Menu190_Click` | 1743-1750 | Public | 1 | 5 | 0 | handler GUI |
| `lblMat_MouseDown` | 1752-1760 | Public | 1 | 6 | 0 | handler GUI |
| `Menu191_Click` | 1762-1766 | Public | 1 | 3 | 0 | handler GUI |
| `Menu193_Click` | 1768-1794 | Public | 12 | 23 | 0 | handler GUI |
| `lblFac2_MouseDown` | 1796-1801 | Public | 1 | 4 | 0 | handler GUI |
| `Menu194_Click` | 1803-1807 | Public | 1 | 3 | 0 | handler GUI |
| `brdreg_Click` | 1809-1813 | Public | 1 | 3 | 0 | handler GUI |
| `Menu195_Click` | 1815-1819 | Public | 1 | 3 | 0 | handler GUI |
| `Menu196_Click` | 1821-1825 | Public | 1 | 3 | 0 | handler GUI |
| `Menu197_Click` | 1827-1831 | Public | 1 | 3 | 0 | handler GUI |
| `Menu198_Click` | 1833-1837 | Public | 1 | 3 | 0 | handler GUI |
| `Menu199_Click` | 1839-1843 | Public | 1 | 3 | 0 | handler GUI |
| `Menu202_Click` | 1845-1849 | Public | 1 | 3 | 0 | handler GUI |
| `Menu205_Click` | 1851-1855 | Public | 1 | 3 | 0 | handler GUI |
| `Menu207_Click` | 1857-1861 | Public | 1 | 3 | 0 | handler GUI |
| `Menu206_Click` | 1863-1867 | Public | 1 | 3 | 0 | handler GUI |
| `Menu214_Click` | 1869-1873 | Public | 1 | 3 | 0 | handler GUI |
| `Menu208_Click` | 1875-1879 | Public | 1 | 3 | 0 | handler GUI |
| `Menu209_Click` | 1881-1885 | Public | 1 | 3 | 0 | handler GUI |
| `Menu215_Click` | 1887-1899 | Public | 7 | 10 | 0 | handler GUI |
| `Menu218_Click` | 1901-1905 | Public | 1 | 3 | 0 | handler GUI |
| `Menu204_Click` | 1907-1911 | Public | 1 | 3 | 0 | handler GUI |
| `Menu219_Click` | 1913-1917 | Public | 1 | 3 | 0 | handler GUI |
| `Menu221_Click` | 1919-1923 | Public | 1 | 3 | 0 | handler GUI |
| `Menu222_Click` | 1925-1929 | Public | 1 | 3 | 0 | handler GUI |
| `Menu223_Click` | 1931-1935 | Public | 1 | 3 | 0 | handler GUI |
| `Menu225_Click` | 1937-1941 | Public | 1 | 3 | 0 | handler GUI |
| `Menu226_Click` | 1943-1947 | Public | 1 | 3 | 0 | handler GUI |
| `Menu227_Click` | 1949-1953 | Public | 1 | 3 | 0 | handler GUI |
| `Menu229_Click` | 1955-1959 | Public | 1 | 3 | 0 | handler GUI |
| `Menu230_Click` | 1961-1973 | Public | 7 | 10 | 0 | handler GUI |
| `Menu232_Click` | 1975-1979 | Public | 1 | 3 | 0 | handler GUI |
| `Menu233_Click` | 1981-1985 | Public | 1 | 3 | 0 | handler GUI |
| `Menu234_Click` | 1987-1991 | Public | 1 | 3 | 0 | handler GUI |
| `lblClm3_MouseDown` | 1993-1998 | Public | 1 | 4 | 0 | handler GUI |
| `Menu238_Click` | 2000-2004 | Public | 1 | 3 | 0 | handler GUI |
| `Menu239_Click` | 2006-2010 | Public | 1 | 3 | 0 | handler GUI |
| `Menu240_Click` | 2012-2016 | Public | 1 | 3 | 0 | handler GUI |
| `Menu241_Click` | 2018-2022 | Public | 1 | 3 | 0 | handler GUI |
| `Menu242_Click` | 2024-2028 | Public | 1 | 3 | 0 | handler GUI |
| `Menu245_Click` | 2030-2034 | Public | 1 | 3 | 0 | handler GUI |
| `Menu246_Click` | 2036-2040 | Public | 1 | 3 | 0 | handler GUI |
| `Menu247_Click` | 2042-2046 | Public | 1 | 3 | 0 | handler GUI |
| `Menu248_Click` | 2048-2052 | Public | 1 | 3 | 0 | handler GUI |
| `Menu249_Click` | 2054-2058 | Public | 1 | 3 | 0 | handler GUI |
| `Menu250_Click` | 2060-2064 | Public | 1 | 3 | 0 | handler GUI |
| `Menu251_Click` | 2066-2070 | Public | 1 | 3 | 0 | handler GUI |
| `Menu252_Click` | 2072-2076 | Public | 1 | 3 | 0 | handler GUI |
| `Menu253_Click` | 2078-2082 | Public | 1 | 3 | 0 | handler GUI |
| `Menu254_Click` | 2084-2088 | Public | 1 | 3 | 0 | handler GUI |
| `Menu255_Click` | 2090-2094 | Public | 1 | 3 | 0 | handler GUI |
| `Menu256_Click` | 2096-2100 | Public | 1 | 3 | 0 | handler GUI |
| `Menu259_Click` | 2102-2106 | Public | 1 | 3 | 0 | handler GUI |
| `Menu260_Click` | 2108-2112 | Public | 1 | 3 | 0 | handler GUI |
| `Menu261_Click` | 2114-2118 | Public | 1 | 3 | 0 | handler GUI |
| `Menu262_Click` | 2120-2124 | Public | 1 | 3 | 0 | handler GUI |
| `Menu263_Click` | 2126-2130 | Public | 1 | 3 | 0 | handler GUI |
| `Menu265_Click` | 2132-2136 | Public | 1 | 3 | 0 | handler GUI |
| `Menu264_Click` | 2138-2142 | Public | 1 | 3 | 0 | handler GUI |
| `Menu266_Click` | 2144-2148 | Public | 1 | 3 | 0 | handler GUI |
| `Menu268_Click` | 2150-2154 | Public | 1 | 3 | 0 | handler GUI |
| `Menu269_Click` | 2156-2160 | Public | 1 | 3 | 0 | handler GUI |
| `Menu270_Click` | 2162-2166 | Public | 1 | 3 | 0 | handler GUI |
| `Menu272_Click` | 2168-2172 | Public | 1 | 3 | 0 | handler GUI |
| `Menu273_Click` | 2174-2178 | Public | 1 | 3 | 0 | handler GUI |
| `Menu275_Click` | 2180-2184 | Public | 1 | 3 | 0 | handler GUI |
| `Menu277_Click` | 2186-2193 | Public | 1 | 5 | 0 | handler GUI |
| `Menu278_Click` | 2195-2202 | Public | 1 | 5 | 0 | handler GUI |
| `Menu279_Click` | 2204-2208 | Public | 1 | 3 | 0 | handler GUI |
| `Menu281_Click` | 2210-2214 | Public | 1 | 3 | 0 | handler GUI |
| `Menu282_Click` | 2216-2220 | Public | 1 | 3 | 0 | handler GUI |
| `Menu283_Click` | 2222-2226 | Public | 1 | 3 | 0 | handler GUI |
| `Menu284_Click` | 2228-2232 | Public | 1 | 3 | 0 | handler GUI |
| `Menu286_Click` | 2234-2238 | Public | 1 | 3 | 0 | handler GUI |
| `Menu287_Click` | 2240-2244 | Public | 1 | 3 | 0 | handler GUI |
| `Menu288_Click` | 2246-2250 | Public | 1 | 3 | 0 | handler GUI |
| `Menu289_Click` | 2252-2256 | Public | 1 | 3 | 0 | handler GUI |
| `Menu290_Click` | 2258-2262 | Public | 1 | 3 | 0 | handler GUI |
| `Menu292_Click` | 2264-2268 | Public | 1 | 3 | 0 | handler GUI |
| `Menu293_Click` | 2270-2274 | Public | 1 | 3 | 0 | handler GUI |
| `Menu294_Click` | 2276-2280 | Public | 1 | 3 | 0 | handler GUI |
| `Menu295_Click` | 2282-2294 | Public | 7 | 10 | 0 | handler GUI |
| `Menu296_Click` | 2296-2300 | Public | 1 | 3 | 0 | handler GUI |
| `Menu297_Click` | 2302-2306 | Public | 1 | 3 | 0 | handler GUI |
| `Menu298_Click` | 2308-2312 | Public | 1 | 3 | 0 | handler GUI |
| `Menu299_Click` | 2314-2326 | Public | 7 | 10 | 0 | handler GUI |
| `Menu302_Click` | 2328-2335 | Public | 1 | 5 | 0 | handler GUI |
| `Menu303_Click` | 2337-2341 | Public | 1 | 3 | 0 | handler GUI |
| `Menu305_Click` | 2343-2347 | Public | 1 | 3 | 0 | handler GUI |
| `Menu306_Click` | 2349-2353 | Public | 1 | 3 | 0 | handler GUI |
| `Menu309_Click` | 2355-2362 | Public | 1 | 5 | 0 | handler GUI |
| `Menu310_Click` | 2364-2368 | Public | 1 | 3 | 0 | handler GUI |
| `Menu311_Click` | 2370-2374 | Public | 1 | 3 | 0 | handler GUI |
| `Menu312_Click` | 2376-2380 | Public | 1 | 3 | 0 | handler GUI |
| `Menu313_Click` | 2382-2386 | Public | 1 | 3 | 0 | handler GUI |
| `Menu314_Click` | 2388-2392 | Public | 1 | 3 | 0 | handler GUI |
| `Menu315_Click` | 2394-2398 | Public | 1 | 3 | 0 | handler GUI |
| `Menu319_Click` | 2400-2407 | Public | 1 | 5 | 0 | handler GUI |
| `Menu318_Click` | 2409-2413 | Public | 1 | 3 | 0 | handler GUI |
| `Menu320_Click` | 2415-2423 | Public | 1 | 6 | 0 | handler GUI |
| `Menu321_Click` | 2425-2429 | Public | 1 | 3 | 0 | handler GUI |
| `Menu323_Click` | 2431-2435 | Public | 1 | 3 | 0 | handler GUI |
| `Button1_Click` | 2437-2441 | Public | 1 | 3 | 0 | handler GUI |
| `Menu324_Click` | 2443-2447 | Public | 1 | 3 | 0 | handler GUI |
| `Menu325_Click` | 2449-2453 | Public | 1 | 3 | 0 | handler GUI |
| `Menu326_Click` | 2455-2463 | Public | 1 | 6 | 0 | handler GUI |
| `Menu327_Click` | 2465-2469 | Public | 1 | 3 | 0 | handler GUI |
| `mvst_Click` | 2471-2475 | Public | 1 | 3 | 0 | handler GUI |
| `Menu328_Click` | 2477-2481 | Public | 1 | 3 | 0 | handler GUI |
| `Menu330_Click` | 2484-2490 | Public | 1 | 5 | 0 | handler GUI |
| `Menuimpfec_Click` | 2492-2496 | Public | 1 | 3 | 0 | handler GUI |
| `MenuTbq_Click` | 2498-2502 | Public | 1 | 3 | 0 | handler GUI |
| `MenuTrlcr_Click` | 2504-2508 | Public | 1 | 3 | 0 | handler GUI |
| `MenuAbq_Click` | 2510-2514 | Public | 1 | 3 | 0 | handler GUI |
| `Menuprep_Click` | 2516-2520 | Public | 1 | 3 | 0 | handler GUI |
| `MenuGbrd_Click` | 2522-2526 | Public | 1 | 3 | 0 | handler GUI |
| `Menuis_Click` | 2528-2532 | Public | 1 | 3 | 0 | handler GUI |
| `Menu332_Click` | 2534-2552 | Public | 4 | 15 | 0 | handler GUI |
| `Menu142_Click` | 2554-2569 | Public | 3 | 13 | 0 | handler GUI |
| `Menu300_Click` | 2571-2575 | Public | 1 | 3 | 0 | handler GUI |
| `rglmt_Click` | 2577-2581 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Construction, démarrage et fermeture

- **`_new()`** [portée : nécessaire (spéciale)] [nature : GUI]. Si `/Soc<XX>/Tme`, restaure la taille
  depuis `/Soc<XX>/Ecran` (`"L;H"` lu par `Scan(…, "*;*")`, erreurs ignorées). Enregistre les
  observateurs de replay (`Utils.Observers(Me)`), centre la fenêtre et crée l'observateur clavier
  `KeyObserver`.
- **`KeyObserver_Keypress()`** [handler] [GUI]. `F11` bascule le plein écran.
- **`Form_Open()`** [handler] [mixte] (CC 54, 189 LOC). Séquence :
  1. `Soc`, `intitule` ; visibilité des menus selon les options société (`/Exp` →
     `Menushowhide`, `/Btq`, `/Materiel`, `/Caisse`, `/Taches` → `Menu50`, `/Blocsoc` → `Menu26`,
     `/Lcr` → `MenuLcr`/`MenuTbq`, `/Vendeurs` → `Menu287`, `/Faca` → `Menu299`, `/Sms` →
     `Menu315`/`Menu316`) ; menus optionnels « bois » / « pp » ajoutés dynamiquement par
     [`Menuopt`](../../Gestion/option/menuopt.class/architecture.md) (qui masque aussi `Menu306`).
  2. Image de fond `/Soc<XX>/Fecran` ; si `/Slide`, **rotation** de l'image pour le prochain
     lancement (`Laurux1.jpg` → … → `Laurux5.jpg` → aucune).
  3. `If Error Then` (l. 143) : propose « Config SQL / Réinitialisation préférences / Quitter ».
     ⚠️ Le seul `Try` qui précède est celui de la ligne 88 (`/intitule`) : ce dialogue n'est
     pratiquement jamais affiché (anomalie FMENU-A08).
  4. `Utils.glb()`, tunnel SSH (`Utils.monteTunnel`) si `/dbase/Con-ssh`, `Try Utils.db.Open`.
  5. MySQL : `SET NAMES utf8mb4…`, `SET SESSION sql_mode` (retrait de `ONLY_FULL_GROUP_BY`), puis
     **`Shell "mysql -h … -u … -p<mot de passe> -e \"…SET @@global.sql_mode=…\"" Wait`** (l. 175) :
     mot de passe en clair sur la ligne de commande, réglage global du serveur (anomalie FMENU-A07).
  6. `Start.Restore_Args()` (restauration de test en ligne de commande).
  7. Titre : `SELECT * FROM Cbase.Table("TabSoc") WHERE cd_sc = &1`.
  8. `Menu173` masqué si l'application est installée dans `/usr/bin/Laurux`.
  9. **Migrations** : `Majversion.RecupVersion()` puis `LauruxMaj.Verif_Version()`.
  10. Préférences globales : `New Prefs(Start.LocalSettings)`, `Start.GlobalSettings =
      Pr.ReadGlobal()`, `Pr.ApplyGlobal(...)` ; `/Infob` → `Application.ShowTooltips = False`.
  11. `SetObserver(ScrollView1)` (survol des libellés).
  12. `Try` promotions du jour (`Cbase.Table("TabPromo")`, `datedeb = &1` puis `datefin = &1`) →
      `Syntheses.Message` + `Message.Info`. Les étapes 13 à 15 ne s'exécutent **que si cette
      première requête réussit**.
  13. Tarifs différés : `SELECT * FROM Fiches_TarTemp WHERE date <= &1 AND dtmaj = &2` (nom de table
      en dur) → `DateTar.EnrTouTar(rResult)` (**écrit** les tarifs en base).
  14. `/Faca` → `Abonnement()`.
  15. Son d'accueil `son/menu.ogg`.
  16. Si `/Taches` : en-tête « Bonjour … » et `RecupTaches()`.
  - `Catch` : message selon le texte de l'erreur (base absente, configuration absente ou corrompue,
    accès refusé…), puis `Message.Question` « Config SQL / Réinitialisation préférences / Restaurer
    une sauvegarde » (`Config`, `preferences`, `FRestore.ShowModal`), puis `Me.Close` et `Quit`.
  SQL émis : `TabSoc`, `TabPromo`, `Fiches_TarTemp` (+ écritures de `DateTar.EnrTouTar`, de
  `LauruxMaj` et de `Abonnement` en lecture). Partie extractible : étapes 1-2 (options d'affichage),
  4-6 (connexion), 12-14 (rappels).
- **`form_close()`** [handler] [mixte]. `Start.UnLock()`, enregistre `/Soc<XX>/Ecran = L;H`,
  `SauvesAuto.Sauvegarde(Me)` si `/Sauvauto` **et** `/dbase/Maj`, son de fermeture (`Wait 1.5`),
  `Utils.fermeTunnel()`, `Utils.db.Close()`, `Utils.Exit(True)`.
- **`ToolButton1_Click()`** [handler] [mixte]. `Shell "rm " & User.home & "/tmp/*"` (chemin non
  protégé, tout `~/tmp` vidé), `Me.Persistent = False`, `Me.Close`. Le menu « Quitter »
  (`Menu118`) ferme sans ce nettoyage (FMENU-A14).
- **`Config()`** [portée : réductible] [GUI]. `LauruxConf.ShowModal()` puis `Soc = Start.Societe`.
- **`preferences()`** [portée : réductible] [mixte]. Réinitialise une quarantaine de clés de
  `Start.LocalSettings` (son, astuces, entête, TVA, couleurs `/Coul/*`, police, slide, taxe,
  familles, options bois/pp…), `Save`, `Reload`, `Message.Info`. Appelée uniquement depuis les deux
  dialogues d'erreur de `Form_Open`. ⚠️ Écrit `/Coul/Coulfonds = "255,252,216,"` et
  `/Coul/Others = "255,232,199,"` avec des **virgules**, alors que `Start.Coul` découpe sur `;`
  (`Start.module:230`) : la couleur de repli 255;254;212 est alors utilisée (FMENU-A03). Les clés
  `Qt1`, `Coulfonds`, `Others` sont écrites deux fois (première valeur morte) ; `"&FFEE81&"` sans
  `H` est écrasé aussitôt. Les clés `/Coul/Devis2`, `/Coul/Motps`, `/Coul/Momnt`, présentes dans
  `Start.module:132-155`, ne sont pas réinitialisées ici.

### Tâches et rendez-vous

- **`RecupTaches()`** [portée : réductible] [mixte]. Colonnes de `Coltaches`, puis
  `Utils.Base(Coltaches, "select * from Fiches_Taches where nom like \"" & User.name & "%\" ")`
  (SQL **concaténé**, table en dur, résultat dans le global partagé `Utils.rs1`). `Panel2` n'est
  affiché que s'il y a **plus d'une** tâche (FMENU-A05).
- **`Coltaches_Data(Row, Column)`** [handler] [GUI]. Remplit `CpTable` (noms de colonnes) à chaque
  appel puis lit `Utils.rs1` : si un autre écran a réutilisé `Utils.rs1` (`Utils.Base`), la grille
  affiche d'autres données au prochain rafraîchissement (FMENU-A06).
- **`ColTaches_KeyPress()`** [handler] [mixte]. **Toute touche** déclenche la question « Etes vous
  sur de vouloir effacer cet enregistrement » ; sur « Oui » : `DELETE FROM Fiches_Taches WHERE lind
  = &1`, puis `ALTER TABLE Fiches_Taches ORDER BY lind` (MySQL seulement : erreur sous SQLite),
  puis `RecupTaches()` (FMENU-A04).
- **`Button1_Click()`** [handler] [GUI]. Masque `Panel2`.
- **`Timer1_Timer()`** [handler] [GUI]. Toutes les 60 s (`Timer1.Delay = 60000` dans le `.form`) :
  `AffRdv.Calc_Timer(Timer1)` (rappels d'agenda).

### Factures périodiques

- **`Abonnement()`** [portée : réductible] [mixte] (CC 25). Requête :
  `SELECT * FROM TabBl LEFT JOIN TabCli ON cli_code = cdclibl WHERE type = 'A' AND totalht <> 0 AND
  (dtefac <= aujourd'hui OR isnull(dtefac)) ORDER BY cdclibl, dtefac DESC` (parenthèses implicites
  par la priorité de `AND`). Pour la **première ligne de chaque client** (la plus récente) : sans
  `dtefac`, la facture est due ; sinon selon `cli_aban` (« 1- Mensuel », « 2- Bimensuel », « 3-
  Trimestriel », « 4- Semestriel », « 5- Annuel »), le mois de `dtefac` (lu par `Left$(DteFac, 2)` sur
  la conversion implicite Date → String, format à confirmer) est comparé au mois courant moins la
  période, et le jour de `dtefac` au jour courant. Si au moins une facture est due :
  `Syntheses.Message` + `Message.Info` avec le nombre.
  ⚠️ Passage d'année : `12 - Val(mois)` au lieu de `12 + Val(mois)` (l. 364-391) : en janvier, la
  période bimestrielle donne le mois 13 (FMENU-A01). Périodicité annuelle : le jour de la facture est
  comparé aux **deux derniers chiffres de l'année** (`Right$(dteN2, 2)`, l. 401) (FMENU-A02).
  `dateAb` est lu mais jamais utilisé. Partie extractible : tout le calcul (fonction pure prenant
  le résultat et la date du jour, renvoyant le nombre).

### Visibilité des menus (appelées par `Prefs`)

- **`Menushowhide(Exprt)`**, **`Menu2showhide(Btq)`**, **`Menu3showhide(Mat)`**,
  **`Menu4showhide(Cai)`** [portée : nécessaire, `Prefs.class:729-750`] [GUI]. Affichent ou masquent
  des couples de menus (`Menu133`/`Menu134` en exclusion mutuelle ; `Menu184`/`Menu183` ;
  `Menu190`/`Menu193`/`HBox17`/`HBox18` ; `Menu203`/`Menu296`) selon une chaîne `"1"`. Déclarées
  `As String` sans `Return` (valeur de retour inutilisée). ⚠️ `Prefs` les appelle sur
  **l'auto-instance** `Fmenu.`, distincte de l'instance `New Fmenu` créée par `Start` (FMENU-A13).

### Survol des libellés

- **`SetObserver(hCont)`** [portée : réductible] [GUI]. Parcourt récursivement le conteneur et
  attache un `Observer` « OBS » à chaque `Label` (curseur main).
- **`OBS_Enter()` / `OBS_Leave()`** [handler] [GUI]. Libellé survolé en bleu souligné / couleur
  normale.

### Raccourcis (barre d'outils et libellés)

Tous [handler] [GUI] ; ils appellent le handler de menu équivalent ou ouvrent directement l'écran.

| Contrôle | Handler | Effet |
|---|---|---|
| `Client` / `lblCli` | `Client_Click`, `lblCli_MouseDown` | `menu12_Click` |
| `Fournisseur` / `lblFour` | `fournisseur_Click`, `lblFour_MouseUp` | `Menu13_Click` |
| `Compte` | `compte_Click` | `Menu114_Click` |
| `Tvac` | `Tvac_Click` | `Menu113_Click` |
| `Tvav` | `Tvav_Click` | `Menu112_Click` |
| `Libellesaisies` | `libellesaisies_Click` | `Menu24_Click` |
| `Collectif` | `collectif_Click` | `Menu111_Click` |
| `Journal` | `journal_Click` | `Fjournaux.Show` (identique à `Menu115`) |
| `Achat` | `Achat_Click` | `Menu21_Click` |
| `Tsr` | `Tsr_Click` | `Menu22_Click` |
| `Article` / `lblArt` | `Article_Click`, `lblArt_MouseUp` | `Menu15_Click` |
| `Moeuvre` / `lblMO` | `Moeuvre_Click`, `lblMO_MouseUp` | `Menu37_Click` |
| `ToolButton2` / `lblFac` | `ToolButton2_Click`, `lblFac_MouseUp` | `Menu42_Click` |
| `ToolButton3` | `ToolButton3_Click` | `Menu61_Click` |
| `ToolButton4` | `ToolButton4_Click` | `Menu10_Click` |
| `ToolButton5` | `ToolButton5_Click` | `Menu40_Click` |
| `ToolButton6` | `ToolButton6_Click` | `Menu16_Click` |
| `ToolButton7` | `ToolButton7_Click` | `Menu51_click` |
| `Mvt` / `lblRgl` | `Mvt_Click`, `lblRgl_MouseUp` | `Menu79_Click` |
| `Com` / `lblCom` | `com_Click`, `lblCom_MouseUp` | `Menu88_Click` |
| `rglmt` / `lbsr` | `rglmt_Click`, `lbsr_MouseUp` | `SaiReg.ShowModal` (identique à `brdreg`) |
| `ToolButton1` | `ToolButton1_Click` | quitter (voir plus haut) |
| `lblFam` | `LblFam_MouseUp` | `Menu14_Click` |
| `lblVrecpt` | `lblVrecpt_MouseUp` | `Menu295_Click` |
| `lblRem` | `lblRem_MouseUp` | `Menu154_Click` |
| `lblFac2` | `lblFac2_MouseDown` | `Menu193_Click` |
| `lblMat` | `lblMat_MouseDown` | `New Materiel("")`.ShowModal (identique à `Menu190`) |
| `lblArch` | `lblArch_MouseDown` | `Archives.ShowModal` |
| `lblFacfm` | `lblFacfm_MouseDown` | `Facturefm.ShowModal` **sans** contrôle de réplication (≠ `Menu138`) |
| `lblClm` | `lblClm_MouseDown` | `ClotureF.ShowModal` **sans** contrôle de réplication (≠ `Menu147`) |
| `lblClm2` | `lblClm2_MouseDown` | `ConsultArt.Show` |
| `lblClm3` | `lblClm3_MouseDown` | `Fprepdus.Show` |

Les libellés finissent par `Stop Event`. **Code mort** : `Tva_Click` (l. 593) et `journaux_Click`
(l. 611) ne correspondent à **aucun contrôle** du `.form` (les boutons s'appellent `Tvav`/`Tvac` et
`Journal`) [portée : réductible, en réalité supprimable].

### Handlers de menu : carte de navigation

Chaque handler `MenuNNN_Click` est [handler] [GUI] et se réduit à l'ouverture d'un écran ; seules
les variantes suivantes ajoutent de la logique :

- **Mot de passe administrateur** (si `/Soc<XX>/Admin`) : `MDP.ShowModal()` puis test de
  `Start.Motdepasse = "OK"` et remise à `""` — `Menu25`, `Menu26`, `Menu65`, `Menu110`, `Menu142`,
  `Menu150`, `Menu166`, `Menu173` (8 copies du même bloc ; `Fsoc.class:400-408` en contient une
  9ᵉ). `Menu329` utilise le mot de passe **global** (`/AdminG`, `New MDP(Null, True)`).
- **Contrôle de réplication** (si `/dbase/Con-ssh` **et** `/Replique` **et** `/Breplique`) :
  `Btunnel = Utils.ControlTunnel()` ; échec → `Message.Error("Problème de réplication ! …")` et
  abandon — 14 copies : `Menu21`, `Menu22`, `Menu42`, `Menu46`, `Menu60`, `Menu79`, `Menu88`,
  `Menu138`, `Menu147`, `Menu193`, `Menu215`, `Menu230`, `Menu295`, `Menu299`. `Utils.ControlTunnel` est lui-même défectueux (voir
  [UTILS-A01](../../Utils/Utils.module/rework.md)).
- **Choix du vendeur** (`Menu42`, `Menu193`) : `New Facture(False|True)` est **toujours** construit,
  puis affiché sauf si les vendeurs sont activés sans `CodeVendeur`, auquel cas c'est
  `ConVendeurs` (sans argument pour `Menu42`, `True` pour `Menu193`) qui est affiché (FMENU-A09).
- **Caisse POS intégrée** (`Menu332`) : une seule instance (`Object.IsValid(CMenu)`), choix de la
  caisse `Start.$tcai`, puis `Object.Call(CMenu, "Show")` (appel dynamique).
- **Instances paramétrées** : `New Saisecrit("")`, `New Tresor("")`, `New Lettrage("", "")`,
  `New Extrait("", "", "", "")`, `New Edinv("T"|"F")`, `New TarTypeCli(TarTypeCli.client|type)`,
  `New Etiqart("")`, `New Etigond("")`, `New Etiqcasier("")`, `New Materiel("")`, `New Commail("")`,
  `New Emailing("mail"|"sms")`, `New Gsm("")`, `New LGed(Null, 0, LGed.Autres, "", "", "")`,
  `New DB_Sanity(Utils.db)`, `New DB_Log(Utils.db)`, `New Fsoc(Me)`, `New Prefs(…)`.

Légende de la colonne « Remarque » : **mort** = handler inatteignable (menu parent qui possède des
sous-menus, ou séparateur sans texte) ; « aussi » = raccourcis qui appellent le même handler ;
« masqué si » = visibilité pilotée par `Form_Open` ou `Menu*showhide`. Les menus parents et
séparateurs sans handler ne sont pas listés.

| Menu | Chemin (libellé du `.form`) | Handler (lignes) | Écran ouvert / action | Remarque |
|---|---|---|---|---|
| `Menu26` | Paramètres > Sociétés | `Menu26_Click` (630-646) | `New Fsoc(Me)`.Show | mot de passe admin si `/Admin` ; masqué si `/Blocsoc` |
| `Menu25` | Paramètres > Paramètres généraux | `Menu25_Click` (688-700) | `Parametre.Showmodal` | mot de passe admin si `/Admin` |
| `Menu110` | Paramètres > Préférences Locales | `Menu110_Click` (1151-1166) | `New Prefs(Start.LocalSettings)`.ShowModal (préférences locales) | mot de passe admin si `/Admin` |
| `Menu329` | Paramètres > Préférences Globales | `Menu329_Click` (1168-1190) | `New Prefs(Start.GlobalSettings, Null, True)`.ShowModal (mot de passe `AdminG` global via `New MDP(Null, True)`), puis réapplication des globales sur les locales | mot de passe global si `/AdminG` |
| `Menu153` | Paramètres > Couleurs | `Menu153_Click` (1525-1529) | `SetColors.ShowDialog` |  |
| `Menu173` | Paramètres > Maj version | `Menu173_Click` (1674-1687) | `Majversion.Show` | mot de passe admin si `/Admin` ; masqué si installé dans `/usr/bin/Laurux` |
| `Menu118` | Paramètres > Quitter | `Menu118_Click` (1211-1215) | `Me.Close` (→ `form_close`, fin de l'application) | mêmes effets que `ToolButton1` sauf `rm ~/tmp/*` |
| `Menu112` | Gestion > Constantes > TVA sur ventes | `Menu112_Click` (539-543) | `FTvav.Show` | aussi `Tvav` (ToolButton) |
| `Menu300` | Gestion > Constantes > Réglements | `Menu300_Click` (2571-2575) | `Mreglement.Show` |  |
| `Menu17` | Gestion > Constantes > Commentaires | `Menu17_Click` (885-889) | `Comment.Show` |  |
| `Menu326` | Gestion > Constantes > Textes des courriels | `Menu326_Click` (2455-2463) | `New Commail("")`.Showmodal |  |
| `Menu14` | Gestion > Constantes > Familles | `Menu14_Click` (873-877) | `Famille.Show` | aussi `lblFam` |
| `Menu28` | Gestion > Constantes > Taux de main d'oeuvre | `Menu28_Click` (891-895) | `Txmo.Show` |  |
| `Menu130` | Gestion > Constantes > Texte bas de facture | `Menu130_Click` (1318-1322) | `LibelFac.Show` |  |
| `Menu199` | Gestion > Constantes > Texte de "Réserve de propriété" | `Menu199_Click` (1839-1843) | `Tleg.Show` |  |
| `Menu255` | Gestion > Constantes > Texte associé aux courriels facturation | `Menu255_Click` (2090-2094) | `Tmail.Show` |  |
| `Menu315` | Gestion > Constantes > Textes SMS | `Menu315_Click` (2394-2398) | `Sms.Show` | masqué si `/Sms` = 0 |
| `Menu195` | Gestion > Constantes > Civilités | `Menu195_Click` (1815-1819) | `Identite.ShowModal` |  |
| `Menu149` | Gestion > Constantes > Types client | `Menu149_Click` (1421-1425) | `Typec.show` |  |
| `Menu219` | Gestion > Constantes > Statuts clients | `Menu219_Click` (1913-1917) | `Statut.Show` |  |
| `Menu165` | Gestion > Constantes > Types étiquettes | `Menu165_Click` (1620-1624) | `Etiquettes.Show` |  |
| `Menu189` | Gestion > Constantes > Codes postaux | `Menu189_Click` (1737-1741) | `Cpostaux.Show` |  |
| `Menu191` | Gestion > Constantes > Marques | `Menu191_Click` (1762-1766) | `Marques.Show` |  |
| `Menu241` | Gestion > Constantes > Centrales | `Menu241_Click` (2018-2022) | `Centrales.Show` |  |
| `Menu50` | Gestion > Constantes > Utilisateurs | `Menu50_Click` (785-789) | `Fusers.Show` | masqué si `/Taches` faux |
| `Menu327` | Gestion > Constantes > Tournées | `Menu327_Click` (2465-2469) | `Ttourne.Show` |  |
| `Menu12` | Gestion > Tables > Client | `Menu12_Click` (563-567) | `FClient.ShowModal` | aussi `Client` (ToolButton), `lblCli` |
| `Menu13` | Gestion > Tables > Fournisseur | `Menu13_Click` (569-573) | `Ffournisseur.ShowModal` | aussi `Fournisseur` (ToolButton), `lblFour` |
| `Menu15` | Gestion > Tables > Articles | `Menu15_Click` (623-627) | `Articles.Show` | aussi `Article` (ToolButton), `lblArt` |
| `Menu190` | Gestion > Tables > Matériels | `Menu190_Click` (1743-1750) | `New Materiel("")`.Showmodal | visible si `/Materiel` ; aussi `lblMat` |
| `MenuTbq` | Gestion > Tables > Banque | `MenuTbq_Click` (2498-2502) | `Banque.Show` | masqué si `/Lcr` faux |
| `Menu37` | Gestion > Tables > Main d'oeuvre | `Menu37_Click` (909-913) | `Movr.ShowModal` | aussi `Moeuvre` (ToolButton), `lblMO` |
| `Menu287` | Gestion > Tables > Vendeurs | `Menu287_Click` (2240-2244) | `Fvendeurs.Show` | visible si `/Vendeurs` ; même écran que `Menu206` (ShowModal) |
| `Menu312` | Gestion > Tables > Commerciaux | `Menu312_Click` (2376-2380) | `Commerciaux.Show` |  |
| `Menu226` | Gestion > Tables > Remises client par famille | `Menu226_Click` (1943-1947) | `Remisecli.ShowModal` |  |
| `Menu154` | Gestion > Tables > Remises par type client | `Menu154_Click` (1409-1413) | `Remisec.show` | aussi `lblRem` |
| `Menu277` | Gestion > Tables > Tarif par client | `Menu277_Click` (2186-2193) | `New TarTypeCli(TarTypeCli.client)`.Show |  |
| `Menu278` | Gestion > Tables > Tarif par type client | `Menu278_Click` (2195-2202) | `New TarTypeCli(TarTypeCli.type)`.Show |  |
| `Menu288` | Gestion > Tables > Coeff de vente par type client | `Menu288_Click` (2246-2250) | `CoefTypeC.Show` |  |
| `Menu227` | Gestion > Tables > Produits composés | `Menu227_Click` (1949-1953) | `Prodcomposes.ShowModal` |  |
| `Menu42` | Gestion > Facturation > Saisie des documents | `Menu42_Click` (921-947) | `New Facture(False)`.ShowModal, ou `New ConVendeurs`.ShowModal si vendeurs actifs sans `CodeVendeur` | contrôle réplication ; aussi `ToolButton2`, `lblFac` ; Facture construite même si non affichée |
| `Menu193` | Gestion > Facturation > Saisie des factures entretien | `Menu193_Click` (1768-1794) | `New Facture(True)`.ShowModal, ou `New ConVendeurs(True)`.ShowModal (même règle que Menu42) | contrôle réplication ; visible si `/Materiel` ; aussi `lblFac2` |
| `Menu138` | Gestion > Facturation > Factures fin de mois | `Menu138_Click` (1354-1366) | `Facturefm.ShowModal` | contrôle réplication ; `lblFacfm` ouvre le même écran **sans** contrôle réplication |
| `Menu299` | Gestion > Facturation > Facturation périodique | `Menu299_Click` (2314-2326) | `FacturefmA.ShowModal` | contrôle réplication ; masqué si `/Faca` = 0 |
| `Menu306` | Gestion > Facturation > Regroupement des BL | `Menu306_Click` (2349-2353) | `Facturergbl.ShowModal` | masqué par `Menuopt` (options bois / pp) |
| `Menu194` | Gestion > Facturation > Bordereaux des réglements (ancienne version) | `Menu194_Click` (1803-1807) | `Edpaiement.ShowModal` |  |
| `brdreg` | Gestion > Facturation > Saisie des règlements | `brdreg_Click` (1809-1813) | `SaiReg.ShowModal` | aussi `rglmt` (ToolButton), `lbsr` |
| `Menu265` | Gestion > Facturation > LCR > Liste des traites | `Menu265_Click` (2132-2136) | `Traites.Show` | sous-menu LCR masqué si `/Lcr` faux |
| `MenuTrlcr` | Gestion > Facturation > LCR > Traitements LCR non attribuées | `MenuTrlcr_Click` (2504-2508) | `Lcr.Show` | sous-menu LCR masqué si `/Lcr` faux |
| `MenuAbq` | Gestion > Facturation > LCR > Attribution banques | `MenuAbq_Click` (2510-2514) | `Attribution.Show` | sous-menu LCR masqué si `/Lcr` faux |
| `Menuprep` | Gestion > Facturation > LCR > Préparation des bordereaux | `Menuprep_Click` (2516-2520) | `Preparation.Show` | sous-menu LCR masqué si `/Lcr` faux |
| `MenuGbrd` | Gestion > Facturation > LCR > Gestion des bordereaux | `MenuGbrd_Click` (2522-2526) | `Bordrx.Show` | sous-menu LCR masqué si `/Lcr` faux |
| `Menuis` | Gestion > Facturation > LCR > Impression / suppression LCR | `Menuis_Click` (2528-2532) | `Glcr.Show` | sous-menu LCR masqué si `/Lcr` faux |
| `Menu254` | Gestion > Facturation > Liste des documents en cours | `Menu254_Click` (2084-2088) | `EdDocs.Show` |  |
| `Menu106` | Gestion > Facturation > (Menu106) | `Menu106_Click` (1145-1149) | `EdNlettrees.Show` | **mort** : séparateur (sans texte) ; doublon de `Menu103` |
| `Menu72` | Gestion > Facturation > Archives | `Menu72_Click` (955-959) | `Archives.ShowModal` |  |
| `Menu309` | Gestion > GED > Acquisition | `Menu309_Click` (2355-2362) | `New LGed(Null, 0, LGed.Autres, "", "", "")`.Show |  |
| `Menu310` | Gestion > GED > Recherche/Edition/Suppression | `Menu310_Click` (2364-2368) | `GedR.Show` |  |
| `Menu221` | Gestion > Promotions > Tables des promotions | `Menu221_Click` (1919-1923) | `Fpromo.ShowModal` |  |
| `Menu222` | Gestion > Promotions > Articles en promotion | `Menu222_Click` (1925-1929) | `FpromoArt.ShowModal` |  |
| `Menu223` | Gestion > Promotions > Statistiques promotions | `Menu223_Click` (1931-1935) | `StatPromo.ShowModal` |  |
| `Menu225` | Gestion > Promotions > Etiquettes promotion | `Menu225_Click` (1937-1941) | `EtiqPromo.ShowModal` |  |
| `Menu73` | Gestion > Impression des tables > Tarif > Interne | `Menu73_Click` (855-859) | `EdArt1.Show` |  |
| `Menu74` | Gestion > Impression des tables > Tarif > Client | `Menu74_Click` (861-865) | `EdArt4.Show` |  |
| `Menu297` | Gestion > Impression des tables > Tarif > Type client (coeff"T\ | `Menu297_Click` (2302-2306) | `EdArt3.ShowModal` |  |
| `Menu54` | Gestion > Impression des tables > Familles | `Menu54_Click` (809-813) | `EdFam.Show` |  |
| `Menu59` | Gestion > Impression des tables > Main d'oeuvre | `Menu59_Click` (821-825) | `Edmo.Show` |  |
| `Menu101` | Gestion > Impression des tables > Clients | `Menu101_Click` (1270-1274) | `EdClient.Show` |  |
| `Menu108` | Gestion > Impression des tables > Fournisseurs | `Menu108_Click` (1276-1280) | `EDfour.Show` |  |
| `Menu289` | Gestion > Impression des tables > Matériels | `Menu289_Click` (2252-2256) | `EdMat.Show` |  |
| `Menu161` | Gestion > Impression des tables > Etiquettes > Articles | `Menu161_Click` (1590-1597) | `New Etiqart("")`.Showmodal | doublon de `Menu157` |
| `Menu162` | Gestion > Impression des tables > Etiquettes > Gondole | `Menu162_Click` (1599-1606) | `New Etigond("")`.Showmodal | doublon de `Menu158` |
| `Menu163` | Gestion > Impression des tables > Etiquettes > Clients | `Menu163_Click` (1608-1612) | `Eticli.show` |  |
| `Menu302` | Gestion > Impression des tables > Etiquettes > Casier | `Menu302_Click` (2328-2335) | `New Etiqcasier("")`.Showmodal |  |
| `Menu88` | Gestion > Stock > Commande fournisseur | `Menu88_Click` (1011-1023) | `Commande1.show` | contrôle réplication ; aussi `Com` (ToolButton), `lblCom` |
| `Menu295` | Gestion > Stock > Validation des réceptions | `Menu295_Click` (2282-2294) | `ValidBR1.ShowModal` | contrôle réplication ; aussi `lblVrecpt` |
| `Menu253` | Gestion > Stock > Impression des produits a commander | `Menu253_Click` (2078-2082) | `EdRup.Show` |  |
| `mvst` | Gestion > Stock > Interrogation des mouvements de stock | `mvst_Click` (2471-2475) | `Stockmvt.Show` |  |
| `Menu325` | Gestion > Stock > Préparation des livraisons | `Menu325_Click` (2449-2453) | `EdPrep.Show` |  |
| `Menu79` | Gestion > Stock > Régularisation | `Menu79_Click` (991-1003) | `Mvtex.showModal` | contrôle réplication ; aussi `Mvt` (ToolButton), `lblRgl` |
| `Menu229` | Gestion > Stock > Effacement des mouvements | `Menu229_Click` (1955-1959) | `EpurMvtexp.ShowModal` |  |
| `Menu268` | Gestion > Stock > Dépôts > Table des dépôts | `Menu268_Click` (2150-2154) | `Depots.Show` |  |
| `Menu269` | Gestion > Stock > Dépôts > Transfert dépôts | `Menu269_Click` (2156-2160) | `MvtDepots.Show` |  |
| `Menu270` | Gestion > Stock > Dépôts > Sorties manuelles | `Menu270_Click` (2162-2166) | `Sdepots.show` |  |
| `Menu272` | Gestion > Stock > Dépôts > Impressions > Impression stock dépôts | `Menu272_Click` (2168-2172) | `ImpDepots.show` |  |
| `Menu273` | Gestion > Stock > Dépôts > Impressions > Impression des mouvements | `Menu273_Click` (2174-2178) | `Edsdepots.Show` |  |
| `Menu230` | Gestion > Stock > Entrées des produits composés | `Menu230_Click` (1961-1973) | `MvtProdcomp.ShowModal` | contrôle réplication |
| `Menu156` | Gestion > Stock > Etiquettes | `Menu156_Click` (1415-1419) | `Carch.show` | **mort** : menu parent (sous-menus) ; seul point d'entrée vers `Carch` |
| `Menu157` | Gestion > Stock > Etiquettes > Etiquettes articles | `Menu157_Click` (1572-1579) | `New Etiqart("")`.Showmodal | doublon de `Menu161` |
| `Menu158` | Gestion > Stock > Etiquettes > Etiquettes gondole | `Menu158_Click` (1581-1588) | `New Etigond("")`.Showmodal | doublon de `Menu162` |
| `Menu164` | Gestion > Stock > Etiquettes > Etiquettes préparées | `Menu164_Click` (1614-1618) | `EtiqRecpt.show` |  |
| `Menu242` | Gestion > Stock > Etiquettes > Etiquettes future base tarif | `Menu242_Click` (2024-2028) | `Etiqfbtarif.ShowModal` | doublon de `Menu247` |
| `Menu95` | Gestion > Stock > Inventaire tournant > Génération | `Menu95_Click` (1089-1093) | `GeninvT.Showmodal` |  |
| `Menu96` | Gestion > Stock > Inventaire tournant > Saisie | `Menu96_Click` (1095-1099) | `SaisieinvT.Show` |  |
| `Menu98` | Gestion > Stock > Inventaire tournant > Impression  des écarts | `Menu98_Click` (1107-1111) | `EcartsT.Show` |  |
| `Menu97` | Gestion > Stock > Inventaire tournant > Impression  des non saisis | `Menu97_Click` (1101-1105) | `EdnsaisisT.Show` |  |
| `Menu99` | Gestion > Stock > Inventaire tournant > Impression de l'inventaire tournant | `Menu99_Click` (1113-1119) | `New Edinv("T")`.Show |  |
| `Menu100` | Gestion > Stock > Inventaire tournant > Validation de l'inventaire tournant | `Menu100_Click` (1121-1125) | `ValidinvT.Show` |  |
| `Menu233` | Gestion > Stock > Inventaire tournant > Suppression de l'inventaire | `Menu233_Click` (1981-1985) | `RazInvT.ShowModal` |  |
| `Menu81` | Gestion > Stock > Inventaire de fin d'exercice > Génération | `Menu81_Click` (1050-1054) | `Geninv.Show` |  |
| `Menu82` | Gestion > Stock > Inventaire de fin d'exercice > Saisie | `Menu82_Click` (1056-1060) | `Saisieinv.Show` |  |
| `Menu83` | Gestion > Stock > Inventaire de fin d'exercice > Impression des écarts | `Menu83_Click` (1068-1072) | `Ecarts.Show` |  |
| `Menu93` | Gestion > Stock > Inventaire de fin d'exercice > Impression  des non saisis | `Menu93_Click` (1083-1087) | `Ednsaisis.Show` |  |
| `Menu85` | Gestion > Stock > Inventaire de fin d'exercice > Impression  de l'inventaire | `Menu85_Click` (1074-1081) | `New Edinv("F")`.Show |  |
| `Menu84` | Gestion > Stock > Inventaire de fin d'exercice > Validation de l'inventaire | `Menu84_Click` (1062-1066) | `Validinv.Show` |  |
| `Menu232` | Gestion > Stock > Inventaire de fin d'exercice > Suppression de l'inventaire | `Menu232_Click` (1975-1979) | `RazInv.ShowModal` |  |
| `Menu92` | Gestion > Stock > Impressions > Commandes fournisseurs | `Menu92_Click` (1044-1048) | `Edcom.Show` |  |
| `Menu90` | Gestion > Stock > Impressions > Bons de réception | `Menu90_Click` (1032-1036) | `Edbl.Show` |  |
| `Menu91` | Gestion > Stock > Impressions > Régularisations | `Menu91_Click` (1038-1042) | `Edregul.Show` |  |
| `Menu264` | Gestion > Stock > Impressions > Entrées des produits composés | `Menu264_Click` (2138-2142) | `Edregulprdc.Show` |  |
| `Menu102` | Gestion > Stock > Impressions > Stock | `Menu102_Click` (1127-1131) | `EdStk.Show` |  |
| `Menu234` | Gestion > Stock > Suppression des articles | `Menu234_Click` (1987-1991) | `SupprArt.ShowModal` |  |
| `Menu186` | Gestion > Stock > Tarif > Import et Maj articles | `Menu186_Click` (1731-1735) | `Impart.ShowModal` |  |
| `Menu246` | Gestion > Stock > Tarif > Future base tarif > Maj future base tarif | `Menu246_Click` (2036-2040) | `MajFbtarif2.Showmodal` |  |
| `Menu247` | Gestion > Stock > Tarif > Future base tarif > Etiquettes future base tarif | `Menu247_Click` (2042-2046) | `Etiqfbtarif.ShowModal` | doublon de `Menu242` |
| `Menu248` | Gestion > Stock > Tarif > Maj Tarif en % | `Menu248_Click` (2048-2052) | `MajTarifP.show` |  |
| `Menu249` | Gestion > Stock > Tarif > Maj tarif manuelle | `Menu249_Click` (2054-2058) | `MajTarifM.Show` |  |
| `Menu245` | Gestion > Stock > Tarif > Table des fichiers d'import | `Menu245_Click` (2030-2034) | `ImpartParam.ShowModal` |  |
| `Menu275` | Gestion > Stock > Mise à jour code casier | `Menu275_Click` (2180-2184) | `Majcasier.Show` |  |
| `Menu104` | Gestion > Statistiques | `Menu104_Click` (1139-1143) | `EDfour.Show` | **mort** : menu parent (sous-menus) ; même écran que `Menu108` |
| `Menu251` | Gestion > Statistiques > Tableau de bord | `Menu251_Click` (2066-2070) | `TBord.Show` |  |
| `Menu176` | Gestion > Statistiques > Chiffre d'affaire type client | `Menu176_Click` (1701-1705) | `StatTypCli.Show` |  |
| `Menu313` | Gestion > Statistiques > CA clients/commerciaux | `Menu313_Click` (2382-2386) | `StatComm.Show` |  |
| `Menu314` | Gestion > Statistiques > CA articles/commerciaux | `Menu314_Click` (2388-2392) | `StatComArt.Show` |  |
| `Menu117` | Gestion > Statistiques > Chiffre d'affaire produits-Mo par client | `Menu117_Click` (1205-1209) | `StatClimo.Show` |  |
| `Menu143` | Gestion > Statistiques > Qté MO vendues pour une période | `Menu143_Click` (1368-1372) | `Histovmo.Show` |  |
| `Menu169` | Gestion > Statistiques > Chiffre d'affaire fournisseur | `Menu169_Click` (1646-1650) | `StatFour.show` |  |
| `Menu318` | Gestion > Statistiques > Statistiques et relevés détaillés | `Menu318_Click` (2409-2413) | `Histocliart.Show` |  |
| `Menu196` | Gestion > Statistiques > Relevé MO par client | `Menu196_Click` (1821-1825) | `RelvMo.Show` |  |
| `Menu197` | Gestion > Statistiques > Recapitulatif MO-produit par client | `Menu197_Click` (1827-1831) | `RelMoprod.Show` |  |
| `Menu250` | Gestion > Statistiques > Statistiques utilisation base Laurux | `Menu250_Click` (2060-2064) | `Statbase.ShowModal` |  |
| `Menu259` | Gestion > Epurations > Epuration des factures archivées | `Menu259_Click` (2102-2106) | `RazHistoFac.ShowModal` |  |
| `Menu260` | Gestion > Epurations > Epuration des tickets de caisse | `Menu260_Click` (2108-2112) | `RazHistoTk.ShowModal` |  |
| `Menu261` | Gestion > Epurations > Epuration des BL fournisseurs | `Menu261_Click` (2114-2118) | `RazHistoFbl.ShowModal` |  |
| `Menu290` | Gestion > Epurations > Epuration des devis | `Menu290_Click` (2258-2262) | `RazDevis.ShowModal` |  |
| `Menu296` | Gestion > Epurations > Epuration des clients divers caisses | `Menu296_Click` (2296-2300) | `RazClientd.ShowModal` | visible si `/Caisse` |
| `Menu145` | Gestion > Outils > Changement famille/code | `Menu145_Click` (1374-1378) | `Changefam.ShowModal` |  |
| `Menu305` | Gestion > Outils > Changement fournisseur | `Menu305_Click` (2343-2347) | `Changefour.ShowModal` |  |
| `Menu168` | Gestion > Outils > Recalcul des stocks | `Menu168_Click` (1640-1644) | `Calcstock.ShowModal` |  |
| `Menu328` | Gestion > Outils > Liste des documents actifs (ouvert) | `Menu328_Click` (2477-2481) | `DocActif.Show` |  |
| `Menu152` | Gestion > Outils > Import des clients | `Menu152_Click` (1566-1570) | `Impclient.show` |  |
| `Menu170` | Gestion > Outils > Export des clients | `Menu170_Click` (1652-1656) | `Expclient.show` |  |
| `Menu283` | Gestion > Outils > Export des contacts | `Menu283_Click` (2222-2226) | `Expcontact.Show` |  |
| `Menu281` | Gestion > Outils > Export des articles | `Menu281_Click` (2210-2214) | `Expart.Show` |  |
| `Menu279` | Gestion > Outils > RAZ zones article | `Menu279_Click` (2204-2208) | `RazArt.Show` |  |
| `Menu141` | Gestion > Outils > (Menu141) | `Menu141_Click` (1348-1352) | `Prgm.Show` | **mort** : séparateur (sans texte) ; doublon de `Menu282` |
| `Menu284` | Gestion > Outils > Import des codes postaux | `Menu284_Click` (2228-2232) | `Impcpostaux.Show` |  |
| `Menu282` | Gestion > Outils > Appel programme | `Menu282_Click` (2216-2220) | `Prgm.show` | même écran que `Menu141` (mort) |
| `Menu175` | Gestion > E-mailing | `Menu175_Click` (1664-1672) | `New Emailing("mail")`.Showmodal |  |
| `Menu319` | Gestion > SMS > Envoi unique | `Menu319_Click` (2400-2407) | `New Gsm("")`.Showmodal |  |
| `Menu320` | Gestion > SMS > Envoi multiples | `Menu320_Click` (2415-2423) | `New Emailing("sms")`.Showmodal |  |
| `Menu184` | Gestion > Boutique > Saisie et envoi des produits | `Menu184_Click` (1725-1729) | `Btqart.ShowModal` | visible si `/Btq` |
| `Menu147` | Gestion > Clôture mensuelle | `Menu147_Click` (1380-1392) | `ClotureF.ShowModal` | contrôle réplication ; `lblClm` ouvre le même écran **sans** contrôle réplication |
| `Menu332` | Caisse > Caisse (Laurux-Pos) | `Menu332_Click` (2534-2552) | `New Cmenu` (caisse POS dans la session Gestion, une seule instance ; `Start.$tcai`) | sous-menu Caisse visible si `/Caisse` ; appel dynamique `Object.Call(CMenu, "Show")` |
| `Menu205` | Caisse > Constantes > Fiches caisses | `Menu205_Click` (1851-1855) | `Fcaisses.ShowModal` |  |
| `Menu206` | Caisse > Constantes > Fiches vendeurs(ses) | `Menu206_Click` (1863-1867) | `Fvendeurs.ShowModal` | même écran que `Menu287` (Show) |
| `Menu207` | Caisse > Constantes > Libellé bas de ticket | `Menu207_Click` (1857-1861) | `LibelTicket.ShowModal` |  |
| `Menu208` | Caisse > Constantes > Libellé avoir | `Menu208_Click` (1875-1879) | `LibelAvoirs.ShowModal` |  |
| `Menu209` | Caisse > Constantes > Compte client caisse | `Menu209_Click` (1881-1885) | `Fclientc.ShowModal` |  |
| `Menu238` | Caisse > Carte de fidélité > Table des cartes | `Menu238_Click` (2000-2004) | `FClientcarte.ShowModal` |  |
| `Menu239` | Caisse > Carte de fidélité > Hit parade des cartes | `Menu239_Click` (2006-2010) | `HitCarte.ShowModal` |  |
| `Menu240` | Caisse > Carte de fidélité > Emailing | `Menu240_Click` (2012-2016) | `EmailingCarte.ShowModal` |  |
| `Menu214` | Caisse > Opérations de fin de journée > Impressions des bordereaux | `Menu214_Click` (1869-1873) | `Bordereaux.ShowModal` |  |
| `Menu215` | Caisse > Opérations de fin de journée > Moulinage des tickets | `Menu215_Click` (1887-1899) | `Moulinage.ShowModal` | contrôle réplication |
| `Menu204` | Caisse > Statistiques caisses > CA journalier | `Menu204_Click` (1907-1911) | `Statcai.Showmodal` |  |
| `Menu218` | Caisse > Statistiques caisses > Historique tickets | `Menu218_Click` (1901-1905) | `ArchivesTck.ShowModal` |  |
| `Menu111` | Comptabilité > Constantes > Comptes Collectifs | `Menu111_Click` (551-555) | `Fcollectif.show` | aussi `Collectif` (ToolButton) |
| `Menu113` | Comptabilité > Constantes > TVA sur achat | `Menu113_Click` (545-549) | `FTvac.show` | aussi `Tvac` (ToolButton) |
| `Menu114` | Comptabilité > Constantes > Comptes | `Menu114_Click` (533-537) | `Fcomptes.Show` | aussi `Compte` (ToolButton) |
| `Menu115` | Comptabilité > Constantes > Journaux | `Menu115_Click` (557-561) | `Fjournaux.show` | même écran que `Journal` (ToolButton) |
| `Menu24` | Comptabilité > Constantes > Libellés des saisies | `Menu24_Click` (682-686) | `Flibelle.Show` | aussi `Libellesaisies` (ToolButton) |
| `Menu131` | Comptabilité > Constantes > Echéances | `Menu131_Click` (1324-1328) | `echeances.ShowModal` |  |
| `Menu198` | Comptabilité > Constantes > Masques de saisies | `Menu198_Click` (1833-1837) | `Abont.show` |  |
| `Menu294` | Comptabilité > Constantes > Postes analytiques | `Menu294_Click` (2276-2280) | `FPostes.show` |  |
| `Menu21` | Comptabilité > Saisies > Saisies des écritures | `Menu21_Click` (648-663) | `New Saisecrit("")`.Show | contrôle réplication ; aussi `Achat` (ToolButton) |
| `Menu22` | Comptabilité > Saisies > Saisies de la trésorerie | `Menu22_Click` (665-680) | `New Tresor("")`.Showmodal | contrôle réplication ; aussi `Tsr` (ToolButton) |
| `Menu128` | Comptabilité > Traitement des écarts | `Menu128_Click` (1300-1304) | `Trecarts.Show` |  |
| `Menu27` | Comptabilité > Relances > Saisie des textes | `Menu27_Click` (773-777) | `Frelance.Show` |  |
| `Menu49` | Comptabilité > Relances > Préparation des relances | `Menu49_Click` (779-783) | `FEditrel.Show` |  |
| `Menu52` | Comptabilité > Relevés > De facture | `Menu52_Click` (797-801) | `FRelFacture.Show` |  |
| `Menu30` | Comptabilité > Relevés > De compte | `Menu30_Click` (791-795) | `FRelcompte.Show` |  |
| `Menu303` | Comptabilité > Echéanciers | `Menu303_Click` (2337-2341) | `Echeancier.ShowModal` |  |
| `Menu321` | Comptabilité > Bordereaux chèques (ancienne version) | `Menu321_Click` (2425-2429) | `BordereauxC.showmodal` |  |
| `Menu51` | Comptabilité > Lettrage > Lettrage manuel | `Menu51_Click` (708-715) | `New Lettrage("", "")`.Showmodal | aussi `ToolButton7` |
| `Menu126` | Comptabilité > Lettrage > Lettrage par montant | `Menu126_Click` (1288-1292) | `Lettragemontant.show` |  |
| `Menu127` | Comptabilité > Lettrage > Lettrage des comptes soldés | `Menu127_Click` (1294-1298) | `Lettragesoldes.show` |  |
| `Menu61` | Comptabilité > Rapp. bancaire > Saisie des rapprochements | `Menu61_Click` (717-721) | `Pointage.Show` | aussi `ToolButton3` |
| `Menu38` | Comptabilité > Impressions > Grands livres | `Menu38_Click` (702-706) | `Editcompte.Show` |  |
| `Menu31` | Comptabilité > Impressions > Balances | `Menu31_Click` (739-743) | `Balance.Show` |  |
| `Menu32` | Comptabilité > Impressions > Journaux | `Menu32_Click` (745-749) | `journaux.Show` |  |
| `Menu109` | Comptabilité > Impressions > Journaux centralisateurs | `Menu109_Click` (1192-1196) | `jourcent.Show` |  |
| `Menu292` | Comptabilité > Impressions > Analytiques > Journaux | `Menu292_Click` (2264-2268) | `JournauxA.ShowModal` |  |
| `Menu293` | Comptabilité > Impressions > Analytiques > Comptes | `Menu293_Click` (2270-2274) | `EditcompteA.ShowModal` |  |
| `Menu263` | Comptabilité > Impressions > Récapitulatif TVA | `Menu263_Click` (2126-2130) | `FTVA.show` |  |
| `Menu103` | Comptabilité > Impressions > Ecritures non lettrées | `Menu103_Click` (1133-1137) | `EdNlettrees.Show` |  |
| `Menu252` | Comptabilité > Impressions > Ecritures non justifiées | `Menu252_Click` (2072-2076) | `EdNjustifiees.Show` |  |
| `Menu323` | Comptabilité > Impressions > Ecritures modifiées/supprimées | `Menu323_Click` (2431-2435) | `EcrM.Show` |  |
| `Menu324` | Comptabilité > Impressions > Anomalies des clés | `Menu324_Click` (2443-2447) | `Anomalies.Show` |  |
| `Menu70` | Comptabilité > Impressions > Plan comptable | `Menu70_Click` (879-883) | `Plancomptable.Show` |  |
| `Menu16` | Comptabilité > Extrait de compte > Visualisation | `Menu16_Click` (723-731) | `New Extrait("", "", "", "")`.Showmodal | aussi `ToolButton6` |
| `Menu40` | Comptabilité > Extrait de compte > Recherche d'un montant | `Menu40_Click` (803-807) | `Fmontant.Show` | aussi `ToolButton5` |
| `Menu10` | Comptabilité > Extrait de compte > Visu/modif des écritures | `Menu10_Click` (903-907) | `Ecritures.Show` | aussi `ToolButton4` |
| `Menu122` | Comptabilité > Compte de résultat > Gestion des rubriques | `Menu122_Click` (1246-1250) | `Rubresult.Show` |  |
| `Menu123` | Comptabilité > Compte de résultat > Gestion des comptes | `Menu123_Click` (1252-1256) | `Rubcompt.Show` |  |
| `Menu124` | Comptabilité > Compte de résultat > Impression | `Menu124_Click` (1258-1262) | `RubImp.Show` |  |
| `Menu121` | Comptabilité > Compte de résultat > (Menu121) | `Menu121_Click` (1217-1221) | `Me.Close` | **mort** : séparateur (sans texte) ; doublon de `Menu118` |
| `Menu46` | Comptabilité > Clotures > Clôture de période | `Menu46_Click` (759-771) | `FCloture.ShowModal` | contrôle réplication |
| `Menu60` | Comptabilité > Clotures > Clôture annuelle | `Menu60_Click` (841-853) | `FClotureAn.Show` | contrôle réplication |
| `Menu76` | Comptabilité > Outils > Recalcul des soldes | `Menu76_Click` (967-971) | `Calcsolde.ShowModal` |  |
| `Menu132` | Comptabilité > Outils > Vérification des balances | `Menu132_Click` (1330-1334) | `Verbal.ShowModal` |  |
| `Menu262` | Comptabilité > Outils > Epuration des relevés bancaires | `Menu262_Click` (2120-2124) | `RazRlvb.ShowModal` |  |
| `Menu311` | Comptabilité > Outils > Déblocage écritures | `Menu311_Click` (2370-2374) | `RazClos.ShowModal` |  |
| `Menu133` | Comptabilité > Outils > Export des journaux | `Menu133_Click` (1336-1340) | `ExportJdv.ShowModal` | visible si `/Exp` |
| `Menu298` | Comptabilité > Outils > Export fichier A47 (FEC) | `Menu298_Click` (2308-2312) | `ExportA47.ShowModal` |  |
| `Menu134` | Comptabilité > Outils > Import du JDV Laurux | `Menu134_Click` (1342-1346) | `ImpJdv.ShowModal` | visible si `/Exp` faux |
| `Menu286` | Comptabilité > Outils > Import écritures Sage | `Menu286_Click` (2234-2238) | `ImpSage.ShowModal` |  |
| `Menuimpfec` | Comptabilité > Outils > Import fichier FEC | `Menuimpfec_Click` (2492-2496) | `impfec.Show` |  |
| `Menu180` | Comptabilité > Outils > Import Ciel Expert > Tables de correspondance > Table des clients et fournisseurs | `Menu180_Click` (1713-1717) | `Cielcorsp.ShowModal` |  |
| `Menu181` | Comptabilité > Outils > Import Ciel Expert > Tables de correspondance > Table des journaux | `Menu181_Click` (1707-1711) | `Cielcorspj.ShowModal` |  |
| `Menu182` | Comptabilité > Outils > Import Ciel Expert > Import des écritures | `Menu182_Click` (1719-1723) | `Cielimp.ShowModal` |  |
| `Menu150` | Comptabilité > Outils > Duplication de société | `Menu150_Click` (1394-1406) | `Dup.showModal` | mot de passe admin si `/Admin` |
| `Menu57` | Base > Sauvegarde | `Menu57_Click` (815-819) | `FSauve.Show` |  |
| `Menu65` | Base > Restauration | `Menu65_Click` (827-839) | `FRestore.ShowModal` | mot de passe admin si `/Admin` |
| `Menu166` | Base > Connexion nouvelle base | `Menu166_Click` (1626-1638) | `LauruxConf.Show` | mot de passe admin si `/Admin` |
| `Menu171` | Base > Envoi base | `Menu171_Click` (1658-1662) | `Expbase.show` |  |
| `Menu142` | Base > Contrôle de la base | `Menu142_Click` (2554-2569) | `New DB_Sanity(Utils.db)`.ShowModal (lit `db_control.csv` du répertoire courant) | mot de passe admin si `/Admin` (abandon si refus) |
| `Menu330` | Base > Debug Log | `Menu330_Click` (2484-2490) | `New DB_Log(Utils.db)`.Show |  |
| `Menu202` | Agenda > Agenda | `Menu202_Click` (1845-1849) | `Agenda.show` |  |
| `Menu201` | Agenda > (Menu201) | `Menu201_Click` (1198-1202) | `StatClimo.Show` | **mort** : séparateur (sans texte) ; doublon de `Menu117` |
| `Menu23` | ? > Concernant Laurux | `Menu23_Click` (733-737) | `Fabout.Show` |  |
| `Menu266` | ? > Information système | `Menu266_Click` (2144-2148) | `Fsystem.show` |  |
| `Menu63` | ? > Aide Html | `Menu63_Click` (1689-1693) | `Doc.Open("LauruxIndexParCategories")` (navigateur) |  |
| `Menu125` | ? > Astuces | `Menu125_Click` (1282-1286) | `FTips.Show` |  |
| `Menu64` | ? > Connexion site Laurux | `Menu64_Click` (1695-1699) | `xdg-open http://www.laurux.fr` |  |
| `Menu256` | ? > Mon IP | `Menu256_Click` (2096-2100) | `Monip.Monip()` |  |
| `Menu331` | (icône « stop », barre de menus) | — | aucune | **aucun handler** : clic sans effet (voir A) |

**Handlers inatteignables (6)** : `Menu104_Click` (« Gestion > Statistiques », parent → `EDfour`),
`Menu156_Click` (« Gestion > Stock > Etiquettes », parent → `Carch`, seul point d'entrée de
[`Carch`](../../Utils/Carch.class/architecture.md), voir CARCH-A01/A02), et quatre séparateurs sans
texte : `Menu106_Click` (→ `EdNlettrees`), `Menu121_Click` (→ `Me.Close`), `Menu141_Click` (→
`Prgm`), `Menu201_Click` (→ `StatClimo`). Leur suppression touche des handlers de contrôles du
`.form` : elle est classée en anomalie (FMENU-A12). `Menu331` (icône « stop » de la barre de
menus) n'a **aucun** handler (FMENU-A11).

**Doublons fonctionnels** (même écran, deux entrées) : `Menu157`/`Menu161` (`Etiqart`),
`Menu158`/`Menu162` (`Etigond`), `Menu242`/`Menu247` (`Etiqfbtarif`), `Menu206`/`Menu287`
(`Fvendeurs`, `ShowModal` contre `Show`), `Menu282`/`Menu141`, `Menu103`/`Menu106`,
`Menu108`/`Menu104`, `Menu117`/`Menu201`.

## État global utilisé

- **`Start`** : `Societe`, `LocalSettings` (une cinquantaine de clés `/Soc<XX>/…`, `/Coul/…`,
  `/dbase/…`, `/intitule`, `/son`, `/Tips`), `GlobalSettings` (écrit), `Motdepasse` (lu, remis à
  `""`), `son`, `NoTips` (écrit), `$tcai` (écrit par `Menu332`), `Restore_Args`, `UnLock`.
- **`Utils`** : `db` (connexion), `glb`, `monteTunnel`, `fermeTunnel`, `ControlTunnel`, `Base` +
  `rs1` (grille des tâches), `cdate_dbase`, `Observers`, `Exit`.
- **`Cbase.Table`** : `TabSoc`, `TabPromo`, `TabBl`, `TabCli`. Tables en dur : `Fiches_TarTemp`,
  `Fiches_Taches` (pas de clé `Cbase` correspondante).
- Membres `Public` de l'instance : `Soc`, `intitule`, `CpTable` (usage interne seulement),
  `Version`, `PsX`, `PsY` (**jamais utilisés**).
- Auto-instance : `Prefs`, `Fsoc`, `LauruxConf` et `Cmenu` écrivent `Fmenu.Text` ou appellent
  `Fmenu.Menu*showhide` via le nom de classe (FMENU-A13).

## Propositions d'amélioration

### Réécriture / refactorisation

- `Form_Open` (CC 54) : découper en sous-procédures privées appelées dans le même ordre —
  `AppliqueOptionsMenus()`, `ImageFond()`, `OuvreConnexion() As Boolean`, `RappelsDuJour()`,
  `InitTaches()` — en conservant le `Catch` final et la sémantique du `If Error` de la ligne 143
  (qui teste le `Try` de la ligne 88).
- Rappels de promotion : les deux blocs (début / fin) sont identiques à la colonne et au texte près
  → helper `RappelPromo(colonne, texte_synthese, texte_message)` (même SQL).
- `Abonnement` : extraire le calcul dans une fonction pure, et remplacer les quatre blocs
  mensuel/bimestriel/trimestriel/semestriel (identiques à la période près) par un seul bloc
  paramétré par le nombre de mois — en conservant **à l'identique** le calcul erroné du passage
  d'année tant que FMENU-A01 n'est pas validée.
- `Menushowhide`…`Menu4showhide` : un helper privé `Affiche(bVisible, menus As Object[])`, les quatre
  signatures `Public` restant inchangées.

### Commonalisation avec d'autres fichiers

- **Contrôle de réplication** : les 14 tests de `Fmenu`, celui de `Start.module:112` et celui de
  `Facture.class:1520` → une fonction `Utils.ReplicationOK(Optional sMessage As String) As Boolean`
  (renvoie `True` si la réplication n'est pas configurée ou si `ControlTunnel` réussit ; affiche le
  message sinon). Voir [Utils](../../Utils/Utils.module/architecture.md),
  [Start](../../Start.module/architecture.md),
  [Facture](../../Gestion/Facturation/Facture.class/architecture.md).
- **Accès administrateur** : les 8 blocs `MDP.ShowModal`/`Motdepasse` de `Fmenu` et celui de
  `Fsoc.class:400-408` → une fonction statique `MDP.Autorise(Optional Glob As Boolean) As Boolean`
  (voir [MDP](../MDP.class/architecture.md), MDP-003). `Fsoc` case 6 et `Menu150` ouvrent tous
  deux `Dup` derrière ce même bloc.
- **Ouverture de la connexion** : `Form_Open` et [`Cmenu._new`](../../Caisse/Cmenu.class/architecture.md)
  enchaînent `Utils.glb`, `monteTunnel`, `db.Open`, `SET NAMES`, puis lisent le libellé de la
  société (`TabSoc`, `cd_sc`) ; `LauruxConf.class:292-297` refait la même lecture de libellé. Un
  helper `Utils.LibelleSociete(code) As String` couvrirait les trois lectures. Les deux séquences de
  connexion diffèrent (`ALTER DATABASE` côté caisse, `sql_mode` côté gestion) : ne commonaliser que
  la lecture du libellé.
- **Couleurs par défaut** : `preferences()` (l. 437-456) duplique `Start.module:132-155` et
  `SetColors.Button2_Click`/`Button3_Click` — voir [SETCOLORS-005](../../Utils/SetColors.class/rework.md)
  et [CFormat](../../Utils/CFormat.class/architecture.md). Les chaînes doivent être conservées
  caractère pour caractère (virgules comprises) tant que FMENU-A03 n'est pas validée.
- **`SetObserver`** : `Cmenu`, `Ouverture`, `Preferences`, `Fondcaisse` (dossier `Caisse`) ont
  chacun un `SetObservers(hClass, hCont)` récursif proche ; un parcours générique
  `Utils.ParcourtControles(hCont, filtre)` pourrait être partagé (phase 3, après documentation du
  lot Caisse).

### Réduction de portée

- `RecupTaches`, `preferences`, `Config`, `Abonnement`, `SetObserver` : aucun appelant externe
  (vérifié par `grep -rn` sur `.src`) → `Private`. Ils restent couverts par les replays de
  démarrage (règle de portée du PLAN §6).
- `Soc`, `intitule`, `CpTable` → `Private` (les `Soc` et `intitule` d'autres fichiers sont leurs
  propres variables ou contrôles).
- `Version`, `PsX`, `PsY` : jamais lus ni écrits → suppression (code mort).
- `Btunnel` : membre privé utilisé comme variable temporaire dans 14 handlers → variable locale
  (ou disparaît avec `Utils.ReplicationOK`).
- `Menushowhide`…`Menu4showhide` : **nécessaires** (`Prefs`).

### Séparation traitement / GUI

- `Abonnement` : fonction pure `NbFacturesPeriodiques(rClient As Result, dJour As Date) As Integer`
  testable en gb.test ; le handler garde `Syntheses.Message` / `Message.Info`.
- `ColTaches_KeyPress` : extraire `SupprimeTache(lind)` (le `DELETE` et l'`ALTER TABLE`).
- `Form_Open` : la connexion et les rappels deviennent des fonctions sans accès aux contrôles ; les
  `Message.*` restent dans `Form_Open`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `Fiches_Bl.dtefac` et `cli_aban` : la périodicité stockée en libellé (« 3- Trimestriel ») pourrait
  devenir un nombre de mois, et une colonne « prochaine échéance » éviterait tout le calcul de dates
  d'`Abonnement`.
- `Fiches_Taches.nom` est un `char(8)` comparé par `LIKE 'user%'` : une colonne utilisateur complète
  indexée rendrait la recherche exacte.
- `ALTER TABLE Fiches_Taches ORDER BY lind` est inutile avec une clé primaire auto-incrémentée
  (l'ordre se demande dans le `SELECT`).
