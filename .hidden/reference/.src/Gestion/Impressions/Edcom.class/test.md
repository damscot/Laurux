# Edcom — Tests

> Source : `.src/Gestion/Impressions/Edcom.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Tests `replay` (texte de `~/tmp/Commande.pdf` par `pdftotext -layout`, lignes `Exec_SQL`, dump
inchangé). Valeurs attendues produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EDCOM-T01 | replay | Choix à la souris | liste, clic sur la 1re commande (3 commandes de dates différentes), Imprimer | texte du PDF ; date = celle de la **dernière** commande listée (A02 figée) | `tests/choix_souris/` | implémenté |
| EDCOM-T02 | replay | Choix au clavier | liste, Entrée sur une commande, Imprimer | « Aucun mouvement » (`Codefour` vide, A01 figée) | `tests/choix_clavier/` | à faire : Entrée vers une ColumnView non rejouable ; pas d'équivalent gb.test : le choix (`Ncom.Text = Colcom.Item[2]`) est écrit dans `Colcom_KeyPress` sous `If Key.Code = Key.Enter` (aucun événement clavier en gb.test) |
| EDCOM-T03 | replay | Numéro saisi | numéro tapé dans `Ncom`, Imprimer | « Aucun mouvement » (A01) | `tests/numero_saisi/` | implémenté |
| EDCOM-T04 | replay | Réimpression | deux impressions successives | 2e PDF identique (fichier `.kdf`/PDF rouvert : sans effet visible) | `tests/reimpression/` | implémenté |
| EDCOM-T05 | replay | Saut de page | commande de 40 lignes | en-têtes répétés | `tests/saut_page/` | implémenté |
| EDCOM-T06 | replay | Fournisseur supprimé | commande dont le fournisseur n'existe plus ; ouvrir la liste | erreur à l'ouverture de la liste (A03 figée) | `tests/fournisseur_absent/` | implémenté |

## Détail des tests

- **Données** : jeu `editions_gestion` (voir [Edbr](../Edbr.module/test.md)) : 3 commandes
  `Fiches_Entcom`/`Fiches_Ligcom` de dates distinctes pour 2 fournisseurs, une de 40 lignes, une
  orpheline ; société avec tous les champs d'en-tête renseignés.
- **Comparaison** : `pdftotext` (date d'édition masquée) ; `Exec_SQL` (N+1 lectures fournisseur).
- **Non testable automatiquement** : logo (non imprimé), son.

- **Implémentation (vague 5)** : jeu `.hidden/Tests/Gestion/assets/edcom_shared/edcom_base.sql` (C1, C3 de 40 lignes
  pour 401001, C2 pour 401002 ; quantités NULL, voir ci-dessous) ; scénarios `edcom_choix_souris` (T01),
  `edcom_numero_saisi` (T03, lecture seule), `edcom_reimpression` (T04), `edcom_saut_page` (T05, « Page 1/2 » et
  « Page 2/2 »), `edcom_fournisseur_absent` (T06, jeu `edcom_orphelin.sql`, code de sortie 125
  `ToggleButton1_Click.100: Result is not available`). Texte du PDF par `pdftotext` dans `edition.txt`.
- **Quantités décimales** : avec `qte` renseigné (decimal lu « 2.000 »), `Val(qte)` vaut Null en fr_FR et
  `Button2_Click` échoue (« Type mismatch: wanted Number, got Null », ligne `totht = …`) : le jeu laisse `qte` à NULL
  (imprimé « 1 »). Candidat anomalie.
