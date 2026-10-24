# Cpostaux — Dépendances

> Source : `.src/Gestion/Tables/Cpostaux.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Tables/Cpostaux.class` — classe, formulaire associé `Cpostaux.form`
- Handlers GUI détectés : 16
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `cpoint`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Colcpost_Click`, `Colcp_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `Start` | `Musique`, `son` |
| `Utils` | `Base`, `Observers`, `SetEditColor`, `db`, `rs1` |

### Tables SQL référencées

`Fiches_Cpostaux`

### Membres Public sans usage externe détecté (portée réductible ?)

`cpoint`, `Tris`, `Deb2`, `Deb3`, `Refresh`, `Maj_Zones`, `Cleanchamps`, `Cpostal_GotFocus`, `Burdist_GotFocus`, `Cpostal_LostFocus`, `Button1_Click`, `Button3_Click`, `Cpman`, `aff_cp`, `ChkCp`, `Ref`, `Dbclk`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Seul point d'entrée : `Fmenu.class:1739` (`Cpostaux.Show()`).
- **Faux négatif** : la table est nommée en dur (`Tab`, `Tabcp`) ; écrivains : `Enrgcp.Ecp`
  (`Enrgcp.module:9-10`, même logique que `Button1_Click`), `Impcpostaux` ; lecteurs : `Tricp`
  (`:287`, `:294`, même idiome de filtre), `FClient`, `FFournisseur`, `Facture`, `Fsoc`,
  `FClientcarte`, `Dup`.
- **État partagé** : `Utils.rs1` est écrit par `Utils.Base` et relu par `Colcpost_Data`. Tout
  autre écran ouvert qui appelle `Utils.Base` pendant que Cpostaux est affiché (fenêtre non
  modale) remplace le résultat affiché : dépendance cachée à surveiller lors du rework de `Utils.Base`.
- Pseudo-handlers (contrôles groupés `Cpost`, jamais levés par Gambas) : `Cpostal_GotFocus`,
  `Burdist_GotFocus`, `Cpostal_LostFocus`, ainsi que `Button1_Click`/`Button3_Click` (groupe `Btn`).
- `Colcpost_Click` et `Colcp_Click` rejoués par `ReplayObserver.Replay_Click` : doivent rester `Public`.
- `cpoint` : jamais appelée (`unused`).
- Ordre de rework : avec Marques et Depots (socle « grille filtrable »).
