# Ecritures — Tests

> Source : `.src/Compta/Utils/Ecritures.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran de consultation : tests `replay` depuis le menu ; on compare le contenu des grilles (capturé
dans le log replay ou par capture des `Exec_SQL`) et, pour la modification, le dump de `Fiches_Mvt`.
Données : `Laurux01.sql` + quelques écritures (une clôturée, une de trésorerie, une avec collectif,
une ligne au `control` altéré).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| ECRITURES-T01 | replay | Écran 1 par type | cliquer C, F, G, B | requêtes `Exec_SQL` et lignes affichées | `tests/soldes_types/` | à faire |
| ECRITURES-T02 | replay | Écran 2 et navigation | choisir un compte, précédent, suivant | extrait, solde progressif, lettrage | `tests/extrait/` | à faire |
| ECRITURES-T03 | replay | Écran 3 et clés | choisir une écriture (dont celle au `control` altéré) | lignes, clé mémorisée ≠ clé calculée | `tests/detail_cles/` | à faire |
| ECRITURES-T04 | replay | Modification via `Saisecrit` | écriture non clôturée, `Necrit`, modifier un libellé | dump `Fiches_Mvt`/`Fiches_MvtM` ; repositionnement | `tests/modif_saisecrit/` | à faire |
| ECRITURES-T05 | replay | Modification via `Tresor` | écriture de trésorerie, `Necrit` | dump ; repositionnement | `tests/modif_tresor/` | à faire |
| ECRITURES-T06 | replay | Écriture clôturée | clic sur une ligne clôturée | message d'erreur, pas de `Necrit` | `tests/cloturee/` | à faire |
| ECRITURES-T07 | replay | Retour arrière | `Button1` depuis les écrans 3 puis 2 | visibilité des grilles et boutons | `tests/retour/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone Laurux non modifié. Pour les reworks « SQL
  modifié » (ECRITURES-002), le diff `Exec_SQL` est informatif et la comparaison porte sur les
  lignes affichées.
- Les écrans `Saisecrit`/`Tresor` ont leurs propres tests ; T04/T05 ne vérifient que l'enchaînement.
