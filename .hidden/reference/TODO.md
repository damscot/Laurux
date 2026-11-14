# TODO du rework

> Phase 2 : tests (bloc généré ci-dessous). Phase 3 : ordre des rework_id (à venir).

## Hors périmètre des tests (décisions utilisateur)

- `Communs/LauruxMaj.module` (2026-11-11) : migrations historiques de la base non testées (voir [PLAN.md §4.0](PLAN.md)). Un test dont le statut commence par « hors périmètre » n'apparaît pas dans la liste générée.

<!-- AUTO:tests -->
## Phase 2 — tests

> Bloc généré par `python3 .src/Tests/Framework/runner.py report` ; liste détaillée des tests implémentés : [output/tests/list.md](../../output/tests/list.md).

### Tests à vérifier à la main (16)

Tests synthétisés dont le comportement obtenu diffère de celui décrit par test.md (xfail), en échec, ou retirés des campagnes car connus instables ou en erreur (« à la main » : verification_manuelle de meta.json, lancés seulement par leur nom exact) : à vérifier ou corriger par l'utilisateur.

| Test | Statut | Obtenu | Attendu (test.md) | Raison | Description |
|---|---|---|---|---|---|
| [ARCHIVES-T13](.src/Archivages/Archives.class/test.md) | xfail | identique | erreur SQL attrapée, liste inchangée (A06) | erreur SQL non attrapée : Query failed (Archives.… | archives_guillemet |
| [CALCSTOCK-T05](.src/Utils/Calcstock.class/test.md) | xfail | identique | avertissement « Traitement impossible, la caisse numéro 01e… | contrôle de caisse connectée inopérant sur MySQL … | calcstock_caisse_connectee |
| [CDOCUMENTS-T06](.src/Reports/Cdocuments.class/test.md) | xfail | identique | PDF du relevé de 411003 (10 prestations) produit et comparé… | Button2 : « If rResult!villerc_sc Then » (champs … | cdocuments_relvmo |
| [EDBL-T01](.src/Gestion/Impressions/Edbl.class/test.md) | xfail | identique | PDF BonReception.pdf du BR produit et visualise (test.md) | Edbr.Ed.190 : Val(paht) sur une valeur formatee s… | edbl_numero_entree |
| [EDBL-T03](.src/Gestion/Impressions/Edbl.class/test.md) | xfail | identique | PDF BonReception.pdf du BR produit et visualise (test.md) | Edbr.Ed.190 : Val(paht) sur une valeur formatee s… | edbl_choix_liste |
| [EDBL-T07](.src/Gestion/Impressions/Edbl.class/test.md) | xfail | identique | PDF BonReception.pdf du BR produit et visualise (test.md) | Edbr.Ed.190 : Val(paht) sur une valeur formatee s… | edbl_numero_partage |
| [EDDOCS-T07](.src/Gestion/Impressions/EdDocs.class/test.md) | xfail | identique | ligne F00001 affichée avec le numéro FA0001 et la date 08.0… | imp est un tinyint(1) lu comme Booléen : rResult!… | eddocs_facture_imprimee |
| [ETIQUETTES-T06](.src/Gestion/Etiquettes/Etiquettes.class/test.md) | xfail | identique | ligne de code '' enregistrée (ETIQUETTES-A01) | code vide : Left$(,1) vaut Null, INSERT refusé (C… | etiquettes_code_invalide |
| [FSOC-T06](.src/Communs/Fsoc.class/test.md) | xfail | identique | /Soc=02, collation de Laurux02 modifiée, redémarrage par St… | Soclist_Click : SET NAMES après Utils.db.Close/Op… | fsoc_selection_liste |
| [GEDR-T08](.src/Utils/GedR.class/test.md) | xfail | identique | erreur SQL figée par un message (test.md GEDR-T08), rejeu t… | erreur SQL non interceptée (guillemet non échappé… | gedr_replay_filtre_guillemet |
| [LAURUXCONF-T04](.src/Communs/LauruxConf.class/test.md) | xfail | identique | base Laurux05 avec cd_sc = 05, Message.Info final | Createbase : Fill_DataBase exécute une requête su… | lauruxconf_creation_base |
| [MATERIEL-T07](.src/Gestion/Tables/Materiel.class/test.md) | xfail | identique | contenu de Colachat, Colrcp2 et total de la réception | Colachat_click.2454 : Val(Ligrcpt!pbht) renvoie N… | materiel_histo_achats |
| [MDP-T01](.src/Communs/MDP.class/test.md) | à la main | code 3, dump ±0 l., SQL ±1 l. | dump et SQL identiques à ref | instable (code 3) : le clic Quitter de Prefs est … | mdp_mdp_local_ok |
| [RELVMO-T03](.src/Statistiques/RelvMo.class/test.md) | xfail | identique | message « Veuillez saisir votre date SVP », Fiches_Stat non… | Cdate_calc intercepte l'erreur de date (Message.E… | relvmo_date_invalide |
| [START-T17](.src/Start.module/test.md) | xfail | identique | deux itérations de Main, fin propre (code 0) | La fermeture de LauruxConf écrit dans le journal … | start_redemarrage |
| [TRECARTS-T06](.src/Compta/Trecarts.class/test.md) | xfail | identique | ligne collectif écrite sur un compte vide (comportement A04… | erreur SQL fatale (compte NULL) au lieu d'une lig… | trecarts_sans_collectif |

### Classes dont des tests restent à implémenter (353), par priorité

Priorité = complexité cyclomatique totale (×2 pour un module complexe à scénarios validés par l'utilisateur) + 5 par test restant.

| # | Classe | Tests prévus | Restant | CC totale | CC max | LOC | Complexe | test.md |
|---|---|---|---|---|---|---|---|---|
| 1 | Facture | 27 | 27 | 3116 | 166 | 10446 | oui | [.src/Gestion/Facturation/Facture.class](.src/Gestion/Facturation/Facture.class/test.md) |
| 2 | Caisse | 25 | 25 | 2102 | 77 | 7303 | oui | [.src/Caisse/Caisse.class](.src/Caisse/Caisse.class/test.md) |
| 3 | Articles | 18 | 18 | 1128 | 96 | 3775 | oui | [.src/Gestion/Tables/Articles.class](.src/Gestion/Tables/Articles.class/test.md) |
| 4 | FClient | 18 | 18 | 675 | 42 | 2716 | oui | [.src/Gestion/Tables/FClient.class](.src/Gestion/Tables/FClient.class/test.md) |
| 5 | Saisecrit | 17 | 17 | 654 | 72 | 2528 | oui | [.src/Compta/Saisecrit.class](.src/Compta/Saisecrit.class/test.md) |
| 6 | Moulinage | 23 | 23 | 622 | 196 | 2431 | oui | [.src/Caisse/Moulinage.class](.src/Caisse/Moulinage.class/test.md) |
| 7 | Impart | 15 | 15 | 548 | 186 | 1647 | oui | [.src/Gestion/Stock/Tarifs/Impart.class](.src/Gestion/Stock/Tarifs/Impart.class/test.md) |
| 8 | FFournisseur | 16 | 16 | 545 | 35 | 2156 | oui | [.src/Gestion/Tables/FFournisseur.class](.src/Gestion/Tables/FFournisseur.class/test.md) |
| 9 | PdfWriter | 15 | 1 | 791 | 45 | 3403 |  | [.src/Reports/PdfWriter.class](.src/Reports/PdfWriter.class/test.md) |
| 10 | MajTarifM | 11 | 11 | 319 | 25 | 1107 | oui | [.src/Gestion/Stock/Tarifs/MajTarifM.class](.src/Gestion/Stock/Tarifs/MajTarifM.class/test.md) |
| 11 | Achat | 14 | 14 | 293 | 19 | 1463 | oui | [.src/Gestion/Entrées/Achat.class](.src/Gestion/Entrées/Achat.class/test.md) |
| 12 | Tresor | 17 | 11 | 579 | 82 | 2185 |  | [.src/Compta/Tresor.class](.src/Compta/Tresor.class/test.md) |
| 13 | Fmenu | 20 | 7 | 510 | 54 | 1579 |  | [.src/Communs/Fmenu.class](.src/Communs/Fmenu.class/test.md) |
| 14 | ObjFacB | 18 | 18 | 226 | 56 | 930 | oui | [.src/Gestion/option/ObjFacB.class](.src/Gestion/option/ObjFacB.class/test.md) |
| 15 | commande1 | 14 | 14 | 219 | 29 | 850 | oui | [.src/Gestion/Stock/commande1.class](.src/Gestion/Stock/commande1.class/test.md) |
| 16 | Utils | 26 | 4 | 475 | 77 | 1315 |  | [.src/Utils/Utils.module](.src/Utils/Utils.module/test.md) |
| 17 | ValidBR | 3 | 3 | 231 | 40 | 1079 | oui | [.src/Gestion/Stock/ValidBR.class](.src/Gestion/Stock/ValidBR.class/test.md) |
| 18 | SaiReg | 11 | 11 | 207 | 24 | 913 | oui | [.src/Gestion/Facturation/SaiReg.class](.src/Gestion/Facturation/SaiReg.class/test.md) |
| 19 | Materiel | 12 | 5 | 444 | 24 | 2054 |  | [.src/Gestion/Tables/Materiel.class](.src/Gestion/Tables/Materiel.class/test.md) |
| 20 | ObjFac | 16 | 16 | 181 | 45 | 893 | oui | [.src/Gestion/Facturation/ObjFac.class](.src/Gestion/Facturation/ObjFac.class/test.md) |
| 21 | Prefs | 17 | 3 | 374 | 186 | 1121 |  | [.src/Communs/Prefs.class](.src/Communs/Prefs.class/test.md) |
| 22 | Stockmvt | 11 | 11 | 163 | 75 | 843 | oui | [.src/Gestion/Stockmvt.class](.src/Gestion/Stockmvt.class/test.md) |
| 23 | Start | 17 | 8 | 327 | 95 | 849 |  | [.src/Start.module](.src/Start.module/test.md) |
| 24 | Archives | 15 | 9 | 307 | 35 | 1202 |  | [.src/Archivages/Archives.class](.src/Archivages/Archives.class/test.md) |
| 25 | Imp_Bilan | 10 | 2 | 336 | 335 | 767 |  | [.src/Compta/Impressions/Imp_Bilan.module](.src/Compta/Impressions/Imp_Bilan.module/test.md) |
| 26 | Movr | 9 | 4 | 323 | 35 | 1271 |  | [.src/Gestion/Tables/Movr.class](.src/Gestion/Tables/Movr.class/test.md) |
| 27 | Preparation | 11 | 11 | 135 | 16 | 644 | oui | [.src/Gestion/Lcr/Preparation.class](.src/Gestion/Lcr/Preparation.class/test.md) |
| 28 | Caleditcmat | 14 | 14 | 121 | 35 | 766 | oui | [.src/Gestion/option/Caleditcmat.class](.src/Gestion/option/Caleditcmat.class/test.md) |
| 29 | Lcr | 11 | 11 | 121 | 17 | 563 | oui | [.src/Gestion/Lcr/Lcr.class](.src/Gestion/Lcr/Lcr.class/test.md) |
| 30 | Attribution | 9 | 9 | 125 | 19 | 518 | oui | [.src/Gestion/Lcr/Attribution.class](.src/Gestion/Lcr/Attribution.class/test.md) |
| 31 | GeninvT | 14 | 14 | 110 | 20 | 531 | oui | [.src/Gestion/Stock/Inventaires/Tournant/GeninvT.class](.src/Gestion/Stock/Inventaires/Tournant/GeninvT.class/test.md) |
| 32 | SaisieInv | 16 | 16 | 104 | 24 | 418 | oui | [.src/Gestion/Stock/Inventaires/Fin-annee/SaisieInv.class](.src/Gestion/Stock/Inventaires/Fin-annee/SaisieInv.class/test.md) |
| 33 | FComptes | 11 | 3 | 271 | 48 | 919 |  | [.src/Compta/Tables/FComptes.class](.src/Compta/Tables/FComptes.class/test.md) |
| 34 | Cmenu | 14 | 14 | 107 | 16 | 325 | oui | [.src/Caisse/Cmenu.class](.src/Caisse/Cmenu.class/test.md) |
| 35 | SaisieInvT | 16 | 16 | 97 | 23 | 418 | oui | [.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class](.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class/test.md) |
| 36 | Facturergbl | 7 | 2 | 258 | 121 | 1232 |  | [.src/Gestion/Facturation/Facturergbl.class](.src/Gestion/Facturation/Facturergbl.class/test.md) |
| 37 | Extrait | 14 | 6 | 236 | 31 | 1127 |  | [.src/Compta/Extrait.class](.src/Compta/Extrait.class/test.md) |
| 38 | Histocliart | 11 | 2 | 245 | 141 | 836 |  | [.src/Statistiques/Histocliart.class](.src/Statistiques/Histocliart.class/test.md) |
| 39 | Emailing | 11 | 7 | 212 | 37 | 775 |  | [.src/Gestion/Mails/Emailing.class](.src/Gestion/Mails/Emailing.class/test.md) |
| 40 | Fondcaisse | 10 | 10 | 98 | 12 | 335 | oui | [.src/Caisse/Fondcaisse.class](.src/Caisse/Fondcaisse.class/test.md) |
| 41 | ExportJdv | 16 | 8 | 205 | 103 | 839 |  | [.src/Compta/Utils/ExportJdv.class](.src/Compta/Utils/ExportJdv.class/test.md) |
| 42 | FClientcarte | 10 | 5 | 216 | 28 | 863 |  | [.src/Caisse/FClientcarte.class](.src/Caisse/FClientcarte.class/test.md) |
| 43 | ImpartParam | 8 | 7 | 206 | 27 | 782 |  | [.src/Gestion/Stock/Tarifs/ImpartParam.class](.src/Gestion/Stock/Tarifs/ImpartParam.class/test.md) |
| 44 | FClotureAn | 13 | 13 | 88 | 74 | 583 | oui | [.src/Compta/Clotures/FClotureAn.class](.src/Compta/Clotures/FClotureAn.class/test.md) |
| 45 | LGed | 15 | 5 | 215 | 29 | 757 |  | [.src/Utils/LGed.class](.src/Utils/LGed.class/test.md) |
| 46 | Etigond | 13 | 1 | 235 | 51 | 915 |  | [.src/Gestion/Etiquettes/Etigond.class](.src/Gestion/Etiquettes/Etigond.class/test.md) |
| 47 | MvtDepots | 6 | 6 | 103 | 11 | 409 | oui | [.src/Gestion/Depots/MvtDepots.class](.src/Gestion/Depots/MvtDepots.class/test.md) |
| 48 | TresorFac | 2 | 2 | 225 | 44 | 1081 |  | [.src/Gestion/Reglements/TresorFac.class](.src/Gestion/Reglements/TresorFac.class/test.md) |
| 49 | Cdocuments | 12 | 4 | 212 | 23 | 986 |  | [.src/Reports/Cdocuments.class](.src/Reports/Cdocuments.class/test.md) |
| 50 | Suivi | 8 | 8 | 95 | 14 | 293 | oui | [.src/Gestion/Suivi.class](.src/Gestion/Suivi.class/test.md) |
| 51 | Famille | 9 | 2 | 218 | 28 | 761 |  | [.src/Gestion/Tables/Famille.class](.src/Gestion/Tables/Famille.class/test.md) |
| 52 | RubImp | 10 | 5 | 198 | 135 | 983 |  | [.src/Compta/Impressions/RubImp.class](.src/Compta/Impressions/RubImp.class/test.md) |
| 53 | ValidBR1 | 10 | 10 | 85 | 15 | 460 | oui | [.src/Gestion/Stock/ValidBR1.class](.src/Gestion/Stock/ValidBR1.class/test.md) |
| 54 | Parametre | 12 | 2 | 208 | 62 | 539 |  | [.src/Communs/Parametre.class](.src/Communs/Parametre.class/test.md) |
| 55 | TriEcritures | 6 | 4 | 198 | 11 | 602 |  | [.src/Affichages/TriEcritures.class](.src/Affichages/TriEcritures.class/test.md) |
| 56 | Tricp | 8 | 8 | 88 | 13 | 220 | oui | [.src/Affichages/Tricp.class](.src/Affichages/Tricp.class/test.md) |
| 57 | facopt | 8 | 8 | 173 | 19 | 875 |  | [.src/Gestion/option/facopt.class](.src/Gestion/option/facopt.class/test.md) |
| 58 | TextReg | 10 | 7 | 177 | 31 | 536 |  | [.src/Utils/TextReg.class](.src/Utils/TextReg.class/test.md) |
| 59 | Etiqart | 12 | 3 | 197 | 24 | 848 |  | [.src/Gestion/Etiquettes/Etiqart.class](.src/Gestion/Etiquettes/Etiqart.class/test.md) |
| 60 | TriFac2 | 7 | 5 | 187 | 20 | 630 |  | [.src/Affichages/TriFac2.class](.src/Affichages/TriFac2.class/test.md) |
| 61 | Bordrx | 11 | 11 | 78 | 21 | 460 | oui | [.src/Gestion/Lcr/Bordrx.class](.src/Gestion/Lcr/Bordrx.class/test.md) |
| 62 | ConsultArt | 7 | 2 | 200 | 37 | 771 |  | [.src/Gestion/Tables/ConsultArt.class](.src/Gestion/Tables/ConsultArt.class/test.md) |
| 63 | RelMoprod | 9 | 4 | 189 | 30 | 787 |  | [.src/Statistiques/RelMoprod.class](.src/Statistiques/RelMoprod.class/test.md) |
| 64 | Editfac | 10 | 10 | 154 | 112 | 476 |  | [.src/Reports/Editfac.class](.src/Reports/Editfac.class/test.md) |
| 65 | DB_Sanity | 9 | 6 | 171 | 50 | 576 |  | [.src/Utils/DB_Sanity.class](.src/Utils/DB_Sanity.class/test.md) |
| 66 | TriEqu | 6 | 6 | 85 | 12 | 283 | oui | [.src/Affichages/TriEqu.class](.src/Affichages/TriEqu.class/test.md) |
| 67 | GesTar | 10 | 10 | 145 | 14 | 676 |  | [.src/Gestion/Entrées/GesTar.class](.src/Gestion/Entrées/GesTar.class/test.md) |
| 68 | Cdocuments2 | 2 | 2 | 182 | 31 | 926 |  | [.src/Reports/Cdocuments2.class](.src/Reports/Cdocuments2.class/test.md) |
| 69 | Etiqcasier | 9 | 1 | 187 | 24 | 793 |  | [.src/Gestion/Etiquettes/Etiqcasier.class](.src/Gestion/Etiquettes/Etiqcasier.class/test.md) |
| 70 | Ouverture | 11 | 11 | 67 | 19 | 212 | oui | [.src/Caisse/Ouverture.class](.src/Caisse/Ouverture.class/test.md) |
| 71 | Eticli | 8 | 1 | 180 | 31 | 702 |  | [.src/Gestion/Etiquettes/Eticli.class](.src/Gestion/Etiquettes/Eticli.class/test.md) |
| 72 | Histovmo | 9 | 4 | 163 | 39 | 674 |  | [.src/Statistiques/Histovmo.class](.src/Statistiques/Histovmo.class/test.md) |
| 73 | ImpSage | 10 | 2 | 172 | 50 | 699 |  | [.src/Compta/Utils/ImpSage.class](.src/Compta/Utils/ImpSage.class/test.md) |
| 74 | TriGen | 12 | 3 | 163 | 17 | 626 |  | [.src/Affichages/TriGen.class](.src/Affichages/TriGen.class/test.md) |
| 75 | DB_Connection | 16 | 2 | 162 | 42 | 561 |  | [.src/Utils/DB_Connection.class](.src/Utils/DB_Connection.class/test.md) |
| 76 | FTVA | 13 | 7 | 133 | 51 | 698 |  | [.src/Compta/Impressions/FTVA.class](.src/Compta/Impressions/FTVA.class/test.md) |
| 77 | Ecomptamat | 7 | 7 | 66 | 6 | 306 | oui | [.src/Gestion/option/Ecomptamat.class](.src/Gestion/option/Ecomptamat.class/test.md) |
| 78 | EmailingCarte | 7 | 5 | 136 | 25 | 474 |  | [.src/Gestion/Mails/EmailingCarte.class](.src/Gestion/Mails/EmailingCarte.class/test.md) |
| 79 | Cielimp | 12 | 4 | 140 | 54 | 520 |  | [.src/Compta/Cielimp.class](.src/Compta/Cielimp.class/test.md) |
| 80 | Geninv | 16 | 16 | 36 | 13 | 203 | oui | [.src/Gestion/Stock/Inventaires/Fin-annee/Geninv.class](.src/Gestion/Stock/Inventaires/Fin-annee/Geninv.class/test.md) |
| 81 | Jourcent | 10 | 3 | 137 | 22 | 780 |  | [.src/Compta/Impressions/Jourcent.class](.src/Compta/Impressions/Jourcent.class/test.md) |
| 82 | TriHistos | 6 | 1 | 147 | 29 | 602 |  | [.src/Affichages/TriHistos.class](.src/Affichages/TriHistos.class/test.md) |
| 83 | Editcompte | 10 | 3 | 136 | 56 | 579 |  | [.src/Compta/Impressions/Editcompte.class](.src/Compta/Impressions/Editcompte.class/test.md) |
| 84 | calculdroit1 | 10 | 10 | 50 | 7 | 167 | oui | [.src/Gestion/option/calculdroit1.class](.src/Gestion/option/calculdroit1.class/test.md) |
| 85 | Prodcomposes | 8 | 4 | 130 | 20 | 534 |  | [.src/Gestion/Tables/Prodcomposes.class](.src/Gestion/Tables/Prodcomposes.class/test.md) |
| 86 | Facturefm | 11 | 2 | 139 | 29 | 629 |  | [.src/Gestion/Facturation/Facturefm.class](.src/Gestion/Facturation/Facturefm.class/test.md) |
| 87 | JournauxA | 8 | 4 | 128 | 24 | 664 |  | [.src/Compta/Impressions/JournauxA.class](.src/Compta/Impressions/JournauxA.class/test.md) |
| 88 | Validinv | 16 | 16 | 32 | 20 | 158 | oui | [.src/Gestion/Stock/Inventaires/Fin-annee/Validinv.class](.src/Gestion/Stock/Inventaires/Fin-annee/Validinv.class/test.md) |
| 89 | EcrAuto | 12 | 9 | 99 | 22 | 601 |  | [.src/Compta/Utils/EcrAuto.class](.src/Compta/Utils/EcrAuto.class/test.md) |
| 90 | Journaux | 10 | 3 | 129 | 22 | 621 |  | [.src/Compta/Impressions/Journaux.class](.src/Compta/Impressions/Journaux.class/test.md) |
| 91 | EditcompteA | 8 | 6 | 114 | 19 | 695 |  | [.src/Compta/Impressions/EditcompteA.class](.src/Compta/Impressions/EditcompteA.class/test.md) |
| 92 | Fcaisses | 7 | 4 | 122 | 26 | 293 |  | [.src/Caisse/Fcaisses.class](.src/Caisse/Fcaisses.class/test.md) |
| 93 | Saisiedecons | 7 | 5 | 117 | 9 | 497 |  | [.src/Gestion/option/Saisiedecons.class](.src/Gestion/option/Saisiedecons.class/test.md) |
| 94 | TriFac | 5 | 3 | 127 | 19 | 410 |  | [.src/Affichages/TriFac.class](.src/Affichages/TriFac.class/test.md) |
| 95 | Pointage | 13 | 3 | 126 | 23 | 647 |  | [.src/Compta/Pointage.class](.src/Compta/Pointage.class/test.md) |
| 96 | EcrM | 13 | 7 | 105 | 34 | 485 |  | [.src/Compta/Impressions/EcrM.class](.src/Compta/Impressions/EcrM.class/test.md) |
| 97 | FacturefmA | 8 | 6 | 109 | 41 | 517 |  | [.src/Gestion/Facturation/FacturefmA.class](.src/Gestion/Facturation/FacturefmA.class/test.md) |
| 98 | ExportA47 | 14 | 8 | 95 | 34 | 426 |  | [.src/Compta/Impressions/ExportA47.class](.src/Compta/Impressions/ExportA47.class/test.md) |
| 99 | Abont | 7 | 2 | 125 | 16 | 438 |  | [.src/Compta/Tables/Abont.class](.src/Compta/Tables/Abont.class/test.md) |
| 100 | EdArt1 | 11 | 2 | 122 | 31 | 532 |  | [.src/Gestion/Impressions/EdArt1.class](.src/Gestion/Impressions/EdArt1.class/test.md) |
| 101 | TriMat | 6 | 3 | 117 | 11 | 329 |  | [.src/Affichages/TriMat.class](.src/Affichages/TriMat.class/test.md) |
| 102 | OptFac | 10 | 8 | 91 | 16 | 390 |  | [.src/Gestion/Facturation/OptFac.class](.src/Gestion/Facturation/OptFac.class/test.md) |
| 103 | artopt | 4 | 4 | 110 | 15 | 473 |  | [.src/Gestion/option/artopt.class](.src/Gestion/option/artopt.class/test.md) |
| 104 | Lettrage | 7 | 5 | 104 | 20 | 447 |  | [.src/Compta/Lettrages/Lettrage.class](.src/Compta/Lettrages/Lettrage.class/test.md) |
| 105 | Cbase | 4 | 1 | 122 | 122 | 248 |  | [.src/Utils/Cbase.module](.src/Utils/Cbase.module/test.md) |
| 106 | EdRup | 10 | 1 | 122 | 73 | 503 |  | [.src/Gestion/Impressions/EdRup.class](.src/Gestion/Impressions/EdRup.class/test.md) |
| 107 | Fmontant | 7 | 2 | 58 | 41 | 168 | oui | [.src/Compta/Utils/Fmontant.class](.src/Compta/Utils/Fmontant.class/test.md) |
| 108 | Einvmat | 5 | 5 | 50 | 6 | 244 | oui | [.src/Gestion/option/Einvmat.class](.src/Gestion/option/Einvmat.class/test.md) |
| 109 | LDate | 14 | 1 | 119 | 20 | 489 |  | [.src/Utils/LDate.class](.src/Utils/LDate.class/test.md) |
| 110 | TriFacture | 6 | 6 | 47 | 13 | 237 | oui | [.src/Affichages/TriFacture.class](.src/Affichages/TriFacture.class/test.md) |
| 111 | numtostring | 6 | 6 | 92 | 62 | 166 |  | [.src/Caisse/numtostring.module](.src/Caisse/numtostring.module/test.md) |
| 112 | Mvtex | 9 | 5 | 97 | 16 | 589 |  | [.src/Gestion/Stock/Mvtex.class](.src/Gestion/Stock/Mvtex.class/test.md) |
| 113 | MajTarifP | 7 | 2 | 112 | 31 | 350 |  | [.src/Gestion/Stock/Tarifs/MajTarifP.class](.src/Gestion/Stock/Tarifs/MajTarifP.class/test.md) |
| 114 | ValidinvT | 13 | 13 | 26 | 23 | 122 | oui | [.src/Gestion/Stock/Inventaires/Tournant/ValidinvT.class](.src/Gestion/Stock/Inventaires/Tournant/ValidinvT.class/test.md) |
| 115 | EdArt2 | 1 | 1 | 112 | 21 | 489 |  | [.src/Gestion/Impressions/EdArt2.class](.src/Gestion/Impressions/EdArt2.class/test.md) |
| 116 | Balance | 10 | 3 | 102 | 20 | 497 |  | [.src/Compta/Impressions/Balance.class](.src/Compta/Impressions/Balance.class/test.md) |
| 117 | Crupt | 9 | 2 | 106 | 106 | 319 |  | [.src/Utils/Crupt.module](.src/Utils/Crupt.module/test.md) |
| 118 | Changefam | 12 | 2 | 106 | 14 | 548 |  | [.src/Utils/Changefam.class](.src/Utils/Changefam.class/test.md) |
| 119 | Dup | 6 | 5 | 89 | 82 | 230 |  | [.src/Compta/Utils/Dup.class](.src/Compta/Utils/Dup.class/test.md) |
| 120 | Tricartes | 7 | 2 | 102 | 11 | 322 |  | [.src/Caisse/Affichages/Tricartes.class](.src/Caisse/Affichages/Tricartes.class/test.md) |
| 121 | FEditrel | 7 | 2 | 102 | 25 | 497 |  | [.src/Compta/Relances/FEditrel.class](.src/Compta/Relances/FEditrel.class/test.md) |
| 122 | EdStk | 8 | 2 | 101 | 27 | 435 |  | [.src/Gestion/Impressions/EdStk.class](.src/Gestion/Impressions/EdStk.class/test.md) |
| 123 | FTvav | 7 | 1 | 106 | 25 | 413 |  | [.src/Compta/Tables/FTvav.class](.src/Compta/Tables/FTvav.class/test.md) |
| 124 | SupprArt | 7 | 4 | 90 | 18 | 337 |  | [.src/Gestion/SupprArt.class](.src/Gestion/SupprArt.class/test.md) |
| 125 | GedR | 8 | 4 | 88 | 20 | 388 |  | [.src/Utils/GedR.class](.src/Utils/GedR.class/test.md) |
| 126 | ReplayObserver | 7 | 4 | 88 | 28 | 264 |  | [.src/Utils/ReplayObserver.class](.src/Utils/ReplayObserver.class/test.md) |
| 127 | RelvMo | 8 | 2 | 97 | 37 | 382 |  | [.src/Statistiques/RelvMo.class](.src/Statistiques/RelvMo.class/test.md) |
| 128 | Tregie | 7 | 1 | 101 | 13 | 448 |  | [.src/Gestion/option/Tregie.class](.src/Gestion/option/Tregie.class/test.md) |
| 129 | EdMat | 8 | 1 | 100 | 35 | 393 |  | [.src/Gestion/Impressions/EdMat.class](.src/Gestion/Impressions/EdMat.class/test.md) |
| 130 | RichDataGrid | 7 | 6 | 73 | 24 | 225 |  | [.src/Utils/RichDataGrid.class](.src/Utils/RichDataGrid.class/test.md) |
| 131 | EnvMail | 11 | 1 | 98 | 56 | 238 |  | [.src/Gestion/Mails/EnvMail.module](.src/Gestion/Mails/EnvMail.module/test.md) |
| 132 | TarTypeCli | 8 | 2 | 93 | 8 | 414 |  | [.src/Gestion/Tables/TarTypeCli.class](.src/Gestion/Tables/TarTypeCli.class/test.md) |
| 133 | LauruxConf | 10 | 1 | 97 | 54 | 384 |  | [.src/Communs/LauruxConf.class](.src/Communs/LauruxConf.class/test.md) |
| 134 | Etiqfbtarif | 7 | 2 | 92 | 18 | 365 |  | [.src/Gestion/Etiquettes/Etiqfbtarif.class](.src/Gestion/Etiquettes/Etiqfbtarif.class/test.md) |
| 135 | BordereauxC | 11 | 4 | 82 | 30 | 416 |  | [.src/Compta/Impressions/BordereauxC.class](.src/Compta/Impressions/BordereauxC.class/test.md) |
| 136 | FpromoArt | 7 | 1 | 96 | 22 | 377 |  | [.src/Gestion/Tables/FpromoArt.class](.src/Gestion/Tables/FpromoArt.class/test.md) |
| 137 | gridvi | 10 | 4 | 80 | 25 | 493 |  | [.src/Utils/gridvi.class](.src/Utils/gridvi.class/test.md) |
| 138 | Changefour | 8 | 2 | 90 | 12 | 411 |  | [.src/Utils/Changefour.class](.src/Utils/Changefour.class/test.md) |
| 139 | TriCpt | 10 | 2 | 89 | 17 | 456 |  | [.src/Affichages/TriCpt.class](.src/Affichages/TriCpt.class/test.md) |
| 140 | Attrib | 7 | 3 | 82 | 12 | 298 |  | [.src/Caisse/Attrib.class](.src/Caisse/Attrib.class/test.md) |
| 141 | gridvi2 | 1 | 1 | 92 | 20 | 387 |  | [.src/Utils/gridvi2.class](.src/Utils/gridvi2.class/test.md) |
| 142 | Preferences | 6 | 6 | 65 | 41 | 183 |  | [.src/Caisse/Preferences.class](.src/Caisse/Preferences.class/test.md) |
| 143 | ClotureF | 8 | 8 | 27 | 8 | 153 | oui | [.src/Gestion/ClotureF.class](.src/Gestion/ClotureF.class/test.md) |
| 144 | FRelFacture | 6 | 1 | 89 | 24 | 425 |  | [.src/Compta/Relances/FRelFacture.class](.src/Compta/Relances/FRelFacture.class/test.md) |
| 145 | EdNlettrees | 11 | 6 | 63 | 17 | 424 |  | [.src/Compta/Impressions/EdNlettrees.class](.src/Compta/Impressions/EdNlettrees.class/test.md) |
| 146 | TBord | 8 | 5 | 67 | 49 | 340 |  | [.src/Statistiques/TBord.class](.src/Statistiques/TBord.class/test.md) |
| 147 | Edart4 | 8 | 5 | 66 | 19 | 392 |  | [.src/Gestion/Impressions/Edart4.class](.src/Gestion/Impressions/Edart4.class/test.md) |
| 148 | Remisecli | 7 | 1 | 86 | 12 | 351 |  | [.src/Gestion/Tables/Remisecli.class](.src/Gestion/Tables/Remisecli.class/test.md) |
| 149 | Txmo | 6 | 2 | 80 | 14 | 356 |  | [.src/Gestion/Tables/Txmo.class](.src/Gestion/Tables/Txmo.class/test.md) |
| 150 | Cfacture | 9 | 6 | 59 | 8 | 267 |  | [.src/Caisse/Reports/Cfacture.class](.src/Caisse/Reports/Cfacture.class/test.md) |
| 151 | TarArt | 12 | 3 | 37 | 32 | 149 | oui | [.src/Utils/TarArt.class](.src/Utils/TarArt.class/test.md) |
| 152 | Edmo | 7 | 1 | 83 | 11 | 370 |  | [.src/Gestion/Impressions/Edmo.class](.src/Gestion/Impressions/Edmo.class/test.md) |
| 153 | Rubresult | 8 | 5 | 63 | 21 | 290 |  | [.src/Compta/Utils/Rubresult.class](.src/Compta/Utils/Rubresult.class/test.md) |
| 154 | TriArticles | 11 | 2 | 78 | 16 | 363 |  | [.src/Affichages/TriArticles.class](.src/Affichages/TriArticles.class/test.md) |
| 155 | JournauxM | 12 | 5 | 62 | 55 | 338 |  | [.src/Compta/Impressions/JournauxM.module](.src/Compta/Impressions/JournauxM.module/test.md) |
| 156 | modfichier | 5 | 3 | 71 | 32 | 172 |  | [.src/Gestion/option/modfichier.module](.src/Gestion/option/modfichier.module/test.md) |
| 157 | Listextcpt | 13 | 2 | 76 | 28 | 297 |  | [.src/Compta/Utils/Listextcpt.class](.src/Compta/Utils/Listextcpt.class/test.md) |
| 158 | Imp_Sig | 7 | 5 | 61 | 60 | 403 |  | [.src/Compta/Impressions/Imp_Sig.module](.src/Compta/Impressions/Imp_Sig.module/test.md) |
| 159 | Majversion | 7 | 3 | 70 | 21 | 295 |  | [.src/Communs/Majversion.class](.src/Communs/Majversion.class/test.md) |
| 160 | StatComm | 10 | 4 | 62 | 37 | 224 |  | [.src/Statistiques/StatComm.class](.src/Statistiques/StatComm.class/test.md) |
| 161 | Echeancier | 10 | 3 | 67 | 28 | 386 |  | [.src/Compta/Impressions/Echeancier.class](.src/Compta/Impressions/Echeancier.class/test.md) |
| 162 | Calc | 1 | 1 | 76 | 14 | 213 |  | [.src/Utils/Calc.class](.src/Utils/Calc.class/test.md) |
| 163 | FRelCompte | 6 | 1 | 76 | 23 | 365 |  | [.src/Compta/Relances/FRelCompte.class](.src/Compta/Relances/FRelCompte.class/test.md) |
| 164 | Depots | 5 | 1 | 74 | 13 | 274 |  | [.src/Gestion/Depots/Depots.class](.src/Gestion/Depots/Depots.class/test.md) |
| 165 | Ligcli | 7 | 4 | 59 | 25 | 334 |  | [.src/Compta/Relances/Ligcli.class](.src/Compta/Relances/Ligcli.class/test.md) |
| 166 | Numtostring | 7 | 1 | 73 | 58 | 144 |  | [.src/Utils/Numtostring.module](.src/Utils/Numtostring.module/test.md) |
| 167 | SaiTableau | 8 | 2 | 67 | 9 | 284 |  | [.src/Utils/SaiTableau.class](.src/Utils/SaiTableau.class/test.md) |
| 168 | FTvac | 5 | 2 | 67 | 16 | 262 |  | [.src/Compta/Tables/FTvac.class](.src/Compta/Tables/FTvac.class/test.md) |
| 169 | DataButtonList | 1 | 1 | 71 | 13 | 247 |  | [.src/Utils/DataButtonList.class](.src/Utils/DataButtonList.class/test.md) |
| 170 | StatComArt | 7 | 7 | 41 | 16 | 162 |  | [.src/Statistiques/StatComArt.class](.src/Statistiques/StatComArt.class/test.md) |
| 171 | TriclientsD | 2 | 2 | 65 | 11 | 177 |  | [.src/Caisse/Affichages/TriclientsD.class](.src/Caisse/Affichages/TriclientsD.class/test.md) |
| 172 | EdPrep | 7 | 1 | 70 | 43 | 350 |  | [.src/Gestion/Impressions/EdPrep.class](.src/Gestion/Impressions/EdPrep.class/test.md) |
| 173 | Fvendeurs | 6 | 6 | 43 | 9 | 163 |  | [.src/Caisse/Fvendeurs.class](.src/Caisse/Fvendeurs.class/test.md) |
| 174 | Sailig | 5 | 1 | 68 | 27 | 200 |  | [.src/Utils/Sailig.class](.src/Utils/Sailig.class/test.md) |
| 175 | EtiqRecpt | 9 | 1 | 68 | 36 | 322 |  | [.src/Gestion/Etiquettes/EtiqRecpt.class](.src/Gestion/Etiquettes/EtiqRecpt.class/test.md) |
| 176 | MajFbtarif2 | 7 | 2 | 63 | 15 | 236 |  | [.src/Gestion/Stock/Tarifs/MajFbtarif2.class](.src/Gestion/Stock/Tarifs/MajFbtarif2.class/test.md) |
| 177 | Cbilan | 5 | 1 | 67 | 17 | 166 |  | [.src/Reports/Cbilan.class](.src/Reports/Cbilan.class/test.md) |
| 178 | StatClimo | 8 | 2 | 62 | 37 | 235 |  | [.src/Statistiques/StatClimo.class](.src/Statistiques/StatClimo.class/test.md) |
| 179 | FPrepRel2 | 1 | 1 | 67 | 10 | 346 |  | [.src/Compta/Relances/FPrepRel2.class](.src/Compta/Relances/FPrepRel2.class/test.md) |
| 180 | EdNjustifiees | 8 | 5 | 47 | 16 | 249 |  | [.src/Compta/Impressions/EdNjustifiees.class](.src/Compta/Impressions/EdNjustifiees.class/test.md) |
| 181 | impfec | 9 | 2 | 61 | 25 | 294 |  | [.src/Compta/Utils/impfec.class](.src/Compta/Utils/impfec.class/test.md) |
| 182 | Rubcompt | 8 | 1 | 66 | 14 | 270 |  | [.src/Compta/Utils/Rubcompt.class](.src/Compta/Utils/Rubcompt.class/test.md) |
| 183 | Trecarts | 8 | 4 | 50 | 24 | 224 |  | [.src/Compta/Trecarts.class](.src/Compta/Trecarts.class/test.md) |
| 184 | Remisec | 5 | 3 | 53 | 10 | 243 |  | [.src/Gestion/Tables/Remisec.class](.src/Gestion/Tables/Remisec.class/test.md) |
| 185 | atribvignette | 8 | 6 | 37 | 12 | 138 |  | [.src/Gestion/option/atribvignette.class](.src/Gestion/option/atribvignette.class/test.md) |
| 186 | Edbr | 7 | 6 | 37 | 19 | 228 |  | [.src/Gestion/Impressions/Edbr.module](.src/Gestion/Impressions/Edbr.module/test.md) |
| 187 | CoefTypeC | 5 | 1 | 62 | 10 | 281 |  | [.src/Gestion/Tables/CoefTypeC.class](.src/Gestion/Tables/CoefTypeC.class/test.md) |
| 188 | Echeances | 8 | 2 | 57 | 18 | 220 |  | [.src/Compta/Echeances.class](.src/Compta/Echeances.class/test.md) |
| 189 | Verbal | 7 | 2 | 57 | 19 | 314 |  | [.src/Compta/Utils/Verbal.class](.src/Compta/Utils/Verbal.class/test.md) |
| 190 | LBox | 7 | 4 | 46 | 11 | 182 |  | [.src/Utils/LBox.class](.src/Utils/LBox.class/test.md) |
| 191 | VarMajTar | 7 | 6 | 36 | 15 | 137 |  | [.src/Gestion/Stock/VarMajTar.class](.src/Gestion/Stock/VarMajTar.class/test.md) |
| 192 | Ccompta | 10 | 1 | 60 | 5 | 546 |  | [.src/Reports/Ccompta.class](.src/Reports/Ccompta.class/test.md) |
| 193 | Ttarfioul | 5 | 1 | 60 | 10 | 267 |  | [.src/Gestion/option/Ttarfioul.class](.src/Gestion/option/Ttarfioul.class/test.md) |
| 194 | DateTar | 8 | 2 | 55 | 13 | 197 |  | [.src/Gestion/Entrées/DateTar.class](.src/Gestion/Entrées/DateTar.class/test.md) |
| 195 | StatTypCli | 7 | 3 | 50 | 25 | 208 |  | [.src/Statistiques/StatTypCli.class](.src/Statistiques/StatTypCli.class/test.md) |
| 196 | Cielcorsp | 7 | 3 | 50 | 10 | 199 |  | [.src/Compta/Cielcorsp.class](.src/Compta/Cielcorsp.class/test.md) |
| 197 | FCloture | 8 | 8 | 25 | 17 | 116 |  | [.src/Compta/Clotures/FCloture.class](.src/Compta/Clotures/FCloture.class/test.md) |
| 198 | ImageButton | 4 | 4 | 22 | 7 | 103 | oui | [.src/Caisse/ImageButton.class](.src/Caisse/ImageButton.class/test.md) |
| 199 | Edinv | 7 | 7 | 29 | 15 | 135 |  | [.src/Gestion/Stock/Inventaires/Fin-annee/Edinv.class](.src/Gestion/Stock/Inventaires/Fin-annee/Edinv.class/test.md) |
| 200 | Intjdv | 1 | 1 | 58 | 11 | 308 |  | [.src/Compta/Utils/Intjdv.class](.src/Compta/Utils/Intjdv.class/test.md) |
| 201 | Gsm | 8 | 2 | 52 | 14 | 198 |  | [.src/Gestion/SMS/Gsm.class](.src/Gestion/SMS/Gsm.class/test.md) |
| 202 | EditcompteM | 13 | 4 | 42 | 35 | 316 |  | [.src/Compta/Impressions/EditcompteM.module](.src/Compta/Impressions/EditcompteM.module/test.md) |
| 203 | Statcai | 6 | 6 | 31 | 17 | 146 |  | [.src/Caisse/Statcai.class](.src/Caisse/Statcai.class/test.md) |
| 204 | FRestore | 10 | 2 | 51 | 30 | 179 |  | [.src/Communs/FRestore.class](.src/Communs/FRestore.class/test.md) |
| 205 | Ttourne | 10 | 3 | 46 | 7 | 147 |  | [.src/Gestion/option/Ttourne.class](.src/Gestion/option/Ttourne.class/test.md) |
| 206 | Edconsigne | 6 | 5 | 35 | 15 | 244 |  | [.src/Gestion/option/Edconsigne.class](.src/Gestion/option/Edconsigne.class/test.md) |
| 207 | StatFour | 7 | 4 | 40 | 17 | 166 |  | [.src/Statistiques/StatFour.class](.src/Statistiques/StatFour.class/test.md) |
| 208 | Bordereaux | 7 | 7 | 24 | 14 | 147 |  | [.src/Caisse/Bordereaux.class](.src/Caisse/Bordereaux.class/test.md) |
| 209 | fourconsdroi | 2 | 2 | 49 | 8 | 213 |  | [.src/Gestion/option/fourconsdroi.class](.src/Gestion/option/fourconsdroi.class/test.md) |
| 210 | VisStatComArt | 6 | 6 | 29 | 9 | 186 |  | [.src/Statistiques/VisStatComArt.class](.src/Statistiques/VisStatComArt.class/test.md) |
| 211 | BalanceM | 10 | 3 | 44 | 30 | 355 |  | [.src/Compta/Impressions/BalanceM.module](.src/Compta/Impressions/BalanceM.module/test.md) |
| 212 | EdImpayes | 2 | 2 | 49 | 15 | 314 |  | [.src/Compta/Impressions/EdImpayes.class](.src/Compta/Impressions/EdImpayes.class/test.md) |
| 213 | Prgm | 9 | 1 | 53 | 38 | 101 |  | [.src/Communs/Prgm.class](.src/Communs/Prgm.class/test.md) |
| 214 | EditfacB | 4 | 4 | 38 | 10 | 628 |  | [.src/Gestion/option/EditfacB.class](.src/Gestion/option/EditfacB.class/test.md) |
| 215 | Btqart | 6 | 1 | 53 | 17 | 153 |  | [.src/Gestion/Tables/Btqart.class](.src/Gestion/Tables/Btqart.class/test.md) |
| 216 | DB_Log | 7 | 3 | 42 | 9 | 225 |  | [.src/Utils/DB_Log.class](.src/Utils/DB_Log.class/test.md) |
| 217 | barselection | 4 | 4 | 37 | 10 | 173 |  | [.src/Gestion/option/barselection.class](.src/Gestion/option/barselection.class/test.md) |
| 218 | Cielcorspj | 6 | 2 | 47 | 8 | 192 |  | [.src/Compta/Cielcorspj.class](.src/Compta/Cielcorspj.class/test.md) |
| 219 | VerifDate | 9 | 3 | 41 | 10 | 117 |  | [.src/Utils/VerifDate.class](.src/Utils/VerifDate.class/test.md) |
| 220 | Edcom | 6 | 1 | 49 | 23 | 279 |  | [.src/Gestion/Impressions/Edcom.class](.src/Gestion/Impressions/Edcom.class/test.md) |
| 221 | HitCarte | 7 | 2 | 44 | 16 | 159 |  | [.src/Statistiques/HitCarte.class](.src/Statistiques/HitCarte.class/test.md) |
| 222 | SetColors | 6 | 4 | 33 | 9 | 88 |  | [.src/Utils/SetColors.class](.src/Utils/SetColors.class/test.md) |
| 223 | Tconsigne | 6 | 1 | 48 | 7 | 153 |  | [.src/Gestion/option/Tconsigne.class](.src/Gestion/option/Tconsigne.class/test.md) |
| 224 | EdFam | 5 | 1 | 47 | 7 | 217 |  | [.src/Gestion/Impressions/EdFam.class](.src/Gestion/Impressions/EdFam.class/test.md) |
| 225 | Statut | 4 | 1 | 47 | 6 | 136 |  | [.src/Gestion/Tables/Statut.class](.src/Gestion/Tables/Statut.class/test.md) |
| 226 | chainage | 7 | 4 | 31 | 13 | 76 |  | [.src/Utils/chainage.class](.src/Utils/chainage.class/test.md) |
| 227 | ObjProp | 7 | 1 | 45 | 9 | 161 |  | [.src/Utils/ObjProp.class](.src/Utils/ObjProp.class/test.md) |
| 228 | journauxSetting | 6 | 3 | 35 | 16 | 123 |  | [.src/Compta/Impressions/journauxSetting.class](.src/Compta/Impressions/journauxSetting.class/test.md) |
| 229 | Cbalances | 6 | 1 | 44 | 5 | 263 |  | [.src/Reports/Cbalances.class](.src/Reports/Cbalances.class/test.md) |
| 230 | FCalc | 7 | 2 | 39 | 20 | 124 |  | [.src/Utils/FCalc.class](.src/Utils/FCalc.class/test.md) |
| 231 | Edbl | 7 | 2 | 39 | 6 | 212 |  | [.src/Gestion/Impressions/Edbl.class](.src/Gestion/Impressions/Edbl.class/test.md) |
| 232 | Tregion | 8 | 1 | 43 | 8 | 168 |  | [.src/Gestion/option/Tregion.class](.src/Gestion/option/Tregion.class/test.md) |
| 233 | EdnsaisisT | 6 | 6 | 18 | 7 | 151 |  | [.src/Gestion/Stock/Inventaires/Tournant/EdnsaisisT.class](.src/Gestion/Stock/Inventaires/Tournant/EdnsaisisT.class/test.md) |
| 234 | Ednsaisis | 6 | 6 | 18 | 7 | 154 |  | [.src/Gestion/Stock/Inventaires/Fin-annee/Ednsaisis.class](.src/Gestion/Stock/Inventaires/Fin-annee/Ednsaisis.class/test.md) |
| 235 | MajFbtarif1 | 1 | 1 | 43 | 21 | 161 |  | [.src/Gestion/Stock/Tarifs/MajFbtarif1.class](.src/Gestion/Stock/Tarifs/MajFbtarif1.class/test.md) |
| 236 | Analytique | 8 | 3 | 33 | 8 | 182 |  | [.src/Compta/Analytique.class](.src/Compta/Analytique.class/test.md) |
| 237 | DocActif | 12 | 2 | 37 | 13 | 150 |  | [.src/Communs/DocActif.class](.src/Communs/DocActif.class/test.md) |
| 238 | Carticles | 9 | 2 | 37 | 2 | 370 |  | [.src/Reports/Carticles.class](.src/Reports/Carticles.class/test.md) |
| 239 | Trifam | 8 | 2 | 37 | 18 | 131 |  | [.src/Utils/Trifam.class](.src/Utils/Trifam.class/test.md) |
| 240 | calculdroit | 8 | 2 | 37 | 15 | 160 |  | [.src/Gestion/option/calculdroit.class](.src/Gestion/option/calculdroit.class/test.md) |
| 241 | EcartsT | 6 | 6 | 17 | 5 | 164 |  | [.src/Gestion/Stock/Inventaires/Tournant/EcartsT.class](.src/Gestion/Stock/Inventaires/Tournant/EcartsT.class/test.md) |
| 242 | Ecarts | 6 | 6 | 17 | 5 | 162 |  | [.src/Gestion/Stock/Inventaires/Fin-annee/Ecarts.class](.src/Gestion/Stock/Inventaires/Fin-annee/Ecarts.class/test.md) |
| 243 | Plancomptable | 4 | 1 | 42 | 8 | 155 |  | [.src/Compta/Impressions/Plancomptable.class](.src/Compta/Impressions/Plancomptable.class/test.md) |
| 244 | ComMail | 5 | 2 | 36 | 7 | 130 |  | [.src/Gestion/Tables/ComMail.class](.src/Gestion/Tables/ComMail.class/test.md) |
| 245 | Creleve | 6 | 2 | 35 | 12 | 225 |  | [.src/Reports/Creleve.class](.src/Reports/Creleve.class/test.md) |
| 246 | Visreglements | 5 | 4 | 24 | 8 | 191 |  | [.src/Gestion/Reglements/Visreglements.class](.src/Gestion/Reglements/Visreglements.class/test.md) |
| 247 | Fclientc | 4 | 3 | 28 | 5 | 123 |  | [.src/Caisse/Fclientc.class](.src/Caisse/Fclientc.class/test.md) |
| 248 | Chistoriques | 7 | 2 | 33 | 1 | 291 |  | [.src/Reports/Chistoriques.class](.src/Reports/Chistoriques.class/test.md) |
| 249 | Commerciaux | 5 | 1 | 38 | 9 | 145 |  | [.src/Gestion/Tables/Commerciaux.class](.src/Gestion/Tables/Commerciaux.class/test.md) |
| 250 | VisStatComm | 6 | 2 | 32 | 14 | 219 |  | [.src/Statistiques/VisStatComm.class](.src/Statistiques/VisStatComm.class/test.md) |
| 251 | Telium | 3 | 3 | 26 | 5 | 97 |  | [.src/Caisse/Telium.class](.src/Caisse/Telium.class/test.md) |
| 252 | FSetFormat | 5 | 5 | 16 | 4 | 57 |  | [.src/Utils/FSetFormat.class](.src/Utils/FSetFormat.class/test.md) |
| 253 | VisHitCartes | 5 | 4 | 20 | 7 | 171 |  | [.src/Statistiques/VisHitCartes.class](.src/Statistiques/VisHitCartes.class/test.md) |
| 254 | Anomalies | 5 | 4 | 20 | 9 | 110 |  | [.src/Compta/Impressions/Anomalies.class](.src/Compta/Impressions/Anomalies.class/test.md) |
| 255 | MajEqu | 6 | 2 | 29 | 24 | 47 |  | [.src/Gestion/Stock/Tarifs/MajEqu.module](.src/Gestion/Stock/Tarifs/MajEqu.module/test.md) |
| 256 | Comment | 5 | 1 | 34 | 7 | 125 |  | [.src/Gestion/Tables/Comment.class](.src/Gestion/Tables/Comment.class/test.md) |
| 257 | Cetiquettes | 6 | 1 | 33 | 3 | 185 |  | [.src/Reports/Cetiquettes.class](.src/Reports/Cetiquettes.class/test.md) |
| 258 | ConVendeurs | 6 | 1 | 33 | 9 | 98 |  | [.src/Gestion/Facturation/ConVendeurs.class](.src/Gestion/Facturation/ConVendeurs.class/test.md) |
| 259 | StatPromo | 6 | 1 | 33 | 12 | 142 |  | [.src/Statistiques/StatPromo.class](.src/Statistiques/StatPromo.class/test.md) |
| 260 | Clivre | 1 | 1 | 32 | 7 | 142 |  | [.src/Reports/Clivre.class](.src/Reports/Clivre.class/test.md) |
| 261 | textfamille | 6 | 2 | 27 | 7 | 107 |  | [.src/Utils/textfamille.class](.src/Utils/textfamille.class/test.md) |
| 262 | EdReg | 5 | 3 | 22 | 10 | 59 |  | [.src/Gestion/Impressions/EdReg.class](.src/Gestion/Impressions/EdReg.class/test.md) |
| 263 | Sha1Calc | 9 | 1 | 31 | 15 | 115 |  | [.src/Utils/Sha1Calc.module](.src/Utils/Sha1Calc.module/test.md) |
| 264 | VisStatTypCli | 5 | 1 | 30 | 10 | 206 |  | [.src/Statistiques/VisStatTypCli.class](.src/Statistiques/VisStatTypCli.class/test.md) |
| 265 | Cstocks | 7 | 2 | 24 | 1 | 241 |  | [.src/Reports/Cstocks.class](.src/Reports/Cstocks.class/test.md) |
| 266 | VisStatFour | 4 | 1 | 29 | 8 | 214 |  | [.src/Statistiques/VisStatFour.class](.src/Statistiques/VisStatFour.class/test.md) |
| 267 | Epurjdv | 2 | 1 | 29 | 18 | 172 |  | [.src/Compta/Utils/Epurjdv.class](.src/Compta/Utils/Epurjdv.class/test.md) |
| 268 | FSauve | 6 | 2 | 22 | 12 | 88 |  | [.src/Communs/FSauve.class](.src/Communs/FSauve.class/test.md) |
| 269 | Edinv1 | 1 | 1 | 27 | 15 | 126 |  | [.src/Gestion/Stock/Inventaires/Fin-annee/Edinv1.class](.src/Gestion/Stock/Inventaires/Fin-annee/Edinv1.class/test.md) |
| 270 | Conditions | 4 | 2 | 21 | 13 | 79 |  | [.src/Utils/Conditions.class](.src/Utils/Conditions.class/test.md) |
| 271 | VerifNumfac | 2 | 1 | 26 | 26 | 86 |  | [.src/Utils/VerifNumfac.module](.src/Utils/VerifNumfac.module/test.md) |
| 272 | Variables | 7 | 6 | 0 | 0 | 42 | oui | [.src/Utils/Variables.module](.src/Utils/Variables.module/test.md) |
| 273 | Cprod | 2 | 2 | 20 | 6 | 86 |  | [.src/Utils/Cprod.class](.src/Utils/Cprod.class/test.md) |
| 274 | AFacture | 5 | 2 | 20 | 12 | 83 |  | [.src/Affichages/AFacture.class](.src/Affichages/AFacture.class/test.md) |
| 275 | CompArt | 3 | 3 | 14 | 10 | 54 |  | [.src/Utils/CompArt.class](.src/Utils/CompArt.class/test.md) |
| 276 | Ccomptes | 5 | 1 | 24 | 6 | 97 |  | [.src/Compta/Ccomptes.module](.src/Compta/Ccomptes.module/test.md) |
| 277 | Agenda | 4 | 1 | 23 | 5 | 117 |  | [.src/Utils/Agenda.class](.src/Utils/Agenda.class/test.md) |
| 278 | menuopt | 3 | 2 | 18 | 3 | 127 |  | [.src/Gestion/option/menuopt.class](.src/Gestion/option/menuopt.class/test.md) |
| 279 | EdinvT | 1 | 1 | 23 | 10 | 161 |  | [.src/Gestion/Stock/Inventaires/Tournant/EdinvT.class](.src/Gestion/Stock/Inventaires/Tournant/EdinvT.class/test.md) |
| 280 | Tleg | 4 | 1 | 23 | 6 | 67 |  | [.src/Gestion/Tables/Tleg.class](.src/Gestion/Tables/Tleg.class/test.md) |
| 281 | Lettragemontant | 5 | 1 | 23 | 16 | 104 |  | [.src/Compta/Lettrages/Lettragemontant.class](.src/Compta/Lettrages/Lettragemontant.class/test.md) |
| 282 | FTips | 5 | 1 | 22 | 8 | 87 |  | [.src/Communs/FTips.class](.src/Communs/FTips.class/test.md) |
| 283 | Cdocuments3 | 3 | 2 | 17 | 2 | 159 |  | [.src/Reports/Cdocuments3.class](.src/Reports/Cdocuments3.class/test.md) |
| 284 | Listecom | 5 | 1 | 22 | 14 | 162 |  | [.src/Gestion/Stock/Listecom.class](.src/Gestion/Stock/Listecom.class/test.md) |
| 285 | Clavier | 4 | 2 | 16 | 8 | 59 |  | [.src/Caisse/Clavier.class](.src/Caisse/Clavier.class/test.md) |
| 286 | TestCaisses | 4 | 4 | 6 | 6 | 25 |  | [.src/Caisse/TestCaisses.module](.src/Caisse/TestCaisses.module/test.md) |
| 287 | Cbordereaux | 6 | 2 | 16 | 1 | 97 |  | [.src/Reports/Cbordereaux.class](.src/Reports/Cbordereaux.class/test.md) |
| 288 | ArtPromo | 6 | 2 | 16 | 4 | 44 |  | [.src/Gestion/Tables/ArtPromo.module](.src/Gestion/Tables/ArtPromo.module/test.md) |
| 289 | EcrReg | 7 | 1 | 21 | 18 | 135 |  | [.src/Compta/Utils/EcrReg.class](.src/Compta/Utils/EcrReg.class/test.md) |
| 290 | Svendeur | 4 | 2 | 15 | 6 | 44 |  | [.src/Caisse/Svendeur.class](.src/Caisse/Svendeur.class/test.md) |
| 291 | Fprepdus | 5 | 1 | 20 | 8 | 73 |  | [.src/Communs/Fprepdus.class](.src/Communs/Fprepdus.class/test.md) |
| 292 | Calcsolde | 7 | 1 | 20 | 8 | 70 |  | [.src/Utils/Calcsolde.class](.src/Utils/Calcsolde.class/test.md) |
| 293 | VisStatClimo | 5 | 1 | 19 | 4 | 185 |  | [.src/Statistiques/VisStatClimo.class](.src/Statistiques/VisStatClimo.class/test.md) |
| 294 | ACom | 4 | 2 | 14 | 6 | 66 |  | [.src/Affichages/ACom.class](.src/Affichages/ACom.class/test.md) |
| 295 | RazHistoTk | 6 | 3 | 9 | 7 | 34 |  | [.src/Archivages/RazHistoTk.class](.src/Archivages/RazHistoTk.class/test.md) |
| 296 | RazHistoFac | 6 | 2 | 14 | 11 | 50 |  | [.src/Archivages/RazHistoFac.class](.src/Archivages/RazHistoFac.class/test.md) |
| 297 | RazDevis | 5 | 2 | 14 | 11 | 50 |  | [.src/Archivages/RazDevis.class](.src/Archivages/RazDevis.class/test.md) |
| 298 | Cclients | 5 | 2 | 13 | 1 | 118 |  | [.src/Reports/Cclients.class](.src/Reports/Cclients.class/test.md) |
| 299 | Cmo | 2 | 2 | 13 | 3 | 55 |  | [.src/Utils/Cmo.class](.src/Utils/Cmo.class/test.md) |
| 300 | RazArt | 7 | 1 | 18 | 13 | 68 |  | [.src/Utils/RazArt.class](.src/Utils/RazArt.class/test.md) |
| 301 | LDateC | 3 | 3 | 8 | 3 | 33 |  | [.src/Utils/LDateC.class](.src/Utils/LDateC.class/test.md) |
| 302 | Carch | 2 | 2 | 13 | 3 | 56 |  | [.src/Utils/Carch.class](.src/Utils/Carch.class/test.md) |
| 303 | rechcons | 4 | 1 | 18 | 8 | 74 |  | [.src/Gestion/option/rechcons.class](.src/Gestion/option/rechcons.class/test.md) |
| 304 | Visimpayes | 1 | 1 | 18 | 7 | 157 |  | [.src/Compta/Lettrages/Visimpayes.class](.src/Compta/Lettrages/Visimpayes.class/test.md) |
| 305 | RazRlvb | 6 | 3 | 8 | 6 | 30 |  | [.src/Archivages/RazRlvb.class](.src/Archivages/RazRlvb.class/test.md) |
| 306 | ProgBar | 6 | 1 | 17 | 4 | 73 |  | [.src/Utils/ProgBar.class](.src/Utils/ProgBar.class/test.md) |
| 307 | modCrBcode | 1 | 1 | 17 | 17 | 79 |  | [.src/Utils/modCrBcode.module](.src/Utils/modCrBcode.module/test.md) |
| 308 | Statbase | 4 | 4 | 2 | 1 | 32 |  | [.src/Statistiques/Statbase.class](.src/Statistiques/Statbase.class/test.md) |
| 309 | TriTest | 3 | 3 | 7 | 2 | 43 |  | [.src/Tests/TriTest.class](.src/Tests/TriTest.class/test.md) |
| 310 | Mmysql | 3 | 2 | 11 | 7 | 27 |  | [.src/Utils/Mmysql.module](.src/Utils/Mmysql.module/test.md) |
| 311 | Cstock | 12 | 1 | 16 | 13 | 108 |  | [.src/Utils/Cstock.module](.src/Utils/Cstock.module/test.md) |
| 312 | LVar | 6 | 1 | 15 | 5 | 61 |  | [.src/Utils/LVar.class](.src/Utils/LVar.class/test.md) |
| 313 | rechtour | 4 | 2 | 10 | 3 | 41 |  | [.src/Gestion/option/rechtour.class](.src/Gestion/option/rechtour.class/test.md) |
| 314 | RazInvT | 3 | 3 | 5 | 3 | 13 |  | [.src/Gestion/Stock/Inventaires/Tournant/RazInvT.class](.src/Gestion/Stock/Inventaires/Tournant/RazInvT.class/test.md) |
| 315 | RazInv | 3 | 3 | 5 | 3 | 13 |  | [.src/Gestion/Stock/Inventaires/Fin-annee/RazInv.class](.src/Gestion/Stock/Inventaires/Fin-annee/RazInv.class/test.md) |
| 316 | Expbase | 3 | 1 | 14 | 10 | 42 |  | [.src/Utils/Exports-Imports/Expbase.class](.src/Utils/Exports-Imports/Expbase.class/test.md) |
| 317 | Edittipp | 3 | 2 | 9 | 2 | 38 |  | [.src/Gestion/option/Edittipp.class](.src/Gestion/option/Edittipp.class/test.md) |
| 318 | Lettragesoldes | 4 | 1 | 14 | 7 | 68 |  | [.src/Compta/Lettrages/Lettragesoldes.class](.src/Compta/Lettrages/Lettragesoldes.class/test.md) |
| 319 | Exprub | 5 | 2 | 9 | 9 | 48 |  | [.src/Compta/Utils/Exprub.class](.src/Compta/Utils/Exprub.class/test.md) |
| 320 | RazHistoFbl | 6 | 2 | 9 | 7 | 34 |  | [.src/Archivages/RazHistoFbl.class](.src/Archivages/RazHistoFbl.class/test.md) |
| 321 | rechtipp | 4 | 1 | 13 | 5 | 59 |  | [.src/Gestion/option/rechtipp.class](.src/Gestion/option/rechtipp.class/test.md) |
| 322 | Cresultat | 3 | 1 | 12 | 3 | 66 |  | [.src/Reports/Cresultat.class](.src/Reports/Cresultat.class/test.md) |
| 323 | CalcRem | 4 | 1 | 12 | 7 | 40 |  | [.src/Utils/CalcRem.class](.src/Utils/CalcRem.class/test.md) |
| 324 | DB_Desktop | 4 | 2 | 7 | 3 | 31 |  | [.src/Utils/DB_Desktop.class](.src/Utils/DB_Desktop.class/test.md) |
| 325 | Expart | 5 | 1 | 12 | 8 | 79 |  | [.src/Utils/Exports-Imports/Expart.class](.src/Utils/Exports-Imports/Expart.class/test.md) |
| 326 | Consigne | 6 | 1 | 12 | 3 | 61 |  | [.src/Gestion/option/Consigne.class](.src/Gestion/option/Consigne.class/test.md) |
| 327 | MDP | 5 | 1 | 11 | 6 | 34 |  | [.src/Communs/MDP.class](.src/Communs/MDP.class/test.md) |
| 328 | Impression | 3 | 1 | 11 | 7 | 44 |  | [.src/Utils/Impression.module](.src/Utils/Impression.module/test.md) |
| 329 | RecupDech | 4 | 2 | 6 | 4 | 20 |  | [.src/Compta/Utils/RecupDech.class](.src/Compta/Utils/RecupDech.class/test.md) |
| 330 | LTrans | 5 | 2 | 5 | 1 | 22 |  | [.src/Utils/LTrans.class](.src/Utils/LTrans.class/test.md) |
| 331 | gridv | 1 | 1 | 10 | 10 | 56 |  | [.src/Utils/gridv.module](.src/Utils/gridv.module/test.md) |
| 332 | Cmat | 2 | 1 | 8 | 1 | 54 |  | [.src/Reports/Cmat.class](.src/Reports/Cmat.class/test.md) |
| 333 | Monip | 2 | 2 | 3 | 3 | 30 |  | [.src/Utils/Monip.module](.src/Utils/Monip.module/test.md) |
| 334 | RenumBl | 3 | 1 | 8 | 8 | 29 |  | [.src/Utils/RenumBl.class](.src/Utils/RenumBl.class/test.md) |
| 335 | RazClientd | 5 | 1 | 8 | 6 | 28 |  | [.src/Archivages/RazClientd.class](.src/Archivages/RazClientd.class/test.md) |
| 336 | Fsystem | 2 | 1 | 7 | 6 | 30 |  | [.src/Communs/Fsystem.class](.src/Communs/Fsystem.class/test.md) |
| 337 | Doc | 5 | 2 | 2 | 2 | 8 |  | [.src/Communs/Doc.module](.src/Communs/Doc.module/test.md) |
| 338 | RenMvt | 3 | 1 | 7 | 4 | 48 |  | [.src/Compta/Utils/RenMvt.module](.src/Compta/Utils/RenMvt.module/test.md) |
| 339 | Htickets | 3 | 1 | 6 | 1 | 33 |  | [.src/Reports/Htickets.class](.src/Reports/Htickets.class/test.md) |
| 340 | ChxImp | 1 | 1 | 6 | 5 | 20 |  | [.src/Reports/ChxImp.class](.src/Reports/ChxImp.class/test.md) |
| 341 | Cecheancier | 1 | 1 | 6 | 1 | 39 |  | [.src/Reports/Cecheancier.class](.src/Reports/Cecheancier.class/test.md) |
| 342 | TypeClient | 3 | 1 | 6 | 3 | 24 |  | [.src/Compta/Utils/TypeClient.class](.src/Compta/Utils/TypeClient.class/test.md) |
| 343 | Copie | 3 | 1 | 5 | 5 | 17 |  | [.src/Utils/Copie.module](.src/Utils/Copie.module/test.md) |
| 344 | AffRdv | 2 | 1 | 5 | 4 | 18 |  | [.src/Utils/AffRdv.module](.src/Utils/AffRdv.module/test.md) |
| 345 | RazClos | 4 | 1 | 4 | 1 | 15 |  | [.src/Compta/Utils/RazClos.class](.src/Compta/Utils/RazClos.class/test.md) |
| 346 | Ctraites | 1 | 1 | 3 | 1 | 19 |  | [.src/Reports/Ctraites.class](.src/Reports/Ctraites.class/test.md) |
| 347 | RenAN | 1 | 1 | 3 | 3 | 12 |  | [.src/Compta/Utils/RenAN.class](.src/Compta/Utils/RenAN.class/test.md) |
| 348 | Renech | 3 | 1 | 3 | 3 | 15 |  | [.src/Compta/Utils/Renech.class](.src/Compta/Utils/Renech.class/test.md) |
| 349 | Tchauffeur | 1 | 1 | 2 | 1 | 6 |  | [.src/Gestion/option/Tchauffeur.class](.src/Gestion/option/Tchauffeur.class/test.md) |
| 350 | Site | 2 | 1 | 1 | 1 | 9 |  | [.src/Gestion/Site.module](.src/Gestion/Site.module/test.md) |
| 351 | Condition | 1 | 1 | 0 | 0 | 4 |  | [.src/Utils/Condition.class](.src/Utils/Condition.class/test.md) |
| 352 | Cmoprod | 1 | 1 | 0 | 0 | 6 |  | [.src/Utils/Cmoprod.class](.src/Utils/Cmoprod.class/test.md) |
| 353 | Comptabilite | 2 | 1 | 0 | 0 | 6 |  | [.src/Compta/Utils/Comptabilite.module](.src/Compta/Utils/Comptabilite.module/test.md) |
<!-- /AUTO:tests -->
