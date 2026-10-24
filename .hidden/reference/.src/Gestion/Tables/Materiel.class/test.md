# Materiel — Tests

> Source : `.src/Gestion/Tables/Materiel.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Fiche GUI legacy : les scénarios sont des **replays** (menu Gestion → Matériels, ou bouton
matériel de la fiche article) comparant le dump normalisé de `Fiches_Materiels` (seule table
modifiée) et, pour les historiques, le contenu capturé des listes. Les calculs de prix deviennent
testables en `gbtest` après MATERIEL-007/008.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| MATERIEL-T01 | replay | Création d'un matériel | Nouveau ; code produit `MAT1` (Entrée) ; n° de série `SN001` ; marque (liste) ; type ; PA `100`, frais `10`, coef `1,5` ; Enregistrer (clic) | ligne `Fiches_Materiels` ; états intermédiaires de `B2` figés (A02) | `tests/creation/` | à faire |
| MATERIEL-T02 | replay | Ouvrir puis enregistrer sans modification | clic sur `SN010` (jeu dérivé avec `mat_cequ`, `mat_prvt`, `mat_pmp` distincts), Enregistrer | dump : `mat_cequ` ← `mat_four`, `mat_prvt` ← `mat_paht`, `mat_pmp` ← prix de revient (A01 figée) | `tests/ouvrir_enregistrer/` | à faire |
| MATERIEL-T03 | replay | Chaîne de calcul des prix | sur `SN010` : modifier PA, frais, coef, taux de marque, PV HT, PV TTC, avec arrondis `0,01`, `0,05`, `0,10`, `0,50`, `1,00` et `nbd` = 2 puis 3 | valeurs affichées après chaque zone et dump final | `tests/calcul_prix/` | à faire |
| MATERIEL-T04 | replay | Contrôles de saisie | article non stocké, non matériel, suspendu, fournisseur absent (A07) ; n° de série en double ; matériel divers en double (A12) ; marque vide | messages ; aucune écriture ou état figé | `tests/controles/` | à faire |
| MATERIEL-T05 | replay | Suppression | matériel dont le n° de série figure en `code_ligbl` d'un BL ; matériel libre ; Nouveau puis Supprimer | refus ; `DELETE` ; vidage de la fiche | `tests/suppression/` | à faire |
| MATERIEL-T06 | replay | Historique des ventes et interventions | `SN010` vendu par BL puis facture, avec deux bons d'entretien `Fiches_BlM` et une facture `Fiches_HistoFacM` ; bouton historique ventes ; Entrée sur chaque ligne | contenu de `Colventes` (un seul bon `BlM`, A06) et de `Colrcp3` ; commentaire `Fiches_HisentMat` | `tests/histo_ventes/` | à faire |
| MATERIEL-T07 | replay | Historique des achats | `SN010` reçu par `R0001` ; bouton historique achats ; clic sur la réception | contenu de `Colachat`, `Colrcp2`, total | `tests/histo_achats/` | à faire |
| MATERIEL-T08 | replay | Tri, filtre et radios | clic/double clic sur chaque en-tête, saisie `SN`, `*01` sur série, retour arrière ; radio « non vendus » ; focus et saisie dans une zone du panneau de détail (A03) | ordre et contenu de `colmat` | `tests/tri_filtre/` | à faire |
| MATERIEL-T09 | replay | Garantie | cocher la garantie, dates de début et de fin par le calendrier, Enregistrer (vendu et non vendu) | `mat_chkgarantie`, `mat_dtevte`, `mat_dateg1` selon le cas ; `DateG2` perdue (A08) | `tests/garantie/` | à faire |
| MATERIEL-T10 | gbtest | `ArrondiPrix` et calculs de prix (après MATERIEL-007/008) | TTC `12,48`, `12,43`, `12,20`, `12,80`, `12,26`, `12,76`, `0`, négatif × arrondis × formats `0.00`/`0.000` ; PA/frais/coef/taux | chaînes et Float de référence (identiques à MOVR-T08 sur les cas communs) | `tests/calculs/` | à faire |
| MATERIEL-T11 | replay | Ouverture depuis la fiche article | fiche article `MAT1`, bouton matériel, sélection, fermeture | liste filtrée sur `MAT1` (`Deb`, ordre A04) ; grille des tâches d'`Articles` après retour | `tests/depuis_articles/` | à faire |
| MATERIEL-T12 | replay | Sélection du client | onglet client, liste (TriCpt) : sélection ; puis réouverture et annulation | `Cd` renseigné ; ancienne valeur réappliquée après annulation (A09) | `tests/client/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` ne contient aucun matériel. Jeu dérivé (script SQL) : articles
  `MAT1`/`MAT2` (`art_mat = 1`, `art_stocke = 1`, un suspendu, un non stocké), famille avec code
  TVA et compte existants, marques, fournisseur, matériels `SN001`…`SN010` (vendus et non vendus,
  avec garantie), un BL et une facture historisée de vente, deux bons d'entretien `Fiches_BlM`
  (+ lignes `Fiches_LigblM`), une facture `Fiches_HistoFacM` (+ lignes), un commentaire
  `Fiches_HisentMat`, une réception `Fiches_Ligrecpt`.
- **Valeurs attendues** : produites par le même replay dans le clone **Laurux non modifié** ;
  dump normalisé de `Fiches_Materiels` ; listes (`colmat`, `Colventes`, `Colachat`, `Colrcp*`)
  capturées par le harnais. Les anomalies sont figées telles quelles.
- **Locale** : `fr_FR.UTF-8` (formats `nbdec` avec virgule, `Val` localisé).
- **Verrou** : `colmat_Click` dépend de `DocActif.Is_Lock("Reception", …)` : vider la table des
  verrous avant chaque replay.
- **Non testable automatiquement** : photo (`Photos`, fichier image), couleurs de la colonne 0,
  son ; erreurs non interceptées (A07) seulement par un replay qui attend la boîte d'erreur.
