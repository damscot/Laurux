# Chistoriques — Synthèse

> Source : `.src/Reports/Chistoriques.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Gabarit PDF (`Inherits PdfWriter`) de l'historique des ventes de main d'oeuvre (`Histovmo`) et des
écrans de statistiques de vente (`VisStatClimo`, `VisStatComArt`, `VisStatComm`, `VisStatFour`,
`VisStatTypCli`, `VisHitCartes`) : titre, bandeau de période `Level0F`, en-têtes, lignes, totaux,
trait et pied de page.

## Points clés

- 33 méthodes `Public`, complexité 1 ; rendu pur, sans base.
- Suffixes par édition (`C`, `AC`, `A`, `H`, `P`, `FO`) ; `Level0F` sert de bandeau de période à
  toutes les statistiques malgré son suffixe « familles ».
- 7 méthodes sans appelant (`Level1bis`, `Level2bis`, `Level1F`, `level2F`, `Level4F`, `Level5F`,
  `Level5AC`).
- `level2FO` est la seule ligne qui formate ses valeurs (`Format$(Val(x), "0.00")`).
- `Footer` et `Entete` sont des copies de ceux de `Carticles` (titre en taille 12).

## Dépendances principales

- Hérite de [PdfWriter](../PdfWriter.class/summary.md) ; lit `Start.R/G/B`.
- Utilisé par 7 écrans de `.src/Statistiques` (bouton « Imprimer »).

## Risques

- **CHISTORIQUES-A01** : `level2FO` lève « Type mismatch » sur une colonne vide ; `VisStatFour`
  la laisse vide quand le CA de la période est nul → impression interrompue (à confirmer).
- `level2P` reçoit des `Float` non formatés de `VisStatClimo` (VISSTATCLIMO-A01, renvoi A02).
- Dépend de la locale fr_FR (`Val` avec virgule).
- Défauts hérités de `PdfWriter` : encodage (€ → ¤, accents, PDFWRITER-A01) et largeur de
  texte (alignements à droite décalés, PDFWRITER-A02).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 291 |
| Lignes de commentaire | 37 |
| Fonctions | 33 |
| Fonctions Public | 33 |
| Complexité cyclomatique totale | 33 |
| Complexité max (fonction) | 1 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

7 tests : 5 `gbtest` qui appellent directement les méthodes et comparent le texte `pdftotext` et
le flux PDF non compressé, 2 `replay` par les écrans de statistiques (jeu `statistiques_ventes`),
dont la caractérisation de l'erreur de `level2FO`.

## Rework

5 étapes (CHISTORIQUES-001 à 005) : documentation, suppression de 7 méthodes mortes, passage à la
base commune `PdfLaurux`, helpers de colonnes, extraction du formatage de `level2FO`.
2 anomalies (A01 erreur de format, A02 renvoi vers VISSTATCLIMO-A01).
