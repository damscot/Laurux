# Epurjdv — Dépendances

> Source : `.src/Compta/Utils/Epurjdv.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Utils/Epurjdv.class` — classe, formulaire associé `Epurjdv.form`
- Handlers GUI détectés : 4
- ⚠️ Classe jamais référencée (aucun appelant, nom absent des chaînes du projet) : code mort probable ; la suppression d'un couple .class + .form est une anomalie à valider

### Utilisé par

_Aucun usage externe détecté statiquement._

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Csolde` | `Recalc_solde` |
| `DB_Connection` | `AutoIncrement`, `Engine`, `Exec` |
| `Doc` | `Open` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `Utils` | `Cdate_Aff`, `Cdate_Comp`, `Cdate_Dbase`, `Observers`, `db` |

### Tables SQL référencées

`Fiches_Comptes`, `Fiches_Mvt`, `Fiches_Mvt1`, `Fiches_Mvt2`, `Fiches_Mvt3`, `Fiches_Mvt4`, `Fiches_Mvt5`, `Fiches_Parametres`

### Membres Public sans usage externe détecté (portée réductible ?)

`Aff_date`, `Sauve`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Aucun appelant** : confirmé par `grep -rniw Epurjdv .src` (seul l'en-tête du fichier), absence
  dans `Fmenu.form` et dans le répartiteur par nom de `Prgm` ; aucune instanciation dynamique
  (`Class.Load` n'est utilisé que par `Start` pour `LPrix`/`LScript`). Seule trace : la page d'aide
  `Doc.Open("Epurationjdv")`.
- Commande externe non détectée par `deps.py` : `mysqldump` (Shell), plus `Compress` (gb.compress).
- `Csolde.Recalc_solde` est également appelé par `Fmontant` ; la suppression d'Epurjdv ne change pas
  la portée de `Csolde`.
- Tables touchées en DDL : `Fiches_Mvt`, `Fiches_Mvt1` à `Fiches_Mvt5` (rotation) ; toute
  évolution du schéma `Fiches_Mvt*` rend ce code encore plus divergent.
- Pas de dépendance circulaire ; aucune contrainte d'ordre (fichier isolé).
