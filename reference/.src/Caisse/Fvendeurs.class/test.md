# Fvendeurs — Tests

> Source : `.src/Caisse/Fvendeurs.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI de table : tests `replay` depuis le menu Gestion › Tables › Vendeurs (`Fmenu.Menu206`,
et `Menu287` pour T06). `Utils.Observers(Me)` est appelé une seule fois dans `_New` : rejouable ;
les clics dans la liste `Vendeur` sont rejouables (`Vendeur_Click` existe). Comparaison : dump de
`Fiches_Vendeurs` (`lind` masqué ; `mdp` comparé tel quel, chiffrement déterministe à confirmer),
messages.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FVENDEURS-T01 | replay | Création | code `5`, nom, mot de passe `abcd` deux fois, `Admin` coché | ligne insérée, `mdp` chiffré, `admin = -1` | `tests/creation/` | à faire |
| FVENDEURS-T02 | replay | Refus | mots de passe différents ; mot de passe `ab` ; code vide | deux messages, focus sur le code ; base inchangée | `tests/refus/` | à faire |
| FVENDEURS-T03 | replay | Modification | clic sur le vendeur `1`, nouveau nom, confirmation retapée | ligne mise à jour ; `Prenom` affichait le mot de passe déchiffré | `tests/modification/` | à faire |
| FVENDEURS-T04 | replay | Suppression | code `12` saisi, vendeur `1` sélectionné, « Oui » ; puis sans sélection | figer : suppression du vendeur sélectionné ; erreur non interceptée sans sélection (A01) | `tests/suppression/` | à faire |
| FVENDEURS-T05 | replay | Clavier | touche `Tab` sur « Enregistrer » ; Échap dans la liste | figer : enregistrement par toute touche (A02) ; liste masquée (A03) | `tests/clavier/` | à faire |
| FVENDEURS-T06 | replay | Ouverture non modale | `Menu287` puis `Menu206` | même fenêtre réutilisée, liste chargée une fois | `tests/ouverture_menus/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone Laurux **non modifié**.
- **Données** : jeu dérivé `caisse_base` (vendeurs `1`, `12`, un administrateur).
- **Non testable automatiquement** : aide HTML (F1, `Button4`), couleur d'édition.
- T04 et T05 caractérisent des anomalies ; ils seront mis à jour avec leur correction.
