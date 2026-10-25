# ImpartParam — Tests

> Source : `.src/Gestion/Stock/Tarifs/ImpartParam.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran d'édition sans logique pure : tests par **replay**, comparaison du dump de
`Fiches_ImpArtDef` et `Fiches_ImpArtDef2`. Fichier d'exemple `tests/<nom>/tarif.csv`
(séparateur `;`) et `tarif.txt` (largeur fixe), 10 lignes.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| IMPARTPARAM-T01 | replay | Création d'une définition séparée | `Btncreer`, nom, fournisseur, famille, fichier `.csv`, onglet 2, ajout de 5 zones (code article, intitulé, prix de base, remise, code-barre) | dump des deux tables | `tests/creation_sep/` | à faire |
| IMPARTPARAM-T02 | replay | Création d'une définition largeur fixe (A03) | idem en mode `Cfix`, 17 zones | dump (fige : zones 16-17 et `posorg` absents) | `tests/creation_fixe/` | à faire |
| IMPARTPARAM-T03 | replay | Déplacement `+`/`-` en mode séparé (A02) | définition de T01, touche `+` puis `-` sur la 2e zone | dump ; erreur SQL éventuelle (caractérisation) | `tests/deplacement_sep/` | à faire |
| IMPARTPARAM-T04 | replay | Déplacement en largeur fixe (A01) | définition de T02, touche `+` | erreur « Out of bounds » (caractérisation), dump | `tests/deplacement_fixe/` | à faire |
| IMPARTPARAM-T05 | replay | Retrait et édition de zone | Suppr sur une zone ; double-clic (`Champs_Activate`) puis ré-enregistrement | dump | `tests/retrait_zone/` | à faire |
| IMPARTPARAM-T06 | replay | Sélection d'une définition existante | liste `TgleBtnFDef` → `DefList_Click` ; saisie directe du n° dans `Cdef` | champs affichés, aucune écriture | `tests/selection/` | à faire |
| IMPARTPARAM-T07 | replay | Suppression d'une définition | `BtnSupprime` + confirmation ; `BtnEffacerList` | dump | `tests/suppression/` | à faire |
| IMPARTPARAM-T08 | replay | Numérotation (A04) | `Btncreer` avec définitions 1, 2, 10 existantes, MySQL puis SQLite | numéro proposé | `tests/numerotation/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone **Laurux non modifié** ; les erreurs (A01, A02)
  sont figées telles quelles (message ou arrêt).
- **Rejeu** : `Utils.Observers(Me)` une fois dans `form_Open`. La grille `Champs` n'a pas de
  `Champs_Click` (`replay_missing`) : n'utiliser que double-clic (`Activate`) et clavier.
  `DefList_Click`, `FamList_Click`, `fourList_Click` sont appelés dynamiquement.
- **Chemin de fichier** : la définition mémorise `adrfic` ; le fichier d'exemple doit être placé
  au même chemin absolu dans les deux clones.
- **Lien avec `Impart`** : les définitions de T01/T02 servent de données aux tests IMPART-T01 à T04.
