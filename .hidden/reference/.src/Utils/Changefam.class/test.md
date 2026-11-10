# Changefam — Tests

> Source : `.src/Utils/Changefam.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran de traitement de masse en base : l'essentiel se teste en **replay** sur MariaDB (Docker), avec
un dump normalisé avant/après des tables touchées par `Modifart` et `Change2`. Les fonctions sont
toutes privées de fait (aucun appelant externe) : pas de test gb.test possible avant la séparation
traitement/GUI (CHANGEFAM-006), sauf en instanciant le formulaire.

Tables comparées dans tous les replays : `Fiches_Art`, `Fiches_HistoLigfac`, `Fiches_HistoLigfacM`,
`Fiches_Ligbl`, `Fiches_LigblM`, `Fiches_Materiels`, `Fiches_HisLigTickets`, `Fiches_LigTicketz`,
`Docs_Ged`, `Fiches_ArtPromo`, `Fiches_CdBarre`, `Fiches_CdFour`, `Fiches_Cequ`, `Fiches_EtiGond`,
`Fiches_EtiProd`, `Fiches_HisInvT`, `Fiches_Inv`, `Fiches_InvT`, `Fiches_Ligcom`, `Fiches_Ligrecpt`,
`Fiches_Mvtexp`, `Fiches_Mvtexpdc`, `Fiches_PrdComp`, `Fiches_Rpl1`, `Fiches_Rpl2`, `Fiches_Tarcli`,
`Fiches_TarTypcli`, `Rupture`, `RuptureC`, plus les lignes `Exec_SQL` du log.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CHANGEFAM-T01 | replay | Un article, famille seule | Menu Gestion → Changement de famille ; `Code` = article existant, `Nfam` = famille existante, `NvCode` vide, « Lancer » | dump : famille changée dans les 8 tables ; log identique | `tests/article_famille/` | implémenté (`changefam_article_famille`) |
| CHANGEFAM-T02 | replay | Un article, famille + nouveau code | idem avec `NvCode` libre | dump : code propagé dans les 29 tables | `tests/article_code/` | implémenté (`changefam_article_code`) |
| CHANGEFAM-T03 | replay | Nouveau code déjà existant | `NvCode` = code d'un autre article | figer le comportement actuel (erreur SQL, tables restées verrouillées) | `tests/article_code_doublon/` | implémenté (`.hidden/Tests/Utils/assets/changefam_article_code_doublon/`, erreur fatale « Duplicate entry '002' » Changefam.Modifart.505 figée, code 125) |
| CHANGEFAM-T04 | replay | Famille inexistante | `Nfam` inconnu, Entrée puis « Lancer » | avertissement, aucune écriture | `tests/famille_inconnue/` | implémenté (`changefam_famille_inconnue`) |
| CHANGEFAM-T05 | replay | Liste d'articles | case `Liste`, 3 articles ajoutés (`Button9`), « Lancer » | dump : 3 articles traités ; `CFamille` créée (log) | `tests/liste_articles/` | implémenté (`changefam_liste_articles`) |
| CHANGEFAM-T06 | replay | Liste : article saisi deux fois | même code ajouté 2 fois | message « déjà saisi », un seul traitement | `tests/liste_doublon/` | implémenté (`changefam_liste_doublon`) |
| CHANGEFAM-T07 | replay | Famille entière | cadre bas `Afam2` → `Nfam2`, bouton `Tag 6` | dump des 8 tables | `tests/famille_globale/` | implémenté (`changefam_famille_globale`) |
| CHANGEFAM-T08 | replay | Import fichier CSV | case `Fichier`, fichier `code;fam;nvcode` (3 lignes valides, 1 famille inconnue) | figer le comportement actuel (cf. anomalies A01/A02) | `tests/import_fichier/` | à faire : sélection de fichier (Dialog.OpenFile) non rejouable |
| CHANGEFAM-T09 | replay | Base sans `Rupture`/`RuptureC` | T01 sur `Laurux01.sql` brut | figer l'échec du `LOCK TABLES` (anomalie A03) | `tests/verrou_sans_rupture/` | implémenté (`.hidden/Tests/Utils/assets/changefam_verrou_sans_rupture/`, erreur fatale « Fiches_Inv doesn't exist » Changefam.verrou.732 figée, code 125) |
| CHANGEFAM-T10 | replay | Saisie code-barres | `Code` = `*<code-barres>` | article retrouvé via `Fiches_CdBarre` | `tests/code_barre/` | implémenté (`changefam_code_barre`) |
| CHANGEFAM-T11 | replay | Sélection par listes | `Button1` (TriArticles), `Button2` (FamList), Échap | champs remplis ; aucune écriture | `tests/selection_listes/` | implémenté (`changefam_selection_listes`, sans TriArticles ; seule l'absence d'écriture est comparée) |
| CHANGEFAM-T12 | gbtest | `Modifart` (après CHANGEFAM-006) | base dérivée, appels directs avec code inchangé / changé / vide | dump identique à T01/T02 | `tests/modifart_unitaire/` | à faire : après CHANGEFAM-006 (extraction de Modifart) |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone **Laurux non modifié** (`./Laurux -l --logfile …`,
  dump MariaDB normalisé) puis rejouées sur `Laurux_reworked` ; le diff doit être vide.
- **Données** : `Laurux01.sql` enrichi d'un jeu dérivé (`tests/*/data.sql`) : 2 familles, 4 articles
  stockés avec historique (facture, BL, ticket, réception, inventaire, code-barres, promo, tarif
  client), et les tables `Rupture`/`RuptureC` créées (sauf T09).
- **Colonnes volatiles masquées** : aucune (pas de date système écrite).
- **Non testable automatiquement** : sons (`Music.Play`), `Balloon`, apparence du formulaire
  dynamique ; sous SQLite, les `LOCK TABLES` sont neutralisés (comportement différent de MariaDB :
  T03/T08/T09 à jouer sur MariaDB uniquement).
- Jeu de données : `.src/Tests/Framework/datasets/changefam_base.sql` (Rupture, RuptureC et Fiches_Inv, Fiches_InvT créées : ces 4 tables sont absentes de Laurux01.sql et verrouillées par `verrou()` ; historique des articles 001/002). T03/T09 : nombre de boîtes de message à confirmer au premier rejeu. T11 ne couvre pas TriArticles (Button1) ; Échap remplacé par un second clic sur Button4 (Échap non rejouable).
- **Rejeu phase 2** : T03 et T09 aboutissent à une erreur SQL propagée (`Error.Propagate` dans `DB_Connection.Exec`,
  backtrace désactivée) : aucune boîte `FMessage`, gbx3 ouvre sa boîte d'erreur fatale et le rejeu dépasse le délai.
  En mode Liste, `Nfam` n'est pas vidé après « Ajouter » : il n'est saisi que pour le premier article.
