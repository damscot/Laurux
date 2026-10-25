# EdReg — Dépendances

> Source : `.src/Gestion/Impressions/EdReg.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Impressions/EdReg.class` — classe, formulaire associé `EdReg.report`
- Handlers GUI détectés : 4

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/Facturation/SaiReg.class` | `<type>`, `ajout`, `tous` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `LDate` | `_call` |
| `Start` | `B`, `G`, `R` |
| `Utils` | `db` |
| `VarEcr` | `<type>`, `L_ajou`, `L_sup`, `etat`, `nb`, `plus`, `somme`, `trouve` |

### Tables SQL référencées

`Fiches_Societes`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Fichier d'interface : `EdReg.report` (gb.report), non analysé par `deps.py`. Les fonctions
  `dte_Data`, `cde_Data`, `nom_Data`, `montant_Data` sont les handlers `Data` des `ReportLabel`
  `dte`, `cde`, `nom`, `montant` : le signal `unused` / « portée réductible » est un **faux
  positif** (limite de l'outil : contrôles des `.report`).
- Appelants vérifiés par grep : `SaiReg.class:1115` (`EdReg.ajout`) et `SaiReg.class:1128`
  (`EdReg.tous`), puis `ed.Print(imp)` (méthode héritée de `Report`, notée `<inconnu:print>`).
- Utilise `VarEcr` (`plus`, `nb`, `somme`, `trouve`, `L_ajou`, `L_sup`) — non listé par l'outil car
  les accès passent par un `Variant` dans les handlers.
- Table `Fiches_Societes` en dur (clé `TabSoc` disponible), sans filtre société.
- Contrainte d'ordre : rework conjoint possible avec `SaiReg` (même scénario de test).
