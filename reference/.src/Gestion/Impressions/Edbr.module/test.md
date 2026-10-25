# Edbr — Tests

> Source : `.src/Gestion/Impressions/Edbr.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Module appelé depuis deux écrans : tests `replay` via [`Edbl`](../Edbl.class/test.md) et
[`ValidBR`](../../Stock/ValidBR.class/test.md), avec comparaison du texte extrait de
`~/tmp/BonReception.pdf` (`pdftotext -layout`), des lignes `Exec_SQL` du log et du dump normalisé
(`Docs_Ged`, `Docs_Tag`, `Fiches_Tag`). Valeurs attendues produites dans le clone **Laurux non
modifié**, horloge figée (noms de fichiers GED horodatés `LDate(Now).FT`).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EDBR-T01 | replay | BR simple via `Edbl` | BR de 2 lignes, fournisseur `fo_copie = 0` | texte du PDF ; copie `~/Impressions/BonReception-401001.pdf` ; dump inchangé | `tests/br_simple/` | à faire |
| EDBR-T02 | replay | Archivage GED | même BR, `fo_copie = 1`, `tag_def` renseigné | `Docs_Ged`, `Docs_Tag`, `Fiches_Tag` (dump) ; fichier GED créé | `tests/archivage_ged/` | à faire |
| EDBR-T03 | replay | Validation multiple via `ValidBR` | 2 BR du même fournisseur validés ensemble ; TVA 20 % et 5,5 % | PDF : 2 BR + pied TVA (`Totalisation`) ; GED au numéro du dernier BR (A01 figée) | `tests/validation_multiple/` | à faire |
| EDBR-T04 | replay | Saut de page | BR de 50 lignes | 2 pages, date de l'en-tête de page 2 = `dater` (A02 figée) | `tests/saut_page/` | à faire |
| EDBR-T05 | replay | Auto-entrepreneur | `/Soc01/AutoEnt` = 1, via `ValidBR` | pas de ligne de TVA, totaux présents | `tests/auto_entrepreneur/` | à faire |
| EDBR-T06 | replay | Prix sans décimale | `/Soc01/Prxdec` = 1, via `ValidBR` | totaux et code TVA en entiers | `tests/prix_sans_decimale/` | à faire |
| EDBR-T07 | replay | BR sans ligne | numéro de BR d'un autre fournisseur (via `ValidBR` multi-fournisseur ou donnée forgée) | message « Aucun mouvement », page vide dans le PDF (A04 figée) | `tests/br_vide/` | à faire |

## Détail des tests

- **Jeu `editions_gestion`** (partagé par les éditions de `Gestion/Impressions` : `Edbr`, `Edbl`,
  `Edcom`, `EdFam`, `EdFour`, `EdClient`, `EdDocs`, `EdPrep`, `Edregul`, `Edregulprdc`,
  `Edpaiement`, `Traites`) : dérivé de `Laurux01.sql` (qui ne contient ni réception, ni commande,
  ni BL, ni mouvement de stock, ni traite) et du jeu `facturation_base`
  ([ObjFac](../../Facturation/ObjFac.class/test.md)). Contenu : 3 fournisseurs (dont un avec
  `fo_copie = 1` et `tag_def`), réceptions `Fiches_Entrecpt`/`Fiches_Ligrecpt` (1, 2 et 50
  lignes), commandes `Fiches_Entcom`/`Fiches_Ligcom`, régularisations `Fiches_Mvtexp`/
  `Fiches_Mvtexpdc`, documents `Fiches_Bl` de types D/C/B/F (adresses de livraison `Fiches_AdrlivC`
  et `Fiches_AdrlivBL`, lignes de commentaire `YY`/`XX`), `Fiches_Traites`, statuts
  `Fiches_Statut`, familles (> 52 pour les sauts de page). Script à produire en phase 2 dans
  `tests/_donnees/editions_gestion.sql`.
- **Comparaison PDF** : `pdftotext -layout`, puis suppression des dates d'édition et des numéros
  de page « n/{nb} » si `AliasNbPages` n'est pas résolu par l'extracteur.
- **Neutralisation** : `Visualiseur.Prog` (script de capture), `Copie.Dupli` laissé actif (le
  fichier copié fait partie des sorties).
- **Non testable automatiquement** : couleurs de fond (`Coulfond`) ; son (jamais joué ici).
