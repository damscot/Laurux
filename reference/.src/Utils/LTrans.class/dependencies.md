# LTrans — Dépendances

> Source : `.src/Utils/LTrans.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/LTrans.class` — classe, Create Static
- Handlers GUI détectés : 0
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `New`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Affichages/TriFacture.class` | `List` |
| `.src/Caisse/Caisse.class` | `<type>`, `List` |
| `.src/Utils/GedR.class` | `<type>`, `List` |
| `.src/Utils/LGed.class` | `<type>`, `List` |

### Utilise

_Aucune dépendance vers d'autres fichiers du projet._

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`New`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Faux positifs** dans `TriFacture.class` : les lignes `CB1.List[…]` (ComboBox) ne concernent
  pas `LTrans`. Les vrais usages de `TriFacture` sont l. 81-82, 284-285, 293-294, sur
  l'auto-instance `LTrans.List`.
- **Usage via `Object`** : `LBox` reçoit l'`LTrans` dans `$obj As Object` et écrit
  `$obj.List = …` (l. 104, 111, 118) ; `TriFacture` teste `Object.Class(Obj).Name = "LTrans"`
  (nom de classe en chaîne : un renommage de la classe casserait ce test). Non résolu par `deps.py`.
- **État global** : `Caisse.class:7162` lit `LTrans.List` (auto-instance) écrit par `TriFacture`.
  `LTrans` doit être reworké avec `TriFacture` et `Caisse` (rework minimal sur `Caisse`).
- `New` signalé « portée réductible » : en réalité code mort (jamais appelé).
- Aucun SQL, aucun appel dynamique au sens `Object.Call`.
