# ImpartParam — Tests

> Source : `.src/Gestion/Stock/Tarifs/ImpartParam.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran d'édition sans logique pure : tests par **replay**, comparaison du dump de
`Fiches_ImpArtDef` et `Fiches_ImpArtDef2`. Fichier d'exemple `tests/<nom>/tarif.csv`
(séparateur `;`) et `tarif.txt` (largeur fixe), 10 lignes.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| IMPARTPARAM-T01 | replay | Création d'une définition séparée | `Btncreer`, nom, fournisseur, famille, fichier `.csv`, onglet 2, ajout de 5 zones (code article, intitulé, prix de base, remise, code-barre) | dump des deux tables | `tests/creation_sep/` | implémenté (gb.test ImpartParamTest.T01CreationSep : fenêtre non affichée, gestionnaires appelés ; tables et grille) |
| IMPARTPARAM-T02 | replay | Création d'une définition largeur fixe (A03) | idem en mode `Cfix`, 17 zones | dump (fige : zones 16-17 et `posorg` absents) | `tests/creation_fixe/` | implémenté (gb.test ImpartParamTest.T02CreationFixe : 17 zones, seules 15 enregistrées, posorg absents : A03 figée) |
| IMPARTPARAM-T03 | replay | Déplacement `+`/`-` en mode séparé (A02) | définition de T01, touche `+` puis `-` sur la 2e zone | dump ; erreur SQL éventuelle (caractérisation) | `tests/deplacement_sep/` | à faire : touches + / - lues par Key.Code dans Champs_KeyPress (illisible hors événement clavier en gb.test) ; rejeu essayé en vague 7 (Menu245, TgleBtnFDef, DefList_Click, onglet Champs, Focus Champs, Keypress « + »/« - ») : code 0 mais Champs_KeyPress jamais déclenché (aucune requête Fiches_ImpArtDef2), cause non établie (SendKeys vers la ColumnView d'une fenêtre ShowModal) |
| IMPARTPARAM-T04 | replay | Déplacement en largeur fixe (A01) | définition de T02, touche `+` | erreur « Out of bounds » (caractérisation), dump | `tests/deplacement_fixe/` | à faire : touches + / - lues par Key.Code dans Champs_KeyPress (illisible hors événement clavier en gb.test) ; rejeu : Keypress vers Champs sans effet (voir T03) |
| IMPARTPARAM-T05 | replay | Retrait et édition de zone | Suppr sur une zone ; double-clic (`Champs_Activate`) puis ré-enregistrement | dump | `tests/retrait_zone/` | implémenté (gb.test ImpartParamTest.T05RetraitZone : BtnRetirerZone sur la 2e zone, Champs_Activate sur la 1re puis ré-enregistrement ; Suppr par Champs_KeyPress non exercée (Key.Code)) |
| IMPARTPARAM-T06 | replay | Sélection d'une définition existante | liste `TgleBtnFDef` → `DefList_Click` ; saisie directe du n° dans `Cdef` | champs affichés, aucune écriture | `tests/selection/` | implémenté (gb.test ImpartParamTest.T06Selection : TgleBtnFDef puis DefList_Click ; saisie directe du n° dans Cdef non exercée : Cmpt_keypress lit Last.Tag et Key.Code) |
| IMPARTPARAM-T07 | replay | Suppression d'une définition | `BtnSupprime` + confirmation ; `BtnEffacerList` | dump | `tests/suppression/` | à faire : BtnSupprime ouvre Message.Question (bloquant en gb.test) ; partie BtnEffacerList écrite (gb.test ImpartParamTest.T07EffacerList) |
| IMPARTPARAM-T08 | replay | Numérotation (A04) | `Btncreer` avec définitions 1, 2, 10 existantes, MySQL puis SQLite | numéro proposé | `tests/numerotation/` | implémenté (MySQL ; partie SQLite à faire : pas de base SQLite dans le framework) |

## Détail des tests

- **Implémentation (phase 2)** : T08 en gb.test (`.src/Tests/Gestion/ImpartParamTest.test`, `T08Numerotation`) : jeu
  `impartparam_shared/definitions_1_2_10`, fenêtre non affichée, `Btncreer_Click` → Cdef (11 sur MySQL, puis 1 sur
  table vidée).

- **Valeurs attendues** : capturées dans le clone **Laurux non modifié** ; les erreurs (A01, A02)
  sont figées telles quelles (message ou arrêt).
- **Rejeu** : `Utils.Observers(Me)` une fois dans `form_Open`. La grille `Champs` n'a pas de
  `Champs_Click` (`replay_missing`) : n'utiliser que double-clic (`Activate`) et clavier.
  `DefList_Click`, `FamList_Click`, `fourList_Click` sont appelés dynamiquement.
- **Chemin de fichier** : la définition mémorise `adrfic` ; le fichier d'exemple doit être placé
  au même chemin absolu dans les deux clones.
- **Lien avec `Impart`** : les définitions de T01/T02 servent de données aux tests IMPART-T01 à T04.
- **Implémentation (phase 2, vague 7)** : T01, T02, T05, T06, T07 (partie BtnEffacerList) dans `ImpartParamTest` : fenêtre non affichée, contrôles posés par `Object.SetProperty`, gestionnaires publics appelés ; fichier tarif écrit par le test (chemin masqué `<fichier>`).
