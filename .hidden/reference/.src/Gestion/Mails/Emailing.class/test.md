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
| EMAILING-T01 | replay | Mailing par plage de codes, tri par code | Fmenu › E-mailing, plage par défaut, sujet + texte, Envoyer | un message par client ayant un courriel, ordre `cli_code`, copie cachée à `/Adrmail` | `tests/plage_code/` | à faire : faux serveur SMTP disponible depuis le 2026-11-14 (`laurux-smtp`, clé `"smtp"` de meta.json), à implémenter |
| EMAILING-T02 | replay | Filtre type + statut, tri type puis CP | `CheckType`, `bstatut`, `RadioButton2`, `CheckCp` | destinataires et ordre de référence (CP sans effet de filtre, figé) | `tests/type_statut/` | à faire : faux serveur SMTP disponible depuis le 2026-11-14 (`laurux-smtp`, clé `"smtp"` de meta.json), à implémenter |
| EMAILING-T03 | replay | Mode liste | `Liste` coché, saisie de 3 codes dont 1 doublon et 1 inexistant, Envoyer | `Cli_Mailing` créée puis remplie (2 lignes), messages « déjà saisi » / « compte existant », 2 courriels | `tests/mode_liste/` | à faire : faux serveur SMTP disponible depuis le 2026-11-14 (`laurux-smtp`, clé `"smtp"` de meta.json), à implémenter |
| EMAILING-T04 | replay | Mode liste vide puis décoché | `Liste` coché, Envoyer sans code, `Liste` décoché | erreur interceptée par le `Catch` (figée) ; `Cli_Mailing` supprimée | `tests/liste_vide/` | implémenté |
| EMAILING-T05 | replay | Pièce jointe (anomalie) | `btnopen` sur `doc.pdf`, Envoyer | erreur `File.Load` au premier client, aucun courriel (figé, A02) | `tests/piece_jointe/` | à faire : sélection du fichier par Dialog (btnopen) non rejouable ; le serveur SMTP n'est plus un obstacle (faux `laurux-smtp` depuis le 2026-11-14) |
| EMAILING-T06 | replay | Extension non reconnue | `btnopen` sur `a.docx` | message « Impossible d'ouvrir le fichier », `TextBox2` vide | `tests/piece_docx/` | à faire : sélection du fichier par Dialog (btnopen) non rejouable |
| EMAILING-T07 | replay | Grilles de recherche | F2 sur `Client1`, tri par colonne Nom, clic ; idem `Client2` et `Type`/`Type2` | codes recopiés ; tri de `Colcli2` reconfigurant `Colcli` (figé, A07) | `tests/grilles/` | à faire : F2 et clic d'en-tête de colonne non rejoués |
| EMAILING-T08 | replay | Contrôles de saisie | sujet vide, texte vide | messages « veuillez saisir le sujet / le texte » | `tests/saisie_obligatoire/` | implémenté |
| EMAILING-T09 | replay | Mode SMS | Fmenu › SMS › Envoi multiples, texte, Envoyer | « veuillez saisir le sujet » (figé, A01) ; nombre d'appels au faux `curl` (crédits) relevé pour statuer sur `Label7_GotFocus` | `tests/mode_sms/` | à faire : faux `curl` disponible depuis le 2026-11-14 (crédits et envoi Spot-Hit selon l'URL et la clé `/Soc01/Api`), à implémenter |
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
