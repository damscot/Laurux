# Site — Tests

> Source : `.src/Gestion/Site.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| SITE-T01 | gbtest | Compilation sans le module | suppression de `Site.module` | `gbc3 -agt` sans erreur ; `Fsoc` compile toujours (contrôle `Site` du formulaire) | `tests/suppression/` | à faire |
| SITE-T02 | replay | Écran Société, champ « Site » | `Fsoc` : ouvrir une société, naviguer jusqu'au champ `Site` (touche qui déclenche `Case 17`), saisir une URL, enregistrer | dump de `Fiches_Societes` identique au clone de référence | `tests/fsoc_champ_site/` | à faire |

## Détail des tests

- `connect_site` n'a aucun effet observable (connexion jamais ouverte) : aucun test fonctionnel
  n'est possible. T01 garantit que la suppression ne casse pas la compilation ; T02 vérifie que le
  contrôle homonyme `Site` de `Fsoc` continue de fonctionner (résolution de nom après suppression).
- Valeurs attendues de T02 produites dans le clone **Laurux non modifié** à partir de
  `Laurux01.sql`.
