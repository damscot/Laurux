# Journaux — Rework

> Source : `.src/Compta/Impressions/Journaux.class` · Message de commit (phase 4) : `reference/.src/Compta/Impressions/Journaux.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 621 |
| Lignes de commentaire | 33 |
| Fonctions | 45 |
| Fonctions Public | 45 |
| Complexité cyclomatique totale | 129 |
| Complexité max (fonction) | 22 (`Button4_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 621 | 129 | 22 | 0 | 45 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] JOURNAUX-001 — [documentation] En-tête en français : rôle de l'écran, choix d'exercice
  (`Tab0`, `dte1`/`dte2`), contrat des clés `/ExportJournal<soc>/…` et format du fichier
  `journaux.txt` · appelants : aucun · tests : aucun · sources : [Journaux.class:1-25](../../../../../.src/Compta/Impressions/Journaux.class#L1-L25), [Journaux.class:Button4_Click](../../../../../.src/Compta/Impressions/Journaux.class#L653-L784)
- [ ] JOURNAUX-002 — [code mort] Supprimer `Createtable`, `donnees1`, `donnees2`, `Janx`, les
  variables et cumuls jamais lus (`DebhP`, `CredhP`, `TotSldhP`, `Db_ction`, `Cd_ction`, `TotDeb`,
  `TotCred`, `TotSld` dans `Button4_Click`), la lecture inutile de `dtepc` et le calcul `dte`/`jour`
  écrasé, la requête `Fiches_Comptes` sur les collectifs (`Intitcol` jamais lu) ; SQL modifié
  (deux `SELECT` en moins), dump identique · appelants : aucun · tests : T01, T06, T09 · sources : [Journaux.class:Createtable](../../../../../.src/Compta/Impressions/Journaux.class#L591-L603), [Journaux.class:donnees1](../../../../../.src/Compta/Impressions/Journaux.class#L626-L630), [Journaux.class:donnees2](../../../../../.src/Compta/Impressions/Journaux.class#L632-L636), [Journaux.class:83](../../../../../.src/Compta/Impressions/Journaux.class#L83), [Journaux.class:695-699](../../../../../.src/Compta/Impressions/Journaux.class#L695-L699), [Journaux.class:713-717](../../../../../.src/Compta/Impressions/Journaux.class#L713-L717)
- [ ] JOURNAUX-003 — [commonalisation] Adopter le helper commun `Bornes(index)`
  de BALANCE-004 et créer `ImpCompta.TableMvt(index)` (`Cbase.Table("TabMvt…")`, mêmes noms physiques) ; `Ex1`, `Exo`…`Exo5`
  et `E0_Click`…`N5_Click` y délèguent, dates affichées identiques (y compris `Exo5` et la
  bascule d'`Ex1`) · appelants : aucun (même helper que JOURNAUXA-003, JOURCENT-003, EXPORTA47-003,
  BALANCE-004, EDITCOMPTE-007) · tests : T01, T02 · sources : [Journaux.class:Ex1](../../../../../.src/Compta/Impressions/Journaux.class#L71-L96), [Journaux.class:Exo](../../../../../.src/Compta/Impressions/Journaux.class#L98-L116), [Journaux.class:Exo5](../../../../../.src/Compta/Impressions/Journaux.class#L182-L201), [Journaux.class:E0_Click](../../../../../.src/Compta/Impressions/Journaux.class#L542-L547), [Journaux.class:N5_Click](../../../../../.src/Compta/Impressions/Journaux.class#L584-L589)
- [ ] JOURNAUX-004 — [commonalisation] Adopter `ControleDate(texte, debut, fin)` de BALANCE-005 (sans GUI, variante de complétion pour `JournauxA`) dans `dteN0_LostFocus`/`dteN1_LostFocus` (mêmes messages, même enchaînement
  `Compdate`/`compdate2`) · appelants : aucun · tests : T03 · sources : [Journaux.class:dteN0_LostFocus](../../../../../.src/Compta/Impressions/Journaux.class#L378-L399), [Journaux.class:dteN1_LostFocus](../../../../../.src/Compta/Impressions/Journaux.class#L407-L436), [Journaux.class:Compdate](../../../../../.src/Compta/Impressions/Journaux.class#L438-L450), [Journaux.class:compdate2](../../../../../.src/Compta/Impressions/Journaux.class#L452-L464)
- [ ] JOURNAUX-005 — [commonalisation] Créer `ImpCompta.ListeJournaux(hCol)` (bascule
  visible/masqué, colonnes, `SELECT … Fiches_Journaux order by code_jo` via `Cbase.Table("TabJour")`)
  pour `ToggleButton3_Click`/`ToggleButton2_Click` ; un helper privé commun pour
  `coljour_*`/`coljour2_*` · appelants : aucun (repris par JOURCENT-003, ExportJdv) · tests : T04 · sources : [Journaux.class:ToggleButton3_Click](../../../../../.src/Compta/Impressions/Journaux.class#L203-L233), [Journaux.class:ToggleButton2_Click](../../../../../.src/Compta/Impressions/Journaux.class#L235-L265), [Journaux.class:coljour_KeyPress](../../../../../.src/Compta/Impressions/Journaux.class#L480-L502), [Journaux.class:coljour2_KeyPress](../../../../../.src/Compta/Impressions/Journaux.class#L518-L540)
- [ ] JOURNAUX-006 — [complexité] `Button4_Click` : lire une fois la correspondance des colonnes
  (`Integer[]`) avant la boucle au lieu de 32 lectures de configuration par ligne ; contenu du
  fichier identique · appelants : aucun · tests : T06, T08 · sources : [Journaux.class:741-760](../../../../../.src/Compta/Impressions/Journaux.class#L741-L760)
- [ ] JOURNAUX-007 — [séparation traitement/GUI] Extraire `ExporteJournaux(sFichier, sJ1, sJ2,
  sDeb, sFin, sTab) As Integer` (SQL + écriture du fichier, sans contrôle) ; `Button4_Click` garde
  le test de configuration, le curseur, `Panel2` et les messages · appelants : aucun · tests :
  T06-T09 · sources : [Journaux.class:Button4_Click](../../../../../.src/Compta/Impressions/Journaux.class#L653-L784)
- [ ] JOURNAUX-008 — [complexité] Filtrer la période en SQL (`dte >= début` et `dte < lendemain
  de la fin`, pour inclure les heures non nulles comme `Cdate_Comp`) au lieu de lire tout
  l'exercice ; SQL modifié, dump et fichier identiques (à vérifier sous SQLite) · appelants :
  aucun · tests : T06, T09 · sources : [Journaux.class:706](../../../../../.src/Compta/Impressions/Journaux.class#L706), [Journaux.class:710](../../../../../.src/Compta/Impressions/Journaux.class#L710)
- [ ] JOURNAUX-009 — [réduction de portée] `Ex1`, `Exo`…`Exo5`, `Compdate`, `compdate2`,
  `Colonnes`, `donnees3`, `Raz` → `Private` (aucun appelant externe, grep) · appelants : aucun ·
  tests : T01-T09 · sources : [Journaux.class:Ex1](../../../../../.src/Compta/Impressions/Journaux.class#L71-L96), [Journaux.class:Colonnes](../../../../../.src/Compta/Impressions/Journaux.class#L793-L808), [Journaux.class:donnees3](../../../../../.src/Compta/Impressions/Journaux.class#L638-L642), [Journaux.class:Raz](../../../../../.src/Compta/Impressions/Journaux.class#L611-L624)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] JOURNAUX-A01 — [anomalie] `Button1_Click` passe la commande `RadioButton1` (objet, converti
  en `True`) au lieu de `RadioButton1.Value` : le tri « numéro/date/compte » n'est jamais appliqué
  à l'impression · tests : T05, JOURNAUXM-T01 · sources : [Journaux.class:607](../../../../../.src/Compta/Impressions/Journaux.class#L607), [JournauxM.module:96](../../../../../.src/Compta/Impressions/JournauxM.module#L96)
- [ ] JOURNAUX-A02 — [anomalie] Export : le solde de ligne n'est jamais remis à zéro (`pl` n'est
  jamais incrémenté, `Raz` ne touche pas `solde`) ; il court d'un journal à l'autre et d'un export
  à l'autre dans la même session · tests : T08 · sources : [Journaux.class:721](../../../../../.src/Compta/Impressions/Journaux.class#L721), [Journaux.class:733-737](../../../../../.src/Compta/Impressions/Journaux.class#L733-L737), [Journaux.class:Raz](../../../../../.src/Compta/Impressions/Journaux.class#L611-L624)
- [ ] JOURNAUX-A03 — [anomalie] Export : `q[]` n'est pas réinitialisé ; après réduction du nombre
  de colonnes dans la session, les colonnes non configurées reprennent les valeurs de l'export
  précédent (12 champs toujours écrits) · tests : T08 · sources : [Journaux.class:753-760](../../../../../.src/Compta/Impressions/Journaux.class#L753-L760)
- [ ] JOURNAUX-A04 — [anomalie] Export : `DROP`/`CREATE` de la table `centralisation` (types
  `FLOAT`/`Char(40)` différents de `JournauxM`) sans usage ; la suppression change le dump ·
  tests : T06 · sources : [Journaux.class:683-690](../../../../../.src/Compta/Impressions/Journaux.class#L683-L690)
- [ ] JOURNAUX-A05 — [anomalie] Quitter : `Kill filename` sur une variable jamais affectée,
  `~/tmp/Journaux.pdf` n'est pas supprimé (contrairement à `Jourcent`) · tests : T10 · sources : [Journaux.class:340](../../../../../.src/Compta/Impressions/Journaux.class#L340)
- [ ] JOURNAUX-A06 — [anomalie] Export : boucle `For y = 0 To 15` sur `q` de taille 12 ;
  dépassement d'indice si `Entete12..15` est renseigné (configuration modifiée à la main) ·
  tests : T06 · sources : [Journaux.class:753-756](../../../../../.src/Compta/Impressions/Journaux.class#L753-L756), [Journaux.class:52-53](../../../../../.src/Compta/Impressions/Journaux.class#L52-L53)
- [ ] JOURNAUX-A07 — [anomalie] Date hors bornes ou fin < début : `Exo()` recharge les dates de
  l'**exercice précédent** puis coche « Exercice en cours » (`E0.Value = True`). Si ce changement
  ne déclenche pas `E0_Click` (à confirmer), `Tab0` garde la table de l'exercice choisi (ex. `N3`
  → requêtes sur `Fiches_Mvt3` avec les dates de l'exercice précédent : journaux vides) ; s'il le
  déclenche, `Ex1` écrase aussitôt les dates. Dans tous les cas la saisie est remplacée par une
  autre période que celle de l'exercice sélectionné · tests : T03 · sources : [Journaux.class:427-429](../../../../../.src/Compta/Impressions/Journaux.class#L427-L429), [Journaux.class:Compdate](../../../../../.src/Compta/Impressions/Journaux.class#L438-L450), [Journaux.class:compdate2](../../../../../.src/Compta/Impressions/Journaux.class#L452-L464)
