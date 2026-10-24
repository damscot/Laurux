# Achat — Rework

> Source : `.src/Gestion/Entrées/Achat.class` · Message de commit (phase 4) : `reference/.src/Gestion/Entrées/Achat.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 1463 |
| Lignes de commentaire | 24 |
| Fonctions | 58 |
| Fonctions Public | 44 |
| Complexité cyclomatique totale | 293 |
| Complexité max (fonction) | 19 (`Import`) |
| Variables globales | 0 |
| Variables Public | 8 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 1463 | 293 | 19 | 0 | 44 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

Module complexe : reworks minimaux et ciblés ; la liste des scénarios (test.md) doit être validée
par l'utilisateur avant la phase 2.

- [ ] ACHAT-001 — [documentation] En-tête de classe en français : rôle (grille d'achat héritée de
  `SaiTableau`, sans `.form`), énumérations d'état et d'index `AutresObj`, liste des handlers
  dynamiques (`Object.Attach` de `SaiTableau.evenement`) à ne jamais renommer ni passer en
  `Private`, sens inversé de `IgnoreTarif`, transaction validée par `EnrAch` · appelants : aucun ·
  tests : aucun · sources : [Achat.class:_new](../../../../../.src/Gestion/Entrées/Achat.class#L50-L170), [Achat.class:Code_lostfocus](../../../../../.src/Gestion/Entrées/Achat.class#L244-L253), [Achat.class:EnrAch](../../../../../.src/Gestion/Entrées/Achat.class#L839-L923)
- [ ] ACHAT-002 — [code mort] Supprimer `$Mat` (jamais relu), le membre `OptAr` (jamais affecté) et
  `Try OptAr.Delete`, `Shell "cd " & User.Home` et `With utils` dans `Import`, l'affectation
  `prx.Qte = Pal` écrasée par `calcul` dans `qte_lostfocus`, et les 4 affectations en double de
  `valider_click` (`mat_dfour`, `mat_dpa`, `mat_cequ`, `mat_eco`) · appelants : aucun (`OptAr` sans
  usage externe, vérifié par `grep -rn`) · tests : T01, T08, T10, T11 · sources : [Achat.class:62](../../../../../.src/Gestion/Entrées/Achat.class#L62), [Achat.class:13](../../../../../.src/Gestion/Entrées/Achat.class#L13), [Achat.class:497](../../../../../.src/Gestion/Entrées/Achat.class#L497), [Achat.class:707](../../../../../.src/Gestion/Entrées/Achat.class#L707), [Achat.class:288](../../../../../.src/Gestion/Entrées/Achat.class#L288), [Achat.class:1558](../../../../../.src/Gestion/Entrées/Achat.class#L1558), [Achat.class:1561](../../../../../.src/Gestion/Entrées/Achat.class#L1561), [Achat.class:1566](../../../../../.src/Gestion/Entrées/Achat.class#L1566), [Achat.class:1568](../../../../../.src/Gestion/Entrées/Achat.class#L1568)
- [ ] ACHAT-003 — [complexité] `imprime` : helper privé `Cellule(conteneur, texte, police,
  largeur, alignement, bordure) As ReportLabel` pour la vingtaine de blocs `ReportLabel`
  identiques ; même `Report` (vérifié par le texte du PDF) · appelants : `commande1` (inchangé) ·
  tests : T13 · sources : [Achat.class:imprime](../../../../../.src/Gestion/Entrées/Achat.class#L1017-L1251)
- [ ] ACHAT-004 — [complexité] `calcul` : helper privé `RemiseDepuisTexte(txt) As LTaxe` pour les
  quatre branches de remise (même `LTaxe` construite) · appelants : aucun · tests : T01, T05, T14 ·
  sources : [Achat.class:calcul](../../../../../.src/Gestion/Entrées/Achat.class#L359-L391)
- [ ] ACHAT-005 — [complexité] `Doublon` : détection par `Collection` indexée par code au lieu de
  la double boucle O(n²), même liste et même ordre d'affichage · appelants : `commande1` (inchangé) ·
  tests : T12 · sources : [Achat.class:Doublon](../../../../../.src/Gestion/Entrées/Achat.class#L504-L555)
- [ ] ACHAT-006 — [réarchitecture] `Cbase.Table(…)` pour les tables qui ont une clé (`TabArt`,
  `TabTvav`, `TabEntcom`, `TabLigcom`, `TabEntrecpt`, `TabLigrecpt`, `TabMat`, `TabFour`,
  `TabMailFour`, `TabContactF`) ; SQL émis identique · appelants : aucun · tests : T01-T13 ·
  sources : [Achat.class:LitCommande](../../../../../.src/Gestion/Entrées/Achat.class#L564-L639), [Achat.class:SupAchat](../../../../../.src/Gestion/Entrées/Achat.class#L772-L836), [Achat.class:EnrAch](../../../../../.src/Gestion/Entrées/Achat.class#L839-L923), [Achat.class:imprime](../../../../../.src/Gestion/Entrées/Achat.class#L1017-L1251), [Achat.class:mail](../../../../../.src/Gestion/Entrées/Achat.class#L1297-L1352)
- [ ] ACHAT-007 — [complexité] `generer` : quantité déjà commandée lue par une seule requête
  `SELECT code, SUM(qte) … GROUP BY code` au lieu d'une requête par article (SQL modifié, dump
  identique) · appelants : `commande1` (inchangé) · tests : T02 · sources : [Achat.class:generer](../../../../../.src/Gestion/Entrées/Achat.class#L641-L681)
- [ ] ACHAT-008 — [séparation traitement/GUI] `EnrRec` : lecture des contrôles de la ligne dans
  une structure (`ValeursLigne(sl)`), écriture du `Result` sans accès aux contrôles ; `generer` :
  calcul des quantités à commander dans une fonction pure (code → quantité) · appelants : aucun ·
  tests : T01, T02, T05, T10 · sources : [Achat.class:EnrRec](../../../../../.src/Gestion/Entrées/Achat.class#L925-L981), [Achat.class:generer](../../../../../.src/Gestion/Entrées/Achat.class#L641-L681)
- [ ] ACHAT-009 — [commonalisation] Helper privé `FenetreModale(titre, hauteur, largeur)` +
  bouton « Ok » à `Tag` = fenêtre, pour `Doublon`, `ChoixCode`, `mail` et `CreFen` (mêmes
  contrôles créés) · appelants : aucun · tests : T08, T12, T13 · sources : [Achat.class:Doublon](../../../../../.src/Gestion/Entrées/Achat.class#L504-L555), [Achat.class:ChoixCode](../../../../../.src/Gestion/Entrées/Achat.class#L1253-L1289), [Achat.class:mail](../../../../../.src/Gestion/Entrées/Achat.class#L1297-L1352), [Achat.class:CreFen](../../../../../.src/Gestion/Entrées/Achat.class#L1582-L1617)
- [ ] ACHAT-010 — [réduction de portée] `ligne_LecCode`, `mat`, `rec` → `Private` (appels internes
  seulement, vérifié par `grep -rn`) ; les handlers dynamiques et `Bsel`/`Bval` restent `Public` ·
  appelants : aucun · tests : T01-T12 · sources : [Achat.class:ligne_LecCode](../../../../../.src/Gestion/Entrées/Achat.class#L172-L236), [Achat.class:14](../../../../../.src/Gestion/Entrées/Achat.class#L14), [Achat.class:15](../../../../../.src/Gestion/Entrées/Achat.class#L15)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] ACHAT-A01 — [anomalie] `SupAchat` : `IsNull(matvendu)` est toujours faux pour un tableau créé
  par `New` (vérifié avec `gbs3`) → toute réception qui a des matériels déclenche
  `Error.Raise` avec une liste vide, suppression refusée et rollback. Correction :
  `matvendu.Count = 0` · tests : T08 · sources : [Achat.class:799](../../../../../.src/Gestion/Entrées/Achat.class#L799), [Achat.class:802](../../../../../.src/Gestion/Entrées/Achat.class#L802)
- [ ] ACHAT-A02 — [anomalie] `LitCommande` : `pg.Close` sans test alors que `pg` n'est créée que
  si le résultat est disponible → document sans ligne : erreur « objet nul » · tests : T03 ·
  sources : [Achat.class:587](../../../../../.src/Gestion/Entrées/Achat.class#L587), [Achat.class:637](../../../../../.src/Gestion/Entrées/Achat.class#L637)
- [ ] ACHAT-A03 — [anomalie] `valider_click` : le contrôle d'unicité des numéros de série lit
  `mat.ligne[mat.ind]` au lieu de la ligne parcourue `lig` → seul le numéro de la ligne qui a le
  focus est contrôlé · tests : T09 · sources : [Achat.class:1520](../../../../../.src/Gestion/Entrées/Achat.class#L1520), [Achat.class:1522](../../../../../.src/Gestion/Entrées/Achat.class#L1522)
- [ ] ACHAT-A04 — [anomalie] `Import` : `Code` n'est pas réinitialisé entre deux enregistrements
  (un code-barre vide reprend le code précédent) et les enregistrements rejetés sont quand même
  ajoutés à la grille et comptés comme importés · tests : T11 · sources : [Achat.class:733](../../../../../.src/Gestion/Entrées/Achat.class#L733), [Achat.class:738](../../../../../.src/Gestion/Entrées/Achat.class#L738), [Achat.class:747](../../../../../.src/Gestion/Entrées/Achat.class#L747)
- [ ] ACHAT-A05 — [anomalie] `EnrRec` : remise saisie sans `%` → division par `Px_Brut` (nulle
  possible), erreur et rollback de tout le document · tests : T14 · sources : [Achat.class:940](../../../../../.src/Gestion/Entrées/Achat.class#L940)
- [ ] ACHAT-A06 — [anomalie] `ligne_LecCode` : le test `NomControl = "art_frais"` ne correspond à
  aucun contrôle (colonne `Frais`) → les frais sont affichés avec `art_nbd` décimales au lieu de 2 ·
  tests : T05 · sources : [Achat.class:198](../../../../../.src/Gestion/Entrées/Achat.class#L198)
- [ ] ACHAT-A07 — [anomalie] `mail` : l'adresse d'un contact (`nom pnm | mail`) est retenue avec
  l'espace qui suit le `|` ; un seul contact de `Fiches_ContactF` est proposé (à confirmer) ·
  tests : aucun (envoi manuel) · sources : [Achat.class:1334](../../../../../.src/Gestion/Entrées/Achat.class#L1334), [Achat.class:1347](../../../../../.src/Gestion/Entrées/Achat.class#L1347)
- [ ] ACHAT-A08 — [anomalie] Reliquats : `commande1.annul_Click` appelle `tbl.Delete` (donc
  `rec.Delete`) **avant** `CreReliquat`, qui parcourt `rec` : la commande de reliquat serait
  vide si `rec.Delete` aboutit (à confirmer par T04 : `Try` sur des contrôles déjà détruits) ·
  tests : T04 · sources : [Achat.class:499](../../../../../.src/Gestion/Entrées/Achat.class#L499), [Achat.class:CreReliquat](../../../../../.src/Gestion/Entrées/Achat.class#L1725-L1741), [commande1.class:828](../../../../../.src/Gestion/Stock/commande1.class#L828)
- [ ] ACHAT-A09 — [anomalie] `EnrRec` : `Fiches_ligregie.numlig = Format(sl.Ind, "000")` alors que
  `Fiches_Ligrecpt.nligne` et `Fiches_ligcons.numlig` utilisent `Ind + 1` (à confirmer avec les
  lecteurs de `Fiches_ligregie`) · tests : T10 · sources : [Achat.class:962](../../../../../.src/Gestion/Entrées/Achat.class#L962), [Achat.class:948](../../../../../.src/Gestion/Entrées/Achat.class#L948)
- [ ] ACHAT-A10 — [anomalie] `verifdrt` lit `art_dra` sans tester `Available` (article supprimé
  depuis la réception → erreur et rollback de la suppression) · tests : T07 · sources : [Achat.class:1008](../../../../../.src/Gestion/Entrées/Achat.class#L1008), [Achat.class:1009](../../../../../.src/Gestion/Entrées/Achat.class#L1009)
- [ ] ACHAT-A11 — [anomalie] Textes : message « Aricle innexitant » et polices `"Serif,Blod,…"`
  (jamais en gras) dans `imprime` · tests : T13 · sources : [Achat.class:230](../../../../../.src/Gestion/Entrées/Achat.class#L230), [Achat.class:1045](../../../../../.src/Gestion/Entrées/Achat.class#L1045), [Achat.class:1078](../../../../../.src/Gestion/Entrées/Achat.class#L1078)
- [ ] ACHAT-A12 — [anomalie, à confirmer] (ajoutée après le lot Gestion-2, voir CALCULDROIT1-A04) l. 967 :
  `res!volume = cdd.volume_total().TotBHT.G * res!qte` alors que `volume_total()` intègre probablement
  déjà la quantité : volume de régie multiplié deux fois par la quantité dans `Fiches_ligregie` ;
  à confirmer par un replay de réception de boissons (jeu `option_boisson`) · tests : à ajouter · sources : [Achat.class:967](../../../../../.src/Gestion/Entrées/Achat.class#L967), [calculdroit1.class:volume_total](../../../../../.src/Gestion/option/calculdroit1.class#L72-L82)
