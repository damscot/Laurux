# TestCaisses — Rework

> Source : `.src/Caisse/TestCaisses.module` · Message de commit (phase 4) : `reference/.src/Caisse/TestCaisses.module/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 25 |
| Lignes de commentaire | 2 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 6 |
| Complexité max (fonction) | 6 (`TestCai`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 25 | 6 | 6 | 0 | 1 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] TESTCAISSES-001 — [documentation] En-tête : contrôle d'exécution (et non harnais de test),
  format des verrous `~/Caisse<N>.lock`, valeur de retour `"0"`/`"1"`, comparaison sur le premier
  caractère · appelants : aucun · tests : aucun · sources : [TestCaisses.module:TestCai](../../../../.src/Caisse/TestCaisses.module#L3-L31)
- [ ] TESTCAISSES-002 — [séparation traitement/GUI] Extraire `CaisseDuVendeur(Cai, Vdr) As
  Integer` (lecture des verrous, même règle de comparaison) ; `TestCai` garde le
  `Message.Warning` et le retour identiques · appelants : aucun (`Ouverture` inchangé) · tests :
  T01-T04 · sources : [TestCaisses.module:TestCai](../../../../.src/Caisse/TestCaisses.module#L3-L31)
- [ ] TESTCAISSES-003 — [complexité] Fermer le fichier avant `Break` et renvoyer explicitement
  `CStr(b)` (comportement identique) · appelants : aucun · tests : T01, T02 · sources : [TestCaisses.module:24](../../../../.src/Caisse/TestCaisses.module#L24), [TestCaisses.module:29](../../../../.src/Caisse/TestCaisses.module#L29)
- [ ] TESTCAISSES-004 — [commonalisation] Module `VerrouCaisse` (chemin, lecture, écriture,
  suppression des `~/Caisse<N>.lock`) utilisé par `TestCaisses` et `Ouverture.Button1_Click`,
  sans changer le format ni les chemins · appelants : `Ouverture` · tests : T01-T04, tests
  d'`Ouverture` · sources : [TestCaisses.module:TestCai](../../../../.src/Caisse/TestCaisses.module#L3-L31), [Ouverture.class:Button1_Click](../../../../.src/Caisse/Ouverture.class#L155-L227)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] TESTCAISSES-A01 — [anomalie] Le message « Cette caissière est déjà utilisée sur la caisse »
  affiche le premier caractère du code vendeur (`$Vdr`) au lieu du numéro de caisse `C` · tests :
  T02 · sources : [TestCaisses.module:22](../../../../.src/Caisse/TestCaisses.module#L22)
- [ ] TESTCAISSES-A02 — [anomalie] Comparaison sur le seul premier caractère du code vendeur
  (`char(2)`) : deux vendeurs `10` et `11` sont pris pour le même et le second ne peut pas se
  connecter. Correction à faire avec `Ouverture` (qui passe `Left$(Caissiere.Text, 1)`) · tests :
  T03 · sources : [TestCaisses.module:20](../../../../.src/Caisse/TestCaisses.module#L20), [Ouverture.class:200](../../../../.src/Caisse/Ouverture.class#L200)
