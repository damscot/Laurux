# CoefTypeC — Synthèse

> Source : `.src/Gestion/Tables/CoefTypeC.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran de la table des coefficients de vente par type de client et par famille
(`Fiches_CoeffTypec`), lue par `TarArt`, `Facture` et `EdArt3`. Ouvert depuis le menu ou depuis
la fiche article ; dans ce dernier cas, un panneau affiche le prix de vente de l'article avec le
coefficient sélectionné.

## Points clés

- Même gabarit que `Remisec` (copie au nom de table et de colonne près) et proche de
  `Remisecli`.
- Contrôles `Quitte_*` sans valeur de retour : l'enregistrement n'est jamais bloqué.
- Mode article piloté par des variables globales de `Variables` écrites par `Articles`.
- Petit fichier (281 lignes de code, CC max 10).

## Dépendances principales

- Utilise : `Cbase` (`TabCtcli`, `TabTypec`, `TabFam`), `Utils` (couleurs, observateurs,
  `cpoint`), `Variables`, `Doc`.
- Utilisé par : `Fmenu`, `Articles` (ouverture) ; la table est lue par `TarArt`, `Facture`,
  `EdArt3`.

## Risques

- Enregistrement d'un type ou d'une famille inexistants, coefficient invalide → `NULL` (A01).
- Panneau article périmé après une ouverture depuis la fiche article (A02).
- Libellés du panneau décalés après un enregistrement (A03).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 281 |
| Lignes de commentaire | 36 |
| Fonctions | 20 |
| Fonctions Public | 20 |
| Complexité cyclomatique totale | 62 |
| Complexité max (fonction) | 10 (`Rem_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

5 scénarios `replay` (COEFTYPEC-T01 à T05) : création, modification, saisie invalide,
suppression, mode article. gb.test du calcul de prix après séparation.

## Rework

6 étapes (COEFTYPEC-001 à 006) : documentation, code mort, `Cbase.Table`, réduction de portée
de 6 fonctions, séparation traitement/GUI, gabarit commun avec `Remisec`/`Remisecli`.
3 anomalies (COEFTYPEC-A01 à A03).
