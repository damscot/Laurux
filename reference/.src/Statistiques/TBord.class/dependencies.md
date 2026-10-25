# TBord — Dépendances

> Source : `.src/Statistiques/TBord.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Statistiques/TBord.class` — classe, formulaire associé `TBord.form`
- Handlers GUI détectés : 1

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |
| `.src/Communs/Prgm.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Engine`, `Exec` |
| `Start` | `LocalSettings`, `Societe`, `son` |
| `Utils` | `Cdate_Dbase`, `PointBase`, `cpoint`, `db` |
| `Variables` | `Musique`, `son` |

### Tables SQL référencées

`Fiches_Bl`, `Fiches_BlM`, `Fiches_HistoFac`, `Fiches_HistoFacM`, `Fiches_Parametres`

### Membres Public sans usage externe détecté (portée réductible ?)

`Traitement`, `Aff_Mois`, `Draw_Chart`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelants** (vérifiés par `grep -rn`) : `Fmenu.class:2068` (`TBord.Show()`, auto-instance) et
  `Prgm.class:70` (`If Prog = "Tbord" Then TBord.Show()`, dispatcher par nom saisi). Aucun appel
  dynamique.
- **Table de travail `Total`** non vue par `deps.py` (nom en dur dans une variable `Tab2`, puis dans
  `DROP TABLE IF EXISTS  Total`) : recréée à chaque ouverture, partagée par nom avec `HitCarte`,
  `VisHitCartes` (lecture), `StatClimo`, `StatComm`, `StatComArt`, `StatFour`, `StatTypCli`,
  `VisStat*` et `Caisse/Statcai` (structures différentes, STATCAI-A04).
- Les tables `Fiches_HistoFac`, `Fiches_HistoFacM`, `Fiches_Bl`, `Fiches_BlM` sont citées en dur
  (variables `Tab`, `Tab3`, `Tab4`, `Tab5`) ; seul le comptage des documents en cours et la devise
  passent par `Cbase.Table`.
- Dépendances de configuration : `/Soc<XX>/Materiel` (union avec les tables `M`), `/Soc<XX>/Prxdec`
  (échelle de l'histogramme).
- `Variables.Musique`/`Variables.son` au lieu de `Start.Musique`/`Start.Son` (seul écran du lot dans ce
  cas).
- SQL `MONTH()` : traduit en `strftime('%m', …)` par `DB_Connection.Exec` sous SQLite, **mais** le
  paramètre `&1` est une `Date` substituée avant la traduction ; si la valeur substituée contient
  l'heure (`:`), elle sort de la classe de caractères de la regex (`[()'. a-zA-Z0-9_-]`) et
  `MONTH('…')` n'est pas traduit (TBORD-A02, à confirmer sous SQLite).
- Ordre de rework : indépendant ; à traiter avec `VisHitCartes` si la commonalisation de
  l'histogramme est retenue.
