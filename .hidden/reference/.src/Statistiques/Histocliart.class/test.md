# Histocliart — Tests

> Source : `.src/Statistiques/Histocliart.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran en lecture seule. Deux sorties comparables : le **CSV** `~/tmp/HistoVente.csv` (export, comparé
tel quel) et le **PDF** `~/tmp/Histo.pdf` (édition `gb.report`, capturé par le script de
`/Soc01/caisse/CmdVis`, `pdftotext -layout`, dates normalisées). Les lignes `Exec_SQL` du log
contiennent la requête complète : elles sont **la** référence de non-régression de `crearequ` (le
rework HISTOCLIART-003 doit produire un texte SQL identique). Le dump doit être inchangé. Les valeurs
attendues sont produites dans le clone **Laurux non modifié**. `Utils.Observers(Me)` est appelé une
fois : rejouable.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| HISTOCLIART-T01 | replay | Export par client, réglages par défaut | `statistiques_ventes` ; **Exporter** (BL + factures, BL et factures cochés) | CSV (client;qte;marge;ca, tri par qté) ; SQL `UNION ALL` de 2 sous-requêtes | `tests/histocliart_export_client/` | implémenté (`Statistiques/histocliart_export_client`) |
| HISTOCLIART-T02 | replay | Édition par client avec détail article | `Checkdetart`, `Checkca`, `Checkmarg`, **Éditer** | texte PDF (titres de groupe, sous-totaux, total) | `tests/histocliart_edit_detail/` | implémenté (`Statistiques/histocliart_edit_detail` : SQL et absence d'erreur ; texte gb.report vide sous pdftotext, non comparé) |
| HISTOCLIART-T03 | replay | Par article et par famille | `Radioart` + `Checkdetcli` puis `Radiofam` + `Checkdetart`, **Exporter** chaque fois | CSV et SQL de chaque mode | `tests/histocliart_modes/` | implémenté (`Statistiques/histocliart_modes` : code 125 figé, Unknown field client, candidat anomalie ; `histocliart_modes_famille`) |
| HISTOCLIART-T04 | replay | Toutes les sources sauf tickets | `CheckDoc`, `CheckDocE`, `CheckFacA`, `CheckFacEA` ; types P, D, C, B, F | SQL à 4 sous-requêtes ; CSV | `tests/histocliart_sources/` | implémenté (`Statistiques/histocliart_sources`) |
| HISTOCLIART-T05 | replay | Factures + factures matériel sans BL | décocher `CheckDoc`, cocher `CheckFacEA`, **Exporter** | SQL invalide (sous-requêtes collées), `Message.Error` de `DB_Connection` puis erreur (A01 figée) | `tests/histocliart_union_manquante/` | implémenté (`Statistiques/histocliart_union_manquante`, code 125 figé : Query failed) |
| HISTOCLIART-T06 | replay | Tickets | `CheckTk` (les autres cases se désactivent), **Exporter** | SQL tickets (dernier bloc `max(type)`, `suppr != 1`) ; CSV | `tests/histocliart_tickets/` | implémenté (`Statistiques/histocliart_tickets`) |
| HISTOCLIART-T07 | replay | Filtres | plages client/article/fournisseur, type client (liste `Buttype`, double-clic), commercial, marque et centrale (listes `btn`, double-clic), 2 familles sélectionnées avec `Checktfam` décochée | clauses `cli_typec`, `cli_comm`, `art_marque`, `art_centrale`, `IN (…)` dans le SQL | `tests/histocliart_filtres/` | implémenté partiel (`Statistiques/histocliart_filtres` : type client, marque, centrale saisis, erreur « type de document ») ; à faire : listes `Buttype`/`btn` (double-clic non rejoué), commercial (aucun dans Laurux01), familles (clic TreeView) |
| HISTOCLIART-T08 | replay | Familles sans sélection | `Checktfam` décochée, aucune famille sélectionnée, **Exporter** | SQL `IN)` invalide (UTILS-A02 figée) | `tests/histocliart_famille_vide/` | implémenté (`Statistiques/histocliart_famille_vide` : 1re famille sélectionnée par défaut → `IN('01')` ; cas `IN)` inatteignable sans clic TreeView) |
| HISTOCLIART-T09 | replay | Sélection de tiers | `Butcli` → choix, `Butcli2` → choix puis `Butcli2` → annulation ; saisie d'un code inexistant | zones remplies ; annulation reprend l'ancien choix (A04) ; contrôle de `Cli` au lieu de `Cli2` (A03) | `tests/histocliart_tiers/` | à faire : choix dans la liste par double-clic (non rejoué) ; contrôle de saisie par boîte depuis LostFocus |
| HISTOCLIART-T10 | replay | Aucune source / résultat vide | aucune case de source, **Éditer** puis **Exporter** ; période sans vente, **Exporter** | message « Veuillez sélectionner au moins un fichier » ; export en erreur (A05 figée) | `tests/histocliart_vide/` | implémenté (`Statistiques/histocliart_vide` : avertissement puis Query failed, code 125 figé) ; à faire : période sans vente |
| HISTOCLIART-T11 | gbtest | Construction de la requête (après HISTOCLIART-004) | collections de critères reprenant T01-T08 | texte SQL identique aux lignes `Exec_SQL` capturées en T01-T08 | `tests/histocliart_requete/` | à faire : exige l'extraction HISTOCLIART-004 (crearequ privée) |

## Détail des tests

- **Données** : `statistiques_ventes` (voir [`TBord/test.md`](../TBord.class/test.md)) : documents en cours
  de chaque type (`P`, `D`, `C`, `B`, `F`, `A`) avec `dtefac` pour `A`/`F`, documents matériel, factures
  historisées normales et matériel, tickets avec plusieurs blocs et versions `A`/`S` d'une ligne, un
  ticket supprimé, valeurs avec virgule et `NULL` dans `qte`/`netht`/`mrgart`/`mrgmo`, 2 commerciaux,
  2 types client, marques et centrales, arborescence de familles (`Trifam`), un client supprimé
  référencé par une facture (ligne sautée par `edition`).
- **Période** : début d'exercice et fin de mois dépendent de `Now` ; horloge fixée.
- **Comparaison du SQL** : les lignes `Exec_SQL` sont **bloquantes** pour HISTOCLIART-003/004 (rework
  déclaré sans changement SQL).
- **Grilles sans `_Click`** : `ColumnView1`/`ColumnView2` (`replay_missing`) : choisir par double-clic.
- **Non testable automatiquement** : couleur du titre (`Start.R/G/B`), son, contenu de `TextArea1`
  (journal du SQL, vérifiable visuellement).

- **Jeu de données (phase 2)** : `.hidden/Tests/Statistiques/assets/histocliart_shared/ventes.sql` (BL B/F/D, factures historisées 2017-2018, tickets avec bloc en versions A/S et ticket supprimé) ; scénarios dans `.hidden/Tests/Statistiques/assets/histocliart_*/`.
