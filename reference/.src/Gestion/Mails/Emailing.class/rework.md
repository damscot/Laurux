# Emailing — Rework

> Source : `.src/Gestion/Mails/Emailing.class` · Message de commit (phase 4) : `reference/.src/Gestion/Mails/Emailing.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 775 |
| Lignes de commentaire | 70 |
| Fonctions | 41 |
| Fonctions Public | 41 |
| Complexité cyclomatique totale | 212 |
| Complexité max (fonction) | 37 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 775 | 212 | 37 | 0 | 41 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] EMAILING-001 — [documentation] En-tête : deux modes (`"mail"`/`"sms"`), critères de
  sélection (plage, type, statut, CP = tri seulement, liste), table de travail `Cli_Mailing`,
  dépendances externes (Spot-Hit, `gammu`) ; commentaires sur `Button2_Click` · appelants :
  aucun · tests : aucun · sources : [Emailing.class:_New](../../../../../.src/Gestion/Mails/Emailing.class#L55-L113), [Emailing.class:Button2_Click](../../../../../.src/Gestion/Mails/Emailing.class#L797-L900)
- [ ] EMAILING-002 — [code mort] Supprimer les variables `CoulZnaf` (écrite, jamais lue) et
  `credit`, les blocs `With Utils` vides de sens, les branches `Case 7`/`Case 8` d'`Etiq_KeyPress`
  et l'appel `ChkInput` associé (aucun contrôle ne porte ces tags) ; `EnvoiSms`, `$gsm`, `mesg`
  seulement si la décision sur EMAILING-A01 ne les réutilise pas · appelants : aucun ·
  tests : T01-T08 · sources : [Emailing.class:35](../../../../../.src/Gestion/Mails/Emailing.class#L35), [Emailing.class:53](../../../../../.src/Gestion/Mails/Emailing.class#L53), [Emailing.class:Etiq_KeyPress](../../../../../.src/Gestion/Mails/Emailing.class#L693-L780), [Emailing.class:EnvoiSms](../../../../../.src/Gestion/Mails/Emailing.class#L902-L939)
- [ ] EMAILING-003 — [complexité] `Button2_Click` (CC 37) : construire `WHERE`/`ORDER BY` à partir
  des critères en produisant exactement les mêmes chaînes SQL que les 14 variantes actuelles
  (aucun changement SQL), boucle d'envoi commune aux modes plage et liste ; CC ≤ 12 visé ·
  appelants : aucun · tests : T01-T05, T08, T11 · sources : [Emailing.class:Button2_Click](../../../../../.src/Gestion/Mails/Emailing.class#L797-L900)
- [ ] EMAILING-004 — [complexité] Fusionner `Tris`/`Tris2`, `AffClients`/`AffClients2`,
  `ToggleButton3_Click`/`ToggleButton4_Click`, `ColType_KeyPress`/`ColType2_KeyPress` avec un
  paramètre de grille ; comportement de `colinit` conservé (A07 figée) · appelants : aucun ·
  tests : T07 · sources : [Emailing.class:Tris](../../../../../.src/Gestion/Mails/Emailing.class#L187-L197), [Emailing.class:AffClients2](../../../../../.src/Gestion/Mails/Emailing.class#L295-L305), [Emailing.class:ToggleButton3_Click](../../../../../.src/Gestion/Mails/Emailing.class#L469-L501), [Emailing.class:ToggleButton4_Click](../../../../../.src/Gestion/Mails/Emailing.class#L531-L563)
- [ ] EMAILING-005 — [documentation] Noms de tables en dur `Fiches_Cli`, `Fiches_Typec` remplacés
  par `Cbase.Table("TabCli")`, `Cbase.Table("TabTypec")` (SQL émis identique) · appelants :
  aucun · tests : T03, T07 · sources : [Emailing.class:AffClients](../../../../../.src/Gestion/Mails/Emailing.class#L280-L290), [Emailing.class:Cli_Man](../../../../../.src/Gestion/Mails/Emailing.class#L349-L377), [Emailing.class:ToggleButton3_Click](../../../../../.src/Gestion/Mails/Emailing.class#L469-L501)
- [ ] EMAILING-006 — [commonalisation] Classe de sélection de destinataires partagée avec
  `EmailingCarte` et `Eticli` (grilles, plage, liste `Cli_Mailing`, navigation `Etiq_KeyPress`) ;
  `SetObservers`/`OBS_*` vers le helper commun proposé par les écrans de tables · appelants :
  aucun · tests : T01-T07, EMAILINGCARTE-T01-T06 · sources : [Emailing.class:colinit](../../../../../.src/Gestion/Mails/Emailing.class#L257-L275), [Emailing.class:Cli_Man](../../../../../.src/Gestion/Mails/Emailing.class#L349-L377), [Emailing.class:liste_Click](../../../../../.src/Gestion/Mails/Emailing.class#L642-L681), [EmailingCarte.class:Cli_Man](../../../../../.src/Gestion/Mails/EmailingCarte.class#L252-L279), [Eticli.class:Cli_Man](../../../../../.src/Gestion/Etiquettes/Eticli.class#L301-L325)
- [ ] EMAILING-007 — [séparation traitement/GUI] Extraire `SelectionClients(critères) As Result`,
  `AjouteListe(code) As Boolean`, `CreeListe()`/`SupprimeListe()` sans accès aux contrôles ·
  appelants : aucun · tests : T01-T04 · sources : [Emailing.class:Button2_Click](../../../../../.src/Gestion/Mails/Emailing.class#L797-L900), [Emailing.class:Cli_Man](../../../../../.src/Gestion/Mails/Emailing.class#L349-L377), [Emailing.class:liste_Click](../../../../../.src/Gestion/Mails/Emailing.class#L642-L681)
- [ ] EMAILING-008 — [commonalisation] Contrôle de crédit Spot-Hit de `Label7_GotFocus` vers le
  module SMS commun (voir GSM-005) ; même commande `curl`, mêmes messages · appelants : aucun ·
  tests : T09 · sources : [Emailing.class:Label7_GotFocus](../../../../../.src/Gestion/Mails/Emailing.class#L121-L157), [Gsm.class:TextLabel1_GotFocus](../../../../../.src/Gestion/SMS/Gsm.class#L39-L75)
- [ ] EMAILING-009 — [réduction de portée] `Tris`, `Tris2`, `colinit`, `AffClients`, `AffClients2`,
  `Cli_Man`, `ChkInput`, `Button2_Click`, `SetObservers` → `Private` ; les handlers (dont
  `ColCli_Click`, `ColCli2_Click`, `ColType_Click`, `ColType2_Click` appelés par le rejeu) restent
  `Public` · appelants : aucun · tests : T01-T08 · sources : [Emailing.class:Tris](../../../../../.src/Gestion/Mails/Emailing.class#L187-L197), [Emailing.class:Tris2](../../../../../.src/Gestion/Mails/Emailing.class#L199-L209), [Emailing.class:colinit](../../../../../.src/Gestion/Mails/Emailing.class#L257-L275), [Emailing.class:AffClients](../../../../../.src/Gestion/Mails/Emailing.class#L280-L290), [Emailing.class:AffClients2](../../../../../.src/Gestion/Mails/Emailing.class#L295-L305), [Emailing.class:Cli_Man](../../../../../.src/Gestion/Mails/Emailing.class#L349-L377), [Emailing.class:ChkInput](../../../../../.src/Gestion/Mails/Emailing.class#L683-L691), [Emailing.class:Button2_Click](../../../../../.src/Gestion/Mails/Emailing.class#L797-L900), [Emailing.class:SetObservers](../../../../../.src/Gestion/Mails/Emailing.class#L981-L993)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] EMAILING-A01 — [anomalie] Mode SMS inopérant : `Button2_Click` exige le sujet `TextBox1`,
  masqué en mode SMS (« veuillez saisir le sujet » systématique) ; `EnvoiSms` n'est jamais
  appelé et `$gsm`/`mesg` ne sont jamais affectés ; compteur de caractères par frappes, limite de
  160 non imposée. Décision : implémenter l'envoi via le module SMS commun ou retirer le menu
  « SMS › Envoi multiples » · tests : T09 · sources : [Emailing.class:800](../../../../../.src/Gestion/Mails/Emailing.class#L800), [Emailing.class:EnvoiSms](../../../../../.src/Gestion/Mails/Emailing.class#L902-L939), [Emailing.class:sText_KeyPress](../../../../../.src/Gestion/Mails/Emailing.class#L782-L795), [Fmenu.class:Menu320_Click](../../../../../.src/Communs/Fmenu.class#L2415-L2423)
- [ ] EMAILING-A02 — [anomalie] Pièce jointe : `TextBox2.Text` (chemin complet) est passé comme
  répertoire à `EnvMail.Envoi`, qui charge `chemin & FileN` : fichier introuvable, mailing
  interrompu au premier client ; `piece` n'est jamais remis à `False` · tests : T05 ·
  sources : [Emailing.class:848](../../../../../.src/Gestion/Mails/Emailing.class#L848), [Emailing.class:862](../../../../../.src/Gestion/Mails/Emailing.class#L862), [Emailing.class:btnopen_Click](../../../../../.src/Gestion/Mails/Emailing.class#L941-L957), [EnvMail.module:30](../../../../../.src/Gestion/Mails/EnvMail.module#L30)
- [ ] EMAILING-A03 — [anomalie] Mode liste : `rcli2` lu sans test `Available` (liste vide →
  erreur `Catch`), `rCli!cli_email` lu même si le `Try` a échoué · tests : T04 ·
  sources : [Emailing.class:838-849](../../../../../.src/Gestion/Mails/Emailing.class#L838-L849)
- [ ] EMAILING-A04 — [anomalie] `Btn_KeyPress` : toute touche (Tab, flèche…) sur le bouton
  Envoyer lance le mailing ; Espace déclenche probablement `KeyPress` puis `Click`, soit un
  double envoi (à confirmer par T10) · tests : T10 · sources : [Emailing.class:Btn_KeyPress](../../../../../.src/Gestion/Mails/Emailing.class#L633-L640)
- [ ] EMAILING-A05 — [anomalie] La plage de codes postaux `Cp1`…`Cp2` n'est jamais utilisée dans
  le SQL : `CheckCp` ne fait que trier par `cli_cd_ptl` (contrairement à `EmailingCarte`) ·
  tests : T02 · sources : [Emailing.class:Button2_Click](../../../../../.src/Gestion/Mails/Emailing.class#L797-L900)
- [ ] EMAILING-A06 — [anomalie] Bouton radio masqué resté sélectionné (`RadioButton2` après
  décochage de `CheckType`, `RadioButton3` après `CheckCp`) : aucune requête ne correspond,
  `rCli` vaut `Null` (erreur) ou la sélection précédente est renvoyée · tests : T11 ·
  sources : [Emailing.class:804-811](../../../../../.src/Gestion/Mails/Emailing.class#L804-L811), [Emailing.class:CheckType_Click](../../../../../.src/Gestion/Mails/Emailing.class#L159-L170)
- [ ] EMAILING-A07 — [anomalie] Tri de `Colcli2` par clic sur l'en-tête : `colinit` appelle
  `AffClients`, qui reconfigure `colcli` et donne le focus à la grille masquée · tests : T07 ·
  sources : [Emailing.class:colinit](../../../../../.src/Gestion/Mails/Emailing.class#L257-L275), [Emailing.class:AffClients](../../../../../.src/Gestion/Mails/Emailing.class#L280-L290)
- [ ] EMAILING-A08 — [anomalie] Table de travail `Cli_Mailing` hors `Cbase`, partagée avec
  `EmailingCarte` et entre postes (même base) : deux utilisateurs simultanés mélangent ou
  effacent leurs listes ; la table reste en base si l'écran est fermé en mode liste ·
  tests : T03, T04 · sources : [Emailing.class:liste_Click](../../../../../.src/Gestion/Mails/Emailing.class#L642-L681), [EmailingCarte.class:liste_Click](../../../../../.src/Gestion/Mails/EmailingCarte.class#L390-L423)
- [ ] EMAILING-A09 — [anomalie] [sécurité] Clé API Spot-Hit envoyée en HTTP clair et visible sur
  la ligne de commande (`ps`) ; contrôle SMTP inutile en mode SMS ; `Label7` (un `Label`) ne
  reçoit probablement jamais le focus, le contrôle de crédit ne s'exécuterait pas (à confirmer
  par T09) · tests : T09 · sources : [Emailing.class:133](../../../../../.src/Gestion/Mails/Emailing.class#L133), [Emailing.class:Form_Show](../../../../../.src/Gestion/Mails/Emailing.class#L115-L119)
