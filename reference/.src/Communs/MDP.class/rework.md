# MDP — Rework

> Source : `.src/Communs/MDP.class` · Message de commit (phase 4) : `reference/.src/Communs/MDP.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 33 |
| Lignes de commentaire | 4 |
| Fonctions | 3 |
| Fonctions Public | 3 |
| Complexité cyclomatique totale | 11 |
| Complexité max (fonction) | 6 (`Mdp2_LF`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 33 | 11 | 6 | 0 | 3 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] MDP-001 — [documentation] En-tête : rôle, protocole `Start.Motdepasse` (`"OK"`/`""`, remise à
  `""` par l'appelant), modes local/global et clés `MdpPrefs`/`MdpPrefsG` · appelants : aucun ·
  tests : aucun · sources : [MDP.class:_new](../../../../.src/Communs/MDP.class#L5-L10), [MDP.class:Mdp2_LF](../../../../.src/Communs/MDP.class#L21-L49)
- [ ] MDP-002 — [complexité] `admn` Integer → Boolean, `If … Else` unique · appelants : aucun ·
  tests : T01, T02 · sources : [MDP.class:Mdp2_LF](../../../../.src/Communs/MDP.class#L21-L49)
- [ ] MDP-003 — [commonalisation] Fonctions statiques `Verifie(sSaisie, Optional bGlobal) As Boolean`
  (pure, utilisée par `Mdp2_LF`, `Prgm.Mdp_LF`, `Prefs.Mdp_LF`) et `Autorise(Optional bGlobal) As
  Boolean` (dialogue + protocole `Start.Motdepasse`, utilisée par `Fmenu` et `Fsoc`) ; ajout d'API,
  comportement inchangé · appelants : `Fmenu` (FMENU-006), `Prgm` (PRGM-003), `Fsoc`, `Prefs` ·
  tests : T01-T05, FMENU-T12, PRGM-T01 · sources : [MDP.class:Mdp2_LF](../../../../.src/Communs/MDP.class#L21-L49), [Prgm.class:Mdp_LF](../../../../.src/Communs/Prgm.class#L26-L45), [Prefs.class:Mdp_LF](../../../../.src/Communs/Prefs.class#L461-L483), [Fsoc.class:400-408](../../../../.src/Communs/Fsoc.class#L400-L408)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] MDP-A01 — [anomalie, sécurité] Si `/Admin` est actif sans mot de passe enregistré, le
  déchiffrement de la clé absente donne vraisemblablement `""` et une saisie vide est acceptée (à
  confirmer) · tests : T05 · sources : [MDP.class:32-33](../../../../.src/Communs/MDP.class#L32-L33)
- [ ] MDP-A02 — [anomalie] La touche Tab valide la saisie (perte de focus = tentative) et l'aide
  « Escape pour sortir » n'est pas implémentée · tests : T02, T04 · sources : [MDP.class:Mdp2_KeyPress](../../../../.src/Communs/MDP.class#L15-L19)
