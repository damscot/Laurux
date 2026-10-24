# AffRdv — Dépendances

> Source : `.src/Utils/AffRdv.module` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/AffRdv.module` — module
- Handlers GUI détectés : 0

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `Calc_Timer` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Syntheses` | `Message` |
| `Utils` | `db` |

### Tables SQL référencées

`Fiches_Agenda`

### Membres Public sans usage externe détecté (portée réductible ?)

`Aff_Rdv`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Appelant unique vérifié par grep : `Communs/Fmenu.class:338` (`Timer1_Timer` → `AffRdv.Calc_Timer`).
  `Aff_Rdv` n'est appelé que par `Calc_Timer`.
- Le timer (`Timer1`, 60 s, `Enabled = True`) est déclaré dans `Fmenu.form` : seul le mode Gestion
  annonce les rendez-vous (pas `Cmenu`).
- Table : `Fiches_Agenda` (`TabAgenda`), également écrite par `Utils/Agenda.class`.
- Dépend de `Syntheses` (rework indépendant).
