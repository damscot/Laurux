# Etiqart — Tests

> Source : `.src/Gestion/Etiquettes/Etiqart.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI produisant un PDF : tests `replay`. On compare (1) le dump normalisé de la base (table de
travail `Etiquettes` comprise, avant `fin_impression` qui la vide) et (2) le **contenu du PDF**
`~/tmp/EtiqArt.pdf`, normalisé (date de création et identifiants retirés, ou extraction texte +
positions par `pdftotext -bbox`). Valeurs attendues capturées dans le clone **Laurux non
modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| ETIQART-T01 | replay | Plage, tri par code, A4 | menu Articles ; modèle `Z- Test (A4 Portrait)` (3 × 8) ; bornes par défaut ; 2 étiquettes ; Imprimer | PDF : pages, positions, textes, EAN13 | `tests/etiqart_plage_code/` | à faire |
| ETIQART-T02 | replay | Les 5 tris | T01 avec `Radiobutton2..5` | ordre des articles dans le PDF | `tests/etiqart_tris/` | à faire |
| ETIQART-T03 | replay | Position de départ et saut de page | `Posetiq` = 5, 30 articles | positions sautées, nouvelles pages (V1) | `tests/etiqart_position/` | à faire |
| ETIQART-T04 | replay | Nombre = stock | `EtiqStk` ; articles stockés (qté 0, 0,5, 3) et non stocké | nombre d'étiquettes figé (A05) | `tests/etiqart_stock/` | à faire |
| ETIQART-T05 | replay | Mode liste : ajout, cumul, remplacement, suppression | `Liste` ; saisie de 3 codes dont `*<code-barre>` ; ressaisie (Cumuler, Remplacer) ; clic grille (Supprimer) ; Imprimer | table `Etiquettes` (dump avant impression), grille (log), PDF | `tests/etiqart_liste/` | à faire |
| ETIQART-T06 | replay | Article sans `art_etiq` / inexistant | `Liste` ; codes refusés | messages, table inchangée | `tests/etiqart_refus/` | à faire |
| ETIQART-T07 | replay | Dymo | `/Soc01/Impetiq = "3- Dymo"` ; 3 articles | une étiquette par page `dymog` | `tests/etiqart_dymo/` | à faire |
| ETIQART-T08 | replay | Zebra (caractérisation) | `Impetiq = "2- Zebra"` ; Imprimer | erreur `Null object` figée (A01) | `tests/etiqart_zebra/` | à faire |
| ETIQART-T09 | replay | Import portable | `~/Portable/inventaire.txt` fourni (codes valides, inconnus, vides) ; bouton Import | table `Etiquettes`, PDF, fichier ouvert par l'éditeur (A02), `~/tmp/ImpT.txt` | `tests/etiqart_portable/` | à faire |
| ETIQART-T10 | replay | Ouverture depuis la fiche article | `Articles` ; Étiquette › 1- Article | bornes = code courant, PDF d'un article | `tests/etiqart_depuis_article/` | à faire |
| ETIQART-T11 | replay | Article supprimé en mode liste | liste contenant un code absent de `Fiches_Art` (orphelin type ARTICLES-A05) | erreur figée (A03) | `tests/etiqart_orphelin/` | à faire |
| ETIQART-T12 | gbtest | Calcul de position (après ETIQART-010) | `PlancheEtiquettes` variante V1, formats 1 × 1, 3 × 8, `Posetiq` 1..25 | suites (X, Y, page) identiques à celles relevées en T03 | `tests/planche_v1/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` + jeu dérivé `etiquettes_base` (≈ 30 articles sur 3 familles et 2
  fournisseurs, avec/sans code-barres de 13 caractères, `art_etiq` 0/1, stockés ou non, une ligne
  `Fiches_CdBarre`), format `Z- Test` de ETIQUETTES-T01, paramètres `/Soc01/Impetiq`.
- **Comparaison PDF** : `PdfWriter` écrit une date de création ; le script `check_output.py`
  retire les métadonnées variables avant le diff, ou compare l'extraction `pdftotext -bbox`.
- **Rejeu** : `Utils.Observers(Me)` est appelé **deux fois** dans `Form_Open` (l. 93 et 97) : les
  événements sont probablement journalisés en double ; le scénario doit en tenir compte (ou
  ETIQART-011 appliqué avant la capture de référence, ce qui ne change pas le dump).
  `Gridbart_Click` et `Col*_Click` sont rejoués par `Object.Call`.
- **Dialogues** : `Message.Question`/`Warning` (Cumuler/Remplacer, confirmation d'import) doivent
  être pilotés par le rejeu.
- **Non testable** : rendu sur imprimante physique (A4, Dymo), visionneuse (`Visualiseur.Prog`),
  éditeur, aide (`xdg-open`), sortie Zebra (inatteignable, ZEBRA-A01 ; le flux est couvert par
  ZEBRA-T01).
