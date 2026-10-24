# JournauxM — Dépendances

> Source : `.src/Compta/Impressions/JournauxM.module` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Impressions/JournauxM.module` — module
- Handlers GUI détectés : 0

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Compta/Impressions/Journaux.class` | `Imprime` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Ccompta` | `<type>`, `BasPage2`, `Entete`, `Level0J`, `Level1J`, `Level1JT`, `Lines`, `level2J`, `level2JT`, `level6J`, `level7J` |
| `DB_Connection` | `Engine`, `Exec` |
| `Journaux` | `<hérité>` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `Societe` |
| `Utils` | `Cdate_Aff`, `Cdate_Dbase`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Comptes`, `Fiches_Journaux`, `Fiches_Parametres`, `Fiches_Societes`

### Membres Public sans usage externe détecté (portée réductible ?)

`Raz`, `Centralisation`, `Createtable`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelant unique** : `Journaux.Button1_Click` (`Journaux.class:607`), avec `Cloture = False`
  et la **commande** `RadioButton1` (objet) passée au paramètre booléen de tri (voir
  JOURNAUX-A01). `EcrM.class` ne l'appelle pas : il en contient une copie.
- **Couplage inverse** : le module lit et écrit `Journaux.Mouse` (l. 70, 314), ce qui crée une
  dépendance circulaire `Journaux` ↔ `JournauxM`. Les deux fichiers doivent être reworkés dans le
  même lot.
- **Non vu par `deps.py`** : `Ccompta` (variable de module `pdf` : `Entete`, `Level0J`,
  `Level1J`, `level2J`, `Lines`, `Baspage2`, `level6J`, `level7J`, `level1JT`, `level2JT`,
  `Output`, `Open`, `AliasNbPages`) ; `Visualiseur.Prog` ; la table reçue en paramètre `Tab0`
  (`Fiches_Mvt` … `Fiches_Mvt5`) ; la table de travail `centralisation` (DDL, `SELECT`,
  `UPDATE`, `INSERT`), absente de `db_control.csv`.
- **Tables écrites** : uniquement `centralisation` ; elle apparaît donc dans le dump de base des
  replays et doit être comparée (ou exclue explicitement) par le runner.
- **Ordre de rework** : après `Ccompta` (rendu inchangé) ; le socle `ImpCompta`
  (centralisation) est créé ici puis repris par `JournauxA`, `Jourcent` et `EcrM`.
