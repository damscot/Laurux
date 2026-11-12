# Ccomptes — Tests

> Source : `.src/Compta/Ccomptes.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Module GUI en lecture seule, piloté par `FComptes`. Les tests sont des replays de l'écran plan
comptable : critère = lignes `Exec_SQL` (bloquant pour les reworks « sans changement SQL ») et
contenu de la grille ; le dump de la base doit rester identique.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CCOMPTES-T01 | replay | Ouverture et tri croissant (`Deb2`) | `Laurux01.sql` ; ouverture du plan comptable | grille triée par `cast(compte_cc AS char)` ; soldes en `0.00` | `tests/liste_ouverture/` | implémenté (gb.test `.src/Tests/Compta/CcomptesTest.test`) |
| CCOMPTES-T02 | replay | Recherche par préfixe | saisie `41`, puis `512`, puis un préfixe absent | lignes filtrées ; grille vide pour le préfixe absent | `tests/recherche_prefixe/` | implémenté (gb.test `.src/Tests/Compta/CcomptesTest.test`) |
| CCOMPTES-T03 | replay | Tri décroissant (`Deb3`) | double-clic sur l'en-tête Code puis Intitulé | ordre inverse ; second double-clic → retour au tri croissant | `tests/tri_decroissant/` | implémenté (gb.test `.src/Tests/Compta/CcomptesTest.test`) (appel direct de Deb3 : double-clic d'en-tête non rejouable) |
| CCOMPTES-T04 | replay | Couleurs de fond | `/Soc01/Coul_fen` à 0 puis à 1 | fond `&HF9F9BD` puis `&HFAFAFA` (capture) | `tests/couleur_fond/` | à faire : couleurs posées dans l'événement Data de la grille (non déclenché sans affichage), rendu non comparé |
| CCOMPTES-T05 | gbtest | Construction du SQL (après CCOMPTES-007) | `Tab`, `Tri`, `Sel` (dont `Sel` vide et accentué), `bDesc` | chaîne SQL identique à celle capturée dans T01-T03 | `tests/requete_liste/` | implémenté (gb.test `.src/Tests/Compta/CcomptesTest.test`) (résultat des requêtes, sans extraction CCOMPTES-007) |

## Détail des tests

- **Génération des valeurs attendues** : scénarios capturés dans le clone **Laurux non modifié**
  (`Exec_SQL` activé), rejoués dans les deux clones.
- **Données** : `Laurux01.sql` ; pour T02, un jeu dérivé avec quelques comptes `41xxxx` et
  `512xxx` supplémentaires.
- **Non testable automatiquement** : rendu exact des couleurs (T04 se limite à une comparaison de
  capture d'écran sous Xvfb).
- **Implémentation (phase 2)** : T01, T02, T03, T05 en gb.test (`CcomptesTest`) : `Deb2`…`Deb9` et `Tris` appelés sur une
  GridView non affichée ; relevé de `Utils.rs3` (nombre, 5 premières lignes et dernière) et du nombre de lignes de la
  grille. Jeu `.hidden/Tests/Compta/assets/CcomptesTest/ccomptes_comptes.sql` (416100, 418100, 512100, 512200 dont un
  intitulé accentué). T03 : le double-clic d’en-tête (non rejouable) est remplacé par l’appel direct de `Deb3`.
