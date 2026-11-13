# BordereauxC — Tests

> Source : `.src/Compta/Impressions/BordereauxC.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

L'écran **écrit en base** (chèques en attente, écritures de remise, soldes, compteurs, SHA-1) :
les replays comparent le **dump normalisé** (colonnes volatiles `lind` auto-incrémentées
masquées si besoin, empreinte SHA-1 conservée car déterministe à données égales) et le PDF
`~/tmp/Bordereau.pdf` après `pdftotext -layout` et normalisation de la date du titre
(« Bordereaux de chèques du dd.mm.yyyy »).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| BORDEREAUXC-T01 | replay | Ouverture | jeu `Fiches_BordereauxC` (3 chèques clients, 2 chèques caisse) | grille chargée, combo banques hors `53` ; dump inchangé | `tests/ouverture/` | implémenté (requêtes de chargement, dump inchangé ; contenu de la grille non comparé) |
| BORDEREAUXC-T02 | replay | Ajout / modification / suppression de chèque | clic droit + saisie + « save » ; modification d'une ligne existante ; « trash » + Oui | dump `Fiches_BordereauxC` (date de la ligne modifiée et montant saisi avec virgule figés, A08) | `tests/grille/` | à faire : ajout par clic droit (Grd1_MouseUp, Mouse.Right) et clic de cellule de Grd1 (TableView sans Grd1_Click) non rejouables |
| BORDEREAUXC-T03 | replay | Impression sans comptabilisation | n° 12, banque 51, « Imprimer », Non à l'effacement | PDF normalisé ; copie sous `FactcheminC/Bordereaux/aaaa/mm` ; compteurs `numecriture*` incrémentés (A04 figée) | `tests/impression_seule/` | implémenté |
| BORDEREAUXC-T04 | replay | Remise complète | idem, Oui à l'effacement | dump : lignes `Fiches_Mvt` (clients, caisse, banque, collectif), soldes `Fiches_Comptes`, SHA-1, chèques supprimés ; libellé banque sans numéro (A01), collectif crédité deux fois du dernier chèque (A02), solde du collectif (A03) figés | `tests/remise_complete/` | implémenté |
| BORDEREAUXC-T05 | replay | Désélection | un chèque désélectionné (colonne 2) puis remise | chèque désélectionné conservé, absent du PDF et des écritures | `tests/deselection/` | à faire : désélection par clic sur la colonne 2 de Grd1 (Grd1_MouseUp, pas de Grd1_Click) non rejouable |
| BORDEREAUXC-T06 | replay | Lettrage | chèque client dont le lot (n° de facture) solde exactement la facture | ligne `lettree = 1` ; chèque caisse jamais lettré (A05 figée) | `tests/lettrage/` | implémenté |
| BORDEREAUXC-T07 | replay | Chèque sans code client | ligne sans code | `Message.Error` avec le montant du chèque précédent (A06 figée) | `tests/sans_code/` | implémenté |
| BORDEREAUXC-T08 | replay | Contrôles de saisie | sans n° de bordereau ; sans banque | `Message.Warning` correspondant ; aucun changement en base | `tests/controles/` | implémenté |
| BORDEREAUXC-T09 | replay | Chemin de copie absent ou avec espace | `FactcheminC` vide ; puis chemin « /tmp/a b » | avertissement « Copie impossible » ; copie échouée sans message (A07 figée) | `tests/copie_pdf/` | implémenté |
| BORDEREAUXC-T10 | gbtest | `Comptabilise_Remise` (après BORDEREAUXC-006) | base de test, liste de chèques en paramètre | dump identique à T04 | `tests/comptabilise/` | à faire : exige l'extraction BORDEREAUXC-006 |
| BORDEREAUXC-T11 | replay | SQLite | T04 sur `Laurux01.sqlite` | même dump fonctionnel que MySQL (sinon écart documenté) | `tests/sqlite/` | à faire : variante SQLite non traitée (vague 4, temps) |

## Détail des tests

- **Implémentés** : T01 `.hidden/Tests/Compta/assets/bordereauxc_ouverture/`, T08 `bordereauxc_controles/`
  (jeu `bordereauxc_shared/bordereauxc_base.sql` : 3 chèques clients, date 2018-06-15). Menu
  `Fmenu#Menu67#Menu321` (fenêtre modale).
- **Implémentés (vague 4)** : banque choisie par `Click=0@Bq` (seul journal TR hors 53 : `50-Banque`), PDF comparé par
  son texte (`CmdVis` → `pdftotext`, `edition.txt`), `FactcheminC` posé par `"conf"` (`{home}/pdfc`).
  T03 `bordereauxc_impression_seule/` (Non = Tab + Espace ; copie `pdfc/Bordereaux/2018/06/Bordereau12.pdf`
  comparée ; compteurs incrémentés, A04) ; T04 `bordereauxc_remise_complete/` (Oui, Message.Info ; écritures,
  collectif 411000, SHA-1, chèques supprimés) ; T06 `bordereauxc_lettrage/` (jeu `bordereauxc_lettrage` : lot F001
  soldé → `lettree = 1`, lot F003 non soldé → 0, chèque du client caisse 411027 → 0, A05) ; T07
  `bordereauxc_sans_code/` (jeu `bordereauxc_sans_code` : Message.Error puis Message.Info) ; T09 en deux scénarios :
  `bordereauxc_copie_vide/` (`FactcheminC` vide → Message.Warning « Copie impossible ») et
  `bordereauxc_copie_espace/` (`FactcheminC` = `~/a b` : `cp` sans guillemets échoue sans message, copie notée
  `<fichier absent>`, A07).

- **Génération des valeurs attendues** : clone **Laurux non modifié**, base MariaDB Docker restaurée
  avant chaque test, `faketime` à date fixe (date du bordereau, `DateChooser1`, titre du PDF),
  `/Soc01/caisse/CmdVis` = copie du PDF, `/Soc01/FactcheminC` vers un répertoire du test.
- **Données** : `Laurux01.sql` ne contient **aucune écriture** : base = jeu dérivé commun aux éditions
  comptables décrit dans [Balance/test.md](../Balance.class/test.md#détail-des-tests), complété par : `jeu_bordereaux.sql` : client caisse dans `Fiches_ClientCaisse`,
  clients 411 rattachés à un collectif (`coll_cc`), journal de banque `51` avec `cde_banque`,
  factures dont les lots soldent ou non les chèques, compteurs `numecriture`/`numecriture2` connus.
- **Ordre** : T04 et T06 dépendent des compteurs ; chaque test repart de la base restaurée.
- **Non testable automatiquement** : rendu visuel du PDF, menu contextuel au clic droit si le
  replay ne sait pas simuler `Mouse.Right` (à confirmer avec `ReplayObserver`).
