# CPrix — Tests

> Source : `.src/Utils/CPrix.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CPRIX-T01 | gbtest | `Cascade` | `("100", "10")`, `("100,50", "2.5")`, `("0", "50")`, `("", "")`, `("abc", "10")`, remise négative ; 2 locales | chaînes de référence | `tests/cascade/` | implémenté |
| CPRIX-T02 | gbtest | `CTva` | `Laurux01.sql` ; codes TVA existants, inconnu, `""` | taux de référence | `tests/ctva/` | implémenté |

## Détail des tests

- Valeurs attendues produites dans le clone **Laurux non modifié** sous `LANG=fr_FR.UTF-8` et
  `LANG=C` (dépendance à la locale de `Val`).
- Les écrans appelants (`Articles`, `MajTarifM`, `Impart`) sont couverts par leurs propres replays.
- **Implémentation (phase 2)** : `.src/Tests/Utils/CPrixTest.test` ; T01 sous la locale du runner (fr_FR.UTF-8) puis `System.Language = "C"` dans le même processus ; T02 sur `Laurux01.sql` (`Fiches_Tvaav`).
