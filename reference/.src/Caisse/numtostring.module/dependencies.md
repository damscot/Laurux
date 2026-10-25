# numtostring — Dépendances

> Source : `.src/Caisse/numtostring.module` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Caisse/numtostring.module` — module
- Handlers GUI détectés : 0
- ⚠️ Homonyme à la casse près (un seul `.gambas/` compilé pour les deux) : `.src/Utils/Numtostring.module`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Caisse/Caisse.class` | `nbtostring` |
| `.src/Compta/Relances/FRelFacture.class` | `<hérité>` |

### Utilise

_Aucune dépendance vers d'autres fichiers du projet._

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`Calc_unite`, `Calc_Dizaine`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Homonymie à la casse près** avec `.src/Utils/Numtostring.module` : `deps.py` et `links.py`
  traitent les deux fichiers comme distincts, mais Gambas n'en compile **qu'un**
  (`.gambas/NUMTOSTRING`, version `Utils`, qui contient `Num2Text` et pas `nbtostring`). Les
  appels relevés ici sont donc **fictifs à l'exécution** :
  - `Caisse.class:5064`, `5069` (`Imp_Cheque`) et `5149`, `5154` (`Imp_Cheque1`, sans appelant)
    appellent `numtostring.nbtostring`, symbole absent du module réellement chargé →
    NUMTOSTRING_CAISSE-A01 ;
  - `FRelFacture.class:464` (`numtostring.Num2Text`, `<inconnu:num2text>` pour `deps.py`) vise en
    réalité `Utils/Numtostring` (code d'ailleurs mort, l'appel de `Solde` étant commenté).
- **Portée réductible** : `Calc_unite`, `Calc_Dizaine` confirmés (appel interne seulement). Aucun
  `unused`, `arity_errors`, handler ni appel dynamique.
- **Limite d'outillage à documenter** : `deps.py`/`links.py` devraient signaler les classes dont les
  noms ne diffèrent que par la casse (collision dans `.gambas/`).
- **Ordre de rework** : la décision sur A01 précède tout rework de ce module et NUMTOSTRING-005
  (`Utils`) ; une correction touche `Caisse.class` (2 ou 4 appels) dans le même commit.
