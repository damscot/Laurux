# Cmo — Tests

> Source : `.src/Utils/Cmo.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CMO-T01 | gbtest | Compilation sans la classe | suppression de `Cmo.class` + `Cmo.form` | `gbc3 -agt` sans erreur | `tests/suppression/` | à faire |
| CMO-T02 | replay | Réglages équivalents via `SetColors` | modifier `/Coul/Motps`, `/Coul/Momnt` dans « Couleurs » (`SetColors`) | `Laurux.conf` de référence (mêmes clés) | `tests/setcolors_equivalent/` | à faire |

## Détail des tests

- Aucun appelant : les occurrences de `Cmo` dans `Facture.class` (l.1402-3122) visent le `TextBox` `Cmo` de `Facture.form:631`. deps.py ne s'y trompe pas. Aucun scénario utilisateur ne peut donc l'exercer de manière fiable ; T02 vérifie que la
  fonctionnalité reste disponible par `SetColors` après suppression (comparaison du fichier de
  configuration produit, capturé dans le clone non modifié).
