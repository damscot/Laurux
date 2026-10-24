# Suivi — Tests

> Source : `.src/Gestion/Suivi.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| SUIVI-T01 | replay | Création d'un suivi sur devis | Facture en mode devis, client et devis existants, F12 ; saisir Qte 10, Ach 100, Vtes 250 ; Enregistrer | ligne `Fiches_Suivis` identique à la référence ; textes affichés (TotMo, MargeMo, MargeArt, TotMarge) | `tests/creation_devis/` | à faire |
| SUIVI-T02 | replay | Saisie du réalisé sur facture | même devis transformé en facture non imprimée, F12 ; saisir Qte2, Ach2, Vtes2 ; Enregistrer | `UPDATE` de la ligne existante ; écarts `EmargeMO`/`EmargeArt`/`EmargeTot` affichés | `tests/realise_facture/` | à faire |
| SUIVI-T03 | replay | Consultation depuis les archives | `Archives`, facture archivée avec suivi, F12 | champs en lecture seule, valeurs chargées par `numfac` | `tests/consultation_archive/` | à faire |
| SUIVI-T04 | gbtest | Calculs de marge et écarts | après SUIVI-005 : `MargeMo(10, 45, 30)`, `MargeArt(250, 100)`, écarts positifs, négatifs et nuls | valeurs Float de référence ; textes `EmargeMO`/`EmargeArt` identiques à ceux de T01/T02 (signes opposés figés, anomalie A02) | `tests/calculs_marge/` | à faire |
| SUIVI-T05 | replay | Prix de revient MO nul | `Fiches_Txtmo.prvt_txtmo = 0` pour le code MO, suivi existant | avertissement ; champs vides (fige A01) ; pas d'écriture si on quitte | `tests/prix_revient_nul/` | à faire |
| SUIVI-T06 | replay | Suppression | suivi existant, Supprimer → Oui | ligne supprimée (`numdev` + `code`) ; dump identique | `tests/suppression/` | à faire |
| SUIVI-T07 | replay | Même n° de devis pour deux clients | deux lignes `Fiches_Suivis` de même `numdev`, codes différents ; modifier l'une | fige A03 : `UPDATE` des deux lignes | `tests/numdev_partage/` | à faire |
| SUIVI-T08 | replay | Code MO absent des préférences | `/Soc01/CodeMO` vide | avertissement « taux de MO non défini », aucun chargement | `tests/codemo_absent/` | à faire |

## Détail des tests

- **Valeurs attendues** : jouées dans le clone **Laurux non modifié** (dump normalisé de
  `Fiches_Suivis` et capture des textes des contrôles via le journal `Utils.Observers`).
- **Données** : `Laurux01.sql` + jeu dérivé : un code MO dans `Fiches_Txtmo` (taux et prix de
  revient), `/Soc01/CodeMO` dans `Laurux.conf`, un devis et une facture pour le même client, une
  facture archivée (T03).
- T04 n'est possible qu'après la séparation traitement/GUI (fonctions pures) ; avant, les calculs
  sont couverts par T01/T02.
- Les chemins d'ouverture passent par `Facture` (module complexe) : scénarios minimaux (ouvrir le
  document, F12), sans modifier le document.
