# FSauve — Rework

> Source : `.src/Communs/FSauve.class` · Message de commit (phase 4) : `reference/.src/Communs/FSauve.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 88 |
| Lignes de commentaire | 23 |
| Fonctions | 8 |
| Fonctions Public | 8 |
| Complexité cyclomatique totale | 22 |
| Complexité max (fonction) | 12 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 88 | 22 | 12 | 0 | 8 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] FSAUVE-001 — [documentation] En-tête en français : fichiers produits (contrat avec
  `FRestore`/`Expbase`), commandes externes, rôle du contrôle de processus · appelants : aucun ·
  tests : aucun · sources : [FSauve.class:1-26](../../../../.src/Communs/FSauve.class#L1-L26), [FSauve.class:Button2_Click](../../../../.src/Communs/FSauve.class#L50-L101)
- [ ] FSAUVE-002 — [code mort] Variables d'instance `Lg` et `txterror` → locales ; commentaire
  `Mkdir` mort supprimé · appelants : aucun · tests : T01, T04 · sources : [FSauve.class:28-29](../../../../.src/Communs/FSauve.class#L28-L29), [FSauve.class:56](../../../../.src/Communs/FSauve.class#L56)
- [ ] FSAUVE-003 — [séparation traitement/GUI] Extraire `SauveBase(sRep, bCompresse) As Boolean`
  (suppressions, `mysqldump`, copie de la configuration, compression) sans accès aux contrôles ;
  commandes émises identiques · appelants : aucun · tests : T01-T03, T06 · sources : [FSauve.class:57-82](../../../../.src/Communs/FSauve.class#L57-L82)
- [ ] FSAUVE-004 — [commonalisation] `mysqldump` par `Utils.DumpBase(sFichier, "--lock-tables=0")`
  (helper créé par SAUVESAUTO-003, sur la base d'UTILS-014), ligne de commande identique ·
  appelants : `SauvesAuto` · tests : T01, T02, SAUVESAUTO-T01 · sources : [FSauve.class:68](../../../../.src/Communs/FSauve.class#L68), [SauvesAuto.module:19](../../../../.src/Communs/SauvesAuto.module#L19)
- [ ] FSAUVE-005 — [commonalisation] Chemin `<rep>/<base>.sql[.gz]` par `Utils.FichierSauvegarde`
  (EXPBASE-004) · appelants : `FRestore`, `SauvesAuto`, `Expbase` · tests : T01, T02, FRESTORE-T01 ·
  sources : [FSauve.class:57](../../../../.src/Communs/FSauve.class#L57), [FSauve.class:68-81](../../../../.src/Communs/FSauve.class#L68-L81), [Expbase.class:45-49](../../../../.src/Utils/Exports-Imports/Expbase.class#L45-L49)
- [ ] FSAUVE-006 — [commonalisation] `Svs_Click` et contrôle `Process_List` partagés avec
  `FRestore` (`Utils.ChoisirRepertoire`, `Mmysql.ControleProcessus`, voir FRESTORE-008) ·
  appelants : `FRestore` · tests : T03, T04 · sources : [FSauve.class:Svs_Click](../../../../.src/Communs/FSauve.class#L103-L113), [FSauve.class:59-66](../../../../.src/Communs/FSauve.class#L59-L66)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] FSAUVE-A01 — [anomalie] Aucune détection d'échec de `mysqldump` : `txterror` contient le
  chemin du fichier (test `Left$(…, 9) = "mysqldump"` toujours faux), code retour et `stderr`
  ignorés ; un dump vide ou partiel est annoncé « correctement sauvegardé » · tests : T06 · sources : [FSauve.class:68-71](../../../../.src/Communs/FSauve.class#L68-L71)
- [ ] FSAUVE-A02 — [anomalie] Répertoire de sauvegarde absent : aucun message, curseur laissé en
  attente · tests : T03 · sources : [FSauve.class:69](../../../../.src/Communs/FSauve.class#L69), [FSauve.class:97](../../../../.src/Communs/FSauve.class#L97)
- [ ] FSAUVE-A03 — [anomalie] Copie de `~/.config/gambas3/<App>.conf` en dur (ignore `-c` /
  `Start.LocalSettings.Path`, ne sauve pas les réglages en mémoire), `Shell cp` sans guillemets
  (échec silencieux si le chemin contient un espace) · tests : T01 · sources : [FSauve.class:78](../../../../.src/Communs/FSauve.class#L78)
- [ ] FSAUVE-A04 — [anomalie] `cp.File` sans `Try` ni `Catch` (disque plein → erreur non
  interceptée) ; le `.sql` non compressé est conservé à côté du `.gz` · tests : T02 · sources : [FSauve.class:80-82](../../../../.src/Communs/FSauve.class#L80-L82)
- [ ] FSAUVE-A05 — [anomalie] `mysqldump` : mot de passe visible dans `ps`, `/dbase/Port` et tunnel
  SSH ignorés · tests : T01 · sources : [FSauve.class:68](../../../../.src/Communs/FSauve.class#L68)
- [ ] FSAUVE-A06 — [anomalie] Suppression inconditionnelle de `~/<base>.sql` (fichier hors du
  répertoire de sauvegarde) · tests : T01 · sources : [FSauve.class:58](../../../../.src/Communs/FSauve.class#L58)
- [ ] FSAUVE-A07 — [anomalie] `/Compression` n'est enregistré que par le bouton Fermer : après une
  sauvegarde compressée réussie (fermeture automatique), `FRestore`/`Expbase` lisent l'ancienne
  valeur · tests : T05 · sources : [FSauve.class:Button3_Click](../../../../.src/Communs/FSauve.class#L42-L48), [FSauve.class:88](../../../../.src/Communs/FSauve.class#L88)
