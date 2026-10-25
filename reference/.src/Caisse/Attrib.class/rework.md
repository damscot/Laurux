# Attrib — Rework

> Source : `.src/Caisse/Attrib.class` · Message de commit (phase 4) : `reference/.src/Caisse/Attrib.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 298 |
| Lignes de commentaire | 7 |
| Fonctions | 19 |
| Fonctions Public | 19 |
| Complexité cyclomatique totale | 82 |
| Complexité max (fonction) | 12 (`Init2`) |
| Variables globales | 0 |
| Variables Public | 4 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 298 | 82 | 12 | 0 | 19 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] ATTRIB-001 — [documentation] En-tête de classe : rôle (touches de la caisse tactile par caisse
  `Start.$Tcai`), nommage des touches (`A<n>`, `A<n>B<m>`), membres publics et leurs écrivains
  (`TriArticles` pour `Bsel`/`Bval`, `FSetFormat` lit `fnd`) · appelants : aucun · tests : T01-T07 · sources : [Attrib.class:Form_Open](../../../../.src/Caisse/Attrib.class#L18-L25), [Attrib.class:Init](../../../../.src/Caisse/Attrib.class#L40-L71), [Attrib.class:Cbutton](../../../../.src/Caisse/Attrib.class#L272-L290)
- [ ] ATTRIB-002 — [code mort] Variables `Couleur` (calculée, jamais lue) de `Clav2_Dblclick` et
  `Fond_ImageButton`, variable `t` initialisée inutilement, boucle de remise à blanc de `Init2` sur
  des noms `B1`…`B35` inexistants · appelants : aucun · tests : T05, T06 · sources : [Attrib.class:Clav2_Dblclick](../../../../.src/Caisse/Attrib.class#L120-L143), [Attrib.class:Fond_ImageButton](../../../../.src/Caisse/Attrib.class#L345-L375), [Attrib.class:Init2](../../../../.src/Caisse/Attrib.class#L311-L343)
- [ ] ATTRIB-003 — [complexité] Fonction `Touche(sNom) As ImageButton` (renvoie `Null` si absente)
  à la place du test `Try Me.Controls[x].Name = x`, dans `Init` et `Init2` uniquement (les appels
  sans `Try` gardent leur erreur, voir A07) · appelants : aucun · tests : T01, T05 · sources : [Attrib.class:Init](../../../../.src/Caisse/Attrib.class#L40-L71), [Attrib.class:Init2](../../../../.src/Caisse/Attrib.class#L311-L343)
- [ ] ATTRIB-004 — [commonalisation] `Bouton_KeyPress` (Suppr) et `Button5_Click` → méthode
  `SupprimeTouche(iCouleur)` (même SQL, même ordre ; la couleur `&HDFE7FF&` de `Bouton_KeyPress`
  passée en paramètre) · appelants : aucun · tests : T03 · sources : [Attrib.class:Bouton_KeyPress](../../../../.src/Caisse/Attrib.class#L145-L162), [Attrib.class:Button5_Click](../../../../.src/Caisse/Attrib.class#L187-L206)
- [ ] ATTRIB-005 — [commonalisation] `Clav2_Dblclick`/`Fond_ImageButton` → `ChoisitCouleur(hBouton,
  bFiltreCai, bInsere)` qui reproduit exactement les deux variantes actuelles (SELECT sans `cai` et
  sans INSERT pour `Clav2`) ; application du format via `CFormat.Applique` si elle est créée (avec
  `SetColors`, `FSetFormat`, `RichDataGrid`) · appelants : aucun · tests : T06 · sources : [Attrib.class:Clav2_Dblclick](../../../../.src/Caisse/Attrib.class#L120-L143), [Attrib.class:Fond_ImageButton](../../../../.src/Caisse/Attrib.class#L345-L375)
- [ ] ATTRIB-006 — [réduction de portée] `createPanel`, `Init`, `TestArt`, `Cbutton`, `Init2`, `Fond_ImageButton` → `Private` (aucun appelant externe, vérifié). `Bsel`, `Bval`, `fnd` restent `Public` · appelants : aucun · tests : T01-T07 · sources : [Attrib.class:createPanel](../../../../.src/Caisse/Attrib.class#L27-L38), [Attrib.class:TestArt](../../../../.src/Caisse/Attrib.class#L79-L93), [Attrib.class:Fond_ImageButton](../../../../.src/Caisse/Attrib.class#L345-L375)
- [ ] ATTRIB-007 — [séparation traitement/GUI] `LitTouches(sPrefixe, cai) As Result`,
  `EnregistreTouche(…)` (SELECT + UPDATE/INSERT et repli actuels **inchangés**),
  `SupprimeTouche(touche, cai)`, `EnregistreCouleur(…)` ; `TestArt` → `ArticleExiste(code)` avec
  `Cbase.Table("TabArt")` (texte SQL identique) · appelants : aucun · tests : T01-T04 · sources : [Attrib.class:Init](../../../../.src/Caisse/Attrib.class#L40-L71), [Attrib.class:Button1_Click](../../../../.src/Caisse/Attrib.class#L164-L185), [Attrib.class:TestArt](../../../../.src/Caisse/Attrib.class#L79-L93)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] ATTRIB-A01 — [anomalie] `Button1_Click` : si l'`INSERT` échoue, le repli exécute `UPDATE
  Fiches_Touches SET cai = <caisse> WHERE touche = <code article>` (`Cart.Text` au lieu de
  `Bouton.Text`) : déplace vers la caisse courante les touches d'une autre caisse dont le nom égale
  le code article, voire provoque un doublon de clé · tests : T02 · sources : [Attrib.class:174](../../../../.src/Caisse/Attrib.class#L174)
- [ ] ATTRIB-A02 — [anomalie] `Clav2_Dblclick` teste l'existence de la touche **toutes caisses
  confondues** (`WHERE touche = &1`, sans `cai`) puis met à jour avec `cai`, et n'insère rien si la
  touche n'existe pas dans cette caisse : la couleur choisie est perdue au `Init()` suivant · tests :
  T06 · sources : [Attrib.class:136](../../../../.src/Caisse/Attrib.class#L136), [Attrib.class:138](../../../../.src/Caisse/Attrib.class#L138)
- [ ] ATTRIB-A03 — [anomalie] `FSetFormat.Lgo2_Click` enregistre l'image de fond par
  `UPDATE … WHERE touche = Attrib.fnd` sans `cai` : l'image est appliquée à la même touche de
  toutes les caisses (correction dans `FSetFormat`, lot Utils) · tests : T06 · sources : [FSetFormat.class:72](../../../../.src/Utils/FSetFormat.class#L72), [Attrib.class:113](../../../../.src/Caisse/Attrib.class#L113)
- [ ] ATTRIB-A04 — [anomalie] `Libellearticle` n'est écrit par personne (`TriArticles` ne transmet
  que `Bsel`/`Bval`) : après une recherche d'article, `Label3` reste vide au lieu d'afficher la
  désignation · tests : T04 · sources : [Attrib.class:219](../../../../.src/Caisse/Attrib.class#L219), [TriArticles.class:165](../../../../.src/Affichages/TriArticles.class#L165)
- [ ] ATTRIB-A05 — [anomalie] En mode sous-famille, `Button1_Click`, `Button5_Click` et
  `Bouton_KeyPress` rechargent par `Init()` (et non `Init2()`) ; le filtre `left(touche,1) = 'A'`
  inclut les touches `A<n>B<m>` dont les contrôles existent alors : textes et `CodeA` mélangés entre
  familles et sous-familles (à confirmer en phase 2) · tests : T05 · sources : [Attrib.class:180](../../../../.src/Caisse/Attrib.class#L180), [Attrib.class:203](../../../../.src/Caisse/Attrib.class#L203), [Attrib.class:52](../../../../.src/Caisse/Attrib.class#L52)
- [ ] ATTRIB-A06 — [anomalie] `Form_Open` écrit `Caisse.origine = "Attrib"` : membre jamais lu, et
  l'accès crée l'auto-instance de `Caisse` (fenêtre cachée, distincte de celle ouverte par `Cmenu`) ;
  le retrait supprime cet effet de bord · tests : T01 · sources : [Attrib.class:22](../../../../.src/Caisse/Attrib.class#L22), [Cmenu.class:253](../../../../.src/Caisse/Cmenu.class#L253)
- [ ] ATTRIB-A07 — [anomalie] Suppression d'une touche (`Button5`, touche Suppr dans `Bouton`) sans
  confirmation ; `Me.Controls[Bouton.Text]` sans `Try` dans `Button1_Click`, `Button5_Click`,
  `Bouton_KeyPress` : un nom saisi à la main qui n'est pas une touche lève une erreur après
  l'écriture en base ; `Button4_Click` masque toute erreur par un `Catch` vide · tests : T03, T07 · sources : [Attrib.class:149](../../../../.src/Caisse/Attrib.class#L149), [Attrib.class:176](../../../../.src/Caisse/Attrib.class#L176), [Attrib.class:198](../../../../.src/Caisse/Attrib.class#L198), [Attrib.class:Button4_Click](../../../../.src/Caisse/Attrib.class#L236-L267)
