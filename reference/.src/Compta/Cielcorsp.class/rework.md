# Cielcorsp — Rework

> Source : `.src/Compta/Cielcorsp.class` · Message de commit (phase 4) : `reference/.src/Compta/Cielcorsp.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 199 |
| Lignes de commentaire | 43 |
| Fonctions | 13 |
| Fonctions Public | 13 |
| Complexité cyclomatique totale | 50 |
| Complexité max (fonction) | 10 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 199 | 50 | 10 | 0 | 13 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CIELCORSP-001 — [documentation] En-tête en français : rôle, table `Ciel_Lrx`, aiguillage
  `Btn_Click` par `Tag`, édition par suppression au double-clic · appelants : aucun · tests :
  aucun · sources : [Cielcorsp.class:_New](../../../../.src/Compta/Cielcorsp.class#L31-L64), [Cielcorsp.class:Btn_Click](../../../../.src/Compta/Cielcorsp.class#L146-L164)
- [ ] CIELCORSP-002 — [code mort] Supprimer `ChkInput` (jamais appelé), le second `Me.Center` et
  la variable `params` · appelants : aucun · tests : T01, T02 · sources : [Cielcorsp.class:ChkInput](../../../../.src/Compta/Cielcorsp.class#L250-L258), [Cielcorsp.class:34](../../../../.src/Compta/Cielcorsp.class#L34), [Cielcorsp.class:40](../../../../.src/Compta/Cielcorsp.class#L40)
- [ ] CIELCORSP-003 — [commonalisation] Module commun `CielCorresp` (chargement de la liste,
  contrôle, ajout, suppression) paramétré par la table et les requêtes, partagé avec `Cielcorspj`
  (89 % de code identique) ; handlers et `.form` inchangés, SQL identique · appelants : aucun
  (même commit que CIELCORSPJ-003) · tests : T01-T06, CIELCORSPJ-T01-T06 ·
  sources : [Cielcorsp.class:Button2_Click](../../../../.src/Compta/Cielcorsp.class#L177-L217), [Cielcorsp.class:Cpt_man](../../../../.src/Compta/Cielcorsp.class#L222-L248), [Cielcorspj.class:Button2_Click](../../../../.src/Compta/Cielcorspj.class#L171-L212)
- [ ] CIELCORSP-004 — [commonalisation] `Cbase.Table("TabComptes")` au lieu de `"Fiches_Comptes"`
  (SQL identique) · appelants : aucun · tests : T02, T03 · sources : [Cielcorsp.class:74](../../../../.src/Compta/Cielcorsp.class#L74), [Cielcorsp.class:226](../../../../.src/Compta/Cielcorsp.class#L226)
- [ ] CIELCORSP-005 — [séparation traitement/GUI] `AjouteCorrespondance(sCiel, sLrx, sIntitule)
  As String` et `ControleCompteLaurux(sCode) As String` sans accès aux contrôles ; `Cpt_man` ne
  pose plus le membre `B` mais renvoie un booléen (SQL identique) · appelants : aucun ·
  tests : T02, T04, T05, T07 · sources : [Cielcorsp.class:Button2_Click](../../../../.src/Compta/Cielcorsp.class#L177-L217), [Cielcorsp.class:Cpt_man](../../../../.src/Compta/Cielcorsp.class#L222-L248)
- [ ] CIELCORSP-006 — [réduction de portée] `Cpt_man`, `Compte_delete` → `Private` · appelants :
  aucun · tests : T02, T06 · sources : [Cielcorsp.class:Cpt_man](../../../../.src/Compta/Cielcorsp.class#L222-L248), [Cielcorsp.class:Compte_delete](../../../../.src/Compta/Cielcorsp.class#L281-L288)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] CIELCORSP-A01 — [anomalie] Double-clic (`Listecompte_Activate`) : la correspondance est
  supprimée en base dès la recopie dans les zones de saisie ; si l'utilisateur quitte sans
  réajouter, elle est perdue · tests : T06 · sources : [Cielcorsp.class:Listecompte_Activate](../../../../.src/Compta/Cielcorsp.class#L272-L279)
- [ ] CIELCORSP-A02 — [anomalie] `Suppr` sur une liste vide ou sans ligne courante :
  `Listecompte.Current` nul → erreur non interceptée (à confirmer) · tests : T06 ·
  sources : [Cielcorsp.class:Listecompte_KeyPress](../../../../.src/Compta/Cielcorsp.class#L263-L270), [Cielcorsp.class:286](../../../../.src/Compta/Cielcorsp.class#L286)
