# Fsoc — Rework

> Source : `.src/Communs/Fsoc.class` · Message de commit (phase 4) : `reference/.src/Communs/Fsoc.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 488 |
| Lignes de commentaire | 40 |
| Fonctions | 20 |
| Fonctions Public | 20 |
| Complexité cyclomatique totale | 113 |
| Complexité max (fonction) | 30 (`Soc_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 488 | 113 | 30 | 0 | 20 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] FSOC-001 — [documentation] En-tête en français (rôle, appelants, dépendance MySQL, séquence de
  changement de société) et commentaires `'''` sur chaque fonction ; suppression de l'en-tête
  `' Gambas class file` dupliqué · appelants : aucun · tests : aucun · sources : [Fsoc.class:1-27](../../../../.src/Communs/Fsoc.class#L1-L27), [Fsoc.class:_New](../../../../.src/Communs/Fsoc.class#L41-L60)
- [ ] FSOC-002 — [code mort] Supprimer `Nsoc` (aucun appel, copie de `Utils.Nsoc`),
  `Nbase_MouseDown` (aucun contrôle `Nbase` dans le `.form`), les variables `Soc1` et `chkNbase`
  (écrites, jamais lues) et la variable locale `siren` de `Button1_Click` · appelants : aucun ·
  tests : T01-T03 · sources : [Fsoc.class:Nsoc](../../../../.src/Communs/Fsoc.class#L155-L162), [Fsoc.class:Nbase_MouseDown](../../../../.src/Communs/Fsoc.class#L593-L598), [Fsoc.class:32](../../../../.src/Communs/Fsoc.class#L32), [Fsoc.class:38](../../../../.src/Communs/Fsoc.class#L38), [Fsoc.class:457-459](../../../../.src/Communs/Fsoc.class#L457-L459)
- [ ] FSOC-003 — [réduction de portée] `Recup_Soc`, `Init_base`, `Init_Civilite`, `Maj_Zones`,
  `cleanChamps`, `Refresh` → `Private` ; variables d'instance `Tab`, `Lig`, `cs`, `Soc` → locales ·
  appelants : aucun · tests : T01-T06, T12 · sources : [Fsoc.class:Recup_Soc](../../../../.src/Communs/Fsoc.class#L62-L72), [Fsoc.class:Init_base](../../../../.src/Communs/Fsoc.class#L84-L135), [Fsoc.class:Init_Civilite](../../../../.src/Communs/Fsoc.class#L137-L153), [Fsoc.class:Maj_Zones](../../../../.src/Communs/Fsoc.class#L164-L199), [Fsoc.class:cleanChamps](../../../../.src/Communs/Fsoc.class#L201-L225), [Fsoc.class:Refresh](../../../../.src/Communs/Fsoc.class#L227-L235)
- [ ] FSOC-004 — [documentation] Noms de tables par `Cbase.Table("TabSoc")` /
  `Cbase.Table("TabIdentite")` (y compris dans les requêtes qualifiées `<base>.<table>`) ; SQL
  émis identique · appelants : aucun · tests : T01-T04 · sources : [Fsoc.class:Init_base](../../../../.src/Communs/Fsoc.class#L84-L135), [Fsoc.class:Init_Civilite](../../../../.src/Communs/Fsoc.class#L137-L153), [Fsoc.class:Maj_Zones](../../../../.src/Communs/Fsoc.class#L164-L199), [Fsoc.class:Button1_Click](../../../../.src/Communs/Fsoc.class#L449-L511)
- [ ] FSOC-005 — [complexité] `Soc_KeyPress` : table `tag → contrôle suivant` pour les 16 cas de
  navigation simple, cas 1, 11, 12 et F1 conservés à l'identique (`Stop Event` compris) ; CC 30 →
  ≤ 8 visé · appelants : aucun · tests : T07-T10 · sources : [Fsoc.class:Soc_KeyPress](../../../../.src/Communs/Fsoc.class#L237-L377)
- [ ] FSOC-006 — [commonalisation] Helper privé `ChoisirSociete(sCode, sIntitule, sBase)` pour
  l'écriture `/Soc`, `/intitule`, `/dbase/Name`, `Save`, `Reload`, `Start.Societe` (deux copies
  après FSOC-011), ordre des écritures conservé · appelants : aucun · tests : T03, T06 · sources : [Fsoc.class:489-495](../../../../.src/Communs/Fsoc.class#L489-L495), [Fsoc.class:612-618](../../../../.src/Communs/Fsoc.class#L612-L618)
- [ ] FSOC-007 — [commonalisation] Séquence de reconnexion de `Soclist_Click` (après FSOC-011)
  remplacée par `Utils.OuvreBase(sNom)` (créé par LAURUXCONF-004), mêmes instructions dans le même
  ordre · appelants : `LauruxConf`, `Fmenu` (même commit que LAURUXCONF-004) · tests : T06,
  LAURUXCONF-T02 · sources : [Fsoc.class:603-610](../../../../.src/Communs/Fsoc.class#L603-L610), [LauruxConf.class:274-280](../../../../.src/Communs/LauruxConf.class#L274-L280), [Fmenu.class:175](../../../../.src/Communs/Fmenu.class#L175)
- [ ] FSOC-008 — [commonalisation] Détection des bases Laurux par `Utils.BasesLaurux(bPrefixe)`
  (créé par LAURUXCONF-005), règle actuelle conservée pour chaque appelant · appelants : `LauruxConf`,
  `Dup` · tests : T01, T03, T11, LAURUXCONF-T01 · sources : [Fsoc.class:93-112](../../../../.src/Communs/Fsoc.class#L93-L112), [Fsoc.class:461-473](../../../../.src/Communs/Fsoc.class#L461-L473), [LauruxConf.class:58-87](../../../../.src/Communs/LauruxConf.class#L58-L87)
- [ ] FSOC-009 — [commonalisation] Nettoyage du SIREN par un helper `CTestTVA.Siren(sSiret)`
  (corrigé après le lot Gestion : `FFournisseur` ne nettoie aucun SIREN, seul l'appel
  `CTestTVA.isIntraComValide` est commun ; le helper ne sert donc qu'à `Fsoc`) · appelants : aucun · tests : T07, T08 · sources : [Fsoc.class:305-306](../../../../.src/Communs/Fsoc.class#L305-L306), [Fsoc.class:317-318](../../../../.src/Communs/Fsoc.class#L317-L318), [CTestTVA.class:isIntraComValide](../../../../.src/Utils/CTestTVA.class#L13-L48)
- [ ] FSOC-010 — [séparation traitement/GUI] Extraire `EnregistreSociete(sBase, aValeurs)`
  (SELECT/TRUNCATE/INSERT), `LitSociete(sCode) As Result` et `SupprimeBase(sBase)` sans accès aux
  contrôles, appelées par `Button1_Click`, `Maj_Zones` et `Button3_Click` · appelants : aucun ·
  tests : T02-T04 · sources : [Fsoc.class:Button1_Click](../../../../.src/Communs/Fsoc.class#L449-L511), [Fsoc.class:Maj_Zones](../../../../.src/Communs/Fsoc.class#L164-L199), [Fsoc.class:Button3_Click](../../../../.src/Communs/Fsoc.class#L513-L548)

- [ ] FSOC-011 — [code mort] Supprimer `Button4_Click` : `Button4` (« Créer », tag 2) est dans le
  groupe `Btn`, dont le handler `Btn_Click` traite le tag 2 par `cleanChamps()` ; aucun appel
  (vérifié par `grep`, handler nominal inactif signalé par `deps.py`). Pas de modification du
  `.form`. **À exécuter avant FSOC-006 et FSOC-007** · appelants : aucun · tests : T03, T05
  (bouton « Créer »), T06 · sources : [Fsoc.class:Button4_Click](../../../../.src/Communs/Fsoc.class#L550-L585), [Fsoc.class:Btn_Click](../../../../.src/Communs/Fsoc.class#L379-L413)
### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] FSOC-A01 — [anomalie] `Button3_Click` : message « Société  supprimée » (variable `Tables`
  jamais affectée) ; `If Not Error` sans `Try` rend la branche « Suppression impossible »
  inatteignable (l'erreur part dans le `Catch`) · tests : T04 · sources : [Fsoc.class:515](../../../../.src/Communs/Fsoc.class#L515), [Fsoc.class:521-524](../../../../.src/Communs/Fsoc.class#L521-L524), [Fsoc.class:534-537](../../../../.src/Communs/Fsoc.class#L534-L537)
- [ ] FSOC-A02 — [anomalie] Suppression : `DROP DATABASE Laurux<code>` ignore le préfixe, peut
  supprimer la base **courante**, et remet à vide des clés incohérentes (`Soc` sans `/`,
  `/Societes/Soc`, `/Societes/intitule`) au lieu de `/Soc`, `/intitule`, `/dbase/Name` : la
  configuration pointe ensuite vers une base supprimée · tests : T04 · sources : [Fsoc.class:521](../../../../.src/Communs/Fsoc.class#L521), [Fsoc.class:525-527](../../../../.src/Communs/Fsoc.class#L525-L527)
- [ ] FSOC-A03 — [anomalie] Préfixe de base ignoré par `Button1_Click` (recherche de
  `Laurux<code>`, `Createbase("Laurux" & code)`, `INSERT` dans `Laurux<code>`) , alors que `/dbase/Name` est écrit avec
  `/dbase/Prefixe` · tests : T03, T11 · sources : [Fsoc.class:461-484](../../../../.src/Communs/Fsoc.class#L461-L484)
- [ ] FSOC-A04 — [anomalie] `Soc_KeyPress` tag 12 : un n° TVA **valide** ne fait pas passer au champ
  `Capital` (seul `Stop Event`), un n° **invalide** affiche l'avertissement puis y passe (logique
  inversée par le commentaire `'ELSE`) · tests : T08 · sources : [Fsoc.class:320-332](../../../../.src/Communs/Fsoc.class#L320-L332)
- [ ] FSOC-A05 — [anomalie] `Button1_Click` ne reconnecte pas `Utils.db` alors qu'il change
  `Start.Societe` et `/dbase/Name` : après création d'une société, la session travaille sur
  l'ancienne base avec le code de la nouvelle · tests : T03 · sources : [Fsoc.class:487-496](../../../../.src/Communs/Fsoc.class#L487-L496)
- [ ] FSOC-A06 — [anomalie] `Prgm.class:81` appelle `Fsoc.ShowModal()` sans argument alors que
  `_New(hform)` est obligatoire (auto-instance impossible, à confirmer) ; correction : `hform`
  `Optional` et test `If $hform` dans `Soclist_Click` · tests : T13 · sources : [Fsoc.class:_New](../../../../.src/Communs/Fsoc.class#L41-L60), [Prgm.class:81](../../../../.src/Communs/Prgm.class#L81), [Fsoc.class:623](../../../../.src/Communs/Fsoc.class#L623)
- [ ] FSOC-A07 — [anomalie] `Shell mysql … SET @@global.sql_mode` : mot de passe en clair dans la
  ligne de commande, `/dbase/Port` et tunnel SSH ignorés, droit `SUPER` requis, échec silencieux
  (même défaut dans `LauruxConf`, `Fmenu`) · tests : T06 · sources : [Fsoc.class:608](../../../../.src/Communs/Fsoc.class#L608)
- [ ] FSOC-A08 — [anomalie] **Sans objet** : le défaut (messages utilisant `Soc` avant son
  affectation) se trouve dans `Button4_Click`, qui est du code mort ; il disparaît avec FSOC-011 ·
  tests : aucun · sources : [Fsoc.class:557-559](../../../../.src/Communs/Fsoc.class#L557-L559)
- [ ] FSOC-A09 — [anomalie] `Recup_Soc` : liste vide → `Catch` → fermeture silencieuse de l'écran ;
  société courante absente → la dernière ligne reste sélectionnée et `Maj_Zones` cherche son code
  dans la base courante (champs non remplis) · tests : T01, T11 · sources : [Fsoc.class:Recup_Soc](../../../../.src/Communs/Fsoc.class#L62-L72), [Fsoc.class:169-171](../../../../.src/Communs/Fsoc.class#L169-L171)
- [ ] FSOC-A10 — [anomalie] `code_LostFocus` met `s = 1` sur un code invalide mais seul le cas
  tag 1 de `Soc_KeyPress` le remet à 0 ; `Button1_Click` peut aussi le mettre à 1 : focus resté
  bloqué sur `Code` à la saisie suivante (à confirmer) · tests : T09 · sources : [Fsoc.class:code_LostFocus](../../../../.src/Communs/Fsoc.class#L435-L447), [Fsoc.class:246-253](../../../../.src/Communs/Fsoc.class#L246-L253), [Fsoc.class:509](../../../../.src/Communs/Fsoc.class#L509)
