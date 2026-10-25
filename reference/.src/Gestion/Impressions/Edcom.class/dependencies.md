# Edcom — Dépendances

> Source : `.src/Gestion/Impressions/Edcom.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Impressions/Edcom.class` — classe, formulaire associé `Edcom.form`
- Handlers GUI détectés : 7
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Level1`, `Level2`, `Level3`, `Level3bis`, `Level4`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Colcom_click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cdocuments` | `<type>`, `Entete`, `Entete2`, `Level1`, `Level2`, `Level3`, `Level4` |
| `DB_Connection` | `Exec` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `Utils` | `Cdate_Aff`, `Observers`, `SetEditColor`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Entcom`, `Fiches_Four`, `Fiches_Ligcom`, `Fiches_Societes`

### Membres Public sans usage externe détecté (portée réductible ?)

`Level1`, `Level2`, `Level3`, `Level3bis`, `Level4`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Point d'entrée : `Fmenu.class:1046` (`Menu92_Click`).
- `replay_dynamic` : `Colcom_click` → reste `Public`.
- **Faux négatif de `deps.py`** : `Level1`, `Level2`, `Level3`, `Level4` sont listés en « portée
  réductible » (donc vus comme utilisés) alors qu'aucun appel n'existe : les appels
  `pdf.Level1/2/3/4` du fichier visent `Cdocuments` (membre `pdf As Cdocuments`). Seul `Level3bis`
  est détecté `unused`. Les cinq routines sont mortes.
- Utilise `Cdocuments` (`Entete`, `Entete2`, `Level1`, `Level2`, `Level3`, `Level4`) et
  `Visualiseur`.
- Tables en dur : `Fiches_Entcom`, `Fiches_Ligcom`, `Fiches_Four`, `Fiches_Societes` (clés Cbase
  `TabEntcom`, `TabLigcom`, `TabFour`, `TabSoc` disponibles).
