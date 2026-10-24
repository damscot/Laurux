# EditcompteM — Synthèse

> Source : `.src/Compta/Impressions/EditcompteM.module` · Synthèse des autres documents.

## Rôle

Module d'**impression PDF des grands livres** (`~/tmp/Glivre.pdf`), appelé par
`Editcompte.Button1_Click`. Parcourt les comptes de la plage, imprime leurs écritures avec solde
cumulé, les totaux de sous-comptes, de compte, de type (grand livre général) et le total général, et
centralise par mois les comptes `cent_cc = 1` via la table de travail `Ctrln`. Rendu par `Ccompta`.

## Points clés

- `Imprime` : CC 35, 229 LOC ; état dans 35 variables `Private` de module ; pas de `Catch`.
- `Centralisation`, `finmois`, `Raz` identiques à `Editcompte` (et proches d'`EditcompteA`, `Extrait`).
- `finmois` est la seule fonction pure du lot (test `gbtest`).
- Tables en dur (`Fiches_Comptes`, `Fiches_Societes`, `Fiches_SousComptes`).
- Couplage GUI : `Editcompte.Mouse` (auto-instance), `Message`, `Visualiseur`.

## Dépendances principales

- Appelant unique : `Editcompte.Button1_Click` (dépendance circulaire avec `Editcompte`).
- Utilise `Ccompta` (partagée par 15 fichiers), `Utils`, `Visualiseur`.
- Tables : `Fiches_Comptes`, `Fiches_Societes`, `Fiches_SousComptes`, `Fiches_Mvt*` (lecture),
  `Ctrln` (écriture).

## Risques

- **EDITCOMPTEM-A01** : total du dernier groupe de sous-comptes jamais imprimé si la plage finit dans
  le groupe.
- **EDITCOMPTEM-A02** : total « Bilan » à zéro en tête du grand livre général sans compte de bilan.
- **EDITCOMPTEM-A03** : journal des lignes centralisées faux (dernier journal lu).
- `Ctrln` partagée et persistante (A05) ; pas de gestion d'erreur (A04).
- Aucun test existant.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 316 |
| Lignes de commentaire | 15 |
| Fonctions | 5 |
| Fonctions Public | 5 |
| Complexité cyclomatique totale | 42 |
| Complexité max (fonction) | 35 (`Imprime`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

13 tests (EDITCOMPTEM-T01 à T13) : 12 `replay` depuis l'écran `Editcompte` (5 natures, centralisation,
sous-comptes, saut de page, aucune écriture, bornes de dates, solde nul, impressions successives) et
1 `gbtest` sur `finmois`. Comparaison du texte PDF normalisé et du dump (`Ctrln`).

## Rework

7 étapes (EDITCOMPTEM-001 à 007) : documentation, code mort, découpage d'`Imprime` (CC 35 → ≤ 12),
`Cbase`, helper commun de centralisation, curseur et message déplacés dans l'écran, réduction de
portée. 5 anomalies (EDITCOMPTEM-A01 à A05).
