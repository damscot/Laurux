# Fmenu — Rework

> Source : `.src/Communs/Fmenu.class` · Message de commit (phase 4) : `reference/.src/Communs/Fmenu.class/rework.md <REWORK_ID>`

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

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 1579 | 510 | 54 | 0 | 296 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

Fenêtre principale : chaque étape est validée par les replays de démarrage (T01 à T06) en plus des
tests cités, car tous les scénarios de l'application passent par `Fmenu`.

- [ ] FMENU-001 — [documentation] En-tête en français (rôle, séquence de démarrage, renvoi vers la
  carte de navigation d'architecture.md) ; commentaire sur le `If Error` de la ligne 143 qui teste le
  `Try` de la ligne 88 ; commentaires `'''` sur `Abonnement`, `preferences` et `Menu*showhide` ·
  appelants : aucun · tests : aucun · sources : [Fmenu.class:Form_Open](../../../../.src/Communs/Fmenu.class#L72-L288), [Fmenu.class:143](../../../../.src/Communs/Fmenu.class#L143), [Fmenu.class:Abonnement](../../../../.src/Communs/Fmenu.class#L342-L420)
- [ ] FMENU-002 — [code mort] Supprimer `Tva_Click` et `journaux_Click` (aucun contrôle `Tva` ni
  `journaux` dans le `.form`), les membres `Version`, `PsX`, `PsY` (jamais référencés), la variable
  locale `Tab` de `Form_Open` et `dateAb` d'`Abonnement` · appelants : aucun · tests : T01, T04,
  T16 · sources : [Fmenu.class:Tva_Click](../../../../.src/Communs/Fmenu.class#L593-L597), [Fmenu.class:journaux_Click](../../../../.src/Communs/Fmenu.class#L611-L615), [Fmenu.class:33-35](../../../../.src/Communs/Fmenu.class#L33-L35), [Fmenu.class:82](../../../../.src/Communs/Fmenu.class#L82), [Fmenu.class:356](../../../../.src/Communs/Fmenu.class#L356)
- [ ] FMENU-003 — [réduction de portée] `RecupTaches`, `preferences`, `Config`, `Abonnement`,
  `SetObserver` → `Private` ; `Soc`, `intitule`, `CpTable` → `Private` ; `Btunnel` → variable locale
  (couverture par les replays de démarrage) · appelants : aucun (vérifié par grep) · tests : T01,
  T04, T06, T13, T14 · sources : [Fmenu.class:RecupTaches](../../../../.src/Communs/Fmenu.class#L290-L307), [Fmenu.class:preferences](../../../../.src/Communs/Fmenu.class#L422-L472), [Fmenu.class:Config](../../../../.src/Communs/Fmenu.class#L526-L531), [Fmenu.class:Abonnement](../../../../.src/Communs/Fmenu.class#L342-L420), [Fmenu.class:SetObserver](../../../../.src/Communs/Fmenu.class#L1427-L1440), [Fmenu.class:31-37](../../../../.src/Communs/Fmenu.class#L31-L37)
- [ ] FMENU-004 — [commonalisation] Helper privé `ReplicationOK(sMessage As String) As Boolean`
  remplaçant les 14 blocs `Con-ssh`/`Replique`/`Breplique` + `ControlTunnel` (messages inchangés,
  y compris leurs variantes) · appelants : aucun · tests : T13, T07-T11 · sources : [Fmenu.class:Menu21_Click](../../../../.src/Communs/Fmenu.class#L648-L663), [Fmenu.class:Menu42_Click](../../../../.src/Communs/Fmenu.class#L921-L947), [Fmenu.class:Menu46_Click](../../../../.src/Communs/Fmenu.class#L759-L771), [Fmenu.class:Menu295_Click](../../../../.src/Communs/Fmenu.class#L2282-L2294)
- [ ] FMENU-005 — [commonalisation] (transverse, après FMENU-004) Déplacer le helper dans
  `Utils.ReplicationOK(Optional sMessage)` et l'utiliser dans `Start.module:112` (même message) et
  `Facture.class:1520` (sans message) · appelants : `Start`, `Facture` · tests : T13 + replays de
  démarrage et de facturation · sources : [Fmenu.class:Menu21_Click](../../../../.src/Communs/Fmenu.class#L648-L663), [Start.module:112-118](../../../../.src/Start.module#L112-L118), [Facture.class:1520](../../../../.src/Gestion/Facturation/Facture.class#L1520)
- [ ] FMENU-006 — [commonalisation] Remplacer les 8 blocs « mot de passe administrateur » par
  `MDP.Autorise()` (voir MDP-003) ; `Menu142` garde son abandon explicite (`Return` si refus) ·
  appelants : aucun (Fmenu) · tests : T12, MDP-T01, MDP-T02 · sources : [Fmenu.class:Menu25_Click](../../../../.src/Communs/Fmenu.class#L688-L700), [Fmenu.class:Menu26_Click](../../../../.src/Communs/Fmenu.class#L630-L646), [Fmenu.class:Menu65_Click](../../../../.src/Communs/Fmenu.class#L827-L839), [Fmenu.class:Menu110_Click](../../../../.src/Communs/Fmenu.class#L1151-L1166), [Fmenu.class:Menu142_Click](../../../../.src/Communs/Fmenu.class#L2554-L2569), [Fmenu.class:Menu150_Click](../../../../.src/Communs/Fmenu.class#L1394-L1406), [Fmenu.class:Menu166_Click](../../../../.src/Communs/Fmenu.class#L1626-L1638), [Fmenu.class:Menu173_Click](../../../../.src/Communs/Fmenu.class#L1674-L1687)
- [ ] FMENU-007 — [commonalisation] `Menushowhide`/`Menu2showhide`/`Menu3showhide`/`Menu4showhide`
  : corps factorisé dans un helper privé `Affiche(bVisible, aCtrl As Object[])`, signatures `Public`
  inchangées · appelants : `Prefs` (inchangé) · tests : T01, T17 · sources : [Fmenu.class:Menushowhide](../../../../.src/Communs/Fmenu.class#L474-L484), [Fmenu.class:Menu4showhide](../../../../.src/Communs/Fmenu.class#L514-L524)
- [ ] FMENU-008 — [complexité] Découper `Form_Open` (CC 54) en procédures privées appelées dans le
  même ordre (`AppliqueOptionsMenus`, `ImageFond`, `OuvreConnexion`, `RappelsDuJour`,
  `InitTaches`) ; `Catch` final et sémantique du `If Error` l. 143 conservés · appelants : aucun ·
  tests : T01-T04, T06, T20 · sources : [Fmenu.class:Form_Open](../../../../.src/Communs/Fmenu.class#L72-L288)
- [ ] FMENU-009 — [complexité] Rappels de promotion : un helper `RappelPromo(colonne, textes)` pour
  les deux blocs début / fin (même SQL, mêmes messages) · appelants : aucun · tests : T02 · sources : [Fmenu.class:198-220](../../../../.src/Communs/Fmenu.class#L198-L220)
- [ ] FMENU-010 — [séparation traitement/GUI] `Abonnement` : calcul extrait dans une fonction pure
  `NbFacturesPeriodiques(rClient, dJour) As Integer` (Public pour gb.test), les quatre périodes
  mensuelle à semestrielle factorisées par nombre de mois **en conservant le calcul actuel du
  passage d'année** (FMENU-A01) ; le handler garde `Syntheses.Message`/`Message.Info` · appelants :
  aucun · tests : T04, T05 · sources : [Fmenu.class:Abonnement](../../../../.src/Communs/Fmenu.class#L342-L420)
- [ ] FMENU-011 — [séparation traitement/GUI] `ColTaches_KeyPress` : `DELETE` + `ALTER TABLE`
  extraits dans `SupprimeTache(lind)` privé · appelants : aucun · tests : T06 · sources : [Fmenu.class:ColTaches_KeyPress](../../../../.src/Communs/Fmenu.class#L323-L334)
- [ ] FMENU-012 — [réarchitecture] `RecupTaches` : requête paramétrée (`WHERE nom LIKE &1`, avec
  `User.Name & "%"`) au lieu de la concaténation entre guillemets doubles — SQL modifié, dump
  identique, résultat identique pour tout nom d'utilisateur sans `"` · appelants : aucun · tests :
  T06 · sources : [Fmenu.class:302](../../../../.src/Communs/Fmenu.class#L302)
- [ ] FMENU-013 — [commonalisation] `preferences` : couleurs par défaut lues depuis les constantes
  communes de SETCOLORS-005, chaînes conservées caractère pour caractère (virgules et doubles
  écritures comprises tant que FMENU-A03 n'est pas validée) · appelants : `Start`, `SetColors` (via
  SETCOLORS-005) · tests : T14, SETCOLORS-T04, SETCOLORS-T05 · sources : [Fmenu.class:437-456](../../../../.src/Communs/Fmenu.class#L437-L456), [Start.module:132-155](../../../../.src/Start.module#L132-L155), [SetColors.class:Button2_Click](../../../../.src/Utils/SetColors.class#L103-L116)
- [ ] FMENU-014 — [commonalisation] `Utils.LibelleSociete(code) As String` (lecture `TabSoc` +
  formatage `type_sc - int_sc`) partagé avec `Cmenu._new` · appelants : `Cmenu` · tests : T01 +
  replay d'ouverture de `Cmenu` · sources : [Fmenu.class:178-180](../../../../.src/Communs/Fmenu.class#L178-L180), [Cmenu.class:62-64](../../../../.src/Caisse/Cmenu.class#L62-L64)
- [ ] FMENU-015 — [commonalisation] `Menu42_Click` et `Menu193_Click` : corps commun dans
  `OuvreFacture(bEntretien As Boolean)` privé (même ordre de construction `Facture` puis
  `ConVendeurs`, `ConVendeurs` sans argument pour `Menu42` et `True` pour `Menu193`) · appelants :
  aucun · tests : T08, T13 · sources : [Fmenu.class:Menu42_Click](../../../../.src/Communs/Fmenu.class#L921-L947), [Fmenu.class:Menu193_Click](../../../../.src/Communs/Fmenu.class#L1768-L1794)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] FMENU-A01 — [anomalie] `Abonnement` : passage d'année calculé par `12 - Val(mois)` au lieu de
  `12 + Val(mois)` ; en janvier, un abonnement bimestriel cherche le mois 13, trimestriel le mois 14,
  semestriel le mois 17 (factures périodiques non signalées) · tests : T04, T05 · sources : [Fmenu.class:373](../../../../.src/Communs/Fmenu.class#L373), [Fmenu.class:382](../../../../.src/Communs/Fmenu.class#L382), [Fmenu.class:391](../../../../.src/Communs/Fmenu.class#L391)
- [ ] FMENU-A02 — [anomalie] `Abonnement`, périodicité annuelle : le jour de la dernière facture est
  comparé aux deux derniers chiffres de l'année (`Right$(dteN2, 2)`) ; dépendance au format implicite
  Date → String de `dtefac` (à confirmer) · tests : T04, T05 · sources : [Fmenu.class:398-403](../../../../.src/Communs/Fmenu.class#L398-L403)
- [ ] FMENU-A03 — [anomalie] `preferences` écrit `/Coul/Coulfonds` et `/Coul/Others` avec des
  virgules alors que `Start.Coul` découpe sur `;` (couleur de repli utilisée) ; clés `Devis2`,
  `Motps`, `Momnt` non réinitialisées ; écritures doubles de `Qt1`, `Coulfonds`, `Others` · tests :
  T14 · sources : [Fmenu.class:446-447](../../../../.src/Communs/Fmenu.class#L446-L447), [Fmenu.class:432-434](../../../../.src/Communs/Fmenu.class#L432-L434), [Start.module:230](../../../../.src/Start.module#L230)
- [ ] FMENU-A04 — [anomalie] `ColTaches_KeyPress` : n'importe quelle touche (flèches, Tab…) propose
  la suppression de la tâche ; `ALTER TABLE Fiches_Taches ORDER BY lind` échoue sous SQLite · tests :
  T06 · sources : [Fmenu.class:ColTaches_KeyPress](../../../../.src/Communs/Fmenu.class#L323-L334), [Fmenu.class:330](../../../../.src/Communs/Fmenu.class#L330)
- [ ] FMENU-A05 — [anomalie] `RecupTaches` n'affiche le panneau des tâches que s'il y a **plus
  d'une** tâche (`itaches > 1`) · tests : T06 · sources : [Fmenu.class:305](../../../../.src/Communs/Fmenu.class#L305)
- [ ] FMENU-A06 — [anomalie] La grille des tâches lit le résultat global partagé `Utils.rs1` : tout
  écran qui appelle `Utils.Base` le remplace, et la grille affiche alors d'autres données au prochain
  rafraîchissement · tests : T06 · sources : [Fmenu.class:Coltaches_Data](../../../../.src/Communs/Fmenu.class#L309-L321), [Fmenu.class:302](../../../../.src/Communs/Fmenu.class#L302)
- [ ] FMENU-A07 — [anomalie, sécurité] Démarrage MySQL : mot de passe en clair sur la ligne de
  commande `mysql` (visible dans `ps`) et `SET @@global.sql_mode` modifié à chaque lancement
  (droit `SUPER` requis, échec silencieux sinon) · tests : T01 (log du `Shell`) · sources : [Fmenu.class:175](../../../../.src/Communs/Fmenu.class#L175)
- [ ] FMENU-A08 — [anomalie] `If Error Then` (l. 143) teste le `Try` de la ligne 88 : le dialogue
  « fichier de configuration incorrect » n'est quasiment jamais proposé ; seul le `Catch` final
  traite les erreurs de configuration · tests : T20 · sources : [Fmenu.class:143-154](../../../../.src/Communs/Fmenu.class#L143-L154), [Fmenu.class:88](../../../../.src/Communs/Fmenu.class#L88)
- [ ] FMENU-A09 — [anomalie] `Menu42`/`Menu193` construisent `New Facture(…)` même quand c'est
  `ConVendeurs` qui est affiché (effets de bord de `Facture._new` à confirmer : verrous, requêtes) ·
  tests : T08 · sources : [Fmenu.class:934](../../../../.src/Communs/Fmenu.class#L934), [Fmenu.class:1781](../../../../.src/Communs/Fmenu.class#L1781)
- [ ] FMENU-A10 — [anomalie] Les libellés `lblFacfm` et `lblClm` ouvrent `Facturefm` et `ClotureF`
  **sans** le contrôle de réplication appliqué par `Menu138`/`Menu147` · tests : T13, T16 · sources : [Fmenu.class:lblFacfm_MouseDown](../../../../.src/Communs/Fmenu.class#L1545-L1550), [Fmenu.class:lblClm_MouseDown](../../../../.src/Communs/Fmenu.class#L1552-L1557)
- [ ] FMENU-A11 — [anomalie] `Menu331` (icône « stop » de la barre de menus) n'a aucun handler :
  clic sans effet (intention probable : quitter comme `ToolButton1`) · tests : T07 · sources : [Fmenu.class:ToolButton1_Click](../../../../.src/Communs/Fmenu.class#L751-L757)
- [ ] FMENU-A12 — [anomalie][code mort] Supprimer les 6 handlers inatteignables `Menu104_Click`,
  `Menu106_Click`, `Menu121_Click`, `Menu141_Click`, `Menu156_Click`, `Menu201_Click` (menus
  parents ou séparateurs) ; à coordonner avec CARCH-A02 (seul accès à `Carch`) · tests : T07-T11 ·
  sources : [Fmenu.class:Menu104_Click](../../../../.src/Communs/Fmenu.class#L1139-L1143), [Fmenu.class:Menu106_Click](../../../../.src/Communs/Fmenu.class#L1145-L1149), [Fmenu.class:Menu121_Click](../../../../.src/Communs/Fmenu.class#L1217-L1221), [Fmenu.class:Menu141_Click](../../../../.src/Communs/Fmenu.class#L1348-L1352), [Fmenu.class:Menu156_Click](../../../../.src/Communs/Fmenu.class#L1415-L1419), [Fmenu.class:Menu201_Click](../../../../.src/Communs/Fmenu.class#L1198-L1202)
- [ ] FMENU-A13 — [anomalie] `Prefs`, `Fsoc`, `LauruxConf` et `Cmenu` agissent sur l'auto-instance
  `Fmenu.` et non sur la fenêtre créée par `Start` (`Start.MainWindow`) : menus et titre de la
  fenêtre visible non mis à jour, fenêtre cachée créée (à confirmer à l'exécution) · appelants :
  `Prefs`, `Fsoc`, `LauruxConf`, `Cmenu` · tests : T17 · sources : [Prefs.class:729](../../../../.src/Communs/Prefs.class#L729), [Fsoc.class:496](../../../../.src/Communs/Fsoc.class#L496), [LauruxConf.class:297](../../../../.src/Communs/LauruxConf.class#L297), [Cmenu.class:64](../../../../.src/Caisse/Cmenu.class#L64)
- [ ] FMENU-A14 — [anomalie] `ToolButton1` vide tout `~/tmp` par `Shell "rm " & User.home &
  "/tmp/*"` (chemin non protégé) ; `Menu118` (« Quitter ») ne le fait pas · tests : T15 · sources : [Fmenu.class:753](../../../../.src/Communs/Fmenu.class#L753)
- [ ] FMENU-A15 — [anomalie] (relevée par le lot Gestion, CONVENDEURS-A01) `Menu193_Click` fait
  `New ConVendeurs(True)` alors que `ConVendeurs._new()` n'a aucun paramètre : l'argument devient le
  `Parent` de `Form` → « Type mismatch: wanted Control, got Boolean » (vérifié gbc3/gbx3 sur un projet
  minimal) ; l'écran de connexion vendeur ne s'ouvre pas depuis ce menu · tests : à ajouter (replay
  Menu193) · sources : [Fmenu.class:1788](../../../../.src/Communs/Fmenu.class#L1788)
- [ ] FMENU-A16 — [anomalie] (relevée par le lot Gestion, CLOTUREF-A04) `lblClm_MouseDown` ouvre
  `ClotureF` sans le contrôle du tunnel de réplication fait par `Menu147_Click` · tests : à ajouter
  (replay clôture mensuelle) · sources : [Fmenu.class:lblClm_MouseDown](../../../../.src/Communs/Fmenu.class#L1552-L1557), [Fmenu.class:Menu147_Click](../../../../.src/Communs/Fmenu.class#L1380-L1392)
