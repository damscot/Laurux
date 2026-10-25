# StatComm — Tests

> Source : `.src/Statistiques/StatComm.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI : tests `replay` depuis le menu Gestion › Statistiques › « CA clients/commerciaux »
(`Fmenu.Menu313`). `Utils.Observers(Me)` est appelé une fois dans `_New` : rejouable. Chaque
scénario saisit les dates, choisit la source (`Fact`/`Face`/`Facn`), coche ou non `Detail`,
clique **Traitement**, puis relève l'écran `VisStatComm` ouvert (voir ses tests). On compare : le
**dump normalisé de la table `Total`** (trié par `cdclifac`), les lignes `Exec_SQL` du journal
(informatif), les messages affichés ; le reste de la base doit être inchangé.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| STATCOMM-T01 | replay | Détail par client, factures hors entretien | `statistiques_ventes`, période N, `Facn`, `Detail` coché | dump `Total` : une ligne par client, `brutfac`/`rmfac`/`totfac` cumulés, `commercial` = `cli_comm` | `tests/statcomm_detail_facn/` | à faire |
| STATCOMM-T02 | replay | Synthèse par commercial | même période, `Detail` décoché | une ligne par commercial ; clients sans commercial ignorés ; `pnmclifac` = prénom d'un client (A04 figée) | `tests/statcomm_synthese/` | à faire |
| STATCOMM-T03 | replay | Sources entretien / toutes | `Face` puis `Fact` | lignes issues de `HistoFacM`, puis des deux tables (`union`) | `tests/statcomm_sources/` | à faire |
| STATCOMM-T04 | replay | Cumul N-1 | factures N et N-1 pour un même client ; client vendu en N-1 seulement | `totfacn1` cumulé ; client N-1 seul absent (A03 figée) | `tests/statcomm_n1/` | à faire |
| STATCOMM-T05 | replay | Client supprimé | facture d'un `cdclifac` absent de `Fiches_Cli`, après une facture d'un autre client | synthèse : montant attribué au commercial précédent (A01 figée) ; détail : erreur figée (A02) | `tests/statcomm_client_absent/` | à faire |
| STATCOMM-T06 | replay | Période vide et dates inversées | période sans facture ; fin < début (Entrée dans `Dten1`) | « Aucune donnée pour cette période ! » ; `Message.Warning` « sélection n'est pas possible » | `tests/statcomm_cas_limites/` | à faire |
| STATCOMM-T07 | replay | Option matériel désactivée | `/Soc01/Materiel = 0` | `HBox3` masquée, `Facn` forcé | `tests/statcomm_sans_materiel/` | à faire |
| STATCOMM-T08 | replay | Base SQLite | `Laurux01.sqlite` + jeu de T01 | même dump `Total` que T01 (aucune fonction MySQL non traduite) | `tests/statcomm_sqlite/` | à faire |
| STATCOMM-T09 | gbtest | `CalculTotal` (après STATCOMM-006) | jeu de T01-T04, paramètres équivalents | contenu de `Total` identique aux dumps T01-T04 | `tests/statcomm_calcul/` | à faire |
| STATCOMM-T10 | gbtest | `StatCommun.PeriodeN1` / `DateSaisie` (après STATCOMM-005) | `01.03.2024`, `29.02.2024`, `""`, `"00.00.0:00"` | chaînes de référence (29.02 → 29.02.2023 figé) | `tests/statcommun_dates/` | à faire |

## Détail des tests

- **Jeu `statistiques_ventes`** (commun au lot Statistiques : `StatComm`, `StatTypCli`,
  `StatComArt`, `StatClimo`, `StatFour`, `StatPromo`, `Statbase` et leurs `VisStat*`), dérivé de
  `facturation_base` ([ObjFac/test.md](../../Gestion/Facturation/ObjFac.class/test.md)) et
  d'`editions_articles` ([EdArt1/test.md](../../Gestion/Impressions/EdArt1.class/test.md)).
  Script SQL à produire en phase 2 dans `tests/_donnees/statistiques_ventes.sql`. Contenu :
  - 3 commerciaux (`Fiches_Commerciaux`, `comm` 0, 5,5 et NULL) ; 3 types client
    (`Fiches_Typec`) ; ≈ 10 clients `411…` répartis (un sans commercial, un sans type, un dont le
    type est supprimé) ;
  - factures archivées `Fiches_HistoFac` + `Fiches_HistoLigfac` sur une période N (mars de
    l'année courante) **et** la même période N-1, plusieurs factures par client, lignes `A`
    (articles) et `M` (main d'oeuvre), remises `remmofac`/`remartfac` au format `"12,50"` et une
    au format `"12.50"`, une facture d'un client supprimé ;
  - factures d'entretien `Fiches_HistoFacM` + `Fiches_HistoLigfacM`, dont un numéro identique à
    une facture `HistoFac` (cas `union` / mauvaise table de lignes) ;
  - BL en cours `Fiches_Bl`/`Fiches_Ligbl` (+ `M`) de types `F`, `B` et `D`, dans et hors
    période (StatClimo) ;
  - réceptions `Fiches_Entrecpt` sur N et N-1 (plusieurs par fournisseur, une validée et une
    non, un fournisseur supprimé) (StatFour) ;
  - une promotion `Fiches_Promo` et ses articles `Fiches_ArtPromo` avec `qte` renseignée et un
    `pht` NULL (StatPromo) ;
  - quelques tickets archivés `Fiches_HisEntTickets` et en cours `Fiches_EntTicketz` (Statbase).
- **Valeurs attendues** : produites dans le clone **Laurux non modifié** (anomalies comprises),
  horloge figée (`faketime`) car `Dten1` vaut la date du jour et `DteN0` dérive de `dteclec1`.
- **Normalisation du dump** : `Total` trié par clé primaire, décimaux à 2 chiffres.
- **Non testable automatiquement** : son (`Music.Play`), couleur du champ actif, curseur souris.
- **Isolation** : la table `Total` est partagée ; les replays du lot doivent tourner **en série**
  sur une base dédiée (sinon STATCOMM-A05 rend les dumps instables).
- T02, T04 et T05 caractérisent des anomalies ; ils seront mis à jour avec leur correction.
