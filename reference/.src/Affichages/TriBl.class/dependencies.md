# TriBl — Dépendances

> Source : `.src/Affichages/TriBl.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Affichages/TriBl.class` — classe, formulaire associé `TriBl.form`
- Handlers GUI détectés : 21
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `ClavInput`, `ClavInput2`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `colcli_Click`
- ⚠️ Classe jamais référencée (aucun appelant, nom absent des chaînes du projet) : code mort probable ; la suppression d'un couple .class + .form est une anomalie à valider

### Utilisé par

_Aucun usage externe détecté statiquement._

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Start` | `LocalSettings` |
| `Utils` | `Base2`, `Fcolr`, `ObsGotf`, `ObsLstf`, `Observers`, `Obstch`, `cpoint`, `db`, `rs2` |

### Tables SQL référencées

`Fiches_Bl`

### Membres Public sans usage externe détecté (portée réductible ?)

`Tris`, `Select_Bl`, `Compute_Total_Bl`, `Deplacement`, `Deb3`, `Deb4`, `Dbclk`, `ChkInput`, `ClavInput`, `ClavInput2`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **`jamais_reference` confirmé** : aucun `New TriBl`/`TriBl.` dans `.src` ; les occurrences de
  `Tribl` dans `Facture.class` (35, 36, 518, 1244, 11504…) sont une **variable** `String` locale à
  `Facture` (colonne de tri de sa liste de BL), homonyme à la casse près. Aucune chaîne `"TriBl"`
  (`Class.Load`, `Object.New`). Le dernier appel (`Caisse`, `New Tribl(Bval, numero_tk)`) a été
  retiré par `7101bb39` (2022) au profit de `TriFacture`.
- `unused` : `ClavInput`, `ClavInput2` (vérifié). `unused_transitive` vide.
- `replay_dynamic` : `colcli_Click` (resterait `Public` si la classe était conservée).
- `deps.py` ne détecte pas les tables nommées par concaténation : ici toutes passent par
  `Cbase.Table("TabBl")`, la détection est complète.
- `sql_params` vide : les requêtes concaténées (`Deb3`, `Deb4`) n'ont aucun argument `&N`, elles ne
  sont donc pas signalées par ce contrôle (voir le relevé dans architecture.md).
- Aucune dépendance entrante : la suppression n'impacte aucun autre fichier.
