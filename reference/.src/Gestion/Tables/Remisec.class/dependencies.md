# Remisec — Dépendances

> Source : `.src/Gestion/Tables/Remisec.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Tables/Remisec.class` — classe, formulaire associé `Remisec.form`
- Handlers GUI détectés : 12
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Coltype_Click`, `Colfam_Click`
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `Tabtypec`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `CFormat` | `_get` |
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `RichDataGrid` | `<type>`, `ColFormats`, `DataField`, `Display`, `Fields`, `Refresh`, `Table`, `Value` |
| `Start` | `LocalSettings`, `Musique`, `son` |
| `Utils` | `Fcolr`, `Observers`, `cpoint`, `db` |
| `textfamille` | `<form>`, `Clear`, `Select`, `setfocus`, `text` |

### Tables SQL référencées

`Fiches_Fam`, `Fiches_RemTypec`, `Fiches_Typec`

### Membres Public sans usage externe détecté (portée réductible ?)

`Maj_Zones`, `Cleanchamps`, `Quitte_Cdt`, `Quitte_Cdf`, `Quitte_Remise`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Point d'entrée** : `Fmenu:1411` (`Remisec.show`), auto-instance. Aucun membre utilisé de
  l'extérieur.
- **Unique utilisateur de `RichDataGrid`** (`Remisec:47`) et donc de `CFormat` via
  `ColFormats` : toute modification de ces deux classes se valide avec les tests de `Remisec`
  (REMISEC-T05). Les anomalies CFORMAT-A01 et RICHDATAGRID-A04 se manifestent ici (REMISEC-A02).
- **`Tabtypec_Select`** est levé par `RichDataGrid` (`Raise Select`) et non par le `GridView`
  (événements détournés par `Object.Attach`) ; il n'existe pas de `Tabtypec_Click` : le rejeu
  d'un clic sur la grille par `ReplayObserver` (`Object.Call`) est à vérifier en phase 2.
- **`replay_dynamic`** : `Coltype_Click`, `Colfam_Click` restent `Public`.
- **Vraies réductions** (aucun appel externe, `grep -rn`) : `Maj_Zones`, `Cleanchamps`,
  `Quitte_Cdt`, `Quitte_Cdf`, `Quitte_Remise`.
- **Lecteurs de `Fiches_RemTypec`** : `TarArt`, `Facture`, `Moulinage` (verrou `LOCK TABLES`),
  `TriEqu` (via `Cbase.Table("TabRemTypec")`). `deps.py` ne relie pas `Remisec` à la clé
  `TabRemTypec` puisque le nom est en dur.
- **Ordre de rework** : après `CFormat` et `RichDataGrid` (lot Utils) ; REMISEC-005 avec
  COEFTYPEC-006.
