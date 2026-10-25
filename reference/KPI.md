# KPI du projet Laurux — tableau de bord du rework

> Généré par `reference/tools/kpi_report.py` le 2026-10-25 au commit `6a223c11`. Référence initiale : `6b6b9dfc` (`reference/data/kpi_initial.json`).
> **Ne pas éditer à la main** : relancer `python3 reference/tools/kpi_report.py` après chaque rework_id (phase 4), dans le même commit que le code et le `rework.md` coché.

Définitions des KPI : [tools/README.md](tools/README.md). LOC = lignes non vides hors commentaires ; CC = complexité cyclomatique ; globales = `Public` non-`Const` d'un `.module` ou `Static Public` d'une classe. Couverture (`gbx3 -t`) et durée des tests (`gbx3 -p`) : alimentées en phase 2 par `reference/data/coverage.json` (absent : n/a).

## Avancement

| Élément | Fait | Total | % |
|---|---|---|---|
| Fichiers source documentés | 457 | 457 | 100 % |
| Étapes de rework (`<ID>-NNN`) | 0 | 2673 | 0 % |
| Anomalies traitées (`<ID>-Annn`, validation utilisateur) | 0 | 1800 | 0 % |
| Tests au vert | 0 | 3086 | 0 % |
| Tests implémentés (pas encore verts) | 0 | 3086 | 0 % |
| Tests bloqués | 1 | 3086 | 0 % |

## KPI globaux

| KPI | Initial | Actuel | Évolution |
|---|---|---|---|
| Lignes de code (hors commentaires) | 168 255 | 168 255 | = |
| Lignes de commentaire | 13 532 | 13 532 | = |
| Fonctions | 9 095 | 9 095 | = |
| Fonctions Public | 8 420 | 8 420 | = |
| Complexité cyclomatique totale | 42 851 | 42 851 | = |
| Complexité max (fonction) | 550 | 550 | = |
| Variables globales | 120 | 120 | = |
| Variables Public | 546 | 546 | = |
| Fichiers source | 457 | 457 | = |
| Couverture des tests (`gbx3 -t`, moyenne) | n/a | n/a | |
| Durée des tests (`gbx3 -p`, somme) | n/a | n/a | |

## Par lot

Valeurs « initial → actuel (Δ) » ; une seule valeur si inchangée.

| Lot | Fichiers | LOC | CC totale | CC max | Globales | Fonc. Public | Reworks | Anomalies | Tests verts | Couverture |
|---|---|---|---|---|---|---|---|---|---|---|
| Utils | 92 | 13 735 | 3 812 | 122 | 60 | 665 | 0/408 | 0/242 | 0/503 | n/a |
| Communs | 22 | 10 460 | 3 902 | 550 | 0 | 611 | 0/134 | 0/112 | 0/164 | n/a |
| Start / Serveur | 2 | 706 | 258 | 90 | 51 | 14 | 0/21 | 0/11 | 0/25 | n/a |
| Compta | 83 | 31 208 | 6 975 | 335 | 6 | 1 428 | 0/540 | 0/370 | 0/609 | n/a |
| Gestion (sous-lot 1) | 54 | 40 196 | 10 417 | 166 | 1 | 1 968 | 0/393 | 0/292 | 0/413 | n/a |
| Gestion (sous-lot 2) | 108 | 35 052 | 8 108 | 186 | 2 | 1 696 | 0/603 | 0/429 | 0/769 | n/a |
| Caisse | 28 | 14 213 | 4 044 | 196 | 0 | 608 | 0/172 | 0/131 | 0/188 | n/a |
| Statistiques | 19 | 5 526 | 1 254 | 141 | 0 | 242 | 0/127 | 0/82 | 0/132 | n/a |
| Affichages | 16 | 5 724 | 1 642 | 29 | 0 | 436 | 0/104 | 0/51 | 0/94 | n/a |
| Archivages | 8 | 1 979 | 526 | 46 | 0 | 130 | 0/47 | 0/41 | 0/59 | n/a |
| Reports | 24 | 9 413 | 1 906 | 112 | 0 | 618 | 0/121 | 0/39 | 0/127 | n/a |
| Tests | 1 | 43 | 7 | 2 | 0 | 4 | 0/3 | 0/0 | 0/3 | n/a |
| **Total** | **457** | **168 255** | **42 851** | **550** | **120** | **8 420** | **0/2673** | **0/1800** | **0/3086** | **n/a** |

## Points chauds

Les 20 fonctions les plus complexes (CC max par fichier), à surveiller pendant le rework.

| Fichier | Fonction | CC initiale | CC actuelle | LOC du fichier | Reworks |
|---|---|---|---|---|---|
| [Communs/LauruxMaj.module](.src/Communs/LauruxMaj.module/rework.md) | `Maj369` | 550 | 550 | 5 100 | 0/1 |
| [Compta/Impressions/Imp_Bilan.module](.src/Compta/Impressions/Imp_Bilan.module/rework.md) | `Lancement` | 335 | 335 | 767 | 0/11 |
| [Caisse/Moulinage.class](.src/Caisse/Moulinage.class/rework.md) | `Livre_caisse` | 196 | 196 | 2 430 | 0/17 |
| [Communs/Prefs.class](.src/Communs/Prefs.class/rework.md) | `Form_Open` | 186 | 186 | 1 121 | 0/14 |
| [Gestion/Stock/Tarifs/Impart.class](.src/Gestion/Stock/Tarifs/Impart.class/rework.md) | `Import` | 186 | 186 | 1 647 | 0/8 |
| [Gestion/Facturation/Facture.class](.src/Gestion/Facturation/Facture.class/rework.md) | `Coldetail_KeyRelease` | 166 | 166 | 10 446 | 0/24 |
| [Statistiques/Histocliart.class](.src/Statistiques/Histocliart.class/rework.md) | `crearequ` | 141 | 141 | 836 | 0/8 |
| [Compta/Impressions/RubImp.class](.src/Compta/Impressions/RubImp.class/rework.md) | `Button2_Click` | 135 | 135 | 983 | 0/10 |
| [Utils/Cbase.module](.src/Utils/Cbase.module/rework.md) | `Table` | 122 | 122 | 248 | 0/4 |
| [Gestion/Facturation/Facturergbl.class](.src/Gestion/Facturation/Facturergbl.class/rework.md) | `Button14_Click` | 121 | 121 | 1 232 | 0/5 |
| [Reports/Editfac.class](.src/Reports/Editfac.class/rework.md) | `_new` | 112 | 112 | 476 | 0/9 |
| [Utils/Crupt.module](.src/Utils/Crupt.module/rework.md) | `Rupture` | 106 | 106 | 319 | 0/7 |
| [Compta/Utils/ExportJdv.class](.src/Compta/Utils/ExportJdv.class/rework.md) | `Button2_Click` | 103 | 103 | 839 | 0/10 |
| [Gestion/Tables/Articles.class](.src/Gestion/Tables/Articles.class/rework.md) | `Maj_Zones` | 96 | 96 | 3 775 | 0/18 |
| [Serveur.module](.src/Serveur.module/rework.md) | `Pass` | 90 | 90 | 295 | 0/8 |
| [Compta/Tresor.class](.src/Compta/Tresor.class/rework.md) | `Cmpt_KeyPress` | 82 | 82 | 2 185 | 0/17 |
| [Compta/Utils/Dup.class](.src/Compta/Utils/Dup.class/rework.md) | `Button1_Click` | 82 | 82 | 230 | 0/5 |
| [Caisse/Caisse.class](.src/Caisse/Caisse.class/rework.md) | `Art_man` | 77 | 77 | 7 303 | 0/18 |
| [Utils/Utils.module](.src/Utils/Utils.module/rework.md) | `Calcech` | 77 | 77 | 1 311 | 0/16 |
| [Gestion/Stockmvt.class](.src/Gestion/Stockmvt.class/rework.md) | `Buttrait_Click` | 75 | 75 | 843 | 0/8 |

## Détail par fichier

Un tableau par lot (déplier). Colonnes : LOC, CC totale, CC max, globales et fonctions `Public` (initial → actuel), avancement des reworks et anomalies, tests verts / total, couverture, durée.

<details><summary><b>Utils</b> — 92 fichiers</summary>

| Fichier | LOC | CC tot. | CC max | Glob. | Fonc. Public | Reworks | Anomalies | Tests | Couv. | Durée |
|---|---|---|---|---|---|---|---|---|---|---|
| [Utils/AffRdv.module](.src/Utils/AffRdv.module/rework.md) | 18 | 5 | 4 | 0 | 2 | 0/3 | 0/1 | 0/2 | n/a | n/a |
| [Utils/Agenda.class](.src/Utils/Agenda.class/rework.md) | 116 | 23 | 5 | 0 | 15 | 0/6 | 0/4 | 0/4 | n/a | n/a |
| [Utils/CFormat.class](.src/Utils/CFormat.class/rework.md) | 123 | 48 | 18 | 0 | 3 | 0/4 | 0/3 | 0/7 | n/a | n/a |
| [Utils/CPrix.module](.src/Utils/CPrix.module/rework.md) | 15 | 5 | 3 | 0 | 2 | 0/2 | 0/0 | 0/2 | n/a | n/a |
| [Utils/CTestTVA.class](.src/Utils/CTestTVA.class/rework.md) | 29 | 7 | 6 | 0 | 2 | 0/4 | 0/3 | 0/5 | n/a | n/a |
| [Utils/Calc.class](.src/Utils/Calc.class/rework.md) | 213 | 76 | 14 | 1 | 32 | 0/0 | 0/1 | 0/1 | n/a | n/a |
| [Utils/CalcRem.class](.src/Utils/CalcRem.class/rework.md) | 39 | 12 | 7 | 0 | 4 | 0/2 | 0/3 | 0/4 | n/a | n/a |
| [Utils/Calcsolde.class](.src/Utils/Calcsolde.class/rework.md) | 70 | 20 | 8 | 0 | 5 | 0/5 | 0/2 | 0/7 | n/a | n/a |
| [Utils/Calcstock.class](.src/Utils/Calcstock.class/rework.md) | 133 | 31 | 15 | 0 | 9 | 0/5 | 0/2 | 0/8 | n/a | n/a |
| [Utils/Carch.class](.src/Utils/Carch.class/rework.md) | 55 | 13 | 3 | 0 | 5 | 0/1 | 0/2 | 0/2 | n/a | n/a |
| [Utils/Cbase.module](.src/Utils/Cbase.module/rework.md) | 248 | 122 | 122 | 0 | 1 | 0/4 | 0/2 | 0/4 | n/a | n/a |
| [Utils/Cdoc.class](.src/Utils/Cdoc.class/rework.md) | 103 | 26 | 6 | 0 | 6 | 0/1 | 0/1 | 0/1 | n/a | n/a |
| [Utils/Changefam.class](.src/Utils/Changefam.class/rework.md) | 548 | 106 | 14 | 0 | 28 | 0/9 | 0/6 | 0/12 | n/a | n/a |
| [Utils/Changefour.class](.src/Utils/Changefour.class/rework.md) | 411 | 90 | 12 | 0 | 20 | 0/8 | 0/5 | 0/8 | n/a | n/a |
| [Utils/CheckProg.module](.src/Utils/CheckProg.module/rework.md) | 13 | 2 | 2 | 0 | 1 | 0/3 | 0/0 | 0/1 | n/a | n/a |
| [Utils/Cmo.class](.src/Utils/Cmo.class/rework.md) | 55 | 13 | 3 | 0 | 5 | 0/1 | 0/1 | 0/2 | n/a | n/a |
| [Utils/Cmoprod.class](.src/Utils/Cmoprod.class/rework.md) | 6 | 0 | 0 | 0 | 0 | 0/1 | 0/0 | 0/1 | n/a | n/a |
| [Utils/CompArt.class](.src/Utils/CompArt.class/rework.md) | 53 | 14 | 10 | 0 | 4 | 0/3 | 0/1 | 0/3 | n/a | n/a |
| [Utils/Condition.class](.src/Utils/Condition.class/rework.md) | 4 | 0 | 0 | 0 | 0 | 0/2 | 0/0 | 0/1 | n/a | n/a |
| [Utils/Conditions.class](.src/Utils/Conditions.class/rework.md) | 79 | 21 | 13 | 0 | 4 | 0/3 | 0/1 | 0/4 | n/a | n/a |
| [Utils/Copie.module](.src/Utils/Copie.module/rework.md) | 17 | 5 | 5 | 2 | 1 | 0/3 | 0/3 | 0/3 | n/a | n/a |
| [Utils/Cprod.class](.src/Utils/Cprod.class/rework.md) | 86 | 20 | 6 | 0 | 5 | 0/1 | 0/2 | 0/2 | n/a | n/a |
| [Utils/Crupt.module](.src/Utils/Crupt.module/rework.md) | 319 | 106 | 106 | 0 | 1 | 0/7 | 0/6 | 0/9 | n/a | n/a |
| [Utils/Csolde.module](.src/Utils/Csolde.module/rework.md) | 53 | 6 | 3 | 0 | 2 | 0/4 | 0/0 | 0/4 | n/a | n/a |
| [Utils/Cstock.module](.src/Utils/Cstock.module/rework.md) | 108 | 16 | 13 | 0 | 2 | 0/7 | 0/5 | 0/12 | n/a | n/a |
| [Utils/DB_Connection.class](.src/Utils/DB_Connection.class/rework.md) | 561 | 162 | 42 | 0 | 34 | 0/13 | 0/11 | 0/16 | n/a | n/a |
| [Utils/DB_Desktop.class](.src/Utils/DB_Desktop.class/rework.md) | 31 | 7 | 3 | 0 | 2 | 0/4 | 0/3 | 0/4 | n/a | n/a |
| [Utils/DB_Log.class](.src/Utils/DB_Log.class/rework.md) | 224 | 42 | 9 | 0 | 15 | 0/7 | 0/3 | 0/7 | n/a | n/a |
| [Utils/DB_Sanity.class](.src/Utils/DB_Sanity.class/rework.md) | 575 | 171 | 50 | 0 | 17 | 0/7 | 0/6 | 0/9 | n/a | n/a |
| [Utils/DataButtonList.class](.src/Utils/DataButtonList.class/rework.md) | 247 | 71 | 13 | 0 | 13 | 0/1 | 0/0 | 0/1 | n/a | n/a |
| [Utils/Dcfour.class](.src/Utils/Dcfour.class/rework.md) | 60 | 16 | 14 | 0 | 3 | 0/3 | 0/3 | 0/3 | n/a | n/a |
| [Utils/Enrgcp.module](.src/Utils/Enrgcp.module/rework.md) | 7 | 3 | 3 | 0 | 1 | 0/2 | 0/0 | 0/2 | n/a | n/a |
| [Utils/Epurfour.class](.src/Utils/Epurfour.class/rework.md) | 12 | 3 | 3 | 0 | 1 | 0/3 | 0/1 | 0/2 | n/a | n/a |
| [Utils/Exports-Imports/Expart.class](.src/Utils/Exports-Imports/Expart.class/rework.md) | 79 | 12 | 8 | 0 | 4 | 0/5 | 0/3 | 0/5 | n/a | n/a |
| [Utils/Exports-Imports/Expbase.class](.src/Utils/Exports-Imports/Expbase.class/rework.md) | 42 | 14 | 10 | 0 | 4 | 0/4 | 0/1 | 0/3 | n/a | n/a |
| [Utils/Exports-Imports/Expclient.class](.src/Utils/Exports-Imports/Expclient.class/rework.md) | 59 | 9 | 5 | 0 | 4 | 0/5 | 0/2 | 0/3 | n/a | n/a |
| [Utils/Exports-Imports/Expcontact.class](.src/Utils/Exports-Imports/Expcontact.class/rework.md) | 117 | 14 | 9 | 0 | 4 | 0/6 | 0/4 | 0/4 | n/a | n/a |
| [Utils/Exports-Imports/Impclient.class](.src/Utils/Exports-Imports/Impclient.class/rework.md) | 125 | 50 | 40 | 0 | 5 | 0/8 | 0/4 | 0/6 | n/a | n/a |
| [Utils/Exports-Imports/Impcpostaux.class](.src/Utils/Exports-Imports/Impcpostaux.class/rework.md) | 54 | 14 | 10 | 0 | 5 | 0/6 | 0/3 | 0/4 | n/a | n/a |
| [Utils/Exports-Imports/ImportStk.class](.src/Utils/Exports-Imports/ImportStk.class/rework.md) | 55 | 14 | 10 | 0 | 4 | 0/4 | 0/3 | 0/4 | n/a | n/a |
| [Utils/Exports-Imports/ImptartypeC.class](.src/Utils/Exports-Imports/ImptartypeC.class/rework.md) | 52 | 14 | 6 | 0 | 4 | 0/5 | 0/3 | 0/4 | n/a | n/a |
| [Utils/FCalc.class](.src/Utils/FCalc.class/rework.md) | 124 | 39 | 20 | 1 | 10 | 0/5 | 0/2 | 0/7 | n/a | n/a |
| [Utils/FSetFormat.class](.src/Utils/FSetFormat.class/rework.md) | 57 | 16 | 4 | 0 | 8 | 0/5 | 0/4 | 0/5 | n/a | n/a |
| [Utils/GedR.class](.src/Utils/GedR.class/rework.md) | 387 | 88 | 20 | 0 | 20 | 0/9 | 0/5 | 0/8 | n/a | n/a |
| [Utils/HistoCom.class](.src/Utils/HistoCom.class/rework.md) | 11 | 4 | 4 | 0 | 1 | 0/2 | 0/1 | 0/2 | n/a | n/a |
| [Utils/Impression.module](.src/Utils/Impression.module/rework.md) | 44 | 11 | 7 | 0 | 2 | 0/3 | 0/3 | 0/3 | n/a | n/a |
| [Utils/LBox.class](.src/Utils/LBox.class/rework.md) | 181 | 46 | 11 | 0 | 9 | 0/4 | 0/1 | 0/6 | n/a | n/a |
| [Utils/LCoul.class](.src/Utils/LCoul.class/rework.md) | 92 | 9 | 5 | 0 | 4 | 0/5 | 0/3 | 0/4 | n/a | n/a |
| [Utils/LDate.class](.src/Utils/LDate.class/rework.md) | 489 | 119 | 20 | 0 | 13 | 0/9 | 0/8 | 0/14 | n/a | n/a |
| [Utils/LDateC.class](.src/Utils/LDateC.class/rework.md) | 30 | 7 | 3 | 0 | 4 | 0/3 | 0/1 | 0/3 | n/a | n/a |
| [Utils/LGed.class](.src/Utils/LGed.class/rework.md) | 756 | 215 | 29 | 0 | 43 | 0/10 | 0/7 | 0/14 | n/a | n/a |
| [Utils/LLog.class](.src/Utils/LLog.class/rework.md) | 55 | 14 | 6 | 0 | 4 | 0/4 | 0/2 | 0/7 | n/a | n/a |
| [Utils/LPrix.class](.src/Utils/LPrix.class/rework.md) | 518 | 124 | 21 | 0 | 17 | 0/9 | 0/4 | 0/14 | n/a | n/a |
| [Utils/LScript.class](.src/Utils/LScript.class/rework.md) | 88 | 20 | 8 | 0 | 5 | 0/4 | 0/3 | 0/8 | n/a | n/a |
| [Utils/LTaxe.class](.src/Utils/LTaxe.class/rework.md) | 88 | 23 | 5 | 0 | 2 | 0/7 | 0/3 | 0/10 | n/a | n/a |
| [Utils/LTrans.class](.src/Utils/LTrans.class/rework.md) | 22 | 5 | 1 | 0 | 1 | 0/3 | 0/1 | 0/5 | n/a | n/a |
| [Utils/LVar.class](.src/Utils/LVar.class/rework.md) | 61 | 15 | 5 | 0 | 4 | 0/4 | 0/3 | 0/6 | n/a | n/a |
| [Utils/Mmysql.module](.src/Utils/Mmysql.module/rework.md) | 27 | 11 | 7 | 0 | 2 | 0/3 | 0/2 | 0/3 | n/a | n/a |
| [Utils/Monip.module](.src/Utils/Monip.module/rework.md) | 30 | 3 | 3 | 0 | 1 | 0/3 | 0/1 | 0/2 | n/a | n/a |
| [Utils/NetHandler.class](.src/Utils/NetHandler.class/rework.md) | 43 | 16 | 5 | 0 | 5 | 0/2 | 0/2 | 0/6 | n/a | n/a |
| [Utils/Numtostring.module](.src/Utils/Numtostring.module/rework.md) | 144 | 73 | 58 | 0 | 3 | 0/5 | 0/4 | 0/7 | n/a | n/a |
| [Utils/ObjProp.class](.src/Utils/ObjProp.class/rework.md) | 161 | 45 | 9 | 0 | 8 | 0/5 | 0/2 | 0/7 | n/a | n/a |
| [Utils/Papmp.class](.src/Utils/Papmp.class/rework.md) | 18 | 4 | 4 | 0 | 1 | 0/3 | 0/1 | 0/2 | n/a | n/a |
| [Utils/Posnum.module](.src/Utils/Posnum.module/rework.md) | 45 | 21 | 21 | 0 | 1 | 0/1 | 0/0 | 0/1 | n/a | n/a |
| [Utils/ProgBar.class](.src/Utils/ProgBar.class/rework.md) | 73 | 17 | 4 | 0 | 10 | 0/4 | 0/2 | 0/6 | n/a | n/a |
| [Utils/RazArt.class](.src/Utils/RazArt.class/rework.md) | 67 | 18 | 13 | 0 | 5 | 0/5 | 0/5 | 0/7 | n/a | n/a |
| [Utils/Recup.module](.src/Utils/Recup.module/rework.md) | 20 | 4 | 3 | 0 | 2 | 0/3 | 0/0 | 0/2 | n/a | n/a |
| [Utils/RecupN.class](.src/Utils/RecupN.class/rework.md) | 23 | 4 | 4 | 0 | 1 | 0/3 | 0/3 | 0/3 | n/a | n/a |
| [Utils/RenumBl.class](.src/Utils/RenumBl.class/rework.md) | 29 | 8 | 8 | 0 | 1 | 0/2 | 0/3 | 0/3 | n/a | n/a |
| [Utils/ReplayObserver.class](.src/Utils/ReplayObserver.class/rework.md) | 261 | 86 | 26 | 0 | 15 | 0/6 | 0/6 | 0/7 | n/a | n/a |
| [Utils/RichDataGrid.class](.src/Utils/RichDataGrid.class/rework.md) | 225 | 73 | 24 | 0 | 10 | 0/4 | 0/4 | 0/7 | n/a | n/a |
| [Utils/SaiTableau.class](.src/Utils/SaiTableau.class/rework.md) | 284 | 67 | 9 | 0 | 15 | 0/5 | 0/3 | 0/8 | n/a | n/a |
| [Utils/Sailig.class](.src/Utils/Sailig.class/rework.md) | 200 | 68 | 27 | 0 | 5 | 0/5 | 0/2 | 0/5 | n/a | n/a |
| [Utils/SetColors.class](.src/Utils/SetColors.class/rework.md) | 88 | 33 | 9 | 0 | 11 | 0/5 | 0/2 | 0/6 | n/a | n/a |
| [Utils/Sha1Calc.module](.src/Utils/Sha1Calc.module/rework.md) | 115 | 31 | 15 | 0 | 4 | 0/5 | 0/2 | 0/9 | n/a | n/a |
| [Utils/Syntheses.module](.src/Utils/Syntheses.module/rework.md) | 12 | 4 | 4 | 0 | 1 | 0/2 | 0/1 | 0/2 | n/a | n/a |
| [Utils/TarArt.class](.src/Utils/TarArt.class/rework.md) | 148 | 37 | 32 | 0 | 4 | 0/6 | 0/4 | 0/12 | n/a | n/a |
| [Utils/TextReg.class](.src/Utils/TextReg.class/rework.md) | 536 | 177 | 31 | 0 | 15 | 0/10 | 0/4 | 0/10 | n/a | n/a |
| [Utils/Trifam.class](.src/Utils/Trifam.class/rework.md) | 131 | 37 | 18 | 0 | 2 | 0/5 | 0/3 | 0/8 | n/a | n/a |
| [Utils/Utils.module](.src/Utils/Utils.module/rework.md) | 1 311 | 473 | 77 | 16 | 76 | 0/16 | 0/12 | 0/26 | n/a | n/a |
| [Utils/Variables.module](.src/Utils/Variables.module/rework.md) | 42 | 0 | 0 | 40 | 0 | 0/5 | 0/2 | 0/7 | n/a | n/a |
| [Utils/VerifDate.class](.src/Utils/VerifDate.class/rework.md) | 117 | 41 | 10 | 0 | 8 | 0/6 | 0/3 | 0/9 | n/a | n/a |
| [Utils/VerifNumfac.module](.src/Utils/VerifNumfac.module/rework.md) | 86 | 26 | 26 | 0 | 1 | 0/2 | 0/1 | 0/2 | n/a | n/a |
| [Utils/VisPmp.class](.src/Utils/VisPmp.class/rework.md) | 38 | 7 | 5 | 0 | 3 | 0/3 | 0/1 | 0/2 | n/a | n/a |
| [Utils/Visualiseur.module](.src/Utils/Visualiseur.module/rework.md) | 8 | 2 | 2 | 0 | 1 | 0/2 | 0/1 | 0/2 | n/a | n/a |
| [Utils/chainage.class](.src/Utils/chainage.class/rework.md) | 76 | 31 | 13 | 0 | 8 | 0/4 | 0/4 | 0/7 | n/a | n/a |
| [Utils/gridv.module](.src/Utils/gridv.module/rework.md) | 56 | 10 | 10 | 0 | 1 | 0/1 | 0/0 | 0/1 | n/a | n/a |
| [Utils/gridvi.class](.src/Utils/gridvi.class/rework.md) | 493 | 80 | 25 | 0 | 5 | 0/9 | 0/4 | 0/10 | n/a | n/a |
| [Utils/gridvi2.class](.src/Utils/gridvi2.class/rework.md) | 387 | 92 | 20 | 0 | 5 | 0/1 | 0/0 | 0/1 | n/a | n/a |
| [Utils/hexdblKey.module](.src/Utils/hexdblKey.module/rework.md) | 38 | 11 | 4 | 0 | 1 | 0/3 | 0/1 | 0/4 | n/a | n/a |
| [Utils/modCrBcode.module](.src/Utils/modCrBcode.module/rework.md) | 79 | 17 | 17 | 0 | 1 | 0/1 | 0/0 | 0/1 | n/a | n/a |
| [Utils/textfamille.class](.src/Utils/textfamille.class/rework.md) | 107 | 27 | 7 | 0 | 7 | 0/5 | 0/2 | 0/6 | n/a | n/a |

</details>

<details><summary><b>Communs</b> — 22 fichiers</summary>

| Fichier | LOC | CC tot. | CC max | Glob. | Fonc. Public | Reworks | Anomalies | Tests | Couv. | Durée |
|---|---|---|---|---|---|---|---|---|---|---|
| [Communs/Deblockbl.class](.src/Communs/Deblockbl.class/rework.md) | 21 | 5 | 3 | 0 | 3 | 0/3 | 0/2 | 0/3 | n/a | n/a |
| [Communs/Doc.module](.src/Communs/Doc.module/rework.md) | 8 | 2 | 2 | 0 | 1 | 0/4 | 0/2 | 0/5 | n/a | n/a |
| [Communs/DocActif.class](.src/Communs/DocActif.class/rework.md) | 149 | 37 | 13 | 0 | 9 | 0/6 | 0/4 | 0/12 | n/a | n/a |
| [Communs/FAbout.class](.src/Communs/FAbout.class/rework.md) | 43 | 9 | 3 | 0 | 5 | 0/2 | 0/1 | 0/2 | n/a | n/a |
| [Communs/FRestore.class](.src/Communs/FRestore.class/rework.md) | 178 | 51 | 30 | 0 | 10 | 0/9 | 0/8 | 0/10 | n/a | n/a |
| [Communs/FSauve.class](.src/Communs/FSauve.class/rework.md) | 88 | 22 | 12 | 0 | 8 | 0/6 | 0/7 | 0/6 | n/a | n/a |
| [Communs/FTips.class](.src/Communs/FTips.class/rework.md) | 87 | 22 | 8 | 0 | 9 | 0/4 | 0/2 | 0/5 | n/a | n/a |
| [Communs/Fblocsoc.class](.src/Communs/Fblocsoc.class/rework.md) | 18 | 10 | 4 | 0 | 3 | 0/2 | 0/3 | 0/4 | n/a | n/a |
| [Communs/Fmenu.class](.src/Communs/Fmenu.class/rework.md) | 1 579 | 510 | 54 | 0 | 296 | 0/15 | 0/16 | 0/20 | n/a | n/a |
| [Communs/Fprepdus.class](.src/Communs/Fprepdus.class/rework.md) | 72 | 20 | 8 | 0 | 4 | 0/5 | 0/2 | 0/5 | n/a | n/a |
| [Communs/Fsoc.class](.src/Communs/Fsoc.class/rework.md) | 488 | 113 | 30 | 0 | 20 | 0/11 | 0/10 | 0/13 | n/a | n/a |
| [Communs/Fsystem.class](.src/Communs/Fsystem.class/rework.md) | 29 | 7 | 6 | 0 | 2 | 0/2 | 0/2 | 0/2 | n/a | n/a |
| [Communs/Fusers.class](.src/Communs/Fusers.class/rework.md) | 75 | 15 | 4 | 0 | 8 | 0/4 | 0/4 | 0/8 | n/a | n/a |
| [Communs/LauruxConf.class](.src/Communs/LauruxConf.class/rework.md) | 384 | 97 | 54 | 0 | 8 | 0/10 | 0/10 | 0/10 | n/a | n/a |
| [Communs/LauruxMaj.module](.src/Communs/LauruxMaj.module/rework.md) | 5 100 | 2 251 | 550 | 0 | 110 | 0/1 | 0/0 | 0/1 | n/a | n/a |
| [Communs/MDP.class](.src/Communs/MDP.class/rework.md) | 33 | 11 | 6 | 0 | 3 | 0/3 | 0/2 | 0/5 | n/a | n/a |
| [Communs/Majversion.class](.src/Communs/Majversion.class/rework.md) | 294 | 70 | 21 | 0 | 12 | 0/8 | 0/7 | 0/7 | n/a | n/a |
| [Communs/Parametre.class](.src/Communs/Parametre.class/rework.md) | 539 | 208 | 62 | 0 | 24 | 0/11 | 0/7 | 0/12 | n/a | n/a |
| [Communs/Prefs.class](.src/Communs/Prefs.class/rework.md) | 1 121 | 374 | 186 | 0 | 67 | 0/14 | 0/11 | 0/17 | n/a | n/a |
| [Communs/Prgm.class](.src/Communs/Prgm.class/rework.md) | 101 | 53 | 38 | 0 | 6 | 0/6 | 0/6 | 0/9 | n/a | n/a |
| [Communs/Raz.class](.src/Communs/Raz.class/rework.md) | 18 | 5 | 4 | 0 | 2 | 0/3 | 0/0 | 0/3 | n/a | n/a |
| [Communs/SauvesAuto.module](.src/Communs/SauvesAuto.module/rework.md) | 35 | 10 | 10 | 0 | 1 | 0/5 | 0/6 | 0/5 | n/a | n/a |

</details>

<details><summary><b>Start / Serveur</b> — 2 fichiers</summary>

| Fichier | LOC | CC tot. | CC max | Glob. | Fonc. Public | Reworks | Anomalies | Tests | Couv. | Durée |
|---|---|---|---|---|---|---|---|---|---|---|
| [Serveur.module](.src/Serveur.module/rework.md) | 295 | 143 | 90 | 0 | 4 | 0/8 | 0/3 | 0/8 | n/a | n/a |
| [Start.module](.src/Start.module/rework.md) | 411 | 115 | 35 | 51 | 10 | 0/13 | 0/8 | 0/17 | n/a | n/a |

</details>

<details><summary><b>Compta</b> — 83 fichiers</summary>

| Fichier | LOC | CC tot. | CC max | Glob. | Fonc. Public | Reworks | Anomalies | Tests | Couv. | Durée |
|---|---|---|---|---|---|---|---|---|---|---|
| [Compta/Analytique.class](.src/Compta/Analytique.class/rework.md) | 181 | 33 | 8 | 0 | 11 | 0/7 | 0/5 | 0/8 | n/a | n/a |
| [Compta/Ccomptes.module](.src/Compta/Ccomptes.module/rework.md) | 97 | 24 | 6 | 0 | 10 | 0/7 | 0/1 | 0/5 | n/a | n/a |
| [Compta/Cecrit.module](.src/Compta/Cecrit.module/rework.md) | 71 | 17 | 8 | 0 | 10 | 0/1 | 0/0 | 0/1 | n/a | n/a |
| [Compta/Cielcorsp.class](.src/Compta/Cielcorsp.class/rework.md) | 199 | 50 | 10 | 0 | 13 | 0/6 | 0/2 | 0/7 | n/a | n/a |
| [Compta/Cielcorspj.class](.src/Compta/Cielcorspj.class/rework.md) | 192 | 47 | 8 | 0 | 13 | 0/5 | 0/1 | 0/6 | n/a | n/a |
| [Compta/Cielimp.class](.src/Compta/Cielimp.class/rework.md) | 520 | 140 | 54 | 0 | 11 | 0/8 | 0/9 | 0/12 | n/a | n/a |
| [Compta/Clotures/FCloture.class](.src/Compta/Clotures/FCloture.class/rework.md) | 116 | 25 | 17 | 0 | 6 | 0/7 | 0/3 | 0/8 | n/a | n/a |
| [Compta/Clotures/FClotureAn.class](.src/Compta/Clotures/FClotureAn.class/rework.md) | 583 | 88 | 74 | 0 | 8 | 0/14 | 0/10 | 0/13 | n/a | n/a |
| [Compta/Echeances.class](.src/Compta/Echeances.class/rework.md) | 220 | 57 | 18 | 0 | 16 | 0/6 | 0/4 | 0/8 | n/a | n/a |
| [Compta/Extrait.class](.src/Compta/Extrait.class/rework.md) | 1 127 | 236 | 31 | 0 | 52 | 0/11 | 0/8 | 0/14 | n/a | n/a |
| [Compta/Impressions/Anomalies.class](.src/Compta/Impressions/Anomalies.class/rework.md) | 109 | 20 | 9 | 0 | 6 | 0/5 | 0/3 | 0/5 | n/a | n/a |
| [Compta/Impressions/Balance.class](.src/Compta/Impressions/Balance.class/rework.md) | 497 | 102 | 20 | 0 | 33 | 0/8 | 0/5 | 0/10 | n/a | n/a |
| [Compta/Impressions/BalanceM.module](.src/Compta/Impressions/BalanceM.module/rework.md) | 355 | 44 | 30 | 0 | 5 | 0/8 | 0/4 | 0/10 | n/a | n/a |
| [Compta/Impressions/BordereauxC.class](.src/Compta/Impressions/BordereauxC.class/rework.md) | 415 | 82 | 30 | 0 | 13 | 0/9 | 0/9 | 0/11 | n/a | n/a |
| [Compta/Impressions/Echeancier.class](.src/Compta/Impressions/Echeancier.class/rework.md) | 386 | 67 | 28 | 0 | 23 | 0/8 | 0/5 | 0/10 | n/a | n/a |
| [Compta/Impressions/EcrM.class](.src/Compta/Impressions/EcrM.class/rework.md) | 485 | 105 | 34 | 0 | 34 | 0/10 | 0/6 | 0/13 | n/a | n/a |
| [Compta/Impressions/EdImpayes.class](.src/Compta/Impressions/EdImpayes.class/rework.md) | 314 | 49 | 15 | 0 | 15 | 0/3 | 0/2 | 0/2 | n/a | n/a |
| [Compta/Impressions/EdNjustifiees.class](.src/Compta/Impressions/EdNjustifiees.class/rework.md) | 249 | 47 | 16 | 0 | 14 | 0/6 | 0/2 | 0/8 | n/a | n/a |
| [Compta/Impressions/EdNlettrees.class](.src/Compta/Impressions/EdNlettrees.class/rework.md) | 424 | 63 | 17 | 0 | 27 | 0/7 | 0/3 | 0/11 | n/a | n/a |
| [Compta/Impressions/Editcompte.class](.src/Compta/Impressions/Editcompte.class/rework.md) | 579 | 136 | 56 | 0 | 38 | 0/9 | 0/7 | 0/10 | n/a | n/a |
| [Compta/Impressions/EditcompteA.class](.src/Compta/Impressions/EditcompteA.class/rework.md) | 695 | 114 | 19 | 0 | 35 | 0/7 | 0/4 | 0/8 | n/a | n/a |
| [Compta/Impressions/EditcompteM.module](.src/Compta/Impressions/EditcompteM.module/rework.md) | 316 | 42 | 35 | 0 | 5 | 0/7 | 0/5 | 0/13 | n/a | n/a |
| [Compta/Impressions/ExportA47.class](.src/Compta/Impressions/ExportA47.class/rework.md) | 426 | 95 | 34 | 0 | 33 | 0/9 | 0/9 | 0/14 | n/a | n/a |
| [Compta/Impressions/FTVA.class](.src/Compta/Impressions/FTVA.class/rework.md) | 697 | 133 | 51 | 0 | 16 | 0/13 | 0/6 | 0/13 | n/a | n/a |
| [Compta/Impressions/Imp_Bilan.module](.src/Compta/Impressions/Imp_Bilan.module/rework.md) | 767 | 336 | 335 | 0 | 2 | 0/11 | 0/9 | 0/10 | n/a | n/a |
| [Compta/Impressions/Imp_Sig.module](.src/Compta/Impressions/Imp_Sig.module/rework.md) | 403 | 61 | 60 | 0 | 2 | 0/8 | 0/6 | 0/7 | n/a | n/a |
| [Compta/Impressions/Jourcent.class](.src/Compta/Impressions/Jourcent.class/rework.md) | 780 | 137 | 22 | 0 | 44 | 0/7 | 0/4 | 0/10 | n/a | n/a |
| [Compta/Impressions/Journaux.class](.src/Compta/Impressions/Journaux.class/rework.md) | 621 | 129 | 22 | 0 | 45 | 0/9 | 0/7 | 0/10 | n/a | n/a |
| [Compta/Impressions/JournauxA.class](.src/Compta/Impressions/JournauxA.class/rework.md) | 664 | 128 | 24 | 0 | 40 | 0/7 | 0/6 | 0/8 | n/a | n/a |
| [Compta/Impressions/JournauxM.module](.src/Compta/Impressions/JournauxM.module/rework.md) | 338 | 62 | 55 | 0 | 4 | 0/10 | 0/4 | 0/12 | n/a | n/a |
| [Compta/Impressions/Plancomptable.class](.src/Compta/Impressions/Plancomptable.class/rework.md) | 155 | 42 | 8 | 0 | 16 | 0/4 | 0/2 | 0/4 | n/a | n/a |
| [Compta/Impressions/RubImp.class](.src/Compta/Impressions/RubImp.class/rework.md) | 983 | 198 | 135 | 0 | 29 | 0/10 | 0/7 | 0/10 | n/a | n/a |
| [Compta/Impressions/journauxSetting.class](.src/Compta/Impressions/journauxSetting.class/rework.md) | 123 | 35 | 16 | 0 | 10 | 0/6 | 0/2 | 0/6 | n/a | n/a |
| [Compta/Lettrages/Lettrage.class](.src/Compta/Lettrages/Lettrage.class/rework.md) | 447 | 104 | 20 | 0 | 27 | 0/8 | 0/5 | 0/7 | n/a | n/a |
| [Compta/Lettrages/Lettragemontant.class](.src/Compta/Lettrages/Lettragemontant.class/rework.md) | 104 | 23 | 16 | 0 | 5 | 0/6 | 0/4 | 0/5 | n/a | n/a |
| [Compta/Lettrages/Lettragesoldes.class](.src/Compta/Lettrages/Lettragesoldes.class/rework.md) | 68 | 14 | 7 | 0 | 5 | 0/6 | 0/4 | 0/4 | n/a | n/a |
| [Compta/Lettrages/Visimpayes.class](.src/Compta/Lettrages/Visimpayes.class/rework.md) | 157 | 18 | 7 | 0 | 6 | 0/1 | 0/3 | 0/1 | n/a | n/a |
| [Compta/Pointage.class](.src/Compta/Pointage.class/rework.md) | 646 | 126 | 23 | 0 | 33 | 0/11 | 0/7 | 0/13 | n/a | n/a |
| [Compta/Relances/FEditrel.class](.src/Compta/Relances/FEditrel.class/rework.md) | 497 | 102 | 25 | 0 | 16 | 0/9 | 0/4 | 0/7 | n/a | n/a |
| [Compta/Relances/FPrepRel2.class](.src/Compta/Relances/FPrepRel2.class/rework.md) | 346 | 67 | 10 | 0 | 21 | 0/1 | 0/1 | 0/1 | n/a | n/a |
| [Compta/Relances/FRelCompte.class](.src/Compta/Relances/FRelCompte.class/rework.md) | 365 | 76 | 23 | 0 | 18 | 0/8 | 0/3 | 0/6 | n/a | n/a |
| [Compta/Relances/FRelFacture.class](.src/Compta/Relances/FRelFacture.class/rework.md) | 425 | 89 | 24 | 0 | 19 | 0/6 | 0/3 | 0/6 | n/a | n/a |
| [Compta/Relances/FRelance.class](.src/Compta/Relances/FRelance.class/rework.md) | 74 | 18 | 4 | 0 | 9 | 0/3 | 0/3 | 0/5 | n/a | n/a |
| [Compta/Relances/Ligcli.class](.src/Compta/Relances/Ligcli.class/rework.md) | 333 | 59 | 25 | 0 | 8 | 0/7 | 0/5 | 0/7 | n/a | n/a |
| [Compta/Relances/Ligext.class](.src/Compta/Relances/Ligext.class/rework.md) | 61 | 9 | 3 | 0 | 2 | 0/3 | 0/2 | 0/3 | n/a | n/a |
| [Compta/Saisecrit.class](.src/Compta/Saisecrit.class/rework.md) | 2 528 | 654 | 72 | 0 | 101 | 0/15 | 0/9 | 0/17 | n/a | n/a |
| [Compta/Tables/Abont.class](.src/Compta/Tables/Abont.class/rework.md) | 438 | 125 | 16 | 0 | 27 | 0/6 | 0/6 | 0/7 | n/a | n/a |
| [Compta/Tables/FCollectif.class](.src/Compta/Tables/FCollectif.class/rework.md) | 172 | 43 | 10 | 0 | 13 | 0/4 | 0/4 | 0/5 | n/a | n/a |
| [Compta/Tables/FComptes.class](.src/Compta/Tables/FComptes.class/rework.md) | 919 | 271 | 48 | 0 | 60 | 0/10 | 0/7 | 0/11 | n/a | n/a |
| [Compta/Tables/FJournaux.class](.src/Compta/Tables/FJournaux.class/rework.md) | 275 | 71 | 13 | 0 | 17 | 0/6 | 0/4 | 0/5 | n/a | n/a |
| [Compta/Tables/FLibelle.class](.src/Compta/Tables/FLibelle.class/rework.md) | 134 | 35 | 10 | 0 | 15 | 0/5 | 0/1 | 0/3 | n/a | n/a |
| [Compta/Tables/FPostes.class](.src/Compta/Tables/FPostes.class/rework.md) | 117 | 35 | 7 | 0 | 13 | 0/3 | 0/2 | 0/4 | n/a | n/a |
| [Compta/Tables/FTvac.class](.src/Compta/Tables/FTvac.class/rework.md) | 262 | 67 | 16 | 0 | 23 | 0/7 | 0/5 | 0/5 | n/a | n/a |
| [Compta/Tables/FTvav.class](.src/Compta/Tables/FTvav.class/rework.md) | 413 | 106 | 25 | 0 | 22 | 0/8 | 0/5 | 0/7 | n/a | n/a |
| [Compta/Trecarts.class](.src/Compta/Trecarts.class/rework.md) | 224 | 50 | 24 | 0 | 9 | 0/7 | 0/6 | 0/8 | n/a | n/a |
| [Compta/Tresor.class](.src/Compta/Tresor.class/rework.md) | 2 185 | 579 | 82 | 0 | 87 | 0/17 | 0/15 | 0/17 | n/a | n/a |
| [Compta/Utils/Comptabilite.module](.src/Compta/Utils/Comptabilite.module/rework.md) | 6 | 0 | 0 | 6 | 0 | 0/2 | 0/1 | 0/2 | n/a | n/a |
| [Compta/Utils/Dup.class](.src/Compta/Utils/Dup.class/rework.md) | 230 | 89 | 82 | 0 | 4 | 0/5 | 0/4 | 0/6 | n/a | n/a |
| [Compta/Utils/EcrAuto.class](.src/Compta/Utils/EcrAuto.class/rework.md) | 601 | 99 | 22 | 0 | 4 | 0/9 | 0/7 | 0/12 | n/a | n/a |
| [Compta/Utils/EcrReg.class](.src/Compta/Utils/EcrReg.class/rework.md) | 135 | 21 | 18 | 0 | 2 | 0/5 | 0/1 | 0/7 | n/a | n/a |
| [Compta/Utils/Ecritures.class](.src/Compta/Utils/Ecritures.class/rework.md) | 374 | 66 | 18 | 0 | 18 | 0/7 | 0/2 | 0/7 | n/a | n/a |
| [Compta/Utils/Epurjdv.class](.src/Compta/Utils/Epurjdv.class/rework.md) | 172 | 29 | 18 | 0 | 7 | 0/3 | 0/5 | 0/2 | n/a | n/a |
| [Compta/Utils/Equilibrage.class](.src/Compta/Utils/Equilibrage.class/rework.md) | 55 | 11 | 7 | 0 | 3 | 0/3 | 0/3 | 0/3 | n/a | n/a |
| [Compta/Utils/ExportJdv.class](.src/Compta/Utils/ExportJdv.class/rework.md) | 839 | 205 | 103 | 0 | 33 | 0/10 | 0/12 | 0/16 | n/a | n/a |
| [Compta/Utils/Exprub.class](.src/Compta/Utils/Exprub.class/rework.md) | 48 | 9 | 9 | 0 | 1 | 0/5 | 0/2 | 0/5 | n/a | n/a |
| [Compta/Utils/Fmontant.class](.src/Compta/Utils/Fmontant.class/rework.md) | 168 | 58 | 41 | 0 | 10 | 0/5 | 0/5 | 0/7 | n/a | n/a |
| [Compta/Utils/ImpJdv.class](.src/Compta/Utils/ImpJdv.class/rework.md) | 533 | 85 | 17 | 0 | 20 | 0/11 | 0/10 | 0/9 | n/a | n/a |
| [Compta/Utils/ImpSage.class](.src/Compta/Utils/ImpSage.class/rework.md) | 699 | 172 | 50 | 0 | 24 | 0/10 | 0/8 | 0/10 | n/a | n/a |
| [Compta/Utils/Intjdv.class](.src/Compta/Utils/Intjdv.class/rework.md) | 308 | 58 | 11 | 0 | 14 | 0/3 | 0/2 | 0/1 | n/a | n/a |
| [Compta/Utils/Listextcpt.class](.src/Compta/Utils/Listextcpt.class/rework.md) | 297 | 76 | 28 | 0 | 11 | 0/7 | 0/7 | 0/13 | n/a | n/a |
| [Compta/Utils/RazClos.class](.src/Compta/Utils/RazClos.class/rework.md) | 14 | 4 | 1 | 0 | 4 | 0/3 | 0/2 | 0/4 | n/a | n/a |
| [Compta/Utils/RazEcr.class](.src/Compta/Utils/RazEcr.class/rework.md) | 10 | 4 | 1 | 0 | 4 | 0/1 | 0/1 | 0/1 | n/a | n/a |
| [Compta/Utils/Recalcsolde.module](.src/Compta/Utils/Recalcsolde.module/rework.md) | 48 | 5 | 5 | 0 | 1 | 0/1 | 0/0 | 0/1 | n/a | n/a |
| [Compta/Utils/RecupDech.class](.src/Compta/Utils/RecupDech.class/rework.md) | 17 | 5 | 4 | 0 | 2 | 0/2 | 0/2 | 0/4 | n/a | n/a |
| [Compta/Utils/RenAN.class](.src/Compta/Utils/RenAN.class/rework.md) | 12 | 3 | 3 | 0 | 1 | 0/1 | 0/1 | 0/1 | n/a | n/a |
| [Compta/Utils/RenMvt.module](.src/Compta/Utils/RenMvt.module/rework.md) | 48 | 7 | 4 | 0 | 2 | 0/2 | 0/3 | 0/3 | n/a | n/a |
| [Compta/Utils/Renech.class](.src/Compta/Utils/Renech.class/rework.md) | 15 | 3 | 3 | 0 | 1 | 0/2 | 0/2 | 0/3 | n/a | n/a |
| [Compta/Utils/Rubcompt.class](.src/Compta/Utils/Rubcompt.class/rework.md) | 270 | 66 | 14 | 0 | 19 | 0/6 | 0/5 | 0/8 | n/a | n/a |
| [Compta/Utils/Rubresult.class](.src/Compta/Utils/Rubresult.class/rework.md) | 290 | 63 | 21 | 0 | 16 | 0/7 | 0/6 | 0/8 | n/a | n/a |
| [Compta/Utils/TypeClient.class](.src/Compta/Utils/TypeClient.class/rework.md) | 24 | 6 | 3 | 0 | 1 | 0/3 | 0/0 | 0/3 | n/a | n/a |
| [Compta/Utils/VarEcr.class](.src/Compta/Utils/VarEcr.class/rework.md) | 110 | 28 | 4 | 0 | 12 | 0/2 | 0/1 | 0/6 | n/a | n/a |
| [Compta/Utils/Verbal.class](.src/Compta/Utils/Verbal.class/rework.md) | 314 | 57 | 19 | 0 | 12 | 0/7 | 0/4 | 0/7 | n/a | n/a |
| [Compta/Utils/impfec.class](.src/Compta/Utils/impfec.class/rework.md) | 294 | 61 | 25 | 0 | 7 | 0/8 | 0/6 | 0/9 | n/a | n/a |

</details>

<details><summary><b>Gestion (sous-lot 1)</b> — 54 fichiers</summary>

| Fichier | LOC | CC tot. | CC max | Glob. | Fonc. Public | Reworks | Anomalies | Tests | Couv. | Durée |
|---|---|---|---|---|---|---|---|---|---|---|
| [Gestion/ClotureF.class](.src/Gestion/ClotureF.class/rework.md) | 153 | 27 | 8 | 0 | 8 | 0/7 | 0/4 | 0/8 | n/a | n/a |
| [Gestion/Depots/Depots.class](.src/Gestion/Depots/Depots.class/rework.md) | 274 | 74 | 13 | 0 | 31 | 0/6 | 0/3 | 0/5 | n/a | n/a |
| [Gestion/Depots/Edsdepots.class](.src/Gestion/Depots/Edsdepots.class/rework.md) | 253 | 53 | 15 | 0 | 12 | 0/6 | 0/3 | 0/5 | n/a | n/a |
| [Gestion/Depots/ImpDepots.class](.src/Gestion/Depots/ImpDepots.class/rework.md) | 135 | 30 | 11 | 0 | 10 | 0/6 | 0/2 | 0/4 | n/a | n/a |
| [Gestion/Depots/MvtDepots.class](.src/Gestion/Depots/MvtDepots.class/rework.md) | 409 | 103 | 11 | 0 | 26 | 0/5 | 0/5 | 0/6 | n/a | n/a |
| [Gestion/Depots/Sdepots.class](.src/Gestion/Depots/Sdepots.class/rework.md) | 307 | 83 | 13 | 0 | 21 | 0/5 | 0/4 | 0/5 | n/a | n/a |
| [Gestion/Entrées/Achat.class](.src/Gestion/Entrées/Achat.class/rework.md) | 1 463 | 293 | 19 | 0 | 44 | 0/10 | 0/12 | 0/14 | n/a | n/a |
| [Gestion/Entrées/DateTar.class](.src/Gestion/Entrées/DateTar.class/rework.md) | 196 | 55 | 13 | 0 | 12 | 0/6 | 0/6 | 0/8 | n/a | n/a |
| [Gestion/Entrées/GesTar.class](.src/Gestion/Entrées/GesTar.class/rework.md) | 675 | 145 | 14 | 0 | 29 | 0/9 | 0/7 | 0/10 | n/a | n/a |
| [Gestion/Facturation/ConVendeurs.class](.src/Gestion/Facturation/ConVendeurs.class/rework.md) | 97 | 33 | 9 | 0 | 7 | 0/5 | 0/5 | 0/6 | n/a | n/a |
| [Gestion/Facturation/Facture.class](.src/Gestion/Facturation/Facture.class/rework.md) | 10 446 | 3 116 | 166 | 0 | 323 | 0/24 | 0/33 | 0/27 | n/a | n/a |
| [Gestion/Facturation/Facturefm.class](.src/Gestion/Facturation/Facturefm.class/rework.md) | 629 | 139 | 29 | 0 | 29 | 0/7 | 0/3 | 0/11 | n/a | n/a |
| [Gestion/Facturation/FacturefmA.class](.src/Gestion/Facturation/FacturefmA.class/rework.md) | 517 | 109 | 41 | 0 | 26 | 0/7 | 0/5 | 0/8 | n/a | n/a |
| [Gestion/Facturation/Facturergbl.class](.src/Gestion/Facturation/Facturergbl.class/rework.md) | 1 232 | 258 | 121 | 0 | 30 | 0/5 | 0/6 | 0/7 | n/a | n/a |
| [Gestion/Facturation/Fcaras.class](.src/Gestion/Facturation/Fcaras.class/rework.md) | 38 | 12 | 7 | 0 | 4 | 0/3 | 0/0 | 0/2 | n/a | n/a |
| [Gestion/Facturation/ObjFac.class](.src/Gestion/Facturation/ObjFac.class/rework.md) | 893 | 181 | 45 | 0 | 9 | 0/11 | 0/8 | 0/16 | n/a | n/a |
| [Gestion/Facturation/OptFac.class](.src/Gestion/Facturation/OptFac.class/rework.md) | 389 | 91 | 16 | 0 | 43 | 0/6 | 0/5 | 0/10 | n/a | n/a |
| [Gestion/Facturation/SaiReg.class](.src/Gestion/Facturation/SaiReg.class/rework.md) | 913 | 207 | 24 | 0 | 39 | 0/7 | 0/5 | 0/11 | n/a | n/a |
| [Gestion/Reglements/TresorFac.class](.src/Gestion/Reglements/TresorFac.class/rework.md) | 1 081 | 225 | 44 | 0 | 45 | 0/4 | 0/5 | 0/2 | n/a | n/a |
| [Gestion/Reglements/Visreglements.class](.src/Gestion/Reglements/Visreglements.class/rework.md) | 191 | 24 | 8 | 0 | 7 | 0/6 | 0/4 | 0/5 | n/a | n/a |
| [Gestion/Site.module](.src/Gestion/Site.module/rework.md) | 9 | 1 | 1 | 1 | 1 | 0/1 | 0/0 | 0/2 | n/a | n/a |
| [Gestion/Stockmvt.class](.src/Gestion/Stockmvt.class/rework.md) | 843 | 163 | 75 | 0 | 13 | 0/8 | 0/6 | 0/11 | n/a | n/a |
| [Gestion/Suivi.class](.src/Gestion/Suivi.class/rework.md) | 292 | 95 | 14 | 0 | 31 | 0/7 | 0/4 | 0/8 | n/a | n/a |
| [Gestion/SupprArt.class](.src/Gestion/SupprArt.class/rework.md) | 336 | 90 | 18 | 0 | 23 | 0/7 | 0/6 | 0/7 | n/a | n/a |
| [Gestion/Tables/ArtPromo.module](.src/Gestion/Tables/ArtPromo.module/rework.md) | 44 | 16 | 4 | 0 | 6 | 0/5 | 0/2 | 0/6 | n/a | n/a |
| [Gestion/Tables/Articles.class](.src/Gestion/Tables/Articles.class/rework.md) | 3 775 | 1 128 | 96 | 0 | 144 | 0/18 | 0/18 | 0/18 | n/a | n/a |
| [Gestion/Tables/Btqart.class](.src/Gestion/Tables/Btqart.class/rework.md) | 153 | 53 | 17 | 0 | 12 | 0/5 | 0/6 | 0/6 | n/a | n/a |
| [Gestion/Tables/Centrales.class](.src/Gestion/Tables/Centrales.class/rework.md) | 135 | 47 | 6 | 0 | 20 | 0/6 | 0/3 | 0/5 | n/a | n/a |
| [Gestion/Tables/CoefTypeC.class](.src/Gestion/Tables/CoefTypeC.class/rework.md) | 281 | 62 | 10 | 0 | 20 | 0/6 | 0/3 | 0/5 | n/a | n/a |
| [Gestion/Tables/ComMail.class](.src/Gestion/Tables/ComMail.class/rework.md) | 130 | 36 | 7 | 0 | 14 | 0/6 | 0/3 | 0/5 | n/a | n/a |
| [Gestion/Tables/Comment.class](.src/Gestion/Tables/Comment.class/rework.md) | 125 | 34 | 7 | 0 | 14 | 0/7 | 0/3 | 0/5 | n/a | n/a |
| [Gestion/Tables/Commerciaux.class](.src/Gestion/Tables/Commerciaux.class/rework.md) | 145 | 38 | 9 | 0 | 13 | 0/6 | 0/4 | 0/5 | n/a | n/a |
| [Gestion/Tables/ConsultArt.class](.src/Gestion/Tables/ConsultArt.class/rework.md) | 771 | 200 | 37 | 0 | 49 | 0/9 | 0/5 | 0/7 | n/a | n/a |
| [Gestion/Tables/Cpostaux.class](.src/Gestion/Tables/Cpostaux.class/rework.md) | 286 | 70 | 8 | 0 | 34 | 0/7 | 0/3 | 0/6 | n/a | n/a |
| [Gestion/Tables/FClient.class](.src/Gestion/Tables/FClient.class/rework.md) | 2 716 | 675 | 42 | 0 | 155 | 0/16 | 0/16 | 0/18 | n/a | n/a |
| [Gestion/Tables/FFournisseur.class](.src/Gestion/Tables/FFournisseur.class/rework.md) | 2 156 | 545 | 35 | 0 | 131 | 0/16 | 0/12 | 0/16 | n/a | n/a |
| [Gestion/Tables/Famille.class](.src/Gestion/Tables/Famille.class/rework.md) | 761 | 218 | 28 | 0 | 40 | 0/8 | 0/6 | 0/9 | n/a | n/a |
| [Gestion/Tables/Fpromo.class](.src/Gestion/Tables/Fpromo.class/rework.md) | 186 | 43 | 8 | 0 | 18 | 0/6 | 0/2 | 0/5 | n/a | n/a |
| [Gestion/Tables/FpromoArt.class](.src/Gestion/Tables/FpromoArt.class/rework.md) | 377 | 96 | 22 | 0 | 26 | 0/6 | 0/3 | 0/7 | n/a | n/a |
| [Gestion/Tables/Identite.class](.src/Gestion/Tables/Identite.class/rework.md) | 156 | 48 | 6 | 0 | 20 | 0/7 | 0/2 | 0/5 | n/a | n/a |
| [Gestion/Tables/LibelFac.class](.src/Gestion/Tables/LibelFac.class/rework.md) | 35 | 10 | 4 | 0 | 4 | 0/5 | 0/1 | 0/3 | n/a | n/a |
| [Gestion/Tables/Marques.class](.src/Gestion/Tables/Marques.class/rework.md) | 240 | 62 | 8 | 0 | 29 | 0/6 | 0/3 | 0/5 | n/a | n/a |
| [Gestion/Tables/Materiel.class](.src/Gestion/Tables/Materiel.class/rework.md) | 2 054 | 444 | 24 | 0 | 107 | 0/10 | 0/12 | 0/12 | n/a | n/a |
| [Gestion/Tables/Movr.class](.src/Gestion/Tables/Movr.class/rework.md) | 1 271 | 323 | 35 | 0 | 70 | 0/9 | 0/6 | 0/9 | n/a | n/a |
| [Gestion/Tables/Mreglement.class](.src/Gestion/Tables/Mreglement.class/rework.md) | 318 | 77 | 11 | 0 | 23 | 0/6 | 0/4 | 0/9 | n/a | n/a |
| [Gestion/Tables/Prodcomposes.class](.src/Gestion/Tables/Prodcomposes.class/rework.md) | 534 | 130 | 20 | 0 | 34 | 0/7 | 0/8 | 0/8 | n/a | n/a |
| [Gestion/Tables/Remisec.class](.src/Gestion/Tables/Remisec.class/rework.md) | 243 | 53 | 10 | 0 | 18 | 0/5 | 0/4 | 0/5 | n/a | n/a |
| [Gestion/Tables/Remisecli.class](.src/Gestion/Tables/Remisecli.class/rework.md) | 351 | 86 | 12 | 0 | 32 | 0/6 | 0/4 | 0/7 | n/a | n/a |
| [Gestion/Tables/Statut.class](.src/Gestion/Tables/Statut.class/rework.md) | 136 | 47 | 6 | 0 | 20 | 0/6 | 0/2 | 0/4 | n/a | n/a |
| [Gestion/Tables/TarTypeCli.class](.src/Gestion/Tables/TarTypeCli.class/rework.md) | 413 | 93 | 8 | 0 | 29 | 0/7 | 0/5 | 0/8 | n/a | n/a |
| [Gestion/Tables/Tleg.class](.src/Gestion/Tables/Tleg.class/rework.md) | 67 | 23 | 6 | 0 | 11 | 0/5 | 0/3 | 0/4 | n/a | n/a |
| [Gestion/Tables/Tmail.class](.src/Gestion/Tables/Tmail.class/rework.md) | 67 | 26 | 6 | 0 | 11 | 0/5 | 0/2 | 0/3 | n/a | n/a |
| [Gestion/Tables/Txmo.class](.src/Gestion/Tables/Txmo.class/rework.md) | 356 | 80 | 14 | 0 | 21 | 0/7 | 0/4 | 0/6 | n/a | n/a |
| [Gestion/Tables/Typec.class](.src/Gestion/Tables/Typec.class/rework.md) | 143 | 47 | 6 | 0 | 20 | 0/7 | 0/2 | 0/4 | n/a | n/a |

</details>

<details><summary><b>Gestion (sous-lot 2)</b> — 108 fichiers</summary>

| Fichier | LOC | CC tot. | CC max | Glob. | Fonc. Public | Reworks | Anomalies | Tests | Couv. | Durée |
|---|---|---|---|---|---|---|---|---|---|---|
| [Gestion/Etiquettes/Dymo.module](.src/Gestion/Etiquettes/Dymo.module/rework.md) | 19 | 1 | 1 | 0 | 1 | 0/1 | 0/0 | 0/1 | n/a | n/a |
| [Gestion/Etiquettes/Eticli.class](.src/Gestion/Etiquettes/Eticli.class/rework.md) | 702 | 180 | 31 | 0 | 39 | 0/10 | 0/4 | 0/8 | n/a | n/a |
| [Gestion/Etiquettes/Etigond.class](.src/Gestion/Etiquettes/Etigond.class/rework.md) | 915 | 235 | 51 | 0 | 39 | 0/10 | 0/5 | 0/13 | n/a | n/a |
| [Gestion/Etiquettes/EtiqPromo.class](.src/Gestion/Etiquettes/EtiqPromo.class/rework.md) | 306 | 69 | 20 | 0 | 12 | 0/5 | 0/5 | 0/7 | n/a | n/a |
| [Gestion/Etiquettes/EtiqRecpt.class](.src/Gestion/Etiquettes/EtiqRecpt.class/rework.md) | 322 | 68 | 36 | 0 | 11 | 0/7 | 0/4 | 0/9 | n/a | n/a |
| [Gestion/Etiquettes/Etiqart.class](.src/Gestion/Etiquettes/Etiqart.class/rework.md) | 848 | 197 | 24 | 0 | 38 | 0/11 | 0/6 | 0/12 | n/a | n/a |
| [Gestion/Etiquettes/Etiqcasier.class](.src/Gestion/Etiquettes/Etiqcasier.class/rework.md) | 793 | 187 | 24 | 0 | 35 | 0/10 | 0/4 | 0/9 | n/a | n/a |
| [Gestion/Etiquettes/Etiqfbtarif.class](.src/Gestion/Etiquettes/Etiqfbtarif.class/rework.md) | 365 | 92 | 18 | 0 | 20 | 0/6 | 0/2 | 0/7 | n/a | n/a |
| [Gestion/Etiquettes/Etiquettes.class](.src/Gestion/Etiquettes/Etiquettes.class/rework.md) | 228 | 73 | 7 | 0 | 23 | 0/7 | 0/2 | 0/6 | n/a | n/a |
| [Gestion/Etiquettes/Zebra.module](.src/Gestion/Etiquettes/Zebra.module/rework.md) | 19 | 1 | 1 | 0 | 1 | 0/2 | 0/2 | 0/3 | n/a | n/a |
| [Gestion/Impressions/EdArt1.class](.src/Gestion/Impressions/EdArt1.class/rework.md) | 532 | 122 | 31 | 0 | 23 | 0/9 | 0/7 | 0/11 | n/a | n/a |
| [Gestion/Impressions/EdArt2.class](.src/Gestion/Impressions/EdArt2.class/rework.md) | 489 | 112 | 21 | 0 | 23 | 0/1 | 0/3 | 0/1 | n/a | n/a |
| [Gestion/Impressions/EdArt3.class](.src/Gestion/Impressions/EdArt3.class/rework.md) | 583 | 135 | 30 | 0 | 27 | 0/8 | 0/6 | 0/8 | n/a | n/a |
| [Gestion/Impressions/EdClient.class](.src/Gestion/Impressions/EdClient.class/rework.md) | 338 | 78 | 15 | 0 | 17 | 0/6 | 0/3 | 0/6 | n/a | n/a |
| [Gestion/Impressions/EdDocs.class](.src/Gestion/Impressions/EdDocs.class/rework.md) | 328 | 84 | 39 | 0 | 20 | 0/6 | 0/4 | 0/7 | n/a | n/a |
| [Gestion/Impressions/EdFam.class](.src/Gestion/Impressions/EdFam.class/rework.md) | 217 | 47 | 7 | 0 | 12 | 0/6 | 0/0 | 0/5 | n/a | n/a |
| [Gestion/Impressions/EdFour.class](.src/Gestion/Impressions/EdFour.class/rework.md) | 234 | 50 | 10 | 0 | 12 | 0/6 | 0/1 | 0/5 | n/a | n/a |
| [Gestion/Impressions/EdMat.class](.src/Gestion/Impressions/EdMat.class/rework.md) | 393 | 100 | 35 | 0 | 19 | 0/5 | 0/5 | 0/8 | n/a | n/a |
| [Gestion/Impressions/EdPrep.class](.src/Gestion/Impressions/EdPrep.class/rework.md) | 350 | 70 | 43 | 0 | 7 | 0/7 | 0/3 | 0/7 | n/a | n/a |
| [Gestion/Impressions/EdReg.class](.src/Gestion/Impressions/EdReg.class/rework.md) | 59 | 22 | 10 | 0 | 5 | 0/4 | 0/2 | 0/5 | n/a | n/a |
| [Gestion/Impressions/EdRup.class](.src/Gestion/Impressions/EdRup.class/rework.md) | 503 | 122 | 73 | 0 | 15 | 0/7 | 0/6 | 0/10 | n/a | n/a |
| [Gestion/Impressions/EdStk.class](.src/Gestion/Impressions/EdStk.class/rework.md) | 435 | 101 | 27 | 0 | 23 | 0/6 | 0/4 | 0/8 | n/a | n/a |
| [Gestion/Impressions/Edart4.class](.src/Gestion/Impressions/Edart4.class/rework.md) | 392 | 66 | 19 | 0 | 14 | 0/8 | 0/6 | 0/8 | n/a | n/a |
| [Gestion/Impressions/Edbl.class](.src/Gestion/Impressions/Edbl.class/rework.md) | 212 | 39 | 6 | 0 | 15 | 0/5 | 0/4 | 0/7 | n/a | n/a |
| [Gestion/Impressions/Edbr.module](.src/Gestion/Impressions/Edbr.module/rework.md) | 228 | 37 | 19 | 1 | 3 | 0/7 | 0/4 | 0/7 | n/a | n/a |
| [Gestion/Impressions/Edcom.class](.src/Gestion/Impressions/Edcom.class/rework.md) | 279 | 49 | 23 | 0 | 13 | 0/6 | 0/4 | 0/6 | n/a | n/a |
| [Gestion/Impressions/Editeur.module](.src/Gestion/Impressions/Editeur.module/rework.md) | 15 | 5 | 3 | 0 | 2 | 0/3 | 0/1 | 0/4 | n/a | n/a |
| [Gestion/Impressions/Edmo.class](.src/Gestion/Impressions/Edmo.class/rework.md) | 370 | 83 | 11 | 0 | 20 | 0/6 | 0/3 | 0/7 | n/a | n/a |
| [Gestion/Impressions/Edpaiement.class](.src/Gestion/Impressions/Edpaiement.class/rework.md) | 187 | 44 | 29 | 0 | 6 | 0/7 | 0/2 | 0/7 | n/a | n/a |
| [Gestion/Impressions/Edregul.class](.src/Gestion/Impressions/Edregul.class/rework.md) | 153 | 37 | 13 | 0 | 8 | 0/6 | 0/4 | 0/7 | n/a | n/a |
| [Gestion/Impressions/Edregulprdc.class](.src/Gestion/Impressions/Edregulprdc.class/rework.md) | 186 | 39 | 13 | 0 | 10 | 0/5 | 0/3 | 0/5 | n/a | n/a |
| [Gestion/Impressions/Traites.class](.src/Gestion/Impressions/Traites.class/rework.md) | 132 | 13 | 8 | 0 | 5 | 0/5 | 0/2 | 0/5 | n/a | n/a |
| [Gestion/Lcr/Attribution.class](.src/Gestion/Lcr/Attribution.class/rework.md) | 517 | 125 | 19 | 0 | 47 | 0/6 | 0/6 | 0/9 | n/a | n/a |
| [Gestion/Lcr/Banque.class](.src/Gestion/Lcr/Banque.class/rework.md) | 336 | 71 | 8 | 0 | 32 | 0/6 | 0/5 | 0/8 | n/a | n/a |
| [Gestion/Lcr/Bordrx.class](.src/Gestion/Lcr/Bordrx.class/rework.md) | 460 | 78 | 21 | 0 | 17 | 0/7 | 0/9 | 0/11 | n/a | n/a |
| [Gestion/Lcr/CLcr.class](.src/Gestion/Lcr/CLcr.class/rework.md) | 179 | 27 | 10 | 0 | 15 | 0/5 | 0/2 | 0/6 | n/a | n/a |
| [Gestion/Lcr/EntreeItem.module](.src/Gestion/Lcr/EntreeItem.module/rework.md) | 14 | 6 | 6 | 0 | 1 | 0/2 | 0/0 | 0/2 | n/a | n/a |
| [Gestion/Lcr/Glcr.class](.src/Gestion/Lcr/Glcr.class/rework.md) | 305 | 84 | 39 | 0 | 16 | 0/7 | 0/9 | 0/8 | n/a | n/a |
| [Gestion/Lcr/Lcr.class](.src/Gestion/Lcr/Lcr.class/rework.md) | 562 | 121 | 17 | 0 | 48 | 0/8 | 0/8 | 0/11 | n/a | n/a |
| [Gestion/Lcr/Portables/Majcasier.class](.src/Gestion/Lcr/Portables/Majcasier.class/rework.md) | 88 | 23 | 17 | 0 | 4 | 0/4 | 0/3 | 0/5 | n/a | n/a |
| [Gestion/Lcr/Portables/Portable.module](.src/Gestion/Lcr/Portables/Portable.module/rework.md) | 69 | 18 | 18 | 1 | 1 | 0/4 | 0/3 | 0/5 | n/a | n/a |
| [Gestion/Lcr/Preparation.class](.src/Gestion/Lcr/Preparation.class/rework.md) | 644 | 135 | 16 | 0 | 51 | 0/6 | 0/8 | 0/11 | n/a | n/a |
| [Gestion/Mails/Emailing.class](.src/Gestion/Mails/Emailing.class/rework.md) | 775 | 212 | 37 | 0 | 41 | 0/9 | 0/9 | 0/11 | n/a | n/a |
| [Gestion/Mails/EmailingCarte.class](.src/Gestion/Mails/EmailingCarte.class/rework.md) | 474 | 136 | 25 | 0 | 31 | 0/6 | 0/6 | 0/7 | n/a | n/a |
| [Gestion/Mails/EnvMail.module](.src/Gestion/Mails/EnvMail.module/rework.md) | 238 | 98 | 56 | 0 | 6 | 0/7 | 0/6 | 0/11 | n/a | n/a |
| [Gestion/SMS/Gsm.class](.src/Gestion/SMS/Gsm.class/rework.md) | 198 | 52 | 14 | 0 | 9 | 0/6 | 0/6 | 0/8 | n/a | n/a |
| [Gestion/SMS/Psms.class](.src/Gestion/SMS/Psms.class/rework.md) | 51 | 13 | 5 | 0 | 6 | 0/1 | 0/2 | 0/1 | n/a | n/a |
| [Gestion/SMS/Sms.class](.src/Gestion/SMS/Sms.class/rework.md) | 128 | 36 | 8 | 0 | 14 | 0/6 | 0/3 | 0/6 | n/a | n/a |
| [Gestion/Stock/Epurmvtexp.class](.src/Gestion/Stock/Epurmvtexp.class/rework.md) | 109 | 21 | 7 | 0 | 8 | 0/5 | 0/3 | 0/5 | n/a | n/a |
| [Gestion/Stock/Inventaires/Fin-annee/Ecarts.class](.src/Gestion/Stock/Inventaires/Fin-annee/Ecarts.class/rework.md) | 162 | 17 | 5 | 0 | 7 | 0/5 | 0/1 | 0/6 | n/a | n/a |
| [Gestion/Stock/Inventaires/Fin-annee/Edinv.class](.src/Gestion/Stock/Inventaires/Fin-annee/Edinv.class/rework.md) | 135 | 29 | 15 | 0 | 4 | 0/5 | 0/3 | 0/7 | n/a | n/a |
| [Gestion/Stock/Inventaires/Fin-annee/Edinv1.class](.src/Gestion/Stock/Inventaires/Fin-annee/Edinv1.class/rework.md) | 126 | 27 | 15 | 0 | 4 | 0/1 | 0/1 | 0/1 | n/a | n/a |
| [Gestion/Stock/Inventaires/Fin-annee/Ednsaisis.class](.src/Gestion/Stock/Inventaires/Fin-annee/Ednsaisis.class/rework.md) | 154 | 18 | 7 | 0 | 7 | 0/5 | 0/1 | 0/6 | n/a | n/a |
| [Gestion/Stock/Inventaires/Fin-annee/Geninv.class](.src/Gestion/Stock/Inventaires/Fin-annee/Geninv.class/rework.md) | 203 | 36 | 13 | 0 | 7 | 0/8 | 0/4 | 0/16 | n/a | n/a |
| [Gestion/Stock/Inventaires/Fin-annee/RazInv.class](.src/Gestion/Stock/Inventaires/Fin-annee/RazInv.class/rework.md) | 13 | 5 | 3 | 0 | 3 | 0/3 | 0/1 | 0/3 | n/a | n/a |
| [Gestion/Stock/Inventaires/Fin-annee/SaisieInv.class](.src/Gestion/Stock/Inventaires/Fin-annee/SaisieInv.class/rework.md) | 418 | 104 | 24 | 0 | 19 | 0/7 | 0/7 | 0/16 | n/a | n/a |
| [Gestion/Stock/Inventaires/Fin-annee/Validinv.class](.src/Gestion/Stock/Inventaires/Fin-annee/Validinv.class/rework.md) | 158 | 32 | 20 | 0 | 5 | 0/8 | 0/9 | 0/16 | n/a | n/a |
| [Gestion/Stock/Inventaires/Tournant/EcartsT.class](.src/Gestion/Stock/Inventaires/Tournant/EcartsT.class/rework.md) | 164 | 17 | 5 | 0 | 7 | 0/5 | 0/2 | 0/6 | n/a | n/a |
| [Gestion/Stock/Inventaires/Tournant/EdinvT.class](.src/Gestion/Stock/Inventaires/Tournant/EdinvT.class/rework.md) | 161 | 23 | 10 | 0 | 7 | 0/1 | 0/1 | 0/1 | n/a | n/a |
| [Gestion/Stock/Inventaires/Tournant/EdnsaisisT.class](.src/Gestion/Stock/Inventaires/Tournant/EdnsaisisT.class/rework.md) | 151 | 18 | 7 | 0 | 7 | 0/5 | 0/2 | 0/6 | n/a | n/a |
| [Gestion/Stock/Inventaires/Tournant/GeninvT.class](.src/Gestion/Stock/Inventaires/Tournant/GeninvT.class/rework.md) | 531 | 110 | 20 | 0 | 22 | 0/8 | 0/5 | 0/14 | n/a | n/a |
| [Gestion/Stock/Inventaires/Tournant/RazInvT.class](.src/Gestion/Stock/Inventaires/Tournant/RazInvT.class/rework.md) | 13 | 5 | 3 | 0 | 3 | 0/3 | 0/1 | 0/3 | n/a | n/a |
| [Gestion/Stock/Inventaires/Tournant/SaisieInvT.class](.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class/rework.md) | 418 | 97 | 23 | 0 | 20 | 0/7 | 0/10 | 0/16 | n/a | n/a |
| [Gestion/Stock/Inventaires/Tournant/ValidinvT.class](.src/Gestion/Stock/Inventaires/Tournant/ValidinvT.class/rework.md) | 122 | 26 | 23 | 0 | 4 | 0/6 | 0/7 | 0/13 | n/a | n/a |
| [Gestion/Stock/Listecom.class](.src/Gestion/Stock/Listecom.class/rework.md) | 162 | 22 | 14 | 0 | 2 | 0/5 | 0/4 | 0/5 | n/a | n/a |
| [Gestion/Stock/MvtProdcomp.class](.src/Gestion/Stock/MvtProdcomp.class/rework.md) | 408 | 89 | 14 | 0 | 23 | 0/8 | 0/5 | 0/8 | n/a | n/a |
| [Gestion/Stock/Mvtex.class](.src/Gestion/Stock/Mvtex.class/rework.md) | 589 | 97 | 16 | 0 | 20 | 0/9 | 0/4 | 0/9 | n/a | n/a |
| [Gestion/Stock/Tarifs/Impart.class](.src/Gestion/Stock/Tarifs/Impart.class/rework.md) | 1 647 | 548 | 186 | 0 | 48 | 0/8 | 0/13 | 0/15 | n/a | n/a |
| [Gestion/Stock/Tarifs/ImpartParam.class](.src/Gestion/Stock/Tarifs/ImpartParam.class/rework.md) | 782 | 206 | 27 | 0 | 39 | 0/6 | 0/5 | 0/8 | n/a | n/a |
| [Gestion/Stock/Tarifs/MajEqu.module](.src/Gestion/Stock/Tarifs/MajEqu.module/rework.md) | 47 | 29 | 24 | 0 | 2 | 0/4 | 0/2 | 0/6 | n/a | n/a |
| [Gestion/Stock/Tarifs/MajFbtarif1.class](.src/Gestion/Stock/Tarifs/MajFbtarif1.class/rework.md) | 161 | 43 | 21 | 0 | 11 | 0/2 | 0/2 | 0/1 | n/a | n/a |
| [Gestion/Stock/Tarifs/MajFbtarif2.class](.src/Gestion/Stock/Tarifs/MajFbtarif2.class/rework.md) | 236 | 63 | 15 | 0 | 18 | 0/7 | 0/4 | 0/7 | n/a | n/a |
| [Gestion/Stock/Tarifs/MajTarifM.class](.src/Gestion/Stock/Tarifs/MajTarifM.class/rework.md) | 1 107 | 319 | 25 | 0 | 72 | 0/7 | 0/6 | 0/11 | n/a | n/a |
| [Gestion/Stock/Tarifs/MajTarifP.class](.src/Gestion/Stock/Tarifs/MajTarifP.class/rework.md) | 350 | 112 | 31 | 0 | 23 | 0/7 | 0/4 | 0/7 | n/a | n/a |
| [Gestion/Stock/ValidBR.class](.src/Gestion/Stock/ValidBR.class/rework.md) | 1 079 | 231 | 40 | 0 | 32 | 0/3 | 0/2 | 0/3 | n/a | n/a |
| [Gestion/Stock/ValidBR1.class](.src/Gestion/Stock/ValidBR1.class/rework.md) | 459 | 85 | 15 | 0 | 13 | 0/7 | 0/6 | 0/10 | n/a | n/a |
| [Gestion/Stock/VarMajTar.class](.src/Gestion/Stock/VarMajTar.class/rework.md) | 137 | 36 | 15 | 0 | 4 | 0/6 | 0/3 | 0/7 | n/a | n/a |
| [Gestion/Stock/commande1.class](.src/Gestion/Stock/commande1.class/rework.md) | 849 | 219 | 29 | 0 | 43 | 0/9 | 0/8 | 0/14 | n/a | n/a |
| [Gestion/option/Caleditcmat.class](.src/Gestion/option/Caleditcmat.class/rework.md) | 765 | 121 | 35 | 0 | 11 | 0/9 | 0/9 | 0/14 | n/a | n/a |
| [Gestion/option/Consigne.class](.src/Gestion/option/Consigne.class/rework.md) | 61 | 12 | 3 | 0 | 4 | 0/6 | 0/2 | 0/6 | n/a | n/a |
| [Gestion/option/Ecomptamat.class](.src/Gestion/option/Ecomptamat.class/rework.md) | 306 | 66 | 6 | 0 | 47 | 0/4 | 0/4 | 0/7 | n/a | n/a |
| [Gestion/option/Edconsigne.class](.src/Gestion/option/Edconsigne.class/rework.md) | 244 | 35 | 15 | 0 | 4 | 0/5 | 0/4 | 0/6 | n/a | n/a |
| [Gestion/option/EditStkDepart.class](.src/Gestion/option/EditStkDepart.class/rework.md) | 136 | 17 | 9 | 0 | 1 | 0/6 | 0/2 | 0/6 | n/a | n/a |
| [Gestion/option/EditfacB.class](.src/Gestion/option/EditfacB.class/rework.md) | 628 | 38 | 10 | 0 | 11 | 0/5 | 0/2 | 0/4 | n/a | n/a |
| [Gestion/option/Edittipp.class](.src/Gestion/option/Edittipp.class/rework.md) | 38 | 9 | 2 | 0 | 8 | 0/4 | 0/3 | 0/3 | n/a | n/a |
| [Gestion/option/Einvmat.class](.src/Gestion/option/Einvmat.class/rework.md) | 244 | 50 | 6 | 0 | 34 | 0/4 | 0/4 | 0/5 | n/a | n/a |
| [Gestion/option/ObjFacB.class](.src/Gestion/option/ObjFacB.class/rework.md) | 930 | 226 | 56 | 0 | 13 | 0/11 | 0/16 | 0/18 | n/a | n/a |
| [Gestion/option/Saisiedecons.class](.src/Gestion/option/Saisiedecons.class/rework.md) | 497 | 117 | 9 | 0 | 27 | 0/8 | 0/5 | 0/7 | n/a | n/a |
| [Gestion/option/Tchauffeur.class](.src/Gestion/option/Tchauffeur.class/rework.md) | 6 | 2 | 1 | 0 | 2 | 0/1 | 0/1 | 0/1 | n/a | n/a |
| [Gestion/option/Tconsigne.class](.src/Gestion/option/Tconsigne.class/rework.md) | 153 | 48 | 7 | 0 | 17 | 0/4 | 0/4 | 0/6 | n/a | n/a |
| [Gestion/option/Tregie.class](.src/Gestion/option/Tregie.class/rework.md) | 448 | 101 | 13 | 0 | 22 | 0/7 | 0/5 | 0/7 | n/a | n/a |
| [Gestion/option/Tregion.class](.src/Gestion/option/Tregion.class/rework.md) | 168 | 43 | 8 | 0 | 16 | 0/5 | 0/5 | 0/8 | n/a | n/a |
| [Gestion/option/Ttarfioul.class](.src/Gestion/option/Ttarfioul.class/rework.md) | 267 | 60 | 10 | 0 | 13 | 0/5 | 0/3 | 0/5 | n/a | n/a |
| [Gestion/option/Ttourne.class](.src/Gestion/option/Ttourne.class/rework.md) | 147 | 46 | 7 | 0 | 18 | 0/5 | 0/4 | 0/10 | n/a | n/a |
| [Gestion/option/Visucmat.class](.src/Gestion/option/Visucmat.class/rework.md) | 86 | 8 | 2 | 0 | 6 | 0/3 | 0/3 | 0/4 | n/a | n/a |
| [Gestion/option/artopt.class](.src/Gestion/option/artopt.class/rework.md) | 472 | 110 | 15 | 0 | 17 | 0/6 | 0/2 | 0/4 | n/a | n/a |
| [Gestion/option/atribvignette.class](.src/Gestion/option/atribvignette.class/rework.md) | 137 | 37 | 12 | 0 | 5 | 0/6 | 0/5 | 0/8 | n/a | n/a |
| [Gestion/option/barselection.class](.src/Gestion/option/barselection.class/rework.md) | 173 | 37 | 10 | 0 | 3 | 0/2 | 0/1 | 0/4 | n/a | n/a |
| [Gestion/option/calculdroit.class](.src/Gestion/option/calculdroit.class/rework.md) | 160 | 37 | 15 | 0 | 1 | 0/6 | 0/2 | 0/8 | n/a | n/a |
| [Gestion/option/calculdroit1.class](.src/Gestion/option/calculdroit1.class/rework.md) | 167 | 50 | 7 | 0 | 5 | 0/7 | 0/4 | 0/10 | n/a | n/a |
| [Gestion/option/facopt.class](.src/Gestion/option/facopt.class/rework.md) | 875 | 173 | 19 | 0 | 26 | 0/7 | 0/5 | 0/8 | n/a | n/a |
| [Gestion/option/fourconsdroi.class](.src/Gestion/option/fourconsdroi.class/rework.md) | 213 | 49 | 8 | 0 | 7 | 0/1 | 0/0 | 0/2 | n/a | n/a |
| [Gestion/option/menuopt.class](.src/Gestion/option/menuopt.class/rework.md) | 127 | 18 | 3 | 0 | 14 | 0/3 | 0/2 | 0/3 | n/a | n/a |
| [Gestion/option/modfichier.module](.src/Gestion/option/modfichier.module/rework.md) | 172 | 71 | 32 | 0 | 3 | 0/3 | 0/4 | 0/5 | n/a | n/a |
| [Gestion/option/rechcons.class](.src/Gestion/option/rechcons.class/rework.md) | 73 | 18 | 8 | 0 | 7 | 0/3 | 0/1 | 0/4 | n/a | n/a |
| [Gestion/option/rechtipp.class](.src/Gestion/option/rechtipp.class/rework.md) | 58 | 13 | 5 | 0 | 5 | 0/3 | 0/2 | 0/4 | n/a | n/a |
| [Gestion/option/rechtour.class](.src/Gestion/option/rechtour.class/rework.md) | 40 | 10 | 3 | 0 | 5 | 0/4 | 0/2 | 0/4 | n/a | n/a |
| [Gestion/option/ticpe.class](.src/Gestion/option/ticpe.class/rework.md) | 40 | 9 | 5 | 0 | 3 | 0/2 | 0/1 | 0/3 | n/a | n/a |

</details>

<details><summary><b>Caisse</b> — 28 fichiers</summary>

| Fichier | LOC | CC tot. | CC max | Glob. | Fonc. Public | Reworks | Anomalies | Tests | Couv. | Durée |
|---|---|---|---|---|---|---|---|---|---|---|
| [Caisse/Affichages/Tricartes.class](.src/Caisse/Affichages/Tricartes.class/rework.md) | 322 | 102 | 11 | 0 | 37 | 0/6 | 0/2 | 0/7 | n/a | n/a |
| [Caisse/Affichages/TriclientsD.class](.src/Caisse/Affichages/TriclientsD.class/rework.md) | 177 | 65 | 11 | 0 | 22 | 0/3 | 0/2 | 0/2 | n/a | n/a |
| [Caisse/Attrib.class](.src/Caisse/Attrib.class/rework.md) | 298 | 82 | 12 | 0 | 19 | 0/7 | 0/7 | 0/7 | n/a | n/a |
| [Caisse/Bordereaux.class](.src/Caisse/Bordereaux.class/rework.md) | 146 | 24 | 14 | 0 | 6 | 0/7 | 0/2 | 0/7 | n/a | n/a |
| [Caisse/Caisse.class](.src/Caisse/Caisse.class/rework.md) | 7 303 | 2 102 | 77 | 0 | 240 | 0/18 | 0/31 | 0/25 | n/a | n/a |
| [Caisse/Clavier.class](.src/Caisse/Clavier.class/rework.md) | 59 | 16 | 8 | 0 | 6 | 0/6 | 0/3 | 0/4 | n/a | n/a |
| [Caisse/Cmenu.class](.src/Caisse/Cmenu.class/rework.md) | 325 | 107 | 16 | 0 | 25 | 0/11 | 0/5 | 0/14 | n/a | n/a |
| [Caisse/Dcaisses.module](.src/Caisse/Dcaisses.module/rework.md) | 14 | 3 | 3 | 0 | 1 | 0/1 | 0/0 | 0/0 | n/a | n/a |
| [Caisse/FClientcarte.class](.src/Caisse/FClientcarte.class/rework.md) | 863 | 216 | 28 | 0 | 65 | 0/12 | 0/7 | 0/10 | n/a | n/a |
| [Caisse/Fcaisses.class](.src/Caisse/Fcaisses.class/rework.md) | 293 | 122 | 26 | 0 | 17 | 0/9 | 0/5 | 0/7 | n/a | n/a |
| [Caisse/Fclientc.class](.src/Caisse/Fclientc.class/rework.md) | 122 | 28 | 5 | 0 | 13 | 0/5 | 0/4 | 0/4 | n/a | n/a |
| [Caisse/Fondcaisse.class](.src/Caisse/Fondcaisse.class/rework.md) | 335 | 98 | 12 | 0 | 28 | 0/10 | 0/6 | 0/10 | n/a | n/a |
| [Caisse/Fvendeurs.class](.src/Caisse/Fvendeurs.class/rework.md) | 163 | 43 | 9 | 0 | 14 | 0/6 | 0/4 | 0/6 | n/a | n/a |
| [Caisse/ImageButton.class](.src/Caisse/ImageButton.class/rework.md) | 103 | 22 | 7 | 0 | 8 | 0/2 | 0/1 | 0/4 | n/a | n/a |
| [Caisse/LibelAvoirs.class](.src/Caisse/LibelAvoirs.class/rework.md) | 34 | 11 | 4 | 0 | 5 | 0/5 | 0/2 | 0/3 | n/a | n/a |
| [Caisse/LibelTicket.class](.src/Caisse/LibelTicket.class/rework.md) | 33 | 11 | 4 | 0 | 5 | 0/5 | 0/3 | 0/4 | n/a | n/a |
| [Caisse/Moulinage.class](.src/Caisse/Moulinage.class/rework.md) | 2 430 | 622 | 196 | 0 | 29 | 0/17 | 0/17 | 0/23 | n/a | n/a |
| [Caisse/MyStyle.class](.src/Caisse/MyStyle.class/rework.md) | 38 | 5 | 5 | 0 | 1 | 0/3 | 0/1 | 0/2 | n/a | n/a |
| [Caisse/Ouverture.class](.src/Caisse/Ouverture.class/rework.md) | 212 | 67 | 19 | 0 | 15 | 0/10 | 0/7 | 0/11 | n/a | n/a |
| [Caisse/Positions.class](.src/Caisse/Positions.class/rework.md) | 1 | 0 | 0 | 0 | 0 | 0/1 | 0/0 | 0/0 | n/a | n/a |
| [Caisse/Preferences.class](.src/Caisse/Preferences.class/rework.md) | 183 | 65 | 41 | 0 | 14 | 0/7 | 0/3 | 0/6 | n/a | n/a |
| [Caisse/Reports/Cfacture.class](.src/Caisse/Reports/Cfacture.class/rework.md) | 267 | 59 | 8 | 0 | 20 | 0/4 | 0/3 | 0/9 | n/a | n/a |
| [Caisse/Reports/Cticket.class](.src/Caisse/Reports/Cticket.class/rework.md) | 14 | 4 | 1 | 0 | 4 | 0/1 | 0/0 | 0/0 | n/a | n/a |
| [Caisse/Statcai.class](.src/Caisse/Statcai.class/rework.md) | 146 | 31 | 17 | 0 | 4 | 0/5 | 0/5 | 0/6 | n/a | n/a |
| [Caisse/Svendeur.class](.src/Caisse/Svendeur.class/rework.md) | 44 | 15 | 6 | 0 | 4 | 0/3 | 0/2 | 0/4 | n/a | n/a |
| [Caisse/Telium.class](.src/Caisse/Telium.class/rework.md) | 97 | 26 | 5 | 0 | 2 | 0/1 | 0/4 | 0/3 | n/a | n/a |
| [Caisse/TestCaisses.module](.src/Caisse/TestCaisses.module/rework.md) | 25 | 6 | 6 | 0 | 1 | 0/4 | 0/2 | 0/4 | n/a | n/a |
| [Caisse/numtostring.module](.src/Caisse/numtostring.module/rework.md) | 166 | 92 | 62 | 0 | 3 | 0/3 | 0/3 | 0/6 | n/a | n/a |

</details>

<details><summary><b>Statistiques</b> — 19 fichiers</summary>

| Fichier | LOC | CC tot. | CC max | Glob. | Fonc. Public | Reworks | Anomalies | Tests | Couv. | Durée |
|---|---|---|---|---|---|---|---|---|---|---|
| [Statistiques/Histocliart.class](.src/Statistiques/Histocliart.class/rework.md) | 836 | 245 | 141 | 0 | 18 | 0/8 | 0/7 | 0/11 | n/a | n/a |
| [Statistiques/Histovmo.class](.src/Statistiques/Histovmo.class/rework.md) | 674 | 163 | 39 | 0 | 31 | 0/9 | 0/6 | 0/9 | n/a | n/a |
| [Statistiques/HitCarte.class](.src/Statistiques/HitCarte.class/rework.md) | 159 | 44 | 16 | 0 | 8 | 0/7 | 0/4 | 0/7 | n/a | n/a |
| [Statistiques/RelMoprod.class](.src/Statistiques/RelMoprod.class/rework.md) | 787 | 189 | 30 | 0 | 52 | 0/9 | 0/8 | 0/9 | n/a | n/a |
| [Statistiques/RelvMo.class](.src/Statistiques/RelvMo.class/rework.md) | 382 | 97 | 37 | 0 | 16 | 0/8 | 0/6 | 0/8 | n/a | n/a |
| [Statistiques/StatClimo.class](.src/Statistiques/StatClimo.class/rework.md) | 235 | 62 | 37 | 0 | 8 | 0/7 | 0/5 | 0/8 | n/a | n/a |
| [Statistiques/StatComArt.class](.src/Statistiques/StatComArt.class/rework.md) | 162 | 41 | 16 | 0 | 8 | 0/7 | 0/4 | 0/7 | n/a | n/a |
| [Statistiques/StatComm.class](.src/Statistiques/StatComm.class/rework.md) | 224 | 62 | 37 | 0 | 8 | 0/7 | 0/5 | 0/10 | n/a | n/a |
| [Statistiques/StatFour.class](.src/Statistiques/StatFour.class/rework.md) | 166 | 40 | 17 | 0 | 8 | 0/7 | 0/5 | 0/7 | n/a | n/a |
| [Statistiques/StatPromo.class](.src/Statistiques/StatPromo.class/rework.md) | 142 | 33 | 12 | 0 | 9 | 0/5 | 0/3 | 0/6 | n/a | n/a |
| [Statistiques/StatTypCli.class](.src/Statistiques/StatTypCli.class/rework.md) | 208 | 50 | 25 | 0 | 8 | 0/7 | 0/4 | 0/7 | n/a | n/a |
| [Statistiques/Statbase.class](.src/Statistiques/Statbase.class/rework.md) | 32 | 2 | 1 | 0 | 2 | 0/4 | 0/2 | 0/4 | n/a | n/a |
| [Statistiques/TBord.class](.src/Statistiques/TBord.class/rework.md) | 339 | 67 | 49 | 0 | 5 | 0/8 | 0/6 | 0/8 | n/a | n/a |
| [Statistiques/VisHitCartes.class](.src/Statistiques/VisHitCartes.class/rework.md) | 171 | 20 | 7 | 0 | 4 | 0/6 | 0/3 | 0/5 | n/a | n/a |
| [Statistiques/VisStatClimo.class](.src/Statistiques/VisStatClimo.class/rework.md) | 185 | 19 | 4 | 0 | 11 | 0/5 | 0/1 | 0/5 | n/a | n/a |
| [Statistiques/VisStatComArt.class](.src/Statistiques/VisStatComArt.class/rework.md) | 186 | 29 | 9 | 0 | 10 | 0/6 | 0/4 | 0/6 | n/a | n/a |
| [Statistiques/VisStatComm.class](.src/Statistiques/VisStatComm.class/rework.md) | 219 | 32 | 14 | 0 | 11 | 0/6 | 0/3 | 0/6 | n/a | n/a |
| [Statistiques/VisStatFour.class](.src/Statistiques/VisStatFour.class/rework.md) | 213 | 29 | 8 | 0 | 14 | 0/5 | 0/3 | 0/4 | n/a | n/a |
| [Statistiques/VisStatTypCli.class](.src/Statistiques/VisStatTypCli.class/rework.md) | 206 | 30 | 10 | 0 | 11 | 0/6 | 0/3 | 0/5 | n/a | n/a |

</details>

<details><summary><b>Affichages</b> — 16 fichiers</summary>

| Fichier | LOC | CC tot. | CC max | Glob. | Fonc. Public | Reworks | Anomalies | Tests | Couv. | Durée |
|---|---|---|---|---|---|---|---|---|---|---|
| [Affichages/ACom.class](.src/Affichages/ACom.class/rework.md) | 65 | 14 | 6 | 0 | 4 | 0/5 | 0/2 | 0/4 | n/a | n/a |
| [Affichages/AFacture.class](.src/Affichages/AFacture.class/rework.md) | 82 | 20 | 12 | 0 | 4 | 0/5 | 0/2 | 0/5 | n/a | n/a |
| [Affichages/TriArticles.class](.src/Affichages/TriArticles.class/rework.md) | 363 | 78 | 16 | 0 | 22 | 0/8 | 0/3 | 0/11 | n/a | n/a |
| [Affichages/TriBl.class](.src/Affichages/TriBl.class/rework.md) | 255 | 98 | 14 | 0 | 32 | 0/4 | 0/2 | 0/1 | n/a | n/a |
| [Affichages/TriCpt.class](.src/Affichages/TriCpt.class/rework.md) | 455 | 89 | 17 | 0 | 15 | 0/8 | 0/5 | 0/10 | n/a | n/a |
| [Affichages/TriEcritures.class](.src/Affichages/TriEcritures.class/rework.md) | 602 | 198 | 11 | 0 | 65 | 0/8 | 0/3 | 0/6 | n/a | n/a |
| [Affichages/TriEcritures2.class](.src/Affichages/TriEcritures2.class/rework.md) | 520 | 176 | 11 | 0 | 59 | 0/3 | 0/1 | 0/1 | n/a | n/a |
| [Affichages/TriEqu.class](.src/Affichages/TriEqu.class/rework.md) | 283 | 85 | 12 | 0 | 25 | 0/7 | 0/3 | 0/6 | n/a | n/a |
| [Affichages/TriFac.class](.src/Affichages/TriFac.class/rework.md) | 409 | 127 | 19 | 0 | 35 | 0/9 | 0/5 | 0/5 | n/a | n/a |
| [Affichages/TriFac2.class](.src/Affichages/TriFac2.class/rework.md) | 629 | 187 | 20 | 0 | 44 | 0/9 | 0/5 | 0/7 | n/a | n/a |
| [Affichages/TriFacture.class](.src/Affichages/TriFacture.class/rework.md) | 237 | 47 | 13 | 0 | 11 | 0/8 | 0/1 | 0/6 | n/a | n/a |
| [Affichages/TriGen.class](.src/Affichages/TriGen.class/rework.md) | 626 | 163 | 17 | 0 | 33 | 0/10 | 0/5 | 0/11 | n/a | n/a |
| [Affichages/TriHistos.class](.src/Affichages/TriHistos.class/rework.md) | 601 | 147 | 29 | 0 | 26 | 0/7 | 0/5 | 0/6 | n/a | n/a |
| [Affichages/TriMat.class](.src/Affichages/TriMat.class/rework.md) | 329 | 117 | 11 | 0 | 32 | 0/6 | 0/3 | 0/6 | n/a | n/a |
| [Affichages/TriMo.class](.src/Affichages/TriMo.class/rework.md) | 48 | 8 | 2 | 0 | 5 | 0/1 | 0/1 | 0/1 | n/a | n/a |
| [Affichages/Tricp.class](.src/Affichages/Tricp.class/rework.md) | 220 | 88 | 13 | 0 | 24 | 0/6 | 0/5 | 0/8 | n/a | n/a |

</details>

<details><summary><b>Archivages</b> — 8 fichiers</summary>

| Fichier | LOC | CC tot. | CC max | Glob. | Fonc. Public | Reworks | Anomalies | Tests | Couv. | Durée |
|---|---|---|---|---|---|---|---|---|---|---|
| [Archivages/Archives.class](.src/Archivages/Archives.class/rework.md) | 1 202 | 307 | 35 | 0 | 70 | 0/12 | 0/10 | 0/15 | n/a | n/a |
| [Archivages/ArchivesTck.class](.src/Archivages/ArchivesTck.class/rework.md) | 557 | 157 | 46 | 0 | 42 | 0/8 | 0/8 | 0/10 | n/a | n/a |
| [Archivages/RazClientd.class](.src/Archivages/RazClientd.class/rework.md) | 27 | 8 | 6 | 0 | 3 | 0/5 | 0/3 | 0/5 | n/a | n/a |
| [Archivages/RazDevis.class](.src/Archivages/RazDevis.class/rework.md) | 49 | 14 | 11 | 0 | 3 | 0/4 | 0/4 | 0/5 | n/a | n/a |
| [Archivages/RazHistoFac.class](.src/Archivages/RazHistoFac.class/rework.md) | 49 | 14 | 11 | 0 | 3 | 0/4 | 0/4 | 0/6 | n/a | n/a |
| [Archivages/RazHistoFbl.class](.src/Archivages/RazHistoFbl.class/rework.md) | 33 | 9 | 7 | 0 | 3 | 0/3 | 0/4 | 0/6 | n/a | n/a |
| [Archivages/RazHistoTk.class](.src/Archivages/RazHistoTk.class/rework.md) | 33 | 9 | 7 | 0 | 3 | 0/4 | 0/4 | 0/6 | n/a | n/a |
| [Archivages/RazRlvb.class](.src/Archivages/RazRlvb.class/rework.md) | 29 | 8 | 6 | 0 | 3 | 0/7 | 0/4 | 0/6 | n/a | n/a |

</details>

<details><summary><b>Reports</b> — 24 fichiers</summary>

| Fichier | LOC | CC tot. | CC max | Glob. | Fonc. Public | Reworks | Anomalies | Tests | Couv. | Durée |
|---|---|---|---|---|---|---|---|---|---|---|
| [Reports/Carticles.class](.src/Reports/Carticles.class/rework.md) | 370 | 37 | 2 | 0 | 36 | 0/7 | 0/3 | 0/9 | n/a | n/a |
| [Reports/Cbalances.class](.src/Reports/Cbalances.class/rework.md) | 263 | 44 | 5 | 0 | 22 | 0/6 | 0/0 | 0/6 | n/a | n/a |
| [Reports/Cbilan.class](.src/Reports/Cbilan.class/rework.md) | 166 | 67 | 17 | 0 | 11 | 0/6 | 0/2 | 0/5 | n/a | n/a |
| [Reports/Cbordereaux.class](.src/Reports/Cbordereaux.class/rework.md) | 97 | 16 | 1 | 0 | 16 | 0/4 | 0/1 | 0/6 | n/a | n/a |
| [Reports/Cclients.class](.src/Reports/Cclients.class/rework.md) | 118 | 13 | 1 | 0 | 13 | 0/5 | 0/1 | 0/5 | n/a | n/a |
| [Reports/Ccompta.class](.src/Reports/Ccompta.class/rework.md) | 546 | 60 | 5 | 0 | 53 | 0/8 | 0/2 | 0/10 | n/a | n/a |
| [Reports/Cdocuments.class](.src/Reports/Cdocuments.class/rework.md) | 986 | 212 | 23 | 0 | 72 | 0/12 | 0/2 | 0/12 | n/a | n/a |
| [Reports/Cdocuments2.class](.src/Reports/Cdocuments2.class/rework.md) | 926 | 182 | 31 | 0 | 59 | 0/1 | 0/0 | 0/2 | n/a | n/a |
| [Reports/Cdocuments3.class](.src/Reports/Cdocuments3.class/rework.md) | 159 | 17 | 2 | 0 | 14 | 0/5 | 0/1 | 0/3 | n/a | n/a |
| [Reports/Cecheancier.class](.src/Reports/Cecheancier.class/rework.md) | 39 | 6 | 1 | 0 | 6 | 0/1 | 0/0 | 0/1 | n/a | n/a |
| [Reports/Cetiquettes.class](.src/Reports/Cetiquettes.class/rework.md) | 185 | 33 | 3 | 0 | 29 | 0/5 | 0/1 | 0/6 | n/a | n/a |
| [Reports/Chistoriques.class](.src/Reports/Chistoriques.class/rework.md) | 291 | 33 | 1 | 0 | 33 | 0/5 | 0/2 | 0/7 | n/a | n/a |
| [Reports/ChxImp.class](.src/Reports/ChxImp.class/rework.md) | 20 | 6 | 5 | 0 | 2 | 0/1 | 0/2 | 0/1 | n/a | n/a |
| [Reports/Clivre.class](.src/Reports/Clivre.class/rework.md) | 142 | 32 | 7 | 0 | 19 | 0/1 | 0/0 | 0/1 | n/a | n/a |
| [Reports/Cmat.class](.src/Reports/Cmat.class/rework.md) | 54 | 8 | 1 | 0 | 8 | 0/3 | 0/0 | 0/2 | n/a | n/a |
| [Reports/Creleve.class](.src/Reports/Creleve.class/rework.md) | 225 | 35 | 12 | 0 | 16 | 0/9 | 0/2 | 0/6 | n/a | n/a |
| [Reports/Cresultat.class](.src/Reports/Cresultat.class/rework.md) | 66 | 12 | 3 | 0 | 8 | 0/4 | 0/1 | 0/3 | n/a | n/a |
| [Reports/Csig.class](.src/Reports/Csig.class/rework.md) | 188 | 72 | 25 | 0 | 14 | 0/5 | 0/1 | 0/4 | n/a | n/a |
| [Reports/Cstocks.class](.src/Reports/Cstocks.class/rework.md) | 241 | 24 | 1 | 0 | 24 | 0/6 | 0/1 | 0/7 | n/a | n/a |
| [Reports/Ctraites.class](.src/Reports/Ctraites.class/rework.md) | 19 | 3 | 1 | 0 | 3 | 0/1 | 0/0 | 0/1 | n/a | n/a |
| [Reports/Editfac.class](.src/Reports/Editfac.class/rework.md) | 476 | 154 | 112 | 0 | 13 | 0/9 | 0/3 | 0/10 | n/a | n/a |
| [Reports/Htickets.class](.src/Reports/Htickets.class/rework.md) | 33 | 6 | 1 | 0 | 6 | 0/3 | 0/1 | 0/3 | n/a | n/a |
| [Reports/PdfWriter.class](.src/Reports/PdfWriter.class/rework.md) | 3 403 | 791 | 45 | 0 | 123 | 0/11 | 0/10 | 0/15 | n/a | n/a |
| [Reports/PdfWriterFont.class](.src/Reports/PdfWriterFont.class/rework.md) | 400 | 43 | 19 | 0 | 18 | 0/3 | 0/3 | 0/2 | n/a | n/a |

</details>

<details><summary><b>Tests</b> — 1 fichiers</summary>

| Fichier | LOC | CC tot. | CC max | Glob. | Fonc. Public | Reworks | Anomalies | Tests | Couv. | Durée |
|---|---|---|---|---|---|---|---|---|---|---|
| [Tests/TriTest.class](.src/Tests/TriTest.class/rework.md) | 43 | 7 | 2 | 0 | 4 | 0/3 | 0/0 | 0/3 | n/a | n/a |

</details>
