# Ttourne — Tests

> Source : `.src/Gestion/option/Ttourne.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI instrumenté par `Utils.Observers(Me)` : tous les tests sont des replays capturés dans
le clone **Laurux non modifié**, puis rejoués sur les deux clones ; le dump normalisé de
`Fiches_tourne` fait foi.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| TTOURNE-T01 | replay | Création d'une tournée | jeu `tournees_base` ; Création → code `T9`, libellé → Valider | `Fiches_tourne` + 1 ligne ; fiche affichée = position mémorisée | `tests/creation/` | à faire |
| TTOURNE-T02 | replay | Création refusée (code existant, code vide) | Création → `T1` → Valider ; puis code vide → Valider ; Annuler | aucune ligne ajoutée ; ballons affichés ; barre restée en validation | `tests/creation_refusee/` | à faire |
| TTOURNE-T03 | replay | Modification du libellé | Modification de `T2` → nouveau libellé → Valider | `tourne` modifié pour `T2` uniquement | `tests/modification/` | à faire |
| TTOURNE-T04 | replay | Annulation | Création → saisie → Annuler ; Modification → saisie → Annuler | dump identique au jeu initial | `tests/annulation/` | à faire |
| TTOURNE-T05 | replay | Navigation et recherche | premier, suivant ×2, précédent, dernier ; Recherche → activer `T1` | lignes `Exec_SQL` identiques ; aucune écriture | `tests/navigation/` | à faire |
| TTOURNE-T06 | replay | Suppression (non implémentée, A04) | Suppression → Valider | dump identique (rien supprimé) | `tests/suppression/` | à faire |
| TTOURNE-T07 | replay | Fermeture en cours de saisie, réponse « Non » (A02) | Création → saisie → fermer la fenêtre → Non → ouvrir un autre écran qui écrit | figer l'état de la transaction (dump après l'autre écran) | `tests/fermeture_non/` | à faire |
| TTOURNE-T08 | replay | Fermeture en cours de saisie, réponse « Oui » (A01) | Modification → fermer → Oui | figer l'erreur « Not enough arguments » (log) | `tests/fermeture_oui/` | à faire |
| TTOURNE-T09 | replay | Première tournée sur table vide (A03) | `Laurux01.sql` (table vide) ; Création → `T1` → Valider | figer le comportement (erreur « Null object » attendue dans `affichedonne`) ; dump : ligne créée | `tests/table_vide/` | à faire |
| TTOURNE-T10 | replay | Onglet statistiques | jeu `tournees_base` + documents de `facturation_base` portant une tournée ; onglet Statistiques sur `T1` | lignes `Exec_SQL` de `Gridvi` identiques | `tests/statistiques/` | à faire |

## Détail des tests

- **Jeu `tournees_base`** : `Laurux01.sql` + `Fiches_tourne` (`T3`, `T1`, `T2`, insérés dans cet
  ordre) ; partagé avec [rechtour](../rechtour.class/test.md). T10 ajoute des BL/factures avec
  `tour_ligbl`/`tour_ligfac` renseignés (dérivé du jeu `facturation_base` d'ObjFac).
- **T07** : la transaction laissée ouverte n'est observable qu'à travers les écritures suivantes
  de la session ; le scénario enchaîne donc un autre écran qui écrit (par exemple `Mreglement`) et
  compare le dump final. Comportement à figer tel quel.
- **T08/T09** : tests de caractérisation d'erreurs d'exécution ; le harnais doit accepter le
  message d'erreur Gambas affiché (à adapter selon la gestion des erreurs du replay).
- **Cas non testables** : la réentrance de `Me.Close` dans `form_Close` (comportement interne
  Gambas).
