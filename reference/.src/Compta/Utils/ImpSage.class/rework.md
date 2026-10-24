# ImpSage — Rework

> Source : `.src/Compta/Utils/ImpSage.class` · Message de commit (phase 4) : `reference/.src/Compta/Utils/ImpSage.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 699 |
| Lignes de commentaire | 59 |
| Fonctions | 24 |
| Fonctions Public | 24 |
| Complexité cyclomatique totale | 172 |
| Complexité max (fonction) | 50 (`ComptaS`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 699 | 172 | 50 | 0 | 24 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] IMPSAGE-001 — [documentation] En-tête en français : positions fixes de `clients.pnc` et
  `ecritures.pnm`, rôle de `Corsage`, correspondance des journaux, règle de numérotation des
  écritures et des tiers · appelants : aucun · tests : aucun · sources : [ImpSage.class:Import_Sage](../../../../../.src/Compta/Utils/ImpSage.class#L121-L271), [ImpSage.class:ComptaS](../../../../../.src/Compta/Utils/ImpSage.class#L509-L691), [ImpSage.class:Controle_journal](../../../../../.src/Compta/Utils/ImpSage.class#L705-L725)
- [ ] IMPSAGE-002 — [code mort] Supprimer `Maj_Client`, `Maj_Parametres`, `header`, `content1`,
  `content0` (aucun appel), le membre `Coulfond` et `Utils.Coulfd()` (après vérification),
  `Shell "cd ~"`, l'appel à `Parametres()` (membre `Jnl` jamais relu : SQL modifié, dump identique)
  et la branche inatteignable `bcpt <> "0"` · appelants : aucun · tests : T01 · sources : [ImpSage.class:Maj_Client](../../../../../.src/Compta/Utils/ImpSage.class#L324-L346), [ImpSage.class:Maj_Parametres](../../../../../.src/Compta/Utils/ImpSage.class#L761-L771), [ImpSage.class:header](../../../../../.src/Compta/Utils/ImpSage.class#L783-L794), [ImpSage.class:139](../../../../../.src/Compta/Utils/ImpSage.class#L139), [ImpSage.class:567](../../../../../.src/Compta/Utils/ImpSage.class#L567), [ImpSage.class:254-260](../../../../../.src/Compta/Utils/ImpSage.class#L254-L260)
- [ ] IMPSAGE-003 — [réduction de portée] `Import_Sage`, `Sauve`, `Creation_Fournisseur`,
  `Creation_Client`, `Controle`, `ControleS`, `ComptaS`, `Controle_tiers`, `Controle_journal`,
  `Parametres`, `Ecritures`, `Majnum`, `footer`, `Compteur`, `Compteurf` → `Private` (couverts par
  les replays) · appelants : aucun · tests : tous · sources : [ImpSage.class:Import_Sage](../../../../../.src/Compta/Utils/ImpSage.class#L121-L271), [ImpSage.class:ComptaS](../../../../../.src/Compta/Utils/ImpSage.class#L509-L691), [ImpSage.class:Compteurf](../../../../../.src/Compta/Utils/ImpSage.class#L844-L860)
- [ ] IMPSAGE-004 — [commonalisation] `Sauve` → `Utils.DumpBase` (SAUVESAUTO-003), commande et
  nom de fichier identiques · appelants : aucun · tests : T08 · sources : [ImpSage.class:Sauve](../../../../../.src/Compta/Utils/ImpSage.class#L273-L282), [SauvesAuto.module:19](../../../../../.src/Communs/SauvesAuto.module#L19)
- [ ] IMPSAGE-005 — [commonalisation] `Compteur` / `Compteurf` → helper pur
  `ProchainCodeTiers(sDernier, sPrefixe) As String` (extension de `ProchainCodeClient`,
  IMPCLIENT-008), résultat identique y compris la conversion entière · appelants : `Impclient`,
  `Facture` (via IMPCLIENT-008) · tests : T09, T01, T05 · sources : [ImpSage.class:Compteur](../../../../../.src/Compta/Utils/ImpSage.class#L823-L839), [ImpSage.class:Compteurf](../../../../../.src/Compta/Utils/ImpSage.class#L844-L860), [Impclient.class:Compteur](../../../../../.src/Utils/Exports-Imports/Impclient.class#L154-L170)
- [ ] IMPSAGE-006 — [commonalisation] Module commun d'import comptable avec `ImpJdv` :
  `Btn_Click`/`Svs2_Click` (socle `ImpExp`), `Ecritures`/`Majnum`, `Controle` (liste `Nvcompte`),
  insertion `Fiches_Mvt` + ligne collectif + `MajSoldeCompte` (4 occurrences dans `ComptaS`),
  collectif client (`CollectifClient`, ici le **premier** `41*`) ; SQL identique · appelants :
  `ImpJdv` (même lot) · tests : T01-T07 + IMPJDV-T01-T05 · sources : [ImpSage.class:Ecritures](../../../../../.src/Compta/Utils/ImpSage.class#L745-L756), [ImpSage.class:Majnum](../../../../../.src/Compta/Utils/ImpSage.class#L776-L781), [ImpSage.class:Controle](../../../../../.src/Compta/Utils/ImpSage.class#L348-L430), [ImpSage.class:638-665](../../../../../.src/Compta/Utils/ImpSage.class#L638-L665), [ImpSage.class:165-179](../../../../../.src/Compta/Utils/ImpSage.class#L165-L179), [ImpJdv.class:Compta](../../../../../.src/Compta/Utils/ImpJdv.class#L387-L530)
- [ ] IMPSAGE-007 — [complexité] `Import_Sage` : fusionner les trois blocs `411`/`401`/`403`
  identiques en un bloc paramétré (compteur, fonction de création) sans corriger la table testée
  (CC 32 → ≤ 15 visé) · appelants : aucun · tests : T01, T02, T06 · sources : [ImpSage.class:196-236](../../../../../.src/Compta/Utils/ImpSage.class#L196-L236)
- [ ] IMPSAGE-008 — [complexité] `ComptaS` / `ControleS` : fonction pure `LigneSage(sLig) As
  String[]` pour le découpage à positions fixes, `InStr("12345", sCar)` pour les tests de premier
  caractère, `Controle_journal` en table constante ; même résultat (CC 50 → ≤ 20 visé) ·
  appelants : aucun · tests : T01, T03, T07, T10 · sources : [ImpSage.class:ComptaS](../../../../../.src/Compta/Utils/ImpSage.class#L509-L691), [ImpSage.class:ControleS](../../../../../.src/Compta/Utils/ImpSage.class#L432-L507), [ImpSage.class:Controle_journal](../../../../../.src/Compta/Utils/ImpSage.class#L705-L725)
- [ ] IMPSAGE-009 — [réarchitecture] Noms de tables via `Cbase.Table` (`TabCli`, `TabFour`,
  `TabComptes`, `TabMvt`, `TabParam`), SQL identique ; `Corsage` reste en dur (pas de clé `Cbase`) ·
  appelants : aucun · tests : T01 · sources : [ImpSage.class:Import_Sage](../../../../../.src/Compta/Utils/ImpSage.class#L121-L271), [ImpSage.class:Creation_Fournisseur](../../../../../.src/Compta/Utils/ImpSage.class#L284-L302), [ImpSage.class:Creation_Client](../../../../../.src/Compta/Utils/ImpSage.class#L304-L322)
- [ ] IMPSAGE-010 — [séparation traitement/GUI] Extraire `ImporteTiers(sFichier)`,
  `CreeComptesManquants(sFichier) As String[]` et `ImporteEcritures(sFichier, bCloture)` sans accès
  aux contrôles ; `Import_Sage` garde souris, confirmation, messages, PDF et éditeur · appelants :
  aucun · tests : T01-T08 · sources : [ImpSage.class:Import_Sage](../../../../../.src/Compta/Utils/ImpSage.class#L121-L271), [ImpSage.class:ControleS](../../../../../.src/Compta/Utils/ImpSage.class#L432-L507), [ImpSage.class:ComptaS](../../../../../.src/Compta/Utils/ImpSage.class#L509-L691)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] IMPSAGE-A01 — [anomalie] **Grave** : pour un code Sage déjà présent dans `Corsage`,
  `num = Sageresult!ncode` écrase le compteur du prochain client ; le tiers inconnu suivant reçoit
  ce code déjà utilisé (aucune création, `Corsage` pointe vers un autre client) et ses écritures
  sont imputées à ce client · tests : T02 · sources : [ImpSage.class:235](../../../../../.src/Compta/Utils/ImpSage.class#L235)
- [ ] IMPSAGE-A02 — [anomalie] Fournisseurs : existence testée dans `Fiches_Cli` au lieu de
  `Fiches_Four` ; `INSERT INTO Fiches_Four` sans `Try` (erreur si le code existe) ; `Nbc` compté
  pour tout nouveau code, même hors `411/401/403` · tests : T06 · sources : [ImpSage.class:209](../../../../../.src/Compta/Utils/ImpSage.class#L209), [ImpSage.class:218](../../../../../.src/Compta/Utils/ImpSage.class#L218), [ImpSage.class:294](../../../../../.src/Compta/Utils/ImpSage.class#L294), [ImpSage.class:225](../../../../../.src/Compta/Utils/ImpSage.class#L225)
- [ ] IMPSAGE-A03 — [anomalie] `ComptaS` : la ligne d'un tiers dont le code Laurux ne commence pas
  par `4110`/`4010` est insérée deux fois (branche tiers puis branche générale) et son solde mis à
  jour deux fois : c'est le cas de **tous** les codes générés au-delà de `411099` / `401099`
  (`411100`…, `4111000`…), seuls `411001`-`411099` y échappent (à confirmer par T05) · tests : T05 · sources : [ImpSage.class:633-656](../../../../../.src/Compta/Utils/ImpSage.class#L633-L656), [ImpSage.class:657-665](../../../../../.src/Compta/Utils/ImpSage.class#L657-L665)
- [ ] IMPSAGE-A04 — [anomalie] `ComptaS` : `intitule` jamais affecté, `Nbe2` jamais incrémenté,
  message final sans décompte, doublon testé sans le montant (5ᵉ argument ignoré), `coll_cc` et
  `solde` lus sans test `Available`, ordre `cpoint`/`Val` inversé l.651/661, aucune transaction ·
  tests : T01, T04 · sources : [ImpSage.class:628](../../../../../.src/Compta/Utils/ImpSage.class#L628), [ImpSage.class:636](../../../../../.src/Compta/Utils/ImpSage.class#L636), [ImpSage.class:651](../../../../../.src/Compta/Utils/ImpSage.class#L651), [ImpSage.class:661](../../../../../.src/Compta/Utils/ImpSage.class#L661), [ImpSage.class:668](../../../../../.src/Compta/Utils/ImpSage.class#L668), [ImpSage.class:683](../../../../../.src/Compta/Utils/ImpSage.class#L683)
- [ ] IMPSAGE-A05 — [anomalie] `Controle` ne contrôle rien (`Filetxt2` jamais affecté) ;
  `ControleS` crée silencieusement les comptes généraux manquants (intitulé `" "`, type hérité de la
  ligne précédente pour les classes 8/9/0) et sa valeur de retour est ignorée : décider entre
  supprimer `Controle` ou rétablir un contrôle bloquant · tests : T01, T03 · sources : [ImpSage.class:378](../../../../../.src/Compta/Utils/ImpSage.class#L378), [ImpSage.class:478-480](../../../../../.src/Compta/Utils/ImpSage.class#L478-L480), [ImpSage.class:254](../../../../../.src/Compta/Utils/ImpSage.class#L254)
- [ ] IMPSAGE-A06 — [anomalie] `Corsage.acode` est en `char(8)` alors que le code Sage lu fait
  13 caractères : troncature (collisions) ou erreur masquée par `Try` selon `sql_mode` (à
  confirmer) · tests : T01 · sources : [ImpSage.class:189](../../../../../.src/Compta/Utils/ImpSage.class#L189), [ImpSage.class:199](../../../../../.src/Compta/Utils/ImpSage.class#L199)
- [ ] IMPSAGE-A07 — [anomalie] Numérotation des écritures : `Val(n° pièce) <> numdoc` compare un
  nombre et une chaîne ; pour une pièce alphanumérique, chaque ligne pourrait ouvrir une nouvelle
  écriture (à confirmer) ; journaux Sage non listés → `jour` vide · tests : T07 · sources : [ImpSage.class:597-602](../../../../../.src/Compta/Utils/ImpSage.class#L597-L602), [ImpSage.class:Controle_journal](../../../../../.src/Compta/Utils/ImpSage.class#L705-L725)
- [ ] IMPSAGE-A08 — [anomalie] `Sauve` : mêmes défauts qu'`ImpJdv.Sauve` (fichier supprimé ≠
  fichier produit, port/tunnel ignorés, dump avant confirmation) ; fichiers `hFile3`, `hFile2` non
  fermés ; vestige Kugar écrit dans le PDF · tests : T08 · sources : [ImpSage.class:Sauve](../../../../../.src/Compta/Utils/ImpSage.class#L273-L282), [ImpSage.class:183](../../../../../.src/Compta/Utils/ImpSage.class#L183), [ImpSage.class:footer](../../../../../.src/Compta/Utils/ImpSage.class#L808-L812)
