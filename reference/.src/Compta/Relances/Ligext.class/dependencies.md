# Ligext — Dépendances

> Source : `.src/Compta/Relances/Ligext.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Relances/Ligext.class` — classe, formulaire associé `Ligext.form`
- Handlers GUI détectés : 1

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Compta/Relances/Ligcli.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Create9`, `Exec` |
| `Utils` | `db` |

### Tables SQL référencées

`Fiches_relances`
<!-- /AUTO:dependances -->

## Notes d'analyse

Vérifications faites par `grep -rn` sur `.src` (commit `6b6b9dfc`).

- Seul créateur : `Ligcli.visext` (`Ligcli.class:168`), avec le `ScrollView2` de `FEditrel` comme
  parent.
- **Non détecté par l'heuristique** : `FEditrel.CheckBox2_Click` (`FEditrel.class:128`) écrit la
  propriété `selection` via un `Variant` (`tab[i].selection`).
- La table `Fiches_relances` n'a pas de clé `Cbase` ; elle est créée dynamiquement par
  `FEditrel.class:326` (clé `(compte, lind)`).
- Ordre de rework : avec `Ligcli` et `FEditrel` (même écran composite, mêmes replays).
