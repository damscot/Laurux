# Expbase — Dépendances

> Source : `.src/Utils/Exports-Imports/Expbase.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/Exports-Imports/Expbase.class` — classe, formulaire associé `Expbase.form`
- Handlers GUI détectés : 3

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `<hérité>` |
| `EnvMail` | `Envoi2` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `Utils` | `Observers`, `db` |

### Tables SQL référencées

_Aucune._
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Faux négatif** : ouverte par `.src/Communs/Fmenu.class:1660` (`Menu171_Click`, « Envoi base »).
- Réglages partagés : `/Rep_Sauv` et `/Compression` écrits par `Communs/FSauve.class:44` (et lus par
  `Communs/SauvesAuto.module:9`) ; `/Soc<XX>/Adr-base` écrit par `Communs/Prefs.class:642` ;
  `/intitule` écrit par `Fsoc`/`LauruxConf`.
- `EnvMail.Envoi2` (`Gestion/Mails/EnvMail.module:155`) : dépendance externe au lot ; son
  comportement (client mail, SMTP) conditionne le test.
- Le nom de fichier attendu (`<base>.sql` / `<base>.sql.gz`) correspond à la sauvegarde manuelle de
  `FSauve.class:68-81` ; la sauvegarde automatique (`SauvesAuto.module:20`) produit
  `<base><jour>.sql.gz`, que cette fenêtre n'envoie jamais.
