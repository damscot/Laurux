# FComptes — Tests

> Source : `.src/Compta/Tables/FComptes.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI complexe : `replay` avec diff de `Fiches_Comptes`, `Fiches_SousComptes`,
`Fiches_Analytiques` ; `gbtest` sur les fonctions extraites (`TypeParNumero`,
`RepartitionEquilibree`). Valeurs attendues produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FCOMPTES-T01 | replay | Création de comptes avec forçage du type | menu Plan comptable ; `606100` type `B` ; `512100` type `G` ; `801000` vide ; `901000` `G` | types forcés `G`, `B`, `B`, `A` ; messages ; lignes créées | `.hidden/Tests/Compta/assets/fcomptes_creation_type_force/` | implémenté |
| FCOMPTES-T02 | replay | Refus d'enregistrement | type `F` ; type `C` sans collectif ; case collectif cochée ; `411200` type `G` ; code vide | messages, aucune écriture | `.hidden/Tests/Compta/assets/fcomptes_refus/` | implémenté (4112 type G forcé B puis **créé** : comportement figé, voir Détail) |
| FCOMPTES-T03 | replay | Modification avec TVA | compte 707 : F2 TVA ventes, choix du code 3 ; F2 TVA achats ; Enregistrer | `code_tvente`, `taux_tvente`, `gen_tv`… ; formes des booléens en base | `.hidden/Tests/Compta/assets/fcomptes_modification_tva/` | implémenté (boutons TVA au lieu de F2) |
| FCOMPTES-T04 | replay | Type `A` et drapeau `Enr` | type `A` saisi après un code TVA invalide, puis après un code valide | pas d'enregistrement puis enregistrement (A04 figée) | `.hidden/Tests/Compta/assets/fcomptes_drapeau_enr/` | implémenté |
| FCOMPTES-T05 | replay | Suppression | compte libre ; compte mouvementé (Mvt3) ; compte de famille ; code saisi ≠ ligne sélectionnée | suppression (+ `Fiches_SousComptes`) ; refus ; refus ; suppression de la ligne sélectionnée (A03) | `.hidden/Tests/Compta/assets/fcomptes_suppression/` | implémenté |
| FCOMPTES-T06 | replay | Sous-comptes | compte principal coché ; ajout de 2 sous-comptes (F2 `TriCpt`) ; touche quelconque puis Suppr dans la liste | lignes `Fiches_SousComptes` ; question à chaque touche (A01) | `.hidden/Tests/Compta/assets/fcomptes_sous_comptes/` | implémenté (saisie directe au lieu de F2 ; Suppr sans effet au clavier, voir Détail) |
| FCOMPTES-T07 | replay | Analytique | option `/Soc01/Analytique` active ; compte 6xx : postes 60 % + 40 % ; puis 60 % seul ; suppression de tous les postes ; fermeture | `Fiches_Analytiques` ; fermeture refusée puis bloquée (A02 figée) | `.hidden/Tests/Compta/assets/fcomptes_analytique/` | implémenté (postes ramenés à 0 % au lieu de supprimés, voir Détail) |
| FCOMPTES-T08 | replay | Recherche et tri | clic et saisie dans `CO`, `INTIT`, double-clic | contenu de la grille (relevé) | `.hidden/Tests/Compta/assets/fcomptes_recherche/` | implémenté (sans double-clic, non rejoué) |
| FCOMPTES-T09 | replay | Ouverture depuis la saisie | `Saisecrit`, compte inexistant en Gestion → création | compte créé ; retour à la saisie | `tests/depuis_saisie/` | à faire : ouverture par F4 dans Saisecrit (touche F4 non rejouée) |
| FCOMPTES-T10 | gbtest | `TypeParNumero` (après FCOMPTES-007) | codes `100`…`999` par tranches × types `""`, `B`, `G`, `A` | type résultant et indicateur d'avertissement | `tests/type_par_numero/` | à faire : exige l'extraction FCOMPTES-007 (TypeParNumero n'existe pas encore) |
| FCOMPTES-T11 | gbtest | `RepartitionEquilibree` (après FCOMPTES-008) | totaux 0, 60, 100, 99.99, 100.00000001 ; 0 ou n postes ; état précédent | valeur de `Qpostes` identique à `Quitter_Postes` | `tests/repartition/` | à faire : exige l'extraction FCOMPTES-008 (RepartitionEquilibree n'existe pas encore) |

## Détail des tests

- **Données** : `Laurux01.sql` ; jeux dérivés : écriture sur un compte dans `Fiches_Mvt3`, famille
  utilisant un compte, postes analytiques, option `Analytique` dans `Laurux.conf` du test.
- **Comparaison** : dump normalisé de `Fiches_Comptes`, `Fiches_SousComptes`, `Fiches_Analytiques` ;
  grille relevée par le replay pour T08.
- **Non testable automatiquement** : couleurs de focus (`ObsGotf`), son.
- **Couverture visée** : toutes les branches de `Button2_Click` et `Button1_Click`.

### Implémentation (phase 2, agent 5)

- Scénarios sous `.hidden/Tests/Compta/assets/fcomptes_*/` ; fenêtre rejouée `Fcomptes` (nom réel de la fenêtre,
  pas `FComptes`) ; menu Fichiers › Comptes (`Fmenu#Menu67#Menu11#Menu114`).
- Jeux de données : `.hidden/Tests/Compta/assets/fcomptes_shared/fcomptes_base.sql` (comptes libres 606900/606950, sous-compte 606900→606100,
  écriture sur 604000 dans `Fiches_Mvt3`, postes 01/02) ; `.hidden/Tests/Compta/assets/fcomptes_analytique/fcomptes_analytique.sql` (postes 01/02 et
  option `/Soc01/Analytique` posée par le blob `conf` de `Fiches_Parametres`, appliqué par `Fmenu` au démarrage).
- Retaper dans un champ déjà rempli : le `Focus` rejoué ne sélectionne pas toujours le texte ; le scénario efface
  par BackSpace avant de saisir.
- T02 : `4112` saisi en type `G` est d'abord forcé en `B` (règle des comptes de bilan 402–411) ; le contrôle
  « 401/411 non `B` » ne se déclenche donc plus et le compte est **créé** en `B`. Figé (candidat anomalie).
- T06/T07 : `Vents_KeyPress`/`Postes_KeyPress` lisent `Key.Code` **après** la `Message.Question` ; quand la
  réponse est donnée au clavier (Entrée), `Key.Code` vaut Entrée et la suppression n'a jamais lieu (seul un clic
  souris sur « Oui » supprime). Figé : Suppr + « Oui » au clavier ne supprime rien (candidat anomalie, s'ajoute à A01).
  T07 ramène donc les postes à 0 % au lieu de les supprimer : fermeture refusée à 60 %, puis toujours refusée à
  0 % (A02). Les grilles `Vents`/`Postes` n'ont pas de handler `_Click` (REPLAYOBSERVER-A06) : pas de clic.
