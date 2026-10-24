# Changefour — Rework

> Source : `.src/Utils/Changefour.class` · Message de commit (phase 4) : `reference/.src/Utils/Changefour.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 411 |
| Lignes de commentaire | 52 |
| Fonctions | 20 |
| Fonctions Public | 20 |
| Complexité cyclomatique totale | 90 |
| Complexité max (fonction) | 12 (`Cmpt_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 411 | 90 | 12 | 0 | 20 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CHANGEFOUR-001 — [documentation] Corriger l'en-tête (nom `ChangeFam.class` et description
  « famille » erronés), décrire les 4 modes · appelants : aucun · tests : aucun · sources : [Changefour.class:21](../../../../.src/Utils/Changefour.class#L21)
- [ ] CHANGEFOUR-002 — [code mort] Variable `b` et branches mortes de `Cmpt_KeyPress`, cas
  commentés, `With utils`, double `Stop Event`, écriture inutile de `Variables.bsel`, `Rarts` de
  `AjoutArt` gardé tant que A01 n'est pas tranchée (seule la variable inutilisée est retirée si le
  `SELECT` reste) · tests : T01, T04, T07 · sources : [Changefour.class:Cmpt_KeyPress](../../../../.src/Utils/Changefour.class#L50-L105), [Changefour.class:Btn_Click](../../../../.src/Utils/Changefour.class#L255-L292), [Changefour.class:SelectionFour3](../../../../.src/Utils/Changefour.class#L202-L218), [Changefour.class:AjoutArt](../../../../.src/Utils/Changefour.class#L132-L150)
- [ ] CHANGEFOUR-003 — [complexité] `Change` : remplacer la boucle `Repeat` sur un résultat d'une
  ligne par `If r2Result.Available Then UPDATE` (même `SELECT` et même `UPDATE` émis une fois : log
  identique) · tests : T01, T06 · sources : [Changefour.class:Change](../../../../.src/Utils/Changefour.class#L297-L340)
- [ ] CHANGEFOUR-004 — [commonalisation] `SelectionFour/2/3` → helper privé
  `ChoisirFournisseur(hSaisie, sOrg)` · tests : T01, T03, T07 · sources : [Changefour.class:SelectionFour](../../../../.src/Utils/Changefour.class#L168-L183), [Changefour.class:SelectionFour2](../../../../.src/Utils/Changefour.class#L185-L200), [Changefour.class:SelectionFour3](../../../../.src/Utils/Changefour.class#L202-L218)
- [ ] CHANGEFOUR-005 — [commonalisation] Classe commune avec `Changefam` (import CSV dynamique +
  table temporaire de liste), cf. CHANGEFAM-005 · appelants : `Changefam` · tests : T04, T06 · sources : [Changefour.class:Fichier_Click](../../../../.src/Utils/Changefour.class#L438-L482), [Changefour.class:Bouton1_Click](../../../../.src/Utils/Changefour.class#L484-L500), [Changefour.class:Bouton3_Click](../../../../.src/Utils/Changefour.class#L537-L542), [Changefour.class:Liste_Click](../../../../.src/Utils/Changefour.class#L416-L436), [Changefour.class:AjoutArt](../../../../.src/Utils/Changefour.class#L132-L150)
- [ ] CHANGEFOUR-006 — [séparation traitement/GUI] Extraire `ChangeFournisseur(code, four)`,
  `ChangeFournisseurGlobal(ancien, nouveau)`, `TraiterListe()` sans accès aux contrôles · tests :
  T01, T03, T04, T06 · sources : [Changefour.class:Change](../../../../.src/Utils/Changefour.class#L297-L340), [Changefour.class:Change2](../../../../.src/Utils/Changefour.class#L345-L380), [Changefour.class:Change3](../../../../.src/Utils/Changefour.class#L385-L414)
- [ ] CHANGEFOUR-007 — [réarchitecture] `Cbase.Table("TabArt")` / `Cbase.Table("TabFour")` à la
  place des noms en dur · tests : tous · sources : [Changefour.class:art_man](../../../../.src/Utils/Changefour.class#L113-L130), [Changefour.class:Change](../../../../.src/Utils/Changefour.class#L297-L340), [Changefour.class:Change2](../../../../.src/Utils/Changefour.class#L345-L380), [Changefour.class:Change3](../../../../.src/Utils/Changefour.class#L385-L414)
- [ ] CHANGEFOUR-008 — [réduction de portée] `art_man`, `AjoutArt`, `SelectionArt`,
  `SelectionFour*`, `fourman`, `Change`, `Change2`, `Change3` → `Private` · tests : tous · sources : [Changefour.class:art_man](../../../../.src/Utils/Changefour.class#L113-L130), [Changefour.class:fourman](../../../../.src/Utils/Changefour.class#L223-L253), [Changefour.class:Change](../../../../.src/Utils/Changefour.class#L297-L340)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] CHANGEFOUR-A01 — [anomalie] `AjoutArt:138` : `SELECT … WHERE code = &1` sur `CFour` (colonne
  `codeart`) → erreur SQL au lieu du message « déjà saisi » · tests : T05 · sources : [Changefour.class:138](../../../../.src/Utils/Changefour.class#L138), [Changefour.class:AjoutArt](../../../../.src/Utils/Changefour.class#L132-L150)
- [ ] CHANGEFOUR-A02 — [anomalie] `Change2` : messages « ancien »/« nouveau fournisseur » inversés et
  focus sur `Nfour` au lieu de `Nfour2` · tests : T03 · sources : [Changefour.class:363-378](../../../../.src/Utils/Changefour.class#L363-L378), [Changefour.class:Change2](../../../../.src/Utils/Changefour.class#L345-L380)
- [ ] CHANGEFOUR-A03 — [anomalie] `Bsel` n'est pas remis à `False` avant `TriCpt` : une annulation
  reprend l'ancien `Bval` · tests : T07 · sources : [Changefour.class:SelectionFour](../../../../.src/Utils/Changefour.class#L168-L183), [Changefour.class:SelectionFour2](../../../../.src/Utils/Changefour.class#L185-L200), [Changefour.class:SelectionFour3](../../../../.src/Utils/Changefour.class#L202-L218)
- [ ] CHANGEFOUR-A04 — [anomalie] Aucun contrôle du fournisseur saisi au clavier (cas `Tag 2..5`
  commentés) ni dans `Change`/`Change2` : un code fournisseur inexistant est écrit dans
  `art_four` · tests : T01, T03 · sources : [Changefour.class:Cmpt_KeyPress](../../../../.src/Utils/Changefour.class#L50-L105), [Changefour.class:Change](../../../../.src/Utils/Changefour.class#L297-L340), [Changefour.class:Change2](../../../../.src/Utils/Changefour.class#L345-L380)
- [ ] CHANGEFOUR-A05 — [anomalie] `Bouton2_Click` : ligne sans `;` → dépassement d'indice ;
  `Liste_Click` ne vide pas `listBart` · tests : T04, T06 · sources : [Changefour.class:517](../../../../.src/Utils/Changefour.class#L517), [Changefour.class:Liste_Click](../../../../.src/Utils/Changefour.class#L416-L436)
