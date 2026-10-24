# Expbase — Tests

> Source : `.src/Utils/Exports-Imports/Expbase.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EXPBASE-T01 | replay | Préremplissage | `Laurux.conf` de test avec `/Soc01/Adr-base` | `Adrbase` affiche l'adresse (log GUI) | `tests/preremplissage/` | à faire |
| EXPBASE-T02 | replay | Adresse vide | `Adrbase` vidé, `Button2` | `Message.Error` « Veuillez renseigner l'adresse… » | `tests/adresse_vide/` | à faire |
| EXPBASE-T03 | replay | Chemin du fichier joint | `/Rep_Sauv`, `/Compression` = -1 puis 0 ; `EnvMail` neutralisé | arguments passés à `EnvMail.Envoi2` (`.sql.gz` / `.sql`) | `tests/chemin_sauvegarde/` | à faire |

## Détail des tests

- Capture dans le clone **Laurux non modifié** ; l'envoi réel est neutralisé (configuration mail
  pointant vers un serveur SMTP factice ou `xdg-email` remplacé par un script qui journalise ses
  arguments). Aucune table modifiée : diff BDD vide.
- Non testable automatiquement : la réception effective du courriel.
