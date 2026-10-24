# ObjFac — Rework

> Source : `.src/Gestion/Facturation/ObjFac.class` · Message de commit (phase 4) : `reference/.src/Gestion/Facturation/ObjFac.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 893 |
| Lignes de commentaire | 38 |
| Fonctions | 26 |
| Fonctions Public | 9 |
| Complexité cyclomatique totale | 181 |
| Complexité max (fonction) | 45 (`calcul`) |
| Variables globales | 0 |
| Variables Public | 85 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 893 | 181 | 45 | 0 | 9 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] OBJFAC-001 — [documentation] En-tête : rôle, relation avec `ObjFacB` (seule instanciation,
  redéfinition de `calcul`/`verifdat`), sens de `num` selon `choix` (BL, facture, suffixe de table
  en fin de mois), table des options `LocalSettings` ; commentaires `'''` des méthodes publiques ·
  appelants : aucun · tests : aucun · sources : [ObjFac.class:_new](../../../../../.src/Gestion/Facturation/ObjFac.class#L166-L285), [ObjFac.class:calcul](../../../../../.src/Gestion/Facturation/ObjFac.class#L447-L665)
- [ ] OBJFAC-002 — [code mort] Supprimer `Orig2FactType` (aucun appel), les membres jamais lus
  `poids`, `mdepo`, `cheque`, `intcheque`, `cptcheque`, `intcarte`, `cptcarte`, `intaut`, `cptaut`,
  `joinsms`, `nomfm` (et leurs lectures `LocalSettings`, sans effet de bord), les privés `$resfam`,
  `$restva`, `$facav` et les variables locales inutilisées · appelants : aucun (vérifié par `grep`,
  y compris variables typées `ObjFacB`) · tests : T01, T04, T13 · sources : [ObjFac.class:Orig2FactType](../../../../../.src/Gestion/Facturation/ObjFac.class#L1018-L1029), [ObjFac.class:82](../../../../../.src/Gestion/Facturation/ObjFac.class#L82), [ObjFac.class:104-110](../../../../../.src/Gestion/Facturation/ObjFac.class#L104-L110), [ObjFac.class:147-149](../../../../../.src/Gestion/Facturation/ObjFac.class#L147-L149)
- [ ] OBJFAC-003 — [réduction de portée] `FactType2Orig`, `Origine`, `treg`, `sauvpdf`,
  `nblfac`, `pdfchemin`, `ligneart`, `lignecom` → `Private` (aucun usage dans `ObjFacB` ni
  ailleurs). `calcul` et `verifdat` **restent** `Public` (`Super.` depuis `ObjFacB`) · appelants :
  aucun · tests : T01-T14 · sources : [ObjFac.class:FactType2Orig](../../../../../.src/Gestion/Facturation/ObjFac.class#L1031-L1041), [ObjFac.class:46](../../../../../.src/Gestion/Facturation/ObjFac.class#L46), [ObjFac.class:118-119](../../../../../.src/Gestion/Facturation/ObjFac.class#L118-L119)
- [ ] OBJFAC-004 — [complexité] Découper `calcul` (CC 45) en fonctions privées
  `ChargeDocument`, `AjouteLigne`, `FraisGestion`, `EcrituresTva`, `LigneTotalLettres`, sans
  changer l'ordre ni le texte des requêtes (CC ≤ 12 visé) · appelants : `ObjFacB` (inchangé) ·
  tests : T04-T11, T16 · sources : [ObjFac.class:calcul](../../../../../.src/Gestion/Facturation/ObjFac.class#L447-L665)
- [ ] OBJFAC-005 — [complexité] `_new` : helper privé `Opt(clé)` pour les ≈ 40 lectures
  `Start.LocalSettings["/Soc" & Start.Societe & "/…"]` et boucle sur les quatre recherches
  `Fiches_Bl[M]` par `numbl` puis `numfac` (même ordre de requêtes) · appelants : aucun · tests :
  T01, T02 · sources : [ObjFac.class:_new](../../../../../.src/Gestion/Facturation/ObjFac.class#L166-L285)
- [ ] OBJFAC-006 — [documentation] Renommer les variables locales `lg` en `ged` (`LGed`,
  `CopieGedFac`) et `ve` (`VarEcr`, `calcul`, `ecriturecompt`) : lève l'ambiguïté qui fait
  produire à `deps.py` des membres `<inconnu:…>` · appelants : aucun · tests : T07, T12, T14 ·
  sources : [ObjFac.class:892](../../../../../.src/Gestion/Facturation/ObjFac.class#L892), [ObjFac.class:456](../../../../../.src/Gestion/Facturation/ObjFac.class#L456), [ObjFac.class:977](../../../../../.src/Gestion/Facturation/ObjFac.class#L977)
- [ ] OBJFAC-007 — [commonalisation] `Cbase.Table` pour toutes les tables qui ont une clé
  (`TabBl`, `TabBlM`, `TabLigbl`, `TabHisFac`, `TabHisLigFac`, `TabCli`, `TabEch`, `TabTleg`,
  `TabLibelFac`, `TabParam`, `TabArt`, `TabMo`, `TabFam`, `TabComptes`, `TabTvav`…), SQL identique
  · appelants : aucun · tests : T01-T12 · sources : [ObjFac.class:_new](../../../../../.src/Gestion/Facturation/ObjFac.class#L166-L285), [ObjFac.class:calcul](../../../../../.src/Gestion/Facturation/ObjFac.class#L447-L665), [ObjFac.class:calc](../../../../../.src/Gestion/Facturation/ObjFac.class#L667-L755)
- [ ] OBJFAC-008 — [commonalisation] `CopieGedFac` : remplacer la séquence
  `Search/New/PDFDupli/Supprime/DelAllTag/AddTag(s)` par `LGed.Archive` (LGED-007, prérequis),
  la lecture de `tag_def` restant à l'identique tant que A05 n'est pas validée · appelants :
  `ObjFacB` (inchangé) · tests : T14 · sources : [ObjFac.class:CopieGedFac](../../../../../.src/Gestion/Facturation/ObjFac.class#L884-L945), [LGed.class:PDFDupli](../../../../../.src/Utils/LGed.class#L990-L1009)
- [ ] OBJFAC-009 — [séparation traitement/GUI] `verifdat`, `testchem` et `ecriturecompt` :
  isoler les contrôles et le SQL dans des fonctions privées sans `Message`, les messages restant
  dans la fonction publique (textes identiques) · appelants : `ObjFacB` (inchangé) · tests : T12,
  T14, T15 · sources : [ObjFac.class:verifdat](../../../../../.src/Gestion/Facturation/ObjFac.class#L824-L848), [ObjFac.class:testchem](../../../../../.src/Gestion/Facturation/ObjFac.class#L852-L882), [ObjFac.class:ecriturecompt](../../../../../.src/Gestion/Facturation/ObjFac.class#L975-L1015)
- [ ] OBJFAC-010 — [complexité] `nbexplemplaire_Write` : `TypeOf(Value) = gb.String` au lieu de
  `Value = gb.String` (résultat identique pour les valeurs numériques transmises par `OptFac` et
  `Moulinage`) ; `mult` : conversion Variant → Float via `Utils.VariantToFloat` (voir LPRIX-009)
  · appelants : aucun · tests : T04, T10 · sources : [ObjFac.class:nbexplemplaire_Write](../../../../../.src/Gestion/Facturation/ObjFac.class#L385-L393), [ObjFac.class:mult](../../../../../.src/Gestion/Facturation/ObjFac.class#L791-L821)
- [ ] OBJFAC-011 — [documentation] Corriger l'ordre `type`/`etat` de `ecriturecompt`
  (`type = Vente`, `etat = L_ajou`, comme dans `ecriture`) : les deux constantes valent 2, aucun
  changement de comportement · appelants : aucun · tests : T12 · sources : [ObjFac.class:990-991](../../../../../.src/Gestion/Facturation/ObjFac.class#L990-L991), [ObjFac.class:778-779](../../../../../.src/Gestion/Facturation/ObjFac.class#L778-L779)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] OBJFAC-A01 — [anomalie] Écotaxes en mode TTC calculées sur l'accumulateur
  (`eco.tee * txtva`, `eco.tea * txtva`) au lieu de `art_eco`/`art_eco2` : total d'écotaxe
  toujours nul sur les éditions TTC · tests : T10 · sources : [ObjFac.class:680](../../../../../.src/Gestion/Facturation/ObjFac.class#L680), [ObjFac.class:683](../../../../../.src/Gestion/Facturation/ObjFac.class#L683)
- [ ] OBJFAC-A02 — [anomalie] `calcul` remet à zéro les totaux sauf `remart` et `remmo` : en fin
  de mois (`ObjFacB.editefm`, un `calcul` par client sur le même objet) les remises affichées se
  cumulent d'un client à l'autre · tests : T11 · sources : [ObjFac.class:464-469](../../../../../.src/Gestion/Facturation/ObjFac.class#L464-L469), [ObjFac.class:547](../../../../../.src/Gestion/Facturation/ObjFac.class#L547), [ObjFac.class:553](../../../../../.src/Gestion/Facturation/ObjFac.class#L553)
- [ ] OBJFAC-A03 — [anomalie, à confirmer] TVA des frais de gestion calculée si
  `Not exobl Or Not autoent`, alors que la TVA des lignes l'est si `Not exobl And Not autoent` :
  un client exonéré non auto-entrepreneur se voit facturer de la TVA sur les frais · tests : T06 ·
  sources : [ObjFac.class:614](../../../../../.src/Gestion/Facturation/ObjFac.class#L614), [ObjFac.class:729](../../../../../.src/Gestion/Facturation/ObjFac.class#L729)
- [ ] OBJFAC-A04 — [anomalie] `sms` est lu sur la clé `/TxtF` (texte de règlement) au lieu de
  `/Sms` (option écrite par `Prefs`, lue par `Fmenu`) : le bouton SMS d'`OptFac` suit la mauvaise
  préférence · tests : T01, OPTFAC-T01 · sources : [ObjFac.class:273](../../../../../.src/Gestion/Facturation/ObjFac.class#L273), [Prefs.class:703](../../../../../.src/Communs/Prefs.class#L703)
- [ ] OBJFAC-A05 — [anomalie] `CopieGedFac` lit `tag_def` par `"… WHERE cli_code = " & $numcli`
  (sans quotes ni `&1`) : erreur SQL pour un code client non numérique, et correspondance
  numérique approximative sous MySQL (`'0123'` = `123`) · tests : T14 · sources : [ObjFac.class:932](../../../../../.src/Gestion/Facturation/ObjFac.class#L932)
- [ ] OBJFAC-A06 — [anomalie, à confirmer] `ecriturecompt` et `verifdat` utilisent `Fiches_Bl` /
  `Fiches_Ligbl` en dur, sans le suffixe `tab` : pour un document d'entretien (`Fiches_BlM`),
  `utils.db.Edit` ne trouve pas le BL (écriture d'un `Result` vide) et les dates de mouvement ne
  sont pas mises à jour · tests : T12, T15 · sources : [ObjFac.class:1004](../../../../../.src/Gestion/Facturation/ObjFac.class#L1004), [ObjFac.class:845](../../../../../.src/Gestion/Facturation/ObjFac.class#L845)
- [ ] OBJFAC-A07 — [anomalie, à confirmer] `mult` remplace un nombre de décimales nul par la
  lettre `"O"` au lieu de `"0"` (`art_nbd`/`art_dec` à `NULL`) : résultat de `Utils.arrondi(x,
  "O")` à caractériser · tests : T10 · sources : [ObjFac.class:797](../../../../../.src/Gestion/Facturation/ObjFac.class#L797)
- [ ] OBJFAC-A08 — [anomalie] `calc` lit `resart!art_ect` sans tester `Available` (article
  supprimé depuis la saisie du BL → erreur) ; `nom()` lit `adrfac.nom` alors que `adrfac` reste
  `Null` si le client n'existe plus (`calcul`, lui, teste `IsNull(adrfac)`) · tests : T05, T03 · sources : [ObjFac.class:679](../../../../../.src/Gestion/Facturation/ObjFac.class#L679), [ObjFac.class:968](../../../../../.src/Gestion/Facturation/ObjFac.class#L968)
