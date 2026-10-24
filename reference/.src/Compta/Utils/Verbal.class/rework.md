# Verbal — Rework

> Source : `.src/Compta/Utils/Verbal.class` · Message de commit (phase 4) : `reference/.src/Compta/Utils/Verbal.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 314 |
| Lignes de commentaire | 52 |
| Fonctions | 12 |
| Fonctions Public | 12 |
| Complexité cyclomatique totale | 57 |
| Complexité max (fonction) | 19 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 314 | 57 | 19 | 0 | 12 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] VERBAL-001 — [documentation] En-tête en français : rôle, tableau des sept lignes (catégories
  de comptes), contrôle attendu (collectifs = balances auxiliaires, solde général nul), exercice
  courant uniquement · appelants : aucun · tests : aucun · sources : [Verbal.class:_New](../../../../../.src/Compta/Utils/Verbal.class#L42-L82), [Verbal.class:Button2_Click](../../../../../.src/Compta/Utils/Verbal.class#L318-L426)
- [ ] VERBAL-002 — [code mort] Supprimer `date1` (aucun appel), la variable `TotSldHP` (jamais
  lue), le `Else` vide et le `If Message.Warning(…) = 1 Then Endif` vide de `dteN1_LF`, et
  l'effacement des 21 champs juste avant `Me.Close` · appelants : aucun · tests : T01, T04 ·
  sources : [Verbal.class:date1](../../../../../.src/Compta/Utils/Verbal.class#L87-L101), [Verbal.class:Btn_Click](../../../../../.src/Compta/Utils/Verbal.class#L131-L164), [Verbal.class:276](../../../../../.src/Compta/Utils/Verbal.class#L276), [Verbal.class:417](../../../../../.src/Compta/Utils/Verbal.class#L417)
- [ ] VERBAL-003 — [réduction de portée] `Ex1`, `Exo`, `dteN0_LF`, `dteN1_LF`, `Compdate`,
  `compdate2` → `Private` (couverts par T01 et T04) · appelants : aucun · tests : T01, T04 ·
  sources : [Verbal.class:Ex1](../../../../../.src/Compta/Utils/Verbal.class#L185-L204), [Verbal.class:Exo](../../../../../.src/Compta/Utils/Verbal.class#L209-L223), [Verbal.class:dteN0_LF](../../../../../.src/Compta/Utils/Verbal.class#L228-L250), [Verbal.class:dteN1_LF](../../../../../.src/Compta/Utils/Verbal.class#L255-L283), [Verbal.class:Compdate](../../../../../.src/Compta/Utils/Verbal.class#L285-L298), [Verbal.class:compdate2](../../../../../.src/Compta/Utils/Verbal.class#L300-L313)
- [ ] VERBAL-004 — [complexité] Tableau privé des 21 champs pour la remise à `"0,00"` dans `_New`
  et `Button2_Click` (sans modification du `.form`) · appelants : aucun · tests : T02 · sources : [Verbal.class:_New](../../../../../.src/Compta/Utils/Verbal.class#L42-L82), [Verbal.class:Button2_Click](../../../../../.src/Compta/Utils/Verbal.class#L318-L426)
- [ ] VERBAL-005 — [séparation traitement/GUI] Extraire `CalculeBalances(sDeb, sFin) As Float[]`
  (SQL identique, cumul arrondi à 2 décimales à chaque pas comme aujourd'hui) ; `Button2_Click`
  n'écrit les champs qu'à la fin. Le texte affiché doit être identique (T02, T03) · appelants :
  aucun · tests : T02, T03, T06 · sources : [Verbal.class:Button2_Click](../../../../../.src/Compta/Utils/Verbal.class#L318-L426)
- [ ] VERBAL-006 — [complexité] Remplacer les N+1 requêtes `Fiches_Mvt` par une jointure triée
  par compte puis par ordre physique actuel (SQL modifié, lecture seule, dump identique ; abandon si
  T02/T03 montrent un écart d'arrondi) · appelants : aucun · tests : T02, T03, T07 · sources : [Verbal.class:354](../../../../../.src/Compta/Utils/Verbal.class#L354), [Verbal.class:360](../../../../../.src/Compta/Utils/Verbal.class#L360)
- [ ] VERBAL-007 — [commonalisation] Bornes d'exercice par `LDate.Exercice_Cloture(0/1)` dans
  `Ex1`/`Exo` et comparaisons de dates par `LDate` au lieu de la recomposition `yyyymmdd` (même
  helper que RUBIMP-003) ; noms de tables par `Cbase.Table` (SQL identique) · appelants : aucun ·
  tests : T01, T04 · sources : [Verbal.class:Ex1](../../../../../.src/Compta/Utils/Verbal.class#L185-L204), [Verbal.class:Exo](../../../../../.src/Compta/Utils/Verbal.class#L209-L223), [LDate.class:Exercice_Cloture](../../../../../.src/Utils/LDate.class#L648-L672)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] VERBAL-A01 — [anomalie] Le bouton d'aide (`Button1`, tag 1) est sans effet : `Btn_Click` ne
  traite pas le tag 1 (ajouter `Doc.Open`, nom de page à définir) · tests : aucun (manuel) ·
  sources : [Verbal.class:Btn_Click](../../../../../.src/Compta/Utils/Verbal.class#L131-L164)
- [ ] VERBAL-A02 — [anomalie] Alerte de déséquilibre : seulement un fond rouge et
  `Syntheses.Message` (son ou voix, rien d'affiché) ; test `Sgenerale.Text <> "0,00"` dépendant de
  la locale et vrai pour `-0,00` ; les écarts collectif/balance auxiliaire ne sont pas signalés ·
  tests : T02, T03 · sources : [Verbal.class:413](../../../../../.src/Compta/Utils/Verbal.class#L413), [Verbal.class:415](../../../../../.src/Compta/Utils/Verbal.class#L415)
- [ ] VERBAL-A03 — [anomalie] Seule `Fiches_Mvt` (exercice courant) est lue : une période d'un
  exercice antérieur, acceptée avec un simple avertissement, donne des balances nulles · tests :
  T05 · sources : [Verbal.class:350](../../../../../.src/Compta/Utils/Verbal.class#L350), [Verbal.class:dteN0_LF](../../../../../.src/Compta/Utils/Verbal.class#L228-L250)
- [ ] VERBAL-A04 — [anomalie] Une date de fin antérieure à la date de début ne produit qu'un
  avertissement sans correction ; la borne haute acceptée est `année(fin d'exercice) + 1` ·
  tests : T04 · sources : [Verbal.class:239](../../../../../.src/Compta/Utils/Verbal.class#L239), [Verbal.class:272](../../../../../.src/Compta/Utils/Verbal.class#L272)
