# Tconsigne — Rework

> Source : `.src/Gestion/option/Tconsigne.class` · Message de commit (phase 4) : `reference/.src/Gestion/option/Tconsigne.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 153 |
| Lignes de commentaire | 2 |
| Fonctions | 20 |
| Fonctions Public | 17 |
| Complexité cyclomatique totale | 48 |
| Complexité max (fonction) | 7 (`bar1_valide`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 153 | 48 | 7 | 0 | 17 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] TCONSIGNE-001 — [documentation] En-tête : rôle (référentiel des consignes P/C/B), cycle de
  transaction de la barre `barselection`, sens réel du second paramètre de `bar1_valide`/`bar1_annule`
  (modification), suppression non implémentée · appelants : aucun · tests : T01-T05 · sources : [Tconsigne.class:form_Open](../../../../../.src/Gestion/option/Tconsigne.class#L7-L23), [Tconsigne.class:bar1_valide](../../../../../.src/Gestion/option/Tconsigne.class#L101-L122)
- [ ] TCONSIGNE-002 — [complexité] Fonction privée `Relire()` pour les trois
  `SELECT * FROM Fiches_consigne ORDER BY code` (SQL identique) · appelants : aucun · tests :
  T01-T04 · sources : [Tconsigne.class:form_Open](../../../../../.src/Gestion/option/Tconsigne.class#L7-L23), [Tconsigne.class:bar1_annule](../../../../../.src/Gestion/option/Tconsigne.class#L37-L46), [Tconsigne.class:bar1_valide](../../../../../.src/Gestion/option/Tconsigne.class#L101-L122)
- [ ] TCONSIGNE-003 — [séparation traitement/GUI] Fonction privée `CodeExiste(code) As Boolean`
  utilisée par `bar1_valide` et `Textcode_LostFocus` (même requête) · appelants : aucun · tests :
  T02, T03 · sources : [Tconsigne.class:bar1_valide](../../../../../.src/Gestion/option/Tconsigne.class#L101-L122), [Tconsigne.class:Textcode_LostFocus](../../../../../.src/Gestion/option/Tconsigne.class#L164-L183)
- [ ] TCONSIGNE-004 — [commonalisation] Cycle de barre commun avec `Mreglement`, `Tregie`,
  `Ttourne`, `Tregion`, `Tchauffeur` (voir MREGLEMENT-006) · appelants : aucun · tests : T01-T06 ·
  sources : [Tconsigne.class:bar1_creer](../../../../../.src/Gestion/option/Tconsigne.class#L48-L57), [Tconsigne.class:bar1_modif](../../../../../.src/Gestion/option/Tconsigne.class#L68-L73), [Tconsigne.class:bar1_annule](../../../../../.src/Gestion/option/Tconsigne.class#L37-L46)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] TCONSIGNE-A01 — [anomalie] `form_Close` appelle `bar1_valide` sans ses deux arguments
  obligatoires : « Not enough arguments » (vérifié `gbs3`) quand l'utilisateur répond « Oui » à
  l'enregistrement avant fermeture · tests : T06 · sources : [Tconsigne.class:158](../../../../../.src/Gestion/option/Tconsigne.class#L158)
- [ ] TCONSIGNE-A02 — [anomalie] Transaction ouverte pendant toute la saisie ; fermeture avec
  « Non » : ni `Commit` ni `Rollback` sur la connexion partagée (même défaut que MREGLEMENT-A01) ·
  tests : T06 · sources : [Tconsigne.class:51](../../../../../.src/Gestion/option/Tconsigne.class#L51), [Tconsigne.class:70](../../../../../.src/Gestion/option/Tconsigne.class#L70), [Tconsigne.class:form_Close](../../../../../.src/Gestion/option/Tconsigne.class#L155-L162)
- [ ] TCONSIGNE-A03 — [anomalie] Bouton Supprimer affiché (`"111111111"`) mais `bar1_suprimer` vide :
  aucune suppression possible depuis l'écran · tests : T01 · sources : [Tconsigne.class:12](../../../../../.src/Gestion/option/Tconsigne.class#L12), [Tconsigne.class:bar1_suprimer](../../../../../.src/Gestion/option/Tconsigne.class#L124-L128)
- [ ] TCONSIGNE-A04 — [anomalie] `$ind` n'est pas mis à jour par `bar1_modif` ni après une
  création : la fiche affichée après validation n'est pas celle qui vient d'être saisie ;
  `rech_trouver` boucle sans test de fin ; `bar1_suivant` sans test `Available` · tests : T04, T05 ·
  sources : [Tconsigne.class:bar1_modif](../../../../../.src/Gestion/option/Tconsigne.class#L68-L73), [Tconsigne.class:118](../../../../../.src/Gestion/option/Tconsigne.class#L118), [Tconsigne.class:rech_trouver](../../../../../.src/Gestion/option/Tconsigne.class#L145-L153), [Tconsigne.class:bar1_suivant](../../../../../.src/Gestion/option/Tconsigne.class#L93-L99)
