# Cticket — Tests

> Source : `.src/Caisse/Reports/Cticket.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|

## Détail des tests

Aucun test : la classe n'est jamais instanciée et son unique suppression (CTICKET-001) ne peut
pas changer le comportement. La validation du rework se limite à `gbc3 -agt` (aucune référence
restante) et à `./Laurux -T all`. Un test de `Entete2` figerait seulement l'erreur `Me.seto`,
sans intérêt.
