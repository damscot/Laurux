# Edinv1 — Dépendances

> Source : `.src/Gestion/Stock/Inventaires/Fin-annee/Edinv1.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Stock/Inventaires/Fin-annee/Edinv1.class` — classe, formulaire associé `Edinv1.form`
- Handlers GUI détectés : 3
- ⚠️ Classe jamais référencée (aucun appelant, nom absent des chaînes du projet) : code mort probable ; la suppression d'un couple .class + .form est une anomalie à valider

### Utilisé par

_Aucun usage externe détecté statiquement._

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cstocks` | `<type>`, `BasPage`, `Entete`, `Entetefam`, `Level1`, `Level2`, `Level3`, `level3fam` |
| `DB_Connection` | `Exec` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `Musique`, `son` |
| `Trifam` | `<type>`, `Text`, `cle`, `enfant`, `parent`, `precedant`, `soustotpa`, `soustotpmp` |
| `Utils` | `CDec`, `Coulfd`, `Find_nbdec`, `Observers`, `PointBase`, `cpoint`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Fam`, `Fiches_Inv`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Aucun appelant** (bloc « Utilisé par » vide ; confirmé par `grep -rn -i Edinv1 .src`, y compris
  `.form` et chaînes). Remplacée par `Edinv` (`Fmenu.class:1076` et `1115`).
- `deps.py` ne signale pas la classe entière comme morte (il ne le fait que par fonction).
- Signaux `deps.py` : aucun.
