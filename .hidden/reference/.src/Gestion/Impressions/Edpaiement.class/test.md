# Edpaiement — Tests

> Source : `.src/Gestion/Impressions/Edpaiement.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Tests `replay` avec comparaison du texte extrait de `~/tmp/Regl.pdf` (`pdftotext -layout`),
des lignes `Exec_SQL` et du dump normalisé (la table de travail `Paiements` est **exclue** du dump
ou comparée à part). Valeurs attendues produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EDPAIEMENT-T01 | replay | Toutes factures (`Fact`) | date avec factures `Fiches_Bl` et `Fiches_BlM`, 2 modes (chèque, espèces) | texte du PDF : groupes par mode, totaux singulier/pluriel | `tests/toutes_factures/` | implémenté |
| EDPAIEMENT-T02 | replay | Entretien seul (`Face`) | `/Soc01/Materiel` = 1 ; `Face` | seulement `Fiches_BlM` | `tests/entretien/` | implémenté |
| EDPAIEMENT-T03 | replay | Hors entretien (`Facn`) | `/Soc01/Materiel` = 1 ; `Facn` | seulement `Fiches_Bl` | `tests/hors_entretien/` | implémenté |
| EDPAIEMENT-T04 | replay | Double règlement | facture avec `reg` et `reg2` | deux lignes (une par mode) | `tests/double_reglement/` | implémenté |
| EDPAIEMENT-T05 | replay | Aucune facture | date sans facture | message « Aucun mouvement » | `tests/aucune_facture/` | implémenté |
| EDPAIEMENT-T06 | replay | `dtefac` avec heure | facture de caisse (`dtefac` à 10:30) | facture absente (A01 figée) | `tests/dtefac_heure/` | implémenté |
| EDPAIEMENT-T07 | replay | Saut de page | 60 règlements le même jour | pages successives, en-tête répété | `tests/saut_page/` | implémenté |

## Détail des tests

- **Données** : jeu `facturation_base` (voir [ObjFac](../../Facturation/ObjFac.class/test.md)),
  complété de BL facturés `F` le même jour en `Fiches_Bl` et `Fiches_BlM` avec `reg`/`mtreg`,
  `reg2`/`mtreg2`, dont un `dtefac` avec heure (T06) ; un même `numbl` dans les deux tables pour
  observer A02 (cas à confirmer).
- **Comparaison** : `pdftotext` ; dump hors `Paiements` ; `Exec_SQL` (informatif : DDL de la table
  de travail, un `INSERT` par règlement).
- **Rejeu** : modal (`ShowModal`) ; `Utils.Observers` présent dans `_New`.
- **Implémentation (vague 5)** : jeu `.hidden/Tests/Gestion/assets/edpaiement_shared/edpaiement_base.sql`
  (Fiches_Bl B00101/B00102, Fiches_BlM M00201/M00202 au 15/06/2018, B00104 au 14/06) ; scénarios
  `edpaiement_toutes_factures` (T01), `edpaiement_entretien` (T02, `/Soc01/Materiel` = true, `Face`),
  `edpaiement_hors_entretien` (T03, `Facn`), `edpaiement_double_reglement` (T04, jeu `edpaiement_double.sql`),
  `edpaiement_aucune_facture` (T05 : Laurux01 sans facture, date du jour), `edpaiement_dtefac_heure` (T06, jeu
  `edpaiement_heure.sql`), `edpaiement_saut_page` (T07, jeu `edpaiement_soixante.sql`, 2 pages). Texte du PDF par
  `pdftotext` (`edition.txt`). Le `numbl` commun aux deux tables (A02) n'est pas couvert.
- **Saisie de date non rejouée** : une date saisie dans `Date1` (« 16.06.2018 » + Entrée) suivie de Imprimer
  n'ouvre pas la boîte « Aucun mouvement » attendue (rejeu en code 3, fenêtre active Edpaiement) ; T05 utilise donc
  la date du jour sur Laurux01 sans facture. Cause non établie (à examiner).
