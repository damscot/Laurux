# TriFacture — Synthèse

> Source : `.src/Affichages/TriFacture.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran de **sélection multiple de documents de vente** (`Fiches_Bl`) bâti sur `TriGen`, ouvert par la
caisse (`Caisse.Button30_click`, choix « Régler des bons de caisses ») pour rattacher des BL et des
factures non payés au ticket en cours. Introduit en 2022 (`7101bb39`) en remplacement de `TriBl`.

## Points clés

- `TriGen` fournit la grille, le tri, le filtre et la pagination ; `TriFacture` ajoute le filtre par
  type (`CB1`), la sélection multiple (`Selected`), les totaux et le retour de la sélection.
- Protocole : `TriGen` écrit `Bsel`/`Bval` sur la fenêtre (`Object.SetProperty`), puis lève
  `MajSel` ; `TriFacture` bascule la ligne et bloque la fermeture (`Stop Event`).
- Résultat rendu dans la liste statique `LTrans.List` (ou `Bsel`/`Bval` de l'appelant).
- `Utils.Observers(Me)` appelé (avant la création de `TriGen`).

## Dépendances principales

- Appelant unique : `Caisse` (`Caisse.class:7160`).
- Utilise : `TriGen`, `ObjProp`, `LCoul.Fac_DB_bgcolor`, `LTrans`, `Utils.db`, `Cbase`.
- Même schéma de sélection multiple que `GedR` et `Pointage`.

## Risques

- **A01** : liste `numbl in (…)` concaténée sans guillemets (totaux et rattachement en caisse) :
  comparaison numérique en MySQL, textuelle en SQLite, erreur si numéro non numérique.
- `Bsel`/`Bval` doivent rester `Public` (écrits dynamiquement par `TriGen`).
- `Update_Req` lit toute la table `Fiches_Bl` pour obtenir la liste des champs.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 237 |
| Lignes de commentaire | 7 |
| Fonctions | 11 |
| Fonctions Public | 11 |
| Complexité cyclomatique totale | 47 |
| Complexité max (fonction) | 13 (`_new`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

6 tests : 4 `replay` en caisse (sélection, reprise d'une sélection, filtre par type et sélection
globale, Raz) mutualisés avec `CAISSE-T11`, 2 `gbtest` sur les futures fonctions pures
`FiltreDocuments` et `TotauxSelection`.

## Rework

8 étapes (TRIFACTURE-001 à 008) : documentation, code mort, simplification de `_new`, requête des
champs bornée, réduction de portée de 3 fonctions, commonalisation de la sélection multiple
(`TriSelection`, avec `GedR`/`Pointage`) et du retour de sélection, séparation filtre/totaux.
1 anomalie (A01).
