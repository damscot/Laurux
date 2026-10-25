# Edinv — Rework

> Source : `.src/Gestion/Stock/Inventaires/Fin-annee/Edinv.class` · Message de commit (phase 4) : `reference/.src/Gestion/Stock/Inventaires/Fin-annee/Edinv.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 135 |
| Lignes de commentaire | 27 |
| Fonctions | 6 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 29 |
| Complexité max (fonction) | 15 (`TriArticles`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 135 | 29 | 15 | 0 | 4 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] EDINV-001 — [documentation] En-tête en français : paramètre `"F"`/`"T"`, parcours `Trifam`,
  cumul des sous-totaux, prérequis `/SocXX/ipr` · appelants : aucun · tests : T01-T07 · sources : [Edinv.class:_New](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Edinv.class#L40-L74), [Edinv.class:TriArticles](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Edinv.class#L76-L134)
- [ ] EDINV-002 — [code mort] Supprimer la trace `Print fm.cle, fm.Text` (sortie console seulement),
  `Coulfond`, `Nbpage`, les variables `Nlig` et le bloc commenté de `Button1_Click`, le
  `Shell "cd ~"` · appelants : aucun · tests : T01 · sources : [Edinv.class:90](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Edinv.class#L90), [Edinv.class:Button1_Click](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Edinv.class#L145-L175)
- [ ] EDINV-003 — [réarchitecture] `Cbase.Table("TabInv"/"TabInvT")`, `("TabArt")`, `("TabFam")`
  (ou `Inventaire.Table`) ; SQL identique · appelants : aucun · tests : T01, T02 · sources : [Edinv.class:_New](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Edinv.class#L40-L74), [Edinv.class:TriArticles](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Edinv.class#L76-L134)
- [ ] EDINV-004 — [séparation traitement/GUI] `LignesFamille(sCle)` et `Valorise(fPu, fPmp, fQte,
  sNbd)` purs ; `TriArticles` ne fait plus que le parcours et la mise en page · appelants : aucun ·
  tests : T01, T06 · sources : [Edinv.class:TriArticles](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Edinv.class#L76-L134)
- [ ] EDINV-005 — [commonalisation] Utiliser le module `Inventaire` (`Table`, `Libelle`, `DateInv`)
  à la place de `$fichier` et du `Select Case` ; `_New(choix)` garde sa signature · appelants :
  `Fmenu` (inchangé) · tests : T01-T03 · sources : [Edinv.class:_New](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Edinv.class#L40-L74)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] EDINV-A01 — [anomalie, à confirmer] Les articles comptés dont la famille n'est pas un nœud de
  l'arbre `Trifam` (famille absente de `Fiches_Fam`, vide) sont exclus de l'édition et du total :
  inventaire valorisé incomplet · tests : T04 · sources : [Edinv.class:94](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Edinv.class#L94)
- [ ] EDINV-A02 — [anomalie, à confirmer] Sans inventaire, `_New` ferme la fenêtre puis `Fmenu`
  appelle `ed.Show` sur l'objet fermé · tests : T03 · sources : [Edinv.class:67](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Edinv.class#L67), [Edinv.class:71](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Edinv.class#L71)
- [ ] EDINV-A03 — [anomalie] En-tête des pages 2 et suivantes `Me.Text & dte.Text` (« …inventaire25.10.2026 »,
  sans « du ») différent de la 1re page · tests : T05 · sources : [Edinv.class:139](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Edinv.class#L139), [Edinv.class:154](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Edinv.class#L154)
