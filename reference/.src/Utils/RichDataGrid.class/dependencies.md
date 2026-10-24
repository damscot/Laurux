# RichDataGrid — Dépendances

> Source : `.src/Utils/RichDataGrid.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/RichDataGrid.class` — classe
- Handlers GUI détectés : 8
- ⚠️ Appels dynamiques (Object.Call/New, Class.Load…) lignes : [52](../../../../.src/Utils/RichDataGrid.class#L52)

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/Tables/Remisec.class` | `<type>`, `ColFormats`, `DataField`, `Display`, `Fields`, `Refresh`, `Table`, `Value` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `CFormat` | `<type>`, `Alignment`, `Background`, `Font`, `Foreground`, `Format`, `Padding` |
| `Conditions` | `<type>`, `Compute`, `Value` |
| `Utils` | `Cdate_Aff` |

### Tables SQL référencées

_Aucune._
<!-- /AUTO:dependances -->

## Notes d'analyse

- Seul appelant : `Gestion/Tables/Remisec.class` (vérifié par `grep -rni RichDataGrid .src`) :
  `New RichDataGrid(Tabtypec) As "Tabtypec"` (ligne 47), propriétés `Table`, `Fields`, `Display`,
  `DataField`, `ColFormats` (lignes 61-73), `Refresh` (76, 283, 316), `Value` (86, 279, 281).
  Aucun `.form` ne l'instancie (ce n'est pas un `UserControl`) ; le `GridView` `Tabtypec` de
  `Remisec.form` ne doit pas changer.
- **Non détecté par `deps.py`** : `db.Exec` (ligne 116) appelle la classe statique `DB` de gb.db,
  pas `Utils.db` ; dépendance implicite à `DB.Current` (à confirmer : connexion ouverte par
  `DB_Connection`).
- Les membres `<inconnu:backcolor>`/`<inconnu:forecolor>` attribués à `CFormat` sont réellement
  absents de `CFormat` (anomalie A03), et `<inconnu:font>`/`<inconnu:format>` correspondent aux
  propriétés `{Font}`/`{Format}` déclarées entre accolades (limite du parseur).
- Classe `Conditions` (`.src/Utils/Conditions.class`) : utilisée par `CondFormats`, aucun appelant
  ne remplit `CondFormats` aujourd'hui.
- Appel dynamique ligne 52 : `Object.Attach` (redirection des événements de la grille).
- `Grid_Read` et `Grid` : `gambas_parse.py` étiquette `Grid_Read` « handler GUI » ; c'est
  l'accesseur de la propriété `Grid` (faux positif d'étiquetage).
- Ordre de rework : après `CFormat` ; rejouer les tests de `Remisec`.
