# Monip — Tests

> Source : `.src/Utils/Monip.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| MONIP-T01 | replay | Fenêtre « Mon IP » | `Fmenu`, menu correspondant ; `curl` factice dans le `PATH` renvoyant `203.0.113.7` ; répertoire courant = `$HOME` | texte du label capturé | `tests/replay_monip/` | à faire : bloqué par l'anomalie MONIP-A01 (décision utilisateur du 2026-11-15 : conservé en anomalie) : `curl ifconfig.me > monip` (l. 25) écrit dans le répertoire courant du processus (racine du clone au rejeu) alors que Laurux lit `~/monip` (l. 26) ; le test n'est écrit qu'après correction de A01 |
| MONIP-T02 | replay | `curl` absent | `PATH` sans `curl`, `$HOME/monip` absent | `Message.Warning` capturé | `tests/replay_monip_sans_curl/` | à faire : bloqué par l'anomalie MONIP-A01 (décision utilisateur du 2026-11-15 : conservé en anomalie) : la redirection crée `monip` dans le répertoire courant même quand curl échoue ; scénario `monip_sans_curl` (règle « outils » curl code 127) conservé hors dépôt dans output/claude/2026-11-08_phase2/lot2/outils/monip_de_cote/, à intégrer après correction de A01 |

## Détail des tests

- `curl` est remplacé par un script factice (pas d'accès réseau en test). Les captures attendues
  sont produites dans le clone **Laurux non modifié** avec le même script.
- Le cas « répertoire courant différent de `$HOME` » (anomalie A01) est figé dans T01 en variante
  (`tests/replay_monip/cwd_autre/`).
