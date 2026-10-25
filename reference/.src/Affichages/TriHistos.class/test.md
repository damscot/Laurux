# TriHistos — Tests

> Source : `.src/Affichages/TriHistos.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran de consultation ouvert depuis `Articles`. En ventes, il **écrit** dans la base (table de travail
`Fiches_Stat` recréée) : le dump normalisé de `Fiches_Stat` est la référence principale. En achats,
seule la grille change : comparaison des lignes `Exec_SQL` et, après instrumentation, du contenu
affiché.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| TRIHISTOS-T01 | replay | Historique des ventes d'un article | `Articles` : article vendu (BL en cours, BL facturé, facture archivée, sortie exceptionnelle), bouton ventes | contenu de `Fiches_Stat` (dump) ; `Qte_totale` | `tests/histo_ventes/` | à faire |
| TRIHISTOS-T02 | replay | Changement de période et tri | `ComboBox1` 1 → 3 ans ; focus `COD`, `NM`, `NFAC`, double-clic `DA` | `Fiches_Stat` recréée ; ordre des lignes de référence | `tests/periode_tri/` | à faire |
| TRIHISTOS-T03 | replay | Détail d'un document de vente | clic sur une ligne de facture archivée puis sur une ligne de BL ; fermeture du panneau | lignes de détail ; figer la quantité non formatée de la branche facture (A05) | `tests/detail_vente/` | à faire |
| TRIHISTOS-T04 | replay | Historique des achats | `Articles` : article reçu de deux fournisseurs, entrée exceptionnelle ; bouton achats ; tri `NM` | grille de référence ; figer l'absence des réceptions par référence fournisseur (A01) | `tests/histo_achats/` | à faire |
| TRIHISTOS-T05 | replay | Détail d'une réception et fournisseur supprimé | clic sur une réception ; puis réception d'un fournisseur absent de `Fiches_Four` | détail de référence ; figer l'erreur (A02) | `tests/detail_achat/` | à faire |
| TRIHISTOS-T06 | gbtest | `ConstruireStatVentes` (après TRIHISTOS-007) | code article, date de début ; base MySQL puis SQLite | contenu de `Fiches_Stat` identique au clone non modifié ; figer l'écart SQLite (A03) | `tests/stat_ventes/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone **Laurux non modifié** ; A01, A02, A03, A05 figées.
- **Horloge** : `Dtejour` dépend de `Now` : fixer la date (faketime) entre capture et rejeu.
- **Données** : jeu dérivé `histo_article` : un article à 2 et un à 3 décimales ; BL en cours (types B
  et F, `imp` 0 et 1), factures archivées (`Fiches_HistoFac`/`HistoLigfac`) avec ligne commentaire
  multi-ligne, mouvements `Fiches_Mvtexp` (`qtem`, `qtep`), réceptions `Fiches_Ligrecpt` de deux
  fournisseurs dont un supprimé.
- **Instrumentation** : pas de `Utils.Observers(Me)` → T01 à T05 non rejouables tant que l'écran
  n'est pas instrumenté dans les deux clones (décision de phase 2). `Colrcp2`/`Colrcp3` n'ont pas de
  `_Click` (`replay_missing`) : ne pas cliquer dans les panneaux de détail.
- **Rejeu** : `Colhisto_click` doit rester `Public` (`Object.Call`).
- **Multi-poste** (A04) : non testable par replay mono-poste ; documenté seulement.
