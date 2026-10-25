# Psms — Synthèse

> Source : `.src/Gestion/SMS/Psms.class` · Synthèse des autres documents.

## Rôle

Formulaire de paramétrage SMS (support, clé API Spot-Hit, type de contrat, expéditeur) stocké
dans une table `Fiches_Psms`, avec contrôle de la clé par `curl` sur l'API Spot-Hit.

## Points clés

- **Couple `.class` + `.form` mort** : aucun menu ni aucune classe ne l'ouvre (vérifié par grep).
- **Table inexistante** : `Fiches_Psms` est absente de `db_control.csv`, `Laurux01.sql` et
  `LauruxMaj.module`.
- Le paramétrage SMS réellement utilisé est dans `Prefs` (`/Soc<XX>/Support`, `/Api`, `/Type`,
  `/Expediteur`), lu par `Gsm` et `Emailing`.
- 6 handlers, aucune fonction métier.

## Dépendances principales

- Utilise : `Utils.db`, `Doc`, `curl` (API HTTP Spot-Hit), `~/tmp/sms.txt`.
- Utilisé par : aucun fichier.

## Risques

- Aucun en exploitation (inaccessible). S'il était réactivé : `UPdate … WHERE lind = &5` sans
  5ᵉ argument, `Truncate` incompatible SQLite, clé API en HTTP clair et sur la ligne de commande.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 51 |
| Lignes de commentaire | 1 |
| Fonctions | 6 |
| Fonctions Public | 6 |
| Complexité cyclomatique totale | 13 |
| Complexité max (fonction) | 5 (`api_LostFocus`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

1 test `gbtest` (PSMS-T01) de constat : aucune référence hors du couple, table absente. Les
handlers ne sont pas atteignables par le rejeu.

## Rework

1 étape de documentation (PSMS-001). 2 anomalies : suppression du couple mort (PSMS-A01) et
défauts à corriger si le formulaire est conservé (PSMS-A02).
