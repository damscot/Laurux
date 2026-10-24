# LVar — Dépendances

> Source : `.src/Utils/LVar.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/LVar.class` — classe, Create Static
- Handlers GUI détectés : 0

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Compta/Saisecrit.class` | `<type>`, `AddDate`, `Evaluate`, `ParseResult` |
| `.src/Compta/Tresor.class` | `<type>`, `AddDate`, `Evaluate`, `ParseResult` |
| `.src/Compta/Utils/EcrAuto.class` | `<type>`, `AddDate`, `Evaluate`, `ParseResult` |
| `.src/Gestion/Stock/ValidBR.class` | `<type>`, `AddDate`, `Evaluate`, `ParseResult` |
| `.src/Gestion/Stock/ValidBR1.class` | `<type>`, `AddDate`, `Evaluate`, `ParseResult` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `LDate` | `<type>`, `Day`, `MonStr`, `MonStr3`, `Month`, `Week`, `WeekDay`, `WeekDay3`, `Year`, `Year2` |

### Tables SQL référencées

_Aucune._
<!-- /AUTO:dependances -->

## Notes d'analyse

- Liste des appelants exacte (vérifiée par `grep`) : `Saisecrit` (l. 411-414, 2984-3040),
  `Tresor` (l. 2491-2547), `EcrAuto` (l. 293-299), `ValidBR` (l. 480-483), `ValidBR1` (l. 94-97,
  395-401).
- Dépendance vers [`LDate`](../LDate.class/dependencies.md) : `Year`, `Year2`, `Month`, `MonStr`,
  `MonStr3`, `Week`, `Day`, `WeekDay`, `WeekDay3`. Toute correction de `MonStr` ou `Year2` dans
  `LDate` modifie les libellés générés par `LVar`.
- **Appel dynamique** : `Eval(str, $context)` sur une expression lue en base
  (`Fiches_Comptes.libel_def`, `numDoc`…) ; `deps.py` ne le signale pas.
- La `Collection` de contexte est partagée par référence avec l'appelant.
- Aucun SQL direct.
