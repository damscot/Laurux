# StatComm — Rework

> Source : `.src/Statistiques/StatComm.class` · Message de commit (phase 4) : `reference/.src/Statistiques/StatComm.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 224 |
| Lignes de commentaire | 36 |
| Fonctions | 8 |
| Fonctions Public | 8 |
| Complexité cyclomatique totale | 62 |
| Complexité max (fonction) | 37 (`Traitement`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 224 | 62 | 37 | 0 | 8 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] STATCOMM-001 — [documentation] En-tête en français : rôle, deux modes de clé de `Total`
  (client / commercial), sources lues (factures archivées seulement), structure de `Total`
  partagée avec `VisStatComm` · appelants : aucun · tests : T01-T08 · sources : [StatComm.class:_New](../../../../.src/Statistiques/StatComm.class#L33-L57), [StatComm.class:Traitement](../../../../.src/Statistiques/StatComm.class#L161-L296)
- [ ] STATCOMM-002 — [code mort] Supprimer `Tot`, `Frmt` (`_New`), `Tab4`/`Tab5`, la seconde
  remise à zéro de `TotA`, la requête `TotResult` en double du N-1 (mode détail) et les
  `TotA = TotA + 0` (SQL modifié pour le doublon de `SELECT`, dump identique) · appelants : aucun
  · tests : T01-T05 · sources : [StatComm.class:_New](../../../../.src/Statistiques/StatComm.class#L33-L57), [StatComm.class:257](../../../../.src/Statistiques/StatComm.class#L257), [StatComm.class:263](../../../../.src/Statistiques/StatComm.class#L263)
- [ ] STATCOMM-003 — [complexité] Noms de tables en dur → `Cbase.Table("TabParam")`,
  `("TabHisFac")`, `("TabHisFacm")` (texte SQL identique) ; test de saisie des dates réduit à
  `dteN0.Text <> "" Or dteN1.Text <> ""` (même valeur) · appelants : aucun · tests : T01, T06 · sources : [StatComm.class:_New](../../../../.src/Statistiques/StatComm.class#L33-L57), [StatComm.class:197](../../../../.src/Statistiques/StatComm.class#L197)
- [ ] STATCOMM-004 — [réduction de portée] `dateN1`, `dteN0_LF`, `dteN1_LF`, `Traitement` →
  `Private` (aucun appelant externe ni appel dynamique) · appelants : aucun · tests : T01, T06 · sources : [StatComm.class:dateN1](../../../../.src/Statistiques/StatComm.class#L82-L89), [StatComm.class:dteN0_LF](../../../../.src/Statistiques/StatComm.class#L119-L133), [StatComm.class:dteN1_LF](../../../../.src/Statistiques/StatComm.class#L138-L159), [StatComm.class:Traitement](../../../../.src/Statistiques/StatComm.class#L161-L296)
- [ ] STATCOMM-005 — [commonalisation] Créer `StatCommun.module` (`PeriodeN1`, `DateSaisie`,
  `PeriodeInversee`, `TotalCree`, `Factures`) et y déléguer `dateN1`, `dteN0_LF`/`dteN1_LF`, la
  création de `Total` et la sélection des factures ; même SQL émis. À répliquer dans
  `StatComArt`, `StatFour`, `StatTypCli`, `StatClimo` (cases 005 de chacun) · appelants : aucun
  · tests : T01-T08, T10 · sources : [StatComm.class:dateN1](../../../../.src/Statistiques/StatComm.class#L82-L89), [StatComm.class:dteN0_LF](../../../../.src/Statistiques/StatComm.class#L119-L133), [StatComm.class:dteN1_LF](../../../../.src/Statistiques/StatComm.class#L138-L159), [StatComm.class:186](../../../../.src/Statistiques/StatComm.class#L186), [StatComm.class:198](../../../../.src/Statistiques/StatComm.class#L198), [StatComArt.class:dateN1](../../../../.src/Statistiques/StatComArt.class#L81-L88), [StatTypCli.class:dateN1](../../../../.src/Statistiques/StatTypCli.class#L82-L89)
- [ ] STATCOMM-006 — [séparation traitement/GUI] Extraire `CalculTotal(sDeb, sFin, sDebN1,
  sFinN1, iSource, bDetail)` sans accès aux contrôles ; `Traitement` lit les contrôles, gère
  curseur, messages et ouverture de `VisStatComm` · appelants : aucun · tests : T01-T05, T09 · sources : [StatComm.class:Traitement](../../../../.src/Statistiques/StatComm.class#L161-L296)
- [ ] STATCOMM-007 — [complexité] Cumul en mémoire (`Collection` par clé) puis un `INSERT` par
  ligne de `Total` (SQL modifié, dump identique) ; à faire **après** STATCOMM-A01 ou en
  reproduisant la persistance de `Codec`/`TotResult` (CC 37 → ≤ 15 visé) · appelants : aucun ·
  tests : T01-T05, T09 · sources : [StatComm.class:Traitement](../../../../.src/Statistiques/StatComm.class#L161-L296)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] STATCOMM-A01 — [anomalie] Mode synthèse : `Codec`, `commercial`, `Client` et `TotResult`
  affectés par `Try` ; si le client de la facture n'existe plus, ils gardent les valeurs de la
  facture précédente → CA attribué au mauvais commercial (N et N-1) · tests : T05 · sources : [StatComm.class:226](../../../../.src/Statistiques/StatComm.class#L226), [StatComm.class:229](../../../../.src/Statistiques/StatComm.class#L229), [StatComm.class:261](../../../../.src/Statistiques/StatComm.class#L261), [StatComm.class:263](../../../../.src/Statistiques/StatComm.class#L263)
- [ ] STATCOMM-A02 — [anomalie] Mode détail : `cliResult!cli_nom` lu sans test `Available` →
  erreur d'exécution si une facture archivée référence un client supprimé · tests : T05 · sources : [StatComm.class:221](../../../../.src/Statistiques/StatComm.class#L221), [StatComm.class:222](../../../../.src/Statistiques/StatComm.class#L222)
- [ ] STATCOMM-A03 — [anomalie] Le N-1 ne met à jour que les lignes déjà créées par N (clients
  ou commerciaux sans vente en N ignorés) et `totfacn1` n'est affiché nulle part (`VisStatComm`
  n'a pas de colonne N-1, `Bnet2_MouseDown` est mort) : calcul inutile ou affichage à ajouter,
  à trancher · tests : T04 · sources : [StatComm.class:249](../../../../.src/Statistiques/StatComm.class#L249), [StatComm.class:270](../../../../.src/Statistiques/StatComm.class#L270), [VisStatComm.class:Bnet2_MouseDown](../../../../.src/Statistiques/VisStatComm.class#L219-L224)
- [ ] STATCOMM-A04 — [anomalie] Mode synthèse : `pnmclifac` d'une ligne de commercial reçoit le
  prénom du client de la facture traitée (colonne « Prenom » de `VisStatComm` sans signification)
  · tests : T02 · sources : [StatComm.class:236](../../../../.src/Statistiques/StatComm.class#L236), [StatComm.class:238](../../../../.src/Statistiques/StatComm.class#L238)
- [ ] STATCOMM-A05 — [anomalie] Table de travail `Total` détruite et recréée sous un nom partagé
  par tous les postes et par 7 écrans de structures différentes (même défaut que STATCAI-A04) :
  deux traitements simultanés se mélangent, et un `VisStat*` resté ouvert relit une `Total`
  d'une autre structure (erreur SQL « colonne inconnue » au tri). Correction (nom par poste ou
  table temporaire) à faire dans `StatCommun.TotalCree`, change le dump · tests : T01 · sources : [StatComm.class:186](../../../../.src/Statistiques/StatComm.class#L186), [StatComm.class:187](../../../../.src/Statistiques/StatComm.class#L187), [Statcai.class:96](../../../../.src/Caisse/Statcai.class#L96)
