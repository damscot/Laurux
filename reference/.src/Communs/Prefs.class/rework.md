# Prefs — Rework

> Source : `.src/Communs/Prefs.class` · Message de commit (phase 4) : `reference/.src/Communs/Prefs.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 1121 |
| Lignes de commentaire | 76 |
| Fonctions | 68 |
| Fonctions Public | 67 |
| Complexité cyclomatique totale | 374 |
| Complexité max (fonction) | 186 (`Form_Open`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 1121 | 374 | 186 | 0 | 67 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] PREFS-001 — [documentation] En-tête de classe en français : rôle, modes local/global,
  mécanisme de surcharge (`ReadGlobal`/`ApplyGlobal`), renvoi vers le tableau des clés
  d'architecture.md ; commentaires `'''` sur `_new`, `ReadSettings`, `ReadGlobal`, `ApplyGlobal`,
  `form_close` · appelants : aucun · tests : aucun · sources : [Prefs.class:_new](../../../../.src/Communs/Prefs.class#L40-L65), [Prefs.class:ReadGlobal](../../../../.src/Communs/Prefs.class#L75-L93), [Prefs.class:ApplyGlobal](../../../../.src/Communs/Prefs.class#L95-L113)
- [ ] PREFS-002 — [code mort] Supprimer le `Shell "gbx3 -V" To sVer` (résultat inutilisé) et
  `sVer`/`stmp`, la variable membre `Tab` (remplacée par `Cbase.Table`, voir 010), les variables
  `NmFic`/`ific` d'`Ecr_Click`, les 3 couleurs en double (l.171-173) et les 3 écritures en double
  (l.581-583) · appelants : aucun · tests : T01, T02, T05 · sources : [Prefs.class:187](../../../../.src/Communs/Prefs.class#L187), [Prefs.class:171](../../../../.src/Communs/Prefs.class#L171), [Prefs.class:581](../../../../.src/Communs/Prefs.class#L581), [Prefs.class:Ecr_Click](../../../../.src/Communs/Prefs.class#L971-L983)
- [ ] PREFS-003 — [code mort] Supprimer `Copie_Click` (aucun contrôle `Copie` dans le `.form` ;
  handler jamais déclenché) · appelants : aucun · tests : T11 · sources : [Prefs.class:Copie_Click](../../../../.src/Communs/Prefs.class#L1042-L1050)
- [ ] PREFS-004 — [complexité] `Form_Open` et `form_close` : table privée `[clé, contrôle,
  propriété, mode]` et deux boucles de lecture/écriture ; cas particuliers explicites (mots de
  passe, `Codetva`, `CodeMO`, `ipr`, police, défauts, `ServerLog*`). Comportement identique, ordre
  d'écriture des nouvelles clés éventuellement différent (comparaison normalisée) · CC 186 → ≤ 30
  visé · appelants : aucun · tests : T01 à T05, T09, T10 · sources : [Prefs.class:Form_Open](../../../../.src/Communs/Prefs.class#L115-L450), [Prefs.class:form_close](../../../../.src/Communs/Prefs.class#L515-L766)
- [ ] PREFS-005 — [complexité] Coloration des contrôles globaux (`Background = &HFFEFBF`) par une
  boucle sur les contrôles « G+L » de la table de PREFS-004 · appelants : aucun · tests : T05 · sources : [Prefs.class:Form_Open](../../../../.src/Communs/Prefs.class#L115-L450)
- [ ] PREFS-006 — [séparation traitement/GUI] Extraire `ListeEcheances()`, `ListeTypesClient()`,
  `ListeCodesTva()`, `ListeTauxMo()` (SQL → `String[]`) ; les handlers remplissent les `ComboBox`
  (mêmes libellés, même ordre) · appelants : aucun · tests : T01, T17 · sources : [Prefs.class:Echeances](../../../../.src/Communs/Prefs.class#L805-L818), [Prefs.class:Typeclient](../../../../.src/Communs/Prefs.class#L820-L833), [Prefs.class:Form_Open](../../../../.src/Communs/Prefs.class#L115-L450)
- [ ] PREFS-007 — [séparation traitement/GUI] `EcrireConfGlobale(sConf)` : seul `UPDATE … SET conf`,
  appelé par `form_close` (texte du fichier) et `Supprime_Click` (`Null`) ; SQL identique ·
  appelants : aucun · tests : T05, T08 · sources : [Prefs.class:form_close](../../../../.src/Communs/Prefs.class#L515-L766), [Prefs.class:Supprime_Click](../../../../.src/Communs/Prefs.class#L1439-L1453)
- [ ] PREFS-008 — [commonalisation] `ChoisirRepertoire(hCible, sTitre)` pour les 12 sélecteurs
  `SelectDirectory` (titres et exception de `Svs3_Click` conservés à l'identique) · appelants :
  aucun · tests : T12 · sources : [Prefs.class:Bchemin_Click](../../../../.src/Communs/Prefs.class#L1052-L1062), [Prefs.class:Bchemin10_Click](../../../../.src/Communs/Prefs.class#L893-L903), [Prefs.class:Svs_Click](../../../../.src/Communs/Prefs.class#L905-L915), [Prefs.class:Svs3_Click](../../../../.src/Communs/Prefs.class#L929-L939), [Prefs.class:Phot_Click](../../../../.src/Communs/Prefs.class#L1003-L1013)
- [ ] PREFS-009 — [complexité] Bascules de visibilité réécrites en `x.Visible = y.Value`
  (`Tva550_Click`, `MO_Click`, `Libdevis_Click`, `CheckBox2_Click`, `Sms_Click`, `Zebra_Click`,
  `Affichage`/`Masquage` fusionnés en `AfficherFtp(bVisible)`) · appelants : aucun · tests : T11 · sources : [Prefs.class:Sms_Click](../../../../.src/Communs/Prefs.class#L1253-L1275), [Prefs.class:Affichage](../../../../.src/Communs/Prefs.class#L1128-L1137), [Prefs.class:Masquage](../../../../.src/Communs/Prefs.class#L1139-L1148)
- [ ] PREFS-010 — [documentation] `Fiches_Tvaav` en dur → `Cbase.Table("TabTvav")` (même nom
  physique, SQL identique) · appelants : aucun · tests : T01 · sources : [Prefs.class:186](../../../../.src/Communs/Prefs.class#L186)
- [ ] PREFS-011 — [code mort] `NmBr_pays` : fermer le fichier `Pays.txt` (`Close #hFil`) ;
  remplacer `Do … Loop Until` par l'idiome `Repeat … Until` (l.193, l.201) · appelants : aucun ·
  tests : T01 · sources : [Prefs.class:NmBr_pays](../../../../.src/Communs/Prefs.class#L791-L803), [Prefs.class:Form_Open](../../../../.src/Communs/Prefs.class#L115-L450)
- [ ] PREFS-012 — [réduction de portée] `NmBr_pays`, `Echeances`, `Typeclient`, `aff_logo`,
  `aff_logo2`, `afffam`, `Affichage`, `Masquage`, `Mdp_LF` → `Private` (aucun appelant externe,
  vérifié par grep ; couverts par les replays) · appelants : aucun · tests : T01, T09, T11 · sources : [Prefs.class:NmBr_pays](../../../../.src/Communs/Prefs.class#L791-L803), [Prefs.class:afffam](../../../../.src/Communs/Prefs.class#L1381-L1407), [Prefs.class:aff_logo2](../../../../.src/Communs/Prefs.class#L1295-L1308), [Prefs.class:Mdp_LF](../../../../.src/Communs/Prefs.class#L461-L483)
- [ ] PREFS-013 — [commonalisation] Valeurs de création d'une société : procédure statique
  `Prefs.Defauts(hSettings, sSoc)` reprenant la partie commune de `Fmenu.preferences()` et de
  `LauruxConf` ; chaque appelant garde ses clés propres (`Slide` ; `Pays`, `Impbl`, `Exp`,
  `Lettrage`) et l'ordre d'écriture · appelants : `Fmenu`, `LauruxConf` (mis à jour dans le même
  commit) · tests : T01, LAURUXCONF (création de société), replay de réinitialisation Fmenu · sources : [Fmenu.class:preferences](../../../../.src/Communs/Fmenu.class#L422-L472), [LauruxConf.class:349](../../../../.src/Communs/LauruxConf.class#L349)
- [ ] PREFS-014 — [séparation traitement/GUI] `ApplyGlobal` : version `Static` pure
  `Fusionner(hCible, hGlobal)` appelée par la méthode d'instance (signature Public inchangée), pour
  un test gb.test sans fenêtre · appelants : `Fmenu` (inchangé) · tests : T06, T16 · sources : [Prefs.class:ApplyGlobal](../../../../.src/Communs/Prefs.class#L95-L113)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] PREFS-A01 — [anomalie] `ServerLogIP` prend la valeur par défaut `127.0.0.1` (et le port
  6556) à l'ouverture, puis elle est **enregistrée** à la fermeture (y compris dans le global) :
  `DB_Connection` crée alors un `NetHandler` vers un serveur de log inexistant, ce qui peut bloquer
  ou ralentir le démarrage (voir DB_CONNECTION-A06). Correction proposée : défaut vide · tests : T01, T15 · sources : [Prefs.class:437](../../../../.src/Communs/Prefs.class#L437), [Prefs.class:439](../../../../.src/Communs/Prefs.class#L439), [Prefs.class:593](../../../../.src/Communs/Prefs.class#L593), [DB_Connection.class:84](../../../../.src/Utils/DB_Connection.class#L84)
- [ ] PREFS-A02 — [anomalie] `CodeMO` : `Left$(Codemo.Text, iPos - 1)` avec `iPos = 0` (texte relu
  sans « - ») retire le dernier caractère ; chaque ouverture/fermeture tronque le code (« 12 » →
  « 1 » → « ») · tests : T10 · sources : [Prefs.class:591](../../../../.src/Communs/Prefs.class#L591), [Prefs.class:592](../../../../.src/Communs/Prefs.class#L592), [Prefs.class:360](../../../../.src/Communs/Prefs.class#L360)
- [ ] PREFS-A03 — [anomalie] `Kgl` est lu (l.277) mais jamais écrit : la case n'a aucun effet, alors
  que `Etigond` lit la clé · tests : T02 · sources : [Prefs.class:277](../../../../.src/Communs/Prefs.class#L277), [Etigond.class:115](../../../../.src/Gestion/Etiquettes/Etigond.class#L115)
- [ ] PREFS-A04 — [anomalie] `Svs3_Click` : en cas d'annulation, `User.Home` est écrit dans
  `Chmexport` au lieu de `Chmimp` · tests : T12 · sources : [Prefs.class:936](../../../../.src/Communs/Prefs.class#L936)
- [ ] PREFS-A05 — [anomalie] `Form_Open` affiche `Label27` (libellé du serveur FTP) au lieu de
  `Label31` quand `Impetiq` vaut « 2- Zebra » ; `Impetiq_Click` utilise bien `Label31` · tests : T11 · sources : [Prefs.class:424](../../../../.src/Communs/Prefs.class#L424), [Prefs.class:Impetiq_Click](../../../../.src/Communs/Prefs.class#L1241-L1251)
- [ ] PREFS-A06 — [anomalie] 13 clés écrites et jamais lues ailleurs : `Imp`, `Qt1`, `Coef`, `Tmq`,
  `Adrbtq`, `Numdossier`, `Nomdossier`, `MO`, `Idftp3`, `MdpFTP3`, `Rcptman`, `NumBr`, `IpZebra`.
  Pour `IpZebra`, les classes d'étiquettes (`Etiqart`, `Etigond`, `Etiqcasier`, `EtiqPromo`) ont une
  variable `IpZebra` jamais affectée : l'adresse saisie ici n'est **pas utilisée** pour
  l'impression Zebra. Décision utilisateur : brancher les lecteurs manquants ou retirer les
  contrôles (modification du contenu de `Laurux.conf`) · tests : T02 · sources : [Prefs.class:form_close](../../../../.src/Communs/Prefs.class#L515-L766), [Etiqart.class:995](../../../../.src/Gestion/Etiquettes/Etiqart.class#L995)
- [ ] PREFS-A07 — [anomalie] Contrôle de mot de passe interne inatteignable : `HBox20` n'est jamais
  rendu visible, donc `Mdp_KeyPress`/`Mdp_LF` ne s'exécutent jamais (le contrôle d'accès est fait par
  `MDP`). Supprimer ces handlers et le conteneur demande une modification du `.form` · tests : aucun · sources : [Prefs.class:Mdp_KeyPress](../../../../.src/Communs/Prefs.class#L455-L459), [Prefs.class:Mdp_LF](../../../../.src/Communs/Prefs.class#L461-L483)
- [ ] PREFS-A08 — [anomalie] En mode local, une clé « G+L » modifiée par l'utilisateur est
  silencieusement écrasée par la valeur globale à la fermeture (`ApplyGlobal` l.761) ; l'ouverture
  sauvegarde aussi le fichier local avant tout affichage. Proposition : griser les contrôles
  couverts par le global en mode local · tests : T06, T07 · sources : [Prefs.class:122](../../../../.src/Communs/Prefs.class#L122), [Prefs.class:761](../../../../.src/Communs/Prefs.class#L761)
- [ ] PREFS-A09 — [anomalie] `api_LostFocus` concatène la clé API dans une commande `Shell`
  (injection) et l'envoie en HTTP clair ; `~/tmp` doit exister. Proposition : `Exec ["curl", …]` et
  HTTPS (changement de requête externe) · tests : aucun (appel externe) · sources : [Prefs.class:api_LostFocus](../../../../.src/Communs/Prefs.class#L1322-L1339)
- [ ] PREFS-A10 — [anomalie] `afffam` : un `ipr` contenant 0 provoque `$check[-1]` ; un `Textfam`
  vidé par `Textfam_LostFocus` conduit à `Val("") - 1` (erreur à confirmer) · tests : T09 · sources : [Prefs.class:afffam](../../../../.src/Communs/Prefs.class#L1381-L1407), [Prefs.class:1404](../../../../.src/Communs/Prefs.class#L1404), [Prefs.class:Textfam_LostFocus](../../../../.src/Communs/Prefs.class#L1361-L1369)
- [ ] PREFS-A11 — [anomalie] `Supprime_Click` vide le global sans restaurer les fichiers locaux
  (les valeurs recopiées restent actives sur tous les postes) ; `Button1_Click` lance
  `pico2wave` sans argument avant `aplay` et écrit `msg.wav` dans le répertoire courant · tests : T08 · sources : [Prefs.class:Supprime_Click](../../../../.src/Communs/Prefs.class#L1439-L1453), [Prefs.class:1090](../../../../.src/Communs/Prefs.class#L1090)
