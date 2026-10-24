# Rubresult — Dépendances

> Source : `.src/Compta/Utils/Rubresult.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Utils/Rubresult.class` — classe, formulaire associé `Rubresult.form`
- Handlers GUI détectés : 7
- ⚠️ Handlers nominaux inactifs (contrôle rattaché à un groupe d'événements du .form) : `Button3_Click`
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Button3_Click`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `colcol_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Engine`, `Exec` |
| `Doc` | `Open` |
| `Start` | `Musique`, `son` |
| `Utils` | `Observers`, `Remplace`, `SetEditColor`, `db` |

### Tables SQL référencées

`Fiches_RubCompt`, `Fiches_Rubriques`

### Membres Public sans usage externe détecté (portée réductible ?)

`CleanChamps`, `Refresh`, `Button1_Click`, `Button2_Click`, `Button3_Click`, `Rubman`, `Button5_Click`, `Button4_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse
- **Appelant unique** : `Fmenu.Menu122_Click` (`Fmenu.class:1248`, `Rubresult.Show`).
- **Tables** : `Fiches_Rubriques` (lecture/écriture) ; `Fiches_RubCompt` uniquement dans l'import
  `BcrSelect_Activate`, qui **supprime et recrée** les deux tables (`Truncate`, `DROP TABLE IF
  EXISTS`, `CREATE TABLE … Utils.db.Engine()`). La structure créée correspond à `db_control.csv`
  (types, clés) mais sans collation explicite : elle dépend de la collation par défaut de la base.
- **Fichiers externes** : `Bcr.txt` et `Bcrcpt.txt` du répertoire choisi dans `BcrSelect`
  (format produit par `Exprub.run` dans `~`). Dépendance de format avec `Exprub` non visible par
  `deps.py` (aucun appel de fonction).
- **Handler inactif confirmé** : `Button3_Click` (`Button3` est dans le groupe `Btn`, tag 4 →
  `Me.Close` dans `Btn_Click` ; aucune autre occurrence).
- **Appel dynamique** : `colcol_Click` est appelé par `ReplayObserver` via `Object.Call` (doit
  rester `Public`). `BcrSelect_Activate` est un événement de `DirChooser`.
- `Refresh` : même réserve que pour `Rubcompt` (masque `Form.Refresh`).
- Sous SQLite, `Truncate` n'est pas traduit par `DB_Connection` : l'import échoue (voir RUBRESULT-A03).
- Contrainte d'ordre : à traiter avec `Rubcompt` et `Exprub` (format commun d'export/import).
