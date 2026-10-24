# ImpJdv — Rework

> Source : `.src/Compta/Utils/ImpJdv.class` · Message de commit (phase 4) : `reference/.src/Compta/Utils/ImpJdv.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 533 |
| Lignes de commentaire | 41 |
| Fonctions | 20 |
| Fonctions Public | 20 |
| Complexité cyclomatique totale | 85 |
| Complexité max (fonction) | 17 (`Compta`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 533 | 85 | 17 | 0 | 20 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] IMPJDV-001 — [documentation] En-tête en français : format de `clients.txt` (31 champs) et
  de `ecritures<JJ>.csv`, lien avec ExportJdv type 1, règle de numérotation des écritures (nouveau
  numéro sur chaque ligne 411), tables et fichiers écrits · appelants : aucun · tests : aucun · sources : [ImpJdv.class:Import](../../../../../.src/Compta/Utils/ImpJdv.class#L130-L243), [ImpJdv.class:Compta](../../../../../.src/Compta/Utils/ImpJdv.class#L387-L530)
- [ ] IMPJDV-002 — [code mort] Supprimer `header`, `content1`, `content0` (jamais appelés), le
  membre `Coulfond` et l'appel `Utils.Coulfd()` (résultat jamais lu ; vérifier l'absence d'effet de
  bord), `Shell "cd ~"` (sans effet), le paramètre `Ctrl2` et les affectations de `Ctrl` dans la
  boucle de `Controle` (écrasées après la boucle) · appelants : aucun · tests : T01, T03 · sources : [ImpJdv.class:header](../../../../../.src/Compta/Utils/ImpJdv.class#L588-L599), [ImpJdv.class:content1](../../../../../.src/Compta/Utils/ImpJdv.class#L601-L605), [ImpJdv.class:content0](../../../../../.src/Compta/Utils/ImpJdv.class#L607-L611), [ImpJdv.class:77](../../../../../.src/Compta/Utils/ImpJdv.class#L77), [ImpJdv.class:144](../../../../../.src/Compta/Utils/ImpJdv.class#L144), [ImpJdv.class:Controle](../../../../../.src/Compta/Utils/ImpJdv.class#L312-L385)
- [ ] IMPJDV-003 — [code mort] Supprimer l'appel à `Parametres()` dans la boucle de `Compta` (son
  seul effet est le membre `Jnl`, jamais relu) et le `SELECT` inutile de `Maj_Parametres` (SQL
  modifié, dump identique) · appelants : aucun · tests : T01, T04 · sources : [ImpJdv.class:476](../../../../../.src/Compta/Utils/ImpJdv.class#L476), [ImpJdv.class:Maj_Parametres](../../../../../.src/Compta/Utils/ImpJdv.class#L566-L576)
- [ ] IMPJDV-004 — [réduction de portée] `Import`, `Sauve`, `Creation_Client`, `Maj_Client`,
  `Controle`, `Compta`, `Parametres`, `Ecritures`, `Maj_Parametres`, `Majnum`, `footer` →
  `Private` (seul `Fmenu` ouvre la fenêtre) ; couverts par les replays · appelants : aucun · tests :
  tous · sources : [ImpJdv.class:Import](../../../../../.src/Compta/Utils/ImpJdv.class#L130-L243), [ImpJdv.class:Compta](../../../../../.src/Compta/Utils/ImpJdv.class#L387-L530), [ImpJdv.class:Majnum](../../../../../.src/Compta/Utils/ImpJdv.class#L581-L586)
- [ ] IMPJDV-005 — [commonalisation] `Sauve` → `Utils.DumpBase` (SAUVESAUTO-003) avec la même
  commande et le même nom de fichier (`Laurux_dump.sql<JJMMAAAA>`) · appelants : aucun · tests :
  T07 · sources : [ImpJdv.class:Sauve](../../../../../.src/Compta/Utils/ImpJdv.class#L245-L254), [SauvesAuto.module:19](../../../../../.src/Communs/SauvesAuto.module#L19)
- [ ] IMPJDV-006 — [commonalisation] Module commun d'import comptable partagé avec `ImpSage` :
  `Maj_Client`, `Ecritures`/`Majnum` (→ `DernierNumeroEcriture()` / `MajNumeroEcriture(n)`),
  `Maj_Parametres`, liste `Nvcompte` (`Controle`), `Svs2_Click`/`Btn_Click` (socle `ImpExp`) ;
  SQL identique · appelants : `ImpSage` (même lot) · tests : T01-T05 + IMPSAGE-T01-T04 · sources : [ImpJdv.class:Maj_Client](../../../../../.src/Compta/Utils/ImpJdv.class#L287-L310), [ImpJdv.class:Ecritures](../../../../../.src/Compta/Utils/ImpJdv.class#L550-L561), [ImpJdv.class:Majnum](../../../../../.src/Compta/Utils/ImpJdv.class#L581-L586), [ImpJdv.class:Controle](../../../../../.src/Compta/Utils/ImpJdv.class#L312-L385), [ImpSage.class:Maj_Client](../../../../../.src/Compta/Utils/ImpSage.class#L324-L346), [ImpSage.class:Ecritures](../../../../../.src/Compta/Utils/ImpSage.class#L745-L756)
- [ ] IMPJDV-007 — [commonalisation] Insertion d'une ligne `Fiches_Mvt` et mise à jour de
  `Fiches_Comptes.solde` (2 occurrences ici, 4 dans `ImpSage.ComptaS`) dans des helpers communs
  `AjouteLigneMvt(...)` / `MajSoldeCompte(sCompte, fMtd, fMtc)` qui reproduisent exactement le SQL
  et la règle de solde (y compris la reprise de `Sld` précédent si le compte est introuvable) ·
  appelants : `ImpSage` · tests : T01, T04, T05 + IMPSAGE-T01 · sources : [ImpJdv.class:488-506](../../../../../.src/Compta/Utils/ImpJdv.class#L488-L506), [ImpSage.class:638-665](../../../../../.src/Compta/Utils/ImpSage.class#L638-L665)
- [ ] IMPJDV-008 — [commonalisation] Recherche du collectif client (`Creation_Client`,
  `Maj_Client`) via un helper `CollectifClient(bDernier)` partagé avec `ImpSage` et `Impclient`
  (ici : **dernier** `41*`) · appelants : `ImpSage`, `Impclient` · tests : T01, T02 · sources : [ImpJdv.class:267-275](../../../../../.src/Compta/Utils/ImpJdv.class#L267-L275), [ImpJdv.class:296-304](../../../../../.src/Compta/Utils/ImpJdv.class#L296-L304), [Impclient.class:91-97](../../../../../.src/Utils/Exports-Imports/Impclient.class#L91-L97)
- [ ] IMPJDV-009 — [complexité] Lecture des 31 champs client par une boucle sur un tableau de noms
  et état client dans une structure locale au lieu de ~30 membres ; même valeur pour chaque champ ·
  appelants : aucun · tests : T01, T02 · sources : [ImpJdv.class:166-198](../../../../../.src/Compta/Utils/ImpJdv.class#L166-L198), [ImpJdv.class:33-63](../../../../../.src/Compta/Utils/ImpJdv.class#L33-L63)
- [ ] IMPJDV-010 — [réarchitecture] Noms de tables via `Cbase.Table` (`TabCli`, `TabComptes`,
  `TabMvt`, `TabParam`, `TabJour`), SQL identique · appelants : aucun · tests : T01-T05 · sources : [ImpJdv.class:Creation_Client](../../../../../.src/Compta/Utils/ImpJdv.class#L256-L285), [ImpJdv.class:Compta](../../../../../.src/Compta/Utils/ImpJdv.class#L387-L530), [ImpJdv.class:ToggleButton3_Click](../../../../../.src/Compta/Utils/ImpJdv.class#L625-L653)
- [ ] IMPJDV-011 — [séparation traitement/GUI] Extraire `ImporteClients(sFichier)`,
  `ComptesManquants(sFichier) As String[]` et `ImporteEcritures(sFichier, bCloture) As Integer`
  sans accès aux contrôles ; `Import` garde souris, confirmation, PDF, éditeur et visualiseur ·
  appelants : aucun · tests : T01-T08 · sources : [ImpJdv.class:Import](../../../../../.src/Compta/Utils/ImpJdv.class#L130-L243), [ImpJdv.class:Controle](../../../../../.src/Compta/Utils/ImpJdv.class#L312-L385), [ImpJdv.class:Compta](../../../../../.src/Compta/Utils/ImpJdv.class#L387-L530)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] IMPJDV-A01 — [anomalie] **Grave** : `Maj_Parametres` écrit `dnfac = Nfac` alors que `Nfac`
  n'est jamais affecté : chaque écriture importée remet à vide le dernier numéro de facture, lu par
  `Moulinage` (l.2682) et `EcrAuto` (`LockIncrement`) → numérotation des factures relancée à 1
  (à confirmer sur une base de test) · tests : T01 · sources : [ImpJdv.class:573](../../../../../.src/Compta/Utils/ImpJdv.class#L573), [ImpJdv.class:508](../../../../../.src/Compta/Utils/ImpJdv.class#L508), [Moulinage.class:2682](../../../../../.src/Caisse/Moulinage.class#L2682)
- [ ] IMPJDV-A02 — [anomalie] `Creation_Client` : arguments décalés dans l'`INSERT` (`cli_dmln` ←
  clé RIB, `cli_cle_rib` ← n° de compte, `cli_num_cpt` ← domiciliation) et `cli_obs` ← code client
  au lieu des observations · tests : T02 · sources : [ImpJdv.class:277](../../../../../.src/Compta/Utils/ImpJdv.class#L277)
- [ ] IMPJDV-A03 — [anomalie] `Maj_Client` inverse `cli_tel_dom` et `cli_tel_bur` par rapport à la
  création et à l'export · tests : T01 · sources : [ImpJdv.class:305](../../../../../.src/Compta/Utils/ImpJdv.class#L305)
- [ ] IMPJDV-A04 — [anomalie] `pdf.Level2` appelé avec 12 arguments alors que
  `Cclients.Level2` en exige 13 (paramètre `reglt` non optionnel) : erreur d'exécution attendue à
  la première création de client, avant l'import des écritures (à confirmer) · tests : T02 · sources : [ImpJdv.class:205](../../../../../.src/Compta/Utils/ImpJdv.class#L205), [Cclients.class:Level2](../../../../../.src/Reports/Cclients.class#L64-L83)
- [ ] IMPJDV-A05 — [anomalie] Incompatibilité avec ExportJdv : la 1re ligne de `clients.txt` et
  de `ecritures<JJ>.csv` produits est l'intitulé de la société ; les lectures `Lig2[1..30]` sans
  protection lèvent une erreur d'indice (ligne courte ou vide) · tests : T06 · sources : [ImpJdv.class:167-198](../../../../../.src/Compta/Utils/ImpJdv.class#L167-L198), [ImpJdv.class:346-348](../../../../../.src/Compta/Utils/ImpJdv.class#L346-L348), [ExportJdv.class:588-589](../../../../../.src/Compta/Utils/ExportJdv.class#L588-L589)
- [ ] IMPJDV-A06 — [anomalie] `Nbe2` (écritures rejetées) n'est jamais incrémenté : le message
  annonce toujours 0 rejet ; seules les lignes 411 sont listées dans `rejets.txt` · tests : T04 · sources : [ImpJdv.class:511](../../../../../.src/Compta/Utils/ImpJdv.class#L511), [ImpJdv.class:518-523](../../../../../.src/Compta/Utils/ImpJdv.class#L518-L523)
- [ ] IMPJDV-A07 — [anomalie] Robustesse de `Compta` : contrepartie importée avec le numéro de
  l'écriture précédente quand la ligne 411 est rejetée mais pas ses contreparties ; `coll_cc` lu
  sans test `Available` ; solde du collectif réécrit avec la valeur précédente de `Sld` si le compte
  est introuvable ; aucune transaction (import partiel en cas d'erreur) · tests : T04 · sources : [ImpJdv.class:480-506](../../../../../.src/Compta/Utils/ImpJdv.class#L480-L506)
- [ ] IMPJDV-A08 — [anomalie] `Sauve` : supprime `Laurux_dump.sql` mais écrit
  `Laurux_dump.sql<JJMMAAAA>` ; exécuté avant la vérification des fichiers et la confirmation ; port,
  tunnel SSH et code retour ignorés ; mot de passe visible dans `ps` · tests : T07, T08 · sources : [ImpJdv.class:Sauve](../../../../../.src/Compta/Utils/ImpJdv.class#L245-L254), [ImpJdv.class:158](../../../../../.src/Compta/Utils/ImpJdv.class#L158)
- [ ] IMPJDV-A09 — [anomalie] `Controle` : `UPDATE Nvcompte` par concaténation (apostrophe dans
  l'intitulé → erreur SQL) ; à remplacer par `&1`, `&2` · tests : T09 · sources : [ImpJdv.class:356](../../../../../.src/Compta/Utils/ImpJdv.class#L356)
- [ ] IMPJDV-A10 — [anomalie] Fichiers non fermés (`hFile` et `hFile3` si « Non », `hFile3` dans
  tous les cas, `hFile2` de `Controle` toujours) ; `hFile3` ouvre le fichier PDF lui-même et `footer` y écrit
  avant `pdf.Output` (fichier vide laissé si « Non ») ; message « ecritures.txt » et libellé du
  `.form` (« ecrituresXX.txt ») alors que le fichier lu est `ecritures<JJ>.csv` · tests : T07, T08 · sources : [ImpJdv.class:162](../../../../../.src/Compta/Utils/ImpJdv.class#L162), [ImpJdv.class:footer](../../../../../.src/Compta/Utils/ImpJdv.class#L613-L617), [ImpJdv.class:525](../../../../../.src/Compta/Utils/ImpJdv.class#L525)
