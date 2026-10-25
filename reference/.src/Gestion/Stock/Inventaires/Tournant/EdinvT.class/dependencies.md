# EdinvT — Dépendances

> Source : `.src/Gestion/Stock/Inventaires/Tournant/EdinvT.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Stock/Inventaires/Tournant/EdinvT.class` — classe, formulaire associé `EdinvT.form`
- Handlers GUI détectés : 3
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Level1`, `Level2`, `Level3`
- ⚠️ Classe jamais référencée (aucun appelant, nom absent des chaînes du projet) : code mort probable ; la suppression d'un couple .class + .form est une anomalie à valider

### Utilisé par

_Aucun usage externe détecté statiquement._

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cstocks` | `<type>`, `BasPage`, `Entete`, `Level1`, `Level2`, `Level3` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `Musique`, `son` |
| `Utils` | `CDec`, `Coulfd`, `Find_nbdec`, `Observers`, `PointBase`, `cpoint`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_InvT`

### Membres Public sans usage externe détecté (portée réductible ?)

`Level1`, `Level2`, `Level3`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Aucun appelant** (bloc « Utilisé par » vide ; confirmé par `grep -rn -i EdinvT .src`, y compris
  `.form` et chaînes). Remplacée par `Edinv` (`Fmenu.class:1076` et `1115`).
- `deps.py` ne signale pas la classe entière comme morte (il ne le fait que par fonction) et ne marque pas `Level1/2/3` comme `unused`, alors qu’elles ne sont appelées nulle part (faux négatif : les appels `pdf.Level1()` de `Cstocks` sont probablement confondus avec ces méthodes homonymes).
- Signaux `deps.py` : `scope_reducible` = `Level1`, `Level2`, `Level3` (sans objet : code mort).
