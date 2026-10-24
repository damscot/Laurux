# Fmenu — Tests

> Source : `.src/Communs/Fmenu.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Fenêtre principale : presque tout passe par des scénarios **replay** lancés sans `-p`. Le résultat
comparé est, selon le test, le dump normalisé de la base, le fichier `Laurux.conf` de test (passé
par `-c`) et la liste des fenêtres ouvertes / messages affichés relevée dans le log. Les menus sont
rejoués par `ReplayObserver` (`Menu.Value = True`, `Utils.module:976` parcourt `Fmenu.Menus`).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FMENU-T01 | replay | Démarrage et visibilité des menus | `Laurux01.sql` ; deux `Laurux.conf` : options société toutes actives (`Exp`, `Btq`, `Materiel`, `Caisse`, `Taches`, `Blocsoc`, `Lcr`, `Vendeurs`, `Faca`, `Sms`, `Slide`) puis toutes inactives | dump de la propriété `Visible` des menus pilotés (liste dans architecture.md) ; titre de fenêtre ; `/Fecran` après rotation ; log `Exec_SQL` du démarrage (y compris le `Shell mysql`) | `tests/demarrage_options/` | à faire |
| FMENU-T02 | replay | Rappels de promotion | jeu dérivé : `Fiches_Promo` avec une promotion débutant et une finissant à la date du jour (date système figée, `faketime`) | deux `Message.Info` et deux lignes `Syntheses` ; aucune écriture | `tests/demarrage_promos/` | à faire |
| FMENU-T03 | replay | Tarifs différés au démarrage | jeu dérivé : lignes `Fiches_TarTemp` échues (`dtmaj = 1`, `date <= maintenant`) et non échues | dump `Fiches_Art`, `Fiches_TarTemp` (et tables écrites par `DateTar.EnrTouTar`) | `tests/demarrage_tartemp/` | à faire |
| FMENU-T04 | replay | Factures périodiques (`Abonnement`) | `/Faca = 1` ; jeu dérivé `Fiches_Bl` type `A` × `cli_aban` (5 périodicités + sans `dtefac`) ; date figée au 15 janvier, 15 juin et 31 décembre | nombre annoncé dans `Message.Info` (anomalies A01/A02 figées) | `tests/abonnement/` | à faire |
| FMENU-T05 | gbtest | `NbFacturesPeriodiques` (après FMENU-010) | mêmes cas que T04, résultat SQL simulé et date passée en paramètre | nombre de factures dues par cas | `tests/abonnement_calcul/` | à faire |
| FMENU-T06 | replay | Tâches de l'utilisateur | `/Taches = 1` ; `Fiches_Taches` avec 0, 1 et 3 tâches pour l'utilisateur courant ; touche sur la grille, réponse Oui puis Non | visibilité de `Panel2` (A05 figée), contenu de la grille, dump `Fiches_Taches` après suppression | `tests/taches/` | à faire |
| FMENU-T07 | replay | Navigation « Paramètres » et « ? » | chaque entrée de la carte de navigation (ouverture puis fermeture de l'écran), y compris `Menu331` | fenêtre ouverte attendue par entrée (classe), aucune écriture en base | `tests/navigation_parametres/` | à faire |
| FMENU-T08 | replay | Navigation « Gestion » | idem, menus `Menu66` et descendants ; `Menu42`/`Menu193` avec et sans vendeurs | classe de la fenêtre ouverte par entrée ; dump base inchangé | `tests/navigation_gestion/` | à faire |
| FMENU-T09 | replay | Navigation « Caisse » | `/Caisse = 1` ; entrées `Menu203` et descendants ; `Menu332` ouvert deux fois | fenêtres ouvertes ; avertissement « Une interface de caisse est déjà ouverte! » | `tests/navigation_caisse/` | à faire |
| FMENU-T10 | replay | Navigation « Comptabilité » | entrées `Menu67` et descendants | fenêtres ouvertes ; dump inchangé | `tests/navigation_compta/` | à faire |
| FMENU-T11 | replay | Navigation « Base » et « Agenda » | entrées `Menu55`, `Menu200` (sauf restauration et nouvelle base, testées avec `FRestore`/`LauruxConf`) | fenêtres ouvertes (`FSauve`, `Expbase`, `DB_Sanity`, `DB_Log`, `Agenda`) | `tests/navigation_base/` | à faire |
| FMENU-T12 | replay | Accès administrateur | `/Admin = 1`, `MdpPrefs` chiffré connu ; `AdminG` + `MdpPrefsG` en global ; bon puis mauvais mot de passe sur les 8 menus protégés et `Menu329` | écran ouvert seulement avec le bon mot de passe ; `Start.Motdepasse` remis à `""` | `tests/acces_admin/` | à faire |
| FMENU-T13 | replay | Réplication en échec | `/dbase/Con-ssh = 1`, `Replique = 1`, `Breplique = 1`, commande `mysql` factice dans le `PATH` (pas de « Yes ») ; les 14 menus contrôlés + `lblFacfm`/`lblClm` | `Message.Error` attendu et aucun écran ouvert pour les menus ; écrans ouverts pour les libellés (A10 figée) | `tests/replication_ko/` | à faire |
| FMENU-T14 | replay | Réinitialisation des préférences | `Laurux.conf` provoquant le `Catch` de `Form_Open` (base inexistante), choix « Réinitialisation Péférences » | diff de `Laurux.conf` (chaînes à virgules A03 figées) ; fin de l'application | `tests/preferences_defaut/` | à faire |
| FMENU-T15 | replay | Fermeture | fermeture par `Menu118` puis par `ToolButton1` ; `~/tmp` du `HOME` de test peuplé ; `/Sauvauto` 0 puis 1 | `/Soc<XX>/Ecran` dans la conf ; contenu de `~/tmp` (A14) ; sauvegarde créée ou non | `tests/fermeture/` | à faire |
| FMENU-T16 | replay | Raccourcis barre d'outils et libellés | clic sur chaque `ToolButton` et chaque `lbl*` | même fenêtre que le menu équivalent (tableau d'architecture.md) ; les libellés nécessitent `xdotool`/`ydotool` (sinon test manuel) | `tests/raccourcis/` | à faire |
| FMENU-T17 | replay | Visibilité modifiée depuis les préférences | `Menu110` → `Prefs`, bascule des options `Exp`, `Btq`, `Materiel`, `Caisse`, validation | `Visible` des menus de la fenêtre principale **avant redémarrage** (A13 figée) et après redémarrage | `tests/prefs_menus/` | à faire |
| FMENU-T18 | replay | Plein écran | `F11` deux fois | `Me.FullScreen` vrai puis faux | `tests/plein_ecran/` | à faire |
| FMENU-T19 | replay | Rendez-vous | table `Cbase.Table("TabAgenda")` (jeu dérivé) avec un rendez-vous à l'heure figée pour l'utilisateur courant ; attente d'un tick de `Timer1` (60 s) | rappel affiché par `AffRdv` | `tests/timer_rdv/` | à faire |
| FMENU-T20 | replay | Erreurs de démarrage | conf sans base, base inexistante, mauvais mot de passe MySQL | message du `Catch` selon le cas, dialogue de choix, `Quit` | `tests/demarrage_erreurs/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone **Laurux non modifié** (`./Laurux -l --logfile …
  -c <conf de test>`), base MariaDB jetable restaurée depuis `Laurux01.sql` ou un jeu dérivé
  (`tests/<nom>/*.sql`). Les anomalies (A01 à A14) sont figées telles quelles.
- **Date système** : T02, T04 et T19 dépendent de `Now` ; ils tournent sous `faketime` (dates
  listées dans chaque répertoire). Le dump masque les colonnes horodatées.
- **Démarrage** : `Form_Open` exécute `LauruxMaj.Verif_Version` ; la base de test doit être à la
  version courante (3.69) pour que le dump ne contienne pas de migration.
- **Carte de navigation** : T07 à T11 sont générés à partir du tableau d'architecture.md
  (`gen_input.py` produit la liste « menu → classe attendue ») ; `check_output.py` compare la
  classe de la fenêtre active relevée dans le log. Ces tests servent de **socle** aux replays des
  autres écrans.
- **Non testable automatiquement** : le rendu (image de fond, survol `OBS_Enter`/`OBS_Leave`), le
  son, le tunnel SSH réel (T13 utilise une commande `mysql` factice), le `Shell mysql … global
  sql_mode` (vérifié seulement dans le log, A07).
- **Couverture visée** : tous les handlers atteignables ; les 6 handlers inatteignables (A12) et
  les 2 handlers sans contrôle (FMENU-002) ne sont pas couverts par construction.
