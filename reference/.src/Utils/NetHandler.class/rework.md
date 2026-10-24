# NetHandler — Rework

> Source : `.src/Utils/NetHandler.class` · Message de commit (phase 4) : `reference/.src/Utils/NetHandler.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 43 |
| Lignes de commentaire | 4 |
| Fonctions | 5 |
| Fonctions Public | 5 |
| Complexité cyclomatique totale | 16 |
| Complexité max (fonction) | 5 (`Open`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 43 | 16 | 5 | 0 | 5 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] NETHANDLER-001 — [documentation] Commentaires en français : rôle, états de `Step` (0/1/2),
  contrat `LogHandler` (méthodes appelées par gb.logging), commande serveur `nc` · appelants : aucun ·
  tests : aucun · sources : [NetHandler.class:Open](../../../../.src/Utils/NetHandler.class#L25-L44), [NetHandler.class:GetOutput](../../../../.src/Utils/NetHandler.class#L66-L76)
- [ ] NETHANDLER-002 — [code mort] Supprimer `$sLogStream` et la ligne commentée `Blocking` ·
  appelants : aucun · tests : T01 à T04 · sources : [NetHandler.class:12](../../../../.src/Utils/NetHandler.class#L12)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] NETHANDLER-A01 — [anomalie] `Open` : attente de connexion sans délai maximal (blocage du
  démarrage si l'hôte ne répond pas) · tests : T02, test manuel · sources : [NetHandler.class:Open](../../../../.src/Utils/NetHandler.class#L25-L44), [NetHandler.class:32-34](../../../../.src/Utils/NetHandler.class#L32-L34)
- [ ] NETHANDLER-A02 — [anomalie] `Write` : pas de gestion de la perte de connexion (erreur
  d'écriture non interceptée, à confirmer) · tests : T04 · sources : [NetHandler.class:Write](../../../../.src/Utils/NetHandler.class#L46-L54), [NetHandler.class:52](../../../../.src/Utils/NetHandler.class#L52)
