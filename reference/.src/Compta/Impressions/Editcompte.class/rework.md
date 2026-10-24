# Editcompte — Rework

> Source : `.src/Compta/Impressions/Editcompte.class` · Message de commit (phase 4) : `reference/.src/Compta/Impressions/Editcompte.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 579 |
| Lignes de commentaire | 123 |
| Fonctions | 38 |
| Fonctions Public | 38 |
| Complexité cyclomatique totale | 136 |
| Complexité max (fonction) | 56 (`Cmpt_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 579 | 136 | 56 | 0 | 38 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] EDITCOMPTE-001 — [documentation] En-tête en français : écran des **grands livres** (et non des
  extraits), natures `C/F/G/B/BG`, exercices ↔ `Tab0`, sorties (PDF via `EditcompteM`, export
  `~/tmp/Glivre.txt`), table de travail `Ctrln` · appelants : aucun · tests : aucun · sources : [Editcompte.class:_New](../../../../../.src/Compta/Impressions/Editcompte.class#L72-L94)
- [ ] EDITCOMPTE-002 — [code mort] Supprimer `content1`, `donnees2`, la variable `Filename` et son
  `Try Kill`, et dans `Button2_Click` les cumuls jamais écrits (hors période, `Slddeb`, `Sldcred`,
  `Sldtot`, `Libel`) ; variables de classe devenues inutiles · appelants : aucun · tests : T05 à T08 · sources : [Editcompte.class:content1](../../../../../.src/Compta/Impressions/Editcompte.class#L658-L662), [Editcompte.class:donnees2](../../../../../.src/Compta/Impressions/Editcompte.class#L670-L674), [Editcompte.class:Btn_Click](../../../../../.src/Compta/Impressions/Editcompte.class#L355-L374), [Editcompte.class:Button2_Click](../../../../../.src/Compta/Impressions/Editcompte.class#L729-L841)
- [ ] EDITCOMPTE-003 — [complexité] `Exo`…`Exo4` → chargeur privé unique ; `Cbase.Table("TabParam")`
  et `Cbase.Table("TabMvt…")`/`("TabComptes")` à la place des noms en dur (SQL identique) · appelants :
  aucun · tests : T01, T02, T04, T10 · sources : [Editcompte.class:Exo](../../../../../.src/Compta/Impressions/Editcompte.class#L123-L142), [Editcompte.class:Exo4](../../../../../.src/Compta/Impressions/Editcompte.class#L207-L222), [Editcompte.class:E0_Click](../../../../../.src/Compta/Impressions/Editcompte.class#L556-L561), [Editcompte.class:N5_Click](../../../../../.src/Compta/Impressions/Editcompte.class#L616-L621)
- [ ] EDITCOMPTE-004 — [complexité] `Cmpt_KeyPress` : extraire `MessageCompte(compte) As String` (règle
  de préfixe par nature, **y compris** la condition `Or` actuelle de `cpt2` en gestion) ; CC 56 → ~10 ·
  appelants : aucun · tests : T03 · sources : [Editcompte.class:Cmpt_KeyPress](../../../../../.src/Compta/Impressions/Editcompte.class#L250-L350)
- [ ] EDITCOMPTE-005 — [complexité] `_New` : remplacer la séquence `E0_Click`/`Exo`/`Ex1`/`E0.Value`
  par `E0_Click()` seul, **si** T01 et T02 montrent un état identique (SQL modifié : moins de lectures
  de `Fiches_Parametres`, dump identique) · appelants : aucun · tests : T01, T02 · sources : [Editcompte.class:_New](../../../../../.src/Compta/Impressions/Editcompte.class#L72-L94)
- [ ] EDITCOMPTE-006 — [commonalisation] `Centralisation`, `finmois`, `Raz` et la création de `Ctrln`
  → helper commun « centralisation » partagé avec `EditcompteM`, `EditcompteA` (`Ctrlnc`) et `Extrait`
  (nom de table et DDL en paramètre, SQL identique) ; `finmois` délègue à `LDate.Fin_Mois` · appelants :
  aucun · tests : T06, EDITCOMPTEM-T06, EDITCOMPTEM-T11 · sources : [Editcompte.class:Centralisation](../../../../../.src/Compta/Impressions/Editcompte.class#L685-L708), [Editcompte.class:finmois](../../../../../.src/Compta/Impressions/Editcompte.class#L713-L724), [EditcompteM.module:Centralisation](../../../../../.src/Compta/Impressions/EditcompteM.module#L294-L317), [EditcompteA.class:Centralisation](../../../../../.src/Compta/Impressions/EditcompteA.class#L777-L800), [Extrait.class:Centralisation](../../../../../.src/Compta/Extrait.class#L727-L750)
- [ ] EDITCOMPTE-007 — [commonalisation] Bornes d'exercice et contrôle de date via les helpers communs
  de BALANCE-004/005 (phase 3) · appelants : aucun · tests : T01, T04 · sources : [Editcompte.class:Ex1](../../../../../.src/Compta/Impressions/Editcompte.class#L99-L118), [Editcompte.class:Exo5](../../../../../.src/Compta/Impressions/Editcompte.class#L227-L245), [Editcompte.class:dteN0_LostFocus](../../../../../.src/Compta/Impressions/Editcompte.class#L387-L407), [Editcompte.class:dteN1_LostFocus](../../../../../.src/Compta/Impressions/Editcompte.class#L409-L437)
- [ ] EDITCOMPTE-008 — [séparation traitement/GUI] `Button2_Click` → `ExporteGrandLivre(…) As Boolean`
  sans contrôle ; filtre de dates en SQL comme `EditcompteM` (SQL modifié, dump identique) ; messages
  et son dans le handler · appelants : aucun · tests : T05 à T08, T10 · sources : [Editcompte.class:Button2_Click](../../../../../.src/Compta/Impressions/Editcompte.class#L729-L841), [Editcompte.class:donnees](../../../../../.src/Compta/Impressions/Editcompte.class#L664-L668)
- [ ] EDITCOMPTE-009 — [réduction de portée] `Ex1`, `Exo`…`Exo5`, `Compdate`, `compdate2`, `Raz`,
  `donnees`, `Centralisation`, `finmois` → `Private` (`Bsel`/`Bval` et `dteN*_LostFocus` restent
  `Public`) · appelants : aucun · tests : T01 à T10 · sources : [Editcompte.class:Ex1](../../../../../.src/Compta/Impressions/Editcompte.class#L99-L118), [Editcompte.class:Compdate](../../../../../.src/Compta/Impressions/Editcompte.class#L439-L450), [Editcompte.class:Raz](../../../../../.src/Compta/Impressions/Editcompte.class#L468-L481), [Editcompte.class:finmois](../../../../../.src/Compta/Impressions/Editcompte.class#L713-L724)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] EDITCOMPTE-A01 — [anomalie] Contrôle de `cpt2` en gestion : `… <> "6" Or … <> "7"` est toujours
  vrai : tout compte de fin est refusé au clavier en mode Gestion (`cpt` utilise correctement `And`) ·
  tests : T03 · sources : [Editcompte.class:312](../../../../../.src/Compta/Impressions/Editcompte.class#L312)
- [ ] EDITCOMPTE-A02 — [anomalie] Message fautif « Le compte saisit n'est un compte client ! »
  (texte affiché) · tests : T03 · sources : [Editcompte.class:273](../../../../../.src/Compta/Impressions/Editcompte.class#L273)
- [ ] EDITCOMPTE-A03 — [anomalie] `dteN1_LostFocus` appelle `Compdate` (focus sur `dteN0`) pour une
  date de fin antérieure au début de période, au lieu de `compdate2` · tests : T04 · sources : [Editcompte.class:418](../../../../../.src/Compta/Impressions/Editcompte.class#L418)
- [ ] EDITCOMPTE-A04 — [anomalie] `Compdate`/`compdate2` remettent la période sur l'exercice
  précédent (`Exo`) et cochent `E0` (même défaut que BALANCE-A04) · tests : T04 · sources : [Editcompte.class:445](../../../../../.src/Compta/Impressions/Editcompte.class#L445), [Editcompte.class:458](../../../../../.src/Compta/Impressions/Editcompte.class#L458)
- [ ] EDITCOMPTE-A05 — [anomalie] Export : `Close #hFile` seulement si des comptes existent (fichier
  laissé ouvert sinon), aucun `Catch`, message « extrait.txt » pour `~/tmp/Glivre.txt` · tests : T08 · sources : [Editcompte.class:826](../../../../../.src/Compta/Impressions/Editcompte.class#L826), [Editcompte.class:830](../../../../../.src/Compta/Impressions/Editcompte.class#L830)
- [ ] EDITCOMPTE-A06 — [anomalie] `Ctrln` : `DROP`/`CREATE` à chaque compte dans la boucle, table
  laissée en base et partagée par nom avec 5 autres éditions de structures différentes (collision
  multi-poste) ; toute correction change le dump · tests : T06 · sources : [Editcompte.class:755](../../../../../.src/Compta/Impressions/Editcompte.class#L755)
- [ ] EDITCOMPTE-A07 — [anomalie] Plage client par défaut incohérente : `411999999` à l'ouverture,
  `41999999` après clic sur Client (inclut 412…419) · tests : T01 · sources : [Editcompte.class:81](../../../../../.src/Compta/Impressions/Editcompte.class#L81), [Editcompte.class:489](../../../../../.src/Compta/Impressions/Editcompte.class#L489)
