# TriBl — Rework

> Source : `.src/Affichages/TriBl.class` · Message de commit (phase 4) : `reference/.src/Affichages/TriBl.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 255 |
| Lignes de commentaire | 11 |
| Fonctions | 32 |
| Fonctions Public | 32 |
| Complexité cyclomatique totale | 98 |
| Complexité max (fonction) | 14 (`Select_Bl`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 255 | 98 | 14 | 0 | 32 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

Ces étapes ne s'appliquent que si l'anomalie TRIBL-A01 (suppression) est **refusée**.

- [ ] TRIBL-001 — [documentation] En-tête signalant que la classe n'est plus appelée depuis
  `7101bb39` (remplacée par `TriFacture`) · appelants : aucun · tests : T01 · sources : [TriBl.class:_new](../../../../.src/Affichages/TriBl.class#L13-L33)
- [ ] TRIBL-002 — [code mort] Supprimer `ClavInput` et `ClavInput2` (jamais appelées), `Frmt`/`Frmt2`
  de `Colcli_Data` (jamais utilisés) ; `Clitable` dimensionné à 4 · appelants : aucun · tests : T01 ·
  sources : [TriBl.class:ClavInput](../../../../.src/Affichages/TriBl.class#L323-L328), [TriBl.class:ClavInput2](../../../../.src/Affichages/TriBl.class#L330-L335), [TriBl.class:Colcli_Data](../../../../.src/Affichages/TriBl.class#L51-L68)
- [ ] TRIBL-003 — [réduction de portée] `Tris`, `Select_Bl`, `Compute_Total_Bl`, `Deplacement`, `Deb3`, `Deb4`, `Dbclk`, `ChkInput` → `Private` (aucun appelant) · appelants : aucun · tests : T01 · sources : [TriBl.class:Select_Bl](../../../../.src/Affichages/TriBl.class#L70-L84), [TriBl.class:Compute_Total_Bl](../../../../.src/Affichages/TriBl.class#L86-L98), [TriBl.class:Deb3](../../../../.src/Affichages/TriBl.class#L195-L203), [TriBl.class:Deb4](../../../../.src/Affichages/TriBl.class#L205-L213)
- [ ] TRIBL-004 — [commonalisation] Pagination et `ChkInput` vers `PaginationListe` (voir
  TRICARTES-005, TRIFAC-007) · appelants : aucun · tests : T01 · sources : [TriBl.class:Descendre_Click](../../../../.src/Affichages/TriBl.class#L142-L152), [TriBl.class:Deplacement](../../../../.src/Affichages/TriBl.class#L184-L193), [Tricartes.class:Descendre_Click](../../../../.src/Caisse/Affichages/Tricartes.class#L127-L137)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] TRIBL-A01 — [anomalie] Classe morte : supprimer le couple `TriBl.class` + `TriBl.form` (aucun
  appelant depuis `7101bb39`, remplacé par `TriFacture` ; `deps.py` : `jamais_reference`, confirmé par
  `grep` et `git log -S`) · tests : T01 · sources : [TriBl.class:_new](../../../../.src/Affichages/TriBl.class#L13-L33), [TriFacture.class:_new](../../../../.src/Affichages/TriFacture.class#L17-L91)
- [ ] TRIBL-A02 — [anomalie] (latente, seulement si la classe est conservée) SQL concaténé dans
  `Deb3`/`Deb4` : `cdclibl = <code>` et `numtick = <ticket>` sans guillemets (code client
  alphanumérique → erreur SQL, ticket vide → erreur de syntaxe, comparaison numérique en MySQL), motif
  `LIKE "%<sel>%"` ; `Annuler_Click` détache aussi les BL rattachés avant l'ouverture ; le filtre de
  `N1` porte sur `numbl` · tests : T01 · sources : [TriBl.class:199](../../../../.src/Affichages/TriBl.class#L199), [TriBl.class:209](../../../../.src/Affichages/TriBl.class#L209), [TriBl.class:Annuler_Click](../../../../.src/Affichages/TriBl.class#L344-L350), [TriBl.class:ChkInput](../../../../.src/Affichages/TriBl.class#L312-L321)
