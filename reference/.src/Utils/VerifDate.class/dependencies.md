# VerifDate — Dépendances

> Source : `.src/Utils/VerifDate.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/VerifDate.class` — classe, Create Static, hérite de `LDate`
- Handlers GUI détectés : 0

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/Facturation/Facture.class` | `<type>`, `ClotDroi` |
| `.src/Gestion/Facturation/Facturefm.class` | `<type>`, `ClotFac` |
| `.src/Gestion/Facturation/ObjFac.class` | `<type>`, `ClotFac` |
| `.src/Gestion/Facturation/SaiReg.class` | `<type>`, `ClotComptable` |
| `.src/Gestion/Stock/Mvtex.class` | `<type>`, `ClotDroi` |
| `.src/Gestion/Stock/commande1.class` | `<type>`, `ClotDroi`, `DateCom` |
| `.src/Gestion/option/ObjFacB.class` | `<type>`, `ClotDroi`, `ClotFac` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `LDate` | `<type>`, `Apres`, `Avant`, `Day`, `Dte`, `FinJour`, `FinMois`, `G`, `L`, `Month` |
| `Utils` | `Option`, `db` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Parametres`, `Fiches_ligregie`, `Fiches_regie`

### Membres Public sans usage externe détecté (portée réductible ?)

`ClotGestion`, `ClotSuspendu`, `ClotAcquite`, `DateSus`, `DateAcq`, `DateGes`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Héritage** : `Inherits LDate` ; dépend du constructeur et de `Avant`, `Apres`, `FinMois`,
  `FinJour`, `L`, `G` de [`LDate`](../LDate.class/dependencies.md). Rework de `LDate` d'abord.
- **`_call` surestimé** par `deps.py` : les lignes listées sont des `New VerifDate(…)` ; aucun appel
  `VerifDate(…)` direct (vérifié par `grep`).
- **Appel statique** : `Facture.class:6511` `VerifDate.ClotDroi(cart.Text)` utilise
  l'auto-instance (date = instant de sa création), alors que `Facture` crée aussi
  `$vdate = New VerifDate(Now)` (l. 411), jamais utilisé ensuite.
- `DateCom` est lu par `commande1.class:750` ; `deps.py` le signale correctement.
- Tables écrites en dur : `Fiches_Parametres`, `Fiches_Art`, `Fiches_regie`, `Fiches_ligregie`
  (lecture seule).
- `Error.Raise` dans `_new` : les appelants (`commande1`, `Mvtex`, `ObjFac`…) ne l'attrapent pas
  explicitement (à vérifier au cas par cas lors de leur rework).
- Aucun appel dynamique.
