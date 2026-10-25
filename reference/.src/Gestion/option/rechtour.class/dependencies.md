# rechtour — Dépendances

> Source : `.src/Gestion/option/rechtour.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/option/rechtour.class` — classe, formulaire associé `rechtour.form`
- Handlers GUI détectés : 4
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `GridView1`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/Facturation/Facture.class` | `<type>` |
| `.src/Gestion/Facturation/Facturefm.class` | `<type>` |
| `.src/Gestion/Tables/FClient.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `Utils` | `db` |

### Tables SQL référencées

`Fiches_tourne`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Événement `trouve`** : l'heuristique liste les appelants (`<type>` + `ShowModal`) mais pas les
  handlers d'événement qui en dépendent : `Facture.to1_trouve` (`Facture.class:12202`),
  `Facturefm.tourne_trouve` (`Facturefm.class:755`), `FClient.butto1_trouve` (`:3304`) et
  `FClient.butto2_trouve` (`:3352`). Changer la signature ou la valeur renvoyée (l'espace de la
  touche Suppr) impose de les mettre à jour dans le même commit.
- `Facture.class` déclare aussi un handler `tr1_trouve` (`Facture.class:12235`) : il ne dépend pas
  de `rechtour` (autre fenêtre de recherche, à documenter dans le lot Facturation).
- **`replay_missing` : `GridView1`** (vérifié) : la grille n'a pas de `GridView1_Click`. Si le
  rejeu passe par `Object.Call(…, "GridView1_Click")`, il échouera ; de plus la fenêtre n'appelle
  pas `Utils.Observers(Me)`, ses actions ne sont donc pas journalisées du tout.
- Table `Fiches_tourne` nommée en dur (pas de clé `Cbase`).
- Ordre de rework : indépendant ; la clé `Cbase` éventuelle (RECHTOUR-003) se fait avec TTOURNE-004.
