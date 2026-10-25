# EditStkDepart — Dépendances

> Source : `.src/Gestion/option/EditStkDepart.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/option/EditStkDepart.class` — classe, formulaire associé `EditStkDepart.report`
- Handlers GUI détectés : 0

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/option/Caleditcmat.class` | `<type>`, `depart`, `fin`, `inventaire`, `tournant` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `LDate` | `_call` |
| `Start` | `B`, `G`, `R` |
| `Utils` | `db` |
| `calculdroit` | `<type>`, `vol`, `volap`, `volumess` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Inv`, `Fiches_InvT`, `Fiches_regie`

### Membres Public sans usage externe détecté (portée réductible ?)

`nomInv`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelant unique** : `Caleditcmat.editinv` (`Caleditcmat.class:924-930`), via les boutons
  `inv`, `invt`, `stdep` (groupe du contrôle `Button3`), `stock`. Les quatre valeurs de
  l'énumération sont lues par `Caleditcmat.class:898`, `:904`, `:910`, `:917`.
- **`scope_reducible` : `nomInv`** — confirmé par `grep -rn nomInv .src/` (seule lecture ligne 41).
- **`Calculdroit`** : chaque ligne instancie un `Calculdroit`, qui exécute lui-même des requêtes
  (`Fiches_regie`, `Fiches_Tvaav`, `Fiches_Parametres`) ; ces tables ne figurent pas dans le bloc
  généré. Toute modification de `calculdroit` change les volumes imprimés ici.
- Le `.report` n'est pas analysé par `deps.py` : le contrôle `ligne` (`ReportHBox`) est utilisé
  comme variable par le code.
