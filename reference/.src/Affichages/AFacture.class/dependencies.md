# AFacture — Dépendances

> Source : `.src/Affichages/AFacture.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Affichages/AFacture.class` — classe, formulaire associé `AFacture.form`
- Handlers GUI détectés : 2
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `Colrcp3`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/Facturation/Facture.class` | `<type>` |
| `.src/Gestion/Facturation/Facturefm.class` | `<type>` |
| `.src/Gestion/Facturation/Facturergbl.class` | `<type>` |
| `.src/Gestion/Tables/Articles.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Utils` | `CDec`, `db` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Ligbl`, `Fiches_LigblM`

### Membres Public sans usage externe détecté (portée réductible ?)

`DocVentes`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelants** (vérifiés par `grep -rnw "AFacture"`) :
  - `Facture.AffDoc` (`Facture.class:9674-9677`) : `New AFacture(num.Text, Code3.text, nm.text,
    datej.text)` ;
  - `Facturefm.Coldetail_Activate` (`Facturefm.class:477-480`) ;
  - `Facturergbl.Coldetail_Activate` (`Facturergbl.class:302-305`) ;
  - `Articles.Colcom_Activate` (`Articles.class:4253-4254`, quand la liste n'est pas celle des
    commandes fournisseurs).
- Aucun protocole de retour.
- `replay_missing` : `Colrcp3` (`ColumnView` sans `_Click`) : ne pas cliquer dans la vue en replay
  (ou REPLAYOBSERVER-A06). Écran non instrumenté (`Utils.Observers` absent).
- `deps.py` détecte `Fiches_LigblM` cité en dur (ligne 48).
- « Portée réductible » : `DocVentes` confirmé.
- Pas d'`unused`, d'`arity_errors`, de `handlers_inactifs` ni de `replay_dynamic`.
- Contrainte d'ordre : commonalisation `DetailDocument` avec `ACom` et `TriHistos`.
