# TriGen — Synthèse

> Source : `.src/Affichages/TriGen.class` · Synthèse des autres documents.

## Rôle

Composant générique de **liste filtrable, triable et paginée**, créé par code dans un `Panel` de
l'écran appelant (ou dans une fenêtre propre si `Parent = Null`). Pas de `.form`, pas d'héritage :
14 fichiers l'instancient (`TriArticles`, `TriCpt`, `TriFacture`, `GedR`, `LGed`, `Pointage`,
`ValidBR1`, `commande1`, `Articles`, `FClient`, `FFournisseur`, `TarTypeCli`, `Visucmat`, `TriTest`).

## Points clés

- Colonnes décrites par des `ObjProp` ; un champ de filtre `TextReg` par colonne ; requête de base
  de l'appelant complétée par filtres (`LIKE "%…%"`), filtre imposé (`ExtraSel`), `GROUP BY`, tri
  et `LIMIT début, lg`.
- **Protocole de retour** : `_new` remet `Bsel`/`Bval` de l'objet `ob` à `False`/`Null`
  (`Object.SetProperty`) ; `Close` y écrit la sélection (colonne 0, ou `Collection` des colonnes
  `cle`) puis lève `MajSel` (annulable par `Stop Event`). `Bsel`/`Bval` doivent rester `Public`
  chez tous les appelants.
- Événements : `MajSel`, `Activate`, `Data`, `keyPress`, `Resize`, `ReDim`, `Raz`.
- Sélection multiple construite au-dessus par `GedR`, `TriFacture`, `Pointage` (même code ×3).
- SQL entièrement concaténé (filtres saisis compris).

## Dépendances principales

- Utilise : `Utils.db`, `Utils.Observers`, `ObjProp`, `TextReg`, `Chainage`.
- Utilisé par 14 fichiers ; méthodes publiques les plus appelées : `ExtraSel` (13 fichiers),
  `Update` (9), `Show` (7), `GetAllFiltered`, `Refresh_Data`, `FontSize`.
- **Banc d'essai** : [`Tests/TriTest`](../../Tests/TriTest.class/summary.md) est l'implémentation d'un
  test de TriGen (décision utilisateur, lot Reports + Tests) ; dépendance croisée à maintenir.

## Risques

- Toute modification de signature ou d'événement touche 14 écrans (dont `Articles`, `FClient`,
  `FFournisseur`, `Pointage`).
- Filtre sans résultat : anciennes lignes conservées (A01) ; caractères spéciaux dans les filtres
  (A02) ; impression limitée à la page affichée (A03).
- Contrôles créés après `Utils.Observers` : rejeu des clics dans la grille à vérifier en phase 2.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 626 |
| Lignes de commentaire | 11 |
| Fonctions | 35 |
| Fonctions Public | 33 |
| Complexité cyclomatique totale | 163 |
| Complexité max (fonction) | 17 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

11 tests prévus (TRIGEN-T01 à T11) : 9 `replay` à travers les écrans hôtes (filtre, tri,
pagination, sélection simple, colonnes `cle`, sélection multiple, cas limites, impression,
fenêtre propre) et 2 `gbtest` sur les fonctions pures extraites (`Requete`, construction du
filtre).

## Rework

10 étapes sans changement de comportement (TRIGEN-001 à 010) : documentation, code mort
(`ExtraHave`, variables inutilisées), requête unique pour `DB_Incr`/`DB_Decr`/`GetAllFiltered`,
valeur de ligne commune, séparation du filtre, réduction de portée de 4 membres, simplification
de `Coltri_KeyPress` et `_new`, pagination partagée `PaginationListe`, sélection multiple
commune. 5 anomalies (TRIGEN-A01 à A05) soumises à validation.
