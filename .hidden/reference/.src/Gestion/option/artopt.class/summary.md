# artopt — Synthèse

> Source : `.src/Gestion/option/artopt.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Onglet « Options » de la fiche article (et de `commande1`) pour les options boisson et carburant :
frais de transport, régie et droits (`Calculdroit`), consignes, prix de revient, tarif fioul ;
enregistrement des colonnes d'option de `Fiches_Art`.

## Points clés

- Formulaire incrusté (7 paramètres obligatoires puis `Parent`), modifie des contrôles de
  l'appelant (`Frais` en lecture seule, `Prvt`) et lève `recalculpx` (traité par
  `Articles.$opt_recalculpx`, ignoré par `commande1`).
- Propriété `creer` et variable `$snbdec` inutilisées.
- `replay_missing` : `Gridtarpp`, `Listcons`, `Listregie` sans `_Click`.

## Dépendances principales

- Utilisé par : `Articles`, `commande1` (`Achat.OptAr` jamais affecté).
- Utilise : `Calculdroit`, `Chainage`, `TextReg`, `Ttarfioul`, `Tconsigne`, `Utils`.
- Tables : `Fiches_Art`, `Fiches_regie`, `Fiches_consigne`, `Fiches_ligtarpp`, `Fiches_Tvaav`.

## Risques

- A01 : transaction laissée ouverte si l'article est introuvable à l'enregistrement.
- A02 : destruction de contrôles de l'appelant à la fermeture (à confirmer).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 472 |
| Lignes de commentaire | 13 |
| Fonctions | 30 |
| Fonctions Public | 17 |
| Complexité cyclomatique totale | 110 |
| Complexité max (fonction) | 15 (`affiche`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

4 tests `replay` (ARTOPT-T01 à T04) : affichage boisson, saisie et recalcul, enregistrement en
options B/P/T, carburant via `Articles` et `commande1`.

## Rework

6 étapes (ARTOPT-001 à 006) : documentation, code mort, réglages `TextReg` en table, affichage
commun des consignes, `LitConsigne` partagé avec `facopt`, séparation calcul/GUI. 2 anomalies.
