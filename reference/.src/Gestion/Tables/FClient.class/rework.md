# FClient — Rework

> Source : `.src/Gestion/Tables/FClient.class` · Message de commit (phase 4) : `reference/.src/Gestion/Tables/FClient.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 2716 |
| Lignes de commentaire | 84 |
| Fonctions | 157 |
| Fonctions Public | 155 |
| Complexité cyclomatique totale | 675 |
| Complexité max (fonction) | 42 (`Maj_Zones`) |
| Variables globales | 0 |
| Variables Public | 4 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 2716 | 675 | 42 | 0 | 155 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

Gros écran legacy (2716 LOC) : reworks minimaux et ciblés ; aucun `.form`, nom de contrôle ou nom
de handler n'est modifié. Les étapes FCLIENT-011 à 014 sont menées **dans le même commit** que leurs
jumelles FFOURNISSEUR-010 à 013 (socle commun `FicheTiers`).

- [ ] FCLIENT-001 — [documentation] En-tête en français : rôle, table des onglets, dispatch du groupe
  `Btn` par `Tag`, pseudo-handlers (`ButtonN_Click` groupés, `C1_Click`… sur `TextBox`, `V1_Clk`),
  drapeau partagé `Enr`, rôle de `bl`, membres `Public` écrits par `Tricp`/`TriCpt`/`TriGen`, options
  `B`/`P`/`T` · appelants : aucun · tests : aucun · sources : [FClient.class:_New](../../../../../.src/Gestion/Tables/FClient.class#L76-L182), [FClient.class:Btn_Click](../../../../../.src/Gestion/Tables/FClient.class#L1356-L1392), [FClient.class:V1_Clk](../../../../../.src/Gestion/Tables/FClient.class#L2197-L2211)
- [ ] FCLIENT-002 — [code mort] Supprimer `Remmo_LF`, `Remart_LF` (jamais levés, `_LF` n'est pas un
  événement), `Maj_vtl`, `Ref`, `Cpman`, `ChkCp`, `FileFilter`, `Cmpt3_Click` (une `TextBox` n'a pas
  d'événement `Click`), les membres `n`, `CoulFc`, `Fichier`, `Tableau`, `tab` ; les branches
  inaccessibles `Case 8` de `Cmpt_KeyPress`/`Cmpt_LostFocus` (aucun contrôle `Cmpt` de tag 8),
  `Case 10` de `Btn_Click`, `Column = 8` de `Colcli_Data` ; les instructions sans effet
  (`Randomize` de `Maj_Zones`, `Replace$` ignoré l. 529, `Shell "cd …"` l. 2477, `If Error` sans
  `Try` l. 2877, `Try $lcom.Close` l. 3363, première affectation de `cli_reg` et doublon de
  `cli_typec` dans `majchamp`) · appelants : aucun · tests : T01-T14 · sources : [FClient.class:Remmo_LF](../../../../../.src/Gestion/Tables/FClient.class#L1394-L1406), [FClient.class:Remart_LF](../../../../../.src/Gestion/Tables/FClient.class#L1408-L1420), [FClient.class:Maj_vtl](../../../../../.src/Gestion/Tables/FClient.class#L565-L570), [FClient.class:Ref](../../../../../.src/Gestion/Tables/FClient.class#L2219-L2227), [FClient.class:Cpman](../../../../../.src/Gestion/Tables/FClient.class#L2637-L2651), [FClient.class:ChkCp](../../../../../.src/Gestion/Tables/FClient.class#L2747-L2755), [FClient.class:FileFilter](../../../../../.src/Gestion/Tables/FClient.class#L3098-L3105), [FClient.class:Cmpt3_Click](../../../../../.src/Gestion/Tables/FClient.class#L2070-L2074), [FClient.class:529](../../../../../.src/Gestion/Tables/FClient.class#L529), [FClient.class:1549](../../../../../.src/Gestion/Tables/FClient.class#L1549), [FClient.class:2477](../../../../../.src/Gestion/Tables/FClient.class#L2477), [FClient.class:2877](../../../../../.src/Gestion/Tables/FClient.class#L2877), [FClient.class:3363](../../../../../.src/Gestion/Tables/FClient.class#L3363)
- [ ] FCLIENT-003 — [réarchitecture] `Cbase.Table` pour les noms en dur qui ont une clé : `TabCli`
  (dont `Create9`/`Edit("Fiches_Cli")`), `TabComptes`, `TabCliVtl`, `TabMvt`, `TabBl`, `TabParam`,
  `TabEch`, `TabTypec`, `TabEtiq`, `TabHisFac`/`TabHisFacm`, `TabTag` ; texte SQL identique.
  `Fiches_Reglements`, `Fiches_region`, `Fiches_tourne` et `Corsage` restent en dur (pas de clé) ·
  appelants : aucun · tests : T01-T14 · sources : [FClient.class:Button4_Click](../../../../../.src/Gestion/Tables/FClient.class#L1422-L1502), [FClient.class:majchamp](../../../../../.src/Gestion/Tables/FClient.class#L1504-L1603), [FClient.class:Button3_Click](../../../../../.src/Gestion/Tables/FClient.class#L1605-L1673), [FClient.class:Button2_Click](../../../../../.src/Gestion/Tables/FClient.class#L1675-L1737), [FClient.class:ChiffreA](../../../../../.src/Gestion/Tables/FClient.class#L496-L517), [FClient.class:Ventilations](../../../../../.src/Gestion/Tables/FClient.class#L1746-L1784)
- [ ] FCLIENT-004 — [complexité] `Deb2`/`Deb3` : clause `WHERE` construite une seule fois par
  `ClauseRecherche(sTri, sSel, bDebut, sActif, sStatut)` (fonction pure) ; les branches `hColcli`
  identiques sont fusionnées ; texte SQL **identique à l'octet** (CC 18 → ≤ 4) · appelants : aucun ·
  tests : T11, T17 · sources : [FClient.class:Deb2](../../../../../.src/Gestion/Tables/FClient.class#L290-L320), [FClient.class:Deb3](../../../../../.src/Gestion/Tables/FClient.class#L352-L367)
- [ ] FCLIENT-005 — [commonalisation] En-têtes de recherche : `C1/N1/A1/Cp1_Click` et `V1_Clk` →
  `ChoixTri(sTri, hEntete)` ; les cinq `*_KeyPress` → `SaisieRecherche(bDebut)` ; handlers et
  pseudo-handlers conservés (corps délégués) · appelants : aucun · tests : T11 · sources : [FClient.class:C1_Click](../../../../../.src/Gestion/Tables/FClient.class#L2125-L2135), [FClient.class:V1_Clk](../../../../../.src/Gestion/Tables/FClient.class#L2197-L2211), [FClient.class:C1_KeyPress](../../../../../.src/Gestion/Tables/FClient.class#L2229-L2242), [FClient.class:Cp1_KeyPress](../../../../../.src/Gestion/Tables/FClient.class#L2274-L2289)
- [ ] FCLIENT-006 — [commonalisation] `Cpman2`/`Cpman3` → `ChoixVille(hCp, hVille)` (même requête)
  · appelants : aucun · tests : T01, T08, T12 · sources : [FClient.class:Cpman2](../../../../../.src/Gestion/Tables/FClient.class#L2758-L2777), [FClient.class:Cpman3](../../../../../.src/Gestion/Tables/FClient.class#L2779-L2798)
- [ ] FCLIENT-007 — [séparation traitement/GUI] `Button2_Click` : `ProchainCode(sDernier, sRacine)`
  pure (411999 → 4111000, 4119999 → 41110000, sinon +1) et `ReserveCode()` (LOCK, lecture `dnc`,
  contrôle d'existence, UPDATE, UNLOCK dans le même ordre, y compris l'absence d'`UNLOCK` du cas
  d'erreur tant que A05 n'est pas validée) · appelants : aucun · tests : T01, T02, T16 · sources : [FClient.class:Button2_Click](../../../../../.src/Gestion/Tables/FClient.class#L1675-L1737)
- [ ] FCLIENT-008 — [séparation traitement/GUI] `majchamp` : extraire `EcritCompteTiers(sCode, sNom,
  sColl, bLettrable)` (partie `Fiches_Comptes`, mêmes requêtes) ; `Button3_Click` : extraire
  `SupprimeClient(sCode) As String` (contrôles puis `DELETE` dans le même ordre, motif de refus
  renvoyé, messages dans le handler) · appelants : aucun · tests : T01, T03, T05 · sources : [FClient.class:majchamp](../../../../../.src/Gestion/Tables/FClient.class#L1504-L1603), [FClient.class:Button3_Click](../../../../../.src/Gestion/Tables/FClient.class#L1605-L1673)
- [ ] FCLIENT-009 — [séparation traitement/GUI] `collman`, `Ventilman`, `echman` : contrôle SQL
  sans GUI renvoyant un code (`ControleCollectif` conserve le défaut A01), messages, focus et `Enr`
  dans l'appelant · appelants : aucun · tests : T04, T09, T12 · sources : [FClient.class:collman](../../../../../.src/Gestion/Tables/FClient.class#L2306-L2336), [FClient.class:Ventilman](../../../../../.src/Gestion/Tables/FClient.class#L2338-L2366), [FClient.class:echman](../../../../../.src/Gestion/Tables/FClient.class#L2050-L2068)
- [ ] FCLIENT-010 — [complexité] `Maj_Zones` : `LitClient(sCode) As Result` (même requête) puis
  affectations regroupées par onglet ; CC 42 → ≤ 15 · appelants : aucun · tests : T03, T11 · sources : [FClient.class:Maj_Zones](../../../../../.src/Gestion/Tables/FClient.class#L369-L477)
- [ ] FCLIENT-011 — [commonalisation] Socle `FicheTiers` (nouvelle classe, voir architecture.md) :
  mails et contacts (`Maj_Email`, suppression de `Email_KeyPress`, `Button16_Click`, `Aff_Ct`,
  `Colal2_Click`, `Colal2_KeyPress`, `CleanChampsCt`) paramétrés par les clés `TabMailCli`/`TabContact`
  et le domaine d'export ; mêmes requêtes, `Aff_Ct` continue d'écrire `Numero` (A02) · appelants :
  `FFournisseur` (FFOURNISSEUR-010, même commit) · tests : T06, T07 · sources : [FClient.class:Maj_Email](../../../../../.src/Gestion/Tables/FClient.class#L694-L711), [FClient.class:Email_KeyPress](../../../../../.src/Gestion/Tables/FClient.class#L661-L686), [FClient.class:Button16_Click](../../../../../.src/Gestion/Tables/FClient.class#L2939-L2959), [FClient.class:Aff_Ct](../../../../../.src/Gestion/Tables/FClient.class#L2961-L2983), [FFournisseur.class:Button16_Click](../../../../../.src/Gestion/Tables/FFournisseur.class#L2445-L2465)
- [ ] FCLIENT-012 — [commonalisation] Socle `FicheTiers` : ventilations, libellé et tags par défaut,
  GED (`Ventilations`, `Ventilman`, `Button6_Click`, `Vents_Activate`, `LibelDef_LostFocus`,
  `Update_ListTags`, `RechTag_Click`, `Maj_Dssr`, `PanelGedDoc_MajSel`, `Button9_Click`) ; requêtes
  inchangées (y compris le `Limit 1` propre à FClient) · appelants : `FFournisseur`
  (FFOURNISSEUR-011) · tests : T09, T10 · sources : [FClient.class:Ventilations](../../../../../.src/Gestion/Tables/FClient.class#L1746-L1784), [FClient.class:Button6_Click](../../../../../.src/Gestion/Tables/FClient.class#L1874-L1911), [FClient.class:Maj_Dssr](../../../../../.src/Gestion/Tables/FClient.class#L3032-L3082), [FClient.class:Button9_Click](../../../../../.src/Gestion/Tables/FClient.class#L3131-L3161), [FClient.class:Update_ListTags](../../../../../.src/Gestion/Tables/FClient.class#L3409-L3424)
- [ ] FCLIENT-013 — [commonalisation] Socle `FicheTiers` : listes et outils (`nom_pays`, listes
  collectifs / échéances, `Colcompt2_KeyPress`, `Colech_KeyPress`, carte, vCard, Infogreffe, SMS,
  `ProchainCode` de FCLIENT-007) ; handlers conservés · appelants : `FFournisseur` (FFOURNISSEUR-012)
  · tests : T01, T02, T12, T14, T16 · sources : [FClient.class:nom_pays](../../../../../.src/Gestion/Tables/FClient.class#L226-L238), [FClient.class:ToggleButton2_Click](../../../../../.src/Gestion/Tables/FClient.class#L1801-L1838), [FClient.class:ToggleButton3_Click](../../../../../.src/Gestion/Tables/FClient.class#L1979-L2009), [FClient.class:Button10_Click](../../../../../.src/Gestion/Tables/FClient.class#L519-L536), [FClient.class:button11_Click](../../../../../.src/Gestion/Tables/FClient.class#L538-L551), [FClient.class:Button17_Click](../../../../../.src/Gestion/Tables/FClient.class#L553-L563), [FClient.class:Button19_Click](../../../../../.src/Gestion/Tables/FClient.class#L2398-L2419)
- [ ] FCLIENT-014 — [commonalisation] Étiquettes : classe `PlancheEtiquettes` (état et calcul de
  position de `Imprime`, `ImprimeC`, `pos_Etiq`, `pos_EtiqC`, `fin_impression`), utilisée par
  `Button13_Click` ; PDF produit identique · appelants : `FFournisseur` (FFOURNISSEUR-013), puis les
  écrans de `.src/Gestion/Etiquettes/` dans leur lot · tests : T13 · sources : [FClient.class:Button13_Click](../../../../../.src/Gestion/Tables/FClient.class#L2447-L2515), [FClient.class:pos_Etiq](../../../../../.src/Gestion/Tables/FClient.class#L2572-L2601), [FClient.class:pos_EtiqC](../../../../../.src/Gestion/Tables/FClient.class#L2603-L2634), [FClient.class:Imprime](../../../../../.src/Gestion/Tables/FClient.class#L2517-L2534), [FClient.class:ImprimeC](../../../../../.src/Gestion/Tables/FClient.class#L2536-L2562)
- [ ] FCLIENT-015 — [commonalisation] Garde d'export `Variables.Sprix And Variables.Sexport And
  Variables.SMajCli` (5 occurrences) → `Serveur.Actif("Cli")` (après SERVEUR-008) · appelants :
  aucun · tests : T18 · sources : [FClient.class:1453](../../../../../.src/Gestion/Tables/FClient.class#L1453), [FClient.class:1475](../../../../../.src/Gestion/Tables/FClient.class#L1475), [FClient.class:2947](../../../../../.src/Gestion/Tables/FClient.class#L2947), [FClient.class:2953](../../../../../.src/Gestion/Tables/FClient.class#L2953), [FClient.class:3008](../../../../../.src/Gestion/Tables/FClient.class#L3008)
- [ ] FCLIENT-016 — [réduction de portée] → `Private` : `nom_pays`, `Tris`, `Deb2`, `Colcli_contact`,
  `Deb3`, `Maj_Zones`, `Aff_Mat`, `ChiffreA`, `CleanVtl`, `Refresh`, `CleanChamps`, `Maj_Email`,
  `RdimColcli`, `Aff_Statut`, `GenRum`, `Ventilations`, `Recup_Typec`, `echman`, `Dbclk`, `Titre`,
  `V1_Clk`, `collman`, `Ventilman`, `Envoi`, `init_ComboBox`, `Imprime`, `ImprimeC`,
  `fin_impression`, `pos_Etiq`, `pos_EtiqC`, `aff_cp`, `Cpman2`, `Cpman3`, `Aff_AdrC`,
  `CleanChampsAdr`, `Aff_Ct`, `CleanChampsCt`, `Maj_Dssr`, `Update_ListTags` (ceux que les étapes
  011-014 n'ont pas déplacés) ; membre `Col` → local de `Maj_Dssr`. `Bsel`, `Bval`, `Codepostal`,
  `Bureaudistributeur`, `ListTags_Add`, pseudo-handlers et `<Grille>_Click` du rejeu restent `Public`
  · appelants : aucun · tests : T01-T15 · sources : [FClient.class:Maj_Zones](../../../../../.src/Gestion/Tables/FClient.class#L369-L477), [FClient.class:collman](../../../../../.src/Gestion/Tables/FClient.class#L2306-L2336), [FClient.class:Maj_Dssr](../../../../../.src/Gestion/Tables/FClient.class#L3032-L3082)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] FCLIENT-A01 — [anomalie] `collman` accepte tout compte existant **non collectif** comme
  collectif (`Enr` remis à 1 par le `Else` du second test) ; seul un compte collectif hors `41`/`453`
  est refusé · tests : T04 · sources : [FClient.class:2315](../../../../../.src/Gestion/Tables/FClient.class#L2315), [FClient.class:2316](../../../../../.src/Gestion/Tables/FClient.class#L2316), [FClient.class:2319](../../../../../.src/Gestion/Tables/FClient.class#L2319)
- [ ] FCLIENT-A02 — [anomalie] `Aff_Ct` écrit `Numero` (adresse de livraison) au lieu de `Numero2`
  (contact) ; `Button15_Click` teste l'existence de l'adresse sur ce numéro et peut **écraser** une
  adresse existante du client au lieu d'en créer une · tests : T07, T08 · sources : [FClient.class:2977](../../../../../.src/Gestion/Tables/FClient.class#L2977), [FClient.class:2840](../../../../../.src/Gestion/Tables/FClient.class#L2840)
- [ ] FCLIENT-A03 — [anomalie] SMS (`Button19_Click`) : l'onglet testé pour le portable du contact
  est 4 (Matériels) au lieu de 6 (Contacts) · tests : T14 · sources : [FClient.class:2410](../../../../../.src/Gestion/Tables/FClient.class#L2410)
- [ ] FCLIENT-A04 — [anomalie] Suppression : `DELETE FROM <TabCdocs>` (clé absente, CBASE-A01) lève
  une erreur SQL : message d'erreur à chaque suppression, `Corsage` non nettoyé, liste non
  rafraîchie ; contrôle limité à `Fiches_Mvt` et `Fiches_Bl` (pas `Mvt1-5`, `MvtM*`, factures) ;
  mails, contacts, adresses, documents GED orphelins · tests : T05 · sources : [FClient.class:1653](../../../../../.src/Gestion/Tables/FClient.class#L1653), [FClient.class:1629](../../../../../.src/Gestion/Tables/FClient.class#L1629), [FClient.class:1637](../../../../../.src/Gestion/Tables/FClient.class#L1637)
- [ ] FCLIENT-A05 — [anomalie] `Button2_Click` : `dnc` absent ou < 411000 → message sans `UNLOCK
  TABLES` (MySQL : les écritures suivantes sur d'autres tables échouent jusqu'à la fin de session) ;
  idem sur erreur (`Catch`) · tests : T02 · sources : [FClient.class:1688](../../../../../.src/Gestion/Tables/FClient.class#L1688), [FClient.class:1691](../../../../../.src/Gestion/Tables/FClient.class#L1691), [FClient.class:1730](../../../../../.src/Gestion/Tables/FClient.class#L1730)
- [ ] FCLIENT-A06 — [anomalie] `Button4_Click` : transaction ouverte par `Begin` jamais close si
  `Edit` ne renvoie pas de ligne ; pas de `Rollback` dans le `Catch` · tests : T03 · sources : [FClient.class:1449](../../../../../.src/Gestion/Tables/FClient.class#L1449), [FClient.class:1473](../../../../../.src/Gestion/Tables/FClient.class#L1473), [FClient.class:1495](../../../../../.src/Gestion/Tables/FClient.class#L1495)
- [ ] FCLIENT-A07 — [anomalie] `INSERT … VALUE (…)` pour les adresses de livraison et les contacts :
  refusé par SQLite (MySQL l'accepte) · tests : T07, T08 · sources : [FClient.class:2847](../../../../../.src/Gestion/Tables/FClient.class#L2847), [FClient.class:2952](../../../../../.src/Gestion/Tables/FClient.class#L2952)
- [ ] FCLIENT-A08 — [anomalie] Suppression du **dernier** mail : la liste n'est pas vidée et
  `cli_email` reçoit l'adresse supprimée · tests : T06 · sources : [FClient.class:674](../../../../../.src/Gestion/Tables/FClient.class#L674), [FClient.class:682](../../../../../.src/Gestion/Tables/FClient.class#L682)
- [ ] FCLIENT-A09 — [anomalie] `ChiffreA` cumule **4 ans** de factures mais affiche « CA sur 12 mois »
  · tests : T14 · sources : [FClient.class:504](../../../../../.src/Gestion/Tables/FClient.class#L504), [FClient.class:513](../../../../../.src/Gestion/Tables/FClient.class#L513)
- [ ] FCLIENT-A10 — [anomalie] `Bsel` n'est jamais remis à faux après `Tricp`/`TriCpt` : une
  sélection annulée recopie le choix précédent ; `ToggleButton6` annulé refocalise `Cp` au lieu de
  `Cp2` · tests : T09, T12 · sources : [FClient.class:2807](../../../../../.src/Gestion/Tables/FClient.class#L2807), [FClient.class:2823](../../../../../.src/Gestion/Tables/FClient.class#L2823), [FClient.class:2827](../../../../../.src/Gestion/Tables/FClient.class#L2827), [FClient.class:1793](../../../../../.src/Gestion/Tables/FClient.class#L1793)
- [ ] FCLIENT-A11 — [anomalie] `Button20_Click` crée la fenêtre avec `New Form As "Form"` : ses
  événements appellent les handlers `Form_*` de FClient (`Form_Open` recharge la liste et déplace le
  focus) ; à confirmer en replay · tests : T14 · sources : [FClient.class:3212](../../../../../.src/Gestion/Tables/FClient.class#L3212)
- [ ] FCLIENT-A12 — [anomalie] Onglet Abonnement : « dernière facture » lue sans `ORDER BY` (ligne
  quelconque) · tests : T14 · sources : [FClient.class:220](../../../../../.src/Gestion/Tables/FClient.class#L220)
- [ ] FCLIENT-A13 — [anomalie] `Colcli_contact` : `drop Table IF exists` sur le littéral `BlTab`
  au lieu de la table `Contact` ; contact orphelin (client absent) → erreur et table temporaire
  laissée en place · tests : T11 · sources : [FClient.class:328](../../../../../.src/Gestion/Tables/FClient.class#L328), [FClient.class:342](../../../../../.src/Gestion/Tables/FClient.class#L342), [FClient.class:343](../../../../../.src/Gestion/Tables/FClient.class#L343)
- [ ] FCLIENT-A14 — [anomalie] Recherches concaténées (`Deb2`, `Deb3`, `Colcli_contact`, `aff_cp`,
  `Ventilations`, `Button9_Click`) : une saisie contenant `"` ou `'` provoque une erreur SQL ;
  paramétrer (`&1`) corrige ce cas (comportement identique sinon) · tests : T10, T11, T12 · sources : [FClient.class:296](../../../../../.src/Gestion/Tables/FClient.class#L296), [FClient.class:339](../../../../../.src/Gestion/Tables/FClient.class#L339), [FClient.class:2674](../../../../../.src/Gestion/Tables/FClient.class#L2674), [FClient.class:1759](../../../../../.src/Gestion/Tables/FClient.class#L1759), [FClient.class:3145](../../../../../.src/Gestion/Tables/FClient.class#L3145)
- [ ] FCLIENT-A15 — [anomalie] `Maj_Zones` lit le client sans test `Available` ; le test
  `IsNull(Lettrable.value)` porte sur la case au lieu de la donnée · tests : T03 · sources : [FClient.class:380](../../../../../.src/Gestion/Tables/FClient.class#L380), [FClient.class:381](../../../../../.src/Gestion/Tables/FClient.class#L381)
- [ ] FCLIENT-A16 — [anomalie] F2 sur les zones de tag 10 (`Teldom`, `Statut`) ouvre la liste des
  échéances ; F2 sur `Cdech` (onglet Divers) ne fait rien · tests : T12 · sources : [FClient.class:960](../../../../../.src/Gestion/Tables/FClient.class#L960), [FClient.class:961](../../../../../.src/Gestion/Tables/FClient.class#L961)
