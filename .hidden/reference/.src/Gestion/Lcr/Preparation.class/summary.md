# Preparation — Synthèse

> Source : `.src/Gestion/Lcr/Preparation.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran « Préparation des bordereaux » : étape 3 de la chaîne LCR. Sur les LCR attribuées à une
banque, fixe le code entrée (type de remise) et génère un bordereau (`Fiches_Bordereaux`, numéro
reporté dans `Fiches_Lcr.bordereau`), ensuite traité par `Bordrx` (fichier bancaire).

## Points clés

- Copie d'`Attribution` (en-têtes, totaux, recherche, fiche, impression) : forte duplication.
- Génération sous `LOCK TABLES`, numéro « dernier `lind` + 1 », une requête par LCR, sans
  transaction.
- Marquage des lignes par clic droit dans une colonne cachée de la grille.
- Code mort : `N_click`, `A_click`, `Button5_Click`, bouton invisible `Button7`, `Nb`.
- Rejouable, mais `ColLcr` sans `ColLcr_Click`.

## Dépendances principales

- Ouvert par `Fmenu.Menuprep_Click`. Utilise `EntreeItem`, `CLcr`, `TriCpt`, `Utils`, `Cbase`.
- Tables : `Fiches_Lcr`, `Fiches_Bordereaux`, `Fiches_Banques`, `Fiches_Cli`, `Fiches_Comptes`.
- Aval : `Bordrx`.

## Risques

- **A01 (grave)** : `INSERT` du bordereau avec des libellés dans des colonnes entières → en mode
  strict ou SQLite, LCR rattachées à un bordereau inexistant.
- Filtre d'échéance inopérant, LCR écartées incluses (A02) ; suppression sans confirmation (A05).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 644 |
| Lignes de commentaire | 45 |
| Fonctions | 51 |
| Fonctions Public | 51 |
| Complexité cyclomatique totale | 135 |
| Complexité max (fonction) | 16 (`Imp_Lcr`) |
| Variables globales | 0 |
| Variables Public | 8 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

11 replays (PREPARATION-T01 à T11) : listes, filtres, recherche, modification, marquage, génération
de bordereaux (avec/sans échéances, numérotation), suppression, impression, SQLite. **Module
complexe : liste de scénarios à valider par l'utilisateur avant la phase 2.**

## Rework

6 étapes (PREPARATION-001 à 006) : documentation, code mort, réduction de portée, cache des
banques, séparation traitement/GUI, commonalisation avec `Attribution`/`Lcr`. 8 anomalies
(PREPARATION-A01 à A08).
