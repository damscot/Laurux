# Cielcorsp — Tests

> Source : `.src/Compta/Cielcorsp.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Replays sur MariaDB Docker, critère = dump normalisé de `Ciel_Lrx` (et existence des tables
créées par `Utils.Ciel`).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CIELCORSP-T01 | replay | Première ouverture | base sans tables Ciel | `Ciel_Lrx`, `Ciel_Lrx_Jo`, `imp_ciel` créés ; liste vide | `tests/premiere_ouverture/` | à faire |
| CIELCORSP-T02 | replay | Ajout d'une correspondance client | F1, choix d'un 411xxx, saisie Ciel `411DUPONT`, Ajouter | ligne `Ciel_Lrx` (`Cciel`, `Clrx`, `Intitule` = intitulé Laurux) | `tests/ajout_client/` | à faire |
| CIELCORSP-T03 | replay | Liste fournisseurs | `RadioButton2`, F1 | liste des comptes `type_cc = 'F'` (capture) | `tests/liste_fournisseurs/` | à faire |
| CIELCORSP-T04 | replay | Doublons | même code Ciel, puis même compte Laurux | message d'erreur, base inchangée | `tests/doublons/` | à faire |
| CIELCORSP-T05 | replay | Compte Laurux inexistant ou vide | `CptLrx` = `999999` puis vide | avertissement adapté, base inchangée | `tests/compte_inconnu/` | à faire |
| CIELCORSP-T06 | replay | Suppression | `Suppr` sur une ligne ; double-clic sur une autre puis Quitter | les deux correspondances supprimées (A01 figée) | `tests/suppression/` | à faire |
| CIELCORSP-T07 | gbtest | Ajout pur (après CIELCORSP-005) | base de test, couples valides et doublons | message renvoyé et lignes `Ciel_Lrx` | `tests/ajout_pur/` | à faire |

## Détail des tests

- **Génération des valeurs attendues** : scénarios capturés dans le clone **Laurux non modifié**,
  rejoués dans les deux clones, dumps comparés.
- **Données** : `Laurux01.sql` (comptes 411/401 existants).
- **Mutualisation** : les mêmes scénarios, adaptés aux journaux, constituent CIELCORSPJ-T01…T06 ;
  après la commonalisation (CIELCORSP-003), les deux séries doivent rester vertes.
- **Non testable automatiquement** : documentation HTML.
