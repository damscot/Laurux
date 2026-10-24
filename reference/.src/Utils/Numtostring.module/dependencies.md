# Numtostring — Dépendances

> Source : `.src/Utils/Numtostring.module` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/Numtostring.module` — module
- Handlers GUI détectés : 0
- ⚠️ Homonyme à la casse près (un seul `.gambas/` compilé pour les deux) : `.src/Caisse/numtostring.module`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Compta/Relances/FRelFacture.class` | `Convertir`, `Num2Text` |
| `.src/Gestion/Facturation/ObjFac.class` | `Convertir` |

### Utilise

_Aucune dépendance vers d'autres fichiers du projet._

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`palabraPlural`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **`.src/Caisse/Caisse.class` (`<inconnu:nbtostring>` l.5064-5154)** : à l'exécution, ces appels visent
  **ce** module, seul compilé des deux homonymes à la casse près (vérifié, voir NUMTOSTRING_CAISSE-A01),
  qui n'a pas `nbtostring` : erreur à l'impression d'un chèque. deps.py et links.py traitent les deux
  modules comme distincts (limite connue).
- Appelants réels :
  - `.src/Gestion/Facturation/ObjFac.class:653` — `Numtostring.Convertir(montttc, devise)` (total
    document en lettres) ;
  - `.src/Compta/Relances/FRelFacture.class:427` — `Numtostring.Convertir(...)` (solde du relevé) ;
  - `.src/Compta/Relances/FRelFacture.class:459` — `Numtostring.Num2Text` dans `Solde`, fonction
    sans appelant (code mort de `FRelFacture`) ; l.464 `numtostring.Num2Text` (casse différente, voir
    architecture.md).
- `palabraPlural` : portée réductible confirmée par `grep -rni palabraPlural .src`.
- Pas de dépendance sortante : module feuille, à reworker tôt (avant `ObjFac`, `FRelFacture`).
