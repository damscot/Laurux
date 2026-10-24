# SauvesAuto — Rework

> Source : `.src/Communs/SauvesAuto.module` · Message de commit (phase 4) : `reference/.src/Communs/SauvesAuto.module/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 35 |
| Lignes de commentaire | 3 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 10 |
| Complexité max (fonction) | 10 (`Sauvegarde`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 35 | 10 | 10 | 0 | 1 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] SAUVESAUTO-001 — [documentation] En-tête en français : déclenchement (`Fmenu.form_close`,
  conditions), fichiers produits et rotation hebdomadaire, préférences FTP ; suppression du
  commentaire mort `'Private hftp` · appelants : aucun · tests : aucun · sources : [SauvesAuto.module:1-4](../../../../.src/Communs/SauvesAuto.module#L1-L4), [SauvesAuto.module:Sauvegarde](../../../../.src/Communs/SauvesAuto.module#L6-L43)
- [ ] SAUVESAUTO-002 — [complexité] Nom de l'archive `<rep>/<base><jour>.sql.gz` calculé une seule
  fois dans une variable locale (4 occurrences de `WeekDay(Now)`) ; noms identiques hors passage
  à minuit pendant l'exécution · appelants : aucun · tests : T01, T04 · sources : [SauvesAuto.module:20](../../../../.src/Communs/SauvesAuto.module#L20), [SauvesAuto.module:25](../../../../.src/Communs/SauvesAuto.module#L25), [SauvesAuto.module:29](../../../../.src/Communs/SauvesAuto.module#L29)
- [ ] SAUVESAUTO-003 — [commonalisation] Créer `Utils.DumpBase(sFichier, Optional sOptions)` (sur
  la base de la ligne de commande MySQL d'UTILS-014) et l'utiliser ici ; commande `mysqldump`
  identique (sans `--lock-tables=0`) ; `FSauve` suit avec FSAUVE-004 · appelants : `FSauve` ·
  tests : T01, T03, FSAUVE-T01 · sources : [SauvesAuto.module:19](../../../../.src/Communs/SauvesAuto.module#L19), [FSauve.class:68](../../../../.src/Communs/FSauve.class#L68)
- [ ] SAUVESAUTO-004 — [commonalisation] Chemin `<rep>/<base>.sql` par `Utils.FichierSauvegarde`
  (EXPBASE-004) · appelants : `FSauve`, `FRestore`, `Expbase` · tests : T01 · sources : [SauvesAuto.module:18-19](../../../../.src/Communs/SauvesAuto.module#L18-L19)
- [ ] SAUVESAUTO-005 — [séparation traitement/GUI] Extraire `SauveAuto(sRep) As String` (dump +
  compression) et `EnvoiFtp(sFichier) As Boolean` sans accès à `Menu` ni aux messages ;
  `Sauvegarde(Menu)` garde curseur et messages, signature inchangée · appelants : `Fmenu`
  (inchangé) · tests : T01-T04 · sources : [SauvesAuto.module:Sauvegarde](../../../../.src/Communs/SauvesAuto.module#L6-L43)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] SAUVESAUTO-A01 — [anomalie] `hftp.Put` sans `Try` : une erreur FTP lève une exception non
  interceptée pendant la fermeture ; le `If Error` qui suit teste l'erreur du `Try cp.File` et
  annonce toujours « Sauvegarde terminée ! » · tests : T04, T05 · sources : [SauvesAuto.module:29](../../../../.src/Communs/SauvesAuto.module#L29), [SauvesAuto.module:34-38](../../../../.src/Communs/SauvesAuto.module#L34-L38)
- [ ] SAUVESAUTO-A02 — [anomalie] Échec de `mysqldump` non détecté (code retour et `stderr`
  ignorés) : un `.sql` vide est compressé et envoyé · tests : T01 · sources : [SauvesAuto.module:19](../../../../.src/Communs/SauvesAuto.module#L19)
- [ ] SAUVESAUTO-A03 — [anomalie] Test `IsNull(hftp.URL)` toujours faux (l'URL contient au moins
  `/<fichier>`) : sans `/Adrbase`, l'envoi part vers une URL invalide au lieu d'afficher
  l'avertissement · tests : T05 · sources : [SauvesAuto.module:25](../../../../.src/Communs/SauvesAuto.module#L25), [SauvesAuto.module:28-32](../../../../.src/Communs/SauvesAuto.module#L28-L32)
- [ ] SAUVESAUTO-A04 — [anomalie] Curseur de `Menu` non restauré sans FTP ou en cas d'erreur de
  compression ; aucun message de fin sans FTP ; succès signalé par `Message.Warning` · tests : T01,
  T03 · sources : [SauvesAuto.module:15](../../../../.src/Communs/SauvesAuto.module#L15), [SauvesAuto.module:21-23](../../../../.src/Communs/SauvesAuto.module#L21-L23), [SauvesAuto.module:33](../../../../.src/Communs/SauvesAuto.module#L33)
- [ ] SAUVESAUTO-A05 — [anomalie] `mysqldump` : mot de passe visible dans `ps`, port et tunnel SSH
  ignorés ; pas de `--lock-tables=0` (verrouillage des tables, contrairement à `FSauve`) · tests :
  T01 · sources : [SauvesAuto.module:19](../../../../.src/Communs/SauvesAuto.module#L19)
- [ ] SAUVESAUTO-A06 — [anomalie] Mode synchrone de `FtpClient.Put` à confirmer : si l'envoi est
  asynchrone, l'objet local `hftp` est libéré en fin de fonction et le transfert peut être
  interrompu (application en cours de fermeture) · tests : T04 · sources : [SauvesAuto.module:10](../../../../.src/Communs/SauvesAuto.module#L10), [SauvesAuto.module:29](../../../../.src/Communs/SauvesAuto.module#L29)
