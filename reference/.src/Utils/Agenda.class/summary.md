# Agenda — Synthèse

> Source : `.src/Utils/Agenda.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran d'agenda journalier (menu principal → Agenda) : grille de créneaux de 15 minutes de 06h00 à
20h45, saisie d'une action par créneau stockée dans `Fiches_Agenda` avec l'utilisateur système,
horloge, quantième, semaine et liens vers des sites externes.

## Points clés

- Classe GUI ; SQL dans `Ecr_action` (SELECT puis INSERT ou UPDATE) et `Maj_Zones` (SELECT du jour).
- Requêtes paramétrées et `Cbase.Table("TabAgenda")` : conforme aux règles.
- Code mort mineur (ancienne version commentée, variable inutilisée, double `Init`).

## Dépendances principales

- Utilise : `Utils.db`, `Cbase`, `xdg-open`.
- Utilisé par : `Fmenu` (`Agenda.show`, non détecté par `deps.py`).

## Risques

- Gestion multi-utilisateur incohérente : modification et affichage sans filtre `nuser`
  (AGENDA-A01/A02).
- Faible criticité métier (fonction annexe).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 116 |
| Lignes de commentaire | 16 |
| Fonctions | 15 |
| Fonctions Public | 15 |
| Complexité cyclomatique totale | 23 |
| Complexité max (fonction) | 5 (`Maj_Zones`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

4 scénarios `replay` (AGENDA-T01 à T04) : création, modification, cas multi-utilisateur (anomalies
figées), changement de date ; comparaison du dump de `Fiches_Agenda`.

## Rework

6 étapes (AGENDA-001 à 006) : documentation, code mort, `LDate.D`, séparation SQL/GUI, recherche
de créneau, réduction de portée. 4 anomalies (AGENDA-A01 à A04).
