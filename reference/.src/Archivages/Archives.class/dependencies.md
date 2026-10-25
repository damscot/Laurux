# Archives — Dépendances

> Source : `.src/Archivages/Archives.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Archivages/Archives.class` — classe, formulaire associé `Archives.form`
- Handlers GUI détectés : 52
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Maj_Zones`, `Refresh`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Colbl_click`
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `Coldetail`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Engine`, `Exec` |
| `LDate` | `_call` |
| `ObjFac` | `archive` |
| `OptFac` | `<type>` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `Suivi` | `<type>` |
| `Utils` | `Base`, `Cdate_Aff`, `Fcolr`, `ObsLstf`, `Observers`, `Option`, `cpoint`, `db`, `orientation`, `rs1` |
| `Variables` | `bRemise` |

### Tables SQL référencées

`Fiches_Cli`, `Fiches_HisentMat`, `Fiches_HistoFac`, `Fiches_HistoFacM`, `Fiches_HistoLigfac`, `Fiches_HistoLigfacM`, `Fiches_Parametres`, `Fiches_ligcons`, `Fiches_ligregie`

### Membres Public sans usage externe détecté (portée réductible ?)

`Deb2`, `Deb2b`, `Deb3b`, `Deb3`, `Debcom`, `Tris`, `Titre`, `Dbclk`, `Colfac_com`, `Colfac_art`, `Colfac_libel`, `Maj_Zones`, `Refresh`, `CleanChamps`, `Deplacement`, `Recup_ligbl`, `CalculTotal`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Appelants : `Fmenu.Menu72_Click` (`Fmenu.class:957`) et `Fmenu.lblArch_MouseDown`
  (`Fmenu.class:1540`), tous deux `Archives.ShowModal()`. Aucun accès `Archives.<membre>` hors du
  fichier (vérifié par grep) ; les trois `Archives.Width` internes visent l'auto-instance, qui est
  la fenêtre affichée.
- Signaux `deps.py` vérifiés :
  - `unused` : `Maj_Zones` (vide) et `Refresh` — confirmés (aucun appel direct ni dynamique) ;
  - `replay_dynamic` : `Colbl_click` → doit rester `Public` ;
  - `replay_missing` : `Coldetail` (ColumnView sans `Coldetail_Click`) → ne pas cliquer dans le
    détail lors des scénarios (ou REPLAYOBSERVER-A06) ;
  - `arity_errors`, `unused_transitive`, `handlers_inactifs` : aucun. Appels vérifiés à la main :
    `New OptFac(…)` à 8 arguments (3 obligatoires + `Parent` + 4 optionnels) et `New Suivi(…)` à 11
    arguments sont conformes.
- Faux « handlers » : `NO_Click`, `DA_Click`, `CO_Click`, `MT_Click`, `MTC_Click`, `NUMS_Click`
  portent sur des `TextBox` (pas d'événement `Click`) ; ils sont appelés par les `*_GotFocus`.
- Non détectés : `Button7` du groupe `Btn` (aide) sans `Btn_Click` (A08) ; pas de `NM_Click` sur la
  ComboBox (A10).
- Tables : `Fiches_HistoFac`, `Fiches_HistoFacM`, `Fiches_HistoLigfac`, `Fiches_HistoLigfacM`,
  `Fiches_HisentMat` (`TabHisEntm`), `Fiches_Cli`, `Fiches_Parametres`, `Fiches_ligcons`,
  `Fiches_ligregie` (noms en dur) ; table de travail `Blcom` (nom en dur, partagée avec `Facture`).
- Classes utilisées : `OptFac` (→ `ObjFacB`, mode `ObjFac.archive`), `Suivi`, `Utils`
  (`Base`/`rs1`, `Option`, `orientation`, `ObsLstf`…), `Variables.bRemise` (lu par `Cdocuments`).
- Ordre de rework : `PaginationListe` (lot Affichages, TRICARTES-005) et `Utils.LitLargeurs`
  (SAISECRIT-010) d'abord ; la recherche `Blcom` attend la décision sur A01 et sur la table
  `Blcom` de `Facture`.
