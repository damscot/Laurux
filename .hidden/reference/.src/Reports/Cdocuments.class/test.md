# Cdocuments — Tests

> Source : `.src/Reports/Cdocuments.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Classe de dessin PDF sans accès à la base. Deux niveaux de test :

- `gbtest` : instancier `Cdocuments` directement, appeler les méthodes avec des chaînes figées,
  `Output` dans un fichier, puis comparer **le texte extrait** (`pdftotext -layout`) et, pour les
  logos, la liste des images (`pdfimages -list`). Le binaire PDF n'est pas comparé (date de
  création, compression).
- `replay` : générer les documents par les écrans appelants (atteignables) sur un jeu de données
  dérivé, puis comparer le texte extrait du PDF produit (`~/tmp/*.pdf`) et le dump de la base
  (inchangée : ces éditions ne modifient pas la base, sauf `Edbr` via la GED).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CDOCUMENTS-T01 | gbtest | `Entete` + `Entete2` + `Level1` : en-tête société complet | 19 arguments renseignés, puis variante avec `cap`/`rcs`/`iban`… nuls ; `glogo`, `glogo3` faux | texte `pdftotext` de référence (ordre des lignes, `site` avant `mail`) | `tests/entete_societe/` | implémenté (gb.test CdocumentsTest.T01EnteteSociete) |
| CDOCUMENTS-T02 | gbtest | Logos d'`Entete` | `glogo` vrai (image 200 px), `glogo3` vrai (adresse masquée), les deux ; image de 5 px de large | nombre et taille des images ; image < 10 px : « Division by zero » (A02, figé) | `tests/entete_logos/` | implémenté (gb.test CdocumentsTest.T02EnteteLogos ; logo JPEG : PdfWriter refuse un PNG à canal alpha) |
| CDOCUMENTS-T03 | gbtest | Arité d'`Entete` (A01) | appel à 18 arguments comme `RelvMo:427` | erreur « Not enough arguments » capturée (figée) | `tests/entete_arite/` | implémenté (gb.test CdocumentsTest.T03EnteteArite, Object.Call) |
| CDOCUMENTS-T04 | gbtest | En-têtes de facture selon le régime | `Level2F`/`Level3F`/`Level7F`/`Level10F` × `AutoEnt`, `Franchise`, `Impttc`, `ImpAuto`, `Exo`, `bRemise` (matrice 2⁶ réduite aux cas distincts) | texte de référence par cas (libellés TTC/HT/neutres, mentions légales) | `tests/facture_regimes/` | implémenté (gb.test CdocumentsTest.T04FactureRegimes, 5 régimes) |
| CDOCUMENTS-T05 | replay | Commande fournisseur `Edcom` **multi-pages** | jeu `editions_gestion` : commande de 40 lignes (saut à `PosY >= 280`) ; écran Edcom, sélection fournisseur/commande, bouton d'édition | texte `Commande.pdf` : 2 pages, en-têtes répétés, « Page n/2 », total (téléphone société = fournisseur, défaut Edcom figé) | `tests/edcom_multipage/` | implémenté (gb.test CdocumentsTest.T05EdcomMultipage : appels de Cdocuments dans l'ordre d'Edcom, 40 lignes, 2 pages ; texte pdftotext) |
| CDOCUMENTS-T06 | replay | Relevé des prestations `RelvMo` | jeu `statistiques_ventes` : un client avec 10 lignes de MO, un autre avec 40 lignes | 1er client : PDF de référence ; 2e : erreur au saut de page, aucun PDF (RELVMO-A01 figée) | `tests/relvmo_saut_page/` | xfail : erreur sur les champs NULL de Fiches_Societes dans RelvMo.Button2, aucun PDF (scénario Reports/cdocuments_relvmo, jeu relvmo) ; cas 40 lignes à faire |
| CDOCUMENTS-T07 | replay | Bon de réception `Edbr` **multi-pages** | jeu `editions_gestion` : BR de 60 lignes (saut à `PosY >= 250`) depuis `Edbl` | texte de référence : en-tête fournisseur répété, tableau de TVA (`Level7F`/`Level9F`/`Level10F`/`Level11F`), pied de page | `tests/edbr_multipage/` | implémenté (gb.test CdocumentsTest.T07EdbrMultipage : appels d'Edbr (ValidBR), BR de 60 lignes sur 2 pages, Level3br, tableau de TVA Level7F/Level9F/Level10F/Level11F ; texte pdftotext) |
| CDOCUMENTS-T08 | replay | Liste des documents `EdDocs` (paysage) | 3 clients, détail des lignes activé, > 1 page (saut à 180/194) | texte de référence (`Level2D` détaillé, `Level2DLG`/`DLG2`, `Level4D`, `BasPageP`) | `tests/eddocs_paysage/` | implémenté (scénario Reports/cdocuments_eddocs_paysage, jeu eddocs_paysage : 24 commandes, 3 pages) |
| CDOCUMENTS-T09 | replay | Liste de préparation `EdPrep` (partie `Cdocuments`) | commandes à préparer, détail activé | texte de référence de `Filename` (paysage) | `tests/edprep_liste/` | implémenté (gb.test CdocumentsTest.T09EdprepListe : appels d'EdPrep, liste paysage détaillée, 12 commandes, 3 pages ; texte pdftotext) |
| CDOCUMENTS-T10 | replay | Liste des familles `EdFam` **multi-pages** | 60 familles (saut à `PosY >= 278`) | 2 pages, en-tête et pied répétés | `tests/edfam_multipage/` | implémenté (gb.test CdocumentsTest.T10EdfamMultipage : appels d'EdFam, 60 familles, 2 pages ; texte pdftotext) |
| CDOCUMENTS-T11 | replay | Historique `RelMoprod` | client avec MO et articles, deux modes de tri | texte de référence (`Level2RL`/`Level4RL`/`Level5RL`) | `tests/relmoprod/` | implémenté (scénario Reports/cdocuments_relmoprod, jeu Gestion/listecom_shared/historique_client en lecture, deux tris) |
| CDOCUMENTS-T12 | gbtest | Gabarits élémentaires | `EnteteN`, `EnteteP`, `Lines`, `LinesLG`, `LinesP`, `BasPage`, `BasPageP`, `Level4`/`Level4D`, `Level4F`/`Level4aF` | texte et position des traits (`pdftotext -bbox`) de référence ; sert de garde aux factorisations 005/009 | `tests/gabarits_elementaires/` | implémenté (gb.test CdocumentsTest.T12Gabarits ; texte seulement, pas de -bbox) |

## Détail des tests

- **Implémentation (phase 2, vague 6)** : module `.src/Tests/Reports/CdocumentsTest.test` (T01 à T04, T12 ; logos
  générés en JPEG par le test, PdfWriter refusant un PNG à canal alpha ; images vérifiées par `pdfimages -list`) ;
  scénarios `.hidden/Tests/Reports/assets/cdocuments_eddocs_paysage/` (T08, jeu `eddocs_paysage`),
  `cdocuments_relmoprod/` (T11, jeu `Gestion/listecom_shared/historique_client` en lecture),
  `cdocuments_relvmo/` (T06, jeu `relvmo`, xfail) ; T05, T09, T10 couverts par les scénarios Gestion existants
  `edcom_saut_page`, `edprep_avec_detail`, `edfam_saut_page` (texte du PDF comparé).

- **Valeurs attendues** : normalisation commune des PDF par `check_output.py` (flux
  décompressés, `CreationDate` et xref masqués, voir [PdfWriter/test.md](../PdfWriter.class/test.md)) en plus du texte
  `pdftotext` ; produites dans le clone **Laurux non modifié** (mêmes appels, mêmes
  données), jamais déduites du code. Date figée (`faketime`) et utilisateur de test fixe, car
  `BasPage` imprime `Now` et `User.Name`. Comparaison : `pdftotext -layout` normalisé (espaces de
  fin de ligne supprimés) ; `pdftotext -bbox` pour T12 (coordonnées arrondies au dixième de mm).
- **Prérequis gbtest** : `Start.R/G/B` et `Start.LocalSettings` doivent être initialisés
  (fichier `Laurux.conf` de test chargé avant les tests, `-c`). Si `gb.test` ne peut pas
  initialiser `Start`, T01-T04 et T12 deviennent des replays d'un écran appelant (`Edcom` pour
  T01-T03).
- **Données** : `Laurux01.sql` ne contient ni commande fournisseur ni BR ; jeux dérivés
  `editions_gestion` (voir [Edbr](../../Gestion/Impressions/Edbr.module/test.md)) et
  `statistiques_ventes` (voir [StatComm](../../Statistiques/StatComm.class/test.md)), à unifier en
  phase 2. Les volumes ci-dessus garantissent au moins un **saut de page** par appelant.
- **Non testable / non testé** :
  - la famille facture (`Level1F`… `Level13F`, `Colonnes`) n'a pas d'appelant atteignable :
    seule T04 la caractérise (pour les méthodes partagées avec `Edbr`), le reste est couvert par
    la suppression prévue ;
  - les 23 fonctions mortes (CDOCUMENTS-002) : aucun test, la compilation (`gbc3 -agt`) suffit ;
  - les branches `Variables.EnvoiMail = "Mail"` et `TypeL = "B"` : inatteignables.
- **Couverture visée** : 100 % des fonctions atteignables ; les fonctions de facture couvertes
  par T04 jusqu'à la décision FACTURERGBL-A01.
- **Implémentation (phase 2, vague 7)** : T05, T09, T10 portés par la classe dans `CdocumentsTest` : les appels de `Cdocuments` des écrans Edcom, EdPrep (liste) et EdFam sont reproduits avec des valeurs figées et le même pas de saut de page (texte `pdftotext -layout`).
