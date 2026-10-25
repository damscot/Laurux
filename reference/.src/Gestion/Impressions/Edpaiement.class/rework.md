# Edpaiement — Rework

> Source : `.src/Gestion/Impressions/Edpaiement.class` · Message de commit (phase 4) : `reference/.src/Gestion/Impressions/Edpaiement.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 187 |
| Lignes de commentaire | 32 |
| Fonctions | 6 |
| Fonctions Public | 6 |
| Complexité cyclomatique totale | 44 |
| Complexité max (fonction) | 29 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 187 | 44 | 29 | 0 | 6 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] EDPAIEMENT-001 — [documentation] En-tête : sources des règlements (`reg`/`reg2`), rôle des
  boutons `Fact`/`Face`/`Facn`, table de travail `Paiements`, boutons sans handler · appelants :
  aucun · tests : aucun · sources : [Edpaiement.class:_New](../../../../../.src/Gestion/Impressions/Edpaiement.class#L34-L45), [Edpaiement.class:Button2_Click](../../../../../.src/Gestion/Impressions/Edpaiement.class#L102-L246)
- [ ] EDPAIEMENT-002 — [code mort] Supprimer `Shell "cd …"`, `p`, `Nbpage`, `dte`, les `INSERT`
  commentés et la branche « Aucun mouvement » inatteignable dans la boucle · appelants : aucun ·
  tests : T01-T07 · sources : [Edpaiement.class:138](../../../../../.src/Gestion/Impressions/Edpaiement.class#L138), [Edpaiement.class:149](../../../../../.src/Gestion/Impressions/Edpaiement.class#L149), [Edpaiement.class:200](../../../../../.src/Gestion/Impressions/Edpaiement.class#L200)
- [ ] EDPAIEMENT-003 — [réduction de portée] `date1_LostFocus` → `Private` (pseudo-handler d'un
  contrôle groupé, appelé seulement par `Cmpt_KeyPress`) · appelants : aucun · tests : T01 ·
  sources : [Edpaiement.class:date1_LostFocus](../../../../../.src/Gestion/Impressions/Edpaiement.class#L81-L93)
- [ ] EDPAIEMENT-004 — [complexité] `Button2_Click` (CC 29) : extraire `LibelleTotal(n, mode,
  total, devise)`, `NouvellePage(mode)` et `RequeteDocuments(sDate)` ; sortie PDF identique ·
  appelants : aucun · tests : T01-T07 · sources : [Edpaiement.class:Button2_Click](../../../../../.src/Gestion/Impressions/Edpaiement.class#L102-L246)
- [ ] EDPAIEMENT-005 — [séparation traitement/GUI] `ReglementsDuJour(sDate, iSource)` sans accès
  aux contrôles (SQL inchangé) ; `Cbase.Table` pour `TabParam`, `TabBl`, `TabBlM` (SQL identique)
  · appelants : aucun · tests : T01-T04 · sources : [Edpaiement.class:124](../../../../../.src/Gestion/Impressions/Edpaiement.class#L124), [Edpaiement.class:144](../../../../../.src/Gestion/Impressions/Edpaiement.class#L144), [Edpaiement.class:165](../../../../../.src/Gestion/Impressions/Edpaiement.class#L165)
- [ ] EDPAIEMENT-006 — [réarchitecture] Remplacer la table de travail `Paiements` (DROP/CREATE à
  chaque impression) par une liste en mémoire triée par mode puis numéro (SQL modifié ; dump
  identique hors table de travail ; texte PDF identique) · appelants : aucun · tests : T01-T07 ·
  sources : [Edpaiement.class:131](../../../../../.src/Gestion/Impressions/Edpaiement.class#L131), [Edpaiement.class:132](../../../../../.src/Gestion/Impressions/Edpaiement.class#L132), [Edpaiement.class:155](../../../../../.src/Gestion/Impressions/Edpaiement.class#L155)
- [ ] EDPAIEMENT-007 — [commonalisation] Saisie de date via le helper commun aux écrans de
  période (`Edregul`, `Edregulprdc`) · appelants : aucun · tests : T01 · sources : [Edpaiement.class:Cmpt_KeyPress](../../../../../.src/Gestion/Impressions/Edpaiement.class#L50-L68), [Edregul.class:Cmpt_KeyPress](../../../../../.src/Gestion/Impressions/Edregul.class#L50-L78)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] EDPAIEMENT-A01 — [anomalie, à confirmer] Filtre `dtefac = &1` sur un `datetime` : les
  factures dont la date porte une heure (factures de caisse, `LDate.DT`) sont absentes de la liste ;
  correction : intervalle `[jour, jour + 1[` · tests : T06 · sources : [Edpaiement.class:144](../../../../../.src/Gestion/Impressions/Edpaiement.class#L144), [Edpaiement.class:145](../../../../../.src/Gestion/Impressions/Edpaiement.class#L145), [Edpaiement.class:146](../../../../../.src/Gestion/Impressions/Edpaiement.class#L146), [Moulinage.class:1336](../../../../../.src/Caisse/Moulinage.class#L1336)
- [ ] EDPAIEMENT-A02 — [anomalie, à confirmer] En mode `Fact`, la relecture par `numbl` fait
  l'`UNION` des deux tables : un numéro présent dans `Fiches_Bl` et `Fiches_BlM` imprime les deux
  documents sous chaque règlement · tests : T01 · sources : [Edpaiement.class:165](../../../../../.src/Gestion/Impressions/Edpaiement.class#L165)
