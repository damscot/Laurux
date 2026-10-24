# ComMail — Tests

> Source : `.src/Gestion/Tables/ComMail.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

`replay` avec diff de `Fiches_ComMail` (et, pour le mode choix, du document produit par
l'appelant). Valeurs attendues produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| COMMAIL-T01 | replay | Création (mode gestion) | menu textes courriels ; `01`, texte avec `&` ; Enregistrer | ligne insérée, `&` → `et` | `tests/creation/` | à faire |
| COMMAIL-T02 | replay | Modification | clic `01` ; texte modifié ; Enregistrer | UPDATE | `tests/modification/` | à faire |
| COMMAIL-T03 | replay | Suppression | sélection `01` ; Supprimer, Oui | ligne supprimée | `tests/suppression/` | à faire |
| COMMAIL-T04 | replay | Mode choix depuis la fiche client | `FClient`, envoi de courriel, sélection `01`, Choisir | corps du courriel = texte `01` (brut), aucune écriture `Fiches_ComMail` | `tests/choix_fclient/` | à faire |
| COMMAIL-T05 | replay | Touche sur le bouton Choisir | mode choix, focus sur le bouton, touche Tab | texte choisi et fenêtre fermée (comportement figé) | `tests/keypress_choisir/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` (table vide) ; T02-T05 sur un jeu dérivé avec `01`.
- **Comparaison** : dump normalisé de `Fiches_ComMail` ; pour T04, log de rejeu (pas d'envoi réel de
  courriel : configurer un serveur SMTP factice ou s'arrêter avant l'envoi).
- **Non testable automatiquement** : couleur de focus, aide.
