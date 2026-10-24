# Lettrage — Rework

> Source : `.src/Compta/Lettrages/Lettrage.class` · Message de commit (phase 4) : `reference/.src/Compta/Lettrages/Lettrage.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 447 |
| Lignes de commentaire | 35 |
| Fonctions | 27 |
| Fonctions Public | 27 |
| Complexité cyclomatique totale | 104 |
| Complexité max (fonction) | 20 (`affichage`) |
| Variables globales | 0 |
| Variables Public | 3 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 447 | 104 | 20 | 0 | 27 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] LETTRAGE-001 — [documentation] En-tête en français : rôle, points d'entrée (Fmenu, Extrait F4),
  fenêtre de dates, règle du lot, rôle de `Item[9]` (lind) ; commentaires sur `affichage`,
  `Button5_Click` et `Button7_Click` · appelants : aucun · tests : aucun · sources : [Lettrage.class:_New](../../../../../.src/Compta/Lettrages/Lettrage.class#L64-L119), [Lettrage.class:affichage](../../../../../.src/Compta/Lettrages/Lettrage.class#L267-L370), [Lettrage.class:Button5_Click](../../../../../.src/Compta/Lettrages/Lettrage.class#L412-L453)
- [ ] LETTRAGE-002 — [code mort] Supprimer `Desg`, `Lettrable` et la ligne 439 qui en dépend
  (toujours fausse), les locales `num`/`Tab` de `Button5_Click`, `Tab`/`Tab2` de `affichage`, le
  code commenté de `Button7_Click` et l'appel redondant `Indexation()` de `Button9_Click` ·
  appelants : aucun · tests : T02-T05 · sources : [Lettrage.class:39](../../../../../.src/Compta/Lettrages/Lettrage.class#L39), [Lettrage.class:439](../../../../../.src/Compta/Lettrages/Lettrage.class#L439), [Lettrage.class:Button5_Click](../../../../../.src/Compta/Lettrages/Lettrage.class#L412-L453), [Lettrage.class:Button7_Click](../../../../../.src/Compta/Lettrages/Lettrage.class#L509-L528), [Lettrage.class:Button9_Click](../../../../../.src/Compta/Lettrages/Lettrage.class#L193-L206)
- [ ] LETTRAGE-003 — [commonalisation] `cpoint` local → `Utils.cpoint` (même effet après le test
  `Val(...) = Null`) ; `convBool` supprimé, `ConvBool(x.Value) = 1` remplacé par `x.Value` ·
  appelants : aucun · tests : T01, T02, T07 · sources : [Lettrage.class:convBool](../../../../../.src/Compta/Lettrages/Lettrage.class#L45-L56), [Lettrage.class:cpoint](../../../../../.src/Compta/Lettrages/Lettrage.class#L58-L62), [Lettrage.class:Colcli_Click](../../../../../.src/Compta/Lettrages/Lettrage.class#L372-L392), [Utils.module:cpoint](../../../../../.src/Utils/Utils.module#L267-L275)
- [ ] LETTRAGE-004 — [commonalisation] Fonction privée `ChargeComptes()` pour la requête des
  comptes lettrables répétée dans `_New`, `Bclient_Click`, `Bfournisseur_Click`, `Bbilan_Click`
  (SQL identique) · appelants : aucun · tests : T05 · sources : [Lettrage.class:_New](../../../../../.src/Compta/Lettrages/Lettrage.class#L64-L119), [Lettrage.class:Bclient_Click](../../../../../.src/Compta/Lettrages/Lettrage.class#L476-L485), [Lettrage.class:Bfournisseur_Click](../../../../../.src/Compta/Lettrages/Lettrage.class#L487-L496), [Lettrage.class:Bbilan_Click](../../../../../.src/Compta/Lettrages/Lettrage.class#L498-L507)
- [ ] LETTRAGE-005 — [réarchitecture] `Cbase.Table("TabComptes")` et `Cbase.Table("TabParam")` à
  la place de `Fiches_Comptes`/`Fiches_Parametres` en dur (SQL identique) · appelants : aucun ·
  tests : T01, T05 · sources : [Lettrage.class:70](../../../../../.src/Compta/Lettrages/Lettrage.class#L70), [Lettrage.class:compteman](../../../../../.src/Compta/Lettrages/Lettrage.class#L208-L242), [Lettrage.class:321](../../../../../.src/Compta/Lettrages/Lettrage.class#L321)
- [ ] LETTRAGE-006 — [complexité] `affichage` : extraire `Naviguer()` (5 blocs `Compt`) et le
  choix du filtre `"n"|"o"|"t"` (3 blocs `New Listextcpt`) ; CC 20 → ≤ 8 visé, comportement
  identique y compris l'erreur sur liste vide · appelants : aucun · tests : T01, T05 · sources : [Lettrage.class:affichage](../../../../../.src/Compta/Lettrages/Lettrage.class#L267-L370)
- [ ] LETTRAGE-007 — [séparation traitement/GUI] `TotalSelection(...)` pure pour le calcul de
  `Colcli_Click` ; `Lettrer(aLind, bValeur, sLot)` pour les boucles `letcpt` de `Button5_Click` et
  `Button7_Click` (même ordre d'appels, donc même SQL, A01 conservée) · appelants : aucun ·
  tests : T02-T04, T07 · sources : [Lettrage.class:Colcli_Click](../../../../../.src/Compta/Lettrages/Lettrage.class#L372-L392), [Lettrage.class:Button5_Click](../../../../../.src/Compta/Lettrages/Lettrage.class#L412-L453), [Lettrage.class:Button7_Click](../../../../../.src/Compta/Lettrages/Lettrage.class#L509-L528)
- [ ] LETTRAGE-008 — [réduction de portée] `compteman`, `Indexation`, `clear`, `affichage` →
  `Private` ; `Bsel`/`Bval` restent `Public` (écrits par `TriCpt` via `Object.SetProperty`) ·
  appelants : aucun · tests : T01-T06 · sources : [Lettrage.class:compteman](../../../../../.src/Compta/Lettrages/Lettrage.class#L208-L242), [Lettrage.class:Indexation](../../../../../.src/Compta/Lettrages/Lettrage.class#L244-L255), [Lettrage.class:clear](../../../../../.src/Compta/Lettrages/Lettrage.class#L257-L265), [Lettrage.class:affichage](../../../../../.src/Compta/Lettrages/Lettrage.class#L267-L370)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] LETTRAGE-A01 — [anomalie] `Button5_Click` délettre en base toutes les lignes cochées
  **avant** de contrôler le total : un lettrage refusé (total ≠ 0) laisse les lignes déjà lettrées
  délettrées, avec un nouveau lot. Proposition : contrôler le total avant toute écriture · tests : T03 · sources : [Lettrage.class:422](../../../../../.src/Compta/Lettrages/Lettrage.class#L422), [Lettrage.class:426](../../../../../.src/Compta/Lettrages/Lettrage.class#L426), [Lettrage.class:429](../../../../../.src/Compta/Lettrages/Lettrage.class#L429)
- [ ] LETTRAGE-A02 — [anomalie] Numéro de lot aléatoire (`Rnd(1000000, 9999999)`) sans contrôle
  d'unicité, ou lot de la dernière ligne cliquée (qui peut appartenir à un autre groupe) : fusion
  possible de lettrages distincts · tests : T02 · sources : [Lettrage.class:420](../../../../../.src/Compta/Lettrages/Lettrage.class#L420), [Lettrage.class:421](../../../../../.src/Compta/Lettrages/Lettrage.class#L421), [Lettrage.class:388](../../../../../.src/Compta/Lettrages/Lettrage.class#L388)
- [ ] LETTRAGE-A03 — [anomalie] Le délettrage écrit `numlot = numlot.Text` (lot de la dernière ligne
  cliquée) au lieu de vider le lot · tests : T04 · sources : [Lettrage.class:517](../../../../../.src/Compta/Lettrages/Lettrage.class#L517)
- [ ] LETTRAGE-A04 — [anomalie] Navigation premier/dernier sur une liste de comptes lettrables vide
  → erreur (`rrResult!compte_cc` sans enregistrement) ; `Fiches_Parametres` lu sans test
  `Available` · tests : T05 · sources : [Lettrage.class:279](../../../../../.src/Compta/Lettrages/Lettrage.class#L279), [Lettrage.class:310](../../../../../.src/Compta/Lettrages/Lettrage.class#L310), [Lettrage.class:323](../../../../../.src/Compta/Lettrages/Lettrage.class#L323)
- [ ] LETTRAGE-A05 — [anomalie] Contrôle d'équilibre par comparaison du texte affiché
  (`Totselection.Text <> "0,00"`) : en locale à point décimal le lettrage est toujours refusé
  (et A01 s'applique). Proposition : comparer la valeur `TT` arrondie à 2 décimales · tests : T02, T03 · sources : [Lettrage.class:429](../../../../../.src/Compta/Lettrages/Lettrage.class#L429), [Lettrage.class:390](../../../../../.src/Compta/Lettrages/Lettrage.class#L390)
