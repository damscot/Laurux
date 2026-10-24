# Lettragemontant — Dépendances

> Source : `.src/Compta/Lettrages/Lettragemontant.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Lettrages/Lettragemontant.class` — classe, formulaire associé `Lettragemontant.form`
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

- Seul point d'entrée : `Fmenu.Menu126_Click` (`.src/Communs/Fmenu.class:1290`, auto-instance `Show`).
- `clear` : aucun appel interne ni externe (vérifié par `grep`) → code mort, pas seulement réductible.
- `Sha1Calc.CalcSha1` reçoit le nom de table `"Fiches_Mvt"` en dur (même constat que Tresor,
  Saisecrit, Moulinage dans les notes transverses).
- Aucun appel dynamique. Pas de dépendance circulaire.
- Ordre de rework : indépendant ; à traiter avec Lettragesoldes si le module commun est retenu.
