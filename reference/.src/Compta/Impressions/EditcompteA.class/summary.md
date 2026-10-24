# EditcompteA — Synthèse

> Source : `.src/Compta/Impressions/EditcompteA.class` · Synthèse des autres documents.

## Rôle

Écran d'édition des **extraits de comptes analytiques** (Comptabilité > Impressions > Analytiques >
Comptes). Le suffixe `A` signifie analytique. Copie de 2012 d'`Editcompte`, avec l'impression codée
dans l'écran (`Button1_Click`, `Ccompta`, `~/tmp/Extrait.pdf`) : comptes ventilés dans
`Fiches_Analytiques`, écritures de `Fiches_MvtA`, centralisation dans `Ctrlnc`.

## Points clés

- 29 fonctions identiques à `Editcompte` ; `Button1_Click` reprend 126 lignes d'`EditcompteM.Imprime`.
- `Button2_Click` (export, 104 LOC) est **mort** : le `.form` n'a pas de bouton Exporter.
- Le choix d'exercice ne change pas la table lue (toujours `Fiches_MvtA`).
- Prétraitement maison des dates saisies, qui dégrade `Cdate_calc`.
- Variable `Coulfc` et lecture de couleur inutiles.

## Dépendances principales

- Appelé par `Fmenu.Menu293_Click` (`ShowModal`).
- Utilise `Ccompta`, `TriCpt`, `Utils`, `Cbase` (`TabAna`, `TabMvtA`, `TabComptes`, `TabSoc`),
  `Visualiseur`.
- Tables : `Fiches_Analytiques`, `Fiches_MvtA`, `Fiches_Comptes`, `Fiches_Parametres` (lecture),
  `Ctrlnc` (écriture).

## Risques

- **EDITCOMPTEA-A01** (grave) : `pdf.level4C` appelé avec 4 arguments au lieu de 5 → erreur
  d'exécution non interceptée au premier compte mouvementé ; l'édition analytique n'aboutirait
  jamais (à confirmer par T03).
- **EDITCOMPTEA-A02** : exercices N-1…N-5 lus dans `Fiches_MvtA` (même défaut dans `JournauxA`).
- **EDITCOMPTEA-A03** : saisie `jjmmaa` → année remplacée par l'année courante.
- Aucun test existant.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 695 |
| Lignes de commentaire | 106 |
| Fonctions | 35 |
| Fonctions Public | 35 |
| Complexité cyclomatique totale | 114 |
| Complexité max (fonction) | 19 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

8 tests `replay` (EDITCOMPTEA-T01 à T08) : bornes, prétraitement des dates, impression avec
écritures (caractérise A01), comptes ventilés sans écriture, aucun compte, exercice N-1, bilan et
`TriCpt`, fermeture. Comparaison du texte PDF normalisé et du dump (`Ctrlnc`).

## Rework

7 étapes (EDITCOMPTEA-001 à 007) : documentation, suppression du code mort (export, helpers CSV,
couleur), helper de saut de page, centralisation et écran communs avec `Editcompte`, séparation des
traitements, réduction de portée. La fusion avec `EditcompteM.Imprime` attend la décision sur
A01/A02. 4 anomalies (EDITCOMPTEA-A01 à A04).
