# Marques — Synthèse

> Source : `.src/Gestion/Tables/Marques.class` · Synthèse des autres documents.

## Rôle

Écran de la table des marques (`Fiches_Marques`), proposées dans les fiches articles et matériels.

## Points clés

- Copie du squelette « grille filtrable » de Cpostaux (similarité 0,70), noms hérités (`Cpost`,
  `ChkCp`).
- Le code de marque n'accepte que des chiffres (`ChkCp`).
- Code mort : `cpoint` ; pseudo-handler `Cmarque_LostFocus`.

## Dépendances principales

- Utilise : `Utils.Base`, `Utils.rs1`, `Utils.db`, `Utils.SetEditColor`, `Doc`.
- Utilisé par : `Fmenu` (`Show`) ; table lue par `Articles`, `Materiel`, `EdMat`, `Stockmvt`.
- `Colmarque_Click` rejoué par `ReplayObserver` : reste `Public`.

## Risques

- A01 : filtre concaténé ; A02 : code numérique imposé ; A03 : suppression sans contrôle, doublons.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 240 |
| Lignes de commentaire | 22 |
| Fonctions | 29 |
| Fonctions Public | 29 |
| Complexité cyclomatique totale | 62 |
| Complexité max (fonction) | 8 (`Cpost_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

5 replays (création, modification, code alphabétique, filtre et tri, suppression).

## Rework

6 étapes (001 à 006) : documentation, code mort, `Cbase.Table`, socle « grille filtrable »,
séparation traitement/GUI, réduction de portée. 3 anomalies (A01 à A03).
