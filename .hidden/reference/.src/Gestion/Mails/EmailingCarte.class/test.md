# EmailingCarte — Tests

> Source : `.src/Gestion/Mails/EmailingCarte.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI : scénarios `replay` capturés dans le clone **Laurux non modifié**, même environnement
qu'Emailing : `HOME` isolé, serveur SMTP de test (MailHog `127.0.0.1:1025`), base `Laurux01.sql`
+ jeu dérivé `cartes_base` (~8 cartes `Fiches_Carte` avec et sans `email`, codes postaux
variés, adresses `@example.test`). Comparaison : messages reçus, dump de la base (dont
`Cli_Mailing`).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EMAILINGCARTE-T01 | replay | Plage de codes, tri par code puis par CP | Fmenu › Emailing (cartes), sujet + texte, `RadioButton1` puis `RadioButton3` | messages par carte avec courriel, dans l'ordre de référence | `tests/plage_code/` | implémenté (gb.test `EmailingCarteTest.T01PlageCode` : RadioButton1 puis RadioButton3, Button2_Click direct, faux SMTP : 1001 et 1003 à chaque passage ; boîtes répondues par un Timer) ; le rejeu reste bloqué (REPLAYOBSERVER-A18) |
| EMAILINGCARTE-T02 | replay | Plage de codes postaux | `CheckCp`, `Cp1`/`Cp2` restreints | seules les cartes de la plage reçoivent le message | `tests/plage_cp/` | implémenté (gb.test `EmailingCarteTest.T02PlageCp` : CheckCp 44000..69999 : seul 1001 reçoit le message) |
| EMAILINGCARTE-T03 | replay | Mode liste | `Liste`, 3 codes (1 doublon, 1 inexistant), Envoyer ; puis liste vide | `Cli_Mailing` remplie, messages d'erreur ; liste vide → erreur `Catch` (figée) ; `Panel4` resté visible | `tests/mode_liste/` | implémenté sans envoi (cartes sans courriel) ; liste vide non couverte |
| EMAILINGCARTE-T04 | replay | Pièce jointe | `btnopen` sur `doc.pdf`, Envoyer | erreur `File.Load` au premier porteur (figé, A02) | `tests/piece_jointe/` | à faire : Dialog (btnopen) non rejouable ; en gb.test, sans Dialog, `FileN` (privé) reste vide et l'erreur `File.Load` aboutit au `Message.Error` du `Catch` de Button2_Click (bloquant en gb.test) |
| EMAILINGCARTE-T05 | replay | Grilles et tri | F2 sur `Client1`/`Client2`, tri par colonne, sélection | codes recopiés ; tri de `Colcli2` reconfigurant `Colcli` (figé, A05) | `tests/grilles/` | implémenté partiellement (gb.test `EmailingCarteTest.T05Grilles` : listes ouvertes par ToggleButton1/2 (équivalent de F2), tri par en-tête appelé directement : ordre de `Utils.rs1`, colonnes de Colcli ; A05 non observable, Colcli déjà configurée à l'identique) ; à faire : clic sur une ligne (cellules vides sans événement Data hors affichage) |
| EMAILINGCARTE-T06 | replay | Configuration SMTP absente | `Laurux.conf` sans `/Smtp` | message d'erreur et fermeture à l'ouverture | `tests/smtp_absent/` | implémenté |
| EMAILINGCARTE-T07 | replay | Touche sur le bouton Envoyer | focus sur `Button2`, Tab puis Espace | nombre d'envois déclenchés (figé, A03) | `tests/btn_keypress/` | implémenté (`Gestion/emailingcarte_btn_keypress` : Tab → 1 traitement (A03 figée), Espace → 1 seul traitement ; cartes sans courriel, aucune connexion SMTP) |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone Laurux non modifié (MailHog vidé avant chaque
  scénario, en-têtes volatils masqués).
- **Rejeu** : `_New` appelle deux fois `Utils.Observers(Me)` : vérifier l'absence d'événements
  rejoués en double. `ColCli_Click`/`ColCli2_Click` existent : pas de `replay_missing`.
- **`bstatut_Click`** n'est pas testable par l'interface (aucun contrôle ne le lève) ; le test
  STATUT-T04 de la documentation de Statut, qui suppose un bouton statut dans cet écran, est à
  revoir.
- **Non testable sans service réel** : délivrabilité SMTP, TLS avec certificat réel.

### Implémentation (phase 2, vague 5)
- Jeu partagé `.hidden/Tests/Gestion/assets/emailingcarte_shared/cartes.sql` : cartes 1001 à 1003 sans courriel
  (aucun envoi SMTP). Scénarios `emailingcarte_smtp_absent` (T06 : `Laurux-test.conf` n'a pas de `/Smtp`) et
  `emailingcarte_mode_liste` (T03 : `/Smtp`, `/Port`, `/Adrmail` posés par `"conf"`).
- Le code client est saisi en chiffres (filtre `ChkInput`) ; `Client1` est prérempli (`000001`) : vidé par Suppr/BackSpace.
