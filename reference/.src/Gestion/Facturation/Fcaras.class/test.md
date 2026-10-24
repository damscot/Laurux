# Fcaras — Tests

> Source : `.src/Gestion/Facturation/Fcaras.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Fenêtre d'affichage sans accès à la base : tests `replay` depuis la saisie de documents
(`Facture`), sur un article ayant une photo et des caractéristiques renseignées.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FCARAS-T01 | replay | Ouverture avec photo valide | Saisie document, article avec photo PNG existante et texte | fenêtre ouverte, `Crst.Text` = caractéristiques, fermeture par `Fermer` ; dump BDD inchangé | `tests/photo_valide/` | à faire |
| FCARAS-T02 | replay | Photo absente ou illisible | article dont le chemin photo n'existe pas | zone image vide, aucun message ; fermeture par `Échap` dans `Crst` | `tests/photo_absente/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone Laurux non modifié (journal de rejeu et dump
  normalisé de la base, qui doit rester identique).
- **Données** : `Laurux01.sql` + un article avec `art_photo` (lu par `Facture`, l. 4790/8181) et `art_crst` renseignés,
  `art_photo` pointant vers `tests/photo_valide/photo.png`, et un second vers un
  chemin inexistant.
- **Non testable automatiquement** : le rendu de l'image (pas de capture d'écran comparée) ;
  `Tnom_Photo` n'a pas d'effet observable, sa suppression est couverte par T01/T02.
