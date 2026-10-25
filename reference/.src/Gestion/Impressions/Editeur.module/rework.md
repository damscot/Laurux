# Editeur — Rework

> Source : `.src/Gestion/Impressions/Editeur.module` · Message de commit (phase 4) : `reference/.src/Gestion/Impressions/Editeur.module/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 15 |
| Lignes de commentaire | 5 |
| Fonctions | 2 |
| Fonctions Public | 2 |
| Complexité cyclomatique totale | 5 |
| Complexité max (fonction) | 3 (`Prog_Email`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 15 | 5 | 3 | 0 | 2 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] EDITEUR-001 — [documentation] En-tête en français : rôle, clé `/CmdEditor<n>` (non écrite par
  Laurux, réglage manuel), repli `Desktop.Open`, signification de `FILE_TYPE_*` · appelants :
  aucun · tests : T01-T04 · sources : [Editeur.module:Prog_Editeur](../../../../../.src/Gestion/Impressions/Editeur.module#L10-L20)
- [ ] EDITEUR-002 — [code mort] Supprimer `Prog_Email` (aucun appelant, résultat jamais utilisé ;
  signalée `unused` par `deps.py`) ; débloque CHECKPROG-003 · appelants : aucun · tests : aucun ·
  sources : [Editeur.module:Prog_Email](../../../../../.src/Gestion/Impressions/Editeur.module#L22-L30), [CheckProg.module:Chk](../../../../../.src/Utils/CheckProg.module#L3-L18)
- [ ] EDITEUR-003 — [code mort] `Prog_Editeur` : supprimer la variable `$Exec` et le type de retour
  `As String` jamais renseigné ni lu (37 appels en instruction) · appelants : 27 fichiers
  (inchangés : l'appel reste identique) · tests : T01-T04 · sources : [Editeur.module:Prog_Editeur](../../../../../.src/Gestion/Impressions/Editeur.module#L10-L20)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] EDITEUR-A01 — [anomalie] `Shell <commande> & " " & Fic` sans quoting : un chemin contenant un
  espace ou un caractère spécial du shell est découpé (fichier non ouvert, ou commande injectée) ;
  correction par `Shell.Quote(Fic)` · tests : T02 · sources : [Editeur.module:15](../../../../../.src/Gestion/Impressions/Editeur.module#L15)
