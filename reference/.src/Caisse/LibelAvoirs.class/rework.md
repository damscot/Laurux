# LibelAvoirs — Rework

> Source : `.src/Caisse/LibelAvoirs.class` · Message de commit (phase 4) : `reference/.src/Caisse/LibelAvoirs.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 34 |
| Lignes de commentaire | 26 |
| Fonctions | 5 |
| Fonctions Public | 5 |
| Complexité cyclomatique totale | 11 |
| Complexité max (fonction) | 4 (`Btn_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 34 | 11 | 4 | 0 | 5 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] LIBELAVOIRS-001 — [documentation] En-tête : rôle, table mono-ligne `Fiches_LibelAvoirs` (UPDATE sans
  `WHERE` volontaire), lecteur `Caisse.class:289`, limite de 250 caractères · appelants : aucun · tests :
  aucun · sources : [LibelAvoirs.class:Form_Open](../../../../.src/Caisse/LibelAvoirs.class#L36-L43), [LibelAvoirs.class:Button2_Click](../../../../.src/Caisse/LibelAvoirs.class#L63-L77)
- [ ] LIBELAVOIRS-002 — [code mort] Supprimer `Music.Load` (aucun `Music.Play` dans l'écran) et la
  branche vide `Case 1` de `Btn_Click` (`Button1` hors du groupe `Btn`) · appelants : aucun ·
  tests : T01 · sources : [LibelAvoirs.class:_New](../../../../.src/Caisse/LibelAvoirs.class#L28-L34), [LibelAvoirs.class:Btn_Click](../../../../.src/Caisse/LibelAvoirs.class#L45-L61)
- [ ] LIBELAVOIRS-003 — [séparation traitement/GUI] Fonctions privées `LitTexte() As String` et
  `EcritTexte(sTexte)` sans accès aux contrôles, SQL identique · appelants : aucun · tests :
  T01-T03 · sources : [LibelAvoirs.class:Form_Open](../../../../.src/Caisse/LibelAvoirs.class#L36-L43), [LibelAvoirs.class:Button2_Click](../../../../.src/Caisse/LibelAvoirs.class#L63-L77)
- [ ] LIBELAVOIRS-004 — [commonalisation] Remplacer `LitTexte`/`EcritTexte` par les fonctions
  « texte unique » communes à Tleg, Tmail, LibelFac, LibelTicket et LibelAvoirs (voir TLEG-003,
  LIBELFAC-004), SQL identique · appelants : aucun · tests : T01-T03 · sources : [LibelAvoirs.class:Form_Open](../../../../.src/Caisse/LibelAvoirs.class#L36-L43), [LibelAvoirs.class:Button2_Click](../../../../.src/Caisse/LibelAvoirs.class#L63-L77), [LibelFac.class:Button2_Click](../../../../.src/Gestion/Tables/LibelFac.class#L66-L82)
- [ ] LIBELAVOIRS-005 — [réduction de portée] `Button2_Click` → `Private` (pseudo-handler du groupe
  `Btn`, appelé seulement par `Btn_Click`) · appelants : aucun · tests : T01 · sources : [LibelAvoirs.class:Button2_Click](../../../../.src/Caisse/LibelAvoirs.class#L63-L77)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] LIBELAVOIRS-A01 — [anomalie] Texte vide non enregistrable (impossible d'effacer le texte) ;
  `ReplaceLb` altère `"` et `&` ; aucun retour visuel après l'enregistrement (même défaut que
  LIBELFAC-A01) · tests : T02, T03 · sources : [LibelAvoirs.class:Button2_Click](../../../../.src/Caisse/LibelAvoirs.class#L63-L77)
- [ ] LIBELAVOIRS-A02 — [anomalie] Écran non instrumenté (`Utils.Observers(Me)` absent) : saisie et
  enregistrement non journalisés, donc non rejouables · tests : T01 · sources : [LibelAvoirs.class:_New](../../../../.src/Caisse/LibelAvoirs.class#L28-L34)
