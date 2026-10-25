# ACom — Dépendances

> Source : `.src/Affichages/ACom.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Affichages/ACom.class` — classe, formulaire associé `ACom.form`
- Handlers GUI détectés : 2
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `Colrcp3`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/Tables/Articles.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Utils` | `CDec`, `db` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Four`, `Fiches_Ligcom`

### Membres Public sans usage externe détecté (portée réductible ?)

`DocCom`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Seul appelant** (vérifié par `grep -rnw -i "ACom"`) : `Articles.Colcom_Activate`
  (`Articles.class:4247-4251`) avec `New Acom(Colcom.Item[2], Colcom.Item[0], Colcom.Item[3],
  Colcom.Item[4])` = numéro de commande, code fournisseur, date, montant (la casse `Acom` est
  indifférente en Gambas).
- Aucun protocole de retour.
- `replay_missing` : `Colrcp3` (`ColumnView` sans `Colrcp3_Click`) : un clic rejoué sur la vue
  échouerait (`Object.Call` d'une méthode absente) ; à éviter dans les scénarios ou à traiter par
  REPLAYOBSERVER-A06. L'écran n'appelle pas `Utils.Observers(Me)`.
- « Portée réductible » : `DocCom` confirmé.
- Pas d'`unused`, d'`arity_errors`, de `handlers_inactifs` ni de `replay_dynamic`.
- Contrainte d'ordre : commonalisation `DetailDocument` avec `AFacture` et `TriHistos`.
