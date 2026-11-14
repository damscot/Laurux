# Monip — Tests

> Source : `.src/Utils/Monip.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| MONIP-T01 | replay | Fenêtre « Mon IP » | `Fmenu`, menu correspondant ; `curl` factice dans le `PATH` renvoyant `203.0.113.7` ; répertoire courant = `$HOME` | texte du label capturé | `tests/replay_monip/` | à faire : rejoué (Menu256, faux curl tracé) mais `curl ifconfig.me > monip` écrit dans le répertoire courant du rejeu = racine du clone (fichier `monip` non ignoré par git), puis ~/monip absent → Message.Warning (A01 confirmé) ; besoin d'outillage : répertoire courant = HOME de test pour les rejeux. Scénario mis de côté (`monip_replay_monip`) |
| MONIP-T02 | replay | `curl` absent | `PATH` sans `curl`, `$HOME/monip` absent | `Message.Warning` capturé | `tests/replay_monip_sans_curl/` | à faire : même besoin d'outillage (PATH sans curl par scénario) |

## Détail des tests

- `curl` est remplacé par un script factice (pas d'accès réseau en test). Les captures attendues
  sont produites dans le clone **Laurux non modifié** avec le même script.
- Le cas « répertoire courant différent de `$HOME` » (anomalie A01) est figé dans T01 en variante
  (`tests/replay_monip/cwd_autre/`).
