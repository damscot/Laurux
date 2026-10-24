# Txmo — Dépendances

> Source : `.src/Gestion/Tables/Txmo.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Tables/Txmo.class` — classe, formulaire associé `Txmo.form`
- Handlers GUI détectés : 8
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Coltxmo_Click`, `Colcompt_Click`

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
| `Start` | `Musique`, `son` |
| `Utils` | `Observers`, `SetEditColor`, `cpoint`, `db` |

### Tables SQL référencées

`Fiches_Comptes`, `Fiches_Mo`, `Fiches_Txtmo`

### Membres Public sans usage externe détecté (portée réductible ?)

`Refresh`, `Maj_Zones`, `Cleanchamps`, `Button1_Click`, `MajMo`, `Calc_MargeMo`, `Button3_Click`, `codecompt_LostFocus`, `txtmo_LostFocus`, `Prvt_LostFocus`, `compteGman`, `Button5_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Point d'entrée unique : `Fmenu.Menu28_Click` (`.src/Communs/Fmenu.class:893`, `Txmo.Show` sur
  l'auto-instance, non modal). Aucun membre de `Txmo` n'est appelé de l'extérieur.
- **Homonymes** : `Txmo` est aussi le nom d'un contrôle de `Facture.form` (`Facture.class:646`,
  `1006`…), d'une variable privée d'`Archives.class:33` et d'une variable locale
  d'`Edmo.class:429`. Dans ces fichiers le nom local masque la classe : ce ne sont **pas** des
  appelants (à juste titre absents de `used_by`).
- Lecteurs de `Fiches_Txtmo` hors de ce fichier (à repasser si le format de `tx_txtmo` change) :
  `Movr` (`TxMoMan`, `ToggleButton5_Click`), `Prefs.class:198`, `Suivi.class:81`.
- Écrivain de `Fiches_Mo` : `MajMo` modifie `mo_txht`, `mo_prvt`, `mo_marge` des MO du taux ; les
  fiches MO sont gérées par [Movr](../Movr.class/dependencies.md) et lues par la facturation
  (`Facture`, `Prodcomposes`). Tout rework de `MajMo` doit repasser TXMO-T02.
- Pseudo-handlers : `txtmo_LostFocus`, `Prvt_LostFocus`, `codecompt_LostFocus`, `Button1_Click`,
  `Button3_Click`, `Button5_Click` sont rattachés à un groupe du `.form` (`Tmo`, `Btn`) : jamais
  levés par Gambas, appelés seulement depuis `Tmo_KeyPress`/`Btn_Click`. `deps.py` ne les signale
  pas en `handlers_inactifs` car ils sont appelés explicitement (comportement correct) ; ils
  apparaissent en « portée réductible », ce qui est exact.
- `Coltxmo_Click` et `Colcompt_Click` sont rejoués par `Object.Call` (REPLAYOBSERVER-A06) :
  ils restent `Public`.
- Pas de dépendance circulaire. Ordre de rework : avec `Movr` pour la fonction commune de marge
  (TXMO-004 / MOVR-006).
