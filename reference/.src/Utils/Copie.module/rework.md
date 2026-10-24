# Copie — Rework

> Source : `.src/Utils/Copie.module` · Message de commit (phase 4) : `reference/.src/Utils/Copie.module/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 17 |
| Lignes de commentaire | 1 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 5 |
| Complexité max (fonction) | 5 (`Dupli`) |
| Variables globales | 2 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 17 | 5 | 5 | 2 | 1 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] COPIE-001 — [documentation] Commentaires en français : rôle de `spiece`/`schemin`, lecteur
  `FacturefmA`, paramètre `Dtef` inutilisé · appelants : aucun · tests : aucun · sources : [Copie.module:Dupli](../../../../.src/Utils/Copie.module#L6-L22)
- [ ] COPIE-002 — [code mort] Supprimer `Try spiece = ""` et `Shell "cd " & User.Home` (sans effet) ·
  appelants : aucun · tests : T01, T02 · sources : [Copie.module:14-15](../../../../.src/Utils/Copie.module#L14-L15)
- [ ] COPIE-003 — [réduction de portée] `schemin` → `Private` (aucun lecteur externe) · appelants :
  aucun · tests : T01 · sources : [Copie.module:4](../../../../.src/Utils/Copie.module#L4)

### Anomalies : changement de comportement, validation utilisateur requise

- [ ] COPIE-A01 — [anomalie] `Dupli` ne copie pas le fichier lors de l'appel qui crée le répertoire
  (premier bon de réception sur un poste neuf) · appelant : `Edbr` · tests : T02 · sources : [Copie.module:8-12](../../../../.src/Utils/Copie.module#L8-L12)
- [ ] COPIE-A02 — [anomalie, à confirmer ; sans effet aujourd'hui : `FacturefmA.EnvoiFTP` n'est appelée
  nulle part, voir FacturefmA] `FacturefmA.EnvoiFTP` envoie `Copie.spiece`, c'est-à-dire
  la dernière copie faite par `Edbr` (bon de réception) ou `""`, et non la facture courante ·
  appelant : `FacturefmA` · tests : à définir avec l'utilisateur (FTP) · sources : [FacturefmA.class:554](../../../../.src/Gestion/Facturation/FacturefmA.class#L554), [FacturefmA.class:560](../../../../.src/Gestion/Facturation/FacturefmA.class#L560), [Edbr.module:226](../../../../.src/Gestion/Impressions/Edbr.module#L226)
- [ ] COPIE-A03 — [anomalie] Chemins non quotés dans `Shell "cp …"` : échec si le nom du fournisseur
  ou le chemin contient un espace · tests : T01 (variante avec espace) · sources : [Copie.module:16](../../../../.src/Utils/Copie.module#L16)
