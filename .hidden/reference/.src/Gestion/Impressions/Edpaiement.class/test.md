# Edpaiement — Tests

> Source : `.src/Gestion/Impressions/Edpaiement.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Tests `replay` avec comparaison du texte extrait de `~/tmp/Regl.pdf` (`pdftotext -layout`),
des lignes `Exec_SQL` et du dump normalisé (la table de travail `Paiements` est **exclue** du dump
ou comparée à part). Valeurs attendues produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EDPAIEMENT-T01 | replay | Toutes factures (`Fact`) | date avec factures `Fiches_Bl` et `Fiches_BlM`, 2 modes (chèque, espèces) | texte du PDF : groupes par mode, totaux singulier/pluriel | `tests/toutes_factures/` | à faire |
| EDPAIEMENT-T02 | replay | Entretien seul (`Face`) | `/Soc01/Materiel` = 1 ; `Face` | seulement `Fiches_BlM` | `tests/entretien/` | à faire |
| EDPAIEMENT-T03 | replay | Hors entretien (`Facn`) | `/Soc01/Materiel` = 1 ; `Facn` | seulement `Fiches_Bl` | `tests/hors_entretien/` | à faire |
| EDPAIEMENT-T04 | replay | Double règlement | facture avec `reg` et `reg2` | deux lignes (une par mode) | `tests/double_reglement/` | à faire |
| EDPAIEMENT-T05 | replay | Aucune facture | date sans facture | message « Aucun mouvement » | `tests/aucune_facture/` | à faire |
| EDPAIEMENT-T06 | replay | `dtefac` avec heure | facture de caisse (`dtefac` à 10:30) | facture absente (A01 figée) | `tests/dtefac_heure/` | à faire |
| EDPAIEMENT-T07 | replay | Saut de page | 60 règlements le même jour | pages successives, en-tête répété | `tests/saut_page/` | à faire |

## Détail des tests

- **Données** : jeu `facturation_base` (voir [ObjFac](../../Facturation/ObjFac.class/test.md)),
  complété de BL facturés `F` le même jour en `Fiches_Bl` et `Fiches_BlM` avec `reg`/`mtreg`,
  `reg2`/`mtreg2`, dont un `dtefac` avec heure (T06) ; un même `numbl` dans les deux tables pour
  observer A02 (cas à confirmer).
- **Comparaison** : `pdftotext` ; dump hors `Paiements` ; `Exec_SQL` (informatif : DDL de la table
  de travail, un `INSERT` par règlement).
- **Rejeu** : modal (`ShowModal`) ; `Utils.Observers` présent dans `_New`.
