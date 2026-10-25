# Listecom — Tests

> Source : `.src/Gestion/Stock/Listecom.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran en lecture seule, ouvert depuis `Facture` (Ctrl+H / Ctrl+A) ou `FClient` (bouton 24). Tous
les tests sont des `replay` : le **contenu de la grille** (texte des cellules, relevé par le
replay) fait foi ; le dump de la base doit rester inchangé. Valeurs attendues produites dans le
clone **Laurux non modifié** (caractérisation, défauts compris).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| LISTECOM-T01 | replay | Mode client (sans article) | `FClient`, client avec factures, BL et BL entretien sur 12 dates ; bouton 24 | 10 dates en colonnes, une ligne par article, désignations Art/Mo/libellé ; base inchangée | `tests/listecom_client/` | à faire |
| LISTECOM-T02 | replay | Mode article | `Facture`, client et article saisis ; Ctrl+A | lignes (code, date, qté, Px HT moyen), colonnes vides en trop figées | `tests/listecom_article/` | à faire |
| LISTECOM-T03 | replay | Date sans ligne A/M | client dont une des 10 dates n'a que des lignes de commentaire ; Ctrl+H | comportement actuel figé (erreur ou grille partielle, à constater) | `tests/listecom_date_vide/` | à faire |
| LISTECOM-T04 | replay | Client sans historique | client sans facture ni BL | fenêtre vide, aucune erreur | `tests/listecom_vide/` | à faire |
| LISTECOM-T05 | replay | Base SQLite | T01 rejoué sur `Laurux01.sqlite` | résultat actuel figé (échec probable de `UNION(SELECT …)`) | `tests/listecom_sqlite/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` + jeu dérivé `historique_client.sql` (un client, 12 dates d'achat
  réparties entre `Fiches_HistoFac`, `Fiches_Bl`, `Fiches_BlM`, `Fiches_HistoFacM`, avec des
  lignes `A`, `M` et `C`, un article supprimé de `Fiches_Art` pour tester le repli sur le libellé).
- **Scénarios** : ne pas cliquer dans `GridView1` (pas de `GridView1_Click`, rejeu impossible,
  REPLAYOBSERVER-A06). L'écran appelle `Utils.Observers(Me)` : il est instrumenté.
- **Comparaison** : texte de toutes les cellules et en-têtes de ligne, nombre de colonnes ; dump de
  la base identique avant/après.
- **gbtest** : aucun aujourd'hui (logique dans le constructeur d'un formulaire). Après LISTECOM-003,
  `ReqLignes` peut être testé en gb.test (texte SQL identique à la référence).
