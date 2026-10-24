# FEditrel — Synthèse

> Source : `.src/Compta/Relances/FEditrel.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran de préparation et d'édition des relances clients (menu Relances › Préparation des
relances) : génère la table de travail `Fiches_relances` à partir des écritures 411 non lettrées
échues, affiche un client par ligne (`Ligcli`) avec son extrait (`Ligext`) et édite les lettres de
relance ou relevés dans un PDF unique en mettant à jour `Fiches_Mvt.relance`.

## Points clés

- Niveau de relance proposé = dernier niveau + 1, borné à 3.
- Lignes `Ligcli` manipulées via `Variant` : contrat implicite (propriétés et méthodes publiques).
- Deux fonctions lourdes : `Button1_Click` (génération) et `Impressionr` (édition, CC 25).
- Remplace `FPrepRel2` (mort).

## Dépendances principales

- Utilise : `Ligcli`, `Ligext`, `Listextcpt`, `LDate`, `ProgBar`, `Creleve`, `Visualiseur`, `Utils`.
- Tables : `Fiches_relances` (travail), `Fiches_Mvt`, `Fiches_Cli`, `Fiches_Comptes`,
  `Fiches_Societes`, `Fiches_Txt_Relances`, `Fiches_Parametres`.
- Utilisé par : `Fmenu.Menu49_Click`.

## Risques

- Erreur « objet nul » si rien à relancer ou date vide (FEDITREL-A01) ; erreur d'indice à
  l'édition sans ligne (A02).
- Niveau de relance enregistré incohérent avec la lettre choisie (A03).
- Table de travail partagée entre postes (A04).
- Duplication forte avec `Ligcli`, `FRelCompte`, `FRelFacture` (en-tête société, corps de lettre).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 497 |
| Lignes de commentaire | 26 |
| Fonctions | 21 |
| Fonctions Public | 16 |
| Complexité cyclomatique totale | 102 |
| Complexité max (fonction) | 25 (`Impressionr`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

7 tests `replay` (FEDITREL-T01 à T07) : ouverture, génération (normale et vide), navigation/tri,
sélection globale, édition groupée, exclusion des lettres déjà traitées.

## Rework

9 étapes : documentation, code mort, réduction de portée d'`Impressionr`, factorisation de la
navigation et du tri, extraction de la génération, impression commune avec `Ligcli`,
`Cbase.Table`, typage. 4 anomalies (FEDITREL-A01 à A04).
