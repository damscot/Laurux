# Cdocuments3 — Tests

> Source : `.src/Reports/Cdocuments3.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CDOCUMENTS3-T01 | gbtest | Bon de préparation élémentaire | `Entete`, `Entete2`, `cadre`, `adresse` (8 lignes), `adresse2`, `Level1`, 3 × `Level2`/`carre` (i = 0, 1, 2), `Level2b`, `Basep`, `BasPage` avec valeurs figées | texte `pdftotext -layout` et positions (`-bbox`) de référence ; fond alterné | `tests/bon_preparation/` | à faire |
| CDOCUMENTS3-T02 | replay | Bons de préparation `EdPrep` **multi-pages** | jeu `editions_gestion` : 2 commandes client (type `C`), dont une de 45 articles (saut à `PosY >= 266`), adresse de livraison `Fiches_AdrlivBL` ; écran EdPrep, détail désactivé | `Filename2` : 3 pages (2 + 1), en-têtes complets répétés, « Page n/3 » | `tests/edprep_bons_multipage/` | à faire |
| CDOCUMENTS3-T03 | replay | Saut de page dans les commentaires (A01) | commande avec un article suivi d'un commentaire de 60 lignes, détail activé | caractérisation : en-tête réimprimé sur la même page (surimpression, nombre de pages inchangé) | `tests/edprep_commentaires/` | à faire |

## Détail des tests

- **Valeurs attendues** : normalisation PDF commune `check_output.py` (voir
  [PdfWriter/test.md](../PdfWriter.class/test.md)) ; produites dans le clone **Laurux non modifié**, date (`faketime`) et
  utilisateur figés (`BasPage`). Comparaison du texte extrait (`pdftotext -layout`) ; T03 compare
  aussi le nombre de pages (`pdfinfo`) et les coordonnées (`-bbox`) pour mettre en évidence la
  surimpression.
- **Impression directe** : `EdPrep` envoie `Filename2` à l'imprimante ; en replay, utiliser une
  imprimante PDF (CUPS-PDF) ou le réglage qui produit un fichier, puis comparer
  `~/tmp/<Filename2>` (à confirmer avec `Impression.Facture`).
- **Données** : jeu `editions_gestion` (voir [Edbr/test.md](../../Gestion/Impressions/Edbr.module/test.md)),
  complété par des commandes client (`Fiches_Bl` type `C`, `Fiches_Ligbl`, `Fiches_AdrlivC`,
  `Fiches_AdrlivBL`).
- **Non testé** : `Lines` et `Level3` (code mort, suppression vérifiée par `gbc3 -agt`).
