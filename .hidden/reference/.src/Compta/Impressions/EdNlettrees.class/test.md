# EdNlettrees — Tests

> Source : `.src/Compta/Impressions/EdNlettrees.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran d'édition sans écriture en base. Résultat : `~/tmp/Enlettrees.pdf` comparé après
`pdftotext -layout` et normalisation (date d'édition et utilisateur du pied de page ; les bornes
« du … au … » sont fixées par `faketime`) ; lignes `Exec_SQL` du log en complément.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EDNLETTREES-T01 | replay | Ouverture | `faketime`, `Fiches_Parametres` de test | `DteN0` = début de l'exercice, `Dten1` = aujourd'hui, plage clients | `tests/ouverture/` | implémenté (requête Fiches_Parametres ; dates affichées non comparées) |
| EDNLETTREES-T02 | replay | Clients, exercice en cours | jeu non lettré ; « Imprimer » | texte normalisé : comptes, lignes, soldes progressifs, totaux | `tests/clients/` | implémenté (requêtes comptes lettrables et Listextcpt bornées 01.01.2018-15.06.2018, ouverture du PDF ; texte PDF non comparé) |
| EDNLETTREES-T03 | replay | Fournisseurs et bilan | `Bfournisseur` puis `Bbilan` | texte normalisé ; plages par défaut | `tests/fournisseurs_bilan/` | implémenté (requêtes types F et B, deux PDF ouverts ; texte non comparé) |
| EDNLETTREES-T04 | replay | Type de clients | sélection d'un type dans `TypeClient1` | seuls les clients du type (`cli_typec IN (…)`) | `tests/type_client/` | à faire : sélection dans TypeClient1 (TreeView) non rejouable |
| EDNLETTREES-T05 | replay | Multi-exercices | `DteN0` dans l'exercice N-1 (écritures en `Fiches_Mvt1`) | lignes des deux exercices, journal d'à-nouveaux exclu | `tests/multi_exercices/` | implémenté (Listextcpt borné au 01.06.2017, lecture Fiches_Mvt1 ; exclusion des à-nouveaux visible dans le PDF seulement) |
| EDNLETTREES-T06 | replay | Compte centralisateur | compte `cent_cc = 1` avec écritures | en-tête du compte et total à 0, aucune ligne (A02 figée) | `tests/centralisateur/` | à faire : sortie PDF non comparée (411003 centralisateur présent dans ednl_lettrage) |
| EDNLETTREES-T07 | replay | Sélection par `TriCpt` | F2 sur `Cpt`, choix d'un compte | `Cpt` renseigné (`Bsel`/`Bval`) | `tests/tricpt/` | à faire : touche F2 non rejouée |
| EDNLETTREES-T08 | replay | Aucune écriture / aucun compte | plage sans compte ; plage avec comptes tous lettrés | message « Aucune ecriture » ; puis PDF sans ligne (A03 figée) | `tests/vide/` | implémenté (cas « plage sans compte » ; cas « tous lettrés » : PDF non comparé) |
| EDNLETTREES-T09 | replay | Multipage | > 60 lignes | en-têtes répétés, pied de page sur la dernière page | `tests/multipage/` | à faire : sortie PDF non comparée (en-têtes répétés) |
| EDNLETTREES-T10 | gbtest | `Lignes_Compte` (après EDNLETTREES-006) | compte, bornes, centralisateur oui/non | lignes et totaux identiques à T02/T06 | `tests/lignes_compte/` | à faire : extraction EDNLETTREES-006 non réalisée |
| EDNLETTREES-T11 | replay | SQLite | T02 sur `Laurux01.sqlite` | même texte que MySQL (`lettrable <> false` accepté par SQLite ≥ 3.23, à vérifier) | `tests/sqlite/` | à faire : rejeu SQLite non outillé par le runner (base MariaDB seule) |

## Détail des tests

- **Génération des valeurs attendues** : clone **Laurux non modifié**, `faketime` à date fixe,
  `/Soc01/caisse/CmdVis` = copie du PDF ; rejeu sur les deux clones.
- **Données** : `Laurux01.sql` ne contient **aucune écriture** : base = jeu dérivé commun aux éditions
  comptables décrit dans [Balance/test.md](../Balance.class/test.md#détail-des-tests), complété par : `jeu_lettrage.sql` : comptes 411/401/bilan lettrables et non
  lettrables, types de clients, écritures non lettrées sur deux exercices (`Fiches_Mvt` et
  `Fiches_Mvt1`), écritures du journal d'à-nouveaux, un compte centralisateur.
- **Partage** : le jeu est réutilisable par EDNJUSTIFIEES et EDIMPAYES.
- **`TypeClient`** (`Inherits TreeView`) : `ReplayObserver` reconnaît les contrôles par le nom exact
  de leur classe et ne rejoue probablement pas la sélection dans `TypeClient1` : T04 est à valider
  en début de phase 2 (sinon scénario manuel, ou test `gbtest` de `Comptes_Plage` avec le fragment
  `where` passé en paramètre).
- **Non testable automatiquement** : son, aide, rendu graphique.

- **Phase 2 (agent 3, vague 3)** : scénarios `.hidden/Tests/Compta/assets/ednlettrees_<nom>/` (`ouverture`,
  `clients`, `fournisseurs_bilan`, `multi_exercices`, `vide`), jeu partagé `ednlettrees_shared/ednl_lettrage.sql`
  (comptes lettrables, 411003 centralisateur, Fiches_Mvt 2018 dont à-nouveaux jour 90, Fiches_Mvt1 2017).
  Ouverture du PDF vérifiée par `@ouvrir.trace` ; texte du PDF non comparé.
