# Tconsigne — Dépendances

> Source : `.src/Gestion/option/Tconsigne.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/option/Tconsigne.class` — classe, formulaire associé `Tconsigne.form`
- Handlers GUI détectés : 17

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/option/artopt.class` | `<hérité>` |
| `.src/Gestion/option/menuopt.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Create9`, `Edit`, `Exec` |
| `Utils` | `ObsGotf`, `ObsLstf`, `Observers`, `db` |
| `barselection` | `<type>`, `estcreer`, `estmodif` |
| `rechcons` | `<type>` |

### Tables SQL référencées

`Fiches_consigne`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Ouvertures (vérifiées par `grep`) : `menuopt.class:39` (`Tconsigne.Show`, auto-instance) et
  `artopt.class:355` (`Tconsigne.ShowModal`). Le menu de `menuopt` porte le nom d'événement
  `"Tconsigne"` (`menuopt.class:12`) : homonyme du formulaire, sans lien avec la classe.
- Événements `bar1_*` levés par `barselection` (`.src/Gestion/option/barselection.class`) :
  `valide`/`annule` reçoivent `($bcreer, $bmodif)` ; le paramètre `anul` est le drapeau de
  modification.
- `rech_trouver` : événement `trouver` de `rechcons` (`New Rechcons("T") As "rech"`).
- **Arité non détectée** : `form_Close` appelle `bar1_valide` sans argument (`Tconsigne.class:158`)
  alors que la signature en exige deux ; `deps.py` ne contrôle pas les appels sans parenthèses.
- Lecteurs de `Fiches_consigne` : `Consigne`, `rechcons`, `Saisiedecons`, `Edconsigne`,
  `fourconsdroi` (mort), `facopt`.
- Ordre de rework : avec les autres écrans à `barselection` (`Tregie`, `Ttourne`, `Tregion`,
  `Tchauffeur`, `Mreglement`) si un helper commun est créé.
