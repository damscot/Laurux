# EdReg — Synthèse

> Source : `.src/Gestion/Impressions/EdReg.class` · Synthèse des autres documents.

## Rôle

État gb.report (`EdReg.report`) du **bordereau des règlements clients** saisis dans `SaiReg` :
date, compte, nom et montant de chaque règlement, nombre et total, en-tête société et mode de
règlement. Sortie `~/tmp/Bordereau.pdf`.

## Points clés

- Deux modes : `ajout` (règlements ajoutés) et `tous` (sauf supprimés, avec `InputBox` du numéro
  de bordereau).
- Remplissage par les événements `Data` de quatre `ReportLabel` (handlers identiques à la donnée
  près) ; `deps.py` les croit morts (faux positif, `.report` non analysé).
- Une seule requête : `SELECT * FROM Fiches_Societes`, sans filtre société.

## Dépendances principales

- Appelé par `SaiReg.editions_Click` / `editionb_Click`.
- Utilise `VarEcr` (sélection, somme), `LDate`, `Start.R/G/B`.

## Risques

- EDREG-A01 : raison sociale de la première société en multi-société.
- EDREG-A02 : couleur de bande fausse si une composante du thème est < 16 (`Hex` non complété).
- Test uniquement par le replay de `SaiReg` (pas d'écran propre, pas d'`Utils.Observers`).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 59 |
| Lignes de commentaire | 1 |
| Fonctions | 5 |
| Fonctions Public | 5 |
| Complexité cyclomatique totale | 22 |
| Complexité max (fonction) | 10 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

5 tests `replay` via `SaiReg` (EDREG-T01 à T05) : modes `ajout`/`tous`, numéro de bordereau,
multi-société, couleur ; comparaison `pdftotext` du bordereau.

## Rework

4 étapes (EDREG-001 à 004) : documentation, couleur calculée une fois + `Cbase`, factorisation des
handlers `Data`, extraction de la sélection. 2 anomalies (EDREG-A01, A02).
