# SupprArt — Synthèse

> Source : `.src/Gestion/SupprArt.class` · Synthèse des autres documents.

## Rôle

Écran de **suppression en masse d'articles** (menu `Fmenu.Menu234`) selon quatre modes :
sélection par familles/fournisseurs (avec exclusion des articles vendus après une date), articles
suspendus, liste manuelle (table de travail `Artsup`) ou fichier texte. La suppression est déléguée
à `Articles.art_Suppr`.

## Points clés

- Rapport des refus dans `~/tmp/Artsuppr.txt`, ouvert dans l'éditeur.
- `Articles.art_Suppr` est appelé sur l'auto-instance du formulaire `Articles`.
- Comparée à `Changefam.Modifart`, la suppression laisse des références orphelines dans une dizaine
  de tables (tarifs, produits composés, remplaçants, codes fournisseurs…).
- `button8_Click` (CC 18) et `Suppression` dupliquent la boucle de suppression et de rapport.
- Pas de `Utils.Observers(Me)` : écran probablement non journalisé pour le rejeu.

## Dépendances principales

- Utilise : `Articles.art_Suppr`, `TriCpt`, `TriArticles`, `ProgBar`, `Editeur`, `Utils`,
  `Cbase.Table` (`TabParam`, `TabFam`, `TabArt`, `TabHisLigFac[m]`).
- Utilisé par : `Fmenu` (1 appel).

## Risques

- A03 : contrôle de stock inopérant, des articles en stock sont supprimés.
- A05 : références orphelines après suppression.
- A02 : bornes de familles/fournisseurs exclues ; A01 : rapport décalé ; A04 : liste manuelle
  jamais purgée.
- Syntaxe MySQL (`DELETE IGNORE`, `SHOW TABLES`) dans `art_Suppr` : non portable SQLite.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 336 |
| Lignes de commentaire | 27 |
| Fonctions | 23 |
| Fonctions Public | 23 |
| Complexité cyclomatique totale | 90 |
| Complexité max (fonction) | 18 (`button8_Click`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

7 replays (SUPPRART-T01 à T07 : sélection, suspendus, liste manuelle, liste existante, fichier,
annulation, orphelins) sur un jeu dérivé riche en références d'articles ; rejeu à confirmer
(journalisation absente).

## Rework

7 étapes (SUPPRART-001 à 007) : documentation, code mort, boucle commune, requête de sélection,
séparation traitement/GUI, constante `Artsup`, portée. 6 anomalies (SUPPRART-A01 à A06).
