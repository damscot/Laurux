# Facture — Tests

> Source : `.src/Gestion/Facturation/Facture.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

> ⚠️ **Module complexe (PLAN §0 et §4.5) : la liste de scénarios ci-dessous est une proposition.
> Elle doit être présentée à l'utilisateur et validée (ou ajustée) avant toute génération de test
> en phase 2.**

Écran de saisie interactif, fortement couplé au SQL : l'essentiel des tests est en **replay**
(scénario capturé avec `./Laurux -l --logfile …` dans le clone **Laurux non modifié**, puis rejoué sur
les deux clones). Le résultat comparé est le **dump normalisé** de `Fiches_Bl`/`Fiches_BlM`,
`Fiches_Ligbl`/`Fiches_LigblM`, `Fiches_Parametres` (`dnbon`, `dnc`), `Fiches_Art` (`art_qte`),
`Fiches_StkDepots`, `Fiches_ArtPromo`, `Fiches_Cli`, `Fiches_Comptes`, `Mails_Cli`,
`Fiches_Materiels`, `Fiches_EntMat`, `Fiches_HistoFac`/`HistoLigfac`, `Fiches_Mvt`, `Docs_Ged`,
`Fiches_Taches`, `Fiches_ligcons` selon le scénario. Les `gbtest` portent uniquement sur les fonctions
pures extraites par le rework (FACTURE-008, 011, 016, 017, 018) et sur les helpers partagés.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FACTURE-T01 | replay | Création d'un BL complet | Menu Gestion → Facturation ; « Nouveau » (`Btn` Tag 3) ; date ; client existant (code puis Entrée, `Cli_man`) ; saisie des lignes (`Lignes_Bon`) : article stocké, MO au temps, commentaire ; fin de saisie (`Button15_Click`) ; quitter | `Fiches_Parametres.dnbon` + 1 ; `Fiches_Bl` (entête, totaux, marges, remises) ; `Fiches_Ligbl` (types A/M/C, montants texte) ; stock `art_qte` diminué une seule fois ; `/Col/LcolF` écrit | `tests/creation_bl/` | à faire |
| FACTURE-T02 | replay | Nouveau client depuis l'écran | `button1_Click` (numéro `dnc` 411xxx, cas 411999 → 4111000 sur base dérivée) ; nom, adresse, code postal (`Cpman` → `Tricp` à plusieurs choix), courriel ; enregistrement | `Fiches_Cli`, compte `Fiches_Comptes` rattaché au collectif, `Mails_Cli`, `Fiches_Cpostaux` (`Enrgcp`), `dnc` ; création refusée si le code existe | `tests/nouveau_client/` | à faire |
| FACTURE-T03 | replay | Transformations de type | devis avec articles stockés → BL → facture → commande → BL ; clic « Facture abonnement » sur client non abonné (question) ; même clic sur document imprimé (FACTURE-A01 : erreur figée) | `Fiches_Bl.type`, `dte_ligbl` (`Bmajdte`), stock après chaque transition (réintégration / sortie), `acquitte`/`mtreg` via `Fiches_Mvt` | `tests/transformations_type/` | à faire |
| FACTURE-T04 | replay | Édition d'une facture | facture de T01 transformée ; F3 (`Bl_Edit` → `OptFac`) : impression PDF (imprimante fictive), validation | numéro de facture, `Fiches_HistoFac`/`HistoLigfac`, écritures `Fiches_Mvt`, document `Docs_Ged`, `imp = 1` ; retour par `Maj_typeBL` ; modification ensuite refusée | `tests/edition_facture/` | à faire |
| FACTURE-T05 | replay | Avoir sur facture | (a) clic droit sur une facture imprimée de la liste (`Colbl_Activate`) choix 1 (avoir) puis 2 (archivage seul) ; (b) `ToggleButton5_Click` + `Button26_Click` (`TriFac`), reprise totale puis partielle (`Button20_Click`) | archivage (`ObjFacB.transblfac`), nouveau BL aux quantités et montants négatifs (`Importlig`), stock réintégré, lignes « Annule le Bon n… » ; `Maj_libelle` par ligne (FACTURE-A21 figée) | `tests/avoir_facture/` | à faire |
| FACTURE-T06 | replay | Duplications | Ctrl+D totale puis partielle (lignes marquées par Espace) sur un BL et sur une commande (reliquat, effacement des lignes reprises « Oui ») ; `Button25_Click` (duplication en devis depuis `TriFac2`) | nouveau numéro, entête et lignes ; commentaires de reliquat dans l'original ; stock (`Maj_QuantiteD`) pour BL/facture | `tests/duplications/` | à faire |
| FACTURE-T07 | replay | Remises et tarifs | client avec remise (`cli_rart`), type client (`Fiches_RemTypec`/`TarTypcli`), tarif client (`Tarcli`) ; article en promotion (`Fiches_Promo`) ; remises quantitatives sur les 6 tranches (A07) ; mention `N` (Net) ; remise > 100 % ; rétrocession ; quantité « ,5 » et « 1,5 » sur article sans décimale (A16) ; article à stock nul sur F et sur B (A28) | `rem_ligbl`, `netht_ligbl`, `nettc_ligbl`, mention « Net », ligne « *** Article … en promotion *** », compteurs promo, messages | `tests/remises_tarifs/` | à faire |
| FACTURE-T08 | replay | Main d'œuvre | MO au temps et au forfait (`mo_valeurht`) ; modification du taux, du brut, de la remise, du net (question 1 puis 2), du TTC ; arrondis `0,05`/`0,10`/`0,50`/`1,00` ; MO avec caractéristiques ; prix nul | lignes M et R ; `mrgmo_ligbl` (A08 figée) ; marge du document | `tests/main_oeuvre/` | à faire |
| FACTURE-T09 | replay | HT/TTC, arrondis article, exonération | `/Fht` ; bascules `sTTC`, `sFacht`, `Tvar` (TVA réduite `Codetva`) ; articles aux arrondis `0,05`…`1,00` ; TTC vidé (A12) ; `/Prxdec` ; client exonéré, auto-entrepreneur, franchise | `pu_ligbl`, `netht_ligbl`, `nettc_ligbl`, `tx_ligbl` ; totaux d'entête | `tests/ht_ttc_arrondis/` | à faire |
| FACTURE-T10 | replay | Taxes annexes | article avec DEE, DEA (client France puis étranger) et copie privée ; modification de quantité de la ligne ; remise 100 % | lignes E/D/P créées puis mises à jour (même bloc) ; aucune taxe à 100 % | `tests/taxes_annexes/` | à faire |
| FACTURE-T11 | replay | Produits composés | article composé (`Fiches_PrdComp`, un composant MO et deux articles avec écotaxe) ; tentative de déplacement `+`/`-` ; modification d'un composant (branche `UPDATE` d'`Enrg_Pdc`, A05 figée) | lignes O ; taxes des composants ; refus de déplacement | `tests/produits_composes/` | à faire |
| FACTURE-T12 | replay | Grille des lignes | sur un document de 8 lignes : Entrée (rappel M, A, C), modification ; Suppr sur A, C, R ; `-` et `+` sur blocs de tailles différentes ; modification d'un commentaire non premier (A11) | `Fiches_Ligbl` après chaque action (renumérotation `Ren_ligbl`/`Maj_Base`) | `tests/grille_lignes/` | à faire |
| FACTURE-T13 | replay | Suppression d'un document | `Btn` Tag 4 sur : BL avec stock et document GED ; facture imprimée (refus) ; BL réglé par ticket (`numtick`, refus) ; BL avec matériel (A06 sous MySQL : refus) | entête et lignes supprimés, `Docs_Ged`, stock réintégré, matériels remis non vendus | `tests/suppression_document/` | à faire |
| FACTURE-T14 | replay | Stock par dépôt | `/Depots` ; dépôt `02` choisi ; BL avec une ligne positive et une ligne négative ; fermeture puis réouverture de la saisie | `Fiches_StkDepots.qte` (signes de A09 figés) ; `Fiches_Art` inchangé | `tests/stock_depots/` | à faire |
| FACTURE-T15 | replay | Facturation entretien | Menu193 (`Facture(True)`) : matériel du client (`ToggleButton11_Click`), nouveau bon, MO + pièce, fiche atelier (T), transformation en facture | `Fiches_BlM` (A04 figée au 1er enregistrement), `Fiches_LigblM`, `Fiches_EntMat` ; tables `Fiches_Ligbl` touchées à tort (A30) | `tests/facturation_entretien/` | à faire |
| FACTURE-T16 | replay | Numéros de série | `/Materiel` ; article matériel sur BL : liste `NumsList`, numéro inexistant, déjà vendu, valide ; rappel de la ligne puis abandon (A17) ; suppression de la ligne | lignes T « Numéro de série … », `Fiches_Materiels` (`mat_vendu`, `mat_bl`, `mat_cli`, prix, garantie) | `tests/numeros_serie/` | à faire |
| FACTURE-T17 | replay | Raccourcis clavier | entête : F1-F6, Ctrl+A ; articles : Ctrl+R/H/A/P, F2, F4, F5, F7, F8 (tags 4 et 6), F9, F10 (désignation : `UPDATE Fiches_Art`), F11, F12 ; MO : F2, F4, F5, F12, lettres de `Button10` ; commentaires : F2, F4 ; grille : `*`, Espace | fenêtres ouvertes (journal), champs focalisés, `art_design` modifié par F10 | `tests/raccourcis/` | à faire |
| FACTURE-T18 | replay | Liste et recherche | tri par type, numéro, date (`jj.mm.aaaa`, `aaaa.mm.jj`), code, nom, n° facture ; recherches commentaire/code/libellé/référence (`Blcom`) ; agrandissement F2 | contenu de `Colbl` capturé par le journal ; colonne prénom (A20) ; couleurs devis périmés (A24) | `tests/liste_recherche/` | à faire |
| FACTURE-T19 | replay | Règlement et acompte | acompte saisi (`Button18_Click`) ; règlement à la saisie (`Rgmt`, modes chèque puis LCR) ; facture réglée en trésorerie puis retour sur le document | `Fiches_Bl.acpt`, `mreg`, `acquitte`, `mtreg` | `tests/reglement_acompte/` | à faire |
| FACTURE-T20 | replay | Tâches | `/Taches` : création d'une tâche, doublon refusé, touche quelconque sur la grille (A10), suppression | `Fiches_Taches` | `tests/taches/` | à faire |
| FACTURE-T21 | replay | Options P, T, B | `Utils.Option()` = P (tournée, TIPP : `Rechtour`, `Rechtipp`, `defpxpp`), puis B (boisson : palettes/colis, consignes, CM clôturée via `VerifDate`, A02) ; frais de gestion | `tour_ligbl`, `tipp_ligbl`, `Fiches_ligcons`, totaux `calculfindoc` | `tests/options_ptb/` | à faire |
| FACTURE-T22 | replay | Import portable | `~/Portable/inventaire.txt` avec codes valides, code inconnu, ligne vide, quantité nulle ; puis fichier absent | lignes A créées ; `~/tmp/ImpT.txt` (A26 figée) | `tests/import_portable/` | à faire |
| FACTURE-T23 | replay | Largeurs et préférences d'affichage | `/Col/LcolF` absent puis `col1:90;col10:40;` ; option boisson (décalage) ; `/Refl` dans `Laurux.conf` et via `-c` (A27) ; `/Col/LcolEqu` | largeurs appliquées et valeurs écrites | `tests/largeurs_preferences/` | à faire |
| FACTURE-T24 | replay | Base SQLite | T01, T12, T13 et T20 sur `Laurux01.sqlite` | mêmes dumps que MySQL hors identifiants ; erreurs attendues : `ALTER TABLE … ORDER BY` (A10), BL à matériel supprimable (A06) | `tests/sqlite/` | à faire |
| FACTURE-T25 | gbtest | Fonctions pures extraites | `ArrondiPas` (pas × montants positifs/négatifs, chiffres 0-9 en dernière décimale), `DeltaStock`, `RemiseTranche`, `InverseSigne`, `CumulLigne`, `FormatDocument`, `ProchainCodeClient` (après FACTURE-008, 011, 016-018 et IMPCLIENT-008) | valeurs de référence capturées en appelant le code actuel dans le clone non modifié (harnais temporaire), anomalies figées | `tests/fonctions_pures/` | à faire |
| FACTURE-T26 | replay | Contrôles client | client à encours dépassé (Oui/Non), plafond `"0,5"` (A15), client inactif, client divers (`Cdivers`), vendeur (F5 → `ConVendeurs`, A23), CA (F6, A14), extrait de compte et total des BL (`ToggleButton7_MouseDown`, A18) | messages ; entête vidé ; fenêtres ouvertes ; journal (doublons éventuels d'événements) | `tests/controles_client/` | à faire |
| FACTURE-T27 | replay | Performance | document de 200 lignes : ajout d'une ligne, suppression, fermeture ; reprise d'une facture de 100 lignes | durée (`gbx3 -p`) ; nombre de requêtes `Exec_SQL` (`Recup_ligbl` et `Maj_libelle` par ligne) | `tests/perf_document_long/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées en rejouant chaque scénario dans le clone **Laurux non modifié**,
  sur une base MariaDB jetable restaurée depuis `Laurux01.sql` complétée par un **jeu dérivé**
  commun `tests/jeu_facturation.sql` : articles stockés et non stockés, décimales 0/2/3, arrondis
  `0,05`…`1,00`, écotaxes DEE/DEA, copie privée, remises quantitatives (6 tranches), promotion
  active, produits composés, articles de remplacement et équivalents, matériels avec numéros de
  série, dépôts, clients (remises, type, tarif, encours, divers, inactif, abonné, étranger),
  MO au temps et au forfait, commentaires, échéances. Les anomalies FACTURE-A01 à A33 sont figées
  telles quelles (caractérisation).
- **Normalisation du dump** : `block_ligbl` contient `Round(Rnd(1000, 9999))` (`Randomize` dans
  `_New`) → valeur masquée ou remplacée par un rang ; `dte_ligbl` (`Now` à chaque enregistrement de
  ligne), `datebl` des duplications, dates de vente/garantie des matériels et horodatages GED
  masqués ou figés par `faketime` ; `lind` conservé seulement si la base de départ est identique ;
  table temporaire `Blcom` exclue.
- **Préférences** : chaque test fournit son `Laurux.conf` (`-c`) avec les clés `/Soc01/…` utiles
  (`Factdef`, `Depots`, `Materiel`, `Taches`, `Casier`, `Cqte`, `Ctrlstk`, `Marge`, `Prxdec`…) ;
  `Utils.Option()` (P/T/B) est fixé par le jeu de données de l'option.
- **Dialogues modaux** (`Message.Question`, `TriCpt`, `TriArticles`, `TriEqu`, `Tricp`, `TriFac`,
  `OptFac`, `FCalc`, `TarArt`, `Rechtour`, `Rechtipp`) : rejoués par `ReplayObserver` ; les handlers
  `Colcp_Click`, `Colmo_Click`, `hcol_click`, `NumsList_Click`, `Colfam_Click`, `Colcom_Click`,
  `Colal_Click` sont appelés dynamiquement et doivent garder leur nom et leur portée `Public`.
  Les contrôles créés par code (`$Matlist`, `hTxtb`, `$textpal`, `$textcol`) sont à vérifier dans le
  rejeu (noms dynamiques).
- **Verrous** : `DocActif` et `LOCK TABLES` supposent un seul poste ; aucun test de concurrence.
- **Non testable automatiquement** : impression physique et aperçu (`OptFac`, `AFacture`), aide
  (`Doc.Open`), visualiseur de pièce jointe, fenêtres externes ouvertes par F4/F11/F12 (vérifiées
  seulement par leur ouverture), rendu des couleurs de `Colbl_Data`. Les tests `gbtest` de
  T25 n'existent qu'après les extractions du rework ; avant cela, la couverture repose sur les
  replays.
- **Couverture visée** : toutes les fonctions hors code mort (FACTURE-003) ; les branches propres à
  l'entretien, aux options P/T/B et au matériel exigent les jeux dérivés correspondants.
