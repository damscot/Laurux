# Doc — Rework

> Source : `.src/Communs/Doc.module` · Message de commit (phase 4) : `reference/.src/Communs/Doc.module/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 8 |
| Lignes de commentaire | 2 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 2 |
| Complexité max (fonction) | 2 (`Open`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 8 | 2 | 2 | 0 | 1 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] DOC-001 — [documentation] En-tête : rôle, convention `Application.Path/Ecrans/<Rubrique>.html`,
  repli sur le site, dépendance à `xdg-open` · appelants : aucun · tests : aucun · sources : [Doc.module:Open](../../../../.src/Communs/Doc.module#L6-L15)
- [ ] DOC-002 — [complexité] `wwwpath` en `Private Const`, chemin calculé une seule fois ·
  appelants : aucun · tests : T01-T03 · sources : [Doc.module:3](../../../../.src/Communs/Doc.module#L3), [Doc.module:Open](../../../../.src/Communs/Doc.module#L6-L15)
- [ ] DOC-003 — [séparation traitement/GUI] Fonction pure `CheminAide(Rubrique, Optional Module)
  As String` ; `Open` se limite à l'`Exec` · appelants : aucun (signature d'`Open` inchangée) ·
  tests : T01-T05 · sources : [Doc.module:Open](../../../../.src/Communs/Doc.module#L6-L15)
- [ ] DOC-004 — [commonalisation] (transverse) `Doc.OuvreUrl(sUrl)` pour les `Exec ["xdg-open", …]`
  directs de `Fmenu.Menu64_Click` (puis `LGed`, `FClientcarte` après revue de leurs arguments) ·
  appelants : `Fmenu` · tests : T04, FMENU-T07 · sources : [Doc.module:Open](../../../../.src/Communs/Doc.module#L6-L15), [Fmenu.class:Menu64_Click](../../../../.src/Communs/Fmenu.class#L1695-L1699)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] DOC-A01 — [anomalie] Aucune page locale n'est livrée (pas de dossier `Ecrans` dans le dépôt) :
  les 111 rubriques ouvrent toutes la page générale du site ; l'aide contextuelle est de fait
  inexistante (fournir les pages, ou construire une URL par rubrique) · tests : T01 · sources : [Doc.module:8-13](../../../../.src/Communs/Doc.module#L8-L13)
- [ ] DOC-A02 — [anomalie] `Exec` sans gestion d'erreur : poste sans `xdg-open` → erreur
  d'exécution dans l'écran appelant (à confirmer) · tests : manuel · sources : [Doc.module:9](../../../../.src/Communs/Doc.module#L9), [Doc.module:12](../../../../.src/Communs/Doc.module#L12)
