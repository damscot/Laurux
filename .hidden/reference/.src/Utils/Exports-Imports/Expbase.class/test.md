# Expbase — Tests

> Source : `.src/Utils/Exports-Imports/Expbase.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EXPBASE-T01 | replay | Préremplissage | `Laurux.conf` de test avec `/Soc01/Adr-base` | `Adrbase` affiche l'adresse (log GUI) | `tests/preremplissage/` | implémenté |
| EXPBASE-T02 | replay | Adresse vide | `Adrbase` vidé, `Button2` | `Message.Error` « Veuillez renseigner l'adresse… » | `tests/adresse_vide/` | implémenté (`assets/expbase_adresse_vide/`) : `Message.Error` vérifié par le rejeu (une boîte FMessage), aucune requête d'envoi |
| EXPBASE-T03 | replay | Chemin du fichier joint | `/Rep_Sauv`, `/Compression` = -1 puis 0 ; `EnvMail` neutralisé | arguments passés à `EnvMail.Envoi2` (`.sql.gz` / `.sql`) | `tests/chemin_sauvegarde/` | à faire : neutralisation d'EnvMail.Envoi2 (envoi réel) non disponible |

## Détail des tests

- Capture dans le clone **Laurux non modifié** ; l'envoi réel est neutralisé (configuration mail
  pointant vers un serveur SMTP factice ou `xdg-email` remplacé par un script qui journalise ses
  arguments). Aucune table modifiée : diff BDD vide.
- Non testable automatiquement : la réception effective du courriel.
- **Phase 2 (implémentation)** : T01 vérifié en gb.test (`.src/Tests/Utils/ExpbaseTest.test`) : la
  configuration de test n'a pas `/Soc01/Adr-base` et un scénario ne peut pas la surcharger ; la clé est écrite
  en mémoire puis `Adrbase` relu. T02 = scénario `.hidden/Tests/Utils/assets/expbase_adresse_vide/` (`Menu171`).
