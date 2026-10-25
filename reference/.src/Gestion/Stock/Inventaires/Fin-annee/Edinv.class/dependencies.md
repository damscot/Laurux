# Edinv — Dépendances

> Source : `.src/Gestion/Stock/Inventaires/Fin-annee/Edinv.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Stock/Inventaires/Fin-annee/Edinv.class` — classe, formulaire associé `Edinv.form`
- Handlers GUI détectés : 3

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cstocks` | `<type>`, `BasPage`, `Entete`, `Entetefam`, `Level1`, `Level2`, `Level3`, `level3fam` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `Musique`, `son` |
| `Trifam` | `<type>`, `Text`, `cle`, `enfant`, `parent`, `precedant`, `soustotpa`, `soustotpmp` |
| `Utils` | `CDec`, `Coulfd`, `Find_nbdec`, `Observers`, `PointBase`, `cpoint`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Fam`, `Fiches_Inv`, `Fiches_InvT`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Appelants : `Fmenu.Menu85_Click` (`Fmenu.class:1076`, `New Edinv("F")`) et `Fmenu.Menu99_Click`
  (`Fmenu.class:1115`, `New Edinv("T")`). `_New(choix)` est `Public` et fait partie de l'API :
  tout changement de signature impose de modifier ces deux lignes.
- `Trifam` : `New Trifam("1")` lit `/SocXX/ipr` et **quitte l'application** (`Quit`) si le
  paramétrage des familles est absent ; dépendance forte pour les tests.
- Table nommée par variable (`$fichier`) et littéraux `Fiches_Art`, `Fiches_Fam` dans la jointure.
- Remplace les classes mortes `Edinv1` et `EdinvT` (aucun appelant).
- Signaux `deps.py` : aucun (vérifié).
