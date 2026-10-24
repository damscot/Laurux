# Prgm — Rework

> Source : `.src/Communs/Prgm.class` · Message de commit (phase 4) : `reference/.src/Communs/Prgm.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 101 |
| Lignes de commentaire | 6 |
| Fonctions | 6 |
| Fonctions Public | 6 |
| Complexité cyclomatique totale | 53 |
| Complexité max (fonction) | 38 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 101 | 53 | 38 | 0 | 6 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] PRGM-001 — [documentation] En-tête en français : rôle, liste des 36 noms acceptés avec leur
  niveau de danger (renvoi vers architecture.md), arguments de `CalcSha1` · appelants : aucun ·
  tests : aucun · sources : [Prgm.class:Button1_Click](../../../../.src/Communs/Prgm.class#L47-L116)
- [ ] PRGM-002 — [complexité] Remplacer les 36 `If Prog = …` successifs par un `Select Case Prog`
  (noms distincts : un seul cas possible, `Me.Close` final conservé) · appelants : aucun · tests :
  T02-T08 · sources : [Prgm.class:Button1_Click](../../../../.src/Communs/Prgm.class#L47-L116)
- [ ] PRGM-003 — [commonalisation] `Mdp_LF` utilise `MDP.Verifie(Mdp.Text)` (MDP-003) pour la
  comparaison ; messages, son et sélection inchangés · appelants : aucun · tests : T01 · sources : [Prgm.class:Mdp_LF](../../../../.src/Communs/Prgm.class#L26-L45), [MDP.class:Mdp2_LF](../../../../.src/Communs/MDP.class#L21-L49)
- [ ] PRGM-004 — [séparation traitement/GUI] Fonction pure `Commande(sTexte) As String[]` (découpage
  nom + arguments) et procédure privée `VideVerrous()` pour le `TRUNCATE` ; le handler garde
  messages et fermeture · appelants : aucun · tests : T03, T04, T09 · sources : [Prgm.class:54-56](../../../../.src/Communs/Prgm.class#L54-L56), [Prgm.class:95-99](../../../../.src/Communs/Prgm.class#L95-L99)
- [ ] PRGM-005 — [code mort] Supprimer la ligne commentée `Import` et `'Arga = New String[]` ;
  `Tab` remplacé par `Cbase.Table("TabActif")` (SQL identique : `Fiches_Docactif`) · appelants :
  aucun · tests : T03 · sources : [Prgm.class:53](../../../../.src/Communs/Prgm.class#L53), [Prgm.class:69](../../../../.src/Communs/Prgm.class#L69), [Prgm.class:49](../../../../.src/Communs/Prgm.class#L49)
- [ ] PRGM-006 — [réarchitecture] (transverse, avec PAPMP-003) Table nom → procédure pour les
  scripts regroupés dans un module `Maintenance` ; liste des noms acceptés inchangée · appelants :
  scripts `run` listés dans dependencies.md · tests : T02-T06 · sources : [Prgm.class:Button1_Click](../../../../.src/Communs/Prgm.class#L47-L116), [Papmp.class:run](../../../../.src/Utils/Papmp.class#L3-L23)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] PRGM-A01 — [anomalie, sécurité] Le lancement ne vérifie pas que le mot de passe administrateur
  a été validé : seul le panneau `HBox1` superposé au champ `Prg` l'empêche (bouton « Lancer »
  toujours actif) ; à confirmer à l'exécution · tests : T01 · sources : [Prgm.class:_New](../../../../.src/Communs/Prgm.class#L3-L15), [Prgm.class:Button1_Click](../../../../.src/Communs/Prgm.class#L47-L116)
- [ ] PRGM-A02 — [anomalie] Scripts destructeurs lancés sans confirmation ni transaction :
  `RazDocactif` (vide tous les verrous de tous les postes), `RecupN`, `Epurfour`, `RenMvt`, `Renech`,
  `RenAN`, `HistoCom`, `RenumBl`, `MajEqu`, `CalcSha1` ; à retirer ou protéger (voir RECUPN-A01,
  EPURFOUR-A01, HISTOCOM-A01, RENUMBL-A01) · tests : T03-T06 · sources : [Prgm.class:96](../../../../.src/Communs/Prgm.class#L96), [Prgm.class:64](../../../../.src/Communs/Prgm.class#L64), [Prgm.class:67](../../../../.src/Communs/Prgm.class#L67), [Prgm.class:74](../../../../.src/Communs/Prgm.class#L74), [Prgm.class:82](../../../../.src/Communs/Prgm.class#L82), [Prgm.class:84](../../../../.src/Communs/Prgm.class#L84), [Prgm.class:111](../../../../.src/Communs/Prgm.class#L111)
- [ ] PRGM-A03 — [anomalie] `Fsoc` : `Fsoc.ShowModal()` utilise l'auto-instance d'une classe dont
  le constructeur exige `hform As Form` (erreur d'exécution attendue, à confirmer) ; utiliser
  `New Fsoc(Start.MainWindow)` · tests : T08 · sources : [Prgm.class:81](../../../../.src/Communs/Prgm.class#L81), [Fsoc.class:_New](../../../../.src/Communs/Fsoc.class#L41-L60)
- [ ] PRGM-A04 — [anomalie] `CalcSha1 <suffixe>` : le suffixe saisi est concaténé au nom de table
  sans contrôle (table inexistante → erreur SQL, injection possible) ; restreindre à `1`…`5` ·
  tests : T04 · sources : [Prgm.class:90](../../../../.src/Communs/Prgm.class#L90)
- [ ] PRGM-A05 — [anomalie] Champ vide : `Arga[0]` sur le résultat de `Split("", " ")` (tableau
  éventuellement vide, erreur d'indice à confirmer) · tests : T07 · sources : [Prgm.class:55](../../../../.src/Communs/Prgm.class#L55)
- [ ] PRGM-A06 — [anomalie] `RenAN` met à jour `Fiches_Mvtoc`, table absente de la référence
  `db_control.csv` : le script échoue (erreur SQL) ; à retirer de la liste ou à corriger dans
  `RenAN` (lot Compta) · tests : T06 · sources : [Prgm.class:74](../../../../.src/Communs/Prgm.class#L74), [RenAN.class:10](../../../../.src/Compta/Utils/RenAN.class#L10)
