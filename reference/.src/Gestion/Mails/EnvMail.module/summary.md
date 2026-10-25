# EnvMail — Synthèse

> Source : `.src/Gestion/Mails/EnvMail.module` · Synthèse des autres documents.

## Rôle

Module d'envoi de courriels, sans état et sans accès à la base. Deux mécanismes :
- `Envoi` : envoi SMTP direct (`gb.net.smtp`), avec pièce jointe et CGV optionnelles ; utilisé
  pour les tickets de caisse, les factures (`ObjFacB`) et les mailings (`Emailing`,
  `EmailingCarte`) ;
- `Envoi2` / `Envoi3` : ouverture d'une fenêtre de composition dans le client de messagerie
  choisi (`/Soc<XX>/Prgmail` : Thunderbird, Icedove, Evolution, Kmail), par `Shell` ou `Exec`.

`Extension` déduit un type MIME du nom de la pièce jointe d'un mailing.

## Points clés

- 12 fichiers appelants ; `Envoi2` est la fonction la plus utilisée (11 appels).
- Paramètres SMTP lus dans `Start.LocalSettings` (`/Smtp`, `/Port`, `/Adrmail`, `/Utilisateur`,
  `/MdpStmp` déchiffré par `hexdblKey`, `/Secumail`), mais la copie cachée et deux chemins sont
  lus dans l'objet `Settings` par défaut.
- Bloc d'encodage du corps (6 `Replace$`) copié 8 fois ; `Envoi2b` et `Envoi5` sont du code mort.
- `Extension` : CC 56 (maximum), parcours des segments 1 et 2 du nom au lieu de la dernière
  extension.

## Dépendances principales

- Utilise : `Start` (`LocalSettings`, `Societe`), `hexdblKey.Crypt`, `SmtpClient`, programmes
  externes `thunderbird`, `icedove`, `evolution`, `kmail`.
- Utilisé par : `Caisse`, `ObjFacB`, `Emailing`, `EmailingCarte`, `Achat`, `Bordrx`, `FClient`,
  `FFournisseur`, `ExportA47`, `ExportJdv`, `Ligcli`, `Expbase`.

## Risques

- **`Envoi3` jamais exécuté** : son seul appelant (`ExportJdv.class:1000`) passe 5 arguments
  → « Too many arguments » (vérifié), l'export en deux fichiers n'est jamais envoyé (A01).
- **Sécurité** : `SmtpClient.Debug = True` (dialogue SMTP, éventuellement `AUTH`, sur la sortie
  d'erreur, A03) ; commandes `Shell` sans échappement de l'adresse, du sujet et du corps
  (injection de commande, A04) ; copie cachée vers l'adresse du fichier par défaut avec `-c` (A02) ;
  mot de passe SMTP chiffré de façon réversible avec une clé fixe.
- Contrat `chemin`/`FileN` d'`Envoi` non respecté par les mailings : pièces jointes introuvables
  (voir EMAILING-A02, EMAILINGCARTE-A02).
- `Extension` lève « Out of bounds » pour `.docx`, `.xlsx`… (A05) ; `piece2` ignorée hors
  Thunderbird (A06).

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

## Tests

11 tests prévus (ENVMAIL-T01 à T11), dont 10 `gbtest` et 1 `replay` : `Extension`, envoi SMTP
vers un serveur de test local (MailHog ou `aiosmtpd`) dans un `HOME` isolé, lignes de commande
des clients de messagerie capturées par de faux binaires en tête du `PATH`. Non testable sans
infrastructure réelle : TLS/SSL avec certificat, ouverture effective des clients graphiques.

## Rework

7 étapes sans changement de comportement (ENVMAIL-001 à 007) : documentation, suppression
d'`Envoi2b`/`Envoi5`, factorisation de l'encodage du corps, séparation traitement/GUI d'`Envoi`
et d'`Envoi2/3`, simplification des pièces jointes et d'`Extension`. 6 anomalies (ENVMAIL-A01 à
A06), dont 2 de sécurité, sont soumises à validation utilisateur.
