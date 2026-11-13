# ComMail — Tests

> Source : `.src/Gestion/Tables/ComMail.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

`replay` avec diff de `Fiches_ComMail` (et, pour le mode choix, du document produit par
l'appelant). Valeurs attendues produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| COMMAIL-T01 | replay | Création (mode gestion) | menu textes courriels ; `01`, texte avec `&` ; Enregistrer | ligne insérée, `&` → `et` | `tests/creation/` | implémenté |
| COMMAIL-T02 | replay | Modification | clic `01` ; texte modifié ; Enregistrer | UPDATE | `tests/modification/` | implémenté |
| COMMAIL-T03 | replay | Suppression | sélection `01` ; Supprimer, Oui | ligne supprimée | `tests/suppression/` | implémenté |
| COMMAIL-T04 | replay | Mode choix depuis la fiche client | `FClient`, envoi de courriel, sélection `01`, Choisir | corps du courriel = texte `01` (brut), aucune écriture `Fiches_ComMail` | `tests/choix_fclient/` | à faire : passe par FClient (écran complexe, scénarios en attente de validation utilisateur) |
| COMMAIL-T05 | replay | Touche sur le bouton Choisir | mode choix, focus sur le bouton, touche Tab | texte choisi et fenêtre fermée (comportement figé) | `tests/keypress_choisir/` | à faire : mode choix accessible seulement depuis FClient ou ObjFacB (écrans complexes) |

## Détail des tests

- **Implémentation (vague 4)** : scénarios `Gestion/commail_creation` (`&` → `et`), `commail_modification`, `commail_suppression` (fenêtre nommée `Commail` comme dans `Fmenu.Menu326_Click`) ; jeu partagé `.hidden/Tests/Gestion/assets/commail_shared/commail_deux.sql`.

- **Données** : `Laurux01.sql` (table vide) ; T02-T05 sur un jeu dérivé avec `01`.
- **Comparaison** : dump normalisé de `Fiches_ComMail` ; pour T04, log de rejeu (pas d'envoi réel de
  courriel : configurer un serveur SMTP factice ou s'arrêter avant l'envoi).
- **Non testable automatiquement** : couleur de focus, aide.
