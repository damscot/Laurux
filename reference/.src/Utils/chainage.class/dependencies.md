# chainage — Dépendances

> Source : `.src/Utils/chainage.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/chainage.class` — classe
- Handlers GUI détectés : 3
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `addintercale`, `modif`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Affichages/TriGen.class` | `<type>`, `add` |
| `.src/Caisse/Fondcaisse.class` | `<type>` |
| `.src/Communs/Parametre.class` | `<type>` |
| `.src/Compta/Cielcorsp.class` | `<type>` |
| `.src/Compta/Cielcorspj.class` | `<type>` |
| `.src/Compta/Extrait.class` | `<type>` |
| `.src/Gestion/Entrées/Achat.class` | `<type>`, `add`, `sup` |
| `.src/Gestion/Entrées/GesTar.class` | `sup` |
| `.src/Gestion/Facturation/OptFac.class` | `<type>` |
| `.src/Gestion/Facturation/SaiReg.class` | `<type>`, `add` |
| `.src/Gestion/Lcr/Attribution.class` | `<type>` |
| `.src/Gestion/Lcr/Banque.class` | `<type>` |
| `.src/Gestion/Lcr/Glcr.class` | `<type>` |
| `.src/Gestion/Lcr/Lcr.class` | `<type>` |
| `.src/Gestion/Lcr/Preparation.class` | `<type>` |
| `.src/Gestion/Stock/Inventaires/Fin-annee/SaisieInv.class` | `<type>` |
| `.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class` | `<type>` |
| `.src/Gestion/Stock/Mvtex.class` | `<type>` |
| `.src/Gestion/Stock/ValidBR1.class` | `<type>` |
| `.src/Gestion/Stock/commande1.class` | `<type>`, `sup` |
| `.src/Gestion/Stockmvt.class` | `<type>` |
| `.src/Gestion/Tables/Mreglement.class` | `<type>` |
| `.src/Gestion/Tables/TarTypeCli.class` | `<type>` |
| `.src/Gestion/option/Caleditcmat.class` | `<type>` |
| `.src/Gestion/option/Edconsigne.class` | `<type>` |
| `.src/Gestion/option/Visucmat.class` | `<type>` |
| `.src/Gestion/option/artopt.class` | `<type>`, `add` |
| `.src/Gestion/option/menuopt.class` | `<type>`, `add` |
| `.src/Statistiques/Histocliart.class` | `<type>` |
| `.src/Utils/Sailig.class` | `<type>`, `add`, `tableaux` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Utils` | `ObsGotf`, `ObsLstf` |

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`addintercale`, `modif`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Le nom de classe est écrit `Chainage` (majuscule) par tous les appelants (`New Chainage(...)`,
  `As Chainage`) : `grep -rniw chainage` est nécessaire (68 occurrences `as chainage`/`new chainage`
  dans `.src`). deps.py les résout correctement (liste « Utilisé par » ci-dessus).
- **Faux négatifs** de deps.py sur les membres, appels via des objets non typés (`sl.chain`,
  `Me.ligne[...].chain`, `Value.chain`) :
  - `sup` : `Gestion/Entrées/GesTar.class:129, 391, 395`, `Gestion/Entrées/Achat.class:480, 630-634,
    1469, 1683`, `Gestion/Stock/commande1.class:225, 235, 236` ;
  - `tableaux` : `Utils/Sailig.class:96` (`.Clear`), `Gestion/Entrées/Achat.class:415, 478`
    (`.Extract(1)`).
- `addintercale` (signalé réductible) et `modif` (non signalé) : **aucun appelant**
  (`grep -rni "\.modif(\|\.addintercale(" .src`).
- Dépend de `Utils.ObsGotf`/`ObsLstf` : `Utils.module` doit garder ces signatures.
- Classe très partagée : tout rework doit repasser les replays des écrans de saisie (Parametre,
  Achat, SaiReg, Sailig/GesTar, Fondcaisse).
