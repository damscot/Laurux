# TriArticles — Synthèse

> Source : `.src/Affichages/TriArticles.class` · Synthèse des autres documents.

## Rôle

Fenêtre modale de **sélection d'un article** (ou d'une main d'œuvre) : une liste `TriGen`
(filtrable, paginée) surmontée de filtres métier (fournisseur, famille, centrale, disponible,
matériel) et d'un choix de 3ᵉ colonne. Utilisée par 29 écrans (31 appels).

## Points clés

- Signature `_new(Barticle, Bstocke, TriArticle, Selection, Option, [Dispo], [Mat], [ob])` ;
  les appels à **9 arguments** sont corrects : le 6ᵉ (`Null`) est le `Parent` du `Form`.
- `Barticle` est ignoré ; `TriArticle` vaut `"art_code"` ou `"mo_code"` (sinon erreur).
- **Protocole** : remise à zéro de `Bsel`/`Bval` chez l'appelant à l'ouverture, puis relais de
  la sélection de `TriGen` (`ColTri_MajSel`) vers l'appelant. Valeur = code article ou MO.
- Chaque ouverture lit d'abord **toute** la table des articles pour obtenir la structure, puis
  deux requêtes paginées ; plusieurs actions émettent la même requête deux fois.
- Code mort : `ChkInput`, `TriArticles_KeyPress`, `_KeyPress`, `FourMan`, 6 variables.

## Dépendances principales

- Utilise : `TriGen`, `ObjProp`, `LCoul`, `Utils`, `Cbase.Table` (`TabArt`, `TabMo`, `TabFour`,
  `TabFam`, `TabCentrales`).
- Utilisé par : `Facture`, `Caisse`, `Attrib`, `Achat`, `Prodcomposes`, `Materiel`, `Stockmvt`,
  éditions (`EdArt1-3`, `Edart4`, `EdStk`, `EdRup`), étiquettes, `Changefam`/`Changefour`/
  `Calcstock`… `Bsel`/`Bval` doivent rester `Public` chez tous.

## Risques

- 29 appelants : toute évolution de la signature est coûteuse et touche `Facture` et `Caisse`.
- Filtre SQL concaténé (A01) ; nom du fournisseur absent à l'ouverture (A02) ; filtres perdus au
  changement de colonne (A03).
- Grille `TriGen` créée après `Utils.Observers` : rejeu des clics à vérifier.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 363 |
| Lignes de commentaire | 11 |
| Fonctions | 22 |
| Fonctions Public | 22 |
| Complexité cyclomatique totale | 78 |
| Complexité max (fonction) | 16 (`Filter_Calc`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

11 tests prévus (TRIARTICLES-T01 à T11) : 10 `replay` (sélection, annulation, filtres
fournisseur/famille/centrale, disponible, matériel, colonne `CB1`, main d'œuvre, deux cas
d'anomalie) et 1 `gbtest` sur le filtre extrait.

## Rework

8 étapes sans changement de comportement (TRIARTICLES-001 à 008) : documentation, code mort,
listes de choix communes, suppression des requêtes redondantes, lecture de structure sans
parcours de table, filtre en fonction pure, réduction de portée, relais commun avec `TriCpt`.
3 anomalies (TRIARTICLES-A01 à A03).
