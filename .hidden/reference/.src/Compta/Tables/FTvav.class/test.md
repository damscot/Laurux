# FTvav — Tests

> Source : `.src/Compta/Tables/FTvav.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran de saisie avec traitement de masse : `replay` avec diff des tables, `gbtest` sur l'arrondi
extrait (FTVAV-005). Valeurs attendues produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FTVAV-T01 | replay | Création d'un code | menu TVA ventes ; code `4`, taux `10`, compte `445740` (clic Enregistrer) | ligne ajoutée dans `Fiches_Tvaav` ; question de recalcul répondue Non | `tests/creation/` | à faire |
| FTVAV-T02 | replay | Modification de taux sans recalcul | code `3`, `20` → `21`, réponse Non | taux restauré (`20,00`) puis enregistrement inchangé | `tests/modif_sans_recalcul/` | à faire |
| FTVAV-T03 | replay | Modification de taux avec recalcul | code `3`, `20` → `21`, réponse Oui | diff de `Fiches_Tvaav`, `Fiches_Comptes`, `Fiches_Fam`, `Fiches_Ligbl`, `Fiches_LigblM`, `Fiches_Art`, `Fiches_Mo` | `tests/modif_avec_recalcul/` | à faire |
| FTVAV-T04 | replay | Compte TVA déjà attribué | code `4` avec le compte du code `3`, nouveau taux, Oui | refus d'enregistrement **après** recalcul (A01 figée) | `tests/compte_deja_attribue/` | à faire |
| FTVAV-T05 | replay | Suppression, clavier, liste | suppression refusée/acceptée ; touche quelconque sur Enregistrer ; F2 sur le compte | diff `Fiches_Tvaav` ; enregistrement sans recalcul (A02) ; contenu de `Tvavlist` | `tests/suppression_clavier/` | à faire |
| FTVAV-T06 | gbtest | `ArrondiPrix` (après FTVAV-005) | prix `12.48`, `12.43`, `12.20`, `12.80`, `0`, négatif × arrondis `0,01`/`0,05`/`0,10`/`0,50`/`1,00` × formats `0`/`0.00`/`0.000` | chaînes de référence | `tests/arrondi/` | à faire |
| FTVAV-T07 | replay | Performance du recalcul | base dérivée : 5 000 lignes de BL non facturés au code `3` | durée de référence (`gbx3 -p`) ; dump identique au clone de référence | `tests/perf_recalcul/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` ; jeu dérivé pour T03/T04/T07 (script SQL) : familles, articles
  avec arrondis `0,05` et `0,50`, main-d'œuvre, BL et bons d'entretien non facturés avec lignes `A`
  et `M` au code `3`.
- **Comparaison** : dump normalisé des tables listées ; T06 compare des chaînes exactes (la virgule
  dépend de la locale `fr_FR.UTF-8`, imposée par le harnais).
- **Non testable** : erreur de `Recalcul` sur un article supprimé référencé par un bon d'entretien
  (A04) sauf jeu dédié ; son et couleurs.
