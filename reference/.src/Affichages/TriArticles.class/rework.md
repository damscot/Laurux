# TriArticles — Rework

> Source : `.src/Affichages/TriArticles.class` · Message de commit (phase 4) : `reference/.src/Affichages/TriArticles.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 363 |
| Lignes de commentaire | 11 |
| Fonctions | 22 |
| Fonctions Public | 22 |
| Complexité cyclomatique totale | 78 |
| Complexité max (fonction) | 16 (`Filter_Calc`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 363 | 78 | 16 | 0 | 22 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] TRIARTICLES-001 — [documentation] En-tête de classe : rôle, signature `_new` et lecture des
  appels à 9 arguments (5 obligatoires, `Parent`, `Dispo`, `Mat`, `ob`), valeurs admises de
  `TriArticle` et `Option`, protocole `Bsel`/`Bval` (remise à zéro chez `ob`, relais de
  `TriGen`) · appelants : aucun · tests : T01-T08 · sources : [TriArticles.class:_new](../../../../.src/Affichages/TriArticles.class#L24-L81), [TriArticles.class:ColTri_MajSel](../../../../.src/Affichages/TriArticles.class#L160-L177)
- [ ] TRIARTICLES-002 — [code mort] Supprimer `ChkInput`, `TriArticles_KeyPress`, `_KeyPress`
  (jamais levés ni appelés, signal `unused` vérifié) et les variables `Dbl`, `sel`, `Bart`,
  `NbEnreg`, `lg`, `chkfocus` ; `FourMan` est supprimée seulement si TRIARTICLES-A02 est refusée
  (sinon elle sert à la correction) · appelants : aucun · tests : T01-T07 · sources : [TriArticles.class:ChkInput](../../../../.src/Affichages/TriArticles.class#L185-L193), [TriArticles.class:TriArticles_KeyPress](../../../../.src/Affichages/TriArticles.class#L195-L201), [TriArticles.class:_KeyPress](../../../../.src/Affichages/TriArticles.class#L203-L209), [TriArticles.class:FourMan](../../../../.src/Affichages/TriArticles.class#L230-L241)
- [ ] TRIARTICLES-003 — [commonalisation] `Button1_Click` : `RemplitListe(sTable, sCode,
  sLibelle)` privée pour les trois listes fournisseurs/familles/centrales (SQL identique) ·
  appelants : aucun · tests : T03, T04 · sources : [TriArticles.class:Button1_Click](../../../../.src/Affichages/TriArticles.class#L243-L325)
- [ ] TRIARTICLES-004 — [complexité] Supprimer `tr.Update()` après `Filter_Calc()` dans
  `Colist_Click`, `Materiel_Click`, `Disponible_Click` (`ExtraSel` fait déjà `Update`) : une
  requête de moins par action (SQL modifié, dump identique) · appelants : aucun · tests : T03, T05,
  T06 · sources : [TriArticles.class:Colist_Click](../../../../.src/Affichages/TriArticles.class#L330-L339), [TriArticles.class:Materiel_Click](../../../../.src/Affichages/TriArticles.class#L451-L456), [TriArticles.class:Disponible_Click](../../../../.src/Affichages/TriArticles.class#L458-L463)
- [ ] TRIARTICLES-005 — [complexité] `Update_Req` : lire la structure par la requête de base
  suivie de ` LIMIT 0` au lieu de toute la table `Fiches_Art`/`Fiches_Mo` (`Res` n'est utilisé que
  pour `Fields` ; `TriGen` relance sa propre requête) — SQL modifié, dump identique ; vérifier
  que `Res.Fields` est disponible sur un résultat vide (MySQL et SQLite) et que la fenêtre ne
  dépend plus du `Return` sur table vide (à figer par un test sur table vide) · appelants :
  aucun · tests : T01, T07, T08 · sources : [TriArticles.class:Update_Req](../../../../.src/Affichages/TriArticles.class#L89-L158)
- [ ] TRIARTICLES-006 — [séparation traitement/GUI] `Filter_Calc` → fonction pure
  `FiltreArticles(sOrg, sCode, bStock, bDispo, bMat, sTri) As String` (texte identique), appelée
  avec les valeurs des contrôles · appelants : aucun · tests : T03-T06, T11 · sources : [TriArticles.class:Filter_Calc](../../../../.src/Affichages/TriArticles.class#L396-L448)
- [ ] TRIARTICLES-007 — [réduction de portée] `Update_Req`, `Filter_Calc` → `Private` (aucun
  appelant externe, vérifié ; couverts par les replays) ; `Bsel`/`Bval` restent `Public` (écrits
  par `TriGen`) · appelants : aucun · tests : T01-T08 · sources : [TriArticles.class:Update_Req](../../../../.src/Affichages/TriArticles.class#L89-L158), [TriArticles.class:Filter_Calc](../../../../.src/Affichages/TriArticles.class#L396-L448)
- [ ] TRIARTICLES-008 — [commonalisation] Relais `ColTri_MajSel` / `ColTri_ReDim` identiques à
  ceux de `TriCpt` : méthode commune (par ex. dans `TriGen` ou une classe `SelectionModale`),
  handlers conservés et réduits à un appel · appelants : aucun · tests : T01, T02 · sources : [TriArticles.class:ColTri_MajSel](../../../../.src/Affichages/TriArticles.class#L160-L177), [TriCpt.class:ColTri_MajSel](../../../../.src/Affichages/TriCpt.class#L107-L124)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] TRIARTICLES-A01 — [anomalie] `Filter_Calc` concatène le code fournisseur/famille/centrale
  entre guillemets doubles dans le filtre SQL : un code contenant `"` ou `\` provoque une erreur
  SQL ; paramétrer (`Utils.db.Subst`) change ce cas · tests : T09 · sources : [TriArticles.class:404](../../../../.src/Affichages/TriArticles.class#L404), [TriArticles.class:406](../../../../.src/Affichages/TriArticles.class#L406), [TriArticles.class:408](../../../../.src/Affichages/TriArticles.class#L408)
- [ ] TRIARTICLES-A02 — [anomalie] Ouverture avec un code initial (`Selection`, ex. `Achat`,
  `Changefour`) : `CB2` est rempli mais le nom (`Fnom`) reste vide, `FourMan` n'étant jamais
  appelée (et ne couvrant que les fournisseurs) · tests : T10 · sources : [TriArticles.class:37](../../../../.src/Affichages/TriArticles.class#L37), [TriArticles.class:FourMan](../../../../.src/Affichages/TriArticles.class#L230-L241)
- [ ] TRIARTICLES-A03 — [anomalie] `CB1_Click` reconstruit toute la liste : les filtres saisis
  dans les en-têtes et la page courante sont perdus à chaque changement de 3ᵉ colonne · tests :
  T07 · sources : [TriArticles.class:CB1_Click](../../../../.src/Affichages/TriArticles.class#L381-L385), [TriArticles.class:155](../../../../.src/Affichages/TriArticles.class#L155)
