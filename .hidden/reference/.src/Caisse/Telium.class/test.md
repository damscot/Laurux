# Telium — Tests

> Source : `.src/Caisse/Telium.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Classe morte : ces tests ne sont utiles que si l'utilisateur décide de **conserver** la classe
(TELIUM-001 non exécuté). Ils figent le comportement actuel, défauts compris, et serviraient de
point de départ à une correction (A01-A04).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| TELIUM-T01 | gbtest | `_new` : port absent | `New Telium(1, True, False, "/dev/inexistant")` | erreur figée `'Telium.:Error' is not static` (A01) | `tests/telium_port_absent/` | à faire |
| TELIUM-T02 | gbtest | `demanderPaiement` sur faux TPE | paire pty `socat`, faux TPE Python qui répond `ACK` / `ACK` / `ENQ` ; montant 12,5 | retour `False` ; octets reçus par le faux TPE `06 0a 06 0a` (A02, A03) | `tests/telium_pty/` | à faire |
| TELIUM-T03 | gbtest | Modes `_new` | combinaisons `unModeReponse` × `forcerAutorisation` | trame émise (si un jour atteinte) ; aujourd'hui identique à T02 | `tests/telium_modes/` | à faire |

## Détail des tests

- **Faux périphérique** : `socat pty,raw,echo=0,link=<dir>/ttyA pty,raw,echo=0,link=<dir>/ttyB`
  crée une paire de pseudo-terminaux ; la classe ouvre `ttyA` (passé en `unCheminAppareil`), un
  script Python (`fake_tpe.py`, lancé avec `-I`) lit et répond sur `ttyB`. Essai concluant en
  scratchpad (phase 1) sur une copie de la classe : c'est la méthode recommandée pour la phase 2.
  `socat` doit être ajouté à l'image Docker du harnais.
- **Valeurs attendues** : capturées en exécutant le test dans le clone Laurux non modifié.
- **Non testable sans matériel** : comportement réel d'un TPE Ingenico (temps de réponse, trames
  de réponse, refus de carte, mode de connexion USB/série), conformité au protocole caisse.
- Si TELIUM-001 est exécuté, ces tests sont supprimés avec la classe.
