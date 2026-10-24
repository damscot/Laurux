# DB_Connection — Rework

> Source : `.src/Utils/DB_Connection.class` · Message de commit (phase 4) : `reference/.src/Utils/DB_Connection.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 561 |
| Lignes de commentaire | 42 |
| Fonctions | 34 |
| Fonctions Public | 34 |
| Complexité cyclomatique totale | 162 |
| Complexité max (fonction) | 42 (`Exec`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 561 | 162 | 42 | 0 | 34 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] DB_CONNECTION-001 — [documentation] En-tête de classe en français : quatre rôles, singleton
  `Utils.db`, format des lignes de log (`Exec_SQL`, `GUI`, `Log`), tableau des règles de réécriture
  SQLite ; commentaires `'''` sur chaque méthode Public · appelants : aucun · tests : aucun · sources : [DB_Connection.class:Exec](../../../../.src/Utils/DB_Connection.class#L317-L450), [DB_Connection.class:GUI_Event](../../../../.src/Utils/DB_Connection.class#L705-L724)
- [ ] DB_CONNECTION-002 — [code mort] Supprimer les variables inutilisées (`hFile`, `patrn`, `ctx`,
  `filterlist`, `DteInv`, `res`/`res1` de `Lockstock`, `$user`), le bloc `With utils` de
  `LockIncrement`, le `Default` redondant d'`IsType` · appelants : aucun · tests : T07, T09, T10 · sources : [DB_Connection.class:Lockstock](../../../../.src/Utils/DB_Connection.class#L521-L551), [DB_Connection.class:LockIncrement](../../../../.src/Utils/DB_Connection.class#L553-L592), [DB_Connection.class:IsType](../../../../.src/Utils/DB_Connection.class#L289-L301), [DB_Connection.class:Get_Filter](../../../../.src/Utils/DB_Connection.class#L163-L172), [DB_Connection.class:Print](../../../../.src/Utils/DB_Connection.class#L737-L756)
- [ ] DB_CONNECTION-003 — [complexité] Extraire la réécriture SQLite d'`Exec` en fonction privée
  `SqliteRewrite(Request) As String` (comportement identique, `Message.Error` conservés à
  l'identique dans un premier temps) ; CC d'`Exec` 42 → ≤ 10 visé · appelants : aucun · tests : T03, T04, T08 · sources : [DB_Connection.class:Exec](../../../../.src/Utils/DB_Connection.class#L317-L450), [DB_Connection.class:355-433](../../../../.src/Utils/DB_Connection.class#L355-L433)
- [ ] DB_CONNECTION-004 — [commonalisation] Helper privé `SubstParam(Request, Param)` pour les trois
  copies du bloc `Object.Call(Me, "Subst", …)` (`Exec`, `Prepare`, `Edit`) · appelants : aucun · tests : T01, T12, T14 · sources : [DB_Connection.class:Exec](../../../../.src/Utils/DB_Connection.class#L317-L450), [DB_Connection.class:Prepare](../../../../.src/Utils/DB_Connection.class#L452-L481), [DB_Connection.class:Edit](../../../../.src/Utils/DB_Connection.class#L656-L702)
- [ ] DB_CONNECTION-005 — [commonalisation] Helper privé `LogLine(sType, iSkip, sMessage, level)` pour
  les 5 écritures de log (`Exec`, `Edit`, `Create9`, `GUI_Event`, `Log_Event`), format **identique**
  octet pour octet · appelants : aucun · tests : T02, T05, T06, T15 · sources : [DB_Connection.class:Exec](../../../../.src/Utils/DB_Connection.class#L317-L450), [DB_Connection.class:Edit](../../../../.src/Utils/DB_Connection.class#L656-L702), [DB_Connection.class:Create9](../../../../.src/Utils/DB_Connection.class#L617-L644), [DB_Connection.class:GUI_Event](../../../../.src/Utils/DB_Connection.class#L705-L724), [DB_Connection.class:Log_Event](../../../../.src/Utils/DB_Connection.class#L726-L735)
- [ ] DB_CONNECTION-006 — [complexité] `SqliteRewrite` : table de règles (déclencheur, regex,
  remplacement) pour les règles 1 à 9, boucle unique · appelants : aucun · tests : T03, T04 · sources : [DB_Connection.class:361-374](../../../../.src/Utils/DB_Connection.class#L361-L374)
- [ ] DB_CONNECTION-007 — [séparation traitement/GUI] `SqliteRewrite` pure : erreurs de regex
  renvoyées à `Exec`, qui affiche les mêmes `Message.Error` · appelants : aucun · tests : T03 · sources : [DB_Connection.class:377-421](../../../../.src/Utils/DB_Connection.class#L377-L421)
- [ ] DB_CONNECTION-008 — [réduction de portée] `Start`, `Set_Level`, `Refresh_Filter`, `Is_Filtered`
  → `Private` (couverts par `Exec`/`DB_Log`/T05) · appelants : aucun · tests : T02, T05 · sources : [DB_Connection.class:Start](../../../../.src/Utils/DB_Connection.class#L48-L97), [DB_Connection.class:Set_Level](../../../../.src/Utils/DB_Connection.class#L131-L137), [DB_Connection.class:Refresh_Filter](../../../../.src/Utils/DB_Connection.class#L184-L222), [DB_Connection.class:Is_Filtered](../../../../.src/Utils/DB_Connection.class#L256-L277)
- [ ] DB_CONNECTION-009 — [code mort] Supprimer `Enable_Log`, `Disable_Log`, `Print` (aucun appelant,
  vérifié par grep) · appelants : aucun · tests : tous · sources : [DB_Connection.class:Enable_Log](../../../../.src/Utils/DB_Connection.class#L139-L143), [DB_Connection.class:Disable_Log](../../../../.src/Utils/DB_Connection.class#L145-L149), [DB_Connection.class:Print](../../../../.src/Utils/DB_Connection.class#L737-L756)
- [ ] DB_CONNECTION-010 — [réarchitecture] Renommer la méthode `Start` (privée après 008) en
  `Demarrer_Log` pour lever la confusion avec le module global `Start` ; séparer `hFilePath` en
  `$sLogPath` / `$sFilterPath` · appelants : aucun · tests : T02, T05, T15 · sources : [DB_Connection.class:Start](../../../../.src/Utils/DB_Connection.class#L48-L97), [DB_Connection.class:Get_Filter](../../../../.src/Utils/DB_Connection.class#L163-L172), [DB_Connection.class:Set_Filter](../../../../.src/Utils/DB_Connection.class#L175-L182)
- [ ] DB_CONNECTION-011 — [commonalisation] `Lockstock` et `RecArt` : `Cbase.Table("TabArt")`,
  `Cbase.Table("TabTvav")` au lieu des noms en dur (`Fiches_regie` sans entrée `Cbase` : laissé tel
  quel, à confirmer) ; `utils.db` → `Me` · appelants : `Achat` (inchangé) · tests : T09, T11 · sources : [DB_Connection.class:Lockstock](../../../../.src/Utils/DB_Connection.class#L521-L551), [DB_Connection.class:RecArt](../../../../.src/Utils/DB_Connection.class#L594-L615)
- [ ] DB_CONNECTION-012 — [séparation traitement/GUI] `LockIncrement` : calcul et contrôle dans une
  fonction privée renvoyant un code ; `Message.Error` identiques en fin de fonction · appelants :
  `Caisse`, `Moulinage`, `EcrAuto`, `commande1` (inchangés) · tests : T10 · sources : [DB_Connection.class:LockIncrement](../../../../.src/Utils/DB_Connection.class#L553-L592)
- [ ] DB_CONNECTION-013 — [commonalisation] `Public Enum` des positions de champs du log, partagée avec
  `DB_Log` et `ReplayObserver` (voir DB_LOG-004, REPLAYOBSERVER-004) · appelants : `DB_Log`,
  `ReplayObserver` · tests : T02, T06, T15 · sources : [DB_Connection.class:GUI_Event](../../../../.src/Utils/DB_Connection.class#L705-L724), [DB_Log.class:Refresh](../../../../.src/Utils/DB_Log.class#L48-L89), [ReplayObserver.class:Replay_Event](../../../../.src/Utils/ReplayObserver.class#L229-L359)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] DB_CONNECTION-A01 — [anomalie] SQLite : `COLLATE NOCASE` est inséré avant la première
  occurrence **textuelle** de `ORDER` (ligne 426) : `Fiches_Bordereaux`, `Fiches_BordereauxC`, la
  colonne `bordereau` ou un littéral `'…BORDEREAU…'` sont coupés ; requête cassée ou **valeur écrite
  corrompue** ; de plus la clause ne s'applique qu'au dernier terme du `WHERE` · tests : T03, T04 · sources : [DB_Connection.class:425-432](../../../../.src/Utils/DB_Connection.class#L425-L432)
- [ ] DB_CONNECTION-A02 — [anomalie] SQLite : `LEFT(x,n)` → `substr(x,0,n)` renvoie n-1 caractères
  (règle 6), alors que la règle 11 corrige en `n+1` · tests : T03, T04 · sources : [DB_Connection.class:370](../../../../.src/Utils/DB_Connection.class#L370), [DB_Connection.class:405](../../../../.src/Utils/DB_Connection.class#L405)
- [ ] DB_CONNECTION-A03 — [anomalie] SQLite : `abs(x) ` → `CAST(x) AS INTEGER) ` (ligne 423) : SQL
  invalide et sémantique différente (SQLite connaît `abs`) · tests : T03, T04 · sources : [DB_Connection.class:423](../../../../.src/Utils/DB_Connection.class#L423)
- [ ] DB_CONNECTION-A04 — [anomalie] SQLite : `CopieTable` génère le DDL par `SELECT` sans l'exécuter ;
  la table destination n'est pas créée (clôture annuelle `FClotureAn`) · tests : T13 · sources : [DB_Connection.class:CopieTable](../../../../.src/Utils/DB_Connection.class#L646-L654), [DB_Connection.class:649](../../../../.src/Utils/DB_Connection.class#L649)
- [ ] DB_CONNECTION-A05 — [anomalie] SQLite : `Execute` évalue le SQL comme expression Gambas
  (`Eval("Me.Exec(" & sql & ")")`) ; MySQL : `Prepare` n'échappe pas les quotes ; `Set` exécute
  `Exec("")` pour un type non prévu · tests : T12 · sources : [DB_Connection.class:Prepare](../../../../.src/Utils/DB_Connection.class#L452-L481), [DB_Connection.class:Set](../../../../.src/Utils/DB_Connection.class#L483-L506), [DB_Connection.class:Execute](../../../../.src/Utils/DB_Connection.class#L508-L519), [DB_Connection.class:513](../../../../.src/Utils/DB_Connection.class#L513), [DB_Connection.class:477](../../../../.src/Utils/DB_Connection.class#L477)
- [ ] DB_CONNECTION-A06 — [anomalie] `Start` : condition `Or` (ligne 84) ; un `NetHandler` est créé
  dès que `ServerLogIP` est renseigné (défaut `127.0.0.1` de `Prefs`), même sans port valide · tests : T02 · sources : [DB_Connection.class:84](../../../../.src/Utils/DB_Connection.class#L84)
- [ ] DB_CONNECTION-A07 — [anomalie] `Is_Filtered` : `regex.Count >= 0` toujours vrai (à confirmer) ;
  `Refresh_Filter` traite une ligne sans `:` comme un filtre valide · tests : T05 · sources : [DB_Connection.class:Is_Filtered](../../../../.src/Utils/DB_Connection.class#L256-L277), [DB_Connection.class:269](../../../../.src/Utils/DB_Connection.class#L269), [DB_Connection.class:Refresh_Filter](../../../../.src/Utils/DB_Connection.class#L184-L222), [DB_Connection.class:198-202](../../../../.src/Utils/DB_Connection.class#L198-L202)
- [ ] DB_CONNECTION-A08 — [anomalie] `Exec` : le curseur reste en attente après une erreur SQL
  (`MouseDefault` sauté) ; test `Utils.db.Opened` au lieu de `Me.Opened` · tests : T08 · sources : [DB_Connection.class:436-448](../../../../.src/Utils/DB_Connection.class#L436-L448)
- [ ] DB_CONNECTION-A09 — [anomalie] `LockIncrement` : `rResult.Available And rResult.Available`
  (ligne 574) au lieu de tester `rResult2` · tests : T10 · sources : [DB_Connection.class:574](../../../../.src/Utils/DB_Connection.class#L574)
- [ ] DB_CONNECTION-A10 — [anomalie] `GUI_Event` : valeurs non échappées (`;`, `#`, `@`, `=`, saut de
  ligne) ; ligne de log non rejouable · tests : T06, T15 · sources : [DB_Connection.class:GUI_Event](../../../../.src/Utils/DB_Connection.class#L705-L724), [DB_Connection.class:708](../../../../.src/Utils/DB_Connection.class#L708)
- [ ] DB_CONNECTION-A11 — [anomalie] SQLite : `NOW()` → date sans heure ; `DAY(` touche aussi
  `WEEKDAY(` ; `CONCAT` limité à 2 arguments · tests : T03 · sources : [DB_Connection.class:363](../../../../.src/Utils/DB_Connection.class#L363), [DB_Connection.class:364](../../../../.src/Utils/DB_Connection.class#L364), [DB_Connection.class:367](../../../../.src/Utils/DB_Connection.class#L367)
