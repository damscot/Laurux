# TriCpt — Rework

> Source : `.src/Affichages/TriCpt.class` · Message de commit (phase 4) : `reference/.src/Affichages/TriCpt.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 455 |
| Lignes de commentaire | 1 |
| Fonctions | 25 |
| Fonctions Public | 15 |
| Complexité cyclomatique totale | 89 |
| Complexité max (fonction) | 17 (`tricond`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 455 | 89 | 17 | 0 | 15 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] TRICPT-001 — [documentation] En-tête de classe : rôle, énumérations, conversion des lettres
  `B/G/C/F/T`, protocole `Bsel`/`Bval` (relais de `TriGen`, **pas** de remise à zéro à
  l'ouverture), dépendance au nom `Lettrage`, tables lues · appelants : aucun · tests : T01-T09 · sources : [TriCpt.class:_new](../../../../.src/Affichages/TriCpt.class#L23-L99), [TriCpt.class:ColTri_MajSel](../../../../.src/Affichages/TriCpt.class#L107-L124), [TriCpt.class:tricond](../../../../.src/Affichages/TriCpt.class#L359-L398)
- [ ] TRICPT-002 — [commonalisation] `AjouteColonne(sChamp, sEntete, …)` privée utilisée par
  `debut`, `Tricli`, `Trilivr`, `Tricont`, `Tricontfour`, `Trifou`, `Triclifou`, `slde` (requêtes
  et colonnes identiques) · appelants : aucun · tests : T01-T04, T08, T09 · sources : [TriCpt.class:debut](../../../../.src/Affichages/TriCpt.class#L132-L144), [TriCpt.class:Tricli](../../../../.src/Affichages/TriCpt.class#L157-L185), [TriCpt.class:Trilivr](../../../../.src/Affichages/TriCpt.class#L187-L221), [TriCpt.class:Tricont](../../../../.src/Affichages/TriCpt.class#L223-L261), [TriCpt.class:Tricontfour](../../../../.src/Affichages/TriCpt.class#L263-L297), [TriCpt.class:Trifou](../../../../.src/Affichages/TriCpt.class#L299-L319), [TriCpt.class:Triclifou](../../../../.src/Affichages/TriCpt.class#L321-L346)
- [ ] TRICPT-003 — [commonalisation] `RemplitCselc(cCol)` pour les remplissages de `Cselc` (`_new`,
  `cli_Click`, `Livr_Click`, `contact_Click`) et `Reconstruit(iType)` pour la séquence
  `$col`/`Tri*`/`slde`/`tricond` des handlers de mode (handlers conservés) · appelants : aucun ·
  tests : T02, T04 · sources : [TriCpt.class:cli_Click](../../../../.src/Affichages/TriCpt.class#L414-L444), [TriCpt.class:Livr_Click](../../../../.src/Affichages/TriCpt.class#L446-L459), [TriCpt.class:contact_Click](../../../../.src/Affichages/TriCpt.class#L461-L478), [TriCpt.class:gest_Click](../../../../.src/Affichages/TriCpt.class#L507-L518)
- [ ] TRICPT-004 — [code mort] Supprimer `$tr.Show(True)` (sans effet pour une liste dans un
  `Panel`) et les divisions de largeur de `Tritous` (écrasées par `TriGen`) ; vérifier par
  captures d'écran identiques · appelants : aucun · tests : T01, T04 · sources : [TriCpt.class:396](../../../../.src/Affichages/TriCpt.class#L396), [TriCpt.class:Tritous](../../../../.src/Affichages/TriCpt.class#L146-L154)
- [ ] TRICPT-005 — [séparation traitement/GUI] `tricond` : condition calculée par une fonction
  pure `ConditionComptes(iType, sAppelant, bInact, bAutoe, bDivers) As String` (texte identique,
  y compris les espaces) · appelants : aucun · tests : T01, T03, T06, T08, T10 · sources : [TriCpt.class:tricond](../../../../.src/Affichages/TriCpt.class#L359-L398)
- [ ] TRICPT-006 — [complexité] Lire la structure des requêtes `Tri*` avec ` LIMIT 0` (au lieu de
  tous les comptes) : `$res` ne sert qu'à `Fields` — SQL modifié, dump identique ; vérifier
  `Res.Fields` sur résultat vide (MySQL, SQLite, requête `UNION`) · appelants : aucun · tests :
  T01-T04, T09 · sources : [TriCpt.class:Tritous](../../../../.src/Affichages/TriCpt.class#L146-L154), [TriCpt.class:Triclifou](../../../../.src/Affichages/TriCpt.class#L321-L346)
- [ ] TRICPT-007 — [réarchitecture] Tables en dur → `Cbase.Table("TabComptes")`, `TabCli`,
  `TabFour`, `TabAdrC`, `TabContact`, `TabContactF` (clés vérifiées dans `Cbase.module`) ;
  texte SQL identique si le mapping renvoie les mêmes noms · appelants : aucun · tests : T01-T09 · sources : [TriCpt.class:148](../../../../.src/Affichages/TriCpt.class#L148), [TriCpt.class:166](../../../../.src/Affichages/TriCpt.class#L166), [TriCpt.class:196](../../../../.src/Affichages/TriCpt.class#L196), [TriCpt.class:232](../../../../.src/Affichages/TriCpt.class#L232), [TriCpt.class:267](../../../../.src/Affichages/TriCpt.class#L267), [TriCpt.class:303](../../../../.src/Affichages/TriCpt.class#L303), [TriCpt.class:325](../../../../.src/Affichages/TriCpt.class#L325)
- [ ] TRICPT-008 — [commonalisation] Relais `ColTri_MajSel`/`ColTri_ReDim` partagé avec
  `TriArticles` (voir TRIARTICLES-008) · appelants : aucun · tests : T01, T07 · sources : [TriCpt.class:ColTri_MajSel](../../../../.src/Affichages/TriCpt.class#L107-L124), [TriArticles.class:ColTri_MajSel](../../../../.src/Affichages/TriArticles.class#L160-L177)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] TRICPT-A01 — [anomalie] `_new` ne remet pas `Bsel`/`Bval` de l'appelant à `False`/`Null`
  (contrairement à `TriArticles` et `TriGen`) : après une première sélection, une annulation
  réapplique l'ancien compte chez les appelants qui ne le font pas eux-mêmes (MATERIEL-A09,
  FFOURNISSEUR-A07). Correction : `Object.SetProperty($obj, "Bsel", False)` / `"Bval", Null` dans
  `_new` (les 41 appelants sont concernés, comportement d'annulation modifié) · tests : T07 · sources : [TriCpt.class:48](../../../../.src/Affichages/TriCpt.class#L48), [Materiel.class:2528](../../../../.src/Gestion/Tables/Materiel.class#L2528)
- [ ] TRICPT-A02 — [anomalie] Mode `General` : condition `type_cc='B' OR type_cc='G'` sans
  parenthèses, combinée par `AND` avec `lettrable` et avec les filtres saisis : les comptes de
  bilan s'affichent sans tenir compte du filtre ni de `lettrable` · tests : T01 · sources : [TriCpt.class:388](../../../../.src/Affichages/TriCpt.class#L388)
- [ ] TRICPT-A03 — [anomalie] Les conditions `inact`/`autoe`/`divers` (colonnes `cli_*`) restent
  appliquées après passage en mode Bilan/Gestion/General/Trésorerie (requête sur
  `Fiches_Comptes` seule) : erreur SQL « colonne inconnue » ; chemin accessible depuis le mode
  Tous (`cli` → cocher → `gest`) · tests : T05 · sources : [TriCpt.class:369](../../../../.src/Affichages/TriCpt.class#L369), [TriCpt.class:379](../../../../.src/Affichages/TriCpt.class#L379)
- [ ] TRICPT-A04 — [anomalie] Filtre `lettrable` (appelant `Lettrage`) appliqué seulement aux
  modes Client/Bilan/Gestion/General/Trésorerie : en lettrage fournisseur, les comptes non
  lettrables sont proposés puis refusés par `Lettrage` (message « ce n'est pas un compte
  lettrable ») · tests : T06 · sources : [TriCpt.class:365](../../../../.src/Affichages/TriCpt.class#L365), [Lettrage.class:225](../../../../.src/Compta/Lettrages/Lettrage.class#L225)
- [ ] TRICPT-A05 — [anomalie] Le bouton radio `treso` n'est jamais rendu visible (et porte le
  libellé « Bilan ») : `treso_Click` est inatteignable ; le mode Trésorerie n'est accessible qu'à
  l'ouverture (`Pointage`). Le rendre visible en mode Tous change l'écran · tests : T04 · sources : [TriCpt.class:treso_Click](../../../../.src/Affichages/TriCpt.class#L546-L557), [TriCpt.class:55](../../../../.src/Affichages/TriCpt.class#L55)
