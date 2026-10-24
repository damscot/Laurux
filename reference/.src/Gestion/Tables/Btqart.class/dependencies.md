# Btqart — Dépendances

> Source : `.src/Gestion/Tables/Btqart.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Tables/Btqart.class` — classe, formulaire associé `Btqart.form`
- Handlers GUI détectés : 8
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `ChkInput`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Engine`, `Exec` |
| `Doc` | `Open` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `TriArticles` | `<type>` |
| `Utils` | `Fcolr`, `Observers`, `SetEditColor`, `db` |

### Tables SQL référencées

`Art_Saisis`, `Fiches_Art`, `Fiches_Fam`, `Fiches_Tvaav`

### Membres Public sans usage externe détecté (portée réductible ?)

`SelectionArt`, `Art_man`, `ChkInput`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Seul appelant : `Fmenu.Menu184_Click` (`Fmenu.class:1727`), `Btqart.ShowModal()` sur
  l'auto-instance ; chaque ouverture recrée `Art_Saisis` et tronque les fichiers.
- **Portée réductible, faux positifs à exclure** : `Bsel`/`Bval` (variables) sont écrits par
  `TriArticles` via `Object.SetProperty(Obj, "Bsel"/"Bval", …)` (`TriArticles.class:30-31`,
  `165-166`) : ils restent `Public`. `SelectionArt` et `Art_man` sont réellement réductibles (grep).
- **Code mort** : `ChkInput` (`unused`, confirmé par grep).
- **Table `Art_Saisis`** : détectée par `deps.py` via `Cbase.Table("TabArtSaisis")` ; table de travail
  créée à l'exécution, absente de `db_control.csv` (vérifié), sans colonne de poste : collision
  multi-utilisateurs. Écritures : `DROP`/`CREATE`/`INSERT` sur `Art_Saisis` ; lectures seules sur
  `Fiches_Art`, `Fiches_Tvaav`, `Fiches_Fam`.
- **Dépendances non vues par l'heuristique** : commande externe `wput` (`Shell`), fichiers
  `User.Home/Prd.csv` et `Photo.csv`, paramètres saisis dans `Prefs` (`Prefs.class:284-286`,
  `650-652`).
- Aucun appel dynamique entrant (pas de `GridView`/`ColumnView`/`ListBox` : `ListBart` est un
  `TextLabel`).
- Ordre de rework : indépendant ; BTQART-004 avant toute correction de A04/A05.
