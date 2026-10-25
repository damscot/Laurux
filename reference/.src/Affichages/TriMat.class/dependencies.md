# TriMat — Dépendances

> Source : `.src/Affichages/TriMat.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Affichages/TriMat.class` — classe, formulaire associé `TriMat.form`
- Handlers GUI détectés : 25
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `ColMat_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/Impressions/EdMat.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `EdMat` | `Bsel`, `CodeMat` |
| `Utils` | `Base2`, `ObsGotf`, `ObsLstf`, `Observers`, `Obstch`, `rs2` |

### Tables SQL référencées

`Fiches_Materiels`

### Membres Public sans usage externe détecté (portée réductible ?)

`mat_Dblclk`, `ChkInput`, `TriMat`, `Deb1`, `Deb2`, `Deplacement`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelant unique** : `EdMat.SelectionMat` (`EdMat.class:136`), `New TriMat(True, "", Tri,
  "EdMat")` puis lecture de `EdMat.Bsel`/`CodeMat` (l. 138-147). Le 2ᵉ argument `""` est converti
  en `Boolean` (`False`) sans erreur.
- **Écriture sortante en dur** : `EdMat.Bsel`, `EdMat.CodeMat` (l. 381-382) sur l'auto-instance ;
  `EdMat` n'est ouvert que par `EdMat.Show()` (`Fmenu:2254`) : pas de signal `auto_instance`, accès
  correct. Membres à garder `Public` (`EdMat.class:17-19`).
- **Homonymie** : la méthode `TriMat()` porte le nom de la classe ; `deps.py` la range dans
  `scope_reducible` (vérifié : appelée seulement depuis `_new`).
- **Signaux `deps.py`** : `replay_dynamic` = `ColMat_Click` (doit rester `Public`) ;
  `scope_reducible` = `mat_Dblclk`, `ChkInput`, `TriMat`, `Deb1`, `Deb2`, `Deplacement` (vérifié
  par grep) ; aucun `unused`, `arity_errors`, `replay_missing`. `CO_click` (handler vide d'un
  `TextBox`) et `Frame1_KeyPress` (contrôle sans focus) ne sont pas détectés comme inactifs
  (limite : événement non vérifié contre la classe du contrôle).
- **Résultat partagé** `Utils.rs2` (comme `Tricp`, `TriEqu`, `Tricartes`…).
- **Ordre de rework** : indépendant ; TRIMAT-A02 se corrige dans `TriMat` (remise à zéro à
  l'ouverture) ou dans `EdMat` (`Bsel = False` avant l'ouverture).
