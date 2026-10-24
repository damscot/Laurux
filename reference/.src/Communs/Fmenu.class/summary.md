# Fmenu — Synthèse

> Source : `.src/Communs/Fmenu.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Fenêtre principale du mode Gestion (créée par `Start.Lancement` sans `-p`). Elle ouvre la
connexion SQL, lance les migrations de schéma, affiche les rappels du jour, puis donne accès à
environ 235 écrans par la barre de menus, une barre d'outils et des libellés cliquables. Sa
fermeture termine l'application.

## Points clés

- `Form_Open` (CC 54) : options d'affichage des menus, image de fond tournante, tunnel SSH,
  `SET NAMES`/`sql_mode` (y compris un `Shell mysql` qui règle le `sql_mode` **global**),
  `Start.Restore_Args`, **`LauruxMaj.Verif_Version`** (migrations), préférences globales,
  promotions du jour, **tarifs différés appliqués en base** (`DateTar.EnrTouTar`), factures
  périodiques (`Abonnement`), tâches de l'utilisateur. `Catch` final : diagnostic puis `Quit`.
- Handlers de menu : ouverture d'un écran ; 8 sont protégés par le mot de passe administrateur
  (`MDP`), 14 par un contrôle de réplication (`Utils.ControlTunnel`, lui-même défectueux).
- **Carte de navigation** complète (menu → libellé → écran) dans architecture.md : base des
  scénarios replay de toute l'application.
- Handlers inatteignables : `Menu104`, `Menu156` (menus parents), `Menu106`, `Menu121`, `Menu141`,
  `Menu201` (séparateurs) ; sans contrôle : `Tva_Click`, `journaux_Click` ; `Menu331` sans handler.
- Huit doublons fonctionnels (deux entrées pour le même écran).
- `preferences()` réécrit une quarantaine de préférences par défaut (couleurs en dur, en double
  avec `Start.module` et `SetColors`).

## Dépendances principales

- Utilise : `Start` (`LocalSettings`, `GlobalSettings`, `Motdepasse`…), `Utils` (connexion, tunnel,
  `Base`/`rs1`, `Observers`), `Cbase`, `LauruxMaj`, `Majversion`, `Prefs`, `MDP`, `DateTar`,
  `AffRdv`, `Syntheses`, `Menuopt`, et ~230 écrans ouverts depuis les menus.
- Utilisé par : `Start` (instance), `Prefs` (`Menu*showhide`), `Fsoc`, `LauruxConf`, `Cmenu`
  (titre via l'auto-instance), `Utils.Recursive_Observers` (test de type).
- Tables : `Fiches_Societes`, `Fiches_Promo`, `Fiches_TarTemp`, `Fiches_Bl`, `Fiches_Cli`,
  `Fiches_Taches` (`Fiches_TarTemp` et `Fiches_Taches` en dur, sans `Cbase`).

## Risques

- Toute régression bloque **toute** l'application (démarrage, migrations, navigation).
- Anomalies notables : calcul des factures périodiques faux au changement d'année (A01, A02) ;
  couleurs par défaut au mauvais format (A03) ; n'importe quelle touche propose la suppression d'une
  tâche, `ALTER TABLE` non SQLite (A04) ; mot de passe MySQL en clair dans `ps` et `sql_mode`
  global modifié (A07) ; auto-instance `Fmenu.` utilisée par `Prefs`/`Fsoc`/`LauruxConf`/`Cmenu`
  au lieu de la fenêtre visible (A13, à confirmer) ; raccourcis `lblFacfm`/`lblClm` sans contrôle
  de réplication (A10).
- Grille des tâches alimentée par le global partagé `Utils.rs1` (A06).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 1579 |
| Lignes de commentaire | 42 |
| Fonctions | 296 |
| Fonctions Public | 296 |
| Complexité cyclomatique totale | 510 |
| Complexité max (fonction) | 54 (`Form_Open`) |
| Variables globales | 0 |
| Variables Public | 6 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

20 tests prévus (FMENU-T01 à T20), dont 19 `replay` : démarrage selon les options société,
rappels (promotions, tarifs, factures périodiques sous date figée), tâches, navigation complète par
groupe de menus (générée depuis la carte), accès administrateur, réplication en échec,
préférences par défaut, fermeture, raccourcis, plein écran, rendez-vous, erreurs de démarrage. Un
`gbtest` (T05) couvre le calcul des factures périodiques une fois extrait (FMENU-010).

## Rework

15 étapes sans changement de comportement (FMENU-001 à 015) : documentation, code mort, réduction
de portée de 8 membres, helpers pour le contrôle de réplication (local puis `Utils`), l'accès
administrateur (`MDP.Autorise`), la visibilité des menus, l'ouverture de facture et les rappels,
découpage de `Form_Open`, extraction pure d'`Abonnement`, SQL paramétré des tâches, constantes de
couleurs et libellé de société partagés. 16 anomalies (FMENU-A01 à A16) attendent une validation
utilisateur.
