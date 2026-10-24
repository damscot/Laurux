# Editcompte — Tests

> Source : `.src/Compta/Impressions/Editcompte.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran : tests `replay`. Le rendu PDF (bouton **Imprimer**) est couvert par
[`EditcompteM`](../EditcompteM.module/test.md) ; ici : bornes, contrôles de saisie, export texte et
table `Ctrln`. Valeurs attendues produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EDITCOMPTE-T01 | replay | Ouverture et bornes d'exercice | ouverture (date du jour fixée), puis `E1`, `N1`…`N5`, `E0` | `dteN0`/`dteN1`, `cpt`/`cpt2` (`411999999`) après chaque étape | `tests/bornes_exercice/` | à faire |
| EDITCOMPTE-T02 | replay | Ouverture avec début d'exercice futur | jeu où `dteclec` est postérieur à aujourd'hui | dates affichées (chemin `Exo` de `_New`) | `tests/ouverture_debut_futur/` | à faire |
| EDITCOMPTE-T03 | replay | Contrôle du préfixe de compte | pour chaque nature, Entrée sur `cpt` puis `cpt2` avec un compte valide et un invalide | messages et focus ; en gestion, `cpt2` toujours refusé (A01 figée) | `tests/controle_compte/` | à faire |
| EDITCOMPTE-T04 | replay | Contrôle des dates | `dteN0` hors période, `dteN1` avant le début, après la fin, `dteN1 < dteN0` | messages, focus (`dteN0` pour A03), période remise sur `Exo` (A04) | `tests/controle_dates/` | à faire |
| EDITCOMPTE-T05 | replay | Export grand livre client | `Bclient`, période courante, **Exporter** | `~/tmp/Glivre.txt` de référence | `tests/export_client/` | à faire |
| EDITCOMPTE-T06 | replay | Export avec compte centralisé | compte `cent_cc = 1` avec écritures sur 3 mois et 2 journaux | lignes « Centralisation » mensuelles ; dump : contenu final de `Ctrln` | `tests/export_centralise/` | à faire |
| EDITCOMPTE-T07 | replay | Export grand livre général | `Bgen`, 10000 → 99999999 | comptes `B` puis `G`, ordre `type_cc, compte` | `tests/export_general/` | à faire |
| EDITCOMPTE-T08 | replay | Export sans compte | plage vide, puis un export normal | message « Aucune ecriture… » ; le second export réussit malgré le fichier resté ouvert (A05) | `tests/export_vide/` | à faire |
| EDITCOMPTE-T09 | replay | `TriCpt` | F2 sur `cpt` en `Bgen` puis en `Bclient` | `TriCpt` en mode `Tous` puis `Client` ; `cpt` rempli | `tests/tricpt/` | à faire |
| EDITCOMPTE-T10 | replay | Export sur exercice archivé | `N2`, **Exporter** | lecture de `Fiches_Mvt2` | `tests/export_n2/` | à faire |

## Détail des tests

- **Données** : jeu dérivé commun aux éditions comptables (voir [Balance](../Balance.class/test.md)),
  avec en plus un compte centralisé (`cent_cc = 1`) mouvementé sur plusieurs mois et journaux, et des
  écritures dans `Fiches_Mvt2`.
- **Base** : l'export **écrit** en base (table `Ctrln`, détruite et recréée) : le dump après le test est
  comparé à la référence (contenu de `Ctrln` inclus). Le diff `Exec_SQL` est informatif.
- **Date du jour** : `_New` et `Ex1` dépendent de `Now` : `faketime` pour T01/T02, dates saisies sinon.
- **`finmois`** : couvert par T06 (fins de mois 28/29/30/31 dans le jeu, dont février bissextile) ; un
  test `gbtest` direct est porté par [EditcompteM](../EditcompteM.module/test.md) (fonction identique).
- **Non testable automatiquement** : son, coloration du focus, aide HTML, ouverture de l'éditeur
  (neutralisée par `/CmdEditor0`).
