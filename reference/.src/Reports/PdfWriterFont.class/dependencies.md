# PdfWriterFont — Dépendances

> Source : `.src/Reports/PdfWriterFont.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Reports/PdfWriterFont.class` — classe
- Handlers GUI détectés : 0

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Reports/PdfWriter.class` | `Font` |

### Utilise

_Aucune dépendance vers d'autres fichiers du projet._

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`courier`, `courierB`, `courierI`, `courierBI`, `serif`, `serifB`, `serifI`, `helvetica`, `helveticaB`, `helveticaI`, `helveticaBI`, `symbol`, `times`, `timesB`, `timesBI`, `timesI`, `zapfdingbats`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Seul appelant : `PdfWriter.SetFont` (`PdfWriter.class:907`, polices de base) et `PdfWriter.AddFont`
  (mort). Vérifié par `grep -rn PdfWriterFont .src` : aucun autre usage.
- `scope_reducible` (17 fonctions par police) : confirmé, appelées uniquement par `Font` dans ce
  fichier (forme `PdfWriterFont.courier()`, qualifiée par la classe, ce qui reste valable en
  `Static Private`).
- **Membre inexistant non détecté par deps.py** : `PdfWriterFont.serifBI()` (`Case "serifBI"`,
  l.49) : la fonction n'existe pas ; `gbc3` l'accepte, l'exécution lèverait « Unknown symbol ».
- Signaux `unused`, `unused_transitive`, `arity_errors`, `handlers_inactifs`, `replay_*` : vides.
- Pas de dépendance circulaire ; à reworker **avant** `PdfWriter` (indépendant de lui).
