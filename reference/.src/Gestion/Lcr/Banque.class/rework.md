# Banque — Rework

> Source : `.src/Gestion/Lcr/Banque.class` · Message de commit (phase 4) : `reference/.src/Gestion/Lcr/Banque.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 336 |
| Lignes de commentaire | 34 |
| Fonctions | 32 |
| Fonctions Public | 32 |
| Complexité cyclomatique totale | 71 |
| Complexité max (fonction) | 8 (`Button4_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 336 | 71 | 8 | 0 | 32 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] BANQUE-001 — [documentation] En-tête en français : rôle de la table `Fiches_Banques` dans le
  fichier bancaire LCR (`Bordrx`), signification des options `banques_adr` (N/O/C) et
  `banques_fenrg`, correspondance Tag → bouton · appelants : aucun · tests : aucun ·
  sources : [Banque.class:_New](../../../../../.src/Gestion/Lcr/Banque.class#L42-L66), [Banque.class:Btn_Click](../../../../../.src/Gestion/Lcr/Banque.class#L218-L237)
- [ ] BANQUE-002 — [code mort] Supprimer les membres inutilisés ou seulement affectés (`tab`,
  `CoulZns`, `CoulZnaf`, `ComboTest`), le `Print "ok"` de débogage de `TabStrip1_Click` (handler
  devenu vide, supprimable : l'onglet n'a pas d'autre traitement) et la logique `B`/`code_LF`
  toujours vraie (`If b <> 1`) · appelants : aucun · tests : T01-T07 ·
  sources : [Banque.class:TabStrip1_Click](../../../../../.src/Gestion/Lcr/Banque.class#L213-L217), [Banque.class:code_LF](../../../../../.src/Gestion/Lcr/Banque.class#L262-L270), [Banque.class:442](../../../../../.src/Gestion/Lcr/Banque.class#L442)
- [ ] BANQUE-003 — [complexité] `banques_man` : une seule lecture (appel direct de `Maj_Zones`),
  `Deb2`/`Deb3` fusionnés en `Deb(ordre)` · SQL modifié (une requête `SELECT` en moins), dump
  identique · appelants : aucun · tests : T01, T07 · sources : [Banque.class:banques_man](../../../../../.src/Gestion/Lcr/Banque.class#L396-L409),
  [Banque.class:Deb2](../../../../../.src/Gestion/Lcr/Banque.class#L100-L104), [Banque.class:Deb3](../../../../../.src/Gestion/Lcr/Banque.class#L106-L110)
- [ ] BANQUE-004 — [réduction de portée] `Tris`, `Deb2`, `Deb3`, `Maj_Zones`, `Refresh`,
  `CleanChamps`, `code_LF`, `Dbclk`, `Ref`, `banques_man`, `Button3_Click`, `Button4_Click`,
  `Button7_Click` → `Private` (pseudo-handlers du groupe `Btn` ; `Colbanque_Click` et les handlers
  réels restent `Public`) · appelants : aucun · tests : T01-T07 · sources : [Banque.class:Tris](../../../../../.src/Gestion/Lcr/Banque.class#L90-L98),
  [Banque.class:Button4_Click](../../../../../.src/Gestion/Lcr/Banque.class#L432-L472)
- [ ] BANQUE-005 — [séparation traitement/GUI] Extraire `Enregistre(…)`, `Supprime(code)` et
  `Lit(code) As Result` sans accès aux contrôles · appelants : aucun · tests : T02-T05 ·
  sources : [Banque.class:Button4_Click](../../../../../.src/Gestion/Lcr/Banque.class#L432-L472), [Banque.class:Button3_Click](../../../../../.src/Gestion/Lcr/Banque.class#L414-L427), [Banque.class:Maj_Zones](../../../../../.src/Gestion/Lcr/Banque.class#L112-L140)
- [ ] BANQUE-006 — [commonalisation] Fournir la liste « code - nom » des banques à `Glcr`,
  `Attribution`, `Preparation` (fonction commune, phase 3) · appelants : `Glcr`, `Attribution`,
  `Preparation` · tests : T01 et replays de ces écrans · sources : [Attribution.class:Form_Open](../../../../../.src/Gestion/Lcr/Attribution.class#L84-L106)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] BANQUE-A01 — [anomalie] Après création, la resélection compare la colonne nom au code : la
  nouvelle banque n'est jamais sélectionnée (comparer la colonne 0) · tests : T03 ·
  sources : [Banque.class:451](../../../../../.src/Gestion/Lcr/Banque.class#L451)
- [ ] BANQUE-A02 — [anomalie] Suppression d'une banque sans contrôle des LCR et bordereaux qui la
  référencent (`Fiches_Lcr.banque`, `Fiches_Bordereaux.banque`) : bordereaux sans coordonnées
  bancaires dans `Bordrx` · tests : T05 · sources : [Banque.class:Button3_Click](../../../../../.src/Gestion/Lcr/Banque.class#L414-L427)
- [ ] BANQUE-A03 — [anomalie] Filtre clavier concaténé dans le SQL (`like "<sel>%"`) : une saisie
  avec guillemet produit une erreur SQL ; passer par `&1` · tests : T08 · sources :
  [Banque.class:Deb2](../../../../../.src/Gestion/Lcr/Banque.class#L100-L104), [Banque.class:Deb3](../../../../../.src/Gestion/Lcr/Banque.class#L106-L110)
- [ ] BANQUE-A04 — [anomalie] Écran non instrumenté (`Utils.Observers(Me)` absent) : ni journal ni
  rejeu possibles. L'ajout modifie le log produit (à valider, nécessaire aux replays T01-T08) ·
  tests : T01-T08 · sources : [Banque.class:_New](../../../../../.src/Gestion/Lcr/Banque.class#L42-L66)
- [ ] BANQUE-A05 — [anomalie] `nv` n'est jamais remis à `True` : après une première sélection, la
  saisie d'un code existant ne charge plus la fiche, et `Dsg_GotFocus`/`Btn_keyPress` peuvent
  déclencher un double enregistrement (à confirmer en phase 2) · tests : T03, T07 ·
  sources : [Banque.class:Cmpt_Lostfocus](../../../../../.src/Gestion/Lcr/Banque.class#L239-L260), [Banque.class:Dsg_GotFocus](../../../../../.src/Gestion/Lcr/Banque.class#L204-L212), [Banque.class:Btn_keyPress](../../../../../.src/Gestion/Lcr/Banque.class#L185-L202)
