# Plancomptable — Tests

> Source : `.src/Compta/Impressions/Plancomptable.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran d'impression en lecture seule : tests `replay` sur MariaDB Docker (`Laurux01.sql`). Le
résultat comparé est le **texte du PDF** (`pdftotext ~/tmp/Plan.pdf`) et les lignes `Exec_SQL`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| PLANCOMPTABLE-T01 | replay | Impression par type | Clients, Fournisseurs, Gestion, Bilan avec plages par défaut | texte PDF de référence (titre, comptes, pagination) | `tests/plancomptable_types/` | à faire |
| PLANCOMPTABLE-T02 | replay | Plage personnalisée et vide | Gestion `606000`-`606999` ; plage sans compte | texte PDF ; message « Aucun compte » | `tests/plancomptable_plage/` | à faire |
| PLANCOMPTABLE-T03 | replay | Sélection par `TriCpt` | F2 dans `Cpt`, F2 dans `Cpt2`, boutons `ToggleButton2`/`3` | champ rempli (comportement A01 figé) | `tests/plancomptable_tricpt/` | à faire |
| PLANCOMPTABLE-T04 | replay | Quitter | bouton Quitter après impression | fichier `~/tmp/Plan.pdf` supprimé | `tests/plancomptable_quitter/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone **Laurux non modifié**, `HOME` isolé ; la date
  d'impression du pied de page est masquée avant comparaison.
- Plus de 50 comptes clients dans le jeu pour couvrir le saut de page.
- **Non testable automatiquement** : l'affichage par `Visualiseur` (seul le fichier est comparé).
