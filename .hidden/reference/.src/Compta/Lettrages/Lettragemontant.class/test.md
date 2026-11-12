# Lettragemontant — Tests

> Source : `.src/Compta/Lettrages/Lettragemontant.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Traitement de masse sur `Fiches_Mvt` : tests `replay` avec dump normalisé de `Fiches_Mvt`
(colonnes `numlot`, `lettree`, `control`), puis `gbtest` sur la fonction extraite
(LETTRAGEMONTANT-006). Valeurs attendues produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| LETTRAGEMONTANT-T01 | replay | Lettrage clients sur la base de référence | `Laurux01.sql` ; menu, Clients, Lancer | dump `Fiches_Mvt` ; texte du message (nombre de lignes) | `tests/clients_reference/` | implémenté (Laurux01 sans écriture : 0 ligne) |
| LETTRAGEMONTANT-T02 | replay | Lettrage fournisseurs | même base, radio Fournisseurs | dump `Fiches_Mvt` ; message | `tests/fournisseurs_reference/` | implémenté (jeu lettragemontant_controle au lieu de Laurux01, sans écriture) |
| LETTRAGEMONTANT-T03 | replay | Jeu dérivé contrôlé | compte 411 : facture 120 + règlement 120 ; compte 411 dont la 1re ligne est un crédit (montant de référence 0) ; deux groupes de montants différents | lettrage des groupes équilibrés, lot `"M"` commun, cas montant 0 (A01) et limite de deux groupes (A04) figés | `tests/jeu_controle/` | implémenté |
| LETTRAGEMONTANT-T04 | replay | Rien à lettrer | toutes les écritures lettrées | « 0 écriture(s) lettrée(s) », dump inchangé | `tests/rien_a_lettrer/` | implémenté |
| LETTRAGEMONTANT-T05 | gbtest | `LettrerParMontant` (après LETTRAGEMONTANT-006) | jeu de T03 | nombre de lignes renvoyé ; dump identique à T03 | `tests/calcul/` | à faire : extraction LETTRAGEMONTANT-006 requise |

## Détail des tests

- **Données** : `Laurux01.sql` ; le jeu de T03 insère des écritures validées dans `Fiches_Mvt`
  par script SQL (montants exacts en `decimal(12,2)`).
- **Comparaison** : dump normalisé de `Fiches_Mvt` (la colonne `control`, SHA1, est comparée : elle
  doit être identique entre les deux clones). Après LETTRAGEMONTANT-003 le diff des lignes
  `Exec_SQL` est seulement informatif.
- **Cas non testable** : erreur sur `EcrResult` nul (A02) quand la première ligne du premier compte
  n'a pas de montant ; à reproduire seulement si une donnée NULL le permet (`montantd` NULL).
- **Assets (phase 2)** : jeux `.hidden/Tests/Compta/assets/lettragemontant_shared/lettragemontant_controle.sql` (T02, T03) et `lettragemontant_rien_a_lettrer/lettragemontant_tout_lettre.sql` (T04) ; scénarios `lettragemontant_clients_reference/`, `lettragemontant_fournisseurs/`, `lettragemontant_jeu_controle/`, `lettragemontant_rien_a_lettrer/`. Texte du Message.Info non comparé (seul le dump l'est). Observé dans ref (T03) : 411002 lettré en lot MA1 malgré une 1re ligne crédit (A01), 411003 : 2 groupes sur 3 lettrés (A04).
