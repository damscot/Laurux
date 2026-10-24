# Articles — Tests

> Source : `.src/Gestion/Tables/Articles.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

> ⚠️ **Scénarios à valider par l'utilisateur.** `Articles` est un écran complexe (PLAN §0) : la
> liste ci-dessous (création, modification, prix et coefficients, promotion, GED, suppression…) est
> une **proposition** à présenter à l'utilisateur, qui la valide ou l'ajuste avant toute génération
> de test en phase 2.

Écran de saisie : l'essentiel des tests est en **replay** (journal capturé avec `./Laurux -l
--logfile …` dans le clone **Laurux non modifié**, puis rejoué avec `-r` sur les deux clones). Le
résultat comparé est le **dump normalisé** des tables `Fiches_Art`, `Fiches_CdBarre`, `Fiches_Cequ`,
`Fiches_Rpl1`, `Fiches_Rpl2`, `Fiches_Parametres` (`dnart`), `Docs_Ged`, `Docs_Tag`, `Fiches_Tag`
et, selon le test, des tables listées dans la colonne « Résultat attendu ». Les fichiers d'export
`Serveur` (`Art_Serveur.txt`, `CB_Serveur.txt`) sont comparés quand l'export est activé. Les `gbtest`
portent sur les fonctions pures extraites par ARTICLES-011.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| ARTICLES-T01 | replay | Création d'un article | `Laurux01.sql` + jeu dérivé (familles avec coefficient, remise, TVA et compte de TVA ; fournisseurs) ; `Créer` (code proposé depuis `dnart`), désignations, famille (paramètres appliqués), fournisseur, référence fournisseur, code-barre, prix de base, remise, coefficient, stock initial ; `Enregistrer` puis confirmation « Oui » ; variante « Non » | dump `Fiches_Art` (`art_cdate` masquée), `dnart`, `Fiches_CdBarre`, `Fiches_Cequ` ; aucune ligne si « Non » ; `art_refcentrale` vide et `art_pbfbt`/`art_datefbt` absents (A18 figée) | `tests/creation_article/` | à faire |
| ARTICLES-T02 | replay | Modification d'un article existant | sélection dans la liste (`ColTri`), modification des désignations, stock mini/maxi, minimum de commande, poids, casier, unités, remises quantitatives (`Tbrem` au clavier et `Button10` « remises de la famille »), écotaxes TEE/TEA/copie privée, case « stocké » décochée | dump `Fiches_Art` (`art_ddatefbt` masquée) ; stock remis à 0 sans contrôle (A15 figée) ; tags 24/27 (A14 figée) | `tests/modification_article/` | à faire |
| ARTICLES-T03 | replay | Chaîne de prix et coefficients | pour `Nbd` 2 puis 3 : prix de base → remise → remises en cascade `Rem1..3` (`Cmpt_dblclick` sur `Tr`) → PA net (question « modifier la remise / le prix de base », les deux réponses) → taux de conversion → frais → coefficient → taux de marque → PV HT → PV TTC ; arrondis `0,01`, `0,05`, `0,10`, `0,50`, `1,00` avec des valeurs aux bornes (x,x3 / x,x7 / x,25 / x,75 / x,76) ; `Pmp_DblClick` | valeurs des champs relevées dans le log (`Exec_SQL` de l'enregistrement) et dump `Fiches_Art` (`art_pbht`, `art_tr`, `art_pauaht`, `art_paht`, `art_prvt`, `art_coef`, `art_pvht`, `art_pvttc`, `art_cdarr`) | `tests/chaine_prix/` | à faire |
| ARTICLES-T04 | replay | Alertes de saisie | PV HT < PA, PV TTC < PA, PV conseillé < PV TTC (`/Soc01/Pvcons = 1`), saisie non numérique dans chaque champ `*LF`, taux de conversion modifié avec stock ≠ 0 | messages dans le log ; aucun enregistrement tant que `b = 1` | `tests/alertes_saisie/` | à faire |
| ARTICLES-T05 | replay | Tarifs et coefficients par type de client | `Button9` (`CoefTypeC` : saisie d'un coefficient), `Button6` / `Button13` (`TarTypeCli`), affichage `Coltype` (`Button16`) ; puis ouverture de `CoefTypeC` depuis le menu | dump `Fiches_CoeffTypec`, `Fiches_TarTypcli`, `Fiches_Tarcli` ; valeurs `Variables.Art*` vues par `CoefTypeC` ; mode article persistant (A16 figée) | `tests/tarifs_type_client/` | à faire |
| ARTICLES-T06 | replay | Promotion en cours | jeu dérivé : promotion `Fiches_Promo` active à la date figée (`faketime`) + article présent dans `Fiches_ArtPromo`, article absent, deux promotions chevauchantes | `Balloon` « présent dans la promotion » dans le log pour le seul article promu ; première promotion seulement | `tests/promo_en_cours/` | à faire |
| ARTICLES-T07 | replay | GED de l'article | `Button8` sur un article à code numérique puis alphanumérique ; annulation ; ouverture d'un document de la liste (`ColTriGenDoc_MajSel`) | `Docs_Ged`, `Docs_Tag` (tags famille et fournisseur, montants HT/TTC) ; erreur SQL et document sans tags pour le code alphanumérique (A10 figée) ; aucun document après annulation | `tests/ged_article/` | à faire |
| ARTICLES-T08 | replay | Suppression d'un article | `Supprimer` + « Oui » sur un article sans mouvement, avec code-barre, équivalence, remplacement (deux sens), composant, promotion, tarif client, documents GED ; « Non » ; refus : stock ≠ 0, BL en cours, commande fournisseur, réception non validée, matériel, ticket non archivé | lignes supprimées dans `Fiches_Art`, `Fiches_Mvtexp`, `Fiches_Inv*`, `Fiches_Ligrecpt`, `Fiches_CdBarre`, `Fiches_Rpl1/2` (`codep`), `Fiches_Cequ`, `Docs_Ged`, `Docs_Tag` ; orphelins conservés (A05 figée) ; message de refus pour chaque cas | `tests/suppression_article/` | à faire |
| ARTICLES-T09 | replay | Suppression en masse via `SupprArt` | `SupprArt` (`Fmenu`) sur une sélection contenant un article **en stock**, avec et sans l'écran Articles ouvert sur un autre article | article en stock supprimé (A04 figée) ; fichier `~/tmp/Artsuppr.txt` | `tests/suppression_supprart/` | à faire |
| ARTICLES-T10 | replay | Codes-barres, équivalences, remplacements | `Cbarre` : saisie EAN13 valide / clé fausse / longueur fausse, F9 (`Gencode`, clé vérifiée seulement), doublon ; `Cequ` saisi (écriture immédiate `MajEqu`) ; `Rpl1`/`Rpl2` ajout et Suppr confirmée ; Suppr dans `Cbarre` sur le code-barre principal et dans `Cequ` | `Fiches_CdBarre`, `Fiches_Cequ`, `Fiches_Rpl1/2`, `art_cbarre`/`art_cequ` ; **fiche supprimée** par Suppr dans `Cbarre` (A01 figée, base jetable) ; équivalences de l'article équivalent supprimées (A02 figée) ; doublon de code-barre enregistré (A03 figée) | `tests/codes_lies/` | à faire |
| ARTICLES-T11 | replay | Changement de famille | par la liste (`ToggleButton3` / F2, réponses « Oui » et « Non »), par saisie clavier (`FamLF`), sur un article présent dans un BL | `art_fam`, `art_coef`, `art_tr`, TVA ; ancien code remis après application (A08 figée) ; nouvelle famille enregistrée malgré le message BL (A03 figée) | `tests/changement_famille/` | à faire |
| ARTICLES-T12 | replay | Nombre de décimales des prix | article avec code-barre et équivalence ; `Nbd` 2 → 3 ; enregistrement | état de `Cbarre`/`Cequ` dans le log et dump `art_cbarre`/`art_cequ` (A09 figée) | `tests/decimales_prix/` | à faire |
| ARTICLES-T13 | replay | Références fournisseur et centrale | référence fournisseur déjà utilisée, égale au code d'un autre article, modifiée sur un article en commande fournisseur ; référence centrale déjà attribuée | messages/`Balloon` ; valeurs enregistrées (A03 figée) | `tests/references_uniques/` | à faire |
| ARTICLES-T14 | replay | Liste, filtres et fenêtres annexes | radios 1 à 7, `CB1` (7 colonnes), F2 (agrandir la liste), `Qte_DblClick` (stock par dépôt), `ToggleButton5`/`ToggleButton6` (commandes) + `Colcom_Activate`, listes fournisseurs/familles/marques avec et sans F2 (texte contenant une apostrophe), `Composants_Click` ; `/Soc01/ipr` vide | contenu des listes dans le log ; aucune écriture en base ; erreur SQL sur l'apostrophe (A11 figée) ; comportement de `_New` sans `ipr` (A17 figée) | `tests/listes_filtres/` | à faire |
| ARTICLES-T15 | replay | Base SQLite | T01 puis T08 sur `Laurux01.sqlite` | même dump que T01 (hors identifiants) ; erreurs `SHOW TABLES`/`DELETE IGNORE` et succès apparent (A06 figée) | `tests/sqlite_creation_suppression/` | à faire |
| ARTICLES-T16 | gbtest | Fonctions pures extraites | `PrixAchatNet`, `PrixTTC`, `ArrondiPvTTC` (5 arrondis × formats `0.00`/`0.000` × valeurs aux bornes), `TauxMarque`, `CoefDepuisTaux`, `CoefTTC`, `Marges` (après ARTICLES-011) | valeurs de référence capturées en appelant le code actuel dans le clone non modifié (harnais temporaire) | `tests/fonctions_pures/` | à faire |
| ARTICLES-T17 | replay | Option métier (`Artopt`) | `/Soc01/bois = 1` (option `B`) : onglet option, modification du PA (événement `recalculpx`), enregistrement | tables de l'option (`$opt.enregiste`) et `Fiches_Art` | `tests/option_article/` | à faire |
| ARTICLES-T18 | replay | Matériel, photo, centrale | `/Soc01/Materiel = 1` + case « Matériel » + `ToggleButton2` ; photo trop grande puis chemin invalide ; centrale | fenêtre `Materiel` ouverte ; messages photo (A13 figée) ; `art_centrale` | `tests/materiel_photo/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées en rejouant chaque scénario dans le clone **Laurux non modifié**
  (MariaDB jetable restaurée depuis `Laurux01.sql` ou un jeu dérivé décrit dans `tests/<nom>/*.sql`) ;
  les anomalies ARTICLES-A01 à A18 sont figées telles quelles. A01 et A02 suppriment des données :
  ces scénarios ne tournent que sur la base jetable.
- **Jeu dérivé** : `Laurux01.sql` + familles complètes (coefficient, remise, TVA et compte 4457x
  existant, remises quantitatives), deux fournisseurs, articles stockés / non stockés / suspendus /
  composés, un BL, une commande fournisseur, une réception non validée, un ticket, une promotion,
  des documents GED (fichiers dans un répertoire de test).
- **Normalisation du dump** : `art_cdate`, `art_ddatefbt`, horodatages GED masqués ; `lind` comparé
  seulement si la base de départ est identique.
- **Date système** : `faketime` pour la promotion du jour (T06) et les dates écrites. `Calc_barre`
  (F9) utilise `Rnd` : T10 vérifie seulement la longueur et la clé EAN13, pas la valeur.
- **Dialogues modaux** (`Message.Question`/`Warning`, `TriHistos`, `CoefTypeC`, `TarTypeCli`,
  `LGed`, `Famille`, `FFournisseur`, `Materiel`) : rejoués par `ReplayObserver` ; les
  `<Grille>_Click` `Composants_Click`, `fourList_Click`, `FamList_Click`, `ColMarque_Click` sont
  appelés dynamiquement et doivent garder leur nom et leur portée `Public`.
- **Export serveur** : T01, T08, T10 sont joués avec `Variables.Sprix`, `Sexport`, `SMajArt` activés
  (fichiers d'échange dans un répertoire de test, comparés ligne à ligne) et désactivés.
- **Non testable automatiquement** : `Dialog.OpenFile` de la photo (chemin injecté dans `Photo`
  puis `aff_Photo` déclenché) ; dessin dans `Photos` ; aide `Doc.Open` (F1) vérifiée par l'appel ;
  impression des étiquettes (`Etiqart`, `Etigond`, `Etiqcasier`) limitée à l'ouverture des fenêtres.
