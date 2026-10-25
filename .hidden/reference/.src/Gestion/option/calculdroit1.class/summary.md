# calculdroit1 — Synthèse

> Source : `.src/Gestion/option/calculdroit1.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Seconde version du calcul des **droits sur les alcools** (option boissons), sous forme d'objet prix :
la classe hérite de `LPrix` et rattache au prix unitaire les taxes `Regie` (droit), `SS` (cotisation
sécurité sociale), `DA` (accise facturée) et `TVA`, d'après la régie de l'article (`Fiches_regie`).
Classe mère de `Consigne` ; utilisée par `Moulinage` (caisse) et `Achat` (réception).

## Points clés

- Assiette : volume (`vol / 100` litres) ou alcool pur (× degré) selon `ap` ; droit = assiette ×
  `tauxa / 100` ; sécu si degré > seuil `degres` ; accise différenciée si `drfac` ; droits ajoutés
  au prix en régime suspendu.
- Montants **unitaires** ; totaux par les propriétés `Tot*` de `LPrix`.
- Coexiste avec `calculdroit` (calcul `Float` sur quantité totale, 14 appelants) : seulement
  7 lignes textuellement communes, mais mêmes règles et mêmes 3 `SELECT`.

## Dépendances principales

- Utilise : `LPrix` (héritage), `LTaxe`, `Utils.Option`, `Utils.db` ; tables `Fiches_regie`,
  `Fiches_Tvaav`, `Fiches_Parametres` (`tvass`).
- Utilisé par : `Consigne` (héritage) et donc `Achat`/`ValidBR1`, `Moulinage`.

## Risques

- **Drapeau `opt` faux** (l. 33, vérifié `gbs3`) : en option `B` seule, aucun droit n'est calculé
  ni enregistré ; seule l'option `T` active le calcul.
- `Error.Raise` à deux arguments : message remplacé par « Too many arguments ».
- Écriture de `volume`/`degre` sans régie lue → « Null object » (à confirmer dans `Achat`).
- Volume enregistré par `Achat` probablement multiplié deux fois par la quantité (à reporter dans
  Achat).
- Tables de l'option absentes de `db_control.csv` et de `Laurux01.sql`.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 167 |
| Lignes de commentaire | 1 |
| Fonctions | 17 |
| Fonctions Public | 5 |
| Complexité cyclomatique totale | 50 |
| Complexité max (fonction) | 7 (`LecDra`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

10 tests (CALCULDROIT1-T01 à T10) : 9 `gbtest` (drapeau d'option, volume, droit, seuil de sécu,
accise, taxes rattachées, erreurs, propriétés) et 1 replay de moulinage caisse (lot Caisse).

## Rework

7 étapes (CALCULDROIT1-001 à 007) : documentation, `taxe_droit` en `Private`, variable `famille`
et propriétés `droit`/`secu` sans lecteur, factorisation des propriétés, `Cbase.Table`, lecture de
régie commune avec `calculdroit`. 4 anomalies (A01 drapeau `opt`, A02 `Error.Raise`, A03 écriture
sans régie, A04 volume d'`Achat`).
