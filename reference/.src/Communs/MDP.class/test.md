# MDP — Tests

> Source : `.src/Communs/MDP.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Boîte modale appelée depuis `Fmenu`/`Fsoc` : les scénarios replay partent d'un menu protégé. Le
résultat observé est l'ouverture (ou non) de l'écran protégé et la valeur de `Start.Motdepasse`
après fermeture (relevée dans le log). `MDP` n'enregistre pas d'observateurs de replay
(`Utils.Observers` absent) : la saisie doit être injectée par le harnais (à valider en phase 2).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| MDP-T01 | replay | Bon mot de passe local | `/Admin = 1`, `/Soc01/MdpPrefs` = chiffrement de `secret` ; `Fmenu` → « Paramètres généraux » ; saisie `secret` + Entrée | `Parametre` ouvert ; `Motdepasse` = `""` après usage | `tests/mdp_local_ok/` | à faire |
| MDP-T02 | replay | Mauvais mot de passe | même conf ; saisie `faux` + Tab | `Message.Error`, aucun écran ouvert | `tests/mdp_local_ko/` | à faire |
| MDP-T03 | replay | Mot de passe global | `AdminG` et `MdpPrefsG` dans les préférences globales ; `Fmenu` → « Préférences Globales » | `Prefs` global ouvert avec le bon mot de passe seulement | `tests/mdp_global/` | à faire |
| MDP-T04 | replay | Fermeture sans saisie | fermeture par le bouton de fenêtre | aucun écran ouvert, `Motdepasse` inchangé | `tests/mdp_annule/` | à faire |
| MDP-T05 | gbtest | `MDP.Verifie` (après MDP-003) | clé chiffrée connue ; saisies exacte, vide, différente ; clé absente | `True`/`False` attendus (clé absente : comportement figé, voir MDP-A01) | `tests/verifie/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone Laurux non modifié avec un `Laurux.conf` de test
  contenant les mots de passe chiffrés par `hexdblKey.Crypt("en", …, "Laurux")`.
- **Non testable automatiquement** : le son d'erreur.
