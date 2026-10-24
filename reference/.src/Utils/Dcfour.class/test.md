# Dcfour — Tests

> Source : `.src/Utils/Dcfour.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| DCFOUR-T01 | replay | Doublons | jeu dérivé : 3 articles même `art_cfour`, 2 autres même `art_cfour`, 1 unique | `~/Doublon.txt` de référence (groupes répétés, figé) | `tests/doublons/` | à faire |
| DCFOUR-T02 | replay | Aucun doublon | `Laurux01.sql` sans doublon | fichier vide ouvert, « Traitement terminé. » | `tests/sans_doublon/` | à faire |
| DCFOUR-T03 | replay | Table vide | `Fiches_Art` vide | « Il n'existe aucun doublon. » | `tests/table_vide/` | à faire |

## Détail des tests

- Capture dans le clone **Laurux non modifié** via « Appel programme » → `Dcfour` ; `HOME` de test ;
  éditeur neutralisé (le runner remplace la commande d'édition par un script qui copie le fichier).
- Comparaison du fichier `Doublon.txt` ; diff BDD vide (lecture seule).
