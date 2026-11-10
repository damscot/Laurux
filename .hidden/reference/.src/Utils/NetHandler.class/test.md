# NetHandler — Tests

> Source : `.src/Utils/NetHandler.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Tests `gbtest` avec un serveur TCP de test lancé par un script Python (`tests/<nom>/serveur.py`,
écoute sur un port local libre et enregistre les octets reçus). Valeurs attendues produites dans le
clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| NETHANDLER-T01 | gbtest | Connexion réussie | serveur actif ; `Open` ; `GetOutput` | `Step = 1` ; « Successfully connected to … » | `tests/connexion_ok/` | implémenté |
| NETHANDLER-T02 | gbtest | Connexion refusée | port fermé ; `Open` ; `Write` | `Step = 0` ; « Fail to Connect … » ; aucune erreur levée | `tests/connexion_refusee/` | implémenté |
| NETHANDLER-T03 | gbtest | Écriture et niveaux | niveau minimal Info ; messages Debug, Info, Error (accents compris) | octets reçus par le serveur (2 lignes UTF-8) | `tests/ecriture_niveaux/` | implémenté |
| NETHANDLER-T04 | gbtest | Fermeture | `Close` puis `Write` ; `GetOutput` | rien n'est envoyé ; « Connection closed … » | `tests/fermeture/` | implémenté |
| NETHANDLER-T05 | gbtest | Double `Open` | `Open` deux fois | erreur « Handler already initialized! » | `tests/double_open/` | implémenté |
| NETHANDLER-T06 | gbtest | Intégration `DB_Connection` | `ServerLogIP`/`ServerLogPort` vers le serveur de test, log actif, une requête | ligne `Exec_SQL` reçue identique à la ligne locale | `tests/integration_log/` | implémenté |

## Détail des tests

- **Non testable automatiquement** : l'hôte qui ne répond pas (blocage jusqu'au timeout TCP du
  système, plusieurs dizaines de secondes) ; à documenter comme test manuel (adresse non routable).
- **Implémentation (phase 2)** : `.src/Tests/Utils/NetHandlerTest.test`, serveur
  `.hidden/Tests/Utils/assets/NetHandlerTest/serveur.py` (port libre, remplacé par `<port>` dans les valeurs).
  T02 vise le port 1 de 127.0.0.1 (refus immédiat). T06 configure `/Soc01/ServerLogIP`/`ServerLogPort` en
  mémoire puis `Utils.db.Refresh()` et compare la ligne reçue à la dernière ligne du journal local.
