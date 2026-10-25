# VarMajTar — Synthèse

> Source : `.src/Gestion/Stock/VarMajTar.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

État tarifaire d'une ligne de saisie d'achat (réception, commande fournisseur). Une instance par
ligne, créée par `Achat.ajout` et rangée dans `Sailig.AutresObj[Achat.Tarif]`. Elle charge la
fiche article et les tarifs de vente provisoires (`Fiches_TarTemp`) : tarif général, tarifs
clients, tarifs par type de client, avec recalcul des prix HT/TTC, pour l'écran `GesTar`.

## Points clés

- `LecArt` : une requête directe (`Fiches_Art` + `Fiches_Tvaav` + `Fiches_TarTemp`) et deux
  requêtes **préparées** (`requ_cli`, `requ_typ`) créées par `commande1._new`.
- Cascade de prix `LPrix(pxrev, 1, art_cdarr)` + remise négative (= marge) + TVA : forme de
  référence de la fabrique `PrixVente` proposée par GESTAR-008.
- `Delete` et `SauvColl` sont appelées dynamiquement (`Sailig.Delete`, `GesTar.class:230` via
  `Variant`) : les signaux `unused` de `deps.py` sont des faux positifs.

## Dépendances principales

- Utilisé par : `GesTar` (toutes les propriétés, `LecArt`, `SauvColl`), `Achat` (création,
  `IgnoreTarif`), `Sailig` (`Delete`).
- Utilise : `Utils.db` (`Exec`, `Set`, `Execute`), `LPrix`, `LTaxe`, `LDate`, `ObjProp`,
  `Sailig`, `SaiTableau`, énumérations de `GesTar`.

## Risques

- **SQLite** : `DB_Connection.Execute` est cassé (DB_CONNECTION-A05) ; le panneau tarif des
  achats échoue (VARMAJTAR-A02).
- Drapeau `sup` des tarifs client/type lu sur la mauvaise ligne (VARMAJTAR-A01).
- Marge négative concaténée en `"--x%"` (VARMAJTAR-A03, à confirmer).
- Couplage fort avec `GesTar`/`Achat`/`commande1` : rework à mener dans leur lot.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 137 |
| Lignes de commentaire | 3 |
| Fonctions | 6 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 36 |
| Complexité max (fonction) | 15 (`LecArt`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

7 tests : 5 replays de l'écran d'achat (tarif général, tarifs clients/types, drapeau `sup`,
SQLite, appels dynamiques) à intégrer aux scénarios validés d'`Achat` ; 2 gb.test sur la cascade
`LPrix`/`LTaxe` (dont le jeu partagé avec GESTAR/DATETAR pour l'équivalence `PrixVente`).

## Rework

6 étapes (VARMAJTAR-001 à 006) : documentation des appels dynamiques, code mort local,
substitution par `PrixVente` après preuve, découpage de `LecArt`, `Cbase.Table`, séparation des
lectures de contrôles. 3 anomalies (A01 à A03) soumises à validation.
