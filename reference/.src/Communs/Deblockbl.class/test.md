# Deblockbl — Tests

> Source : `.src/Communs/Deblockbl.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Scénarios lancés depuis `Prgm` (nom `Deblockbl`) ; on compare le dump de `Fiches_Docactif` et les
messages affichés.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| DEBLOCKBL-T01 | replay | Numéro inconnu | numéro absent de `Fiches_Bl` | « Ce numéro de document n'existe pas ! », dump inchangé | `tests/inconnu/` | à faire |
| DEBLOCKBL-T02 | replay | Numéro existant verrouillé | `Laurux01.sql` + verrou dans `Fiches_Docactif` sur un BL existant | comportement actuel figé (erreur SQL attendue, verrou conservé, A01) | `tests/existant/` | à faire |
| DEBLOCKBL-T03 | replay | Champ vide | « Débloquer » sans saisie | aucun effet | `tests/vide/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone Laurux non modifié (MariaDB).
- T02 fige l'anomalie A01 ; il sera mis à jour si la correction est validée.
