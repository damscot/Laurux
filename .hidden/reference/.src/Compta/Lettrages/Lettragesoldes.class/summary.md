# Lettragesoldes — Synthèse

> Source : `.src/Compta/Lettrages/Lettragesoldes.class` · Synthèse des autres documents.

## Rôle

Traitement de masse qui lettre (lot `S…`) les écritures non lettrées de `Fiches_Mvt` des comptes
clients ou fournisseurs dont le solde enregistré dans `Fiches_Comptes` est nul.

## Points clés

- Copie structurelle de `Lettragemontant` ; tout le traitement dans `Button2_Click`.
- Repose sur `Fiches_Comptes.solde` calculé par `Csolde` ; recoupe la sélection de `Fprepdus`.
- UPDATE rejoué pour chaque ligne ; SHA1 recalculé ligne à ligne.

## Dépendances principales

- Utilise : `Utils.db`, `Sha1Calc`, `Doc` ; tables `Fiches_Comptes`, `Fiches_Mvt` (en dur).
- Utilisé par : `Fmenu.Menu127_Click`.

## Risques

- A01 : seules les lignes du lot de la première ligne sont lettrées ; lot NULL → rien de lettré.
- A02 : aucun contrôle d'équilibre des lignes lettrées ; lignes provisoires incluses.
- A03 : lot commun `"S"` ; A04 : page d'aide d'un autre écran (à confirmer).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 68 |
| Lignes de commentaire | 22 |
| Fonctions | 5 |
| Fonctions Public | 5 |
| Complexité cyclomatique totale | 14 |
| Complexité max (fonction) | 7 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

3 replays (clients, fournisseurs, jeu contrôlé) avec dump de `Fiches_Mvt`, 1 gbtest après extraction.

## Rework

6 étapes (001 à 006) : documentation, code mort, UPDATE unique (dump identique), `Cbase.Table`,
séparation traitement/GUI, module commun avec Lettragemontant. 4 anomalies (A01 à A04).
