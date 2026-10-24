# Ccomptes — Dépendances

> Source : `.src/Compta/Ccomptes.module` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Ccomptes.module` — module
- Handlers GUI détectés : 0
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Deb4`, `Deb5`, `Deb6`, `Deb7`, `Deb8`, `Deb9`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Compta/Tables/FComptes.class` | `Colco_Data`, `Deb2`, `Deb3`, `Tris` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Start` | `LocalSettings`, `Societe` |
| `Utils` | `Base3`, `cpoint`, `rs3` |

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`Deb4`, `Deb5`, `Deb6`, `Deb7`, `Deb8`, `Deb9`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Appelant unique confirmé par `grep -rn "Ccomptes\." .src` : `FComptes.class` (l. 50, 723, 729,
  767, 786, 800, 819, 828, 831).
- `Deb4`…`Deb9` : aucun appel `Ccomptes.Deb4…9`. Les `Deb4()`, `Deb7()`, `Deb8()` de
  `Tricartes`, `TriclientsD` et `Facture` sont des méthodes locales homonymes.
- Table : `Fiches_Comptes`, passée en paramètre (`Cbase.Table("TabComptes")`) par `FComptes`,
  donc non détectée par `deps.py` dans ce module.
- Couplage implicite : `Utils.rs3` est partagé avec tout écran utilisant `Utils.Base3`.
- Ordre de rework : avec `FComptes` (même lot) ; avant UTILS-005 si `Utils.Base3` change.
