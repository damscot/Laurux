# Etiquettes — Dépendances

> Source : `.src/Gestion/Etiquettes/Etiquettes.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Etiquettes/Etiquettes.class` — classe, formulaire associé `Etiquettes.form`
- Handlers GUI détectés : 17

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `Start` | `LocalSettings`, `Musique`, `Societe` |
| `Utils` | `Fcolr`, `Observers`, `PageFormatSupported`, `db` |

### Tables SQL référencées

`Fiches_Etiquettes`

### Membres Public sans usage externe détecté (portée réductible ?)

`init_ComboBox`, `SetObservers`, `IsValidKey`, `ChkInput`, `Observers2`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Seul appelant : `Fmenu.Menu165_Click` (`Fmenu.class:1622`, `Etiquettes.Show`, auto-instance
  non modale).
- Table : `Fiches_Etiquettes` en lecture **et écriture** (seul écran qui l'écrit ; les autres
  écritures sont dans `LauruxMaj` et la copie de société `Dup.class:159`). Lecteurs :
  `Etiqart`, `Etigond`, `Etiqcasier`, `Eticli`, `EtiqRecpt`, `EtiqPromo`, `Etiqfbtarif`,
  `FClient`, `FFournisseur`, `Portable.module` (table de travail homonyme `Etiquettes`, sans
  rapport).
- `scope_reducible` (`init_ComboBox`, `SetObservers`, `IsValidKey`, `ChkInput`, `Observers2`) :
  confirmé par `grep -rn` (aucun usage hors du fichier).
- Handlers `OBS_GotFocus`/`OBS_LostFocus` : levés par les `Observer` créés dans `SetObservers`
  (groupe `obs`) ; à garder `Public`.
- Aucun appel dynamique ; pas de grille (rien en `replay_dynamic`/`replay_missing`).
- Dépendances externes : `Doc.Open` (`xdg-open` sur la page d'aide HTML), son (`Music`).
- Ordre de rework : avant ou avec le socle `PlancheEtiquettes` (ETIQART-010), dont il
  deviendrait l'écran d'administration.
