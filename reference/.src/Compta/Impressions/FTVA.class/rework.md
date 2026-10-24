# FTVA — Rework

> Source : `.src/Compta/Impressions/FTVA.class` · Message de commit (phase 4) : `reference/.src/Compta/Impressions/FTVA.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 697 |
| Lignes de commentaire | 4 |
| Fonctions | 16 |
| Fonctions Public | 16 |
| Complexité cyclomatique totale | 133 |
| Complexité max (fonction) | 51 (`button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 697 | 133 | 51 | 0 | 16 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] FTVA-001 — [documentation] En-tête en français : rôle (récapitulatif TVA 4456/4457 sur
  `Fiches_Mvt`), modes de période, sens des soldes, fichier produit ; commentaires `'''` sur chaque
  fonction · appelants : aucun · tests : aucun · sources : [FTVA.class:1-30](../../../../../.src/Compta/Impressions/FTVA.class#L1-L30), [FTVA.class:Affiche](../../../../../.src/Compta/Impressions/FTVA.class#L72-L222)
- [ ] FTVA-002 — [code mort] Supprimer les variables jamais lues (`dten0`, `dten1`, `Coulfond`,
  `DebP`, `CredP`, `Tothtdeb`, `Tothtcred`, `exon`, `debutOpen` et ses affectations redondantes
  dans `trimestre`), le calcul `tmpMois`/`dten*` de `Form_Open`, les locales `Totd`/`Totc` de
  `RadioBtnmensuel_Click`, `tmpMois`/`tmpMois2`/`Datj`/`libelle`/`jour`/`Slddeb`/`Sldcred` de
  `button2_Click` (passer 0 à `Level5T`), le `Shell "cd"` et la trace `Print cptresult.count`
  (sortie standard) · appelants : aucun · tests : T01-T07 · sources : [FTVA.class:Form_Open](../../../../../.src/Compta/Impressions/FTVA.class#L32-L70), [FTVA.class:trimestre](../../../../../.src/Compta/Impressions/FTVA.class#L379-L396), [FTVA.class:139](../../../../../.src/Compta/Impressions/FTVA.class#L139), [FTVA.class:485](../../../../../.src/Compta/Impressions/FTVA.class#L485), [FTVA.class:501-510](../../../../../.src/Compta/Impressions/FTVA.class#L501-L510)
- [ ] FTVA-003 — [code mort] Supprimer les requêtes `Fiches_Journaux` dont le résultat est ignoré
  (une par écriture) et les paramètres inutilisés de l'`Exec` annuel (SQL modifié, dump
  identique) · appelants : aucun · tests : T01-T07 · sources : [FTVA.class:136](../../../../../.src/Compta/Impressions/FTVA.class#L136), [FTVA.class:141](../../../../../.src/Compta/Impressions/FTVA.class#L141), [FTVA.class:601](../../../../../.src/Compta/Impressions/FTVA.class#L601)
- [ ] FTVA-004 — [code mort] Supprimer le `DROP`/`CREATE TABLE Ctrln` de `button2_Click` (table
  jamais alimentée ici). SQL modifié ; le dump ne diffère que par la table de travail `Ctrln`, à
  exclure du dump normalisé (décision utilisateur, sinon reclasser en anomalie). Vérifier avant que
  `Editcompte` (l. 691) ne lit `Ctrln` qu'après l'avoir créée (l. 755). Le nom `Ctrln` est partagé
  par 5 éditions de structures différentes (collision multi-poste, voir EDITCOMPTE-A06) : la
  suppression ici réduit ce risque · appelants : aucun ·
  tests : T05 · sources : [FTVA.class:574-584](../../../../../.src/Compta/Impressions/FTVA.class#L574-L584), [Editcompte.class:691](../../../../../.src/Compta/Impressions/Editcompte.class#L691)
- [ ] FTVA-005 — [commonalisation] `Calcul_Recap()` privé : séquence commune des trois
  `RadioBtn*_Click` (vider, ventes, achats, totaux, TVA à déclarer), chaque handler ne fixant que
  `mois1`/`mois2`/`Annee` · appelants : aucun · tests : T01-T04, T08 · sources : [FTVA.class:RadioBtnTrimestre_Click](../../../../../.src/Compta/Impressions/FTVA.class#L230-L282), [FTVA.class:RadioBtnmensuel_Click](../../../../../.src/Compta/Impressions/FTVA.class#L284-L332), [FTVA.class:RadioBtnAnnuel_Click](../../../../../.src/Compta/Impressions/FTVA.class#L334-L377)
- [ ] FTVA-006 — [complexité] « TVA à déclarer » : deux branches au lieu de quatre, expressions
  strictement identiques (`Val` sans `cpoint` conservé, voir A03) · appelants : aucun · tests :
  T01, T11 · sources : [FTVA.class:267-279](../../../../../.src/Compta/Impressions/FTVA.class#L267-L279)
- [ ] FTVA-007 — [complexité] `button2_Click` : helper privé `SautPage(pdf, sTitre)` pour les cinq
  blocs « `PosY >= 273` » (le bloc de la ligne 671 garde son titre sans préfixe, A04), tableaux
  constants des libellés de mois/trimestres (CC 51 → ≤ 20 visé) · appelants : aucun · tests :
  T05-T07 · sources : [FTVA.class:button2_Click](../../../../../.src/Compta/Impressions/FTVA.class#L443-L729)
- [ ] FTVA-008 — [complexité] `Affiche` : sens du solde passé en paramètre au lieu du test sur
  `ColView.Name`, suppression du test redondant l. 145 · appelants : aucun · tests : T01, T04 ·
  sources : [FTVA.class:Affiche](../../../../../.src/Compta/Impressions/FTVA.class#L72-L222)
- [ ] FTVA-009 — [réduction de portée] `Affiche`, `trimestre`, `moiscalc`, `anneecalc`, `Raz` →
  `Private` (aucun appel externe, grep vérifié) ; couverture par les replays · appelants : aucun ·
  tests : T01-T09 · sources : [FTVA.class:Affiche](../../../../../.src/Compta/Impressions/FTVA.class#L72-L222), [FTVA.class:trimestre](../../../../../.src/Compta/Impressions/FTVA.class#L379-L396), [FTVA.class:moiscalc](../../../../../.src/Compta/Impressions/FTVA.class#L398-L402), [FTVA.class:anneecalc](../../../../../.src/Compta/Impressions/FTVA.class#L404-L408), [FTVA.class:Raz](../../../../../.src/Compta/Impressions/FTVA.class#L731-L742)
- [ ] FTVA-010 — [séparation traitement/GUI] Fonctions sans accès aux contrôles :
  `SoldesTVA(sPrefixe, iMois1, iMois2, iAnnee, bDetail, bVente)` (requêtes + cumuls) et
  `TvaADeclarer(sVente, sAchat)` ; `Affiche` et les handlers ne font plus que l'affichage ·
  appelants : aucun · tests : T01-T04, T11, T12 · sources : [FTVA.class:Affiche](../../../../../.src/Compta/Impressions/FTVA.class#L72-L222), [FTVA.class:RadioBtnTrimestre_Click](../../../../../.src/Compta/Impressions/FTVA.class#L230-L282)
- [ ] FTVA-011 — [séparation traitement/GUI] `button2_Click` : extraire le cumul par compte
  (requête + totaux débit/crédit/solde) dans une fonction privée réutilisant `SoldesTVA` si les
  sens de solde concordent (à confirmer : sens inversés entre écran et PDF) · appelants : aucun ·
  tests : T05-T07 · sources : [FTVA.class:button2_Click](../../../../../.src/Compta/Impressions/FTVA.class#L443-L729)
- [ ] FTVA-012 — [commonalisation] Noms de tables par `Cbase.Table` (`TabParam`, `TabMvt`,
  `TabComptes`, `TabSoc`) au lieu des noms en dur · appelants : aucun · tests : T01, T05 · sources : [FTVA.class:38](../../../../../.src/Compta/Impressions/FTVA.class#L38), [FTVA.class:81](../../../../../.src/Compta/Impressions/FTVA.class#L81), [FTVA.class:480-482](../../../../../.src/Compta/Impressions/FTVA.class#L480-L482)
- [ ] FTVA-013 — [commonalisation] (transverse) Socle commun des éditions comptables :
  `LibelleSociete()`, `FichierPdf()`, `Termine(pdf, fichier)` (voir architecture.md) ; dates de
  clôture par `LDate.Exercice_Cloture(0|1)` (LDATE-008) · appelants : aucun · tests : T05-T07 ·
  sources : [FTVA.class:Form_Open](../../../../../.src/Compta/Impressions/FTVA.class#L32-L70), [FTVA.class:541-542](../../../../../.src/Compta/Impressions/FTVA.class#L541-L542), [FTVA.class:720-722](../../../../../.src/Compta/Impressions/FTVA.class#L720-L722), [LDate.class:Exercice_Cloture](../../../../../.src/Utils/LDate.class#L648-L672)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] FTVA-A01 — [anomalie] `trimestre()` : mars et septembre sont classés « Trimestre 4 »
  (bornes `< 3` / `> 3` et `< 9` fausses) ; le trimestre proposé par défaut est faux deux mois par
  an · tests : T09 · sources : [FTVA.class:trimestre](../../../../../.src/Compta/Impressions/FTVA.class#L379-L396), [FTVA.class:382-393](../../../../../.src/Compta/Impressions/FTVA.class#L382-L393)
- [ ] FTVA-A02 — [anomalie] Seule `Fiches_Mvt` est lue : l'année N-1 proposée par `ComboBoxYear`
  ne montre rien si ses écritures sont déjà en `Fiches_Mvt1` (après clôture) ; aucun filtre
  `validee`/`provisoire` (brouillard inclus) · tests : T03 · sources : [FTVA.class:81](../../../../../.src/Compta/Impressions/FTVA.class#L81), [FTVA.class:134](../../../../../.src/Compta/Impressions/FTVA.class#L134), [FTVA.class:572](../../../../../.src/Compta/Impressions/FTVA.class#L572)
- [ ] FTVA-A03 — [anomalie] « TVA à déclarer » relit `TextLabelTAchat.Text` (formaté `",0.00"`)
  par `Val` sans `Utils.cpoint` : résultat faux ou nul au-delà de 999,99 selon la locale (à
  confirmer) · tests : T11 · sources : [FTVA.class:269](../../../../../.src/Compta/Impressions/FTVA.class#L269), [FTVA.class:318](../../../../../.src/Compta/Impressions/FTVA.class#L318), [FTVA.class:363](../../../../../.src/Compta/Impressions/FTVA.class#L363)
- [ ] FTVA-A04 — [anomalie] Saut de page avant le total d'un compte : en-tête `Level0T(dateedition)`
  sans « Sélection du » ni libellé annuel · tests : T06 · sources : [FTVA.class:671-677](../../../../../.src/Compta/Impressions/FTVA.class#L671-L677)
- [ ] FTVA-A05 — [anomalie] Impression sans interaction après l'ouverture : `mois1`/`mois2` valent 0
  si `ComboBoxMois_Click` n'est pas déclenché par `Form_Open` → PDF vide (à confirmer) ·
  tests : T10 · sources : [FTVA.class:Form_Open](../../../../../.src/Compta/Impressions/FTVA.class#L32-L70), [FTVA.class:572](../../../../../.src/Compta/Impressions/FTVA.class#L572)
- [ ] FTVA-A06 — [anomalie] Libellés : « mois de fèvrier », « mois de août », « mois de octobre »,
  « deuxieme/troisieme/quatrieme » sans accent ; message « Aucune ecriture » affiché seulement en
  l'absence de comptes de TVA · tests : T05 · sources : [FTVA.class:517](../../../../../.src/Compta/Impressions/FTVA.class#L517), [FTVA.class:703](../../../../../.src/Compta/Impressions/FTVA.class#L703)
