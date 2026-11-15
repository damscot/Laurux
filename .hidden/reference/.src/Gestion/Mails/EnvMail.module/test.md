# EnvMail — Tests

> Source : `.src/Gestion/Mails/EnvMail.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Module sans accès à la base : les tests portent sur le **message SMTP produit** et sur la **ligne
de commande** passée au client de messagerie. Aucun envoi réel : tout se fait dans un `HOME`
isolé (`HOME=$(mktemp -d)`, `Laurux.conf` de test passé par `-c` **et** copié en
`$HOME/.config/gambas3/Laurux.conf` pour l'objet `Settings`), avec :
- un **serveur SMTP de test** local : MailHog (`mailhog -smtp-bind-addr 127.0.0.1:1025`, API HTTP
  pour relire les messages) ou `python3 -m aiosmtpd -n -l 127.0.0.1:1025` (le module `smtpd` a
  disparu de Python 3.12) ;
- de **faux binaires** `thunderbird`, `icedove`, `evolution`, `kmail` placés en tête du `PATH` :
  un script qui écrit ses arguments (`printf '%s\n' "$@" > $HOME/argv.txt`) et rend la main.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| ENVMAIL-T01 | gbtest | `Extension` | `doc.pdf`, `IMG.JPG`, `a.tar.gz`, `facture.2024.pdf`, `x.rtf`, `son.wav`, `a.b.c.pdf`, `doc`, `a.docx` | type MIME par cas ; « Out of bounds » figé pour `doc` et `a.docx` | `tests/extension_mime/` | implémenté |
| ENVMAIL-T02 | gbtest | `Envoi` sans pièce jointe | `/Smtp=127.0.0.1`, `/Port=1025`, `/Secumail=Sans`, mot de passe chiffré de test | 1 message reçu : `To`, `Bcc` (valeur de `Settings["/Adrmail"]`), sujet, corps ; retour `False` | `tests/smtp_simple/` | implémenté (gb.test `EnvMailTest.T02SmtpSimple`, faux serveur `laurux-smtp` : enveloppe, De/À, objet, corps ; Bcc lu dans `Settings`, ENVMAIL-A02) |
| ENVMAIL-T03 | gbtest | `Envoi` avec pièce jointe, sans puis avec `/Soc01/Pdfchemin` | `chemin` = répertoire, `FileN` = `Ticket.pdf` | 1 puis 2 pièces jointes, noms et types MIME (le type de la 2ᵉ = `TypeM`) | `tests/smtp_pieces/` | implémenté (gb.test `EnvMailTest.T03SmtpPieces` : 1 puis 2 pièces jointes, noms, types, tailles, md5) |
| ENVMAIL-T04 | gbtest | `Envoi` : contrat `chemin`/`FileN` des mailings | `chemin` = chemin complet, `FileN` = nom | erreur `File.Load` propagée (figée, voir EMAILING-A02) | `tests/smtp_chemin_complet/` | implémenté (gb.test `EnvMailTest.T04SmtpCheminComplet` : « File or directory does not exist », aucun message) |
| ENVMAIL-T05 | gbtest | `Envoi` : `Email` vide | `""` | aucun message, retour `False` | `tests/smtp_vide/` | implémenté |
| ENVMAIL-T06 | gbtest | `Envoi` : `Bcc` lu dans `Settings` et non dans `-c` | `Laurux.conf` par défaut et fichier `-c` avec deux `/Adrmail` différents | `Bcc` = adresse du fichier par défaut (anomalie figée, ENVMAIL-A02) | `tests/smtp_bcc_settings/` | implémenté (gb.test `EnvMailTest.T06SmtpBccSettings` : Bcc = `Settings["/Adrmail"]`, From = `/Adrmail` du fichier `-c` ; Settings sans `/Adrmail` : aucune copie cachée, envoi réussi) |
| ENVMAIL-T07 | gbtest | `Envoi2` Thunderbird, 1 et 2 pièces | corps avec `,` `;` `(` `)` `'` et sauts de ligne | `argv.txt` du faux `thunderbird` identique à la référence | `tests/compose_thunderbird/` | implémenté (faux thunderbird, trace) |
| ENVMAIL-T08 | gbtest | `Envoi2` Icedove / Evolution / Kmail | mêmes entrées, `/Soc01/Prgmail` variant | `argv.txt` de référence ; `piece2` ignorée (figé) | `tests/compose_autres/` | implémenté |
| ENVMAIL-T09 | gbtest | `Envoi3` (appel direct à 4 arguments) | Thunderbird et Icedove, `/Soc01/Pdfchemin` renseigné | `argv.txt` : pièce + CGV | `tests/compose_envoi3/` | implémenté |
| ENVMAIL-T10 | replay | `ExportJdv` → `Envoi3` à 5 arguments | écran Export journal, format 2 pièces, adresse renseignée | message « Le fichier n'a pas pu être envoyé » ; aucun lancement du client (figé, ENVMAIL-A01) | `tests/exportjdv_envoi3/` | implémenté (`Gestion/envmail_exportjdv_envoi3` : 2e boîte FMessage = message d'échec d'envoi (une 3e réponse échoue, code 3), `outils.trace` absent : aucun client lancé) |
| ENVMAIL-T11 | gbtest | Corps avec `"`, `$(…)`, `` ` `` | `Envoi2` Thunderbird, faux binaire | figer la commande effectivement exécutée (preuve de l'injection, ENVMAIL-A04) ; aucun effet hors `HOME` de test | `tests/compose_injection/` | implémenté (le guillemet casse la commande sh : client non lancé) |

## Détail des tests

- **Valeurs attendues** : générées en exécutant les mêmes appels dans le clone **Laurux non
  modifié** (messages relus par l'API de MailHog ou le fichier de sortie d'`aiosmtpd`,
  `argv.txt` des faux binaires), puis stockées dans `tests/<nom>/expected/`. Les en-têtes
  volatils (`Date`, `Message-ID`, frontières MIME) sont masqués avant comparaison.
- **Données** : aucune base nécessaire ; `Laurux.conf` de test avec les clés listées dans
  architecture.md (mot de passe SMTP chiffré par `hexdblKey.Crypt("en", …)`).
- **GUI** : `Message.Error` (échec SMTP) et `Message.Warning` (`Prgmail` vide) bloquent un test
  sans écran ; ces cas sont couverts par la séparation traitement/GUI (ENVMAIL-004/005) ou par un
  replay manuel.
- **Non testable sans infrastructure réelle** : chiffrement `SSL`/`TLS` avec un vrai certificat
  (possible avec un serveur de test configuré en TLS, hors périmètre initial), délivrabilité,
  ouverture effective des fenêtres de composition Thunderbird/Evolution/Kmail (programme
  graphique externe ; seul l'appel est vérifié via les faux binaires).
- **Sécurité** : vérifier dans T02 que la sortie d'erreur contient le dialogue SMTP
  (`Debug = True`) et si la ligne `AUTH` y figure (ENVMAIL-A03) ; ne jamais utiliser de vrais
  identifiants dans les jeux de test.

### Implémentation (phase 2, vague 5)
- Module `.src/Tests/Gestion/EnvMailTest.test` (T01, T05, T07, T08, T09, T11) : faux clients de
  `.src/Tests/Framework/bin` en tête du PATH, trace par appel dans un fichier temporaire (`LAURUX_FACTICE_TRACE`),
  attente de la trace (Shell asynchrone). `Prgmail`/`Pdfchemin` posés en mémoire dans `Start.LocalSettings`.
- Observé : T01, `a.b.c.pdf` rend une chaîne vide (seuls les indices 1 et 2 sont examinés), `son.wav` rend
  `video/wav`, `x.rtf` rend `application/msword` ; « Out of bounds » pour `doc` et `a.docx`.
  T08 Icedove : sujet et corps non protégés, découpés en plusieurs arguments par le shell. T11 : un guillemet dans
  le corps casse la commande `sh` (client jamais lancé, aucune erreur signalée) ; l'injection `$(…)` n'est donc
  pas observée dans ce cas (ENVMAIL-A04 à compléter par un corps sans guillemet).
