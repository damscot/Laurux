# TriFacture — Tests

> Source : `.src/Affichages/TriFacture.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran de la caisse (`./Laurux -p`) : scénarios `replay` mutualisés avec `CAISSE-T11` (règlement de BL
et factures). Comparaison : dump normalisé (`Fiches_Bl.numtick`, ticket et règlements créés) ; lignes
`Exec_SQL` à titre informatif.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| TRIFACTURE-T01 | replay | Sélection de documents à régler | caisse : Ctrl+F12, choix 2, clic sur deux BL et une facture non payée, fermeture | `numtick` des trois documents = ticket courant ; compteur 3 ; totaux HT/TTC | `tests/selection_reglement/` | implémenté (gb.test `TriFactureTest.T01SelectionReglement` : écran instancié comme le fait la caisse ; l'écriture de `numtick` reste dans Caisse, revue manuelle) |
| TRIFACTURE-T02 | replay | Reprise d'une sélection existante | ticket ayant déjà des BL rattachés : choix 2, désélection d'un BL, fermeture | sélection initiale = BL du ticket ; `numtick` du BL retiré à `NULL` | `tests/reprise_selection/` | implémenté (gb.test `TriFactureTest.T02RepriseSelection` : sélection initiale et `LTrans.List` ; remise à NULL de `numtick` faite par Caisse, revue manuelle) |
| TRIFACTURE-T03 | replay | Filtre par type et (dé)sélection globale | `CB1` sur chaque type ; filtre texte TriGen ; `SelectAllFil` puis `DeSelectAllFil` | lignes affichées et compteur de référence ; sélection conservée hors filtre | `tests/filtre_type/` | implémenté (gb.test `TriFactureTest.T03FiltreType` : CB1, SelectAllFil/DeSelectAllFil ; filtre texte de TriGen non joué) |
| TRIFACTURE-T04 | replay | Raz et fermeture sans sélection | bouton Raz de TriGen, fermeture | `LTrans.List` vide ; aucun BL rattaché | `tests/raz/` | implémenté (gb.test `TriFactureTest.T04Raz`) |
| TRIFACTURE-T05 | gbtest | `FiltreDocuments` (après TRIFACTURE-007) | chaque index de `CB1`, client vide ou non, ticket vide ou non | texte du filtre identique au clone non modifié | `tests/filtre_documents/` | à faire : après TRIFACTURE-007 (extraction : fonction privée) |
| TRIFACTURE-T06 | gbtest | `TotauxSelection` (après TRIFACTURE-007) | sélection vide, 1, 3 BL ; numéro à zéros non significatifs (SQLite) | totaux de référence ; figer A01 | `tests/totaux_selection/` | à faire : après TRIFACTURE-007 (extraction : fonction privée) |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone **Laurux non modifié** (A01 figée).
- **Données** : jeu dérivé de `Laurux01.sql` avec un client en compte, ≥ 25 documents `Fiches_Bl`
  de chaque type (P, D, C, B, F), payés et non payés, dont certains déjà rattachés à un ticket ; base
  caisse (`Fiches_Caisses`, vendeur) des scénarios `Caisse`.
- **Rejeu** : `_new` appelle `Utils.Observers(Me)` **avant** la création de `TriGen` : vérifier en
  phase 2 que la grille et les filtres créés dynamiquement par `TriGen` sont bien journalisés (sinon
  instrumenter après `Update_Req`). Les clics de grille sont rejoués par `TriGen.Coltri_Click`.
- **Caisse** : module complexe (PLAN.md §4.5) ; scénarios à valider avec ceux de `Caisse` et
  dépendants de l'anomalie de harnais `ImageButton` (notes du lot Caisse).
- **T05/T06** : gb.test n'accède qu'au `Public` ; les fonctions pures seront `Public` (ou testées via
  un module d'aide), à décider avec la règle de portée de PLAN.md §6.
- **Implémentation (phase 2, vague 9)** : `.src/Tests/Affichages/TriFactureTest.test`, jeu `Affichages/trifac2_shared/documents`
  (lecture seule ; BL 000510 et 000520 rattachés au ticket T0001 dans `_Setup`). L'écran est instancié comme dans
  `Caisse.Button30_click` (`New TriFacture(Null, TriFacture.BonFacNonPaye, Null, ticket, New LTrans)`), sans affichage ;
  clics de grille par `Bsel = True` puis `TriGen_MajSel(numbl)`, fermeture par `Form_Close()`. Les écritures de
  `Fiches_Bl.numtick` sont faites par la caisse (Caisse, revue manuelle) et ne sont pas couvertes ici. Jeu sans
  document de type P, D, C ni F dans `Fiches_Bl` : les filtres correspondants donnent 0 ligne.
