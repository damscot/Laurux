# TriFac2 — Dépendances

> Source : `.src/Affichages/TriFac2.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Affichages/TriFac2.class` — classe, formulaire associé `TriFac2.form`
- Handlers GUI détectés : 31
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `ColFac_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/Facturation/Facture.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `Start` | `LocalSettings`, `Societe` |
| `Utils` | `Base2`, `Fcolr`, `cpoint`, `rs2` |
| `Variables` | `Bsel`, `numeroFac` |

### Tables SQL référencées

`Fiches_Bl`, `Fiches_HistoFac`

### Membres Public sans usage externe détecté (portée réductible ?)

`Deb2`, `Deb2b`, `Deb3b`, `Deb3`, `Deb2bis`, `Deb2bbis`, `Deb3bbis`, `Deb3bis`, `Tris`, `Titre`, `Dbclk`, `Deplacement`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Seul appelant** (vérifié par `grep`) : `Facture.Creation(Avr2 = False)`
  (`Facture.class:12105-12109`, déclenché par `Button25_Click`).
- **Protocole de retour** : `Variables.Bsel` / `Variables.numeroFac`, lus par `Facture.class:12111`
  puis `EntFac` (`Facture.class:9909`, `10018`, `10123`) qui distingue BL et facture archivée par la
  longueur du numéro. Même défaut de remise à zéro que `TriFac` (TRIFAC2-A04).
- `ColFac_Click` est rejoué par `ReplayObserver` via `Object.Call` (`replay_dynamic`) : rester
  `Public`. Aucun `unused`, `arity_errors`, `handlers_inactifs` ni `replay_missing`.
- « Portée réductible » (12 membres) confirmée par `grep` : aucun usage externe.
- Tables : `Fiches_Bl` (`TabBl`) et `Fiches_HistoFac` (`TabHisFac`), lecture seule.
- Contrainte d'ordre : traiter avec `TriFac` (socle `RequeteFactures`/`RequeteDocuments`, même commit
  pour TRIFAC-008 / TRIFAC2-008) et après la création de `PaginationListe`.
- Pas de `Utils.Observers(Me)` : écran non instrumenté.
