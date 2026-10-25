# TriEqu — Dépendances

> Source : `.src/Affichages/TriEqu.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Affichages/TriEqu.class` — classe, formulaire associé `TriEqu.form`
- Handlers GUI détectés : 18
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Colart_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/Facturation/Facture.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Utils` | `Base2`, `Observers`, `cpoint`, `db`, `rs2` |
| `Variables` | `$Codearticle`, `Bsel` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Cequ`, `Fiches_RemTypec`

### Membres Public sans usage externe détecté (portée réductible ?)

`Deplacement`, `Tarifclient`, `Tris`, `Deb2`, `Deb3`, `Dbclk`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelant unique** : `Facture.Art_Equ` (`Facture.class:4523`), quand plus d'un article
  correspond au code équivalent ; lit ensuite `Variables.Bsel` et `Variables.$Codearticle`
  (l. 4525-4530). `Variables.Bsel` est aussi remis à `False` par `Facture:4414` avant d'autres
  sélections.
- **État global écrit** : `Variables.Bsel`, `Variables.$Codearticle` (l. 55-159, 289-351) ;
  `deps.py` reconnaît `Classe.$membre` (`$Codearticle` n'est donc pas réductible). Lecteurs de
  `$Codearticle` : `Facture` uniquement (l. 4435-4841).
- **Résultat partagé** `Utils.rs2` : comme `Tricp`, `TriMat`, `Tricartes`… (une seule liste
  ouverte à la fois en pratique, la fenêtre étant modale).
- **Signaux `deps.py`** : `replay_dynamic` = `Colart_Click` (doit rester `Public`) ;
  `scope_reducible` = `Deplacement`, `Tarifclient`, `Tris`, `Deb2`, `Deb3`, `Dbclk` (vérifié par
  grep) ; aucun `unused`, `arity_errors`, `replay_missing`.
- **Tables** : `Fiches_Cequ`, `Fiches_Art`, `Fiches_RemTypec` (par `Cbase.Table`).
- **Ordre de rework** : indépendant ; tests à mutualiser avec ceux de `Facture` (module complexe).
