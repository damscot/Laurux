# ImpartParam — Dépendances

> Source : `.src/Gestion/Stock/Tarifs/ImpartParam.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Stock/Tarifs/ImpartParam.class` — classe, formulaire associé `ImpartParam.form`
- Handlers GUI détectés : 33
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `fourList_Click`, `FamList_Click`, `DefList_Click`
- ⚠️ Requêtes dont les arguments ne correspondent pas aux marqueurs `&N` : l. 689 (55 argument(s), marqueurs [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58]), l. 702 (4 argument(s), marqueurs [4, 30, 31, 32])
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `Champs`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `Utils` | `ObsGotf`, `ObsLstf`, `Observers`, `db` |

### Tables SQL référencées

`Fiches_Fam`, `Fiches_Four`, `Fiches_ImpArtDef`, `Fiches_ImpArtDef2`

### Membres Public sans usage externe détecté (portée réductible ?)

`Lignes`, `affiche_Selection`, `DefColonnes`, `EnregistreZones`, `Renumerotation`, `Efface_Zone`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Seul appelant : `Fmenu.Menu245_Click` (`Fmenu.class:2032`, `ImpartParam.ShowModal()`).
- Les 6 membres `scope_reducible` (`Lignes`, `affiche_Selection`, `DefColonnes`,
  `EnregistreZones`, `Renumerotation`, `Efface_Zone`) n'ont aucun appelant externe (`grep`).
- `replay_dynamic` : `fourList_Click`, `FamList_Click`, `DefList_Click` doivent rester `Public`.
- `replay_missing` : la grille `Champs` (ColumnView) n'a pas de `Champs_Click` (seulement
  `Champs_Activate` et `Champs_KeyPress`) : un clic rejoué ferait `Object.Call` d'une méthode
  inexistante (voir REPLAYOBSERVER-A06) ; les scénarios utilisent le double-clic/Entrée.
- Handler `BtnSupprime_Click` : groupe `BtnSupprime` du bouton `Button3` (non détecté comme
  handler de contrôle nommé, mais bien levé).
- **Dépendance de données** : les définitions écrites ici sont lues par `Impart`
  (`Impart.DefList_Click`, `ChargementFichierDef`, `Import`, `Maj_*`) : toute correction des
  anomalies A01-A03 change les données lues par `Impart` ; les deux fichiers sont à traiter dans
  le même lot.
- Tables en dur : `Fiches_ImpArtDef`, `Fiches_ImpArtDef2` (pas de clé `Cbase`).
