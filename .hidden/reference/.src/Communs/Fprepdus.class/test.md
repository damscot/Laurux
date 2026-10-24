# Fprepdus — Tests

> Source : `.src/Communs/Fprepdus.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Fenêtre d'affichage sans écriture en base : `replay` sur les textes affichés, puis `gbtest` sur la
fonction de calcul après la séparation (FPREPDUS-003). Valeurs attendues produites dans le clone
**Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FPREPDUS-T01 | replay | Synthèse sur la base de référence | `Laurux01.sql` ; clic sur `lblClm3` | textes de `TextLabel1`, `TextLabel2`, `TextLabel5` (date masquée) | `tests/synthese_reference/` | à faire |
| FPREPDUS-T02 | replay | Jeu dérivé contrôlé | 3 clients (+100 ; +50,5 ; -20), 2 fournisseurs (-300 ; +10) | « 2 clients … 150,50 Euros » ; « … -300,00 Euros réparti sur 1 fournisseurs » (signe et pluriel figés, A01) | `tests/synthese_jeu/` | à faire |
| FPREPDUS-T03 | replay | Aucun dû | soldes tous nuls | « Aucun dû client/fournisseur à ce jour ! » | `tests/aucun_du/` | à faire |
| FPREPDUS-T04 | replay | Devise | `devise` = NULL, « EUR », « Euros » ; table `Fiches_Parametres` vide | « Euros », « EURs », « Euros », devise vide | `tests/devise/` | à faire |
| FPREPDUS-T05 | gbtest | `SyntheseDus` (après FPREPDUS-003) | jeu de T02 | `[2, 150.5]`, `[1, -300]` | `tests/calcul/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` dans MariaDB Docker ; le jeu de T02 met à jour `solde` de comptes
  `411…`/`401…` existants par script SQL.
- **Comparaison** : textes relevés par le replay ; la date du titre est masquée.
- **Couverture visée** : 100 % des lignes.
