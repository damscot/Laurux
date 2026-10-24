# Facturergbl — Tests

> Source : `.src/Gestion/Facturation/Facturergbl.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI : tests `replay` depuis Gestion › Facturation › Regroupement des BL, sur le jeu
`facturation_base` ([ObjFac.class/test.md](../ObjFac.class/test.md)) complété de clients ayant
2 à 3 BL `B` sans ticket (dont des articles identiques, des lignes `M`, `T`, `O`). Comparaisons :
dump normalisé (`Fiches_Bl`, `Fiches_Ligbl`, `Fiches_Parametres.dnbon`, `Fiches_Docactif`),
tables de travail, journal de rejeu.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FACTURERGBL-T01 | replay | Sélection | date fin de mois, `Traiter` | `Facturefm`/`Bl` ; seuls les clients à plusieurs BL listés | `tests/selection/` | à faire |
| FACTURERGBL-T02 | replay | Regroupement d'un client sans fusion | `RadioButton2`, clic client, `Regrouper`, Oui | nouveau BL `dnbon + 1`, lignes `A`/`C` recopiées avec commentaires « Regroupement BL n° », BL sources supprimés, `dnbon` mis à jour | `tests/regroupement_client/` | à faire |
| FACTURERGBL-T03 | replay | Regroupement de tous les clients | `RadioButton1`, `Regrouper` | un BL par client ; numérotation à partir de `dnbon + 2` (A04 figée) | `tests/regroupement_tous/` | à faire |
| FACTURERGBL-T04 | replay | Fusion des articles | `Fusion_art` coché, deux lignes identiques | figer l'erreur « champ inconnu `mrgart_ligbl` » (A02) | `tests/fusion_articles/` | à faire |
| FACTURERGBL-T05 | replay | Retraits | Suppr client, Suppr BL | tables de travail ; colonne Ville modifiée (A05 figée) | `tests/retraits/` | à faire |
| FACTURERGBL-T06 | replay | Aucun client sélectionné | `RadioButton2` sans clic, `Regrouper` | aucun BL créé ; `dnbon` incrémenté (A04 figée) | `tests/sans_selection/` | à faire |
| FACTURERGBL-T07 | replay | `Ent_Bl` depuis la caisse | moulinage d'un ticket réglant 2 BL (scénario de `Moulinage`) | BL regroupé avec la ligne « Règlement en Caisse par le Ticket n° … » ; entête (`htbl`, `ech`, marges) figée (A05) | `tests/ent_bl_caisse/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone Laurux non modifié (MariaDB Docker), date figée
  (`faketime`).
- T07 est partagé avec les tests de `Moulinage` (lot Caisse) : à implémenter une seule fois.
- **Verrous** (A03) : non observables par un replay mono-poste ; un test à deux connexions
  simultanées serait nécessaire (hors harnais actuel, à décider).
- La chaîne d'édition (`Button14_Click`) étant inatteignable depuis l'interface, elle n'est pas
  testée ; si elle était réactivée (A01), ses tests seraient à écrire.
- `lpc` doit être présent (ou simulé) sur le poste de test : `_New` l'exécute.
