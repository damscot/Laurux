# Cetiquettes — Rework

> Source : `.src/Reports/Cetiquettes.class` · Message de commit (phase 4) : `reference/.src/Reports/Cetiquettes.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 185 |
| Lignes de commentaire | 5 |
| Fonctions | 29 |
| Fonctions Public | 29 |
| Complexité cyclomatique totale | 33 |
| Complexité max (fonction) | 3 (`Barcode`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 185 | 33 | 3 | 0 | 29 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CETIQUETTES-001 — [documentation] En-tête de classe en français : rôle (éléments
  d'étiquette à position absolue), sens de `fontratio`, formats de page acceptés (A4, `dymog`,
  `dymoc`), contrat de `Barcode` (13 chiffres, dimensions en chaîne à virgule) ; tableau des
  textes (style, taille, largeur) · appelants : aucun · tests : T01-T05 · sources : [Cetiquettes.class:_new](../../../../.src/Reports/Cetiquettes.class#L8-L14), [Cetiquettes.class:Barcode](../../../../.src/Reports/Cetiquettes.class#L143-L162)
- [ ] CETIQUETTES-002 — [commonalisation] Helper `Texte(txt, posX, posY, style, taille,
  fontratio, largeur, h)` pour les 14 textes simples (`Nom`, `Cp`, `NomC`, `CpC`, `casierc`,
  `Codec`, `Intitulec`, `casier`, `Code`, `IntituleA`, `Intitule`, `stock`, `Refour`, et la partie
  texte d'`Adrexp`) ; `IntituleB` → `Left$(bcode, 29)` ; noms publics conservés, flux identique ·
  appelants : aucun · tests : T01, T02 · sources : [Cetiquettes.class:Nom](../../../../.src/Reports/Cetiquettes.class#L22-L28), [Cetiquettes.class:Code](../../../../.src/Reports/Cetiquettes.class#L107-L113), [Cetiquettes.class:Intitule](../../../../.src/Reports/Cetiquettes.class#L135-L141), [Cetiquettes.class:Codec](../../../../.src/Reports/Cetiquettes.class#L73-L79), [Cetiquettes.class:IntituleA](../../../../.src/Reports/Cetiquettes.class#L115-L121), [Cetiquettes.class:IntituleB](../../../../.src/Reports/Cetiquettes.class#L123-L133), [Cetiquettes.class:Refour](../../../../.src/Reports/Cetiquettes.class#L274-L280)
- [ ] CETIQUETTES-003 — [commonalisation] Helper `LibellePrix(libelle, valeur, posX, posY,
  fontratio, decalage, bDecalageFixe)` pour `Tva`, `PrixHt`, `PrixTTC`, `PrixHtP`, `PrixTTCP`
  (les `SetFillColor` de `PrixHt`/`PrixHtP` sont conservés pour un flux identique) · appelants :
  aucun · tests : T03 · sources : [Cetiquettes.class:Tva](../../../../.src/Reports/Cetiquettes.class#L172-L181), [Cetiquettes.class:PrixHt](../../../../.src/Reports/Cetiquettes.class#L219-L229), [Cetiquettes.class:PrixTTC](../../../../.src/Reports/Cetiquettes.class#L231-L240), [Cetiquettes.class:PrixHtP](../../../../.src/Reports/Cetiquettes.class#L251-L261), [Cetiquettes.class:PrixTTCP](../../../../.src/Reports/Cetiquettes.class#L263-L272)
- [ ] CETIQUETTES-004 — [commonalisation] Hériter de la base `PdfLaurux` (CARTICLES-004) pour la
  couleur du thème (`Rectangle`, `Rectangle2`, prix) et `NewPage` (partagé avec `Clivre`) ; noms
  publics conservés · appelants : aucun · tests : T03, T05, T06 · sources : [Cetiquettes.class:_new](../../../../.src/Reports/Cetiquettes.class#L8-L14), [Cetiquettes.class:NewPage](../../../../.src/Reports/Cetiquettes.class#L16-L20), [Cetiquettes.class:Rectangle](../../../../.src/Reports/Cetiquettes.class#L211-L217), [Cetiquettes.class:Rectangle2](../../../../.src/Reports/Cetiquettes.class#L203-L209)
- [ ] CETIQUETTES-005 — [séparation traitement/GUI] `Barcode` : extraire les calculs purs
  `ModuleEan(largeur) As Float` (÷ 95, plafond 0,55) et `HauteurEan(hauteur) As Integer`
  (troncature conservée), testables en gb.test · appelants : aucun · tests : T04 · sources : [Cetiquettes.class:Barcode](../../../../.src/Reports/Cetiquettes.class#L143-L162)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] CETIQUETTES-A01 — [anomalie] `Barcode` lit ses dimensions par `Val(Utils.cpoint(…))` alors
  que les appelants passent des `Float` convertis implicitement en chaîne (« 4.666… ») : correct
  en locale française seulement (`Val` refuse la virgule ailleurs → `Null` → erreur), et la
  hauteur est tronquée à l'entier (`Haut As Integer`), ce qui écrase les codes-barres des petites
  étiquettes (hauteur 4,67 → 4 mm). Correction : paramètres `Float`, hauteur `Float` (rendu
  modifié) · tests : T04 · sources : [Cetiquettes.class:146](../../../../.src/Reports/Cetiquettes.class#L146), [Cetiquettes.class:149](../../../../.src/Reports/Cetiquettes.class#L149), [Cetiquettes.class:150](../../../../.src/Reports/Cetiquettes.class#L150), [Etiqart.class:939](../../../../.src/Gestion/Etiquettes/Etiqart.class#L939)
