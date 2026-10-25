# Cbilan — Tests

> Source : `.src/Reports/Cbilan.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

La logique de présentation des montants (`Level1`, `Level1L`, `Level1S`) se teste en gb.test en
appelant les niveaux avec des chaînes choisies et en comparant le texte `pdftotext -layout` du PDF
produit. Un replay vérifie le bilan complet sur le jeu comptable dérivé.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CBILAN-T01 | gbtest | Page de titre et en-têtes | `Level0`, `Level3` (`Sens` = `"A"`, `"P"`, `"1"`), `Lines`, `BasPage` | texte de référence | `tests/entetes/` | à faire |
| CBILAN-T02 | gbtest | Net de `Level1` | `Sens = "A"` : (`"100"`, `"30"`), (`"100"`, `"0"`), (`"100"`, `""`), (`"100"`, `"100"`), (`"1234.5"`, `"0.5"`), (`""`, `""`) ; `Sens = "P"` : (`"100"`, `"0"`) | colonnes brut / N de référence ; net nul → brut affiché (A01 figée) | `tests/level1_net/` | à faire |
| CBILAN-T03 | gbtest | Net de `Level1L` et `Level1S` | mêmes couples + brut négatif (`"-100"`, `"30"`) | valeurs de référence (A02 figée : `Abs` du brut dans `Level1L`) | `tests/level1L_level1S/` | à faire |
| CBILAN-T04 | gbtest | Multi-pages | `AliasNbPages`, 2 × (`Level0`, `Level3`, 40 `Level1`, `BasPage`) | `Page 1/2`, `Page 2/2` | `tests/multipages/` | à faire |
| CBILAN-T05 | replay | Bilan complet (`RubImp` → `Imp_Bilan`) | jeu comptable dérivé (comptes 1 à 5, une immobilisation totalement amortie), exercice courant | `pdftotext` de `~/tmp/Bilan.pdf` identique entre clones ; tables de travail exclues du dump | `tests/replay_bilan/` | à faire |

## Détail des tests

- **Outil commun** : extraction et normalisation des PDF (date, utilisateur, métadonnées) par le
  script commun `check_output.py` décrit dans [PdfWriter/test.md](../PdfWriter.class/test.md).
- **Valeurs attendues** : générées par le même module gb.test et le même scénario dans le clone
  **Laurux non modifié** ; `expected/` contient le texte extrait. Les anomalies A01/A02 sont figées.
- **Locale** : `fr_FR.UTF-8` obligatoire (le calcul passe par `Utils.cpoint` + `Val`, localisé ;
  vérifié avec gbs3 : `Val("1234.56")` vaut `Null` en locale française, `Val("1234,56")` vaut
  1234,56).
- **Normalisation** : date et `User.Name` du pied de page.
- **Données** : jeu dérivé de [Balance/test.md](../../Compta/Impressions/Balance.class/test.md),
  avec en plus une immobilisation (2…) totalement amortie (28…) pour exercer A01 en replay.
- **Couverture visée** : 100 % hors `Level1A`, `Level2`, `_free` (suppression prévue).
