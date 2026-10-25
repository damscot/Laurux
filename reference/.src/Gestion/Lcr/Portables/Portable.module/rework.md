# Portable — Rework

> Source : `.src/Gestion/Lcr/Portables/Portable.module` · Message de commit (phase 4) : `reference/.src/Gestion/Lcr/Portables/Portable.module/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 69 |
| Lignes de commentaire | 5 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 18 |
| Complexité max (fonction) | 18 (`Import`) |
| Variables globales | 1 |
| Variables Public | 1 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 69 | 18 | 18 | 1 | 1 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] PORTABLE-001 — [documentation] En-tête en français : terminal portable d'inventaire, format de
  `~/Portable/inventaire.txt` selon l'appelant, rapport `~/tmp/ImpT.txt`, sens de `cpt2` ; signaler
  que le module n'a pas de lien avec les LCR · appelants : aucun · tests : aucun ·
  sources : [Portable.module:Import](../../../../../../.src/Gestion/Lcr/Portables/Portable.module#L8-L79)
- [ ] PORTABLE-002 — [complexité] Supprimer `Shell "cd …"`, `With utils`, le double
  `Val(Utils.cpoint(…))` ; fermer explicitement les fichiers (`Try Close`) ; découpage par `Split`
  à résultat identique (CC 18 → ≤ 10 visé) · appelants : aucun · tests : T01-T05 ·
  sources : [Portable.module:Import](../../../../../../.src/Gestion/Lcr/Portables/Portable.module#L8-L79)
- [ ] PORTABLE-003 — [séparation traitement/GUI] `Import` renvoie un indicateur d'erreur ; le
  `Message.Error` (même texte) passe dans une fonction d'affichage appelée au même endroit ·
  appelants : aucun (signature inchangée) · tests : T04 · sources : [Portable.module:75](../../../../../../.src/Gestion/Lcr/Portables/Portable.module#L75)
- [ ] PORTABLE-004 — [commonalisation] `Portable.LireInventaire() As String[][]` et
  `Portable.ResoudreCode(codebarre)` partagés avec `Majcasier`, `Achat`, `SaisieInv`, `SaisieInvT`
  et (minimalement) `Facture` ; comportement identique · appelants : ces écrans · tests : T01, T02 et
  replays des appelants · sources : [Portable.module:Import](../../../../../../.src/Gestion/Lcr/Portables/Portable.module#L8-L79), [Majcasier.class:Import_Portable](../../../../../../.src/Gestion/Lcr/Portables/Majcasier.class#L46-L102),
  [Achat.class:711](../../../../../../.src/Gestion/Entrées/Achat.class#L711), [SaisieInv.class:472](../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/SaisieInv.class#L472)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] PORTABLE-A01 — [anomalie] `cpt2` n'est jamais remis à 0 : après un premier rejet, chaque import
  ouvre le rapport dans l'éditeur même sans rejet · appelants : `Etigond`, `Etiqart`, `Etiqcasier` ·
  tests : T03 · sources : [Portable.module:3](../../../../../../.src/Gestion/Lcr/Portables/Portable.module#L3), [Portable.module:Import](../../../../../../.src/Gestion/Lcr/Portables/Portable.module#L8-L79)
- [ ] PORTABLE-A02 — [anomalie] `Code` non réinitialisé entre les lignes : une ligne sans code-barres
  (ou après un code inconnu suivi d'une ligne vide) réinsère l'article de la ligne précédente avec
  le nouveau nombre, malgré le message « rejetée » · tests : T02 · sources : [Portable.module:45](../../../../../../.src/Gestion/Lcr/Portables/Portable.module#L45),
  [Portable.module:60](../../../../../../.src/Gestion/Lcr/Portables/Portable.module#L60)
- [ ] PORTABLE-A03 — [anomalie] `inventaire.txt` absent : sortie silencieuse (aucun message), alors
  que les écrans appelants annoncent l'import ; erreurs d'`INSERT` ignorées (`Try`) sans rapport ·
  tests : T04 · sources : [Portable.module:26](../../../../../../.src/Gestion/Lcr/Portables/Portable.module#L26), [Portable.module:63](../../../../../../.src/Gestion/Lcr/Portables/Portable.module#L63)
