# Fclientc — Dépendances

> Source : `.src/Caisse/Fclientc.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Caisse/Fclientc.class` — classe, formulaire associé `Fclientc.form`
- Handlers GUI détectés : 8
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Maj_Zones`, `Cleanchamps`, `Compteman`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Client_Click`
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `tvalist2`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `Start` | `Musique`, `son` |
| `Utils` | `db` |

### Tables SQL référencées

`Fiches_Cli`, `Fiches_ClientCaisse`, `Fiches_Comptes`

### Membres Public sans usage externe détecté (portée réductible ?)

`Refresh`, `Maj_Zones`, `Cleanchamps`, `Compteman`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelant unique** (vérifié) : `Fmenu.Menu209_Click` (`Fmenu.class:1883`, `Fclientc.ShowModal()`,
  menu Constantes › « Compte client caisse »).
- **Lecteurs de la donnée** (`Fiches_ClientCaisse`, noms en dur partout) : `Moulinage.class:1528`,
  `BordereauxC.class:242`, `Cmenu.class:128-136` (refus d'ouvrir la caisse si la table est vide),
  `LauruxMaj.module:1602/2530/5544`. La clé `Cbase` `TabCliCaisse` existe (`Cbase.module:260`) mais
  n'est utilisée par personne.
- `Doc.Open("Client_Caisse")` : `Doc.module` (lot Communs) ouvre `Ecrans/Client_Caisse.html` ou la
  documentation en ligne.
- **Code mort** (`unused`, vérifié par grep) : `Maj_Zones`, `Cleanchamps`, `Compteman`.
- **Portée réductible** annoncée : `Refresh` doit rester `Public` (masque `Control.Refresh`) ; les
  trois autres sont supprimées (FCLIENTC-002).
- **`replay_dynamic`** : `Client_Click` doit rester `Public`.
- **`replay_missing`** : `tvalist2` (ColumnView sans `_Click`) est invisible et jamais affiché :
  aucun scénario ne peut cliquer dessus.
- L'écran n'appelle pas `Utils.Observers(Me)` : non journalisé, non rejouable (FCLIENTC-A03).
- Aucun `arity_errors`, `handlers_inactifs`, `unused_transitive`, `sql_params`.
- **Ordre de rework** : FCLIENTC-005 (`CompteClientCaisse` partagé) dans le même commit que les
  appelants `Moulinage`, `BordereauxC`, `Cmenu`.
