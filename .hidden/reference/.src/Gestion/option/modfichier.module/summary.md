# modfichier — Synthèse

> Source : `.src/Gestion/option/modfichier.module` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Crée à l'exécution les tables et colonnes des options boisson (`fichierboisson`) et carburant
(`fichiercarbu`) quand on coche l'option dans `Prefs` ; affiche une fenêtre d'attente (`commun`,
`supf`) et propose de recopier les frais en transport (`modiffrais`).

## Points clés

- **Modification de schéma hors `LauruxMaj`** : 8 tables (`Fiches_regie`, `Fiches_consigne`,
  `Fiches_ligcons`, `Fiches_ligregie`, `Fiches_region`, `Fiches_tarpp`, `Fiches_ligtarpp`,
  `Art_Tipp`) et ~45 colonnes (`tipp_ligbl`, `cli_tipp`, `cli_cons`, `art_dra`…) absentes de
  `db_control.csv` et des bases de référence ; recouvrement partiel avec `Maj369`.
- Toutes les requêtes sous `Try` : idempotent, mais échecs silencieux.
- Signalé sans rework de schéma (règle du plan) : corrections réservées à une future migration.

## Dépendances principales

- Utilisé par : `Prefs` (seul appelant).
- Schéma utilisé par tout le lot option (`ObjFacB`, `facopt`, `artopt`, `Calculdroit`…),
  `Facture`, `VerifDate`, `Utils.orientation`, `Parametre`.

## Risques

- A01 : types modifiés (`qte_ligbl` réduit à `char(8)`, `Fiches_Ligcom.qte` en `char`).
- A02 : options partiellement créées sous SQLite ; A03 : `modiffrais` en erreur ; A04 :
  `numadr_*` probablement jamais créées (lues par `ObjFacB`).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 172 |
| Lignes de commentaire | 22 |
| Fonctions | 5 |
| Fonctions Public | 3 |
| Complexité cyclomatique totale | 71 |
| Complexité max (fonction) | 32 (`fichiercarbu`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

5 tests `replay` (MODFICHIER-T01 à T05) via `Prefs` : boisson et carburant sous MySQL, copie des
frais, idempotence, SQLite ; comparaison du dump de structure.

## Rework

3 étapes (MODFICHIER-001 à 003) : documentation, boucle sur des tableaux de requêtes, séparation
fenêtre/DDL. 4 anomalies, toutes liées au schéma.
