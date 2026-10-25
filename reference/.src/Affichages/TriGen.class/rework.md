# TriGen — Rework

> Source : `.src/Affichages/TriGen.class` · Message de commit (phase 4) : `reference/.src/Affichages/TriGen.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 626 |
| Lignes de commentaire | 11 |
| Fonctions | 35 |
| Fonctions Public | 33 |
| Complexité cyclomatique totale | 163 |
| Complexité max (fonction) | 17 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 626 | 163 | 17 | 0 | 33 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

Chaque étape repasse aussi les tests du banc d'essai [`Tests/TriTest`](../../Tests/TriTest.class/rework.md)
(TRITEST-T01 à T03), qui doit être mis à jour dans le même commit si l'API de TriGen change.

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] TRIGEN-001 — [documentation] En-tête de classe : rôle (liste filtrable paginée créée par
  code), signature de `_new` (`Par` `Null` = fenêtre propre), protocole `Bsel`/`Bval` sur `ob`
  (valeur = colonne 0 ou `Collection` des colonnes `cle`), tableau des événements (`MajSel`,
  `Activate`, `Data`, `keyPress`, `Resize`, `ReDim`, `Raz`) et de leur annulation ; commentaires
  `'''` sur chaque méthode Public · appelants : aucun · tests : T01-T09 · sources : [TriGen.class:_new](../../../../.src/Affichages/TriGen.class#L50-L165), [TriGen.class:Close](../../../../.src/Affichages/TriGen.class#L221-L255)
- [ ] TRIGEN-002 — [code mort] Supprimer `ExtraHave` (jamais appelée, signal `unused`), les
  variables `Frmt`/`Frmt2` de `Coltri_Data`, `cle` de `Coltri_Click`/`Coltri_Activate`, `fts` et la
  branche `Me.Font` de `FontSize` · appelants : aucun · tests : T01, T03, T05 · sources : [TriGen.class:ExtraHave](../../../../.src/Affichages/TriGen.class#L266-L273), [TriGen.class:Coltri_Data](../../../../.src/Affichages/TriGen.class#L379-L403), [TriGen.class:FontSize](../../../../.src/Affichages/TriGen.class#L747-L764)
- [ ] TRIGEN-003 — [commonalisation] `DB_Incr`, `DB_Decr` et `GetAllFiltered` → fonction privée
  `Requete(bDesc, bLimite) As String` (texte SQL identique, espaces compris : rework « sans
  changement SQL », diff `Exec_SQL` bloquant) · appelants : aucun · tests : T01, T02, T05, T10 · sources : [TriGen.class:DB_Incr](../../../../.src/Affichages/TriGen.class#L654-L676), [TriGen.class:DB_Decr](../../../../.src/Affichages/TriGen.class#L678-L698), [TriGen.class:GetAllFiltered](../../../../.src/Affichages/TriGen.class#L591-L616)
- [ ] TRIGEN-004 — [commonalisation] `Coltri_Click` / `Coltri_Activate` → `ValeurLigne() As
  Variant` privée (corps identiques) ; handlers conservés · appelants : aucun · tests : T03, T04 · sources : [TriGen.class:Coltri_Click](../../../../.src/Affichages/TriGen.class#L405-L425), [TriGen.class:Coltri_Activate](../../../../.src/Affichages/TriGen.class#L497-L517)
- [ ] TRIGEN-005 — [séparation traitement/GUI] `GenFilter` : construction de `Sel`/`Having` dans
  une fonction pure `ConstruitFiltre(FilterRegex, Col_Def) As String[]` ; `Requete` (TRIGEN-003)
  sans accès aux contrôles · appelants : aucun · tests : T01, T10, T11 · sources : [TriGen.class:GenFilter](../../../../.src/Affichages/TriGen.class#L301-L327)
- [ ] TRIGEN-006 — [réduction de portée] `GenFilter`, `DB_Incr`, `DB_Decr`, `imprime` → `Private`
  (aucun appelant externe, vérifié par grep ; `commande1.imprime` est un homonyme ; couverts par
  les replays T01, T02, T08) · appelants : aucun · tests : T01, T02, T08 · sources : [TriGen.class:GenFilter](../../../../.src/Affichages/TriGen.class#L301-L327), [TriGen.class:DB_Incr](../../../../.src/Affichages/TriGen.class#L654-L676), [TriGen.class:DB_Decr](../../../../.src/Affichages/TriGen.class#L678-L698), [TriGen.class:imprime](../../../../.src/Affichages/TriGen.class#L700-L745)
- [ ] TRIGEN-007 — [complexité] `Coltri_KeyPress` (CC 16) : `Select Case Key.Code` et retour
  anticipé après chaque action, comportement identique (y compris l'ordre : `keyPress` levé
  d'abord) ; `NoUp_Write` : `Object.Lock(Coltri)` hors de la boucle · appelants : aucun · tests : T02, T03 · sources : [TriGen.class:Coltri_KeyPress](../../../../.src/Affichages/TriGen.class#L428-L468), [TriGen.class:NoUp_Write](../../../../.src/Affichages/TriGen.class#L773-L792)
- [ ] TRIGEN-008 — [complexité] `_new` (CC 17, 103 LOC) : extraire `CreeFenetre()`,
  `CreeFiltres()` et `CreeCompteur()` privées, même ordre de création des contrôles · appelants :
  aucun · tests : T01, T09 · sources : [TriGen.class:_new](../../../../.src/Affichages/TriGen.class#L50-L165)
- [ ] TRIGEN-009 — [commonalisation] Pagination (`NbEnreg`/`lg`, molette, PageUp/PageDown,
  `Descendre_*`/`Remonter_*`) déléguée à la classe d'aide `PaginationListe` partagée avec `Tricp`,
  `TriMat`, `TriEqu`, `TriFac`, `TriBl`, `Tricartes`, `TriclientsD` (voir TRICARTES-005) ; `TriGen`
  sert de comportement de référence ; handlers conservés, SQL identique · appelants : aucun ·
  tests : T02 · sources : [TriGen.class:Coltri_MouseWheel](../../../../.src/Affichages/TriGen.class#L470-L480), [TriGen.class:Descendre_Click](../../../../.src/Affichages/TriGen.class#L519-L529), [TriGen.class:Remonter_Click](../../../../.src/Affichages/TriGen.class#L531-L539), [Tricartes.class:Descendre_Click](../../../../.src/Caisse/Affichages/Tricartes.class#L127-L137)
- [ ] TRIGEN-010 — [commonalisation] Sélection multiple (mémorisation des valeurs dans `MajSel` +
  `Stop Event`, coloration dans `Data`, vidage dans `Raz`, « tout sélectionner » par
  `GetAllFiltered`) : mode optionnel de `TriGen` ou classe `TriSelection` utilisée par `GedR`,
  `TriFacture` et `Pointage` (handlers des appelants conservés, réduits à un appel ; voir
  POINTAGE-005) · appelants : `GedR`, `TriFacture`, `Pointage` · tests : T05 · sources : [TriGen.class:Close](../../../../.src/Affichages/TriGen.class#L221-L255), [Pointage.class:TriGen_MajSel](../../../../.src/Compta/Pointage.class#L139-L162), [GedR.class:TriGen_MajSel](../../../../.src/Utils/GedR.class#L273-L295), [TriFacture.class:TriGen_MajSel](../../../../.src/Affichages/TriFacture.class#L234-L257)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] TRIGEN-A01 — [anomalie] Requête sans résultat : `DB_Incr` ne remet pas
  `Coltri.Rows.Count` à 0 quand `Res.Count = 0`, `DB_Decr` ni dans ce cas ni quand le `Result` est
  indisponible : les lignes de la page précédente restent affichées (vides) et cliquables · tests :
  T06 · sources : [TriGen.class:668](../../../../.src/Affichages/TriGen.class#L668), [TriGen.class:692](../../../../.src/Affichages/TriGen.class#L692)
- [ ] TRIGEN-A02 — [anomalie] Filtres concaténés dans le SQL (`champ like "%texte%"`) : seuls les
  `"` sont retirés ; `%` et `_` agissent comme jokers, `\` provoque une erreur SQL sous MySQL ;
  passer par `Utils.db.Subst`/`&N` change ces cas · tests : T07 · sources : [TriGen.class:312](../../../../.src/Affichages/TriGen.class#L312), [TriGen.class:314](../../../../.src/Affichages/TriGen.class#L314)
- [ ] TRIGEN-A03 — [anomalie] `imprime` (« imprime la sélection ») n'imprime que la **page
  affichée** (`Res` porte le `LIMIT`) et exécute le corps de `Repeat` sur un résultat vide (erreur
  probable) ; imprimer toute la sélection (via `GetAllFiltered`) change le résultat · tests : T08 · sources : [TriGen.class:726](../../../../.src/Affichages/TriGen.class#L726), [TriGen.class:imprime](../../../../.src/Affichages/TriGen.class#L700-L745)
- [ ] TRIGEN-A04 — [anomalie, à confirmer] Écrire `Count.Value` dans `Update` lève probablement
  `Count_Change`, qui relance `Update` : une requête en double à chaque changement de page ; à
  mesurer en phase 2 (trace `Exec_SQL`) avant correction · tests : T02 · sources : [TriGen.class:625](../../../../.src/Affichages/TriGen.class#L625), [TriGen.class:Count_Change](../../../../.src/Affichages/TriGen.class#L580-L589)
- [ ] TRIGEN-A05 — [anomalie] `Close` en mode `Panel` détruit boutons, filtres et grille mais pas
  le compteur `Count`, qui reste visible dans le panneau de l'appelant (cas `TarTypeCli`,
  `Articles` qui appellent `Close` explicitement) · tests : T03 · sources : [TriGen.class:240](../../../../.src/Affichages/TriGen.class#L240), [TriGen.class:248](../../../../.src/Affichages/TriGen.class#L248)
