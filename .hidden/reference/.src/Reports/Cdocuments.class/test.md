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
| CDOCUMENTS-T01 | gbtest | `Entete` + `Entete2` + `Level1` : en-tête société complet | 19 arguments renseignés, puis variante avec `cap`/`rcs`/`iban`… nuls ; `glogo`, `glogo3` faux | texte `pdftotext` de référence (ordre des lignes, `site` avant `mail`) | `tests/entete_societe/` | à faire |
| CDOCUMENTS-T02 | gbtest | Logos d'`Entete` | `glogo` vrai (image 200 px), `glogo3` vrai (adresse masquée), les deux ; image de 5 px de large | nombre et taille des images ; image < 10 px : « Division by zero » (A02, figé) | `tests/entete_logos/` | à faire |
| CDOCUMENTS-T03 | gbtest | Arité d'`Entete` (A01) | appel à 18 arguments comme `RelvMo:427` | erreur « Not enough arguments » capturée (figée) | `tests/entete_arite/` | à faire |
| CDOCUMENTS-T04 | gbtest | En-têtes de facture selon le régime | `Level2F`/`Level3F`/`Level7F`/`Level10F` × `AutoEnt`, `Franchise`, `Impttc`, `ImpAuto`, `Exo`, `bRemise` (matrice 2⁶ réduite aux cas distincts) | texte de référence par cas (libellés TTC/HT/neutres, mentions légales) | `tests/facture_regimes/` | à faire |
| CDOCUMENTS-T05 | replay | Commande fournisseur `Edcom` **multi-pages** | jeu `editions_gestion` : commande de 40 lignes (saut à `PosY >= 280`) ; écran Edcom, sélection fournisseur/commande, bouton d'édition | texte `Commande.pdf` : 2 pages, en-têtes répétés, « Page n/2 », total (téléphone société = fournisseur, défaut Edcom figé) | `tests/edcom_multipage/` | à faire |
| CDOCUMENTS-T06 | replay | Relevé des prestations `RelvMo` | jeu `statistiques_ventes` : un client avec 10 lignes de MO, un autre avec 40 lignes | 1er client : PDF de référence ; 2e : erreur au saut de page, aucun PDF (RELVMO-A01 figée) | `tests/relvmo_saut_page/` | à faire |
| CDOCUMENTS-T07 | replay | Bon de réception `Edbr` **multi-pages** | jeu `editions_gestion` : BR de 60 lignes (saut à `PosY >= 250`) depuis `Edbl` | texte de référence : en-tête fournisseur répété, tableau de TVA (`Level7F`/`Level9F`/`Level10F`/`Level11F`), pied de page | `tests/edbr_multipage/` | à faire |
| CDOCUMENTS-T08 | replay | Liste des documents `EdDocs` (paysage) | 3 clients, détail des lignes activé, > 1 page (saut à 180/194) | texte de référence (`Level2D` détaillé, `Level2DLG`/`DLG2`, `Level4D`, `BasPageP`) | `tests/eddocs_paysage/` | à faire |
| CDOCUMENTS-T09 | replay | Liste de préparation `EdPrep` (partie `Cdocuments`) | commandes à préparer, détail activé | texte de référence de `Filename` (paysage) | `tests/edprep_liste/` | à faire |
| CDOCUMENTS-T10 | replay | Liste des familles `EdFam` **multi-pages** | 60 familles (saut à `PosY >= 278`) | 2 pages, en-tête et pied répétés | `tests/edfam_multipage/` | à faire |
| CDOCUMENTS-T11 | replay | Historique `RelMoprod` | client avec MO et articles, deux modes de tri | texte de référence (`Level2RL`/`Level4RL`/`Level5RL`) | `tests/relmoprod/` | à faire |
| CDOCUMENTS-T12 | gbtest | Gabarits élémentaires | `EnteteN`, `EnteteP`, `Lines`, `LinesLG`, `LinesP`, `BasPage`, `BasPageP`, `Level4`/`Level4D`, `Level4F`/`Level4aF` | texte et position des traits (`pdftotext -bbox`) de référence ; sert de garde aux factorisations 005/009 | `tests/gabarits_elementaires/` | à faire |

## Détail des tests

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
