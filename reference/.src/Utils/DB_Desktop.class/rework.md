# DB_Desktop — Rework

> Source : `.src/Utils/DB_Desktop.class` · Message de commit (phase 4) : `reference/.src/Utils/DB_Desktop.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 31 |
| Lignes de commentaire | 1 |
| Fonctions | 3 |
| Fonctions Public | 2 |
| Complexité cyclomatique totale | 7 |
| Complexité max (fonction) | 3 (`SendKey`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 31 | 7 | 3 | 0 | 2 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] DB_DESKTOP-001 — [documentation] En-tête : rôle (frappes simulées X11/Wayland), nom trompeur
  `DB_`, dépendance à `wayland.sh`, table `correspondance` · appelants : aucun · tests : aucun · sources : [DB_Desktop.class:_new](../../../../.src/Utils/DB_Desktop.class#L9-L21)
- [ ] DB_DESKTOP-002 — [complexité] `_new` : `Application.Env["XDG_SESSION_TYPE"]` au lieu de
  `Shell "echo …"` (même valeur, sans processus) · appelants : aucun · tests : T01 · sources : [DB_Desktop.class:_new](../../../../.src/Utils/DB_Desktop.class#L9-L21)
- [ ] DB_DESKTOP-003 — [séparation traitement/GUI] `ydotool()` : détection pure
  `YdotoolPresent() As Boolean` (même commande `apt list`) et `Message.Info` dans l'appelant ·
  appelants : aucun · tests : T03 · sources : [DB_Desktop.class:ydotool](../../../../.src/Utils/DB_Desktop.class#L37-L46)
- [ ] DB_DESKTOP-004 — [réduction de portée] `correspondance` → `Private` · appelants : aucun · tests : T02 · sources : [DB_Desktop.class:7](../../../../.src/Utils/DB_Desktop.class#L7)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] DB_DESKTOP-A01 — [anomalie] `SendKey` sous Wayland : argument non quoté (injection shell,
  texte coupé aux espaces) et `Shell` asynchrone (ordre des frappes non garanti) · tests : T02 · sources : [DB_Desktop.class:SendKey](../../../../.src/Utils/DB_Desktop.class#L23-L35), [DB_Desktop.class:29](../../../../.src/Utils/DB_Desktop.class#L29)
- [ ] DB_DESKTOP-A02 — [anomalie] Détection de ydotool par `apt list` : message affiché à tort à
  chaque démarrage sur une distribution sans `apt` · tests : T03 · sources : [DB_Desktop.class:41](../../../../.src/Utils/DB_Desktop.class#L41)
- [ ] DB_DESKTOP-A03 — [anomalie] `TextReg.class:186` et `ReplayObserver.class:210` appellent
  `SendKeys` (hérité) et contournent le routage Wayland · tests : T04 · sources : [TextReg.class:186](../../../../.src/Utils/TextReg.class#L186), [ReplayObserver.class:210](../../../../.src/Utils/ReplayObserver.class#L210)
