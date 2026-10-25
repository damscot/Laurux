# Edcom — Tests

> Source : `.src/Gestion/Impressions/Edcom.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Tests `replay` (texte de `~/tmp/Commande.pdf` par `pdftotext -layout`, lignes `Exec_SQL`, dump
inchangé). Valeurs attendues produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EDCOM-T01 | replay | Choix à la souris | liste, clic sur la 1re commande (3 commandes de dates différentes), Imprimer | texte du PDF ; date = celle de la **dernière** commande listée (A02 figée) | `tests/choix_souris/` | à faire |
| EDCOM-T02 | replay | Choix au clavier | liste, Entrée sur une commande, Imprimer | « Aucun mouvement » (`Codefour` vide, A01 figée) | `tests/choix_clavier/` | à faire |
| EDCOM-T03 | replay | Numéro saisi | numéro tapé dans `Ncom`, Imprimer | « Aucun mouvement » (A01) | `tests/numero_saisi/` | à faire |
| EDCOM-T04 | replay | Réimpression | deux impressions successives | 2e PDF identique (fichier `.kdf`/PDF rouvert : sans effet visible) | `tests/reimpression/` | à faire |
| EDCOM-T05 | replay | Saut de page | commande de 40 lignes | en-têtes répétés | `tests/saut_page/` | à faire |
| EDCOM-T06 | replay | Fournisseur supprimé | commande dont le fournisseur n'existe plus ; ouvrir la liste | erreur à l'ouverture de la liste (A03 figée) | `tests/fournisseur_absent/` | à faire |

## Détail des tests

- **Données** : jeu `editions_gestion` (voir [Edbr](../Edbr.module/test.md)) : 3 commandes
  `Fiches_Entcom`/`Fiches_Ligcom` de dates distinctes pour 2 fournisseurs, une de 40 lignes, une
  orpheline ; société avec tous les champs d'en-tête renseignés.
- **Comparaison** : `pdftotext` (date d'édition masquée) ; `Exec_SQL` (N+1 lectures fournisseur).
- **Non testable automatiquement** : logo (non imprimé), son.
