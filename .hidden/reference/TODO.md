# TODO du rework

> Phase 2 : tests (bloc généré ci-dessous). Phase 3 : ordre des rework_id (à venir).

## Hors périmètre des tests (décisions utilisateur)

- `Communs/LauruxMaj.module` (2026-11-11) : migrations historiques de la base non testées (voir [PLAN.md §4.0](PLAN.md)). Un test dont le statut commence par « hors périmètre » n'apparaît pas dans la liste générée.

<!-- AUTO:tests -->
## Phase 2 — tests

> Bloc généré par `python3 .src/Tests/Framework/runner.py report` ; liste détaillée des tests implémentés : [output/tests/list.md](../../output/tests/list.md).

### Tests à vérifier à la main (21)

Tests synthétisés dont le comportement obtenu diffère de celui décrit par test.md (xfail), en échec, ou retirés des campagnes car connus instables ou en erreur (« à la main » : verification_manuelle de meta.json, lancés seulement par leur nom exact) : à vérifier ou corriger par l'utilisateur.

| Test | Statut | Obtenu | Attendu (test.md) | Raison | Description |
|---|---|---|---|---|---|
| [ARCHIVES-T13](.src/Archivages/Archives.class/test.md) | xfail | identique | erreur SQL attrapée, liste inchangée (A06) | erreur SQL non attrapée : Query failed (Archives.… | archives_guillemet |
| [CALCSTOCK-T05](.src/Utils/Calcstock.class/test.md) | xfail | identique | avertissement « Traitement impossible, la caisse numéro 01e… | contrôle de caisse connectée inopérant sur MySQL … | calcstock_caisse_connectee |
| [CDOCUMENTS-T06](.src/Reports/Cdocuments.class/test.md) | xfail | identique | PDF du relevé de 411003 (10 prestations) produit et comparé… | Button2 : « If rResult!villerc_sc Then » (champs … | cdocuments_relvmo |
| [ECRM-T09](.src/Compta/Impressions/EcrM.class/test.md) | xfail | identique | datem NULL traité sur toutes les branches (date vide), PDF … | Format$(datem NULL) sur la ligne 512 (trésorerie)… | ecrm_datem_nul |
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
| [SAISIEINVT-T13](.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class/test.md) | xfail | identique | message « fichier absent », aucune mise à jour (A09) | erreur non gérée : Eof(hFil) sur le fichier non o… | saisieinvt_import_absent |
| [SAISIEINVT-T15](.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class/test.md) | xfail | identique | message « article absent », aucune mise à jour (A04) | erreur fatale « Result is not available » (Saisie… | saisieinvt_art_supprime_ligne |
| [SAISIEINVT-T15](.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class/test.md) | xfail | identique | ligne affichée sans désignation ou message, écran utilisabl… | erreur fatale « Result is not available » (Saisie… | saisieinvt_art_supprime_ouverture |
| [START-T17](.src/Start.module/test.md) | xfail | identique | deux itérations de Main, fin propre (code 0) | La fermeture de LauruxConf écrit dans le journal … | start_redemarrage |
| [TRECARTS-T06](.src/Compta/Trecarts.class/test.md) | xfail | identique | ligne collectif écrite sur un compte vide (comportement A04… | erreur SQL fatale (compte NULL) au lieu d'une lig… | trecarts_sans_collectif |
| [VALIDINV-T11](.src/Gestion/Stock/Inventaires/Fin-annee/Validinv.class/test.md) | xfail | identique | validation transactionnelle : article absent signalé, aucun… | erreur non attrapée : Result is not available (Va… | validinv_article_supprime |

### Tests bloqués (554), par cause

Test non implémenté dont le statut test.md donne une raison de blocage (évolution du framework de test, réécriture du code applicatif, anomalie, module complexe en attente de validation…), classée par `runner.py` (`BLOCAGES`) d'après cette raison. Les autres tests non implémentés sont « restants » (réalisables avec l'outillage actuel) : 190.

| Cause | Tests |
|---|---|
| extraction / réécriture (phases 3-4) | 170 |
| module complexe (revue manuelle) | 131 |
| Message.* / fenêtre modale | 63 |
| SQLite | 49 |
| outillage runner (comparaison, mesure) | 48 |
| clavier / souris | 32 |
| anomalie applicative | 16 |
| matériel / réseau / environnement | 12 |
| contrôle non rejouable | 9 |
| harnais : démarrage, code de sortie | 8 |
| dialogue natif | 6 |
| écran sans point d'entrée | 5 |
| non retenu par l'utilisateur | 4 |
| autre (voir test.md) | 1 |

### Classes dont des tests restent à implémenter (288), par priorité

Restant = prévus − implémentés − bloqués (tests réalisables avec l'outillage actuel). Priorité = complexité cyclomatique totale (×2 pour un module complexe à scénarios validés par l'utilisateur) + 5 par test restant.

| # | Classe | Tests prévus | Implémentés | Tests bloqués | Restant | Causes de blocage | CC totale | CC max | LOC | Complexe | test.md |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | Facture | 27 | 0 | 0 | 27 |  | 3116 | 166 | 10446 | oui | [.src/Gestion/Facturation/Facture.class](.src/Gestion/Facturation/Facture.class/test.md) |
| 2 | Caisse | 25 | 0 | 0 | 25 |  | 2102 | 77 | 7303 | oui | [.src/Caisse/Caisse.class](.src/Caisse/Caisse.class/test.md) |
| 3 | Articles | 18 | 0 | 0 | 18 |  | 1128 | 96 | 3775 | oui | [.src/Gestion/Tables/Articles.class](.src/Gestion/Tables/Articles.class/test.md) |
| 4 | FClient | 18 | 0 | 0 | 18 |  | 675 | 42 | 2716 | oui | [.src/Gestion/Tables/FClient.class](.src/Gestion/Tables/FClient.class/test.md) |
| 5 | Saisecrit | 17 | 0 | 0 | 17 |  | 654 | 72 | 2528 | oui | [.src/Compta/Saisecrit.class](.src/Compta/Saisecrit.class/test.md) |
| 6 | Moulinage | 23 | 0 | 0 | 23 |  | 622 | 196 | 2431 | oui | [.src/Caisse/Moulinage.class](.src/Caisse/Moulinage.class/test.md) |
| 7 | Impart | 15 | 0 | 0 | 15 |  | 548 | 186 | 1647 | oui | [.src/Gestion/Stock/Tarifs/Impart.class](.src/Gestion/Stock/Tarifs/Impart.class/test.md) |
| 8 | FFournisseur | 16 | 0 | 0 | 16 |  | 545 | 35 | 2156 | oui | [.src/Gestion/Tables/FFournisseur.class](.src/Gestion/Tables/FFournisseur.class/test.md) |
| 9 | MajTarifM | 11 | 0 | 0 | 11 |  | 319 | 25 | 1107 | oui | [.src/Gestion/Stock/Tarifs/MajTarifM.class](.src/Gestion/Stock/Tarifs/MajTarifM.class/test.md) |
| 10 | Achat | 14 | 0 | 0 | 14 |  | 293 | 19 | 1463 | oui | [.src/Gestion/Entrées/Achat.class](.src/Gestion/Entrées/Achat.class/test.md) |
| 11 | Tresor | 17 | 14 | 3 | 0 | clavier / souris 2, contrôle non rejouable 1 | 579 | 82 | 2185 |  | [.src/Compta/Tresor.class](.src/Compta/Tresor.class/test.md) |
| 12 | Fmenu | 20 | 14 | 6 | 0 | harnais : démarrage, code de sortie 3, extraction / réécriture (phases 3-4) 1, outillage runner (comparaison, mesure) 1, clavier / souris 1 | 510 | 54 | 1579 |  | [.src/Communs/Fmenu.class](.src/Communs/Fmenu.class/test.md) |
| 13 | Utils | 26 | 23 | 3 | 0 | outillage runner (comparaison, mesure) 2, Message.* / fenêtre modale 1 | 475 | 77 | 1315 |  | [.src/Utils/Utils.module](.src/Utils/Utils.module/test.md) |
| 14 | Materiel | 12 | 10 | 2 | 0 | extraction / réécriture (phases 3-4) 1, module complexe (revue manuelle) 1 | 444 | 24 | 2054 |  | [.src/Gestion/Tables/Materiel.class](.src/Gestion/Tables/Materiel.class/test.md) |
| 15 | Prefs | 17 | 14 | 3 | 0 | dialogue natif 1, outillage runner (comparaison, mesure) 1, matériel / réseau / environnement 1 | 374 | 186 | 1121 |  | [.src/Communs/Prefs.class](.src/Communs/Prefs.class/test.md) |
| 16 | Start | 17 | 9 | 8 | 0 | outillage runner (comparaison, mesure) 3, extraction / réécriture (phases 3-4) 3, anomalie applicative 1, harnais : démarrage, code de sortie 1 | 350 | 112 | 893 |  | [.src/Start.module](.src/Start.module/test.md) |
| 17 | Imp_Bilan | 10 | 8 | 2 | 0 | extraction / réécriture (phases 3-4) 2 | 336 | 335 | 767 |  | [.src/Compta/Impressions/Imp_Bilan.module](.src/Compta/Impressions/Imp_Bilan.module/test.md) |
| 18 | Movr | 9 | 7 | 2 | 0 | extraction / réécriture (phases 3-4) 1, module complexe (revue manuelle) 1 | 323 | 35 | 1271 |  | [.src/Gestion/Tables/Movr.class](.src/Gestion/Tables/Movr.class/test.md) |
| 19 | Archives | 15 | 12 | 3 | 0 | clavier / souris 1, Message.* / fenêtre modale 1, SQLite 1 | 307 | 35 | 1202 |  | [.src/Archivages/Archives.class](.src/Archivages/Archives.class/test.md) |
| 20 | FComptes | 11 | 8 | 3 | 0 | extraction / réécriture (phases 3-4) 2, clavier / souris 1 | 271 | 48 | 919 |  | [.src/Compta/Tables/FComptes.class](.src/Compta/Tables/FComptes.class/test.md) |
| 21 | Facturergbl | 7 | 5 | 2 | 0 | extraction / réécriture (phases 3-4) 1, module complexe (revue manuelle) 1 | 258 | 121 | 1232 |  | [.src/Gestion/Facturation/Facturergbl.class](.src/Gestion/Facturation/Facturergbl.class/test.md) |
| 22 | Histocliart | 11 | 10 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 245 | 141 | 836 |  | [.src/Statistiques/Histocliart.class](.src/Statistiques/Histocliart.class/test.md) |
| 23 | Extrait | 14 | 12 | 2 | 0 | SQLite 1, extraction / réécriture (phases 3-4) 1 | 236 | 31 | 1127 |  | [.src/Compta/Extrait.class](.src/Compta/Extrait.class/test.md) |
| 24 | Etigond | 13 | 12 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 235 | 51 | 915 |  | [.src/Gestion/Etiquettes/Etigond.class](.src/Gestion/Etiquettes/Etigond.class/test.md) |
| 25 | ValidBR | 3 | 2 | 1 | 0 | Message.* / fenêtre modale 1 | 231 | 40 | 1079 |  | [.src/Gestion/Stock/ValidBR.class](.src/Gestion/Stock/ValidBR.class/test.md) |
| 26 | TresorFac | 2 | 0 | 2 | 0 | extraction / réécriture (phases 3-4) 1, écran sans point d'entrée 1 | 225 | 44 | 1081 |  | [.src/Gestion/Reglements/TresorFac.class](.src/Gestion/Reglements/TresorFac.class/test.md) |
| 27 | commande1 | 14 | 6 | 8 | 0 | module complexe (revue manuelle) 8 | 219 | 29 | 850 |  | [.src/Gestion/Stock/commande1.class](.src/Gestion/Stock/commande1.class/test.md) |
| 28 | Famille | 9 | 8 | 1 | 0 | outillage runner (comparaison, mesure) 1 | 218 | 28 | 761 |  | [.src/Gestion/Tables/Famille.class](.src/Gestion/Tables/Famille.class/test.md) |
| 29 | FClientcarte | 10 | 8 | 2 | 0 | Message.* / fenêtre modale 1, extraction / réécriture (phases 3-4) 1 | 216 | 28 | 863 |  | [.src/Caisse/FClientcarte.class](.src/Caisse/FClientcarte.class/test.md) |
| 30 | LGed | 15 | 12 | 3 | 0 | dialogue natif 1, outillage runner (comparaison, mesure) 1, module complexe (revue manuelle) 1 | 215 | 29 | 757 |  | [.src/Utils/LGed.class](.src/Utils/LGed.class/test.md) |
| 31 | Emailing | 11 | 8 | 3 | 0 | Message.* / fenêtre modale 3 | 212 | 37 | 775 |  | [.src/Gestion/Mails/Emailing.class](.src/Gestion/Mails/Emailing.class/test.md) |
| 32 | Parametre | 12 | 11 | 1 | 0 | Message.* / fenêtre modale 1 | 208 | 62 | 539 |  | [.src/Communs/Parametre.class](.src/Communs/Parametre.class/test.md) |
| 33 | SaiReg | 11 | 8 | 3 | 0 | Message.* / fenêtre modale 2, module complexe (revue manuelle) 1 | 207 | 24 | 913 |  | [.src/Gestion/Facturation/SaiReg.class](.src/Gestion/Facturation/SaiReg.class/test.md) |
| 34 | ImpartParam | 8 | 6 | 2 | 0 | Message.* / fenêtre modale 1, clavier / souris 1 | 206 | 27 | 782 |  | [.src/Gestion/Stock/Tarifs/ImpartParam.class](.src/Gestion/Stock/Tarifs/ImpartParam.class/test.md) |
| 35 | ExportJdv | 16 | 13 | 3 | 0 | contrôle non rejouable 1, extraction / réécriture (phases 3-4) 1, matériel / réseau / environnement 1 | 205 | 103 | 839 |  | [.src/Compta/Utils/ExportJdv.class](.src/Compta/Utils/ExportJdv.class/test.md) |
| 36 | ConsultArt | 7 | 5 | 2 | 0 | contrôle non rejouable 1, extraction / réécriture (phases 3-4) 1 | 200 | 37 | 771 |  | [.src/Gestion/Tables/ConsultArt.class](.src/Gestion/Tables/ConsultArt.class/test.md) |
| 37 | RubImp | 10 | 6 | 4 | 0 | outillage runner (comparaison, mesure) 2, SQLite 1, extraction / réécriture (phases 3-4) 1 | 198 | 135 | 983 |  | [.src/Compta/Impressions/RubImp.class](.src/Compta/Impressions/RubImp.class/test.md) |
| 38 | TriEcritures | 6 | 4 | 2 | 0 | module complexe (revue manuelle) 1, extraction / réécriture (phases 3-4) 1 | 198 | 11 | 602 |  | [.src/Affichages/TriEcritures.class](.src/Affichages/TriEcritures.class/test.md) |
| 39 | Etiqart | 12 | 9 | 3 | 0 | module complexe (revue manuelle) 2, extraction / réécriture (phases 3-4) 1 | 197 | 24 | 848 |  | [.src/Gestion/Etiquettes/Etiqart.class](.src/Gestion/Etiquettes/Etiqart.class/test.md) |
| 40 | RelMoprod | 9 | 8 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 189 | 30 | 787 |  | [.src/Statistiques/RelMoprod.class](.src/Statistiques/RelMoprod.class/test.md) |
| 41 | Etiqcasier | 9 | 8 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 187 | 24 | 793 |  | [.src/Gestion/Etiquettes/Etiqcasier.class](.src/Gestion/Etiquettes/Etiqcasier.class/test.md) |
| 42 | TriFac2 | 7 | 2 | 5 | 0 | module complexe (revue manuelle) 3, clavier / souris 1, extraction / réécriture (phases 3-4) 1 | 187 | 20 | 630 |  | [.src/Affichages/TriFac2.class](.src/Affichages/TriFac2.class/test.md) |
| 43 | Cdocuments2 | 2 | 0 | 2 | 0 | module complexe (revue manuelle) 1, extraction / réécriture (phases 3-4) 1 | 182 | 31 | 926 |  | [.src/Reports/Cdocuments2.class](.src/Reports/Cdocuments2.class/test.md) |
| 44 | ObjFac | 16 | 15 | 1 | 0 | outillage runner (comparaison, mesure) 1 | 181 | 45 | 893 |  | [.src/Gestion/Facturation/ObjFac.class](.src/Gestion/Facturation/ObjFac.class/test.md) |
| 45 | TextReg | 10 | 6 | 4 | 0 | clavier / souris 2, module complexe (revue manuelle) 1, extraction / réécriture (phases 3-4) 1 | 177 | 31 | 536 |  | [.src/Utils/TextReg.class](.src/Utils/TextReg.class/test.md) |
| 46 | facopt | 8 | 0 | 8 | 0 | module complexe (revue manuelle) 8 | 173 | 19 | 875 |  | [.src/Gestion/option/facopt.class](.src/Gestion/option/facopt.class/test.md) |
| 47 | ImpSage | 10 | 8 | 2 | 0 | extraction / réécriture (phases 3-4) 2 | 172 | 50 | 699 |  | [.src/Compta/Utils/ImpSage.class](.src/Compta/Utils/ImpSage.class/test.md) |
| 48 | DB_Sanity | 9 | 3 | 6 | 0 | outillage runner (comparaison, mesure) 3, extraction / réécriture (phases 3-4) 2, SQLite 1 | 171 | 50 | 576 |  | [.src/Utils/DB_Sanity.class](.src/Utils/DB_Sanity.class/test.md) |
| 49 | Stockmvt | 11 | 9 | 2 | 0 | module complexe (revue manuelle) 1, extraction / réécriture (phases 3-4) 1 | 163 | 75 | 843 |  | [.src/Gestion/Stockmvt.class](.src/Gestion/Stockmvt.class/test.md) |
| 50 | Histovmo | 9 | 8 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 163 | 39 | 674 |  | [.src/Statistiques/Histovmo.class](.src/Statistiques/Histovmo.class/test.md) |
| 51 | TriGen | 12 | 9 | 3 | 0 | extraction / réécriture (phases 3-4) 2, Message.* / fenêtre modale 1 | 163 | 17 | 626 |  | [.src/Affichages/TriGen.class](.src/Affichages/TriGen.class/test.md) |
| 52 | DB_Connection | 16 | 14 | 2 | 0 | module complexe (revue manuelle) 1, outillage runner (comparaison, mesure) 1 | 162 | 42 | 561 |  | [.src/Utils/DB_Connection.class](.src/Utils/DB_Connection.class/test.md) |
| 53 | Editfac | 10 | 0 | 10 | 0 | module complexe (revue manuelle) 10 | 154 | 112 | 476 |  | [.src/Reports/Editfac.class](.src/Reports/Editfac.class/test.md) |
| 54 | TriHistos | 6 | 5 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 147 | 29 | 602 |  | [.src/Affichages/TriHistos.class](.src/Affichages/TriHistos.class/test.md) |
| 55 | GesTar | 10 | 0 | 10 | 0 | module complexe (revue manuelle) 10 | 145 | 14 | 676 |  | [.src/Gestion/Entrées/GesTar.class](.src/Gestion/Entrées/GesTar.class/test.md) |
| 56 | Cielimp | 12 | 11 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 140 | 54 | 520 |  | [.src/Compta/Cielimp.class](.src/Compta/Cielimp.class/test.md) |
| 57 | Jourcent | 10 | 9 | 1 | 0 | clavier / souris 1 | 137 | 22 | 780 |  | [.src/Compta/Impressions/Jourcent.class](.src/Compta/Impressions/Jourcent.class/test.md) |
| 58 | EmailingCarte | 7 | 6 | 1 | 0 | Message.* / fenêtre modale 1 | 136 | 25 | 474 |  | [.src/Gestion/Mails/EmailingCarte.class](.src/Gestion/Mails/EmailingCarte.class/test.md) |
| 59 | Editcompte | 10 | 8 | 2 | 0 | outillage runner (comparaison, mesure) 1, Message.* / fenêtre modale 1 | 136 | 56 | 579 |  | [.src/Compta/Impressions/Editcompte.class](.src/Compta/Impressions/Editcompte.class/test.md) |
| 60 | Preparation | 11 | 8 | 3 | 0 | clavier / souris 2, SQLite 1 | 135 | 16 | 644 |  | [.src/Gestion/Lcr/Preparation.class](.src/Gestion/Lcr/Preparation.class/test.md) |
| 61 | FTVA | 13 | 9 | 4 | 0 | extraction / réécriture (phases 3-4) 2, contrôle non rejouable 1, SQLite 1 | 133 | 51 | 698 |  | [.src/Compta/Impressions/FTVA.class](.src/Compta/Impressions/FTVA.class/test.md) |
| 62 | Prodcomposes | 8 | 5 | 3 | 0 | clavier / souris 1, extraction / réécriture (phases 3-4) 1, SQLite 1 | 130 | 20 | 534 |  | [.src/Gestion/Tables/Prodcomposes.class](.src/Gestion/Tables/Prodcomposes.class/test.md) |
| 63 | JournauxA | 8 | 6 | 2 | 0 | outillage runner (comparaison, mesure) 2 | 128 | 24 | 664 |  | [.src/Compta/Impressions/JournauxA.class](.src/Compta/Impressions/JournauxA.class/test.md) |
| 64 | TriFac | 5 | 2 | 3 | 0 | module complexe (revue manuelle) 2, extraction / réécriture (phases 3-4) 1 | 127 | 19 | 410 |  | [.src/Affichages/TriFac.class](.src/Affichages/TriFac.class/test.md) |
| 65 | Pointage | 13 | 11 | 2 | 0 | contrôle non rejouable 1, SQLite 1 | 126 | 23 | 647 |  | [.src/Compta/Pointage.class](.src/Compta/Pointage.class/test.md) |
| 66 | Attribution | 9 | 8 | 1 | 0 | SQLite 1 | 125 | 19 | 518 |  | [.src/Gestion/Lcr/Attribution.class](.src/Gestion/Lcr/Attribution.class/test.md) |
| 67 | Fcaisses | 7 | 5 | 2 | 0 | Message.* / fenêtre modale 1, clavier / souris 1 | 122 | 26 | 293 |  | [.src/Caisse/Fcaisses.class](.src/Caisse/Fcaisses.class/test.md) |
| 68 | Cbase | 4 | 3 | 1 | 0 | outillage runner (comparaison, mesure) 1 | 122 | 122 | 248 |  | [.src/Utils/Cbase.module](.src/Utils/Cbase.module/test.md) |
| 69 | EdArt1 | 11 | 10 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 122 | 31 | 532 |  | [.src/Gestion/Impressions/EdArt1.class](.src/Gestion/Impressions/EdArt1.class/test.md) |
| 70 | EdRup | 10 | 9 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 122 | 73 | 503 |  | [.src/Gestion/Impressions/EdRup.class](.src/Gestion/Impressions/EdRup.class/test.md) |
| 71 | Caleditcmat | 14 | 12 | 2 | 0 | SQLite 1, extraction / réécriture (phases 3-4) 1 | 121 | 35 | 766 |  | [.src/Gestion/option/Caleditcmat.class](.src/Gestion/option/Caleditcmat.class/test.md) |
| 72 | Lcr | 11 | 10 | 1 | 0 | SQLite 1 | 121 | 17 | 563 |  | [.src/Gestion/Lcr/Lcr.class](.src/Gestion/Lcr/Lcr.class/test.md) |
| 73 | LDate | 14 | 13 | 1 | 0 | Message.* / fenêtre modale 1 | 119 | 20 | 489 |  | [.src/Utils/LDate.class](.src/Utils/LDate.class/test.md) |
| 74 | Saisiedecons | 7 | 3 | 4 | 0 | clavier / souris 2, contrôle non rejouable 1, extraction / réécriture (phases 3-4) 1 | 117 | 9 | 497 |  | [.src/Gestion/option/Saisiedecons.class](.src/Gestion/option/Saisiedecons.class/test.md) |
| 75 | TriMat | 6 | 5 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 117 | 11 | 329 |  | [.src/Affichages/TriMat.class](.src/Affichages/TriMat.class/test.md) |
| 76 | MajTarifP | 7 | 5 | 2 | 0 | SQLite 1, extraction / réécriture (phases 3-4) 1 | 112 | 31 | 350 |  | [.src/Gestion/Stock/Tarifs/MajTarifP.class](.src/Gestion/Stock/Tarifs/MajTarifP.class/test.md) |
| 77 | EdArt2 | 1 | 0 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 112 | 21 | 489 |  | [.src/Gestion/Impressions/EdArt2.class](.src/Gestion/Impressions/EdArt2.class/test.md) |
| 78 | artopt | 4 | 0 | 4 | 0 | module complexe (revue manuelle) 4 | 110 | 15 | 473 |  | [.src/Gestion/option/artopt.class](.src/Gestion/option/artopt.class/test.md) |
| 79 | GeninvT | 14 | 13 | 1 | 0 | SQLite 1 | 110 | 20 | 531 |  | [.src/Gestion/Stock/Inventaires/Tournant/GeninvT.class](.src/Gestion/Stock/Inventaires/Tournant/GeninvT.class/test.md) |
| 80 | FacturefmA | 8 | 7 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 109 | 41 | 517 |  | [.src/Gestion/Facturation/FacturefmA.class](.src/Gestion/Facturation/FacturefmA.class/test.md) |
| 81 | Cmenu | 14 | 11 | 3 | 0 | harnais : démarrage, code de sortie 1, module complexe (revue manuelle) 1, SQLite 1 | 107 | 16 | 325 |  | [.src/Caisse/Cmenu.class](.src/Caisse/Cmenu.class/test.md) |
| 82 | Crupt | 9 | 8 | 1 | 0 | outillage runner (comparaison, mesure) 1 | 106 | 106 | 319 |  | [.src/Utils/Crupt.module](.src/Utils/Crupt.module/test.md) |
| 83 | Changefam | 12 | 10 | 2 | 0 | Message.* / fenêtre modale 1, extraction / réécriture (phases 3-4) 1 | 106 | 14 | 548 |  | [.src/Utils/Changefam.class](.src/Utils/Changefam.class/test.md) |
| 84 | FTvav | 7 | 6 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 106 | 25 | 413 |  | [.src/Compta/Tables/FTvav.class](.src/Compta/Tables/FTvav.class/test.md) |
| 85 | EcrM | 13 | 9 | 4 | 0 | extraction / réécriture (phases 3-4) 2, Message.* / fenêtre modale 1, module complexe (revue manuelle) 1 | 105 | 34 | 485 |  | [.src/Compta/Impressions/EcrM.class](.src/Compta/Impressions/EcrM.class/test.md) |
| 86 | SaisieInv | 16 | 14 | 2 | 0 | clavier / souris 1, extraction / réécriture (phases 3-4) 1 | 104 | 24 | 418 |  | [.src/Gestion/Stock/Inventaires/Fin-annee/SaisieInv.class](.src/Gestion/Stock/Inventaires/Fin-annee/SaisieInv.class/test.md) |
| 87 | Lettrage | 7 | 4 | 3 | 0 | Message.* / fenêtre modale 1, clavier / souris 1, extraction / réécriture (phases 3-4) 1 | 104 | 20 | 447 |  | [.src/Compta/Lettrages/Lettrage.class](.src/Compta/Lettrages/Lettrage.class/test.md) |
| 88 | Tricartes | 7 | 5 | 2 | 0 | module complexe (revue manuelle) 1, extraction / réécriture (phases 3-4) 1 | 102 | 11 | 322 |  | [.src/Caisse/Affichages/Tricartes.class](.src/Caisse/Affichages/Tricartes.class/test.md) |
| 89 | Balance | 10 | 8 | 2 | 0 | outillage runner (comparaison, mesure) 1, Message.* / fenêtre modale 1 | 102 | 20 | 497 |  | [.src/Compta/Impressions/Balance.class](.src/Compta/Impressions/Balance.class/test.md) |
| 90 | Tregie | 7 | 6 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 101 | 13 | 448 |  | [.src/Gestion/option/Tregie.class](.src/Gestion/option/Tregie.class/test.md) |
| 91 | EdStk | 8 | 7 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 101 | 27 | 435 |  | [.src/Gestion/Impressions/EdStk.class](.src/Gestion/Impressions/EdStk.class/test.md) |
| 92 | EcrAuto | 12 | 9 | 3 | 0 | Message.* / fenêtre modale 2, SQLite 1 | 99 | 22 | 601 |  | [.src/Compta/Utils/EcrAuto.class](.src/Compta/Utils/EcrAuto.class/test.md) |
| 93 | Fondcaisse | 10 | 6 | 4 | 0 | extraction / réécriture (phases 3-4) 2, clavier / souris 1, module complexe (revue manuelle) 1 | 98 | 12 | 335 |  | [.src/Caisse/Fondcaisse.class](.src/Caisse/Fondcaisse.class/test.md) |
| 94 | LauruxConf | 10 | 9 | 1 | 0 | matériel / réseau / environnement 1 | 97 | 54 | 384 |  | [.src/Communs/LauruxConf.class](.src/Communs/LauruxConf.class/test.md) |
| 95 | Mvtex | 9 | 7 | 2 | 0 | Message.* / fenêtre modale 1, clavier / souris 1 | 97 | 16 | 589 |  | [.src/Gestion/Stock/Mvtex.class](.src/Gestion/Stock/Mvtex.class/test.md) |
| 96 | SaisieInvT | 16 | 14 | 2 | 0 | clavier / souris 1, extraction / réécriture (phases 3-4) 1 | 97 | 23 | 418 |  | [.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class](.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class/test.md) |
| 97 | RelvMo | 8 | 6 | 2 | 0 | clavier / souris 1, extraction / réécriture (phases 3-4) 1 | 97 | 37 | 382 |  | [.src/Statistiques/RelvMo.class](.src/Statistiques/RelvMo.class/test.md) |
| 98 | OptFac | 10 | 3 | 6 | 1 | module complexe (revue manuelle) 6 | 91 | 16 | 390 |  | [.src/Gestion/Facturation/OptFac.class](.src/Gestion/Facturation/OptFac.class/test.md) |
| 99 | FpromoArt | 7 | 6 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 96 | 22 | 377 |  | [.src/Gestion/Tables/FpromoArt.class](.src/Gestion/Tables/FpromoArt.class/test.md) |
| 100 | Suivi | 8 | 7 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 95 | 14 | 293 |  | [.src/Gestion/Suivi.class](.src/Gestion/Suivi.class/test.md) |
| 101 | ValidBR1 | 10 | 7 | 1 | 2 | autre (voir test.md) 1 | 85 | 15 | 460 |  | [.src/Gestion/Stock/ValidBR1.class](.src/Gestion/Stock/ValidBR1.class/test.md) |
| 102 | ExportA47 | 14 | 11 | 3 | 0 | Message.* / fenêtre modale 1, SQLite 1, outillage runner (comparaison, mesure) 1 | 95 | 34 | 426 |  | [.src/Compta/Impressions/ExportA47.class](.src/Compta/Impressions/ExportA47.class/test.md) |
| 103 | TarTypeCli | 8 | 6 | 2 | 0 | extraction / réécriture (phases 3-4) 1, module complexe (revue manuelle) 1 | 93 | 8 | 414 |  | [.src/Gestion/Tables/TarTypeCli.class](.src/Gestion/Tables/TarTypeCli.class/test.md) |
| 104 | FClotureAn | 13 | 9 | 3 | 1 | contrôle non rejouable 1, SQLite 1, extraction / réécriture (phases 3-4) 1 | 88 | 74 | 583 |  | [.src/Compta/Clotures/FClotureAn.class](.src/Compta/Clotures/FClotureAn.class/test.md) |
| 105 | numtostring | 6 | 0 | 6 | 0 | outillage runner (comparaison, mesure) 5, module complexe (revue manuelle) 1 | 92 | 62 | 166 |  | [.src/Caisse/numtostring.module](.src/Caisse/numtostring.module/test.md) |
| 106 | gridvi2 | 1 | 0 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 92 | 20 | 387 |  | [.src/Utils/gridvi2.class](.src/Utils/gridvi2.class/test.md) |
| 107 | Etiqfbtarif | 7 | 6 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 92 | 18 | 365 |  | [.src/Gestion/Etiquettes/Etiqfbtarif.class](.src/Gestion/Etiquettes/Etiqfbtarif.class/test.md) |
| 108 | Changefour | 8 | 7 | 1 | 0 | Message.* / fenêtre modale 1 | 90 | 12 | 411 |  | [.src/Utils/Changefour.class](.src/Utils/Changefour.class/test.md) |
| 109 | SupprArt | 7 | 3 | 4 | 0 | module complexe (revue manuelle) 4 | 90 | 18 | 337 |  | [.src/Gestion/SupprArt.class](.src/Gestion/SupprArt.class/test.md) |
| 110 | Dup | 6 | 1 | 5 | 0 | anomalie applicative 3, matériel / réseau / environnement 2 | 89 | 82 | 230 |  | [.src/Compta/Utils/Dup.class](.src/Compta/Utils/Dup.class/test.md) |
| 111 | TriCpt | 10 | 8 | 2 | 0 | Message.* / fenêtre modale 1, extraction / réécriture (phases 3-4) 1 | 89 | 17 | 456 |  | [.src/Affichages/TriCpt.class](.src/Affichages/TriCpt.class/test.md) |
| 112 | GedR | 8 | 6 | 2 | 0 | contrôle non rejouable 1, Message.* / fenêtre modale 1 | 88 | 20 | 388 |  | [.src/Utils/GedR.class](.src/Utils/GedR.class/test.md) |
| 113 | ReplayObserver | 7 | 3 | 4 | 0 | outillage runner (comparaison, mesure) 2, extraction / réécriture (phases 3-4) 1, harnais : démarrage, code de sortie 1 | 88 | 28 | 264 |  | [.src/Utils/ReplayObserver.class](.src/Utils/ReplayObserver.class/test.md) |
| 114 | Tricp | 8 | 3 | 5 | 0 | module complexe (revue manuelle) 4, extraction / réécriture (phases 3-4) 1 | 88 | 13 | 220 |  | [.src/Affichages/Tricp.class](.src/Affichages/Tricp.class/test.md) |
| 115 | Remisecli | 7 | 6 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 86 | 12 | 351 |  | [.src/Gestion/Tables/Remisecli.class](.src/Gestion/Tables/Remisecli.class/test.md) |
| 116 | TriEqu | 6 | 5 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 85 | 12 | 283 |  | [.src/Affichages/TriEqu.class](.src/Affichages/TriEqu.class/test.md) |
| 117 | Edmo | 7 | 6 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 83 | 11 | 370 |  | [.src/Gestion/Impressions/Edmo.class](.src/Gestion/Impressions/Edmo.class/test.md) |
| 118 | Attrib | 7 | 4 | 3 | 0 | module complexe (revue manuelle) 3 | 82 | 12 | 298 |  | [.src/Caisse/Attrib.class](.src/Caisse/Attrib.class/test.md) |
| 119 | BordereauxC | 11 | 7 | 4 | 0 | extraction / réécriture (phases 3-4) 2, Message.* / fenêtre modale 1, SQLite 1 | 82 | 30 | 416 |  | [.src/Compta/Impressions/BordereauxC.class](.src/Compta/Impressions/BordereauxC.class/test.md) |
| 120 | gridvi | 10 | 6 | 4 | 0 | Message.* / fenêtre modale 2, SQLite 1, extraction / réécriture (phases 3-4) 1 | 80 | 25 | 493 |  | [.src/Utils/gridvi.class](.src/Utils/gridvi.class/test.md) |
| 121 | Txmo | 6 | 4 | 2 | 0 | Message.* / fenêtre modale 1, extraction / réécriture (phases 3-4) 1 | 80 | 14 | 356 |  | [.src/Gestion/Tables/Txmo.class](.src/Gestion/Tables/Txmo.class/test.md) |
| 122 | Bordrx | 11 | 10 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 78 | 21 | 460 |  | [.src/Gestion/Lcr/Bordrx.class](.src/Gestion/Lcr/Bordrx.class/test.md) |
| 123 | TriArticles | 11 | 9 | 2 | 0 | Message.* / fenêtre modale 1, extraction / réécriture (phases 3-4) 1 | 78 | 16 | 363 |  | [.src/Affichages/TriArticles.class](.src/Affichages/TriArticles.class/test.md) |
| 124 | Calc | 1 | 0 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 76 | 14 | 213 |  | [.src/Utils/Calc.class](.src/Utils/Calc.class/test.md) |
| 125 | Listextcpt | 13 | 11 | 2 | 0 | SQLite 1, outillage runner (comparaison, mesure) 1 | 76 | 28 | 297 |  | [.src/Compta/Utils/Listextcpt.class](.src/Compta/Utils/Listextcpt.class/test.md) |
| 126 | Numtostring | 7 | 6 | 1 | 0 | module complexe (revue manuelle) 1 | 73 | 58 | 144 |  | [.src/Utils/Numtostring.module](.src/Utils/Numtostring.module/test.md) |
| 127 | RichDataGrid | 7 | 4 | 3 | 0 | extraction / réécriture (phases 3-4) 2, SQLite 1 | 73 | 24 | 225 |  | [.src/Utils/RichDataGrid.class](.src/Utils/RichDataGrid.class/test.md) |
| 128 | DataButtonList | 1 | 0 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 71 | 13 | 247 |  | [.src/Utils/DataButtonList.class](.src/Utils/DataButtonList.class/test.md) |
| 129 | modfichier | 5 | 4 | 1 | 0 | SQLite 1 | 71 | 32 | 172 |  | [.src/Gestion/option/modfichier.module](.src/Gestion/option/modfichier.module/test.md) |
| 130 | Majversion | 7 | 4 | 3 | 0 | matériel / réseau / environnement 3 | 70 | 21 | 295 |  | [.src/Communs/Majversion.class](.src/Communs/Majversion.class/test.md) |
| 131 | Sailig | 5 | 4 | 1 | 0 | module complexe (revue manuelle) 1 | 68 | 27 | 200 |  | [.src/Utils/Sailig.class](.src/Utils/Sailig.class/test.md) |
| 132 | EtiqRecpt | 9 | 8 | 1 | 0 | module complexe (revue manuelle) 1 | 68 | 36 | 322 |  | [.src/Gestion/Etiquettes/EtiqRecpt.class](.src/Gestion/Etiquettes/EtiqRecpt.class/test.md) |
| 133 | Ouverture | 11 | 10 | 1 | 0 | SQLite 1 | 67 | 19 | 212 |  | [.src/Caisse/Ouverture.class](.src/Caisse/Ouverture.class/test.md) |
| 134 | SaiTableau | 8 | 6 | 2 | 0 | module complexe (revue manuelle) 1, extraction / réécriture (phases 3-4) 1 | 67 | 9 | 284 |  | [.src/Utils/SaiTableau.class](.src/Utils/SaiTableau.class/test.md) |
| 135 | TBord | 8 | 6 | 2 | 0 | extraction / réécriture (phases 3-4) 1, SQLite 1 | 67 | 49 | 340 |  | [.src/Statistiques/TBord.class](.src/Statistiques/TBord.class/test.md) |
| 136 | FPrepRel2 | 1 | 0 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 67 | 10 | 346 |  | [.src/Compta/Relances/FPrepRel2.class](.src/Compta/Relances/FPrepRel2.class/test.md) |
| 137 | Echeancier | 10 | 8 | 2 | 0 | extraction / réécriture (phases 3-4) 1, SQLite 1 | 67 | 28 | 386 |  | [.src/Compta/Impressions/Echeancier.class](.src/Compta/Impressions/Echeancier.class/test.md) |
| 138 | FTvac | 5 | 4 | 1 | 0 | Message.* / fenêtre modale 1 | 67 | 16 | 262 |  | [.src/Compta/Tables/FTvac.class](.src/Compta/Tables/FTvac.class/test.md) |
| 139 | Ecomptamat | 7 | 5 | 2 | 0 | extraction / réécriture (phases 3-4) 2 | 66 | 6 | 306 |  | [.src/Gestion/option/Ecomptamat.class](.src/Gestion/option/Ecomptamat.class/test.md) |
| 140 | Edart4 | 8 | 6 | 2 | 0 | anomalie applicative 1, Message.* / fenêtre modale 1 | 66 | 19 | 392 |  | [.src/Gestion/Impressions/Edart4.class](.src/Gestion/Impressions/Edart4.class/test.md) |
| 141 | Rubcompt | 8 | 7 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 66 | 14 | 270 |  | [.src/Compta/Utils/Rubcompt.class](.src/Compta/Utils/Rubcompt.class/test.md) |
| 142 | Preferences | 6 | 3 | 3 | 0 | dialogue natif 1, module complexe (revue manuelle) 1, extraction / réécriture (phases 3-4) 1 | 65 | 41 | 183 |  | [.src/Caisse/Preferences.class](.src/Caisse/Preferences.class/test.md) |
| 143 | TriclientsD | 2 | 1 | 1 | 0 | module complexe (revue manuelle) 1 | 65 | 11 | 177 |  | [.src/Caisse/Affichages/TriclientsD.class](.src/Caisse/Affichages/TriclientsD.class/test.md) |
| 144 | MajFbtarif2 | 7 | 5 | 2 | 0 | SQLite 1, extraction / réécriture (phases 3-4) 1 | 63 | 15 | 236 |  | [.src/Gestion/Stock/Tarifs/MajFbtarif2.class](.src/Gestion/Stock/Tarifs/MajFbtarif2.class/test.md) |
| 145 | Rubresult | 8 | 5 | 3 | 0 | Message.* / fenêtre modale 1, SQLite 1, extraction / réécriture (phases 3-4) 1 | 63 | 21 | 290 |  | [.src/Compta/Utils/Rubresult.class](.src/Compta/Utils/Rubresult.class/test.md) |
| 146 | EdNlettrees | 11 | 8 | 3 | 0 | Message.* / fenêtre modale 1, extraction / réécriture (phases 3-4) 1, SQLite 1 | 63 | 17 | 424 |  | [.src/Compta/Impressions/EdNlettrees.class](.src/Compta/Impressions/EdNlettrees.class/test.md) |
| 147 | CoefTypeC | 5 | 4 | 1 | 0 | module complexe (revue manuelle) 1 | 62 | 10 | 281 |  | [.src/Gestion/Tables/CoefTypeC.class](.src/Gestion/Tables/CoefTypeC.class/test.md) |
| 148 | StatComm | 10 | 7 | 3 | 0 | extraction / réécriture (phases 3-4) 2, SQLite 1 | 62 | 37 | 224 |  | [.src/Statistiques/StatComm.class](.src/Statistiques/StatComm.class/test.md) |
| 149 | StatClimo | 8 | 6 | 2 | 0 | SQLite 1, extraction / réécriture (phases 3-4) 1 | 62 | 37 | 235 |  | [.src/Statistiques/StatClimo.class](.src/Statistiques/StatClimo.class/test.md) |
| 150 | JournauxM | 12 | 10 | 2 | 0 | SQLite 1, outillage runner (comparaison, mesure) 1 | 62 | 55 | 338 |  | [.src/Compta/Impressions/JournauxM.module](.src/Compta/Impressions/JournauxM.module/test.md) |
| 151 | impfec | 9 | 8 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 61 | 25 | 294 |  | [.src/Compta/Utils/impfec.class](.src/Compta/Utils/impfec.class/test.md) |
| 152 | Imp_Sig | 7 | 6 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 61 | 60 | 403 |  | [.src/Compta/Impressions/Imp_Sig.module](.src/Compta/Impressions/Imp_Sig.module/test.md) |
| 153 | Ttarfioul | 5 | 4 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 60 | 10 | 267 |  | [.src/Gestion/option/Ttarfioul.class](.src/Gestion/option/Ttarfioul.class/test.md) |
| 154 | Cfacture | 9 | 3 | 6 | 0 | module complexe (revue manuelle) 6 | 59 | 8 | 267 |  | [.src/Caisse/Reports/Cfacture.class](.src/Caisse/Reports/Cfacture.class/test.md) |
| 155 | Ligcli | 7 | 6 | 1 | 0 | clavier / souris 1 | 59 | 25 | 334 |  | [.src/Compta/Relances/Ligcli.class](.src/Compta/Relances/Ligcli.class/test.md) |
| 156 | Intjdv | 1 | 0 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 58 | 11 | 308 |  | [.src/Compta/Utils/Intjdv.class](.src/Compta/Utils/Intjdv.class/test.md) |
| 157 | Fmontant | 7 | 5 | 2 | 0 | module complexe (revue manuelle) 1, extraction / réécriture (phases 3-4) 1 | 58 | 41 | 168 |  | [.src/Compta/Utils/Fmontant.class](.src/Compta/Utils/Fmontant.class/test.md) |
| 158 | Verbal | 7 | 5 | 2 | 0 | extraction / réécriture (phases 3-4) 1, outillage runner (comparaison, mesure) 1 | 57 | 19 | 314 |  | [.src/Compta/Utils/Verbal.class](.src/Compta/Utils/Verbal.class/test.md) |
| 159 | DateTar | 8 | 7 | 1 | 0 | harnais : démarrage, code de sortie 1 | 55 | 13 | 197 |  | [.src/Gestion/Entrées/DateTar.class](.src/Gestion/Entrées/DateTar.class/test.md) |
| 160 | Prgm | 9 | 8 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 53 | 38 | 101 |  | [.src/Communs/Prgm.class](.src/Communs/Prgm.class/test.md) |
| 161 | Btqart | 6 | 5 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 53 | 17 | 153 |  | [.src/Gestion/Tables/Btqart.class](.src/Gestion/Tables/Btqart.class/test.md) |
| 162 | Remisec | 5 | 4 | 1 | 0 | Message.* / fenêtre modale 1 | 53 | 10 | 243 |  | [.src/Gestion/Tables/Remisec.class](.src/Gestion/Tables/Remisec.class/test.md) |
| 163 | Gsm | 8 | 6 | 2 | 0 | module complexe (revue manuelle) 1, Message.* / fenêtre modale 1 | 52 | 14 | 198 |  | [.src/Gestion/SMS/Gsm.class](.src/Gestion/SMS/Gsm.class/test.md) |
| 164 | calculdroit1 | 10 | 9 | 1 | 0 | module complexe (revue manuelle) 1 | 50 | 7 | 167 |  | [.src/Gestion/option/calculdroit1.class](.src/Gestion/option/calculdroit1.class/test.md) |
| 165 | StatTypCli | 7 | 5 | 2 | 0 | SQLite 1, extraction / réécriture (phases 3-4) 1 | 50 | 25 | 208 |  | [.src/Statistiques/StatTypCli.class](.src/Statistiques/StatTypCli.class/test.md) |
| 166 | Cielcorsp | 7 | 4 | 3 | 0 | Message.* / fenêtre modale 2, extraction / réécriture (phases 3-4) 1 | 50 | 10 | 199 |  | [.src/Compta/Cielcorsp.class](.src/Compta/Cielcorsp.class/test.md) |
| 167 | Trecarts | 8 | 6 | 2 | 0 | Message.* / fenêtre modale 1, SQLite 1 | 50 | 24 | 224 |  | [.src/Compta/Trecarts.class](.src/Compta/Trecarts.class/test.md) |
| 168 | fourconsdroi | 2 | 0 | 2 | 0 | extraction / réécriture (phases 3-4) 2 | 49 | 8 | 213 |  | [.src/Gestion/option/fourconsdroi.class](.src/Gestion/option/fourconsdroi.class/test.md) |
| 169 | Edcom | 6 | 5 | 1 | 0 | clavier / souris 1 | 49 | 23 | 279 |  | [.src/Gestion/Impressions/Edcom.class](.src/Gestion/Impressions/Edcom.class/test.md) |
| 170 | EdImpayes | 2 | 0 | 2 | 0 | extraction / réécriture (phases 3-4) 1, harnais : démarrage, code de sortie 1 | 49 | 15 | 314 |  | [.src/Compta/Impressions/EdImpayes.class](.src/Compta/Impressions/EdImpayes.class/test.md) |
| 171 | EdFam | 5 | 4 | 1 | 0 | clavier / souris 1 | 47 | 7 | 217 |  | [.src/Gestion/Impressions/EdFam.class](.src/Gestion/Impressions/EdFam.class/test.md) |
| 172 | Cielcorspj | 6 | 4 | 2 | 0 | Message.* / fenêtre modale 2 | 47 | 8 | 192 |  | [.src/Compta/Cielcorspj.class](.src/Compta/Cielcorspj.class/test.md) |
| 173 | EdNjustifiees | 8 | 6 | 2 | 0 | Message.* / fenêtre modale 1, extraction / réécriture (phases 3-4) 1 | 47 | 16 | 249 |  | [.src/Compta/Impressions/EdNjustifiees.class](.src/Compta/Impressions/EdNjustifiees.class/test.md) |
| 174 | TriFacture | 6 | 4 | 2 | 0 | extraction / réécriture (phases 3-4) 2 | 47 | 13 | 237 |  | [.src/Affichages/TriFacture.class](.src/Affichages/TriFacture.class/test.md) |
| 175 | LBox | 7 | 5 | 2 | 0 | anomalie applicative 1, dialogue natif 1 | 46 | 11 | 182 |  | [.src/Utils/LBox.class](.src/Utils/LBox.class/test.md) |
| 176 | Ttourne | 10 | 8 | 2 | 0 | contrôle non rejouable 1, Message.* / fenêtre modale 1 | 46 | 7 | 147 |  | [.src/Gestion/option/Ttourne.class](.src/Gestion/option/Ttourne.class/test.md) |
| 177 | HitCarte | 7 | 6 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 44 | 16 | 159 |  | [.src/Statistiques/HitCarte.class](.src/Statistiques/HitCarte.class/test.md) |
| 178 | Fvendeurs | 6 | 5 | 1 | 0 | Message.* / fenêtre modale 1 | 43 | 9 | 163 |  | [.src/Caisse/Fvendeurs.class](.src/Caisse/Fvendeurs.class/test.md) |
| 179 | Tregion | 8 | 7 | 1 | 0 | Message.* / fenêtre modale 1 | 43 | 8 | 168 |  | [.src/Gestion/option/Tregion.class](.src/Gestion/option/Tregion.class/test.md) |
| 180 | MajFbtarif1 | 1 | 0 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 43 | 21 | 161 |  | [.src/Gestion/Stock/Tarifs/MajFbtarif1.class](.src/Gestion/Stock/Tarifs/MajFbtarif1.class/test.md) |
| 181 | DB_Log | 7 | 5 | 2 | 0 | outillage runner (comparaison, mesure) 1, extraction / réécriture (phases 3-4) 1 | 42 | 9 | 225 |  | [.src/Utils/DB_Log.class](.src/Utils/DB_Log.class/test.md) |
| 182 | Plancomptable | 4 | 3 | 1 | 0 | Message.* / fenêtre modale 1 | 42 | 8 | 155 |  | [.src/Compta/Impressions/Plancomptable.class](.src/Compta/Impressions/Plancomptable.class/test.md) |
| 183 | VerifDate | 9 | 8 | 1 | 0 | module complexe (revue manuelle) 1 | 41 | 10 | 117 |  | [.src/Utils/VerifDate.class](.src/Utils/VerifDate.class/test.md) |
| 184 | StatComArt | 7 | 5 | 2 | 0 | SQLite 1, extraction / réécriture (phases 3-4) 1 | 41 | 16 | 162 |  | [.src/Statistiques/StatComArt.class](.src/Statistiques/StatComArt.class/test.md) |
| 185 | StatFour | 7 | 5 | 2 | 0 | SQLite 1, extraction / réécriture (phases 3-4) 1 | 40 | 17 | 166 |  | [.src/Statistiques/StatFour.class](.src/Statistiques/StatFour.class/test.md) |
| 186 | FCalc | 7 | 5 | 2 | 0 | module complexe (revue manuelle) 2 | 39 | 20 | 124 |  | [.src/Utils/FCalc.class](.src/Utils/FCalc.class/test.md) |
| 187 | Edbl | 7 | 6 | 1 | 0 | anomalie applicative 1 | 39 | 6 | 212 |  | [.src/Gestion/Impressions/Edbl.class](.src/Gestion/Impressions/Edbl.class/test.md) |
| 188 | EditfacB | 4 | 0 | 4 | 0 | module complexe (revue manuelle) 4 | 38 | 10 | 628 |  | [.src/Gestion/option/EditfacB.class](.src/Gestion/option/EditfacB.class/test.md) |
| 189 | Commerciaux | 5 | 4 | 1 | 0 | Message.* / fenêtre modale 1 | 38 | 9 | 145 |  | [.src/Gestion/Tables/Commerciaux.class](.src/Gestion/Tables/Commerciaux.class/test.md) |
| 190 | DocActif | 12 | 10 | 2 | 0 | Message.* / fenêtre modale 1, extraction / réécriture (phases 3-4) 1 | 37 | 13 | 150 |  | [.src/Communs/DocActif.class](.src/Communs/DocActif.class/test.md) |
| 191 | Carticles | 9 | 8 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 37 | 2 | 370 |  | [.src/Reports/Carticles.class](.src/Reports/Carticles.class/test.md) |
| 192 | Trifam | 8 | 7 | 1 | 0 | Message.* / fenêtre modale 1 | 37 | 18 | 131 |  | [.src/Utils/Trifam.class](.src/Utils/Trifam.class/test.md) |
| 193 | TarArt | 12 | 9 | 3 | 0 | matériel / réseau / environnement 1, clavier / souris 1, outillage runner (comparaison, mesure) 1 | 37 | 32 | 149 |  | [.src/Utils/TarArt.class](.src/Utils/TarArt.class/test.md) |
| 194 | calculdroit | 8 | 7 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 37 | 15 | 160 |  | [.src/Gestion/option/calculdroit.class](.src/Gestion/option/calculdroit.class/test.md) |
| 195 | atribvignette | 8 | 7 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 37 | 12 | 138 |  | [.src/Gestion/option/atribvignette.class](.src/Gestion/option/atribvignette.class/test.md) |
| 196 | Edbr | 7 | 1 | 6 | 0 | anomalie applicative 6 | 37 | 19 | 228 |  | [.src/Gestion/Impressions/Edbr.module](.src/Gestion/Impressions/Edbr.module/test.md) |
| 197 | VarMajTar | 7 | 1 | 6 | 0 | module complexe (revue manuelle) 4, Message.* / fenêtre modale 1, SQLite 1 | 36 | 15 | 137 |  | [.src/Gestion/Stock/VarMajTar.class](.src/Gestion/Stock/VarMajTar.class/test.md) |
| 198 | Geninv | 16 | 15 | 1 | 0 | SQLite 1 | 36 | 13 | 203 |  | [.src/Gestion/Stock/Inventaires/Fin-annee/Geninv.class](.src/Gestion/Stock/Inventaires/Fin-annee/Geninv.class/test.md) |
| 199 | ComMail | 5 | 3 | 2 | 0 | module complexe (revue manuelle) 2 | 36 | 7 | 130 |  | [.src/Gestion/Tables/ComMail.class](.src/Gestion/Tables/ComMail.class/test.md) |
| 200 | journauxSetting | 6 | 4 | 2 | 0 | Message.* / fenêtre modale 1, écran sans point d'entrée 1 | 35 | 16 | 123 |  | [.src/Compta/Impressions/journauxSetting.class](.src/Compta/Impressions/journauxSetting.class/test.md) |
| 201 | Comment | 5 | 4 | 1 | 0 | module complexe (revue manuelle) 1 | 34 | 7 | 125 |  | [.src/Gestion/Tables/Comment.class](.src/Gestion/Tables/Comment.class/test.md) |
| 202 | SetColors | 6 | 3 | 3 | 0 | clavier / souris 2, extraction / réécriture (phases 3-4) 1 | 33 | 9 | 88 |  | [.src/Utils/SetColors.class](.src/Utils/SetColors.class/test.md) |
| 203 | ConVendeurs | 6 | 5 | 1 | 0 | module complexe (revue manuelle) 1 | 33 | 9 | 98 |  | [.src/Gestion/Facturation/ConVendeurs.class](.src/Gestion/Facturation/ConVendeurs.class/test.md) |
| 204 | StatPromo | 6 | 5 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 33 | 12 | 142 |  | [.src/Statistiques/StatPromo.class](.src/Statistiques/StatPromo.class/test.md) |
| 205 | Analytique | 8 | 6 | 2 | 0 | module complexe (revue manuelle) 1, extraction / réécriture (phases 3-4) 1 | 33 | 8 | 182 |  | [.src/Compta/Analytique.class](.src/Compta/Analytique.class/test.md) |
| 206 | Clivre | 1 | 0 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 32 | 7 | 142 |  | [.src/Reports/Clivre.class](.src/Reports/Clivre.class/test.md) |
| 207 | Validinv | 16 | 13 | 3 | 0 | non retenu par l'utilisateur 3 | 32 | 20 | 158 |  | [.src/Gestion/Stock/Inventaires/Fin-annee/Validinv.class](.src/Gestion/Stock/Inventaires/Fin-annee/Validinv.class/test.md) |
| 208 | VisStatComm | 6 | 5 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 32 | 14 | 219 |  | [.src/Statistiques/VisStatComm.class](.src/Statistiques/VisStatComm.class/test.md) |
| 209 | Statcai | 6 | 4 | 2 | 0 | SQLite 1, extraction / réécriture (phases 3-4) 1 | 31 | 17 | 146 |  | [.src/Caisse/Statcai.class](.src/Caisse/Statcai.class/test.md) |
| 210 | Sha1Calc | 9 | 8 | 1 | 0 | outillage runner (comparaison, mesure) 1 | 31 | 15 | 115 |  | [.src/Utils/Sha1Calc.module](.src/Utils/Sha1Calc.module/test.md) |
| 211 | chainage | 7 | 4 | 3 | 0 | outillage runner (comparaison, mesure) 2, module complexe (revue manuelle) 1 | 31 | 13 | 76 |  | [.src/Utils/chainage.class](.src/Utils/chainage.class/test.md) |
| 212 | VisStatTypCli | 5 | 4 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 30 | 10 | 206 |  | [.src/Statistiques/VisStatTypCli.class](.src/Statistiques/VisStatTypCli.class/test.md) |
| 213 | FCloture | 8 | 6 | 1 | 1 | non retenu par l'utilisateur 1 | 25 | 17 | 116 |  | [.src/Compta/Clotures/FCloture.class](.src/Compta/Clotures/FCloture.class/test.md) |
| 214 | MajEqu | 6 | 4 | 2 | 0 | module complexe (revue manuelle) 2 | 29 | 24 | 47 |  | [.src/Gestion/Stock/Tarifs/MajEqu.module](.src/Gestion/Stock/Tarifs/MajEqu.module/test.md) |
| 215 | VisStatFour | 4 | 3 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 29 | 8 | 214 |  | [.src/Statistiques/VisStatFour.class](.src/Statistiques/VisStatFour.class/test.md) |
| 216 | VisStatComArt | 6 | 5 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 29 | 9 | 186 |  | [.src/Statistiques/VisStatComArt.class](.src/Statistiques/VisStatComArt.class/test.md) |
| 217 | Epurjdv | 2 | 1 | 1 | 0 | Message.* / fenêtre modale 1 | 29 | 18 | 172 |  | [.src/Compta/Utils/Epurjdv.class](.src/Compta/Utils/Epurjdv.class/test.md) |
| 218 | Fclientc | 4 | 1 | 3 | 0 | Message.* / fenêtre modale 2, extraction / réécriture (phases 3-4) 1 | 28 | 5 | 123 |  | [.src/Caisse/Fclientc.class](.src/Caisse/Fclientc.class/test.md) |
| 219 | ImageButton | 3 | 2 | 0 | 1 |  | 22 | 7 | 103 |  | [.src/Caisse/ImageButton.class](.src/Caisse/ImageButton.class/test.md) |
| 220 | textfamille | 6 | 4 | 2 | 0 | module complexe (revue manuelle) 1, Message.* / fenêtre modale 1 | 27 | 7 | 107 |  | [.src/Utils/textfamille.class](.src/Utils/textfamille.class/test.md) |
| 221 | ClotureF | 8 | 7 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 27 | 8 | 153 |  | [.src/Gestion/ClotureF.class](.src/Gestion/ClotureF.class/test.md) |
| 222 | Edinv1 | 1 | 0 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 27 | 15 | 126 |  | [.src/Gestion/Stock/Inventaires/Fin-annee/Edinv1.class](.src/Gestion/Stock/Inventaires/Fin-annee/Edinv1.class/test.md) |
| 223 | VerifNumfac | 2 | 1 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 26 | 26 | 86 |  | [.src/Utils/VerifNumfac.module](.src/Utils/VerifNumfac.module/test.md) |
| 224 | ValidinvT | 13 | 12 | 1 | 0 | SQLite 1 | 26 | 23 | 122 |  | [.src/Gestion/Stock/Inventaires/Tournant/ValidinvT.class](.src/Gestion/Stock/Inventaires/Tournant/ValidinvT.class/test.md) |
| 225 | Cstocks | 7 | 6 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 24 | 1 | 241 |  | [.src/Reports/Cstocks.class](.src/Reports/Cstocks.class/test.md) |
| 226 | Visreglements | 5 | 1 | 4 | 0 | écran sans point d'entrée 3, extraction / réécriture (phases 3-4) 1 | 24 | 8 | 191 |  | [.src/Gestion/Reglements/Visreglements.class](.src/Gestion/Reglements/Visreglements.class/test.md) |
| 227 | EdinvT | 1 | 0 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 23 | 10 | 161 |  | [.src/Gestion/Stock/Inventaires/Tournant/EdinvT.class](.src/Gestion/Stock/Inventaires/Tournant/EdinvT.class/test.md) |
| 228 | Lettragemontant | 5 | 4 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 23 | 16 | 104 |  | [.src/Compta/Lettrages/Lettragemontant.class](.src/Compta/Lettrages/Lettragemontant.class/test.md) |
| 229 | FTips | 5 | 4 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 22 | 8 | 87 |  | [.src/Communs/FTips.class](.src/Communs/FTips.class/test.md) |
| 230 | FSauve | 6 | 5 | 1 | 0 | matériel / réseau / environnement 1 | 22 | 12 | 88 |  | [.src/Communs/FSauve.class](.src/Communs/FSauve.class/test.md) |
| 231 | Listecom | 5 | 4 | 1 | 0 | SQLite 1 | 22 | 14 | 162 |  | [.src/Gestion/Stock/Listecom.class](.src/Gestion/Stock/Listecom.class/test.md) |
| 232 | EdReg | 5 | 4 | 1 | 0 | outillage runner (comparaison, mesure) 1 | 22 | 10 | 59 |  | [.src/Gestion/Impressions/EdReg.class](.src/Gestion/Impressions/EdReg.class/test.md) |
| 233 | Conditions | 4 | 3 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 21 | 13 | 79 |  | [.src/Utils/Conditions.class](.src/Utils/Conditions.class/test.md) |
| 234 | Fprepdus | 5 | 4 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 20 | 8 | 73 |  | [.src/Communs/Fprepdus.class](.src/Communs/Fprepdus.class/test.md) |
| 235 | Cprod | 2 | 0 | 2 | 0 | extraction / réécriture (phases 3-4) 2 | 20 | 6 | 86 |  | [.src/Utils/Cprod.class](.src/Utils/Cprod.class/test.md) |
| 236 | VisHitCartes | 5 | 4 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 20 | 7 | 171 |  | [.src/Statistiques/VisHitCartes.class](.src/Statistiques/VisHitCartes.class/test.md) |
| 237 | Anomalies | 5 | 3 | 2 | 0 | outillage runner (comparaison, mesure) 1, Message.* / fenêtre modale 1 | 20 | 9 | 110 |  | [.src/Compta/Impressions/Anomalies.class](.src/Compta/Impressions/Anomalies.class/test.md) |
| 238 | AFacture | 5 | 3 | 2 | 0 | module complexe (revue manuelle) 1, extraction / réécriture (phases 3-4) 1 | 20 | 12 | 83 |  | [.src/Affichages/AFacture.class](.src/Affichages/AFacture.class/test.md) |
| 239 | VisStatClimo | 5 | 4 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 19 | 4 | 185 |  | [.src/Statistiques/VisStatClimo.class](.src/Statistiques/VisStatClimo.class/test.md) |
| 240 | RazArt | 7 | 6 | 1 | 0 | SQLite 1 | 18 | 13 | 68 |  | [.src/Utils/RazArt.class](.src/Utils/RazArt.class/test.md) |
| 241 | menuopt | 3 | 1 | 2 | 0 | outillage runner (comparaison, mesure) 1, Message.* / fenêtre modale 1 | 18 | 3 | 127 |  | [.src/Gestion/option/menuopt.class](.src/Gestion/option/menuopt.class/test.md) |
| 242 | Visimpayes | 1 | 0 | 1 | 0 | anomalie applicative 1 | 18 | 7 | 157 |  | [.src/Compta/Lettrages/Visimpayes.class](.src/Compta/Lettrages/Visimpayes.class/test.md) |
| 243 | modCrBcode | 1 | 0 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 17 | 17 | 79 |  | [.src/Utils/modCrBcode.module](.src/Utils/modCrBcode.module/test.md) |
| 244 | Clavier | 4 | 2 | 2 | 0 | module complexe (revue manuelle) 1, extraction / réécriture (phases 3-4) 1 | 16 | 8 | 59 |  | [.src/Caisse/Clavier.class](.src/Caisse/Clavier.class/test.md) |
| 245 | FSetFormat | 5 | 0 | 5 | 0 | dialogue natif 2, clavier / souris 2, outillage runner (comparaison, mesure) 1 | 16 | 4 | 57 |  | [.src/Utils/FSetFormat.class](.src/Utils/FSetFormat.class/test.md) |
| 246 | Cstock | 12 | 11 | 1 | 0 | outillage runner (comparaison, mesure) 1 | 16 | 13 | 108 |  | [.src/Utils/Cstock.module](.src/Utils/Cstock.module/test.md) |
| 247 | ArtPromo | 6 | 4 | 2 | 0 | module complexe (revue manuelle) 1, matériel / réseau / environnement 1 | 16 | 4 | 44 |  | [.src/Gestion/Tables/ArtPromo.module](.src/Gestion/Tables/ArtPromo.module/test.md) |
| 248 | Svendeur | 4 | 2 | 2 | 0 | module complexe (revue manuelle) 2 | 15 | 6 | 44 |  | [.src/Caisse/Svendeur.class](.src/Caisse/Svendeur.class/test.md) |
| 249 | LVar | 6 | 5 | 1 | 0 | module complexe (revue manuelle) 1 | 15 | 5 | 61 |  | [.src/Utils/LVar.class](.src/Utils/LVar.class/test.md) |
| 250 | Lettragesoldes | 4 | 3 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 14 | 7 | 68 |  | [.src/Compta/Lettrages/Lettragesoldes.class](.src/Compta/Lettrages/Lettragesoldes.class/test.md) |
| 251 | ACom | 4 | 2 | 2 | 0 | clavier / souris 1, extraction / réécriture (phases 3-4) 1 | 14 | 6 | 66 |  | [.src/Affichages/ACom.class](.src/Affichages/ACom.class/test.md) |
| 252 | RazHistoFac | 6 | 5 | 1 | 0 | Message.* / fenêtre modale 1 | 14 | 11 | 50 |  | [.src/Archivages/RazHistoFac.class](.src/Archivages/RazHistoFac.class/test.md) |
| 253 | RazDevis | 5 | 4 | 1 | 0 | SQLite 1 | 14 | 11 | 50 |  | [.src/Archivages/RazDevis.class](.src/Archivages/RazDevis.class/test.md) |
| 254 | Cmo | 2 | 0 | 2 | 0 | extraction / réécriture (phases 3-4) 1, Message.* / fenêtre modale 1 | 13 | 3 | 55 |  | [.src/Utils/Cmo.class](.src/Utils/Cmo.class/test.md) |
| 255 | Carch | 2 | 0 | 2 | 0 | extraction / réécriture (phases 3-4) 1, Message.* / fenêtre modale 1 | 13 | 3 | 56 |  | [.src/Utils/Carch.class](.src/Utils/Carch.class/test.md) |
| 256 | rechtipp | 4 | 3 | 1 | 0 | module complexe (revue manuelle) 1 | 13 | 5 | 59 |  | [.src/Gestion/option/rechtipp.class](.src/Gestion/option/rechtipp.class/test.md) |
| 257 | CalcRem | 4 | 3 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 12 | 7 | 40 |  | [.src/Utils/CalcRem.class](.src/Utils/CalcRem.class/test.md) |
| 258 | Expart | 5 | 4 | 1 | 0 | SQLite 1 | 12 | 8 | 79 |  | [.src/Utils/Exports-Imports/Expart.class](.src/Utils/Exports-Imports/Expart.class/test.md) |
| 259 | Consigne | 6 | 5 | 1 | 0 | module complexe (revue manuelle) 1 | 12 | 3 | 61 |  | [.src/Gestion/option/Consigne.class](.src/Gestion/option/Consigne.class/test.md) |
| 260 | MDP | 5 | 4 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 11 | 6 | 34 |  | [.src/Communs/MDP.class](.src/Communs/MDP.class/test.md) |
| 261 | Impression | 3 | 2 | 1 | 0 | module complexe (revue manuelle) 1 | 11 | 7 | 44 |  | [.src/Utils/Impression.module](.src/Utils/Impression.module/test.md) |
| 262 | Mmysql | 3 | 1 | 2 | 0 | outillage runner (comparaison, mesure) 2 | 11 | 7 | 27 |  | [.src/Utils/Mmysql.module](.src/Utils/Mmysql.module/test.md) |
| 263 | gridv | 1 | 0 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 10 | 10 | 56 |  | [.src/Utils/gridv.module](.src/Utils/gridv.module/test.md) |
| 264 | rechtour | 4 | 2 | 2 | 0 | module complexe (revue manuelle) 2 | 10 | 3 | 41 |  | [.src/Gestion/option/rechtour.class](.src/Gestion/option/rechtour.class/test.md) |
| 265 | Exprub | 5 | 3 | 2 | 0 | SQLite 1, extraction / réécriture (phases 3-4) 1 | 9 | 9 | 48 |  | [.src/Compta/Utils/Exprub.class](.src/Compta/Utils/Exprub.class/test.md) |
| 266 | RazHistoTk | 6 | 4 | 2 | 0 | Message.* / fenêtre modale 1, SQLite 1 | 9 | 7 | 34 |  | [.src/Archivages/RazHistoTk.class](.src/Archivages/RazHistoTk.class/test.md) |
| 267 | RenumBl | 3 | 2 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 8 | 8 | 29 |  | [.src/Utils/RenumBl.class](.src/Utils/RenumBl.class/test.md) |
| 268 | RazClientd | 5 | 4 | 1 | 0 | SQLite 1 | 8 | 6 | 28 |  | [.src/Archivages/RazClientd.class](.src/Archivages/RazClientd.class/test.md) |
| 269 | RazRlvb | 6 | 5 | 1 | 0 | SQLite 1 | 8 | 6 | 30 |  | [.src/Archivages/RazRlvb.class](.src/Archivages/RazRlvb.class/test.md) |
| 270 | Fsystem | 2 | 1 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 7 | 6 | 30 |  | [.src/Communs/Fsystem.class](.src/Communs/Fsystem.class/test.md) |
| 271 | DB_Desktop | 4 | 3 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 7 | 3 | 31 |  | [.src/Utils/DB_Desktop.class](.src/Utils/DB_Desktop.class/test.md) |
| 272 | TestCaisses | 4 | 3 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 6 | 6 | 25 |  | [.src/Caisse/TestCaisses.module](.src/Caisse/TestCaisses.module/test.md) |
| 273 | ChxImp | 1 | 0 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 6 | 5 | 20 |  | [.src/Reports/ChxImp.class](.src/Reports/ChxImp.class/test.md) |
| 274 | Cecheancier | 1 | 0 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 6 | 1 | 39 |  | [.src/Reports/Cecheancier.class](.src/Reports/Cecheancier.class/test.md) |
| 275 | RecupDech | 4 | 3 | 1 | 0 | SQLite 1 | 6 | 4 | 20 |  | [.src/Compta/Utils/RecupDech.class](.src/Compta/Utils/RecupDech.class/test.md) |
| 276 | LTrans | 5 | 4 | 1 | 0 | clavier / souris 1 | 5 | 1 | 22 |  | [.src/Utils/LTrans.class](.src/Utils/LTrans.class/test.md) |
| 277 | AffRdv | 2 | 1 | 1 | 0 | matériel / réseau / environnement 1 | 5 | 4 | 18 |  | [.src/Utils/AffRdv.module](.src/Utils/AffRdv.module/test.md) |
| 278 | Ctraites | 1 | 0 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 3 | 1 | 19 |  | [.src/Reports/Ctraites.class](.src/Reports/Ctraites.class/test.md) |
| 279 | Monip | 2 | 0 | 2 | 0 | anomalie applicative 2 | 3 | 3 | 30 |  | [.src/Utils/Monip.module](.src/Utils/Monip.module/test.md) |
| 280 | Renech | 3 | 2 | 1 | 0 | outillage runner (comparaison, mesure) 1 | 3 | 3 | 15 |  | [.src/Compta/Utils/Renech.class](.src/Compta/Utils/Renech.class/test.md) |
| 281 | Doc | 5 | 4 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 2 | 2 | 8 |  | [.src/Communs/Doc.module](.src/Communs/Doc.module/test.md) |
| 282 | Tchauffeur | 1 | 0 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 2 | 1 | 6 |  | [.src/Gestion/option/Tchauffeur.class](.src/Gestion/option/Tchauffeur.class/test.md) |
| 283 | Statbase | 4 | 2 | 2 | 0 | SQLite 1, extraction / réécriture (phases 3-4) 1 | 2 | 1 | 32 |  | [.src/Statistiques/Statbase.class](.src/Statistiques/Statbase.class/test.md) |
| 284 | Site | 2 | 1 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 1 | 1 | 9 |  | [.src/Gestion/Site.module](.src/Gestion/Site.module/test.md) |
| 285 | Variables | 7 | 2 | 5 | 0 | module complexe (revue manuelle) 3, outillage runner (comparaison, mesure) 2 | 0 | 0 | 42 |  | [.src/Utils/Variables.module](.src/Utils/Variables.module/test.md) |
| 286 | Condition | 1 | 0 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 0 | 0 | 4 |  | [.src/Utils/Condition.class](.src/Utils/Condition.class/test.md) |
| 287 | Cmoprod | 1 | 0 | 1 | 0 | extraction / réécriture (phases 3-4) 1 | 0 | 0 | 6 |  | [.src/Utils/Cmoprod.class](.src/Utils/Cmoprod.class/test.md) |
| 288 | Comptabilite | 2 | 1 | 1 | 0 | module complexe (revue manuelle) 1 | 0 | 0 | 6 |  | [.src/Compta/Utils/Comptabilite.module](.src/Compta/Utils/Comptabilite.module/test.md) |
<!-- /AUTO:tests -->
