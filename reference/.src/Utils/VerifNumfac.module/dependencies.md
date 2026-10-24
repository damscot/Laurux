# VerifNumfac — Dépendances

> Source : `.src/Utils/VerifNumfac.module` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/VerifNumfac.module` — module
- Handlers GUI détectés : 0
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Dnfac`
- ⚠️ Classe jamais référencée (aucun appelant, nom absent des chaînes du projet) : code mort probable ; la suppression d'un couple .class + .form est une anomalie à valider

### Utilisé par

_Aucun usage externe détecté statiquement._

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `Start` | `LocalSettings`, `Societe` |
| `Utils` | `db` |

### Tables SQL référencées

`Fiches_Bl`, `Fiches_BlM`, `Fiches_HistoFac`, `Fiches_HistoFacM`

### Membres Public sans usage externe détecté (portée réductible ?)

`Dnfac`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Aucun usage : `grep -rni "VerifNumfac" .src` → ce fichier seulement ; les `dnfac` de
  `Communs/Parametre.class` (l.37, 120, 373, 537…) sont un `TextBox` et une colonne SQL. deps.py est
  correct (« Utilisé par » vide) mais ne signale pas `Dnfac` comme réductible.
- Tables lues : `Fiches_HistoFac`, `Fiches_Bl`, `Fiches_HistoFacM`, `Fiches_BlM` (en dur).
