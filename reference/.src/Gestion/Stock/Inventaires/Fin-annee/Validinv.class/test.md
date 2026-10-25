# Validinv — Tests

> Source : `.src/Gestion/Stock/Inventaires/Fin-annee/Validinv.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

> **Module complexe (inventaire)** : la liste des scénarios ci-dessous est **à faire valider par
> l'utilisateur avant la phase 2** (PLAN.md §0 et §4.5). La validation modifie le stock : tous les
> tests comparent le dump de `Fiches_Art` (`art_qte`, `art_stkdep`), `Fiches_Parametres.dteinv`,
> `Fiches_HisInvT` et `Fiches_Inv`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| VALIDINV-T01 | replay | Inventaire entièrement compté | `inv_fin_compte.sql` (toutes lignes `inv_comptee = 1`, écarts +, −, 0) ; « Lancer » ; « Oui » | `art_qte = art_stkdep = inv_qtecomptee` ; `dteinv` = date saisie ; `Fiches_HisInvT` vide ; `Fiches_Inv` conservée | `tests/valid_complet/` | à faire |
| VALIDINV-T02 | replay | Partiel, non saisis à zéro | `inv_fin_partiel.sql` ; `RadioButton1` | non saisis : `art_qte = art_stkdep = 0` | `tests/valid_zero/` | à faire |
| VALIDINV-T03 | replay | Partiel, non saisis conservés | idem ; `RadioButton2` | non saisis : `art_stkdep = art_qte` courant (≠ `inv_qtestock` si mouvement depuis la génération) | `tests/valid_conserve/` | à faire |
| VALIDINV-T04 | replay | Comptage nul explicite | ligne comptée à 0 vs ligne non comptée | 0 dans les deux cas avec `RadioButton1` ; distincts avec `RadioButton2` | `tests/valid_zero_compte/` | à faire |
| VALIDINV-T05 | replay | Refus | « Non » à la confirmation | dump identique (seul le fichier `mysqldump` est produit) | `tests/valid_non/` | à faire |
| VALIDINV-T06 | replay | Sans inventaire | table absente ; table vide | message « aucun inventaire » et fermeture | `tests/valid_absent/` | à faire |
| VALIDINV-T07 | replay | Mouvements postérieurs | BL et réception datés après la date saisie | stock non recalculé (figé CSTOCK-A01, lien CSTOCK-T09) | `tests/valid_mouvements/` | à faire |
| VALIDINV-T08 | replay | Date de validation ≠ date de génération | génération au 20/12, validation au 31/12 avec ventes entre les deux | `dteinv` = 31/12 ; stock = comptage (mouvements intermédiaires ignorés, figé A08) | `tests/valid_dates/` | à faire |
| VALIDINV-T09 | replay | Historique tournant | `Fiches_HisInvT` non vide | table vidée | `tests/valid_histo_t/` | à faire |
| VALIDINV-T10 | replay | Revalidation | relancer T01 une seconde fois | aucune alerte, résultat identique (figé A05) | `tests/valid_double/` | à faire |
| VALIDINV-T11 | replay | Article supprimé | ligne d'inventaire dont l'article a été supprimé, option « laisser » | erreur, validation partielle (figé A04) | `tests/valid_article_supprime/` | à faire |
| VALIDINV-T12 | replay | SQLite | T01 sur base SQLite | `TRUNCATE` en erreur après les mises à jour (figé A06) | `tests/valid_sqlite/` | à faire |
| VALIDINV-T13 | replay | Stock par dépôt | articles présents dans `Fiches_StkDepots` | `Fiches_StkDepots` et `Fiches_Sdepots` inchangés (figé A07) | `tests/valid_depots/` | à faire |
| VALIDINV-T14 | replay | Compta matière | option boissons (`/SocXX/bois`) ; inventaire avec articles à droits ; « Compta matière » | lignes `Fiches_ligregie` type `I` par régie (volumes) | `tests/compta_matiere/` | à faire |
| VALIDINV-T15 | replay | Compta matière déjà clôturée | ligne `I` existante à `arrete + 13 mois` | message « déjà une cloture », dump inchangé | `tests/compta_matiere_cloture/` | à faire |
| VALIDINV-T16 | replay | Sauvegarde | T01 | fichier `~/Sauve/LauruxInv.sqlAAAAMMJJ` présent (existence seulement) | `tests/valid_sauvegarde/` | à faire |

## Détail des tests

- Valeurs attendues produites dans le clone **Laurux non modifié** à partir des jeux dérivés
  `inv_fin_compte.sql`, `inv_fin_partiel.sql` (générés par GENINV-T01 puis saisies SAISIEINV-T02)
  et de `Laurux01.sql` ; date système figée.
- Dump normalisé : `dteinv` non masquée (saisie) ; le fichier `mysqldump` est exclu de la
  comparaison (horodaté, contient le mot de passe).
- Le `mysqldump` doit pouvoir s'exécuter contre la MariaDB Docker (identifiants de test).
- `son` jamais initialisé : aucun son, rien à neutraliser.
- Couverture visée : toutes les branches de `Button2_click` et `button4_Click`.
