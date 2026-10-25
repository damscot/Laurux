# Edbl — Dépendances

> Source : `.src/Gestion/Impressions/Edbl.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Impressions/Edbl.class` — classe, formulaire associé `Edbl.form`
- Handlers GUI détectés : 12
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Colbl_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `Edbr` | `Ed` |
| `Start` | `Musique` |
| `Utils` | `Cdate_Aff`, `Observers`, `SetEditColor`, `db` |

### Tables SQL référencées

`Fiches_Entrecpt`, `Fiches_Four`, `Fiches_Ligrecpt`

### Membres Public sans usage externe détecté (portée réductible ?)

`Aff_Data`, `cache_bl`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Point d'entrée : `Fmenu.class:1034` (`Menu90_Click`).
- `replay_dynamic` : `Colbl_Click` → reste `Public`.
- « Portée réductible » confirmée par grep : `Aff_Data` (appelé par `ToggleButton1_Click` et les
  cinq `*_GotFocus`), `cache_bl` (appelé par `Colbl_KeyPress`).
- Délègue l'impression à `Edbr.Ed` (3 appels : lignes 62, 290, 299) ; tout effet de bord (copie
  `~/Impressions`, GED) vient d'`Edbr`. Contrainte d'ordre : reworks d'`Edbr` testés aussi par les
  scénarios de cet écran.
- Tables en dur : `Fiches_Ligrecpt`, `Fiches_Entrecpt`, `Fiches_Four` (clés `TabLigrecpt`,
  `TabEntrecpt`, `TabFour` disponibles).
