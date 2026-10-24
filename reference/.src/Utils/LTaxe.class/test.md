# LTaxe — Tests

> Source : `.src/Utils/LTaxe.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Classe de calcul pur, sans accès à la base : tous les tests sont de type `gbtest`. Les valeurs
attendues sont produites en phase 2 en exécutant les mêmes appels dans le clone **Laurux non
modifié** (sortie capturée dans `tests/<nom>/expected/`). Les anomalies sont figées telles quelles.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| LTAXE-T01 | gbtest | `_New` : conversions d'entrée | `"20%"`, `"5,5 %"`, `"3"`, `3`, `2.5`, `""`, `Null`, `0` | `Montant(LPrix(100), True).G` par cas ; `Pct` déduit | `tests/conversion_entree/` | à faire |
| LTAXE-T02 | gbtest | Signe des remises | `New LTaxe("3", LTaxe.Remise)`, `Deconsigne`, `TVA` | montant négatif pour Remise/Deconsigne | `tests/signe_remise/` | à faire |
| LTAXE-T03 | gbtest | `Ttx` aller-retour | chaque type de `Aucune` à `Marge` | `Ttx` relu identique | `tests/type_taxe/` | à faire |
| LTAXE-T04 | gbtest | `Cpt` valide | TVA + `"44571"`, TVA + `""`, Remise + `"709"` | `Cpt` relu ; `change` levé | `tests/compte_valide/` | à faire |
| LTAXE-T05 | gbtest | `Montant` en pourcentage HT | 20 % sur `LPrix(100)`, `LPrix(12.34)`, `LPrix(-5)` | Float de référence | `tests/montant_pct_ht/` | à faire |
| LTAXE-T06 | gbtest | `Montant` en pourcentage TTC | 20 % sur `LPrix(120)`, 0 % sur `LPrix(50)`, `TTC = True` | 20 ; 0 | `tests/montant_pct_ttc/` | à faire |
| LTAXE-T07 | gbtest | `Montant` fixe | `New LTaxe(2.5, LTaxe.Fixe)` sur prix de qté 1 et 3 | Float de référence | `tests/montant_fixe/` | à faire |
| LTAXE-T08 | gbtest | Quantité ≠ 1 (anomalie A01 + LPRIX-A01) | prix `New LPrix(10, 3)`, `ignore_quantite` False/True | `.Mnt`, `.Qte`, `.G` du résultat figés (Qte = 1, Mnt = total) | `tests/montant_quantite/` | à faire |
| LTAXE-T09 | gbtest | Arrondi et compte propagés | prix `Arr_005`, taxe avec compte `"44571"` | `.Arr` et `.Cpt` du résultat | `tests/montant_arr_cpt/` | à faire |
| LTAXE-T10 | gbtest | Listes statiques | `LTaxe.All_Taxes`, `LTaxe.All_Remises`, `LTaxe.TxLast` | contenus figés | `tests/listes_types/` | à faire |

## Détail des tests

- **Génération des valeurs attendues** : un module gb.test exécute les appels ci-dessus dans le
  clone Laurux non modifié et écrit une ligne `id;valeur` par cas dans `expected/` ;
  `check_output.py` compare avec une tolérance de 1e-9 sur les Float.
- **Données** : aucune base n'est nécessaire.
- **Non testable en gb.test** : les chemins d'erreur `Message.Error` (type hors bornes, compte non
  `445` pour la TVA) bloquent sans GUI. Ils deviennent testables après la séparation
  traitement/GUI (LTAXE-004) via les prédicats purs ; d'ici là, test manuel documenté.
- **Couverture visée** : 100 % des lignes hors branches `Message.Error`.
- T08 doit être repassé avec LPRIX-T12 : il fige le couplage décrit dans LTAXE-A01.
