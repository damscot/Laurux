# Histocliart — Synthèse

> Source : `.src/Statistiques/Histocliart.class` · Synthèse des autres documents.

## Rôle

Historique des ventes croisé par client, article ou famille (menu `Fmenu`), avec détail optionnel,
quantité, CA et marge, sur les documents en cours, les factures historisées (normales et matériel)
ou les tickets de caisse, filtré par période, plages de tiers et d'articles, type client, commercial,
marque, centrale et familles. Sorties : édition PDF (`gb.report`) ou export CSV.

## Points clés

- Pas de table de travail : une requête d'agrégat construite dynamiquement (`crearequ`, CC 141,
  350 lignes) sur l'union des sources cochées, avec conversion des valeurs textuelles.
- Les tickets prennent la dernière version de chaque bloc et excluent les tickets supprimés ; leur
  sous-requête n'a pas le même nombre de colonnes, d'où leur exclusivité.
- `Bsel`/`Bval` écrits dynamiquement par `TriCpt`/`TriArticles` : restent `Public`.
- Tables nommées en dur (sauf les commerciaux).

## Dépendances principales

- Appelé par `Fmenu` (ligne 2411).
- Utilise `Utils.db` (`Exec`, `Subst`), `Utils.fam`, `LDate`, `TextReg`, `Chainage`, `Trifam`,
  `TriCpt`, `TriArticles`, `gb.report`, `Visualiseur`, `Editeur`.

## Risques

- SQL invalide si factures et factures matériel sans document en cours (A01) ou familles sans
  sélection (A02, UTILS-A02).
- Contrôle du mauvais code client (A03) ; sélection annulée qui reprend l'ancienne (A04) ; export
  sans garde (A05).
- Sous-totaux dépendants de l'ordre implicite du `GROUP BY`, lignes orphelines omises (A06) ;
  détails d'affichage (A07).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 836 |
| Lignes de commentaire | 67 |
| Fonctions | 26 |
| Fonctions Public | 18 |
| Complexité cyclomatique totale | 245 |
| Complexité max (fonction) | 141 (`crearequ`) |
| Variables globales | 0 |
| Variables Public | 3 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

11 tests prévus (HISTOCLIART-T01 à T11) : 10 replays (modes, sources, tickets, filtres, cas
d'erreur, sélection de tiers) comparant le CSV, le texte du PDF et surtout les lignes `Exec_SQL`
(référence bloquante pour le rework de `crearequ`), puis 1 gbtest de la construction de la requête
après extraction.

## Rework

8 étapes (HISTOCLIART-001 à 008) : documentation, code mort, factorisation de `crearequ` à SQL
identique, fonction pure de construction de requête, `Cbase.Table`, export séparé, sélection de tiers
factorisée, réduction de portée de `Cli_man`. 7 anomalies (HISTOCLIART-A01 à A07).
