# Depots — Dépendances

> Source : `.src/Gestion/Depots/Depots.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Depots/Depots.class` — classe, formulaire associé `Depots.form`
- Handlers GUI détectés : 16
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Btn_KeyPress`, `Cpman`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Coldepot_Click`
- Fonctions mortes par transitivité (appelées seulement depuis du code mort) : `Libelle_GotFocus`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `Start` | `Musique`, `son` |
| `Utils` | `Base`, `ObsGotf`, `Observers`, `SetEditColor`, `db`, `rs1` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Depots`, `Fiches_Sdepots`, `Fiches_StkDepots`

### Membres Public sans usage externe détecté (portée réductible ?)

`Tris`, `Deb2`, `Deb3`, `Refresh`, `Maj_Zones`, `Cleanchamps`, `Btn_KeyPress`, `Code_GotFocus`, `Libelle_GotFocus`, `Code_LostFocus`, `Cpman`, `ChkCp`, `Ref`, `Dbclk`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Seul point d'entrée : `Fmenu.class:2152` (`Depots.Show()`).
- Lecteurs de `Fiches_Depots` : `Fcaisses` (`:66`, `:109`), `Famille` (`:95`), `Articles` (`:771`),
  `Facture`, et les autres écrans du répertoire. `Fiches_StkDepots` est lue par `Articles`,
  `Facture`, `Caisse` ; `Fiches_Sdepots` par `Cstock` (recalcul du stock du dépôt `01`,
  `Cstock.module:98`) : la suppression d'un dépôt efface son historique.
- `Fiches_Art` est lue en dur (`SELECT art_code FROM Fiches_Art`) pour l'initialisation du stock.
- État partagé `Utils.rs1` (voir [Cpostaux](../../Tables/Cpostaux.class/dependencies.md)).
- `Btn_KeyPress` (groupe `Btn` absent) et `Cpman` : jamais appelés (`unused`). Pseudo-handlers
  des contrôles groupés `Cpost` : `Code_GotFocus`, `Libelle_GotFocus`, `Code_LostFocus`.
- `Coldepot_Click` rejoué par `ReplayObserver.Replay_Click` : doit rester `Public`.
- Ordre de rework : avec Cpostaux/Marques (socle) et les autres écrans de dépôts (module `Depot`).
