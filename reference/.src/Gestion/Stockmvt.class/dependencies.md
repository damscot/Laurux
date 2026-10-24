# Stockmvt — Dépendances

> Source : `.src/Gestion/Stockmvt.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Stockmvt.class` — classe, formulaire associé `Stockmvt.form`
- Handlers GUI détectés : 12
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `ColumnView1`, `GridView1`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Achat` | `Validee` |
| `DB_Connection` | `Exec` |
| `Editeur` | `Prog_Editeur` |
| `LDate` | `<type>`, `DT`, `EDeb`, `FinJour`, `FinMois`, `G`, `L`, `_call` |
| `ObjFac` | `archive`, `bl` |
| `ObjFacB` | `<type>`, `visualisation` |
| `ProgBar` | `<type>` |
| `Start` | `B`, `G`, `Musique`, `R` |
| `TextReg` | `<form>`, `EstDate`, `Name`, `Text`, `Type`, `reg` |
| `TriArticles` | `<type>` |
| `TriCpt` | `<type>`, `Client`, `Fournisseur`, `Sans_Solde` |
| `Trifam` | `<type>`, `Text`, `cle`, `enfant`, `parent`, `precedant` |
| `Utils` | `Observers`, `db`, `fam`, `totobs` |
| `Visualiseur` | `Prog` |
| `chainage` | `<type>` |
| `commande1` | `<type>` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Bl`, `Fiches_BlM`, `Fiches_Centrales`, `Fiches_Entrecpt`, `Fiches_Fam`, `Fiches_HisEntTickets`, `Fiches_HisLigTickets`, `Fiches_HistoFac`, `Fiches_HistoFacM`, `Fiches_HistoLigfac`, `Fiches_HistoLigfacM`, `Fiches_Ligbl`, `Fiches_LigblM`, `Fiches_Ligrecpt`, `Fiches_Marques`, `Fiches_Mvtexp`, `Fiches_Mvtexpdc`, `Fiches_Parametres`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelant vérifié** : `Fmenu.class:2473` (`mvst_Click`, `Stockmvt.Show`, auto-instance), seul
  point d'entrée.
- `deps.py` : `arity_errors`, `unused`, `handlers_inactifs`, `replay_dynamic`, `scope_reducible`
  vides ; vérifié. `GridView1` est une `GridView` mais n'a pas de `GridView1_Click` : un clic
  rejoué par `ReplayObserver` appellerait une méthode inexistante (même limite que d'autres
  grilles) ; seul `GridView1_Activate` (double-clic) est géré.
- **Homonymie** : la méthode privée `TriArticles` et la classe `TriArticles` (l. 927-938) ; un outil
  qui résout par nom peut confondre l'appel `TriArticles($familles.enfant)` avec la classe.
- `Bsel`/`Bval` : écrits par `TriCpt`/`TriArticles` via `Object.SetProperty` (chaînes `"Bsel"`,
  `"Bval"`) : à ne jamais réduire.
- Groupe `dte` (`Textdtinf`/`Textdtsup`) déclaré dans le `.form` sans handler : normal.
- Tables : toutes en littéral et détectées ; aucune passée par `Cbase.Table`.
- Dépendance de comportement à `Utils.fam` (UTILS-A02) et à `DB_Connection` (traduction SQLite de
  `CONCAT`, `MONTH`, `YEAR`).
- **Ordre de rework** : la commonalisation des sources de mouvements avec
  [`Cstock`](../../Utils/Cstock.module/rework.md) est à planifier dans le même lot de phase 3 ; la
  correction d'UTILS-A02 modifie le comportement de `Radiofam` sans sélection.
