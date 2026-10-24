# RazClos — Synthèse

> Source : `.src/Compta/Utils/RazClos.class` · Synthèse des autres documents.

## Rôle

Écran « Déblocage d'une écriture clôturée » : remet `cloturee = 0` sur les lignes d'une écriture
de `Fiches_Mvt` dont le numéro est saisi, puis recalcule et réécrit sa clé SHA-1.

## Points clés

- Deux instructions dans `Raz` (`UPdate` paramétré + `Sha1Calc.CalcSha1`), lisant `TextBox1`.
- Accessible par le menu « Déblocage écritures » sans mot de passe, et par `Prgm`.
- Table `Fiches_Mvt` en dur, exercice en cours seulement.

## Dépendances principales

- Utilise : `Utils.db`, `Sha1Calc.CalcSha1`.
- Utilisé par : `Fmenu.Menu311_Click`, `Prgm.class:79`.

## Risques

- **Conformité** : la clé d'inaltérabilité est re-scellée après déblocage, ce qui rend la
  modification indétectable par « Anomalies des clés » (A01).
- Aucun contrôle de saisie ni confirmation (A02).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 14 |
| Lignes de commentaire | 1 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 4 |
| Complexité max (fonction) | 1 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

4 tests `replay` (RAZCLOS-T01 à T04) : déblocage nominal, numéro invalide, effet sur le contrôle
des clés, lancement par `Prgm`.

## Rework

3 étapes (RAZCLOS-001 à 003) : documentation, séparation traitement/GUI avec réduction de portée,
`Cbase.Table`. 2 anomalies (A01 conformité, A02 contrôle de saisie).
