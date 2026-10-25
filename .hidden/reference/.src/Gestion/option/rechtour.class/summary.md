# rechtour — Synthèse

> Source : `.src/Gestion/option/rechtour.class` · Synthèse des autres documents.

## Rôle

Fenêtre modale de recherche d'une tournée (`Fiches_tourne`) : grille code/libellé ; la ligne
activée est renvoyée à l'appelant par l'événement `trouve(cle)`, et la touche Suppr renvoie une
espace (convention « effacer la tournée »).

## Points clés

- 5 fonctions, toutes handlers ou constructeur ; une seule requête (`_new`).
- Utilisée par `Facture` (`to1`), `Facturefm` (`tourne`) et `FClient` (`Butto1`, `Butto2`).
- Requête sans `ORDER BY`, contrairement à `Ttourne`.
- Pas d'`Utils.Observers(Me)` : fenêtre non journalisée.

## Dépendances principales

- Utilise : `Utils.db`, table `Fiches_tourne` (nom en dur, pas de clé `Cbase`).
- Utilisée par : `Facture`, `Facturefm`, `FClient` (handlers `*_trouve`).

## Risques

- Changer la valeur renvoyée par Suppr (espace) casserait les quatre handlers appelants.
- Rejeu impossible en l'état (pas d'observateur, `GridView1` sans `_Click`).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 40 |
| Lignes de commentaire | 1 |
| Fonctions | 5 |
| Fonctions Public | 5 |
| Complexité cyclomatique totale | 10 |
| Complexité max (fonction) | 3 (`GridView1_Data`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

4 replays (RECHTOUR-T01 à T04) via la fiche client : choix, effacement, ordre d'affichage
(caractérisation de A01), table vide. Leur faisabilité dépend de la journalisation de la fenêtre
(à valider en début de phase 2).

## Rework

4 étapes (RECHTOUR-001 à 004) : documentation, variable morte, clé `Cbase` partagée avec
`Ttourne`, composant commun des fenêtres de recherche du lot option. 2 anomalies : liste non
triée (A01) et fenêtre non journalisée (A02).
