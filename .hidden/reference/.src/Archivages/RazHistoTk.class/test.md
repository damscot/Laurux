# RazHistoTk — Tests

> Source : `.src/Archivages/RazHistoTk.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

> ⚠️ **Opération destructive : les scénarios de purge ci-dessous doivent être validés par
> l'utilisateur avant leur implémentation (phase 2).**

Comparaison du **dump normalisé de `Fiches_HisEntTickets` et `Fiches_HisLigTickets`** (et de
`Fiches_Bl`, `Fiches_Acomptes`, inchangés) avant/après, jeu dérivé, horloge figée. Valeurs attendues
produites dans le clone **Laurux non modifié** (A01 figée).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| RAZHISTOTK-T01 | replay | Purge nominale | jeu `tickets_archives` : tickets et lignes avant, le jour même et après la date ; « Lancer », « Oui » | tickets strictement antérieurs et leurs lignes supprimés ; message « N tickets » | `tests/razhistotk_nominal/` | implémenté |
| RAZHISTOTK-T02 | replay | Abandon | « Lancer », « Non » | tables inchangées | `tests/razhistotk_abandon/` | implémenté |
| RAZHISTOTK-T03 | replay | Numéro en doublon | un ticket antérieur et un ticket postérieur de même `numero` (caisses différentes) | comportement figé : **les deux** tickets et leurs lignes supprimés (A01) | `tests/razhistotk_doublon/` | implémenté |
| RAZHISTOTK-T04 | replay | Interruption | jeu de 300 tickets ; arrêt par le bouton de la `ProgBar` | purge partielle, chaque ticket supprimé avec ses lignes ; message avec le nombre réel | `tests/razhistotk_interruption/` | à faire : bouton d'arrêt de la ProgBar non rejouable (fenêtre ProgBar non instrumentée) |
| RAZHISTOTK-T05 | replay | Sauvegarde | T01 avec puis sans `mysqldump` | fichier `EffaceT.sql` présent dans le 1er cas ; purge faite dans les deux cas (A03) | `tests/razhistotk_sauvegarde/` | implémenté partiel (cas « sans mysqldump » : scénario `razhistotk_sans_mysqldump`, règle `"outils": {"mysqldump": {"rc": 127}}` ; purge faite sans sauvegarde, `EffaceT.sql` créé vide par la redirection du Shell, A03 figée) ; à faire : cas « avec mysqldump » (contenu du dump horodaté, comparer sa seule présence) |
| RAZHISTOTK-T06 | replay | SQLite | T01 sur `Laurux01.sqlite` + jeu dérivé | comportement figé (A04, à confirmer) | `tests/razhistotk_sqlite/` | à faire : base SQLite non prise en charge par le runner |

## Détail des tests

- **Données** : `Laurux01.sql` + jeu dérivé `tickets_archives.sql` (en-têtes et lignes archivés
  avec `control`/`prev_numero`, un BL `numtick` et un acompte `ntk` pointant vers un ticket purgé).
  À unifier avec les jeux caisse du lot Caisse (`caisse_base`, `jeu_caisse.sql`).
- **Horloge** : figée ; date limite choisie par le scénario.
- **Instrumentation** : écran sans `Utils.Observers` (décision de phase 2) ; T04 demande de piloter
  le bouton d'arrêt de `ProgBar` (rejeu à adapter).
- **Comparaison** : dump des deux tables d'archives + tables référentes.
- **Non testable** : conformité réglementaire (A02, décision utilisateur) ; lecture vocale.
- **Assets (phase 2)** : `.hidden/Tests/Archivages/assets/razhistotk_{nominal,abandon,doublon}/`, jeux `razhistotk_shared/tickets_archives.sql`, `doublon.sql`. Date limite = date figée 2018-06-15.
