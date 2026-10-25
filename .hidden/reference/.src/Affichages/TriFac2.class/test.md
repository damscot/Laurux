# TriFac2 — Tests

> Source : `.src/Affichages/TriFac2.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Liste de sélection modale lancée depuis `Facture` (`Button25`). Comparaison : dump normalisé après
enregistrement du document créé ; lignes `Exec_SQL` à titre informatif.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| TRIFAC2-T01 | replay | Reprise d'un BL en cours | `Facture` : nouveau document, `Button25`, mode « en cours », clic sur un BL, enregistrement | lignes reprises du BL choisi (`Fiches_Bl`, `Fiches_Ligbl`) | `tests/reprise_bl/` | à faire |
| TRIFAC2-T02 | replay | Reprise d'une facture archivée | idem en mode `Archives` ; tri `NMF`, filtre `NM` | lignes reprises de `Fiches_HistoLigfac` ; numéro de BL vide dans la grille | `tests/reprise_archive/` | à faire |
| TRIFAC2-T03 | replay | Tri, filtre, date, double-clic, pagination | chaque en-tête, `DA` `0101`/`01012025`, double-clic ×2, PageDown/molette | grilles et requêtes de référence ; figer A02 (second double-clic en archives) | `tests/tri_pagination/` | à faire |
| TRIFAC2-T04 | replay | Changement de source | filtre `DU` sur `NM` en cours, page 2, puis `Archives`, puis `Encours` | figer le filtre et le décalage conservés (A03) | `tests/changement_source/` | à faire |
| TRIFAC2-T05 | replay | Retour arrière sur la date en archives | `Archives`, `DA`, saisie `01` puis 2 retours arrière | figer l'erreur SQL (A01 : `datefac` sur `Fiches_Bl`) | `tests/date_archives/` | à faire |
| TRIFAC2-T06 | replay | Fermeture sans choix | après une reprise réussie, nouveau document, `Button25`, Échap dans un en-tête | figer le rechargement de l'ancien document (A04) | `tests/fermeture/` | à faire |
| TRIFAC2-T07 | gbtest | `RequeteDocuments` (après TRIFAC2-009) | source en cours/archives, tri, filtre, sens, pages | texte SQL identique au clone non modifié | `tests/requete_documents/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone **Laurux non modifié** ; A01 à A04 figées.
- **Données** : jeu dérivé `factures_base` (commun avec `TriFac`) complété de ≥ 3 pages de
  `Fiches_Bl` (types B, F, D) dont quelques documents à `totalht = 0` (exclus de la liste).
- **Instrumentation** : pas de `Utils.Observers(Me)` → T01 à T06 non rejouables tant que l'écran
  n'est pas instrumenté dans les deux clones (décision de phase 2, comme `TriFac`).
- **T05** : l'erreur SQL passe par `DB_Connection.Exec` (`Message.Error`) ; le scénario doit
  fermer le message.
- **Rejeu** : `ColFac_Click` doit rester `Public` ; géométrie de la grille fixée (calcul de `lg`).
