# Fblocsoc — Tests

> Source : `.src/Communs/Fblocsoc.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Scénarios lancés depuis `Prgm` (nom `Blocsoc`) ; on compare la section `[Soc01]` du `Laurux.conf`
de test.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FBLOCSOC-T01 | replay | Blocage avec mot de passe | case cochée, mot de passe `secret`, « Quitter » | `Blocsoc = True`, `BlocsocMdp` = chiffrement de `secret` | `tests/blocage/` | implémenté (gbtest : Form_Open/Form_Close appelés directement) |
| FBLOCSOC-T02 | replay | Blocage sans mot de passe | case cochée, champ vide, « Quitter » puis fermeture de fenêtre | avertissement deux fois ; conf enregistrée quand même (A03 figée) | `tests/sans_mdp/` | implémenté (avertissements vérifiés par le rejeu ; @Laurux.conf comparé : Blocsoc=-1, BlocsocMdp vide) |
| FBLOCSOC-T03 | replay | Réouverture | rouvrir après T01 et fermer sans rien saisir | `BlocsocMdp` réécrit vide (A02 figée) | `tests/reouverture/` | implémenté (case relue cochée, avertissement à la fermeture ; @Laurux.conf comparé : BlocsocMdp réécrit vide, A02) |
| FBLOCSOC-T04 | replay | Effet sur le menu principal | conf de T01, relancer Laurux | `Fmenu.Menu26` invisible ; `LauruxConf` : `Nbase` désactivé | `tests/effet_menu/` | implémenté (gbtest, partiel : `LauruxConf.Nbase` désactivé ; `Fmenu.Menu26` non vérifié, Fmenu non construit en gb.test) |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone non modifié ; la valeur chiffrée dépend seulement
  du texte et de la clé `"Laurux"`.
- **Implémentation (phase 2)** : `.src/Tests/Communs/FblocsocTest.test` (T01, T04 ; valeurs `assets/FblocsocTest/`) :
  fenêtre construite sans affichage, `Form_Open`/`Form_Close` appelés directement ; mot de passe `secret` →
  `32091B0D1D01`. T04 vérifie `LauruxConf.Nbase` (désactivé si `Blocsoc`) ; `Fmenu.Menu26` n'est pas vérifié.
  Scénarios `assets/fblocsoc_sans_mdp` (T02) et `assets/fblocsoc_reouverture` (T03, jeu `.hidden/Tests/Communs/assets/fblocsoc_reouverture/fblocsoc_conf.sql` :
  `Blocsoc`/`BlocsocMdp` posés dans le blob `conf` de `Fiches_Parametres`, appliqué par `Fmenu` après le test
  de `Menu26`) : les boîtes `Message.Warning` sont vérifiées par le rejeu (Entrée sur `FMessage`), le fichier de
  configuration n'est pas comparé par le runner.
- **Vague 2 bis** : `"fichiers": ["@Laurux.conf"]` ajouté à `fblocsoc_sans_mdp` et `fblocsoc_reouverture` ; attendus
  régénérés, `dump.sql` et `sql.log` inchangés. Une valeur vide (`BlocsocMdp`) n'apparaît pas dans le fichier
  (gb.settings n'écrit pas la clé) : le fichier comparé contient `Blocsoc=-1` sans `BlocsocMdp`.

