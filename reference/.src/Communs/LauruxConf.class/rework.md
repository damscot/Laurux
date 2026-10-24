# LauruxConf — Rework

> Source : `.src/Communs/LauruxConf.class` · Message de commit (phase 4) : `reference/.src/Communs/LauruxConf.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 384 |
| Lignes de commentaire | 81 |
| Fonctions | 8 |
| Fonctions Public | 8 |
| Complexité cyclomatique totale | 97 |
| Complexité max (fonction) | 54 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 384 | 97 | 54 | 0 | 8 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] LAURUXCONF-001 — [documentation] En-tête en français : format de la section `[dbase]` /
  `[dbase/ssh]`, chiffrement des mots de passe (clés `Laurux` / `LauruX2012`), modes modal / non
  modal, usage de `Createbase` sur l'auto-instance · appelants : aucun · tests : aucun · sources : [LauruxConf.class:1-31](../../../../.src/Communs/LauruxConf.class#L1-L31), [LauruxConf.class:Createbase](../../../../.src/Communs/LauruxConf.class#L321-L414)
- [ ] LAURUXCONF-002 — [code mort] Supprimer `Nouveau` (jamais lu), `sTemp` (inutilisé), les
  écritures écrasées dans la même fonction (`Qt1` en double, premières valeurs de
  `/Coul/Coulfonds` et `/Coul/Others`) ; fichier `Laurux.conf` produit identique · appelants :
  aucun · tests : T04, T07 · sources : [LauruxConf.class:37](../../../../.src/Communs/LauruxConf.class#L37), [LauruxConf.class:324](../../../../.src/Communs/LauruxConf.class#L324), [LauruxConf.class:357](../../../../.src/Communs/LauruxConf.class#L357), [LauruxConf.class:365-366](../../../../.src/Communs/LauruxConf.class#L365-L366)
- [ ] LAURUXCONF-003 — [complexité] `_new` : helper privé `ChargeConfig()` appelé par le corps et
  par le `Catch` (bloc dupliqué l. 105-135 / 137-169), différences conservées (`Nouveau`/`Maj`
  forcés dans le `Catch`) ; CC 54 → ≤ 20 visé · appelants : aucun · tests : T01, T07 · sources : [LauruxConf.class:_new](../../../../.src/Communs/LauruxConf.class#L39-L173)
- [ ] LAURUXCONF-004 — [commonalisation] Créer `Utils.OuvreBase(sNom)` (Open, `SET NAMES`, `Shell
  mysql … sql_mode`, `ALTER DATABASE … COLLATE`, `SET NAMES … COLLATE`, même ordre) et l'utiliser
  ici, dans `Fsoc` (FSOC-007) et `Fmenu.class:175` · appelants : `Fsoc`, `Fmenu` · tests : T02,
  FSOC-T05, FSOC-T06 · sources : [LauruxConf.class:274-280](../../../../.src/Communs/LauruxConf.class#L274-L280), [Fsoc.class:565-572](../../../../.src/Communs/Fsoc.class#L565-L572), [Fmenu.class:175](../../../../.src/Communs/Fmenu.class#L175)
- [ ] LAURUXCONF-005 — [commonalisation] Créer `Utils.BasesLaurux(bPrefixe) As String[]`
  (balayage de `Utils.db.Databases`) utilisé par `_new`, `Fsoc.Init_base` (FSOC-008) et `Dup` ;
  règle de filtrage actuelle conservée · appelants : `Fsoc`, `Dup` · tests : T01, T10, FSOC-T01,
  FSOC-T11 · sources : [LauruxConf.class:58-87](../../../../.src/Communs/LauruxConf.class#L58-L87), [Fsoc.class:93-112](../../../../.src/Communs/Fsoc.class#L93-L112), [Dup.class:82](../../../../.src/Compta/Utils/Dup.class#L82)
- [ ] LAURUXCONF-006 — [commonalisation] Paramètres du tunnel SSH par `Utils.ChargeParamSsh()`
  (UTILS-015), même ordre d'affectation · appelants : aucun · tests : T09 · sources : [LauruxConf.class:245-251](../../../../.src/Communs/LauruxConf.class#L245-L251), [Utils.module:glb](../../../../.src/Utils/Utils.module#L93-L129)
- [ ] LAURUXCONF-007 — [séparation traitement/GUI] `Createbase` : extraire
  `CreeBaseSociete(sBase, sSoc, sLogin, sMdp, sHost, sPort)` (CREATE DATABASE, préférences par
  défaut, `Fill_DataBase`, `UPdate Fiches_Societes`) sans accès aux contrôles ; `Createbase`
  garde la question, la souris et les messages, signature inchangée · appelants : `Fsoc`, `Dup`
  (inchangés) · tests : T04, T05, FSOC-T03, FSOC-T12 · sources : [LauruxConf.class:Createbase](../../../../.src/Communs/LauruxConf.class#L321-L414)
- [ ] LAURUXCONF-008 — [complexité] Helper privé `EcritConfig()` pour les écritures de
  configuration communes à `Button1_Click` et `Form_Close`, chaque différence actuelle étant
  conservée par paramètre (clé `ssh/Con-ssh`, `Passphrase`/`Passp`, calcul de `Name`, `Save`) ·
  appelants : aucun · tests : T02, T06 · sources : [LauruxConf.class:190-219](../../../../.src/Communs/LauruxConf.class#L190-L219), [LauruxConf.class:Form_Close](../../../../.src/Communs/LauruxConf.class#L426-L468)
- [ ] LAURUXCONF-009 — [réduction de portée] Variables d'instance `rResult` et `Lig` → locales ;
  `Soc` local à `Button1_Click` (masqué dans `Createbase` par une locale homonyme) · appelants :
  aucun · tests : T01, T02, T04 · sources : [LauruxConf.class:32-36](../../../../.src/Communs/LauruxConf.class#L32-L36)
- [ ] LAURUXCONF-010 — [commonalisation] Couleurs `[Coul]` par défaut dans un helper partagé avec
  `Start.module`, `Fmenu.class:437` et `SetColors.class:106`, valeurs propres à chaque appelant
  passées en paramètre (séparateur `,` ici, `;` dans `Start`) · appelants : `Start`, `Fmenu`,
  `SetColors` · tests : T04, T07 · sources : [LauruxConf.class:360-379](../../../../.src/Communs/LauruxConf.class#L360-L379), [Start.module:132-150](../../../../.src/Start.module#L132-L150)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] LAURUXCONF-A01 — [anomalie] `ComboBox1_Click` force `mysql` : SQLite n'est pas sélectionnable,
  les branches `sqlite3` de `Button1_Click`/`Form_Close` sont inatteignables par la GUI (à
  valider : SQLite volontairement désactivé ?) · tests : T01 · sources : [LauruxConf.class:ComboBox1_Click](../../../../.src/Communs/LauruxConf.class#L493-L508)
- [ ] LAURUXCONF-A02 — [anomalie] `Createbase` remplit `Laurux<XX>` au lieu de `Base` (préfixe et
  nom passé par `Dup` ignorés : la base créée peut rester vide, ou une autre base être écrasée) ;
  sortie d'erreur de `Fill_DataBase` ignorée (succès annoncé même si l'import échoue) · tests :
  T04, FSOC-T12 · sources : [LauruxConf.class:398](../../../../.src/Communs/LauruxConf.class#L398), [LauruxConf.class:402](../../../../.src/Communs/LauruxConf.class#L402)
- [ ] LAURUXCONF-A03 — [anomalie] `Button1_Click` écrit `/dbase/ssh/Con-ssh` alors que
  `Utils.glb`, `Start` et `_new` lisent `/dbase/Con-ssh` (rattrapé seulement par `Form_Close` ou
  `Createbase`) · tests : T02, T09 · sources : [LauruxConf.class:208](../../../../.src/Communs/LauruxConf.class#L208), [LauruxConf.class:123](../../../../.src/Communs/LauruxConf.class#L123), [Utils.module:103](../../../../.src/Utils/Utils.module#L103)
- [ ] LAURUXCONF-A04 — [anomalie] Préfixe : `Nbase.Text` contient déjà le préfixe (l. 89) mais
  `Utils.db.name = Prefixe.Text & Nbase.Text` l'ajoute une seconde fois ; `/dbase/Name` est écrit
  avec préfixe par `Button1_Click` puis sans par `Form_Close` · tests : T10 · sources : [LauruxConf.class:89](../../../../.src/Communs/LauruxConf.class#L89), [LauruxConf.class:199](../../../../.src/Communs/LauruxConf.class#L199), [LauruxConf.class:275](../../../../.src/Communs/LauruxConf.class#L275), [LauruxConf.class:433-439](../../../../.src/Communs/LauruxConf.class#L433-L439)
- [ ] LAURUXCONF-A05 — [anomalie] `Createbase` écrit `/Soc<Start.Societe>/Exp`, `/Lettrage`,
  `/Impbl` sur la société **courante** au lieu de la nouvelle, et réinitialise les clés globales
  `/son`, `/Tips` et toutes les couleurs `[Coul]` à chaque création · tests : T04 · sources : [LauruxConf.class:349-350](../../../../.src/Communs/LauruxConf.class#L349-L350), [LauruxConf.class:387-389](../../../../.src/Communs/LauruxConf.class#L387-L389)
- [ ] LAURUXCONF-A06 — [anomalie] `Button1_Click` lit `rResult!type_sc` sans test `Available` (base
  sans ligne `cd_sc = Right$(Nbase, 2)` → erreur générique) ; code société supposé être les 2
  derniers caractères du nom · tests : T02 · sources : [LauruxConf.class:291-297](../../../../.src/Communs/LauruxConf.class#L291-L297)
- [ ] LAURUXCONF-A07 — [anomalie] `Createbase` ouvre sa connexion avec `Host`/`Port` du formulaire
  même si le tunnel SSH est actif (contourne le tunnel), sans gestion d'erreur (échec d'ouverture →
  `Print`, puis exception chez l'appelant) · tests : T09 · sources : [LauruxConf.class:336-345](../../../../.src/Communs/LauruxConf.class#L336-L345)
- [ ] LAURUXCONF-A08 — [anomalie] `Form_Close` n'écrit ni `Passphrase` ni `Passp` et ne fait pas
  `Save` (enregistrement dépendant d'une sauvegarde ultérieure de `Start.LocalSettings`) · tests :
  T06 · sources : [LauruxConf.class:447-453](../../../../.src/Communs/LauruxConf.class#L447-L453)
- [ ] LAURUXCONF-A09 — [anomalie] `Shell mysql … SET @@global.sql_mode` : mot de passe visible dans
  `ps`, port et tunnel ignorés, droit `SUPER` requis (même défaut que FSOC-A07) · tests : T02 ·
  sources : [LauruxConf.class:278](../../../../.src/Communs/LauruxConf.class#L278)
- [ ] LAURUXCONF-A10 — [anomalie] Le `Catch` de `Button1_Click` reconnaît les erreurs par leur texte
  anglais (`Cannot open database: …`) : un pilote ou un serveur aux messages différents (MariaDB
  récent, autre langue) tombe dans `Message.Error` brut · tests : T03, T08 · sources : [LauruxConf.class:304-317](../../../../.src/Communs/LauruxConf.class#L304-L317)
