# EnvMail — Rework

> Source : `.src/Gestion/Mails/EnvMail.module` · Message de commit (phase 4) : `reference/.src/Gestion/Mails/EnvMail.module/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 238 |
| Lignes de commentaire | 6 |
| Fonctions | 6 |
| Fonctions Public | 6 |
| Complexité cyclomatique totale | 98 |
| Complexité max (fonction) | 56 (`Extension`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 238 | 98 | 56 | 0 | 6 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] ENVMAIL-001 — [documentation] En-tête du module en français : deux mécanismes (SMTP direct,
  client de messagerie), clés de configuration lues, contrat `chemin` (répertoire) / `FileN`
  (nom) d'`Envoi`, dépendances externes ; commentaire `'''` sur chaque fonction Public ·
  appelants : aucun · tests : aucun · sources : [EnvMail.module:Envoi](../../../../../.src/Gestion/Mails/EnvMail.module#L3-L46), [EnvMail.module:Envoi2](../../../../../.src/Gestion/Mails/EnvMail.module#L155-L206)
- [ ] ENVMAIL-002 — [code mort] Supprimer `Envoi2b` et `Envoi5` (aucun appelant) et les
  variables `Pjointe` inutilisées d'`Envoi2` · appelants : aucun · tests : T07, T08 ·
  sources : [EnvMail.module:Envoi2b](../../../../../.src/Gestion/Mails/EnvMail.module#L48-L85), [EnvMail.module:Envoi5](../../../../../.src/Gestion/Mails/EnvMail.module#L124-L153), [EnvMail.module:156](../../../../../.src/Gestion/Mails/EnvMail.module#L156)
- [ ] ENVMAIL-003 — [commonalisation] Fonction privée `EncodeCorps(corps)` remplaçant les blocs
  de 6 `Replace$` (copiés dans `Envoi2`, `Envoi3`) et helper privé de construction de la commande
  Thunderbird ; commandes produites identiques caractère pour caractère · appelants : aucun ·
  tests : T07, T08, T09, T11 · sources : [EnvMail.module:Envoi2](../../../../../.src/Gestion/Mails/EnvMail.module#L155-L206), [EnvMail.module:Envoi3](../../../../../.src/Gestion/Mails/EnvMail.module#L87-L122)
- [ ] ENVMAIL-004 — [séparation traitement/GUI] `Envoi` : extraire `EnvoiSmtp(…) As String`
  (préparation du `SmtpClient`, pièces jointes, envoi ; renvoie le texte d'erreur) ; `Envoi`
  conserve `Message.Error` et la valeur de retour · appelants : aucun · tests : T02-T06 ·
  sources : [EnvMail.module:Envoi](../../../../../.src/Gestion/Mails/EnvMail.module#L3-L46)
- [ ] ENVMAIL-005 — [séparation traitement/GUI] `Envoi2`/`Envoi3` : fonction pure
  `CommandeMail(programme, Email, sujet, corps, pieces) As String` (testable en gb.test), le
  `Shell`/`Exec` et le `Message.Warning` restent dans les fonctions Public · appelants : aucun ·
  tests : T07-T09 · sources : [EnvMail.module:Envoi2](../../../../../.src/Gestion/Mails/EnvMail.module#L155-L206), [EnvMail.module:Envoi3](../../../../../.src/Gestion/Mails/EnvMail.module#L87-L122)
- [ ] ENVMAIL-006 — [complexité] `Envoi` : fusionner les deux branches de pièce jointe (premier
  `.Add` commun, puis CGV si `Pdfchemin`) ; même ordre et mêmes pièces · appelants : aucun ·
  tests : T03 · sources : [EnvMail.module:29-36](../../../../../.src/Gestion/Mails/EnvMail.module#L29-L36)
- [ ] ENVMAIL-007 — [complexité] `Extension` : table de correspondance extension → type MIME
  parcourue sur les segments 1 et 2 comme aujourd'hui (erreur « Out of bounds » et écrasement
  `rtf` → `msword` conservés) ; CC 56 → ≤ 6 visé · appelants : `Emailing`, `EmailingCarte`
  (inchangés) · tests : T01 · sources : [EnvMail.module:Extension](../../../../../.src/Gestion/Mails/EnvMail.module#L208-L276)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] ENVMAIL-A01 — [anomalie] `ExportJdv.export` appelle `Envoi3` avec 5 arguments (4 attendus) :
  « Too many arguments » à l'exécution, l'export en deux fichiers n'est jamais envoyé par
  courriel. Correction proposée : `EnvMail.Envoi2(Email, stext, sText2, Fle1, Fle2)` dans
  `ExportJdv`, puis suppression d'`Envoi3` devenu sans appelant (sinon, `Envoi3` joindrait les
  CGV au lieu du fichier d'écritures) · appelants : `ExportJdv` · tests : T09, T10,
  EXPORTJDV (replay d'export) · sources : [ExportJdv.class:1000](../../../../../.src/Compta/Utils/ExportJdv.class#L1000), [EnvMail.module:Envoi3](../../../../../.src/Gestion/Mails/EnvMail.module#L87-L122)
- [ ] ENVMAIL-A02 — [anomalie] Copie cachée et chemins de pièces lus dans l'objet `Settings` par
  défaut au lieu de `Start.LocalSettings` : avec `-c`, la copie cachée d'`Envoi` part vers
  l'adresse du fichier par défaut (fuite possible de factures, tickets et mailings vers une autre
  boîte) · tests : T06 · sources : [EnvMail.module:26](../../../../../.src/Gestion/Mails/EnvMail.module#L26), [EnvMail.module:176](../../../../../.src/Gestion/Mails/EnvMail.module#L176)
- [ ] ENVMAIL-A03 — [anomalie] [sécurité] `SmtpClient.Debug = True` en production : dialogue SMTP
  (dont la ligne `AUTH`, identifiant et mot de passe en base64, à confirmer) écrit sur la sortie
  d'erreur ; à désactiver ou à lier à `Start.Arg_Debug` · tests : T02 · sources : [EnvMail.module:15](../../../../../.src/Gestion/Mails/EnvMail.module#L15)
- [ ] ENVMAIL-A04 — [anomalie] [sécurité] Lignes de commande `Shell` construites sans échappement
  (adresse, sujet, corps, chemins) : un `"`, `$(…)` ou `` ` `` dans une fiche tiers ou un texte de
  courriel casse la commande ou exécute une commande. Correction : `Exec` avec tableau
  d'arguments (comme pour Evolution) · tests : T07, T08, T11 · sources : [EnvMail.module:Envoi2](../../../../../.src/Gestion/Mails/EnvMail.module#L155-L206), [EnvMail.module:Envoi3](../../../../../.src/Gestion/Mails/EnvMail.module#L87-L122)
- [ ] ENVMAIL-A05 — [anomalie] `Extension` : « Out of bounds » pour un nom sans point ou à
  extension unique inconnue (`.docx`, `.xlsx`, `.odg`…), segment testé au lieu de la dernière
  extension, `rtf` → `msword`, `wav` → `video/wav` : la pièce jointe d'un mailing est refusée ·
  tests : T01 · sources : [EnvMail.module:Extension](../../../../../.src/Gestion/Mails/EnvMail.module#L208-L276)
- [ ] ENVMAIL-A06 — [anomalie] `Envoi2` : `piece2` ignorée pour Icedove, Evolution et Kmail
  (deuxième pièce jointe perdue : conditions de vente d'`ObjFacB`, fichier LCR de `Bordrx`) ;
  `\\&body=` d'Evolution transmet un `\` littéral (à confirmer) · tests : T08 ·
  sources : [EnvMail.module:194](../../../../../.src/Gestion/Mails/EnvMail.module#L194), [EnvMail.module:197](../../../../../.src/Gestion/Mails/EnvMail.module#L197)
