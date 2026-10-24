# DateTar — Dépendances

> Source : `.src/Gestion/Entrées/DateTar.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Entrées/DateTar.class` — classe, formulaire associé `DateTar.form`
- Handlers GUI détectés : 10
- ⚠️ Accès par l'auto-instance du formulaire alors que la classe est aussi ouverte par `New` (la fenêtre affichée n'est pas celle modifiée) : `Fmenu:225` → `EnrTouTar`
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `ListArt`, `ListFour`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `EnrTouTar` |
| `.src/Gestion/Stock/commande1.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Create9`, `Edit`, `Exec` |
| `GesTar` | `TarCli`, `TarGen`, `TarTcli` |
| `LDate` | `D`, `G`, `_call` |
| `LPrix` | `<type>`, `Add_Taxe`, `G`, `PuNHT`, `PuNTC` |
| `LTaxe` | `<type>`, `Remise`, `TVA` |
| `ProgBar` | `<type>`, `Avancement` |
| `TextReg` | `<form>`, `EstDate`, `Text`, `Type`, `dte` |
| `Utils` | `db` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_TarTemp`, `Fiches_TarTypcli`, `Fiches_Tarcli`, `Fiches_Tvaav`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelants** : `commande1.tardt_Click` (`commande1:856`, `New DateTar(Null, fcode.Text)` puis
  `ShowModal`) et `Fmenu:225` (`DateTar.EnrTouTar(rResult)` au démarrage, sur l'auto-instance du
  formulaire). Le `Result` passé par `Fmenu` est `SELECT * FROM Fiches_TarTemp WHERE date <= &1 AND
  dtmaj = &2` (`Fmenu:223`) : le contrat porte sur les colonnes `art`, `temp_type`, `code`,
  `temp_coef`, `temp_sup`, `pxrev`, `pbht`, `paht`, `frais`, `txconv`, `rm`.
- **Signaux `deps.py`** : aucun (`arity_errors`, `unused`, `handlers_inactifs`,
  `replay_dynamic`, `scope_reducible` vides). Les `ListBox` (`ListFour`, `ListArt`) ne sont pas
  des cibles de `replay_dynamic` ici car aucun handler `_Click` n'existe pour elles (handlers
  `_Activate`).
- Contrôle `ListView1` du `.form` jamais utilisé dans la classe (le `.form` n'est pas modifiable).
- `GesTar.TarGen/TarCli/TarTcli` : seules dépendances de code vers `GesTar`.
- **Ordre de rework** : DATETAR-005 avec GESTAR-008 (fabrique de prix commune).
