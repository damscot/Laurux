# Ttourne — Dépendances

> Source : `.src/Gestion/option/Ttourne.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/option/Ttourne.class` — classe, formulaire associé `Ttourne.form`
- Handlers GUI détectés : 18

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Create9`, `Edit`, `Exec` |
| `Utils` | `ObsGotf`, `ObsLstf`, `Observers`, `db` |
| `barselection` | `<type>`, `estcreer`, `estmodif` |
| `gridvi` | `<type>`, `code` |

### Tables SQL référencées

`Fiches_tourne`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Ouverture** : `Fmenu.Menu327_Click` (`Fmenu.class:2467`, `Ttourne.Show`) ; le `<hérité>` du
  bloc généré correspond à cet appel.
- **Statistiques** : `Gridvi` (type `"T"`) lit `Fiches_HistoFac`, `Fiches_HistoLigfac`,
  `Fiches_Bl`, `Fiches_Ligbl` et les variantes `*M` ; ces tables n'apparaissent pas dans le bloc
  généré car elles sont lues par `gridvi.class`, pas par Ttourne.
- **Arité non détectée** : `form_Close` (`Ttourne.class:192`) appelle `bar1_valide` sans
  argument alors que la signature en exige deux ; `deps.py` ne signale rien dans
  `arity_errors` (appel sans parenthèses d'une méthode du même fichier). Erreur « Not enough
  arguments » confirmée avec `gbs3` (TTOURNE-A01).
- **Barselection** : les handlers `bar1_*` sont levés par `Barselection` (`Raise`), pas par un
  contrôle du `.form` ; ils doivent rester `Public` avec leur nom.
- Table `Fiches_tourne` nommée en dur (pas de clé `Cbase`).
- Ordre de rework : TTOURNE-004 avec RECHTOUR-003 (clé `Cbase` commune) ; TTOURNE-005 après la
  création du helper `Barselection` commun (phase 3, avec MREGLEMENT-006, TREGION, TREGIE, TCONSIGNE).
