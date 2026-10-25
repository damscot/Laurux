# Edregul — Rework

> Source : `.src/Gestion/Impressions/Edregul.class` · Message de commit (phase 4) : `reference/.src/Gestion/Impressions/Edregul.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 153 |
| Lignes de commentaire | 31 |
| Fonctions | 8 |
| Fonctions Public | 8 |
| Complexité cyclomatique totale | 37 |
| Complexité max (fonction) | 13 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 153 | 37 | 13 | 0 | 8 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] EDREGUL-001 — [documentation] Corriger l'en-tête (« Impression des Bl fournisseurs » →
  régularisations de stock), documenter la période par défaut, la purge et les boutons sans
  handler (`Button1`, `Button6`) · appelants : aucun · tests : aucun · sources : [Edregul.class:24](../../../../../.src/Gestion/Impressions/Edregul.class#L24), [Edregul.class:_New](../../../../../.src/Gestion/Impressions/Edregul.class#L34-L45)
- [ ] EDREGUL-002 — [code mort] Supprimer `date2_GotFocus` (handler inactif, `Date2` groupé dans
  `Cmpt`), `PosX`, les variables `p`, `Nbpage`, `dte`, le `Shell "cd …"` et le `If … Then Endif`
  vide (l'appel `Message.Warning` est conservé) · appelants : aucun · tests : T01-T05 · sources : [Edregul.class:date2_GotFocus](../../../../../.src/Gestion/Impressions/Edregul.class#L105-L109), [Edregul.class:32](../../../../../.src/Gestion/Impressions/Edregul.class#L32), [Edregul.class:122](../../../../../.src/Gestion/Impressions/Edregul.class#L122), [Edregul.class:153](../../../../../.src/Gestion/Impressions/Edregul.class#L153)
- [ ] EDREGUL-003 — [réduction de portée] `date1_LostFocus`, `date2_LostFocus` → `Private`
  (pseudo-handlers de contrôles groupés, appelés seulement par `Cmpt_KeyPress`) · appelants : aucun
  · tests : T05 · sources : [Edregul.class:date1_LostFocus](../../../../../.src/Gestion/Impressions/Edregul.class#L91-L103), [Edregul.class:date2_LostFocus](../../../../../.src/Gestion/Impressions/Edregul.class#L111-L130)
- [ ] EDREGUL-004 — [commonalisation] Module commun d'impression/purge des mouvements
  (`ImprimeMouvements(sTable, sTitre, sOrdre, bSeparateur)`, `PurgeMouvements`) partagé avec
  `Edregulprdc` (sortie identique pour chacun ; même commit qu'EDREGULPRDC-004) · appelants :
  aucun · tests : T01-T04, T07 et tests d'`Edregulprdc` · sources : [Edregul.class:Button2_Click](../../../../../.src/Gestion/Impressions/Edregul.class#L132-L210), [Edregulprdc.class:Button2_Click](../../../../../.src/Gestion/Impressions/Edregulprdc.class#L132-L214)
- [ ] EDREGUL-005 — [séparation traitement/GUI] `ListeRegularisations(sDeb, sFin)` (avec `LEFT
  JOIN` sur `<TabArt>` et `Cbase.Table("TabMvtexp")` ; SQL modifié, dump identique, texte PDF
  identique) et `PurgeRegularisations(sDeb, sFin)` (SQL inchangé jusqu'à A01) · appelants : aucun ·
  tests : T01-T04 · sources : [Edregul.class:164](../../../../../.src/Gestion/Impressions/Edregul.class#L164), [Edregul.class:168](../../../../../.src/Gestion/Impressions/Edregul.class#L168), [Edregul.class:197](../../../../../.src/Gestion/Impressions/Edregul.class#L197)
- [ ] EDREGUL-006 — [commonalisation] Saisie de période (`Cmpt_KeyPress`, normalisation,
  contrôle fin ≥ début) via le helper commun aux écrans de période (`Edregulprdc`, `Edpaiement`,
  `Edsdepots`) · appelants : aucun · tests : T05 · sources : [Edregul.class:Cmpt_KeyPress](../../../../../.src/Gestion/Impressions/Edregul.class#L50-L78), [Edregul.class:date2_LostFocus](../../../../../.src/Gestion/Impressions/Edregul.class#L111-L130), [Edsdepots.class:date2_LostFocus](../../../../../.src/Gestion/Depots/Edsdepots.class#L163-L182)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] EDREGUL-A01 — [anomalie] **Perte de données** : la purge exécute `DELETE … WHERE code = &1`
  pour chaque ligne de la période, ce qui supprime **toutes** les régularisations de l'article, y
  compris hors période (correction : `DELETE … WHERE mind = &1` ou filtre sur la période) · tests :
  T02 · sources : [Edregul.class:201](../../../../../.src/Gestion/Impressions/Edregul.class#L201)
- [ ] EDREGUL-A02 — [anomalie] Purge proposée et message « Les mouvements ont été effacés »
  affiché même quand la période ne contient aucun mouvement · tests : T04 · sources : [Edregul.class:194](../../../../../.src/Gestion/Impressions/Edregul.class#L194), [Edregul.class:205](../../../../../.src/Gestion/Impressions/Edregul.class#L205)
- [ ] EDREGUL-A03 — [anomalie, à confirmer en replay] Une date quittée à la souris n'est pas
  normalisée (`date*_LostFocus` jamais levés pour un contrôle groupé) : saisie abrégée transmise
  telle quelle à `Cdate_Dbase` · tests : T06 · sources : [Edregul.class:date1_LostFocus](../../../../../.src/Gestion/Impressions/Edregul.class#L91-L103), [Edregul.class:164](../../../../../.src/Gestion/Impressions/Edregul.class#L164)
- [ ] EDREGUL-A04 — [anomalie] `Button3_Click` supprime `~/Regul.pdf` au lieu de
  `~/tmp/Regul.pdf` : le PDF temporaire n'est jamais effacé · tests : aucun (vérification du
  fichier) · sources : [Edregul.class:214](../../../../../.src/Gestion/Impressions/Edregul.class#L214), [Edregul.class:154](../../../../../.src/Gestion/Impressions/Edregul.class#L154)
