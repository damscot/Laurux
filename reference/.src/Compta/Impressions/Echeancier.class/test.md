# Echeancier — Tests

> Source : `.src/Compta/Impressions/Echeancier.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran d'édition sans écriture en base. Résultat : `~/tmp/Echeancier.pdf`, comparé après
`pdftotext -layout` et normalisation (date et utilisateur du pied de page) ; lignes `Exec_SQL` du
log en complément.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| ECHEANCIER-T01 | replay | Ouverture | `Fiches_Parametres` de test | `Dten0` = clôture N, `Dten1` = clôture N-1 ; combo `Eche` = « Tous » + modes | `tests/ouverture/` | à faire |
| ECHEANCIER-T02 | replay | Clients, tri échéance, « Tous » | jeu échéances ; « Imprimer » | texte normalisé : ruptures « Total échéance », règlements du lot, total général | `tests/clients_echeance/` | à faire |
| ECHEANCIER-T03 | replay | Clients, tri échéance, mode choisi | `Eche` = un mode de règlement | seules les factures des clients de ce mode | `tests/clients_mode/` | à faire |
| ECHEANCIER-T04 | replay | Clients, tri compte, mode choisi | `TpCompte` + mode | toutes les factures (filtre ignoré, A03 figée) ; ruptures « Total compte » | `tests/clients_compte/` | à faire |
| ECHEANCIER-T05 | replay | Fournisseurs | `Rfour`, tri échéance puis compte | signes inversés côté débit ; filtre de mode ignoré | `tests/fournisseurs/` | à faire |
| ECHEANCIER-T06 | replay | Multipage | > 60 échéances dont un lot avec 10 règlements en bas de page | en-têtes répétés ; règlements débordant la page (A04 figée) | `tests/multipage/` | à faire |
| ECHEANCIER-T07 | replay | Règlement négatif | règlement client au débit négatif | comportement figé (erreur de conversion ou montant, A01) | `tests/reglement_negatif/` | à faire |
| ECHEANCIER-T08 | replay | Saisie des dates | « 3112 » + Entrée dans `Dten0` ; double-clic + calendrier dans `Dten1` | dates normalisées ; calendrier masqué après choix | `tests/saisie_dates/` | à faire |
| ECHEANCIER-T09 | gbtest | `Montant_Signe` (après ECHEANCIER-007) | matrice client/fournisseur × débit/crédit × facture/règlement × signe | valeurs produites par le clone non modifié | `tests/montant_signe/` | à faire |
| ECHEANCIER-T10 | replay | SQLite | T02 sur `Laurux01.sqlite` + jeu | même texte que MySQL (`left()` traduit par `DB_Connection`) | `tests/sqlite/` | à faire |

## Détail des tests

- **Génération des valeurs attendues** : clone **Laurux non modifié**, `faketime` à date fixe,
  `/Soc01/caisse/CmdVis` = commande de copie du PDF ; rejeu sur les deux clones et comparaison
  des textes normalisés.
- **Données** : `Laurux01.sql` ne contient **aucune écriture** : base = jeu dérivé commun aux éditions
  comptables décrit dans [Balance/test.md](../Balance.class/test.md#détail-des-tests), complété par : `jeu_echeances.sql` : factures 411/401 validées non lettrées avec
  `dateech` réparties sur l'exercice, lots avec règlements (`tresorerie = 1`) sur le même compte,
  clients de deux modes (`cli_reg`), une ligne collective (exclue), une ligne lettrée (exclue).
- **Non testable automatiquement** : rendu graphique, son, aide.
