# RecupDech — Tests

> Source : `.src/Compta/Utils/RecupDech.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| RECUPDECH-T01 | gbtest | Export nominal | `Laurux01.sql` + jeu dérivé (401/411 non collectifs avec et sans `dateech`, une échéance avec heure non nulle) | contenu de `~/tmp/Dtech.txt` de référence | `tests/recupdech_export/` | implémenté (couvert par le rejeu Compta/recupdech_prgm : Message.Info bloquant en gb.test) |
| RECUPDECH-T02 | gbtest | Répertoire absent | `HOME` sans `tmp/` | erreur d'exécution figée | `tests/recupdech_sans_tmp/` | implémenté (Compta/RecupDechTest.T02SansTmp) |
| RECUPDECH-T03 | replay | Lancement par `Prgm` | saisie `RecupDech` | même fichier que T01 ; `Message.Info` ; dump inchangé | `tests/recupdech_prgm/` | implémenté (Compta/recupdech_prgm, fichier tmp/Dtech.txt comparé) |
| RECUPDECH-T04 | gbtest | Variante SQLite | `Laurux01.sqlite` + même jeu | fichier de référence (traduction de `left()`) | `tests/recupdech_sqlite/` | à faire : variante SQLite (base Laurux01.sqlite non prise en charge par le rejeu ; Message.Info bloquant en gb.test) |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone **Laurux non modifié**, `HOME` isolé.
- La trace `Print` sur la sortie standard n'est pas comparée.
- Le formulaire (jamais affiché) n'est pas testable.
- Jeu partagé : `.hidden/Tests/Compta/assets/recupdech_shared/recupdech_echeances.sql` (3 lignes exportées, 5 exclues).
  Observé dans ref : les échéances sont écrites décalées d'une heure (`2018-03-05 00:00` → `03/04/2018 23:00:00`,
  `14:30` → `13:30`), conversion implicite Date → chaîne ; comportement figé (candidat anomalie).
