# Attribution — Rework

> Source : `.src/Gestion/Lcr/Attribution.class` · Message de commit (phase 4) : `reference/.src/Gestion/Lcr/Attribution.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 517 |
| Lignes de commentaire | 42 |
| Fonctions | 47 |
| Fonctions Public | 47 |
| Complexité cyclomatique totale | 125 |
| Complexité max (fonction) | 19 (`Imp_Lcr`) |
| Variables globales | 0 |
| Variables Public | 7 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 517 | 125 | 19 | 0 | 47 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] ATTRIBUTION-001 — [documentation] En-tête en français : étape 2 de la chaîne LCR, critères
  « attribuable » (`banque = 0`, `ecartee <> 1`, `bordereau = 0`), fonctionnement des totaux et de
  l'attribution en masse · appelants : aucun · tests : aucun · sources : [Attribution.class:_New](../../../../../.src/Gestion/Lcr/Attribution.class#L53-L82),
  [Attribution.class:Button10_Click](../../../../../.src/Gestion/Lcr/Attribution.class#L511-L541)
- [ ] ATTRIBUTION-002 — [code mort] Supprimer `Deb3`, `Button5_Click` (contrôle absent),
  `Button7_Click` et `compte` (bouton invisible jamais affiché ; `compteman` conservé), la lecture de
  `Fiches_Lcr` de `_New` (`Nb` jamais lu ; SQL modifié, dump identique), `sCmpt`, `sdesg`, `Dte1`,
  `B`, `CoulZns`, `CoulZnaf`, `Coulfond`, `Posx` et l'`Enrg = 0` inatteignable de `Total` ·
  appelants : aucun · tests : T01-T08 · sources : [Attribution.class:Deb3](../../../../../.src/Gestion/Lcr/Attribution.class#L372-L379),
  [Attribution.class:Button5_Click](../../../../../.src/Gestion/Lcr/Attribution.class#L584-L588), [Attribution.class:Button7_Click](../../../../../.src/Gestion/Lcr/Attribution.class#L590-L594), [Attribution.class:compte](../../../../../.src/Gestion/Lcr/Attribution.class#L599-L611),
  [Attribution.class:79](../../../../../.src/Gestion/Lcr/Attribution.class#L79), [Attribution.class:403](../../../../../.src/Gestion/Lcr/Attribution.class#L403)
- [ ] ATTRIBUTION-003 — [réduction de portée] `Entete`, `Tris`, `Deb`, `Deb2`, `Deb4`, `Total`,
  `Refresh`, `CleanChamps`, `Maj_Zones`, `compteman`, `Imp_Lcr`, `Nb`, `sDate`, `iLind` → `Private`
  (`ColLcr_Click`, `N_click`, `A_click` et les autres handlers restent `Public`, `Bsel`/`Bval`
  aussi) · appelants : aucun · tests : T01-T08 · sources : [Attribution.class:Deb2](../../../../../.src/Gestion/Lcr/Attribution.class#L353-L370),
  [Attribution.class:Total](../../../../../.src/Gestion/Lcr/Attribution.class#L390-L424), [Attribution.class:Imp_Lcr](../../../../../.src/Gestion/Lcr/Attribution.class#L646-L705)
- [ ] ATTRIBUTION-004 — [complexité] `ColLcr_Data` : cache des noms de banques et `Lcrtable`
  initialisé une fois (SQL modifié : une requête au lieu d'une par cellule, affichage identique) ·
  appelants : aucun · tests : T01, T02 · sources : [Attribution.class:ColLcr_Data](../../../../../.src/Gestion/Lcr/Attribution.class#L281-L322)
- [ ] ATTRIBUTION-005 — [séparation traitement/GUI] Extraire `AttribueBanque(banque, linds)`,
  `MajLcr(…)`, `SupprimeLcr(lind)` et les requêtes de `Deb*`/`Imp_Lcr` ; SQL inchangé · appelants :
  aucun · tests : T04-T08 · sources : [Attribution.class:Button10_Click](../../../../../.src/Gestion/Lcr/Attribution.class#L511-L541),
  [Attribution.class:Button3_Click](../../../../../.src/Gestion/Lcr/Attribution.class#L546-L555), [Attribution.class:Button2_Click](../../../../../.src/Gestion/Lcr/Attribution.class#L560-L573)
- [ ] ATTRIBUTION-006 — [commonalisation] Fonctions communes avec `Preparation` et `Lcr` (module LCR
  de phase 3) : `Total`, `DAE_KeyPress`/`Deb4` (corps), `Maj_Zones`, `compteman`, `ColLcr_Data`,
  `Imp_Lcr`, liste des banques ; handlers inchangés · appelants : aucun · tests : T01-T08 et replays
  de `Preparation`/`Lcr` · sources : [Attribution.class:Total](../../../../../.src/Gestion/Lcr/Attribution.class#L390-L424), [Preparation.class:Total](../../../../../.src/Gestion/Lcr/Preparation.class#L417-L451),
  [Attribution.class:Form_Open](../../../../../.src/Gestion/Lcr/Attribution.class#L84-L106), [Preparation.class:Form_Open](../../../../../.src/Gestion/Lcr/Preparation.class#L97-L119)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] ATTRIBUTION-A01 — [anomalie] Totaux faux : `Total` s'arrête à `Enrg` lignes, `Enrg` vaut 0 en
  mode « non attribuées » et après une recherche (totaux toujours nuls), et le comptage du mode
  « attribuées » ajoute un filtre `acceptee <> 1` absent de la liste (total partiel). Calculer
  nombre et montant sur la requête de la grille · tests : T01, T02 · sources :
  [Attribution.class:Total](../../../../../.src/Gestion/Lcr/Attribution.class#L390-L424), [Attribution.class:356](../../../../../.src/Gestion/Lcr/Attribution.class#L356), [Attribution.class:360](../../../../../.src/Gestion/Lcr/Attribution.class#L360)
- [ ] ATTRIBUTION-A02 — [anomalie] Recherche par échéance : `Deb4` mélange `And`/`Or` sans
  parenthèses (premier terme sans le filtre `like`) et `DAE_KeyPress` retransforme un motif déjà
  transformé à la 8ᵉ frappe · tests : T03 · sources : [Attribution.class:Deb4](../../../../../.src/Gestion/Lcr/Attribution.class#L381-L388),
  [Attribution.class:DAE_KeyPress](../../../../../.src/Gestion/Lcr/Attribution.class#L185-L204)
- [ ] ATTRIBUTION-A03 — [anomalie] `Imp_Lcr` n'applique pas les filtres de la grille (`ecartee`,
  `bordereau`) : la liste imprimée contient des LCR écartées ou déjà remises ; adresse précédente
  réutilisée si le client est introuvable · tests : T08 · sources : [Attribution.class:658](../../../../../.src/Gestion/Lcr/Attribution.class#L658),
  [Attribution.class:Imp_Lcr](../../../../../.src/Gestion/Lcr/Attribution.class#L646-L705)
- [ ] ATTRIBUTION-A04 — [anomalie] Fin de la boucle d'attribution fondée sur la répétition du `lind`
  après un `MoveTo` hors bornes (à confirmer) ; liste vide → message d'erreur technique ; pas de
  transaction (attribution partielle possible) · tests : T05, T06 · sources :
  [Attribution.class:Button10_Click](../../../../../.src/Gestion/Lcr/Attribution.class#L511-L541)
- [ ] ATTRIBUTION-A05 — [anomalie] `Button3_Click` sans fiche sélectionnée met à jour `lind = 0`
  silencieusement ; `Button2_Click` sans sélection lève une erreur non interceptée · tests : T04, T07
  · sources : [Attribution.class:Button3_Click](../../../../../.src/Gestion/Lcr/Attribution.class#L546-L555), [Attribution.class:566](../../../../../.src/Gestion/Lcr/Attribution.class#L566)
- [ ] ATTRIBUTION-A06 — [anomalie] Écran non instrumenté (`Utils.Observers(Me)` absent) : pas de
  journal ni de rejeu ; l'ajout modifie le log produit (nécessaire aux replays) · tests : T01-T09 ·
  sources : [Attribution.class:_New](../../../../../.src/Gestion/Lcr/Attribution.class#L53-L82)
