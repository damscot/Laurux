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
| ECRAUTO-T01 | gbtest | Écriture « Autre » équilibrée | journal OD, 2 lignes `L_ajou` | `ecriture() = False` ; dump `Fiches_Mvt`, soldes, `numecriture + 1`, `control` | `tests/ecriture_simple/` | implémenté |
| ECRAUTO-T02 | gbtest | Écriture déséquilibrée / une ligne | somme ≠ 0 ; `nb() = 1` | abandon (`True`) ; base inchangée (dialogue à neutraliser, voir Détail) | `tests/desequilibre/` | à faire : Message.Error bloquant en gb.test (abandon d’écriture) |
| ECRAUTO-T03 | gbtest | Écriture de trésorerie avec lettrage | 411 + 512, `Treso`, `Tlettrage` vers une facture | lots reportés, lignes lettrées (`lettree`) | `tests/tresorerie_lettrage/` | implémenté (gb.test `EcrAutoTest.T03TresoLettrage` ; exercice de Fiches_Mvt porté à 2025 dans le test : Listextcpt ne lit que Now ± 8 ans) |
| ECRAUTO-T04 | gbtest | Lettrage avec écart sous le seuil | règlement différent de 0,01 de la facture, `ecart = 0.05` | écriture de régularisation sur `jrnod` ; `var.compte` modifié (A02 figée) | `tests/regularisation/` | implémenté (gb.test `EcrAutoTest.T04Regularisation` : régularisation 0,01 sur jrnod 10, contrepartie cptrsmoins 129000, A02 figée) |
| ECRAUTO-T05 | gbtest | Compte avec collectif | compte avec `coll_cc` | ligne collective ajoutée (`collectif = 1`) | `tests/collectif/` | implémenté |
| ECRAUTO-T06 | gbtest | Modification et suppression | écriture existante : une ligne `L_modif`, une `L_sup` | copies dans `Fiches_MvtM` (`supprimee`), `Fiches_Mvt` mis à jour, délettrage | `tests/modif_sup/` | implémenté (gb.test `EcrAutoTest.T06ModifSup` ; une seconde écriture garde une ligne sur 512000 : supprimer la dernière ligne d'un compte ouvre un Message.Error bloquant, ECRAUTO-A08) |
| ECRAUTO-T07 | replay | Vente via `ObjFac` | facturer un BL (client LCR acceptée) | `numecriture2`, `dnfac`, libellé `LVar`, `Fiches_Traites` | `tests/vente_facture/` | implémenté (gb.test `EcrAutoTest.T07VenteObjFac` au lieu d'un replay : `ObjFac` instancié directement, jeu `Gestion/objfac_shared/facturation_base`, mode de règlement LCR acceptée créé dans le test) |
| ECRAUTO-T08 | replay | Numéro de facture déjà utilisé | `dnfac` positionné sur un numéro existant ; « N° suivant » puis « Annuler » | numéro suivant ; abandon avec compteurs consommés (A03 figée) | `tests/facnum_doublon/` | implémenté (gb.test `EcrAutoTest.T08FacnumSuivant` et `T08bFacnumAnnuler` : boîtes « N° suivant »/« Annuler » répondues par un Timer ; A03 figée : compteurs consommés) |
| ECRAUTO-T09 | replay | Compte inexistant | ligne sur un compte absent de `Fiches_Comptes` via `ValidBR1` | `Message.Error` ; état des verrous et transactions après (A01 figée) | `tests/compte_inexistant/` | à faire : Message.Error (ajout, compte inexistant) bloquant en gb.test ; seul appelant ValidBR1 (ShowModal, REPLAYOBSERVER-A15 ; grilles TriGen) non rejouable |
| ECRAUTO-T10 | gbtest | `Impression`/`FinImp` | écriture de T01, `numecr = 0` puis réel | nombre de panneaux/étiquettes et textes du `Report` | `tests/impression/` | implémenté (gb.test `EcrAutoTest.T10Impression` : libellés du Report avant/après écriture) |
| ECRAUTO-T11 | replay | Archivage GED | `/Soc01/FactcheminC` renseigné, écriture T01 | ligne `Docs_Ged`, tags = comptes, PDF présent | `tests/ged/` | implémenté (en gb.test `EcrAutoTest.T11Ged` plutôt qu'en replay : aucun écran simple n'appelle EcrAuto ; Docs_Ged, tags, PDF) |
| ECRAUTO-T12 | gbtest | Traite sous SQLite | vente client LCR sur base SQLite | comportement actuel figé (erreur `VALUE`, A04) | `tests/traite_sqlite/` | à faire : aucune base SQLite dans le harnais de test (TESTING.md ne prévoit que MariaDB) |

## Détail des tests

- **Valeurs attendues** : générées en exécutant les mêmes scénarios dans le clone Laurux non modifié,
  sur la même base initiale ; colonnes volatiles masquées (`dteval`, `datee`, `datem`, `control`
  recalculé si la date entre dans la clé).
- **Dialogues** : `Message.Error` bloque un `gbtest` ; T02 n'est automatisable qu'avec un mode non
  interactif (à prévoir en phase 2, ex. variable `Start.Arg_*` qui journalise au lieu d'afficher)
  ou en `replay`.
- T04, T08, T09, T12 sont des tests de caractérisation d'anomalies.
- Couverture visée : toutes les branches d'`ajout` et d'`ecriture` ; `Impression` par T10.
- **Implémentation (phase 2, vague 4)** : module `.src/Tests/Compta/EcrAutoTest.test` (base Laurux01 sans jeu) :
  `T01EcritureSimple` (606100/512000, journal 10 : `ecriture()` = False, numecr 1, 2 lignes, soldes, numecriture),
  `T05Collectif` (607000/401001, journal 60 : 3 lignes dont la ligne collective 401000, soldes). Un essai T06
  (modification + suppression de l'écriture de T01) dépasse le délai dans ref : retiré du module.
- **Vague 7** : T03, T04 (exercice porté à 2025 par `UPDATE Fiches_Parametres SET dteclec` dans le test, lignes datées du 2025-06-15 ; `ecart = 0.05` pour T04), T10 (parcours des `Children` du Report, nom d'utilisateur masqué), T11 (`/Soc01/FactcheminC` = `~/gedcompta`, posé dans le test).
