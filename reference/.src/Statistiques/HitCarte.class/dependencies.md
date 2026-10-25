# HitCarte — Dépendances

> Source : `.src/Statistiques/HitCarte.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Statistiques/HitCarte.class` — classe, formulaire associé `HitCarte.form`
- Handlers GUI détectés : 4

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |
| `.src/Statistiques/VisHitCartes.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Engine`, `Exec` |
| `Start` | `LocalSettings`, `Musique`, `son` |
| `Utils` | `Cdate_Aff`, `Cdate_Dbase`, `Cdate_calc`, `Fcolr`, `Observers`, `SetEditColor`, `cpoint`, `db` |
| `VisHitCartes` | `<type>` |

### Tables SQL référencées

`Fiches_Carte`, `Fiches_HisEntTickets`, `Fiches_HistoFac`

### Membres Public sans usage externe détecté (portée réductible ?)

`dteN0_LF`, `dteN1_LF`, `Traitement`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelant** : `Fmenu.class:2008` (`HitCarte.ShowModal()`, auto-instance). `VisHitCartes` ne fait que
  typer son paramètre `Hitniv As HitCarte` (jamais utilisé dans `VisHitCartes`).
- `deps.py` liste `Fiches_HistoFac` à cause de la variable morte `Tab` : la table n'est **pas** lue.
- **Table de travail `Total`** non détectée (nom en dur) : écrite ici, lue par `VisHitCartes` ; même
  nom que les tables de travail de `TBord`, `Stat*` et `Caisse/Statcai` (STATCAI-A04).
- Lecture de `Fiches_Carte` partagée avec `FClientcarte`, `Tricartes`, `Caisse.RecupClientd`,
  `EmailingCarte` (commonalisation `LitCarte`, FCLIENTCARTE-008) : ordre de rework → après
  FCLIENTCARTE-008.
- Couplage fort avec `VisHitCartes` : contrat implicite sur la structure de `Total` (`carte`, `nom`,
  `points`, `visite`) et sur la signature `_New(Hitniv, Tot, Sn, tri, dte1, dte2)` ; toute
  modification se fait dans le même commit.
- Aucun appel dynamique.
