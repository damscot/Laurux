# TriFac2 — Synthèse

> Source : `.src/Affichages/TriFac2.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Liste modale de sélection d'un **document existant** pour en créer un nouveau, ouverte par
`Facture.Creation(False)` (`Button25`). Deux sources : BL en cours (`Fiches_Bl`, par défaut) ou
factures archivées (`Fiches_HistoFac`, bouton radio `Archives`). Retour par `Variables.Bsel` et
`Variables.numeroFac`.

## Points clés

- Copie élargie de `TriFac` (374 lignes communes) : mêmes en-têtes `TextBox` triables, même
  pagination, même dessin de cellule ; 8 requêtes `Deb*` au lieu de 4.
- La variable `Dat` est sans effet (branches identiques) ; `Client` et `Prxdec` morts.
- `Deplacement` est cohérent (contrairement à `TriFac`), mais `Dbclk` et `DA_KeyPress` se trompent
  de requête en mode archives.
- Pas de `Utils.Observers(Me)` : non journalisé.

## Dépendances principales

- Appelant unique : `Facture.Creation` (`Facture.class:12105`) ; `EntFac` lit le numéro.
- Utilise `Utils` (`Base2`, `rs2`, `Fcolr`, `cpoint`), `Variables`, `Cbase`, `Start.LocalSettings`.

## Risques

- **A01** : erreur SQL en effaçant le filtre de date en mode archives.
- **A02** : second double-clic en archives → mauvais filtre.
- **A03** : changement de source sans remise à zéro du filtre et de la page.
- **A04** : `Variables.Bsel` résiduel → rechargement de l'ancien document.
- **A05** : filtre concaténé dans le SQL.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 629 |
| Lignes de commentaire | 16 |
| Fonctions | 44 |
| Fonctions Public | 44 |
| Complexité cyclomatique totale | 187 |
| Complexité max (fonction) | 20 (`ColFac_Data`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

7 tests : 6 `replay` depuis `Facture` (reprise BL, reprise archive, tri/pagination, changement de
source, erreur de date, fermeture sans choix) et 1 `gbtest` sur `RequeteDocuments`. Replays
conditionnés à l'instrumentation de l'écran (phase 2). Jeu `factures_base` partagé avec `TriFac`.

## Rework

9 étapes (TRIFAC2-001 à 009) : documentation, code mort, factorisation des 8 requêtes et des 21
handlers d'en-tête, couleurs, réduction de portée de 12 fonctions, `PaginationListe`, socle commun
avec `TriFac`, séparation du SQL. 5 anomalies (A01 à A05).
