# Edsdepots — Rework

> Source : `.src/Gestion/Depots/Edsdepots.class` · Message de commit (phase 4) : `reference/.src/Gestion/Depots/Edsdepots.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 253 |
| Lignes de commentaire | 33 |
| Fonctions | 12 |
| Fonctions Public | 12 |
| Complexité cyclomatique totale | 53 |
| Complexité max (fonction) | 15 (`Cmpt_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 253 | 53 | 15 | 0 | 12 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] EDSDEPOTS-001 — [documentation] En-tête : rôle (impression et purge des mouvements),
  période par défaut de 4 ans, boutons sans handler (`Button1`, `Button6`) · appelants : aucun ·
  tests : aucun · sources : [Edsdepots.class:20](../../../../../.src/Gestion/Depots/Edsdepots.class#L20), [Edsdepots.class:_New](../../../../../.src/Gestion/Depots/Edsdepots.class#L34-L45)
- [ ] EDSDEPOTS-002 — [code mort] Supprimer `Level1` et `Level2` (ancienne mise en page jamais
  appelée), `date2_GotFocus` (handler inactif, `Date2` groupé dans `Cmpt`), les variables `p` et
  `Nbpage`, le `Shell "cd …"` et le `Kill "~/Regul.ps"` sans effet · appelants : aucun · tests :
  T01-T03 · sources : [Edsdepots.class:Level1](../../../../../.src/Gestion/Depots/Edsdepots.class#L284-L303), [Edsdepots.class:Level2](../../../../../.src/Gestion/Depots/Edsdepots.class#L306-L318), [Edsdepots.class:date2_GotFocus](../../../../../.src/Gestion/Depots/Edsdepots.class#L157-L161), [Edsdepots.class:201](../../../../../.src/Gestion/Depots/Edsdepots.class#L201), [Edsdepots.class:322](../../../../../.src/Gestion/Depots/Edsdepots.class#L322)
- [ ] EDSDEPOTS-003 — [complexité] `Button2_Click` (CC 15) : extraire `ImprimeMouvements(pdf,
  sType, sTitre)` pour les deux boucles, sortie PDF identique (différence `BasPage` conservée) ·
  appelants : aucun · tests : T01, T03 · sources : [Edsdepots.class:Button2_Click](../../../../../.src/Gestion/Depots/Edsdepots.class#L184-L281)
- [ ] EDSDEPOTS-004 — [séparation traitement/GUI] `MouvementsDepots(sDeb, sFin, sType)` et
  `PurgeMouvements(sDeb, sFin)` sans contrôle (SQL inchangé jusqu'à A02) · appelants : aucun ·
  tests : T01, T04 · sources : [Edsdepots.class:204](../../../../../.src/Gestion/Depots/Edsdepots.class#L204), [Edsdepots.class:234](../../../../../.src/Gestion/Depots/Edsdepots.class#L234), [Edsdepots.class:275](../../../../../.src/Gestion/Depots/Edsdepots.class#L275)
- [ ] EDSDEPOTS-005 — [commonalisation] Saisie de période (normalisation, contrôle début/fin,
  calendrier F2/double-clic) via un helper commun aux écrans de période · appelants : aucun ·
  tests : T05 · sources : [Edsdepots.class:date1_LostFocus](../../../../../.src/Gestion/Depots/Edsdepots.class#L143-L155), [Edsdepots.class:date2_LostFocus](../../../../../.src/Gestion/Depots/Edsdepots.class#L163-L182), [Edsdepots.class:Cmpt_dblclick](../../../../../.src/Gestion/Depots/Edsdepots.class#L105-L130), [Fpromo.class:DateChooser1_Activate](../../../../../.src/Gestion/Tables/Fpromo.class#L158-L171)
- [ ] EDSDEPOTS-006 — [réduction de portée] `date1_LostFocus`, `date2_LostFocus` → `Private`
  (pseudo-handlers de contrôles groupés, appelés seulement par le handler du groupe) · appelants : aucun · tests : T05 · sources : [Edsdepots.class:date1_LostFocus](../../../../../.src/Gestion/Depots/Edsdepots.class#L143-L155), [Edsdepots.class:date2_LostFocus](../../../../../.src/Gestion/Depots/Edsdepots.class#L163-L182)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] EDSDEPOTS-A01 — [anomalie] Le PDF n'est créé que s'il existe des entrées : sans entrée, la
  boucle des sorties appelle `pdf.Entete` sur un objet nul (erreur) ; pas de `BasPage` aux sauts de
  page des entrées · tests : T02 · sources : [Edsdepots.class:208](../../../../../.src/Gestion/Depots/Edsdepots.class#L208), [Edsdepots.class:237](../../../../../.src/Gestion/Depots/Edsdepots.class#L237), [Edsdepots.class:227](../../../../../.src/Gestion/Depots/Edsdepots.class#L227)
- [ ] EDSDEPOTS-A02 — [anomalie] Purge : `DELETE … WHERE datesortie …` sur une colonne inexistante
  (`Fiches_Sdepots.date`) : la purge n'a jamais fonctionné et le message de succès s'affiche
  quand même ; la corriger modifierait aussi le recalcul de stock du dépôt `01` (`Cstock`) ·
  tests : T04 · sources : [Edsdepots.class:275](../../../../../.src/Gestion/Depots/Edsdepots.class#L275), [Edsdepots.class:276](../../../../../.src/Gestion/Depots/Edsdepots.class#L276)
- [ ] EDSDEPOTS-A03 — [anomalie] Jointure depuis `Fiches_Art` : les mouvements d'articles supprimés
  ne sont pas imprimés (le repli « Article inexistant » est inatteignable) · tests : T01 · sources : [Edsdepots.class:204](../../../../../.src/Gestion/Depots/Edsdepots.class#L204), [Edsdepots.class:218](../../../../../.src/Gestion/Depots/Edsdepots.class#L218)
