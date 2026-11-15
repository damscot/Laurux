# Histovmo — Tests

> Source : `.src/Statistiques/Histovmo.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran d'édition en lecture seule : tests `replay` lancés depuis le menu (Statistiques > Historique des
ventes de MO). Le PDF `~/tmp/HistoArt.pdf` est capturé par le script de `/Soc01/caisse/CmdVis`,
converti par `pdftotext -layout` puis normalisé (période et date du pied de page). On compare ce texte
et les lignes `Exec_SQL` du log ; le dump doit être identique avant et après. Les valeurs attendues
sont produites dans le clone **Laurux non modifié** (anomalies comprises).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| HISTOVMO-T01 | replay | Historique par défaut | `statistiques_ventes`, `/Soc01/Materiel = 0` ; **Imprimer** | texte PDF (une ligne par MO vendue, qté, total HT) ; factures historisées + factures `F` en cours, `Bl` coché | `tests/histovmo_defaut/` | implémenté (`Statistiques/histovmo_defaut`) |
| HISTOVMO-T02 | replay | Les 4 tris | `RadioButton2`, `3`, `4` successivement, plage fournisseur restreinte | ordre des lignes ; plage fournisseur ignorée hors tri par code (A03 figée) | `tests/histovmo_tris/` | implémenté partiel (`Statistiques/histovmo_tris` : 3 tris, texte du dernier PDF) ; à faire : plage fournisseur restreinte (A03) |
| HISTOVMO-T03 | replay | Sources matériel | `/Soc01/Materiel = 1` ; `Face` puis `Fact` | lignes `…M` seules puis union ; lignes MO matériel en cours exclues en `Fact` (A02 figée) | `tests/histovmo_materiel/` | implémenté (`Statistiques/histovmo_materiel` : Fact puis Face, jeu `histovmo_shared/ventes_mo_materiel`, A02 visible dans sql.log) |
| HISTOVMO-T04 | replay | Case `Bl` | `Bl` coché puis décoché, BL `B` et factures `F` en cours dans et hors période | requête `… type = 'B' or type = 'F'` figée (A01) ; sans `Bl`, factures `F` seules | `tests/histovmo_bl/` | implémenté (`Statistiques/histovmo_bl` : Bl décoché ; Bl coché et A01 dans histovmo_defaut) |
| HISTOVMO-T05 | gbtest | Listes de choix | F2 (ou bouton) sur chaque zone, clic sur une ligne ; Échap sur `Colfam2`/`Colfour2` | zones remplies, focus (anomalie de focus A05 figée) | `tests/histovmo_listes/` | implémenté partiel (gb.test `HistovmoTest.T05Listes` : ouverture des 6 listes par ToggleButton*_Click, choix d'une ligne par Col*_Click, refermeture par le bouton) ; à faire : F2/Échap (Col*_KeyPress lit Key) et anomalie de focus A05 |
| HISTOVMO-T06 | replay | Aucune MO | plage MO `ZZZZY`–`ZZZZZ` | message « Aucune MO pour cette demande », pas de PDF | `tests/histovmo_vide/` | implémenté (`Statistiques/histovmo_vide`) |
| HISTOVMO-T07 | replay | Saisie des dates | `dteN0` = `0101`, `dteN1` antérieure (Entrée) | dates normalisées ; avertissement | `tests/histovmo_dates/` | implémenté (`Statistiques/histovmo_dates` : avertissement ouvert par dte_KeyPress (Entrée), rejouable ; dates « 0103 »/« 3006 » normalisées, titre du PDF) |
| HISTOVMO-T08 | replay | Touche sur le bouton Imprimer | focus sur **Imprimer** puis Tab, puis Espace | une impression sur Tab ; Espace : deux impressions (A04, à observer au rejeu) | `tests/histovmo_touche_imprimer/` | implémenté (`Statistiques/histovmo_touche_imprimer` : Tab sur Imprimer = 1 impression, Espace = 2 impressions (A04 confirmée), 3 éditions dans edition.txt) |
| HISTOVMO-T09 | gbtest | Cumul des ventes (après HISTOVMO-007) | `VentesMo(…)` sur le jeu de T01, T03, T04 | collection code → (qté, pvht) identique au PDF de T01/T03/T04 | `tests/histovmo_ventes/` | à faire : exige l’extraction HISTOVMO-007 |

## Détail des tests

- **Données** : `statistiques_ventes` (voir [`TBord/test.md`](../TBord.class/test.md)) : 3 mains-d'oeuvre
  (familles et fournisseurs différents), lignes `typel = 'M'` dans les 4 tables de lignes, une ligne à
  quantité nulle, un BL `B` et une facture `F` en cours hors période (révèle A01), une ligne `LigblM`
  d'article dont le code égale celui d'une MO (révèle A02).
- **Paramètres** : `/Soc01/Materiel` fixé par test dans le `Laurux.conf` ; horloge fixée.
- **Non testable automatiquement** : son, couleur du champ actif, aide `Doc.Open` (F1).
- **Couverture visée** : toutes les branches de `Button2_Click` ; `Level1`/`Level2` exclus (code mort).
- **Jeu de données (phase 2)** : `.hidden/Tests/Statistiques/assets/histovmo_shared/ventes_mo.sql` (lignes MO en factures historisées 2017/2018, BL `F` et `B` en cours) ; `"conf": {"/Soc01/Materiel": 0}` ; scénarios `.hidden/Tests/Statistiques/assets/histovmo_*/`.
