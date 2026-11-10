# Papmp — Tests

> Source : `.src/Utils/Papmp.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| PAPMP-T01 | replay | Copie du prix de revient | `Laurux01.sql` ; « Appel programme » `Papmp`, « Oui » | diff `Fiches_Art` : `art_pmp` = `art_prvt` | `tests/pmp_prvt/` | implémenté (`.hidden/Tests/Utils/assets/papmp_pmp_prvt/`) |
| PAPMP-T02 | replay | Refus | « Non » | aucune modification | `tests/refus/` | implémenté (`.hidden/Tests/Utils/assets/papmp_refus/`, « Non » = Tab puis Espace) |

## Détail des tests

- Capture dans le clone **Laurux non modifié** ; comparaison du dump de `Fiches_Art`. Le résultat doit
  être identique à RAZART-T02.
- **Scénarios (phase 2)** : `.hidden/Tests/Utils/assets/papmp_pmp_prvt/` (T01 : Appel programme « Papmp », Oui puis OK) et
  `.hidden/Tests/Utils/assets/papmp_refus/` (T02 : Échap sur la question). Menu : Fichiers › Utilitaires › Appel programme
  (`Menu66#Menu144#Menu282`), écran `Prgm` (`Prg`, `Button1` Lancer, `Button2` Quitter).
