# ValidinvT — Tests

> Source : `.src/Gestion/Stock/Inventaires/Tournant/ValidinvT.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

> **Module complexe (inventaire)** : la liste des scénarios ci-dessous est **à faire valider par
> l'utilisateur avant la phase 2** (PLAN.md §0 et §4.5). Tous les tests comparent `Fiches_Art.art_qte`,
> `Fiches_Mvtexp`, `Fiches_HisInvT` et l'existence de `Fiches_InvT`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| VALIDINVT-T01 | replay | Tout compté | `invt_compte.sql` (écarts +, −, 0) ; « Validation » ; « Oui » | `art_qte` = comptage ; `Fiches_Mvtexp` : `qtep`/`qtem` pour les écarts non nuls ; `Fiches_HisInvT` `inv_num = 1` ; `Fiches_InvT` supprimée | `tests/valid_complet/` | à faire |
| VALIDINVT-T02 | replay | Partiel, non comptés à zéro | `invt_partiel.sql` ; `RadioButton1` | non comptés : `art_qte = 0` et sortie `qtem = inv_qtestock` | `tests/valid_zero/` | à faire |
| VALIDINVT-T03 | replay | Partiel, non comptés conservés | `RadioButton2` | `art_qte` inchangé **et** sortie `qtem` écrite (figé A02) | `tests/valid_conserve/` | à faire |
| VALIDINVT-T04 | replay | Deuxième inventaire tournant | `Fiches_HisInvT` contenant `inv_num = 1` | nouvel historique `inv_num = 2` | `tests/valid_num/` | à faire |
| VALIDINVT-T05 | replay | Refus | « Non » | dump identique | `tests/valid_non/` | à faire |
| VALIDINVT-T06 | replay | Sans inventaire | `Fiches_InvT` absente | message, fermeture ; `Fiches_HisInvT` créée si absente | `tests/valid_absent/` | à faire |
| VALIDINVT-T07 | replay | Déjà validé | `inv_valid = 1` sur la 1re ligne (validation interrompue) | message « déjà été validé » | `tests/valid_deja/` | à faire |
| VALIDINVT-T08 | replay | `Fiches_HisInvT` absente | base sans la table | table créée puis alimentée | `tests/valid_creation_histo/` | à faire |
| VALIDINVT-T09 | replay | Recalcul après validation | T01 puis T03, puis recalcul complet (`Calcstock`) | `art_qte` recalculé = comptage + mouvements (lien CSTOCK-T05) ; écart fictif des non comptés figé (A02) | `tests/valid_recalcul/` | à faire |
| VALIDINVT-T10 | replay | Mouvements entre génération et validation | vente après génération, avant comptage | `art_qte` immédiat vs après recalcul (figé A03) | `tests/valid_mouvements/` | à faire |
| VALIDINVT-T11 | replay | SQLite | T01 sur SQLite | même résultat ; `daterecpt` texte `AAAAMMJJ` (à comparer avec Cstock) | `tests/valid_sqlite/` | à faire |
| VALIDINVT-T12 | replay | Stock par dépôt | articles présents dans `Fiches_StkDepots` | inchangé (figé) | `tests/valid_depots/` | à faire |
| VALIDINVT-T13 | replay | Sauvegarde | T01 | fichier `~/Sauve/LauruxInvT.sqlAAAAMMJJ` : dump de la base `Laurux` (figé A01) | `tests/valid_sauvegarde/` | à faire |

## Détail des tests

- Valeurs attendues produites dans le clone **Laurux non modifié** ; jeux dérivés `invt_compte.sql`
  et `invt_partiel.sql` (GENINVT-T02 + SAISIEINVT-T02) ; date système figée.
- Dump normalisé : `Fiches_Mvtexp.mind` (auto-incrément) masqué, contenu trié.
- Pour T13, la base de test doit porter un nom ≠ `Laurux` pour montrer l'anomalie (fichier
  vide ou d'une autre base).
