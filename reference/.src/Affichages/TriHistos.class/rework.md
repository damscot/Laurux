# TriHistos — Rework

> Source : `.src/Affichages/TriHistos.class` · Message de commit (phase 4) : `reference/.src/Affichages/TriHistos.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 601 |
| Lignes de commentaire | 24 |
| Fonctions | 26 |
| Fonctions Public | 26 |
| Complexité cyclomatique totale | 147 |
| Complexité max (fonction) | 29 (`DocVentes`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 601 | 147 | 29 | 0 | 26 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] TRIHISTOS-001 — [documentation] En-tête : rôle (historique ventes/achats d'un article),
  paramètres du constructeur, sources de données, table de travail `Fiches_Stat` recréée à chaque
  ouverture, périodes (mois entier en ventes, jour près en achats) · appelants : aucun · tests :
  T01-T05 · sources : [TriHistos.class:_new](../../../../.src/Affichages/TriHistos.class#L12-L28), [TriHistos.class:Histo_ventes](../../../../.src/Affichages/TriHistos.class#L30-L137)
- [ ] TRIHISTOS-002 — [code mort] Supprimer `Dtejour2`, `Dtejour3`, `dte3`, `LigcaiR`, `CaiR` et le
  bloc caisse commenté de `Histo_ventes` ; les tests de longueur sans effet des lignes 255 et 258 ;
  le calcul de `Dtejour` de `ComboBox1_Change` (écrasé ensuite) ; les blocs `With Utils` inutiles ·
  appelants : aucun · tests : T01, T02, T04 · sources : [TriHistos.class:Histo_ventes](../../../../.src/Affichages/TriHistos.class#L30-L137), [TriHistos.class:255](../../../../.src/Affichages/TriHistos.class#L255), [TriHistos.class:258](../../../../.src/Affichages/TriHistos.class#L258), [TriHistos.class:ComboBox1_Change](../../../../.src/Affichages/TriHistos.class#L700-L711)
- [ ] TRIHISTOS-003 — [complexité] Les 8 handlers `COD_/DA_/NM_/NFAC_` `GotFocus`/`DblClick`
  délèguent à `TriColonne(sTriVentes, sTriAchats, hEntete, bInverse)` ; handlers conservés ·
  appelants : aucun · tests : T02, T04 · sources : [TriHistos.class:COD_GotFocus](../../../../.src/Affichages/TriHistos.class#L318-L331), [TriHistos.class:DA_Dblclick](../../../../.src/Affichages/TriHistos.class#L372-L389), [TriHistos.class:NFAC_GotFocus](../../../../.src/Affichages/TriHistos.class#L438-L452)
- [ ] TRIHISTOS-004 — [complexité] `Histo_ventes` : requêtes N+1 (une lecture de `Fiches_Bl` par
  ligne de BL, une de `Fiches_HistoFac` par ligne de facture) remplacées par deux jointures triées
  dans le même ordre de parcours (valeurs de `lind` identiques) ; SQL modifié, dump identique (à
  vérifier sur `Fiches_Stat`) · appelants : aucun · tests : T01, T02, T06 · sources : [TriHistos.class:Histo_ventes](../../../../.src/Affichages/TriHistos.class#L30-L137)
- [ ] TRIHISTOS-005 — [réduction de portée] `Histo_ventes`, `Aff_StatVE`, `Histo_Achat`, `Aff_StatAC`, `aff_Histo`, `DocVentes`, `DocAchat` → `Private` (aucun appelant externe, vérifié) · appelants : aucun · tests : T01-T05 · sources : [TriHistos.class:Aff_StatVE](../../../../.src/Affichages/TriHistos.class#L139-L189), [TriHistos.class:Histo_Achat](../../../../.src/Affichages/TriHistos.class#L194-L227), [TriHistos.class:aff_Histo](../../../../.src/Affichages/TriHistos.class#L301-L316), [TriHistos.class:DocAchat](../../../../.src/Affichages/TriHistos.class#L617-L677)
- [ ] TRIHISTOS-006 — [commonalisation] Détail d'un document de vente : mise en page de `Colrcp3` et
  boucle des lignes (`DocVentes`, branche BL) vers un module commun `DetailDocument` partagé avec
  `AFacture.DocVentes` et `ACom.DocCom` ; tables en dur `Fiches_Bl,Fiches_Ligbl` remplacées par
  `Cbase.Table("TabBl")`/`("TabLigbl")` (même texte SQL) · appelants : `AFacture`, `ACom` (même
  commit) · tests : T03, AFACTURE-T01, ACOM-T01 · sources : [TriHistos.class:DocVentes](../../../../.src/Affichages/TriHistos.class#L492-L597), [TriHistos.class:561](../../../../.src/Affichages/TriHistos.class#L561), [AFacture.class:DocVentes](../../../../.src/Affichages/AFacture.class#L17-L88), [ACom.class:DocCom](../../../../.src/Affichages/ACom.class#L18-L68)
- [ ] TRIHISTOS-007 — [séparation traitement/GUI] `ConstruireStatVentes(sCode, sDebut)` (DDL et
  alimentation de `Fiches_Stat`, sans contrôle) et `LignesReception(…) As Result` ; les fonctions GUI
  ne gardent que l'affichage · appelants : aucun · tests : T01, T04, T06 · sources : [TriHistos.class:Histo_ventes](../../../../.src/Affichages/TriHistos.class#L30-L137), [TriHistos.class:Aff_StatAC](../../../../.src/Affichages/TriHistos.class#L229-L299)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] TRIHISTOS-A01 — [anomalie] `_new` écrit `Four = Four` (paramètre affecté à lui-même) :
  `Cfour` n'est jamais renseignée, la seconde condition de `Aff_StatAC` (`code = &2`) cherche les
  réceptions de code vide ; les réceptions saisies sous la référence passée par `Articles`
  (`Cfour.text`) n'apparaissent jamais dans l'historique des achats · tests : T04 · sources : [TriHistos.class:19](../../../../.src/Affichages/TriHistos.class#L19), [TriHistos.class:243](../../../../.src/Affichages/TriHistos.class#L243), [Articles.class:1456](../../../../.src/Gestion/Tables/Articles.class#L1456)
- [ ] TRIHISTOS-A02 — [anomalie] Fournisseur absent de `Fiches_Four` : `fours!fo_nom` /
  `fours!fo_code` lus sans test `Available` dans `Aff_StatAC` et `DocAchat` → erreur non interceptée à
  l'affichage de l'historique ou du détail · tests : T05 · sources : [TriHistos.class:253](../../../../.src/Affichages/TriHistos.class#L253), [TriHistos.class:647](../../../../.src/Affichages/TriHistos.class#L647), [TriHistos.class:648](../../../../.src/Affichages/TriHistos.class#L648)
- [ ] TRIHISTOS-A03 — [anomalie] (à confirmer en SQLite) La date de début des ventes est passée au
  format compact `aaaamm01` et comparée à des `datetime` (`datebl >= &2`, `datefac >= &2`,
  `daterecpt >= &2`) : MySQL convertit, SQLite compare des chaînes (`"2025-03-…" < "20250301"`), ce
  qui exclut les ventes de l'année de début. La période des ventes commence au 1er du mois, celle des
  achats au jour près · tests : T06 · sources : [TriHistos.class:47](../../../../.src/Affichages/TriHistos.class#L47), [TriHistos.class:88](../../../../.src/Affichages/TriHistos.class#L88), [TriHistos.class:105](../../../../.src/Affichages/TriHistos.class#L105), [TriHistos.class:239](../../../../.src/Affichages/TriHistos.class#L239)
- [ ] TRIHISTOS-A04 — [anomalie] `Fiches_Stat` est une table **permanente** détruite et recréée à
  chaque ouverture de l'historique des ventes : deux postes simultanés se détruisent mutuellement la
  table (résultat erroné ou erreur « table inexistante ») ; le `DROP`/`CREATE` valide aussi toute
  transaction en cours sur MySQL. Correction : table temporaire de session ou nom propre au poste ·
  tests : T01 · sources : [TriHistos.class:48](../../../../.src/Affichages/TriHistos.class#L48), [TriHistos.class:49](../../../../.src/Affichages/TriHistos.class#L49)
- [ ] TRIHISTOS-A05 — [anomalie] `DocVentes`, branche facture archivée : la quantité formatée
  (`Utils.CDec`) est écrite dans la colonne 2 puis écrasée par la désignation ; la colonne 3 reçoit la
  quantité brute et le code n'est affiché que si l'article existe encore (la branche BL est correcte) ·
  tests : T03 · sources : [TriHistos.class:537](../../../../.src/Affichages/TriHistos.class#L537), [TriHistos.class:538](../../../../.src/Affichages/TriHistos.class#L538), [TriHistos.class:540](../../../../.src/Affichages/TriHistos.class#L540)
