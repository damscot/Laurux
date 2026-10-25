# Majcasier — Rework

> Source : `.src/Gestion/Lcr/Portables/Majcasier.class` · Message de commit (phase 4) : `reference/.src/Gestion/Lcr/Portables/Majcasier.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 88 |
| Lignes de commentaire | 4 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 23 |
| Complexité max (fonction) | 17 (`Import_Portable`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 88 | 23 | 17 | 0 | 4 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] MAJCASIER-001 — [documentation] En-tête en français (mise à jour du casier depuis le terminal
  portable, format de ligne attendu, rapport) et chaînes affichées sous la forme `("…")` ·
  appelants : aucun · tests : aucun · sources : [Majcasier.class:Import_Portable](../../../../../../.src/Gestion/Lcr/Portables/Majcasier.class#L46-L102),
  [Majcasier.class:Button1_Click](../../../../../../.src/Gestion/Lcr/Portables/Majcasier.class#L30-L41)
- [ ] MAJCASIER-002 — [code mort] Supprimer `CoulZns`, `CoulZnaf`, `CoulFc` et leur calcul, le second
  `Me.Center` ; passer `hfil`, `Lig`, `iPos` en variables locales · appelants : aucun · tests :
  T01-T05 · sources : [Majcasier.class:form_Open](../../../../../../.src/Gestion/Lcr/Portables/Majcasier.class#L11-L28)
- [ ] MAJCASIER-003 — [réduction de portée] `Import_Portable` → `Private` · appelants : aucun ·
  tests : T01-T05 · sources : [Majcasier.class:Import_Portable](../../../../../../.src/Gestion/Lcr/Portables/Majcasier.class#L46-L102)
- [ ] MAJCASIER-004 — [séparation traitement/GUI] Extraire `MajCasiers(casier, lignes) As String[]`
  (SQL et rejets) de `Import_Portable` ; lecture du fichier par `Portable.LireInventaire` (PORTABLE-004)
  · appelants : aucun · tests : T01, T02, T05 · sources : [Majcasier.class:Import_Portable](../../../../../../.src/Gestion/Lcr/Portables/Majcasier.class#L46-L102),
  [Portable.module:Import](../../../../../../.src/Gestion/Lcr/Portables/Portable.module#L8-L79)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] MAJCASIER-A01 — [anomalie] `Code` non réinitialisé : une ligne sans code-barres remet à jour
  l'article précédent ; la première ligne vide déclenche une requête avec un code vide · tests : T02 ·
  sources : [Majcasier.class:76](../../../../../../.src/Gestion/Lcr/Portables/Majcasier.class#L76), [Majcasier.class:84](../../../../../../.src/Gestion/Lcr/Portables/Majcasier.class#L84)
- [ ] MAJCASIER-A02 — [anomalie] Rapport inexploitable : `Codeb` n'est jamais affecté, le code-barres
  rejeté n'apparaît pas dans `~/tmp/Casier.txt` (seulement le code résolu, vide) ; aucun bilan du
  nombre d'articles mis à jour ; erreurs d'`UPDATE` ignorées · tests : T02 ·
  sources : [Majcasier.class:89](../../../../../../.src/Gestion/Lcr/Portables/Majcasier.class#L89), [Majcasier.class:86](../../../../../../.src/Gestion/Lcr/Portables/Majcasier.class#L86)
- [ ] MAJCASIER-A03 — [anomalie] Appel `Portable.Import("Casier")` sans traitement utile, qui vide
  `~/tmp/ImpT.txt` (rapport des imports d'étiquettes) : suppression à valider (effet de bord sur un
  fichier temporaire) · tests : T04 · sources : [Majcasier.class:59](../../../../../../.src/Gestion/Lcr/Portables/Majcasier.class#L59)
