# Raz — Dépendances

> Source : `.src/Communs/Raz.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Communs/Raz.class` — classe, formulaire associé `Raz.form`
- Handlers GUI détectés : 2

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Prgm.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Utils` | `db` |

### Tables SQL référencées

`Fiches_Art`
<!-- /AUTO:dependances -->

## Notes d'analyse

Vérifications faites par `grep -rn` sur `.src` (commit `6b6b9dfc`).

- Seul appelant : `Prgm.class:77` (`Raz.Showmodal()`).
- Ne pas confondre avec les nombreuses classes `Raz*` (`RazArt`, `RazEcr`, `RazClos`…) ni avec la
  méthode `RazEcr.Raz` : `grep -rn '\bRaz\.'` ne trouve que l'appel de `Prgm`.
- Table : `Fiches_Art` (colonne `art_stocke`, `tinyint(1)`), via `Cbase.Table("TabArt")`.
- Aucun appel dynamique.
