# Ecomptamat — Dépendances

> Source : `.src/Gestion/option/Ecomptamat.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/option/Ecomptamat.class` — classe, formulaire associé `Ecomptamat.report`
- Handlers GUI détectés : 46

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/option/Caleditcmat.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Caleditcmat` | `ddcl` |
| `DB_Connection` | `Exec` |
| `Utils` | `db`, `lastday` |

### Tables SQL référencées

`Fiches_Parametres`, `Fiches_Societes`, `Fiches_ligregie`, `Fiches_regie`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Faux positifs `unused` (46) / `scope_reducible` (46) / `unused_transitive` (`convers`)** :
  handlers `Data` des contrôles de `Ecomptamat.report` (vérifié : tous les noms y sont déclarés,
  `ni` compris). `deps.py` n'analyse pas les `.report`.
- **Appelant** : `Caleditcmat.Edit` (`Caleditcmat.class:427`), qui passe toujours `edit = False`.
- **Dépendance circulaire** `Caleditcmat` ↔ `Ecomptamat` (`Caleditcmat.ddcl`, lignes 74-320) :
  ECOMPTAMAT-002 et EINVMAT-002 avant CALEDITCMAT-005.
- Lignes de `Fiches_ligregie` lues ici produites par `ObjFacB`, `Achat`, `fourconsdroi`, `Mvtex`
  (voir [atribvignette](../atribvignette.class/dependencies.md)).
