# GesTar — Tests

> Source : `.src/Gestion/Entrées/GesTar.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Formulaire incrusté dans `commande1` (onglet « Tarifs » de l'écran d'achat) : tous les tests sont
des `replay` qui partent de l'écran d'achat. Tables comparées : `Fiches_Art`, `Fiches_Tarcli`,
`Fiches_TarTypcli`, `Fiches_TarTemp`, `Fiches_EtiProd`, `Fiches_EtiGond`. Valeurs attendues
produites dans le clone **Laurux non modifié** (caractérisation, anomalies comprises).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| GESTAR-T01 | replay | Cascade coefficient → prix | réception, article A1 (TVA 20 %, arrondi 0,01) ; onglet Tarifs ; Coef `1,35` puis `40%` | `Coef`, `Px_HT`, `Px_TTC` affichés (relevés par le replay) | `tests/cascade_coef/` | à faire |
| GESTAR-T02 | replay | Saisie inverse HT / TTC | même ligne : `Px_HT = 12`, puis `Px_TTC = 18` | coefficient recalculé et prix affichés | `tests/saisie_ht_ttc/` | à faire |
| GESTAR-T03 | replay | Tarif par client | ajout client existant (F2 + `TriCpt`), client inexistant, client en double | messages d'erreur ; ligne valide affichée avec les valeurs `*_Ar` | `tests/tarif_client/` | à faire |
| GESTAR-T04 | replay | Tarif par type de client | bouton liste des types, choix au clic, type en double | libellé, coefficient repris de l'article | `tests/tarif_type/` | à faire |
| GESTAR-T05 | replay | Enregistrement immédiat | « Mise à jour des tarifs » cochée sans date ; bouton Enregistrer les tarifs | `Fiches_Art` (prix, coef), `Fiches_Tarcli`, `Fiches_TarTypcli` ; `Fiches_TarTemp` vidé | `tests/enreg_immediat/` | à faire |
| GESTAR-T06 | replay | Tarif temporaire daté | date de mise à jour future ; enregistrement de la réception | lignes `Fiches_TarTemp` (`temp_type` 1/2/3, `dtmaj`, `date`) ; `Fiches_Art` inchangé | `tests/tarif_temporaire/` | à faire |
| GESTAR-T07 | replay | Suppression d'une ligne de tarif | Suppr sur un tarif client existant, enregistrer | ligne barrée ; `Fiches_Tarcli` sans le client | `tests/suppression_tarif/` | à faire |
| GESTAR-T08 | replay | Suppression d'un achat multi-articles | réception de 2 articles avec tarifs temporaires ; Supprimer | `Fiches_TarTemp` : seuls les tarifs du dernier article lu sont supprimés (GESTAR-A01 figée) | `tests/suppression_achat/` | à faire |
| GESTAR-T09 | replay | Prix de revient nul | article à `art_prvt = 0` ; saisie de `Px_HT` | erreur de division (GESTAR-A02 figée) | `tests/prvt_nul/` | à faire |
| GESTAR-T10 | replay | Étiquettes et dernier achat | article `art_etiq` ; réception de 3 unités | `Fiches_EtiProd.nombre` +3, `Fiches_EtiGond` créé ; `art_dpa`, `art_dfour`, `art_ddate` (GESTAR-A03 figée) | `tests/etiquettes/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` + jeu dérivé `tarifs.sql` (fournisseur F1, articles A1 et A2 avec
  prix de revient, un article à `art_prvt = 0`, un article `art_etiq`, 2 clients, 2 types de
  client, un tarif client existant).
- **Horloge** : la date de mise à jour des tarifs et `EnrArt.art_ddate` dépendent de `Now` :
  `faketime`.
- **Comparaison** : dump normalisé des tables listées ; valeurs des colonnes de tarif relevées
  par le replay (T01 à T04).
- **Pas de gb.test** : toute la logique passe par les contrôles des tableaux. Après la
  commonalisation GESTAR-008 (fabrique `PrixVente`), la cascade de prix sera testée en gb.test
  (matrice prix de revient × coefficient × TVA × arrondi), avec les mêmes valeurs que T01.
- **Non testable** : couleur du bouton Enregistrer (vérifiable seulement par capture), fenêtre
  `EtiqRecpt`.
