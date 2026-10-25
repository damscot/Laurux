# TriFacture — Dépendances

> Source : `.src/Affichages/TriFacture.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Affichages/TriFacture.class` — classe, formulaire associé `TriFacture.form`
- Handlers GUI détectés : 7
- ⚠️ Appels dynamiques (Object.Call/New, Class.Load…) lignes : [84](../../../../.src/Affichages/TriFacture.class#L84), [85](../../../../.src/Affichages/TriFacture.class#L85), [287](../../../../.src/Affichages/TriFacture.class#L287), [288](../../../../.src/Affichages/TriFacture.class#L288), [296](../../../../.src/Affichages/TriFacture.class#L296), [297](../../../../.src/Affichages/TriFacture.class#L297)

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Caisse/Caisse.class` | `<type>`, `BonFacNonPaye` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `LCoul` | `<type>`, `Fac_DB_bgcolor` |
| `LTrans` | `List` |
| `ObjProp` | `<type>`, `tri` |
| `TriGen` | `<type>`, `ExtraSel`, `GetAllFiltered`, `Refresh_Data` |
| `Utils` | `Observers`, `db` |

### Tables SQL référencées

`Fiches_Bl`

### Membres Public sans usage externe détecté (portée réductible ?)

`Update_Req`, `Filter_Calc`, `Total_Calc`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Seul appelant** (vérifié par `grep -rn "TriFacture"`) : `Caisse.Button30_click`
  (`Caisse.class:7160`, choix 2 « Régler des bons de caisses ») avec
  `New TriFacture(Null, TriFacture.BonFacNonPaye, Null, numero_tk, Selection)` ; le premier
  argument est le `Parent` (correct, voir architecture). Au retour, `Caisse` lit `LTrans.List`, remet
  `numtick` à `NULL` puis rattache la sélection (`Caisse.class:7162-7168`).
- **Appels dynamiques** signalés (lignes 84, 85, 287, 288, 296, 297) : ce sont des
  `Object.SetProperty(Obj, "Bsel"/"Bval")` vers l'objet appelant, jamais exécutés avec l'appelant
  actuel (qui passe un `LTrans`). En sens inverse, `TriGen` écrit `TriFacture.Bsel`/`Bval` par
  `Object.SetProperty` : ces deux variables doivent rester `Public` ; `deps.py` ne compte pas ces
  écritures comme usages (limite connue : variables citées en chaîne).
- Handlers `TriGen_MajSel`, `TriGen_Raz`, `TriGen_Data` : levés par `TriGen` (groupe `"TriGen"`
  donné par `As "TriGen"`), donc `Public` obligatoire.
- Couplage par état statique : `LTrans.List` (classe `LTrans`, `.src/Utils/LTrans.class`).
- « Portée réductible » (`Update_Req`, `Filter_Calc`, `Total_Calc`) confirmée par `grep`.
- Aucun `unused`, `arity_errors`, `handlers_inactifs`, `replay_dynamic` ni `replay_missing` (la grille
  est créée par `TriGen`, son `Coltri_Click` est dans `TriGen`).
- Table : `Fiches_Bl` (`TabBl`), lecture seule (l'écriture de `numtick` est faite par `Caisse`).
- Contrainte d'ordre : rework de commonalisation « sélection multiple » à mener avec `TriGen`,
  `GedR` et `Pointage` (POINTAGE-005, GEDR-008).
