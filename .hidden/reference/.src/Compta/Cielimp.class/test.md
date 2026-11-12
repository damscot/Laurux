# Cielimp — Tests

> Source : `.src/Compta/Cielimp.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Replays sur MariaDB Docker avec des fichiers Ciel générés (`gen_input.py`, format du tableau
d'architecture.md). Critère : dump normalisé de `Fiches_Mvt`, `Fiches_Comptes`,
`Fiches_Parametres`, `Ciel_Lrx*`, `Cptabs`, plus le contenu des fichiers `~/tmp/F*`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CIELIMP-T01 | replay | Import nominal | `Laurux01.sql` + correspondances complètes ; fichier de 3 écritures (vente 411, achat 401, banque 512) | lignes `Fiches_Mvt` (dont lignes collectives), soldes, `numecriture`, `imp_ciel = 1` | `tests/import_nominal/` | implémenté (replay `.hidden/Tests/Compta/assets/cielimp_import_nominal/`) |
| CIELIMP-T02 | replay | Création de comptes | fichier avec deux comptes généraux absents (classe 6 et 5) | comptes créés (types G et B), message, `~/tmp/FCompte`, **pas d'import** | `tests/comptes_crees/` | implémenté (replay `.hidden/Tests/Compta/assets/cielimp_comptes_crees/`, comptes 606390 et 514000) |
| CIELIMP-T03 | replay | Relance dans la même fenêtre | T02 puis second clic Importer | aucun message, aucun import (A01 figée) | `tests/relance_meme_fenetre/` | implémenté (replay `.hidden/Tests/Compta/assets/cielimp_relance_meme_fenetre/`) |
| CIELIMP-T04 | replay | Journal manquant | journal Ciel absent des deux tables | `Cptabs` rempli, `~/tmp/FJournaux`, pas d'import | `tests/journal_manquant/` | implémenté (replay `.hidden/Tests/Compta/assets/cielimp_journal_manquant/`, journal ZZ) |
| CIELIMP-T05 | replay | Tiers sans correspondance | compte 411 absent de `Ciel_Lrx` | message, `~/tmp/FClients`, fermeture, pas d'import | `tests/tiers_manquant/` | implémenté (replay `.hidden/Tests/Compta/assets/cielimp_tiers_manquant/`, tiers 411XYZ) |
| CIELIMP-T06 | replay | Écriture déséquilibrée | une écriture débit ≠ crédit (au milieu, puis en dernier) | message d'erreur ; fichiers laissés ouverts (A02 figée) | `tests/desequilibre/` | implémenté (replays `.hidden/Tests/Compta/assets/cielimp_desequilibre/` et `cielimp_desequilibre_fin/`) |
| CIELIMP-T07 | replay | Import déjà fait | `imp_ciel = "1"` | message « déjà effectué » | `tests/deja_importe/` | implémenté (replay `.hidden/Tests/Compta/assets/cielimp_deja_importe/`) |
| CIELIMP-T08 | replay | Fichier inexistant | `Fimport` vers un chemin absent | message « fichier défini n'existe pas » | `tests/fichier_absent/` | implémenté (replay `.hidden/Tests/Compta/assets/cielimp_fichier_absent/`, Fimport vide) |
| CIELIMP-T09 | replay | Trésorerie | écriture sur `51210000` et journal `TR` | `tresorerie`, `datee` mis à jour par numéro (A05/A06 figées) | `tests/tresorerie/` | à faire : non commencé (vague 3, temps écoulé) ; générateur réutilisable |
| CIELIMP-T10 | replay | Montants et longueurs de compte | `Lcpt` = 6 puis 8 ; montants avec point et avec virgule | valeurs `montantd`/`montantc` figées (A04) | `tests/montants_longueurs/` | à faire : non commencé (vague 3, temps écoulé) ; Lcpt par Click=<index>@Lcpt à valider |
| CIELIMP-T11 | replay | Tiers sans compte Laurux | correspondance vers un compte absent de `Fiches_Comptes` | erreur en cours d'import, import partiel (A03 figée) | `tests/tiers_sans_compte/` | à faire : non commencé (vague 3, temps écoulé) |
| CIELIMP-T12 | gbtest | Découpage d'une ligne (après CIELIMP-005) | lignes de T01, T10 | collection des champs attendus | `tests/ligne_ciel/` | à faire : exige l'extraction CIELIMP-005 (phase 4) |

## Détail des tests

- **Génération des valeurs attendues** : chaque fichier d'entrée est importé dans le clone
  **Laurux non modifié** ; dumps et fichiers `~/tmp/F*` sont conservés dans `expected/`.
- **Données** : `Laurux01.sql` ; `gen_input.py` produit les fichiers Ciel à positions fixes
  (format documenté dans architecture.md) ; `HOME` isolé pour `~/tmp`.
- **Éditeur externe** : `Editeur.Prog_Editeur` est intercepté (variable d'environnement ou
  éditeur factice) pour ne pas bloquer le replay.
- **Non testable automatiquement** : documentation HTML ; fidélité au format Ciel réel (aucun
  fichier Ciel authentique dans le dépôt, format reconstitué depuis le code : à confirmer avec un
  export réel).
- **Implémentation (phase 2)** : scénarios rejoués depuis `Fmenu` (Menu182), chemin du fichier saisi dans `Fimport`
  (`/tmp/laurux-test/ciel.txt`, fichier d’\entrée dans les assets du scénario, positions fixes du tableau d’\architecture.md,
  `Lcpt` = 6). Jeu partagé `cielimp_shared/cielimp_nominal` (tables `Ciel_Lrx`/`Ciel_Lrx_Jo`, tiers `411DUP`→411001,
  `401MAR`→401002 ; journaux Ciel = codes Laurux 70/60/50). `~/tmp/F*` et `@ouvrir.trace` (Desktop.Open de
  `Editeur.Prog_Editeur`) comparés. T07 : jeu `cielimp_deja_importe/cielimp_deja_fait.sql` (imp_ciel = "1").
  T06 : deux scénarios (`cielimp_desequilibre` au milieu, `cielimp_desequilibre_fin` en dernier).
  Constat T01 : `tresorerie` = 0 sur toutes les lignes, y compris le journal 50 de type TR (`Tresor` est un Boolean
  comparé à "TR", Cielimp.class `Compta`).
