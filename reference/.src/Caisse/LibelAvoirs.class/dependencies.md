# LibelAvoirs — Dépendances

> Source : `.src/Caisse/LibelAvoirs.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Caisse/LibelAvoirs.class` — classe, formulaire associé `LibelAvoirs.form`
- Handlers GUI détectés : 3

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `Start` | `Musique` |
| `Utils` | `ReplaceLb`, `db` |

### Tables SQL référencées

`Fiches_LibelAvoirs`

### Membres Public sans usage externe détecté (portée réductible ?)

`Button2_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Appelant unique confirmé : `Fmenu.Menu208_Click` (`Fmenu.class:1877`),
  `LibelAvoirs.ShowModal()` sur l'auto-instance.
- **Lecteurs de la table non liés par `deps.py`** (dépendance de données) : `Caisse.class:289` (table en dur `"Fiches_LibelAvoirs"`), à l'ouverture de la caisse. Toute
  évolution du format du texte doit repasser les tests d'impression du ticket (CFACTURE-T08).
- Table `Fiches_LibelAvoirs` créée par `LauruxMaj.module` (ligne 1597) : ne pas toucher.
- `scope_reducible` = `Button2_Click` : confirmé (pseudo-handler du groupe `Btn`).
- Copie quasi exacte de `LibelTicket` et `LibelFac` : à reworker dans le même lot que
  `Tleg`/`Tmail`/`LibelFac` pour la commonalisation (phase 3).
- Aucun appel dynamique.
