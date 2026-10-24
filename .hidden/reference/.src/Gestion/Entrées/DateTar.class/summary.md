# DateTar — Synthèse

> Source : `.src/Gestion/Entrées/DateTar.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

« Tarif par date » : écran de planification des tarifs temporaires (`Fiches_TarTemp`) saisis
pendant les achats (date d'application, suppression), et procédure `EnrTouTar` qui applique au
démarrage de Laurux (`Fmenu`) les tarifs dont la date est atteinte : prix de la fiche article,
tarifs client et type de client.

## Points clés

- Les articles des deux listes sont identifiés par leur texte affiché, recalculé 4 fois.
- `EnrTouTar` est appelé sur l'auto-instance du formulaire (formulaire caché créé au
  démarrage) ; il pourrait être statique.
- Cascade de prix identique à `GesTar`/`VarMajTar`, coefficient passé en remise négative.
- Pas de signal `deps.py` (aucun code mort, aucune portée réductible).

## Dépendances principales

- Utilise : `LPrix`, `LTaxe`, `LDate`, `ProgBar`, `GesTar` (énumération `temp_type`),
  `Utils.db`.
- Utilisé par : `commande1.tardt_Click` (écran), `Fmenu` (application au démarrage).

## Risques

- `Enr_Click`/`Sup_Click` : boucle d'une itération de trop (erreur, transaction ouverte, A01) et
  recherche d'article qui peut viser le mauvais article (A02).
- `EnrTouTar` : prix public calculé avec un coefficient client faute de tarif général (A04) ;
  un code TVA manquant annule tous les tarifs échus (A06).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 196 |
| Lignes de commentaire | 2 |
| Fonctions | 15 |
| Fonctions Public | 12 |
| Complexité cyclomatique totale | 55 |
| Complexité max (fonction) | 13 (`EnrTouTar`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

8 scénarios `replay` (DATETAR-T01 à T08) : listes et sélection, planification, suppression,
ordre de sélection, application au démarrage (cas nominal, sans tarif général, TVA
manquante), recherche par date. Un gb.test d'`EnrTouTar` devient possible après DATETAR-003 et
006.

## Rework

6 étapes (DATETAR-001 à 006) : documentation, helper de texte de ligne, `EnrTouTar` statique,
`Cbase.Table`, fabrique de prix commune (avec GESTAR-008), séparation traitement/GUI.
6 anomalies (DATETAR-A01 à A06).
