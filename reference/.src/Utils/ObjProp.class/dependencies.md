# ObjProp — Dépendances

> Source : `.src/Utils/ObjProp.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/ObjProp.class` — classe, Create Static
- Handlers GUI détectés : 0
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `AjoutCondfilter`, `CondFilter`
- ⚠️ Appels dynamiques (Object.Call/New, Class.Load…) lignes : [95](../../../../.src/Utils/ObjProp.class#L95), [120](../../../../.src/Utils/ObjProp.class#L120)

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Affichages/TriArticles.class` | `<type>`, `AddChamp`, `tri` |
| `.src/Affichages/TriCpt.class` | `<type>`, `AddChamp`, `tri` |
| `.src/Affichages/TriFacture.class` | `<type>`, `tri` |
| `.src/Affichages/TriGen.class` | `<type>`, `NomControl`, `filter`, `name`, `tri` |
| `.src/Communs/Parametre.class` | `<type>`, `AddChamp`, `ComboBox`, `Height`, `Width` |
| `.src/Compta/Pointage.class` | `<type>`, `tri` |
| `.src/Gestion/Entrées/Achat.class` | `<type>`, `AddChamp`, `Button`, `Height`, `NomControl`, `Width`, `name` |
| `.src/Gestion/Entrées/GesTar.class` | `<type>`, `AddChamp`, `Button`, `Height`, `Width` |
| `.src/Gestion/Stock/ValidBR1.class` | `<type>`, `AddChamp`, `cle`, `tri` |
| `.src/Gestion/Stock/VarMajTar.class` | `<type>`, `NomControl`, `name` |
| `.src/Gestion/Stock/commande1.class` | `<type>`, `AddChamp`, `cle`, `tri` |
| `.src/Gestion/Tables/Articles.class` | `<type>`, `AddChamp`, `tri` |
| `.src/Gestion/Tables/FClient.class` | `<type>`, `tri` |
| `.src/Gestion/Tables/FFournisseur.class` | `<type>`, `tri` |
| `.src/Gestion/Tables/TarTypeCli.class` | `<type>`, `AddChamp` |
| `.src/Gestion/option/Visucmat.class` | `<type>`, `AddChamp` |
| `.src/Utils/GedR.class` | `<type>` |
| `.src/Utils/LGed.class` | `<type>` |
| `.src/Utils/SaiTableau.class` | `<type>`, `AddChamp`, `Height`, `Label`, `NomControl`, `TextReg`, `Width` |
| `.src/Utils/Sailig.class` | `<type>`, `AppProp`, `Button`, `CheckBox`, `ComboBox`, `Label`, `NomControl`, `TextBox`, `TextLabel`, `TextReg`, `TypeClass` |
| `.src/Utils/TextReg.class` | `<type>`, `AppProp`, `EcriParam`, `Param`, `historique` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `LDate` | `<type>`, `G` |
| `Start` | `Societe` |
| `TextReg` | `<type>`, `Text` |
| `Utils` | `CDec` |

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`ModChamp`, `AjoutCondfilter`, `CondFilter`, `LecParam`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appels dynamiques** (lignes 95 et 120) : `Object.SetProperty` / `Object.GetProperty` sur des
  noms de propriétés fournis par les appelants (`"Alignment"`, `"reg"`, `"champ"`, `"Choirech"`,
  `"H"`, `"W"`, `"Text"`, `"Tag"`, `"Tooltip"`…). Ils créent des dépendances **invisibles** vers
  les propriétés de `TextReg` (`Champ`, `reg`, `Choirech`) et des contrôles Gambas (`H`/`W`,
  alias de `Height`/`Width`, posés par les propriétés `Height`/`Width` d'`ObjProp`) : renommer une propriété de `TextReg` casse `ObjProp` sans
  erreur de compilation.
- Dépendance circulaire `ObjProp` ↔ `TextReg` (`ObjProp.filter As TextReg`,
  `TextReg.$prop As ObjProp`) : les deux classes doivent être reworkées dans le même lot.
- Membres `<inconnu:…>` côté appelants (`delete`, `x`, `text`, `add`, `max`…) : résolution
  approximative de variables locales typées différemment (limite connue de `deps.py`).
- Portée réductible proposée (`AjoutCondfilter`, `CondFilter`, `LecParam`) : confirmée par `grep`.
- Fichier externe : `~/.config/gambas3/Laurux-AutoParams-<société>.conf`.
