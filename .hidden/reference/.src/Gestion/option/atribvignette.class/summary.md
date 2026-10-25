# atribvignette — Synthèse

> Source : `.src/Gestion/option/atribvignette.class` · Synthèse des autres documents.

## Rôle

Écran de l'option boissons (comptabilité matières, régime suspendu) qui permet d'attribuer ou
d'effacer le numéro de vignette (25 chiffres) des lignes de régie `Fiches_ligregie` non
clôturées, et qui liste les numéros manquants de la séquence. Ouvert par `menuopt.vign_click`.

## Points clés

- Arbre document → lignes (BL ou réception), zone de saisie, liste des manquants, bouton
  « Mise à blanc ».
- Écrit `Fiches_ligregie.vignette` par deux `UPDATE` (par BL ou par document).
- Tables de l'option boissons créées à l'exécution par `modfichier.fichierboisson` (hors
  `db_control.csv` et `Cbase`).
- Ne concerne **pas** le matériel ni les tables `*M`.
- Pas d'`Utils.Observers(Me)` : non rejouable en l'état.

## Dépendances principales

- Utilise : `Utils.db` ; tables `Fiches_ligregie`, `Fiches_regie`, `Fiches_Bl`,
  `Fiches_HistoFac`, `Fiches_Entrecpt`, `Fiches_Four`.
- Utilisé par : `menuopt`. Lignes produites par `ObjFacB`, `Achat`, `fourconsdroi`, `Mvtex`,
  clôturées par `Caleditcmat`.

## Risques

- Type de document inattendu → erreur « Null object » ou libellé faux (A01).
- `UPDATE` par BL sans filtre `cloture` : modification de lignes déjà déclarées (A02).
- Calcul des manquants en `Float` sur 25 chiffres (A04).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 137 |
| Lignes de commentaire | 1 |
| Fonctions | 9 |
| Fonctions Public | 5 |
| Complexité cyclomatique totale | 37 |
| Complexité max (fonction) | 12 (`affiche`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

7 replays et 1 gbtest (ATRIBVIGNETTE-T01 à T08) sur le jeu `cmat_base` commun à l'option
boissons. Rejouabilité conditionnée à l'instrumentation de l'écran (A03).

## Rework

6 étapes (ATRIBVIGNETTE-001 à 006) : documentation, découpage d'`affiche`, séparation des
calculs et des `UPDATE`, code mort, clés `Cbase`, fonctions communes avec Caleditcmat, ObjFacB et
Mvtex. 5 anomalies (A01 à A05).
