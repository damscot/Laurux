# SaisieInvT — Rework

> Source : `.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class` · Message de commit (phase 4) : `reference/.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 418 |
| Lignes de commentaire | 49 |
| Fonctions | 20 |
| Fonctions Public | 20 |
| Complexité cyclomatique totale | 97 |
| Complexité max (fonction) | 23 (`Import_Portable`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 418 | 97 | 23 | 0 | 20 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] SAISIEINVT-001 — [documentation] En-tête en français (renvoi à SaisieInv, différences
  propres à la variante tournante) · appelants : aucun · tests : T01-T15 · sources : [SaisieInvT.class:_New](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class#L14-L48)
- [ ] SAISIEINVT-002 — [code mort] Supprimer `Button3_Click` (jamais levé : `Button3` est dans le
  groupe `btn`), le paramètre `Prod` et la branche `*` d'`Art_man`, la ligne commentée de
  `Valigne`, les `With utils` ; `hfil`, `Lig`, `iPos` → locaux · appelants : aucun · tests : T03,
  T11 · sources : [SaisieInvT.class:Button3_Click](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class#L459-L463), [SaisieInvT.class:Art_man](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class#L206-L245), [SaisieInvT.class:3](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class#L3)
- [ ] SAISIEINVT-003 — [réarchitecture] `Cbase.Table("TabInvT")`/`("TabArt")` à la place des
  littéraux ; SQL identique sauf `Nseq_LostFocus` qui garde son `SELECT *` · appelants : aucun ·
  tests : T02-T09 · sources : [SaisieInvT.class:Nseq_LostFocus](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class#L163-L188), [SaisieInvT.class:Valigne](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class#L312-L363), [SaisieInvT.class:Colinv_Keypress](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class#L395-L415)
- [ ] SAISIEINVT-004 — [commonalisation] `MajComptage(sNlig, fQte, iComptee)` privé pour les quatre
  `UPDATE` ; SQL identique · appelants : aucun · tests : T02, T05-T08 · sources : [SaisieInvT.class:Valigne](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class#L312-L363), [SaisieInvT.class:Colinv_Activate](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class#L368-L390)
- [ ] SAISIEINVT-005 — [séparation traitement/GUI] `Import_Portable` : parse + mises à jour sans
  contrôle, `Split` au lieu de la boucle (CC 23 → ≤ 10) ; `Saisie_Inv` : requête séparée du
  remplissage · appelants : aucun · tests : T01, T11-T13, T16 · sources : [SaisieInvT.class:Import_Portable](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class#L468-L546), [SaisieInvT.class:Saisie_Inv](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class#L53-L93)
- [ ] SAISIEINVT-006 — [commonalisation] Module `Inventaire` (`"T"`) partagé avec SaisieInv
  (SAISIEINV-006) ; les divergences de comportement restent en l'état tant que A08-A10 ne sont pas
  validées · appelants : aucun · tests : T01-T16 · sources : [SaisieInvT.class:Import_Portable](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class#L468-L546), [SaisieInv.class:Import_Portable](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/SaisieInv.class#L457-L539)
- [ ] SAISIEINVT-007 — [réduction de portée] `Saisie_Inv`, `Nseq_LostFocus`, `Cart_LostFocus`,
  `Art_man`, `Valigne`, `Import_Portable` → `Private` · appelants : aucun · tests : T01-T15 ·
  sources : [SaisieInvT.class:Saisie_Inv](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class#L53-L93), [SaisieInvT.class:Nseq_LostFocus](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class#L163-L188), [SaisieInvT.class:Cart_LostFocus](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class#L190-L201), [SaisieInvT.class:Art_man](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class#L206-L245), [SaisieInvT.class:Valigne](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class#L312-L363), [SaisieInvT.class:Import_Portable](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class#L468-L546)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] SAISIEINVT-A01 — [anomalie] Comme SAISIEINV-A01 : le rappel remet le comptage à 0 avant
  correction · tests : T08 · sources : [SaisieInvT.class:385](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class#L385)
- [ ] SAISIEINVT-A02 — [anomalie, à confirmer] Comme SAISIEINV-A02 : Suppr supprime la ligne
  d'inventaire · tests : T09 · sources : [SaisieInvT.class:405](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class#L405)
- [ ] SAISIEINVT-A03 — [anomalie] Comme SAISIEINV-A03 : écart `+inv_qtestock` pour une quantité
  comptée nulle · tests : T01 · sources : [SaisieInvT.class:80](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class#L80)
- [ ] SAISIEINVT-A04 — [anomalie] Comme SAISIEINV-A04 : `Fiches_Art` lu sans `Available` · tests :
  T15 · sources : [SaisieInvT.class:74](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class#L74), [SaisieInvT.class:179](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class#L179)
- [ ] SAISIEINVT-A05 — [anomalie, à confirmer] Comme SAISIEINV-A05 : doublon détecté par l'échec de
  `Colinv.Add` · tests : T05, T06 · sources : [SaisieInvT.class:321](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class#L321), [SaisieInvT.class:333](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class#L333)
- [ ] SAISIEINVT-A06 — [anomalie] Comme SAISIEINV-A06 : `Code` non réinitialisé, rejet
  `code & " " & Code` · tests : T12 · sources : [SaisieInvT.class:503](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class#L503), [SaisieInvT.class:529](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class#L529)
- [ ] SAISIEINVT-A07 — [anomalie] Comme SAISIEINV-A07 : `Nseq_LostFocus`/`Cart_LostFocus` jamais
  levés · tests : T02 · sources : [SaisieInvT.class:Nseq_LostFocus](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class#L163-L188), [SaisieInvT.class:102](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class#L102)
- [ ] SAISIEINVT-A08 — [anomalie, à confirmer] `Colinv_Activate` lit `Colinv.Item` (curseur
  interne) mais supprime `Colinv.Current` : la ligne rechargée peut différer de la ligne retirée et
  remise à 0 · tests : T07 · sources : [SaisieInvT.class:378](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class#L378), [SaisieInvT.class:383](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class#L383)
- [ ] SAISIEINVT-A09 — [anomalie] Import : pas de test d'erreur après `Try HFil = Open` → fichier
  absent = erreur non gérée sur `Eof(hFil)` (SaisieInv affiche un message) · tests : T13 · sources : [SaisieInvT.class:483](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class#L483), [SaisieInvT.class:489](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class#L489)
- [ ] SAISIEINVT-A10 — [anomalie, à confirmer] Import : quantité testée par `cle <> 0` (chaîne
  comparée à un entier) au lieu de `cle <> ""` : quantité vide → conversion à vérifier (erreur ou
  quantité 0) · tests : T12 · sources : [SaisieInvT.class:514](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class#L514)
