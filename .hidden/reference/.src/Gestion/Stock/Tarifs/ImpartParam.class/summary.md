# ImpartParam — Synthèse

> Source : `.src/Gestion/Stock/Tarifs/ImpartParam.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran « Table des fichiers d'import » : création et édition des définitions d'import de tarifs
utilisées par `Impart` (en-tête `Fiches_ImpArtDef`, zones `Fiches_ImpArtDef2` : libellé, n° de
champ ou début/longueur, champ Laurux cible), avec aperçu des premières lignes du fichier.

## Points clés

- Chaque modification réécrit toute la ligne de 161 colonnes de `Fiches_ImpArtDef2` par de longues
  requêtes écrites à la main (`EnregistreZones`).
- Deux chemins d'écriture : `INSERT` après `DELETE` (ajout, retrait de zone) et `UPDATE`
  (déplacement `+`/`-`) ; c'est ce second chemin qui concentre les erreurs.
- Tables en dur, sans clé `Cbase`.

## Dépendances principales

- Utilisé par : `Fmenu.Menu245_Click` ; données lues par `Impart`.
- Utilise : `Utils.db`, `Utils.Observers/ObsGotf/ObsLstf`, `Cbase.Table("TabFour"/"TabFam")`.

## Risques

- Largeur fixe : déplacement d'une zone → dépassement d'indice (`db_n[231]`, A01) ; création
  limitée à 15 zones sans `posorg` (A03).
- Mode séparé : paramètres dupliqués et `UPDATE` invalide lors d'un déplacement (A02).
- Numérotation sans `ORDER BY` (A04) ; défauts d'ergonomie et fichier non fermé (A05).
- Grille `Champs` sans `Champs_Click` : rejeu par clic impossible.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 782 |
| Lignes de commentaire | 41 |
| Fonctions | 39 |
| Fonctions Public | 39 |
| Complexité cyclomatique totale | 206 |
| Complexité max (fonction) | 27 (`Champs_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

8 replays (création séparée et largeur fixe, déplacements, retrait/édition, sélection,
suppression, numérotation) ; leurs définitions servent de données aux tests d'`Impart`.

## Rework

6 étapes (IMPARTPARAM-001 à 006) : documentation, code mort, `EchangeZones`, réduction de portée
de 6 fonctions, classe commune `LImpDef` avec `Impart`, séparation de l'écriture SQL.
5 anomalies (A01 à A05).
