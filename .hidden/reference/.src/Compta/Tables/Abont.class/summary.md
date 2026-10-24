# Abont — Synthèse

> Source : `.src/Compta/Tables/Abont.class` · Synthèse des autres documents.

## Rôle

Écran de création des masques de saisie d'écritures (abonnements) : en-tête `Fiches_Numabon` et
lignes `Fiches_Ligabon` dont les montants et libellés sont des expressions évaluées par la saisie
comptable (`Saisecrit`, `Tresor`).

## Points clés

- Lignes écrites immédiatement en base ; validation du masque qui réécrit tout.
- « Modifier une ligne » = suppression en base puis ressaisie.
- `Compteur_Incr` est la seule méthode utilisée de l'extérieur, sur l'auto-instance du formulaire.
- `Message.Erreur` inexistant ; `ChkPrx`, `Tri`, `Dbl` morts.

## Dépendances principales

- Utilise : `Utils`, `Cbase` (`TabNumabon`, `TabLigabon`, `TabComptes`), `LPrix`, `TriCpt`, `FCalc`, `Doc`.
- Utilisé par : `Fmenu.Menu198_Click`, `Saisecrit.LignAbt`, `Tresor.LignAbt` (`Compteur_Incr`).

## Risques

- A01 : erreur d'exécution si un format de masque ≠ 1 existe.
- A02 : ligne perdue en cas d'abandon d'une modification.
- A03/A04 : suppression sans confirmation, type de compte invalide ensuite.
- A05 : erreur sans sélection ; A06 : instanciation cachée du formulaire.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 438 |
| Lignes de commentaire | 77 |
| Fonctions | 27 |
| Fonctions Public | 27 |
| Complexité cyclomatique totale | 125 |
| Complexité max (fonction) | 16 (`Colecr_Activate`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

7 replays (création achat, trésorerie, lignes, abandon, suppression, compteur via la saisie, format
inconnu) avec diff de `Fiches_Numabon` et `Fiches_Ligabon`.

## Rework

6 étapes (001 à 006) : documentation, code mort, remise à zéro factorisée, `Colecr_Activate`
simplifiée, séparation traitement/GUI, réduction de portée. 6 anomalies (A01 à A06).
