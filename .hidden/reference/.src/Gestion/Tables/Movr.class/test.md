# Movr — Tests

> Source : `.src/Gestion/Tables/Movr.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Fiche GUI : les scénarios sont des **replays** (menu Gestion → Main-d'œuvre) comparant le dump
normalisé de `Fiches_Mo` (seule table modifiée). Les calculs (TTC, arrondi, marge) deviennent
testables en `gbtest` après la séparation traitement/GUI (MOVR-005/006/007).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| MOVR-T01 | replay | Création d'une MO au temps | code `05`, désignation, famille `10`, fournisseur `401001`, taux `2`, prix de revient `15`, temps `1,5` ; Enregistrer | ligne `Fiches_Mo` (`mo_tempmont = "1"`, `mo_valeurht = 0`, marge calculée) | `tests/creation_temps/` | implémenté |
| MOVR-T02 | replay | Création d'un forfait et arrondis | code `06`, mode forfait, HT `35` puis combo `0,05`, `0,10`, `0,50`, `1,00` ; saisie TTC `41,23` | `mo_valeurht`, `mo_valeurttc`, `mo_cdarr` enregistrés ; valeurs affichées à chaque étape | `tests/forfait_arrondis/` | implémenté (valeurs enregistrées seulement ; valeurs affichées à chaque étape non capturées) |
| MOVR-T03 | replay | Modification depuis la grille | clic sur `04`, nouvelle désignation et prix de revient, Enregistrer | dump identique hors colonnes modifiées | `tests/modif_grille/` | implémenté |
| MOVR-T04 | replay | Saisie manuelle d'un code existant | taper `04` (forfait) dans le code, Tab jusqu'au bout, Enregistrer | état actuel figé : `mo_tempmont`, `mo_valeurht`, `mo_prvt`, `mo_crst` écrasés (A01) | `tests/code_manuel/` | implémenté (A01 figé) |
| MOVR-T05 | replay | Suppression | MO présente dans un BL (`typel_ligbl = 'M'`) puis MO non utilisée ; réponse Non | refus ; suppression ; rafraîchissement après Non | `tests/suppression/` | implémenté |
| MOVR-T06 | replay | Listes et contrôles de zones | F2 sur fournisseur, famille (avec et sans saisie), taux ; Entrée et clic ; famille/fournisseur/taux inexistants | zones remplies ; messages « n'existe pas » ; erreur SQL figée sur la famille filtrée (A05) | `tests/listes/` | à faire : F2 non rejouable ; boîtes ouvertes depuis un LostFocus (Famman/Fourman/TxMoMan) |
| MOVR-T07 | replay | Tri et filtre de la grille | clic et double clic sur chaque en-tête, saisie `0`, retour arrière, Échap/F2 (agrandissement) | ordre et contenu de `Colmo` (capture des cellules) | `tests/tri_filtre/` | à faire : clic et double clic d'en-tête, Échap/F2 non rejoués ; contenu de grille non comparé |
| MOVR-T08 | gbtest | `ArrondiPrix` et `MargeMo` (après MOVR-005/006/007) | TTC `12,48`, `12,43`, `12,20`, `12,80`, `12,26`, `12,76`, `0`, négatif × arrondis `0,01`…`1,00` ; marges temps/forfait (taux `0`) | chaînes et Float de référence | `tests/calculs/` | à faire : attend l'extraction MOVR-005/006/007 (arrondi, Calc_MargeMo non publics hors GUI) |
| MOVR-T09 | replay | Ouverture depuis la facturation | F4 dans la zone MO d'un BL, création d'une MO, fermeture | MO créée ; écran de facturation inchangé (grille non corrompue par `Utils.rs1`) | `tests/depuis_facture/` | à faire : passe par Facture (écran complexe exclu) et F4 non rejoué |

## Détail des tests

- **Assets (phase 2)** : `.hidden/Tests/Gestion/assets/movr_creation_temps/` (T01), `movr_forfait_arrondis/` (T02),
  `movr_modif_grille/` (T03), `movr_code_manuel/` (T04), `movr_suppression/` (T05, jeu
  `movr_shared/movr_bl_mo01.sql` : ligne de BL `M` sur la MO `01`). Date figée 2018-06-15.

- **Données** : `Laurux01.sql` (MO `01`-`04`, taux `1`-`3`, famille `10`, fournisseur `401001`) ;
  jeu dérivé pour T05/T09 : un BL non facturé avec une ligne `M` sur la MO `01`.
- **Valeurs attendues** : produites dans le clone **Laurux non modifié** (dump de `Fiches_Mo`,
  valeurs affichées capturées par le replay) ; T08 réutilise les sorties de `arrondi` et
  `Calc_MargeMo` capturées par un replay instrumenté avant le rework.
- **Locale** : `fr_FR.UTF-8` imposée (formats `0.00` avec virgule, `Utils.cpoint`).
- **Non testable automatiquement** : couleurs de la colonne 0 (`/Coul/Motps`, `/Coul/Momnt`), son,
  contenu graphique de l'onglet statistiques (`Gridvi`).
