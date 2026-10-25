# EntreeItem — Dépendances

> Source : `.src/Gestion/Lcr/EntreeItem.module` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Lcr/EntreeItem.module` — module
- Handlers GUI détectés : 0

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/Lcr/Preparation.class` | `item` |

### Utilise

_Aucune dépendance vers d'autres fichiers du projet._

### Tables SQL référencées

_Aucune._
<!-- /AUTO:dependances -->

## Notes d'analyse

- Usage unique vérifié par `grep -rn "EntreeItem" .src` : `Preparation.class:562`
  (`Entree2.text = EntreeItem.item(sentree)`).
- Les libellés doivent rester identiques aux `List` de `Preparation.form` (lignes 130, 292, 364)
  et `Glcr.form` (ligne 108) : `Preparation.Button3_Click` relit `Left$(Entree2.Text, 1)`.
- Aucun appel dynamique, aucune dépendance circulaire. Peut être reworké indépendamment, avant
  `Preparation`.
