# Glcr — Rework

> Source : `.src/Gestion/Lcr/Glcr.class` · Message de commit (phase 4) : `reference/.src/Gestion/Lcr/Glcr.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 305 |
| Lignes de commentaire | 14 |
| Fonctions | 16 |
| Fonctions Public | 16 |
| Complexité cyclomatique totale | 84 |
| Complexité max (fonction) | 39 (`Deb`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 305 | 84 | 39 | 0 | 16 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] GLCR-001 — [documentation] En-tête en français (rôle de l'écran, sens des radios et des
  colonnes E/B/C, lien avec `Preparation`/`Bordrx`) et commentaires `'''` sur `Deb` ·
  appelants : aucun · tests : aucun · sources : [Glcr.class:Deb](../../../../../.src/Gestion/Lcr/Glcr.class#L81-L153)
- [ ] GLCR-002 — [code mort] Supprimer `CheckBox1_Click` (contrôle absent), les handlers inactifs
  `A1_Click`, `A2_Click`, `T2_Click` (groupe `Btn`), les impressions `Draw` `Level2`, `Level3`,
  `Level4`, la branche inatteignable l. 116-117, les membres inutilisés (`Dte1`, `Tri`, `CoulB`,
  `CoulF`, `Fnt`, `CoulZns`, `CoulZnaf`, `Coulfc`, `Coulfond`) et le `Dim rResult` de `_New` ·
  appelants : aucun · tests : T01-T07 · sources : [Glcr.class:CheckBox1_Click](../../../../../.src/Gestion/Lcr/Glcr.class#L178-L186),
  [Glcr.class:A1_Click](../../../../../.src/Gestion/Lcr/Glcr.class#L188-L195), [Glcr.class:A2_Click](../../../../../.src/Gestion/Lcr/Glcr.class#L197-L204), [Glcr.class:T2_Click](../../../../../.src/Gestion/Lcr/Glcr.class#L206-L213), [Glcr.class:Level2](../../../../../.src/Gestion/Lcr/Glcr.class#L284-L305),
  [Glcr.class:Level3](../../../../../.src/Gestion/Lcr/Glcr.class#L308-L321), [Glcr.class:Level4](../../../../../.src/Gestion/Lcr/Glcr.class#L324-L336), [Glcr.class:116](../../../../../.src/Gestion/Lcr/Glcr.class#L116)
- [ ] GLCR-003 — [réduction de portée] `Deb` → `Private` · appelants : aucun · tests : T01-T05 ·
  sources : [Glcr.class:Deb](../../../../../.src/Gestion/Lcr/Glcr.class#L81-L153)
- [ ] GLCR-004 — [séparation traitement/GUI] Extraire de `Deb` une fonction `RequeteLcr(…) As Result`
  sans accès aux contrôles, et de `Button2_Click` une fonction `SupprimeLcr(linds)` ; **SQL
  inchangé** (y compris les requêtes invalides tant que A02-A04 ne sont pas validées) ·
  appelants : aucun · tests : T01-T07 · sources : [Glcr.class:Deb](../../../../../.src/Gestion/Lcr/Glcr.class#L81-L153), [Glcr.class:Button2_Click](../../../../../.src/Gestion/Lcr/Glcr.class#L353-L372)
- [ ] GLCR-005 — [complexité] Après décision sur A02-A04 : construire la clause `WHERE` par
  fragments au lieu de l'arbre de `If` (CC 39 → ≤ 12 visé) · appelants : aucun · tests : T01-T05 ·
  sources : [Glcr.class:Deb](../../../../../.src/Gestion/Lcr/Glcr.class#L81-L153)
- [ ] GLCR-006 — [commonalisation] Remplissage de la liste des banques partagé avec `Attribution` et
  `Preparation` (fonction commune créée en phase 3) ; comportement identique (liste vide tant que
  A01 n'est pas corrigée) · appelants : aucun · tests : T01, T03 · sources : [Glcr.class:Form_Open](../../../../../.src/Gestion/Lcr/Glcr.class#L38-L76),
  [Attribution.class:Form_Open](../../../../../.src/Gestion/Lcr/Attribution.class#L84-L106), [Preparation.class:Form_Open](../../../../../.src/Gestion/Lcr/Preparation.class#L97-L119)
- [ ] GLCR-007 — [commonalisation] Initialisation des couleurs de `_New` via l'aide commune des
  couleurs `/Coul/*` (transverse) · appelants : aucun · tests : T01 · sources : [Glcr.class:_New](../../../../../.src/Gestion/Lcr/Glcr.class#L15-L36)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] GLCR-A01 — [anomalie] `Form_Open` lit `Cbase.Table("TabBanques")`, clé absente (CBASE-A01) :
  liste des banques toujours vide, filtre « attribuées » par banque inutilisable. Correction :
  `Fiches_Banques` (clé `Cbase` à ajouter ou nom en dur comme ailleurs dans le lot) · tests : T01,
  T03 · sources : [Glcr.class:40](../../../../../.src/Gestion/Lcr/Glcr.class#L40)
- [ ] GLCR-A02 — [anomalie] SQL `andand` (non attribuées, avec ou sans échéance) : erreur SQL au
  lieu de la liste · tests : T04, T05 · sources : [Glcr.class:101](../../../../../.src/Gestion/Lcr/Glcr.class#L101), [Glcr.class:121](../../../../../.src/Gestion/Lcr/Glcr.class#L121),
  [Glcr.class:125](../../../../../.src/Gestion/Lcr/Glcr.class#L125)
- [ ] GLCR-A03 — [anomalie] `",1")` placé dans la chaîne SQL et `&1` non substitué : erreur SQL
  pour les filtres avec échéance · tests : T05 · sources : [Glcr.class:111](../../../../../.src/Gestion/Lcr/Glcr.class#L111), [Glcr.class:120](../../../../../.src/Gestion/Lcr/Glcr.class#L120)
- [ ] GLCR-A04 — [anomalie] Dates d'échéance concaténées sans guillemets ni paramètre
  (`datech >= 2026-10-25`) : filtre par échéance faux ; passer par `&N` · tests : T05 ·
  sources : [Glcr.class:113](../../../../../.src/Gestion/Lcr/Glcr.class#L113), [Glcr.class:124](../../../../../.src/Gestion/Lcr/Glcr.class#L124)
- [ ] GLCR-A05 — [anomalie] Impression : arguments de `Level2A` décalés (banque sous « Code acpt »,
  code entrée sous « Banque ») et titre vide quand l'échéance est cochée · tests : T06 ·
  sources : [Glcr.class:264](../../../../../.src/Gestion/Lcr/Glcr.class#L264), [Glcr.class:Button9_Click](../../../../../.src/Gestion/Lcr/Glcr.class#L221-L281)
- [ ] GLCR-A06 — [anomalie] Impression : nombre et total des LCR calculés (`iLcr`, `mTotal`) mais
  jamais imprimés (`CLcr.Level5A` prévue et inutilisée) · tests : T06 · sources :
  [Glcr.class:Button9_Click](../../../../../.src/Gestion/Lcr/Glcr.class#L221-L281), [CLcr.class:Level5A](../../../../../.src/Gestion/Lcr/CLcr.class#L221-L235)
- [ ] GLCR-A07 — [anomalie] Filtre `bordereau <> 1` partout : la colonne contient le numéro de
  bordereau, seules les LCR du bordereau n° 1 sont masquées ; la suppression peut toucher des LCR
  rattachées à d'autres bordereaux (intention à confirmer : `bordereau = 0` ?) · tests : T01, T07 ·
  sources : [Glcr.class:93](../../../../../.src/Gestion/Lcr/Glcr.class#L93), [Glcr.class:Button2_Click](../../../../../.src/Gestion/Lcr/Glcr.class#L353-L372)
- [ ] GLCR-A08 — [anomalie] `ColLcr.Item[9]` écrit et relu hors des 9 colonnes (à confirmer en
  phase 2) ; suppression basée sur cette colonne · tests : T01, T07 · sources : [Glcr.class:145](../../../../../.src/Gestion/Lcr/Glcr.class#L145),
  [Glcr.class:362](../../../../../.src/Gestion/Lcr/Glcr.class#L362)
- [ ] GLCR-A09 — [anomalie] Boutons « Doc HTML » (`Button1`) et « Quitter » (`Button4`) sans
  handler : inopérants. Ajouter `Button1_Click` (`Doc.Open("LCR")`) et `Button4_Click`
  (`Me.Close`) comme dans les autres écrans LCR · tests : T08 · sources : [Glcr.class:Button9_Click](../../../../../.src/Gestion/Lcr/Glcr.class#L221-L281)
