# Trecarts — Synthèse

> Source : `.src/Compta/Trecarts.class` · Synthèse des autres documents.

## Rôle

Traitement automatique des petits écarts de règlement : pour chaque lot non lettré d'un compte
client ou fournisseur dont le solde est inférieur ou égal à un seuil, génère une OD (tiers,
compte de régularisation 758/658, collectif), lettre le lot sous un numéro `E…` et met à jour
soldes, numéro d'écriture et chaînage SHA1. Ouvert depuis `Fmenu` (`Trecarts.Show`).

## Points clés

- Tout le traitement est dans le handler `Button2_Click` (CC 24, 150 lignes), sous `LOCK TABLES`
  par lot (neutralisé en SQLite).
- Tables en dur (`Fiches_Comptes`, `Fiches_Parametres`, `Fiches_Mvt`, `Fiches_MvtM`), exercice
  courant seulement.
- Soldes `Fiches_Comptes.solde` mis à jour de façon incrémentale (lecture puis écriture).
- Code mort : `Ecarts_keypress` (aucun contrôle `Ecarts`), `clear()`, membres `TT`/`TD`/`TC`.

## Dépendances principales

- Utilise : `Utils.db`, `Utils.cpoint`, `LDate`, `Sha1Calc.CalcSha1`, `Doc.Open`.
- Utilisé par : `Fmenu` uniquement.

## Risques

- **Signe inversé** sur le solde des comptes de régularisation (TRECARTS-A01) : dérive de
  `Fiches_Comptes.solde` pour 758/658 à chaque traitement.
- Pas de transaction ni de `Catch` : une erreur laisse un lot partiel et des tables verrouillées
  (A03).
- Écritures validées datées du jour, sans contrôle d'exercice (A05) ; compteur du message faux (A02).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 224 |
| Lignes de commentaire | 34 |
| Fonctions | 9 |
| Fonctions Public | 9 |
| Complexité cyclomatique totale | 50 |
| Complexité max (fonction) | 24 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

8 replays (TRECARTS-T01 à T08) sur un jeu dérivé de lots à écarts : clients, fournisseurs, aucun
écart, seuil invalide, compteur, compte sans collectif, lot multi-lignes, SQLite. Critère : dump de
`Fiches_Mvt`, `Fiches_Comptes`, `Fiches_Parametres` (date masquée).

## Rework

7 étapes (TRECARTS-001 à 007) : documentation, code mort, `Cbase.Table`, lettrage en un seul
`UPDATE` (dump identique), helpers `Insere_Ligne`/`Maj_Solde` (commun avec `Tresor`), extraction
de `Genere_Ecarts`, membres en locales. 6 anomalies (A01 à A06) soumises à validation.
