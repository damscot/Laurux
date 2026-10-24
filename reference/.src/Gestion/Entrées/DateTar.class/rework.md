# DateTar — Rework

> Source : `.src/Gestion/Entrées/DateTar.class` · Message de commit (phase 4) : `reference/.src/Gestion/Entrées/DateTar.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 196 |
| Lignes de commentaire | 2 |
| Fonctions | 15 |
| Fonctions Public | 12 |
| Complexité cyclomatique totale | 55 |
| Complexité max (fonction) | 13 (`EnrTouTar`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 196 | 55 | 13 | 0 | 12 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] DATETAR-001 — [documentation] En-tête en français : double rôle (écran de planification,
  application des tarifs échus au démarrage), identification des articles par le texte des
  listes, valeurs de `temp_type`, représentation du coefficient (`Remise` négative) ·
  appelants : aucun · tests : aucun · sources : [DateTar.class:_new](../../../../../.src/Gestion/Entrées/DateTar.class#L5-L12), [DateTar.class:EnrTouTar](../../../../../.src/Gestion/Entrées/DateTar.class#L172-L254)
- [ ] DATETAR-002 — [commonalisation] Helper privé `TexteLigne() As String` pour le texte d'une
  ligne de `$restar` (répété dans `affiche`, `Sup_Click`, `Enr_Click`, `Rech_Click`), sans
  toucher aux bornes ni au point de départ des recherches (anomalies A01/A02) · appelants :
  aucun · tests : T01-T04, T08 · sources : [DateTar.class:affiche](../../../../../.src/Gestion/Entrées/DateTar.class#L14-L28), [DateTar.class:Sup_Click](../../../../../.src/Gestion/Entrées/DateTar.class#L63-L89), [DateTar.class:Enr_Click](../../../../../.src/Gestion/Entrées/DateTar.class#L97-L119), [DateTar.class:Rech_Click](../../../../../.src/Gestion/Entrées/DateTar.class#L146-L163)
- [ ] DATETAR-003 — [réarchitecture] `EnrTouTar` en `Static Public` : l'appel `DateTar.EnrTouTar`
  de `Fmenu` reste identique mais n'instancie plus le formulaire caché (une requête
  `fournisseur_LostFocus` de moins au démarrage : SQL modifié, dump identique) · appelants :
  `Fmenu` (inchangé) · tests : T05-T07 · sources : [DateTar.class:EnrTouTar](../../../../../.src/Gestion/Entrées/DateTar.class#L172-L254), [Fmenu.class:225](../../../../../.src/Communs/Fmenu.class#L225)
- [ ] DATETAR-004 — [réarchitecture] `Cbase.Table(…)` pour `TabArt`, `TabTvav`, `TabTarcli`,
  `TabTcli` ; SQL identique · appelants : aucun · tests : T01, T05-T07 · sources : [DateTar.class:fournisseur_LostFocus](../../../../../.src/Gestion/Entrées/DateTar.class#L41-L50), [DateTar.class:EnrTouTar](../../../../../.src/Gestion/Entrées/DateTar.class#L172-L254)
- [ ] DATETAR-005 — [commonalisation] Calcul du prix de vente par la fabrique commune
  `PrixVente` (GESTAR-008), après preuve par gb.test de l'équivalence `Remise −x %` / `Marge x %`
  (même lot que GESTAR-008) · appelants : aucun · tests : T05, T06 · sources : [DateTar.class:191](../../../../../.src/Gestion/Entrées/DateTar.class#L191), [DateTar.class:214](../../../../../.src/Gestion/Entrées/DateTar.class#L214)
- [ ] DATETAR-006 — [séparation traitement/GUI] `EnrTouTar` : `ProgBar` optionnelle (paramètre ou
  rappel), mise à jour de la fiche article et application par `temp_type` dans deux fonctions
  privées ; `Enr_Click`/`Sup_Click` : requêtes isolées de la lecture de `ListArt` ·
  appelants : `Fmenu` (inchangé) · tests : T02, T03, T05-T07 · sources : [DateTar.class:EnrTouTar](../../../../../.src/Gestion/Entrées/DateTar.class#L172-L254), [DateTar.class:Enr_Click](../../../../../.src/Gestion/Entrées/DateTar.class#L97-L119), [DateTar.class:Sup_Click](../../../../../.src/Gestion/Entrées/DateTar.class#L63-L89)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] DATETAR-A01 — [anomalie] `Enr_Click` et `Sup_Click` bouclent `For i = 0 To ListArt.Count`
  (une itération de trop) : erreur d'indice probable après les mises à jour ; dans `Sup_Click`
  la transaction n'est ni validée ni annulée · tests : T02, T03 · sources : [DateTar.class:73](../../../../../.src/Gestion/Entrées/DateTar.class#L73), [DateTar.class:104](../../../../../.src/Gestion/Entrées/DateTar.class#L104)
- [ ] DATETAR-A02 — [anomalie] Recherche de l'article dans `$restar` : elle reprend au curseur
  courant et `j` n'est pas réinitialisé → article non trouvé ou sélectionné dans un autre ordre
  que la liste : l'article précédent (ou le premier) est modifié / supprimé · tests : T04 ·
  sources : [DateTar.class:74](../../../../../.src/Gestion/Entrées/DateTar.class#L74), [DateTar.class:82](../../../../../.src/Gestion/Entrées/DateTar.class#L82), [DateTar.class:105](../../../../../.src/Gestion/Entrées/DateTar.class#L105), [DateTar.class:113](../../../../../.src/Gestion/Entrées/DateTar.class#L113)
- [ ] DATETAR-A03 — [anomalie] `Sup_Click` : `Return` après `Utils.db.Begin` si `$restar` est vide
  (transaction ouverte) ; `affiche` ne vide pas les listes quand le résultat est vide ·
  tests : T01, T03 · sources : [DateTar.class:72](../../../../../.src/Gestion/Entrées/DateTar.class#L72), [DateTar.class:19](../../../../../.src/Gestion/Entrées/DateTar.class#L19)
- [ ] DATETAR-A04 — [anomalie] `EnrTouTar` : au changement d'article, `art_pvht`/`art_pvttc` sont
  calculés avec le coefficient de la première ligne lue, même s'il s'agit d'un tarif client ou
  type ; sans tarif général, le prix public prend un coefficient client · tests : T06 ·
  sources : [DateTar.class:191](../../../../../.src/Gestion/Entrées/DateTar.class#L191), [DateTar.class:198](../../../../../.src/Gestion/Entrées/DateTar.class#L198)
- [ ] DATETAR-A05 — [anomalie] `EnrTouTar` : `art_pauaht = pbht` (prix brut) alors que
  `GesTar.EnrTarArt` écrit le prix net unitaire × conversion (à confirmer : sens de
  `art_pauaht`) · tests : T05 · sources : [DateTar.class:197](../../../../../.src/Gestion/Entrées/DateTar.class#L197), [GesTar.class:576](../../../../../.src/Gestion/Entrées/GesTar.class#L576)
- [ ] DATETAR-A06 — [anomalie] `EnrTouTar` lit `restva!taux_tva` sans tester `Available` : un code
  TVA inexistant annule l'application de **tous** les tarifs échus (rollback global) ·
  tests : T07 · sources : [DateTar.class:190](../../../../../.src/Gestion/Entrées/DateTar.class#L190), [DateTar.class:194](../../../../../.src/Gestion/Entrées/DateTar.class#L194)
