# Fsystem — Rework

> Source : `.src/Communs/Fsystem.class` · Message de commit (phase 4) : `reference/.src/Communs/Fsystem.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 29 |
| Lignes de commentaire | 2 |
| Fonctions | 2 |
| Fonctions Public | 2 |
| Complexité cyclomatique totale | 7 |
| Complexité max (fonction) | 6 (`Form_Open`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 29 | 7 | 6 | 0 | 2 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] FSYSTEM-001 — [documentation] En-tête : rôle, origine de `report.sh`, sections produites ;
  suppression du commentaire `chmod` obsolète · appelants : aucun · tests : aucun · sources : [Fsystem.class:Form_Open](../../../../.src/Communs/Fsystem.class#L9-L41), [Fsystem.class:22](../../../../.src/Communs/Fsystem.class#L22)
- [ ] FSYSTEM-002 — [séparation traitement/GUI] Fonction `RapportSysteme() As String` (même texte),
  `Form_Open` réduit à l'affichage · appelants : aucun · tests : T01, T02 · sources : [Fsystem.class:Form_Open](../../../../.src/Communs/Fsystem.class#L9-L41)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] FSYSTEM-A01 — [anomalie] Recherche des bibliothèques limitée à `/usr/lib/` et à Qt4/GTK2
  (jamais trouvées sur les distributions actuelles) ; titre `[Version Mysql]` affiché aussi sous
  SQLite · tests : T01 · sources : [Fsystem.class:25-28](../../../../.src/Communs/Fsystem.class#L25-L28), [Fsystem.class:34](../../../../.src/Communs/Fsystem.class#L34)
- [ ] FSYSTEM-A02 — [anomalie] `Copy`/`Exec` sans gestion d'erreur : `report.sh` absent ou `/bin/sh`
  en échec → erreur non rattrapée à l'ouverture de la fenêtre · tests : manuel · sources : [Fsystem.class:21-23](../../../../.src/Communs/Fsystem.class#L21-L23)
