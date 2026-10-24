# Sdepots — Synthèse

> Source : `.src/Gestion/Depots/Sdepots.class` · Synthèse des autres documents.

## Rôle

Sorties manuelles de stock d'un dépôt (hors magasin `01`) : décrément de `Fiches_StkDepots` et
historique `S` dans `Fiches_Sdepots`.

## Points clés

- Copie partielle de MvtDepots (205 lignes communes).
- `ToggleButton2_Click` référence `Start.Soc`, inexistant : la liste des articles est inutilisable.
- Code mort : `Code_KeyPress`/`Code_GotFocus`/`Code_LostFocus` (handlers inactifs, contrôle
  groupé), `Dep_KeyPress` (groupe absent).
- Pas d'appel à `Utils.Observers` ; requêtes article par `db.Exec` (classe `DB`).

## Dépendances principales

- Utilise : `Utils.db`, classe `DB`, `Utils.Cdec`, `Utils.cpoint`, `Utils.Cdate_Dbase`, `Cbase`.
- Utilisé par : `Fmenu` (`show`) ; tables relues par `Articles`, `Facture`, `Caisse`, `Edsdepots`.
- `Coldep_Click`, `Coldepa_Click` rejoués par `ReplayObserver` : restent `Public`.

## Risques

- A01 : `Start.Soc` ; A02 : stock supprimé si sortie > stock, sortie silencieusement ignorée sans
  ligne de stock ; A03 : `db.Exec` ; A04 : écran non instrumenté.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 307 |
| Lignes de commentaire | 13 |
| Fonctions | 21 |
| Fonctions Public | 21 |
| Complexité cyclomatique totale | 83 |
| Complexité max (fonction) | 13 (`Rcpt_keypress`) |
| Variables globales | 0 |
| Variables Public | 1 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

5 replays (sortie partielle, sortie totale, refus du magasin, liste des articles, article absent).

## Rework

5 étapes (001 à 005) : documentation, code mort, séparation de la sortie, module `Depot` commun,
réduction de portée. 4 anomalies (A01 à A04).
