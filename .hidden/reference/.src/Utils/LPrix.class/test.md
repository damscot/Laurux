# LPrix — Tests

> Source : `.src/Utils/LPrix.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Classe de calcul pur, sans accès à la base : tous les tests sont de type `gbtest`. Les valeurs
attendues sont produites en phase 2 en exécutant les mêmes appels dans le clone **Laurux non
modifié** (sortie capturée dans `tests/<nom>/expected/`), et non déduites de la lecture du code.
Les anomalies connues sont donc figées telles quelles (tests de caractérisation).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| LPRIX-T01 | gbtest | `_New`/`_call` : conversions d'entrée | `"-3,1500"`, `"1 234.5"`, `3`, `2.5`, `""`, `Null` | `.Mnt` attendu par cas | `tests/conversion_entree/` | à faire |
| LPRIX-T02 | gbtest | Formats `.L`/`.D`/`.G` | montants ± et quantités × 9 arrondis `Arr_*` | chaînes et Float de référence | `tests/formats_sortie/` | à faire |
| LPRIX-T03 | gbtest | `Arrondi_Calc` via `.G`, arrondis « au 5 » | 0,03 → Arr_005 ; 2,47 / 2,42 / 2,49 → Arr_005 ; -3,15 → Arr_01 ; valeurs < 1e-4 | valeurs de référence | `tests/arrondi_5/` | à faire |
| LPRIX-T04 | gbtest | Propriété `Arr` aller-retour | toutes les énumérations, String `"0,05"`, Float `0.5` | libellé ; cas `Arr_00005`/`Arr_00001` → `""` (anomalie figée) | `tests/arrondi_libelle/` | à faire |
| LPRIX-T05 | gbtest | `.Q`/`.QD` lecture/écriture | qtés 1,23456 / 0 / -2 ; `QD = "5"` | figer l'anomalie `QD_Write` → `Mnt` | `tests/quantite/` | à faire |
| LPRIX-T06 | gbtest | Matrice `Conv_Brut_Net_HT_TTC` | jeu de l'`Internal_Test` actuel : remise 3 + TVA 20 %, 4 × 4 conversions, + 4 compositions | 20 Float de référence | `tests/conversion_matrice/` | à faire |
| LPRIX-T07 | gbtest | `ignore_taxe` | mêmes taxes, `ignore_taxe = [LTaxe.TVA]` puis `[LTaxe.Remise]` | Float de référence | `tests/ignore_taxe/` | à faire |
| LPRIX-T08 | gbtest | Propriétés `Pu*`/`Tot*` lecture | `tot` de T06 avec `Qte` = 1, 2, 0 | `.L` des 8 propriétés | `tests/pu_tot_lecture/` | à faire |
| LPRIX-T09 | gbtest | Propriétés `Pu*`/`Tot*` écriture | affectation d'un `LPrix` sur chaque propriété | `Mnt` résultant ; `TotBHT` avec `Qte = 0` | `tests/pu_tot_ecriture/` | à faire |
| LPRIX-T10 | gbtest | Cumuls `Add`/`AddA`/`Sub`/`SubA`/`Sum`/`SumA`/`Abs` | liste de prix d'arrondis différents | `Mnt` attendu ; nombre d'événements `change` levés | `tests/cumuls/` | à faire |
| LPRIX-T11 | gbtest | Taxes `Add_Taxe`/`Del_Taxe`/`Lit_Taxe` | ajout, remplacement, suppression, lecture d'un type absent | booléens et objets attendus | `tests/taxes/` | à faire |
| LPRIX-T12 | gbtest | `_call` avec quantité (anomalie) | `LPrix("10", 3).Qte` ; `LTaxe.Montant` sur qté 3 | figer la valeur actuelle (qté ignorée) | `tests/call_quantite/` | à faire |
| LPRIX-T13 | gbtest | Événement `change` | chaque mutateur Public et chaque propriété en écriture | levé / non levé (`Abs`) | `tests/evenement_change/` | à faire |
| LPRIX-T14 | gbtest | Performance | 100 000 `LPrix(…).TotNTC.L` avec 2 taxes | durée de référence (`gbx3 -p`) | `tests/perf_conversion/` | à faire |

## Détail des tests

- **Erreurs** : les cas qui déclenchent `Message.Error` (arrondi invalide, `Arr = ""`) ne peuvent
  pas tourner en gb.test sans GUI. On les isole via `Arrondi_Conv` après la séparation
  traitement/GUI (rework LPRIX-006), ou on les exclut et on les documente comme replay manuel.
- **`gen_input.py` / `check_output.py`** : T02 et T06 génèrent la matrice d'entrées (CSV) ;
  `check_output.py` compare la sortie gb.test (une ligne `id;valeur` par cas) à `expected/`,
  avec une tolérance de 1e-9 sur les Float.
- **Couverture visée** : 100 % des lignes hors `_get`/`_put`, dont la suppression comme code mort
  est prévue (LPRIX-002).
