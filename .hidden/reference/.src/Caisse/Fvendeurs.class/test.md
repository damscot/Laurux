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
| FVENDEURS-T01 | replay | Création | code `5`, nom, mot de passe `abcd` deux fois, `Admin` coché | ligne insérée, `mdp` chiffré, `admin = -1` | `tests/creation/` | implémenté |
| FVENDEURS-T02 | replay | Refus | mots de passe différents ; mot de passe `ab` ; code vide | deux messages, focus sur le code ; base inchangée | `tests/refus/` | implémenté |
| FVENDEURS-T03 | replay | Modification | clic sur le vendeur `1`, nouveau nom, confirmation retapée | ligne mise à jour ; `Prenom` affichait le mot de passe déchiffré | `tests/modification/` | implémenté |
| FVENDEURS-T04 | replay | Suppression | code `12` saisi, vendeur `1` sélectionné, « Oui » ; puis sans sélection | figer : suppression du vendeur sélectionné ; erreur non interceptée sans sélection (A01) | `tests/suppression/` | implémenté |
| FVENDEURS-T05 | replay | Clavier | touche `Tab` sur « Enregistrer » ; Échap dans la liste | figer : enregistrement par toute touche (A02) ; liste masquée (A03) | `tests/clavier/` | implémenté (Tab sur Enregistrer, A02) ; partie Échap dans la liste (A03) à faire : Échap non rejouable |
| FVENDEURS-T06 | replay | Ouverture non modale | `Menu287` puis `Menu206` | même fenêtre réutilisée, liste chargée une fois | `tests/ouverture_menus/` | à faire : après Menu287 (Fvendeurs.Show, non modal), le rejeu refuse le clic sur Menu206 (« window Fmenu n'est pas actuellement active (Fvendeurs) », code 3) |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone Laurux **non modifié**.
- **Données** : jeu dérivé `caisse_base` (vendeurs `1`, `12`, un administrateur).
- **Non testable automatiquement** : aide HTML (F1, `Button4`), couleur d'édition.
- T04 et T05 caractérisent des anomalies ; ils seront mis à jour avec leur correction.
- **Phase 2 (vague 7)** : scénarios `.hidden/Tests/Caisse/assets/fvendeurs_{creation,refus,modification,suppression,clavier}/` ; jeu `fvendeurs_shared/vendeurs` (caisse et vendeurs activés par le blob conf ; vendeurs 1, 12, 2 avec mots de passe chiffrés abc1, b123, c234). T04 : le vendeur 1 sélectionné est supprimé alors que le code saisi est 12 ; sans sélection, `Fvendeurs.Button3_Click.213: Null object` figé (`code_sortie` 125).
