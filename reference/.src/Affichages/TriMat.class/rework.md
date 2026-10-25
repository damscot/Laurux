# TriMat — Rework

> Source : `.src/Affichages/TriMat.class` · Message de commit (phase 4) : `reference/.src/Affichages/TriMat.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 329 |
| Lignes de commentaire | 5 |
| Fonctions | 32 |
| Fonctions Public | 32 |
| Complexité cyclomatique totale | 117 |
| Complexité max (fonction) | 11 (`ColMat_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 329 | 117 | 11 | 0 | 32 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] TRIMAT-001 — [documentation] En-tête de classe : rôle, signature (`Barticle`/`B2article`
  ignorés, `$Tri` remplacé par `mat_design`), retour en dur vers `EdMat.Bsel`/`CodeMat`, filtres
  et sens des touches · appelants : aucun · tests : T01-T05 · sources : [TriMat.class:_new](../../../../.src/Affichages/TriMat.class#L15-L33), [TriMat.class:ColMat_Click](../../../../.src/Affichages/TriMat.class#L376-L387)
- [ ] TRIMAT-002 — [complexité] `Deb1`/`Deb2` (8 textes SQL) → `Charge(bDesc)` unique, texte
  identique · appelants : aucun · tests : T02-T04 · sources : [TriMat.class:Deb1](../../../../.src/Affichages/TriMat.class#L242-L270), [TriMat.class:Deb2](../../../../.src/Affichages/TriMat.class#L272-L300)
- [ ] TRIMAT-003 — [complexité] `ColMat_Data` : `Mattable` initialisé une fois, colonne 2 par
  `ChampColonne2(Tri)` ; `RadioButton1/2/3_Click` → `Filtre()` commune (handlers conservés) ;
  suppression de `Bart`, `B2art` et des `Dbl = ""` · appelants : aucun · tests : T02, T03 · sources : [TriMat.class:ColMat_Data](../../../../.src/Affichages/TriMat.class#L210-L240), [TriMat.class:RadioButton1_Click](../../../../.src/Affichages/TriMat.class#L418-L424), [TriMat.class:RadioButton3_Click](../../../../.src/Affichages/TriMat.class#L434-L440)
- [ ] TRIMAT-004 — [séparation traitement/GUI] `RequeteMateriels(sTri, sSel, sVendu, bDesc,
  iDebut, iNb) As String` pure, appelée par `Charge` · appelants : aucun · tests : T02, T06 · sources : [TriMat.class:Deb1](../../../../.src/Affichages/TriMat.class#L242-L270)
- [ ] TRIMAT-005 — [réduction de portée] `mat_Dblclk`, `ChkInput`, `TriMat`, `Deb1`, `Deb2`,
  `Deplacement` → `Private` (aucun appelant externe, vérifié ; couverts par T02-T04) · appelants :
  aucun · tests : T02-T04 · sources : [TriMat.class:mat_Dblclk](../../../../.src/Affichages/TriMat.class#L170-L180), [TriMat.class:ChkInput](../../../../.src/Affichages/TriMat.class#L182-L191), [TriMat.class:TriMat](../../../../.src/Affichages/TriMat.class#L193-L208), [TriMat.class:Deplacement](../../../../.src/Affichages/TriMat.class#L365-L374)
- [ ] TRIMAT-006 — [commonalisation] Pagination vers `PaginationListe` (TRICARTES-005) en
  conservant le sens actuel des touches (paramètre de la classe d'aide) tant que TRIMAT-A01 n'est
  pas validée · appelants : aucun · tests : T04 · sources : [TriMat.class:ColMat_KeyPress](../../../../.src/Affichages/TriMat.class#L389-L416), [TriMat.class:ColMat_MouseWheel](../../../../.src/Affichages/TriMat.class#L302-L315), [TriMat.class:Remonter_Click](../../../../.src/Affichages/TriMat.class#L317-L325), [TriMat.class:Descendre_Click](../../../../.src/Affichages/TriMat.class#L327-L335)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] TRIMAT-A01 — [anomalie] Navigation clavier inversée : flèche haut en première ligne et
  PageUp → page suivante ; flèche bas en dernière ligne et PageDown → page précédente (grille et
  boutons) ; le sens est l'inverse de `Tricp`, `TriEqu`, `TriGen` · tests : T04 · sources : [TriMat.class:400](../../../../.src/Affichages/TriMat.class#L400), [TriMat.class:405](../../../../.src/Affichages/TriMat.class#L405), [TriMat.class:409](../../../../.src/Affichages/TriMat.class#L409), [TriMat.class:413](../../../../.src/Affichages/TriMat.class#L413), [TriMat.class:342](../../../../.src/Affichages/TriMat.class#L342), [TriMat.class:352](../../../../.src/Affichages/TriMat.class#L352)
- [ ] TRIMAT-A02 — [anomalie] `EdMat.Bsel` n'est jamais remis à `False` (ni par `TriMat` ni par
  `EdMat`) : après une sélection, une annulation réapplique l'ancien matériel · tests : T05 · sources : [TriMat.class:381](../../../../.src/Affichages/TriMat.class#L381), [EdMat.class:138](../../../../.src/Gestion/Impressions/EdMat.class#L138)
- [ ] TRIMAT-A03 — [anomalie] Changement de filtre vendu/en stock sans retour à la première page
  (`NbEnreg` conservé) : liste vide possible ; `ChkInput` recharge en ordre croissant même après
  inversion du tri · tests : T03, T02 · sources : [TriMat.class:RadioButton1_Click](../../../../.src/Affichages/TriMat.class#L418-L424), [TriMat.class:186](../../../../.src/Affichages/TriMat.class#L186)
