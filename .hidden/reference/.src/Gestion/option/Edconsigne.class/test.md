# Edconsigne — Tests

> Source : `.src/Gestion/option/Edconsigne.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Édition en lecture seule : replays avec comparaison du texte du PDF (`pdftotext`) produit dans le
clone **Laurux non modifié** ; `gbtest` du texte SQL après EDCONSIGNE-002.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EDCONSIGNE-T01 | replay | Par code, détail, valorisé | période de l'exercice, codes `00`-`ZZ` | texte du PDF de référence (A01/A02 figées) | `tests/code_detail/` | implémenté (gb.test EdconsigneTest.T01CodeDetail, jeu edconsigne_shared/edconsigne_mvt : requête journalisée, lignes renvoyées (A01 : codes = identifiants Fiches_ligcons), PDF produit et nombre de pages ; texte gb.report non extractible par pdftotext) |
| EDCONSIGNE-T02 | replay | Par code, cumul | idem, « Détail » décoché | texte du PDF | `tests/code_cumul/` | implémenté (gb.test EdconsigneTest.T02CodeCumul : cumul doublé par la réception de 2 lignes, A02 figée) |
| EDCONSIGNE-T03 | replay | Par client | bornes clients, détail puis cumul | texte du PDF (ruptures par client) | `tests/par_client/` | implémenté (gb.test EdconsigneTest.T03ParClient : détail puis cumul, client connu et inconnu) |
| EDCONSIGNE-T04 | replay | Par fournisseur | bornes fournisseurs, détail puis cumul | texte du PDF | `tests/par_fournisseur/` | implémenté (gb.test EdconsigneTest.T04ParFournisseur : détail (ligne doublée, A02) puis cumul, fournisseur inconnu) |
| EDCONSIGNE-T05 | replay | Sélection vide / date vide | période sans mouvement ; date effacée | aucun PDF ; ballon « Date invalide » | `tests/vide/` | implémenté (sélection vide ; date effacée : à faire, ballon sur LostFocus) |
| EDCONSIGNE-T06 | gbtest | Texte SQL | 3 modes × détail/cumul (après EDCONSIGNE-002) | 6 requêtes identiques au code initial | `tests/requetes/` | implémenté (gb.test EdconsigneTest.T06Requetes : texte SQL des 6 combinaisons relu dans le journal Exec_SQL, sans attendre EDCONSIGNE-002) |

## Détail des tests

- **Données** : jeu `option_boisson` + mouvements `Fiches_ligcons` sur une réception (type `E`), un
  BL et une facture historisée, avec des documents de plusieurs lignes (pour figer A02) et des
  identifiants `Fiches_ligcons.code` choisis pour coïncider ou non avec des codes de consigne
  (pour figer A01).
- **Comparaison** : texte du PDF sans la date d'édition (`Format(Now)`), base inchangée (dump
  identique).
- **Non testable** : boutons de recherche sans gestionnaire (aucun effet).
- **Implémentation (phase 2)** : `.hidden/Tests/Gestion/assets/edconsigne_vide/` (T05, partie « période sans
  mouvement » : menu dynamique `suivcons` sous Menu66 › Menu77, conf `/Soc01/bois = True`, jeu
  `consigne_shared/consigne_base`, `compare_sql_log` ordered, `~/tmp/consigne.pdf` absent). T01-T04 : édition gb.report
  (pdftotext rend un texte vide) et jeu de réceptions consignées à construire : non commencés.
- **Implémentation (phase 2, vague 7)** : T01-T04, T06 dans `.src/Tests/Gestion/EdconsigneTest.test`, jeu `edconsigne_shared/edconsigne_mvt` (réceptions R1 de 2 lignes et R2 d'un fournisseur inconnu, BL BL0001 de 2 lignes, facture F00001 d'un client inconnu reprise par BL0002) : requête relue dans le journal Exec_SQL, lignes renvoyées par cette requête (données de l'édition), PDF produit et nombre de pages ; le texte d'une édition gb.report n'est pas extrait par pdftotext et `$rep` est privé (pas de parcours de `Children`).
