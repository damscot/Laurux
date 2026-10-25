# Caisse — Tests

> Source : `.src/Caisse/Caisse.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

> ⚠️ **Module complexe (PLAN §0 et §4) : la liste de scénarios ci-dessous est une proposition.
> Elle doit être présentée à l'utilisateur et validée (ou ajustée) avant toute génération de test
> en phase 2.** Elle couvre la vente, les retours et avoirs, les remises, les règlements multiples,
> les acomptes, le règlement de BL, la fidélité, les tickets en attente, les tickets X et Z,
> l'impression, le tiroir et l'afficheur, et les modes PDV / POS (imprimante PDF ou série, écran
> tactile).
>
> ⚠️ **Rejouabilité limitée** : les touches `ImageButton` (groupe `Clav2`, et boutons `Clav3` créés
> par code dans `Cbutton`, l. 8673) ne sont gérées ni par `Utils.Recursive_Observers` ni par
> `ReplayObserver.Replay_Click` : les scénarios POS par touches de famille (T17) ne sont pas
> rejouables en l'état ; à décider avec l'utilisateur (saisie clavier équivalente ou évolution du
> rejeu).

Écran de point de vente interactif, fortement couplé au SQL et aux périphériques : l'essentiel des
tests est en **replay** (scénario capturé avec `./Laurux -p -l --logfile …` dans le clone **Laurux
non modifié**, puis rejoué sur les deux clones). Le résultat comparé est le **dump normalisé** de
`Fiches_EntTicketz`, `Fiches_LigTicketz`, `Fiches_Caisses` (`cutk`, `tkz`, `fndtotp`, `fndtotg`),
`Fiches_Parametres` (`cutk`, `dntk`), `Fiches_Art` (`art_qte`), `Fiches_StkDepots`,
`Fiches_ArtPromo`, `Fiches_Avoirs`, `Fiches_Acomptes`, `Fiches_Bl`/`Fiches_Ligbl` (`numtick`, BL
généré), `Fiches_Carte`, et, après bande Z, `Fiches_HisEntTickets`/`Fiches_HisLigTickets`,
`Fiches_Mvt`. Les `gbtest` portent uniquement sur les fonctions pures extraites par le rework
(CAISSE-006, 013, 015) : `Caisse` est un `Form` qui ne s'instancie pas sans interface.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CAISSE-T01 | replay | Vente simple en espèces | ouverture de la caisse 01 (`Cmenu`) ; article par code puis par code-barre `*…` (quantité auto `/caisse/qt1`) ; quantité 3 (F5) ; F7 ; espèces supérieures au total (rendu) ; impression `DéfautA4` | `Fiches_EntTicketz` (espèces, rendu `Q` inclus), `Fiches_LigTicketz` (A, T, L, BH, BA, BC, N, Q), `art_qte` diminué, `fndtotp`/`fndtotg`, `dntk`, `cutk` remis à `NULL`, chaînage SHA1 | `tests/vente_especes/` | à faire |
| CAISSE-T02 | replay | Lignes particulières | article avec écotaxe et copie privée ; article à deux taux de TVA différents dans le ticket (A18 figée) ; quantité négative (retour) ; prix modifié F3 sur article à arrondi `0,05`/`0,50` ; article à prix nul ; article en colisage (`art_colvte`) | lignes `O`, `T`, montants négatifs, `arrondi`, `mtva` d'entête | `tests/lignes_particulieres/` | à faire |
| CAISSE-T03 | replay | Remises | remise % de ligne (F6) ; remise quantitative (F8 : grille vide, A02 figée) ; remise sur total (Ctrl+F9) sur un ticket avec lignes `T` (A10 figée) ; ajout d'article après remise totale (question « Non », A24) ; suppression d'une ligne (recalcul) | lignes `S`, `MT`, montants `Fiches_LigTicketz` | `tests/remises/` | à faire |
| CAISSE-T04 | replay | Règlements multiples | un ticket réglé par espèces + carte (deux cartes : `U`, `U1`) + chèque (impression du chèque refusée, puis acceptée sur imprimante série : A01 figée) + bon d'achat + chèque cadeau + autre (deux saisies, A11) + ticket restaurant ; suppression des règlements (Suppr sur `ColumnView1`) puis nouvelle saisie ; rendu sur carte (question) | colonnes de règlement de l'entête, lignes de règlement, `Tottva` | `tests/reglements_multiples/` | à faire |
| CAISSE-T05 | replay | Avoirs | F11 « Avoir de » client (TriCpt) avec articles : enregistrement de l'avoir (`Fiches_Avoirs`, stock réintégré) ; ticket suivant réglé par cet avoir (F8) partiellement puis totalement ; avoir à total négatif passant par un mode de paiement (A20) | `Fiches_Avoirs` (montant diminué puis ligne supprimée), lignes `EZ`, `Z`, verrous `DocActif` libérés | `tests/avoirs/` | à faire |
| CAISSE-T06 | replay | Acomptes | Ctrl+F3 « Acompte reçu » (client, libellé ≥ 15 caractères) ; ticket suivant : F10, acompte choisi à la souris, « Montant restant uniquement » (partiel), puis acompte choisi par Entrée (A12), acompte supérieur au total (« Continuer ») | `Fiches_Acomptes` (`INSERT` daté, A21 ; diminution ; suppression), lignes `EA`, `RA`, `fndtotp` hors acompte reçu | `tests/acomptes/` | à faire |
| CAISSE-T07 | replay | Crédit client | F4 « Crédit accordé à » (client) ; montant partiel puis solde en espèces | lignes `W`, `scredit`/`mcredit` | `tests/credit/` | à faire |
| CAISSE-T08 | replay | Hors vente | entrée et sortie hors vente (libellé trop court refusé ; validation par Tab, A27) ; puis suppression d'une ligne article du même ticket (A30) ; avec mot de passe admin (A13 : `Frame2`) | lignes `EH`, `SH`, total du ticket | `tests/hors_vente/` | à faire |
| CAISSE-T09 | replay | Tickets en attente | ticket mis en attente (F8) ; nouveau ticket validé ; rappel (F9) du ticket en attente sur la même caisse ; validation ; suppression (F10) d'un autre ticket | statut 1 puis suppression et réécriture, ticket supprimé (`suppr = 1`), `cutk` | `tests/tickets_attente/` | à faire |
| CAISSE-T10 | replay | Bon de caisse client en compte | Ctrl+F12 choix 1 : client sous plafond ; client au-delà du plafond (« Oui » sans puis avec `/caisse/admin`, A13) ; client avec un avoir en cours (A14) ; validation F7 | ligne `M`, `type = 1`, BL généré par `Moulinage.Generation_BL` (`Fiches_Bl`, `Fiches_Ligbl`), `mrem` = n° de BL | `tests/bon_de_caisse/` | à faire |
| CAISSE-T11 | replay | Règlement de BL et factures | Ctrl+F12 choix 2 : sélection de deux BL et d'une facture non payée (`TriFacture`) ; suppression d'une ligne `BL` ; règlement mixte ; puis bande Z | `Fiches_Bl.numtick` posé puis remis à `NULL` ; lignes `BL` (`mrem` = n° de BL) ; après Z : BL facturés `acquitte = 1`, `reg = "Caisse"` | `tests/reglement_bl/` | à faire |
| CAISSE-T12 | replay | Fidélité | carte saisie par code-barre `*299999…` puis par Ctrl+F8 ; carte avec `rem`/`promo` ; bonus utilisé (F9) ; `/caisse/recapbonus` | lignes `BB`, `Fiches_Carte.tp2`/`tg2`, colonnes `carte`, `points`, `sbonus` | `tests/fidelite/` | à faire |
| CAISSE-T13 | replay | Tickets X et Z | Ctrl+F4 (X) ; Ctrl+F5 (Z) refusé avec un ticket en attente, refusé en caisse école ; Z avec `/caisse/ChmZ` absent (A16) puis présent ; Z sur imprimante série (A15) | `Fiches_Caisses.tkz`, archives `Fiches_HisEntTickets`/`HisLigTickets`, écritures `Fiches_Mvt`, PDF copiés | `tests/tickets_x_z/` | à faire |
| CAISSE-T14 | replay | Facturettes et clients divers | F12 : ticket client caisse (coordonnées saisies, `/caisse/histocli` : A06), bon de caisse, ticket inexistant, ticket d'avant la bande Z ; Ctrl+N et F2 (A07) ; Esc dans les coordonnées (A23) | `Fiches_Carte` (client divers créé), PDF produit | `tests/facturettes/` | à faire |
| CAISSE-T15 | replay | Mot de passe administrateur | `/caisse/admin` vrai : F3, F6, F8, F10, F11, Ctrl+F9, Ctrl+F11, Ctrl+F5, Ctrl+F3 ; mot de passe faux puis juste | actions différées exécutées (journal) ; `org` non traités | `tests/mot_de_passe/` | à faire |
| CAISSE-T16 | replay | Imprimantes et modes d'impression | `DéfautA4`, `Défaut80`, `/caisse/choiximp` (Button37 : sortie sans impression), `/caisse/choiximp2`, envoi par mail (`Buttonma_Click`, `EnvMail` vers un serveur SMTP factice) ; bon de caisse sur imprimante série (A22) | tickets enregistrés, `~/Ticket.pdf`, archives `HistoTickets` (A16), mail émis | `tests/modes_impression/` | à faire |
| CAISSE-T17 | replay | Écran tactile et touches de famille (POS) | `/caisse/tactile`, `/caisse/Tfamilles`, `/caisse/touchfam` ; `Fiches_Touches` avec famille et sous-famille ; saisie au clavier virtuel (`Clav`), Entrée et Échap virtuels, `Button38`/`Button39` | lignes ajoutées, zones ; boutons dynamiques `Clav3` (noms à vérifier dans le journal) | `tests/ecran_tactile/` | à faire |
| CAISSE-T18 | replay | Stock | `/caisse/ctrlstk` : article stocké à stock nul refusé ; caisse rattachée à un dépôt (`Fiches_Caisses.depot`) avec article présent dans `Fiches_StkDepots` (A03 figée : erreur) ; caisse école (pas de mouvement) | `art_qte`, `Fiches_StkDepots.qte`, `Fiches_ArtPromo` | `tests/stock/` | à faire |
| CAISSE-T19 | replay | Rétrocession et modification de règlement | Ctrl+R puis articles (prix `art_prvt × coretro`) ; Ctrl+M (ticket à solde nul refusé si non soldé) | `retro = 1`, lignes « Ticket retrocession » / « Ticket modif reglement » | `tests/retro_modif_reglement/` | à faire |
| CAISSE-T20 | replay | Promotion du jour | promotion active (`Fiches_Promo`), article en promotion (ligne « Produit en promotion », remise % refusée), compteur `Fiches_ArtPromo` | lignes `C`, prix promo, `Maj_qteplus` | `tests/promotion/` | à faire |
| CAISSE-T21 | replay | Base SQLite | T01, T04 et T09 sur `Laurux01.sqlite` + jeu caisse | mêmes dumps hors identifiants ; erreur attendue sur `Tottva` (`ENGINE = MYISAM`, A17) | `tests/sqlite/` | à faire |
| CAISSE-T22 | replay | Changement de vendeur | Ctrl+X puis Alt+V avec un ticket vide, vendeur choisi dans `Svendeur` (A04 figée : vendeur inchangé) | colonne `vendeur` des tickets suivants | `tests/changement_vendeur/` | à faire |
| CAISSE-T23 | gbtest | Fonctions pures extraites | `arrondi`/fonction commune (pas × montants positifs et négatifs, dernier chiffre 0-9), `ConvertitPoints`, `FormateLigneTicket`, `MontantEnLettres` (après CAISSE-006, 013, 015, A01) | valeurs de référence capturées en appelant le code actuel dans le clone non modifié (harnais temporaire), anomalies figées | `tests/fonctions_pures/` | à faire |
| CAISSE-T24 | replay | Performance | ticket de 100 lignes avec remise sur total et 5 règlements ; rappel d'un ticket en attente de 100 lignes | durée (`gbx3 -p`), nombre de requêtes `Exec_SQL` (`Calc_Tva`, `art_nbd`, `art_bonus`, famille relus par ligne) | `tests/perf_ticket_long/` | à faire |
| CAISSE-T25 | replay | Périphériques série simulés | imprimante `/dev/pts/N` (paire `socat`) en `6000III` puis `Tmu950` : ticket, chèque, tiroir (Ctrl+T), afficheur ; balance simulée (F10, `Button34`) ; port absent (A25 : `Quit`) ; `/caisse/affusbwn` (A09) | octets ESC/POS capturés comparés à `expected/` ; quantité pesée | `tests/peripheriques_serie/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées en rejouant chaque scénario dans le clone **Laurux non modifié**,
  sur une base MariaDB jetable restaurée depuis `Laurux01.sql`, complétée par un **jeu dérivé**
  `tests/jeu_caisse.sql` : `Laurux01.sql` ne contient **aucune** donnée de caisse (vérifié : pas de
  `Fiches_Caisses`, `Fiches_Vendeurs`, `Fiches_ClientCaisse`, `Fiches_Touches`, `Fiches_Carte`,
  `Fiches_Promo`, `Fiches_LibelTicket`, `Fiches_LibelAvoirs`). Le jeu fournit : deux caisses (dont
  une école et une rattachée à un dépôt), un vendeur administrateur (mot de passe chiffré par
  `hexdblKey`), le client caisse, des articles stockés et non stockés (décimales 0/2/3, arrondis
  `0,05`…`1,00`, écotaxe, copie privée, colisage, tranches de remise, `art_bonus`), deux taux de
  TVA, une promotion active, des touches de famille et de sous-famille, des cartes de fidélité, des
  avoirs et acomptes existants, des clients en compte (sous et au-delà du plafond), des BL et une
  facture non réglés, les libellés de ticket et d'avoir. Chaque test fournit son `Laurux.conf`
  (`-c`) avec les clés `/Soc01/caisse/…` utiles (`Ncai`, `admin`, `tactile`, `choiximp*`,
  `ctrlstk`, `ChmZ`, `histocli`, `qt1`…). La caisse doit être « connectée » (`Ouverture`) avant la
  saisie : prévoir l'état de `Fiches_Caisses` correspondant.
- **Normalisation du dump** : `date` des tickets, `dte` des avoirs et acomptes (A21), `datec`/`datef`
  des cartes, horodatages GED et dates des écritures masqués ou figés par `faketime` ; le
  **chaînage SHA1** (`control`, `prev_numero`) dépend de la date : figer l'horloge ou ne comparer que
  `prev_numero` ; table de travail `Tottva` exclue (contenu du dernier ticket) ; numéros `cutk`
  conservés seulement si la base de départ est identique.
- **Rejeu** : `Utils.Observers(Me)` est appelé une seule fois dans `Form_Open` (pas de cumul).
  `ColTka_Click`, `Cavoirs_Click`, `Cacomptes_Click` sont appelés dynamiquement et doivent garder
  leur nom et leur portée `Public`. Les grilles **`ColumnView1` et `LigTk` n'ont pas de `_Click`**
  (`replay_missing`) : les scénarios suppriment lignes et règlements au clavier (Suppr, Entrée sur
  `Activate`), jamais par clic. Les contrôles créés par code (fenêtre `entremail` : `win`, `mail`,
  `annul`, `valid` ; boutons `Clav3` de sous-famille ; `hpan`) ne sont pas observés par
  `Utils.Observers` : la saisie du courriel et les sous-familles peuvent ne pas être rejouables
  (à vérifier, sinon saisie remplacée par une préférence de test). Les dialogues modaux
  (`Message.Question`, `TriCpt`, `TriArticles`, `TriFacture`, `Tricartes`, `Svendeur`, `FCalc`,
  `Fondcaisse`) sont rejoués par `ReplayObserver`.
- **Non testable sans matériel** : terminal de paiement (TPE Telium : non piloté par cette classe),
  impression physique sur imprimante ticket réelle (rendu, coupe papier, impression du chèque dans
  le lecteur), ouverture effective du tiroir-caisse, afficheur client réel (port imprimante ou BA63
  USB), balance réelle. T25 ne vérifie que les **octets** envoyés sur un port série simulé ; les
  tests PDF ne vérifient que la production du fichier, pas son rendu (CAISSE-A05). L'aide
  (`Doc.Open`) et le plein écran (F11) ne sont vérifiés que par le journal.
- **Verrous et concurrence** : `DocActif`, `LOCK TABLES` et la table partagée `Tottva` (A17)
  supposent un seul poste ; aucun test de concurrence entre caisses.
- **Couverture visée** : toutes les fonctions hors code mort (CAISSE-003) ; les branches propres
  aux imprimantes série et à la balance exigent T25 ; avant les extractions du rework, la
  couverture repose sur les replays.
