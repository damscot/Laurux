# FRelCompte — Tests

> Source : `.src/Compta/Relances/FRelCompte.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Tests `replay` depuis le menu Relevés › De compte. Données : `Laurux01.sql` + jeu dérivé
(clients avec et sans `cli_rlvc`, fournisseurs, période couvrant plus de 50 écritures pour un compte,
un compte 411 sans fiche client). Comparaisons : dump de `Fiches_Relcomptes`, texte du PDF.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FRELCOMPTE-T01 | replay | Liste clients | période du mois, `RB3` | dump `Fiches_Relcomptes` ; lignes et totaux de la liste | `tests/liste_clients/` | implémenté |
| FRELCOMPTE-T02 | replay | Liste fournisseurs | même période, `RB4` | dump `Fiches_Relcomptes` (tous les fournisseurs) | `tests/liste_fournisseurs/` | implémenté |
| FRELCOMPTE-T03 | replay | Édition de tous les comptes | `RB1`, Éditer | texte PDF de référence, saut de page | `tests/edition_tous/` | implémenté |
| FRELCOMPTE-T04 | replay | Édition de la sélection | `RB2`, 2 comptes sélectionnés | texte PDF des 2 comptes seulement | `tests/edition_selection/` | à faire : sélection de comptes dans `CompteRel` non rejouable (ColumnView sans `CompteRel_Click`) |
| FRELCOMPTE-T05 | replay | Contrôle de période | début modifié au 15, fin au 10 ; fin = début | avertissement selon `dte1` initial (A02 figée) | `tests/controle_periode/` | implémenté |
| FRELCOMPTE-T06 | replay | Compte sans fiche tiers | écriture 411 sans `Fiches_Cli` | comportement actuel figé (erreur) | `tests/sans_fiche/` | implémenté |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone Laurux non modifié ; PDF comparé par
  `pdftotext -layout`, date du jour masquée.
- Les mêmes scénarios existent pour `FRelFacture` : les jeux de données sont partagés.
- Non testable automatiquement : l'aide (`Doc.Open`).
- **Implémentation (phase 2, vague 4)** : jeu partagé `.hidden/Tests/Compta/assets/frelcompte_shared/frel_base.sql`
  (411001/411002 avec `cli_rlvc`, 411003 sans ; 35 écritures 411002 pour le saut de page ; écritures 401 ;
  écriture hors période) et `frel_sans_fiche.sql` (411999/401999 sans fiche). Date figée 2018-06-15 (période
  par défaut 01.06.2018 → 15.06.2018). Scénarios `.hidden/Tests/Compta/assets/frelcompte_<nom>/` :
  T01 `liste_clients` (Button2), T02 `liste_fournisseurs` (RB4), T03 `edition_tous` (RB1 + Éditer, texte du PDF
  par `pdftotext` dans `edition.txt`), T05 `controle_periode` (début 15, fin 10 sans avertissement — A02 —,
  rafraîchir : table vide ; fin 01 : avertissement validé par Espace), T06 `sans_fiche` (erreur fatale
  `FRelcompte.MajTab.125: Result is not available`, `code_sortie` 125).
