# Visreglements — Dépendances

> Source : `.src/Gestion/Reglements/Visreglements.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Reglements/Visreglements.class` — classe, formulaire associé `Visreglements.form`
- Handlers GUI détectés : 5
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Colbl_Click`
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `Coldetail`

### Utilisé par

_Aucun usage externe détecté statiquement._

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Engine`, `Exec` |
| `Doc` | `Open` |
| `Start` | `LocalSettings`, `Musique` |
| `Utils` | `Cdate_Aff`, `Coulfd`, `Fcolr`, `Observers`, `PointBase`, `db` |

### Tables SQL référencées

`Fiches_Cli`, `Fiches_Comptes`, `Fiches_Mvt`, `Fiches_Parametres`

### Membres Public sans usage externe détecté (portée réductible ?)

`recup_bl`, `Calc_solde`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Aucun appelant** (vérifié) : `grep -rn "Visreglements" .src` ne renvoie que ce fichier et son
  `.form` ; absent de `Fmenu`, de `Prgm` (dispatcher par nom saisi) et de toute chaîne passée à
  `Object.New`/`Class.Load`. `deps.py` est cohérent (`used_by` vide).
- `Doc.Open("Visreglements")` (l. 251) est un appel d'aide HTML par nom, pas un appelant.
- Tables non détectées par l'heuristique : tables de travail `Facturefm` et `Detail` (noms dans
  des variables `Tab3`/`Tab4`). `Facturefm` est partagée avec `Facturefm.class`,
  `FacturefmA.class` et `Visimpayes.class` (collision, voir architecture.md).
- `replay_dynamic` : `Colbl_Click` (ColumnView) est appelé par `ReplayObserver.Replay_Click` via
  `Object.Call` → doit rester `Public`. `Coldetail` n'a pas de `_Click` : un clic rejoué sur cette
  grille appellerait une méthode inexistante (même cas que `Saisecrit.Ecrit1`).
- Les membres déclarés sans `Private` (l. 28-34) n'apparaissent pas dans le tableau des
  déclarations généré (limite de `gambas_parse.py`).
- Pas de dépendance circulaire ; aucune contrainte d'ordre (fichier isolé).
