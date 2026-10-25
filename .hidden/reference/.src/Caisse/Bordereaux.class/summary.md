# Bordereaux — Synthèse

> Source : `.src/Caisse/Bordereaux.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran de caisse « Impression des bordereaux de remises » : PDF de la liste des règlements par
chèque et/ou par carte des tickets non encore moulinés (`Fiches_LigTicketz`), avec totaux par type,
pour la remise en banque.

## Points clés

- 176 lignes, 6 fonctions, lecture seule (aucune écriture en base).
- PDF `Cbordereaux` dans `~/Caisse/Bordereau_[Cheques_|Cartes_]<date>.pdf`, ouvert par `Visualiseur`.
- En-tête société dupliqué (idiome commun à 6 éditions).
- Écran non journalisé (`Utils.Observers` absent).
- Distinct de `BordereauxC` (Comptabilité), qui charge par erreur l'auto-instance de ce
  formulaire (BORDEREAUXC-A01).

## Dépendances principales

- Appelé par `Fmenu.Menu214_Click` ; référencé accidentellement par `BordereauxC:370`.
- Utilise `Cbordereaux`, `Utils.db`/`cpoint`, `Cbase.Table("TabSoc")`, `Start.LocalSettings`,
  `Visualiseur`, `Music`, `Doc`.

## Risques

- Bordereau incluant les règlements des tickets supprimés ou en erreur et toutes les journées non
  moulinées (A01, à confirmer).
- Mise en page incohérente et lecture de la société sans contrôle (A02).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 146 |
| Lignes de commentaire | 7 |
| Fonctions | 6 |
| Fonctions Public | 6 |
| Complexité cyclomatique totale | 24 |
| Complexité max (fonction) | 14 (`Imp_Bordereaux`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

7 tests `replay` (BORDEREAUX-T01 à T07) comparant le texte du PDF (horloge figée) et un dump
inchangé : Tous / Chèques / Cartes, sans données, pagination, tickets supprimés, en-tête société.
Prérequis : instrumentation de l'écran ou rework BORDEREAUX-004.

## Rework

7 étapes (BORDEREAUX-001 à 007) : documentation, code mort, `Cbase.Table`, séparation
traitement/GUI, factorisation des titres et totaux, en-tête société commun, réduction de portée.
2 anomalies (BORDEREAUX-A01, A02) soumises à validation utilisateur.
