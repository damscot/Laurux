# Impression — Synthèse

> Source : `.src/Utils/Impression.module` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Envoie un PDF à l'imprimante (`lpr` ou commande configurée) : tickets de caisse (`Ticket`) et
factures (`Facture`), avec aperçu optionnel via `Visualiseur`.

## Points clés

- `Ticket` lit les réglages de caisse de la société ; `Facture` lit des clés globales jamais écrites
  par le code (les préférences de caisse sont enregistrées ailleurs).
- `/choiximp2` : aucune impression de facture.
- `Bordrx` appelle `Impression.Prog_Editeur`, qui n'existe pas.
- `Shell "cd"` sans effet ; fonctions déclarées `As String` sans retour.

## Dépendances principales

- Appelants : `Caisse`, `Facturergbl`, `EdPrep`, `ObjFacB` (et `Bordrx`, en erreur).
- `Visualiseur`, `Start.LocalSettings` ; programme `lpr`.

## Risques

- Impression des factures peut-être pilotée par des réglages invisibles pour l'utilisateur.
- Erreur d'exécution dans `Bordrx`.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 44 |
| Lignes de commentaire | 1 |
| Fonctions | 2 |
| Fonctions Public | 2 |
| Complexité cyclomatique totale | 11 |
| Complexité max (fonction) | 7 (`Facture`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

3 tests (IMPRESSION-T01 à T03) : 2 `gbtest` avec `lpr` factice, 1 `replay` d'impression de ticket.

## Rework

3 étapes (IMPRESSION-001 à 003) : documentation, nettoyage, helper de commande commun. 3 anomalies
(IMPRESSION-A01 à A03).
