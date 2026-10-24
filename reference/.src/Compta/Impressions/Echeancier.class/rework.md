# Echeancier — Rework

> Source : `.src/Compta/Impressions/Echeancier.class` · Message de commit (phase 4) : `reference/.src/Compta/Impressions/Echeancier.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 386 |
| Lignes de commentaire | 46 |
| Fonctions | 23 |
| Fonctions Public | 23 |
| Complexité cyclomatique totale | 67 |
| Complexité max (fonction) | 28 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 386 | 67 | 28 | 0 | 23 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] ECHEANCIER-001 — [documentation] En-tête corrigé (nom « Balance.class », date
  « 17/10/202014 ») : rôle, sélection (validées, non lettrées, hors trésorerie et collectif),
  inversion des noms `Dten0` (fin) / `Dten1` (début) ; commentaires `'''` · appelants : aucun ·
  tests : aucun · sources : [Echeancier.class:1-26](../../../../../.src/Compta/Impressions/Echeancier.class#L1-L26), [Echeancier.class:_New](../../../../../.src/Compta/Impressions/Echeancier.class#L49-L71)
- [ ] ECHEANCIER-002 — [code mort] Supprimer les méthodes `Draw` `Level0`, `Level1E`, `level2`,
  `Level3`, `Level4`, `Level5` (aucun appel), les variables `Tab`, `Tab2`, `debit`, `credit`,
  `solde`, `p`, `Nbpage`, `dte` et le `Shell "cd"` · appelants : aucun · tests : T02-T06 ·
  sources : [Echeancier.class:Level0](../../../../../.src/Compta/Impressions/Echeancier.class#L284-L293), [Echeancier.class:Level1E](../../../../../.src/Compta/Impressions/Echeancier.class#L296-L321), [Echeancier.class:level2](../../../../../.src/Compta/Impressions/Echeancier.class#L324-L340), [Echeancier.class:Level3](../../../../../.src/Compta/Impressions/Echeancier.class#L343-L351), [Echeancier.class:Level4](../../../../../.src/Compta/Impressions/Echeancier.class#L354-L368), [Echeancier.class:Level5](../../../../../.src/Compta/Impressions/Echeancier.class#L371-L385), [Echeancier.class:124-130](../../../../../.src/Compta/Impressions/Echeancier.class#L124-L130)
- [ ] ECHEANCIER-003 — [complexité] Helper privé `SautPage()` pour les quatre blocs
  `PosY >= 280` ; clé de rupture unique (échéance ou compte) · appelants : aucun · tests :
  T02-T06 · sources : [Echeancier.class:Button2_Click](../../../../../.src/Compta/Impressions/Echeancier.class#L111-L281)
- [ ] ECHEANCIER-004 — [complexité] Inversion de signe par `-montant` aux deux endroits où
  `montant > 0` est garanti (valeur identique) · appelants : aucun · tests : T02, T05 · sources : [Echeancier.class:191](../../../../../.src/Compta/Impressions/Echeancier.class#L191), [Echeancier.class:195](../../../../../.src/Compta/Impressions/Echeancier.class#L195)
- [ ] ECHEANCIER-005 — [complexité] Une seule construction de la requête d'échéances (jointure
  `Fiches_Cli` et filtre `cli_reg` conditionnels, `ORDER BY` selon le tri, tables par
  `Cbase.Table`) ; SQL modifié, mêmes lignes, dump identique. Requiert une clé `Cbase` pour
  `Fiches_Reglements` (appelant impacté : `Cbase`) · appelants : `Cbase` · tests : T01-T05, T10 ·
  sources : [Echeancier.class:149-157](../../../../../.src/Compta/Impressions/Echeancier.class#L149-L157), [Echeancier.class:64](../../../../../.src/Compta/Impressions/Echeancier.class#L64), [Echeancier.class:126](../../../../../.src/Compta/Impressions/Echeancier.class#L126)
- [ ] ECHEANCIER-006 — [réduction de portée] `Raz` → `Private` · appelants : aucun · tests :
  T02 · sources : [Echeancier.class:Raz](../../../../../.src/Compta/Impressions/Echeancier.class#L76-L86)
- [ ] ECHEANCIER-007 — [séparation traitement/GUI] `Requete_Echeances(...)`,
  `Reglements_Lot(sNumlot, sCompte)` et `Montant_Signe(...)` sans accès aux contrôles ;
  `Button2_Click` ne fait plus que le rendu · appelants : aucun · tests : T02-T07, T09 · sources : [Echeancier.class:Button2_Click](../../../../../.src/Compta/Impressions/Echeancier.class#L111-L281)
- [ ] ECHEANCIER-008 — [commonalisation] (transverse) Socle commun des éditions comptables :
  en-tête société, PDF, `Termine`, saisie de date (`dteN0_LostFocus`/`dteN1_LostFocus`), bascule du
  `DateChooser` (partagée avec `BordereauxC`) ; clôtures par `LDate.Exercice_Cloture(0|1)` ·
  appelants : aucun · tests : T01, T08 · sources : [Echeancier.class:dteN0_LostFocus](../../../../../.src/Compta/Impressions/Echeancier.class#L398-L410), [Echeancier.class:dteN1_LostFocus](../../../../../.src/Compta/Impressions/Echeancier.class#L434-L446), [Echeancier.class:Dten0_DblClick](../../../../../.src/Compta/Impressions/Echeancier.class#L387-L396), [Echeancier.class:58-60](../../../../../.src/Compta/Impressions/Echeancier.class#L58-L60), [BordereauxC.class:Dateb_DblClick](../../../../../.src/Compta/Impressions/BordereauxC.class#L184-L192)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] ECHEANCIER-A01 — [anomalie] Règlements : signe inversé par `"-" & montant` sans test du
  signe (« --x » pour un montant négatif : erreur de conversion probable, à confirmer) ; seuls les
  règlements dans le sens attendu sont cumulés, les autres sont imprimés mais ignorés dans le
  total · tests : T07 · sources : [Echeancier.class:216-228](../../../../../.src/Compta/Impressions/Echeancier.class#L216-L228)
- [ ] ECHEANCIER-A02 — [anomalie] `dateedition` n'est jamais renseigné : l'en-tête imprime
  « Sélection » sans la période choisie · tests : T02 · sources : [Echeancier.class:117](../../../../../.src/Compta/Impressions/Echeancier.class#L117), [Echeancier.class:138](../../../../../.src/Compta/Impressions/Echeancier.class#L138)
- [ ] ECHEANCIER-A03 — [anomalie] Le filtre « Mode de règlement » est ignoré pour les
  fournisseurs et pour le tri par compte, sans avertissement · tests : T04, T05 · sources : [Echeancier.class:150](../../../../../.src/Compta/Impressions/Echeancier.class#L150), [Echeancier.class:156](../../../../../.src/Compta/Impressions/Echeancier.class#L156)
- [ ] ECHEANCIER-A04 — [anomalie] Pas de saut de page dans la boucle des règlements : les lignes
  peuvent déborder du bas de page (à confirmer selon le saut automatique de `PdfWriter`) ; pied de
  page sur la dernière page seulement · tests : T06 · sources : [Echeancier.class:213-237](../../../../../.src/Compta/Impressions/Echeancier.class#L213-L237), [Echeancier.class:274](../../../../../.src/Compta/Impressions/Echeancier.class#L274)
- [ ] ECHEANCIER-A05 — [anomalie] Borne « Du » par défaut = date de clôture N-1 elle-même (le
  dernier jour de N-1 est inclus) ; `dteN1_LostFocus` remet le fond de `dteN0` · tests : T01, T08
  · sources : [Echeancier.class:60](../../../../../.src/Compta/Impressions/Echeancier.class#L60), [Echeancier.class:441](../../../../../.src/Compta/Impressions/Echeancier.class#L441)
