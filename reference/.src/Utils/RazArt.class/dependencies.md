# RazArt — Dépendances

> Source : `.src/Utils/RazArt.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/RazArt.class` — classe, formulaire associé `RazArt.form`
- Handlers GUI détectés : 4

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Utils` | `db` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_CdBarre`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Faux négatif** : ouverte par `.src/Communs/Fmenu.class:2206` (`Menu279_Click`, « RAZ zones
  article ») ; deps.py ne voit pas `Classe.Show`.
- `Fiches_CdBarre` référencée en dur (non mappée via `Cbase.Table` ici).
- `Truncate Table` : non traduit par `DB_Connection` pour SQLite (seuls `LOCK/UNLOCK TABLES` sont
  neutralisés) → échec sous SQLite.
- Duplication exacte avec `Papmp.run` (`Papmp.class:11-17`).
