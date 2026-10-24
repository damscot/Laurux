# Cpostaux — Tests

> Source : `.src/Gestion/Tables/Cpostaux.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

`replay` avec diff de `Fiches_Cpostaux`. Valeurs attendues produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CPOSTAUX-T01 | replay | Création | menu Codes postaux ; `75001`, `PARIS` ; Enregistrer | INSERT | `tests/creation/` | à faire |
| CPOSTAUX-T02 | replay | « Modification » du bureau | clic `75001 PARIS` ; bureau `PARIS 1` ; Enregistrer | nouvelle ligne, ancienne conservée (A01 figée) | `tests/modification/` | à faire |
| CPOSTAUX-T03 | replay | Code à plusieurs bureaux | jeu dérivé `44000` × 2 ; saisie `44000`, Entrée ; choix dans la liste | liste `Colcp` affichée, bureau recopié | `tests/choix_bureau/` | à faire |
| CPOSTAUX-T04 | replay | Filtre et tri | clic en-tête CP, frappe `75`, double-clic | lignes filtrées `75%`, tri décroissant (log de rejeu) | `tests/filtre_tri/` | à faire |
| CPOSTAUX-T05 | replay | Suppression | sélection d'une ligne ; Supprimer, Oui | ligne `lind` supprimée | `tests/suppression/` | à faire |
| CPOSTAUX-T06 | replay | Saisie non numérique | lettres dans le code | caractères bloqués (`ChkCp`) | `tests/saisie_numerique/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` (table vide) ; jeu dérivé d'une dizaine de codes (dont `44000` × 2,
  `75001`).
- **Comparaison** : dump normalisé de `Fiches_Cpostaux` (colonne `lind` masquée si les
  auto-incréments divergent) ; T04 et T06 contrôlent le log de rejeu (pas d'écriture).
- **SQLite** : T04 à rejouer sur `Laurux01.sqlite` (littéral entre guillemets doubles).
