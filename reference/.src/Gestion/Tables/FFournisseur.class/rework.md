# FFournisseur — Rework

> Source : `.src/Gestion/Tables/FFournisseur.class` · Message de commit (phase 4) : `reference/.src/Gestion/Tables/FFournisseur.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 2156 |
| Lignes de commentaire | 90 |
| Fonctions | 132 |
| Fonctions Public | 131 |
| Complexité cyclomatique totale | 545 |
| Complexité max (fonction) | 35 (`Cmpt_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 4 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 2156 | 545 | 35 | 0 | 131 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

Gros écran legacy (2156 LOC) : reworks minimaux et ciblés ; aucun `.form`, nom de contrôle ou nom
de handler n'est modifié. FFOURNISSEUR-010 à 013 sont menées **dans le même commit** que FCLIENT-011
à 014 (socle commun `FicheTiers`).

- [ ] FFOURNISSEUR-001 — [documentation] En-tête en français : rôle, onglets, dispatch `Btn` par
  `Tag` (fonctions `Button14_Click`/`Button15_Click` appelées pour les contrôles `Button15`/`Button13`),
  pseudo-handlers (`Compt_GotFocus`/`Compt_LostFocus`, `C1_Click`…), drapeaux partagés `Enr` et `b`,
  instance créée par `Facture` (F11) · appelants : aucun · tests : aucun · sources : [FFournisseur.class:_New](../../../../../.src/Gestion/Tables/FFournisseur.class#L72-L119), [FFournisseur.class:Btn_Click](../../../../../.src/Gestion/Tables/FFournisseur.class#L1001-L1033), [FFournisseur.class:Compt_LostFocus](../../../../../.src/Gestion/Tables/FFournisseur.class#L1163-L1168)
- [ ] FFOURNISSEUR-002 — [code mort] Supprimer `Tabfour3_click`, `colfo_Click`, `colfo_Activate` (pas
  de contrôle `Tabfour3` ni `colfo`), `Button6_Keypress` (jamais levé : `Button6` est dans le groupe
  `Vnt`) et `Button6_Click` (seul appelant : `Button6_Keypress`), `Maj_vtl`, `FileFilter`,
  `HBox1_MouseDown` (handler vide ; l'enregistrement `MouseDown` de `ReplayObserver` est commenté),
  les membres `N`, `CoulFc`, `Fichier`, `Tableau`, la variable `nom1`, les branches inaccessibles
  `Case 8` de `Cmpt_KeyPress`/`Cmpt_LostFocus`, le test redondant `Esc Or F2` sous `F2`, le
  `Shell "cd …"` l. 2108 · appelants : aucun · tests : T01-T13 · sources : [FFournisseur.class:Tabfour3_click](../../../../../.src/Gestion/Tables/FFournisseur.class#L180-L184), [FFournisseur.class:colfo_Click](../../../../../.src/Gestion/Tables/FFournisseur.class#L1336-L1345), [FFournisseur.class:colfo_Activate](../../../../../.src/Gestion/Tables/FFournisseur.class#L1347-L1351), [FFournisseur.class:Button6_Keypress](../../../../../.src/Gestion/Tables/FFournisseur.class#L1724-L1728), [FFournisseur.class:Button6_Click](../../../../../.src/Gestion/Tables/FFournisseur.class#L1730-L1734), [FFournisseur.class:Maj_vtl](../../../../../.src/Gestion/Tables/FFournisseur.class#L1329-L1334), [FFournisseur.class:FileFilter](../../../../../.src/Gestion/Tables/FFournisseur.class#L2602-L2609), [FFournisseur.class:HBox1_MouseDown](../../../../../.src/Gestion/Tables/FFournisseur.class#L2628-L2630), [FFournisseur.class:439](../../../../../.src/Gestion/Tables/FFournisseur.class#L439), [FFournisseur.class:503](../../../../../.src/Gestion/Tables/FFournisseur.class#L503), [FFournisseur.class:571](../../../../../.src/Gestion/Tables/FFournisseur.class#L571), [FFournisseur.class:2108](../../../../../.src/Gestion/Tables/FFournisseur.class#L2108)
- [ ] FFOURNISSEUR-003 — [réarchitecture] `Cbase.Table` pour les noms en dur : `TabFour` (dont le
  membre `Tab` de `Deb2`/`Deb3`), `TabComptes`, `TabFourVtl`, `TabMvt`, `TabMo`, `TabEntcom`,
  `TabEntrecpt`, `TabParam`, `TabEch`, `TabEtiq`, `TabTag` ; texte SQL identique · appelants : aucun ·
  tests : T01-T13 · sources : [FFournisseur.class:Form_Open](../../../../../.src/Gestion/Tables/FFournisseur.class#L155-L164), [FFournisseur.class:Button4_Click](../../../../../.src/Gestion/Tables/FFournisseur.class#L1353-L1427), [FFournisseur.class:Button3_Click](../../../../../.src/Gestion/Tables/FFournisseur.class#L1505-L1584), [FFournisseur.class:Button2_Click](../../../../../.src/Gestion/Tables/FFournisseur.class#L1586-L1642), [FFournisseur.class:Enrgvent](../../../../../.src/Gestion/Tables/FFournisseur.class#L1736-L1769)
- [ ] FFOURNISSEUR-004 — [commonalisation] En-têtes : les dix `C1…V1_Click`/`_Dblclick` →
  `ChoixTri(sTri, hEntete, bInverse)`, les cinq `*_KeyPress` → `SaisieRecherche()` ; handlers et
  pseudo-handlers conservés ; ordre des appels (`CleanChamps` double compris) inchangé · appelants :
  aucun · tests : T10 · sources : [FFournisseur.class:C1_Click](../../../../../.src/Gestion/Tables/FFournisseur.class#L1827-L1840), [FFournisseur.class:V1_Dblclick](../../../../../.src/Gestion/Tables/FFournisseur.class#L1957-L1969), [FFournisseur.class:C1_KeyPress](../../../../../.src/Gestion/Tables/FFournisseur.class#L1981-L1993), [FFournisseur.class:V1_KeyPress](../../../../../.src/Gestion/Tables/FFournisseur.class#L2037-L2049)
- [ ] FFOURNISSEUR-005 — [commonalisation] `FrancoLF`/`FportLF`/`MinCoMLF` → `FormateMontant(hZone)`
  (mêmes messages, même drapeau `b`) · appelants : aucun · tests : T02 · sources : [FFournisseur.class:FrancoLF](../../../../../.src/Gestion/Tables/FFournisseur.class#L889-L912), [FFournisseur.class:FportLF](../../../../../.src/Gestion/Tables/FFournisseur.class#L917-L940), [FFournisseur.class:MinCoMLF](../../../../../.src/Gestion/Tables/FFournisseur.class#L945-L968)
- [ ] FFOURNISSEUR-006 — [séparation traitement/GUI] Code-barres : `CleEan(sCode)` et
  `GenereCodeBarre(sCode)` purs (`Calc_barre`, partie calcul de `CtrlBarre`), messages dans les
  appelants ; `CtrlCbarre` garde sa requête actuelle (A06) · appelants : aucun · tests : T02, T15 · sources : [FFournisseur.class:CtrlBarre](../../../../../.src/Gestion/Tables/FFournisseur.class#L760-L781), [FFournisseur.class:Calc_barre](../../../../../.src/Gestion/Tables/FFournisseur.class#L827-L837), [FFournisseur.class:Codebarre](../../../../../.src/Gestion/Tables/FFournisseur.class#L786-L800), [FFournisseur.class:CtrlCbarre](../../../../../.src/Gestion/Tables/FFournisseur.class#L805-L822)
- [ ] FFOURNISSEUR-007 — [séparation traitement/GUI] `Button2_Click` : `ProchainCode(sDernier,
  sRacine)` pur et `ReserveCode()` (mêmes requêtes, même ordre, cas d'erreur inchangé tant que A02
  n'est pas validée) · appelants : aucun · tests : T01, T05, T14 · sources : [FFournisseur.class:Button2_Click](../../../../../.src/Gestion/Tables/FFournisseur.class#L1586-L1642)
- [ ] FFOURNISSEUR-008 — [séparation traitement/GUI] `Button3_Click` → `SupprimeFournisseur(sCode)
  As String` (contrôles et `DELETE` dans le même ordre) ; `Button4_Click` : liste ordonnée des 38
  colonnes partagée par l'INSERT et l'UPDATE (texte SQL identique) et `EcritCompteTiers(...)` pour
  `Fiches_Comptes` · appelants : aucun · tests : T01, T02, T04 · sources : [FFournisseur.class:Button3_Click](../../../../../.src/Gestion/Tables/FFournisseur.class#L1505-L1584), [FFournisseur.class:Button4_Click](../../../../../.src/Gestion/Tables/FFournisseur.class#L1353-L1427)
- [ ] FFOURNISSEUR-009 — [séparation traitement/GUI] `collman`, `Ventilman` : contrôle SQL renvoyant
  un code, messages et focus dans l'appelant · appelants : aucun · tests : T03, T08 · sources : [FFournisseur.class:collman](../../../../../.src/Gestion/Tables/FFournisseur.class#L1170-L1198), [FFournisseur.class:Ventilman](../../../../../.src/Gestion/Tables/FFournisseur.class#L1200-L1233)
- [ ] FFOURNISSEUR-010 — [commonalisation] Socle `FicheTiers` (voir FClient) : mails et contacts
  (`Maj_Email`, suppression d'`Email_KeyPress`, `Button16_Click`, `Aff_Ct`, `Colal2_*`,
  `CleanChampsCt`) ; mêmes requêtes · appelants : `FClient` (FCLIENT-011, même commit) · tests : T06,
  T07 · sources : [FFournisseur.class:Maj_Email](../../../../../.src/Gestion/Tables/FFournisseur.class#L374-L392), [FFournisseur.class:Email_KeyPress](../../../../../.src/Gestion/Tables/FFournisseur.class#L339-L366), [FFournisseur.class:Button16_Click](../../../../../.src/Gestion/Tables/FFournisseur.class#L2445-L2465), [FFournisseur.class:Aff_Ct](../../../../../.src/Gestion/Tables/FFournisseur.class#L2467-L2487), [FClient.class:Button16_Click](../../../../../.src/Gestion/Tables/FClient.class#L2939-L2959)
- [ ] FFOURNISSEUR-011 — [commonalisation] Socle `FicheTiers` : ventilations, libellé, tags, GED
  (`Ventilations`, `Ventilman`, `Enrgvent`, `Vents_Activate`, `LibelDef_LostFocus`,
  `Update_ListTags`, `RechTag_Click`, `Maj_Dssr`, `PanelGedDoc_MajSel`, `Button9_Click`) ·
  appelants : `FClient` (FCLIENT-012) · tests : T08, T09 · sources : [FFournisseur.class:Ventilations](../../../../../.src/Gestion/Tables/FFournisseur.class#L1283-L1327), [FFournisseur.class:Enrgvent](../../../../../.src/Gestion/Tables/FFournisseur.class#L1736-L1769), [FFournisseur.class:Maj_Dssr](../../../../../.src/Gestion/Tables/FFournisseur.class#L2536-L2586), [FFournisseur.class:Button9_Click](../../../../../.src/Gestion/Tables/FFournisseur.class#L2632-L2662)
- [ ] FFOURNISSEUR-012 — [commonalisation] Socle `FicheTiers` : `nom_pays`, listes collectifs /
  échéances / CP (`Cpman`, `aff_cp`), outils (`Button11_Click`, `button12_Click`, `Button17_Click`,
  `Button19_Click`), `ProchainCode` · appelants : `FClient` (FCLIENT-013) · tests : T05, T11, T13,
  T14 · sources : [FFournisseur.class:nom_pays](../../../../../.src/Gestion/Tables/FFournisseur.class#L166-L178), [FFournisseur.class:ToggleButton2_Click](../../../../../.src/Gestion/Tables/FFournisseur.class#L1455-L1493), [FFournisseur.class:ToggleButton5_Click](../../../../../.src/Gestion/Tables/FFournisseur.class#L1659-L1688), [FFournisseur.class:Cpman](../../../../../.src/Gestion/Tables/FFournisseur.class#L2270-L2289), [FFournisseur.class:Button11_Click](../../../../../.src/Gestion/Tables/FFournisseur.class#L2401-L2416), [FFournisseur.class:button12_Click](../../../../../.src/Gestion/Tables/FFournisseur.class#L2418-L2430)
- [ ] FFOURNISSEUR-013 — [commonalisation] Étiquettes → `PlancheEtiquettes` (avec l'impression du
  code-barres propre au fournisseur) ; PDF identique · appelants : `FClient` (FCLIENT-014) · tests :
  T12 · sources : [FFournisseur.class:Button15_Click](../../../../../.src/Gestion/Tables/FFournisseur.class#L2077-L2145), [FFournisseur.class:Imprime](../../../../../.src/Gestion/Tables/FFournisseur.class#L2147-L2167), [FFournisseur.class:pos_EtiqC](../../../../../.src/Gestion/Tables/FFournisseur.class#L2236-L2267)
- [ ] FFOURNISSEUR-014 — [commonalisation] Garde d'export (6 occurrences) → `Serveur.Actif("Four")`
  (après SERVEUR-008) · appelants : aucun · tests : T16 · sources : [FFournisseur.class:1384](../../../../../.src/Gestion/Tables/FFournisseur.class#L1384), [FFournisseur.class:1405](../../../../../.src/Gestion/Tables/FFournisseur.class#L1405), [FFournisseur.class:1568](../../../../../.src/Gestion/Tables/FFournisseur.class#L1568), [FFournisseur.class:2453](../../../../../.src/Gestion/Tables/FFournisseur.class#L2453), [FFournisseur.class:2459](../../../../../.src/Gestion/Tables/FFournisseur.class#L2459), [FFournisseur.class:2512](../../../../../.src/Gestion/Tables/FFournisseur.class#L2512)
- [ ] FFOURNISSEUR-015 — [complexité] `Maj_Dssr` : `Limit 1` sur la requête qui ne sert qu'aux
  métadonnées de colonnes, comme FClient (SQL modifié, dump identique ; le contenu du panneau est
  relu par `TriGen.Update`, à confirmer en replay) · appelants : aucun · tests : T09 · sources : [FFournisseur.class:2552](../../../../../.src/Gestion/Tables/FFournisseur.class#L2552)
- [ ] FFOURNISSEUR-016 — [réduction de portée] → `Private` : `nom_pays`, `Tris`, `Deb2`, `Deb3`,
  `Maj_Zones`, `CleanVtl`, `Refresh`, `CleanChamps`, `Maj_Email`, `Aff_Centrale`, `CtrlBarre`,
  `Codebarre`, `CtrlCbarre`, `Calc_barre`, `FrancoLF`, `FportLF`, `MinCoMLF`, `collman`, `Ventilman`,
  `RdimCfour`, `Ventilations`, `Enrgvent`, `Dbclk`, `Ref`, `init_ComboBox`, `Imprime`, `ImprimeC`,
  `fin_impression`, `pos_Etiq`, `pos_EtiqC`, `Cpman`, `aff_cp`, `ChkCp`, `ChkFranco`, `Aff_Ct`,
  `CleanChampsCt`, `Maj_Dssr`, `Update_ListTags` (ceux que 010-013 n'ont pas déplacés) ; membre `Col`
  → local. Restent `Public` : `Bsel`, `Bval`, `Codepostal`, `Bureaudistributeur`, pseudo-handlers,
  `ListTags_Add`, `<Grille>_Click` du rejeu · appelants : aucun · tests : T01-T14 · sources : [FFournisseur.class:Maj_Zones](../../../../../.src/Gestion/Tables/FFournisseur.class#L217-L276), [FFournisseur.class:collman](../../../../../.src/Gestion/Tables/FFournisseur.class#L1170-L1198), [FFournisseur.class:Maj_Dssr](../../../../../.src/Gestion/Tables/FFournisseur.class#L2536-L2586)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] FFOURNISSEUR-A01 — [anomalie] Suppression : `DELETE FROM <TabFdocs>` (clé absente, CBASE-A01)
  lève une erreur : `Fiches_Four_Vtl` non nettoyé, **export serveur de la suppression jamais émis**,
  liste non rafraîchie ; contrôle d'écritures limité à `Fiches_Mvt` · tests : T04, T16 · sources : [FFournisseur.class:1562](../../../../../.src/Gestion/Tables/FFournisseur.class#L1562), [FFournisseur.class:1568](../../../../../.src/Gestion/Tables/FFournisseur.class#L1568), [FFournisseur.class:1528](../../../../../.src/Gestion/Tables/FFournisseur.class#L1528)
- [ ] FFOURNISSEUR-A02 — [anomalie] `Button2_Click` : `dnf` absent ou < 401000 → message sans
  `UNLOCK TABLES` ; idem dans le `Catch` · tests : T05 · sources : [FFournisseur.class:1599](../../../../../.src/Gestion/Tables/FFournisseur.class#L1599), [FFournisseur.class:1602](../../../../../.src/Gestion/Tables/FFournisseur.class#L1602), [FFournisseur.class:1635](../../../../../.src/Gestion/Tables/FFournisseur.class#L1635)
- [ ] FFOURNISSEUR-A03 — [anomalie] Création : `INSERT` dans `Fiches_Comptes` sans test d'existence
  ni transaction : si le compte existe déjà (créé dans FComptes), erreur après l'insertion du
  fournisseur (état partiel) · tests : T01 · sources : [FFournisseur.class:1381](../../../../../.src/Gestion/Tables/FFournisseur.class#L1381), [FFournisseur.class:1382](../../../../../.src/Gestion/Tables/FFournisseur.class#L1382)
- [ ] FFOURNISSEUR-A04 — [anomalie] `INSERT … VALUE (…)` des contacts : refusé par SQLite · tests :
  T07 · sources : [FFournisseur.class:2458](../../../../../.src/Gestion/Tables/FFournisseur.class#L2458)
- [ ] FFOURNISSEUR-A05 — [anomalie] Suppression du **dernier** mail : `fo_email` conserve l'adresse
  supprimée · tests : T06 · sources : [FFournisseur.class:354](../../../../../.src/Gestion/Tables/FFournisseur.class#L354), [FFournisseur.class:361](../../../../../.src/Gestion/Tables/FFournisseur.class#L361)
- [ ] FFOURNISSEUR-A06 — [anomalie] `CtrlCbarre` cherche le code-barres dans `Fiches_Carte` (cartes
  clients) et compare `code` au code-barres au lieu du code fournisseur (copie non adaptée de
  `FClientcarte.CtrlCbarre`) ; `CtrlBarre` ne vérifie pas la clé d'un EAN-8 · tests : T02, T15 ·
  sources : [FFournisseur.class:809](../../../../../.src/Gestion/Tables/FFournisseur.class#L809), [FFournisseur.class:811](../../../../../.src/Gestion/Tables/FFournisseur.class#L811), [FClientcarte.class:532](../../../../../.src/Caisse/FClientcarte.class#L532), [FFournisseur.class:768](../../../../../.src/Gestion/Tables/FFournisseur.class#L768)
- [ ] FFOURNISSEUR-A07 — [anomalie] `Bsel` jamais remis à faux après `Tricp`/`TriCpt` (annulation =
  choix précédent recopié) ; ouverte par `Facture` (F11, `New FFournisseur`), la fiche ne reçoit pas
  le code postal choisi : `Tricp` écrit dans l'auto-instance · tests : T08, T11, T14 · sources : [FFournisseur.class:2384](../../../../../.src/Gestion/Tables/FFournisseur.class#L2384), [FFournisseur.class:1651](../../../../../.src/Gestion/Tables/FFournisseur.class#L1651), [Tricp.class:136](../../../../../.src/Affichages/Tricp.class#L136), [Facture.class:5658](../../../../../.src/Gestion/Facturation/Facture.class#L5658)
- [ ] FFOURNISSEUR-A08 — [anomalie] Étiquettes : `i2` et les positions ne sont pas remis à zéro
  après impression (FClient le fait) : une seconde impression dans la même session peut changer de
  page au mauvais moment · tests : T12 · sources : [FFournisseur.class:2084](../../../../../.src/Gestion/Tables/FFournisseur.class#L2084), [FClient.class:2504](../../../../../.src/Gestion/Tables/FClient.class#L2504)
- [ ] FFOURNISSEUR-A09 — [anomalie] Messages destinés aux clients : « Veuillez sélectionner un compte
  client », « saisir un client avant de scanner » · tests : T09 · sources : [FFournisseur.class:2545](../../../../../.src/Gestion/Tables/FFournisseur.class#L2545), [FFournisseur.class:2659](../../../../../.src/Gestion/Tables/FFournisseur.class#L2659)
- [ ] FFOURNISSEUR-A10 — [anomalie] Recherches concaténées (`Deb2`, `Deb3`, `aff_cp`, `Ventilations`,
  `Button9_Click`) : une saisie contenant `"` ou `'` provoque une erreur SQL · tests : T09, T10, T11 ·
  sources : [FFournisseur.class:205](../../../../../.src/Gestion/Tables/FFournisseur.class#L205), [FFournisseur.class:212](../../../../../.src/Gestion/Tables/FFournisseur.class#L212), [FFournisseur.class:2303](../../../../../.src/Gestion/Tables/FFournisseur.class#L2303), [FFournisseur.class:1296](../../../../../.src/Gestion/Tables/FFournisseur.class#L1296), [FFournisseur.class:2646](../../../../../.src/Gestion/Tables/FFournisseur.class#L2646)
- [ ] FFOURNISSEUR-A11 — [anomalie] `Maj_Zones` lit le fournisseur sans test `Available` · tests :
  T02 · sources : [FFournisseur.class:226](../../../../../.src/Gestion/Tables/FFournisseur.class#L226)
- [ ] FFOURNISSEUR-A12 — [anomalie] `Cmpt_KeyPress` : Entrée sur `Fax1` (tag 10) réinsère le mail et
  réécrit `fo_email` (intention à confirmer) ; F2 sur le CP (tag 6) ouvre `Tricp` sans `Stop Event` ·
  tests : T01, T11 · sources : [FFournisseur.class:521](../../../../../.src/Gestion/Tables/FFournisseur.class#L521), [FFournisseur.class:580](../../../../../.src/Gestion/Tables/FFournisseur.class#L580)
