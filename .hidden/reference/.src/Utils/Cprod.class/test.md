# Cprod — Tests

> Source : `.src/Utils/Cprod.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CPROD-T01 | gbtest | Compilation sans la classe | suppression de `Cprod.class` + `Cprod.form` | `gbc3 -agt` sans erreur | `tests/suppression/` | à faire |
| CPROD-T02 | replay | Réglages équivalents via `SetColors` | modifier `/Coul/Stk`, `/Coul/Nstk`, `/Coul/Eps`, `/Coul/Spd` dans « Couleurs » (`SetColors`) | `Laurux.conf` de référence (mêmes clés) | `tests/setcolors_equivalent/` | à faire |

## Détail des tests

- Aucun appelant : `grep -rniw cprod .src` ne renvoie que ce fichier. Aucun scénario utilisateur ne peut donc l'exercer de manière fiable ; T02 vérifie que la
  fonctionnalité reste disponible par `SetColors` après suppression (comparaison du fichier de
  configuration produit, capturé dans le clone non modifié).
