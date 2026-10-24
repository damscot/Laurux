# Depots — Synthèse

> Source : `.src/Gestion/Depots/Depots.class` · Synthèse des autres documents.

## Rôle

Écran de la table des dépôts (`Fiches_Depots`) ; le dépôt `01` est le magasin. Création avec
initialisation du stock du dépôt, suppression en cascade du stock et des mouvements.

## Points clés

- Copie du squelette « grille filtrable » de Cpostaux/Marques (`Utils.Base`, `Utils.rs1`).
- Initialisation du stock : un `INSERT` par article de `Fiches_Art`.
- Code mort : `Cpman`, `Btn_KeyPress` (groupe absent), `Libelle_GotFocus`, `Code_LostFocus` vide.
- `Cleanchamps` vide l'en-tête `CP` au lieu de `Cp2` (casse).

## Dépendances principales

- Utilise : `Utils.Base`, `Utils.rs1`, `Utils.db`, `Cbase`, `Doc`.
- Utilisé par : `Fmenu` (`Show`) ; tables lues par `Fcaisses`, `Famille`, `Articles`, `Facture`,
  `Caisse`, `Cstock`.
- `Coldepot_Click` rejoué par `ReplayObserver` : reste `Public`.

## Risques

- A01 : suppression de la ligne sélectionnée, sans transaction ni message d'erreur ; A02 : copie
  de tous les articles, filtre concaténé ; A03 : mauvais champ vidé.
- Codes de dépôt > 2 caractères tronqués dans `Fiches_Sdepots` (schéma).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 274 |
| Lignes de commentaire | 23 |
| Fonctions | 31 |
| Fonctions Public | 31 |
| Complexité cyclomatique totale | 74 |
| Complexité max (fonction) | 13 (`Cpost_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

5 replays (création avec initialisation, modification, suppression, filtre et tri, protection du
magasin).

## Rework

6 étapes (001 à 006) : documentation, code mort, `INSERT … SELECT`, socle et module `Depot`,
séparation traitement/GUI, réduction de portée. 3 anomalies (A01 à A03).
