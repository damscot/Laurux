# Portable — Dépendances

> Source : `.src/Gestion/Lcr/Portables/Portable.module` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Lcr/Portables/Portable.module` — module
- Handlers GUI détectés : 0

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/Etiquettes/Etigond.class` | `Import`, `cpt2` |
| `.src/Gestion/Etiquettes/Etiqart.class` | `Import`, `cpt2` |
| `.src/Gestion/Etiquettes/Etiqcasier.class` | `Import`, `cpt2` |
| `.src/Gestion/Lcr/Portables/Majcasier.class` | `Import` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Utils` | `Find_cbarre`, `cpoint`, `db` |

### Tables SQL référencées

`Fiches_Art`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Appelants vérifiés (`grep -rn "Portable\." .src`) : `Etigond:1059/1062`, `Etiqart:1020/1023`,
  `Etiqcasier:997/1000` (`Import("Etiq")` + lecture de `cpt2`), `Majcasier:59` (`Import("Casier")`,
  sans effet utile).
- Rangement trompeur sous `Gestion/Lcr` : aucun lien avec les LCR ; les appelants sont dans
  `Gestion/Etiquettes` et `Lcr/Portables/Majcasier`.
- Table de travail `Etiquettes` (nom en dur) non détectée par `deps.py` (tables par variable).
- Code dupliqué de lecture de `inventaire.txt` (non relié par `deps.py`) : `Majcasier`, `Achat`,
  `Facture`, `SaisieInv`, `SaisieInvT`.
- Ordre de rework : avant ses appelants si `LireInventaire` est introduit ; la remise à zéro de
  `cpt2` (PORTABLE-A01) se coordonne avec les 3 écrans d'étiquettes.
