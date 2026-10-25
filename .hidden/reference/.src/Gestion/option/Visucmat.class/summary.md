# Visucmat — Synthèse

> Source : `.src/Gestion/option/Visucmat.class` · Synthèse des autres documents.

## Rôle

Consultation des mouvements d'entrée et de sortie de la comptabilité matières
(`Fiches_ligregie`, types `E`/`S`) entre deux dates, dans une liste `TriGen` triable. Ouvert depuis
`Caleditcmat` (bouton « Visu »). Lecture seule.

## Points clés

- 7 fonctions ; toute la logique est dans le composant générique `TriGen`.
- Date de début initialisée à partir de `Fiches_Parametres.arrete` (`char(7)`), sans contrôle.
- `Bsel`/`Bval` `Public` écrits par `TriGen` via `Object.SetProperty`.
- Pas d'`Utils.Observers(Me)`.

## Dépendances principales

- Utilise : `TriGen`, `ObjProp`, `Chainage`, `TextReg`, `Utils.db` ; tables `Fiches_ligregie`,
  `Fiches_Parametres`.
- Utilisé par : `Caleditcmat`.

## Risques

- Arrêté non paramétré ou table vide : comportement non maîtrisé à l'ouverture (A01).
- Début de période incohérent avec les éditions `Einvmat`/`Ecomptamat` (A02, à trancher).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 86 |
| Lignes de commentaire | 1 |
| Fonctions | 7 |
| Fonctions Public | 6 |
| Complexité cyclomatique totale | 8 |
| Complexité max (fonction) | 2 (`_new`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

4 replays (VISUCMAT-T01 à T04) sur le jeu `cmat_base` ; comparaison des lignes `Exec_SQL`.

## Rework

3 étapes (VISUCMAT-001 à 003) : documentation, filtre de période factorisé, colonnes décrites
par tableau. 3 anomalies (A01 à A03).
