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
| HISTOVMO-T01 | replay | Historique par défaut | `statistiques_ventes`, `/Soc01/Materiel = 0` ; **Imprimer** | texte PDF (une ligne par MO vendue, qté, total HT) ; factures historisées + factures `F` en cours, `Bl` coché | `tests/histovmo_defaut/` | à faire |
| HISTOVMO-T02 | replay | Les 4 tris | `RadioButton2`, `3`, `4` successivement, plage fournisseur restreinte | ordre des lignes ; plage fournisseur ignorée hors tri par code (A03 figée) | `tests/histovmo_tris/` | à faire |
| HISTOVMO-T03 | replay | Sources matériel | `/Soc01/Materiel = 1` ; `Face` puis `Fact` | lignes `…M` seules puis union ; lignes MO matériel en cours exclues en `Fact` (A02 figée) | `tests/histovmo_materiel/` | à faire |
| HISTOVMO-T04 | replay | Case `Bl` | `Bl` coché puis décoché, BL `B` et factures `F` en cours dans et hors période | requête `… type = 'B' or type = 'F'` figée (A01) ; sans `Bl`, factures `F` seules | `tests/histovmo_bl/` | à faire |
| HISTOVMO-T05 | replay | Listes de choix | F2 (ou bouton) sur chaque zone, clic sur une ligne ; Échap sur `Colfam2`/`Colfour2` | zones remplies, focus (anomalie de focus A05 figée) | `tests/histovmo_listes/` | à faire |
| HISTOVMO-T06 | replay | Aucune MO | plage MO `ZZZZY`–`ZZZZZ` | message « Aucune MO pour cette demande », pas de PDF | `tests/histovmo_vide/` | à faire |
| HISTOVMO-T07 | replay | Saisie des dates | `dteN0` = `0101`, `dteN1` antérieure (Entrée) | dates normalisées ; avertissement | `tests/histovmo_dates/` | à faire |
| HISTOVMO-T08 | replay | Touche sur le bouton Imprimer | focus sur **Imprimer** puis Tab, puis Espace | une impression sur Tab ; Espace : deux impressions (A04, à observer au rejeu) | `tests/histovmo_touche_imprimer/` | à faire |
| HISTOVMO-T09 | gbtest | Cumul des ventes (après HISTOVMO-007) | `VentesMo(…)` sur le jeu de T01, T03, T04 | collection code → (qté, pvht) identique au PDF de T01/T03/T04 | `tests/histovmo_ventes/` | à faire |

## Détail des tests

- **Données** : `statistiques_ventes` (voir [`TBord/test.md`](../TBord.class/test.md)) : 3 mains-d'oeuvre
  (familles et fournisseurs différents), lignes `typel = 'M'` dans les 4 tables de lignes, une ligne à
  quantité nulle, un BL `B` et une facture `F` en cours hors période (révèle A01), une ligne `LigblM`
  d'article dont le code égale celui d'une MO (révèle A02).
- **Paramètres** : `/Soc01/Materiel` fixé par test dans le `Laurux.conf` ; horloge fixée.
- **Non testable automatiquement** : son, couleur du champ actif, aide `Doc.Open` (F1).
- **Couverture visée** : toutes les branches de `Button2_Click` ; `Level1`/`Level2` exclus (code mort).
