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
| FACTUREFM-T01 | replay | Tous clients, sans regroupement | date de fin = fin de mois, `Traiter` | `Facturefm`/`Bl` ; totaux HT/TTC par client | `tests/tous_sans_regroupement/` | implémenté (`Gestion/facturefm_tous_sans_regroupement`) |
| FACTUREFM-T02 | replay | Regroupement décade / quinzaine / mensuel | périodes cohérentes puis incohérentes | sélection par `BETWEEN` ; messages (A01 : traitement poursuivi) | `tests/regroupements/` | implémenté pour Mensuel (`Gestion/facturefm_regroupements`) ; à faire : Décade et Quinzaine (même code, à ajouter si besoin) |
| FACTUREFM-T03 | replay | Un client | `RadioButton2`, code saisi puis via `TriCpt` | BL du client seulement ; filtres `$sreq` ignorés (figé) | `tests/un_client/` | implémenté pour le code saisi (`Gestion/facturefm_un_client`) ; à faire : sélection via `TriCpt` |
| FACTUREFM-T04 | replay | Clients divers | case `Divers` | une ligne par code + nom | `tests/clients_divers/` | implémenté (`Gestion/facturefm_clients_divers`) |
| FACTUREFM-T05 | replay | Filtres tournée, type client, commercial | chaque filtre seul | sous-ensembles attendus | `tests/filtres/` | implémenté pour type client et commercial (`Gestion/facturefm_filtres`) ; à faire : tournée (`Rechtour`) |
| FACTUREFM-T06 | replay | Frais de gestion | client avec 3 BL dont 2 avec `gestbl` | frais comptés une fois (`totf`, `tottc`, `gestbl`) | `tests/frais_gestion/` | implémenté (`Gestion/facturefm_frais_gestion`) |
| FACTUREFM-T07 | replay | Type de facture Boissons / Autres | `Utils.Option` = B, clients paysage/portrait | clients retirés selon l'orientation | `tests/type_facture/` | à faire : jeu avec `Utils.Option` = B et orientations clients à préparer |
| FACTUREFM-T08 | replay | Retraits | Suppr sur un client puis sur un BL | lignes supprimées de `Facturefm`/`Bl` ; totaux affichés recalculés | `tests/retraits/` | implémenté (`Gestion/facturefm_retraits`) |
| FACTUREFM-T09 | replay | Entretien | case `Checentr` | sélection dans `Fiches_BlM`/`Fiches_LigblM` ; `OptFac` reçoit `"M"` | `tests/entretien/` | implémenté pour la sélection `Fiches_BlM` (`Gestion/facturefm_entretien`) ; à faire : `OptFac` avec « M » (édition, passe par `ObjFac`, écran complexe) |
| FACTUREFM-T10 | replay | Édition | `Imprimer` → `OptFac` → `edite` | factures émises, écritures, `Fiches_Bl` (`numfac`, `imp`) : dump complet | `tests/edition_fin_de_mois/` | à faire : édition par `OptFac` → `ObjFac`/`ObjFacB` (classe complexe exclue) |
| FACTUREFM-T11 | replay | Date en période close | date antérieure à la clôture de facturation | message de `VerifDate`, aucun traitement | `tests/periode_close/` | implémenté (`Gestion/facturefm_periode_close`) |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone Laurux non modifié (MariaDB Docker), date
  figée (`faketime`) : `_New` propose le dernier jour du mois courant.
- **Données** : jeu `facturation_base` + 3 clients par périodicité (`cli_regr`), BL datés des
  1, 10, 11, 15, 16, 20, 21 et dernier jour du mois ; un client avec 3 BL dont 2 portent des frais.
- `Utils.orientation` (T07) dépend de la configuration des clients (à préparer dans le jeu).
- T10 recouvre OPTFAC-T06 et les tests d'`ObjFacB.editefm` : à mutualiser en phase 2.

- **Assets** (`.hidden/Tests/Gestion/assets/`) : jeu `facturefm_shared/bl_juin.sql` (clients 411901 DURAND `S`
  type 01 commercial 01, 411902 MARTIN `S` type 02, 411903 PETIT `M`, divers 411001 ; BL B00001–B00008 de juin
  2018, B00009 facture imprimée exclue ; frais `gestbl` 5,00 sur B00002/B00003 ; `dtepec` = `06.2018` pour que
  `VerifDate.ClotGestion` accepte juin, sinon toute date de juin est refusée). Date figée 2018-06-15, fin proposée
  30.06.2018. Les tables de travail `Facturefm` et `Bl` sont dans le dump.
- Rejeu : `Colbl`/`Coldetail` ne reçoivent la touche Suppr qu'après un `Focus` ; la clé de `Colbl` est
  `code & nom` après `recup_bl` mais `code` seul après `affclient` (retrait).
- Comportements figés (candidats anomalies) : `Bl.nom` garde le nom du client précédent hors clients divers
  (B00004 de MARTIN enregistré « DURAND ») ; les frais TTC ne sont pas déduits du 2e BL quand `totfrais` ne
  trouve pas de TVA des frais (`tottc` = 228,00 au lieu de 222,00, `ht` B00003 = 30,00 mais `ttc` = 42,00).
