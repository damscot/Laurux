# Lettragesoldes — Dépendances

> Source : `.src/Compta/Lettrages/Lettragesoldes.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Lettrages/Lettragesoldes.class` — classe, formulaire associé `Lettragesoldes.form`
- Handlers GUI détectés : 1
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `clear`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `Sha1Calc` | `CalcSha1` |
| `Start` | `Musique`, `son` |
| `Utils` | `Observers`, `db` |

### Tables SQL référencées

`Fiches_Comptes`, `Fiches_Mvt`

### Membres Public sans usage externe détecté (portée réductible ?)

`clear`, `Button2_Click`, `Button1_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Seul point d'entrée : `Fmenu.Menu127_Click` (`.src/Communs/Fmenu.class:1296`, auto-instance `Show`).
- `clear` : aucun appel (vérifié par `grep`) → code mort.
- Dépendance **de données** non vue par `deps.py` : le traitement repose sur `Fiches_Comptes.solde`,
  recalculé par `Csolde.Recalc_solde`/`Solde_caisse` ; un rework de `Csolde` doit repasser
  LETTRAGESOLDES-T01 à T03.
- `Sha1Calc.CalcSha1` reçoit `"Fiches_Mvt"` en dur.
- Aucun appel dynamique ; pas de dépendance circulaire.
