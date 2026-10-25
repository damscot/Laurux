# atribvignette — Dépendances

> Source : `.src/Gestion/option/atribvignette.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/option/atribvignette.class` — classe, formulaire associé `atribvignette.form`
- Handlers GUI détectés : 4
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `ColumnView1`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/option/menuopt.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `Utils` | `db` |

### Tables SQL référencées

`Fiches_Bl`, `Fiches_Entrecpt`, `Fiches_Four`, `Fiches_HistoFac`, `Fiches_ligregie`, `Fiches_regie`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Ouverture** : `menuopt.vign_click` (`menuopt.class:81`).
- **Producteurs des lignes affichées** (vérifiés par `grep` sur `Fiches_ligregie`) :
  `ObjFacB.class:437`, `:485` (sorties `S` avec vignette, `:1014` transforme `C` en `S`),
  `Achat.class:959` (entrées `E` avec vignette), `fourconsdroi.class:227` (`E`), `Mvtex.class:510`
  (`S`/`E`), `Validinv.class:255` (inventaire `I`, clôturé), `Caleditcmat` (clôture et stock `M`).
  Un changement de format de la vignette ou de la colonne `numlig` les concerne.
- **`replay_missing` : `ColumnView1`** (vérifié) : la liste des vignettes manquantes n'a pas de
  `ColumnView1_Click` ; elle n'est qu'affichée. Le rejeu d'un clic sur cette liste échouerait,
  mais aucun scénario n'en a besoin.
- Écran sans `Utils.Observers(Me)` : non journalisé (voir test.md).
- Tables de l'option boissons nommées en dur, sans clé `Cbase`.
