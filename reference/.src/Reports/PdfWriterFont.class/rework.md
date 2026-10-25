# PdfWriterFont — Rework

> Source : `.src/Reports/PdfWriterFont.class` · Message de commit (phase 4) : `reference/.src/Reports/PdfWriterFont.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 400 |
| Lignes de commentaire | 8 |
| Fonctions | 18 |
| Fonctions Public | 18 |
| Complexité cyclomatique totale | 43 |
| Complexité max (fonction) | 19 (`Font`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 400 | 43 | 19 | 0 | 18 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

Principe : chaque fonction renvoie exactement les mêmes 256 (ou 254) valeurs qu'aujourd'hui
(test PDFWRITERFONT-T01), anomalies comprises.

- [ ] PDFWRITERFONT-001 — [documentation] En-tête en français : origine (FPDF 1.53 `font/*.php`),
  unité (millièmes d'em), indexation par octet CP1252, polices réellement utilisées, procédure de
  régénération depuis les AFM (`afm_compare.py`) · appelants : aucun · tests : T01 · sources :
  [PdfWriterFont.class:Font](../../../../.src/Reports/PdfWriterFont.class#L11-L58)
- [ ] PDFWRITERFONT-002 — [commonalisation] Fonction privée `Fixe(largeur)` pour les 7 polices à
  chasse fixe (`courier*`, `serif*`), et suppression du `New Integer[]` inutile de `Font` ; cache
  statique facultatif par nom de police (tableau partagé, jamais modifié par `PdfWriter`) · appelants :
  `PdfWriter` (inchangé) · tests : T01, PDFWRITER-T11 · sources : [PdfWriterFont.class:courier](../../../../.src/Reports/PdfWriterFont.class#L60-L70),
  [PdfWriterFont.class:serifI](../../../../.src/Reports/PdfWriterFont.class#L132-L142), [PdfWriterFont.class:Font](../../../../.src/Reports/PdfWriterFont.class#L11-L58)
- [ ] PDFWRITERFONT-003 — [réduction de portée] Les 17 fonctions par police → `Static Private`
  (appelées seulement par `Font`) · appelants : aucun · tests : T01 · sources :
  [PdfWriterFont.class:helvetica](../../../../.src/Reports/PdfWriterFont.class#L144-L176), [PdfWriterFont.class:zapfdingbats](../../../../.src/Reports/PdfWriterFont.class#L450-L482)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] PDFWRITERFONT-A01 — [anomalie] `Case "serifBI"` appelle `serifBI()`, inexistante : erreur
  d'exécution pour `SetFont("serif", "BI")`. Correction : supprimer les polices « Serif » (non
  standard, largeurs de Courier) ou ajouter la fonction · tests : T02 · sources :
  [PdfWriterFont.class:49](../../../../.src/Reports/PdfWriterFont.class#L49), [PdfWriter.class:245](../../../../.src/Reports/PdfWriter.class#L245)
- [ ] PDFWRITERFONT-A02 — [anomalie] `helvetica[0xD8]` = 39778 au lieu de 778 (faute de frappe ;
  devient visible après PDFWRITER-A02) · tests : T01 · sources : [PdfWriterFont.class:169](../../../../.src/Reports/PdfWriterFont.class#L169)
- [ ] PDFWRITERFONT-A03 — [anomalie] Table `symbol` corrompue (254 valeurs, « 987603 » à 0xAE, 53
  écarts avec l'AFM) ; police inutilisée. Correction : régénération depuis l'AFM · tests : T01 ·
  sources : [PdfWriterFont.class:symbol](../../../../.src/Reports/PdfWriterFont.class#L280-L312), [PdfWriterFont.class:301](../../../../.src/Reports/PdfWriterFont.class#L301)
