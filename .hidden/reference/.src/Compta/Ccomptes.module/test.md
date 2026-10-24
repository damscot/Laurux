# Ccomptes — Tests

> Source : `.src/Compta/Ccomptes.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Module GUI en lecture seule, piloté par `FComptes`. Les tests sont des replays de l'écran plan
comptable : critère = lignes `Exec_SQL` (bloquant pour les reworks « sans changement SQL ») et
contenu de la grille ; le dump de la base doit rester identique.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CCOMPTES-T01 | replay | Ouverture et tri croissant (`Deb2`) | `Laurux01.sql` ; ouverture du plan comptable | grille triée par `cast(compte_cc AS char)` ; soldes en `0.00` | `tests/liste_ouverture/` | à faire |
| CCOMPTES-T02 | replay | Recherche par préfixe | saisie `41`, puis `512`, puis un préfixe absent | lignes filtrées ; grille vide pour le préfixe absent | `tests/recherche_prefixe/` | à faire |
| CCOMPTES-T03 | replay | Tri décroissant (`Deb3`) | double-clic sur l'en-tête Code puis Intitulé | ordre inverse ; second double-clic → retour au tri croissant | `tests/tri_decroissant/` | à faire |
| CCOMPTES-T04 | replay | Couleurs de fond | `/Soc01/Coul_fen` à 0 puis à 1 | fond `&HF9F9BD` puis `&HFAFAFA` (capture) | `tests/couleur_fond/` | à faire |
| CCOMPTES-T05 | gbtest | Construction du SQL (après CCOMPTES-007) | `Tab`, `Tri`, `Sel` (dont `Sel` vide et accentué), `bDesc` | chaîne SQL identique à celle capturée dans T01-T03 | `tests/requete_liste/` | à faire |

## Détail des tests

- **Génération des valeurs attendues** : scénarios capturés dans le clone **Laurux non modifié**
  (`Exec_SQL` activé), rejoués dans les deux clones.
- **Données** : `Laurux01.sql` ; pour T02, un jeu dérivé avec quelques comptes `41xxxx` et
  `512xxx` supplémentaires.
- **Non testable automatiquement** : rendu exact des couleurs (T04 se limite à une comparaison de
  capture d'écran sous Xvfb).
