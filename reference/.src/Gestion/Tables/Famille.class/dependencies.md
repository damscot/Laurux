# Famille — Dépendances

> Source : `.src/Gestion/Tables/Famille.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Tables/Famille.class` — classe, formulaire associé `Famille.form`
- Handlers GUI détectés : 24
- ⚠️ Handlers nominaux inactifs (contrôle rattaché à un groupe d'événements du .form) : `Colcompt2_KeyPress`
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Colcompt2_KeyPress`, `Btn_KeyPress`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Colfam_Click`, `Colcompt_Click`, `Colcompt2_Click`, `Tvalist2_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |
| `.src/Gestion/Tables/Articles.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `Serveur` | `Pass` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `Utils` | `Fcolr`, `Observers`, `PointBase`, `Remplace`, `SetEditColor`, `cpoint`, `db` |
| `Variables` | `SMajArt`, `Sexport`, `Sprix` |
| `gridvi` | `<type>`, `bouton_Click`, `code`, `dec`, `razcol` |
| `textfamille` | `<form>`, `Clear`, `Select`, `setfocus`, `text` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Comptes`, `Fiches_Depots`, `Fiches_Fam`, `Fiches_FamDep`, `Fiches_Mo`, `Fiches_Tvaav`

### Membres Public sans usage externe détecté (portée réductible ?)

`Refresh`, `Maj_Zones`, `MoveTo`, `ShowTextBox`, `HideTextBox`, `Cleanchamps`, `AffCpt`, `Colcompt2_KeyPress`, `Coef_LostFocus`, `Remise_LostFocus`, `Ecotx_LostFocus`, `Test_Tva`, `Btn_KeyPress`, `compteGman`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Points d'entrée** : `Fmenu:875` (`Famille.Show`) et `Articles:1290` (`Famille.ShowModal`),
  auto-instance du formulaire. Aucun membre n'est utilisé de l'extérieur.
- **Handler inactif confirmé** : `Colcompt2_KeyPress` (`Colcompt2` appartient au groupe `Fam` du
  `.form`, aucun appel explicite, vérifié par `grep -rn`). De plus `Colcompt2` n'est jamais
  rendu visible : `Colcompt2_Click` (appelé seulement par `Colcompt2_KeyPress`) est mort lui
  aussi, mais il reste `Public` (`replay_dynamic`).
- **`Btn_KeyPress`** : aucun contrôle ni groupe `Btn` dans le `.form` (les boutons `Button1` à
  `Button5` n'ont pas de groupe) : jamais levé, code mort (`deps.py` le classe `unused`).
- **Handlers nominaux de contrôles groupés appelés explicitement** : `Coef_LostFocus`,
  `Remise_LostFocus`, `Ecotx_LostFocus` (par `fam_lostfocus` et `Button1_Click`) : `deps.py` les
  annonce « portée réductible », mais ils gardent leur nom et leur portée `Public` (règle des
  handlers).
- **`replay_dynamic`** : `Colfam_Click`, `Colcompt_Click`, `Colcompt2_Click`, `Tvalist2_Click`
  (`ColumnView`) : appelés par `ReplayObserver.Replay_Click` via `Object.Call`, ils restent
  `Public` (sans objet si REPLAYOBSERVER-A06 est validée).
- **Vraies réductions** (aucun appel externe, `grep -rn`) : `Refresh`, `Maj_Zones`, `MoveTo`,
  `ShowTextBox`, `HideTextBox`, `Cleanchamps`, `AffCpt`, `Test_Tva`, `compteGman`.
- **Tables** : `Fiches_FamDep` en dur (pas de clé `Cbase`), aussi lue par `Moulinage:1146,1211`.
  `Gridvi` (onglet Statistiques) lit les tables de factures et BL (voir sa documentation).
- **État global** : `Variables.Sprix/Sexport/SMajArt` (initialisés depuis `/Soc<XX>/…` dans
  `Variables.module`) conditionnent `Serveur.Pass("Fam", …)`.
- **Ordre de rework** : indépendant ; FAMILLE-007 avec `Articles` et `Txmo`, FAMILLE-008 avec
  `CoefTypeC`, `Remisec`, `Remisecli`.
