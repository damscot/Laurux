# Imp_Sig — Dépendances

> Source : `.src/Compta/Impressions/Imp_Sig.module` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Impressions/Imp_Sig.module` — module
- Handlers GUI détectés : 0
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Button1_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Compta/Impressions/RubImp.class` | `Lancement` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `Csig` | `<type>`, `BasPage`, `Level0`, `Level1`, `Level2`, `Level3`, `Lines`, `Lines2`, `Lines3` |
| `DB_Connection` | `Engine`, `Exec` |
| `Doc` | `Open` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `Societe` |
| `Utils` | `Cdate_Dbase`, `cpoint`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Comptes`, `Fiches_Mvt`, `Fiches_Mvt1`, `Fiches_Mvt2`, `Fiches_Mvt3`, `Fiches_Mvt4`, `Fiches_Mvt5`, `Fiches_Parametres`, `Fiches_RubCompt`, `Fiches_Rubriques`, `Fiches_Societes`

### Membres Public sans usage externe détecté (portée réductible ?)

`Button1_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse
- **Appelant unique** : `RubImp.Button2_Click` (`RubImp.class:591`), bouton radio `Sig` coché.
  Les paramètres `Detail`, `dte1` et `dte2` sont reçus mais sans effet sur l'édition (`dtes1`/`dtes2`
  jamais relus ; `Detail` seulement passé à `Csig.Level0`, qui l'ignore, vérifié).
- **Classe d'impression** : `Csig` (`.src/Reports/Csig.class`, `Inherits PdfWriter`, format paysage
  `"l"`). Appels `level0`, `level1`, `level2`, `level3`, `Lines`, `Lines2`, `Lines3`, `Baspage`.
- **Table de travail** `centralisation` (version SIG : `col1`, `prod`, clé `numrub, compte`),
  partagée par nom avec `Imp_Bilan`, `RubImp`, `Jourcent`, `EcrM`, `ExportA47`, `Intjdv`,
  `JournauxM` (structures différentes, `DROP`/`CREATE` à chaque édition). Invisible pour `deps.py`.
- `deps.py` liste `Fiches_Parametres`, `Fiches_Comptes` et `Fiches_Mvt1`…`Mvt5` : les variables
  `Tab2`, `Tab4` et `Tab6` sont affectées mais jamais utilisées dans une requête (dépendances
  fictives). Seule `Tab5` (une table Mvt) est lue.
- **Fichier produit** : `~/tmp/SIG.pdf`, ouvert par `Visualiseur.Prog`.
- `Button1_Click` : code mort (module sans formulaire, aucun appel).
- Contrainte d'ordre : avec `Imp_Bilan` et `RubImp`.
