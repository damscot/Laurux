# TarArt — Rework

> Source : `.src/Utils/TarArt.class` · Message de commit (phase 4) : `reference/.src/Utils/TarArt.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 148 |
| Lignes de commentaire | 7 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 37 |
| Complexité max (fonction) | 32 (`_new`) |
| Variables globales | 0 |
| Variables Public | 7 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 148 | 37 | 32 | 0 | 4 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] TARART-001 — [documentation] En-tête : ordre de priorité des tarifs, sens des variables
  publiques, options B/T · appelants : aucun · tests : aucun · sources : [TarArt.class:_new](../../../../.src/Utils/TarArt.class#L15-L145)
- [ ] TARART-002 — [séparation traitement/GUI] Extraire le calcul de `_new` dans une fonction
  `CalculTarif(...)` sans accès à la grille (mêmes requêtes, même ordre) ; `_new` l'appelle puis
  configure `GridView1` ; signature de `_new` inchangée · appelants : aucun · tests : T01-T12 · sources : [TarArt.class:_new](../../../../.src/Utils/TarArt.class#L15-L145)
- [ ] TARART-003 — [complexité] Helper privé `AjouteTarif(libelle, prix, retenu, …)` pour les 6
  ajouts de candidats ; supprimer les affectations redondantes du bloc `Fiches_TarTypcli` (CC 32 →
  ≤ 15 visé) · tests : T01-T10 · sources : [TarArt.class:_new](../../../../.src/Utils/TarArt.class#L15-L145), [TarArt.class:85-100](../../../../.src/Utils/TarArt.class#L85-L100)
- [ ] TARART-004 — [réarchitecture] `Edart4` utilise `CalculTarif` au lieu d'instancier un formulaire
  par article (résultats identiques) · appelants : `Edart4` · tests : T12 · sources : [Edart4.class:141](../../../../.src/Gestion/Impressions/Edart4.class#L141)
- [ ] TARART-005 — [réarchitecture] `Cbase.Table(...)` pour les tables mappées (`TabArt`, `TabFam`,
  `TabCli`…) · tests : T01-T10 · sources : [TarArt.class:_new](../../../../.src/Utils/TarArt.class#L15-L145)
- [ ] TARART-006 — [réduction de portée] `remise` → `Private` si l'utilisateur confirme l'abandon de
  la ligne commentée `Facture:4977` · appelants : aucun · tests : T02, T05 · sources : [TarArt.class:9](../../../../.src/Utils/TarArt.class#L9), [Facture.class:4977](../../../../.src/Gestion/Facturation/Facture.class#L4977)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] TARART-A01 — [anomalie] `_new:27` lit `art_prvt` avant le test `Available` : article inconnu →
  erreur levée chez l'appelant ; retours anticipés sans arrondi de `prixht` ni configuration de la
  grille · tests : T09 · sources : [TarArt.class:27-28](../../../../.src/Utils/TarArt.class#L27-L28), [TarArt.class:42](../../../../.src/Utils/TarArt.class#L42)
- [ ] TARART-A02 — [anomalie] Bloc `Fiches_CoeffTypec` : `rescli` peut être `Null` (ni client ni
  type) et toutes les lignes portent le libellé du type courant au lieu de celui de `res!coder`
  · tests : T03, T09 · sources : [TarArt.class:75](../../../../.src/Utils/TarArt.class#L75), [TarArt.class:80](../../../../.src/Utils/TarArt.class#L80)
- [ ] TARART-A03 — [anomalie] Promotion en options B/T : `pxprom` (brut) comparé à `prixht` (déjà
  diminué des droits), à confirmer avec l'utilisateur · tests : T08 · sources : [TarArt.class:125-128](../../../../.src/Utils/TarArt.class#L125-L128)
- [ ] TARART-A04 — [anomalie] `Edart4` crée une fenêtre cachée `TarArt` par article sans la détruire
  (fuite de ressources sur une grosse édition) · tests : T12 · sources : [Edart4.class:141](../../../../.src/Gestion/Impressions/Edart4.class#L141)
