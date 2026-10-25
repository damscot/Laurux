# ValidBR — Synthèse

> Source : `.src/Gestion/Stock/ValidBR.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Ancien écran de validation des bons de réception (2014) : liste des BR non validées, clôture avec
ou sans écriture d'achat dans `Fiches_Mvt`, édition `Edbr` et scan GED. **Code mort** : plus
aucun point d'entrée depuis le commit `a06ada7a` (2022), qui l'a remplacé par `ValidBR1`.

## Points clés

- `used_by` vide (vérifié par grep) ; seule trace : la chaîne `"ValidBR"` testée dans
  `Edbr.module:216`.
- Travail par tables de travail `BRfm`, `Br`, `Totalisation` recréées à chaque traitement,
  `LOCK TABLES` sur ~25 tables, ~45 membres non typés partagés.
- Code mort interne : `Quittedate`, `FileFilter`, `Bl_Sup`, `ard` (identique à
  `Facturergbl.ard`), `Button16_Click`.
- **Module complexe** : décision utilisateur requise avant toute phase 2.

## Dépendances principales

- Aucun appelant. Utilise `commande1`, `Edbr`, `Sha1Calc`, `LGed`, `LVar`, `Calculdroit`,
  `TriCpt`, `Utils`, `Cbase`.

## Risques

- Aucun en production tant que l'écran reste inaccessible ; maintenir ce code coûte des
  dépendances fictives (`LVar`, `LGed`, `Edbr`).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 1079 |
| Lignes de commentaire | 80 |
| Fonctions | 34 |
| Fonctions Public | 32 |
| Complexité cyclomatique totale | 231 |
| Complexité max (fonction) | 40 (`Gen_ecr`) |
| Variables globales | 0 |
| Variables Public | 3 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

3 tests prévus (VALIDBR-T01 à T03, liste à valider) : constat d'inaccessibilité ; deux replays
conditionnés au maintien de l'écran.

## Rework

3 étapes (VALIDBR-001 à 003) : documentation, code mort interne, réduction de portée — sans objet
si VALIDBR-A01 (suppression du couple `.class`/`.form`) est validée. 2 anomalies (A01, A02).
