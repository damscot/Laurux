# Calc — Tests

> Source : `.src/Utils/Calc.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Classe morte, proposée à la suppression (CALC-A01) : aucun test fonctionnel n'est prévu. Le seul
test vérifie que la suppression ne casse pas la compilation ni l'exécution des tests existants.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CALC-T01 | gbtest | Non-régression de la suppression | `gbc3 -agt` puis `./Laurux -T all` après suppression | compilation sans erreur, suite verte | `tests/suppression/` | à faire |

## Détail des tests

- Les comportements défectueux (pourcentage toujours nul, signe initial perdu) ne sont pas figés :
  ils ne sont observables par aucun écran du programme.
- Si l'utilisateur décide de conserver la classe, prévoir des tests gb.test de `calcul`/`Oprt` via
  une instance du formulaire sous affichage virtuel.
