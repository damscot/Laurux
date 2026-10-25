# Cclients — Tests

> Source : `.src/Reports/Cclients.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Gabarit de rendu PDF sans base : tests `gbtest` qui instancient `New Cclients(…)` en portrait
et en paysage (`"l"`), avec `SetCompression(False)`, appellent les méthodes avec des valeurs
fixes et comparent le texte `pdftotext -layout` et le flux non compressé (`/CreationDate`, date
et `User.Name` du pied masqués). Attendus produits dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CCLIENTS-T01 | gbtest | Liste des clients portrait : `Entete`, `Level1`, `Level2`, `Lines`, `BasPage` | 3 clients sur 2 pages | texte et flux de référence ; « Page 1/2 », « Page 2/2 » | `tests/cclients_clients/` | à faire |
| CCLIENTS-T02 | gbtest | Clients Sage : `Level2S` | `dom`/`codebanque`/`codeguichet` renseignés puis vides | même flux dans les deux cas (paramètres ignorés) | `tests/cclients_sage/` | à faire |
| CCLIENTS-T03 | gbtest | Fournisseurs paysage : `EnteteP`, `Level1F`, `Level2F`, `LinesP`, `BasPageP`, puis `BasPage` | 3 fournisseurs | flux de référence ; pied portrait décentré figé (EDFOUR-A01) | `tests/cclients_fournisseurs/` | à faire |
| CCLIENTS-T04 | replay | `Level2` à 12 arguments | scénario IMPJDV-T02 (création de clients) | erreur « Not enough arguments » figée (IMPJDV-A04 / CCLIENTS-A01) | `tests/cclients_impjdv/` | à faire |
| CCLIENTS-T05 | replay | Éditions réelles | scénarios EDCLIENT-T01, EDCLIENT-T03, EDFOUR-T05, IMPSAGE-T01 (voir leurs `test.md`) | texte PDF identique entre les deux clones ; dump identique | `tests/cclients_editions/` | à faire |

## Détail des tests

- **Génération des attendus** : module `.test` exécuté en phase 2 dans le clone non modifié.
- **Données** : aucune base pour T01 à T03 ; T04/T05 reprennent les fichiers d'import et les jeux
  des écrans appelants (`Laurux01.sql`, fichier JDV et fichier Sage de test), voir
  [ImpJdv/test.md](../../Compta/Utils/ImpJdv.class/test.md) et
  [EdClient/test.md](../../Gestion/Impressions/EdClient.class/test.md).
- **T04** : un appel à 12 arguments ne peut pas être écrit dans un module `.test` compilé sans
  reproduire l'erreur à la compilation ou à l'exécution ; il passe donc par le replay d'`ImpJdv`.
- **Couverture visée** : 100 % des méthodes.
