# ArchivesTck — Dépendances

> Source : `.src/Archivages/ArchivesTck.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Archivages/ArchivesTck.class` — classe, formulaire associé `ArchivesTck.form`
- Handlers GUI détectés : 29
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `cpoint`, `Refresh`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Coltk_Click`
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `Detk`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Engine`, `Exec` |
| `Htickets` | `<type>`, `Entete`, `Entete2`, `Level4` |
| `LDate` | `DateFilterDB` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `LocalSettings`, `Societe` |
| `Utils` | `Cdate_Carte`, `Cdate_Comp`, `Observers`, `cpoint`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Cli`, `Fiches_HisEntTickets`, `Fiches_HisLigTickets`, `Fiches_Societes`

### Membres Public sans usage externe détecté (portée réductible ?)

`cpoint`, `Tris`, `Deb2`, `Deb3`, `affiche`, `Refresh`, `Dbclk`, `KeyPress`, `dKeyPress`, `init_Tk`, `Deplacement`, `TabTva`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Seul appelant : `Fmenu.Menu218_Click` (`ArchivesTck.ShowModal()`, `Fmenu.class:1903`). Aucun
  accès `ArchivesTck.<membre>` ailleurs (vérifié par grep) : toutes les fonctions non handlers sont
  réductibles.
- Signaux `deps.py` vérifiés :
  - `unused` : `cpoint` et `Refresh` — confirmés (aucun appel, aucune chaîne dans un appel
    dynamique) ; `Refresh` masque `Control.Refresh`, jamais appelé sur cette fenêtre ;
  - `replay_dynamic` : `Coltk_Click` (appelé par `ReplayObserver` via `Object.Call`) → doit rester
    `Public` ;
  - `replay_missing` : `Detk` (ColumnView sans `Detk_Click`) → les scénarios ne doivent pas cliquer
    dans le détail (ou REPLAYOBSERVER-A06) ;
  - `arity_errors`, `unused_transitive`, `handlers_inactifs` : aucun.
- Non détecté par l'heuristique : `Button1` du groupe `Btn` (aide « Doc HTML ») n'a aucun handler
  `Btn_Click` : bouton inerte (constat transverse, ~100 formulaires ont un bouton `Btn` ; à confirmer).
- Tables : `Fiches_HisEntTickets`/`Fiches_HisLigTickets` (clés `TabHisEntTck`/`TabHisLigTck`),
  `Fiches_Cli`, `Fiches_Societes` ; table de travail `Tottva` (nom en dur, non vue par `deps.py`),
  partagée avec `Caisse`, `Facture`, `Facturergbl`, `ValidBR`, `Archives`.
- Classe d'impression `Htickets` (`Inherits PdfWriter`, `.src/Reports/`) : `Entete`, `Entete2`,
  `Level4`, `Open`, `AliasNbPages`, `Output`.
- Données produites par `Moulinage` et purgées par `RazHistoTk`.
- Ordre de rework : `PaginationListe` avec le lot Affichages (TRICARTES-005) ; la factorisation du
  cumul de TVA attend les décisions CAISSE-A17 et ARCHIVESTCK-A01/A04.
