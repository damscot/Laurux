# SaisieInv — Synthèse

> Source : `.src/Gestion/Stock/Inventaires/Fin-annee/SaisieInv.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Saisie des comptages de l'inventaire de fin d'exercice dans `Fiches_Inv` : par n° de ligne ou
par code (code, code équivalent, référence centrale, code-barres), cumul/remplacement d'une ligne
déjà saisie, rappel, suppression, import d'un terminal portable (`~/Portable/inventaire.txt`).

## Points clés

- 19 fonctions, dont 13 handlers ; `Import_Portable` CC 24.
- `Nseq_LostFocus`/`Cart_LostFocus` portent des noms de handlers mais ne sont jamais levés (groupe
  `Rcpt`) : appelés explicitement au clavier.
- Détection de doublon par exception (`Colinv.Add`).
- 93 % identique à `SaisieInvT` → module commun `Inventaire`.
- Parseur du fichier portable dupliqué dans `Achat`, `Facture`, `Majcasier`.

## Dépendances principales

- `Utils.db`, `Cbase`, `Utils.Find_Cbarre`/`cpoint`/`CDec`, `Chainage`, `Editeur`, `Doc`.
- Appelé par `Fmenu.Menu82_Click`. Tables `Fiches_Inv` (lecture, `UPDATE`, `DELETE`), `Fiches_Art`.

## Risques

- Rappel qui efface le comptage (A01), suppression qui sort l'article de l'inventaire (A02),
  écart affiché de signe faux (A03), article supprimé (A04), doublons (A05), import (A06),
  saisie à la souris ignorée (A07).
- `Colinv` sans `Colinv_Click` : scénarios de rejeu au clavier uniquement.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 418 |
| Lignes de commentaire | 50 |
| Fonctions | 19 |
| Fonctions Public | 19 |
| Complexité cyclomatique totale | 104 |
| Complexité max (fonction) | 24 (`Import_Portable`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

15 `replay` + 1 `gbtest` (SAISIEINV-T01 à T16) : affichages, deux modes de saisie, codes
invalides, cumul/remplacement, rappel, suppression, quantités, import (nominal, rejets, absent),
cas d'erreur. **Liste à valider par l'utilisateur avant la phase 2** (module complexe).

## Rework

7 étapes (SAISIEINV-001 à 007) : documentation, code mort, `Cbase.Table`, `MajComptage`,
séparation de l'import, module `Inventaire` et parseur portable commun, réduction de portée de 6
fonctions. 7 anomalies (SAISIEINV-A01 à A07).
