# Utils — Rework

> Source : `.src/Utils/Utils.module` · Message de commit (phase 4) : `reference/.src/Utils/Utils.module/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 1311 |
| Lignes de commentaire | 101 |
| Fonctions | 76 |
| Fonctions Public | 76 |
| Complexité cyclomatique totale | 473 |
| Complexité max (fonction) | 77 (`Calcech`) |
| Variables globales | 16 |
| Variables Public | 16 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 1311 | 473 | 77 | 16 | 76 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

Module appelé par presque tout le projet : chaque étape est **interne** (signatures Public
conservées), sauf mention contraire, et se valide par le jeu complet UTILS-T01 à T26.

- [ ] UTILS-001 — [documentation] En-tête du module en français : sections thématiques (connexion,
  conversions, dates, GUI, shell MySQL), contrat `BaseN` ↔ `rsN`, format d'entrée de chaque `Cdate_*`
  (tableau d'architecture.md) ; commentaire `'''` sur chaque fonction Public · appelants : aucun ·
  tests : aucun · sources : [Utils.module:Exit](../../../../.src/Utils/Utils.module#L30-L36), [Utils.module:Calcech](../../../../.src/Utils/Utils.module#L657-L772)
- [ ] UTILS-002 — [code mort] Supprimer `do_pcre_extract`, `Form_Close`, `Cdate_Comp2`, `Cdate_Com`,
  `convStr`, `Nsoc`, `Fcoulfond`, `PageFormatGetX`, `PageFormatGetY` (aucun appel, `With Utils`
  compris) · appelants : aucun · tests : T05, T13 · sources : [Utils.module:do_pcre_extract](../../../../.src/Utils/Utils.module#L216-L232), [Utils.module:Form_Close](../../../../.src/Utils/Utils.module#L239-L243), [Utils.module:Cdate_Comp2](../../../../.src/Utils/Utils.module#L379-L388), [Utils.module:Cdate_Com](../../../../.src/Utils/Utils.module#L409-L418), [Utils.module:convStr](../../../../.src/Utils/Utils.module#L495-L506), [Utils.module:Nsoc](../../../../.src/Utils/Utils.module#L809-L818), [Utils.module:Fcoulfond](../../../../.src/Utils/Utils.module#L844-L866), [Utils.module:PageFormatGetX](../../../../.src/Utils/Utils.module#L1460-L1478), [Utils.module:PageFormatGetY](../../../../.src/Utils/Utils.module#L1480-L1498)
- [ ] UTILS-003 — [code mort] Supprimer la variable `mysqlPort` (écrite par `glb`, jamais lue) ·
  appelants : aucun · tests : T18 · sources : [Utils.module:glb](../../../../.src/Utils/Utils.module#L93-L129), [Utils.module:16](../../../../.src/Utils/Utils.module#L16)
- [ ] UTILS-004 — [réduction de portée] `Recursive_Observers`, `Play`, `TunnelPid`, `ROArray` →
  `Private` (`Bip` appelle alors `Play()` sans préfixe) · appelants : aucun · tests : T23, replays · sources : [Utils.module:Recursive_Observers](../../../../.src/Utils/Utils.module#L869-L1008), [Utils.module:Play](../../../../.src/Utils/Utils.module#L1622-L1633), [Utils.module:Bip](../../../../.src/Utils/Utils.module#L1635-L1639), [Utils.module:24-26](../../../../.src/Utils/Utils.module#L24-L26)
- [ ] UTILS-005 — [commonalisation] `Base`/`Base2`/`Base3`/`Base4` : helper privé
  `RemplitGrille(tbv, qry) As Result` ; les quatre fonctions et `rs1`…`rs4` restent Public ·
  appelants : aucun (41 fichiers inchangés) · tests : T22 · sources : [Utils.module:Base](../../../../.src/Utils/Utils.module#L39-L49), [Utils.module:Base2](../../../../.src/Utils/Utils.module#L51-L61), [Utils.module:Base3](../../../../.src/Utils/Utils.module#L63-L73), [Utils.module:Base4](../../../../.src/Utils/Utils.module#L75-L85)
- [ ] UTILS-006 — [commonalisation] Helper privé `CouleurTheme(cle) As Integer` utilisé par
  `SetEditColor`, `Observers`, `ObsGotf`, `ObsLstf`, `ObsLstf2` (relecture des réglages à chaque
  appel conservée) · appelants : aucun · tests : T13, T23 · sources : [Utils.module:SetEditColor](../../../../.src/Utils/Utils.module#L539-L581), [Utils.module:Observers](../../../../.src/Utils/Utils.module#L1011-L1054), [Utils.module:ObsGotf](../../../../.src/Utils/Utils.module#L1056-L1070), [Utils.module:ObsLstf](../../../../.src/Utils/Utils.module#L1072-L1087), [Utils.module:ObsLstf2](../../../../.src/Utils/Utils.module#L1089-L1102)
- [ ] UTILS-007 — [complexité] `Recursive_Observers` et `Observers` : cascades `If … Is …` remplacées
  par des tableaux de noms de classes parcourus dans le **même ordre** (CC 48 → < 10) · appelants :
  aucun · tests : T23 (tous les replays dépendent des observateurs) · sources : [Utils.module:Recursive_Observers](../../../../.src/Utils/Utils.module#L869-L1008), [Utils.module:Observers](../../../../.src/Utils/Utils.module#L1011-L1054)
- [ ] UTILS-008 — [complexité] `Cdate_Comp` : une seule branche paramétrée par le séparateur
  (`-`, `.`, `/`), comportement identique, branche entière inchangée (voir A04) · appelants : aucun ·
  tests : T06 · sources : [Utils.module:Cdate_Comp](../../../../.src/Utils/Utils.module#L326-L377)
- [ ] UTILS-009 — [complexité] `Calcech` (CC 77) : découpage en sous-fonctions privées (calcul du
  décalage en mois, cas 45 jours, fin de mois, février) **uniquement** après la mise au vert de la
  matrice T09 ; aucune règle modifiée · appelants : aucun · tests : T09 · sources : [Utils.module:Calcech](../../../../.src/Utils/Utils.module#L657-L772)
- [ ] UTILS-010 — [commonalisation] `Remplace` appelle `ReplaceLb` puis retire les `\n` ; `Replace`,
  `Accent` et `mois` passent à des tables de correspondance (sorties identiques, y compris
  `ô` → `e`) · appelants : aucun · tests : T08, T10 · sources : [Utils.module:Remplace](../../../../.src/Utils/Utils.module#L774-L781), [Utils.module:ReplaceLb](../../../../.src/Utils/Utils.module#L783-L789), [Utils.module:Replace](../../../../.src/Utils/Utils.module#L791-L807), [Utils.module:Accent](../../../../.src/Utils/Utils.module#L1198-L1211), [Utils.module:mois](../../../../.src/Utils/Utils.module#L1213-L1246)
- [ ] UTILS-011 — [séparation traitement/GUI] Extraire des fonctions pures : `Cdate_Parse` (cœur de
  `Cdate_calc`), cœur de `FloatParse`, cœur de `Next_Code`, prédicat `EmailValide` (cœur de
  `chkEmail`) ; les `Message.*`, `Music.*` restent dans les fonctions Public existantes, mêmes textes ·
  appelants : aucun · tests : T02, T07, T11, T24 · sources : [Utils.module:Cdate_calc](../../../../.src/Utils/Utils.module#L450-L480), [Utils.module:FloatParse](../../../../.src/Utils/Utils.module#L1544-L1575), [Utils.module:Next_Code](../../../../.src/Utils/Utils.module#L1262-L1324), [Utils.module:chkEmail](../../../../.src/Utils/Utils.module#L1181-L1196)
- [ ] UTILS-012 — [séparation traitement/GUI] `fam` et `Fill_Civilite` : lecture des données
  (clés sélectionnées, libellés SQL) séparée de l'accès au contrôle ; requêtes identiques ·
  appelants : aucun · tests : T24 · sources : [Utils.module:fam](../../../../.src/Utils/Utils.module#L1439-L1452), [Utils.module:Fill_Civilite](../../../../.src/Utils/Utils.module#L1604-L1620)
- [ ] UTILS-013 — [complexité] `Commande` : boucle unique paramétrée par le nom de table (branche
  non-`Four` conservée telle quelle, voir A10) ; `SetEditColor` : `If hClass Is Container` au lieu de
  `Try hCont = hClass` · appelants : aucun · tests : T16, T23 · sources : [Utils.module:Commande](../../../../.src/Utils/Utils.module#L1135-L1170), [Utils.module:SetEditColor](../../../../.src/Utils/Utils.module#L539-L581)
- [ ] UTILS-014 — [réarchitecture] Shell MySQL : helper privé commun à `Fill_DataBase`,
  `Clear_DataBase`, `Create_DataBase`, mot de passe passé par `MYSQL_PWD` au lieu de `-p<mdp>`
  (sortie et effet identiques, mot de passe absent de `ps`) · appelants : `Start.module`, `FRestore`,
  `LauruxConf` (inchangés) · tests : T25 · sources : [Utils.module:Fill_DataBase](../../../../.src/Utils/Utils.module#L1500-L1530), [Utils.module:Clear_DataBase](../../../../.src/Utils/Utils.module#L1532-L1536), [Utils.module:Create_DataBase](../../../../.src/Utils/Utils.module#L1538-L1542)
- [ ] UTILS-015 — [commonalisation] `ChargeParamSsh()` Public, appelée par `glb` et par
  `LauruxConf.class:245-251` (même ordre d'affectation) · appelants : `LauruxConf` · tests : T18 · sources : [Utils.module:glb](../../../../.src/Utils/Utils.module#L93-L129), [LauruxConf.class:245-251](../../../../.src/Communs/LauruxConf.class#L245-L251)
- [ ] UTILS-016 — [documentation] Documenter dans le code les variables écrites mais non lues
  (`SshPassw`, `SshPassphrase`) et le rôle réel de `ControlTunnel` (contrôle de la réplication) ·
  appelants : aucun · tests : aucun · sources : [Utils.module:ControlTunnel](../../../../.src/Utils/Utils.module#L248-L263), [Utils.module:19-20](../../../../.src/Utils/Utils.module#L19-L20)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] UTILS-A01 — [anomalie] `ControlTunnel` (l. 254) : clé `" / dbase / Host "` erronée, options
  `- p`/`- e` mal formées, hôte sans `-h` ; le contrôle de réplication renvoie vraisemblablement
  toujours `False` (message « La réplication est inactive » au démarrage, `Start.module:113`, et
  dans `Fmenu`) · appelants : `Start`, `Fmenu`, `Facture` · tests : manuel (réplication) · sources : [Utils.module:254](../../../../.src/Utils/Utils.module#L254)
- [ ] UTILS-A02 — [anomalie] `fam` : sans nœud sélectionné, renvoie `" AND champ IN)"` (SQL invalide)
  au lieu de `""` ou d'un filtre vide · appelants : `Histocliart`, `Stockmvt` · tests : T24 · sources : [Utils.module:1443-1449](../../../../.src/Utils/Utils.module#L1443-L1449)
- [ ] UTILS-A03 — [anomalie] `Obstch` : `Or` au lieu de `And`, la condition est toujours vraie ;
  Entrée/Retour ajoutent `Key.Text` au filtre · appelants : 10 écrans `Tri*`, `FComptes`, `Facture`… ·
  tests : T24 · sources : [Utils.module:1106](../../../../.src/Utils/Utils.module#L1106)
- [ ] UTILS-A04 — [anomalie] `Cdate_Comp` branche entière : plages limitées à l'année 9999, `Lsl` au
  lieu d'une division, affectation d'une `String` (`.L`) à un `LDate` · appelants : `RelvMo`,
  `FTVA`, `BalanceM`, `ArchivesTck` (à vérifier : passent-ils des entiers ? ; `Validinv` retiré après
  le lot Gestion-2 : son appel est en commentaire) · tests : T06 · sources : [Utils.module:333-343](../../../../.src/Utils/Utils.module#L333-L343)
- [ ] UTILS-A05 — [anomalie, à confirmer] `Cdate_Cador`/`Cdate_Sage` : masques `"YYmmdd"`/`"ddmmYY"`
  en majuscules ; branche `Date` de `Cdate_Sage` inatteignable (paramètre `String`) · appelant :
  `ExportJdv` (exports Cador/Sage) · tests : T05 · sources : [Utils.module:433](../../../../.src/Utils/Utils.module#L433), [Utils.module:440-443](../../../../.src/Utils/Utils.module#L440-L443)
- [ ] UTILS-A06 — [anomalie] `monteTunnel` : `For i = 1 To $array_pid.Count` dépasse l'indice si la
  ligne `ps` ne contient pas de champ non vide · appelants : `Fmenu`, `Cmenu`, `LauruxConf` · tests :
  manuel · sources : [Utils.module:167-170](../../../../.src/Utils/Utils.module#L167-L170), [Utils.module:181-184](../../../../.src/Utils/Utils.module#L181-L184)
- [ ] UTILS-A07 — [anomalie] `Mkdir_p`/`Rmdir_rf` : chemin non quoté passé au shell ; un chemin avec
  espace crée/supprime d'autres répertoires (`rm -rf` dangereux) · appelant : `LGed` · tests : T20 · sources : [Utils.module:1690](../../../../.src/Utils/Utils.module#L1690), [Utils.module:1708](../../../../.src/Utils/Utils.module#L1708)
- [ ] UTILS-A08 — [anomalie, à confirmer] `ROArray` n'est jamais purgé : les `ReplayObserver` des
  écrans fermés restent référencés (croissance mémoire sur une longue session) · appelants : tous
  les écrans via `Observers` · tests : T23 + mesure mémoire · sources : [Utils.module:26](../../../../.src/Utils/Utils.module#L26), [Utils.module:Recursive_Observers](../../../../.src/Utils/Utils.module#L869-L1008)
- [ ] UTILS-A09 — [anomalie] `orientation` : la branche `FM` interroge la table `Bl` (au lieu de
  `Fiches_Bl` ?) ; `resregie` reste `Null` si `choix` ∉ {F, B} · appelants : `Facturefm`, `Archives` ·
  tests : T17 · sources : [Utils.module:1352](../../../../.src/Utils/Utils.module#L1352), [Utils.module:1366-1372](../../../../.src/Utils/Utils.module#L1366-L1372)
- [ ] UTILS-A10 — [anomalie] `Commande` branche `org <> "Four"` : colonnes `code`/`qte` inexistantes
  dans `Fiches_Ligbl` (erreur SQL puis `Null.Available`) ; branche sans appelant, à supprimer ou à
  corriger (`code_ligbl`, `qte_ligbl`) · appelants : aucun · tests : T16 · sources : [Utils.module:1155-1166](../../../../.src/Utils/Utils.module#L1155-L1166)
- [ ] UTILS-A11 — [anomalie, à confirmer] `arrondi`, `totobs`, `Calcode` dépendent de la locale
  (`Str$`, `IsNumber`, `Val`) : résultats différents hors locale française · appelants : `ObjFacB`,
  `ObjFac`, `Stockmvt`, `Articles`… · tests : T03, T04, T12 (deux locales) · sources : [Utils.module:1422-1424](../../../../.src/Utils/Utils.module#L1422-L1424), [Utils.module:1388-1389](../../../../.src/Utils/Utils.module#L1388-L1389), [Utils.module:603](../../../../.src/Utils/Utils.module#L603)
- [ ] UTILS-A12 — [anomalie] `Accent` remplace `ô` par `e` au lieu de `o` · appelants : `SaiTableau`
  et 2 fichiers via `With Utils` · tests : T10 · sources : [Utils.module:1205](../../../../.src/Utils/Utils.module#L1205)
