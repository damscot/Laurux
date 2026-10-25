# Tregion — Tests

> Source : `.src/Gestion/option/Tregion.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI instrumenté (`Utils.Observers(Me)` + observateurs `cmpt`) : replays capturés dans le
clone Laurux non modifié ; le dump normalisé de `Fiches_region` fait foi.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| TREGION-T01 | replay | Création d'une nouvelle région (intitulé) | jeu `tipp_base` ; Création → code `R9` → (message « premier code région… ») → libellé → Valider | 1 ligne `(R9, '0')` | `tests/creation_region/` | à faire |
| TREGION-T02 | replay | Ajout d'un taux article à une région | Création → `R1` → article existant → taux → Valider | 1 ligne `(R1, art)` avec le taux | `tests/creation_taux/` | à faire |
| TREGION-T03 | replay | Refus : couple existant, article inconnu | Création → `R1` + article déjà présent → Valider ; article inexistant | aucune ligne ajoutée ; ballons | `tests/creation_refusee/` | à faire |
| TREGION-T04 | replay | Modification d'un taux (A03) | naviguer jusqu'à la 2e ligne de `R1` → Modification → taux → Valider | figer la ligne réellement modifiée (première ligne de `R1` attendue d'après le code) | `tests/modification_taux/` | à faire |
| TREGION-T05 | replay | Annulation | Création → saisie → Annuler ; Modification → Annuler | dump identique | `tests/annulation/` | à faire |
| TREGION-T06 | replay | Suppression (A04) | Suppression → Valider | dump identique | `tests/suppression/` | à faire |
| TREGION-T07 | replay | Fermeture en saisie : « Non » (A02) puis « Oui » (A01) | deux scénarios | figer transaction ouverte / erreur « Not enough arguments » | `tests/fermeture/` | à faire |
| TREGION-T08 | replay | Navigation | premier, suivant, précédent, dernier | lignes `Exec_SQL` identiques (lectures `Fiches_Art`) | `tests/navigation/` | à faire |

## Détail des tests

- **Jeu `tipp_base`** : `Laurux01.sql`, puis activation de l'option carburant dans le clone non
  modifié (Préférences → case `pp`, qui exécute `modfichier.fichiercarbu` et crée `Fiches_region`,
  `Fiches_tarpp`, `Art_Tipp`…), puis insertion de deux régions : `R1` (intitulé + 2 articles) et
  `R2` (intitulé seul). Le dump de référence est pris après cette préparation. Jeu partagé avec
  [rechtipp](../rechtipp.class/test.md) et [Edittipp](../Edittipp.class/test.md).
- **T04** est le test de caractérisation de TREGION-A03 : il doit montrer quelle ligne est
  modifiée quand la région a plusieurs lignes.
- **T07** : voir les remarques de [Ttourne](../Ttourne.class/test.md) (T07/T08) sur l'observation
  de la transaction ouverte et des erreurs d'exécution.
- La table étant absente de `db_control.csv`, `DB_Sanity` la signalera comme inconnue : à
  exclure de la comparaison de structure dans le runner.
