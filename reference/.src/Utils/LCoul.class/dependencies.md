# LCoul — Dépendances

> Source : `.src/Utils/LCoul.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/LCoul.class` — classe, Create Static
- Handlers GUI détectés : 0

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Affichages/TriArticles.class` | `<type>`, `Art_DB_bgcolor` |
| `.src/Affichages/TriFacture.class` | `<type>`, `Fac_DB_bgcolor` |
| `.src/Compta/Utils/Listextcpt.class` | `Ecr_DB_bgcolor` |
| `.src/Gestion/Tables/Articles.class` | `<type>`, `Art_DB_bgcolor` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `LPrix` | `Arr_001` |
| `Start` | `LocalSettings` |
| `Utils` | `Fcolr` |

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`Art_Stk`, `Art_NStk`, `Art_Epuise`, `Art_Suspendu`, `Ecr_provisoire`, `Ecr_lettree`, `Ecr_pointee`, `Ecr_cloture`, `Ecr_oldex`, `Fac_Proforma`, `Fac_Devis`, `Fac_Commande`, `Fac_Bon`, `Fac_Acquite`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Portée réductible confirmée** pour les 14 champs `SColor` : aucun accès externe (`grep`).
  Les trois fonctions `*_DB_bgcolor` restent `Public`.
- `LPrix.Arr_001` n'est qu'une valeur par défaut d'un paramètre inutilisé : la dépendance vers
  `LPrix` disparaît avec le nettoyage de la signature de `_New`.
- Appel statique sur l'auto-instance : `Listextcpt.class:109/114/121/127`.
- Les fragments SQL produits portent sur les tables des appelants : `Fiches_Art` (articles),
  `Fiches_Bl` (documents, via `TriFacture`), `Fiches_Mvt*` (écritures, via `Listextcpt`).
- Lecteurs concurrents des mêmes clés de configuration : `Start.module`, `Cprod.class`, `SetColors`.
- Aucun appel dynamique.
