# Eticli — Dépendances

> Source : `.src/Gestion/Etiquettes/Eticli.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Etiquettes/Eticli.class` — classe, formulaire associé `Eticli.form`
- Handlers GUI détectés : 25
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `ColCli_Click`, `ColCli2_Click`, `ColType_Click`, `ColType2_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cetiquettes` | `<type>`, `Cp`, `NewPage`, `Nom` |
| `DB_Connection` | `Engine`, `Exec` |
| `Doc` | `Open` |
| `PdfWriter` | `Open`, `Output` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `Utils` | `Base`, `Fcolr`, `Observers`, `db`, `rs1` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Cli`, `Fiches_Etiquettes`, `Fiches_Typec`

### Membres Public sans usage externe détecté (portée réductible ?)

`init_ComboBox`, `Tris`, `Tris2`, `colinit`, `AffClients`, `AffClients2`, `Cli_Man`, `ChkInput`, `Button2_Click`, `Imprime`, `fin_impression`, `pos_Etiq`, `SetObservers`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelant** : `Fmenu.Menu163_Click` (`Fmenu.class:1610`, `Eticli.show`).
- **`replay_dynamic`** : `ColCli_Click`, `ColCli2_Click`, `ColType_Click`, `ColType2_Click` →
  `Public` (rejeu). Le `.form` nomme les grilles `Colcli`/`Coltype` : casse différente, sans effet
  en Gambas.
- **`unused`, `arity_errors`, `handlers_inactifs`, `replay_missing`, `unused_transitive`** : vides.
- **`scope_reducible`** : confirmé par grep. `Button2_Click` n'est pas un handler (`Button2` est
  dans le groupe `Btn`).
- **Tables** : `Fiches_Cli`, `Fiches_Typec`, `Fiches_Etiquettes` (littéraux, sans `Cbase`), table de
  travail temporaire `Etiquettes` (non vue par `deps.py`).
- **État partagé** : `Utils.rs1` (via `Utils.Base`) : partage avec les autres écrans qui utilisent
  `rs1` (voir notes transverses, lot Gestion/Tables).
- **Dépendances externes** : `Visualiseur.Prog`, `Doc.Open` (`xdg-open`), `Shell "cd ~"`, fichier
  `~/tmp/EtiqCli.pdf`.
- **Ordre de rework** : après le socle `PlancheEtiquettes` (ETIQART-010) et FCLIENT-014 ; focus avec
  ETIQUETTES-007.
