# FEditrel — Rework

> Source : `.src/Compta/Relances/FEditrel.class` · Message de commit (phase 4) : `.hidden/reference/.src/Compta/Relances/FEditrel.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 497 |
| Lignes de commentaire | 26 |
| Fonctions | 21 |
| Fonctions Public | 16 |
| Complexité cyclomatique totale | 102 |
| Complexité max (fonction) | 25 (`Impressionr`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 497 | 102 | 25 | 0 | 16 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] FEDITREL-001 — [documentation] En-tête : déroulé génération → affichage → édition, table de
  travail `Fiches_relances`, contrat avec `Ligcli`/`Ligext` (membres appelés via `Variant`) ·
  appelants : aucun · tests : aucun · sources : [FEditrel.class:_New](../../../../../../.src/Compta/Relances/FEditrel.class#L10-L40)
- [ ] FEDITREL-002 — [code mort] Supprimer `selcouleur`, `couleur`, la variable `Filetxt`, le
  paramètre `Org` d'`Impressionr` et le `Shell "cd …"` · appelants : aucun · tests : T06 · sources :
  [FEditrel.class:selcouleur](../../../../../../.src/Compta/Relances/FEditrel.class#L282-L292), [FEditrel.class:couleur](../../../../../../.src/Compta/Relances/FEditrel.class#L294-L302), [FEditrel.class:Impressionr](../../../../../../.src/Compta/Relances/FEditrel.class#L438-L610)
- [ ] FEDITREL-003 — [réduction de portée] `Impressionr` → `Private` · appelants : aucun ·
  tests : T06 · sources : [FEditrel.class:Impressionr](../../../../../../.src/Compta/Relances/FEditrel.class#L438-L610)
- [ ] FEDITREL-004 — [complexité] Helper privé `Active(nlig)` commun à `lig_GotF`, `Lig_up`,
  `lig_Down` · appelants : aucun · tests : T04 · sources : [FEditrel.class:lig_GotF](../../../../../../.src/Compta/Relances/FEditrel.class#L42-L57), [FEditrel.class:Lig_up](../../../../../../.src/Compta/Relances/FEditrel.class#L59-L75), [FEditrel.class:lig_Down](../../../../../../.src/Compta/Relances/FEditrel.class#L77-L93)
- [ ] FEDITREL-005 — [complexité] Helper privé `TriLignes(propriete, sens)` pour
  `Buttontrnom_Click`/`Buttontrn_Click`, même algorithme (ordre final identique) · appelants :
  aucun · tests : T04 · sources : [FEditrel.class:Buttontrnom_Click](../../../../../../.src/Compta/Relances/FEditrel.class#L176-L221), [FEditrel.class:Buttontrn_Click](../../../../../../.src/Compta/Relances/FEditrel.class#L223-L268)
- [ ] FEDITREL-006 — [séparation traitement/GUI] `GenereRelances(dteN)` extrait de
  `Button1_Click` (DROP/CREATE + INSERT, SQL identique) · appelants : aucun · tests : T02, T03 ·
  sources : [FEditrel.class:Button1_Click](../../../../../../.src/Compta/Relances/FEditrel.class#L304-L395)
- [ ] FEDITREL-007 — [commonalisation] En-tête société et corps de lettre via les fonctions communes
  créées par LIGCLI-004/005 · appelants : aucun · tests : T06, T07 · sources : [FEditrel.class:Impressionr](../../../../../../.src/Compta/Relances/FEditrel.class#L438-L610), [Ligcli.class:Buttonedit_Click](../../../../../../.src/Compta/Relances/Ligcli.class#L181-L343)
- [ ] FEDITREL-008 — [commonalisation] `NiveauSuivant(relance)` (niveau + 1 borné à 3) et
  `Cbase.Table("TabMvt"/"TabCli"/"TabSoc"/"TabComptes")` pour les noms en dur (SQL identique) ·
  appelants : aucun · tests : T02, T06 · sources : [FEditrel.class:317-319](../../../../../../.src/Compta/Relances/FEditrel.class#L317-L319), [FEditrel.class:358-366](../../../../../../.src/Compta/Relances/FEditrel.class#L358-L366), [FEditrel.class:484-487](../../../../../../.src/Compta/Relances/FEditrel.class#L484-L487)
- [ ] FEDITREL-009 — [complexité] Typage : `Coulfond As Integer`, `Coulfd` local à `_New` ·
  appelants : aucun · tests : T04 · sources : [FEditrel.class:7-8](../../../../../../.src/Compta/Relances/FEditrel.class#L7-L8), [FEditrel.class:_New](../../../../../../.src/Compta/Relances/FEditrel.class#L10-L40)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] FEDITREL-A01 — [anomalie] (confirmée phase 2, vague 3 : `prgb.Close` sur objet nul (`Button1_Click.393`), code 125) `prgb.Close` appelé alors que la barre n'existe pas (date vide ou
  aucune écriture à relancer) → erreur « objet nul » · tests : T03 · sources : [FEditrel.class:393](../../../../../../.src/Compta/Relances/FEditrel.class#L393)
- [ ] FEDITREL-A02 — [anomalie] `Impressionr` : boucle `Repeat … Until i = tabl.count` exécutée
  même sans ligne → erreur d'indice ; en-tête société lu sans `Available` · tests : T01, T06 ·
  sources : [FEditrel.class:497-498](../../../../../../.src/Compta/Relances/FEditrel.class#L497-L498), [FEditrel.class:516-519](../../../../../../.src/Compta/Relances/FEditrel.class#L516-L519), [FEditrel.class:592](../../../../../../.src/Compta/Relances/FEditrel.class#L592)
- [ ] FEDITREL-A03 — [anomalie] Niveau écrit dans `Fiches_Mvt.relance` = niveau de la première
  écriture du client, pas le numéro de lettre imprimée (`numlet`) ; seules les écritures de
  `Fiches_Mvt` (exercice courant) sont mises à jour · tests : T06 · sources : [FEditrel.class:528](../../../../../../.src/Compta/Relances/FEditrel.class#L528), [FEditrel.class:557](../../../../../../.src/Compta/Relances/FEditrel.class#L557)
- [ ] FEDITREL-A04 — [anomalie] `Fiches_relances` est recréée à chaque génération sans distinction
  de poste : deux utilisateurs simultanés s'écrasent · tests : T02 · sources : [FEditrel.class:325-345](../../../../../../.src/Compta/Relances/FEditrel.class#L325-L345)
- [ ] FEDITREL-A05 — [anomalie, à confirmer] `Fiches_relances` absente au lancement : la génération remplit la table mais `affiche()` n'affiche rien (`Utils.db.Tables.Exist` sur un cache périmé ?) ; « Éditer » plante ensuite (`Impressionr.519 : Out of bounds`, voir A02) (phase 2, vague 3, 2026-11-12) · tests : T01, T02 · sources : [FEditrel.class:140](../../../../../../.src/Compta/Relances/FEditrel.class#L140), [FEditrel.class:519](../../../../../../.src/Compta/Relances/FEditrel.class#L519)
- [ ] FEDITREL-A06 — [anomalie] `Impressionr` : une écriture sans `numdoc` n'est jamais marquée relancée (`UPdate … SET relance = … WHERE … numdoc = NULL`) (phase 2, vague 3, 2026-11-12) · tests : T06 · sources : [FEditrel.class:557](../../../../../../.src/Compta/Relances/FEditrel.class#L557)
- [ ] FEDITREL-A07 — [anomalie] « Tout sélectionner » décoché puis recoché : chaque `Ligcli.Checkselec_Click` supprime le client de `Fiches_relances` (DELETE) sans le recréer au recochage ; les lignes de 411002 restent pourtant dans le dump et la ligne 403 passe du niveau 3 au niveau 2 (phase 2, vague 3, 2026-11-12) · tests : T05 · sources : [FEditrel.class:Checktout_Click](../../../../../../.src/Compta/Relances/FEditrel.class#L102-L119), [Ligcli.class:Checkselec_Click](../../../../../../.src/Compta/Relances/Ligcli.class#L106-L116)
