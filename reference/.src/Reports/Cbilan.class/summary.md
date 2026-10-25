# Cbilan — Synthèse

> Source : `.src/Reports/Cbilan.class` · Synthèse des autres documents.

## Rôle

Gabarit PDF (`Inherits PdfWriter`, A4 portrait) du **bilan comptable**, piloté par
`Compta/Impressions/Imp_Bilan.module`. Colonnes actif (brut, amortissements, net N) ou passif
(N) selon le paramètre `Sens` ; couleurs fixes (gris 223).

## Points clés

- 11 méthodes ; `Level0` crée la page (titre, période, société), `Level3` pose les en-têtes.
- `Level1`, `Level1L`, `Level1S` (CC 17, 16, 15) contiennent la logique de présentation du net
  (`brut − amortissements`, zéros effacés, `Format$(…, ",#")` sous `Try`).
- Code mort : `Level1A`, `Level2`, `_free`. Paramètres ignorés : `detail`, `dte2`, `p5`, `imp3`,
  `imp4` (la colonne N-1 n'est jamais imprimée).

## Dépendances principales

- Utilise : `PdfWriter`, `Utils.cpoint`, `User.Name`, `Now`.
- Utilisé par : `Compta/Impressions/Imp_Bilan.module` uniquement.

## Risques

- Défauts communs à tous les gabarits, hérités de `PdfWriter` : encodage (€ → ¤, accents perdus,
  PDFWRITER-A01) et largeur de texte fausse qui décale les montants alignés à droite
  (PDFWRITER-A02).
- **Net nul affiché comme le brut** (poste totalement amorti) dans `Level1` et `Level1S`
  (CBILAN-A01).
- `Level1L` calcule le net sur la valeur absolue du brut, pas les totaux (CBILAN-A02, à confirmer).
- Une conversion qui échoue (`Val("")`) supprime silencieusement la cellule (`Try Me.cell`) :
  comportement à préserver lors de la factorisation.
- Calcul dépendant de la locale (`Val` localisé après `Utils.cpoint`).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 166 |
| Lignes de commentaire | 6 |
| Fonctions | 11 |
| Fonctions Public | 11 |
| Complexité cyclomatique totale | 67 |
| Complexité max (fonction) | 17 (`Level1`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

4 tests `gbtest` (en-têtes, net de `Level1`, nets de `Level1L`/`Level1S`, multi-pages) et 1 replay
du bilan complet sur le jeu comptable dérivé (avec une immobilisation totalement amortie) ;
comparaison `pdftotext` en locale `fr_FR.UTF-8`.

## Rework

6 étapes (CBILAN-001 à 006) : documentation, suppression du code mort et des paramètres inutilisés
(avec `Imp_Bilan`), extraction du calcul du net, factorisation des trois `Level1*`, dérivation de
`PdfLaurux`. 2 anomalies (A01 net nul, A02 valeur absolue) soumises à validation.
