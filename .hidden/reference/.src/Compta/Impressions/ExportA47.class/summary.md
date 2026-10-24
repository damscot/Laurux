# ExportA47 — Synthèse

> Source : `.src/Compta/Impressions/ExportA47.class` · Synthèse des autres documents.

## Rôle

Écran « Export des écritures au format A47 (FEC) » (menu Compta, modal). Produit le fichier des
écritures comptables exigé par l'article A47 A-1 du LPF : `<SIREN>FEC<fin>-<début>` dans le
répertoire choisi, 18 champs séparés par `|`, une ligne par écriture validée non collective.
Format **réglementaire** : le rework doit le reproduire octet par octet.

## Points clés

- Périodes calculées avec `LDate` (`EDeb`/`EFin` des `dteclec*`) ; seule classe du lot qui
  utilise `LDate` plutôt que des manipulations de chaînes.
- Numérotation provisoire (`numero`) ou définitive (`numerodef`) selon `dtepc` ; libellés
  manquants signalés par des valeurs `Err…` et un message final.
- Lignes collectives et lignes nulles exclues ; débit et crédit compensés ; champs bourrés
  d'espaces ; montants au séparateur décimal de la locale ; `Utils.Accent` sur les libellés.
- Tout le traitement est dans `Button2_Click` (CC 34) avec une requête `Fiches_Comptes` par
  ligne.
- Code mort : `finmois`, `export()` (envoi par mail jamais branché), `donnees1/2`, table
  `centralisation` recréée sans usage.

## Dépendances principales

- Ouvert par `Fmenu.Menu298_Click`.
- `LDate`, `Utils.Accent`, `Utils.db`, `Cbase.Table` (`TabSoc`, `TabJour`), `ProgBar`,
  `Editeur`, `Start.LocalSettings` (`/Soc<XX>/Chemin-export`, `Adr-export`, `Expmail`).
- Tables : `Fiches_Mvt*` (en dur), `Fiches_Journaux`, `Fiches_Comptes`, `Fiches_Parametres`,
  `Fiches_Societes`.
- Les anomalies UTILS-A12 (`Accent`) et LDATE-A02/A03 changent directement le fichier produit.

## Risques

- Compte absent : erreur Gambas et fichier partiel (A01).
- « Exercice en cours » vraisemblablement décalé d'un an pour un exercice civil (A02).
- Annulation silencieuse : fichier tronqué annoncé comme réussi (A03).
- Conformité réglementaire à vérifier : noms d'en-tête, `|` final, nom de fichier (A04) ;
  bourrage, `\'`, comptes auxiliaires vides, locale (A05).
- Dernier jour tronqué si heure non nulle (A07) ; bourrage à longueur négative (A08).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 426 |
| Lignes de commentaire | 47 |
| Fonctions | 33 |
| Fonctions Public | 33 |
| Complexité cyclomatique totale | 95 |
| Complexité max (fonction) | 34 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

14 tests `replay` (EXPORTA47-T01 à T14), chacun comparant le fichier produit à une référence
octet par octet (normalisation limitée au répertoire de sortie, locale `fr_FR.UTF-8` fixée) :
définitif, provisoire, erreurs réglementaires, règles de lignes, dates, caractères spéciaux,
compte absent, annulation, périodes, contrôles de dates, heure non nulle, préférences, SQLite,
performance. Jeu de données dérivé jeu dérivé commun (Balance) nécessaire.

## Rework

9 étapes sans changement du fichier produit (EXPORTA47-001 à 009) : documentation du format, code
mort, périodes via `LDate`, `Cbase.Table`, extraction de `GenereFEC` (testable en `gbtest`),
décomposition de la boucle, suppression de la requête par ligne, réduction de portée, SIREN
partagé. 9 anomalies (EXPORTA47-A01 à A09), dont deux de conformité réglementaire à valider avec
l'expert-comptable.
