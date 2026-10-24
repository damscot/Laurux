# Abont — Tests

> Source : `.src/Compta/Tables/Abont.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran de saisie à deux tables : `replay` avec diff de `Fiches_Numabon` et `Fiches_Ligabon`.
Valeurs attendues produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| ABONT-T01 | replay | Création d'un masque achat | menu Masques ; Créer ; libellé ; ligne 607 débit `$montant` ; ligne 445660 débit `($montant * 0.2)` ; ligne 401 crédit ; Valider | `Fiches_Numabon` (type `A`, `typem` `1`, compteur 0) et 3 lignes `Fiches_Ligabon` | `tests/creation_achat/` | à faire |
| ABONT-T02 | replay | Masque de trésorerie | BT ; compte de trésorerie (refusé) puis compte autorisé, `numDoc` = `"VIRL" & $annee4` | lignes enregistrées ; refus du compte `comptr_cc ≠ 0` | `tests/tresorerie/` | à faire |
| ABONT-T03 | replay | Modification et suppression de ligne | Entrée sur la ligne 2, montant changé, Enregistrer ligne ; Suppr sur la ligne 1 | ligne déplacée en fin, renumérotation `lig` (A02 figée) | `tests/lignes/` | à faire |
| ABONT-T04 | replay | Abandon d'une modification | Entrée sur une ligne puis Quitter | ligne supprimée en base (A02 figée) | `tests/abandon/` | à faire |
| ABONT-T05 | replay | Suppression du masque | sélection du masque, Supprimer ; puis saisie d'un compte | masque et lignes supprimés sans confirmation (A03) ; « compte inexistant » (A04) | `tests/suppression/` | à faire |
| ABONT-T06 | replay | Utilisation par la saisie | `Saisecrit`, utilisation du masque de T01 | `compteur` = 1 (via `Compteur_Incr` sur l'auto-instance) | `tests/compteur/` | à faire |
| ABONT-T07 | replay | Format non supporté | `typem = "2"` posé par SQL ; ouverture de l'écran | erreur « Unknown symbol » figée (A01) | `tests/format_inconnu/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` ; T07 modifie `Fiches_Numabon.typem` par script SQL ; T06 dépend
  du replay de saisie d'écriture (`Saisecrit`).
- **Comparaison** : dump normalisé de `Fiches_Numabon` et `Fiches_Ligabon` (la colonne `lind`
  auto-incrémentée est comparée telle quelle, les deux clones partant du même dump).
- **Non testable** : calculatrice F5 (`FCalc`), son.
