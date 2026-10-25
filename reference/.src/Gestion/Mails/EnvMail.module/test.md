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
| ENVMAIL-T01 | gbtest | `Extension` | `doc.pdf`, `IMG.JPG`, `a.tar.gz`, `facture.2024.pdf`, `x.rtf`, `son.wav`, `a.b.c.pdf`, `doc`, `a.docx` | type MIME par cas ; « Out of bounds » figé pour `doc` et `a.docx` | `tests/extension_mime/` | à faire |
| ENVMAIL-T02 | gbtest | `Envoi` sans pièce jointe | `/Smtp=127.0.0.1`, `/Port=1025`, `/Secumail=Sans`, mot de passe chiffré de test | 1 message reçu : `To`, `Bcc` (valeur de `Settings["/Adrmail"]`), sujet, corps ; retour `False` | `tests/smtp_simple/` | à faire |
| ENVMAIL-T03 | gbtest | `Envoi` avec pièce jointe, sans puis avec `/Soc01/Pdfchemin` | `chemin` = répertoire, `FileN` = `Ticket.pdf` | 1 puis 2 pièces jointes, noms et types MIME (le type de la 2ᵉ = `TypeM`) | `tests/smtp_pieces/` | à faire |
| ENVMAIL-T04 | gbtest | `Envoi` : contrat `chemin`/`FileN` des mailings | `chemin` = chemin complet, `FileN` = nom | erreur `File.Load` propagée (figée, voir EMAILING-A02) | `tests/smtp_chemin_complet/` | à faire |
| ENVMAIL-T05 | gbtest | `Envoi` : `Email` vide | `""` | aucun message, retour `False` | `tests/smtp_vide/` | à faire |
| ENVMAIL-T06 | gbtest | `Envoi` : `Bcc` lu dans `Settings` et non dans `-c` | `Laurux.conf` par défaut et fichier `-c` avec deux `/Adrmail` différents | `Bcc` = adresse du fichier par défaut (anomalie figée, ENVMAIL-A02) | `tests/smtp_bcc_settings/` | à faire |
| ENVMAIL-T07 | gbtest | `Envoi2` Thunderbird, 1 et 2 pièces | corps avec `,` `;` `(` `)` `'` et sauts de ligne | `argv.txt` du faux `thunderbird` identique à la référence | `tests/compose_thunderbird/` | à faire |
| ENVMAIL-T08 | gbtest | `Envoi2` Icedove / Evolution / Kmail | mêmes entrées, `/Soc01/Prgmail` variant | `argv.txt` de référence ; `piece2` ignorée (figé) | `tests/compose_autres/` | à faire |
| ENVMAIL-T09 | gbtest | `Envoi3` (appel direct à 4 arguments) | Thunderbird et Icedove, `/Soc01/Pdfchemin` renseigné | `argv.txt` : pièce + CGV | `tests/compose_envoi3/` | à faire |
| ENVMAIL-T10 | replay | `ExportJdv` → `Envoi3` à 5 arguments | écran Export journal, format 2 pièces, adresse renseignée | message « Le fichier n'a pas pu être envoyé » ; aucun lancement du client (figé, ENVMAIL-A01) | `tests/exportjdv_envoi3/` | à faire |
| ENVMAIL-T11 | gbtest | Corps avec `"`, `$(…)`, `` ` `` | `Envoi2` Thunderbird, faux binaire | figer la commande effectivement exécutée (preuve de l'injection, ENVMAIL-A04) ; aucun effet hors `HOME` de test | `tests/compose_injection/` | à faire |

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
