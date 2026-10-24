# Expcontact — Tests

> Source : `.src/Utils/Exports-Imports/Expcontact.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EXPCONTACT-T01 | replay | Export clients + contacts | `Laurux01.sql`, `RadioButton1` coché, `Button1` | `~/Contacts.vcf` identique à `expected/Contacts.vcf` | `tests/export_clients/` | à faire |
| EXPCONTACT-T02 | replay | Export fournisseurs | `RadioButton2` coché | `Contacts.vcf` de référence | `tests/export_fournisseurs/` | à faire |
| EXPCONTACT-T03 | replay | Table vide | base dérivée avec `Fiches_Four` vide, fournisseurs | figer : `Message.Error` puis erreur d'exécution sur `Close` | `tests/table_vide/` | à faire |
| EXPCONTACT-T04 | replay | Caractères spéciaux | client avec `;`, `,` et retour ligne dans `cli_obs` | fichier figé (pas d'échappement) | `tests/caracteres_speciaux/` | à faire |

## Détail des tests

- Scénarios capturés dans le clone **Laurux non modifié**, `HOME` pointant vers un répertoire de
  test pour isoler `~/Contacts.vcf`. Comparaison : fichier produit (la base n'est pas modifiée ;
  vérifier un diff BDD vide).
- Données : `Laurux01.sql` ; jeux dérivés générés par `gen_input.py` (T03, T04).
- T03 provoque une erreur d'exécution : à capturer tel quel (caractérisation), le runner doit
  tolérer la sortie en erreur.
