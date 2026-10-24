# Cielimp — Tests

> Source : `.src/Compta/Cielimp.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Replays sur MariaDB Docker avec des fichiers Ciel générés (`gen_input.py`, format du tableau
d'architecture.md). Critère : dump normalisé de `Fiches_Mvt`, `Fiches_Comptes`,
`Fiches_Parametres`, `Ciel_Lrx*`, `Cptabs`, plus le contenu des fichiers `~/tmp/F*`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CIELIMP-T01 | replay | Import nominal | `Laurux01.sql` + correspondances complètes ; fichier de 3 écritures (vente 411, achat 401, banque 512) | lignes `Fiches_Mvt` (dont lignes collectives), soldes, `numecriture`, `imp_ciel = 1` | `tests/import_nominal/` | à faire |
| CIELIMP-T02 | replay | Création de comptes | fichier avec deux comptes généraux absents (classe 6 et 5) | comptes créés (types G et B), message, `~/tmp/FCompte`, **pas d'import** | `tests/comptes_crees/` | à faire |
| CIELIMP-T03 | replay | Relance dans la même fenêtre | T02 puis second clic Importer | aucun message, aucun import (A01 figée) | `tests/relance_meme_fenetre/` | à faire |
| CIELIMP-T04 | replay | Journal manquant | journal Ciel absent des deux tables | `Cptabs` rempli, `~/tmp/FJournaux`, pas d'import | `tests/journal_manquant/` | à faire |
| CIELIMP-T05 | replay | Tiers sans correspondance | compte 411 absent de `Ciel_Lrx` | message, `~/tmp/FClients`, fermeture, pas d'import | `tests/tiers_manquant/` | à faire |
| CIELIMP-T06 | replay | Écriture déséquilibrée | une écriture débit ≠ crédit (au milieu, puis en dernier) | message d'erreur ; fichiers laissés ouverts (A02 figée) | `tests/desequilibre/` | à faire |
| CIELIMP-T07 | replay | Import déjà fait | `imp_ciel = "1"` | message « déjà effectué » | `tests/deja_importe/` | à faire |
| CIELIMP-T08 | replay | Fichier inexistant | `Fimport` vers un chemin absent | message « fichier défini n'existe pas » | `tests/fichier_absent/` | à faire |
| CIELIMP-T09 | replay | Trésorerie | écriture sur `51210000` et journal `TR` | `tresorerie`, `datee` mis à jour par numéro (A05/A06 figées) | `tests/tresorerie/` | à faire |
| CIELIMP-T10 | replay | Montants et longueurs de compte | `Lcpt` = 6 puis 8 ; montants avec point et avec virgule | valeurs `montantd`/`montantc` figées (A04) | `tests/montants_longueurs/` | à faire |
| CIELIMP-T11 | replay | Tiers sans compte Laurux | correspondance vers un compte absent de `Fiches_Comptes` | erreur en cours d'import, import partiel (A03 figée) | `tests/tiers_sans_compte/` | à faire |
| CIELIMP-T12 | gbtest | Découpage d'une ligne (après CIELIMP-005) | lignes de T01, T10 | collection des champs attendus | `tests/ligne_ciel/` | à faire |

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
