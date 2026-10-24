# Fsoc — Dépendances

> Source : `.src/Communs/Fsoc.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Communs/Fsoc.class` — classe, formulaire associé `Fsoc.form`
- Handlers GUI détectés : 6
- ⚠️ Handlers nominaux inactifs (contrôle rattaché à un groupe d'événements du .form) : `Button4_Click`
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Nsoc`, `Button4_Click`, `Nbase_MouseDown`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Soclist_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<type>` |
| `.src/Communs/Prgm.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `CTestTVA` | `CleTVAIntra`, `isIntraComValide` |
| `DB_Connection` | `Close`, `Exec` |
| `Doc` | `Open` |
| `Dup` | `<hérité>` |
| `Fmenu` | `<hérité>` |
| `LauruxConf` | `Createbase` |
| `MDP` | `<hérité>` |
| `Start` | `LocalSettings`, `Main`, `MainWindow`, `Motdepasse`, `Musique`, `Societe`, `UnLock`, `son` |
| `Syntheses` | `Message` |
| `Utils` | `Observers`, `SetEditColor`, `chkEmail`, `db` |

### Tables SQL référencées

`Fiches_Identite`, `Fiches_Societes`

### Membres Public sans usage externe détecté (portée réductible ?)

`Recup_Soc`, `Init_base`, `Init_Civilite`, `Nsoc`, `Maj_Zones`, `cleanChamps`, `Refresh`, `code_LostFocus`, `Button1_Click`, `Button3_Click`, `Button4_Click`, `Button5_Click`, `Nbase_MouseDown`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelants réels** (vérifiés par `grep -rn Fsoc .src`) : `Fmenu.Menu26_Click`
  (`Fmenu.class:637`, `:642`, `New Fsoc(Me)` puis `Show`) et `Prgm.class:81`
  (`Fsoc.ShowModal()` sans argument : l'auto-instance ne peut pas être créée car `_New` exige
  `hform`, échec probable à l'exécution, à confirmer → FSOC-A06).
- **Portée réductible confirmée** : `Recup_Soc`, `Init_base`, `Init_Civilite`, `Nsoc`, `Maj_Zones`,
  `cleanChamps`, `Refresh`, `Nbase_MouseDown` n'ont aucun appel externe. Aucun appel dynamique
  (`Object.Call`) ne les vise ; `ReplayObserver` n'appelle que `<contrôle>_Click`.
  `Nbase_MouseDown` ne correspond à aucun contrôle du `.form` : code mort.
- `Nsoc` est une copie de `Utils.Nsoc` (`Utils.module:809`), elle aussi sans appel.
- **Tables non vues par l'heuristique** : les requêtes inter-bases portent sur
  `Laurux<XX>.Fiches_Societes` et `DROP DATABASE Laurux<XX>` (bases entières). `Fiches_Identite`
  et `Fiches_Societes` sont écrites en dur (mappings `TabIdentite`, `TabSoc` disponibles dans
  `Cbase`).
- **Dépendance vers une autre fenêtre** : `LauruxConf.Createbase` est appelée sur l'auto-instance
  du formulaire `LauruxConf` : son `_new` s'exécute (lecture de `Laurux.conf`, balayage des
  bases) et `Createbase` lit les contrôles `Login`, `Password`, `Host`, `Port` de cet écran caché.
- `Dup` (`Compta/Utils/Dup.class`) est ouvert par le bouton tag 6 et appelle lui aussi
  `LauruxConf.Createbase`.
- `CTestTVA.CleTVAIntra` / `isIntraComValide` : anomalie `CTESTTVA-A01` (clé sur un chiffre)
  visible dans cet écran.
- **Ordre de rework** : après `Utils` (helper de ligne de commande `UTILS-014`) et `CTestTVA`
  (helper SIREN), et avec `LauruxConf` (helpers `BasesLaurux` / `OuvreBase` partagés).
- Dépendance circulaire faible `Fsoc` → `Fmenu.Text` → `Fsoc` (Fmenu instancie Fsoc).
