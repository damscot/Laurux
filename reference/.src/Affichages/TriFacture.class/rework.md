# TriFacture — Rework

> Source : `.src/Affichages/TriFacture.class` · Message de commit (phase 4) : `reference/.src/Affichages/TriFacture.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 237 |
| Lignes de commentaire | 7 |
| Fonctions | 11 |
| Fonctions Public | 11 |
| Complexité cyclomatique totale | 47 |
| Complexité max (fonction) | 13 (`_new`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 237 | 47 | 13 | 0 | 11 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] TRIFACTURE-001 — [documentation] En-tête : rôle (sélection multiple de documents à régler en
  caisse), contrat `_new(Option, Cl, Nt, ob)` avec `Parent` en premier argument de `New`, protocole
  `LTrans.List` / `Bsel`+`Bval`, raison du `Stop Event` de `TriGen_MajSel`, `Bsel`/`Bval` écrits par
  `TriGen` · appelants : aucun · tests : T01-T04 · sources : [TriFacture.class:_new](../../../../.src/Affichages/TriFacture.class#L17-L91), [TriFacture.class:Form_Close](../../../../.src/Affichages/TriFacture.class#L280-L302), [TriFacture.class:TriGen_MajSel](../../../../.src/Affichages/TriFacture.class#L234-L257)
- [ ] TRIFACTURE-002 — [code mort] Supprimer `Dim Res` et `Val = ""` de `TriGen_MajSel` et la
  branche inatteignable `filter = ""` de `Filter_Calc` · appelants : aucun · tests : T01, T03 ·
  sources : [TriFacture.class:TriGen_MajSel](../../../../.src/Affichages/TriFacture.class#L234-L257), [TriFacture.class:Filter_Calc](../../../../.src/Affichages/TriFacture.class#L140-L167)
- [ ] TRIFACTURE-003 — [complexité] `_new` : `CB1`/`CB1Conv` construits depuis un tableau
  (libellé, types) et `CB1.Text = CB1.List[Option]` (repli sur 0 hors bornes) au lieu du
  `Select Case` de 9 cas · appelants : aucun · tests : T01, T03 · sources : [TriFacture.class:_new](../../../../.src/Affichages/TriFacture.class#L17-L91)
- [ ] TRIFACTURE-004 — [complexité] `Update_Req` : requête des champs bornée (`LIMIT 0`) au lieu
  d'un `select *` complet de `Fiches_Bl`, si `TriGen` n'utilise que `Fields` (à vérifier) ; SQL
  modifié, dump identique · appelants : aucun · tests : T01, T03 · sources : [TriFacture.class:Update_Req](../../../../.src/Affichages/TriFacture.class#L93-L138)
- [ ] TRIFACTURE-005 — [réduction de portée] `Update_Req`, `Filter_Calc`, `Total_Calc` → `Private` (aucun appelant externe, vérifié) ; `Bsel`, `Bval` et l'énumération restent `Public` · appelants : aucun · tests : T01-T04 · sources : [TriFacture.class:Update_Req](../../../../.src/Affichages/TriFacture.class#L93-L138), [TriFacture.class:Filter_Calc](../../../../.src/Affichages/TriFacture.class#L140-L167), [TriFacture.class:Total_Calc](../../../../.src/Affichages/TriFacture.class#L169-L184)
- [ ] TRIFACTURE-006 — [commonalisation] Sélection multiple sur `TriGen` (`Selected`, bascule,
  coloration, Raz, tout (dé)sélectionner) mutualisée avec `GedR` et `Pointage` (classe
  `TriSelection` ou méthodes de `TriGen`, voir POINTAGE-005, GEDR-008) ; handlers conservés ·
  appelants : `GedR`, `Pointage` (dans leurs reworks) · tests : T01, T03, T04 · sources : [TriFacture.class:TriGen_MajSel](../../../../.src/Affichages/TriFacture.class#L234-L257), [TriFacture.class:SelectAllFil_Click](../../../../.src/Affichages/TriFacture.class#L186-L204), [TriFacture.class:DeSelectAllFil_Click](../../../../.src/Affichages/TriFacture.class#L206-L224), [Pointage.class:TriGen_MajSel](../../../../.src/Compta/Pointage.class#L139-L162), [GedR.class:TriGen_MajSel](../../../../.src/Utils/GedR.class#L273-L295)
- [ ] TRIFACTURE-007 — [séparation traitement/GUI] `FiltreDocuments(iType, sClient, sTicket) As
  String` (texte identique) et `TotauxSelection(aNumeros) As Float[]` (même requête) ; `Filter_Calc`
  et `Total_Calc` ne gardent que l'affichage · appelants : aucun · tests : T05, T06 · sources : [TriFacture.class:Filter_Calc](../../../../.src/Affichages/TriFacture.class#L140-L167), [TriFacture.class:Total_Calc](../../../../.src/Affichages/TriFacture.class#L169-L184)
- [ ] TRIFACTURE-008 — [commonalisation] Retour de sélection (`LTrans.List` ou
  `Object.SetProperty(Obj, "Bsel"/"Bval")`) factorisé dans une aide `RenvoyerSelection(Obj, aListe)`
  commune avec `TriGen.Close` ; utilisée par `_new` et `Form_Close` · appelants : `TriGen` (même
  commit si l'aide y est placée) · tests : T01, T04 · sources : [TriFacture.class:_new](../../../../.src/Affichages/TriFacture.class#L17-L91), [TriFacture.class:Form_Close](../../../../.src/Affichages/TriFacture.class#L280-L302), [TriGen.class:Close](../../../../.src/Affichages/TriGen.class#L221-L255)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] TRIFACTURE-A01 — [anomalie] `Total_Calc` (et `Caisse.class:7166`) construisent
  `numbl in (<numéros joints par des virgules>)` sans guillemets ni paramètres : `numbl` est un
  `varchar(6)` ; MySQL compare en numérique (index ignoré, `"0012"` = `12`), SQLite en texte (un
  numéro à zéros non significatifs n'est pas retrouvé, vérifié par `gbs3`) et un numéro non numérique
  provoque une erreur SQL. Paramétrer (`Utils.SqlIn`) change les cas à zéros non significatifs (à
  confirmer selon le format réel des numéros) · tests : T06 · sources : [TriFacture.class:177](../../../../.src/Affichages/TriFacture.class#L177), [Caisse.class:7166](../../../../.src/Caisse/Caisse.class#L7166)
