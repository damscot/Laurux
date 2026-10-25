# RelMoprod — Rework

> Source : `.src/Statistiques/RelMoprod.class` · Message de commit (phase 4) : `reference/.src/Statistiques/RelMoprod.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 787 |
| Lignes de commentaire | 47 |
| Fonctions | 52 |
| Fonctions Public | 52 |
| Complexité cyclomatique totale | 189 |
| Complexité max (fonction) | 30 (`MajTab`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 787 | 189 | 30 | 0 | 52 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] RELMOPROD-001 — [documentation] En-tête en français : rôle, sources, table `Fiches_Stat`
  (structure, colonnes non remplies), modes `RB1`–`RB4`, structure de l'arbre et des clés de nœud ·
  appelants : aucun · tests : aucun · sources : [RelMoprod.class:Form_Open](../../../../.src/Statistiques/RelMoprod.class#L44-L59), [RelMoprod.class:Button1_Click](../../../../.src/Statistiques/RelMoprod.class#L160-L259), [RelMoprod.class:MajTab](../../../../.src/Statistiques/RelMoprod.class#L261-L329)
- [ ] RELMOPROD-002 — [code mort] Supprimer `compteMan` et `A1_KeyPress` (jamais appelés, aucun
  contrôle `A1`), `Stats`, `Coulfond`, `Frmt`, `dte`/`dte1`/`dte2`, `Shell "cd …"` et les variables
  inutiles de `Button4_Click` · appelants : aucun · tests : T01, T04, T05 · sources : [RelMoprod.class:compteMan](../../../../.src/Statistiques/RelMoprod.class#L698-L710), [RelMoprod.class:A1_KeyPress](../../../../.src/Statistiques/RelMoprod.class#L919-L923), [RelMoprod.class:Form_Open](../../../../.src/Statistiques/RelMoprod.class#L44-L59), [RelMoprod.class:Button4_Click](../../../../.src/Statistiques/RelMoprod.class#L331-L476)
- [ ] RELMOPROD-003 — [complexité] `Button1_Click` : factoriser les trois passes (BL, factures,
  factures matériel) dans un helper privé paramétré, mêmes requêtes dans le même ordre (CC 26 → ≤ 10
  visé) · appelants : aucun · tests : T01-T03 · sources : [RelMoprod.class:Button1_Click](../../../../.src/Statistiques/RelMoprod.class#L160-L259)
- [ ] RELMOPROD-004 — [complexité] `MajTab` : itérer sur les clients (`RB3`) ou codes (`RB4`) distincts
  et ajouter les nœuds sans reparcourir l'arbre à chaque ligne ; arbre identique (nœuds, textes,
  ordre) vérifié sur T04/T05 ; **SQL modifié, dump identique** (CC 30 → ≤ 10 visé) · appelants : aucun ·
  tests : T01, T04, T05 · sources : [RelMoprod.class:MajTab](../../../../.src/Statistiques/RelMoprod.class#L261-L329)
- [ ] RELMOPROD-005 — [complexité] `Colcli_Data` : couleurs `CoulB`/`CoulF` et `CliTable` calculées une
  fois à l'ouverture de la grille au lieu de chaque cellule (rendu identique) · appelants : aucun ·
  tests : T08 · sources : [RelMoprod.class:Colcli_Data](../../../../.src/Statistiques/RelMoprod.class#L715-L748)
- [ ] RELMOPROD-006 — [séparation traitement/GUI] Extraire `RemplitStat(d0, d1, sClient) As Boolean`
  (DROP/CREATE et remplissage de `Fiches_Stat`) et `LitFacture(numfac) As Result` (historique puis en
  cours) ; les handlers gardent messages, curseur et remplissage des contrôles · appelants : aucun ·
  tests : T01-T03, T06, T09 · sources : [RelMoprod.class:Button1_Click](../../../../.src/Statistiques/RelMoprod.class#L160-L259), [RelMoprod.class:Rlcli_click](../../../../.src/Statistiques/RelMoprod.class#L529-L646)
- [ ] RELMOPROD-007 — [commonalisation] `Ex1` → `PeriodeParDefaut()` (RELVMO-007) ;
  `dteN0_LostFocus`/`dteN1_LostFocus` → `StatCommun.DateSaisie` (HITCARTE-006) ; `Fiches_Parametres` via
  `Cbase.Table("TabParam")` · appelants : aucun · tests : T01 · sources : [RelMoprod.class:Ex1](../../../../.src/Statistiques/RelMoprod.class#L72-L88), [RelMoprod.class:dteN0_LostFocus](../../../../.src/Statistiques/RelMoprod.class#L122-L136), [RelvMo.class:Ex1](../../../../.src/Statistiques/RelvMo.class#L76-L92)
- [ ] RELMOPROD-008 — [commonalisation] Grille de recherche client (`Deb3`/`Deb4`/`Dbclk`, en-têtes
  `C1/N1/Cp1/V1`, `ChkInput`) : clause de recherche commune avec `Tricartes`, `TriclientsD`, `TriBl`,
  `ConsultArt`, `Materiel` (voir FCLIENTCARTE-012), même texte SQL produit · appelants : aucun · tests :
  T08 · sources : [RelMoprod.class:Deb3](../../../../.src/Statistiques/RelMoprod.class#L807-L811), [RelMoprod.class:Deb4](../../../../.src/Statistiques/RelMoprod.class#L813-L817), [Tricartes.class:Deb4](../../../../.src/Caisse/Affichages/Tricartes.class#L188-L194)
- [ ] RELMOPROD-009 — [réduction de portée] `Ex1`, `dteN0_GotFocus`, `dteN0_LostFocus`,
  `dteN1_GotFocus`, `dteN1_LostFocus` (non levés : groupe `Cmpt`), `MajTab`, `Controle`, `Tris`,
  `compteTiers`, `Deb3`, `Deb4`, `Dbclk`, `ChkInput` → `Private` · appelants : aucun · tests : T01, T04,
  T08 · sources : [RelMoprod.class:Ex1](../../../../.src/Statistiques/RelMoprod.class#L72-L88), [RelMoprod.class:MajTab](../../../../.src/Statistiques/RelMoprod.class#L261-L329), [RelMoprod.class:Controle](../../../../.src/Statistiques/RelMoprod.class#L478-L491), [RelMoprod.class:ChkInput](../../../../.src/Statistiques/RelMoprod.class#L989-L998)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] RELMOPROD-A01 — [anomalie] Clé (code, client, facture) et `INSERT` seulement si absent : une
  deuxième ligne du même code dans la même facture est perdue (quantité et montant) · tests : T01 ·
  sources : [RelMoprod.class:198](../../../../.src/Statistiques/RelMoprod.class#L198), [RelMoprod.class:215](../../../../.src/Statistiques/RelMoprod.class#L215), [RelMoprod.class:232](../../../../.src/Statistiques/RelMoprod.class#L232)
- [ ] RELMOPROD-A02 — [anomalie] Période des factures en cours filtrée sur `datebl` (et non `dtefac`)
  et borne de fin `aaaammjj` sur des colonnes `datetime` (dernier jour exclu) ; documents matériel en
  cours (`Fiches_BlM`) non lus · tests : T01 · sources : [RelMoprod.class:187](../../../../.src/Statistiques/RelMoprod.class#L187), [RelMoprod.class:204](../../../../.src/Statistiques/RelMoprod.class#L204)
- [ ] RELMOPROD-A03 — [anomalie] Détail d'une facture historisée : la quantité formatée par
  `Utils.CDec` est écrite dans la colonne 2 puis écrasée (non formatée en colonne 3) ; `numfac` lu par
  `Right$(clé, 10)` suppose un numéro de 10 caractères (à confirmer) · tests : T06 · sources : [RelMoprod.class:580](../../../../.src/Statistiques/RelMoprod.class#L580), [RelMoprod.class:567](../../../../.src/Statistiques/RelMoprod.class#L567)
- [ ] RELMOPROD-A04 — [anomalie] `Catch` vides dans `Button1_Click`, `MajTab` et `Rlcli_click` : les
  erreurs SQL ou de lecture sont avalées sans message et le curseur reste en attente · tests : T03,
  T06 · sources : [RelMoprod.class:257](../../../../.src/Statistiques/RelMoprod.class#L257), [RelMoprod.class:327](../../../../.src/Statistiques/RelMoprod.class#L327), [RelMoprod.class:644](../../../../.src/Statistiques/RelMoprod.class#L644)
- [ ] RELMOPROD-A05 — [anomalie] `Utils.Observers(Me)` appelé deux fois dans `Form_Open` : observateurs
  probablement cumulés, événements journalisés en double (la correction change le journal de rejeu) ·
  tests : T01 · sources : [RelMoprod.class:50](../../../../.src/Statistiques/RelMoprod.class#L50), [RelMoprod.class:55](../../../../.src/Statistiques/RelMoprod.class#L55)
- [ ] RELMOPROD-A06 — [anomalie] Saisie client : un code tapé à la main dans `Code` n'est jamais
  contrôlé (`compteMan` jamais appelée) ; filtre `like "%<sel>%"` construit par concaténation (le collage
  contourne le filtre de touches `ChkInput`) · tests : T02, T08 · sources : [RelMoprod.class:Cmpt_KeyPress](../../../../.src/Statistiques/RelMoprod.class#L90-L113), [RelMoprod.class:809](../../../../.src/Statistiques/RelMoprod.class#L809), [RelMoprod.class:815](../../../../.src/Statistiques/RelMoprod.class#L815)
- [ ] RELMOPROD-A07 — [anomalie] Impression : en mode par produit, `Baspage` est émis avant le premier
  en-tête et le saut de page (`Controle`) n'appelle pas `Baspage` et repart à 30 mm (13 mm ailleurs) ;
  en mode par client, la ligne d'en-tête client ne déclenche pas de saut de page et `cli_nom` est lu
  sans test (client supprimé → erreur) · tests : T04, T05 · sources : [RelMoprod.class:421](../../../../.src/Statistiques/RelMoprod.class#L421), [RelMoprod.class:Controle](../../../../.src/Statistiques/RelMoprod.class#L478-L491), [RelMoprod.class:367](../../../../.src/Statistiques/RelMoprod.class#L367)
- [ ] RELMOPROD-A08 — [anomalie, sans effet visible] (relevée au lot Reports) l. 401 et 461 :
  `pdf.Footer()` est sans effet (`Cdocuments` ne surcharge pas `Footer`, `PdfWriter.Footer` est vide) :
  le pied de page attendu n'est jamais imprimé · tests : T01 · sources : [RelMoprod.class:401](../../../../.src/Statistiques/RelMoprod.class#L401), [RelMoprod.class:461](../../../../.src/Statistiques/RelMoprod.class#L461)
