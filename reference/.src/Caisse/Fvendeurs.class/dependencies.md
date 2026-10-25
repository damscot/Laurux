# Fvendeurs — Dépendances

> Source : `.src/Caisse/Fvendeurs.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Caisse/Fvendeurs.class` — classe, formulaire associé `Fvendeurs.form`
- Handlers GUI détectés : 8
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Vendeur_Click`

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
| `Utils` | `Observers`, `SetEditColor`, `db` |
| `hexdblKey` | `Crypt` |

### Tables SQL référencées

`Fiches_Vendeurs`

### Membres Public sans usage externe détecté (portée réductible ?)

`Refresh`, `Maj_Zones`, `Cleanchamps`, `Button1_Click`, `Button3_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse

Vérifications faites par `grep -rn` sur `.src` (commit `6b6b9dfc`).

- Appelants (auto-instance) : `Fmenu.Menu206_Click` (`ShowModal`, [Fmenu.class:1865](../../../../.src/Communs/Fmenu.class#L1865)) et
  `Fmenu.Menu287_Click` (`Show`, non modal, [Fmenu.class:2242](../../../../.src/Communs/Fmenu.class#L2242)). Les deux menus partagent la
  même instance : ouvrir le second pendant que le premier est affiché réutilise la fenêtre.
- `replay_dynamic` : `Vendeur_Click` (doit rester `Public`, REPLAYOBSERVER-A06).
- `scope_reducible` signale `Button1_Click` et `Button3_Click` : exact (groupe `Btn`).
- Lecteurs de `Fiches_Vendeurs` (contrat sur `code`, `mdp` chiffré, `admin = -1`) : `Ouverture`,
  `Svendeur`, `Cmenu`, `Caisse`, `ConVendeurs`, `Facture` ; `Fiches_Caisses.vdr_code` référence
  le code sans contrainte.
- Ordre de rework : avec `Fcaisses` (gabarit commun) et après le helper `LVendeur`.
