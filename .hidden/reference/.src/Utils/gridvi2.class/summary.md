# gridvi2 — Synthèse

> Source : `.src/Utils/gridvi2.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Ancienne variante de `gridvi` (onglet « Statistiques » avec tableau comparatif annuel), supplantée
et **jamais instanciée** : code mort.

## Points clés

- Aucun appelant (vérifié par `grep -rni`), aucun `.form`, aucun nom de classe en chaîne.
- 86 lignes strictement identiques à `gridvi` (`affent`, `razcol`, `calcanne`, accesseurs) ;
  `affdon` à 6 lignes près ; `bouton_Click` et `grdv_MouseUp` sur le même squelette avec un SQL plus
  ancien (lignes `A`/`E`, sans archives).
- `bouton_Click` n'est relié à aucun bouton.

## Dépendances principales

- Utilise `Utils.db`, `Utils.mois`, `Utils.lastday`, `Start.LocalSettings` (`Prxdec`).
- Tables lues (si elle était utilisée) : `Fiches_HistoFac`, `Fiches_HistoLigfac`, `Fiches_Bl`,
  `Fiches_Ligbl`, `Fiches_Art`, `Fiches_Parametres`.

## Risques

- Aucun à l'exécution. Risque de confusion lors des évolutions (une correction faite dans la
  mauvaise variante).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 387 |
| Lignes de commentaire | 15 |
| Fonctions | 13 |
| Fonctions Public | 5 |
| Complexité cyclomatique totale | 92 |
| Complexité max (fonction) | 20 (`bouton_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

1 contrôle (GRIDVI2-T01) : compilation et absence de référence après suppression ; les replays de
`gridvi` servent de non-régression.

## Rework

1 étape : suppression du fichier (GRIDVI2-001). Aucune anomalie retenue.
