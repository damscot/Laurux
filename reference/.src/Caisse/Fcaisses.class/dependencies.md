# Fcaisses — Dépendances

> Source : `.src/Caisse/Fcaisses.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Caisse/Fcaisses.class` — classe, formulaire associé `Fcaisses.form`
- Handlers GUI détectés : 10
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Caisse_Click`
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `tvalist2`

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
| `Start` | `LocalSettings`, `Musique`, `Societe` |
| `Utils` | `Observers`, `db` |

### Tables SQL référencées

`Fiches_Caisses`, `Fiches_Depots`, `Fiches_EntTicketz`

### Membres Public sans usage externe détecté (portée réductible ?)

`Refresh`, `Maj_Zones`, `Cleanchamps`, `Button1_Click`, `Button3_Click`, `Chkcaisse`
<!-- /AUTO:dependances -->

## Notes d'analyse

Vérifications faites par `grep -rn` sur `.src` (commit `6b6b9dfc`).

- Seul appelant : `Fmenu.Menu205_Click` → `Fcaisses.ShowModal()` (auto-instance, [Fmenu.class:1853](../../../../.src/Communs/Fmenu.class#L1853)).
- **Homonyme** : le contrôle `Caisse` (`ColumnView`) porte le nom de la classe `Caisse` (saisie
  caisse). Dans ce fichier, `Caisse.*` désigne toujours le contrôle ; `deps.py` ne crée pas de
  fausse dépendance vers la classe (vérifié dans le bloc ci-dessus), mais tout outil de
  renommage doit en tenir compte.
- `replay_dynamic` : `Caisse_Click` (doit rester `Public`, REPLAYOBSERVER-A06).
- `replay_missing` : `tvalist2`, grille invisible et inutilisée ; aucun scénario ne peut cliquer
  dessus.
- `scope_reducible` signale `Button1_Click` et `Button3_Click` : exact, `Button1`/`Button3` sont
  dans le groupe `Btn` (seul `Btn_Click`/`Btn_KeyPress` sont levés).
- Tables en dur : `Fiches_Depots` (`Maj_Zones`), `Fiches_EntTicketz` (`Button3_Click`).
- Les caisses créées ici sont lues par `Cmenu` (`poste`), `Ouverture` (liste du poste),
  `Fondcaisse`, `Moulinage`, `Statcai`, `Caisse` (`imp`, `typeimp`, `depot`, `ecole`) : la
  colonne `depot` tronquée à deux caractères est relue par `Caisse` ([Caisse.class:275](../../../../.src/Caisse/Caisse.class#L275)).
- Ordre de rework : après le module `Depot` (MvtDepots/Sdepots) et le socle des écrans de table.
