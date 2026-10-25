# Archives — Tests

> Source : `.src/Archivages/Archives.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran de consultation instrumenté (`Utils.Observers`) : tests `replay`. Le rejeu relève le contenu de
`Colbl`, `Coldetail` et des totaux ; la base doit rester identique (hors table de travail `Blcom`)
et la clé `/Soc01/Col/LcolH` de `Laurux.conf` est comparée pour T15. Valeurs attendues produites
dans le clone **Laurux non modifié** (anomalies figées).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| ARCHIVES-T01 | replay | Ouverture | jeu `factures_archives`, `/Soc01/Materiel` = 0 puis 1 | 1re page (mode « hors entretien » ou « toutes ») triée par numéro décroissant | `tests/archives_ouverture/` | à faire |
| ARCHIVES-T02 | replay | Modes de liste | clic `Face`, `Facn`, `Fact` | lignes de chaque mode | `tests/archives_modes/` | à faire |
| ARCHIVES-T03 | replay | Tri et filtre par en-tête | focus puis frappe dans `NO`, `CO`, `NM` (nom), `MT`, `MTC`, `NUMS` ; double-clic | lignes filtrées et ordre ; union « Toutes » filtrée par préfixe côté entretien (A04 figée) | `tests/archives_tri_filtre/` | à faire |
| ARCHIVES-T04 | replay | Filtre par date et pagination | `DA` : `0102` puis `01022025` ; puis molette | lignes filtrées, puis page suivante (vide aujourd'hui, A02 figée) | `tests/archives_filtre_date/` | à faire |
| ARCHIVES-T05 | replay | Pagination | 3 pages ; molette, `Descendre`, `Remonter`, Page suiv./préc. | 1re ligne affichée après chaque action | `tests/archives_pagination/` | à faire |
| ARCHIVES-T06 | replay | Détail d'une facture | clic sur une facture avec lignes `A`, `M`, `C` multi-lignes, `O`, remise ; `Prxdec` 0 puis 1 | `Coldetail`, totaux, `Variables.bRemise` | `tests/archives_detail/` | à faire |
| ARCHIVES-T07 | replay | Détail d'une facture entretien | mode `Face`, facture avec `Fiches_HisentMat` | bloc matériel et lignes `…M` | `tests/archives_detail_entretien/` | à faire |
| ARCHIVES-T08 | replay | Facture suivante / précédente | `Button1`/`Button2` en milieu et en bord de page | facture affichée (bornes 26/25 figées, A03) | `tests/archives_suivante/` | à faire |
| ARCHIVES-T09 | replay | Recherche dans les lignes | `NM` = « Commentaire », « Code produit », « Libellé produit », Entrée ; deux recherches par code successives | liste `Blcom` ; 2e recherche par code : erreur figée (A01) | `tests/archives_recherche_lignes/` | à faire |
| ARCHIVES-T10 | replay | Réimpression | détail puis « Imprimer » (`Button9`) ; fermeture d'`OptFac` | `OptFac` ouvert en mode archive pour la bonne facture ; base inchangée | `tests/archives_reimpression/` | à faire |
| ARCHIVES-T11 | replay | Suivi | F12 dans le détail | fenêtre `Suivi` ouverte pour le client et la facture | `tests/archives_suivi/` | à faire |
| ARCHIVES-T12 | replay | Client supprimé | facture dont le client n'existe plus | comportement figé (message d'erreur, A05 à confirmer) | `tests/archives_client_absent/` | à faire |
| ARCHIVES-T13 | replay | Saisie d'un guillemet | `"` dans `NO` puis dans `NM` (commentaire) | comportement figé (erreur SQL attrapée, A06) | `tests/archives_guillemet/` | à faire |
| ARCHIVES-T14 | replay | SQLite | T01 sur `Laurux01.sqlite` + jeu dérivé | comportement figé (A07, à confirmer) | `tests/archives_sqlite/` | à faire |
| ARCHIVES-T15 | replay | Largeurs de colonnes | redimensionner une colonne du détail, sortir par `Button5` puis par Échap | clé `/Soc01/Col/LcolH` écrite ; relue à la réouverture | `tests/archives_largeurs/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` + jeu dérivé `factures_archives.sql` (partagé avec
  `RAZHISTOFAC-T*`) : ~60 factures sur 3 pages, factures entretien avec matériel, lignes de tous
  types, commentaires multi-lignes, un client supprimé, `Fiches_ligcons` pour l'option boissons.
- **Configuration** : variantes `/Soc01/Materiel`, `/Soc01/Prxdec`, option `B` (boissons).
- **Rejeu** : `Colbl_click` appelé par `Object.Call` (rester `Public`) ; ne pas cliquer dans
  `Coldetail` (`replay_missing`) ; `OptFac` et `Suivi` à fermer par le scénario.
- **Comparaison** : grilles et totaux relevés ; dump de la base identique (hors `Blcom`) ;
  `Laurux.conf` pour T15.
- **Non testable automatiquement** : interférence de la table permanente `Blcom` entre deux postes
  (A01, scénario manuel) ; impression réelle (couverte par les tests d'`ObjFacB`).
