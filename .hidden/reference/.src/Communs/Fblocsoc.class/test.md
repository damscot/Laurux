# Fblocsoc — Tests

> Source : `.src/Communs/Fblocsoc.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Scénarios lancés depuis `Prgm` (nom `Blocsoc`) ; on compare la section `[Soc01]` du `Laurux.conf`
de test.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FBLOCSOC-T01 | replay | Blocage avec mot de passe | case cochée, mot de passe `secret`, « Quitter » | `Blocsoc = True`, `BlocsocMdp` = chiffrement de `secret` | `tests/blocage/` | à faire |
| FBLOCSOC-T02 | replay | Blocage sans mot de passe | case cochée, champ vide, « Quitter » puis fermeture de fenêtre | avertissement deux fois ; conf enregistrée quand même (A03 figée) | `tests/sans_mdp/` | à faire |
| FBLOCSOC-T03 | replay | Réouverture | rouvrir après T01 et fermer sans rien saisir | `BlocsocMdp` réécrit vide (A02 figée) | `tests/reouverture/` | à faire |
| FBLOCSOC-T04 | replay | Effet sur le menu principal | conf de T01, relancer Laurux | `Fmenu.Menu26` invisible ; `LauruxConf` : `Nbase` désactivé | `tests/effet_menu/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone non modifié ; la valeur chiffrée dépend seulement
  du texte et de la clé `"Laurux"`.
