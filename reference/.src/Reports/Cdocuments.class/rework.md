# Cdocuments — Rework

> Source : `.src/Reports/Cdocuments.class` · Message de commit (phase 4) : `reference/.src/Reports/Cdocuments.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 986 |
| Lignes de commentaire | 76 |
| Fonctions | 72 |
| Fonctions Public | 72 |
| Complexité cyclomatique totale | 212 |
| Complexité max (fonction) | 23 (`Entete`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 986 | 212 | 23 | 0 | 72 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CDOCUMENTS-001 — [documentation] En-tête de classe en français : rôle (gabarits PDF sans
  SQL), construction (`New Cdocuments(orientation, unité, format)` → `PdfWriter._new`), séquence
  `Open`/`AliasNbPages`/…/`Output`, tableau « famille de méthodes → document → appelant »,
  convention `PosY` et sauts de page gérés par l'appelant ; commentaire `'''` sur chaque méthode
  conservée · appelants : aucun · tests : T01-T12 · sources : [Cdocuments.class:_new](../../../../.src/Reports/Cdocuments.class#L12-L26), [Cdocuments.class:Entete](../../../../.src/Reports/Cdocuments.class#L96-L196)
- [ ] CDOCUMENTS-002 — [code mort] Supprimer les 21 méthodes sans aucun appelant (`EnteteV`,
  `Level4V`, `Entete3`, `Logo2`, `Level1bis`, `Level3bis`, `Level4RB`, `Level1LV`, `Level1DP`,
  `Level2FAC`, `Level2Fa`, `Level3FAC`, `Level10F2`, `Level10F3`, `LevelM`, `Level2M`,
  `Level14F`, `Level15F`, `Level16F`, `EnteteD`, `Level1RL`), puis `Signature` et `SignatureD`
  (appelées seulement par `Level14F`/`Level16F`) et le `_free` commenté (≈ 300 lignes) ·
  appelants : aucun (vérifié par `grep -rni` ; homonymes de `Cfacture`, `Cstocks`, `Ccompta`,
  `Prefs` non concernés) · tests : T01-T12 + `gbc3 -agt` · sources : [Cdocuments.class:EnteteV](../../../../.src/Reports/Cdocuments.class#L54-L58), [Cdocuments.class:Entete3](../../../../.src/Reports/Cdocuments.class#L232-L266), [Cdocuments.class:Logo2](../../../../.src/Reports/Cdocuments.class#L283-L296), [Cdocuments.class:Level2FAC](../../../../.src/Reports/Cdocuments.class#L565-L623), [Cdocuments.class:Level3FAC](../../../../.src/Reports/Cdocuments.class#L666-L692), [Cdocuments.class:LevelM](../../../../.src/Reports/Cdocuments.class#L946-L970), [Cdocuments.class:Level14F](../../../../.src/Reports/Cdocuments.class#L982-L992), [Cdocuments.class:Signature](../../../../.src/Reports/Cdocuments.class#L995-L1006), [Cdocuments.class:Level16F](../../../../.src/Reports/Cdocuments.class#L1031-L1040), [Cdocuments.class:SignatureD](../../../../.src/Reports/Cdocuments.class#L1043-L1054), [Cdocuments.class:EnteteD](../../../../.src/Reports/Cdocuments.class#L1123-L1131), [Cdocuments.class:Level1RL](../../../../.src/Reports/Cdocuments.class#L1253-L1260)
- [ ] CDOCUMENTS-003 — [code mort] **Après décision FACTURERGBL-A01 (option suppression)** :
  supprimer la famille facture sans appelant atteignable (`Level1F`, `Level2F`, `Level3F`,
  `Level4F`, `Level4aF`, `Level4bF`, `Level5F`, `Level6F`, `Level8F`, `Level12F`, `Level13F`,
  `Colonnes`, variable `Coln`) ; `Level7F`, `Level9F`, `Level10F`, `Level11F` restent (utilisées
  par `Edbr`) · appelants : `Facturergbl` (code supprimé par FACTURERGBL-A01 dans le même
  commit) · tests : T04, T07 · sources : [Cdocuments.class:Level1F](../../../../.src/Reports/Cdocuments.class#L472-L485), [Cdocuments.class:Level2F](../../../../.src/Reports/Cdocuments.class#L507-L562), [Cdocuments.class:Level3F](../../../../.src/Reports/Cdocuments.class#L638-L663), [Cdocuments.class:Colonnes](../../../../.src/Reports/Cdocuments.class#L694-L721), [Cdocuments.class:Level6F](../../../../.src/Reports/Cdocuments.class#L764-L787), [Cdocuments.class:Level13F](../../../../.src/Reports/Cdocuments.class#L931-L943), [Facturergbl.class:Button14_Click](../../../../.src/Gestion/Facturation/Facturergbl.class#L470-L992)
- [ ] CDOCUMENTS-004 — [réduction de portée] `Logo`, `Logo3`, `Colonnes` → `Private` (appelés
  seulement par `Entete` et les lignes de facture ; couverts par T01, T02, T04) · appelants :
  aucun · tests : T01, T02, T04 · sources : [Cdocuments.class:Logo](../../../../.src/Reports/Cdocuments.class#L298-L319), [Cdocuments.class:Logo3](../../../../.src/Reports/Cdocuments.class#L268-L281), [Cdocuments.class:Colonnes](../../../../.src/Reports/Cdocuments.class#L694-L721)
- [ ] CDOCUMENTS-005 — [commonalisation] Socle PDF commun `PdfLaurux` (`Inherits PdfWriter`,
  PDFWRITER-011) :
  couleurs du thème (`_new`, identique à `Cdocuments3`), `BasPage`/`BasPageP`, `EnteteN`,
  `EnteteP`, `Lines` ; `Cdocuments` et `Cdocuments3` en héritent (puis `Creleve`, `Ctraites`,
  `Clivre`… dans leurs propres reworks). Vérifier au préalable avec `gbc3`/`gbx3` que les
  arguments de `New Cdocuments("Portrait", "mm", "A4")` atteignent toujours `PdfWriter._new` à
  travers une classe intermédiaire sans paramètre (à confirmer) · appelants : aucun (API
  inchangée) · tests : T01, T05-T12, CDOCUMENTS3-T01 · sources : [Cdocuments.class:_new](../../../../.src/Reports/Cdocuments.class#L12-L26), [Cdocuments.class:BasPage](../../../../.src/Reports/Cdocuments.class#L1202-L1208), [Cdocuments.class:EnteteN](../../../../.src/Reports/Cdocuments.class#L33-L41), [Cdocuments3.class:_new](../../../../.src/Reports/Cdocuments3.class#L12-L26), [Cdocuments3.class:BasPage](../../../../.src/Reports/Cdocuments3.class#L206-L212)
- [ ] CDOCUMENTS-006 — [réarchitecture] Structure de paramètres pour l'en-tête société : objet
  valeur `LEnteteSoc` (raison sociale, `Libre`, adresse, `Lignes As String[]` dans l'ordre
  d'impression, `Iban`) + fabrique `LEnteteSoc.Lit(sCodeSoc)` (`SELECT … FROM
  Cbase.Table("TabSoc") WHERE cd_sc = &1`, libellés par défaut, ligne remplaçable par l'appelant)
  + méthode `EnteteSoc(soc, Optional Col)`. Étape 1 : `Entete` devient un adaptateur qui construit
  un `LEnteteSoc` (aucun appelant modifié, sortie identique). Étape 2 : migration d'`Edcom`
  (EDCOM-005) et de `Facturergbl` (si conservé). `RelvMo` est migré dans le commit de
  CDOCUMENTS-A01/RELVMO-A01 ; `Entete` est supprimée quand il ne reste aucun appelant · appelants :
  `Edcom`, `Facturergbl`, `RelvMo` · tests : T01-T03, T05, T06 · sources : [Cdocuments.class:Entete](../../../../.src/Reports/Cdocuments.class#L96-L196), [Edcom.class:211](../../../../.src/Gestion/Impressions/Edcom.class#L211), [RelvMo.class:376](../../../../.src/Statistiques/RelvMo.class#L376), [Facturergbl.class:587](../../../../.src/Gestion/Facturation/Facturergbl.class#L587)
- [ ] CDOCUMENTS-007 — [complexité] `Entete` (CC 23) : boucle sur les lignes optionnelles
  `[cap, rcs, siret, ape, tvaintra, tel, portable, fax, site, mail]` (pas de 5 mm, ordre actuel
  conservé, `site` avant `mail`), `iban` en italique, choix des logos dans un helper privé ;
  suppression du `SetXY(6, PosY)` sans effet (ligne 124) ; CC visée ≤ 8 · appelants : aucun ·
  tests : T01, T02 · sources : [Cdocuments.class:Entete](../../../../.src/Reports/Cdocuments.class#L96-L196), [Cdocuments.class:124](../../../../.src/Reports/Cdocuments.class#L124)
- [ ] CDOCUMENTS-008 — [complexité] `Level2F` (CC 18) : suffixe de libellé (`" TTC"`, `" HT"`,
  `""`) et présence de la remise calculés une fois, puis mêmes cellules ; table de décision
  actuelle conservée (cas `Or If` compris) ; à faire seulement si CDOCUMENTS-003 n'est pas retenue
  · appelants : aucun · tests : T04 · sources : [Cdocuments.class:Level2F](../../../../.src/Reports/Cdocuments.class#L507-L562)
- [ ] CDOCUMENTS-009 — [commonalisation] Helpers privés paramétrés : `LigneTexte(texte, PosY,
  style)` pour `Level4F`/`Level4aF`, `CadreTotal(libellé, total, PosY)` pour `Level4`/`Level4D`,
  `Trait(PosY, largeur)` pour `Lines`/`LinesLG`/`LinesP` ; méthodes `Public` conservées comme
  façades · appelants : aucun · tests : T12 · sources : [Cdocuments.class:Level4F](../../../../.src/Reports/Cdocuments.class#L724-L731), [Cdocuments.class:Level4aF](../../../../.src/Reports/Cdocuments.class#L734-L741), [Cdocuments.class:Level4](../../../../.src/Reports/Cdocuments.class#L450-L458), [Cdocuments.class:Level4D](../../../../.src/Reports/Cdocuments.class#L461-L469), [Cdocuments.class:LinesLG](../../../../.src/Reports/Cdocuments.class#L79-L85), [Cdocuments.class:LinesP](../../../../.src/Reports/Cdocuments.class#L88-L94)
- [ ] CDOCUMENTS-010 — [complexité] Supprimer les paramètres inutilisés : `Visudoc`, `Pays`
  d'`Entete` (avec ou après 006), `Col` d'`Entete2`, `Coulfond` de `Level7F`, `Mttc` de
  `Level9F`, `TypeD` de `Level2D` (et `Page`, `Coulfond` de `Level1F`/`Level2F` si 003 n'est pas
  retenue) · appelants : `Edcom`, `RelvMo`, `Edbr`, `EdDocs`, `EdPrep`, `Facturergbl` (même
  commit) · tests : T05-T09 · sources : [Cdocuments.class:Entete2](../../../../.src/Reports/Cdocuments.class#L199-L229), [Cdocuments.class:Level7F](../../../../.src/Reports/Cdocuments.class#L790-L812), [Cdocuments.class:Level9F](../../../../.src/Reports/Cdocuments.class#L827-L836), [Cdocuments.class:Level2D](../../../../.src/Reports/Cdocuments.class#L1161-L1180), [Edbr.module:Calc_tva](../../../../.src/Gestion/Impressions/Edbr.module#L23-L109), [EdDocs.class:143](../../../../.src/Gestion/Impressions/EdDocs.class#L143)
- [ ] CDOCUMENTS-011 — [séparation traitement/GUI] Fonction privée `SansTva() As Boolean`
  (lecture de `/AutoEnt` et `/Franchise`) utilisée par `Level2F`, `Level3F` et `Level10F` ;
  mêmes valeurs lues au même moment · appelants : aucun · tests : T04 · sources : [Cdocuments.class:Level3F](../../../../.src/Reports/Cdocuments.class#L638-L663), [Cdocuments.class:Level10F](../../../../.src/Reports/Cdocuments.class#L839-L886)
- [ ] CDOCUMENTS-012 — [code mort] Branches `Variables.EnvoiMail = "Mail"` (logos `glogo5`/
  `glogo6`) et `Variables.TypeL = "B"` : supprimées par VARIABLES-003 après réponse à
  VARIABLES-A02, dans le même commit · appelants : `Variables` · tests : T01, T02, T04 · sources : [Cdocuments.class:113](../../../../.src/Reports/Cdocuments.class#L113), [Cdocuments.class:Logo3](../../../../.src/Reports/Cdocuments.class#L268-L281), [Cdocuments.class:Level3F](../../../../.src/Reports/Cdocuments.class#L638-L663)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] CDOCUMENTS-A01 — [anomalie] Signatures sans paramètre `Optional` appelées avec un argument
  de moins : `RelvMo:427` passe 18 arguments à `Entete` (19 attendus, `Libre` absent) →
  « Not enough arguments » au premier saut de page, aucun PDF pour un client de plus d'une page
  (= RELVMO-A01) ; `Facturergbl:948/953/960` passent 5 arguments à `Level6F` (6 attendus,
  `frais` absent), dans du code inatteignable (= FACTURERGBL-A01). Correction proposée : passer
  `Libre` dans `RelvMo` (ou migrer `RelvMo` vers `EnteteSoc`, CDOCUMENTS-006) ; ne pas rendre
  `Libre` `Optional` (masquerait d'autres oublis) · tests : T03, T06 · sources : [RelvMo.class:427](../../../../.src/Statistiques/RelvMo.class#L427), [Cdocuments.class:Entete](../../../../.src/Reports/Cdocuments.class#L96-L196), [Facturergbl.class:948](../../../../.src/Gestion/Facturation/Facturergbl.class#L948), [Facturergbl.class:953](../../../../.src/Gestion/Facturation/Facturergbl.class#L953), [Facturergbl.class:960](../../../../.src/Gestion/Facturation/Facturergbl.class#L960), [Cdocuments.class:Level6F](../../../../.src/Reports/Cdocuments.class#L764-L787)
- [ ] CDOCUMENTS-A02 — [anomalie] `Logo` : pour un logo de moins de 10 pixels de large,
  `L2 = largeur / 10` vaut 0 et `L / L2` lève « Division by zero » hors du `Try` (vérifié avec
  `gbs3`) : l'édition s'arrête. La taille imprimée (pixels / 5 mm) déforme aussi les grands logos.
  Correction proposée : protéger la division (position par défaut) ; la mise à l'échelle reste à
  décider avec l'utilisateur · tests : T02 · sources : [Cdocuments.class:311](../../../../.src/Reports/Cdocuments.class#L311), [Cdocuments.class:314](../../../../.src/Reports/Cdocuments.class#L314)
