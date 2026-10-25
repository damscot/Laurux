# Preparation — Dépendances

> Source : `.src/Gestion/Lcr/Preparation.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Lcr/Preparation.class` — classe, formulaire associé `Preparation.form`
- Handlers GUI détectés : 34
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `N_click`, `A_click`, `Button5_Click`
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `ColLcr`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `CLcr` | `<type>`, `BasPage`, `Entete`, `Level1A`, `Level2A`, `Lines` |
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `EntreeItem` | `item` |
| `LDate` | `D`, `G`, `_call` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `TextReg` | `<form>`, `EstDate`, `Name`, `Select`, `Text`, `Type`, `dte` |
| `TriCpt` | `<type>`, `Avec_Solde`, `Client` |
| `Utils` | `Base`, `Cdate_Aff`, `Coulfd`, `Fcolr`, `ObsLstf`, `Observers`, `convBool`, `cpoint`, `db`, `rs1` |
| `Visualiseur` | `Prog` |
| `chainage` | `<type>` |

### Tables SQL référencées

`Fiches_Banques`, `Fiches_Bordereaux`, `Fiches_Cli`, `Fiches_Comptes`, `Fiches_Lcr`

### Membres Public sans usage externe détecté (portée réductible ?)

`Entete`, `Tris`, `Deb`, `Deb2`, `Deb3`, `Deb4`, `Total`, `N_click`, `A_click`, `Refresh`, `CleanChamps`, `Maj_Zones`, `Button5_Click`, `compte`, `compteman`, `Imp_Lcr`, `sCmpt`, `sdesg`, `Nb`, `sDate`, `iLind`, `ControleCombobox`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Point d'entrée : `Fmenu.Menuprep_Click` (`Preparation.Show`, `Fmenu.class:2518`).
- `unused` vérifiés : `N_click`, `A_click` (pas de contrôles `N`/`A` dans `Preparation.form`),
  `Button5_Click` (pas de `Button5`). Non détecté : `Button7` invisible → `Button7_Click`/`compte`
  inatteignables.
- `replay_missing` : `ColLcr` (`GridView`) sans `ColLcr_Click` ; la sélection se fait par
  `ColLcr_MouseUp`. Un clic rejoué par `ReplayObserver` appellerait `ColLcr_Click` inexistant →
  scénarios à adapter (REPLAYOBSERVER-A06).
- Utilise `EntreeItem.item` (seul appelant).
- `Settings[...]` (l. 77) : objet global gb.settings, pas `Start.LocalSettings` — non vu par `deps.py`.
- `Bsel`/`Bval` : écrits par `TriCpt` (`Object.SetProperty`), `Public` obligatoire.
- Tables en dur : `Fiches_Lcr`, `Fiches_Banques`, `Fiches_Bordereaux`. `LOCK TABLES` inclut
  `Cbase.Table("TabComptes")` inutilement.
- Aval : `Bordrx` relit `Fiches_Bordereaux.banque`/`codeentree` et `Fiches_Lcr.bordereau` ; un
  changement de ces valeurs impacte le fichier bancaire. Ordre de rework : avec `Attribution`
  (commonalisations), avant `Bordrx` si A01 est corrigée.
