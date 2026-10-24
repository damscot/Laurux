# CoefTypeC — Tests

> Source : `.src/Gestion/Tables/CoefTypeC.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran de table : tests `replay` avec diff de `Fiches_CoeffTypec`. Valeurs attendues produites
dans le clone **Laurux non modifié** (anomalies figées).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| COEFTYPEC-T01 | replay | Création | menu ; type `01` (liste `Coltype`), famille `F1` (liste `Colfam`), coefficient `1,8` ; Entrée sur le bouton | ligne `Fiches_CoeffTypec` ; liste rafraîchie | `tests/creation/` | à faire |
| COEFTYPEC-T02 | replay | Modification | clic sur une ligne, coefficient `2` ; Enregistrer | `coeff` mis à jour | `tests/modification/` | à faire |
| COEFTYPEC-T03 | replay | Saisie invalide | type `ZZ` et famille inexistants, coefficient `abc` ; Enregistrer | bulles d'erreur ; ligne enregistrée quand même avec `coeff` NULL (COEFTYPEC-A01 figée) | `tests/saisie_invalide/` | à faire |
| COEFTYPEC-T04 | replay | Suppression | clic sur une ligne, Supprimer, Oui | ligne supprimée | `tests/suppression/` | à faire |
| COEFTYPEC-T05 | replay | Mode article | depuis la fiche article A1 (bouton coefficients par type), clic sur une ligne ; fermer ; rouvrir depuis le menu | libellés du panneau (PV HT, PV TTC) ; panneau encore visible depuis le menu (A02 figée) ; libellés après Enregistrer (A03) | `tests/mode_article/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` (types de client, familles) + 2 lignes `Fiches_CoeffTypec` ; un
  article A1 avec prix de revient et TVA pour T05.
- **Comparaison** : dump normalisé de `Fiches_CoeffTypec` ; libellés du panneau et contenu de
  la liste relevés par le replay.
- **gb.test** : après COEFTYPEC-005, `PrixProduit(pa, coeff, tva)` (chaînes à virgule, arrondi à
  2 décimales).
- **Non testable** : bulles (`Balloon`) autrement que par leur présence dans le journal, son.
