# Majcasier — Dépendances

> Source : `.src/Gestion/Lcr/Portables/Majcasier.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Lcr/Portables/Majcasier.class` — classe, formulaire associé `Majcasier.form`
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
| `Editeur` | `Prog_Editeur` |
| `Portable` | `Import` |
| `Start` | `LocalSettings`, `Musique` |
| `Utils` | `Fcolr`, `Find_cbarre`, `Observers`, `db` |

### Tables SQL référencées

`Fiches_Art`

### Membres Public sans usage externe détecté (portée réductible ?)

`Import_Portable`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Point d'entrée : `Fmenu.Menu275_Click` (`Majcasier.Show()`, `Fmenu.class:2182`), menu « Mise à jour
  code casier ».
- `scope_reducible` vérifié : `Import_Portable` n'est appelé que par `Button1_Click`.
- Dépend de `Portable.Import` (appel sans effet utile pour `"Casier"`), `Editeur.Prog_Editeur`
  (`.src/Gestion/Impressions/Editeur.module`), `Utils.Find_cbarre`.
- Aucune grille : pas de contrainte de rejeu dynamique ; écran instrumenté (`Utils.Observers`).
- Ordre de rework : après `Portable` si `LireInventaire` est introduit.
