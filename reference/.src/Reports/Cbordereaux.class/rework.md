# Cbordereaux — Rework

> Source : `.src/Reports/Cbordereaux.class` · Message de commit (phase 4) : `reference/.src/Reports/Cbordereaux.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 97 |
| Lignes de commentaire | 12 |
| Fonctions | 16 |
| Fonctions Public | 16 |
| Complexité cyclomatique totale | 16 |
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
| initial | `6b6b9dfc` | 2026-10-25 | 97 | 16 | 1 | 0 | 16 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CBORDEREAUX-001 — [documentation] En-tête de classe en français : trois documents (bordereau
  de caisse, de chèques, liste des paiements) et méthodes correspondantes ; mention de la surcharge
  du crochet `Footer` ; commentaire `'''` par méthode · appelants : aucun · tests : T01-T03 · sources : [Cbordereaux.class:Footer](../../../../.src/Reports/Cbordereaux.class#L46-L53), [Cbordereaux.class:Entete](../../../../.src/Reports/Cbordereaux.class#L20-L24)
- [ ] CBORDEREAUX-002 — [code mort] Supprimer `_free` et le paramètre inutilisé `PosY` d'`EnteteP`
  · appelants : `Edpaiement` (3 appels d'`EnteteP`, même commit) · tests : T03, T06 · sources : [Cbordereaux.class:EnteteP](../../../../.src/Reports/Cbordereaux.class#L35-L43), [Cbordereaux.class:_free](../../../../.src/Reports/Cbordereaux.class#L16-L18), [Edpaiement.class:179](../../../../.src/Gestion/Impressions/Edpaiement.class#L179)
- [ ] CBORDEREAUX-003 — [commonalisation] Helper privé `LigneMontant(x, largeur, intitulé, prix,
  PosY)` pour `Level5` et `Level8` ; rendu identique · appelants : aucun · tests : T01, T02 · sources : [Cbordereaux.class:Level5](../../../../.src/Reports/Cbordereaux.class#L114-L121), [Cbordereaux.class:Level8](../../../../.src/Reports/Cbordereaux.class#L150-L157)
- [ ] CBORDEREAUX-004 — [commonalisation] (phase 3) Dériver de `PdfLaurux` (PDFWRITER-011) :
  `_new`, `Entete` (nouvelle page), `EnteteP` (titre standard) et `Footer` (pied de page standard,
  nom conservé) délèguent à la base ; PDF identique · appelants : aucun · tests : T01-T03 · sources : [Cbordereaux.class:_new](../../../../.src/Reports/Cbordereaux.class#L8-L14), [Cbordereaux.class:EnteteP](../../../../.src/Reports/Cbordereaux.class#L35-L43), [Cbordereaux.class:Footer](../../../../.src/Reports/Cbordereaux.class#L46-L53), [Ccompta.class:BasPage](../../../../.src/Reports/Ccompta.class#L31-L38)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] CBORDEREAUX-A01 — [anomalie, à confirmer par T04] `Logo` appelle `Me.Image` sans contrôle :
  un logo configuré mais absent du disque, ou d'un type autre que JPEG/PNG, lève une erreur non
  interceptée et interrompt l'impression du bordereau de caisse. Correction : `Try` + test
  d'existence (logo ignoré) · appelants : `Bordereaux:153` · tests : T04 · sources : [Cbordereaux.class:64](../../../../.src/Reports/Cbordereaux.class#L64), [Bordereaux.class:153](../../../../.src/Caisse/Bordereaux.class#L153)
