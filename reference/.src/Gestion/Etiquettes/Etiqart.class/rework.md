# Etiqart — Rework

> Source : `.src/Gestion/Etiquettes/Etiqart.class` · Message de commit (phase 4) : `reference/.src/Gestion/Etiquettes/Etiqart.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 848 |
| Lignes de commentaire | 74 |
| Fonctions | 38 |
| Fonctions Public | 38 |
| Complexité cyclomatique totale | 197 |
| Complexité max (fonction) | 24 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 848 | 197 | 24 | 0 | 38 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] ETIQART-001 — [documentation] En-tête en français : rôle, deux modes (plage / liste), table
  de travail `Etiquettes`, imprimantes (A4, Dymo, Zebra inactive), écriture de `Bsel`/`Bval` par
  `TriArticles`, fichiers produits · appelants : aucun · tests : T01 · sources : [Etiqart.class:_new](../../../../../.src/Gestion/Etiquettes/Etiqart.class#L66-L78), [Etiqart.class:Form_Open](../../../../../.src/Gestion/Etiquettes/Etiqart.class#L80-L114)
- [ ] ETIQART-002 — [code mort] Supprimer `Art1_man` (jamais appelée), les membres jamais lus
  (`SorP`, `CoulZns`, `CoulZnaf`, `CoulFc`, variable `dte`), le `Shell "cd ~"` sans effet et la
  valeur initiale `"EtiqArt.ps"` de `Filename` · appelants : aucun · tests : T01-T11 · sources : [Etiqart.class:Art1_man](../../../../../.src/Gestion/Etiquettes/Etiqart.class#L698-L713), [Etiqart.class:790](../../../../../.src/Gestion/Etiquettes/Etiqart.class#L790), [Etiqart.class:Form_Open](../../../../../.src/Gestion/Etiquettes/Etiqart.class#L80-L114)
- [ ] ETIQART-003 — [commonalisation] Module `EtiqArticles` : listes famille / fournisseur
  (`ToggleButton3..6`, `Colfam*_KeyPress`, `Colfour*_KeyPress`, `Col*_Click`) ; handlers conservés
  `Public`, réduits à un appel ; mêmes requêtes · appelants : `Etigond` (ETIGOND-003),
  `Etiqcasier` (ETIQCASIER-003), même commit · tests : T01, T02 · sources : [Etiqart.class:ToggleButton3_Click](../../../../../.src/Gestion/Etiquettes/Etiqart.class#L181-L212), [Etiqart.class:ToggleButton6_Click](../../../../../.src/Gestion/Etiquettes/Etiqart.class#L364-L395), [Etiqart.class:Colfam_KeyPress](../../../../../.src/Gestion/Etiquettes/Etiqart.class#L217-L237), [Etiqart.class:Colfour2_Click](../../../../../.src/Gestion/Etiquettes/Etiqart.class#L464-L471)
- [ ] ETIQART-004 — [commonalisation] `EtiqArticles.RequeteArticles(tri, bornes…)` : les 5
  requêtes de sélection (seul l'`ORDER BY` change) et le contrôle de borne `Art_man`/`Art2_man` ;
  SQL émis identique · appelants : `Etigond` (ETIGOND-004), `Etiqcasier` (ETIQCASIER-004) · tests :
  T01, T02, T10 · sources : [Etiqart.class:Button2_Click](../../../../../.src/Gestion/Etiquettes/Etiqart.class#L758-L864), [Etiqart.class:Art2_man](../../../../../.src/Gestion/Etiquettes/Etiqart.class#L715-L734)
- [ ] ETIQART-005 — [commonalisation] Table de travail `Etiquettes` (création/suppression, ajout
  avec cumul/remplacement, grille) dans `EtiqArticles`, avec option `temporary` pour garder le
  comportement de chaque écran ; SQL identique · appelants : `Etigond`, `Etiqcasier`, `Eticli`
  (ETICLI-005) · tests : T05, T06, T09 · sources : [Etiqart.class:liste_Click](../../../../../.src/Gestion/Etiquettes/Etiqart.class#L597-L622), [Etiqart.class:Art_man](../../../../../.src/Gestion/Etiquettes/Etiqart.class#L639-L696), [Etiqart.class:Gridbart_Update](../../../../../.src/Gestion/Etiquettes/Etiqart.class#L1037-L1058), [Etiqart.class:Gridbart_Click](../../../../../.src/Gestion/Etiquettes/Etiqart.class#L1060-L1082)
- [ ] ETIQART-006 — [complexité] `Button2_Click` (CC 24) découpé en `ChargeFormat`, `OuvrePdf`,
  `SauteEtiquettes`, boucle d'impression ; comportement et ordre des requêtes inchangés ·
  appelants : aucun · tests : T01-T09 · sources : [Etiqart.class:Button2_Click](../../../../../.src/Gestion/Etiquettes/Etiqart.class#L758-L864)
- [ ] ETIQART-007 — [séparation traitement/GUI] `Imprime` : lecture de l'article et calcul du
  nombre d'étiquettes (`NombreEtiquettes`, pur) séparés du dessin ; `Art_man` : ajout en table sans
  `Message` (`ListeAjoute` renvoie « doublon »), la question reste dans l'écran · appelants : aucun
  · tests : T04, T05 · sources : [Etiqart.class:Imprime](../../../../../.src/Gestion/Etiquettes/Etiqart.class#L881-L955), [Etiqart.class:Art_man](../../../../../.src/Gestion/Etiquettes/Etiqart.class#L639-L696)
- [ ] ETIQART-008 — [réduction de portée] `init_ComboBox`, `SelectionArt`, `Art_man`, `Art2_man`,
  `ChkInput`, `Button2_Click`, `fin_impression`, `Imprime`, `pos_Etiq`, `pos_Etiq2`,
  `Import_Portable`, `Gridbart_Update` → `Private` · appelants : aucun · tests : T01-T11 · sources : [Etiqart.class:init_ComboBox](../../../../../.src/Gestion/Etiquettes/Etiqart.class#L116-L133), [Etiqart.class:SelectionArt](../../../../../.src/Gestion/Etiquettes/Etiqart.class#L150-L176), [Etiqart.class:pos_Etiq2](../../../../../.src/Gestion/Etiquettes/Etiqart.class#L981-L990), [Etiqart.class:Import_Portable](../../../../../.src/Gestion/Etiquettes/Etiqart.class#L1016-L1029), [Etiqart.class:Gridbart_Update](../../../../../.src/Gestion/Etiquettes/Etiqart.class#L1037-L1058)
- [ ] ETIQART-009 — [complexité] `Cbase.Table("TabEtiq")` à la place du littéral
  `Fiches_Etiquettes` (SQL émis identique) · appelants : aucun · tests : T01 · sources : [Etiqart.class:init_ComboBox](../../../../../.src/Gestion/Etiquettes/Etiqart.class#L116-L133), [Etiqart.class:776](../../../../../.src/Gestion/Etiquettes/Etiqart.class#L776)
- [ ] ETIQART-010 — [commonalisation] Socle `PlancheEtiquettes` (modèles, chargement du format,
  ouverture du PDF A4/Dymo, `pos_Etiq` variante V1, `pos_Etiq2`, sortie) ; PDF identique ·
  appelants : `FClient` (FCLIENT-014), `FFournisseur` (FFOURNISSEUR-013), puis Etigond, Etiqcasier,
  Eticli, EtiqRecpt, EtiqPromo, Etiqfbtarif (leurs cases « PlancheEtiquettes ») · tests : T01, T03,
  T07, T12 · sources : [Etiqart.class:pos_Etiq](../../../../../.src/Gestion/Etiquettes/Etiqart.class#L957-L979), [Etiqart.class:pos_Etiq2](../../../../../.src/Gestion/Etiquettes/Etiqart.class#L981-L990), [Etiqart.class:fin_impression](../../../../../.src/Gestion/Etiquettes/Etiqart.class#L866-L878), [Etiqart.class:Button2_Click](../../../../../.src/Gestion/Etiquettes/Etiqart.class#L758-L864), [FClient.class:pos_Etiq](../../../../../.src/Gestion/Tables/FClient.class#L2572-L2601)
- [ ] ETIQART-011 — [complexité] Un seul `Utils.Observers(Me)` dans `Form_Open` (le second crée
  des observateurs en double ; dump inchangé, log de rejeu sans doublons) · appelants : aucun ·
  tests : T01-T11 (références de log à régénérer) · sources : [Etiqart.class:93](../../../../../.src/Gestion/Etiquettes/Etiqart.class#L93), [Etiqart.class:97](../../../../../.src/Gestion/Etiquettes/Etiqart.class#L97)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] ETIQART-A01 — [anomalie] Imprimante Zebra : aucun PDF n'est créé, `pdf.Open()` s'exécute sur
  `Null` (« Null object ») à la première impression ; `Connect` (code mort) et `IpZebra` jamais
  renseigné rendent la branche ZPL inatteignable. Décision commune ZEBRA-A01 (brancher ou
  supprimer `Connect` et la branche) · tests : T08 · sources : [Etiqart.class:804](../../../../../.src/Gestion/Etiquettes/Etiqart.class#L804), [Etiqart.class:Connect](../../../../../.src/Gestion/Etiquettes/Etiqart.class#L992-L1011), [Etiqart.class:948](../../../../../.src/Gestion/Etiquettes/Etiqart.class#L948)
- [ ] ETIQART-A02 — [anomalie] Import portable : `Button2_Click` remplace `Filename` par le PDF,
  l'éditeur ouvre donc le PDF et non `~/tmp/ImpT.txt` (rapport des rejets jamais affiché) ;
  `Portable.cpt2` cumulatif entre deux imports · tests : T09 · sources : [Etiqart.class:1019](../../../../../.src/Gestion/Etiquettes/Etiqart.class#L1019), [Etiqart.class:1023](../../../../../.src/Gestion/Etiquettes/Etiqart.class#L1023), [Etiqart.class:791](../../../../../.src/Gestion/Etiquettes/Etiqart.class#L791)
- [ ] ETIQART-A03 — [anomalie] Mode liste : un code de la liste absent de `Fiches_Art` (article
  supprimé, orphelin) donne un résultat vide et une erreur à la lecture `rarts!art_code` dans
  `Imprime` ; le `Try` ne protège que l'`Exec` · tests : T11 · sources : [Etiqart.class:841](../../../../../.src/Gestion/Etiquettes/Etiqart.class#L841), [Etiqart.class:903](../../../../../.src/Gestion/Etiquettes/Etiqart.class#L903)
- [ ] ETIQART-A04 — [anomalie] Table de travail `Etiquettes` créée **permanente** (`CREATE TABLE`)
  alors que `Etigond`/`Eticli` la créent `temporary` : partagée entre postes (deux utilisateurs
  écrasent leur liste), persistante en base, absente de `db_control.csv` ; elle est vidée à chaque
  fin d'impression · tests : T05 · sources : [Etiqart.class:616](../../../../../.src/Gestion/Etiquettes/Etiqart.class#L616), [Etiqart.class:fin_impression](../../../../../.src/Gestion/Etiquettes/Etiqart.class#L866-L878)
- [ ] ETIQART-A05 — [anomalie] `EtiqStk` : stock fractionnaire tronqué, stock < 1 → nombre saisi
  `Nbtiq` (masqué à l'écran) au lieu de 0, article non stocké → aucune étiquette (à confirmer
  avec l'utilisateur) · tests : T04 · sources : [Etiqart.class:912](../../../../../.src/Gestion/Etiquettes/Etiqart.class#L912), [Etiqart.class:914](../../../../../.src/Gestion/Etiquettes/Etiqart.class#L914)
- [ ] ETIQART-A06 — [anomalie] Format introuvable ou libellé sans parenthèse : `PageA` reste `Null`
  (erreur sur `PageA[1]`) ou `Scan(…)[1]` échoue ; en Dymo, les positions sautées (`Posetiq`) sont
  calculées avec `pos_Etiq` (A4) puis `pos_Etiq2` ouvre une page blanche · tests : T03, T07 · sources : [Etiqart.class:776](../../../../../.src/Gestion/Etiquettes/Etiqart.class#L776), [Etiqart.class:793](../../../../../.src/Gestion/Etiquettes/Etiqart.class#L793), [Etiqart.class:830](../../../../../.src/Gestion/Etiquettes/Etiqart.class#L830)
