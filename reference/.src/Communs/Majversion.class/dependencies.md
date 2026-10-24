# Majversion — Dépendances

> Source : `.src/Communs/Majversion.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Communs/Majversion.class` — classe, formulaire associé `Majversion.form`
- Handlers GUI détectés : 5

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Caisse/Preferences.class` | `<hérité>` |
| `.src/Communs/Fmenu.class` | `RecupVersion` |
| `.src/Communs/LauruxConf.class` | `Version` |
| `.src/Communs/LauruxMaj.module` | `RecupVersion`, `RecupVersionApp`, `Version` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `Start` | `LocalSettings`, `Musique` |
| `Utils` | `db` |

### Tables SQL référencées

`Fiches_Parametres`

### Membres Public sans usage externe détecté (portée réductible ?)

`Update_Type`, `Verif_Maj`, `Maj`, `Avancement`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelants vérifiés** : `Fmenu.class:188` (`RecupVersion()` au démarrage, contrôle réseau
  possible), `Fmenu.class:1680`/`1684` (`Menu173_Click`, `Show`), `Caisse/Preferences.class:205`
  (`Show`), `LauruxConf.class:190`/`404` (`Version`), `LauruxMaj.module:1042`/`1047`
  (`Version`), `LauruxMaj.module:1118`/`1119` (`RecupVersion(False)`, `RecupVersionApp()`).
- Tous ces appels passent par l'**auto-instance du formulaire** : un `Majversion` caché est créé au
  premier accès. `Version` n'est renseigné qu'après `RecupVersion`.
- **Portée réductible confirmée** : `Update_Type`, `Verif_Maj`, `Maj`, `Avancement` (les
  occurrences de `Avancement` dans `Moulinage`, `GedR`, `DB_Sanity` concernent `PB.Avancement`).
- **Dépendances externes non vues par deps.py** : composants `gb.net.curl` (`HttpClient`),
  `gb.xml.html` (`HtmlDocument`) ; commandes `wget`, `tar` ; site `https://www.laurux.fr/Laurux/`.
- **Table** : `Fiches_Parametres` en dur (mapping `Cbase.Table("TabParam")` disponible).
- Événements nommés `hClient` / `hDoc` sans aucun handler : nommage inutile.
- **Ordre de rework** : indépendant ; `FRestore` (commonalisation de la version applicative) et
  `LauruxMaj` utilisent `RecupVersionApp` — signature à conserver.
