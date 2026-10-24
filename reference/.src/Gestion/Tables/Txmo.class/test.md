# Txmo — Tests

> Source : `.src/Gestion/Tables/Txmo.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran de paramétrage : l'essentiel est couvert par des **replays** (menu Gestion → Taux de
main-d'œuvre) comparant le dump normalisé de `Fiches_Txtmo` et `Fiches_Mo`. Le calcul de marge
devient testable en `gbtest` après la séparation traitement/GUI (TXMO-004).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| TXMO-T01 | replay | Création d'un taux | code `4`, libellé `Mecanique T4`, taux `40`, compte `706100`, prix de revient `20` (Entrée de zone en zone, Enregistrer) | ligne ajoutée dans `Fiches_Txtmo` ; `Fiches_Mo` inchangée | `tests/creation/` | à faire |
| TXMO-T02 | replay | Modification du taux avec répercussion | clic sur le code `1`, taux `28` → `30`, prix de revient `14` → `15`, Enregistrer | `Fiches_Txtmo` modifiée ; `mo_txht`, `mo_prvt`, `mo_marge` des MO `01` (temps) et `04` (forfait) recalculés | `tests/modif_repercussion/` | à faire |
| TXMO-T03 | replay | Contrôles de saisie | compte `999999` inexistant ; code vide avec compte valide ; taux non numérique | message compte inexistant et retour sur la zone ; message « champs obligatoires » **suivi** de `MajMo`/`Refresh` (A01 figée) ; dump identique hors effets figés | `tests/controles/` | à faire |
| TXMO-T04 | replay | Suppression | suppression du code `1` (utilisé par la MO `01`) puis d'un code créé non utilisé ; suppression avec ligne sélectionnée ≠ code saisi | refus avec message ; suppression effective ; A02 figée (ligne sélectionnée supprimée) | `tests/suppression/` | à faire |
| TXMO-T05 | replay | Liste des comptes | bouton liste et F2 sur le compte ; sélection Entrée et clic ; Échap | contenu de `Colcompt` (comptes 7 triés) ; compte recopié | `tests/liste_comptes/` | à faire |
| TXMO-T06 | gbtest | `MargeMo` (après TXMO-004) | temps : montant `1`, taux `28`, prvt `14` ; forfait : valeur HT `35`, taux `28`, prvt `14` ; taux `0` ; MO absente | `14`, `17,5`, `0`, `0` attendus (à confirmer dans le clone de référence) | `tests/marge_mo/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` contient 3 taux (`1`, `2`, `3`) et 4 MO (`01`-`03` « temps »,
  `04` forfait au taux `1`) : suffisant pour T01-T05, sans jeu dérivé.
- **Valeurs attendues** : produites en rejouant le scénario dans le clone **Laurux non modifié**,
  puis dump normalisé de `Fiches_Txtmo` et `Fiches_Mo` ; pour T06, les valeurs sont celles de
  `Calc_MargeMo` sur le clone de référence (via un replay instrumenté avant TXMO-004).
- **Locale** : `fr_FR.UTF-8` imposée (le taux est stocké en chaîne et formaté avec virgule).
- **Non testable automatiquement** : son, couleurs de focus ; sortie de zone à la souris sans
  validation (A03), sauf replay dédié avec clic.
