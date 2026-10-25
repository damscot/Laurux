# EmailingCarte — Synthèse

> Source : `.src/Gestion/Mails/EmailingCarte.class` · Synthèse des autres documents.

## Rôle

Écran d'envoi groupé de courriels aux porteurs de cartes de fidélité (`Fiches_Carte`), ouvert par
`Fmenu.Menu240_Click` (auto-instance). Sélection par plage de codes, par plage de codes postaux ou
par liste saisie (table de travail `Cli_Mailing`) ; envoi SMTP direct par `EnvMail.Envoi`.

## Points clés

- Copie simplifiée d'`Emailing` (pas de SMS, ni type, ni statut) ; ≈ 80 % de code commun avec
  `Emailing` et `Eticli`.
- 31 fonctions, toutes `Public` ; `Button2_Click` (CC 25) porte toute la sélection et l'envoi.
- Ici la plage de codes postaux est réellement filtrée (contrairement à Emailing).
- `bstatut_Click` : jamais levé (aucun contrôle `bstatut`), bascule l'auto-instance du formulaire
  `Statut` ; préservé, décision renvoyée à l'anomalie A06.

## Dépendances principales

- Utilise : `EnvMail` (`Envoi`, `Extension`), `Utils` (`db`, `Base`, `rs1`, `Observers`, `FColr`),
  `Cbase` (`TabCarte`), `Doc`, `Start`, formulaire `Statut` (auto-instance).
- Utilisé par : `Fmenu` (`Menu240_Click`).

## Risques

- Pièce jointe introuvable (chemin complet passé comme répertoire), envoi interrompu (A02).
- Toute touche sur le bouton Envoyer déclenche l'envoi (A03).
- Mode liste sans test `Available` (A01) ; `Cli_Mailing` partagée entre postes et avec Emailing
  (A04) ; tri de la seconde grille défectueux (A05).
- Double appel de `Utils.Observers(Me)` : cumul possible d'observateurs de rejeu.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 474 |
| Lignes de commentaire | 52 |
| Fonctions | 31 |
| Fonctions Public | 31 |
| Complexité cyclomatique totale | 136 |
| Complexité max (fonction) | 25 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

7 scénarios `replay` (EMAILINGCARTE-T01 à T07) avec serveur SMTP de test (MailHog) dans un `HOME`
isolé : plages de codes et de codes postaux, mode liste, pièce jointe, grilles, configuration
SMTP absente, touches sur le bouton Envoyer.

## Rework

6 étapes sans changement de comportement (EMAILINGCARTE-001 à 006) : documentation, code mort,
réduction de complexité (SQL identique), commonalisation avec Emailing/Eticli, séparation
traitement/GUI, réduction de portée de 9 fonctions. 6 anomalies (EMAILINGCARTE-A01 à A06)
soumises à validation utilisateur.
