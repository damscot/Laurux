# FTvac — Tests

> Source : `.src/Compta/Tables/FTvac.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran de saisie d'une table : tests `replay` avec diff des tables `Fiches_Tvaac` et
`Fiches_Comptes`. Valeurs attendues produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FTVAC-T01 | replay | Création d'un code | menu TVA achats ; code `4`, taux `10`, compte `445660` ; Enregistrer (clic) | ligne ajoutée dans `Fiches_Tvaac` (`taux_tva` tel que saisi après `PointBase`) | `tests/creation/` | à faire |
| FTVAC-T02 | replay | Modification de taux | sélection du code `2`, taux `5,5` → `6` ; Enregistrer | `Fiches_Tvaac` et `Fiches_Comptes.taux_tachat` des comptes `code_tachat = 2` | `tests/modification_taux/` | à faire |
| FTVAC-T03 | replay | Suppression refusée puis acceptée | code utilisé par un compte, puis code inutilisé | message « utilisée par le compte … » ; ligne supprimée ensuite | `tests/suppression/` | à faire |
| FTVAC-T04 | replay | Saisie au clavier et compte inexistant | Entrée sur chaque zone ; compte `999999` ; touche quelconque sur Enregistrer | focus bloqué sur le compte, compte inexistant enregistré (A01, A04 figées) | `tests/saisie_clavier/` | à faire |
| FTVAC-T05 | replay | Liste des comptes | F2 avec compte vide, puis avec `4456` ; Entrée sur un compte | contenu de `Tvalist3` ; compte recopié | `tests/liste_comptes/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` (codes 1 à 3 de `Fiches_Tvaac`) ; T02/T03 ajoutent par SQL un compte
  `6xx` avec `code_tachat` renseigné.
- **Comparaison** : dump normalisé de `Fiches_Tvaac` et de `Fiches_Comptes` ; contenu des listes
  relevé par le replay pour T05.
- **Non testable** : le son et la couleur de fond des zones.
