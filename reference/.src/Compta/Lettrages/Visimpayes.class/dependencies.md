# Visimpayes — Dépendances

> Source : `.src/Compta/Lettrages/Visimpayes.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Lettrages/Visimpayes.class` — classe, formulaire associé `Visimpayes.form`
- Handlers GUI détectés : 4
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Colbl_Click`
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `Coldetail`

### Utilisé par

_Aucun usage externe détecté statiquement._

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Engine`, `Exec` |
| `Doc` | `Open` |
| `Start` | `Musique` |
| `Utils` | `Cdate_Aff`, `Coulfd`, `Observers`, `db` |

### Tables SQL référencées

`Fiches_Cli`, `Fiches_Mvt`, `Fiches_Parametres`

### Membres Public sans usage externe détecté (portée réductible ?)

`recup_bl`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Aucun appelant** : `grep -rni "visimp" .src` ne trouve que `Visimpayes.class` et
  `Visimpayes.form` (ni menu, ni `New`, ni `Show`). `deps.py` le confirme (`used_by` vide).
- Tables non vues par `deps.py` : `Facturefm` et `Detail` (noms dans des variables `Tab3`/`Tab4`,
  créées par `CREATE TABLE`). `Facturefm` est partagée avec `FacturefmA` (`.src/Gestion/Facturation/FacturefmA.class:179`)
  et `ObjFacB` (`.src/Gestion/option/ObjFacB.class:626`), avec une autre structure.
- Ordre de rework : à traiter en premier par la décision de suppression (A01) ; aucun autre fichier
  n'est impacté par cette suppression.
