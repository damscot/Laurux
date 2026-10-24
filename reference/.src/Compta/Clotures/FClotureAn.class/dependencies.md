# FClotureAn — Dépendances

> Source : `.src/Compta/Clotures/FClotureAn.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Clotures/FClotureAn.class` — classe, formulaire associé `FClotureAn.form`
- Handlers GUI détectés : 4

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `AutoIncrement`, `CopieTable`, `Engine`, `Exec` |
| `Doc` | `Open` |
| `LDate` | `<type>`, `G` |
| `ProgBar` | `<type>`, `Avancement`, `Finalize` |
| `Sha1Calc` | `CalcSha1_all` |
| `Start` | `LocalSettings`, `Musique`, `son` |
| `Utils` | `Cdate_Aff`, `Cdate_Comp`, `Cdate_Dbase`, `Observers`, `PointBase`, `cpoint`, `db` |

### Tables SQL référencées

`Fiches_Comptes`, `Fiches_Mvt`, `Fiches_Mvt1`, `Fiches_Mvt2`, `Fiches_Mvt3`, `Fiches_Mvt4`, `Fiches_Mvt5`, `Fiches_MvtA`, `Fiches_MvtA1`, `Fiches_MvtA2`, `Fiches_MvtA3`, `Fiches_MvtA4`, `Fiches_MvtA5`, `Fiches_MvtM`, `Fiches_MvtM1`, `Fiches_MvtM2`, `Fiches_MvtM3`, `Fiches_MvtM4`, `Fiches_MvtM5`, `Fiches_Parametres`

### Membres Public sans usage externe détecté (portée réductible ?)

`Aff_date`, `Calc_Daterpt`, `Sauve`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Appelant unique : `Fmenu.Menu60_Click` (`Fmenu.class:851`, `FClotureAn.Show()`, **non modal**),
  précédé d'un contrôle `Utils.ControlTunnel()` si la réplication SSH est active.
- Tables non détectées par `deps.py` (noms hors `Fiches_` ou construits) : `Report` et `ReportM`
  (tables de travail créées et laissées dans la base).
- `DB_Connection.CopieTable` (l. 357, 364, 371) : sous SQLite, la table destination n'est pas
  créée (DB_CONNECTION-A04) ; sous MySQL, `CREATE TABLE … LIKE` (structure et index, sans données).
- `Sha1Calc.CalcSha1_all("Fiches_Mvt")` (l. 631) recalcule la colonne `control` de toutes les
  écritures : tout rework de `Sha1Calc` impose de rejouer les tests de clôture.
- Commande externe : `mysqldump` (shell, l. 663) ; client requis sur l'hôte du runner, connexion
  `127.0.0.1:3306` (le port n'est pas passé).
- Relation fonctionnelle (sans appel direct) avec `Csolde` (même recalcul), `FCloture` (dates de
  période), `Listextcpt`/`Extrait` (lisent `Fiches_Mvt1..5` après rotation) et `LDate`
  (`Exercice_Cloture` lit `dteclec*`).
- Ordre de rework : après DB_CONNECTION-A04 (si validée), SAUVESAUTO-003 (`Utils.DumpBase`) et
  le rework de `Csolde` ; en même temps que `FCloture`.
