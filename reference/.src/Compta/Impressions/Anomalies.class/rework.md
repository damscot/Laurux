# Anomalies — Rework

> Source : `.src/Compta/Impressions/Anomalies.class` · Message de commit (phase 4) : `reference/.src/Compta/Impressions/Anomalies.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 109 |
| Lignes de commentaire | 1 |
| Fonctions | 6 |
| Fonctions Public | 6 |
| Complexité cyclomatique totale | 20 |
| Complexité max (fonction) | 9 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 109 | 20 | 9 | 0 | 6 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] ANOMALIES-001 — [documentation] En-tête en français : principe du contrôle d'inaltérabilité,
  tables par exercice, colonnes du rapport · appelants : aucun · tests : T02, T03 · sources : [Anomalies.class:Button2_Click](../../../../../.src/Compta/Impressions/Anomalies.class#L17-L82)
- [ ] ANOMALIES-002 — [code mort] Supprimer la requête inutilisée `SELECT * FROM Fiches_Mvt`
  (ligne 28 ; SQL modifié, dump identique), `dte1`, `dte2`, `Ste`, `dte`, `$cle`, `$cle2` et le
  `Shell "cd"` · appelants : aucun · tests : T02-T04 · sources : [Anomalies.class:28](../../../../../.src/Compta/Impressions/Anomalies.class#L28), [Anomalies.class:Button2_Click](../../../../../.src/Compta/Impressions/Anomalies.class#L17-L82)
- [ ] ANOMALIES-003 — [commonalisation] `Exercice_End`/`Exercice_Begin` remplacées par
  `LDate.Exercice_Cloture(n)` et un début d'exercice dérivé (même affichage `dd.mm.yyyy`), puis
  supprimées · appelants : aucun · tests : T01, T05 · sources : [Anomalies.class:Exercice_End](../../../../../.src/Compta/Impressions/Anomalies.class#L99-L125), [Anomalies.class:Exercice_Begin](../../../../../.src/Compta/Impressions/Anomalies.class#L91-L95), [LDate.class:Exercice_Cloture](../../../../../.src/Utils/LDate.class#L648-L672)
- [ ] ANOMALIES-004 — [complexité] Helper privé `Entete(pdf)` pour l'en-tête répété au début et à
  chaque saut de page · appelants : aucun · tests : T02 · sources : [Anomalies.class:Button2_Click](../../../../../.src/Compta/Impressions/Anomalies.class#L17-L82)
- [ ] ANOMALIES-005 — [séparation traitement/GUI] Sélection des lignes de l'exercice dans une
  fonction sans accès aux contrôles (`LignesExercice(sTab, sDu, sAu) As Result`) ; le handler
  garde `ProgBar`, vérification et impression · appelants : aucun · tests : T02-T04 · sources : [Anomalies.class:Button2_Click](../../../../../.src/Compta/Impressions/Anomalies.class#L17-L82)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] ANOMALIES-A01 — [anomalie] Clé recalculée affichée sur `"Fiches_Mvt"` en dur au lieu de
  `Tab` : rapport faux pour les exercices N-1…N-5 · tests : T03 · sources : [Anomalies.class:54](../../../../../.src/Compta/Impressions/Anomalies.class#L54)
- [ ] ANOMALIES-A02 — [anomalie] Message d'erreur trompeur (« pas de somme de control ») pour toute
  erreur SQL (table d'exercice absente, date invalide) · tests : T04 · sources : [Anomalies.class:40](../../../../../.src/Compta/Impressions/Anomalies.class#L40)
- [ ] ANOMALIES-A03 — [anomalie] Aucun message quand la plage ne contient aucune écriture ·
  tests : T04 · sources : [Anomalies.class:45](../../../../../.src/Compta/Impressions/Anomalies.class#L45)
