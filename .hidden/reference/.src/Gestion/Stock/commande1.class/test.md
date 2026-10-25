# commande1 — Tests

> Source : `.src/Gestion/Stock/commande1.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

**Module complexe** (commandes fournisseurs, réceptions, stock, tarifs, validation) : **cette
liste de scénarios est à faire valider par l'utilisateur avant la phase 2** (PLAN.md §0).

`commande1` est l'écran hôte d'`Achat` et de `GesTar` : les scénarios de saisie de documents
sont déjà décrits dans [Achat/test.md](../../Entrées/Achat.class/test.md) (ACHAT-T01 à T14) et
[GesTar/test.md](../../Entrées/GesTar.class/test.md) ; ils couvrent aussi ce fichier et ne sont
pas dupliqués. Les tests ci-dessous portent sur ce que `commande1` fait seul : sélection,
transitions d'état, réception, validation, transaction, GED, verrous.

Tables comparées par défaut : `Fiches_Entcom`, `Fiches_Ligcom`, `Fiches_Entrecpt`,
`Fiches_Ligrecpt`, `Fiches_Art` (stock, PAMP, prix, `art_dfour`/`art_dpa`/`art_ddate`),
`Fiches_TarTemp`, `Fiches_Tarcli`, `Fiches_TarTypcli`, `Fiches_Parametres` (`dnbr`, `dncom`,
`nvign`), `Fiches_Mvt` (validation comptable), `Docs_Ged`/`Docs_Tag`. L'écran n'appelle pas
`Utils.Observers` : la capture suppose une instrumentation par le harnais ou COMMANDE1-A08.
Valeurs attendues produites dans le clone **Laurux non modifié** (anomalies figées).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| COMMANDE1-T01 | replay | Sélection d'un document | ouverture ; radios « commandes », « BR », « BR validées » ; choix d'une BR | listes (texte de la `TriGen`), document chargé, `$win` désactivée, verrou `DocActif` posé | `tests/c1_selection/` | à faire |
| COMMANDE1-T02 | replay | Réception d'une commande | commande existante → « Réception » ; n° BR vide | n° `dnbr` alloué, réception écrite, commande supprimée, stock/PAMP, `Fiches_Art` (`art_dfour`, `art_dpa`), PDF | `tests/c1_reception/` | à faire |
| COMMANDE1-T03 | replay | Réception avec reliquat | quantité reçue < commandée, reliquat accepté | état figé (ACHAT-A08 : reliquat après `tbl.Delete`) | `tests/c1_reliquat/` | à faire |
| COMMANDE1-T04 | replay | Valider les factures (avec écriture) | BR en état Réception ; date d'écriture ; « Avec écriture comptable » | `ValCom` puis `ValidBR1.Ecritures` : `validee = 1`, `Fiches_Mvt` (voir VALIDBR1-T09) | `tests/c1_valider_compta/` | à faire |
| COMMANDE1-T05 | replay | Valider les factures (sans écriture / abandon) | même BR ; « Sans écriture » puis, sur une autre, « Abandon » | `validee = 2` ; rien pour l'abandon | `tests/c1_valider_sans/` | à faire |
| COMMANDE1-T06 | replay | Suppression d'un document à 3 articles avec tarifs temporaires | relire, Supprimer | document et stock supprimés ; `Fiches_TarTemp` : seuls ceux du dernier article lu supprimés (GESTAR-A01 figée) | `tests/c1_suppression/` | à faire |
| COMMANDE1-T07 | replay | Deux documents dans la même session | enregistrer un document, puis en ouvrir un second et modifier un tarif dans l'onglet Tarifs (« Enregistrer » de `GesTar`) | état actuel figé : `Etarif` ne passe plus au rouge, tarif non enregistré par `Tarif_EnrTar` (A03 à confirmer) | `tests/c1_session/` | à faire |
| COMMANDE1-T08 | replay | Abandon de la saisie des numéros de série | réception d'un article matériel, fenêtre `CreMat` annulée, puis seconde action | état figé : transaction laissée ouverte (A04) | `tests/c1_cremat_abandon/` | à faire |
| COMMANDE1-T09 | replay | Vignette (option boissons) | base `B`, commande d'un article à droits suspendus → Réception ; Valider puis, sur une autre, Abandon | `nvign` +1 ; `Fiches_ligregie` ; abandon : `nvign` inchangé, tables déverrouillées | `tests/c1_vignette/` | à faire |
| COMMANDE1-T10 | replay | Ouverture depuis `ValidBR1`/`Stockmvt` | `New Commande1(Null, num, four, date, Validee)` puis `Reception` ; modification d'une ligne ; Enregistrer | état figé : `Validee` refuse ; `Reception` : comportement avec `$Bval = Null` (A02, erreur probable) | `tests/c1_ouverture_externe/` | à faire |
| COMMANDE1-T11 | replay | GED du bon de réception | fournisseur `fo_copie`, code alphanumérique ; Imprimer en réception | document `Docs_Ged`, tags ; erreur SQL possible sur `tag_def` (A05 figée) | `tests/c1_ged/` | à faire |
| COMMANDE1-T12 | replay | Fermeture avec saisie en cours | lignes saisies ; Quitter, « Non » puis « Oui » ; fermeture de `$win` | écran conservé puis fermé ; verrou libéré | `tests/c1_fermeture/` | à faire |
| COMMANDE1-T13 | replay | Informations de stock | focus sur une ligne d'un article à `art_txconv` renseigné, puis à `art_txconv` vide | textes stock/en commande/à commander ; erreur figée pour `txconv` vide (A07) | `tests/c1_affstk/` | à faire |
| COMMANDE1-T14 | replay | Numéros perdus | création de commande sans n° ni date | `dncom` incrémenté malgré le refus (figé) | `tests/c1_numeros/` | à faire |

## Détail des tests

- **Données** : jeu `achats.sql` d'[Achat](../../Entrées/Achat.class/test.md) + compléments :
  commande à 3 articles avec tarifs temporaires (`Fiches_TarTemp`), fournisseur `fo_copie` avec
  `tag_def` et code alphanumérique, article matériel, article à `art_txconv` vide ; base `B`
  (droits, régie suspendue, `nvign`) pour T09 ; `jrnal5` et comptes pour T04.
- **Configuration** : `/Soc01/prixRecpt` vrai (onglet tarifs visible), GED active pour T11.
- **Horloge** : `faketime` (date du document, `Now` des PDF et des noms de fichiers GED).
- **Comparaison** : dump normalisé ; texte des PDF (`pdftotext`) hors pied de page ; nom de
  fichier GED normalisé (horodatage).
- **Transaction (T08)** : l'état « transaction ouverte » se constate par une seconde action dont
  le résultat dépend du `Rollback`/`Commit` suivant ; à confirmer en phase 2 sur MariaDB.
- **Non testables automatiquement** : `mail` (envoi réel), visualiseur PDF, son, concurrence
  multi-poste des verrous `DocActif`.
- **gbtest** : aucun aujourd'hui (logique liée aux contrôles). Après COMMANDE1-005/006,
  `Totaux` et `VerifieDocument` deviennent testables.
