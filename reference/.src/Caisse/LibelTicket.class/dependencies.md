# LibelTicket — Dépendances

> Source : `.src/Caisse/LibelTicket.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Caisse/LibelTicket.class` — classe, formulaire associé `LibelTicket.form`
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

`Fiches_LibelTicket`

### Membres Public sans usage externe détecté (portée réductible ?)

`Button2_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Appelant unique confirmé : `Fmenu.Menu207_Click` (`Fmenu.class:1859`),
  `LibelTicket.ShowModal()` sur l'auto-instance.
- **Lecteurs de la table non liés par `deps.py`** (dépendance de données) : `Caisse.class:4008`, avant l'impression du ticket. Toute
  évolution du format du texte doit repasser les tests d'impression du ticket (CFACTURE-T08).
- Table `Fiches_LibelTicket` créée par `LauruxMaj.module` (ligne 1592) : ne pas toucher.
- `scope_reducible` = `Button2_Click` : confirmé (pseudo-handler du groupe `Btn`).
- Copie quasi exacte de `LibelAvoirs` et `LibelFac` : à reworker dans le même lot que
  `Tleg`/`Tmail`/`LibelFac` pour la commonalisation (phase 3).
- Aucun appel dynamique.
