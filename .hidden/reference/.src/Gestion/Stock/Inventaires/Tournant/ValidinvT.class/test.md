# ValidinvT — Tests

> Source : `.src/Gestion/Stock/Inventaires/Tournant/ValidinvT.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

> **Module complexe (inventaire)** : Scénarios validés par l'utilisateur le 2026-11-16 : T01-T10, T12, T13 ;
> T11 bloqué (SQLite). Tous les tests comparent `Fiches_Art.art_qte`,
> `Fiches_Mvtexp`, `Fiches_HisInvT` et l'existence de `Fiches_InvT`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| VALIDINVT-T01 | replay | Tout compté | `invt_compte.sql` (écarts +, −, 0) ; « Validation » ; « Oui » | `art_qte` = comptage ; `Fiches_Mvtexp` : `qtep`/`qtem` pour les écarts non nuls ; `Fiches_HisInvT` `inv_num = 1` ; `Fiches_InvT` supprimée | `tests/valid_complet/` | implémenté (`Gestion/validinvt_complet`) |
| VALIDINVT-T02 | replay | Partiel, non comptés à zéro | `invt_partiel.sql` ; `RadioButton1` | non comptés : `art_qte = 0` et sortie `qtem = inv_qtestock` | `tests/valid_zero/` | implémenté (`Gestion/validinvt_zero`) |
| VALIDINVT-T03 | replay | Partiel, non comptés conservés | `RadioButton2` | `art_qte` inchangé **et** sortie `qtem` écrite (figé A02) | `tests/valid_conserve/` | implémenté (`Gestion/validinvt_conserve`, A02 figée : 002 conservé à 10 et sortie qtem 10) |
| VALIDINVT-T04 | replay | Deuxième inventaire tournant | `Fiches_HisInvT` contenant `inv_num = 1` | nouvel historique `inv_num = 2` | `tests/valid_num/` | implémenté (`Gestion/validinvt_num`, jeu invt_histo) |
| VALIDINVT-T05 | replay | Refus | « Non » | dump identique | `tests/valid_non/` | implémenté (`Gestion/validinvt_non`, « Non » par Tab puis Espace) |
| VALIDINVT-T06 | replay | Sans inventaire | `Fiches_InvT` absente | message, fermeture ; `Fiches_HisInvT` créée si absente | `tests/valid_absent/` | implémenté (`Gestion/validinvt_absent`, jeu invt_absent : Fiches_HisInvT créée vide) |
| VALIDINVT-T07 | replay | Déjà validé | `inv_valid = 1` sur la 1re ligne (validation interrompue) | message « déjà été validé » | `tests/valid_deja/` | implémenté (`Gestion/validinvt_deja`, jeu invt_deja) |
| VALIDINVT-T08 | replay | `Fiches_HisInvT` absente | base sans la table | table créée puis alimentée | `tests/valid_creation_histo/` | implémenté (`Gestion/validinvt_creation_histo`, jeu invt_sans_histo) |
| VALIDINVT-T09 | replay | Recalcul après validation | T01 puis T03, puis recalcul complet (`Calcstock`) | `art_qte` recalculé = comptage + mouvements (lien CSTOCK-T05) ; écart fictif des non comptés figé (A02) | `tests/valid_recalcul/` | implémenté (`Gestion/validinvt_recalcul` : invt_partiel « conservés » puis Recalcul des stocks, tous les produits : 001 = 12, 003 = 5, 002 non compté recalculé à -10 (pas d'historique, sortie fictive qtem 10 reprise : A02 figée)) |
| VALIDINVT-T10 | replay | Mouvements entre génération et validation | vente après génération, avant comptage | `art_qte` immédiat vs après recalcul (figé A03) | `tests/valid_mouvements/` | implémenté (`Gestion/validinvt_mouvements`, jeu invt_mouvements : vente BL du 10/06 ; 001 = 12 juste après la validation (vente ignorée), 10 après le recalcul : A03 figée) |
| VALIDINVT-T11 | replay | SQLite | T01 sur SQLite | même résultat ; `daterecpt` texte `AAAAMMJJ` (à comparer avec Cstock) | `tests/valid_sqlite/` | à faire : SQLite (bloqué) |
| VALIDINVT-T12 | replay | Stock par dépôt | articles présents dans `Fiches_StkDepots` | inchangé (figé) | `tests/valid_depots/` | implémenté (`Gestion/validinvt_depots`, jeu invt_depots : Fiches_StkDepots inchangé, A07 figée) |
| VALIDINVT-T13 | replay | Sauvegarde | T01 | fichier `~/Sauve/LauruxInvT.sqlAAAAMMJJ` : dump de la base `Laurux` (figé A01) | `tests/valid_sauvegarde/` | implémenté (`Gestion/validinvt_sauvegarde` : trace mysqldump (mot de passe masqué) sur la base « Laurux » en dur, ~/Sauve/LauruxInvT.sql20180615 = en-tête seul (base inconnue), A01 figée) |

## Détail des tests

- Valeurs attendues produites dans le clone **Laurux non modifié** ; jeux dérivés `invt_compte.sql`
  et `invt_partiel.sql` (GENINVT-T02 + SAISIEINVT-T02) ; date système figée.
- **Phase 2 (implémentation)** : scénarios `.hidden/Tests/Gestion/assets/validinvt_*` (menu Gestion › Stock ›
  Inventaire tournant › Validation, `Menu100`), jeux `validinvt_shared/` : `invt_compte` (001 : 10 → 12, 002 : 10 → 7,
  003 : 0 → 0, tout compté), `invt_partiel` (002 non compté, 003 : 0 → 5), `invt_histo`, `invt_deja`, `invt_sans_histo`,
  `invt_absent`, `invt_depots`, `invt_mouvements` ; Fiches_InvT créée avec la structure de GeninvT, articles 001-003
  stockés (`art_stocke = 1`), date 2018-06-15. Le mysqldump de la ligne 71 vise la base `Laurux` absente du serveur
  de test : tous les scénarios le subissent (erreur 1049 en console, sans effet sur le dump).
- Dump normalisé : `Fiches_Mvtexp.mind` (auto-incrément) masqué, contenu trié.
- Pour T13, la base de test doit porter un nom ≠ `Laurux` pour montrer l'anomalie (fichier
  vide ou d'une autre base).
