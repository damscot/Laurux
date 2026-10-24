# LTaxe — Dépendances

> Source : `.src/Utils/LTaxe.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/LTaxe.class` — classe, Create Static, hérite de `Array`
- Handlers GUI détectés : 0

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Caisse/Moulinage.class` | `<type>` |
| `.src/Gestion/Entrées/Achat.class` | `<type>`, `Frais`, `Montant`, `Remise`, `TVA` |
| `.src/Gestion/Entrées/DateTar.class` | `<type>`, `Remise`, `TVA` |
| `.src/Gestion/Entrées/GesTar.class` | `<type>`, `Marge`, `Remise`, `TVA` |
| `.src/Gestion/Stock/ValidBR1.class` | `<type>`, `Montant`, `TVA` |
| `.src/Gestion/Stock/VarMajTar.class` | `<type>`, `Remise`, `TVA` |
| `.src/Gestion/Tables/TarTypeCli.class` | `<type>`, `Remise`, `TVA` |
| `.src/Gestion/option/Consigne.class` | `<type>`, `Consigne` |
| `.src/Gestion/option/calculdroit1.class` | `<type>`, `DA`, `Regie`, `Remise`, `SS`, `TVA` |
| `.src/Reports/Editfac.class` | `<type>` |
| `.src/Utils/LPrix.class` | `<type>`, `All_Remises`, `All_Taxes`, `Montant`, `Remise`, `TVA`, `Ttx`, `TxLast` |
| `.src/Utils/LScript.class` | `<type>` |
| `.src/Utils/Sailig.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `LPrix` | `<type>`, `Arr`, `Mnt`, `Qte`, `_call` |
| `Utils` | `FloatParse` |

### Tables SQL référencées

_Aucune._
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Dépendance circulaire `LPrix` ↔ `LTaxe`** : `LTaxe.Montant` construit un `LPrix` ;
  `LPrix.Conv_Brut_Net_HT_TTC` appelle `LTaxe.Montant`. Les deux classes sont reworkées dans le
  même lot en phase 3, et les anomalies LPRIX-A01 / LTAXE-A01 doivent être corrigées **dans le même
  commit** (voir architecture.md, `Montant`).
- `LTaxe.class:137` : `LPrix(val, qte, HT.Arr, Me.Cpt)` dépend du comportement actuel de
  `LPrix._call` (quantité ignorée).
- Appelants de `Montant` vérifiés par `grep` (le bloc AUTO ne voit que les variables typées) :
  `LPrix.class:537/551/553/567`, `calculdroit1.class:58/60/64/122/134/149/165`,
  `Consigne.class:85`, `Achat.class:354/970/994`, `ValidBR1.class:419`, `Moulinage.class:2804`
  (via `drt.accise_droit().Montant(…)`, objet `Calculdroit1`, non résolu par `deps.py`).
- `Moulinage`, `Editfac`, `LScript`, `Sailig` : référence de type seulement (`<type>`), pas d'appel
  de membre.
- Énumérations jamais utilisées hors de la classe : `TEE`, `TEA`, `CopiePrivee`, `CSS`, `Fixe`,
  `Deconsigne` (elles restent utiles via `All_Taxes`).
- Membres sans usage externe : propriété `Lib`, événement `change`. `deps.py` ne les signale pas
  (le bloc « portée réductible » ne liste que les fonctions).
- Aucun appel dynamique ; aucun accès SQL.
