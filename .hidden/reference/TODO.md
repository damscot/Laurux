# TODO du rework

> Phase 2 : tests (bloc généré ci-dessous). Phase 3 : ordre des rework_id (à venir).

<!-- AUTO:tests -->
## Phase 2 — tests

> Bloc généré par `python3 .src/Tests/Framework/runner.py report` ; liste détaillée des tests implémentés : [output/tests/list.md](../../output/tests/list.md).

### Tests à vérifier à la main (0)

Tests synthétisés dont le comportement obtenu diffère de celui décrit par test.md (xfail), ou en échec : à vérifier ou corriger par l'utilisateur.

| Test | Statut | Obtenu | Attendu (test.md) | Raison | Description |
|---|---|---|---|---|---|

### Classes dont des tests restent à implémenter (454), par priorité

Priorité = complexité cyclomatique totale (×2 pour un module complexe à scénarios validés par l'utilisateur) + 5 par test restant.

| # | Classe | Tests prévus | Restant | CC totale | CC max | LOC | Complexe | test.md |
|---|---|---|---|---|---|---|---|---|
| 1 | Facture | 27 | 27 | 3116 | 166 | 10446 | oui | [.src/Gestion/Facturation/Facture.class](.src/Gestion/Facturation/Facture.class/test.md) |
| 2 | Caisse | 25 | 25 | 2102 | 77 | 7303 | oui | [.src/Caisse/Caisse.class](.src/Caisse/Caisse.class/test.md) |
| 3 | Articles | 18 | 18 | 1128 | 96 | 3775 | oui | [.src/Gestion/Tables/Articles.class](.src/Gestion/Tables/Articles.class/test.md) |
| 4 | LauruxMaj | 1 | 1 | 2251 | 550 | 5100 |  | [.src/Communs/LauruxMaj.module](.src/Communs/LauruxMaj.module/test.md) |
| 5 | FClient | 18 | 18 | 675 | 42 | 2716 | oui | [.src/Gestion/Tables/FClient.class](.src/Gestion/Tables/FClient.class/test.md) |
| 6 | Saisecrit | 17 | 17 | 654 | 72 | 2528 | oui | [.src/Compta/Saisecrit.class](.src/Compta/Saisecrit.class/test.md) |
| 7 | Moulinage | 23 | 23 | 622 | 196 | 2431 | oui | [.src/Caisse/Moulinage.class](.src/Caisse/Moulinage.class/test.md) |
| 8 | Impart | 15 | 15 | 548 | 186 | 1647 | oui | [.src/Gestion/Stock/Tarifs/Impart.class](.src/Gestion/Stock/Tarifs/Impart.class/test.md) |
| 9 | FFournisseur | 16 | 16 | 545 | 35 | 2156 | oui | [.src/Gestion/Tables/FFournisseur.class](.src/Gestion/Tables/FFournisseur.class/test.md) |
| 10 | PdfWriter | 15 | 15 | 791 | 45 | 3403 |  | [.src/Reports/PdfWriter.class](.src/Reports/PdfWriter.class/test.md) |
| 11 | MajTarifM | 11 | 11 | 319 | 25 | 1107 | oui | [.src/Gestion/Stock/Tarifs/MajTarifM.class](.src/Gestion/Stock/Tarifs/MajTarifM.class/test.md) |
| 12 | Tresor | 17 | 17 | 579 | 82 | 2185 |  | [.src/Compta/Tresor.class](.src/Compta/Tresor.class/test.md) |
| 13 | Achat | 14 | 14 | 293 | 19 | 1463 | oui | [.src/Gestion/Entrées/Achat.class](.src/Gestion/Entrées/Achat.class/test.md) |
| 14 | Fmenu | 20 | 20 | 510 | 54 | 1579 |  | [.src/Communs/Fmenu.class](.src/Communs/Fmenu.class/test.md) |
| 15 | Utils | 26 | 26 | 475 | 77 | 1315 |  | [.src/Utils/Utils.module](.src/Utils/Utils.module/test.md) |
| 16 | ObjFacB | 18 | 18 | 226 | 56 | 930 | oui | [.src/Gestion/option/ObjFacB.class](.src/Gestion/option/ObjFacB.class/test.md) |
| 17 | commande1 | 14 | 14 | 219 | 29 | 850 | oui | [.src/Gestion/Stock/commande1.class](.src/Gestion/Stock/commande1.class/test.md) |
| 18 | Materiel | 12 | 12 | 444 | 24 | 2054 |  | [.src/Gestion/Tables/Materiel.class](.src/Gestion/Tables/Materiel.class/test.md) |
| 19 | ValidBR | 3 | 3 | 231 | 40 | 1079 | oui | [.src/Gestion/Stock/ValidBR.class](.src/Gestion/Stock/ValidBR.class/test.md) |
| 20 | SaiReg | 11 | 11 | 207 | 24 | 913 | oui | [.src/Gestion/Facturation/SaiReg.class](.src/Gestion/Facturation/SaiReg.class/test.md) |
| 21 | Prefs | 17 | 17 | 374 | 186 | 1121 |  | [.src/Communs/Prefs.class](.src/Communs/Prefs.class/test.md) |
| 22 | ObjFac | 16 | 16 | 181 | 45 | 893 | oui | [.src/Gestion/Facturation/ObjFac.class](.src/Gestion/Facturation/ObjFac.class/test.md) |
| 23 | Imp_Bilan | 10 | 10 | 336 | 335 | 767 |  | [.src/Compta/Impressions/Imp_Bilan.module](.src/Compta/Impressions/Imp_Bilan.module/test.md) |
| 24 | Archives | 15 | 15 | 307 | 35 | 1202 |  | [.src/Archivages/Archives.class](.src/Archivages/Archives.class/test.md) |
| 25 | Stockmvt | 11 | 11 | 163 | 75 | 843 | oui | [.src/Gestion/Stockmvt.class](.src/Gestion/Stockmvt.class/test.md) |
| 26 | Movr | 9 | 9 | 323 | 35 | 1271 |  | [.src/Gestion/Tables/Movr.class](.src/Gestion/Tables/Movr.class/test.md) |
| 27 | FComptes | 11 | 11 | 271 | 48 | 919 |  | [.src/Compta/Tables/FComptes.class](.src/Compta/Tables/FComptes.class/test.md) |
| 28 | Preparation | 11 | 11 | 135 | 16 | 644 | oui | [.src/Gestion/Lcr/Preparation.class](.src/Gestion/Lcr/Preparation.class/test.md) |
| 29 | Caleditcmat | 14 | 14 | 121 | 35 | 766 | oui | [.src/Gestion/option/Caleditcmat.class](.src/Gestion/option/Caleditcmat.class/test.md) |
| 30 | Extrait | 14 | 14 | 236 | 31 | 1127 |  | [.src/Compta/Extrait.class](.src/Compta/Extrait.class/test.md) |
| 31 | Etigond | 13 | 13 | 235 | 51 | 915 |  | [.src/Gestion/Etiquettes/Etigond.class](.src/Gestion/Etiquettes/Etigond.class/test.md) |
| 32 | Histocliart | 11 | 11 | 245 | 141 | 836 |  | [.src/Statistiques/Histocliart.class](.src/Statistiques/Histocliart.class/test.md) |
| 33 | Lcr | 11 | 11 | 121 | 17 | 563 | oui | [.src/Gestion/Lcr/Lcr.class](.src/Gestion/Lcr/Lcr.class/test.md) |
| 34 | Attribution | 9 | 9 | 125 | 19 | 518 | oui | [.src/Gestion/Lcr/Attribution.class](.src/Gestion/Lcr/Attribution.class/test.md) |
| 35 | Facturergbl | 7 | 7 | 258 | 121 | 1232 |  | [.src/Gestion/Facturation/Facturergbl.class](.src/Gestion/Facturation/Facturergbl.class/test.md) |
| 36 | GeninvT | 14 | 14 | 110 | 20 | 531 | oui | [.src/Gestion/Stock/Inventaires/Tournant/GeninvT.class](.src/Gestion/Stock/Inventaires/Tournant/GeninvT.class/test.md) |
| 37 | SaisieInv | 16 | 16 | 104 | 24 | 418 | oui | [.src/Gestion/Stock/Inventaires/Fin-annee/SaisieInv.class](.src/Gestion/Stock/Inventaires/Fin-annee/SaisieInv.class/test.md) |
| 38 | LGed | 14 | 14 | 215 | 29 | 757 |  | [.src/Utils/LGed.class](.src/Utils/LGed.class/test.md) |
| 39 | ExportJdv | 16 | 16 | 205 | 103 | 839 |  | [.src/Compta/Utils/ExportJdv.class](.src/Compta/Utils/ExportJdv.class/test.md) |
| 40 | Cmenu | 14 | 14 | 107 | 16 | 325 | oui | [.src/Caisse/Cmenu.class](.src/Caisse/Cmenu.class/test.md) |
| 41 | SaisieInvT | 16 | 16 | 97 | 23 | 418 | oui | [.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class](.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class/test.md) |
| 42 | Cdocuments | 12 | 12 | 212 | 23 | 986 |  | [.src/Reports/Cdocuments.class](.src/Reports/Cdocuments.class/test.md) |
| 43 | Parametre | 12 | 12 | 208 | 62 | 539 |  | [.src/Communs/Parametre.class](.src/Communs/Parametre.class/test.md) |
| 44 | Emailing | 11 | 11 | 212 | 37 | 775 |  | [.src/Gestion/Mails/Emailing.class](.src/Gestion/Mails/Emailing.class/test.md) |
| 45 | FClientcarte | 10 | 10 | 216 | 28 | 863 |  | [.src/Caisse/FClientcarte.class](.src/Caisse/FClientcarte.class/test.md) |
| 46 | Famille | 9 | 9 | 218 | 28 | 761 |  | [.src/Gestion/Tables/Famille.class](.src/Gestion/Tables/Famille.class/test.md) |
| 47 | Etiqart | 12 | 12 | 197 | 24 | 848 |  | [.src/Gestion/Etiquettes/Etiqart.class](.src/Gestion/Etiquettes/Etiqart.class/test.md) |
| 48 | RubImp | 10 | 10 | 198 | 135 | 983 |  | [.src/Compta/Impressions/RubImp.class](.src/Compta/Impressions/RubImp.class/test.md) |
| 49 | Fondcaisse | 10 | 10 | 98 | 12 | 335 | oui | [.src/Caisse/Fondcaisse.class](.src/Caisse/Fondcaisse.class/test.md) |
| 50 | ImpartParam | 8 | 8 | 206 | 27 | 782 |  | [.src/Gestion/Stock/Tarifs/ImpartParam.class](.src/Gestion/Stock/Tarifs/ImpartParam.class/test.md) |
| 51 | DB_Connection | 16 | 16 | 162 | 42 | 561 |  | [.src/Utils/DB_Connection.class](.src/Utils/DB_Connection.class/test.md) |
| 52 | FClotureAn | 13 | 13 | 88 | 74 | 583 | oui | [.src/Compta/Clotures/FClotureAn.class](.src/Compta/Clotures/FClotureAn.class/test.md) |
| 53 | MvtDepots | 6 | 6 | 103 | 11 | 409 | oui | [.src/Gestion/Depots/MvtDepots.class](.src/Gestion/Depots/MvtDepots.class/test.md) |
| 54 | TresorFac | 2 | 2 | 225 | 44 | 1081 |  | [.src/Gestion/Reglements/TresorFac.class](.src/Gestion/Reglements/TresorFac.class/test.md) |
| 55 | ConsultArt | 7 | 7 | 200 | 37 | 771 |  | [.src/Gestion/Tables/ConsultArt.class](.src/Gestion/Tables/ConsultArt.class/test.md) |
| 56 | RelMoprod | 9 | 9 | 189 | 30 | 787 |  | [.src/Statistiques/RelMoprod.class](.src/Statistiques/RelMoprod.class/test.md) |
| 57 | Etiqcasier | 9 | 9 | 187 | 24 | 793 |  | [.src/Gestion/Etiquettes/Etiqcasier.class](.src/Gestion/Etiquettes/Etiqcasier.class/test.md) |
| 58 | Suivi | 8 | 8 | 95 | 14 | 293 | oui | [.src/Gestion/Suivi.class](.src/Gestion/Suivi.class/test.md) |
| 59 | TriEcritures | 6 | 6 | 198 | 11 | 602 |  | [.src/Affichages/TriEcritures.class](.src/Affichages/TriEcritures.class/test.md) |
| 60 | TextReg | 10 | 10 | 177 | 31 | 536 |  | [.src/Utils/TextReg.class](.src/Utils/TextReg.class/test.md) |
| 61 | ImpSage | 10 | 10 | 172 | 50 | 699 |  | [.src/Compta/Utils/ImpSage.class](.src/Compta/Utils/ImpSage.class/test.md) |
| 62 | TriFac2 | 7 | 7 | 187 | 20 | 630 |  | [.src/Affichages/TriFac2.class](.src/Affichages/TriFac2.class/test.md) |
| 63 | Eticli | 8 | 8 | 180 | 31 | 702 |  | [.src/Gestion/Etiquettes/Eticli.class](.src/Gestion/Etiquettes/Eticli.class/test.md) |
| 64 | ValidBR1 | 10 | 10 | 85 | 15 | 460 | oui | [.src/Gestion/Stock/ValidBR1.class](.src/Gestion/Stock/ValidBR1.class/test.md) |
| 65 | TriGen | 11 | 11 | 163 | 17 | 626 |  | [.src/Affichages/TriGen.class](.src/Affichages/TriGen.class/test.md) |
| 66 | DB_Sanity | 9 | 9 | 171 | 50 | 576 |  | [.src/Utils/DB_Sanity.class](.src/Utils/DB_Sanity.class/test.md) |
| 67 | Tricp | 8 | 8 | 88 | 13 | 220 | oui | [.src/Affichages/Tricp.class](.src/Affichages/Tricp.class/test.md) |
| 68 | facopt | 8 | 8 | 173 | 19 | 875 |  | [.src/Gestion/option/facopt.class](.src/Gestion/option/facopt.class/test.md) |
| 69 | Start | 17 | 17 | 127 | 35 | 435 |  | [.src/Start.module](.src/Start.module/test.md) |
| 70 | Bordrx | 11 | 11 | 78 | 21 | 460 | oui | [.src/Gestion/Lcr/Bordrx.class](.src/Gestion/Lcr/Bordrx.class/test.md) |
| 71 | Histovmo | 9 | 9 | 163 | 39 | 674 |  | [.src/Statistiques/Histovmo.class](.src/Statistiques/Histovmo.class/test.md) |
| 72 | ArchivesTck | 10 | 10 | 157 | 46 | 557 |  | [.src/Archivages/ArchivesTck.class](.src/Archivages/ArchivesTck.class/test.md) |
| 73 | Editfac | 10 | 10 | 154 | 112 | 476 |  | [.src/Reports/Editfac.class](.src/Reports/Editfac.class/test.md) |
| 74 | Cielimp | 12 | 12 | 140 | 54 | 520 |  | [.src/Compta/Cielimp.class](.src/Compta/Cielimp.class/test.md) |
| 75 | TriEqu | 6 | 6 | 85 | 12 | 283 | oui | [.src/Affichages/TriEqu.class](.src/Affichages/TriEqu.class/test.md) |
| 76 | FTVA | 13 | 13 | 133 | 51 | 698 |  | [.src/Compta/Impressions/FTVA.class](.src/Compta/Impressions/FTVA.class/test.md) |
| 77 | GesTar | 10 | 10 | 145 | 14 | 676 |  | [.src/Gestion/Entrées/GesTar.class](.src/Gestion/Entrées/GesTar.class/test.md) |
| 78 | Facturefm | 11 | 11 | 139 | 29 | 629 |  | [.src/Gestion/Facturation/Facturefm.class](.src/Gestion/Facturation/Facturefm.class/test.md) |
| 79 | Cdocuments2 | 2 | 2 | 182 | 31 | 926 |  | [.src/Reports/Cdocuments2.class](.src/Reports/Cdocuments2.class/test.md) |
| 80 | Pointage | 13 | 13 | 126 | 23 | 647 |  | [.src/Compta/Pointage.class](.src/Compta/Pointage.class/test.md) |
| 81 | Ouverture | 11 | 11 | 67 | 19 | 212 | oui | [.src/Caisse/Ouverture.class](.src/Caisse/Ouverture.class/test.md) |
| 82 | LDate | 14 | 14 | 119 | 20 | 489 |  | [.src/Utils/LDate.class](.src/Utils/LDate.class/test.md) |
| 83 | LPrix | 14 | 14 | 119 | 21 | 447 |  | [.src/Utils/LPrix.class](.src/Utils/LPrix.class/test.md) |
| 84 | Jourcent | 10 | 10 | 137 | 22 | 780 |  | [.src/Compta/Impressions/Jourcent.class](.src/Compta/Impressions/Jourcent.class/test.md) |
| 85 | Editcompte | 10 | 10 | 136 | 56 | 579 |  | [.src/Compta/Impressions/Editcompte.class](.src/Compta/Impressions/Editcompte.class/test.md) |
| 86 | Serveur | 8 | 8 | 143 | 90 | 295 |  | [.src/Serveur.module](.src/Serveur.module/test.md) |
| 87 | TriEcritures2 | 1 | 1 | 176 | 11 | 520 |  | [.src/Affichages/TriEcritures2.class](.src/Affichages/TriEcritures2.class/test.md) |
| 88 | Journaux | 10 | 10 | 129 | 22 | 621 |  | [.src/Compta/Impressions/Journaux.class](.src/Compta/Impressions/Journaux.class/test.md) |
| 89 | Fsoc | 13 | 13 | 113 | 30 | 488 |  | [.src/Communs/Fsoc.class](.src/Communs/Fsoc.class/test.md) |
| 90 | EdArt1 | 11 | 11 | 122 | 31 | 532 |  | [.src/Gestion/Impressions/EdArt1.class](.src/Gestion/Impressions/EdArt1.class/test.md) |
| 91 | TriHistos | 6 | 6 | 147 | 29 | 602 |  | [.src/Affichages/TriHistos.class](.src/Affichages/TriHistos.class/test.md) |
| 92 | EdArt3 | 8 | 8 | 135 | 30 | 583 |  | [.src/Gestion/Impressions/EdArt3.class](.src/Gestion/Impressions/EdArt3.class/test.md) |
| 93 | EdRup | 10 | 10 | 122 | 73 | 503 |  | [.src/Gestion/Impressions/EdRup.class](.src/Gestion/Impressions/EdRup.class/test.md) |
| 94 | EmailingCarte | 7 | 7 | 136 | 25 | 474 |  | [.src/Gestion/Mails/EmailingCarte.class](.src/Gestion/Mails/EmailingCarte.class/test.md) |
| 95 | Prodcomposes | 8 | 8 | 130 | 20 | 534 |  | [.src/Gestion/Tables/Prodcomposes.class](.src/Gestion/Tables/Prodcomposes.class/test.md) |
| 96 | EcrM | 13 | 13 | 105 | 34 | 485 |  | [.src/Compta/Impressions/EcrM.class](.src/Compta/Impressions/EcrM.class/test.md) |
| 97 | JournauxA | 8 | 8 | 128 | 24 | 664 |  | [.src/Compta/Impressions/JournauxA.class](.src/Compta/Impressions/JournauxA.class/test.md) |
| 98 | Ecomptamat | 7 | 7 | 66 | 6 | 306 | oui | [.src/Gestion/option/Ecomptamat.class](.src/Gestion/option/Ecomptamat.class/test.md) |
| 99 | Changefam | 12 | 12 | 106 | 14 | 548 |  | [.src/Utils/Changefam.class](.src/Utils/Changefam.class/test.md) |
| 100 | ExportA47 | 14 | 14 | 95 | 34 | 426 |  | [.src/Compta/Impressions/ExportA47.class](.src/Compta/Impressions/ExportA47.class/test.md) |
| 101 | Abont | 7 | 7 | 125 | 16 | 438 |  | [.src/Compta/Tables/Abont.class](.src/Compta/Tables/Abont.class/test.md) |
| 102 | EcrAuto | 12 | 12 | 99 | 22 | 601 |  | [.src/Compta/Utils/EcrAuto.class](.src/Compta/Utils/EcrAuto.class/test.md) |
| 103 | Fcaisses | 7 | 7 | 122 | 26 | 293 |  | [.src/Caisse/Fcaisses.class](.src/Caisse/Fcaisses.class/test.md) |
| 104 | EditcompteA | 8 | 8 | 114 | 19 | 695 |  | [.src/Compta/Impressions/EditcompteA.class](.src/Compta/Impressions/EditcompteA.class/test.md) |
| 105 | EnvMail | 11 | 11 | 98 | 56 | 238 |  | [.src/Gestion/Mails/EnvMail.module](.src/Gestion/Mails/EnvMail.module/test.md) |
| 106 | Saisiedecons | 7 | 7 | 117 | 9 | 497 |  | [.src/Gestion/option/Saisiedecons.class](.src/Gestion/option/Saisiedecons.class/test.md) |
| 107 | Geninv | 16 | 16 | 36 | 13 | 203 | oui | [.src/Gestion/Stock/Inventaires/Fin-annee/Geninv.class](.src/Gestion/Stock/Inventaires/Fin-annee/Geninv.class/test.md) |
| 108 | Balance | 10 | 10 | 102 | 20 | 497 |  | [.src/Compta/Impressions/Balance.class](.src/Compta/Impressions/Balance.class/test.md) |
| 109 | TriFac | 5 | 5 | 127 | 19 | 410 |  | [.src/Affichages/TriFac.class](.src/Affichages/TriFac.class/test.md) |
| 110 | Crupt | 9 | 9 | 106 | 106 | 319 |  | [.src/Utils/Crupt.module](.src/Utils/Crupt.module/test.md) |
| 111 | calculdroit1 | 10 | 10 | 50 | 7 | 167 | oui | [.src/Gestion/option/calculdroit1.class](.src/Gestion/option/calculdroit1.class/test.md) |
| 112 | FacturefmA | 8 | 8 | 109 | 41 | 517 |  | [.src/Gestion/Facturation/FacturefmA.class](.src/Gestion/Facturation/FacturefmA.class/test.md) |
| 113 | LauruxConf | 10 | 10 | 97 | 54 | 384 |  | [.src/Communs/LauruxConf.class](.src/Communs/LauruxConf.class/test.md) |
| 114 | MajTarifP | 7 | 7 | 112 | 31 | 350 |  | [.src/Gestion/Stock/Tarifs/MajTarifP.class](.src/Gestion/Stock/Tarifs/MajTarifP.class/test.md) |
| 115 | TriMat | 6 | 6 | 117 | 11 | 329 |  | [.src/Affichages/TriMat.class](.src/Affichages/TriMat.class/test.md) |
| 116 | Validinv | 16 | 16 | 32 | 20 | 158 | oui | [.src/Gestion/Stock/Inventaires/Fin-annee/Validinv.class](.src/Gestion/Stock/Inventaires/Fin-annee/Validinv.class/test.md) |
| 117 | Cbase | 4 | 4 | 122 | 122 | 248 |  | [.src/Utils/Cbase.module](.src/Utils/Cbase.module/test.md) |
| 118 | Mvtex | 9 | 9 | 97 | 16 | 589 |  | [.src/Gestion/Stock/Mvtex.class](.src/Gestion/Stock/Mvtex.class/test.md) |
| 119 | OptFac | 10 | 10 | 91 | 16 | 390 |  | [.src/Gestion/Facturation/OptFac.class](.src/Gestion/Facturation/OptFac.class/test.md) |
| 120 | EdStk | 8 | 8 | 101 | 27 | 435 |  | [.src/Gestion/Impressions/EdStk.class](.src/Gestion/Impressions/EdStk.class/test.md) |
| 121 | Listextcpt | 13 | 13 | 76 | 28 | 297 |  | [.src/Compta/Utils/Listextcpt.class](.src/Compta/Utils/Listextcpt.class/test.md) |
| 122 | FTvav | 7 | 7 | 106 | 25 | 413 |  | [.src/Compta/Tables/FTvav.class](.src/Compta/Tables/FTvav.class/test.md) |
| 123 | EdMat | 8 | 8 | 100 | 35 | 393 |  | [.src/Gestion/Impressions/EdMat.class](.src/Gestion/Impressions/EdMat.class/test.md) |
| 124 | Lettrage | 7 | 7 | 104 | 20 | 447 |  | [.src/Compta/Lettrages/Lettrage.class](.src/Compta/Lettrages/Lettrage.class/test.md) |
| 125 | TriCpt | 10 | 10 | 89 | 17 | 456 |  | [.src/Affichages/TriCpt.class](.src/Affichages/TriCpt.class/test.md) |
| 126 | Tricartes | 7 | 7 | 102 | 11 | 322 |  | [.src/Caisse/Affichages/Tricartes.class](.src/Caisse/Affichages/Tricartes.class/test.md) |
| 127 | RelvMo | 8 | 8 | 97 | 37 | 382 |  | [.src/Statistiques/RelvMo.class](.src/Statistiques/RelvMo.class/test.md) |
| 128 | FEditrel | 7 | 7 | 102 | 25 | 497 |  | [.src/Compta/Relances/FEditrel.class](.src/Compta/Relances/FEditrel.class/test.md) |
| 129 | BordereauxC | 11 | 11 | 82 | 30 | 416 |  | [.src/Compta/Impressions/BordereauxC.class](.src/Compta/Impressions/BordereauxC.class/test.md) |
| 130 | Tregie | 7 | 7 | 101 | 13 | 448 |  | [.src/Gestion/option/Tregie.class](.src/Gestion/option/Tregie.class/test.md) |
| 131 | TarTypeCli | 8 | 8 | 93 | 8 | 414 |  | [.src/Gestion/Tables/TarTypeCli.class](.src/Gestion/Tables/TarTypeCli.class/test.md) |
| 132 | TriArticles | 11 | 11 | 78 | 16 | 363 |  | [.src/Affichages/TriArticles.class](.src/Affichages/TriArticles.class/test.md) |
| 133 | FpromoArt | 7 | 7 | 96 | 22 | 377 |  | [.src/Gestion/Tables/FpromoArt.class](.src/Gestion/Tables/FpromoArt.class/test.md) |
| 134 | gridvi | 10 | 10 | 80 | 25 | 493 |  | [.src/Utils/gridvi.class](.src/Utils/gridvi.class/test.md) |
| 135 | Changefour | 8 | 8 | 90 | 12 | 411 |  | [.src/Utils/Changefour.class](.src/Utils/Changefour.class/test.md) |
| 136 | artopt | 4 | 4 | 110 | 15 | 473 |  | [.src/Gestion/option/artopt.class](.src/Gestion/option/artopt.class/test.md) |
| 137 | ImpJdv | 9 | 9 | 85 | 17 | 533 |  | [.src/Compta/Utils/ImpJdv.class](.src/Compta/Utils/ImpJdv.class/test.md) |
| 138 | MvtProdcomp | 8 | 8 | 89 | 14 | 408 |  | [.src/Gestion/Stock/MvtProdcomp.class](.src/Gestion/Stock/MvtProdcomp.class/test.md) |
| 139 | GedR | 8 | 8 | 88 | 20 | 388 |  | [.src/Utils/GedR.class](.src/Utils/GedR.class/test.md) |
| 140 | Etiqfbtarif | 7 | 7 | 92 | 18 | 365 |  | [.src/Gestion/Etiquettes/Etiqfbtarif.class](.src/Gestion/Etiquettes/Etiqfbtarif.class/test.md) |
| 141 | SupprArt | 7 | 7 | 90 | 18 | 337 |  | [.src/Gestion/SupprArt.class](.src/Gestion/SupprArt.class/test.md) |
| 142 | Einvmat | 5 | 5 | 50 | 6 | 244 | oui | [.src/Gestion/option/Einvmat.class](.src/Gestion/option/Einvmat.class/test.md) |
| 143 | Glcr | 8 | 8 | 84 | 39 | 305 |  | [.src/Gestion/Lcr/Glcr.class](.src/Gestion/Lcr/Glcr.class/test.md) |
| 144 | TriFacture | 6 | 6 | 47 | 13 | 237 | oui | [.src/Affichages/TriFacture.class](.src/Affichages/TriFacture.class/test.md) |
| 145 | ReplayObserver | 7 | 7 | 88 | 28 | 264 |  | [.src/Utils/ReplayObserver.class](.src/Utils/ReplayObserver.class/test.md) |
| 146 | numtostring | 6 | 6 | 92 | 62 | 166 |  | [.src/Caisse/numtostring.module](.src/Caisse/numtostring.module/test.md) |
| 147 | Mreglement | 9 | 9 | 77 | 11 | 318 |  | [.src/Gestion/Tables/Mreglement.class](.src/Gestion/Tables/Mreglement.class/test.md) |
| 148 | JournauxM | 12 | 12 | 62 | 55 | 338 |  | [.src/Compta/Impressions/JournauxM.module](.src/Compta/Impressions/JournauxM.module/test.md) |
| 149 | Remisecli | 7 | 7 | 86 | 12 | 351 |  | [.src/Gestion/Tables/Remisecli.class](.src/Gestion/Tables/Remisecli.class/test.md) |
| 150 | EdDocs | 7 | 7 | 84 | 39 | 328 |  | [.src/Gestion/Impressions/EdDocs.class](.src/Gestion/Impressions/EdDocs.class/test.md) |
| 151 | Dup | 6 | 6 | 89 | 82 | 230 |  | [.src/Compta/Utils/Dup.class](.src/Compta/Utils/Dup.class/test.md) |
| 152 | FRelFacture | 6 | 6 | 89 | 24 | 425 |  | [.src/Compta/Relances/FRelFacture.class](.src/Compta/Relances/FRelFacture.class/test.md) |
| 153 | Edmo | 7 | 7 | 83 | 11 | 370 |  | [.src/Gestion/Impressions/Edmo.class](.src/Gestion/Impressions/Edmo.class/test.md) |
| 154 | EdNlettrees | 11 | 11 | 63 | 17 | 424 |  | [.src/Compta/Impressions/EdNlettrees.class](.src/Compta/Impressions/EdNlettrees.class/test.md) |
| 155 | Attrib | 7 | 7 | 82 | 12 | 298 |  | [.src/Caisse/Attrib.class](.src/Caisse/Attrib.class/test.md) |
| 156 | ValidinvT | 13 | 13 | 26 | 23 | 122 | oui | [.src/Gestion/Stock/Inventaires/Tournant/ValidinvT.class](.src/Gestion/Stock/Inventaires/Tournant/ValidinvT.class/test.md) |
| 157 | EdArt2 | 1 | 1 | 112 | 21 | 489 |  | [.src/Gestion/Impressions/EdArt2.class](.src/Gestion/Impressions/EdArt2.class/test.md) |
| 158 | Echeancier | 10 | 10 | 67 | 28 | 386 |  | [.src/Compta/Impressions/Echeancier.class](.src/Compta/Impressions/Echeancier.class/test.md) |
| 159 | EtiqRecpt | 9 | 9 | 68 | 36 | 322 |  | [.src/Gestion/Etiquettes/EtiqRecpt.class](.src/Gestion/Etiquettes/EtiqRecpt.class/test.md) |
| 160 | StatComm | 10 | 10 | 62 | 37 | 224 |  | [.src/Statistiques/StatComm.class](.src/Statistiques/StatComm.class/test.md) |
| 161 | Banque | 8 | 8 | 71 | 8 | 337 |  | [.src/Gestion/Lcr/Banque.class](.src/Gestion/Lcr/Banque.class/test.md) |
| 162 | Ccompta | 10 | 10 | 60 | 5 | 546 |  | [.src/Reports/Ccompta.class](.src/Reports/Ccompta.class/test.md) |
| 163 | Txmo | 6 | 6 | 80 | 14 | 356 |  | [.src/Gestion/Tables/Txmo.class](.src/Gestion/Tables/Txmo.class/test.md) |
| 164 | Numtostring | 7 | 7 | 73 | 58 | 144 |  | [.src/Utils/Numtostring.module](.src/Utils/Numtostring.module/test.md) |
| 165 | RichDataGrid | 7 | 7 | 73 | 24 | 225 |  | [.src/Utils/RichDataGrid.class](.src/Utils/RichDataGrid.class/test.md) |
| 166 | Sdepots | 5 | 5 | 83 | 13 | 308 |  | [.src/Gestion/Depots/Sdepots.class](.src/Gestion/Depots/Sdepots.class/test.md) |
| 167 | EdClient | 6 | 6 | 78 | 15 | 338 |  | [.src/Gestion/Impressions/EdClient.class](.src/Gestion/Impressions/EdClient.class/test.md) |
| 168 | SaiTableau | 8 | 8 | 67 | 9 | 284 |  | [.src/Utils/SaiTableau.class](.src/Utils/SaiTableau.class/test.md) |
| 169 | TBord | 8 | 8 | 67 | 49 | 340 |  | [.src/Statistiques/TBord.class](.src/Statistiques/TBord.class/test.md) |
| 170 | EditcompteM | 13 | 13 | 42 | 35 | 316 |  | [.src/Compta/Impressions/EditcompteM.module](.src/Compta/Impressions/EditcompteM.module/test.md) |
| 171 | Edart4 | 8 | 8 | 66 | 19 | 392 |  | [.src/Gestion/Impressions/Edart4.class](.src/Gestion/Impressions/Edart4.class/test.md) |
| 172 | impfec | 9 | 9 | 61 | 25 | 294 |  | [.src/Compta/Utils/impfec.class](.src/Compta/Utils/impfec.class/test.md) |
| 173 | Rubcompt | 8 | 8 | 66 | 14 | 270 |  | [.src/Compta/Utils/Rubcompt.class](.src/Compta/Utils/Rubcompt.class/test.md) |
| 174 | FRelCompte | 6 | 6 | 76 | 23 | 365 |  | [.src/Compta/Relances/FRelCompte.class](.src/Compta/Relances/FRelCompte.class/test.md) |
| 175 | Majversion | 7 | 7 | 70 | 21 | 295 |  | [.src/Communs/Majversion.class](.src/Communs/Majversion.class/test.md) |
| 176 | EdPrep | 7 | 7 | 70 | 43 | 350 |  | [.src/Gestion/Impressions/EdPrep.class](.src/Gestion/Impressions/EdPrep.class/test.md) |
| 177 | Cfacture | 9 | 9 | 59 | 8 | 267 |  | [.src/Caisse/Reports/Cfacture.class](.src/Caisse/Reports/Cfacture.class/test.md) |
| 178 | EtiqPromo | 7 | 7 | 69 | 20 | 306 |  | [.src/Gestion/Etiquettes/EtiqPromo.class](.src/Gestion/Etiquettes/EtiqPromo.class/test.md) |
| 179 | Etiquettes | 6 | 6 | 73 | 7 | 228 |  | [.src/Gestion/Etiquettes/Etiquettes.class](.src/Gestion/Etiquettes/Etiquettes.class/test.md) |
| 180 | Rubresult | 8 | 8 | 63 | 21 | 290 |  | [.src/Compta/Utils/Rubresult.class](.src/Compta/Utils/Rubresult.class/test.md) |
| 181 | TriBl | 1 | 1 | 98 | 14 | 255 |  | [.src/Affichages/TriBl.class](.src/Affichages/TriBl.class/test.md) |
| 182 | StatClimo | 8 | 8 | 62 | 37 | 235 |  | [.src/Statistiques/StatClimo.class](.src/Statistiques/StatClimo.class/test.md) |
| 183 | FRestore | 10 | 10 | 51 | 30 | 179 |  | [.src/Communs/FRestore.class](.src/Communs/FRestore.class/test.md) |
| 184 | Ecritures | 7 | 7 | 66 | 18 | 374 |  | [.src/Compta/Utils/Ecritures.class](.src/Compta/Utils/Ecritures.class/test.md) |
| 185 | Cpostaux | 6 | 6 | 70 | 8 | 286 |  | [.src/Gestion/Tables/Cpostaux.class](.src/Gestion/Tables/Cpostaux.class/test.md) |
| 186 | Depots | 5 | 5 | 74 | 13 | 274 |  | [.src/Gestion/Depots/Depots.class](.src/Gestion/Depots/Depots.class/test.md) |
| 187 | Prgm | 9 | 9 | 53 | 38 | 101 |  | [.src/Communs/Prgm.class](.src/Communs/Prgm.class/test.md) |
| 188 | MajFbtarif2 | 7 | 7 | 63 | 15 | 236 |  | [.src/Gestion/Stock/Tarifs/MajFbtarif2.class](.src/Gestion/Stock/Tarifs/MajFbtarif2.class/test.md) |
| 189 | DocActif | 12 | 12 | 37 | 13 | 150 |  | [.src/Communs/DocActif.class](.src/Communs/DocActif.class/test.md) |
| 190 | TarArt | 12 | 12 | 37 | 32 | 149 |  | [.src/Utils/TarArt.class](.src/Utils/TarArt.class/test.md) |
| 191 | gridvi2 | 1 | 1 | 92 | 20 | 387 |  | [.src/Utils/gridvi2.class](.src/Utils/gridvi2.class/test.md) |
| 192 | Echeances | 8 | 8 | 57 | 18 | 220 |  | [.src/Compta/Echeances.class](.src/Compta/Echeances.class/test.md) |
| 193 | Ttourne | 10 | 10 | 46 | 7 | 147 |  | [.src/Gestion/option/Ttourne.class](.src/Gestion/option/Ttourne.class/test.md) |
| 194 | modfichier | 5 | 5 | 71 | 32 | 172 |  | [.src/Gestion/option/modfichier.module](.src/Gestion/option/modfichier.module/test.md) |
| 195 | Imp_Sig | 7 | 7 | 61 | 60 | 403 |  | [.src/Compta/Impressions/Imp_Sig.module](.src/Compta/Impressions/Imp_Sig.module/test.md) |
| 196 | FJournaux | 5 | 5 | 71 | 13 | 275 |  | [.src/Compta/Tables/FJournaux.class](.src/Compta/Tables/FJournaux.class/test.md) |
| 197 | Preferences | 6 | 6 | 65 | 41 | 183 |  | [.src/Caisse/Preferences.class](.src/Caisse/Preferences.class/test.md) |
| 198 | DateTar | 8 | 8 | 55 | 13 | 197 |  | [.src/Gestion/Entrées/DateTar.class](.src/Gestion/Entrées/DateTar.class/test.md) |
| 199 | ClotureF | 8 | 8 | 27 | 8 | 153 | oui | [.src/Gestion/ClotureF.class](.src/Gestion/ClotureF.class/test.md) |
| 200 | Ligcli | 7 | 7 | 59 | 25 | 334 |  | [.src/Compta/Relances/Ligcli.class](.src/Compta/Relances/Ligcli.class/test.md) |
| 201 | BalanceM | 10 | 10 | 44 | 30 | 355 |  | [.src/Compta/Impressions/BalanceM.module](.src/Compta/Impressions/BalanceM.module/test.md) |
| 202 | Sailig | 5 | 5 | 68 | 27 | 200 |  | [.src/Utils/Sailig.class](.src/Utils/Sailig.class/test.md) |
| 203 | Fmontant | 7 | 7 | 58 | 41 | 168 |  | [.src/Compta/Utils/Fmontant.class](.src/Compta/Utils/Fmontant.class/test.md) |
| 204 | Cbilan | 5 | 5 | 67 | 17 | 166 |  | [.src/Reports/Cbilan.class](.src/Reports/Cbilan.class/test.md) |
| 205 | Csig | 4 | 4 | 72 | 25 | 188 |  | [.src/Reports/Csig.class](.src/Reports/Csig.class/test.md) |
| 206 | Gsm | 8 | 8 | 52 | 14 | 198 |  | [.src/Gestion/SMS/Gsm.class](.src/Gestion/SMS/Gsm.class/test.md) |
| 207 | Verbal | 7 | 7 | 57 | 19 | 314 |  | [.src/Compta/Utils/Verbal.class](.src/Compta/Utils/Verbal.class/test.md) |
| 208 | FTvac | 5 | 5 | 67 | 16 | 262 |  | [.src/Compta/Tables/FTvac.class](.src/Compta/Tables/FTvac.class/test.md) |
| 209 | Trecarts | 8 | 8 | 50 | 24 | 224 |  | [.src/Compta/Trecarts.class](.src/Compta/Trecarts.class/test.md) |
| 210 | Marques | 5 | 5 | 62 | 8 | 240 |  | [.src/Gestion/Tables/Marques.class](.src/Gestion/Tables/Marques.class/test.md) |
| 211 | CoefTypeC | 5 | 5 | 62 | 10 | 281 |  | [.src/Gestion/Tables/CoefTypeC.class](.src/Gestion/Tables/CoefTypeC.class/test.md) |
| 212 | EdNjustifiees | 8 | 8 | 47 | 16 | 249 |  | [.src/Compta/Impressions/EdNjustifiees.class](.src/Compta/Impressions/EdNjustifiees.class/test.md) |
| 213 | VerifDate | 9 | 9 | 41 | 10 | 117 |  | [.src/Utils/VerifDate.class](.src/Utils/VerifDate.class/test.md) |
| 214 | Ttarfioul | 5 | 5 | 60 | 10 | 267 |  | [.src/Gestion/option/Ttarfioul.class](.src/Gestion/option/Ttarfioul.class/test.md) |
| 215 | StatTypCli | 7 | 7 | 50 | 25 | 208 |  | [.src/Statistiques/StatTypCli.class](.src/Statistiques/StatTypCli.class/test.md) |
| 216 | Cielcorsp | 7 | 7 | 50 | 10 | 199 |  | [.src/Compta/Cielcorsp.class](.src/Compta/Cielcorsp.class/test.md) |
| 217 | CFormat | 7 | 7 | 48 | 18 | 123 |  | [.src/Utils/CFormat.class](.src/Utils/CFormat.class/test.md) |
| 218 | Tregion | 8 | 8 | 43 | 8 | 168 |  | [.src/Gestion/option/Tregion.class](.src/Gestion/option/Tregion.class/test.md) |
| 219 | Btqart | 6 | 6 | 53 | 17 | 153 |  | [.src/Gestion/Tables/Btqart.class](.src/Gestion/Tables/Btqart.class/test.md) |
| 220 | Carticles | 9 | 9 | 37 | 2 | 370 |  | [.src/Reports/Carticles.class](.src/Reports/Carticles.class/test.md) |
| 221 | Calc | 1 | 1 | 76 | 14 | 213 |  | [.src/Utils/Calc.class](.src/Utils/Calc.class/test.md) |
| 222 | ObjProp | 7 | 7 | 45 | 9 | 161 |  | [.src/Utils/ObjProp.class](.src/Utils/ObjProp.class/test.md) |
| 223 | Impclient | 6 | 6 | 50 | 40 | 125 |  | [.src/Utils/Exports-Imports/Impclient.class](.src/Utils/Exports-Imports/Impclient.class/test.md) |
| 224 | Edpaiement | 7 | 7 | 44 | 29 | 187 |  | [.src/Gestion/Impressions/Edpaiement.class](.src/Gestion/Impressions/Edpaiement.class/test.md) |
| 225 | Edcom | 6 | 6 | 49 | 23 | 279 |  | [.src/Gestion/Impressions/Edcom.class](.src/Gestion/Impressions/Edcom.class/test.md) |
| 226 | HitCarte | 7 | 7 | 44 | 16 | 159 |  | [.src/Statistiques/HitCarte.class](.src/Statistiques/HitCarte.class/test.md) |
| 227 | Tconsigne | 6 | 6 | 48 | 7 | 153 |  | [.src/Gestion/option/Tconsigne.class](.src/Gestion/option/Tconsigne.class/test.md) |
| 228 | Edsdepots | 5 | 5 | 53 | 15 | 253 |  | [.src/Gestion/Depots/Edsdepots.class](.src/Gestion/Depots/Edsdepots.class/test.md) |
| 229 | Remisec | 5 | 5 | 53 | 10 | 243 |  | [.src/Gestion/Tables/Remisec.class](.src/Gestion/Tables/Remisec.class/test.md) |
| 230 | DB_Log | 7 | 7 | 42 | 9 | 225 |  | [.src/Utils/DB_Log.class](.src/Utils/DB_Log.class/test.md) |
| 231 | Trifam | 8 | 8 | 37 | 18 | 131 |  | [.src/Utils/Trifam.class](.src/Utils/Trifam.class/test.md) |
| 232 | calculdroit | 8 | 8 | 37 | 15 | 160 |  | [.src/Gestion/option/calculdroit.class](.src/Gestion/option/calculdroit.class/test.md) |
| 233 | atribvignette | 8 | 8 | 37 | 12 | 138 |  | [.src/Gestion/option/atribvignette.class](.src/Gestion/option/atribvignette.class/test.md) |
| 234 | Cielcorspj | 6 | 6 | 47 | 8 | 192 |  | [.src/Compta/Cielcorspj.class](.src/Compta/Cielcorspj.class/test.md) |
| 235 | Sha1Calc | 9 | 9 | 31 | 15 | 115 |  | [.src/Utils/Sha1Calc.module](.src/Utils/Sha1Calc.module/test.md) |
| 236 | Cstock | 12 | 12 | 16 | 13 | 108 |  | [.src/Utils/Cstock.module](.src/Utils/Cstock.module/test.md) |
| 237 | LBox | 6 | 6 | 46 | 11 | 182 |  | [.src/Utils/LBox.class](.src/Utils/LBox.class/test.md) |
| 238 | DataButtonList | 1 | 1 | 71 | 13 | 247 |  | [.src/Utils/DataButtonList.class](.src/Utils/DataButtonList.class/test.md) |
| 239 | StatComArt | 7 | 7 | 41 | 16 | 162 |  | [.src/Statistiques/StatComArt.class](.src/Statistiques/StatComArt.class/test.md) |
| 240 | TriclientsD | 2 | 2 | 65 | 11 | 177 |  | [.src/Caisse/Affichages/TriclientsD.class](.src/Caisse/Affichages/TriclientsD.class/test.md) |
| 241 | EdFour | 5 | 5 | 50 | 10 | 234 |  | [.src/Gestion/Impressions/EdFour.class](.src/Gestion/Impressions/EdFour.class/test.md) |
| 242 | StatFour | 7 | 7 | 40 | 17 | 166 |  | [.src/Statistiques/StatFour.class](.src/Statistiques/StatFour.class/test.md) |
| 243 | Cbalances | 6 | 6 | 44 | 5 | 263 |  | [.src/Reports/Cbalances.class](.src/Reports/Cbalances.class/test.md) |
| 244 | FCalc | 7 | 7 | 39 | 20 | 124 |  | [.src/Utils/FCalc.class](.src/Utils/FCalc.class/test.md) |
| 245 | Edbl | 7 | 7 | 39 | 6 | 212 |  | [.src/Gestion/Impressions/Edbl.class](.src/Gestion/Impressions/Edbl.class/test.md) |
| 246 | Fvendeurs | 6 | 6 | 43 | 9 | 163 |  | [.src/Caisse/Fvendeurs.class](.src/Caisse/Fvendeurs.class/test.md) |
| 247 | LTaxe | 10 | 10 | 23 | 5 | 88 |  | [.src/Utils/LTaxe.class](.src/Utils/LTaxe.class/test.md) |
| 248 | Identite | 5 | 5 | 48 | 6 | 156 |  | [.src/Gestion/Tables/Identite.class](.src/Gestion/Tables/Identite.class/test.md) |
| 249 | Analytique | 8 | 8 | 33 | 8 | 182 |  | [.src/Compta/Analytique.class](.src/Compta/Analytique.class/test.md) |
| 250 | EdFam | 5 | 5 | 47 | 7 | 217 |  | [.src/Gestion/Impressions/EdFam.class](.src/Gestion/Impressions/EdFam.class/test.md) |
| 251 | Edregul | 7 | 7 | 37 | 13 | 153 |  | [.src/Gestion/Impressions/Edregul.class](.src/Gestion/Impressions/Edregul.class/test.md) |
| 252 | Edbr | 7 | 7 | 37 | 19 | 228 |  | [.src/Gestion/Impressions/Edbr.module](.src/Gestion/Impressions/Edbr.module/test.md) |
| 253 | Centrales | 5 | 5 | 47 | 6 | 135 |  | [.src/Gestion/Tables/Centrales.class](.src/Gestion/Tables/Centrales.class/test.md) |
| 254 | FPrepRel2 | 1 | 1 | 67 | 10 | 346 |  | [.src/Compta/Relances/FPrepRel2.class](.src/Compta/Relances/FPrepRel2.class/test.md) |
| 255 | Calcstock | 8 | 8 | 31 | 15 | 133 |  | [.src/Utils/Calcstock.class](.src/Utils/Calcstock.class/test.md) |
| 256 | VarMajTar | 7 | 7 | 36 | 15 | 137 |  | [.src/Gestion/Stock/VarMajTar.class](.src/Gestion/Stock/VarMajTar.class/test.md) |
| 257 | Chistoriques | 7 | 7 | 33 | 1 | 291 |  | [.src/Reports/Chistoriques.class](.src/Reports/Chistoriques.class/test.md) |
| 258 | Fpromo | 5 | 5 | 43 | 8 | 186 |  | [.src/Gestion/Tables/Fpromo.class](.src/Gestion/Tables/Fpromo.class/test.md) |
| 259 | FCollectif | 5 | 5 | 43 | 10 | 172 |  | [.src/Compta/Tables/FCollectif.class](.src/Compta/Tables/FCollectif.class/test.md) |
| 260 | Typec | 4 | 4 | 47 | 6 | 143 |  | [.src/Gestion/Tables/Typec.class](.src/Gestion/Tables/Typec.class/test.md) |
| 261 | Statut | 4 | 4 | 47 | 6 | 136 |  | [.src/Gestion/Tables/Statut.class](.src/Gestion/Tables/Statut.class/test.md) |
| 262 | chainage | 7 | 7 | 31 | 13 | 76 |  | [.src/Utils/chainage.class](.src/Utils/chainage.class/test.md) |
| 263 | Sms | 6 | 6 | 36 | 8 | 128 |  | [.src/Gestion/SMS/Sms.class](.src/Gestion/SMS/Sms.class/test.md) |
| 264 | Creleve | 6 | 6 | 35 | 12 | 225 |  | [.src/Reports/Creleve.class](.src/Reports/Creleve.class/test.md) |
| 265 | Edconsigne | 6 | 6 | 35 | 15 | 244 |  | [.src/Gestion/option/Edconsigne.class](.src/Gestion/option/Edconsigne.class/test.md) |
| 266 | FCloture | 8 | 8 | 25 | 17 | 116 |  | [.src/Compta/Clotures/FCloture.class](.src/Compta/Clotures/FCloture.class/test.md) |
| 267 | journauxSetting | 6 | 6 | 35 | 16 | 123 |  | [.src/Compta/Impressions/journauxSetting.class](.src/Compta/Impressions/journauxSetting.class/test.md) |
| 268 | ImageButton | 4 | 4 | 22 | 7 | 103 | oui | [.src/Caisse/ImageButton.class](.src/Caisse/ImageButton.class/test.md) |
| 269 | Edinv | 7 | 7 | 29 | 15 | 135 |  | [.src/Gestion/Stock/Inventaires/Fin-annee/Edinv.class](.src/Gestion/Stock/Inventaires/Fin-annee/Edinv.class/test.md) |
| 270 | Edregulprdc | 5 | 5 | 39 | 13 | 186 |  | [.src/Gestion/Impressions/Edregulprdc.class](.src/Gestion/Impressions/Edregulprdc.class/test.md) |
| 271 | Cetiquettes | 6 | 6 | 33 | 3 | 185 |  | [.src/Reports/Cetiquettes.class](.src/Reports/Cetiquettes.class/test.md) |
| 272 | SetColors | 6 | 6 | 33 | 9 | 88 |  | [.src/Utils/SetColors.class](.src/Utils/SetColors.class/test.md) |
| 273 | ConVendeurs | 6 | 6 | 33 | 9 | 98 |  | [.src/Gestion/Facturation/ConVendeurs.class](.src/Gestion/Facturation/ConVendeurs.class/test.md) |
| 274 | Commerciaux | 5 | 5 | 38 | 9 | 145 |  | [.src/Gestion/Tables/Commerciaux.class](.src/Gestion/Tables/Commerciaux.class/test.md) |
| 275 | StatPromo | 6 | 6 | 33 | 12 | 142 |  | [.src/Statistiques/StatPromo.class](.src/Statistiques/StatPromo.class/test.md) |
| 276 | Intjdv | 1 | 1 | 58 | 11 | 308 |  | [.src/Compta/Utils/Intjdv.class](.src/Compta/Utils/Intjdv.class/test.md) |
| 277 | VisStatComm | 6 | 6 | 32 | 14 | 219 |  | [.src/Statistiques/VisStatComm.class](.src/Statistiques/VisStatComm.class/test.md) |
| 278 | Plancomptable | 4 | 4 | 42 | 8 | 155 |  | [.src/Compta/Impressions/Plancomptable.class](.src/Compta/Impressions/Plancomptable.class/test.md) |
| 279 | Statcai | 6 | 6 | 31 | 17 | 146 |  | [.src/Caisse/Statcai.class](.src/Caisse/Statcai.class/test.md) |
| 280 | ComMail | 5 | 5 | 36 | 7 | 130 |  | [.src/Gestion/Tables/ComMail.class](.src/Gestion/Tables/ComMail.class/test.md) |
| 281 | Bordereaux | 7 | 7 | 24 | 14 | 147 |  | [.src/Caisse/Bordereaux.class](.src/Caisse/Bordereaux.class/test.md) |
| 282 | Cstocks | 7 | 7 | 24 | 1 | 241 |  | [.src/Reports/Cstocks.class](.src/Reports/Cstocks.class/test.md) |
| 283 | fourconsdroi | 2 | 2 | 49 | 8 | 213 |  | [.src/Gestion/option/fourconsdroi.class](.src/Gestion/option/fourconsdroi.class/test.md) |
| 284 | MajEqu | 6 | 6 | 29 | 24 | 47 |  | [.src/Gestion/Stock/Tarifs/MajEqu.module](.src/Gestion/Stock/Tarifs/MajEqu.module/test.md) |
| 285 | Comment | 5 | 5 | 34 | 7 | 125 |  | [.src/Gestion/Tables/Comment.class](.src/Gestion/Tables/Comment.class/test.md) |
| 286 | VisStatComArt | 6 | 6 | 29 | 9 | 186 |  | [.src/Statistiques/VisStatComArt.class](.src/Statistiques/VisStatComArt.class/test.md) |
| 287 | EdImpayes | 2 | 2 | 49 | 15 | 314 |  | [.src/Compta/Impressions/EdImpayes.class](.src/Compta/Impressions/EdImpayes.class/test.md) |
| 288 | EditfacB | 4 | 4 | 38 | 10 | 628 |  | [.src/Gestion/option/EditfacB.class](.src/Gestion/option/EditfacB.class/test.md) |
| 289 | VarEcr | 6 | 6 | 28 | 4 | 110 |  | [.src/Compta/Utils/VarEcr.class](.src/Compta/Utils/VarEcr.class/test.md) |
| 290 | textfamille | 6 | 6 | 27 | 7 | 107 |  | [.src/Utils/textfamille.class](.src/Utils/textfamille.class/test.md) |
| 291 | barselection | 4 | 4 | 37 | 10 | 173 |  | [.src/Gestion/option/barselection.class](.src/Gestion/option/barselection.class/test.md) |
| 292 | CLcr | 6 | 6 | 27 | 10 | 179 |  | [.src/Gestion/Lcr/CLcr.class](.src/Gestion/Lcr/CLcr.class/test.md) |
| 293 | EcrReg | 7 | 7 | 21 | 18 | 135 |  | [.src/Compta/Utils/EcrReg.class](.src/Compta/Utils/EcrReg.class/test.md) |
| 294 | Fusers | 8 | 8 | 15 | 4 | 75 |  | [.src/Communs/Fusers.class](.src/Communs/Fusers.class/test.md) |
| 295 | Calcsolde | 7 | 7 | 20 | 8 | 70 |  | [.src/Utils/Calcsolde.class](.src/Utils/Calcsolde.class/test.md) |
| 296 | LScript | 8 | 8 | 15 | 8 | 57 |  | [.src/Utils/LScript.class](.src/Utils/LScript.class/test.md) |
| 297 | VisStatTypCli | 5 | 5 | 30 | 10 | 206 |  | [.src/Statistiques/VisStatTypCli.class](.src/Statistiques/VisStatTypCli.class/test.md) |
| 298 | FPostes | 4 | 4 | 35 | 7 | 117 |  | [.src/Compta/Tables/FPostes.class](.src/Compta/Tables/FPostes.class/test.md) |
| 299 | PdfWriterFont | 2 | 2 | 43 | 19 | 400 |  | [.src/Reports/PdfWriterFont.class](.src/Reports/PdfWriterFont.class/test.md) |
| 300 | RazArt | 7 | 7 | 18 | 13 | 68 |  | [.src/Utils/RazArt.class](.src/Utils/RazArt.class/test.md) |
| 301 | FSauve | 6 | 6 | 22 | 12 | 88 |  | [.src/Communs/FSauve.class](.src/Communs/FSauve.class/test.md) |
| 302 | ImpDepots | 4 | 4 | 30 | 11 | 136 |  | [.src/Gestion/Depots/ImpDepots.class](.src/Gestion/Depots/ImpDepots.class/test.md) |
| 303 | FLibelle | 3 | 3 | 35 | 10 | 134 |  | [.src/Compta/Tables/FLibelle.class](.src/Compta/Tables/FLibelle.class/test.md) |
| 304 | LLog | 7 | 7 | 14 | 6 | 55 |  | [.src/Utils/LLog.class](.src/Utils/LLog.class/test.md) |
| 305 | Visreglements | 5 | 5 | 24 | 8 | 191 |  | [.src/Gestion/Reglements/Visreglements.class](.src/Gestion/Reglements/Visreglements.class/test.md) |
| 306 | VisStatFour | 4 | 4 | 29 | 8 | 214 |  | [.src/Statistiques/VisStatFour.class](.src/Statistiques/VisStatFour.class/test.md) |
| 307 | Ccomptes | 5 | 5 | 24 | 6 | 97 |  | [.src/Compta/Ccomptes.module](.src/Compta/Ccomptes.module/test.md) |
| 308 | Fclientc | 4 | 4 | 28 | 5 | 123 |  | [.src/Caisse/Fclientc.class](.src/Caisse/Fclientc.class/test.md) |
| 309 | EdnsaisisT | 6 | 6 | 18 | 7 | 151 |  | [.src/Gestion/Stock/Inventaires/Tournant/EdnsaisisT.class](.src/Gestion/Stock/Inventaires/Tournant/EdnsaisisT.class/test.md) |
| 310 | Ednsaisis | 6 | 6 | 18 | 7 | 154 |  | [.src/Gestion/Stock/Inventaires/Fin-annee/Ednsaisis.class](.src/Gestion/Stock/Inventaires/Fin-annee/Ednsaisis.class/test.md) |
| 311 | MajFbtarif1 | 1 | 1 | 43 | 21 | 161 |  | [.src/Gestion/Stock/Tarifs/MajFbtarif1.class](.src/Gestion/Stock/Tarifs/MajFbtarif1.class/test.md) |
| 312 | Majcasier | 5 | 5 | 23 | 17 | 88 |  | [.src/Gestion/Lcr/Portables/Majcasier.class](.src/Gestion/Lcr/Portables/Majcasier.class/test.md) |
| 313 | Lettragemontant | 5 | 5 | 23 | 16 | 104 |  | [.src/Compta/Lettrages/Lettragemontant.class](.src/Compta/Lettrages/Lettragemontant.class/test.md) |
| 314 | FTips | 5 | 5 | 22 | 8 | 87 |  | [.src/Communs/FTips.class](.src/Communs/FTips.class/test.md) |
| 315 | ProgBar | 6 | 6 | 17 | 4 | 73 |  | [.src/Utils/ProgBar.class](.src/Utils/ProgBar.class/test.md) |
| 316 | EditStkDepart | 6 | 6 | 17 | 9 | 136 |  | [.src/Gestion/option/EditStkDepart.class](.src/Gestion/option/EditStkDepart.class/test.md) |
| 317 | Listecom | 5 | 5 | 22 | 14 | 162 |  | [.src/Gestion/Stock/Listecom.class](.src/Gestion/Stock/Listecom.class/test.md) |
| 318 | EcartsT | 6 | 6 | 17 | 5 | 164 |  | [.src/Gestion/Stock/Inventaires/Tournant/EcartsT.class](.src/Gestion/Stock/Inventaires/Tournant/EcartsT.class/test.md) |
| 319 | Ecarts | 6 | 6 | 17 | 5 | 162 |  | [.src/Gestion/Stock/Inventaires/Fin-annee/Ecarts.class](.src/Gestion/Stock/Inventaires/Fin-annee/Ecarts.class/test.md) |
| 320 | EdReg | 5 | 5 | 22 | 10 | 59 |  | [.src/Gestion/Impressions/EdReg.class](.src/Gestion/Impressions/EdReg.class/test.md) |
| 321 | Cbordereaux | 6 | 6 | 16 | 1 | 97 |  | [.src/Reports/Cbordereaux.class](.src/Reports/Cbordereaux.class/test.md) |
| 322 | NetHandler | 6 | 6 | 16 | 5 | 43 |  | [.src/Utils/NetHandler.class](.src/Utils/NetHandler.class/test.md) |
| 323 | Epurmvtexp | 5 | 5 | 21 | 7 | 109 |  | [.src/Gestion/Stock/Epurmvtexp.class](.src/Gestion/Stock/Epurmvtexp.class/test.md) |
| 324 | ArtPromo | 6 | 6 | 16 | 4 | 44 |  | [.src/Gestion/Tables/ArtPromo.module](.src/Gestion/Tables/ArtPromo.module/test.md) |
| 325 | Fprepdus | 5 | 5 | 20 | 8 | 73 |  | [.src/Communs/Fprepdus.class](.src/Communs/Fprepdus.class/test.md) |
| 326 | LVar | 6 | 6 | 15 | 5 | 61 |  | [.src/Utils/LVar.class](.src/Utils/LVar.class/test.md) |
| 327 | VisHitCartes | 5 | 5 | 20 | 7 | 171 |  | [.src/Statistiques/VisHitCartes.class](.src/Statistiques/VisHitCartes.class/test.md) |
| 328 | Anomalies | 5 | 5 | 20 | 9 | 110 |  | [.src/Compta/Impressions/Anomalies.class](.src/Compta/Impressions/Anomalies.class/test.md) |
| 329 | AFacture | 5 | 5 | 20 | 12 | 83 |  | [.src/Affichages/AFacture.class](.src/Affichages/AFacture.class/test.md) |
| 330 | VisStatClimo | 5 | 5 | 19 | 4 | 185 |  | [.src/Statistiques/VisStatClimo.class](.src/Statistiques/VisStatClimo.class/test.md) |
| 331 | RazHistoFac | 6 | 6 | 14 | 11 | 50 |  | [.src/Archivages/RazHistoFac.class](.src/Archivages/RazHistoFac.class/test.md) |
| 332 | Agenda | 4 | 4 | 23 | 5 | 117 |  | [.src/Utils/Agenda.class](.src/Utils/Agenda.class/test.md) |
| 333 | Portable | 5 | 5 | 18 | 18 | 69 |  | [.src/Gestion/Lcr/Portables/Portable.module](.src/Gestion/Lcr/Portables/Portable.module/test.md) |
| 334 | Tleg | 4 | 4 | 23 | 6 | 67 |  | [.src/Gestion/Tables/Tleg.class](.src/Gestion/Tables/Tleg.class/test.md) |
| 335 | FRelance | 5 | 5 | 18 | 4 | 74 |  | [.src/Compta/Relances/FRelance.class](.src/Compta/Relances/FRelance.class/test.md) |
| 336 | Consigne | 6 | 6 | 12 | 3 | 61 |  | [.src/Gestion/option/Consigne.class](.src/Gestion/option/Consigne.class/test.md) |
| 337 | Telium | 3 | 3 | 26 | 5 | 97 |  | [.src/Caisse/Telium.class](.src/Caisse/Telium.class/test.md) |
| 338 | Conditions | 4 | 4 | 21 | 13 | 79 |  | [.src/Utils/Conditions.class](.src/Utils/Conditions.class/test.md) |
| 339 | FSetFormat | 5 | 5 | 16 | 4 | 57 |  | [.src/Utils/FSetFormat.class](.src/Utils/FSetFormat.class/test.md) |
| 340 | Tmail | 3 | 3 | 26 | 6 | 67 |  | [.src/Gestion/Tables/Tmail.class](.src/Gestion/Tables/Tmail.class/test.md) |
| 341 | Epurjdv | 2 | 2 | 29 | 18 | 172 |  | [.src/Compta/Utils/Epurjdv.class](.src/Compta/Utils/Epurjdv.class/test.md) |
| 342 | RazHistoTk | 6 | 6 | 9 | 7 | 34 |  | [.src/Archivages/RazHistoTk.class](.src/Archivages/RazHistoTk.class/test.md) |
| 343 | RazHistoFbl | 6 | 6 | 9 | 7 | 34 |  | [.src/Archivages/RazHistoFbl.class](.src/Archivages/RazHistoFbl.class/test.md) |
| 344 | RazDevis | 5 | 5 | 14 | 11 | 50 |  | [.src/Archivages/RazDevis.class](.src/Archivages/RazDevis.class/test.md) |
| 345 | Cclients | 5 | 5 | 13 | 1 | 118 |  | [.src/Reports/Cclients.class](.src/Reports/Cclients.class/test.md) |
| 346 | rechcons | 4 | 4 | 18 | 8 | 74 |  | [.src/Gestion/option/rechcons.class](.src/Gestion/option/rechcons.class/test.md) |
| 347 | Traites | 5 | 5 | 13 | 8 | 132 |  | [.src/Gestion/Impressions/Traites.class](.src/Gestion/Impressions/Traites.class/test.md) |
| 348 | RazRlvb | 6 | 6 | 8 | 6 | 30 |  | [.src/Archivages/RazRlvb.class](.src/Archivages/RazRlvb.class/test.md) |
| 349 | Clivre | 1 | 1 | 32 | 7 | 142 |  | [.src/Reports/Clivre.class](.src/Reports/Clivre.class/test.md) |
| 350 | Expart | 5 | 5 | 12 | 8 | 79 |  | [.src/Utils/Exports-Imports/Expart.class](.src/Utils/Exports-Imports/Expart.class/test.md) |
| 351 | Clavier | 4 | 4 | 16 | 8 | 59 |  | [.src/Caisse/Clavier.class](.src/Caisse/Clavier.class/test.md) |
| 352 | MDP | 5 | 5 | 11 | 6 | 34 |  | [.src/Communs/MDP.class](.src/Communs/MDP.class/test.md) |
| 353 | VerifNumfac | 2 | 2 | 26 | 26 | 86 |  | [.src/Utils/VerifNumfac.module](.src/Utils/VerifNumfac.module/test.md) |
| 354 | Svendeur | 4 | 4 | 15 | 6 | 44 |  | [.src/Caisse/Svendeur.class](.src/Caisse/Svendeur.class/test.md) |
| 355 | SauvesAuto | 5 | 5 | 10 | 10 | 35 |  | [.src/Communs/SauvesAuto.module](.src/Communs/SauvesAuto.module/test.md) |
| 356 | Variables | 7 | 7 | 0 | 0 | 42 |  | [.src/Utils/Variables.module](.src/Utils/Variables.module/test.md) |
| 357 | Impcpostaux | 4 | 4 | 14 | 10 | 55 |  | [.src/Utils/Exports-Imports/Impcpostaux.class](.src/Utils/Exports-Imports/Impcpostaux.class/test.md) |
| 358 | ImportStk | 4 | 4 | 14 | 10 | 56 |  | [.src/Utils/Exports-Imports/ImportStk.class](.src/Utils/Exports-Imports/ImportStk.class/test.md) |
| 359 | Expcontact | 4 | 4 | 14 | 9 | 118 |  | [.src/Utils/Exports-Imports/Expcontact.class](.src/Utils/Exports-Imports/Expcontact.class/test.md) |
| 360 | ImptartypeC | 4 | 4 | 14 | 6 | 53 |  | [.src/Utils/Exports-Imports/ImptartypeC.class](.src/Utils/Exports-Imports/ImptartypeC.class/test.md) |
| 361 | Lettragesoldes | 4 | 4 | 14 | 7 | 68 |  | [.src/Compta/Lettrages/Lettragesoldes.class](.src/Compta/Lettrages/Lettragesoldes.class/test.md) |
| 362 | Exprub | 5 | 5 | 9 | 9 | 48 |  | [.src/Compta/Utils/Exprub.class](.src/Compta/Utils/Exprub.class/test.md) |
| 363 | ACom | 4 | 4 | 14 | 6 | 66 |  | [.src/Affichages/ACom.class](.src/Affichages/ACom.class/test.md) |
| 364 | rechtipp | 4 | 4 | 13 | 5 | 59 |  | [.src/Gestion/option/rechtipp.class](.src/Gestion/option/rechtipp.class/test.md) |
| 365 | menuopt | 3 | 3 | 18 | 3 | 127 |  | [.src/Gestion/option/menuopt.class](.src/Gestion/option/menuopt.class/test.md) |
| 366 | RazClientd | 5 | 5 | 8 | 6 | 28 |  | [.src/Archivages/RazClientd.class](.src/Archivages/RazClientd.class/test.md) |
| 367 | Cdocuments3 | 3 | 3 | 17 | 2 | 159 |  | [.src/Reports/Cdocuments3.class](.src/Reports/Cdocuments3.class/test.md) |
| 368 | CTestTVA | 5 | 5 | 7 | 6 | 29 |  | [.src/Utils/CTestTVA.class](.src/Utils/CTestTVA.class/test.md) |
| 369 | CalcRem | 4 | 4 | 12 | 7 | 40 |  | [.src/Utils/CalcRem.class](.src/Utils/CalcRem.class/test.md) |
| 370 | Edinv1 | 1 | 1 | 27 | 15 | 126 |  | [.src/Gestion/Stock/Inventaires/Fin-annee/Edinv1.class](.src/Gestion/Stock/Inventaires/Fin-annee/Edinv1.class/test.md) |
| 371 | LibelTicket | 4 | 4 | 11 | 4 | 34 |  | [.src/Caisse/LibelTicket.class](.src/Caisse/LibelTicket.class/test.md) |
| 372 | hexdblKey | 4 | 4 | 11 | 4 | 38 |  | [.src/Utils/hexdblKey.module](.src/Utils/hexdblKey.module/test.md) |
| 373 | Cdoc | 1 | 1 | 26 | 6 | 103 |  | [.src/Utils/Cdoc.class](.src/Utils/Cdoc.class/test.md) |
| 374 | Dcfour | 3 | 3 | 16 | 14 | 60 |  | [.src/Utils/Dcfour.class](.src/Utils/Dcfour.class/test.md) |
| 375 | Fblocsoc | 4 | 4 | 10 | 4 | 19 |  | [.src/Communs/Fblocsoc.class](.src/Communs/Fblocsoc.class/test.md) |
| 376 | LTrans | 5 | 5 | 5 | 1 | 22 |  | [.src/Utils/LTrans.class](.src/Utils/LTrans.class/test.md) |
| 377 | Cprod | 2 | 2 | 20 | 6 | 86 |  | [.src/Utils/Cprod.class](.src/Utils/Cprod.class/test.md) |
| 378 | rechtour | 4 | 4 | 10 | 3 | 41 |  | [.src/Gestion/option/rechtour.class](.src/Gestion/option/rechtour.class/test.md) |
| 379 | LCoul | 4 | 4 | 9 | 5 | 92 |  | [.src/Utils/LCoul.class](.src/Utils/LCoul.class/test.md) |
| 380 | CompArt | 3 | 3 | 14 | 10 | 54 |  | [.src/Utils/CompArt.class](.src/Utils/CompArt.class/test.md) |
| 381 | Expbase | 3 | 3 | 14 | 10 | 42 |  | [.src/Utils/Exports-Imports/Expbase.class](.src/Utils/Exports-Imports/Expbase.class/test.md) |
| 382 | Visucmat | 4 | 4 | 8 | 2 | 87 |  | [.src/Gestion/option/Visucmat.class](.src/Gestion/option/Visucmat.class/test.md) |
| 383 | EdinvT | 1 | 1 | 23 | 10 | 161 |  | [.src/Gestion/Stock/Inventaires/Tournant/EdinvT.class](.src/Gestion/Stock/Inventaires/Tournant/EdinvT.class/test.md) |
| 384 | Doc | 5 | 5 | 2 | 2 | 8 |  | [.src/Communs/Doc.module](.src/Communs/Doc.module/test.md) |
| 385 | Cresultat | 3 | 3 | 12 | 3 | 66 |  | [.src/Reports/Cresultat.class](.src/Reports/Cresultat.class/test.md) |
| 386 | DB_Desktop | 4 | 4 | 7 | 3 | 31 |  | [.src/Utils/DB_Desktop.class](.src/Utils/DB_Desktop.class/test.md) |
| 387 | LibelAvoirs | 3 | 3 | 11 | 4 | 35 |  | [.src/Caisse/LibelAvoirs.class](.src/Caisse/LibelAvoirs.class/test.md) |
| 388 | TestCaisses | 4 | 4 | 6 | 6 | 25 |  | [.src/Caisse/TestCaisses.module](.src/Caisse/TestCaisses.module/test.md) |
| 389 | Impression | 3 | 3 | 11 | 7 | 44 |  | [.src/Utils/Impression.module](.src/Utils/Impression.module/test.md) |
| 390 | Mmysql | 3 | 3 | 11 | 7 | 27 |  | [.src/Utils/Mmysql.module](.src/Utils/Mmysql.module/test.md) |
| 391 | Csolde | 4 | 4 | 6 | 3 | 53 |  | [.src/Utils/Csolde.module](.src/Utils/Csolde.module/test.md) |
| 392 | Posnum | 1 | 1 | 21 | 21 | 45 |  | [.src/Utils/Posnum.module](.src/Utils/Posnum.module/test.md) |
| 393 | RecupDech | 4 | 4 | 6 | 4 | 20 |  | [.src/Compta/Utils/RecupDech.class](.src/Compta/Utils/RecupDech.class/test.md) |
| 394 | Equilibrage | 3 | 3 | 11 | 7 | 55 |  | [.src/Compta/Utils/Equilibrage.class](.src/Compta/Utils/Equilibrage.class/test.md) |
| 395 | Editeur | 4 | 4 | 5 | 3 | 15 |  | [.src/Gestion/Impressions/Editeur.module](.src/Gestion/Impressions/Editeur.module/test.md) |
| 396 | LibelFac | 3 | 3 | 10 | 4 | 35 |  | [.src/Gestion/Tables/LibelFac.class](.src/Gestion/Tables/LibelFac.class/test.md) |
| 397 | Expclient | 3 | 3 | 9 | 5 | 59 |  | [.src/Utils/Exports-Imports/Expclient.class](.src/Utils/Exports-Imports/Expclient.class/test.md) |
| 398 | Edittipp | 3 | 3 | 9 | 2 | 38 |  | [.src/Gestion/option/Edittipp.class](.src/Gestion/option/Edittipp.class/test.md) |
| 399 | ticpe | 3 | 3 | 9 | 5 | 40 |  | [.src/Gestion/option/ticpe.class](.src/Gestion/option/ticpe.class/test.md) |
| 400 | RazClos | 4 | 4 | 4 | 1 | 15 |  | [.src/Compta/Utils/RazClos.class](.src/Compta/Utils/RazClos.class/test.md) |
| 401 | Ligext | 3 | 3 | 9 | 3 | 62 |  | [.src/Compta/Relances/Ligext.class](.src/Compta/Relances/Ligext.class/test.md) |
| 402 | Cmo | 2 | 2 | 13 | 3 | 55 |  | [.src/Utils/Cmo.class](.src/Utils/Cmo.class/test.md) |
| 403 | LDateC | 3 | 3 | 8 | 3 | 33 |  | [.src/Utils/LDateC.class](.src/Utils/LDateC.class/test.md) |
| 404 | RenumBl | 3 | 3 | 8 | 8 | 29 |  | [.src/Utils/RenumBl.class](.src/Utils/RenumBl.class/test.md) |
| 405 | Carch | 2 | 2 | 13 | 3 | 56 |  | [.src/Utils/Carch.class](.src/Utils/Carch.class/test.md) |
| 406 | Visimpayes | 1 | 1 | 18 | 7 | 157 |  | [.src/Compta/Lettrages/Visimpayes.class](.src/Compta/Lettrages/Visimpayes.class/test.md) |
| 407 | modCrBcode | 1 | 1 | 17 | 17 | 79 |  | [.src/Utils/modCrBcode.module](.src/Utils/modCrBcode.module/test.md) |
| 408 | Fcaras | 2 | 2 | 12 | 7 | 39 |  | [.src/Gestion/Facturation/Fcaras.class](.src/Gestion/Facturation/Fcaras.class/test.md) |
| 409 | Statbase | 4 | 4 | 2 | 1 | 32 |  | [.src/Statistiques/Statbase.class](.src/Statistiques/Statbase.class/test.md) |
| 410 | Cecrit | 1 | 1 | 17 | 8 | 71 |  | [.src/Compta/Cecrit.module](.src/Compta/Cecrit.module/test.md) |
| 411 | RenMvt | 3 | 3 | 7 | 4 | 48 |  | [.src/Compta/Utils/RenMvt.module](.src/Compta/Utils/RenMvt.module/test.md) |
| 412 | TriTest | 3 | 3 | 7 | 2 | 43 |  | [.src/Tests/TriTest.class](.src/Tests/TriTest.class/test.md) |
| 413 | Raz | 3 | 3 | 6 | 4 | 21 |  | [.src/Communs/Raz.class](.src/Communs/Raz.class/test.md) |
| 414 | Htickets | 3 | 3 | 6 | 1 | 33 |  | [.src/Reports/Htickets.class](.src/Reports/Htickets.class/test.md) |
| 415 | TypeClient | 3 | 3 | 6 | 3 | 24 |  | [.src/Compta/Utils/TypeClient.class](.src/Compta/Utils/TypeClient.class/test.md) |
| 416 | Deblockbl | 3 | 3 | 5 | 3 | 22 |  | [.src/Communs/Deblockbl.class](.src/Communs/Deblockbl.class/test.md) |
| 417 | Copie | 3 | 3 | 5 | 5 | 17 |  | [.src/Utils/Copie.module](.src/Utils/Copie.module/test.md) |
| 418 | RazInvT | 3 | 3 | 5 | 3 | 13 |  | [.src/Gestion/Stock/Inventaires/Tournant/RazInvT.class](.src/Gestion/Stock/Inventaires/Tournant/RazInvT.class/test.md) |
| 419 | RazInv | 3 | 3 | 5 | 3 | 13 |  | [.src/Gestion/Stock/Inventaires/Fin-annee/RazInv.class](.src/Gestion/Stock/Inventaires/Fin-annee/RazInv.class/test.md) |
| 420 | FAbout | 2 | 2 | 9 | 3 | 43 |  | [.src/Communs/FAbout.class](.src/Communs/FAbout.class/test.md) |
| 421 | RecupN | 3 | 3 | 4 | 4 | 23 |  | [.src/Utils/RecupN.class](.src/Utils/RecupN.class/test.md) |
| 422 | Cmat | 2 | 2 | 8 | 1 | 54 |  | [.src/Reports/Cmat.class](.src/Reports/Cmat.class/test.md) |
| 423 | Psms | 1 | 1 | 13 | 5 | 51 |  | [.src/Gestion/SMS/Psms.class](.src/Gestion/SMS/Psms.class/test.md) |
| 424 | Renech | 3 | 3 | 3 | 3 | 15 |  | [.src/Compta/Utils/Renech.class](.src/Compta/Utils/Renech.class/test.md) |
| 425 | Fsystem | 2 | 2 | 7 | 6 | 30 |  | [.src/Communs/Fsystem.class](.src/Communs/Fsystem.class/test.md) |
| 426 | VisPmp | 2 | 2 | 7 | 5 | 38 |  | [.src/Utils/VisPmp.class](.src/Utils/VisPmp.class/test.md) |
| 427 | Zebra | 3 | 3 | 1 | 1 | 19 |  | [.src/Gestion/Etiquettes/Zebra.module](.src/Gestion/Etiquettes/Zebra.module/test.md) |
| 428 | EntreeItem | 2 | 2 | 6 | 6 | 14 |  | [.src/Gestion/Lcr/EntreeItem.module](.src/Gestion/Lcr/EntreeItem.module/test.md) |
| 429 | MyStyle | 2 | 2 | 5 | 5 | 38 |  | [.src/Caisse/MyStyle.class](.src/Caisse/MyStyle.class/test.md) |
| 430 | CPrix | 2 | 2 | 5 | 3 | 15 |  | [.src/Utils/CPrix.module](.src/Utils/CPrix.module/test.md) |
| 431 | AffRdv | 2 | 2 | 5 | 4 | 18 |  | [.src/Utils/AffRdv.module](.src/Utils/AffRdv.module/test.md) |
| 432 | gridv | 1 | 1 | 10 | 10 | 56 |  | [.src/Utils/gridv.module](.src/Utils/gridv.module/test.md) |
| 433 | Papmp | 2 | 2 | 4 | 4 | 18 |  | [.src/Utils/Papmp.class](.src/Utils/Papmp.class/test.md) |
| 434 | HistoCom | 2 | 2 | 4 | 4 | 11 |  | [.src/Utils/HistoCom.class](.src/Utils/HistoCom.class/test.md) |
| 435 | Syntheses | 2 | 2 | 4 | 4 | 12 |  | [.src/Utils/Syntheses.module](.src/Utils/Syntheses.module/test.md) |
| 436 | Recup | 2 | 2 | 4 | 3 | 20 |  | [.src/Utils/Recup.module](.src/Utils/Recup.module/test.md) |
| 437 | Monip | 2 | 2 | 3 | 3 | 30 |  | [.src/Utils/Monip.module](.src/Utils/Monip.module/test.md) |
| 438 | Epurfour | 2 | 2 | 3 | 3 | 12 |  | [.src/Utils/Epurfour.class](.src/Utils/Epurfour.class/test.md) |
| 439 | Enrgcp | 2 | 2 | 3 | 3 | 7 |  | [.src/Utils/Enrgcp.module](.src/Utils/Enrgcp.module/test.md) |
| 440 | TriMo | 1 | 1 | 8 | 2 | 48 |  | [.src/Affichages/TriMo.class](.src/Affichages/TriMo.class/test.md) |
| 441 | Visualiseur | 2 | 2 | 2 | 2 | 8 |  | [.src/Utils/Visualiseur.module](.src/Utils/Visualiseur.module/test.md) |
| 442 | ChxImp | 1 | 1 | 6 | 5 | 20 |  | [.src/Reports/ChxImp.class](.src/Reports/ChxImp.class/test.md) |
| 443 | Cecheancier | 1 | 1 | 6 | 1 | 39 |  | [.src/Reports/Cecheancier.class](.src/Reports/Cecheancier.class/test.md) |
| 444 | Site | 2 | 2 | 1 | 1 | 9 |  | [.src/Gestion/Site.module](.src/Gestion/Site.module/test.md) |
| 445 | Comptabilite | 2 | 2 | 0 | 0 | 6 |  | [.src/Compta/Utils/Comptabilite.module](.src/Compta/Utils/Comptabilite.module/test.md) |
| 446 | Recalcsolde | 1 | 1 | 5 | 5 | 48 |  | [.src/Compta/Utils/Recalcsolde.module](.src/Compta/Utils/Recalcsolde.module/test.md) |
| 447 | RazEcr | 1 | 1 | 4 | 1 | 11 |  | [.src/Compta/Utils/RazEcr.class](.src/Compta/Utils/RazEcr.class/test.md) |
| 448 | Ctraites | 1 | 1 | 3 | 1 | 19 |  | [.src/Reports/Ctraites.class](.src/Reports/Ctraites.class/test.md) |
| 449 | RenAN | 1 | 1 | 3 | 3 | 12 |  | [.src/Compta/Utils/RenAN.class](.src/Compta/Utils/RenAN.class/test.md) |
| 450 | CheckProg | 1 | 1 | 2 | 2 | 13 |  | [.src/Utils/CheckProg.module](.src/Utils/CheckProg.module/test.md) |
| 451 | Tchauffeur | 1 | 1 | 2 | 1 | 6 |  | [.src/Gestion/option/Tchauffeur.class](.src/Gestion/option/Tchauffeur.class/test.md) |
| 452 | Dymo | 1 | 1 | 1 | 1 | 19 |  | [.src/Gestion/Etiquettes/Dymo.module](.src/Gestion/Etiquettes/Dymo.module/test.md) |
| 453 | Condition | 1 | 1 | 0 | 0 | 4 |  | [.src/Utils/Condition.class](.src/Utils/Condition.class/test.md) |
| 454 | Cmoprod | 1 | 1 | 0 | 0 | 6 |  | [.src/Utils/Cmoprod.class](.src/Utils/Cmoprod.class/test.md) |
<!-- /AUTO:tests -->
