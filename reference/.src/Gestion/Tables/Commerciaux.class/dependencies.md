# Commerciaux — Dépendances

> Source : `.src/Gestion/Tables/Commerciaux.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Tables/Commerciaux.class` — classe, formulaire associé `Commerciaux.form`
- Handlers GUI détectés : 8
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Vendeur_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `Start` | `son` |
| `Utils` | `ObsGotf`, `ObsLstf`, `Observers`, `cpoint`, `db` |

### Tables SQL référencées

`Fiches_Commerciaux`

### Membres Public sans usage externe détecté (portée réductible ?)

`Button1_Click`, `Button3_Click`, `Refresh`, `Maj_Zones`, `Cleanchamps`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Seul point d'entrée : `Fmenu.class:2378` (`Commerciaux.Show()`).
- Lecteurs de `Fiches_Commerciaux` : `FClient` (`:116`, `:464` ; code stocké dans `cli_comm`,
  `:1560`), `Facturefm`, `StatComm`, `VisStatComm`, `VisStatComArt`, `Histocliart`.
- `Button1_Click`/`Button3_Click` sont des pseudo-handlers (boutons du groupe `Btn`), appelés
  uniquement par `Btn_Click`/`Btn_KeyPress`.
- `Vendeur_Click` rejoué par `ReplayObserver.Replay_Click` : doit rester `Public`.
- `Utils.Observers` appelé à chaque `Form_Open` (donc à chaque `Refresh`) : impact potentiel sur
  le log de rejeu (événements dupliqués), à vérifier en phase 2 avant d'enregistrer les scénarios.
