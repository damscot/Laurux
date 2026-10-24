# TarArt — Synthèse

> Source : `.src/Utils/TarArt.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Calcul du prix de vente HT applicable à un article pour un client ou un type de client, avec la
liste des tarifs candidats affichée dans une grille : prix de base, remises et coefficients par
type client/famille/article, tarifs client, promotion, déduction des droits sur alcools
(options B/T).

## Points clés

- Formulaire dont tout le calcul est dans le constructeur `_new` (CC 32).
- Priorité implicite : la dernière condition rencontrée gagne ; la promotion s'applique si elle est
  moins chère.
- Résultats exposés par 7 variables publiques (`prixht`, `prixrht`, `nego`, `promo`, `detail`,
  `remise`, `cdr`).

## Dépendances principales

- Utilisé par `Facture` (grille de choix, événement `selec`) et `Edart4` (une instance cachée par
  article imprimé).
- Utilise `ArtPromo`, `Calculdroit`, `Utils.Option`, 9 tables en dur.

## Risques

- Article inconnu ou appel sans client ni type → erreurs levées chez l'appelant.
- Libellés erronés des coefficients par type client ; comparaison de promotion incohérente en
  options B/T.
- Fenêtres jamais détruites dans `Edart4`.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 148 |
| Lignes de commentaire | 7 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 37 |
| Complexité max (fonction) | 32 (`_new`) |
| Variables globales | 0 |
| Variables Public | 7 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

12 tests (TARART-T01 à T12) : 10 gb.test (chaque source de tarif, priorités, promotion, droits,
erreurs, type seul) et 2 replays (choix d'un tarif dans Facture, édition Edart4).

## Rework

6 étapes (TARART-001 à 006) : documentation, extraction du calcul hors du formulaire, factorisation
des candidats, usage du calcul pur dans `Edart4`, `Cbase.Table`, réduction de portée de `remise`.
4 anomalies (TARART-A01 à A04).
