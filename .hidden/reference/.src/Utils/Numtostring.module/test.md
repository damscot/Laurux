# Numtostring — Tests

> Source : `.src/Utils/Numtostring.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Module de calcul pur : tests `gbtest` sur l'API `Public`. Valeurs attendues produites en phase 2 en
exécutant les appels dans le clone **Laurux non modifié** (caractérisation, anomalies comprises).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| NUMTOSTRING-T01 | gbtest | `Num2Text` 0-100 | 0 à 100 | 101 chaînes de référence | `tests/num2text_0_100/` | à faire |
| NUMTOSTRING-T02 | gbtest | `Num2Text` grands nombres | 101, 200, 500, 800, 999, 1000, 1001, 1999, 2000, 21 000, 999 999, 1 000 000, 1 000 001, 2 500 000, 10⁹, 10¹², 1,5·10¹², 3·10¹² | chaînes de référence (dont `"un million zéro"`, `Null`) | `tests/num2text_grands/` | à faire |
| NUMTOSTRING-T03 | gbtest | `Convertir` cas nominaux | 1 ; 2 ; 1,01 ; 2,50 ; 1234,56 ; devise `Null`, `"euros"`, `"dollar"` | chaînes de référence | `tests/convertir_nominal/` | à faire |
| NUMTOSTRING-T04 | gbtest | `Convertir` centimes seuls et bords | 0 ; 0,01 ; 0,29 ; 0,999 ; 2,004 ; 2,456 ; 2,4999 | figer `""`, troncatures et erreurs de Float | `tests/convertir_bords/` | à faire |
| NUMTOSTRING-T05 | gbtest | `Convertir` négatifs | -1 ; -0,5 ; -1234,56 | préfixe `"Moins "` | `tests/convertir_negatifs/` | à faire |
| NUMTOSTRING-T06 | gbtest | `palabraPlural` | `"euro"` | `"euro"` | `tests/pluriel/` | à faire |
| NUMTOSTRING-T07 | replay | Total en lettres sur facture | facture avec option « document en lettre » (`ObjFac`) | ligne « Total document : … » du document | `tests/facture_en_lettres/` | à faire |

## Détail des tests

- `gen_input.py` génère la liste des entrées de T01/T02 ; `check_output.py` compare une ligne
  `entrée;sortie` par cas à `expected/`, à l'octet près (espaces finaux significatifs).
- T07 couvre l'intégration avec `ObjFac` (les tests propres à `ObjFac` le réutiliseront).
- Couverture visée : 100 % des lignes sauf la ligne morte l.137.
