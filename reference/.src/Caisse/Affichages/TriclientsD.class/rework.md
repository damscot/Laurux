# TriclientsD — Rework

> Source : `.src/Caisse/Affichages/TriclientsD.class` · Message de commit (phase 4) : `reference/.src/Caisse/Affichages/TriclientsD.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 177 |
| Lignes de commentaire | 11 |
| Fonctions | 22 |
| Fonctions Public | 22 |
| Complexité cyclomatique totale | 65 |
| Complexité max (fonction) | 11 (`ColCli_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 177 | 65 | 11 | 0 | 22 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

La classe est morte : la seule évolution utile est sa suppression (TRICLIENTSD-A01, validation
utilisateur). Les étapes ci-dessous ne s'appliquent que si l'utilisateur refuse la suppression.

- [ ] TRICLIENTSD-001 — [documentation] En-tête signalant la classe comme non utilisée, la table
  `Fiches_Clid` sans écrivain et le membre `Caisse.Clicoded` inexistant · appelants : aucun · tests :
  T01 · sources : [TriclientsD.class:_new](../../../../../.src/Caisse/Affichages/TriclientsD.class#L11-L29), [TriclientsD.class:colcli_Click](../../../../../.src/Caisse/Affichages/TriclientsD.class#L64-L70)
- [ ] TRICLIENTSD-002 — [code mort] Supprimer `ClavInput` (jamais appelée) et les commentaires du
  clavier virtuel de `N1_Click` · appelants : aucun · tests : T01 · sources : [TriclientsD.class:ClavInput](../../../../../.src/Caisse/Affichages/TriclientsD.class#L247-L252), [TriclientsD.class:N1_Click](../../../../../.src/Caisse/Affichages/TriclientsD.class#L190-L204)
- [ ] TRICLIENTSD-003 — [réduction de portée] `Tris`, `Deplacement`, `Deb3`, `Deb4`, `Dbclk`, `ChkInput` → `Private` (aucun appelant externe) · appelants : aucun · tests : T01 · sources : [TriclientsD.class:Tris](../../../../../.src/Caisse/Affichages/TriclientsD.class#L31-L39), [TriclientsD.class:Deplacement](../../../../../.src/Caisse/Affichages/TriclientsD.class#L151-L160), [TriclientsD.class:ChkInput](../../../../../.src/Caisse/Affichages/TriclientsD.class#L236-L245)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] TRICLIENTSD-A01 — [anomalie] Supprimer le couple `TriclientsD.class` + `TriclientsD.form` :
  jamais instancié (aucun appelant, aucune chaîne), remplacé par `Tricartes(-1)` ; son seul effet
  (`Caisse.Clicoded`) viserait un membre inexistant. Vérifier `gbc3 -agt` et le rejeu caisse ·
  tests : T01, T02 · sources : [TriclientsD.class:_new](../../../../../.src/Caisse/Affichages/TriclientsD.class#L11-L29), [TriclientsD.class:67](../../../../../.src/Caisse/Affichages/TriclientsD.class#L67)
- [ ] TRICLIENTSD-A02 — [anomalie] (si la classe est conservée) `colcli_Click` écrit
  `Caisse.Clicoded`, membre inexistant (erreur « Unknown symbol » au clic), et `Caisse.Bsel` sur
  l'auto-instance de `Caisse` au lieu de la fenêtre ouverte par `Cmenu` ; passer par
  `Object.SetProperty(ob, "Bsel"/"Bval")` comme `Tricartes` · tests : T01 · sources : [TriclientsD.class:66](../../../../../.src/Caisse/Affichages/TriclientsD.class#L66), [TriclientsD.class:67](../../../../../.src/Caisse/Affichages/TriclientsD.class#L67), [Cmenu.class:253](../../../../../.src/Caisse/Cmenu.class#L253)
