# Start — Rework

> Source : `.src/Start.module` · Message de commit (phase 4) : `reference/.src/Start.module/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 411 |
| Lignes de commentaire | 21 |
| Fonctions | 10 |
| Fonctions Public | 10 |
| Complexité cyclomatique totale | 115 |
| Complexité max (fonction) | 35 (`Lancement`) |
| Variables globales | 51 |
| Variables Public | 51 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 411 | 115 | 35 | 51 | 10 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] START-001 — [documentation] En-tête du module en français : rôle (démarrage, ligne de
  commande, état global), séquence `Main` → `Lancement` → `Utils.Exit` → `Application_Signal`,
  tableau des options de `Parse_Args` (le 4ᵉ argument de `Args.Get` n'est pas une valeur par
  défaut), commentaire `'` sur chaque globale `Public` (rôle, écrivains) · appelants : aucun ·
  tests : T01 · sources : [Start.module:Main](../../../.src/Start.module#L67-L207), [Start.module:Parse_Args](../../../.src/Start.module#L409-L455)
- [ ] START-002 — [code mort] Supprimer les globales jamais lues `Nstockes`, `Suspendus`,
  `StartDate` (et leurs affectations dans `Main`/`Lancement`) — `$cai` retiré de la liste après le lot
  Caisse : `Start.$Cai` est lu par `Caisse.class:921,977` et écrit par `Svendeur.class:45` —, les `Private` inutilisées
  `hpb`, `hlb`, les locales inutilisées (`$cle`, `$cle2`, `txt`, `sha`, `bcle` dans `Main`, `wa` dans
  `Lancement`) et la seconde copie du bloc de valeurs par défaut `Proform`…`Facture` (l. 289-293,
  sans effet après la première) · appelants : aucun (grep : aucun lecteur externe) · tests : T03,
  T10, T16 · sources : [Start.module:19-20](../../../.src/Start.module#L19-L20), [Start.module:23](../../../.src/Start.module#L23), [Start.module:31](../../../.src/Start.module#L31), [Start.module:33](../../../.src/Start.module#L33), [Start.module:35](../../../.src/Start.module#L35), [Start.module:69-70](../../../.src/Start.module#L69-L70), [Start.module:289-293](../../../.src/Start.module#L289-L293)
- [ ] START-003 — [réduction de portée] `Lock`, `Lancement`, `Parse_Args`, `Start_Test` →
  `Private` (aucun appelant externe ; couverts par les replays T03-T17). `Coul` reste `Public`
  (testé directement par gb.test, T09) ; `Application_Signal` et `ReplayTimer_Timer` restent
  `Public` (handlers) · appelants : aucun · tests : T03-T17 · sources : [Start.module:Lock](../../../.src/Start.module#L263-L270), [Start.module:Lancement](../../../.src/Start.module#L273-L377), [Start.module:Parse_Args](../../../.src/Start.module#L409-L455), [Start.module:Start_Test](../../../.src/Start.module#L473-L516)
- [ ] START-004 — [séparation traitement/GUI] Extraire de `UnLock` une fonction pure
  `RetirePid(sPids As String, iPid As Integer) As String` (`Public` pour gb.test) reproduisant
  **exactement** les trois `Replace$` actuels ; `UnLock` garde la lecture/écriture du fichier ·
  appelants : aucun (signature de `UnLock` inchangée) · tests : T07, T08 · sources : [Start.module:UnLock](../../../.src/Start.module#L244-L261)
- [ ] START-005 — [complexité] `Main` : extraire `InitLogs()`, `InitSociete()`,
  `CouleursParDefaut()` (écriture des clés `/Coul`, condition `If Error Or …` conservée en passant
  l'état d'erreur en paramètre) et `ControleVerrou() As Boolean` ; ordre des effets inchangé
  (CC 34 → ≤ 12 visé) · appelants : `Fsoc` (appelle `Start.Main`, signature inchangée) · tests : T06,
  T07, T10, T14, T15, T17 · sources : [Start.module:Main](../../../.src/Start.module#L67-L207)
- [ ] START-006 — [complexité] `Lancement` : extraire `InitCaisse()` (police, `$tcai`) et
  `ChargeReplay()` (lecture du log, armement du timer), en conservant la locale `ev` qui masque `Ev`
  tant que START-A01 n'est pas validée (CC 35 → ≤ 12 visé) · appelants : aucun · tests : T11, T12,
  T16 · sources : [Start.module:Lancement](../../../.src/Start.module#L273-L377)
- [ ] START-007 — [réduction de portée] Globales sans lecteur externe → `Private` :
  `Arg_Config_File`, `Arg_Test`, `Arg_Start_Societe`, `Arg_Restore_DB`, `hReplayTimer`, `Evens`,
  `Ev`, `Evc`, `Evl` ; `Lig2` et `Fontes` deviennent des locales (`Coul`, `Main`, `Lancement`) ·
  appelants : aucun (grep `Start\.<nom>` sans résultat hors du module) · tests : T03, T06, T11, T13 ·
  sources : [Start.module:39-56](../../../.src/Start.module#L39-L56), [Start.module:21-22](../../../.src/Start.module#L21-L22)
- [ ] START-008 — [commonalisation] Valeurs par défaut des couleurs `/Coul/*` lues depuis les
  constantes communes de SETCOLORS-005 (partagées avec `Fmenu.preferences` FMENU-013 et
  `LauruxConf` LAURUXCONF-010), chaînes conservées caractère pour caractère (séparateur `;` et
  double écriture de `Coulfonds`/`Others` comprises) · appelants : `Fmenu`, `SetColors`,
  `LauruxConf` (via leurs propres cases) · tests : T10 · sources : [Start.module:132-158](../../../.src/Start.module#L132-L158), [SetColors.class:Button2_Click](../../../.src/Utils/SetColors.class#L103-L116), [Fmenu.class:437-456](../../../.src/Communs/Fmenu.class#L437-L456)
- [ ] START-009 — [commonalisation] Contrôle de réplication par `Utils.ReplicationOK` (FMENU-004),
  même message « La réplication est inactive ! … » et même `Return` · appelants : `Fmenu`,
  `Facture` (via FMENU-004/005) · tests : T15 · sources : [Start.module:112-118](../../../.src/Start.module#L112-L118), [Fmenu.class:Menu21_Click](../../../.src/Communs/Fmenu.class#L648-L663)
- [ ] START-010 — [commonalisation] Répertoire `~/tmp/Debug` par `Utils.DebugDir()` (partagé avec
  `LLog._new` et `DB_Connection.Start`, voir LLog) · appelants : `LLog`, `DB_Connection` · tests :
  T14 · sources : [Start.module:94-99](../../../.src/Start.module#L94-L99), [LLog.class:_new](../../../.src/Utils/LLog.class#L23-L41), [DB_Connection.class:Start](../../../.src/Utils/DB_Connection.class#L48-L97)
- [ ] START-011 — [commonalisation] Filtre des lignes rejouables (`Like "*;GUI;*"`) par le parseur
  commun du format de log (DB_CONNECTION-013, positions en `Enum`) · appelants : `DB_Connection`,
  `DB_Log`, `ReplayObserver` · tests : T11 · sources : [Start.module:346-352](../../../.src/Start.module#L346-L352), [DB_Connection.class:GUI_Event](../../../.src/Utils/DB_Connection.class#L705-L724)
- [ ] START-012 — [réarchitecture] Remplacer `Start_Test` et l'option `-t` par le harnais gb.test
  (`./Laurux -T <tests|all|list>`, reproduisant `gbx3 -T`, PLAN §0) une fois les `Internal_Test` de
  `LPrix` et `LScript` convertis ; conserver la sortie `-t list` tant que des scripts l'utilisent
  (à confirmer avec l'utilisateur) · appelants : `LPrix`, `LScript` (suppression de
  `Internal_Test`), `TESTING.md`, `README.md` · tests : T03-T05 · sources : [Start.module:Start_Test](../../../.src/Start.module#L473-L516), [LPrix.class:Internal_Test](../../../.src/Utils/LPrix.class#L685-L781), [LScript.class:Internal_Test](../../../.src/Utils/LScript.class#L90-L134)
- [ ] START-013 — [réduction de portée] `Musique` → `Public Const Musique As String =
  "son/warning.ogg"` (aucun écrivain ; 176 lecteurs inchangés), sous réserve de compilation `gbc3`
  · appelants : aucun changement de source · tests : T03 · sources : [Start.module:9](../../../.src/Start.module#L9)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] START-A01 — [anomalie] Rejeu : `Evl = Evc = 0` affecte `(Evc = 0)` à `Evl` (`-1`), ce qui
  compense la borne `Evc <= Evl` de `ReplayTimer_Timer` au premier lancement ; `Evc` n'est jamais
  remis à zéro (rejeu faux ou dépassement d'indice après un redémarrage) ; la locale `ev` masque la
  globale `Ev` (délai du premier événement). Correction : `Evc = 0`, `Evl = Evens.Count`, borne
  `Evc < Evl`, suppression de la locale `ev` · tests : T11, T12 · sources : [Start.module:277](../../../.src/Start.module#L277), [Start.module:343-344](../../../.src/Start.module#L343-L344), [Start.module:ReplayTimer_Timer](../../../.src/Start.module#L387-L406)
- [ ] START-A02 — [anomalie] `Start_Test` (et le cas « log introuvable » du rejeu) appellent
  `Utils.Exit`, qui envoie `SIGINT`, **avant** `Signal[Signal.SIGINT].Catch` : code de sortie
  possiblement 130 au lieu de 0/1 (à confirmer par T04) ; correction : installer le `Catch` en début
  de `Lancement` · tests : T04, T11 · sources : [Start.module:359](../../../.src/Start.module#L359), [Start.module:363-367](../../../.src/Start.module#L363-L367), [Utils.module:Exit](../../../.src/Utils/Utils.module#L30-L36)
- [ ] START-A03 — [anomalie] `Coul` : en cas d'erreur sur `/Coul/Others`, le repli `229;233;255`
  est écrit dans `R2/G2/B2` au lieu de `R/G/B` ; seul le dernier `Try` est contrôlé · tests : T09 ·
  sources : [Start.module:220-224](../../../.src/Start.module#L220-L224)
- [ ] START-A04 — [anomalie] `UnLock` retire le PID par remplacement de sous-chaîne : un autre PID
  qui contient le PID courant est corrompu (`"5123 7"` → `"57"` pour le PID 123) ; correction par
  découpage sur les espaces · tests : T08 · sources : [Start.module:UnLock](../../../.src/Start.module#L244-L261)
- [ ] START-A05 — [anomalie] `Restore_Args` restaure `"Laurux" & Societe` sans `/dbase/Prefixe`,
  alors que `Main` ouvre `<Prefixe>Laurux<XX>` (à confirmer) · appelants : `Fmenu.Form_Open` ·
  tests : T13 · sources : [Start.module:Restore_Args](../../../.src/Start.module#L457-L471), [Start.module:109](../../../.src/Start.module#L109)
- [ ] START-A06 — [anomalie] Réinitialisation des couleurs conditionnée par `If Error`, qui reflète
  le `Try Son = …/son` de la ligne 120 : une valeur `/son` invalide réécrit les 23 clés `/Coul`
  (à confirmer) · tests : T10 · sources : [Start.module:120](../../../.src/Start.module#L120), [Start.module:132](../../../.src/Start.module#L132)
- [ ] START-A07 — [anomalie] `Fsoc.Soclist_Click` relance `Start.Main()` depuis un gestionnaire
  d'événement (appel récursif, pile croissante à chaque changement de société) au lieu d'utiliser
  `Start.Restart` comme `LauruxConf.Form_Close` ; à reporter dans la documentation de `Fsoc` ·
  appelants : `Fsoc` · tests : T17 · sources : [Fsoc.class:Soclist_Click](../../../.src/Communs/Fsoc.class#L600-L630), [LauruxConf.class:Form_Close](../../../.src/Communs/LauruxConf.class#L426-L468)
- [ ] START-A08 — [anomalie] État non réinitialisé au redémarrage : `Start.Caisse` n'est jamais
  remis à `False`, le fichier de log rejoué n'est jamais fermé, `Args.Begin` est rappelé à chaque
  itération (effet à confirmer) · tests : T12, T17 · sources : [Start.module:322](../../../.src/Start.module#L322), [Start.module:342](../../../.src/Start.module#L342), [Start.module:415](../../../.src/Start.module#L415)
