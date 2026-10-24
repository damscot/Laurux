# RecupDech — Tests

> Source : `.src/Compta/Utils/RecupDech.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| RECUPDECH-T01 | gbtest | Export nominal | `Laurux01.sql` + jeu dérivé (401/411 non collectifs avec et sans `dateech`, une échéance avec heure non nulle) | contenu de `~/tmp/Dtech.txt` de référence | `tests/recupdech_export/` | à faire |
| RECUPDECH-T02 | gbtest | Répertoire absent | `HOME` sans `tmp/` | erreur d'exécution figée | `tests/recupdech_sans_tmp/` | à faire |
| RECUPDECH-T03 | replay | Lancement par `Prgm` | saisie `RecupDech` | même fichier que T01 ; `Message.Info` ; dump inchangé | `tests/recupdech_prgm/` | à faire |
| RECUPDECH-T04 | gbtest | Variante SQLite | `Laurux01.sqlite` + même jeu | fichier de référence (traduction de `left()`) | `tests/recupdech_sqlite/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone **Laurux non modifié**, `HOME` isolé.
- La trace `Print` sur la sortie standard n'est pas comparée.
- Le formulaire (jamais affiché) n'est pas testable.
