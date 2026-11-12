# Imp_Sig — Tests

> Source : `.src/Compta/Impressions/Imp_Sig.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Comme pour Imp_Bilan, les tests sont des replays de l'écran `RubImp` (bouton radio « SIG »,
Imprimer). Sorties comparées : texte du PDF `~/tmp/SIG.pdf` (`pdftotext -layout`, pied de page
normalisé : date et utilisateur) produit d'abord dans le clone Laurux non modifié, et dump de la
table de travail `centralisation`. Jeu dérivé de `Laurux01.sql` (49 rubriques `S` et leurs plages)
avec des écritures de classes 6 et 7 couvrant chaque rubrique, validées et non validées.
`Visualiseur.Prog` neutralisé.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| IMP_SIG-T01 | replay | SIG exercice courant | jeu dérivé, SIG, `E1` | PDF (texte normalisé) et dump `centralisation` identiques à la référence | `tests/sig_e1/` | implémenté (requêtes et dump centralisation ; PDF non comparé) |
| IMP_SIG-T02 | replay | Exercice antérieur et écritures non validées | `N2` (`Fiches_Mvt2`), écritures non validées incluses | idem ; montants incluant les non validées (A01 figée) | `tests/sig_n2/` | à faire : non traité (vague 3, temps) |
| IMP_SIG-T03 | replay | Signes : comptes 709 et 609, résultat exceptionnel négatif | 709 en dernière écriture d'une rubrique avec cumul positif ; 609 ; charges exceptionnelles > produits | PDF figé (le cas 709 à cumul négatif est joué à part : erreur figée, A02) | `tests/signes/` | à faire : sortie PDF non comparée |
| IMP_SIG-T04 | replay | Débordement de page | jeu avec un grand nombre de rubriques `L` actives | changement de colonne/page (`Lines3`, `Level0`) figé | `tests/pagination/` | à faire : sortie PDF non comparée |
| IMP_SIG-T05 | replay | Deux éditions successives | T01 puis T02 sans quitter | second PDF identique à T02 seul | `tests/editions_successives/` | à faire : sortie PDF non comparée |
| IMP_SIG-T06 | replay | Rien à imprimer | aucune rubrique `S` | `Message.Info`, pas de PDF | `tests/rien_a_imprimer/` | implémenté |
| IMP_SIG-T07 | gbtest | Chaîne des soldes (après IMP_SIG-004) | cumuls `TotP`/`TotA` fournis pour chaque entête | valeurs `marge`, `prodexo`, `Valajout`, `excexpl`, `resexpl`, `rescour`, `resexcept` identiques à T01 | `tests/chaine_soldes/` | à faire : extraction IMP_SIG-004 requise |

## Détail des tests

- **Valeurs attendues** : produites dans le clone Laurux non modifié, même jeu, même locale.
- **check_output.py** : extraction `pdftotext -layout`, normalisation du pied de page, diff texte ;
  dump trié de `centralisation`.
- **Non testable automatiquement** : mise en page graphique (colonnes, filets) au-delà du texte.
- **Implémentation (phase 2, vague 3)** : T01 → `.hidden/Tests/Compta/assets/imp_sig_sig_e1/` (jeu `extrait_shared/extrait_base`,
  table `centralisation` du dump : S0030 Ventes 707000 = 175) ; T06 → `imp_sig_rien_a_imprimer/` (jeu `imp_sig_sans_rubrique`,
  `SIG.pdf` absent). Rejeu par RubImp (Menu124), case `Sig`, `Button2`, boîte « traitement long » validée par Entrée.
