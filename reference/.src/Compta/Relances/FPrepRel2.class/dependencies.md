# FPrepRel2 — Dépendances

> Source : `.src/Compta/Relances/FPrepRel2.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Relances/FPrepRel2.class` — classe, formulaire associé `FPrepRel2.form`
- Handlers GUI détectés : 17
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `compteRel_Click`, `relances_Click`
- ⚠️ Classe jamais référencée (aucun appelant, nom absent des chaînes du projet) : code mort probable ; la suppression d'un couple .class + .form est une anomalie à valider

### Utilisé par

_Aucun usage externe détecté statiquement._

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Engine`, `Exec` |
| `Doc` | `Open` |
| `Start` | `Musique`, `son` |
| `Utils` | `Cdate_Aff`, `Cdate_calc`, `Observers`, `db` |

### Tables SQL référencées

`Fiches_Cli`, `Fiches_Mvt`, `Fiches_Parametres`, `Fiches_relances`

### Membres Public sans usage externe détecté (portée réductible ?)

`dteN1_GotFocus`, `dteN1_LostFocus`, `MajTab`
<!-- /AUTO:dependances -->

## Notes d'analyse

Vérifications faites par `grep -rn "FPrepRel"` sur tout le dépôt (hors `reference/`, `output/`)
au commit `6b6b9dfc`.

- **Aucun appelant** : ni `Show`/`ShowModal`, ni nom de classe en chaîne (`Prgm`, `ReplayObserver`),
  ni référence dans un `.form`. Seul `STRUCTURE.md` le mentionne. `deps.py` confirme (pas de
  `used_by`).
- Le menu « Préparation des relances » (`Fmenu.form` `Menu49`) ouvre `FEditrel`.
- Tables : `Fiches_relances` (créée ici avec une autre clé que dans `FEditrel`), `Fiches_Mvt`,
  `Fiches_Cli` en dur, `Fiches_Parametres` via `Cbase`.
- Aucune contrainte d'ordre de rework.
