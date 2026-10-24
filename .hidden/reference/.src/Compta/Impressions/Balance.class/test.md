# Balance — Tests

> Source : `.src/Compta/Impressions/Balance.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran sans logique isolable : tous les tests sont des `replay`. L'impression elle-même est testée
par les tests de [`BalanceM`](../BalanceM.module/test.md) (rendu PDF) ; ici on vérifie la
préparation des paramètres, l'export texte et les contrôles de saisie. Les valeurs attendues sont
produites dans le clone **Laurux non modifié** (anomalies comprises).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| BALANCE-T01 | replay | Bornes d'exercice | ouverture, puis clic sur `E1`, `N1` … `N5`, `E0` | contenu de `dteN0`/`dteN1` après chaque clic (log des contrôles) | `tests/bornes_exercice/` | à faire |
| BALANCE-T02 | replay | `Ex1` avec début d'exercice futur | jeu dont `dteclec` est postérieur à aujourd'hui ; ouverture | bascule sur `Exo` (dates de l'exercice précédent) | `tests/ex1_debut_futur/` | à faire |
| BALANCE-T03 | replay | Choix de la nature | clic `Bclient`, `Bfournisseur`, `Bgestion` puis **Imprimer** | `Cpt`, visibilité de `TypeClient1`, titre du PDF (« Balance client » / « Client ») | `tests/nature_balance/` | à faire |
| BALANCE-T04 | replay | Contrôle des dates | `dteN0` avant le début, puis `dteN1` après la fin, puis `dteN1 < dteN0` (Entrée) | messages, période remise sur `Exo`, `E0` coché (A04 figée), `Tab0` vu par l'impression suivante | `tests/controle_dates/` | à faire |
| BALANCE-T05 | replay | Saisie de date abrégée | `dteN0` = `0101`, `010119`, `1.1` | texte normalisé par `Cdate_calc`/`Cdate_aff` | `tests/date_abregee/` | à faire |
| BALANCE-T06 | replay | Export balance générale | `Bgestion`, plage 6… à 7…, **Exporter** | `~/balances.txt` (tous les comptes `B` présents : A02 figée) | `tests/export_generale/` | à faire |
| BALANCE-T07 | replay | Export client / fournisseur | `Bclient` puis `Bfournisseur`, **Exporter** | `Message.Error` SQL `cli_code` (A01 figée), fichier vide | `tests/export_client/` | à faire |
| BALANCE-T08 | replay | Export avec comptes non mouvementés | `Bgestion`, `Impc` coché puis décoché | lignes `compte;intitulé;;;` présentes / absentes | `tests/export_non_mouvementes/` | à faire |
| BALANCE-T09 | replay | Sélection de compte par `TriCpt` | F2 sur `Cpt` puis `Cpt2`, sélection d'une ligne ; idem en balance générale | `Cpt`/`Cpt2` remplis, `TriCpt` ouvert en mode `General` pour `G/B` | `tests/tricpt/` | à faire |
| BALANCE-T10 | replay | Export sans écriture | plage sans compte | message « Aucune ecriture pour cette demande » | `tests/export_vide/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` n'a **aucune écriture** (`Fiches_Mvt*` vides). Les tests utilisent un
  jeu dérivé commun aux éditions comptables (`Balance`, `BalanceM`, `Editcompte`, `EditcompteA`,
  `EditcompteM`, à mutualiser avec `Journaux*`) : `Laurux01.sql` + un script SQL d'écritures validées
  (`validee = 1`) et quelques non validées, réparties sur l'exercice courant (2019 → aujourd'hui) et
  l'exercice « en cours de bilan » (2018) dans `Fiches_Mvt`, et sur 2017 dans `Fiches_Mvt1` ; comptes
  clients `411…` liés à `Fiches_Cli` avec deux `cli_typec`, fournisseurs `401…`, comptes de gestion
  (6, 7) et de bilan (1 à 5), un compte collectif (`coll = 1`), un compte sans écriture, un compte
  soldé à zéro et un compte avec plus de 60 écritures (saut de page). Une écriture datée du dernier
  jour de la période à 12:00 permet de voir l'effet des filtres SQL `dte <= aaaammjj`.
- **Date du jour** : `Ex1` et les messages dépendent de `Now`. Les scénarios saisissent les dates
  explicitement, ou fixent l'horloge (`faketime`) pour T01/T02.
- **Comparaison** : `~/balances.txt` comparé tel quel ; la BDD n'est pas modifiée (le dump doit être
  identique avant/après). `Editeur.Prog_Editeur`, `Visualiseur.Prog` et `Doc.Open` sont neutralisés
  par la configuration (`/CmdEditor0`, `/Soc01/caisse/CmdVis` pointant vers un script de capture).
- **Non testable automatiquement** : son (`Music.Play`), coloration du focus (`SetEditColor`), aide
  HTML (`Doc.Open`).
