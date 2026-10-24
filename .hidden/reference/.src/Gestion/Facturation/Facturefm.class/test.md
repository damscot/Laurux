# Facturefm — Tests

> Source : `.src/Gestion/Facturation/Facturefm.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI : tests `replay` depuis Gestion › Facturation › Factures fin de mois, sur le jeu
`facturation_base` ([ObjFac.class/test.md](../ObjFac.class/test.md)) avec des BL répartis sur
le mois et des clients `cli_regr` = S/D/Q/M, tournées, types et commerciaux. Comparaisons :
contenu des tables de travail `Facturefm` et `Bl` (dump dédié, trié), contenu affiché de
`Colbl`/`Coldetail` (journal de rejeu), dump normalisé (tables de travail exclues).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FACTUREFM-T01 | replay | Tous clients, sans regroupement | date de fin = fin de mois, `Traiter` | `Facturefm`/`Bl` ; totaux HT/TTC par client | `tests/tous_sans_regroupement/` | à faire |
| FACTUREFM-T02 | replay | Regroupement décade / quinzaine / mensuel | périodes cohérentes puis incohérentes | sélection par `BETWEEN` ; messages (A01 : traitement poursuivi) | `tests/regroupements/` | à faire |
| FACTUREFM-T03 | replay | Un client | `RadioButton2`, code saisi puis via `TriCpt` | BL du client seulement ; filtres `$sreq` ignorés (figé) | `tests/un_client/` | à faire |
| FACTUREFM-T04 | replay | Clients divers | case `Divers` | une ligne par code + nom | `tests/clients_divers/` | à faire |
| FACTUREFM-T05 | replay | Filtres tournée, type client, commercial | chaque filtre seul | sous-ensembles attendus | `tests/filtres/` | à faire |
| FACTUREFM-T06 | replay | Frais de gestion | client avec 3 BL dont 2 avec `gestbl` | frais comptés une fois (`totf`, `tottc`, `gestbl`) | `tests/frais_gestion/` | à faire |
| FACTUREFM-T07 | replay | Type de facture Boissons / Autres | `Utils.Option` = B, clients paysage/portrait | clients retirés selon l'orientation | `tests/type_facture/` | à faire |
| FACTUREFM-T08 | replay | Retraits | Suppr sur un client puis sur un BL | lignes supprimées de `Facturefm`/`Bl` ; totaux affichés recalculés | `tests/retraits/` | à faire |
| FACTUREFM-T09 | replay | Entretien | case `Checentr` | sélection dans `Fiches_BlM`/`Fiches_LigblM` ; `OptFac` reçoit `"M"` | `tests/entretien/` | à faire |
| FACTUREFM-T10 | replay | Édition | `Imprimer` → `OptFac` → `edite` | factures émises, écritures, `Fiches_Bl` (`numfac`, `imp`) : dump complet | `tests/edition_fin_de_mois/` | à faire |
| FACTUREFM-T11 | replay | Date en période close | date antérieure à la clôture de facturation | message de `VerifDate`, aucun traitement | `tests/periode_close/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone Laurux non modifié (MariaDB Docker), date
  figée (`faketime`) : `_New` propose le dernier jour du mois courant.
- **Données** : jeu `facturation_base` + 3 clients par périodicité (`cli_regr`), BL datés des
  1, 10, 11, 15, 16, 20, 21 et dernier jour du mois ; un client avec 3 BL dont 2 portent des frais.
- `Utils.orientation` (T07) dépend de la configuration des clients (à préparer dans le jeu).
- T10 recouvre OPTFAC-T06 et les tests d'`ObjFacB.editefm` : à mutualiser en phase 2.
