# ticpe — Dépendances

> Source : `.src/Gestion/option/ticpe.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/option/ticpe.class` — classe, Create Static
- Handlers GUI détectés : 0
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Valide`
- ⚠️ Requêtes dont les arguments ne correspondent pas aux marqueurs `&N` : l. 50 (0 argument(s), marqueurs [1])

### Utilisé par

_Aucun usage externe détecté statiquement._

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `LDate` | `<type>` |
| `Utils` | `db` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Cli`

### Membres Public sans usage externe détecté (portée réductible ?)

`Valide`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Aucun appelant** (vérifié par `grep -rniw ticpe .src`) : seules mentions hors du fichier,
  `Parametre.class:626-682` (colonne `ticpe` d'`Art_Tipp`, appel `ticpe(Null).categorie` en
  commentaire) et `modfichier.module:132,153`.
- `unused` / `scope_reducible` : `Valide`, confirmé.
- Table `Art_Tipp` non signalée par `deps.py` (préfixe hors `Fiches_*`, citée dans une chaîne).
