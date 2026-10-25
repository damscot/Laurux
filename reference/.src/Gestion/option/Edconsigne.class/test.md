# Edconsigne — Tests

> Source : `.src/Gestion/option/Edconsigne.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Édition en lecture seule : replays avec comparaison du texte du PDF (`pdftotext`) produit dans le
clone **Laurux non modifié** ; `gbtest` du texte SQL après EDCONSIGNE-002.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EDCONSIGNE-T01 | replay | Par code, détail, valorisé | période de l'exercice, codes `00`-`ZZ` | texte du PDF de référence (A01/A02 figées) | `tests/code_detail/` | à faire |
| EDCONSIGNE-T02 | replay | Par code, cumul | idem, « Détail » décoché | texte du PDF | `tests/code_cumul/` | à faire |
| EDCONSIGNE-T03 | replay | Par client | bornes clients, détail puis cumul | texte du PDF (ruptures par client) | `tests/par_client/` | à faire |
| EDCONSIGNE-T04 | replay | Par fournisseur | bornes fournisseurs, détail puis cumul | texte du PDF | `tests/par_fournisseur/` | à faire |
| EDCONSIGNE-T05 | replay | Sélection vide / date vide | période sans mouvement ; date effacée | aucun PDF ; ballon « Date invalide » | `tests/vide/` | à faire |
| EDCONSIGNE-T06 | gbtest | Texte SQL | 3 modes × détail/cumul (après EDCONSIGNE-002) | 6 requêtes identiques au code initial | `tests/requetes/` | à faire |

## Détail des tests

- **Données** : jeu `option_boisson` + mouvements `Fiches_ligcons` sur une réception (type `E`), un
  BL et une facture historisée, avec des documents de plusieurs lignes (pour figer A02) et des
  identifiants `Fiches_ligcons.code` choisis pour coïncider ou non avec des codes de consigne
  (pour figer A01).
- **Comparaison** : texte du PDF sans la date d'édition (`Format(Now)`), base inchangée (dump
  identique).
- **Non testable** : boutons de recherche sans gestionnaire (aucun effet).
