# Materiel — Tests

> Source : `.src/Gestion/Tables/Materiel.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Fiche GUI legacy : les scénarios sont des **replays** (menu Gestion → Matériels, ou bouton
matériel de la fiche article) comparant le dump normalisé de `Fiches_Materiels` (seule table
modifiée) et, pour les historiques, le contenu capturé des listes. Les calculs de prix deviennent
testables en `gbtest` après MATERIEL-007/008.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| MATERIEL-T01 | replay | Création d'un matériel | Nouveau ; code produit `MAT1` (Entrée) ; n° de série `SN001` ; marque (liste) ; type ; PA `100`, frais `10`, coef `1,5` ; Enregistrer (clic) | ligne `Fiches_Materiels` ; états intermédiaires de `B2` figés (A02) | `tests/creation/` | implémenté partiel (Gestion/materiel_creation, jeu materiel_shared/materiel_articles ; saisie des prix et liste des marques non couvertes) |
| MATERIEL-T02 | replay | Ouvrir puis enregistrer sans modification | clic sur `SN010` (jeu dérivé avec `mat_cequ`, `mat_prvt`, `mat_pmp` distincts), Enregistrer | dump : `mat_cequ` ← `mat_four`, `mat_prvt` ← `mat_paht`, `mat_pmp` ← prix de revient (A01 figée) | `tests/ouvrir_enregistrer/` | implémenté (Gestion/materiel_ouvrir_enregistrer, jeu materiel_shared/materiel_base ; A01 figée) |
| MATERIEL-T03 | replay | Chaîne de calcul des prix | sur `SN010` : modifier PA, frais, coef, taux de marque, PV HT, PV TTC, avec arrondis `0,01`, `0,05`, `0,10`, `0,50`, `1,00` et `nbd` = 2 puis 3 | valeurs affichées après chaque zone et dump final | `tests/calcul_prix/` | implémenté partiel (Gestion/materiel_calcul_prix : PA, frais, coef, PV TTC ; variantes d'arrondi et nbd 3 à faire) |
| MATERIEL-T04 | replay | Contrôles de saisie | article non stocké, non matériel, suspendu, fournisseur absent (A07) ; n° de série en double ; matériel divers en double (A12) ; marque vide | messages ; aucune écriture ou état figé | `tests/controles/` | implémenté partiel (Gestion/materiel_controles : non stocké, non matériel, série en double ; suspendu, A07, A12, marque vide à faire) |
| MATERIEL-T05 | replay | Suppression | matériel dont le n° de série figure en `code_ligbl` d'un BL ; matériel libre ; Nouveau puis Supprimer | refus ; `DELETE` ; vidage de la fiche | `tests/suppression/` | implémenté (Gestion/materiel_suppression : matériel libre, Nouveau puis Supprimer ; Gestion/materiel_suppression_refus, jeu materiel_refus : refus BL) |
| MATERIEL-T06 | replay | Historique des ventes et interventions | `SN010` vendu par BL puis facture, avec deux bons d'entretien `Fiches_BlM` et une facture `Fiches_HistoFacM` ; bouton historique ventes ; Entrée sur chaque ligne | contenu de `Colventes` (un seul bon `BlM`, A06) et de `Colrcp3` ; commentaire `Fiches_HisentMat` | `tests/histo_ventes/` | à faire : jeu lourd (BL, facture, bons BlM, HistoFacM) non créé faute de temps |
| MATERIEL-T07 | replay | Historique des achats | `SN010` reçu par `R0001` ; bouton historique achats ; clic sur la réception | contenu de `Colachat`, `Colrcp2`, total | `tests/histo_achats/` | xfail : Colachat_click.2454 Type mismatch (Val d'un décimal), code 125 figé (Gestion/materiel_histo_achats, jeu materiel_achats) |
| MATERIEL-T08 | replay | Tri, filtre et radios | clic/double clic sur chaque en-tête, saisie `SN`, `*01` sur série, retour arrière ; radio « non vendus » ; focus et saisie dans une zone du panneau de détail (A03) | ordre et contenu de `colmat` | `tests/tri_filtre/` | implémenté partiel (Gestion/materiel_tri_filtre : radio non vendus, frappes CO et SE ; doubles clics d'en-tête non rejouables, A03 non couverte) |
| MATERIEL-T09 | replay | Garantie | cocher la garantie, dates de début et de fin par le calendrier, Enregistrer (vendu et non vendu) | `mat_chkgarantie`, `mat_dtevte`, `mat_dateg1` selon le cas ; `DateG2` perdue (A08) | `tests/garantie/` | implémenté (gb.test `MaterielTest.T09GarantieNonVendu`, `T09GarantieVendu` : calendrier remplacé par `Button10_Click`/`ToggleButton4_Click` + `DateChooser1.Value` + `DateChooser1_Activate`, Enregistrer par `TestenrgMat` ; vendu : `mat_chkgarantie`, `mat_dateg1` écrits, `DateG2` perdue (A08) ; non vendu : l'`UPDATE` n'écrit ni `mat_chkgarantie` ni `mat_dateg1`, garantie perdue (candidat, à rattacher à A08)) |
| MATERIEL-T10 | gbtest | `ArrondiPrix` et calculs de prix (après MATERIEL-007/008) | TTC `12,48`, `12,43`, `12,20`, `12,80`, `12,26`, `12,76`, `0`, négatif × arrondis × formats `0.00`/`0.000` ; PA/frais/coef/taux | chaînes et Float de référence (identiques à MOVR-T08 sur les cas communs) | `tests/calculs/` | à faire : extraction ArrondiPrix (MATERIEL-007/008) non faite |
| MATERIEL-T11 | replay | Ouverture depuis la fiche article | fiche article `MAT1`, bouton matériel, sélection, fermeture | liste filtrée sur `MAT1` (`Deb`, ordre A04) ; grille des tâches d'`Articles` après retour | `tests/depuis_articles/` | à faire : passe par Articles (écran complexe) |
| MATERIEL-T12 | replay | Sélection du client | onglet client, liste (TriCpt) : sélection ; puis réouverture et annulation | `Cd` renseigné ; ancienne valeur réappliquée après annulation (A09) | `tests/client/` | implémenté (gb.test MaterielModalTest.T12Client : Timer pendant le ShowModal de TriCpt, sélection 411001 puis fermeture sans choix : ancienne valeur réappliquée, A09 figée) |

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
- **Implémentation (phase 2, vague 7)** : module séparé `.src/Tests/Gestion/MaterielModalTest.test` (sélection modale : un Timer du module retrouve la fenêtre de sélection ouverte en ShowModal parmi `Windows` et simule le choix ou la fermeture), distinct du module principal de la classe pour la fusion.
