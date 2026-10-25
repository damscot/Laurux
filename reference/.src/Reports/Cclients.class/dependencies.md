# Cclients — Dépendances

> Source : `.src/Reports/Cclients.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Reports/Cclients.class` — classe, hérite de `PdfWriter`
- Handlers GUI détectés : 0

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Compta/Utils/ImpJdv.class` | `<type>`, `BasPage`, `Entete`, `Level1`, `Level2`, `Lines` |
| `.src/Compta/Utils/ImpSage.class` | `<type>`, `BasPage`, `Entete`, `Level1`, `Level2S`, `Lines` |
| `.src/Gestion/Impressions/EdClient.class` | `<type>`, `BasPage`, `Entete`, `Level1`, `Level2`, `Lines` |
| `.src/Gestion/Impressions/EdFour.class` | `<type>`, `BasPage`, `BasPageP`, `EnteteP`, `Level1F`, `Level2F`, `LinesP` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `PdfWriter` | `<type>`, `AddPage`, `Cell`, `Line`, `PageNo`, `SetFillColor`, `SetFont`, `SetLineWidth`, `SetXY`, `SetY` |
| `Start` | `B`, `G`, `R` |

### Tables SQL référencées

_Aucune._
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelants vérifiés** (`grep -rn "As Cclients\|New Cclients"`) : `EdClient`, `EdFour`
  (`Gestion/Impressions`), `ImpJdv`, `ImpSage` (`Compta/Utils`). `EdFour` crée le document en
  paysage (`New Cclients("l", "mm", "A4")`), les autres en portrait. Liste complète.
- **Arité** : `ImpJdv:205` appelle `Level2` avec 12 arguments pour 13 paramètres obligatoires
  (signal `arity_errors` porté par `ImpJdv`, IMPJDV-A04) ; corrigé côté gabarit par
  CCLIENTS-A01 ou côté appelant par IMPJDV-A04 (une seule des deux corrections).
- **Paramètres inutilisés** : `Level2S` reçoit `dom`, `codebanque`, `codeguichet` jamais imprimés
  (`ImpSage` passe `""` aux 3 appels, lignes 203, 212, 221).
- **Appelant** : `EdFour` termine par `BasPage` (portrait) un document paysage (EDFOUR-A01).
- Aucun appel dynamique, aucune dépendance circulaire. **Ordre de rework** : après la base
  `PdfLaurux` (CARTICLES-004) ; CCLIENTS-004 (signature de `Level2S`) dans le même commit que la
  mise à jour d'`ImpSage`.
