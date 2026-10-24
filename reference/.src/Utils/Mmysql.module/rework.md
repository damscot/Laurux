# Mmysql — Rework

> Source : `.src/Utils/Mmysql.module` · Message de commit (phase 4) : `reference/.src/Utils/Mmysql.module/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 27 |
| Lignes de commentaire | 1 |
| Fonctions | 2 |
| Fonctions Public | 2 |
| Complexité cyclomatique totale | 11 |
| Complexité max (fonction) | 7 (`Process_List`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 27 | 11 | 7 | 0 | 2 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] MMYSQL-001 — [documentation] Commentaires en français : rôle, prérequis (`gksu`/`kdesu`,
  `/etc/init.d/mysql`, `~/tmp`), signification du retour 0 de `Process_List` · appelants : aucun ·
  tests : aucun · sources : [Mmysql.module:Init](../../../../.src/Utils/Mmysql.module#L5-L18), [Mmysql.module:Process_List](../../../../.src/Utils/Mmysql.module#L20-L36)
- [ ] MMYSQL-002 — [complexité] `Init` : fusion de la branche GNOME avec le défaut (même commande) ·
  appelants : aucun · tests : T03 · sources : [Mmysql.module:7-14](../../../../.src/Utils/Mmysql.module#L7-L14)
- [ ] MMYSQL-003 — [commonalisation] `Process_List` utilise le helper de ligne de commande MySQL
  d'UTILS-014 (après celui-ci), sortie et code identiques · appelants : `FSauve`, `FRestore` ·
  tests : T01, T02 · sources : [Mmysql.module:Process_List](../../../../.src/Utils/Mmysql.module#L20-L36)

### Anomalies : changement de comportement, validation utilisateur requise

- [ ] MMYSQL-A01 — [anomalie] `Process_List` détecte l'échec d'authentification par le mot
  « incorrecte » : en locale anglaise, un mauvais mot de passe n'est pas détecté par `FSauve` /
  `FRestore` · tests : T02 · sources : [Mmysql.module:28](../../../../.src/Utils/Mmysql.module#L28)
- [ ] MMYSQL-A02 — [anomalie] `Init` dépend de `gksu`/`kdesu` et de `/etc/init.d/mysql`, absents
  des distributions récentes : le redémarrage échoue silencieusement. Correction possible :
  `pkexec systemctl restart mariadb|mysql` · tests : T03 · sources : [Mmysql.module:15-16](../../../../.src/Utils/Mmysql.module#L15-L16)
