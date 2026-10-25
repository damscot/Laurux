# Einvmat — Dépendances

> Source : `.src/Gestion/option/Einvmat.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/option/Einvmat.class` — classe, formulaire associé `Einvmat.report`
- Handlers GUI détectés : 33

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

`Fiches_Parametres`, `Fiches_Societes`, `Fiches_regie`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Faux positifs `unused` (33) / `scope_reducible` (33) / `unused_transitive` (`convers`)** :
  les `*_Data` sont des handlers de l'événement `Data` des `ReportLabel` déclarés dans
  `Einvmat.report` (vérifié : `lib`, `vaehldp` … `vapclfp2` y sont présents). `deps.py` ne lit
  pas les `.report` : limite d'outillage à corriger.
- **Appelant** : `Caleditcmat.Edit` (`Caleditcmat.class:431`).
- **Dépendance circulaire** `Caleditcmat` ↔ `Einvmat` : Caleditcmat crée le report ; le report
  écrit `Caleditcmat.ddcl` (lignes 62-231) et utilise la structure `Declaration`. Ordre de rework :
  EINVMAT-002 (variable locale) avant CALEDITCMAT-005 (suppression de `ddcl`), dans le même commit
  qu'ECOMPTAMAT-002.
- Commonalisation prévue avec Ecomptamat : EINVMAT-004 et ECOMPTAMAT-004 dans le même commit.
