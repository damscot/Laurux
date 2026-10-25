# SaisieInv — Rework

> Source : `.src/Gestion/Stock/Inventaires/Fin-annee/SaisieInv.class` · Message de commit (phase 4) : `reference/.src/Gestion/Stock/Inventaires/Fin-annee/SaisieInv.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 418 |
| Lignes de commentaire | 50 |
| Fonctions | 19 |
| Fonctions Public | 19 |
| Complexité cyclomatique totale | 104 |
| Complexité max (fonction) | 24 (`Import_Portable`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 418 | 104 | 24 | 0 | 19 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] SAISIEINV-001 — [documentation] En-tête en français : modes de saisie, groupes `Btn`/`Rcpt`
  (et pourquoi `Nseq_LostFocus`/`Cart_LostFocus` ne sont pas levés), format du fichier portable ·
  appelants : aucun · tests : T01-T15 · sources : [SaisieInv.class:_New](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/SaisieInv.class#L14-L47)
- [ ] SAISIEINV-002 — [code mort] Paramètre `Prod` inutilisé et branche `*` morte d'`Art_man`,
  `Case 2` vide de `Rcpt_KeyPress`, `Dim Tab` inutilisé de `Nseq_LostFocus`, `With utils` inutiles ;
  membres `hfil`, `Lig`, `iPos` → locaux d'`Import_Portable` · appelants : aucun · tests : T02-T04,
  T11 · sources : [SaisieInv.class:Art_man](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/SaisieInv.class#L206-L245), [SaisieInv.class:Rcpt_KeyPress](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/SaisieInv.class#L270-L309), [SaisieInv.class:Nseq_LostFocus](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/SaisieInv.class#L163-L188), [SaisieInv.class:3](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/SaisieInv.class#L3)
- [ ] SAISIEINV-003 — [réarchitecture] `Cbase.Table("TabInv")`/`("TabArt")` à la place des
  littéraux `Fiches_Inv`/`Fiches_Art` ; SQL identique · appelants : aucun · tests : T02-T09 ·
  sources : [SaisieInv.class:Nseq_LostFocus](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/SaisieInv.class#L163-L188), [SaisieInv.class:Art_man](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/SaisieInv.class#L206-L245), [SaisieInv.class:Valigne](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/SaisieInv.class#L314-L364), [SaisieInv.class:Colinv_Activate](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/SaisieInv.class#L369-L391), [SaisieInv.class:Colinv_Keypress](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/SaisieInv.class#L396-L418)
- [ ] SAISIEINV-004 — [commonalisation] Fonction privée `MajComptage(sNlig, fQte, iComptee)` pour
  les quatre `UPDATE` de comptage ; SQL identique · appelants : aucun · tests : T02, T05-T08 ·
  sources : [SaisieInv.class:Valigne](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/SaisieInv.class#L314-L364), [SaisieInv.class:Colinv_Activate](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/SaisieInv.class#L369-L391)
- [ ] SAISIEINV-005 — [séparation traitement/GUI] `Import_Portable` : parse et mises à jour dans une
  fonction sans contrôle renvoyant (importés, rejetés) ; `Split(Lig, ";")` au lieu de la boucle
  `For`/`Select` (CC 24 → ≤ 10 visé) ; lecture SQL de `Saisie_Inv` séparée du remplissage de la
  grille · appelants : aucun · tests : T01, T11-T13, T16 · sources : [SaisieInv.class:Import_Portable](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/SaisieInv.class#L457-L539), [SaisieInv.class:Saisie_Inv](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/SaisieInv.class#L52-L93)
- [ ] SAISIEINV-006 — [commonalisation] Déléguer le SQL au module `Inventaire` (`Lignes`,
  `MajComptage`, `ImportPortable` avec `"F"`), partagé avec `SaisieInvT` ; parseur du fichier
  portable commun avec `Achat`, `Facture`, `Majcasier` (phase 3) · appelants : aucun · tests :
  T01-T16, SAISIEINVT-T01..T16 · sources : [SaisieInv.class:Import_Portable](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/SaisieInv.class#L457-L539), [SaisieInvT.class:Import_Portable](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class#L468-L546), [Achat.class:Import](../../../../../../../.src/Gestion/Entrées/Achat.class#L695-L770)
- [ ] SAISIEINV-007 — [réduction de portée] `Saisie_Inv`, `Nseq_LostFocus`, `Cart_LostFocus`,
  `Art_man`, `Valigne`, `Import_Portable` → `Private` (aucun appelant externe, non levés par
  Gambas) · appelants : aucun · tests : T01-T15 · sources : [SaisieInv.class:Saisie_Inv](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/SaisieInv.class#L52-L93), [SaisieInv.class:Nseq_LostFocus](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/SaisieInv.class#L163-L188), [SaisieInv.class:Cart_LostFocus](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/SaisieInv.class#L190-L201), [SaisieInv.class:Art_man](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/SaisieInv.class#L206-L245), [SaisieInv.class:Valigne](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/SaisieInv.class#L314-L364), [SaisieInv.class:Import_Portable](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/SaisieInv.class#L457-L539)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] SAISIEINV-A01 — [anomalie] Le rappel d'une ligne remet son comptage à 0 en base avant la
  correction : si l'utilisateur quitte sans réenregistrer, le comptage est perdu et l'article sera
  traité comme non saisi à la validation (stock à 0 par défaut) · tests : T08 · sources : [SaisieInv.class:386](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/SaisieInv.class#L386)
- [ ] SAISIEINV-A02 — [anomalie, à confirmer] Suppr fait un `DELETE` de la ligne d'inventaire (pas
  une remise à zéro) : l'article sort de l'inventaire et `Validinv` ne le traite plus, quelle que
  soit l'option « non saisis » · tests : T09 · sources : [SaisieInv.class:406](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/SaisieInv.class#L406)
- [ ] SAISIEINV-A03 — [anomalie] Écart affiché `+inv_qtestock` (au lieu de `-inv_qtestock`) quand
  la quantité comptée vaut 0, incohérent avec `Valigne` · tests : T01 · sources : [SaisieInv.class:80](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/SaisieInv.class#L80), [SaisieInv.class:329](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/SaisieInv.class#L329)
- [ ] SAISIEINV-A04 — [anomalie] Résultats `Fiches_Art` lus sans `Available` : un article supprimé
  depuis la génération empêche l'ouverture de l'écran ou le chargement de la ligne · tests : T15 ·
  sources : [SaisieInv.class:72](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/SaisieInv.class#L72), [SaisieInv.class:179](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/SaisieInv.class#L179)
- [ ] SAISIEINV-A05 — [anomalie, à confirmer] Doublon détecté par l'échec de `Colinv.Add` : en vue
  « non saisis », une ligne non comptée présente dans la grille déclenche la question « déjà
  saisit » ; une ligne déjà comptée absente de la grille est remplacée sans question · tests : T05,
  T06 · sources : [SaisieInv.class:323](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/SaisieInv.class#L323), [SaisieInv.class:335](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/SaisieInv.class#L335)
- [ ] SAISIEINV-A06 — [anomalie] Import : `Code` non réinitialisé entre deux lignes (une ligne sans
  code-barres réutilise le précédent), rejet imprimé `code & " " & Code` (doublon), articles déjà
  comptés rejetés sans proposition de cumul · tests : T12 · sources : [SaisieInv.class:497](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/SaisieInv.class#L497), [SaisieInv.class:522](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/SaisieInv.class#L522)
- [ ] SAISIEINV-A07 — [anomalie] `Nseq_LostFocus`/`Cart_LostFocus` jamais levés (contrôles du
  groupe `Rcpt`) : quitter le champ à la souris ne charge pas la ligne, et « Enregistrer » est
  alors ignoré sans message · tests : T02 · sources : [SaisieInv.class:Nseq_LostFocus](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/SaisieInv.class#L163-L188), [SaisieInv.class:102](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/SaisieInv.class#L102)
