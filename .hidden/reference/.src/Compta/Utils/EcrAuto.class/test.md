# EcrAuto — Tests

> Source : `.src/Compta/Utils/EcrAuto.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Classe de traitement sans formulaire : les cas sans dialogue se testent en `gbtest` (instanciation
directe avec un `VarEcr` construit dans le test, base MariaDB jetable chargée par `Laurux01.sql`),
avec comparaison du **dump normalisé** de `Fiches_Mvt`, `Fiches_MvtM`, `Fiches_Comptes`,
`Fiches_Parametres` (compteurs), `Fiches_Traites`, `Docs_Ged`. Les cas qui ouvrent un
`Message.*` passent par les écrans appelants (`replay`).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| ECRAUTO-T01 | gbtest | Écriture « Autre » équilibrée | journal OD, 2 lignes `L_ajou` | `ecriture() = False` ; dump `Fiches_Mvt`, soldes, `numecriture + 1`, `control` | `tests/ecriture_simple/` | à faire |
| ECRAUTO-T02 | gbtest | Écriture déséquilibrée / une ligne | somme ≠ 0 ; `nb() = 1` | abandon (`True`) ; base inchangée (dialogue à neutraliser, voir Détail) | `tests/desequilibre/` | à faire |
| ECRAUTO-T03 | gbtest | Écriture de trésorerie avec lettrage | 411 + 512, `Treso`, `Tlettrage` vers une facture | lots reportés, lignes lettrées (`lettree`) | `tests/tresorerie_lettrage/` | à faire |
| ECRAUTO-T04 | gbtest | Lettrage avec écart sous le seuil | règlement différent de 0,01 de la facture, `ecart = 0.05` | écriture de régularisation sur `jrnod` ; `var.compte` modifié (A02 figée) | `tests/regularisation/` | à faire |
| ECRAUTO-T05 | gbtest | Compte avec collectif | compte avec `coll_cc` | ligne collective ajoutée (`collectif = 1`) | `tests/collectif/` | à faire |
| ECRAUTO-T06 | gbtest | Modification et suppression | écriture existante : une ligne `L_modif`, une `L_sup` | copies dans `Fiches_MvtM` (`supprimee`), `Fiches_Mvt` mis à jour, délettrage | `tests/modif_sup/` | à faire |
| ECRAUTO-T07 | replay | Vente via `ObjFac` | facturer un BL (client LCR acceptée) | `numecriture2`, `dnfac`, libellé `LVar`, `Fiches_Traites` | `tests/vente_facture/` | à faire |
| ECRAUTO-T08 | replay | Numéro de facture déjà utilisé | `dnfac` positionné sur un numéro existant ; « N° suivant » puis « Annuler » | numéro suivant ; abandon avec compteurs consommés (A03 figée) | `tests/facnum_doublon/` | à faire |
| ECRAUTO-T09 | replay | Compte inexistant | ligne sur un compte absent de `Fiches_Comptes` via `ValidBR1` | `Message.Error` ; état des verrous et transactions après (A01 figée) | `tests/compte_inexistant/` | à faire |
| ECRAUTO-T10 | gbtest | `Impression`/`FinImp` | écriture de T01, `numecr = 0` puis réel | nombre de panneaux/étiquettes et textes du `Report` | `tests/impression/` | à faire |
| ECRAUTO-T11 | replay | Archivage GED | `/Soc01/FactcheminC` renseigné, écriture T01 | ligne `Docs_Ged`, tags = comptes, PDF présent | `tests/ged/` | à faire |
| ECRAUTO-T12 | gbtest | Traite sous SQLite | vente client LCR sur base SQLite | comportement actuel figé (erreur `VALUE`, A04) | `tests/traite_sqlite/` | à faire |

## Détail des tests

- **Valeurs attendues** : générées en exécutant les mêmes scénarios dans le clone Laurux non modifié,
  sur la même base initiale ; colonnes volatiles masquées (`dteval`, `datee`, `datem`, `control`
  recalculé si la date entre dans la clé).
- **Dialogues** : `Message.Error` bloque un `gbtest` ; T02 n'est automatisable qu'avec un mode non
  interactif (à prévoir en phase 2, ex. variable `Start.Arg_*` qui journalise au lieu d'afficher)
  ou en `replay`.
- T04, T08, T09, T12 sont des tests de caractérisation d'anomalies.
- Couverture visée : toutes les branches d'`ajout` et d'`ecriture` ; `Impression` par T10.
