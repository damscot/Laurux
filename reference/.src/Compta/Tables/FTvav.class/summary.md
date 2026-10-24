# FTvav — Synthèse

> Source : `.src/Compta/Tables/FTvav.class` · Synthèse des autres documents.

## Rôle

Écran de la table des codes TVA sur ventes (`Fiches_Tvaav`) ; à un changement de taux, recalcule
sur demande les familles, les lignes des documents clients non facturés, les articles et les
main-d'œuvre.

## Points clés

- Jumeau de `FTvac` pour la partie table (module commun proposé).
- `Recalcul` (CC 25) : traitement de masse sans transaction, une requête par ligne, état partagé
  avec `arrondi` par des membres.
- `arrondi` : arrondi par découpage de chaîne, voisin mais distinct de `Utils.arrondi` et
  `LPrix.Arrondi_Calc`.
- `Tvaman`, `Cleanchamps` et le membre `b` sont morts.

## Dépendances principales

- Utilise : `Utils` (`db`, `cpoint`, `PointBase`, `Find_nbdec`…), `Cbase` (8 tables), `Doc`.
- Utilisé par : `Fmenu.Menu112_Click`, `Parametre` (création d'un code manquant).

## Risques

- A01 : recalcul des données même quand l'enregistrement du taux est refusé.
- A02 : enregistrement au clavier sans recalcul ; A03 : compte non contrôlé.
- A04 : lignes `M` sans arrondi, erreur possible sur bon d'entretien ; A05 : SQL concaténé.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 413 |
| Lignes de commentaire | 37 |
| Fonctions | 22 |
| Fonctions Public | 22 |
| Complexité cyclomatique totale | 106 |
| Complexité max (fonction) | 25 (`Recalcul`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

6 replays (création, modification avec et sans recalcul, compte déjà attribué, suppression et
clavier, performance) et 1 gbtest sur l'arrondi extrait.

## Rework

8 étapes (001 à 008) : documentation, code mort, découpage de `Recalcul`, UPDATE unique des
familles (dump identique), arrondi pur, `Cbase.Table`, module commun avec FTvac, réduction de
portée. 5 anomalies (A01 à A05).
