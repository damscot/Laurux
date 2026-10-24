# FCollectif — Dépendances

> Source : `.src/Compta/Tables/FCollectif.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Tables/FCollectif.class` — classe, formulaire associé `FCollectif.form`
- Handlers GUI détectés : 5
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Colcol_Click`

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
| `Utils` | `Observers`, `SetEditColor`, `db` |

### Tables SQL référencées

`Fiches_Comptes`, `Fiches_Mvt`

### Membres Public sans usage externe détecté (portée réductible ?)

`Maj_Zones`, `CleanChamps`, `Refresh`, `cptman`, `Button1_Click`, `Button2_Click`, `Button4_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Seul point d'entrée : `Fmenu.Menu111_Click` (`.src/Communs/Fmenu.class:553`, `Fcollectif.show`,
  casse différente du nom de classe, résolue par Gambas).
- `Maj_Zones`, `CleanChamps`, `Refresh`, `cptman` : appels internes uniquement (vérifié par `grep`).
- Les collectifs créés ici sont utilisés par `FClient`/`FFournisseur` (`coll_cc`) et par
  `FComptes.collman` : la règle des préfixes doit rester cohérente entre ces fichiers.
- Aucun appel dynamique.
