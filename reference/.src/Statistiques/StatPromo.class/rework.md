# StatPromo — Rework

> Source : `.src/Statistiques/StatPromo.class` · Message de commit (phase 4) : `reference/.src/Statistiques/StatPromo.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 142 |
| Lignes de commentaire | 33 |
| Fonctions | 9 |
| Fonctions Public | 9 |
| Complexité cyclomatique totale | 33 |
| Complexité max (fonction) | 12 (`Affichage`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 142 | 33 | 12 | 0 | 9 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] STATPROMO-001 — [documentation] En-tête en français : origine des quantités (caisse,
  `ArtPromo.Maj_qteplus`), calcul de la marge et des totaux · appelants : aucun · tests : T01-T05 · sources : [StatPromo.class:Affichage](../../../../.src/Statistiques/StatPromo.class#L156-L212)
- [ ] STATPROMO-002 — [code mort] Supprimer `CoulZns`, `CoulZnaf`, `Coulfc`, `Frmt`, le
  `With Utils` inutile de `Button3_Click` et le cumul `Pmp` jamais affiché · appelants : aucun ·
  tests : T01-T05 · sources : [StatPromo.class:_new](../../../../.src/Statistiques/StatPromo.class#L31-L48), [StatPromo.class:63](../../../../.src/Statistiques/StatPromo.class#L63), [StatPromo.class:203](../../../../.src/Statistiques/StatPromo.class#L203)
- [ ] STATPROMO-003 — [réduction de portée] `Affichage` → `Private` (`ColPromo_Click` reste
  `Public` : `replay_dynamic`) · appelants : aucun · tests : T01, T02 · sources : [StatPromo.class:Affichage](../../../../.src/Statistiques/StatPromo.class#L156-L212)
- [ ] STATPROMO-004 — [séparation traitement/GUI] Extraire `LignesPromo(sCode)` (requête,
  formats, marge, totaux) ; `Affichage` remplit `Liste` et les totaux · appelants : aucun ·
  tests : T01, T05, T06 · sources : [StatPromo.class:Affichage](../../../../.src/Statistiques/StatPromo.class#L156-L212)
- [ ] STATPROMO-005 — [commonalisation] Remplissage de la liste des promotions partagé avec
  `FpromoArt` (`RemplirListePromo`) ; même SQL · appelants : aucun · tests : T01 · sources : [StatPromo.class:Button3_Click](../../../../.src/Statistiques/StatPromo.class#L59-L90), [FpromoArt.class:119](../../../../.src/Gestion/Tables/FpromoArt.class#L119)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] STATPROMO-A01 — [anomalie] `Pvht += pht` et `Pvttc += pttc` sans protection : un prix NULL
  dans `Fiches_ArtPromo` (colonnes nullables) provoque une erreur de type (à confirmer par T05) ·
  tests : T05 · sources : [StatPromo.class:200](../../../../.src/Statistiques/StatPromo.class#L200), [StatPromo.class:201](../../../../.src/Statistiques/StatPromo.class#L201)
- [ ] STATPROMO-A02 — [anomalie] Totaux `Tht`/`Tttc` = somme des prix unitaires, non pondérés par
  la quantité vendue, alors que `Tmarge` l'est : totaux sans signification commerciale ·
  tests : T01 · sources : [StatPromo.class:200](../../../../.src/Statistiques/StatPromo.class#L200), [StatPromo.class:204](../../../../.src/Statistiques/StatPromo.class#L204)
- [ ] STATPROMO-A03 — [anomalie] `Button1_Click` teste `Label1` (code validé) mais `Affichage`
  lit `CodeP.Text` : un code retapé sans Entrée affiche une autre promotion que celle annoncée ·
  tests : T04 · sources : [StatPromo.class:141](../../../../.src/Statistiques/StatPromo.class#L141), [StatPromo.class:189](../../../../.src/Statistiques/StatPromo.class#L189)
