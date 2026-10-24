# Sailig — Dépendances

> Source : `.src/Utils/Sailig.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/Sailig.class` — classe
- Handlers GUI détectés : 3

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Parametre.class` | `<type>`, `MonControle` |
| `.src/Gestion/Entrées/Achat.class` | `<type>`, `AutresObj`, `Ind`, `MonControle`, `Tag`, `chain`, `ecriture`, `lecture`, `prx`, `reception` |
| `.src/Gestion/Entrées/GesTar.class` | `<type>`, `AutresObj`, `Ind`, `MonControle`, `Y`, `chain`, `lecture`, `prx`, `valide` |
| `.src/Gestion/Stock/VarMajTar.class` | `<type>`, `AutresObj`, `MonControle`, `valide` |
| `.src/Gestion/Stock/commande1.class` | `<type>`, `AutresObj`, `Delete`, `Dernier`, `MonControle`, `Y`, `chain`, `prx` |
| `.src/Utils/SaiTableau.class` | `<type>`, `Background`, `Delete`, `Dernier`, `Ind`, `MonControle`, `Panel1`, `Y`, `ecriture`, `lecture`, `prx`, `txl` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `LPrix` | `<type>` |
| `LTaxe` | `<type>` |
| `ObjProp` | `<type>`, `AppProp`, `Button`, `CheckBox`, `ComboBox`, `Label`, `NomControl`, `TextBox`, `TextLabel`, `TextReg`, `TypeClass` |
| `TextReg` | `<type>` |
| `chainage` | `<type>`, `add`, `tableaux` |

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`arrondi`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Faux positif** : `arrondi` est écrit par `Achat` (`.src/Gestion/Entrées/Achat.class:227`, via
  `Me.ligne[Me.ind].arrondi`) : la portée doit rester `Public`.
- Les événements de `Sailig` sont consommés par `SaiTableau` (`As "ligne"`, handlers `ligne_*`), par
  son héritier `Achat` (redéfinitions) et par `GesTar` (`ligne_gotfocus`/`Ligne_lostfocus`) : liens
  par nom d'événement, invisibles pour l'heuristique.
- `chainage.add` attend un `Object[]` (`.src/Utils/chainage.class:80`) : l'appel ligne 60 avec un
  objet seul est suspect (cas `ObjProp.TextBox` non utilisé).
- **Dépendance circulaire** `Sailig` ↔ `SaiTableau` (types et événements) : même lot de rework.
  Prérequis : `ObjProp`, `chainage`, `TextReg` stables.
