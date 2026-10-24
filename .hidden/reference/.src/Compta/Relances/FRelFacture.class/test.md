# FRelFacture — Tests

> Source : `.src/Compta/Relances/FRelFacture.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Tests `replay` depuis le menu Relevés › De facture. Données partagées avec `FRelCompte`, plus :
écritures de journaux `VE` et `AC`, écritures de trésorerie et lettrées (exclues), deux lignes d'un
même compte dans une même écriture (doublon de clé), un client sans `cli_rlvf`. Comparaisons : dump
de `Fiches_RelFacture`, texte du PDF.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FRELFACTURE-T01 | replay | Liste clients | période, `RB3` | dump `Fiches_RelFacture` (journaux VE, `cli_rlvf`, doublon ignoré) | `tests/liste_clients/` | à faire |
| FRELFACTURE-T02 | replay | Liste fournisseurs | période, `RB4` | dump (journaux AC) ; erreur figée en cas de doublon | `tests/liste_fournisseurs/` | à faire |
| FRELFACTURE-T03 | replay | Édition de tous les comptes | `RB1`, Éditer | texte PDF : dates de ligne (A01 figée), solde en lettres | `tests/edition_tous/` | à faire |
| FRELFACTURE-T04 | replay | Édition de la sélection, solde négatif | `RB2`, un compte créditeur | texte PDF « - … » | `tests/edition_selection/` | à faire |
| FRELFACTURE-T05 | replay | Contrôle de période | comme FRELCOMPTE-T05 | avertissement (A02 de `FRelCompte` figée) | `tests/controle_periode/` | à faire |
| FRELFACTURE-T06 | gbtest | Conversion de date de ligne | `CStr` + découpage sur dates à 00:00 locales (été, hiver) | chaînes de référence produites par le code actuel | `tests/date_ligne/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone Laurux non modifié (MariaDB), fuseau horaire du
  poste fixé (`TZ=Europe/Paris`) : le résultat de A01 dépend du fuseau.
- T06 teste l'expression isolée (la fonction n'est pas publique) : il sert de caractérisation de
  l'anomalie A01 et devient obsolète après correction.
