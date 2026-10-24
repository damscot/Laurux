# EcrM — Rework

> Source : `.src/Compta/Impressions/EcrM.class` · Message de commit (phase 4) : `reference/.src/Compta/Impressions/EcrM.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 485 |
| Lignes de commentaire | 33 |
| Fonctions | 35 |
| Fonctions Public | 34 |
| Complexité cyclomatique totale | 105 |
| Complexité max (fonction) | 34 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 485 | 105 | 34 | 0 | 34 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] ECRM-001 — [documentation] Corriger l'en-tête (nom « Journaux.class », rôle « Edition des
  journaux ») : écran d'édition des écritures modifiées/supprimées (`Fiches_MvtM*`) ; commentaires
  `'''` sur chaque fonction, signalement du groupe `Cmpt` (handlers appelés explicitement) ·
  appelants : aucun · tests : aucun · sources : [EcrM.class:20-25](../../../../../.src/Compta/Impressions/EcrM.class#L20-L25), [EcrM.class:Cmpt_KeyPress](../../../../../.src/Compta/Impressions/EcrM.class#L164-L191)
- [ ] ECRM-002 — [code mort] Supprimer `donnees1/2/3`, `hfile`, `Filetxt`, `Tab0` et ses
  affectations, les cumuls jamais imprimés (`DebhP`, `CredhP`, `TotSldhP`, `TotDeb`, `TotCred`,
  `TotSld`, `Db_ction`, `Cd_ction`, `TotDeb2`, `TotCred2`, `debitcol`, `creditcol`, `Ccoll`), `Datep`,
  `Tab2`, `Shell "cd"`, la branche `type_jour = "VE"` (jamais vraie) et les paramètres surnuméraires
  de l'`Exec` filtré · appelants : aucun · tests : T03-T05 · sources : [EcrM.class:donnees1](../../../../../.src/Compta/Impressions/EcrM.class#L593-L597), [EcrM.class:donnees3](../../../../../.src/Compta/Impressions/EcrM.class#L605-L609), [EcrM.class:Raz](../../../../../.src/Compta/Impressions/EcrM.class#L578-L591), [EcrM.class:424](../../../../../.src/Compta/Impressions/EcrM.class#L424), [EcrM.class:436-437](../../../../../.src/Compta/Impressions/EcrM.class#L436-L437), [EcrM.class:442](../../../../../.src/Compta/Impressions/EcrM.class#L442), [EcrM.class:526](../../../../../.src/Compta/Impressions/EcrM.class#L526)
- [ ] ECRM-003 — [code mort] Supprimer `Createtable` et son appel (table `centralisation` ni
  alimentée ni lue ici). SQL modifié ; le dump ne diffère que par la table de travail
  `centralisation`, à exclure du dump normalisé (décision utilisateur, sinon anomalie) ·
  appelants : aucun · tests : T03 · sources : [EcrM.class:Createtable](../../../../../.src/Compta/Impressions/EcrM.class#L362-L374), [EcrM.class:420](../../../../../.src/Compta/Impressions/EcrM.class#L420)
- [ ] ECRM-004 — [complexité] Supprimer les alias `Exo`…`Exo5` : appels directs `exercice(n)`
  depuis les handlers, `Ex1` et `Compdate*` · appelants : aucun · tests : T01, T02 · sources : [EcrM.class:Exo](../../../../../.src/Compta/Impressions/EcrM.class#L95-L99), [EcrM.class:Exo5](../../../../../.src/Compta/Impressions/EcrM.class#L125-L129), [EcrM.class:exercice](../../../../../.src/Compta/Impressions/EcrM.class#L131-L162)
- [ ] ECRM-005 — [commonalisation] Handlers d'exercice : `Tab1 = Cbase.Table("TabMvtM" & suffixe)`
  ; `Fiches_Parametres`, `Fiches_Societes`, `Fiches_Comptes` via `Cbase.Table` · appelants :
  aucun · tests : T02-T04 · sources : [EcrM.class:E0_Click](../../../../../.src/Compta/Impressions/EcrM.class#L306-L312), [EcrM.class:N5_Click](../../../../../.src/Compta/Impressions/EcrM.class#L354-L360), [EcrM.class:136](../../../../../.src/Compta/Impressions/EcrM.class#L136), [EcrM.class:412-415](../../../../../.src/Compta/Impressions/EcrM.class#L412-L415)
- [ ] ECRM-006 — [complexité] `Compdate`/`compdate2` fusionnées (paramètre : contrôle à
  refocaliser) · appelants : aucun · tests : T08 · sources : [EcrM.class:Compdate](../../../../../.src/Compta/Impressions/EcrM.class#L278-L290), [EcrM.class:compdate2](../../../../../.src/Compta/Impressions/EcrM.class#L292-L304)
- [ ] ECRM-007 — [complexité] `Button1_Click` : extraction de `ImprimeLigne` et cache local des
  comptes lus (une requête par compte distinct ; SQL modifié, dump identique), CC 34 → ≤ 15 visé
  · appelants : aucun · tests : T03-T06, T09 · sources : [EcrM.class:Button1_Click](../../../../../.src/Compta/Impressions/EcrM.class#L376-L576)
- [ ] ECRM-008 — [séparation traitement/GUI] Fonctions sans contrôle : `Bornes_Exercice(ind)`
  (lecture par `LDate.Exercice_Cloture`), `Date_Hors_Periode(sDate, sDebut, sFin)`,
  `Requete_Modifs(sTable, sDebut, sFin, sType, sOrdre)` · appelants : aucun · tests : T02, T08,
  T11, T12 · sources : [EcrM.class:exercice](../../../../../.src/Compta/Impressions/EcrM.class#L131-L162), [EcrM.class:dteN0_LostFocus](../../../../../.src/Compta/Impressions/EcrM.class#L218-L239), [EcrM.class:440-443](../../../../../.src/Compta/Impressions/EcrM.class#L440-L443), [LDate.class:Exercice_Cloture](../../../../../.src/Utils/LDate.class#L648-L672)
- [ ] ECRM-009 — [réduction de portée] `Ex1`, `Exo`…`Exo5` (si conservés), `Compdate`,
  `compdate2`, `Raz` → `Private` (aucun appel externe, grep vérifié) · appelants : aucun ·
  tests : T01-T08 · sources : [EcrM.class:Ex1](../../../../../.src/Compta/Impressions/EcrM.class#L69-L93), [EcrM.class:Compdate](../../../../../.src/Compta/Impressions/EcrM.class#L278-L290), [EcrM.class:compdate2](../../../../../.src/Compta/Impressions/EcrM.class#L292-L304), [EcrM.class:Raz](../../../../../.src/Compta/Impressions/EcrM.class#L578-L591)
- [ ] ECRM-010 — [commonalisation] (transverse) Socle commun des éditions comptables (EDITCOMPTE-006) :
  en-tête société, fichier PDF, `Termine`, saisie de date normalisée ; bornes d'exercice par le
  helper commun `Bornes(index)` de BALANCE-004 (dont EcrM fait partie), `exercice(ind)` servant de
  modèle · appelants : aucun · tests : T01-T04 ·
  sources : [EcrM.class:421-422](../../../../../.src/Compta/Impressions/EcrM.class#L421-L422), [EcrM.class:dteN0_LostFocus](../../../../../.src/Compta/Impressions/EcrM.class#L218-L239), [EcrM.class:exercice](../../../../../.src/Compta/Impressions/EcrM.class#L131-L162)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] ECRM-A01 — [anomalie] La date de fin n'est jamais validée : `Cmpt_KeyPress` teste le tag 4
  (copié de `Journaux`) au lieu du tag 2 de `Dten1`, et `dteN1_LostFocus` n'est jamais appelé
  (groupe `Cmpt`) : saisie non normalisée (« 3112 » envoyé tel quel à `Cdate2_Dbase`), pas de
  contrôle fin < début · tests : T08 · sources : [EcrM.class:177-183](../../../../../.src/Compta/Impressions/EcrM.class#L177-L183), [EcrM.class:dteN1_LostFocus](../../../../../.src/Compta/Impressions/EcrM.class#L247-L276)
- [ ] ECRM-A02 — [anomalie] `Journaux.Mouse` au lieu de `Me.Mouse` : le curseur d'EcrM ne change
  pas et l'auto-instance du formulaire `Journaux` est créée en mémoire (son `_New` interroge la
  base) ; le curseur n'est pas restauré après `Message.Error` · tests : T06, T13 · sources : [EcrM.class:419](../../../../../.src/Compta/Impressions/EcrM.class#L419), [EcrM.class:465-466](../../../../../.src/Compta/Impressions/EcrM.class#L465-L466), [EcrM.class:570](../../../../../.src/Compta/Impressions/EcrM.class#L570)
- [ ] ECRM-A03 — [anomalie] Après un saut de page, le titre est toujours « Impression des
  écritures modifiées… », même pour « Toutes » ou « Supprimées » · tests : T05 · sources : [EcrM.class:544](../../../../../.src/Compta/Impressions/EcrM.class#L544)
- [ ] ECRM-A04 — [anomalie] `datem` nul : ligne 401/411/453 non imprimée mais espace consommé ;
  autres comptes : `Format$(Null, "dd.mm.yy")` (erreur ou chaîne vide, à confirmer) · tests :
  T09 · sources : [EcrM.class:527](../../../../../.src/Compta/Impressions/EcrM.class#L527), [EcrM.class:531-533](../../../../../.src/Compta/Impressions/EcrM.class#L531-L533)
- [ ] ECRM-A05 — [anomalie] Numérotation des pages : `ipage` non initialisé (0) → « Page N° 0 »
  sur la première page, décalage d'une unité ensuite ; le qualificatif « Edition provisoire »
  (`Qual`) est calculé mais jamais imprimé · tests : T05, T10 · sources : [EcrM.class:400](../../../../../.src/Compta/Impressions/EcrM.class#L400), [EcrM.class:543](../../../../../.src/Compta/Impressions/EcrM.class#L543), [EcrM.class:431-435](../../../../../.src/Compta/Impressions/EcrM.class#L431-L435)
- [ ] ECRM-A06 — [anomalie] Le PDF `~/tmp/Journaux.pdf` porte le même nom que celui de l'édition
  des journaux (écrasement mutuel ; « Quitter » le supprime) ; aide `Doc.Open("Editjournaux")`
  héritée de `Journaux` · tests : T03 · sources : [EcrM.class:418](../../../../../.src/Compta/Impressions/EcrM.class#L418), [EcrM.class:204](../../../../../.src/Compta/Impressions/EcrM.class#L204), [EcrM.class:Button3_Click](../../../../../.src/Compta/Impressions/EcrM.class#L611-L615)
