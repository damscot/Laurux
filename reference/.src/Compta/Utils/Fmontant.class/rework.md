# Fmontant — Rework

> Source : `.src/Compta/Utils/Fmontant.class` · Message de commit (phase 4) : `reference/.src/Compta/Utils/Fmontant.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 168 |
| Lignes de commentaire | 42 |
| Fonctions | 10 |
| Fonctions Public | 10 |
| Complexité cyclomatique totale | 58 |
| Complexité max (fonction) | 41 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 168 | 58 | 41 | 0 | 10 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] FMONTANT-001 — [documentation] En-tête en français : critères de recherche, filtre de type
  de compte, ouverture de `Saisecrit`/`Tresor` · appelants : aucun · tests : T01-T06 · sources : [Fmontant.class:Button2_Click](../../../../../.src/Compta/Utils/Fmontant.class#L83-L148)
- [ ] FMONTANT-002 — [code mort] Supprimer `Tcpt` et le code commenté de `Cb2_Click`/`Cb3_Click` ·
  appelants : aucun · tests : T02 · sources : [Fmontant.class:30](../../../../../.src/Compta/Utils/Fmontant.class#L30), [Fmontant.class:Cb2_Click](../../../../../.src/Compta/Utils/Fmontant.class#L225-L236), [Fmontant.class:Cb3_Click](../../../../../.src/Compta/Utils/Fmontant.class#L238-L249)
- [ ] FMONTANT-003 — [réduction de portée] `affichage` → `Private` · appelants : aucun · tests :
  T01 · sources : [Fmontant.class:affichage](../../../../../.src/Compta/Utils/Fmontant.class#L150-L166)
- [ ] FMONTANT-004 — [séparation traitement/GUI] `FiltreType()` et `Recherche(…) As Result` sans
  accès aux contrôles, même texte SQL (sans changement SQL) ; `Button2_Click` garde contrôles de
  saisie et messages (CC 41 → ≤ 15 visé) · appelants : aucun · tests : T01-T04, T07 · sources : [Fmontant.class:Button2_Click](../../../../../.src/Compta/Utils/Fmontant.class#L83-L148)
- [ ] FMONTANT-005 — [commonalisation] Noms de tables par `Cbase.Table("TabMvt")` et
  `Cbase.Table("TabComptes")` (même SQL) · appelants : aucun · tests : T01, T05 · sources : [Fmontant.class:Button2_Click](../../../../../.src/Compta/Utils/Fmontant.class#L83-L148), [Fmontant.class:Somme_Click](../../../../../.src/Compta/Utils/Fmontant.class#L168-L186)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] FMONTANT-A01 — [anomalie, sécurité] Montant et libellé concaténés dans `LIKE '…%'` : erreur
  SQL sur apostrophe, injection possible ; passer en `&1` · tests : T01, T02 · sources : [Fmontant.class:106](../../../../../.src/Compta/Utils/Fmontant.class#L106), [Fmontant.class:117](../../../../../.src/Compta/Utils/Fmontant.class#L117), [Fmontant.class:132](../../../../../.src/Compta/Utils/Fmontant.class#L132)
- [ ] FMONTANT-A02 — [anomalie] Filtre `coll` écrasé (`=`) pour Clients/Gestion/Bilan mais
  conservé (`&=`) pour Fournisseurs ; « Compte collectif uniquement » sans effet sauf Fournisseurs
  et Tous ; `CompteCol` ne peut plus être décoché · tests : T01 · sources : [Fmontant.class:99](../../../../../.src/Compta/Utils/Fmontant.class#L99), [Fmontant.class:101](../../../../../.src/Compta/Utils/Fmontant.class#L101)
- [ ] FMONTANT-A03 — [anomalie] Saisie refusée : le `rResult` de la recherche précédente est
  réutilisé et « Traitement terminé ! » s'affiche après l'avertissement · tests : T04 · sources : [Fmontant.class:135](../../../../../.src/Compta/Utils/Fmontant.class#L135)
- [ ] FMONTANT-A04 — [anomalie] `Somme_Click` lit `Somme.Item[4]` (curseur interne) au lieu de
  `Somme.Current[4]`, sans test `Available` (à confirmer à l'exécution) · tests : T05 · sources : [Fmontant.class:174](../../../../../.src/Compta/Utils/Fmontant.class#L174)
- [ ] FMONTANT-A05 — [anomalie, performance] `Necrit_Click` recalcule les soldes de **tous** les
  comptes après la modification d'une écriture ; limiter aux comptes de l'écriture (même dump
  attendu, temps réduit) · tests : T06 · sources : [Fmontant.class:206](../../../../../.src/Compta/Utils/Fmontant.class#L206)
