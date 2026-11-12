# Fmenu — Tests

> Source : `.src/Communs/Fmenu.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Fenêtre principale : presque tout passe par des scénarios **replay** lancés sans `-p`. Le résultat
comparé est, selon le test, le dump normalisé de la base, le fichier `Laurux.conf` de test (passé
par `-c`) et la liste des fenêtres ouvertes / messages affichés relevée dans le log. Les menus sont
rejoués par `ReplayObserver` (`Menu.Value = True`, `Utils.module:976` parcourt `Fmenu.Menus`).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FMENU-T01 | replay | Démarrage et visibilité des menus | `Laurux01.sql` ; deux `Laurux.conf` : options société toutes actives (`Exp`, `Btq`, `Materiel`, `Caisse`, `Taches`, `Blocsoc`, `Lcr`, `Vendeurs`, `Faca`, `Sms`, `Slide`) puis toutes inactives | dump de la propriété `Visible` des menus pilotés (liste dans architecture.md) ; titre de fenêtre ; `/Fecran` après rotation ; log `Exec_SQL` du démarrage (y compris le `Shell mysql`) | `tests/demarrage_options/` | implémenté (partiel, gb.test : Form_Open appelé sans affichage, options actives puis inactives sauf /Faca ; titre, menus pilotés, Panel2 ; /Fecran et SQL non relevés) |
| FMENU-T02 | replay | Rappels de promotion | jeu dérivé : `Fiches_Promo` avec une promotion débutant et une finissant à la date du jour (date système figée, `faketime`) | deux `Message.Info` et deux lignes `Syntheses` ; aucune écriture | `tests/demarrage_promos/` | à faire : Message.Info modal dans Form_Open, appelé par Show (Start.Lancement) avant la création du timer de rejeu ; essai vague 2 bis (jeu de 2 promotions, /son2 par `conf`) : code 124 après 20 s, seule la 1re ligne Syntheses tracée (pico2wave) ; une surcharge de conf ne lève pas ce blocage (outillage : démarrer le rejeu avant Show)  — bloqué par le harnais : START-A09 (minuteur de rejeu créé après Show), capture : REPLAYOBSERVER-A07 (FMessage non observé) ; résolutions proposées dans ces anomalies, correction différée (décision utilisateur du 2026-11-12) ; essai manuel : `./Laurux -T FMENU-T02` (scénario `fmenu_demarrage_promos`, non validé) |
| FMENU-T03 | replay | Tarifs différés au démarrage | jeu dérivé : lignes `Fiches_TarTemp` échues (`dtmaj = 1`, `date <= maintenant`) et non échues | dump `Fiches_Art`, `Fiches_TarTemp` (et tables écrites par `DateTar.EnrTouTar`) | `tests/demarrage_tartemp/` | implémenté |
| FMENU-T04 | replay | Factures périodiques (`Abonnement`) | `/Faca = 1` ; jeu dérivé `Fiches_Bl` type `A` × `cli_aban` (5 périodicités + sans `dtefac`) ; date figée au 15 janvier, 15 juin et 31 décembre | nombre annoncé dans `Message.Info` (anomalies A01/A02 figées) | `tests/abonnement/` | à faire : même blocage que T02 (Message.Info d'Abonnement dans Form_Open, avant le timer de rejeu) ; /Faca activable par `conf`, mais le nombre annoncé n'est visible que dans la boîte (et dans pico2wave avec /son2, tracé avant le blocage)  — bloqué par le harnais : START-A09 et REPLAYOBSERVER-A07 (voir FMENU-T02) ; jeu de factures périodiques à créer |
| FMENU-T05 | gbtest | `NbFacturesPeriodiques` (après FMENU-010) | mêmes cas que T04, résultat SQL simulé et date passée en paramètre | nombre de factures dues par cas | `tests/abonnement_calcul/` | à faire : nécessite l'extraction FMENU-010 (Abonnement affiche un Message.Info bloquant sous gb.test) |
| FMENU-T06 | replay | Tâches de l'utilisateur | `/Taches = 1` ; `Fiches_Taches` avec 0, 1 et 3 tâches pour l'utilisateur courant ; touche sur la grille, réponse Oui puis Non | visibilité de `Panel2` (A05 figée), contenu de la grille, dump `Fiches_Taches` après suppression | `tests/taches/` | implémenté (partiel : sélection d'une ligne non rejouable ; touche sans sélection → « Bad row index » figée, code 125) |
| FMENU-T07 | replay | Navigation « Paramètres » et « ? » | chaque entrée de la carte de navigation (ouverture puis fermeture de l'écran), y compris `Menu331` | fenêtre ouverte attendue par entrée (classe), aucune écriture en base | `tests/navigation_parametres/` | implémenté |
| FMENU-T08 | replay | Navigation « Gestion » | idem, menus `Menu66` et descendants ; `Menu42`/`Menu193` avec et sans vendeurs | classe de la fenêtre ouverte par entrée ; dump base inchangé | `tests/navigation_gestion/` | implémenté (5 scénarios, échantillon des entrées ; Menu193 avec vendeurs : erreur fatale figée, code 125) |
| FMENU-T09 | replay | Navigation « Caisse » | `/Caisse = 1` ; entrées `Menu203` et descendants ; `Menu332` ouvert deux fois | fenêtres ouvertes ; avertissement « Une interface de caisse est déjà ouverte! » | `tests/navigation_caisse/` | implémenté (partiel : second appel de Menu332 non rejouable, Cmenu devient la fenêtre active) |
| FMENU-T10 | replay | Navigation « Comptabilité » | entrées `Menu67` et descendants | fenêtres ouvertes ; dump inchangé | `tests/navigation_compta/` | implémenté (3 scénarios, 33 entrées) |
| FMENU-T11 | replay | Navigation « Base » et « Agenda » | entrées `Menu55`, `Menu200` (sauf restauration et nouvelle base, testées avec `FRestore`/`LauruxConf`) | fenêtres ouvertes (`FSauve`, `Expbase`, `DB_Sanity`, `DB_Log`, `Agenda`) | `tests/navigation_base/` | implémenté |
| FMENU-T12 | replay | Accès administrateur | `/Admin = 1`, `MdpPrefs` chiffré connu ; `AdminG` + `MdpPrefsG` en global ; bon puis mauvais mot de passe sur les 8 menus protégés et `Menu329` | écran ouvert seulement avec le bon mot de passe ; `Start.Motdepasse` remis à `""` | `.hidden/Tests/Communs/assets/fmenu_acces_admin/`, `.hidden/Tests/Communs/assets/fmenu_acces_admin_complet/` | implémenté (fmenu_acces_admin : Menu110 mauvais, Menu25 bon, 20 s ; fmenu_acces_admin_complet : autres cas, délai 180 s accordé par l'utilisateur le 2026-11-12 ; Menu173 bon mot de passe non couvert : Majversion interroge www.laurux.fr) |
| FMENU-T13 | replay | Réplication en échec | `/dbase/Con-ssh = 1`, `Replique = 1`, `Breplique = 1`, commande `mysql` factice dans le `PATH` (pas de « Yes ») ; les 14 menus contrôlés + `lblFacfm`/`lblClm` | `Message.Error` attendu et aucun écran ouvert pour les menus ; écrans ouverts pour les libellés (A10 figée) | `tests/replication_ko/` | implémenté (partiel : Menu21, Menu22, Menu42, Menu88 ; libellés non rejoués) |
| FMENU-T14 | replay | Réinitialisation des préférences | `Laurux.conf` provoquant le `Catch` de `Form_Open` (base inexistante), choix « Réinitialisation Péférences » | diff de `Laurux.conf` (chaînes à virgules A03 figées) ; fin de l'application | `tests/preferences_defaut/` | à faire : boîtes du Catch de Form_Open avant le démarrage du rejeu (non évitables par `conf` : elles sont l'objet du test)  — bloqué par le harnais : START-A09 (minuteur de rejeu créé après Show), capture : REPLAYOBSERVER-A07 (FMessage non observé) ; résolutions proposées dans ces anomalies, correction différée (décision utilisateur du 2026-11-12) ; essai manuel : `./Laurux -T FMENU-T14` (scénario `fmenu_reinit_preferences`, non validé) |
| FMENU-T15 | replay | Fermeture | fermeture par `Menu118` puis par `ToolButton1` ; `~/tmp` du `HOME` de test peuplé ; `/Sauvauto` 0 puis 1 | `/Soc<XX>/Ecran` dans la conf ; contenu de `~/tmp` (A14) ; sauvegarde créée ou non | `tests/fermeture/` | implémenté (`fmenu_fermeture_menu118`, `fmenu_fermeture_toolbutton1` : /Soc01/Ecran réécrit dans @Laurux.conf, ~/tmp/resultat conservé ou vidé (A14), sauvegarde avec Sauvauto) |
| FMENU-T16 | replay | Raccourcis barre d'outils et libellés | clic sur chaque `ToolButton` et chaque `lbl*` | même fenêtre que le menu équivalent (tableau d'architecture.md) ; les libellés nécessitent `xdotool`/`ydotool` (sinon test manuel) | `tests/raccourcis/` | implémenté (partiel : 8 ToolButton ; clics xdotool sur les libellés sans effet au rejeu) |
| FMENU-T17 | replay | Visibilité modifiée depuis les préférences | `Menu110` → `Prefs`, bascule des options `Exp`, `Btq`, `Materiel`, `Caisse`, validation | `Visible` des menus de la fenêtre principale **avant redémarrage** (A13 figée) et après redémarrage | `tests/prefs_menus/` | à faire : visibilité des menus non comparée au rejeu (couverte pour le démarrage par FMENU-T01 gb.test) |
| FMENU-T18 | replay | Plein écran | `F11` deux fois | `Me.FullScreen` vrai puis faux | `tests/plein_ecran/` | à faire : touche F11 non rejouée ; FullScreen non comparé |
| FMENU-T19 | replay | Rendez-vous | table `Cbase.Table("TabAgenda")` (jeu dérivé) avec un rendez-vous à l'heure figée pour l'utilisateur courant ; attente d'un tick de `Timer1` (60 s) | rappel affiché par `AffRdv` | `.hidden/Tests/Communs/assets/fmenu_timer_rdv/` | implémenté (délai 95 s accordé par l'utilisateur le 2026-11-12) |
| FMENU-T20 | replay | Erreurs de démarrage | conf sans base, base inexistante, mauvais mot de passe MySQL | message du `Catch` selon le cas, dialogue de choix, `Quit` | `tests/demarrage_erreurs/` | à faire : boîtes du Catch de Form_Open affichées avant le démarrage du rejeu (non évitables par `conf` : elles sont l'objet du test)  — bloqué par le harnais : START-A09 (minuteur de rejeu créé après Show), capture : REPLAYOBSERVER-A07 (FMessage non observé) ; résolutions proposées dans ces anomalies, correction différée (décision utilisateur du 2026-11-12) ; essai manuel : `./Laurux -T FMENU-T20` (scénario `fmenu_erreur_demarrage`, non validé) |

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
- **Implémentation (phase 2)** : module gb.test `.src/Tests/Communs/FmenuTest.test` (T01) et scénarios
  `.hidden/Tests/Communs/assets/fmenu_<nom>/` : `demarrage_tartemp` (T03, jeu `fmenu_tartemp`), `taches` (T06, jeu
  `fmenu_taches`), `navigation_parametres` (T07), `navigation_gestion_constantes`, `navigation_gestion_tables`,
  `navigation_gestion_stock`, `navigation_gestion_stats`, `navigation_gestion_vendeurs` (T08, jeu `fmenu_vendeurs`),
  `navigation_caisse` (T09, jeu `fmenu_caisse`), `navigation_compta_constantes`, `navigation_compta_relances`,
  `navigation_compta_editions` (T10), `navigation_base` (T11), `acces_admin` (T12, jeu `fmenu_admin`),
  `replication_ko` (T13, jeu `fmenu_replication`), `raccourcis` (T16). Les options société sont activées par les
  préférences globales (`Fiches_Parametres.conf`), appliquées par `Prefs.ApplyGlobal` après la connexion : elles
  agissent sur ce qui suit dans `Form_Open` (Faca, Taches) et sur les menus, pas sur la visibilité calculée avant.
- **Navigation** : chaque entrée est ouverte puis fermée (`Close`) ; une fenêtre différente de celle attendue fait
  échouer le clic suivant sur Fmenu (code 3). Cadence resserrée (600 ms) pour tenir dans le délai de 20 s.
- **Comportements figés notables** : `Menu193` avec vendeurs → `New ConVendeurs(True)` alors que `ConVendeurs._new`
  n'a pas de paramètre (« Type mismatch: wanted Control, got Boolean ») ; `ColTaches_KeyPress` sans ligne
  sélectionnée → « Bad row index » après la réponse « Oui ».
- **Implémentation (vague 2 bis)** : FMENU-T15 par `fmenu_fermeture_menu118` et `fmenu_fermeture_toolbutton1`
  (`conf` : `/Soc01/Ecran` = 700;500 ; ToolButton1 avec `Sauvauto` = -1, `Maj` = -1, `Rep_Sauv` =
  `/home/laurux/tmp/rejeu/sauve`). `~/tmp` est peuplé par Base › Restauration depuis `/x` (FRestore écrit
  `~/tmp/resultat` puis échoue, Entrée, Quitter). Comparés (`fichiers`) : `tmp/resultat` (présent après Menu118,
  absent après ToolButton1 : FMENU-A14), `@Laurux.conf` (`Ecran` réécrit à 896;632, taille de la fenêtre sous Xvfb),
  `@sauve/Laurux014.sql.gz` (ToolButton1). `--replay-exit` quitte sans `form_close` : la fermeture doit être rejouée.
  T02/T04/T14/T20 restent bloqués : un `Message.*` de `Form_Open` s'exécute pendant `Object.Call(Menu, "Show")`
  (`Start.Lancement`), avant la création du timer de rejeu ; la surcharge `conf` ne change pas cet ordre.

- **FMENU-T19 (vague 2 bis, délais)** : scénario `fmenu_timer_rdv`, jeu `fmenu_timer_rdv` (rendez-vous de « laurux » à
  10h01 le 2026-01-15, un à 11h30, un d'un autre utilisateur à 10h01), date 10:00:10, `conf` `/son2` = -1,
  `fichiers` `@outils.trace`. Le rejeu ramène à 1 s tout écart de plus de 20 s : l'attente du tick (60 s après la
  création de Fmenu) est faite de clics sur le menu « ? » (`Menu20`) espacés de 11 à 19 s, la réponse au
  `Message.Warning` (Espace) partant 66 s après le premier clic. Ne pas lancer `retime` (il comprimerait l'attente).
  Comparés : `SELECT … Fiches_Agenda … '10h01'` et `pico2wave … « Il est 10 heure 1 . Rendez-vous client Martin »`.
  Durée ~73 s : délai de 95 s demandé (`timeout_accord` provisoire « ESSAI »).
- **FMENU-T12 complet (vague 2 bis, délais)** : scénario `fmenu_acces_admin_complet`, jeu `mdp_shared/mdp_conf`
  (Admin/AdminG, mots de passe « laurux »). Mauvais (« x », Message.Error, Espace) puis bon mot de passe : Menu25
  (mauvais), Menu110 (bon, Prefs fermé), Menu26 (Fsoc), Menu65 (FRestore), Menu150 (Dup), Menu142 (DB_Sanity),
  Menu173 (mauvais seulement : Majversion fait un HttpClient vers www.laurux.fr, non reproductible), Menu329 (MDP
  global, Prefs global fermé par Button2 : réécriture du blob `conf`), Menu166 (LauruxConf laissé ouvert : sa
  fermeture redémarre Laurux). Après `retime`, l'écart avant chaque Entrée de bon mot de passe suivie d'une fermeture
  est porté à 1 s (sinon le `Close` part 50 ms après l'Entrée, avant l'ouverture de l'écran, et rework échoue en code
  3) ; ne pas relancer `retime`. Durée ~142 s pour 38 s de scénario : à la fermeture d'une fenêtre modale, le rejeu
  reprend comme horodatage de référence celui de l'événement qui l'a ouverte, ce qui double à peu près chaque bloc.
  Le scénario dépasse 60 s : deux ticks de `Timer1` (`SELECT … Fiches_Agenda` « 10h01 » puis « 10h02 », chacun
  deux fois) figurent dans `sql.log` (ordre stable sur 2 comparaisons, mais dépendant du minutage). Délai de 180 s
  demandé (`timeout_accord` provisoire « ESSAI »).
