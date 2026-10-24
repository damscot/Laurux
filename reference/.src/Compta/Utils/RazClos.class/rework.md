# RazClos — Rework

> Source : `.src/Compta/Utils/RazClos.class` · Message de commit (phase 4) : `reference/.src/Compta/Utils/RazClos.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 14 |
| Lignes de commentaire | 1 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 4 |
| Complexité max (fonction) | 1 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 14 | 4 | 1 | 0 | 4 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] RAZCLOS-001 — [documentation] En-tête : effet du déblocage (cloturee, clé SHA-1 réécrite),
  exercice en cours seulement · appelants : aucun · tests : T01 · sources : [RazClos.class:Raz](../../../../../.src/Compta/Utils/RazClos.class#L9-L15)
- [ ] RAZCLOS-002 — [séparation traitement/GUI] `Private Sub Debloque(sNumero)` sans accès aux
  contrôles, appelée par `Button1_Click` ; `Raz` passe `Private` (aucun appelant externe) · appelants :
  aucun · tests : T01, T02 · sources : [RazClos.class:Raz](../../../../../.src/Compta/Utils/RazClos.class#L9-L15), [RazClos.class:Button1_Click](../../../../../.src/Compta/Utils/RazClos.class#L23-L27)
- [ ] RAZCLOS-003 — [commonalisation] `Cbase.Table("TabMvt")` au lieu de `"Fiches_Mvt"` (UPDATE et
  `Sha1Calc`), même SQL · appelants : aucun · tests : T01 · sources : [RazClos.class:11](../../../../../.src/Compta/Utils/RazClos.class#L11), [RazClos.class:12](../../../../../.src/Compta/Utils/RazClos.class#L12)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] RAZCLOS-A01 — [anomalie, conformité] Le déblocage réécrit la clé d'inaltérabilité : une
  écriture clôturée peut être modifiée sans que « Anomalies des clés » le détecte ; pas de mot de
  passe sur le menu ni de trace. À protéger (mot de passe Admin, confirmation, journal) ou à
  retirer · tests : T03 · sources : [RazClos.class:12](../../../../../.src/Compta/Utils/RazClos.class#L12), [Fmenu.class:2372](../../../../../.src/Communs/Fmenu.class#L2372)
- [ ] RAZCLOS-A02 — [anomalie] Aucun contrôle du numéro saisi : message de succès même si aucune
  écriture n'existe · tests : T02 · sources : [RazClos.class:Raz](../../../../../.src/Compta/Utils/RazClos.class#L9-L15)
