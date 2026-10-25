# MajEqu — Dépendances

> Source : `.src/Gestion/Stock/Tarifs/MajEqu.module` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Stock/Tarifs/MajEqu.module` — module
- Handlers GUI détectés : 0

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Prgm.class` | `Recup` |
| `.src/Gestion/Stock/Tarifs/Impart.class` | `Maj` |
| `.src/Gestion/Tables/Articles.class` | `Maj` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Serveur` | `Pass` |
| `Utils` | `db` |
| `Variables` | `SMajArt`, `Sexport`, `Sprix` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Cequ`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Appelants vérifiés par `grep` :
  - `Articles.class:933` (`Case 5`), `3917`, `3937` : `MajEqu.Maj(code.Text, Cequ.Text)` (ordre conforme) ;
  - `Impart.class:670` : `MajEqu.Maj(codep, codequ)` (ordre conforme) ;
  - `Impart.class:1290` : `MajEqu.Maj(Cequ, rArt!art_code)` : **arguments inversés**
    (anomalie IMPART-A04 documentée côté [`Impart`](../Impart.class/rework.md)) ;
  - `Prgm.class:102` : `MajEqu.Recup()` (programme « MajEqu » lancé depuis les outils).
- Aucune dépendance circulaire ; aucun appel dynamique.
- `Serveur.Pass("EQ", …)` écrit dans `Variables.Schmprix & "/EQ_Serveur.txt"` (fichier d'échange
  inter-processus) : effet de bord hors base à comparer dans les replays si l'export est actif.
- Le comportement en cas de doublon dépend de `DB_Connection.Exec` (affichage conditionnel du
  `Message.Error` puis `Error.Propagate`) : à reworker après `DB_Connection`.
