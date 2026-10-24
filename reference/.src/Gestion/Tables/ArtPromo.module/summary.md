# ArtPromo — Synthèse

> Source : `.src/Gestion/Tables/ArtPromo.module` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Module d'accès à `Fiches_ArtPromo` (articles d'une promotion) : appartenance d'un article à une
promotion (`art_Promo`), prix HT/TTC et libellé promotionnels (`Prix_Promo`, `Prix_Promottc`,
`Intitule_Promo`), cumul de la quantité vendue en promotion (`Maj_qteplus`, `Maj_qtemoins`).

## Points clés

- 75 lignes, 6 fonctions `Public`, CC max 4 ; SQL paramétré et `Cbase.Table` partout.
- La même requête `SELECT … where code = &1 and code_promo = &2` est répétée six fois.
- `art_Promo` est déclarée `As String` mais calcule un booléen : elle renvoie `"T"` ou `""`,
  reconvertis en booléen par les appelants.
- Le code de la promotion en cours n'est pas fourni par le module : `Articles`, `Caisse` et
  `Facture` le recalculent chacun (première promotion active du jour).

## Dépendances principales

- Utilise : `Utils.db`, `Cbase.Table("TabArtPromo")`.
- Utilisé par : `Caisse` (13 appels), `Facture` (11), `TarArt` (2), `Articles` (1).

## Risques

- **ARTPROMO-A01** : mise à jour de `qte` en lecture puis écriture, sans verrou : perte possible
  d'une vente promotionnelle en caisse multi-postes.
- **ARTPROMO-A02** : une seule promotion active prise en compte par les appelants.
- Changement du type de retour d'`art_Promo` : 14 sites d'appel à vérifier.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 44 |
| Lignes de commentaire | 4 |
| Fonctions | 6 |
| Fonctions Public | 6 |
| Complexité cyclomatique totale | 16 |
| Complexité max (fonction) | 4 (`Maj_qtemoins`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

6 tests prévus (ARTPROMO-T01 à T06) : 5 `gbtest` sur base MariaDB jetable (appartenance, prix,
libellé, quantités avec `Null`, concurrence indicative) et 1 `replay` sur la promotion du jour vue
depuis `Articles`. Valeurs attendues capturées dans le clone non modifié.

## Rework

5 étapes sans changement de comportement (ARTPROMO-001 à 005) : documentation, helper de lecture,
helper de mise à jour des quantités, nouvelle fonction commune `PromoDuJour` (pour `Articles`,
`Caisse`, `Facture`), type de retour booléen d'`art_Promo`. 2 anomalies (A01, A02) soumises à
validation.
