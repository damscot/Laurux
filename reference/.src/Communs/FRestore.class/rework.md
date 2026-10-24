# FRestore — Rework

> Source : `.src/Communs/FRestore.class` · Message de commit (phase 4) : `reference/.src/Communs/FRestore.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 178 |
| Lignes de commentaire | 22 |
| Fonctions | 10 |
| Fonctions Public | 10 |
| Complexité cyclomatique totale | 51 |
| Complexité max (fonction) | 30 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 178 | 51 | 30 | 0 | 10 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] FRESTORE-001 — [documentation] En-tête en français : étapes de la restauration, fichiers
  attendus (noms produits par `FSauve`), commandes externes, fichier `~/tmp/resultat`, condition
  de détection d'erreur · appelants : aucun · tests : aucun · sources : [FRestore.class:1-26](../../../../.src/Communs/FRestore.class#L1-L26), [FRestore.class:Button2_Click](../../../../.src/Communs/FRestore.class#L47-L152)
- [ ] FRESTORE-002 — [code mort] Supprimer `Process_Read` et la variable `Content` (aucun appel),
  les `Me.Mouse = Mouse.Default` redondants · appelants : aucun · tests : T01, T03 · sources : [FRestore.class:Process_Read](../../../../.src/Communs/FRestore.class#L154-L164), [FRestore.class:28](../../../../.src/Communs/FRestore.class#L28), [FRestore.class:120](../../../../.src/Communs/FRestore.class#L120)
- [ ] FRESTORE-003 — [réduction de portée] `Verif_Version` → `Private` (couvert par T05, T06) ·
  appelants : aucun · tests : T04-T06 · sources : [FRestore.class:Verif_Version](../../../../.src/Communs/FRestore.class#L178-L211)
- [ ] FRESTORE-004 — [complexité] Extraire l'analyse de la sortie `ls -1 -g` dans une fonction
  privée `AnalyseLs(sLigne) As String[]` (algorithme inchangé) et la détection MariaDB dans
  `EstMariaDB()` ; CC 30 → ≤ 12 visé · appelants : aucun · tests : T01, T02 · sources : [FRestore.class:68-73](../../../../.src/Communs/FRestore.class#L68-L73), [FRestore.class:88-115](../../../../.src/Communs/FRestore.class#L88-L115)
- [ ] FRESTORE-005 — [séparation traitement/GUI] Extraire `RestaureBase(sFichier) As String`
  (`Clear_DataBase`, `Create_DataBase`, `Fill_DataBase`, `TRUNCATE`) et `ErreurImport(sSortie,
  bMariaDB) As Boolean` (condition actuelle telle quelle) · appelants : aucun · tests : T01, T02,
  T07, T10 · sources : [FRestore.class:129-146](../../../../.src/Communs/FRestore.class#L129-L146)
- [ ] FRESTORE-006 — [commonalisation] Chemin `<rep>/<base>.sql[.gz]` par
  `Utils.FichierSauvegarde` (EXPBASE-004), partagé avec `FSauve`, `SauvesAuto`, `Expbase` ·
  appelants : `FSauve`, `SauvesAuto`, `Expbase` · tests : T01-T03, FSAUVE-T01 · sources : [FRestore.class:74-86](../../../../.src/Communs/FRestore.class#L74-L86), [FSauve.class:57-81](../../../../.src/Communs/FSauve.class#L57-L81), [Expbase.class:45-49](../../../../.src/Utils/Exports-Imports/Expbase.class#L45-L49)
- [ ] FRESTORE-007 — [commonalisation] `Shell mysql … show variables` par le helper de ligne de
  commande MySQL (UTILS-014), sortie identique · appelants : aucun · tests : T01 · sources : [FRestore.class:68](../../../../.src/Communs/FRestore.class#L68)
- [ ] FRESTORE-008 — [commonalisation] `Svs_Click` → `Utils.ChoisirRepertoire(sDefaut)` et
  contrôle `Process_List` (0 / > 7) → helper commun avec `FSauve` · appelants : `FSauve` · tests :
  T08, T09, FSAUVE-T04 · sources : [FRestore.class:Svs_Click](../../../../.src/Communs/FRestore.class#L166-L176), [FRestore.class:117-125](../../../../.src/Communs/FRestore.class#L117-L125), [FSauve.class:Svs_Click](../../../../.src/Communs/FSauve.class#L103-L113)
- [ ] FRESTORE-009 — [documentation] `Fiches_Parametres` par `Cbase.Table("TabParam")` dans
  `Verif_Version`, SQL identique · appelants : aucun · tests : T05, T06 · sources : [FRestore.class:185](../../../../.src/Communs/FRestore.class#L185)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] FRESTORE-A01 — [anomalie] `ls -1 -g` n'affiche pas le propriétaire : « sauvegardée par »
  montre le **groupe** ; date et heure dépendent de la langue et de l'âge du fichier (année au
  lieu de l'heure) ; `Recup.Utilisateur()` est écrasé · tests : T01 · sources : [FRestore.class:67](../../../../.src/Communs/FRestore.class#L67), [FRestore.class:84-86](../../../../.src/Communs/FRestore.class#L84-L86), [FRestore.class:105-114](../../../../.src/Communs/FRestore.class#L105-L114)
- [ ] FRESTORE-A02 — [anomalie] Détection d'échec de l'import (l. 132) : sous MySQL, une erreur
  précédée de l'avertissement « Using a password » passe pour un succès ; sous MariaDB, tout
  avertissement passe pour un échec ; priorité `And` / `Or If` à confirmer · tests : T07 · sources : [FRestore.class:132](../../../../.src/Communs/FRestore.class#L132)
- [ ] FRESTORE-A03 — [anomalie] Restauration des préférences : `Laurux.conf` en dur (au lieu de
  `<Application.Name>.conf`), copié sur `Start.LocalSettings.Path` puis probablement réécrit par
  `Start.LocalSettings.Save` à la fermeture de `Fmenu` (à confirmer) · tests : T04 · sources : [FRestore.class:202-209](../../../../.src/Communs/FRestore.class#L202-L209), [Fmenu.class:1227](../../../../.src/Communs/Fmenu.class#L1227)
- [ ] FRESTORE-A04 — [anomalie] `Verif_Version` : `Utils.Exit` est asynchrone, l'exécution continue
  (question sur les préférences posée après l'annonce d'arrêt) ; le message « modifier le champ
  Version du fichier .conf » est trompeur (la version est lue en base) · tests : T05, T06 · sources : [FRestore.class:189-201](../../../../.src/Communs/FRestore.class#L189-L201)
- [ ] FRESTORE-A05 — [anomalie] Commandes shell : mot de passe visible dans `ps`, `/dbase/Port` et
  tunnel SSH ignorés (restauration impossible via tunnel), chemins non protégés (espaces) · tests :
  T01 · sources : [FRestore.class:68](../../../../.src/Communs/FRestore.class#L68), [FRestore.class:84-86](../../../../.src/Communs/FRestore.class#L84-L86)
- [ ] FRESTORE-A06 — [anomalie] Seul `<base>.sql[.gz]` est restaurable : les archives
  journalières `<base><jour>.sql.gz` de `SauvesAuto` ne sont pas proposées (seule la dernière,
  restée en `<base>.sql`, l'est) ; la décompression écrase
  sans avertir un `<base>.sql` existant · tests : T02 · sources : [FRestore.class:74-76](../../../../.src/Communs/FRestore.class#L74-L76), [SauvesAuto.module:20](../../../../.src/Communs/SauvesAuto.module#L20)
- [ ] FRESTORE-A07 — [anomalie] La base est supprimée **avant** l'import, sans copie de sécurité ni
  transaction : un import en échec laisse une base vide ou partielle · tests : T07 · sources : [FRestore.class:129-131](../../../../.src/Communs/FRestore.class#L129-L131)
- [ ] FRESTORE-A08 — [anomalie] En cas d'échec, le son est joué deux fois (l. 133-137) · tests : T07 ·
  sources : [FRestore.class:133-137](../../../../.src/Communs/FRestore.class#L133-L137)
