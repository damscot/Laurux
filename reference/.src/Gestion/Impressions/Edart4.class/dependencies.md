# Edart4 — Dépendances

> Source : `.src/Gestion/Impressions/Edart4.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Impressions/Edart4.class` — classe, formulaire associé `Edart4.form`
- Handlers GUI détectés : 13
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `ColumnView1_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `Start` | `B`, `G`, `LocalSettings`, `Musique`, `R`, `Societe`, `son` |
| `TarArt` | `<type>`, `cdr`, `nego`, `prixht` |
| `TriArticles` | `<type>` |
| `TriCpt` | `<type>`, `Client`, `Fournisseur`, `Sans_Solde` |
| `Trifam` | `<type>`, `Text`, `cle`, `enfant`, `parent`, `precedant` |
| `Utils` | `ObsGotf`, `ObsLstf`, `Observers`, `Option`, `db`, `totobs` |
| `Visualiseur` | `Prog` |
| `calculdroit` | `droit`, `secu`, `tva` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Cli`, `Fiches_Societes`, `Fiches_Tvaav`, `Fiches_Typec`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelant unique** : `Fmenu.Menu74_Click` (`Fmenu.class:863`) écrit `EdArt4.Show` : la casse
  diffère du nom de fichier `Edart4` (Gambas insensible à la casse ; à conserver tel quel ou à
  aligner dans le même commit si on touche `Fmenu`).
- **TarArt** : `New TarArt(resart!art_code, Textcli.Text, Me, Textyp.Text, "")` (l. 141) : `Me` est
  consommé comme `Parent` de `Form` après les 2 paramètres obligatoires (règle vérifiée sur
  `TriArticles`) ; lit `prixht`, `nego`, `cdr` (`Calculdroit` : `tva`, `droit`, `secu`). Une fenêtre
  par article (TARART-A04).
- **Trifam** : `New Trifam("1")`, `enfant`, `precedant`, `parent`, `cle`, `Text`.
- **TriCpt / TriArticles** : écrivent `Bsel`/`Bval` par `Object.SetProperty` → `Public` obligatoire.
- **Tables en dur** (aucun `Cbase.Table`) : `Fiches_Cli`, `Fiches_Art`, `Fiches_Tvaav`,
  `Fiches_Typec`, `Fiches_Societes`. Lecture seule.
- **gb.report** : `Report`, `ReportHBox`, `ReportVBox`, `ReportLabel`, `ReportImage`,
  `ReportPageBreak`, `ReportBorder`, `ReportBrush`, et `Printer` (gb.qt/gb.gui) pour la sortie PDF.
- **Handlers d'observateur** : `saisie_gotfocus`, `saisie_lostfocus`, `saisie_keypress` (groupe
  `"saisie"` créé par code). Les contrôles `Four`/`Four2` sont aussi déclarés dans le groupe `Cmpt`
  du `.form` sans aucun handler `Cmpt_*` dans la classe.
- **Rejeu** : `ColumnView1_Click` (`replay_dynamic`) → `Public`. `TreeView1` : la sélection des
  familles n'est rejouable que si `ReplayObserver` gère la sélection multiple d'un `TreeView` (à
  vérifier en phase 2). `replay_missing`, `unused`, `arity_errors` vides.
- **Ordre de rework** : après `TarArt` et `Trifam` (lot Utils, commité).
