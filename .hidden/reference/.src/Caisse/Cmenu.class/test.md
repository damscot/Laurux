# Cmenu — Tests

> Source : `.src/Caisse/Cmenu.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

> ⚠️ **Module complexe (cycle d'ouverture/fermeture de caisse)** : la liste des scénarios
> ci-dessous est **à faire valider par l'utilisateur avant la phase 2** (PLAN.md §0 et §4.5).

Écran GUI sans logique pure exposée : tous les tests sont des `replay`, lancés avec
`./Laurux -p -c <conf de test>` (sauf T12, depuis `Fmenu`). `Utils.Observers(Me)` est appelé une
seule fois dans `_new` : l'écran est rejouable. Comparaisons : dump normalisé de la base
(`Fiches_Caisses` surtout, colonnes `dtefm`/`dteov` masquées), `Laurux.conf` du test (clé
`/Soc01/caisse/Ncai`), présence de `~/Caisse<n>.lock`, code de sortie, messages du journal.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CMENU-T01 | replay | Ouverture en mode `-p` (MySQL) | base `caisse_base`, conf valide | libellés poste/société ; seul SQL : `SET NAMES`, `SELECT` société ; dump inchangé | `tests/ouverture_pos/` | à faire |
| CMENU-T02 | replay | Erreurs de connexion du `_new` | conf absente ; mauvais mot de passe ; base inconnue | message attendu par cas, `LauruxConf` ouvert | `tests/erreurs_connexion/` | à faire |
| CMENU-T03 | replay | « Connexion caisse » refusée | aucune caisse pour le poste ; puis caisse mais `Fiches_ClientCaisse` vide | les deux messages ; `Ouverture` non ouverte | `tests/connexion_refusee/` | à faire |
| CMENU-T04 | replay | « Connexion caisse » acceptée | caisse `1` sur le poste, client caisse présent | `Ouverture` ouverte (suite : OUVERTURE-T03) | `tests/connexion_ok/` | à faire |
| CMENU-T05 | replay | « Fond de caisse » et « Saisie caisse » sans caisse connectée | `Ncai` vide | deux messages d'erreur, aucune fenêtre | `tests/actions_sans_caisse/` | à faire |
| CMENU-T06 | replay | « Saisie caisse » deux fois | `Ncai = "1;1 "` | `Caisse` ouverte puis message « déjà ouverte » | `tests/saisie_double/` | à faire |
| CMENU-T07 | replay | Déconnexion acceptée | caisse `1` connectée (`connecte = 1`, verrou présent) ; « Déconnexion », « Oui » | `connecte = 0`, `vdr_code = ''`, `dtefm` renseigné, verrou supprimé, `Ncai = ""` | `tests/deconnexion_oui/` | à faire |
| CMENU-T08 | replay | Déconnexion refusée puis fermeture sans caisse | « Non » ; puis `Ncai` vide et fermeture | fenêtre maintenue, base inchangée ; puis fermeture sans question | `tests/deconnexion_non/` | à faire |
| CMENU-T09 | replay | Déconnexion d'une caisse école | caisse `3` (`ecole = -1`) ; « Oui » puis « Oui » ; puis variante « Non » | figer `Quit 1` (code de sortie 1, `tkz = 1`, `fndc = 0`, verrou conservé) ; variante « Non » : `Efface = 0`, fermeture suivante sans déconnexion (A04) | `tests/caisse_ecole/` | à faire |
| CMENU-T10 | replay | Accès administrateur protégé | `admin2` = 1 ; `Alt+P`, mot de passe faux puis juste ; `Alt+L` puis mot de passe juste ; `Échap` | message d'erreur ; `Preferences` ouvert dans les deux cas (A03 figée) | `tests/admin_protege/` | à faire |
| CMENU-T11 | replay | Accès administrateur libre | `admin2` = 0 ; `Alt+P`, `Alt+L` ; table sans administrateur | `Preferences`, `DB_Log` ; message « Aucun administrateur » | `tests/admin_libre/` | à faire |
| CMENU-T12 | replay | Ouverture depuis `Fmenu` (Menu332) et titre | mode Gestion, menu « Caisse » | figer : titre de la fenêtre Gestion visible inchangé (A01) ; second appel → message | `tests/depuis_fmenu/` | à faire |
| CMENU-T13 | replay | `F12` attribution des touches | `Start.$tcai` nul puis renseigné | message, puis `Attrib` ouvert | `tests/attribution_touches/` | à faire |
| CMENU-T14 | replay | Mode `-p` sur base SQLite | `Laurux01.sqlite`, `type = sqlite3` | figer le comportement actuel (erreur `SET NAMES`, `LauruxConf`, A02) | `tests/pos_sqlite/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone Laurux **non modifié** (`./Laurux -p -l --logfile …`),
  puis rejouées sur les deux clones ; le dump normalisé fait foi, le diff `Exec_SQL` est informatif.
- **Données** : `Laurux01.sql` ne contient ni caisse, ni vendeur, ni client caisse. Jeu dérivé
  `caisse_base` (commun au lot Caisse) : `Fiches_Caisses` codes `1`, `2` (poste = nom d'hôte du
  conteneur de test) et `3` (`ecole = -1`) ; `Fiches_Vendeurs` codes `1`, `12` et un
  administrateur (`admin = -1`), mots de passe chiffrés par `hexdblKey.crypt("en", …, "Laurux")`
  dans le clone non modifié ; une ligne `Fiches_ClientCaisse`.
- **Environnement** : `HOME` dédié par test (verrous `~/Caisse<n>.lock`, `Laurux.conf`) ; T09
  vérifie le code de sortie du processus (1).
- **Non testable automatiquement** : apparence du survol des boutons (`Obs_Enter`/`Obs_Leave`),
  ouverture de l'aide HTML (`Doc.Open`), tunnel SSH (`/dbase/Con-ssh`).
- T09, T10, T12 et T14 caractérisent des anomalies (A01-A04) ; ils seront mis à jour avec leur
  correction.
