# Echeancier — Tests

> Source : `.src/Compta/Impressions/Echeancier.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran d'édition sans écriture en base. Résultat : `~/tmp/Echeancier.pdf`, comparé après
`pdftotext -layout` et normalisation (date et utilisateur du pied de page) ; lignes `Exec_SQL` du
log en complément.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| ECHEANCIER-T01 | replay | Ouverture | `Fiches_Parametres` de test | `Dten0` = clôture N, `Dten1` = clôture N-1 ; combo `Eche` = « Tous » + modes | `tests/ouverture/` | implémenté (requêtes seules : valeurs affichées non comparées) |
| ECHEANCIER-T02 | replay | Clients, tri échéance, « Tous » | jeu échéances ; « Imprimer » | texte normalisé : ruptures « Total échéance », règlements du lot, total général | `tests/clients_echeance/` | implémenté |
| ECHEANCIER-T03 | replay | Clients, tri échéance, mode choisi | `Eche` = un mode de règlement | seules les factures des clients de ce mode | `tests/clients_mode/` | implémenté |
| ECHEANCIER-T04 | replay | Clients, tri compte, mode choisi | `TpCompte` + mode | toutes les factures (filtre ignoré, A03 figée) ; ruptures « Total compte » | `tests/clients_compte/` | implémenté |
| ECHEANCIER-T05 | replay | Fournisseurs | `Rfour`, tri échéance puis compte | signes inversés côté débit ; filtre de mode ignoré | `tests/fournisseurs/` | implémenté (tri échéance seul) |
| ECHEANCIER-T06 | replay | Multipage | > 60 échéances dont un lot avec 10 règlements en bas de page | en-têtes répétés ; règlements débordant la page (A04 figée) | `tests/multipage/` | implémenté |
| ECHEANCIER-T07 | replay | Règlement négatif | règlement client au débit négatif | comportement figé (erreur de conversion ou montant, A01) | `tests/reglement_negatif/` | implémenté |
| ECHEANCIER-T08 | replay | Saisie des dates | « 3112 » + Entrée dans `Dten0` ; double-clic + calendrier dans `Dten1` | dates normalisées ; calendrier masqué après choix | `tests/saisie_dates/` | à faire : double-clic et DateChooser non rejoués ; dates saisies non visibles dans le PDF (dateedition jamais renseignée) |
| ECHEANCIER-T09 | gbtest | `Montant_Signe` (après ECHEANCIER-007) | matrice client/fournisseur × débit/crédit × facture/règlement × signe | valeurs produites par le clone non modifié | `tests/montant_signe/` | à faire : après extraction ECHEANCIER-007 (Montant_Signe) |
| ECHEANCIER-T10 | replay | SQLite | T02 sur `Laurux01.sqlite` + jeu | même texte que MySQL (`left()` traduit par `DB_Connection`) | `tests/sqlite/` | à faire : runner sans base SQLite |

## Détail des tests

- **Génération des valeurs attendues** : clone **Laurux non modifié**, `faketime` à date fixe,
  `/Soc01/caisse/CmdVis` = commande de copie du PDF ; rejeu sur les deux clones et comparaison
  des textes normalisés.
- **Données** : `Laurux01.sql` ne contient **aucune écriture** : base = jeu dérivé commun aux éditions
  comptables décrit dans [Balance/test.md](../Balance.class/test.md#détail-des-tests), complété par : `jeu_echeances.sql` : factures 411/401 validées non lettrées avec
  `dateech` réparties sur l'exercice, lots avec règlements (`tresorerie = 1`) sur le même compte,
  clients de deux modes (`cli_reg`), une ligne collective (exclue), une ligne lettrée (exclue).
- **Non testable automatiquement** : rendu graphique, son, aide.

## Implémentation (phase 2, vague 4)

- Jeu partagé `.hidden/Tests/Compta/assets/echeancier_shared/echeancier_ech.sql` (factures 411001/411002/401001/401002,
  règlements de lot, `cli_reg` 05/20, ligne lettrée et ligne collective exclues) ; jeux propres
  `echeancier_multipage/echeancier_multi.sql` (65 factures 411005, lot n° 22 à 10 règlements) et
  `echeancier_reglement_negatif/echeancier_neg.sql`.
- Scénarios `echeancier_<nom>` ; PDF converti par `pdftotext -layout` via `/Soc01/caisse/CmdVis` dans
  `~/echeancier_pdf.txt` (clé `fichiers`), sql.log ordonné (lecture seule).
- Constats figés : T06 produit 6 pages dont 3 sans contenu, le pied de page n'apparaît que sur la dernière,
  les règlements du lot 22 débordent le bas de la page 1 ; T07 affiche -30 et -20 sous une facture de 150 mais
  « Total échéance » 130 (le débit négatif n'est pas soustrait).
