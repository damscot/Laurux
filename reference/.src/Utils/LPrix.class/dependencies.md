# LPrix — Dépendances

> Source : `.src/Utils/LPrix.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/LPrix.class` — classe, Create Static, hérite de `Array`
- Handlers GUI détectés : 0
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `AddA`, `SubA`, `SumA`, `Del_Taxe`, `Lit_Taxe`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Caisse/Moulinage.class` | `G`, `Mnt`, `TotBTC` |
| `.src/Compta/Pointage.class` | `_call` |
| `.src/Compta/Saisecrit.class` | `<type>`, `Abs`, `Add`, `Sub`, `_call` |
| `.src/Compta/Tables/Abont.class` | `_call` |
| `.src/Compta/Tresor.class` | `<type>`, `Abs`, `Add`, `_call` |
| `.src/Gestion/Entrées/Achat.class` | `<type>`, `Arr_0001`, `Mnt`, `PuBHT`, `PuNHT`, `PuNTC`, `Qte` |
| `.src/Gestion/Entrées/DateTar.class` | `<type>`, `Add_Taxe`, `G`, `PuNHT`, `PuNTC` |
| `.src/Gestion/Entrées/GesTar.class` | `<type>`, `Add_Taxe`, `Arr_0001`, `G`, `Mnt`, `PuBHT`, `PuNHT`, `PuNTC` |
| `.src/Gestion/Facturation/Facture.class` | `_call` |
| `.src/Gestion/Facturation/ObjFac.class` | `_call` |
| `.src/Gestion/Impressions/Edbr.module` | `_call` |
| `.src/Gestion/Stock/ValidBR.class` | `<type>`, `Add`, `_call` |
| `.src/Gestion/Stock/ValidBR1.class` | `Add_Taxe`, `TotNHT`, `_call` |
| `.src/Gestion/Stock/VarMajTar.class` | `<type>`, `Add_Taxe`, `G`, `PuNHT`, `PuNTC` |
| `.src/Gestion/Stock/commande1.class` | `<type>`, `Qte`, `TotNTC`, `_call` |
| `.src/Gestion/Tables/Articles.class` | `<type>`, `Add`, `_call` |
| `.src/Gestion/Tables/FClient.class` | `<type>` |
| `.src/Gestion/Tables/FFournisseur.class` | `<type>` |
| `.src/Gestion/Tables/TarTypeCli.class` | `<type>`, `Add_Taxe`, `G`, `PuNHT`, `PuNTC` |
| `.src/Gestion/option/Consigne.class` | `<type>`, `Qte`, `Sub` |
| `.src/Gestion/option/calculdroit1.class` | `<type>`, `Add_Taxe`, `Arr_0001`, `Cpt`, `Mnt`, `Qte`, `Sub` |
| `.src/Utils/Calcsolde.class` | `_call` |
| `.src/Utils/LCoul.class` | `Arr_001` |
| `.src/Utils/LGed.class` | `<type>`, `D`, `L`, `_call` |
| `.src/Utils/LTaxe.class` | `<type>`, `Arr`, `Mnt`, `Qte`, `_call` |
| `.src/Utils/Sailig.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `LTaxe` | `<type>`, `All_Remises`, `All_Taxes`, `Montant`, `Remise`, `TVA`, `Ttx`, `TxLast` |
| `Utils` | `FloatParse` |

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`Conv_Brut_Net_HT_TTC`, `Arrondi_New`, `AddA`, `SubA`, `Sum`, `SumA`, `Del_Taxe`, `Lit_Taxe`
<!-- /AUTO:dependances -->

## Notes d'analyse
- L'usage dominant est la fabrique `LPrix(…)` (`_call`) suivie d'un format (`.L` 25 occurrences,
  `.D` 14, `.G` 11) : le contrat le plus sensible porte sur ces trois propriétés.
- `LTaxe.Montant` (`LTaxe.class:137`) appelle `LPrix(val, qte, …)` : il dépend de l'anomalie de
  `_call` (quantité ignorée). Voir architecture.md.
- Dépendance circulaire `LPrix` ↔ `LTaxe` : les deux classes doivent être reworkées ensemble
  (même lot en phase 3).
- Aucun appel dynamique ; aucun accès SQL.
