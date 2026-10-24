# Comptabilite — Dépendances

> Source : `.src/Compta/Utils/Comptabilite.module` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Utils/Comptabilite.module` — module
- Handlers GUI détectés : 0

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Affichages/TriEcritures.class` | `Bsel`, `journal`, `libelle`, `sCmpt`, `snum` |
| `.src/Affichages/TriEcritures2.class` | `Bsel`, `journal`, `libelle`, `sCmpt`, `snum` |
| `.src/Compta/Saisecrit.class` | `Bsel`, `snum` |
| `.src/Compta/Tresor.class` | `Bsel`, `journal`, `libelle`, `snum` |
| `.src/Gestion/Reglements/TresorFac.class` | `Bsel`, `sCmpt` |

### Utilise

_Aucune dépendance vers d'autres fichiers du projet._

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`sdesg`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Pas un fichier mort** : la note « Comptabilite.module, 6 lignes, mort ? » est infirmée par
  grep (`Comptabilite\.`) : 5 fichiers l'utilisent (voir le tableau d'architecture.md).
- `sdesg` : seules occurrences dans du code commenté (`FClient.class:1795`,
  `FFournisseur.class:1653`, `Extrait.class:306`, `Lettrage.class:201`, `FComptes.class:858`) ;
  `deps.py` la classe à juste titre en « portée réductible » : c'est du code mort.
- `TriEcritures2` et `TresorFac` n'ont aucun appelant trouvé par grep (ni `New`, ni `.Show`, ni
  `.form` qui les référence) : à confirmer dans les lots `Affichages` et `Gestion/Reglements`.
- `TresorFac.compte` (l. 190-194) ouvre `TriCpt` (qui écrit `Bsel` sur l'appelant par
  `Object.SetProperty`, alors que `TresorFac` n'a pas de membre `Bsel` : erreur d'exécution
  probable) puis lit `Comptabilite.Bsel`/`sCmpt`, état périmé ou vide : défaut à reporter au lot
  `Gestion/Reglements` (COMPTABILITE-A01).
- **Ordre de rework** : toute suppression du module se fait après les reworks de `TriEcritures`,
  `Saisecrit` et `Tresor`.
