# Editeur — Dépendances

> Source : `.src/Gestion/Impressions/Editeur.module` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Impressions/Editeur.module` — module
- Handlers GUI détectés : 0
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Prog_Email`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/FRestore.class` | `Prog_Editeur` |
| `.src/Communs/FSauve.class` | `Prog_Editeur` |
| `.src/Compta/Cielimp.class` | `Prog_Editeur` |
| `.src/Compta/Impressions/Balance.class` | `Prog_Editeur` |
| `.src/Compta/Impressions/Editcompte.class` | `Prog_Editeur` |
| `.src/Compta/Impressions/EditcompteA.class` | `Prog_Editeur` |
| `.src/Compta/Impressions/ExportA47.class` | `Prog_Editeur` |
| `.src/Compta/Impressions/Jourcent.class` | `Prog_Editeur` |
| `.src/Compta/Impressions/Journaux.class` | `Prog_Editeur` |
| `.src/Compta/Utils/ExportJdv.class` | `Prog_Editeur` |
| `.src/Compta/Utils/ImpJdv.class` | `Prog_Editeur` |
| `.src/Compta/Utils/ImpSage.class` | `Prog_Editeur` |
| `.src/Gestion/Entrées/Achat.class` | `Prog_Editeur` |
| `.src/Gestion/Etiquettes/Etigond.class` | `Prog_Editeur` |
| `.src/Gestion/Etiquettes/Etiqart.class` | `Prog_Editeur` |
| `.src/Gestion/Etiquettes/Etiqcasier.class` | `Prog_Editeur` |
| `.src/Gestion/Facturation/Facture.class` | `Prog_Editeur` |
| `.src/Gestion/Impressions/EdPrep.class` | `Prog_Editeur` |
| `.src/Gestion/Lcr/Portables/Majcasier.class` | `Prog_Editeur` |
| `.src/Gestion/Stock/Inventaires/Fin-annee/SaisieInv.class` | `Prog_Editeur` |
| `.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class` | `Prog_Editeur` |
| `.src/Gestion/Stock/Tarifs/Impart.class` | `Prog_Editeur` |
| `.src/Gestion/Stockmvt.class` | `Prog_Editeur` |
| `.src/Gestion/SupprArt.class` | `Prog_Editeur` |
| `.src/Statistiques/Histocliart.class` | `Prog_Editeur` |
| `.src/Utils/Dcfour.class` | `Prog_Editeur` |
| `.src/Utils/VisPmp.class` | `Prog_Editeur` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `CheckProg` | `Chk` |
| `Start` | `LocalSettings` |

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`Prog_Email`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Appelants vérifiés par `grep -rn "Editeur\.Prog_Editeur" .src` : 37 appels dans 27 fichiers, tous
  à un seul argument et en instruction (valeur de retour jamais lue). La liste AUTO est exacte.
- `Prog_Email` : aucun appelant (`grep -rn Prog_Email .src`) — `unused` confirmé ; c'est l'unique
  utilisateur de `CheckProg.Chk` (`grep -rn "CheckProg\." .src`). Contrainte d'ordre : EDITEUR-002
  avant CHECKPROG-003 (suppression du module `CheckProg`).
- `Bordrx.class:383` appelle `Impression.Prog_Editeur` (inexistant) au lieu de
  `Editeur.Prog_Editeur` : IMPRESSION-A03, non vu par `deps.py` (membre inexistant d'un module).
- Clé de configuration `/CmdEditor<n>` : lue ici seulement, écrite par aucun écran.
- Aucun appel dynamique, aucune table.
