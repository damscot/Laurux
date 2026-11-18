# Emailing — Tests

> Source : `.src/Gestion/Mails/Emailing.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI : tous les tests sont des `replay` capturés dans le clone **Laurux non modifié**
(`./Laurux -l --logfile …`) puis rejoués sur les deux clones. Environnement commun : `HOME`
isolé, base `Laurux01.sql` (jeu dérivé `emailing_base` : ~10 clients avec et sans `cli_email`,
3 types, 2 statuts, codes postaux variés), serveur SMTP de test local (MailHog sur
`127.0.0.1:1025`, `/Secumail = Sans`) et faux binaires `curl`/`gammu` en tête du `PATH` qui
journalisent leurs arguments et renvoient une réponse Spot-Hit fixe
(`{"premium":"12","lowcost":"0","mobile":…}`). Comparaison : messages reçus par MailHog (en-têtes
volatils masqués), dump de la base (table `Cli_Mailing` incluse) et arguments des faux binaires.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EMAILING-T01 | replay | Mailing par plage de codes, tri par code | Fmenu › E-mailing, plage par défaut, sujet + texte, Envoyer | un message par client ayant un courriel, ordre `cli_code`, copie cachée à `/Adrmail` | `tests/plage_code/` | implémenté (gb.test `EmailingTest.T01PlageCode` : plage 411001..411004, Button2_Click appelé directement, faux SMTP : 2 messages (411001, 411003) dans l'ordre, Bcc de Settings ; boîte « Traitement terminé » répondue par un Timer du module) ; le rejeu reste bloqué (REPLAYOBSERVER-A18) |
| EMAILING-T02 | replay | Filtre type + statut, tri type puis CP | `CheckType`, `bstatut`, `RadioButton2`, `CheckCp` | destinataires et ordre de référence (CP sans effet de filtre, figé) | `tests/type_statut/` | implémenté (gb.test `EmailingTest.T02TypeStatut`, vague 8 : statuts 01/02 et types/CP/courriels posés par le test ; type A..B, statut 01, RadioButton2 + CheckCp, CP 40000..50000 sans effet ; 3 messages dans l'ordre 411004, 411002, 411001 ; élément vide du ComboBox Statut en tête) |
| EMAILING-T03 | replay | Mode liste | `Liste` coché, saisie de 3 codes dont 1 doublon et 1 inexistant, Envoyer | `Cli_Mailing` créée puis remplie (2 lignes), messages « déjà saisi » / « compte existant », 2 courriels | `tests/mode_liste/` | implémenté (gb.test `EmailingTest.T03ModeListe` : 411001, doublon, 411999 inexistant, 411003 via Cli_Man ; 2 boîtes d'erreur, Cli_Mailing = 411001, 411003 ; 2 messages SMTP) |
| EMAILING-T04 | replay | Mode liste vide puis décoché | `Liste` coché, Envoyer sans code, `Liste` décoché | erreur interceptée par le `Catch` (figée) ; `Cli_Mailing` supprimée | `tests/liste_vide/` | implémenté |
| EMAILING-T05 | replay | Pièce jointe (anomalie) | `btnopen` sur `doc.pdf`, Envoyer | erreur `File.Load` au premier client, aucun courriel (figé, A02) | `tests/piece_jointe/` | à faire : Dialog (btnopen) non rejouable ; en gb.test, sans Dialog, `FileN` (privé) reste vide et l'erreur `File.Load` aboutit au `Message.Error` du `Catch` de Button2_Click (bloquant en gb.test) |
| EMAILING-T06 | replay | Extension non reconnue | `btnopen` sur `a.docx` | message « Impossible d'ouvrir le fichier », `TextBox2` vide | `tests/piece_docx/` | à faire : Dialog (btnopen) non rejouable ; en gb.test, `btnopen_Click` appelle `Dialog.OpenFile` puis `Message.Warning` (bloquants) |
| EMAILING-T07 | replay | Grilles de recherche | F2 sur `Client1`, tri par colonne Nom, clic ; idem `Client2` et `Type`/`Type2` | codes recopiés ; tri de `Colcli2` reconfigurant `Colcli` (figé, A07) | `tests/grilles/` | implémenté partiellement (gb.test `EmailingTest.T07Grilles` : listes ouvertes par ToggleButton1/2 (équivalent de F2), Colcli_ColumnClick / Colcli2_ColumnClick appelés directement : ordre de `Utils.rs1`, colonnes de Colcli ; A07 non observable, Colcli déjà configurée à l'identique) ; à faire : clic sur une ligne (codes recopiés : cellules vides sans événement Data hors affichage ; rejeu : clic d'en-tête non rejoué) |
| EMAILING-T08 | replay | Contrôles de saisie | sujet vide, texte vide | messages « veuillez saisir le sujet / le texte » | `tests/saisie_obligatoire/` | implémenté |
| EMAILING-T09 | replay | Mode SMS | Fmenu › SMS › Envoi multiples, texte, Envoyer | « veuillez saisir le sujet » (figé, A01) ; nombre d'appels au faux `curl` (crédits) relevé pour statuer sur `Label7_GotFocus` | `tests/mode_sms/` | à faire : `Label7_GotFocus` **est** levé (faux curl crédits appelé une fois) mais son Message.Info, ouvert pendant `Form_Show`, n'est pas la fenêtre active au rejeu (code 3). Scénario mis de côté (`emailing_mode_sms`) |
| EMAILING-T10 | replay | Touche sur le bouton Envoyer | focus sur `Button2`, touche Tab puis Espace | nombre de mailings déclenchés (figé, A04) | `tests/btn_keypress/` | implémenté (Tab ; Espace non rejoué) |
| EMAILING-T11 | replay | Bouton radio masqué resté sélectionné | `CheckType` coché, `RadioButton2`, `CheckType` décoché, Envoyer | erreur ou sélection précédente réutilisée (figé, A06) | `tests/radio_masque/` | implémenté |

## Détail des tests

- **Génération des valeurs attendues** : capture dans le clone Laurux non modifié, avec le même
  `HOME`, la même base et les mêmes faux binaires ; MailHog est vidé avant chaque scénario.
- **Rejeu** : l'écran appelle `Utils.Observers(Me)` **deux fois** dans `_New` (l. 84 et 102) :
  vérifier en phase 2 que les événements ne sont pas enregistrés ou rejoués en double. Les
  `Message.Error` émis par `EnvMail.Envoi` (un par destinataire en échec) doivent être acquittés
  par le scénario.
- **`Wait 1`** entre chaque envoi (mode plage) : prévoir une durée de rejeu proportionnelle au
  nombre de destinataires.
- **Données** : `Laurux01.sql` + `emailing_base.sql` (clients `411…` de test, adresses en
  `@example.test`) ; ne jamais utiliser de vraies adresses.
- **Non testable sans matériel ou service réel** : envoi SMS par clé GSM (`gammu`, modem 3G sur
  port série/USB) et API Spot-Hit réelle (crédits, envoi) ; seul l'appel de la commande est
  vérifiable via les faux binaires. `Label7_GotFocus` (contrôle de crédit) n'est peut-être jamais
  levé : T09 tranche ce point.

### Implémentation (phase 2, vague 5)
- Scénarios `.hidden/Tests/Gestion/assets/emailing_<nom>/` (`liste_vide`, `saisie_obligatoire`, `btn_keypress`,
  `radio_masque`), base Laurux01 sans jeu dérivé, aucun envoi.
- Besoin d'outillage : un faux serveur SMTP (comme le faux FTP) pour T01 à T03 et T05, et un faux `curl` (réponse
  Spot-Hit fixe) pour T09.
- Observé : T10, une tabulation sur Envoyer déclenche l'envoi (`Btn_KeyPress` ne filtre pas la touche, A04) ;
  T11, `RadioButton2` masqué reste sélectionné : aucune requête de sélection, erreur interceptée par le `Catch`.

### Vague 6 (2026-11-14) : faux SMTP et faux curl
- T01 à T03 écrits (jeu `emailing_shared/emailing_base.sql` : courriels `@example.test`, types, statuts, CP) mais
  bloqués au rejeu : le 1er `EnvMail.Envoi` part (mode liste, sans `Wait`), le suivant (ou `Wait 1` + envoi en mode
  plage) ne rend jamais la main au rejeu (« Traitement terminé » absent après 55 s, avec ou sans faketime), alors
  que les gb.test EnvMail envoient deux messages de suite en 1 s. Besoin d'outillage à instruire. Scénarios et jeu mis
  de côté hors dépôt (bac sb2, `a2_de_cote/`).
- T09 : `Label7_GotFocus` est bien levé (un appel au faux curl `api/credits`), mais son Message.Info, ouvert pendant
  `Form_Show` de la fenêtre modale, n'est pas la fenêtre active au rejeu (même défaut que GSM-T04).
- Observé (T02) : `Statut.Add(" ", "00")` insère l'élément vide en **tête** de la liste (index 0) ; le 1er statut
  réel est à l'index 1.
