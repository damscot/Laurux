# hexdblKey — Rework

> Source : `.src/Utils/hexdblKey.module` · Message de commit (phase 4) : `reference/.src/Utils/hexdblKey.module/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 38 |
| Lignes de commentaire | 24 |
| Fonctions | 4 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 11 |
| Complexité max (fonction) | 4 (`Crypt`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 38 | 11 | 4 | 0 | 1 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] HEXDBLKEY-001 — [documentation] Commentaire en français sous l'en-tête de licence : il s'agit
  d'une obfuscation (XOR + hexadécimal), pas d'un chiffrement ; actions acceptées ; retour `""` en cas
  d'erreur · appelants : aucun · tests : aucun · sources : [hexdblKey.module:Crypt](../../../../.src/Utils/hexdblKey.module#L28-L39)
- [ ] HEXDBLKEY-002 — [complexité] Normalisation de `sAction` simplifiée (constantes), comportement
  identique pour toutes les casses · appelants : aucun · tests : T01, T02, T03 · sources : [hexdblKey.module:30-36](../../../../.src/Utils/hexdblKey.module#L30-L36)
- [ ] HEXDBLKEY-003 — [commonalisation] Constantes Public `CLE_CONF = "Laurux"` et
  `CLE_SSH = "LauruX2012"` ; les appelants les adoptent lors de leur propre rework · appelants : les
  16 fichiers listés dans dependencies.md (progressivement) · tests : T04 · sources : [hexdblKey.module:Crypt](../../../../.src/Utils/hexdblKey.module#L28-L39), [Utils.module:101](../../../../.src/Utils/Utils.module#L101), [Utils.module:113](../../../../.src/Utils/Utils.module#L113)

### Anomalies : changement de comportement, validation utilisateur requise

- [ ] HEXDBLKEY-A01 — [anomalie, sécurité] Les mots de passe sont seulement obscurcis avec une clé
  publique dans les sources : toute personne ayant accès à `Laurux.conf` les retrouve. Correction
  (trousseau, hachage) hors périmètre du rework, à décider par l'utilisateur · tests : T04 · sources : [hexdblKey.module:Crypting](../../../../.src/Utils/hexdblKey.module#L41-L54), [Utils.module:101](../../../../.src/Utils/Utils.module#L101)
