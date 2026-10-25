# Bordereaux — Rework

> Source : `.src/Caisse/Bordereaux.class` · Message de commit (phase 4) : `reference/.src/Caisse/Bordereaux.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 146 |
| Lignes de commentaire | 7 |
| Fonctions | 6 |
| Fonctions Public | 6 |
| Complexité cyclomatique totale | 24 |
| Complexité max (fonction) | 14 (`Imp_Bordereaux`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 146 | 24 | 14 | 0 | 6 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] BORDEREAUX-001 — [documentation] En-tête en français : rôle (bordereau des chèques et cartes
  non moulinés), sources, fichier produit, différence avec `BordereauxC` · appelants : aucun ·
  tests : aucun · sources : [Bordereaux.class:Imp_Bordereaux](../../../../.src/Caisse/Bordereaux.class#L27-L131)
- [ ] BORDEREAUX-002 — [code mort] Supprimer `Shell "cd " & User.Home` (sous-shell sans effet), les
  remises à zéro de `nbreg`/`Montant` après le total final et les `Kill` commentés · appelants :
  aucun · tests : T01-T05 · sources : [Bordereaux.class:40](../../../../.src/Caisse/Bordereaux.class#L40), [Bordereaux.class:122-123](../../../../.src/Caisse/Bordereaux.class#L122-L123), [Bordereaux.class:Button1_Click](../../../../.src/Caisse/Bordereaux.class#L12-L19)
- [ ] BORDEREAUX-003 — [commonalisation] `Fiches_LigTicketz` → `Cbase.Table("TabLigTck")` (même
  valeur) · appelants : aucun · tests : T01-T03 · sources : [Bordereaux.class:41](../../../../.src/Caisse/Bordereaux.class#L41)
- [ ] BORDEREAUX-004 — [séparation traitement/GUI] `Imp_Bordereaux(sTypes, bNumeros)` : les
  contrôles `Tous`/`Cheques`/`Cartes`/`Imptk` sont lus par `Button2_Click` ; requête isolée dans
  `Lignes_Remise(types) As Result` (même SQL) · appelants : aucun · tests : T01-T06 · sources : [Bordereaux.class:Imp_Bordereaux](../../../../.src/Caisse/Bordereaux.class#L27-L131), [Bordereaux.class:Button2_Click](../../../../.src/Caisse/Bordereaux.class#L21-L25)
- [ ] BORDEREAUX-005 — [complexité] Helpers privés `Titre_Type(type)` (titre et largeur de préfixe)
  et `Imprime_Total(libelle, nb, montant, espaces)` pour les blocs dupliqués ; largeurs 90/50
  conservées (CC 14 → ≤ 8 visé, PDF identique) · appelants : aucun · tests : T01-T05 · sources : [Bordereaux.class:64-99](../../../../.src/Caisse/Bordereaux.class#L64-L99), [Bordereaux.class:115-121](../../../../.src/Caisse/Bordereaux.class#L115-L121)
- [ ] BORDEREAUX-006 — [commonalisation] En-tête société via le helper commun
  `Creleve.EnteteSociete` (LIGCLI-004), à sortie identique (SIRET local + base, logo) ·
  appelants : aucun · tests : T07 · sources : [Bordereaux.class:Imp_Entete](../../../../.src/Caisse/Bordereaux.class#L133-L167)
- [ ] BORDEREAUX-007 — [réduction de portée] `Imp_Bordereaux`, `Imp_Entete` → `Private` (seul
  appelant externe : `Fmenu` par `ShowModal`) · appelants : aucun · tests : T01-T07 · sources : [Bordereaux.class:Imp_Bordereaux](../../../../.src/Caisse/Bordereaux.class#L27-L131), [Bordereaux.class:Imp_Entete](../../../../.src/Caisse/Bordereaux.class#L133-L167)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] BORDEREAUX-A01 — [anomalie, à confirmer] Aucun filtre sur la caisse, la date, le statut ni
  la suppression du ticket : les règlements des tickets supprimés ou en erreur et de toutes les
  journées non moulinées figurent dans le bordereau « du <date du jour> » ; tri par numéro de
  ligne seul (tickets mélangés) · tests : T01, T06 · sources : [Bordereaux.class:44](../../../../.src/Caisse/Bordereaux.class#L44), [Bordereaux.class:48](../../../../.src/Caisse/Bordereaux.class#L48), [Bordereaux.class:52](../../../../.src/Caisse/Bordereaux.class#L52)
- [ ] BORDEREAUX-A02 — [anomalie] Mise en page : premier en-tête à `PosY = 0` (6 ensuite), totaux
  intermédiaire et final alignés différemment (`Space$(90)` / `Space$(50)`), société lue sans test
  `Available` (erreur si la société courante est absente de `Fiches_Societes`) · tests : T01, T05,
  T07 · sources : [Bordereaux.class:42](../../../../.src/Caisse/Bordereaux.class#L42), [Bordereaux.class:78](../../../../.src/Caisse/Bordereaux.class#L78), [Bordereaux.class:115](../../../../.src/Caisse/Bordereaux.class#L115), [Bordereaux.class:144-145](../../../../.src/Caisse/Bordereaux.class#L144-L145)
