# Remisecli — Dépendances

> Source : `.src/Gestion/Tables/Remisecli.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Tables/Remisecli.class` — classe, formulaire associé `Remisecli.form`
- Handlers GUI détectés : 17
- ⚠️ Handlers nominaux inactifs (contrôle rattaché à un groupe d'événements du .form) : `Cdf_GotFocus`, `Cdf_Dblclick`, `Cdf_KeyPress`
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Cdf_GotFocus`, `Cdf_Dblclick`, `Cdf_KeyPress`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Colcli_Click`, `Colfam_Click`
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `Tabcli`

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
| `Start` | `LocalSettings`, `Musique`, `son` |
| `Utils` | `Base`, `Fcolr`, `Observers`, `cpoint`, `db`, `rs1` |
| `textfamille` | `<form>`, `Clear`, `Select`, `setfocus`, `text` |

### Tables SQL référencées

`Fiches_Cli`, `Fiches_Fam`

### Membres Public sans usage externe détecté (portée réductible ?)

`Deb2`, `Deb3`, `Tris`, `Maj_Zones`, `CleanChamps`, `Quitte_Cdt`, `Quitte_Cdf`, `Quitte_Remise`, `entete`, `Cdf_GotFocus`, `Cdf_Dblclick`, `Cdf_KeyPress`, `Dbclk`, `Ref`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Point d'entrée** : `Fmenu:1945` (`Remisecli.ShowModal()`), auto-instance. Aucun membre utilisé
  de l'extérieur.
- **Handlers inactifs confirmés** : `Cdf_GotFocus`, `Cdf_Dblclick`, `Cdf_KeyPress` (`Cdf` est un
  `textfamille` du groupe `rem` dans le `.form` ; aucun appel explicite, vérifié par `grep -rn`).
  Ils ressemblent aux handlers `Co_*` de l'en-tête client et auraient dû viser l'en-tête `FA`
  (aucun handler `FA_*`) : REMISECLI-A01.
- **En-tête `Rem`** (`TextBox` sans groupe) : ses frappes lèvent aussi `Rem_KeyPress` (même nom
  que le groupe `rem`) ; sans `Tag`, aucun effet.
- **`replay_dynamic`** : `Colcli_Click`, `Colfam_Click` restent `Public`. La grille `Tabcli`
  (`GridView`) n'a pas de `Tabcli_Click` : le rejeu d'un clic sur la grille par `ReplayObserver`
  est à vérifier en phase 2 (sélection traitée par `Tabcli_Select`).
- **État global** : `Utils.rs1` (rempli par `Utils.Base`, lu par `Tabcli_Data`) est partagé avec
  tous les écrans qui utilisent `Utils.Base` ; l'écran est modal, ce qui limite les collisions.
- **Vraies réductions** (aucun appel externe) : `Deb2`, `Deb3`, `Tris`, `Maj_Zones`,
  `CleanChamps`, `Quitte_Cdt`, `Quitte_Cdf`, `Quitte_Remise`, `entete`, `Dbclk`, `Ref`.
- **Lecteurs de `Fiches_RemCliFam`** : `TarArt`, `Facture` (via `Cbase.Table("RemCliFam")`).
- **Ordre de rework** : REMISECLI-006 avec `Remisec` et `CoefTypeC`.
