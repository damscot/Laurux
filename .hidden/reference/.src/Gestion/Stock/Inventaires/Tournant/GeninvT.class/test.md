# GeninvT — Tests

> Source : `.src/Gestion/Stock/Inventaires/Tournant/GeninvT.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

> **Module complexe (inventaire)** : Décision utilisateur du 2026-11-18 : hors des 10 classes à revue manuelle,
> tests implémentés sans validation individuelle. Jeux `geninvt_shared/` (`art_stock`, `invt_vide`, `invt_genere`,
> `invt_valide`) et scénarios produits par `geninvt_shared/gen_geninvt.py`. Tous comparent le dump (`Fiches_InvT`).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| GENINVT-T01 | replay | Génération par familles (bornes par défaut), tri Casier | `Laurux01.sql` sans `Fiches_InvT` ; « Traitement » | dump `Fiches_InvT` : articles stockés de toutes les familles, ordre `art_fam, art_design` (tri ignoré, figé) | `tests/gen_familles/` | implémenté (`Gestion/geninvt_familles`) |
| GENINVT-T02 | replay | Plage de familles restreinte, tri Code article | `Fam`/`Fam2` = 2 familles ; radio `Ca` | articles des familles bornées, ordre `art_code, art_code` | `tests/gen_familles_code/` | implémenté (`Gestion/geninvt_familles_code`) |
| GENINVT-T03 | replay | Fournisseurs | `Fr` ; bornes par défaut puis plage d'un fournisseur ; tri Désignation | articles des fournisseurs bornés, ordre `art_four, art_design` | `tests/gen_fournisseurs/` | implémenté (`Gestion/geninvt_fournisseurs`) |
| GENINVT-T04 | replay | Casiers | `Cs` ; plage de casiers ; tri Casier | ordre `art_casier, art_design` | `tests/gen_casiers/` | implémenté (`Gestion/geninvt_casiers`) |
| GENINVT-T05 | replay | Bornes manquantes | `Fam2` vidé | message « Veuillez saisir les bornes » ; dump inchangé | `tests/gen_bornes/` | implémenté (`Gestion/geninvt_bornes`) |
| GENINVT-T06 | replay | Régénération (non validé) Oui / Non | `Fiches_InvT` existante avec comptages | Oui : recréée ; Non : inchangée | `tests/regen/` | implémenté (`Gestion/geninvt_regen_oui`, `Gestion/geninvt_regen_non`) |
| GENINVT-T07 | replay | Régénération d'un inventaire marqué validé | jeu dérivé : `inv_valid = 1` (validation interrompue) | question « détruire l'inventaire validé » | `tests/regen_valide/` | implémenté (`Gestion/geninvt_regen_valide`, réponse Oui) |
| GENINVT-T08 | replay | Première génération (table absente) | base sans `Fiches_InvT` | génération via le `Catch` (figé, GENINVT-A02) | `tests/gen_premiere/` | implémenté (`Gestion/geninvt_premiere`) |
| GENINVT-T09 | replay | Plage vide | bornes sans article | table créée vide ; « Aucun article » | `tests/gen_vide/` | implémenté (`Gestion/geninvt_vide`) |
| GENINVT-T10 | replay | Impression avec renumérotation | après T02, impression tri Désignation puis tri Code | `inv_nlig` renumérotés à chaque impression (dump, figé GENINVT-A01) ; texte PDF | `tests/imp_renum/` | implémenté (`Gestion/geninvt_imp_renum`, texte des 2 PDF dans `edition.txt`) |
| GENINVT-T11 | replay | Impression sans stock théorique / sans inventaire | case décochée ; table absente | colonne vide ; message d'erreur figé | `tests/imp_options/` | implémenté (`Gestion/geninvt_imp_sans_stock`, `Gestion/geninvt_imp_absent`) |
| GENINVT-T12 | replay | Listes de choix | `ToggleButton1..4`, sélection clavier (Entrée), Échap, F1 | bornes recopiées ; focus final (dont `Colfour2` → Quitter, figé GENINVT-A05) | `tests/listes_choix/` | implémenté partiellement (`Gestion/geninvt_listes_choix` : sélection par clic dans les 4 listes) ; à faire : Entrée, Échap, F1 dans les listes (Key.Code, touches non rejouées vers une ColumnView) et focus final (non comparé) |
| GENINVT-T13 | replay | Changement de critère répété | clics `Fm`/`Fr`/`Cs` × 3 puis génération | log : nombre d'événements enregistrés par clic (cumul `Utils.Observers`, GENINVT-A04) | `tests/criteres_observers/` | implémenté (`Gestion/geninvt_criteres` : 9 clics de critère puis génération unique) ; à faire : nombre d'événements journalisés par clic (enregistrement, non comparé) |
| GENINVT-T14 | replay | SQLite | T02 et T10 sur SQLite (`AutoIncrement` SQLite) | même contenu de `Fiches_InvT` | `tests/gen_sqlite/` | à faire : SQLite (bloqué) |

## Détail des tests

- Valeurs attendues produites dans le clone **Laurux non modifié** (dump normalisé ; la colonne
  `lind` est conservée car elle porte l'ordre de génération). Date système figée.
- Données : `Laurux01.sql` ; jeu dérivé `invt_valide.sql` (T07) ; plages choisies selon les
  familles/fournisseurs/casiers présents dans `Laurux01`.
- Rejeu des listes : `Colfam*_Click`/`Colfour*_Click` existent (pas de `replay_missing`) ; ils sont
  appelés par `Object.Call` et doivent rester `Public`.
- `Utils.Observers` est rappelé à chaque `Fm/Fr/Cs_Click` : vérifier dans T13 que le rejeu ne
  double pas les actions ; adapter les scénarios si c'est le cas.
- Non testable : musique, visualiseur PDF (neutralisés).
