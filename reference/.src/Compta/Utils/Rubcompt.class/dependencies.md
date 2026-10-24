# Rubcompt — Dépendances

> Source : `.src/Compta/Utils/Rubcompt.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Utils/Rubcompt.class` — classe, formulaire associé `Rubcompt.form`
- Handlers GUI détectés : 9
- ⚠️ Handlers nominaux inactifs (contrôle rattaché à un groupe d'événements du .form) : `Button3_Click`
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Button3_Click`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `RubList_Click`, `colcol_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `Start` | `son` |
| `Utils` | `Observers`, `SetEditColor`, `db` |

### Tables SQL référencées

`Fiches_RubCompt`, `Fiches_Rubriques`

### Membres Public sans usage externe détecté (portée réductible ?)

`Maj_Zones`, `CleanChamps`, `Refresh`, `Button1_Click`, `Button2_Click`, `Button3_Click`, `Rubman`, `Rubman2`, `Button4_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse
- **Appelant unique** : `Fmenu.Menu123_Click` (`Fmenu.class:1254`, `Rubcompt.Show`, auto-instance du
  formulaire). Aucun autre fichier n'appelle de membre de `Rubcompt` (vérifié par `grep -rn Rubcompt .src`).
- **Tables** : `Fiches_RubCompt` (lecture/écriture) et `Fiches_Rubriques` (lecture), noms écrits
  en dur, sans clé `Cbase` correspondante. Ces deux tables sont aussi lues par `Rubresult`
  (import qui les recrée), `Exprub` (export), `Imp_Bilan`, `Imp_Sig` et `RubImp` (éditions) : un
  changement de contenu de `Fiches_RubCompt` modifie directement le bilan, les SIG et le compte de
  résultat.
- **Handler inactif confirmé** : `Button3_Click` (`deps.py -f handlers_inactifs`). `Button3` est
  déclaré `{ Button3 Button Btn` dans `Rubcompt.form` ; seul `Btn_Click` (tag 4 → `Me.Close`) est
  déclenché. `grep -rn "Button3_Click" .src/Compta/Utils/Rubcompt.class` ne trouve que la
  définition ; `ReplayObserver` ne l'appelle pas par nom (les boutons sont rejoués par
  `ctx.Value = True`).
- **Appel dynamique** : `ReplayObserver.Replay_Click` appelle `Object.Call(ctx.window, ctx.Name &
  "_Click")` pour les `ColumnView` : `colcol_Click` et `RubList_Click` doivent rester `Public` sous
  ce nom.
- `deps.py` propose `Refresh` comme réductible : c'est exact pour les appelants, mais le nom
  redéfinit la méthode héritée `Form.Refresh` (vérifier à la compilation avant de changer la portée).
- `Music` est utilisé sans `Music.Load` dans ce fichier (dépendance implicite au dernier son chargé).
- Contrainte d'ordre : à traiter avec `Rubresult` (même squelette, helper commun `LitRubrique`) et
  après l'ajout des clés `Cbase` (`TabRubriques`, `TabRubCompt`).
