# Carch — Tests

> Source : `.src/Utils/Carch.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CARCH-T01 | gbtest | Compilation sans la classe | suppression de `Carch.class` + `Carch.form` | `gbc3 -agt` sans erreur | `tests/suppression/` | à faire |
| CARCH-T02 | replay | Réglages équivalents via `SetColors` | modifier `/Coul/Facts`, `/Coul/Avs` dans « Couleurs » (`SetColors`) | `Laurux.conf` de référence (mêmes clés) | `tests/setcolors_equivalent/` | à faire |

## Détail des tests

- Seul appelant : `.src/Communs/Fmenu.class:1417` (`Menu156_Click`), menu parent « Etiquettes » dont le `Click` n'est probablement jamais levé (à confirmer) ; deps.py ne le détecte pas (appel `Classe.Show`). Aucun scénario utilisateur ne peut donc l'exercer de manière fiable ; T02 vérifie que la
  fonctionnalité reste disponible par `SetColors` après suppression (comparaison du fichier de
  configuration produit, capturé dans le clone non modifié).
- À confirmer en phase 2 : lancer l'application, cliquer « Etiquettes » dans le menu Gestion et
  vérifier si `Carch` s'ouvre. Si oui, ajouter un replay (double-clic, choix d'une couleur,
  validation, diff de `Laurux.conf`) et requalifier CARCH-A02.
