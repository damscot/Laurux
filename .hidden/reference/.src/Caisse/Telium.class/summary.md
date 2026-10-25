# Telium — Synthèse

> Source : `.src/Caisse/Telium.class` · Synthèse des autres documents.

## Rôle

Ébauche de pilote de TPE Ingenico Telium sur port série (`gb.net` `SerialPort`,
`/dev/ttyACM0`, 9600 8N1), importée avec Laurux-Pos en 2018 et jamais terminée ni appelée.

## Points clés

- Classe **jamais référencée** (aucun appelant, aucun `.form`, nom absent des chaînes) :
  signal `jamais_reference` confirmé ; `demanderPaiement` et ses 5 fonctions privées sont du code
  mort (`unused`, `unused_transitive`).
- Protocole visé : trame `STX` … LRC, dialogue `ACK`/`EOT`/`ENQ` (protocole caisse, à confirmer).
- Implémentation inopérante, vérifiée sur une copie avec un faux TPE (`socat`) : lecture non
  bloquante → échec immédiat ; `Print` ajoute un LF ; erreur d'ouverture remplacée par
  « not static » ; trame mal formée, LRC faux, réponse jamais lue, retour toujours `False`.

## Dépendances principales

- Composant `gb.net` (`SerialPort`) ; périphérique série. Aucun appelant, aucune table.

## Risques

- Aucun en production (jamais exécutée). Risque de fausse impression de fonctionnalité TPE.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 97 |
| Lignes de commentaire | 1 |
| Fonctions | 7 |
| Fonctions Public | 2 |
| Complexité cyclomatique totale | 26 |
| Complexité max (fonction) | 5 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

3 tests `gbtest` prévus (port absent, faux TPE sur pty `socat`, modes), utiles seulement si la
classe est conservée. Le faux périphérique `socat` + script Python fonctionne (essai phase 1) ;
le comportement d'un vrai TPE reste non testable sans matériel.

## Rework

1 étape (TELIUM-001) : suppression [code mort], à confirmer si un pilote TPE est prévu.
4 anomalies (TELIUM-A01 à A04), pertinentes seulement en cas de conservation.
