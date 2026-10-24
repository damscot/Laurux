# Renech — Synthèse

> Source : `.src/Compta/Utils/Renech.class` · Synthèse des autres documents.

## Rôle

Script statique lancé par `Prgm` (`Renech`) : relit `~/Dtech.txt` (`numdoc;compte;date;`) et
remet à jour la date d'échéance (`dateech`) des écritures de `Fiches_Mvt`. Pendant de `RecupDech`
qui exporte ces dates.

## Points clés

- Conversion de date par découpage de chaîne (`mm/jj/aaaa` → `aaaammjj`, à confirmer).
- Fichier statique jamais fermé ; aucune gestion d'erreur ; aucune confirmation.
- `RecupDech` écrit `~/tmp/Dtech.txt`, `Renech` lit `~/Dtech.txt`.

## Dépendances principales

- Utilise : `Utils.db`, `Cbase.Table("TabMvt")`, `User.Home`.
- Utilisé par : `Prgm.class:84` ; dépend du fichier produit par `RecupDech`.

## Risques

- Dates d'échéance écrasées par un fichier ancien ou mal formé ; erreur d'exécution sur fichier
  absent ou ligne vide.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 15 |
| Lignes de commentaire | 1 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 3 |
| Complexité max (fonction) | 3 (`run`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

2 tests `gbtest` (aller-retour avec `RecupDech`, cas limites) et 1 `replay` via `Prgm`
(RENECH-T01 à T03).

## Rework

2 étapes (RENECH-001, 002) : documentation, fermeture du fichier. 2 anomalies (A01, A02) :
fiabilisation ou retrait, chemins incohérents.
