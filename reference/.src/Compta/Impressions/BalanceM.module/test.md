# BalanceM — Tests

> Source : `.src/Compta/Impressions/BalanceM.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

`Imprime` écrit un PDF et manipule le formulaire `Balance` : les tests sont des `replay` lancés depuis
l'écran `Balance` (menu Comptabilité > Impressions > Balances, dates et comptes saisis, **Imprimer**).
Le PDF `~/tmp/Balance.pdf` est capturé (script déclaré dans `/Soc01/caisse/CmdVis`), converti par
`pdftotext -layout`, puis normalisé (date d'édition `jj/mm/aaaa` et utilisateur du pied de page). Les
valeurs attendues sont produites dans le clone **Laurux non modifié**, anomalies comprises.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| BALANCEM-T01 | replay | Balance client sans cumuls | `Bclient`, 41100001 → 99999999, période de l'exercice courant, `Impcumul` et `Impc` décochés | texte PDF de référence (`Level1a`/`Level2a`, total « Client ») | `tests/client_simple/` | à faire |
| BALANCEM-T02 | replay | Balance client avec cumuls hors période | même plage, période d'un trimestre, `Impcumul` coché | colonnes hors période incluant les écritures **postérieures** (A02 figée) | `tests/client_cumuls/` | à faire |
| BALANCEM-T03 | replay | Balance générale, ruptures de classe | `Bgestion`, 10000 → 99999999, `Impcumul` coché | totaux par classe (1 à 7), total balance, comptes collectifs inclus | `tests/generale_classes/` | à faire |
| BALANCEM-T04 | replay | Saut de page | balance générale sur un jeu de plus de 60 comptes mouvementés | pages 2+ titrées « Impression des balances » ; page sans pied si rupture de classe au-delà de 274 mm (A03 figée) | `tests/saut_page/` | à faire |
| BALANCEM-T05 | replay | Comptes non mouvementés | balance fournisseur avec un compte sans écriture, `Impc` coché puis décoché | compte imprimé avec montants vides / absent | `tests/non_mouvementes/` | à faire |
| BALANCEM-T06 | replay | Filtre par type de client | `Bclient`, sélection de 1 puis 2 types dans `TypeClient1` ; puis `Bfournisseur` avec une sélection restée active | seuls les clients des types choisis ; filtre ignoré en fournisseur | `tests/type_client/` | à faire |
| BALANCEM-T07 | replay | Exercice archivé | `N1` (table `Fiches_Mvt1`), période par défaut | balance de l'exercice N-1 | `tests/exercice_n1/` | à faire |
| BALANCEM-T08 | replay | Aucun compte | plage sans compte du type demandé | message « Aucune ecriture pour cette demande », pas de PDF | `tests/aucun_compte/` | à faire |
| BALANCEM-T09 | replay | Deux impressions successives | T01 puis T03 sans fermer l'écran | second PDF identique à T03 seul (état de module remis à zéro) | `tests/impressions_successives/` | à faire |
| BALANCEM-T10 | replay | Soldes nuls et arrondis | compte soldé à 0, compte à 0,005 € de différence | affichage des montants vides / `0,00` / `-0,00` | `tests/soldes_nuls/` | à faire |

## Détail des tests

- **Données** : jeu dérivé commun aux éditions comptables (voir [Balance](../Balance.class/test.md)) :
  `Laurux01.sql` + écritures validées et non validées dans `Fiches_Mvt` et `Fiches_Mvt1`, clients typés
  (`cli_typec`), un compte collectif, comptes de toutes les classes, un compte soldé, des écritures avant,
  pendant et **après** la période testée (pour A02).
- **Normalisation** : `pdftotext -layout`, remplacement de la date d'édition et du nom d'utilisateur du
  pied de page ; le nombre de pages `{nb}` est conservé.
- **Base** : lecture seule ; le dump est comparé avant/après (doit être identique).
- **T09** vérifie que l'état des variables de module ne fuit pas d'une impression à l'autre ; il
  protège les reworks qui remplacent ces variables par des locales.
- **Non testable automatiquement** : curseur `Balance.Mouse`, son, ouverture effective du visualiseur.
