# gridvi — Dépendances

> Source : `.src/Utils/gridvi.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/gridvi.class` — classe
- Handlers GUI détectés : 3

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/Tables/Articles.class` | `<type>`, `bouton_Click`, `code`, `dec`, `razcol` |
| `.src/Gestion/Tables/FClient.class` | `<type>`, `code`, `dec`, `razcol` |
| `.src/Gestion/Tables/Famille.class` | `<type>`, `bouton_Click`, `code`, `dec`, `razcol` |
| `.src/Gestion/Tables/Movr.class` | `<type>`, `bouton_Click`, `code`, `dec`, `razcol` |
| `.src/Gestion/option/Ttourne.class` | `<type>`, `code` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `LDate` | `<type>`, `Day`, `Month`, `Year`, `_call` |
| `Utils` | `db`, `lastday`, `mois`, `totobs` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Bl`, `Fiches_BlM`, `Fiches_HistoFac`, `Fiches_HistoFacM`, `Fiches_HistoLigfac`, `Fiches_HistoLigfacM`, `Fiches_Ligbl`, `Fiches_LigblM`, `Fiches_Mo`, `Fiches_Parametres`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Appelants vérifiés par `grep -rni 'gridvi'` : les 5 fichiers listés, chacun avec
  `Private … As Gridvi` + `New Gridvi(TabStrip, "<type>")` :
  `Articles.class:190` (`A`), `FClient.class:170` (`C`), `Famille.class:90` (`F`),
  `Movr.class:70` (`M`), `Ttourne.class:15` (`T`).
- Appels de membres : `razcol` (`Articles:191,488`, `FClient:171,757`, `Famille:92`, `Movr:72`),
  `bouton_Click` (`Articles:489`, `Famille:188`, `Movr:215`), `code`, `dec`
  (`Ttourne` ne fixe que `code` : `$sdec` reste vide, les quantités sont formatées sans décimale).
- Handlers créés dynamiquement (`New Button(pan) As "bouton"`, `As "sousfam"`,
  `New GridView(…) As "grdv"`) : l'objet `gridvi` est l'observateur implicite. Les noms
  `bouton_Click`, `sousfam_click`, `grdv_MouseUp` sont donc intouchables.
- `Last` (bouton « Familles ») dans `sousfam_click` : non résolu par `deps.py`.
- Aucun `.form` associé ; la classe n'est pas un `UserControl`. Les formulaires des appelants ne
  sont pas concernés.
- Tables : la liste AUTO est exacte (11 tables, toutes en dur, sans `Cbase.Table`).
- Aucune dépendance circulaire. Ordre de rework : indépendant de `gridvi2`/`gridv` (code mort à
  supprimer d'abord pour lever toute ambiguïté), à faire avant un éventuel module commun avec
  `Tregie`.
