# Abont — Tests

> Source : `.src/Compta/Tables/Abont.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran de saisie à deux tables : `replay` avec diff de `Fiches_Numabon` et `Fiches_Ligabon`.
Valeurs attendues produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| ABONT-T01 | replay | Création d'un masque achat | menu Masques ; Créer ; libellé ; ligne 607 débit `$montant` ; ligne 445660 débit `($montant * 0.2)` ; ligne 401 crédit ; Valider | `Fiches_Numabon` (type `A`, `typem` `1`, compteur 0) et 3 lignes `Fiches_Ligabon` | `tests/creation_achat/` | implémenté |
| ABONT-T02 | replay | Masque de trésorerie | BT ; compte de trésorerie (refusé) puis compte autorisé, `numDoc` = `"VIRL" & $annee4` | lignes enregistrées ; refus du compte `comptr_cc ≠ 0` | `tests/tresorerie/` | implémenté |
| ABONT-T03 | replay | Modification et suppression de ligne | Entrée sur la ligne 2, montant changé, Enregistrer ligne ; Suppr sur la ligne 1 | ligne déplacée en fin, renumérotation `lig` (A02 figée) | `tests/lignes/` | à faire : sélection d'une ligne de `Colecr` non rejouable (pas de `Colecr_Click`, replay_missing) ; Entrée sans ligne courante → « Null object » (Colecr_Activate.299) |
| ABONT-T04 | replay | Abandon d'une modification | Entrée sur une ligne puis Quitter | ligne supprimée en base (A02 figée) | `tests/abandon/` | à faire : même limite que T03 (ligne de `Colecr` non sélectionnable au rejeu) |
| ABONT-T05 | replay | Suppression du masque | sélection du masque, Supprimer ; puis saisie d'un compte | masque et lignes supprimés sans confirmation (A03) ; « compte inexistant » (A04) | `tests/suppression/` | implémenté |
| ABONT-T06 | replay | Utilisation par la saisie | `Saisecrit`, utilisation du masque de T01 | `compteur` = 1 (via `Compteur_Incr` sur l'auto-instance) | `tests/compteur/` | implémenté (gbtest : `Compteur_Incr` appelé directement sur l'auto-instance, sans passer par Saisecrit) |
| ABONT-T07 | replay | Format non supporté | `typem = "2"` posé par SQL ; ouverture de l'écran | erreur « Unknown symbol » figée (A01) | `tests/format_inconnu/` | implémenté (erreur fatale figée, code_sortie 125) |

## Détail des tests

- **Données** : `Laurux01.sql` ; T07 modifie `Fiches_Numabon.typem` par script SQL ; T06 dépend
  du replay de saisie d'écriture (`Saisecrit`).
- **Comparaison** : dump normalisé de `Fiches_Numabon` et `Fiches_Ligabon` (la colonne `lind`
  auto-incrémentée est comparée telle quelle, les deux clones partant du même dump).
- **Non testable** : calculatrice F5 (`FCalc`), son.
- **Implémentation (phase 2)** : scénarios `.hidden/Tests/Compta/assets/abont_creation_achat` (cadence
  « traitement » 600 ms pour tenir dans 20 s), `abont_tresorerie`, `abont_suppression`, `abont_format_inconnu`
  (jeu `.hidden/Tests/Compta/assets/abont_format_inconnu/abont_typem2.sql` ; « Unknown symbol 'Erreur' in class 'Message' » dans `Abont.Deb3`, code 125) ;
  gb.test `.src/Tests/Compta/AbontTest.test` (T06, jeu `.hidden/Tests/Compta/assets/abont_shared/abont_masque.sql` : masque 1 et 3 lignes).
  Après Entrée sur le compte, `Compteman` sélectionne `Montant` (ou `Compte` en cas de refus) : pas besoin d'effacer.
  Libellé et Num Doc des lignes : `LibelleEcrit` non saisi (NULL). T05 : `Message.Warning` « Ce compte n'existe
  pas ou n'est pas du type sélectionné ! » vérifiée par le rejeu. T03/T04 : sélection de ligne dans `Colecr`
  impossible au rejeu ; une Entrée sans ligne courante provoque « Null object » (`Colecr_Activate.299`).
