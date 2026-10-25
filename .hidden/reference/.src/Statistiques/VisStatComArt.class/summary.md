# VisStatComArt — Synthèse

> Source : `.src/Statistiques/VisStatComArt.class` · Synthèse des autres documents.

## Rôle

Visualisation et impression du CA articles par commercial calculé par `StatComArt` : grille
`Liste` (article, libellé, brut HT, quantité, commercial), filtre par commercial (`Comm`), total
net, PDF `~/tmp/Statcli.pdf`.

## Points clés

- Lecture seule de `Total` ; une requête `Fiches_Commerciaux` par ligne.
- Tris par RadioButton sur `MouseDown` ; boucle vide et nombreuses variables mortes.
- Famille `VisStat*` : socle commun proposé (voir VisStatComm).

## Dépendances principales

- Ouvert par `StatComArt.Traitement` ; `Chistoriques`, `Visualiseur`, `Utils`,
  `Cbase.Table("TabCommerciaux")`.

## Risques

- **A01** : mode de tri décalé d'un clic.
- **A02** : filtre initial incertain (ajout dans `Comm` pendant `_New`).
- **A03** : lignes de commerciaux supprimés masquées.
- **A04** : PDF partagé avec `VisStatComm`.
- Quantités fausses en amont (STATCOMART-A01).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 186 |
| Lignes de commentaire | 21 |
| Fonctions | 10 |
| Fonctions Public | 10 |
| Complexité cyclomatique totale | 29 |
| Complexité max (fonction) | 9 (`Affichage`) |
| Variables globales | 0 |
| Variables Public | 6 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

6 tests : 5 `replay` (affichage, filtre, tris, commercial supprimé, impression), 1 `gbtest`.
Ne pas cliquer dans `Liste`.

## Rework

6 étapes (VISSTATCOMART-001 à 006) : documentation, code mort, portée, socle `VisStat*`,
jointure, séparation. 4 anomalies (A01 à A04).
