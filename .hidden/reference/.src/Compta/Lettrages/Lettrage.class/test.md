# Lettrage — Tests

> Source : `.src/Compta/Lettrages/Lettrage.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI qui écrit dans `Fiches_Mvt…Mvt5` via `Listextcpt.letcpt` : tests `replay` avec dump
normalisé des tables d'écritures, puis `gbtest` sur les fonctions extraites (LETTRAGE-006/007).
Valeurs attendues produites dans le clone **Laurux non modifié** (caractérisation, anomalies comprises).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| LETTRAGE-T01 | replay | Ouverture et affichage | Menu Lettrage (`Menu51`) ; compte 411 saisi + Entrée ; radios Non lettrées / Lettrées / Toutes ; `Tdate` | contenu de `Colcli`, `Sld`, `Label2` relevés ; aucune écriture en base | `tests/affichage_filtres/` | à faire |
| LETTRAGE-T02 | replay | Lettrage équilibré | facture + règlement de même montant cochés ; `numlot` vide puis lot saisi | `Fiches_Mvt*` : `lettree = 1`, `numlot` (lot aléatoire masqué par la normalisation) | `tests/lettrage_equilibre/` | à faire |
| LETTRAGE-T03 | replay | Lettrage refusé | 2 lignes de montants différents, dont une déjà lettrée (`L` → `*`) | message « Lettrage impossible » ; lignes cochées **délettrées** en base (A01 figée) | `tests/lettrage_refuse/` | à faire |
| LETTRAGE-T04 | replay | Délettrage | lignes lettrées cochées, bouton Délettrer | `lettree = 0`, `numlot` = lot de la dernière ligne cliquée (A03 figée) | `tests/delettrage/` | à faire |
| LETTRAGE-T05 | replay | Navigation et types | boutons premier/précédent/suivant/dernier ; radios Clients/Fournisseurs/Bilan ; F2 (`TriCpt`) | compte affiché à chaque étape ; liste vide → erreur figée (A04) | `tests/navigation/` | à faire |
| LETTRAGE-T06 | replay | Ouverture depuis l'extrait | `Extrait`, compte 401, F4 | fenêtre ouverte sur le compte et le type fournisseur | `tests/depuis_extrait/` | à faire |
| LETTRAGE-T07 | gbtest | `TotalSelection` (après LETTRAGE-007) | cumuls : `"12,50"`/`"0,00"`, `""`, valeurs négatives, cocher/décocher | Float de référence | `tests/total_selection/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` dans MariaDB Docker, plus un jeu dérivé (script SQL) qui crée sur un
  compte 411 lettrable des écritures non lettrées équilibrées et déséquilibrées dans l'exercice de
  `dteclec`, et quelques lignes déjà lettrées.
- **Normalisation** : le lot aléatoire (`Rnd`, 7 chiffres) est remplacé par un jeton stable dans le
  dump (même jeton pour toutes les lignes d'un même lot) ; la date du jour n'intervient pas.
- **Locale** : les replays tournent en `fr_FR.UTF-8` ; le comportement en locale à point décimal
  (A05) est documenté, non testé.
- **Non testable automatiquement** : le son (`Music.Play`) ; le déplacement Haut/Bas éventuellement
  doublé de `Colcli_KeyPress` (vérification visuelle).
- **Couverture visée** : toutes les branches de `affichage` et de `Button5_Click`.
