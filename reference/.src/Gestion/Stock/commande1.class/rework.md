# commande1 — Rework

> Source : `.src/Gestion/Stock/commande1.class` · Message de commit (phase 4) : `reference/.src/Gestion/Stock/commande1.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 849 |
| Lignes de commentaire | 15 |
| Fonctions | 50 |
| Fonctions Public | 43 |
| Complexité cyclomatique totale | 219 |
| Complexité max (fonction) | 29 (`rececp_Click`) |
| Variables globales | 0 |
| Variables Public | 3 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 849 | 219 | 29 | 0 | 43 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] COMMANDE1-001 — [documentation] En-tête en français : rôle, objets incrustés (`Achat`,
  `GesTar`, `artopt`), états et rôle du bouton `rececp`, fenêtre de sélection, **séquence
  transactionnelle partagée** avec `Achat.EnrAch`/`GesTar`, appel externe avec `Null` en `Parent`,
  défauts A01-A08 · appelants : aucun · tests : aucun · sources : [commande1.class:_new](../../../../../.src/Gestion/Stock/commande1.class#L27-L86), [commande1.class:ValCom](../../../../../.src/Gestion/Stock/commande1.class#L587-L625), [commande1.class:rececp_Click](../../../../../.src/Gestion/Stock/commande1.class#L671-L835)
- [ ] COMMANDE1-002 — [code mort] Supprimer le débogage d'`annul_Click` (`Print Object.Count`,
  `Shell "free"` ×2, sortie console seulement), les locales inutilisées `gt`/`opt`
  d'`Achat_Ajou` et `vecr` de `rececp_Click` · appelants : aucun · tests : T01-T05 ·
  sources : [commande1.class:532-533](../../../../../.src/Gestion/Stock/commande1.class#L532-L533), [commande1.class:544-545](../../../../../.src/Gestion/Stock/commande1.class#L544-L545), [commande1.class:219-220](../../../../../.src/Gestion/Stock/commande1.class#L219-L220), [commande1.class:686](../../../../../.src/Gestion/Stock/commande1.class#L686)
- [ ] COMMANDE1-003 — [complexité] `rececp_Click` (CC 29) : une fonction privée par état
  (`ValideFactures`, `ReceptionCommande`), `DemandeModeEcriture()` et `DemandeVignette()` ;
  suppression de la condition inatteignable `$etat = Achat.Reception And Not dra` ; ordre des
  appels et SQL identiques · appelants : aucun · tests : T02-T05, T09, ACHAT-T04/T05 · sources : [commande1.class:rececp_Click](../../../../../.src/Gestion/Stock/commande1.class#L671-L835)
- [ ] COMMANDE1-004 — [réduction de portée] `Update_Req` → `Private` (appelée par les trois
  radios) ; `tbl`, `Bsel`, `Bval` et tous les handlers restent `Public` · appelants : aucun ·
  tests : T01 · sources : [commande1.class:Update_Req](../../../../../.src/Gestion/Stock/commande1.class#L274-L316)
- [ ] COMMANDE1-005 — [séparation traitement/GUI] `LPrix_change` : calcul des totaux dans
  `Totaux() As Float[]` ; `affstk` : calcul séparé de l'affichage · appelants : aucun · tests :
  T13, ACHAT-T01 · sources : [commande1.class:LPrix_change](../../../../../.src/Gestion/Stock/commande1.class#L247-L271), [commande1.class:affstk](../../../../../.src/Gestion/Stock/commande1.class#L1049-L1068)
- [ ] COMMANDE1-006 — [séparation traitement/GUI] `VerSai` : contrôles sans focus ni message
  (`VerifieDocument`), messages et focus dans l'appelant ; allocations `LockIncrement`
  inchangées · appelants : aucun · tests : T02, T14, ACHAT-T01 · sources : [commande1.class:VerSai](../../../../../.src/Gestion/Stock/commande1.class#L890-L937)
- [ ] COMMANDE1-007 — [commonalisation] `ged` → `LGed.Archive` (LGED-007 prérequis, comme
  OBJFAC-008), lecture de `tag_def` à l'identique tant que A05 n'est pas validée · appelants :
  aucun · tests : T11 · sources : [commande1.class:ged](../../../../../.src/Gestion/Stock/commande1.class#L627-L668), [LGed.class:PDFDupli](../../../../../.src/Utils/LGed.class#L990-L1009)
- [ ] COMMANDE1-008 — [commonalisation] Fenêtres modales construites par code (`rececp_Click`)
  via le helper d'`Achat` (ACHAT-009) ; vignette via le helper commun avec `Mvtex.atvig`
  (MVTEX-009) · appelants : aucun · tests : T04, T05, T09, MVTEX-T07 · sources : [commande1.class:694-728](../../../../../.src/Gestion/Stock/commande1.class#L694-L728), [commande1.class:765-803](../../../../../.src/Gestion/Stock/commande1.class#L765-L803), [Mvtex.class:atvig](../../../../../.src/Gestion/Stock/Mvtex.class#L550-L569)
- [ ] COMMANDE1-009 — [complexité] `ValCom` et `rececp_Click` : extraire la séquence commune
  « `CreMat` / `SupAchat` / `EnrAch` / boucle tarifs / PDF / GED » dans une fonction privée
  paramétrée, **sans** changer la gestion de transaction (voir A04) · appelants : aucun · tests :
  T02, T04, T05, ACHAT-T03/T05/T06 · sources : [commande1.class:ValCom](../../../../../.src/Gestion/Stock/commande1.class#L587-L625), [commande1.class:807-828](../../../../../.src/Gestion/Stock/commande1.class#L807-L828)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] COMMANDE1-A01 — [anomalie] `suppr_Click` appelle `$gestarif.SupTarTemp()` une fois par
  ligne sans changer d'article : seuls les tarifs temporaires de l'article courant de `GesTar`
  sont supprimés. À corriger avec **GESTAR-A01** (paramètre article, même commit) · tests : T06 ·
  sources : [commande1.class:508](../../../../../.src/Gestion/Stock/commande1.class#L508), [GesTar.class:SupTarTemp](../../../../../.src/Gestion/Entrées/GesTar.class#L718-L722)
- [ ] COMMANDE1-A02 — [anomalie, à confirmer] Ouverture avec un document (`ValidBR1`,
  `Stockmvt`) : `Form_Open` → `ColTri_MajSel` fait `$Bval = Bval` (membre `Public` `Null`) et
  écrase la clé passée à `_new` ; `ValideS`/`suppr` appellent ensuite `tbl.SupAchat($etat, Null,
  …)` → erreur probable (`Cle[...]` sur `Null`) · tests : T10 · sources : [commande1.class:120](../../../../../.src/Gestion/Stock/commande1.class#L120), [commande1.class:334](../../../../../.src/Gestion/Stock/commande1.class#L334), [commande1.class:604](../../../../../.src/Gestion/Stock/commande1.class#L604)
- [ ] COMMANDE1-A03 — [anomalie, à confirmer] `annul_Click` fait `Object.Detach($gestarif)` sans
  jamais le rattacher : après la première annulation (donc après chaque enregistrement), les
  événements `EnrTar`/`CoulBout` de `GesTar` ne sont plus reçus (bouton « Enregistrer » de
  l'onglet Tarifs sans effet, `Etarif` jamais rouge) · tests : T07 · sources : [commande1.class:538](../../../../../.src/Gestion/Stock/commande1.class#L538), [commande1.class:Tarif_EnrTar](../../../../../.src/Gestion/Stock/commande1.class#L867-L876)
- [ ] COMMANDE1-A04 — [anomalie] Transaction partagée avec `Achat`/`GesTar` : `EnrAch` fait
  `Commit` en plein flux, tarifs/fiche article/étiquettes écrits hors transaction, `Commit` final
  sans `Begin` dans `ValCom`, retours sans `Rollback` après `CreMat` abandonné, résultat
  d'`EnrAch` ignoré dans `rececp_Click`. Correction conjointe (un seul `Begin`/`Commit`/`Rollback`
  par action, avec ACHAT et GESTAR-A07) · tests : T02, T08, ACHAT-T04/T14 · sources : [commande1.class:601](../../../../../.src/Gestion/Stock/commande1.class#L601), [commande1.class:615](../../../../../.src/Gestion/Stock/commande1.class#L615), [commande1.class:809](../../../../../.src/Gestion/Stock/commande1.class#L809), [commande1.class:816](../../../../../.src/Gestion/Stock/commande1.class#L816), [Achat.class:895](../../../../../.src/Gestion/Entrées/Achat.class#L895)
- [ ] COMMANDE1-A05 — [anomalie] `ged` lit `tag_def` par `"… WHERE fo_code = " & fcode.Text`
  (sans quotes ni `&1`) : erreur SQL pour un code fournisseur non numérique (même défaut que
  OBJFAC-A05, VALIDBR1-A04) · tests : T11 · sources : [commande1.class:661](../../../../../.src/Gestion/Stock/commande1.class#L661)
- [ ] COMMANDE1-A06 — [anomalie, à confirmer] `form_Close` avec saisie en cours : `$validBR` est
  mis à `True` avant `annul_Click`, qui ne fait alors que `Me.Close` (réentrant) : lignes, tarifs
  et `$gestarif` non nettoyés ; libération du verrou faite deux fois en mode `$validBR` · tests :
  T12 · sources : [commande1.class:130](../../../../../.src/Gestion/Stock/commande1.class#L130), [commande1.class:136-138](../../../../../.src/Gestion/Stock/commande1.class#L136-L138)
- [ ] COMMANDE1-A07 — [anomalie] `affstk` : `qteac / CFloat(art_txconv)` sans protection
  (`art_txconv` nullable, valeur 0 ou vide → erreur à la prise de focus) · tests : T13 · sources : [commande1.class:1065](../../../../../.src/Gestion/Stock/commande1.class#L1065)
- [ ] COMMANDE1-A08 — [anomalie] Écran non instrumenté (`Utils.Observers` absent, ainsi que dans
  `Achat`/`GesTar`) : l'ajouter change le log de rejeu et les couleurs ; prérequis possible des
  replays ACHAT/GESTAR (à décider en phase 2) · tests : T01 · sources : [commande1.class:_new](../../../../../.src/Gestion/Stock/commande1.class#L27-L86)
