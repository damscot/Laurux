# CTestTVA — Dépendances

> Source : `.src/Utils/CTestTVA.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/CTestTVA.class` — classe
- Handlers GUI détectés : 0

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fsoc.class` | `CleTVAIntra`, `isIntraComValide` |
| `.src/Gestion/Tables/FFournisseur.class` | `isIntraComValide` |

### Utilise

_Aucune dépendance vers d'autres fichiers du projet._

### Tables SQL référencées

_Aucune._
<!-- /AUTO:dependances -->

## Notes d'analyse

- Appelants confirmés par grep : `Communs/Fsoc.class:307` (`CleTVAIntra`, sous `Try`),
  `Communs/Fsoc.class:321` et `Gestion/Tables/FFournisseur.class:654` (`isintracomvalide`, écrit en
  minuscules : la résolution des membres est insensible à la casse ; deps.py le détecte).
- `FFournisseur` n'appelle la fonction que si le numéro commence par `FR` ; `Fsoc` l'appelle pour
  tout numéro non vide.
- Aucune dépendance sortante : classe feuille, à reworker tôt.
