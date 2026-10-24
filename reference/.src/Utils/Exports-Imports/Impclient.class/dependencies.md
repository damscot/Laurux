# Impclient — Dépendances

> Source : `.src/Utils/Exports-Imports/Impclient.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/Exports-Imports/Impclient.class` — classe, formulaire associé `Impclient.form`
- Handlers GUI détectés : 3

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |
| `.src/Communs/Prgm.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Start` | `Musique`, `son` |
| `Utils` | `Observers`, `db` |

### Tables SQL référencées

`Fiches_Cli`, `Fiches_Comptes`, `Fiches_Parametres`, `Mails_Cli`

### Membres Public sans usage externe détecté (portée réductible ?)

`Compteur`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Faux négatif de deps.py** (« Utilisé par » vide) : la fenêtre est ouverte par
  `.src/Communs/Fmenu.class:1568` (`Menu152_Click`, menu « Import des clients ») et par
  `.src/Communs/Prgm.class:59` (`If Prog = "Impclient" Then Impclient.show`). deps.py ne compte pas
  les appels `Classe.Show` hérités de `Form`.
- Tables en dur (`Fiches_Cli`, `Fiches_Comptes`, `Fiches_Parametres`) bien détectées ; `Mails_Cli`
  via `Cbase.Table("TabMailCli")`.
- `Compteur` : portée réductible confirmée par `grep -rniw compteur .src` (seules les occurrences
  internes à ce fichier concernent `Impclient`).
- Aucun appel dynamique, aucune dépendance circulaire. Le rework peut se faire indépendamment, après
  la création éventuelle du socle commun d'import/export.
