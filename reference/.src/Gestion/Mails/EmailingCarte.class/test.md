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
| EMAILINGCARTE-T01 | replay | Plage de codes, tri par code puis par CP | Fmenu › Emailing (cartes), sujet + texte, `RadioButton1` puis `RadioButton3` | messages par carte avec courriel, dans l'ordre de référence | `tests/plage_code/` | à faire |
| EMAILINGCARTE-T02 | replay | Plage de codes postaux | `CheckCp`, `Cp1`/`Cp2` restreints | seules les cartes de la plage reçoivent le message | `tests/plage_cp/` | à faire |
| EMAILINGCARTE-T03 | replay | Mode liste | `Liste`, 3 codes (1 doublon, 1 inexistant), Envoyer ; puis liste vide | `Cli_Mailing` remplie, messages d'erreur ; liste vide → erreur `Catch` (figée) ; `Panel4` resté visible | `tests/mode_liste/` | à faire |
| EMAILINGCARTE-T04 | replay | Pièce jointe | `btnopen` sur `doc.pdf`, Envoyer | erreur `File.Load` au premier porteur (figé, A02) | `tests/piece_jointe/` | à faire |
| EMAILINGCARTE-T05 | replay | Grilles et tri | F2 sur `Client1`/`Client2`, tri par colonne, sélection | codes recopiés ; tri de `Colcli2` reconfigurant `Colcli` (figé, A05) | `tests/grilles/` | à faire |
| EMAILINGCARTE-T06 | replay | Configuration SMTP absente | `Laurux.conf` sans `/Smtp` | message d'erreur et fermeture à l'ouverture | `tests/smtp_absent/` | à faire |
| EMAILINGCARTE-T07 | replay | Touche sur le bouton Envoyer | focus sur `Button2`, Tab puis Espace | nombre d'envois déclenchés (figé, A03) | `tests/btn_keypress/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone Laurux non modifié (MailHog vidé avant chaque
  scénario, en-têtes volatils masqués).
- **Rejeu** : `_New` appelle deux fois `Utils.Observers(Me)` : vérifier l'absence d'événements
  rejoués en double. `ColCli_Click`/`ColCli2_Click` existent : pas de `replay_missing`.
- **`bstatut_Click`** n'est pas testable par l'interface (aucun contrôle ne le lève) ; le test
  STATUT-T04 de la documentation de Statut, qui suppose un bouton statut dans cet écran, est à
  revoir.
- **Non testable sans service réel** : délivrabilité SMTP, TLS avec certificat réel.
