# Epurjdv — Synthèse

> Source : `.src/Compta/Utils/Epurjdv.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Ancienne fenêtre « Epuration du JDV » (2008) : rotation des tables d'écritures `Fiches_Mvt` →
`Fiches_Mvt5`, recréation d'une table `Fiches_Mvt` vide, recopie optionnelle des lignes 411 non
lettrées, décalage des dates de clôture. **Fenêtre non appelée** : aucun menu ni appel dans le
projet (vérifié par `grep`).

## Points clés

- Code mort : couple `.class` + `.form` sans point d'entrée ; seule trace, la page d'aide
  « Epurationjdv ».
- Traitement destructeur (DROP / RENAME / CREATE de `Fiches_Mvt*`), réservé au serveur local.
- `CREATE TABLE Fiches_Mvt` non conforme au schéma de référence (`db_control.csv`).
- Sauvegarde préalable par `mysqldump` construit à la main (base `Laurux` en dur).

## Dépendances principales

- Appelants : aucun.
- Utilise `Utils.db`, `Utils.Cdate_*`, `Csolde.Recalc_solde`, `Doc.Open`, `Start.LocalSettings`,
  commande `mysqldump`.
- Tables : `Fiches_Mvt` à `Fiches_Mvt5`, `Fiches_Parametres`.

## Risques

- Si elle était réactivée : table `Fiches_Mvt` recréée sans `export`/`control` ni index, écritures
  411 recopiées sans contrepartie, échec sous SQLite, dump d'une base erronée.
- Aucun risque en l'état (inaccessible), hormis la confusion à la lecture du code.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 172 |
| Lignes de commentaire | 23 |
| Fonctions | 7 |
| Fonctions Public | 7 |
| Complexité cyclomatique totale | 29 |
| Complexité max (fonction) | 18 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

Aucun replay possible (pas de point d'entrée). Deux tests `gbtest` sous Xvfb sont décrits, à
réaliser seulement si la suppression (EPURJDV-A01) est refusée.

## Rework

3 étapes (EPURJDV-001 à 003) : documentation, puis, seulement si le fichier est conservé, réduction
de portée et `Utils.DumpBase`. 5 anomalies (EPURJDV-A01 à A05), dont la **suppression du couple
`.class` + `.form`** (A01), soumises à validation utilisateur.
