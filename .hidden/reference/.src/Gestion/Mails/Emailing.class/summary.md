# Emailing — Synthèse

> Source : `.src/Gestion/Mails/Emailing.class` · Synthèse des autres documents.

## Rôle

Écran d'envoi groupé de courriels aux clients (`Fiches_Cli`), ouvert par `Fmenu` en mode
`"mail"` (E-mailing) ou `"sms"` (SMS › Envoi multiples). Les destinataires sont choisis par plage
de codes, type client, statut, tri (code, type, code postal) ou liste saisie code par code (table
de travail `Cli_Mailing`) ; chaque client reçoit le message par `EnvMail.Envoi` (SMTP direct).

## Points clés

- 41 fonctions, toutes `Public` ; `Button2_Click` (CC 37) concentre 14 variantes de `SELECT`.
- Copie quasi identique d'`EmailingCarte` et d'`Eticli` (grilles, plage, liste, navigation).
- Mode SMS : contrôle de crédit Spot-Hit par `curl` ; `EnvoiSms` (gammu ou Spot-Hit) est du code
  mort.
- `Statut` est ici un ComboBox du formulaire (pas le formulaire `Statut`).
- Noms de tables en dur (`Fiches_Cli`, `Fiches_Typec`) hors `Button2_Click`.

## Dépendances principales

- Utilise : `EnvMail` (`Envoi`, `Extension`), `Utils` (`db`, `Base`, `rs1`, `Observers`, `FColr`),
  `Cbase`, `Doc`, `Start` ; tables `Fiches_Cli`, `Fiches_Typec`, `Fiches_Statut`, `Cli_Mailing`.
- Externes : `curl` + API HTTP Spot-Hit, `gammu` (code mort), `~/tmp/sms.txt`.
- Utilisé par : `Fmenu` (`Menu175_Click`, `Menu320_Click`).

## Risques

- **Mode SMS inopérant** : le sujet masqué est exigé, aucun SMS ne part (A01).
- **Pièce jointe cassée** : chemin complet passé comme répertoire à `EnvMail.Envoi`, mailing
  interrompu au premier client (A02).
- Toute touche sur le bouton Envoyer lance le mailing, double envoi possible (A04).
- Filtre code postal sans effet (A05) ; bouton radio masqué → erreur ou mauvaise sélection (A06).
- Table `Cli_Mailing` partagée entre postes et avec `EmailingCarte` (A08).
- Sécurité : clé API Spot-Hit en HTTP clair et sur la ligne de commande (A09).
- Double appel de `Utils.Observers(Me)` : cumul possible d'observateurs de rejeu.

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

## Tests

11 scénarios `replay` (EMAILING-T01 à T11) dans un `HOME` isolé avec serveur SMTP de test
(MailHog) et faux `curl`/`gammu` : plages, filtres, mode liste, pièce jointe, grilles, saisies
obligatoires, mode SMS, touches sur le bouton. Non testable sans matériel ni service réel : clé
GSM (`gammu`) et API Spot-Hit.

## Rework

9 étapes sans changement de comportement (EMAILING-001 à 009) : documentation, code mort,
réduction de complexité de `Button2_Click` (SQL identique), fusion des copies de grilles,
`Cbase.Table`, commonalisation avec `EmailingCarte`/`Eticli` et le module SMS commun, séparation
traitement/GUI, réduction de portée de 9 fonctions. 9 anomalies (EMAILING-A01 à A09) soumises à
validation utilisateur.
