# Plancomptable — Tests

> Source : `.src/Compta/Impressions/Plancomptable.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran d'impression en lecture seule : tests `replay` sur MariaDB Docker (`Laurux01.sql`). Le
résultat comparé est le **texte du PDF** (`pdftotext ~/tmp/Plan.pdf`) et les lignes `Exec_SQL`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| PLANCOMPTABLE-T01 | replay | Impression par type | Clients, Fournisseurs, Gestion, Bilan avec plages par défaut | texte PDF de référence (titre, comptes, pagination) | `tests/plancomptable_types/` | implémenté |
| PLANCOMPTABLE-T02 | replay | Plage personnalisée et vide | Gestion `606000`-`606999` ; plage sans compte | texte PDF ; message « Aucun compte » | `tests/plancomptable_plage/` | implémenté |
| PLANCOMPTABLE-T03 | replay | Sélection par `TriCpt` | F2 dans `Cpt`, F2 dans `Cpt2`, boutons `ToggleButton2`/`3` | champ rempli (comportement A01 figé) | `tests/plancomptable_tricpt/` | à faire : F2 non rejoué ; grille de TriCpt (TriGen) construite après la pose des observateurs, non rejouable |
| PLANCOMPTABLE-T04 | replay | Quitter | bouton Quitter après impression | fichier `~/tmp/Plan.pdf` supprimé | `tests/plancomptable_quitter/` | implémenté |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone **Laurux non modifié**, `HOME` isolé ; la date
  d'impression du pied de page est masquée avant comparaison.
- Plus de 50 comptes clients dans le jeu pour couvrir le saut de page.
- **Non testable automatiquement** : l'affichage par `Visualiseur` (seul le fichier est comparé).

## Implémentation (phase 2, vague 4)

- Scénarios `.hidden/Tests/Compta/assets/plancomptable_{types,plage,quitter}/`, base Laurux01 (Gestion et Bilan
  sur 2 pages : saut de page couvert sans jeu dérivé), date 2018-06-15.
- `/Soc01/caisse/CmdVis` = `pdftotext -layout "$0" - >> {home}/plan_pdf.txt` : les éditions successives d'un même
  scénario s'ajoutent dans `~/plan_pdf.txt` (clé `fichiers`).
- T04 compare `tmp/Plan.pdf` (« <fichier absent> » après Quitter).
