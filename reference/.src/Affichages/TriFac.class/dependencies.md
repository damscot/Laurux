# TriFac — Dépendances

> Source : `.src/Affichages/TriFac.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Affichages/TriFac.class` — classe, formulaire associé `TriFac.form`
- Handlers GUI détectés : 26
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `ColFac_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/Facturation/Facture.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `Start` | `LocalSettings`, `Societe` |
| `Utils` | `Base2`, `Fcolr`, `cpoint`, `rs2` |
| `Variables` | `Bsel`, `numeroFac` |

### Tables SQL référencées

`Fiches_HistoFac`

### Membres Public sans usage externe détecté (portée réductible ?)

`Deb2`, `Deb2b`, `Deb3b`, `Deb3`, `Tris`, `Titre`, `Dbclk`, `Deplacement`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Seul appelant** (vérifié par `grep -rn "TriFac\b"`) : `Facture.Creation(Avr2 = True)`
  (`Facture.class:12098-12102`, déclenché par `Button26_Click`, avoir à partir d'une facture). Le
  constructeur reçoit `code.Text` ou `""`.
- **Protocole de retour par état global** : `Variables.Bsel` / `Variables.numeroFac` (module
  `Variables`), lus par `Facture.class:12111` puis par `EntFac` (`Facture.class:9909`, `10018`).
  `Variables.Bsel` est partagé avec d'autres listes (`TriArticles`…) et **n'est pas remis à `False`**
  par `Facture.Creation` avant l'ouverture (voir TRIFAC-A04).
- `ColFac_Click` est appelé dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`) : il
  doit rester `Public` (`replay_dynamic`). Pas de `replay_missing`, pas d'`unused`, pas
  d'`arity_errors`, pas de `handlers_inactifs`.
- Les « membres Public sans usage externe » (`Deb2`, `Deb2b`, `Deb3b`, `Deb3`, `Tris`, `Titre`,
  `Dbclk`, `Deplacement`) sont confirmés par `grep` : aucun usage hors du fichier.
- `Utils.rs2` est un résultat **global** partagé : `ColFac_Data` lit `rs2` rempli par `Deb*`. Toute
  autre liste qui appelle `Utils.Base2` pendant que `TriFac` est affiché (impossible en modal, sauf
  depuis un handler de `TriFac`) écraserait les données.
- Table : `Fiches_HistoFac` (via `Cbase.Table("TabHisFac")`) en lecture seule.
- Dépendance de rework : `TriFac2` (socle commun `RequeteFactures`) et la classe `PaginationListe`
  du lot Caisse/Affichages doivent être traités avant les reworks de commonalisation (phase 3).
- L'écran n'appelle pas `Utils.Observers(Me)` : il n'est pas instrumenté pour le log/replay.
