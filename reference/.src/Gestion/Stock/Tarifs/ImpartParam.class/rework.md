# ImpartParam — Rework

> Source : `.src/Gestion/Stock/Tarifs/ImpartParam.class` · Message de commit (phase 4) : `reference/.src/Gestion/Stock/Tarifs/ImpartParam.class/rework.md <REWORK_ID>`

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

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 782 | 206 | 27 | 0 | 39 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] IMPARTPARAM-001 — [documentation] En-tête de classe en français : structure d'une
  définition (`Fiches_ImpArtDef` + ligne de 161 colonnes de `Fiches_ImpArtDef2`), sens de
  `col_x`/`pos_x`/`db_x`/`lg_x`/`posorg_x`, modes `S`/`F`, lien avec `Impart` · appelants : aucun ·
  tests : T01, T02 · sources : [ImpartParam.class:EnregistreZones](../../../../../../.src/Gestion/Stock/Tarifs/ImpartParam.class#L663-L720), [ImpartParam.class:affiche_Selection](../../../../../../.src/Gestion/Stock/Tarifs/ImpartParam.class#L271-L330)
- [ ] IMPARTPARAM-002 — [code mort] `SELECT` inutilisé de `BtnRetirerZone_Click`, double remise à
  blanc de `posorg` dans `EnregistreZones`, lignes commentées (SQL modifié : une requête `SELECT`
  en moins, dump identique) · appelants : aucun · tests : T05 · sources : [ImpartParam.class:BtnRetirerZone_Click](../../../../../../.src/Gestion/Stock/Tarifs/ImpartParam.class#L722-L736), [ImpartParam.class:EnregistreZones](../../../../../../.src/Gestion/Stock/Tarifs/ImpartParam.class#L663-L720)
- [ ] IMPARTPARAM-003 — [complexité] `Champs_KeyPress` : procédure privée `EchangeZones(iSens)`
  pour les blocs `+`/`-` symétriques, même séquence d'appels ; CC 27 → ≤ 10 · appelants : aucun ·
  tests : T03, T04 · sources : [ImpartParam.class:Champs_KeyPress](../../../../../../.src/Gestion/Stock/Tarifs/ImpartParam.class#L768-L917)
- [ ] IMPARTPARAM-004 — [réduction de portée] `Lignes`, `affiche_Selection`, `DefColonnes`,
  `EnregistreZones`, `Renumerotation`, `Efface_Zone` → `Private` (couverts par T01-T07) ·
  appelants : aucun · tests : T01-T07 · sources : [ImpartParam.class:Lignes](../../../../../../.src/Gestion/Stock/Tarifs/ImpartParam.class#L45-L62), [ImpartParam.class:Efface_Zone](../../../../../../.src/Gestion/Stock/Tarifs/ImpartParam.class#L953-L965)
- [ ] IMPARTPARAM-005 — [commonalisation] Listes fournisseurs/familles/définitions et lecture de
  la définition partagées avec `Impart` dans une classe `LImpDef` (chargement d'une définition) ;
  même lot qu'IMPART-005 · appelants : aucun · tests : T06, IMPART-T01 · sources : [ImpartParam.class:affiche_Selection](../../../../../../.src/Gestion/Stock/Tarifs/ImpartParam.class#L271-L330), [ImpartParam.class:TgleBtnFour_Click](../../../../../../.src/Gestion/Stock/Tarifs/ImpartParam.class#L67-L102), [Impart.class:ChargementFichierDef](../../../../../../.src/Gestion/Stock/Tarifs/Impart.class#L1708-L1740)
- [ ] IMPARTPARAM-006 — [séparation traitement/GUI] `EnregistreZones` : lecture de `Champs` dans
  les tableaux d'un côté, écriture SQL `EcritZones(num, bSep)` de l'autre (mêmes requêtes, mêmes
  défauts) · appelants : aucun · tests : T01-T05 · sources : [ImpartParam.class:EnregistreZones](../../../../../../.src/Gestion/Stock/Tarifs/ImpartParam.class#L663-L720)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] IMPARTPARAM-A01 — [anomalie] Mode largeur fixe, définition existante (déplacement `+`/`-`) :
  `UPDATE` des zones 8-26 sans `col_i[21]` (paramètres décalés et manquants) puis `db_n[231]` →
  dépassement d'indice, erreur non interceptée dans `Champs_KeyPress` · tests : T04 · sources : [ImpartParam.class:689](../../../../../../.src/Gestion/Stock/Tarifs/ImpartParam.class#L689), [ImpartParam.class:690](../../../../../../.src/Gestion/Stock/Tarifs/ImpartParam.class#L690)
- [ ] IMPARTPARAM-A02 — [anomalie] Mode séparé, définition existante : paramètres dupliqués
  (`&{37}` pour `pos_25`/`col_26`, `&{41}` pour `col_28`/`pos_28`) et `UPDATE` invalide
  `set = posorg_30 …` · tests : T03 · sources : [ImpartParam.class:700](../../../../../../.src/Gestion/Stock/Tarifs/ImpartParam.class#L700), [ImpartParam.class:702](../../../../../../.src/Gestion/Stock/Tarifs/ImpartParam.class#L702)
- [ ] IMPARTPARAM-A03 — [anomalie] Mode largeur fixe, création : l'`INSERT` n'enregistre que les
  zones 1 à 15 et aucun `posorg` (zones 16-32 perdues) · tests : T02 · sources : [ImpartParam.class:694](../../../../../../.src/Gestion/Stock/Tarifs/ImpartParam.class#L694)
- [ ] IMPARTPARAM-A04 — [anomalie] `Btncreer_Click` : nouveau numéro = dernier `num` d'un
  `SELECT` sans `ORDER BY` + 1 (numéro existant possible) · tests : T08 · sources : [ImpartParam.class:925](../../../../../../.src/Gestion/Stock/Tarifs/ImpartParam.class#L925)
- [ ] IMPARTPARAM-A05 — [anomalie] Ergonomie : `Cmpt2_Gotfocus` colore le champ suivant (décalage
  de tag) ; `Pfic_Change` découpe l'aperçu par `";"` quel que soit le séparateur ; `Lignes` ne
  ferme pas le fichier · tests : T01 · sources : [ImpartParam.class:Cmpt2_Gotfocus](../../../../../../.src/Gestion/Stock/Tarifs/ImpartParam.class#L470-L482), [ImpartParam.class:Pfic_Change](../../../../../../.src/Gestion/Stock/Tarifs/ImpartParam.class#L499-L512), [ImpartParam.class:Lignes](../../../../../../.src/Gestion/Stock/Tarifs/ImpartParam.class#L45-L62)
